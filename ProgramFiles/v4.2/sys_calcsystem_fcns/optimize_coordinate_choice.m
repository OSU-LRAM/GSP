%Calculate optimal coordinate choice for system
function s = optimize_coordinate_choice(s)

	% Get the path in which to make the caching folders for the
	% optimizations
	configfile = './sysplotter_config';
	load(configfile,'datapath');
	
    %Extract the high density "eval" vector field
    vecfield = s.vecfield.eval.content.Avec;
     
    %get the number of rows in the local connection
    n_rows = size(vecfield,3);
		
	%if there are singularities present, arctan scale the vector fields
	if s.singularity
		
		[vecfield_temp, vecfield_temp_smallest_coefficient] = arctan_scale_vector_fields(vecfield);

	else
		
		[vecfield_temp, vecfield_temp_smallest_coefficient] = deal(vecfield);
	
	end
	
	% Weight the coordinate optimization If there are singularities present
	% and no weighting function specified, use a squared-distance from
	% singularity weighting on points in the shape space for the coordinate
	% optimization
% 	if isfield(s,'coordinate_optimization_weighting_function')
% 		
% 		weight = s.coordinate_optimization_weighting_function(s.grid.eval{:});
% 		
% 	elseif s.singularity
% 		
% 		weight = weight_away_from_singularities(s.vecfield.eval.singularities, s.grid.eval);
% 		
% 	else
		weight = ones(size(s.grid.eval{1}));
%	end
	
	
% 	% Set a default density for the finite element grids
% 	if ~isfield(s,'finite_element_density')
% 		s.finite_element_density = 20;
% 	end
	
	%Perform the Helmholtz decomposition on the theta row
	[gradE_theta, E_theta] =...
		helmholtz(s.grid.eval...
		,vecfield_temp(3,:),weight,datapath);

	%Correct the sign of the output for theta
	E_theta = -E_theta;
	gradE_theta = cellfun(@(x) -x,gradE_theta,'UniformOutput',false);
	
	%Minimize x and y rows
	if (~isfield(s,'xy_no_opt')) || (s.xy_no_opt == 0)
	
		[gradE_x, gradE_y,E_x, E_y] =...
			ref_point_optimizer(s.grid.eval...
			,vecfield_temp(1,:),vecfield_temp(2,:)... %U1,V1 and U2,V2
			,vecfield_temp_smallest_coefficient(3,:)... %U3, V3
			,weight,datapath);
	else
		
		[gradE_x, gradE_y] = deal(cell(size(gradE_theta)));
		[gradE_x{:},gradE_y{:},E_x,E_y] = deal(zeros(size(E_theta)));
		
	end



	%%%%%
	%Zero the potential function for theta at the center of the domain

	% If the shapespace origin is within the domain, use that as E_theta=0.
	% Otherwise, use the value at the center of the domain
	
	% Create a mask to turn all the lower-bounds negative
	n_dim = numel(size(E_theta));
	mask = ones(1,2*n_dim);
	mask(1:2:2*n_dim) = -1;
	within = (mask .* s.grid_range)>0;
	
	if all(within)
		
		zcell = num2cell(zeros(n_dim,1));
		
		E_theta_offset = interpn(s.grid.eval{:},E_theta,zcell{:},'cubic');
		
	else

		% Loop over the dimensions, getting the center values in each dimension
		centervals = zeros(n_dim,2);
		for i = 1:n_dim
			centervals(i,:) = E_theta([floor((size(E_theta,i)+1)/2) ceil((size(E_theta,i)+1)/2)]);
		end
		% Mean these value to get the value at the center of the space
		E_theta_offset = mean(centervals(:));
		
	end
	
	E_theta = E_theta-E_theta_offset;
		
		
	
	%Modify the x and y rows by their gradients and include the cross-product term
	vecfield(1,:) = cellfun(@(V0,Vx,Vt) V0 + Vx - (E_y.*Vt),vecfield(1,:)...
		,gradE_x',vecfield(3,:),'UniformOutput',false);
	vecfield(2,:) = cellfun(@(V0,Vy,Vt) V0 + Vy + (E_x.*Vt),vecfield(2,:)...
		,gradE_y',vecfield(3,:),'UniformOutput',false);

	%Reassign vecfield_temp to be an unchanging copy of vecfield
	vecfield_temp = vecfield;

	%rotate through the x and y rows
	vecfield(1,:) = cellfun(@(Vx,Vy) (Vx .* cos(E_theta)) + (Vy .* sin(E_theta))...
		,vecfield_temp(1,:),vecfield_temp(2,:),'UniformOutput',false);
	vecfield(2,:) = cellfun(@(Vx,Vy) -(Vx .* sin(E_theta)) + (Vy .* cos(E_theta))...
		,vecfield_temp(1,:),vecfield_temp(2,:),'UniformOutput',false);
	

	%Modify the theta row
	vecfield(3,:) = cellfun(@(V0,Vt) V0+Vt,vecfield(3,:),gradE_theta','UniformOutput',false);
	
	
	%Re-zero the singularities
	if s.singularity
		
		for i = 1:numel(vecfield)
			vecfield{i} = vecfield{i} .* (1-s.vecfield.eval.singularities{i});
		end
	
	end
	
	%Save the modified vector field to the system structure
	s.vecfield.eval.content.Avec_optimized = vecfield;
	

	
	%Save the coordinate change data to the system structure
	s.B_optimized.eval.Beta = {E_x;E_y;E_theta};
	s.B_optimized.eval.gradBeta = [gradE_x';gradE_y';gradE_theta'];
	
	%%%%%%%%%%%%%%%%%%%
	%%%%%%%%%%%%%%%%%%%
	
	% Create the optimized vector field for display purposes
	s.vecfield.display.content.Avec_optimized...
		= cellfun(@(V) interpn(s.grid.eval{:},V,s.grid.vector{:})...
		,s.vecfield.eval.content.Avec_optimized,'UniformOutput',false);

	%Re-zero the singularities
	if s.singularity
	
		for i = 1:numel(s.vecfield.display.content.Avec_optimized)
			s.vecfield.display.content.Avec_optimized{i} = s.vecfield.display.content.Avec_optimized{i} .* (1-s.vecfield.display.singularities{i});
		end
		
	end
	
	
	%Save the coordinate change data to the system structure
	s.B_optimized.disp.Beta     = cellfun(@(V) interpn(s.grid.eval{:},V,s.grid.vector{:})...
		,s.B_optimized.eval.Beta    ,'UniformOutput',false);
	s.B_optimized.disp.gradBeta = cellfun(@(V) interpn(s.grid.eval{:},V,s.grid.vector{:})...
		,s.B_optimized.eval.gradBeta,'UniformOutput',false);
	

end
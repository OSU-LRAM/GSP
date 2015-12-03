function output = sysf_sand_swimmer_serpenoid(input_mode)

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
		
	
	% name the data file for this system
	datastring = 'sandswimmer_serpenoid_connection';
	
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'Sandswimmer Serpenoid'; % Display name

		case 'dependency'

			output.dependency = {datastring};

		case 'initialize'

			%Initialize a kinematic snake with unit values for L and R

			%%%%%
			% Filename to save to
			output = mfilename;


			%Functional representation of local connection
			%Functional representation of local connection
			load(datastring)
			[alpha1, alpha2] = ndgrid((-10:1:10)*1.2);

	
			s.A_num = @(a1,a2) Conn_num(a1,a2,alpha1,alpha2,Axc1,Axc2,Ayc1,Ayc2,Awc1,Awc2);
			s.A_den = @Conn_den;


			%%%
			%Processing details

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [min(alpha1(:)), max(alpha1(:)), min(alpha2(:)), max(alpha2(:))];

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [21 21]; %density to display scalar functions
			s.density.eval = [21 21];   %density for function evaluations
			s.finite_element_density = 21;
			% power metric
%			s.metric = @honey_power_metric;

			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*8;
			s.tic_locs.y = [-1 0 1]*8;


			%%%%
			% Return the system structure
			output = s;



	end

end

function A_num = Conn_num(a1,a2,alpha1,alpha2,Axa1,Axa2,Aya1,Aya2,Awa1,Awa2)

	A_num = four_way_symmetry(alpha1, alpha2, Axa1, Axa2, Aya1, Aya2, Awa1,Awa2, a1, a2, 1, 'EvenOdd');
                
end

function A_den = Conn_den(a1,a2)
   
    A_den = repmat(ones(size(a1)),[3,2]);
    
end
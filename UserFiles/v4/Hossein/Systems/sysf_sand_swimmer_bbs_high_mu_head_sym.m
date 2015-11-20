function output = sysf_sand_swimmer_bbs_high_mu_head_sym(input_mode)

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
		
	
	% name the data file for this system
	datastring = 'Aseparate_6mm_robomu';
	
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'Sandswimmer 3-link high-mu BBs'; % Display name

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
			[alpha1, alpha2] = ndgrid((-10:1:10)*pi/11);

	
			s.A_num = @(a1,a2) Conn_num(a1,a2,alpha1,alpha2,Axa1,Axa2,Aya1,Aya2,Awa1,Awa2);
			s.A_den = @Conn_den;


			%%%
			%Processing details

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*2.5;

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [21 21]; %density to display scalar functions
			s.density.eval = [21 21];   %density for function evaluations
			s.finite_element_density = 21;
			% power metric
			s.metric = @honey_power_metric;

			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*1.5;
			s.tic_locs.y = [-1 0 1]*1.5;


			%%%%
			% Return the system structure
			output = s;



	end

end

function A_num = Conn_num(a1,a2,alpha1,alpha2,Axa1,Axa2,Aya1,Aya2,Awa1,Awa2)
	

	% Factors of 2 are to scale from unit-link-length to
	% unit-half-link-length
	
% 	A_num_calc...
% 		= -[2*interpn(alpha1,alpha2,Axa1,a1,a2), 2*interpn(alpha1,alpha2,Axa2,a1,a2);
% 		     2*interpn(alpha1,alpha2,Aya1,a1,a2), 2*interpn(alpha1,alpha2,Aya2,a1,a2);
% 		     interpn(alpha1,alpha2,Awa1,a1,a2), interpn(alpha1,alpha2,Awa2,a1,a2)];
% 		 
% 	% Symmetry-flipped A_num
% 	A_num_sym...
% 		= -[2*(-interpn(alpha1,alpha2,Axa1,-a1,-a2)), 2*(-interpn(alpha1,alpha2,Axa2,-a1,-a2));
% 		     2*interpn(alpha1,alpha2,Aya2,a2,a1), 2*interpn(alpha1,alpha2,Aya1,a2,a1);
% 		     -interpn(alpha1,alpha2,Awa2,-a2,-a1), -interpn(alpha1,alpha2,Awa1,-a2,-a1)];
% 		 
% 	A_num = .5*(A_num_calc+A_num_sym);
		 
		 
	% Correct for reference point
	
% 	A_num = A_num + .5*[zeros(size(a1)), zeros(size(a1));
% 		     interp2(alpha1,alpha2,Awa1,a1,a2), interp2(alpha1,alpha2,Awa2,a1,-a2);
% 		     zeros(size(a1)), zeros(size(a1))];

	% Multiply link lengths by 1/3 to achieve overall unit length
	A_num = four_way_symmetry(alpha1, alpha2, Axa1, Axa2, Aya1, Aya2, Awa1,Awa2, a1, a2, 1/3);
                
end

function A_den = Conn_den(a1,a2)
   
    A_den = repmat(ones(size(a1)),[3,2]);
    
end
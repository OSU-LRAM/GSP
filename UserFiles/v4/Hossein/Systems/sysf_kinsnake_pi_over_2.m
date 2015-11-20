function output = sysf_kinsnake_pi_over_2(input_mode, datapath)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end


	
	switch input_mode

		case 'name'

			output = 'Kinematic Snake pi/2'; % Display name

		case 'dependency'

			output.dependency = {};

		case 'initialize'

			%Initialize a kinematic snake with unit values for L and R

			%%%%%
			% Filename to save to
			output = mfilename;


			%Functional representation of local connection
			s.A_num = @Conn_num;
			s.A_den = @Conn_den;


			%%%
			%Processing details

			%%%
			%Processing details

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 1;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*pi/2;

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [31 31]; %density to display scalar functions
			s.density.eval = [21 21];   %density for function evaluations


			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1];
			s.tic_locs.y = [-1 0 1];


			%%%%
			%Save the system properties
			output = s;



	end

end

function A_num = Conn_num(a1,a2)

%	Unit body length
    L = 1/6;
    R = 1/6;
    
    A_num = R * [R + L*cos(a2) , R + L*cos(a1);
                 zeros(size(a1)), zeros(size(a1));
                 sin(a2), sin(a1)];
                 
end

function A_den = Conn_den(a1,a2)

%	Unit body length
    L = 1/6;
    R = 1/6;
    
    A_den = repmat((R*(sin(a1)-sin(a2)) + L*sin(a1-a2)),[3,2]);
    
end
    
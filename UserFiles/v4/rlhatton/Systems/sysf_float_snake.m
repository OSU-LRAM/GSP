function output = sysf_float_snake(input_mode,datapath)

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'name';
		
	end
	
	if ~exist('datapath','var')
		
		datapath = '';
	end
	
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'Floatsnake ideal'; % Display name

		case 'dependency'

			output.dependency = {};
%			output.product = {[datapath mfilename '.mat']}; % the .mat file sharing the same name as this .m file

		case 'initialize'

			%Initialize a kinematic snake with unit values for L and R

			%%%%%
			% Filename to save to
			output = mfilename;


			%Functional representation of local connection
			s.A_num = @(a1,a2) Conn_num(a1,a2);
			s.A_den = @Conn_den;


			%%%
			%Processing details

			%Mark that system does not have a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*3;

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [31 31]; %density to display scalar functions
			s.density.eval = [31 31];   %density for function evaluations
			s.finite_element_density = 31;
			

			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*2.5;
			s.tic_locs.y = [-1 0 1]*2.5;


			%%%%
			%Save the system properties
			save(fullfile(datapath, mfilename),'s')

			%%%%
			%Output the system properties
			output = s;

	end

end

function A_num = Conn_num(a1,a2)


   A_num =[zeros(size(a1)) zeros(size(a1));
        zeros(size(a1)) zeros(size(a1));
        -(5+3*cos(a1)+cos(a1+a2)) (5+3*cos(a2)+cos(a1+a2))];

	

end



function A_den = Conn_den(a1,a2)
   
    A_den = [ ones(size(a1)), ones(size(a1));
        ones(size(a1)), ones(size(a1)) ;
         (19+6*cos(a1)+6*cos(a2)+2*cos(a1+a2)) (19+6*cos(a1)+6*cos(a2)+2*cos(a1+a2))];
    
end
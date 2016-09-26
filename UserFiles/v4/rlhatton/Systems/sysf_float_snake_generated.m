function output = sysf_float_snake_generated(input_mode,datapath)

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

			output = 'Floatsnake generated'; % Display name

		case 'dependency'
            
            output.dependency = {'floatsnake_connection'}; 

		case 'initialize'

			%Initialize a kinematic snake with unit values for L and R

			%%%%%
			% Filename to save to
			output = mfilename;


			%Functional representation of local connection
			%Functional representation of local connection
			s.A_num = @Conn_num;
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
			s.tic_locs.x = [-1 0 1]*1.5;
			s.tic_locs.y = [-1 0 1]*1.5;


			%%%%
			%Save the system properties
			save(fullfile(datapath, mfilename),'s')

			%%%%
			%Output the system properties
			output = s;

	end

end

function [Ar]=Conn_num(a1,a2)


	Ar_cell = cell(size(a1));
	for i = 1:numel(a1);
		Ar_cell{i} = A_num_helper(a1(i),a2(i));
		waitbar2a(i/numel(a1));
	end
	

	%Pull Ar values into a matrix
	Ar_woven = cell2mat(Ar_cell);

	%Rearrange the A matrix
	Ar = [ Ar_woven(1:3:end,1:2:end) Ar_woven(1:3:end,2:2:end);
		  Ar_woven(2:3:end,1:2:end) Ar_woven(2:3:end,2:2:end);
		   Ar_woven(3:3:end,1:2:end) Ar_woven(3:3:end,2:2:end)];

end

function A = A_num_helper(a1,a2)

% 	% Add the path to the curvature functions
% 	addpath(genpath('/Users/rlhatton/Documents/MATLAB/curvature_mode_toolbox'))
% 	addpath(genpath('/Users/rlhatton/Documents/MATLAB/LowRE_toolbox/'))
	% Get the local connection for the specified shape, with unit length
	A = floatsnake_connection(a1,a2);


end

function A_den = Conn_den(a1,a2) %#ok<INUSD>
   
    A_den = repmat(ones(size(a1)),[3,2]);
    
end
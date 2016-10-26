function output = sysf_honey_swimmer_serpenoid_general(input_mode)

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
	
	if ~exist('datapath','var')
		
		datapath = '';
	end
	
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'Low Re Serpenoid first modes generalized curvature'; % Display name

		case 'dependency'

			output.dependency = {'Utilities/curvature_mode_toolbox/backbone_from_general_curvature.m';
				'Utilities/curvature_mode_toolbox/curvatures/curv_serpenoid_unit';
				'Utilities/LowRE_toolbox/LowRE_dissipation_metric_from_general_curvature.m';
				'Utilities/LowRE_toolbox/LowRE_local_connection_from_general_curvature.m'};

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

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*12;

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [21 21]; %density to display scalar functions
			s.density.eval = [21 21];   %density for function evaluations
			s.finite_element_density = 11;
			% power metric
			s.metric = @(x,y) LowRE_dissipation_metric_from_general_curvature...
				(@curvelock,[x;y],1,1,2);  % @(x,y) eye(2);%

			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*6;
			s.tic_locs.y = [-1 0 1]*6;


			%%%%
			%Save the system properties
			output = s;


	end

end

function [Ar]=Conn_num(a1,a2)


	%Apply the inverse multiplication
	wb = waitbar2a(0,['Building ' num2str(size(a1)) ' connection matrix']);
	Ar_cell = cell(size(a1));
	parfor i = 1:numel(a1);
		Ar_cell{i} = A_num_helper(a1(i),a2(i));
		waitbar2a(i/numel(a1));
	end
	
	close(wb)
	
	%Ar_cell = arrayfun(@(a1,a2) A_num_helper(a1,a2),a1,a2,'UniformOutput',false);

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
	A = LowRE_local_connection_from_general_curvature(@curvelock,[a1;a2],1,1,2);


end

function A_den = Conn_den(a1,a2) %#ok<INUSD>
   
    A_den = repmat(ones(size(a1)),[3,2]);
    
end


function output = curvelock(s,params,mode)

% lock the variable frequency serpenoid curvature to frequency 1

    output = curv_serpenoid_unit(s,params,mode);

end
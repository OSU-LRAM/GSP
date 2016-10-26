function output = sysf_honey_swimmer_serpenoid_var_sharpness(input_mode)

% Name for the curvature functions
curv_name = 'serpenoid_var_sharpness';
curv_fun = str2func(['curv_' curv_name]);

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

			output = 'Low Re Serpenoid first modes variable sharpness'; % Display name

		case 'dependency'
            
           

			output.dependency = {'Utilities/curvature_mode_toolbox/backbone_from_general_curvature.m';
				['Utilities/curvature_mode_toolbox/curvatures/curv_' curv_name '.m'];
				'Utilities/LowRE_toolbox/LowRE_dissipation_metric_from_general_curvature.m';
				'Utilities/LowRE_toolbox/LowRE_local_connection_from_general_curvature.m'};

		case 'initialize'
            

			%%%%%
			% Filename to save to
			output = mfilename;


			%Functional representation of local connection
			s.A_num = @(a1,a2,a3) Conn_num(a1,a2,a3,curv_fun);
			s.A_den = @Conn_den;


			%%%
			%Processing details

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [[-1,1,-1,1]*10,[.1 20]];

			%densities for various operations
			s.density.vector = [1,1,1]*11; %density to display vector field
			s.density.scalar = [1,1,1]*11; %density to display scalar functions
			s.density.eval = [1,1,1]*21;%[21 21 21];   %density for function evaluations
			s.finite_element_density = 11;%11;
			% power metric
			s.metric = @(x,y,z) LowRE_dissipation_metric_from_general_curvature...
				(curv_fun,[x;y;z],1,1,2);  % @(x,y) eye(2);%

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

function [Ar]=Conn_num(a1,a2,a3,curv_fun)


	for i = 1:nargin
      sizea1(i) = size(a1,i);
    end
    


	%Apply the inverse multiplication
	wb = waitbar2a(0,['Building ' num2str(size(a1)) ' connection matrix']);
    Ar_cell = cell(sizea1(1),sizea1(2),sizea1(3));
	parfor i = 1:numel(a1);
		Ar_cell{i} = A_num_helper(a1(i),a2(i),a3(i),curv_fun);
		waitbar2a(i/numel(a1));
	end
	
	close(wb)
	
    Ar1=cell(3);
    for i=1:1:9
        for j=1:sizea1(3)
            for k=1:sizea1(2)
                for l=1:sizea1(1)
                    Ar1{i}(l,k,j)=Ar_cell{l,k,j}(i);
                end
            end
        end
    end
    
    Ar=cell2mat(Ar1);

end

function A = A_num_helper(a1,a2,a3,curv_fun)

% 	% Add the path to the curvature functions
% 	addpath(genpath('/Users/rlhatton/Documents/MATLAB/curvature_mode_toolbox'))
% 	addpath(genpath('/Users/rlhatton/Documents/MATLAB/LowRE_toolbox/'))
	% Get the local connection for the specified shape, with unit length
	A = LowRE_local_connection_from_general_curvature(curv_fun,[a1;a2;a3],1,1,2);


end

function A_den = Conn_den(a1,a2,a3) %#ok<INUSD>
   
    A_den = repmat(ones(size(a1)),[3,3]);
    
end
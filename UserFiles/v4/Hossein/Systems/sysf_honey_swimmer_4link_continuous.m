function output = sysf_honey_swimmer_4link_continuous(input_mode)

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

			output = 'Low Re 4-link continuous'; % Display name

		case 'dependency'

			output.dependency = {'Utilities/curvature_mode_toolbox/backbone_from_curvature_bases.m',
				'Utilities/curvature_mode_toolbox/curvatures/serpenoid_1.m',
				'Utilities/curvature_mode_toolbox/curvatures/serpenoid_2.m',
				'Utilities/LowRE_toolbox/LowRE_dissipation_metric_from_curvature_bases.m',
				'Utilities/LowRE_toolbox/LowRE_local_connection_from_curvature_bases.m'};

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
			s.grid_range = [-1,1,-1,1,-1,1]*2;

			%densities for various operations
			s.density.vector = [5 5 5]; %density to display vector field
			s.density.scalar = [4 4 4]; %density to display scalar functions
			s.density.eval = [5 5 5];   %density for function evaluations
			s.finite_element_density = 5;
			% power metric
			s.metric = @(x,y,z) eye(3);%@(x,y) LowRE_dissipation_metric_from_curvature_bases...
				%({@serpenoid_1;@serpenoid_2},[x;y],1,1);

			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1];
			s.tic_locs.y = [-1 0 1];
            s.tic_locs.z = [-1 0 1];


			%%%%
			%Save the system properties
			output = s;



	end

end

function [Ar]=Conn_num(a1,a2,a3)


	%Apply the inverse multiplication
	for i = 1:nargin
      sizea1(i) = size(a1,i);
    end
    
    wb = waitbar2a(0,['Building ' num2str(sizea1) ' connection matrix']);

    Ar_cell = cell(sizea1(1),sizea1(2),sizea1(3));
	for i = 1:numel(a1);
		Ar_cell{i} = A_num_helper(a1(i),a2(i),a3(i));
		waitbar2a(i/numel(a1));
	end
	
	close(wb)
	
	%Ar_cell = arrayfun(@(a1,a2) A_num_helper(a1,a2),a1,a2,'UniformOutput',false);

    Ar1=cell(3);
    for i=1:1:9
        for j=1:sizea1(3)
            for k=1:sizea1(2)
                for l=1:sizea1(1)
                    Ar1{i}(l,k,j)=Ar_cell{l,k,j}(i);
    %[Ar_cell{1,1,j}(i),Ar_cell{1,2,j}(i);
    %Ar_cell{2,1,j}(i),Ar_cell{2,2,j}(i)];
                end
            end
        end
    end
    
    Ar=cell2mat(Ar1);
	%Pull Ar values into a matrix
	%Ar_woven = cell2mat(Ar_cell);

	%Rearrange the A matrix
	%Ar = [ Ar_woven(1:3:end,1:3:end) Ar_woven(1:3:end,2:3:end) Ar_woven(1:3:end,3:3:end);
	%	  Ar_woven(2:3:end,1:3:end) Ar_woven(2:3:end,2:3:end) Ar_woven(2:3:end,3:3:end);
	%	   Ar_woven(3:3:end,1:3:end) Ar_woven(3:3:end,2:3:end) Ar_woven(3:3:end,3:3:end)];

end

function A = A_num_helper(a1,a2,a3)


% 	% Add the path to the curvature functions
% 	addpath(genpath('/Users/rlhatton/Documents/MATLAB/curvature_mode_toolbox'))
% 	addpath(genpath('/Users/rlhatton/Documents/MATLAB/LowRE_toolbox/'))
	% Get the local connection for the specified shape, with unit length
	A = LowRE_local_connection_from_curvature_bases({@discrete_3_joint_1;@discrete_3_joint_1;@discrete_3_joint_1},[a1;a2;a3],1,1);


end

function A_den = Conn_den(a1,a2,a3) %#ok<INUSD>
   
    A_den = repmat(ones(size(a1)),[3,3]);
    
end
function output = sysf_serpenoid_swimmer_experiment(input_mode)

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
    end

    datapath = '';

    Local_connection = 'Local_Connection_Matrix_for_Experiment.mat';
	
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'Serpenoid Swimmer Experiment'; % Display name

		case 'dependency'

			output.dependency = {Local_connection};

		case 'initialize'

			%Initialize a kinematic snake with unit values for L and R

			%%%%%
			% Filename to save to
			output = mfilename;
            
            load(Local_connection)

			%Functional representation of local connection
			s.A_num = @(a1,a2) Conn_num(a1,a2,alpha1,alpha2,Ax1,Ax2,Ay1,Ay2,Atheta1,Atheta2);
			s.A_den = @Conn_den;


			%%%
			%Processing details

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
% 			s.grid_range = [-3,3,-2.8,2.8]*1;
            s.grid_range = [-1,1,-1,1]*2;
            

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [31 31]; %density to display scalar functions
			s.density.eval = [11 11];   %density for function evaluations
			s.finite_element_density = 11;
			% power metric
            
            load('Metric_Tensor1.mat')
			s.metric = @(x,y) Granular_metric_calc(x,y,Metric_Tensor_cell,alpha1,alpha2);%@(x,y) eye(2);%Granular_metric_calc(x,y,Metric_Tensor_raw,alpha1,alpha2);%eye(2);%@(x,y) LowRE_dissipation_metric_from_curvature_bases...
				%({@serpenoid_1;@serpenoid_2},[x;y],1,1);

			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*0.5;
			s.tic_locs.y = [-1 0 1]*0.5;


			%%%%
			%Save the system properties
			output = s;


	end

end

function [Ar]=Conn_num(a1,a2,alpha1,alpha2,Ax1,Ax2,Ay1,Ay2,Atheta1,Atheta2)


    Local_Connection = 'Local_Connection_Matrix_for_Experiment.mat';

    if exist(Local_Connection,'file')
        
         %Load the Local_Connection file
%          load('Local_Connection_Matrix');
%          
%          New_Ax1 = interpn(alpha2,alpha1,Ax1,a1,a2);
%          New_Ax2 = interpn(alpha2,alpha1,Ax2,a1,a2);
% 
%          New_Ay1 = interpn(alpha2,alpha1,Ay1,a1,a2);
%          New_Ay2 = interpn(alpha2,alpha1,Ay2,a1,a2);
% 
%          New_Atheta1 = interpn(alpha2,alpha1,Atheta1,a1,a2);
%          New_Atheta2 = interpn(alpha2,alpha1,Atheta2,a1,a2);
%          
%          Ar = -[New_Ax1 New_Ax2;
%                New_Ay1 New_Ay2;
%                New_Atheta1 New_Atheta2];

%         cd(Current_path)

%         dp = '\Users\Hossein\Documents\MATLAB\Dr Hatton Snake Robot\GeometricSystemPlotter\ProgramFiles\v4.1\Utilities\Granular Toolbox1';
%         cd(dp)

%         addpath(genpath('\Users\Hossein\Documents\MATLAB\Dr Hatton Snake Robot\GeometricSystemPlotter\ProgramFiles\v4.1\Utilities\Granular Toolbox1'))
        Ar = four_way_symmetry(alpha1, alpha2, -Ax1, -Ax2, -Ay1, -Ay2, -Atheta1,-Atheta2, a1, a2, 1/3,'EvenOdd');
        
        
    else
    
        %Apply the inverse multiplication
%         wb = waitbar2a(0,['Building ' num2str(size(a1)) ' connection matrix']);
%         Ar_cell = cell(size(a1));
%         for i = 1:numel(a1);
        Ar_cell = A_num_helper(a1,a2);
%             waitbar2a(i/numel(a1));
%         end
% 
%         close(wb)
	
        %Ar_cell = arrayfun(@(a1,a2) A_num_helper(a1,a2),a1,a2,'UniformOutput',false);

        %Pull Ar values into a matrix
        Ar_woven = cell2mat(Ar_cell);

        %Rearrange the A matrix
        Ar = [ Ar_woven(1:3:end,1:2:end) Ar_woven(1:3:end,2:2:end);
              Ar_woven(2:3:end,1:2:end) Ar_woven(2:3:end,2:2:end);
               Ar_woven(3:3:end,1:2:end) Ar_woven(3:3:end,2:2:end)];

    end

end

function A = A_num_helper(a1,a2)

	% Add the path to the curvature functions
%     addpath(genpath('/Users/rlhatton/Documents/MATLAB/Granual_Toolbox1/'))
    
	% Get the local connection for the specified shape, with unit length

%     A = feval(@Main_Granular_Swimmer,a2, a1);
    
end

function A_den = Conn_den(a1,a2) %#ok<INUSD>
   
    A_den = repmat(ones(size(a1)),[3,2]);
    
end
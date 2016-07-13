function output = shchf_zero_contour_serpenoid(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Zero Contour Serpenoid';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			% Filename to save to

			%%
			%Path definitions

			%path definition
			p.phi_def{1} = {@strokedef};
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows{1} = {2};

			%time to run path
			p.time_def{1} = {[0 2*pi]};

			%p.cBVI_method{1}{1} = 'simple';

			%path resolution
			p.phi_res{1} = {1000};


			%%%%
			%Output the path properties
			output = p;
	end
	
end

function [stroke] = strokedef(t)

	t = -t(:)';

	Rot=eye(2);%sqrt(2)/2*[1 -1;1 1];
    
    % Elbow up
% 	a=22;   %w = 4
%     b= 6; %w = 4

    a = 10;  %w = 3
    b = 30;  %w = 3
    
    % Normal sepenoid
%     a=22;     %w = 4
%     b= 13;    %w = 4
%     a = 8;
%     b = 4.5;
%     a = 10; %w=3
%     b = 12; %w=3

    % Elbow down
%     a=6;
%     b=6;

	stroke=(Rot*[-a*cos(t);-b*sin(t)])';
   
    
    if length(t) > 1
        
        
        load('~/Documents/MATLAB/GSP/UserFiles/v4/rlhatton/sysplotter_data/v4.2/sysf_honey_swimmer_serpenoid__null.mat')
    
        X_HF = s.height_optimized{1};
        alpha1 = s.grid.eval{1};
        alpha2 = s.grid.eval{2};

        [C,h] = contour(alpha1,alpha2,X_HF,[0 0]);

        % Seperate the data of the contour for specific power and put them into
        % the individual cell.
        [C_Max1,C_Indx1] = find(C(1,:) == C(1,1));

        new_C = C(:,C_Indx1);

        [max_C,ind_max] = max(new_C(2,:));
        
%         max_C = 9;ind_max = 6;

        final_C = C(:,C_Indx1(ind_max)+1:C_Indx1(ind_max)+max_C);
    
    
        % Define new time span
        t1 = linspace(0,t(end),length(final_C(1,:)));

        stroke_x = interp1(t1,final_C(1,:),t);
        stroke_y = interp1(t1,final_C(2,:),t);

        stroke = [stroke_x;stroke_y]';
        
%         pp1 = spline(stroke_x,t);
%         pp2 = spline(stroke_y,t);
        t2 = t;
        
        save('serpenoid_gait_data','stroke_x','stroke_y','t2')
        
    else
        
        load('serpenoid_gait_data')
%         stroke_x = ppval(pp1,t);
%         stroke_y = ppval(pp2,t);

        stroke_x1 = interp1(t2,stroke_x,t);
        stroke_y1 = interp1(t2,stroke_y,t);
        stroke = [stroke_x1;stroke_y1]';
    end

%     for m = 1:length(C_Indx1)
% 
%         C_data = C(:,C_Indx1(m)+1:C_Indx1(m)+C(2,C_Indx1(m)));
%         Sum_C_data{m} = sum(C_data(1,:));     % uesd for Removeing the akward shapes
% 
%     end
%     [C_Min,C_Indx2] = min(abs([Sum_C_data{:}]));      % uesd for Removeing the akward shapes
%     C_data = C(:,C_Indx1(C_Indx2)+1:C_Indx1(C_Indx2)+C(2,C_Indx1(C_Indx2)));      % uesd for Removeing the akward shapes
        


end
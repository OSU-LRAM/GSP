function output = shchf_purcell_family_avron(input_mode)
 %[r1,r2] = convert.old_to_new_points(alpha1,alpha2);
	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
	
	switch input_mode
		
		case 'name'
			
			output = 'purcell family Avron';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			%%
			%Path definitions
			
			%path definition
			A=linspace(0.25, .99*pi, 15); % Amplitdude of circle
			
			for i = 1:1:numel(A)
				p.phi_def{i} = {@(t) strokedef1(t,A(i)),@(t) strokedef2(t,A(i)),@(t) strokedef3(t,A(i)),@(t) strokedef4(t,A(i))};		
				
				% Calculate the cBVI for this gait
				p.cBVI_method{i}{1} = 'simple';
			end
			
% 			for i = 2:2:numel(X)
% 				p.phi_def{i/2,1} = {@(t) strokedef(t,X{i})};
% 			end
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows = [repmat({{0}},numel(A)-1,1);{{0}}];

			%time to run path
			p.time_def{1} = {[0 1],[0 1],[0 1],[0 1]};


			%path resolution
			p.phi_res{1} = {100};


			%%%%
			%Output the shch properties
			output = p;

	end
	
end

function [stroke] = strokedef1(t,A)

	t = t(:);
	
	stroke = A*[ones(size(t)), (1-2*t)];
	
	
end

function [stroke] = strokedef2(t,A)

	t = t(:);
	
	stroke = A*[(1-2*t), -ones(size(t))];
	
	
end

function [stroke] = strokedef3(t,A)

	t = t(:);
	
	stroke = A*[-ones(size(t)), -(1-2*t)];
	
	
end

function [stroke] = strokedef4(t,A)

	t = t(:);
	
	stroke = A*[-(1-2*t), ones(size(t))];
	
	
end
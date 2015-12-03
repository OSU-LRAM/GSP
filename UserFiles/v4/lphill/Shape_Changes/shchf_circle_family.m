function output = shchf_circle_family(input_mode)
 %[r1,r2] = convert.old_to_new_points(alpha1,alpha2);
	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
	
	switch input_mode
		
		case 'name'
			
			output = 'circle family';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			%%
			%Path definitions
			
			%path definition
			A=.125:.125:2; % Amplitdude of circle
			
			for i = 1:1:numel(A)
				p.phi_def{i,1} = {@(t) strokedef(t,A(i))};		
				
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
			p.time_def{1} = {[0 2*pi]};


			%path resolution
			p.phi_res{1} = {70};


			%%%%
			%Output the shch properties
			output = p;

	end
	
end

function [stroke] = strokedef(t,A)

	t = t(:)';

	stroke = (sqrt(2)/2*[1 -1;1 1]*(A*[cos(t); sin(t)]))';

end
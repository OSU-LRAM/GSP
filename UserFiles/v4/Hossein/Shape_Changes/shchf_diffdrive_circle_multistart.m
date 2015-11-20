function output = shchf_diffdrive_circle_multistart(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Diffdrive circle multistart';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			%%
			%Path definitions
			
			%path definition
			A=.1; % Amplitdude of circle
			P = linspace(0, pi, 11); % Starting phase
			
			for i = 1:1:numel(A)
				
				for j = 1:numel(P);
					p.phi_def{i,j} = {@(t) strokedef(t+P(j),A(i))};
					p.dphi_def{i,j} = {@(t) dstrokedef(t+P(j),A(i))};

% 					% Calculate the cBVI for this gait
% 					if j == 1
% 						p.cBVI_method{i,j}{1} = 'simple';
% 					else
% 						p.cBVI_method{i,j}{1} = 'null';
% 					end

				end
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

	stroke = ...(sqrt(2)/2*[1 -1;1 1]*
        (A*[sin(t); -cos(t)])';

end

function [stroke] = dstrokedef(t,A)

	t = t(:)';

	stroke = ...(sqrt(2)/2*[1 -1;1 1]*
        (A*[cos(t); sin(t)])';

end


function [alpha] = drive_forward(t)

	t = t(:);

	alpha = [-1+t -1+t];


end


function [alpha] = turn_in_place(t)

	t = t(:);

	alpha = [-t t];


end
function output = shchf_circle_1p25_multistart(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Circle Stroke, 1.25 amplitude multistart';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			% Filename to save to

			%%
			%Path definitions

			%path definition
			A=1.25; % Amplitdude of circle
			P = [0,pi/2, 3*pi/2]; % Starting phase
			
			for i = 1:1:numel(A)
				
				for j = 1:numel(P);
					p.phi_def{i,j} = {@(t) strokedef(t+P(j),A(i))};
					p.dphi_def{i,j} = {@(t) dstrokedef(t+P(j),A(i))};

					% Calculate the cBVI for this gait
					if j == 1
						p.cBVI_method{i,j}{1} = 'simple';
					else
						p.cBVI_method{i,j}{1} = 'null';
					end

				end
			end			
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

function [stroke] = strokedef(t,A)

	t = t(:)';

	stroke = (sqrt(2)/2*[1 -1;1 1]*(A*[-cos(t); sin(t)]))';

end

function [stroke] = dstrokedef(t,A)

	t = t(:)';

	stroke = (sqrt(2)/2*[1 -1;1 1]*(A*[sin(t); cos(t)]))';

end
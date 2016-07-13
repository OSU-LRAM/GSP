function output = shchf_multiple_gait_serpenoid_swimmer_experiment(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Stroke for Serpenoid Swimmer Experiment';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			% Filename to save to

			%%
			%Path definitions

			%path definition
% 			p.phi_def{1} = {@strokedef};
            
            A=linspace(.2,.8,20); % Amplitdude of circle
			
			for i = 1:1:numel(A)
				p.phi_def{i,1} = {@(t) strokedef(t,A(i))};		
			end
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows{1} = {2};

			%time to run path
			p.time_def{1} = {[0 2*pi]};

			p.cBVI_method{1}{1} = 'simple';

			%path resolution
			p.phi_res{1} = {1000};


			%%%%
			%Output the path properties
			output = p;
	end
	
end

function [stroke] = strokedef(t,A)

	t = -t(:)';
    
%     stroke=(Rot*[A*2.1213*cos(t);A*1.8707*sin(t)])';

    N = 9;
    basis1 = sin((1:N-1)/N*2*pi);
    basis2 = cos((1:N-1)/N*2*pi);

    w1 = A*cos(t)*norm(basis1);
    w2 = A*sin(t)*norm(basis2);
    stroke = [w1;w2]';


end
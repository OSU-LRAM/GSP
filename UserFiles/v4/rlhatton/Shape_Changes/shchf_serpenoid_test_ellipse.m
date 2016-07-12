function output = shchf_serpenoid_test_ellipse(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
	

	switch input_mode
		
		case 'name'
			
			output = 'Low Re serpenoid test ellipse';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%
			%Path definitions

			%path definition
			p.phi_def{1} = {@strokedef}; % locus
			p.dphi_def{1} = {@dstrokedef}; % derivative
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows{1} = {2};

			%time to run path
			p.time_def{1} = {[0 2*pi]};


			%path resolution
			p.phi_res{1} = {200};


			%%%%
			%Save the system properties
			output = p;

	end
	
end

function [stroke] = strokedef(t)

	t = t(:);


	stroke=5.5*[cos(t) sin(t)];


end

function [dstroke] = dstrokedef(t)

	t = t(:);


	dstroke=5.5*[-sin(t) cos(t)];


end
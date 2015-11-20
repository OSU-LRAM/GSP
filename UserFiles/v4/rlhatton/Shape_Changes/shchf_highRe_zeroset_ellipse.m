function output = shchf_highRe_zeroset_ellipse(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
	

	switch input_mode
		
		case 'name'
			
			output = 'High Re zero-set approximating ellipse';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%
			%Path definitions

			%path definition
			p.phi_def{1} = {@strokedef}; % locus
			p.dphi_def{1} = {@dstrokedef}; % derivative
            
            p.cBVI_method{1} = 'simple';			
			
            %marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows{1} = {2};

			%time to run path
			p.time_def{1} = {[0 2*pi]};


			%path resolution
			p.phi_res{1} = {50};


			%%%%
			%Save the system properties
			output = p;

	end
	
end

function [stroke] = strokedef(t)

	t = t(:)';

	
	stroke=([1 1;-1 1]*[0.6*cos(t); 1.45*sin(t)])';


end

function [dstroke] = dstrokedef(t)

	t = t(:)';


	dstroke=([1 1;-1 1]*[-0.6*sin(t); 1.4*cos(t)])';


end
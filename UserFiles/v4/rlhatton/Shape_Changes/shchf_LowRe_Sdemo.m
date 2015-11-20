function output = shchf_LowRe_Sdemo(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Low Re S stroke demo';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			% Filename to save to

			output = mfilename;


			%%
			%Path definitions

			%path definition
			p.phi_def{1} = {@strokedef};
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows{1} = {2};

			%time to run path
			p.time_def{1} = {[-1 1]};

			%path resolution
			p.phi_res{1} = {1000};


			%%%%
			%Save the system properties
			output = p;

	end
	
end

function [stroke] = strokedef(t)

	t = t(:);

	stroke = [t -t]*1.5;


end
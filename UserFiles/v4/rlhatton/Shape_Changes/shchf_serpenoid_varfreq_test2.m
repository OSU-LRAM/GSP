function output = shchf_serpenoid_varfreq_test2(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Serpenoid varfreq test 2';
			
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
			p.time_def{1} = {[0 1]};

			%p.cBVI_method{1}{1} = 'simple';

			%path resolution
			p.phi_res{1} = {100};


			%%%%
			%Output the path properties
			output = p;
	end
	
end

function [stroke] = strokedef(t)

	t = t(:)';

    stroke = [zeros(size(t));
              6*ones(size(t));
              .5 + 2*t].';

end
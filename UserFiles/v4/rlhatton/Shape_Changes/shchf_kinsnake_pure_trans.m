function output = shchf_kinsnake_pure_trans(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Kinsnake Pure Translation Demo';
			
		case 'dependency'
			
			output.dependency = {'kinsnake_pure_trans_def.mat'};
			
		case 'initialize'

			%%%%
			
			load('kinsnake_pure_trans_def');
			
			%%
			%Path definitions

			%path definition
			p.phi_def{1} = {@(t_in)strokedef(t_in,t,stroke)};
			p.dphi_def{1} = {@(t_in)strokedef(t_in,t,dstroke)};
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows{1} = {0};

			%time to run path
			p.time_def{1} = {[0 1]};
			
			% use simple polygon integration for the cBVI
			%p.cBVI_method = 'simple';

			% use fixed step time integration
			%p.fixed_step_integration = 1;

			%path resolution
			p.phi_res{1} = {100};


			%%%%
			%output the system properties
			output = p;

	end
	
end

function [stroke] = strokedef(t_in,t,stroke)

	stroke = interp1(t,stroke,t_in);



end
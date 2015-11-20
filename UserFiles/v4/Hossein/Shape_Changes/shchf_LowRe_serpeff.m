function output = shchf_LowRe_serpeff(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Low Re serp eff';
			
		case 'dependency'
			
			output.dependency = {}; % the .mat file sharing the same name as this .m file
			
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
			p.time_def{1} = {[-pi pi]};%{[-1 1]};

			%path resolution
			p.phi_res{1} = {1000};


			%%%%
			%Save the system properties
			output = p;

	end
	
end

function [stroke] = strokedef(t)
load('X_eff_serpenoid.mat')
XV=X;
len=length(X);
	t = t(:);
    stroke=[fourier_eval(t,XV(1:len/4),XV(len/4+1:len/2),2*pi); fourier_eval(t,XV(len/2+1:3*len/4),XV(3*len/4+1:len),2*pi)]';

	%stroke = [t t]*1.5;


end
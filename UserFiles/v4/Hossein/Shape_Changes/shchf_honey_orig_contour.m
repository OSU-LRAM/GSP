function output = shchf_honey_orig_contour(input_mode)
 %[r1,r2] = convert.old_to_new_points(alpha1,alpha2);
	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
		
	% Name the .mat file with the fourier coefficients
	fourierfile = 'honey_original_params';
	
	
	switch input_mode
		
		case 'name'
			
			output = 'zero-like honey original contour gait';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			%%
			%Path definitions

			%Fourier Coefficients
			% A is cosine, B is sine, number is which joint angle
			load(fourierfile)
			

			p.phi_def{1} = {@(t) [fourier_eval(t(:)+0.335,A1,B1,2*pi);fourier_eval(t(:)+0.335,A2,B2,2*pi)]'};
			
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows = {{2}};

			%time to run path
			p.time_def{1} = {[0 2*pi]};
			
			% calculate the cBVI for this gait
			p.cBVI_method{1}{1} = 'simple';

			%path resolution
			p.phi_res{1} = {50};
			



			%%%%
			%Save the shch properties
			output = p;
	end
	
end
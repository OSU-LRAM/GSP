function output = shchf_gui_gait_draw_1(input_mode)
 %[r1,r2] = convert.old_to_new_points(alpha1,alpha2);
	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
		
	% Name the .mat file with the fourier coefficients
	paramfile = 'params_1';
	
	
	switch input_mode
		
		case 'name'
			
			output = 'params 1';
			
		case 'dependency'
			
			output.dependency = {fullfile(pwd,[paramfile '.mat'])};
			
		case 'initialize'

			%%%%
			%%
			%Path definitions

			% Load the points that the user clicked and the time vector
			load(paramfile)
            
            % Check if start and end are the same point, and set boundary
            % conditions accordingly
            if alpha1(1)==alpha1(end) && alpha2(1)==alpha2(end)
                splinemode = 'periodic';
            else
                splinemode = 'complete';
            end
            
            % Generate spline structures for the selected points
            spline_alpha1 = csape(t,alpha1',splinemode);
            spline_alpha2 = csape(t,alpha2',splinemode);
            
            % The gait path is now defined by evaluating the two splines at
            % specified times
			p.phi_def = @(t) [fnval(spline_alpha1,t(:)),fnval(spline_alpha2,t(:))];
            
            
            % Speed up execution by defining the gait velocity as well (so
            % the evaluator doesn't need to numerically take the derivative
            % at every time
            spline_dalpha1 = fnder(spline_alpha1);
            spline_dalpha2 = fnder(spline_alpha2);	
            
            % The gait path is now defined by evaluating the two splin
            % derivatives at specified times
			p.dphi_def = @(t) [fnval(spline_dalpha1,t(:)),fnval(spline_dalpha2,t(:))];
 
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows = 2;

			%time to run path
			p.time_def = t([1 end]); %#ok<COLND>


			%path resolution
			p.phi_res = 50;
			



			%%%%
			%Save the shch properties
			output = p;
	end
	
end
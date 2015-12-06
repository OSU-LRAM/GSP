function output = shchf_legcube_SO3_wiggle(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'LegCube SO3 Wiggle';
			
		case 'dependency'
			
			output.dependency = {'Systems/FreeCube_SO3_loc_conn.m'}; 
			
		case 'initialize'

			%%
			%Path definitions

			%path definition. Concatenate these two shape change segments into a
			%single trajectory (best results when the end of one segment
			%starts the next.
			p.phi_def{1} = {@right_circle, @left_circle}; 
			
			
			%marker locations
			p.phi_marker = []; % No marker on this path (can put, e.g. endpoints of path if desired)
			
			%arrows to plot
			p.phi_arrows{1} = {2,2}; %put one direction arrow on the first segment, two on the second

			%time to run path
			p.time_def{1} = {[0 2*pi], [0 2*pi]}; % Duration of each segment

			% With a closed-loop gait, enabling this line takes the area
			% integral of the Constraint Curvature Function (note that this
			% is currently a slow operation.
			%p.cBVI_method{1}{1} = 'simple';

			%number of points in each path.
			p.phi_res{1} = {100, 100};


			%%%%
			%Output the path properties
			output = p;
	end
	
end

function [stroke] = right_circle(t)

	t = t(:)';
    
    angle = pi/4;
    Rot = [cos(angle),-sin(angle);...
           sin(angle), cos(angle)];
	a=1.0;

	stroke=(Rot*[a*(cos(t+pi)+1);a*sin(t)])';


end

function [stroke] = left_circle(t)

	t = t(:)';

    angle = pi/4;
    Rot = [cos(angle),-sin(angle);...
           sin(angle), cos(angle)];
	a=1.0;

	stroke=(Rot*[a*(cos(t)-1);a*sin(t)])';


end
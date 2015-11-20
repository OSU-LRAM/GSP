function output = shchf_purcell_family(input_mode)

	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end	
	
	switch input_mode
		
		case 'name'
			
			output = 'Purcell family with five strokes';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			% Filename to save to

			%%
			%Path definitions

				numpaths = 5;
			%path definition
			mags = linspace(0,2-eps,numpaths);
			
			for i = 1:1:numel(mags)
					p.phi_def{i,1} = {@(t) purcell(t,mags(i),[0 2*pi])};
			end
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows{1} = {2};

			%time to run path
			p.time_def{1} = {[0 2*pi]};

			%p.cBVI_method{1}{1} = 'simple';

			%path resolution
			p.phi_res{1} = {1000};


			%%%%
			%Output the path properties
			output = p;
	end
	
end

function alpha = purcell(t,mag,time_window)

	% Divide the time window into four segments
	time_seg = [time_window(1),...
		time_window(1)+diff(time_window)/4,...
		time_window(1)+diff(time_window)/2,...
		time_window(1)+3*diff(time_window)/4,...
		time_window(2)];
	
	seg_length = diff(time_window)/4;
	
	%map the t values into alpha positions, for a square stroke starting
	%in the first quadrant.
	alpha = mag*[ones(size(t(t < time_seg(2)))), 1-2*t(t < time_seg(2))/seg_length;
		1-2*(t( (t > time_seg(2)) & (t <= time_seg(3)) )-time_seg(2))/seg_length, -ones(size(t( (t > time_seg(2)) & (t <= time_seg(3)) )));
		-ones(size(t( (t > time_seg(3)) & (t <= time_seg(4)) ))), -1+2*(t( (t > time_seg(3)) & (t <= time_seg(4)) )-time_seg(3))/seg_length;
		-1+2*(t( (t > time_seg(4)) )-time_seg(4))/seg_length, ones(size(t( (t > time_seg(4)) )))];
	


end
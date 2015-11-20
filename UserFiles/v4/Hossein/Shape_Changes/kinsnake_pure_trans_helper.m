function kinsnake_pure_trans_helper


	t = linspace(0,1);

	%Load the relevant local connection
	load('sysplotter_config')
	load(fullfile(datapath,'sysf_kinsnake_pi_over_2_calc'))


	%Starting point for gait
	alpha_raw = [1.25,-.2];
	
	%Velocity robot should have while executing path (x and theta only)
	target_vel = [.001 0]';

	%use inverse of local connection to find path through shape space,
	%ending when the alpha_2 = -alpha_1 line is reached
	while alpha_raw(end,1) > -alpha_raw(end,2)
		
		%evaluate the local connection
		A = cellfun(@(Y) -interpn(s.grid.eval{:},Y,alpha_raw(end,1),alpha_raw(end,2)),s.vecfield.eval.content.Avec);
		
		%Knock out the middle row of the local connection
		A(2,:) = [];
		
		%use the inverse (remembering that the local connection is
		%negative)
		dalpha = -A\target_vel;
		
		%store the next point in the path
		alpha_raw(end+1,:) = alpha_raw(end,:)+dalpha'; %#ok<AGROW>
		
	end
	
	% Duplicate alpha_raw to get a full sweep motion
	alpha_raw = [alpha_raw; -alpha_raw(end:-1:2,2), -alpha_raw(end:-1:2,1)];
	
	%interpolate to match length of path with input specification
	if numel(t)>1
		stroke = interp1(linspace(t(1),t(end),size(alpha_raw,1)),alpha_raw,linspace(t(1),t(end),length(t)));
	else
		stroke = alpha_raw;
	end
	
	% Duplicate stroke to get alternate stroke motion
	stroke_alt = stroke(end:-1:1,[2,1]);
	
	dstroke = [gradient(stroke(:,1),t(2)-t(1)),gradient(stroke(:,2),t(2)-t(1))];
	dstroke_alt = [gradient(stroke_alt(:,1),t(2)-t(1)),gradient(stroke_alt(:,2),t(2)-t(1))];
		
	save(fullfile(shchpath,'kinsnake_pure_trans_def'),'t','stroke','stroke_alt','dstroke','dstroke_alt')

end
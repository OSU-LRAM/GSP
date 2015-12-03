function output = shchf_sand_rotate_family_loose(input_mode)
 %[r1,r2] = convert.old_to_new_points(alpha1,alpha2);
	% Default argument
	if ~exist('input_mode','var')
		
		input_mode = 'initialize';
		
	end
	
	switch input_mode
		
		case 'name'
			
			output = 'Sandswimmer rotational gait family loose';
			
		case 'dependency'
			
			output.dependency = {};
			
		case 'initialize'

			%%%%
			%%
			%Path definitions

			%path definition
			A=[zeros(4,1), linspace(.3,1.2,4)', linspace(.3,1.2,4)']; % Offset, width radius, height radius of circle
			
			for i = 1:1:size(A,1)
				p.phi_def{i,1} = {@(t) strokedef(t,A(i,:)),@(t) strokedef(t,A(i,:))};		
				
				% Calculate the cBVI for this gait
				%p.cBVI_method{i}{1} = 'section';
			end
			
			
			%marker locations
			p.phi_marker = [];
			
			%arrows to plot
			p.phi_arrows = {{1 1}};

			%time to run path
			p.time_def{1} = {[0 pi] [pi 2*pi]};


			%path resolution
			p.phi_res{1} = {50};
			



			%%%%
			%Save the shch properties
			output = p;

	end
	
end

function stroke = strokedef(t,A)

t = t(:)';

stroke = (repmat(A(1)*[1;1],size(t))+ [cos(pi/4) -sin(pi/4); sin(pi/4) cos(pi/4)]...
	*[A(2)*(1-cos(2*t)).*sign(t-pi);-A(3)*sin(2*t)])';

end
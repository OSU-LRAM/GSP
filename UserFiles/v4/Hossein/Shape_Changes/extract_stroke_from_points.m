function [A1, B1, A2, B2] = extract_stroke_from_points(a1,a2)


raw_points = [a1(:) a2(:)];

if ~all(raw_points(1,:) == raw_points(end,:))
	raw_points = [raw_points;raw_points(1,:)];
end


% raw_points = [
% 	1 0;
% 	1 1;
% 	0 1;
% 	-1 1;
% 	-1 0;
% 	-1 -1;
% 	0 -1;
% 	1 -1;
% 	1 0
% 	];

% set up a baseline vector for plotting the output


a1_in = @(t)interp1(linspace(0,2*pi,size(raw_points,1)),raw_points(:,1),mod(t,2*pi));
a2_in = @(t)interp1(linspace(0,2*pi,size(raw_points,1)),raw_points(:,2),mod(t,2*pi));

figure(977818)
N = 5;
[A1,B1,t1,a1] = fseriesdemo(a1_in,2*pi,N,10);
[A2,B2,t2,a2] = fseriesdemo(a2_in,2*pi,N,10);


% 
% a1 = A0(1)+AN(1,1)*cos(2*pi*t)+BN(1,1)*sin(2*pi*t)+AN(2,1)*cos(2*2*pi*t)+BN(2,1)*sin(2*2*pi*t)+AN(3,1)*cos(4*2*pi*t)+BN(3,1)*sin(4*2*pi*t);
% a2 = A0(2)+AN(1,2)*cos(2*pi*t)+BN(1,2)*sin(2*pi*t)+AN(2,2)*cos(2*2*pi*t)+BN(2,2)*sin(2*2*pi*t)+AN(3,2)*cos(4*2*pi*t)+BN(3,2)*sin(4*2*pi*t);
% 
% plot the shape
figure(977817)
plot(a1,a2)
axis equal

end





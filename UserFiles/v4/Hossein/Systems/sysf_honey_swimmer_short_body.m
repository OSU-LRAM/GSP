function output = sysf_honey_swimmer_short_body(input_mode)

	% Default arguments
	if ~exist('input_mode','var')
		
		input_mode = 'name';
		
	end
	
	%%%%%%%
	
	switch input_mode

		case 'name'

			output = 'Low Re 3-link ideal eta=.75 Peko'; % Display name

		case 'dependency'

			output.dependency = {'honey_power_metric.m'};

		case 'initialize'

			%%%%%

			%Functional representation of local connection
			s.A_num = @Conn_num;

			%%%
			%Processing details

			%Mark that system has a singularity that needs to be accounted for
			s.singularity = 0;

			%Range over which to evaluate connection
			s.grid_range = [-1,1,-1,1]*pi;

			%densities for various operations
			s.density.vector = [11 11]; %density to display vector field
			s.density.scalar = [21 21]; %density to display scalar functions
			s.density.eval = [21 21];   %density for function evaluations
			s.finite_element_density = 31;
			% power metric
% 			s.metric = @(x,y) LowRE_dissipation_metric_from_curvature_bases...
% 				({@discrete_joint_1;@discrete_joint_2},[x;y],1,1);
			%%%
			%Display parameters

			%shape space tic locations
			s.tic_locs.x = [-1 0 1]*1.5;
			s.tic_locs.y = [-1 0 1]*1.5;
			


			%%%%
			%Save the system properties
			output = s;

	end

end

function A_num = Conn_num(a1,a2)

% Unit body length
A = [1 2; 1 -0.747]; x = [1; 0];
y = A\x;

    R = y(2)/2;
    L = y(1)/2;
%     mu = ;
%     kappa = ;
%     k = 2*pi*mu/log(kappa);
    alpha_1 = a1;
    alpha_2 = a2;
    
    %machine generated expression
    A_num = [
        (56.*R.^6.*sin(alpha_1)+12.*R.^4.*L.^2.*sin(-2.*alpha_2+alpha_1)+12.*R.^4.*L.^2.*sin(2.*alpha_2+alpha_1)-8.*R.^6.*sin(2.*alpha_2+alpha_1)+16.*R.^2.*L.^4.*sin(alpha_1)+12.*R.^5.*L.*sin(2.*alpha_1)-16.*R.^4.*L.^2.*sin(2.*alpha_2)+72.*R.^4.*L.^2.*sin(alpha_1-alpha_2)+24.*R.^4.*L.^2.*sin(alpha_1+alpha_2)+8.*R.^4.*L.^2.*sin(2.*alpha_1)+4.*R.^3.*L.^3.*sin(2.*alpha_2+alpha_1)+12.*R.^3.*L.^3.*sin(-2.*alpha_2+alpha_1)+64.*R.^5.*L.*sin(alpha_1)-12.*R.^5.*L.*sin(2.*alpha_2)+4.*R.^5.*L.*sin(2.*alpha_2+2.*alpha_1)-64.*R.^5.*L.*sin(alpha_2)+72.*R.^4.*L.^2.*sin(alpha_1)+80.*R.^3.*L.^3.*sin(alpha_1)+8.*R.^6.*sin(alpha_2+2.*alpha_1)-56.*R.^6.*sin(alpha_2)+72.*R.^5.*L.*sin(alpha_1-alpha_2)+24.*R.^5.*L.*sin(alpha_1+alpha_2))./(168.*cos(alpha_2).*R.^4.*L+192.*cos(alpha_1).*R.^3.*L.^2+192.*cos(alpha_2).*R.^3.*L.^2+168.*cos(alpha_1).*R.^4.*L-4.*R.^4.*L.*cos(2.*alpha_2)+72.*R.*L.^4-12.*R.^3.*L.^2.*cos(-alpha_2+2.*alpha_1)+12.*R.^3.*L.^2.*cos(alpha_2+2.*alpha_1)+24.*R.^4.*L.*cos(alpha_2+2.*alpha_1)+208.*R.^3.*L.^2+8.*L.^5-12.*R.^3.*L.^2.*cos(-2.*alpha_2+alpha_1)+12.*R.^3.*L.^2.*cos(2.*alpha_2+alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_2)+216.*R.^4.*L+18.*L.^3.*R.^2.*cos(2.*alpha_1)+18.*L.^3.*R.^2.*cos(2.*alpha_2)-3.*L.^3.*R.^2.*cos(-2.*alpha_2+2.*alpha_1)+L.^3.*R.^2.*cos(2.*alpha_2+2.*alpha_1)+48.*cos(alpha_1).*L.^3.*R.^2-24.*R.^4.*L.*cos(alpha_1-alpha_2)+72.*R.^4.*L.*cos(alpha_1+alpha_2)+48.*cos(alpha_2).*R.^2.*L.^3+4.*R.*L.^4.*cos(2.*alpha_2)+96.*R.^5.*cos(alpha_1+alpha_2)-4.*R.^4.*L.*cos(2.*alpha_1)+152.*R.^5+24.*R.^4.*L.*cos(2.*alpha_2+alpha_1)+190.*L.^3.*R.^2+4.*R.*L.^4.*cos(2.*alpha_1)+8.*R.^5.*cos(2.*alpha_2+2.*alpha_1)).*ones(size(alpha_1)),...
        (-8.*R.^6.*sin(2.*alpha_2+alpha_1)-16.*R.^2.*L.^4.*sin(alpha_2)-8.*R.^4.*L.^2.*sin(2.*alpha_2)-56.*R.^6.*sin(alpha_2)+12.*R.^5.*L.*sin(2.*alpha_1)-4.*R.^3.*L.^3.*sin(alpha_2+2.*alpha_1)+12.*R.^3.*L.^3.*sin(-alpha_2+2.*alpha_1)+64.*R.^5.*L.*sin(alpha_1)-24.*R.^4.*L.^2.*sin(alpha_1+alpha_2)+72.*R.^4.*L.^2.*sin(alpha_1-alpha_2)-80.*R.^3.*L.^3.*sin(alpha_2)+8.*R.^6.*sin(alpha_2+2.*alpha_1)-12.*R.^4.*L.^2.*sin(alpha_2+2.*alpha_1)+12.*R.^4.*L.^2.*sin(-alpha_2+2.*alpha_1)-72.*R.^4.*L.^2.*sin(alpha_2)+56.*R.^6.*sin(alpha_1)+16.*R.^4.*L.^2.*sin(2.*alpha_1)-12.*R.^5.*L.*sin(2.*alpha_2)-64.*R.^5.*L.*sin(alpha_2)-4.*R.^5.*L.*sin(2.*alpha_2+2.*alpha_1)-24.*R.^5.*L.*sin(alpha_1+alpha_2)+72.*R.^5.*L.*sin(alpha_1-alpha_2))./(168.*cos(alpha_2).*R.^4.*L+192.*cos(alpha_1).*R.^3.*L.^2+192.*cos(alpha_2).*R.^3.*L.^2+168.*cos(alpha_1).*R.^4.*L-4.*R.^4.*L.*cos(2.*alpha_2)+72.*R.*L.^4-12.*R.^3.*L.^2.*cos(-alpha_2+2.*alpha_1)+12.*R.^3.*L.^2.*cos(alpha_2+2.*alpha_1)+24.*R.^4.*L.*cos(alpha_2+2.*alpha_1)+208.*R.^3.*L.^2+8.*L.^5-12.*R.^3.*L.^2.*cos(-2.*alpha_2+alpha_1)+12.*R.^3.*L.^2.*cos(2.*alpha_2+alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_2)+216.*R.^4.*L+18.*L.^3.*R.^2.*cos(2.*alpha_1)+18.*L.^3.*R.^2.*cos(2.*alpha_2)-3.*L.^3.*R.^2.*cos(-2.*alpha_2+2.*alpha_1)+L.^3.*R.^2.*cos(2.*alpha_2+2.*alpha_1)+48.*cos(alpha_1).*L.^3.*R.^2-24.*R.^4.*L.*cos(alpha_1-alpha_2)+72.*R.^4.*L.*cos(alpha_1+alpha_2)+48.*cos(alpha_2).*R.^2.*L.^3+4.*R.*L.^4.*cos(2.*alpha_2)+96.*R.^5.*cos(alpha_1+alpha_2)-4.*R.^4.*L.*cos(2.*alpha_1)+152.*R.^5+24.*R.^4.*L.*cos(2.*alpha_2+alpha_1)+190.*L.^3.*R.^2+4.*R.*L.^4.*cos(2.*alpha_1)+8.*R.^5.*cos(2.*alpha_2+2.*alpha_1)).*ones(size(alpha_1));...
        (32.*R.^5.*cos(alpha_1).*L+8.*R.^2.*cos(alpha_1).*L.^4+32.*R.^5.*L.*cos(alpha_2)+6.*R.^3.*L.^3.*cos(-2.*alpha_2+alpha_1)+2.*R.^3.*L.^3.*cos(2.*alpha_2+alpha_1)+12.*R.^5.*L.*cos(2.*alpha_1)+36.*R.^4.*L.^2.*cos(alpha_1-alpha_2)+36.*R.^4.*L.^2.*cos(alpha_1+alpha_2)+4.*R.^4.*L.^2.*cos(2.*alpha_1)+8.*R.^4.*L.^2.*cos(2.*alpha_2)+72.*R.^5.*L.*cos(alpha_1-alpha_2)+72.*R.^5.*L.*cos(alpha_1+alpha_2)+12.*R.^5.*L.*cos(2.*alpha_2)+56.*R.^6.*cos(alpha_1)+56.*R.^6.*cos(alpha_2)+8.*R.^6.*cos(2.*alpha_2+alpha_1)+12.*R.^4.*L.^2+24.*R.^5.*L+8.*R.^6.*cos(alpha_2+2.*alpha_1)+56.*R.^3.*L.^3.*cos(alpha_1)+84.*R.^4.*cos(alpha_1).*L.^2+12.*R.^4.*L.^2.*cos(-2.*alpha_2+alpha_1))./(168.*cos(alpha_2).*R.^4.*L+192.*cos(alpha_1).*R.^3.*L.^2+192.*cos(alpha_2).*R.^3.*L.^2+168.*cos(alpha_1).*R.^4.*L-4.*R.^4.*L.*cos(2.*alpha_2)+72.*R.*L.^4-12.*R.^3.*L.^2.*cos(-alpha_2+2.*alpha_1)+12.*R.^3.*L.^2.*cos(alpha_2+2.*alpha_1)+24.*R.^4.*L.*cos(alpha_2+2.*alpha_1)+208.*R.^3.*L.^2+8.*L.^5-12.*R.^3.*L.^2.*cos(-2.*alpha_2+alpha_1)+12.*R.^3.*L.^2.*cos(2.*alpha_2+alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_2)+216.*R.^4.*L+18.*L.^3.*R.^2.*cos(2.*alpha_1)+18.*L.^3.*R.^2.*cos(2.*alpha_2)-3.*L.^3.*R.^2.*cos(-2.*alpha_2+2.*alpha_1)+L.^3.*R.^2.*cos(2.*alpha_2+2.*alpha_1)+48.*cos(alpha_1).*L.^3.*R.^2-24.*R.^4.*L.*cos(alpha_1-alpha_2)+72.*R.^4.*L.*cos(alpha_1+alpha_2)+48.*cos(alpha_2).*R.^2.*L.^3+4.*R.*L.^4.*cos(2.*alpha_2)+96.*R.^5.*cos(alpha_1+alpha_2)-4.*R.^4.*L.*cos(2.*alpha_1)+152.*R.^5+24.*R.^4.*L.*cos(2.*alpha_2+alpha_1)+190.*L.^3.*R.^2+4.*R.*L.^4.*cos(2.*alpha_1)+8.*R.^5.*cos(2.*alpha_2+2.*alpha_1)).*ones(size(alpha_1)),...
        (32.*R.^5.*cos(alpha_1).*L+32.*R.^5.*L.*cos(alpha_2)+12.*R.^5.*L.*cos(2.*alpha_1)+36.*R.^4.*L.^2.*cos(alpha_1-alpha_2)+36.*R.^4.*L.^2.*cos(alpha_1+alpha_2)+6.*R.^3.*L.^3.*cos(-alpha_2+2.*alpha_1)+2.*R.^3.*L.^3.*cos(alpha_2+2.*alpha_1)+8.*R.^4.*L.^2.*cos(2.*alpha_1)+4.*R.^4.*L.^2.*cos(2.*alpha_2)+72.*R.^5.*L.*cos(alpha_1-alpha_2)+72.*R.^5.*L.*cos(alpha_1+alpha_2)+12.*R.^4.*L.^2.*cos(-alpha_2+2.*alpha_1)+56.*R.^3.*cos(alpha_2).*L.^3+84.*R.^4.*L.^2.*cos(alpha_2)+12.*R.^5.*L.*cos(2.*alpha_2)+56.*R.^6.*cos(alpha_1)+56.*R.^6.*cos(alpha_2)+8.*R.^6.*cos(2.*alpha_2+alpha_1)+12.*R.^4.*L.^2+24.*R.^5.*L+8.*R.^2.*L.^4.*cos(alpha_2)+8.*R.^6.*cos(alpha_2+2.*alpha_1))./(168.*cos(alpha_2).*R.^4.*L+192.*cos(alpha_1).*R.^3.*L.^2+192.*cos(alpha_2).*R.^3.*L.^2+168.*cos(alpha_1).*R.^4.*L-4.*R.^4.*L.*cos(2.*alpha_2)+72.*R.*L.^4-12.*R.^3.*L.^2.*cos(-alpha_2+2.*alpha_1)+12.*R.^3.*L.^2.*cos(alpha_2+2.*alpha_1)+24.*R.^4.*L.*cos(alpha_2+2.*alpha_1)+208.*R.^3.*L.^2+8.*L.^5-12.*R.^3.*L.^2.*cos(-2.*alpha_2+alpha_1)+12.*R.^3.*L.^2.*cos(2.*alpha_2+alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_2)+216.*R.^4.*L+18.*L.^3.*R.^2.*cos(2.*alpha_1)+18.*L.^3.*R.^2.*cos(2.*alpha_2)-3.*L.^3.*R.^2.*cos(-2.*alpha_2+2.*alpha_1)+L.^3.*R.^2.*cos(2.*alpha_2+2.*alpha_1)+48.*cos(alpha_1).*L.^3.*R.^2-24.*R.^4.*L.*cos(alpha_1-alpha_2)+72.*R.^4.*L.*cos(alpha_1+alpha_2)+48.*cos(alpha_2).*R.^2.*L.^3+4.*R.*L.^4.*cos(2.*alpha_2)+96.*R.^5.*cos(alpha_1+alpha_2)-4.*R.^4.*L.*cos(2.*alpha_1)+152.*R.^5+24.*R.^4.*L.*cos(2.*alpha_2+alpha_1)+190.*L.^3.*R.^2+4.*R.*L.^4.*cos(2.*alpha_1)+8.*R.^5.*cos(2.*alpha_2+2.*alpha_1)).*ones(size(alpha_1));...
        (-32.*R.^3.*L.^2-108.*R.^4.*L-76.*R.^5-12.*R.^4.*L.*cos(2.*alpha_2+alpha_1)+12.*R.^4.*L.*cos(alpha_1-alpha_2)-36.*R.^4.*L.*cos(alpha_1+alpha_2)-24.*cos(alpha_1).*L.^3.*R.^2-6.*R.^3.*L.^2.*cos(2.*alpha_2+alpha_1)+6.*R.^3.*L.^2.*cos(-2.*alpha_2+alpha_1)-48.*R.^5.*cos(alpha_1+alpha_2)-4.*R.^5.*cos(2.*alpha_2+2.*alpha_1)+8.*R.^4.*L.*cos(2.*alpha_2)-4.*R.^4.*L.*cos(2.*alpha_1)-84.*cos(alpha_1).*R.^4.*L-96.*cos(alpha_1).*R.^3.*L.^2)./(168.*cos(alpha_2).*R.^4.*L+192.*cos(alpha_1).*R.^3.*L.^2+192.*cos(alpha_2).*R.^3.*L.^2+168.*cos(alpha_1).*R.^4.*L-4.*R.^4.*L.*cos(2.*alpha_2)+72.*R.*L.^4-12.*R.^3.*L.^2.*cos(-alpha_2+2.*alpha_1)+12.*R.^3.*L.^2.*cos(alpha_2+2.*alpha_1)+24.*R.^4.*L.*cos(alpha_2+2.*alpha_1)+208.*R.^3.*L.^2+8.*L.^5-12.*R.^3.*L.^2.*cos(-2.*alpha_2+alpha_1)+12.*R.^3.*L.^2.*cos(2.*alpha_2+alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_2)+216.*R.^4.*L+18.*L.^3.*R.^2.*cos(2.*alpha_1)+18.*L.^3.*R.^2.*cos(2.*alpha_2)-3.*L.^3.*R.^2.*cos(-2.*alpha_2+2.*alpha_1)+L.^3.*R.^2.*cos(2.*alpha_2+2.*alpha_1)+48.*cos(alpha_1).*L.^3.*R.^2-24.*R.^4.*L.*cos(alpha_1-alpha_2)+72.*R.^4.*L.*cos(alpha_1+alpha_2)+48.*cos(alpha_2).*R.^2.*L.^3+4.*R.*L.^4.*cos(2.*alpha_2)+96.*R.^5.*cos(alpha_1+alpha_2)-4.*R.^4.*L.*cos(2.*alpha_1)+152.*R.^5+24.*R.^4.*L.*cos(2.*alpha_2+alpha_1)+190.*L.^3.*R.^2+4.*R.*L.^4.*cos(2.*alpha_1)+8.*R.^5.*cos(2.*alpha_2+2.*alpha_1)).*ones(size(alpha_1)),...
        (32.*R.^3.*L.^2+76.*R.^5+12.*R.^4.*L.*cos(alpha_2+2.*alpha_1)+4.*R.^4.*L.*cos(2.*alpha_2)-8.*R.^4.*L.*cos(2.*alpha_1)+108.*R.^4.*L+84.*cos(alpha_2).*R.^4.*L+96.*cos(alpha_2).*R.^3.*L.^2-6.*R.^3.*L.^2.*cos(-alpha_2+2.*alpha_1)+6.*R.^3.*L.^2.*cos(alpha_2+2.*alpha_1)+4.*R.^5.*cos(2.*alpha_2+2.*alpha_1)+24.*cos(alpha_2).*R.^2.*L.^3+48.*R.^5.*cos(alpha_1+alpha_2)+36.*R.^4.*L.*cos(alpha_1+alpha_2)-12.*R.^4.*L.*cos(alpha_1-alpha_2))./(168.*cos(alpha_2).*R.^4.*L+192.*cos(alpha_1).*R.^3.*L.^2+192.*cos(alpha_2).*R.^3.*L.^2+168.*cos(alpha_1).*R.^4.*L-4.*R.^4.*L.*cos(2.*alpha_2)+72.*R.*L.^4-12.*R.^3.*L.^2.*cos(-alpha_2+2.*alpha_1)+12.*R.^3.*L.^2.*cos(alpha_2+2.*alpha_1)+24.*R.^4.*L.*cos(alpha_2+2.*alpha_1)+208.*R.^3.*L.^2+8.*L.^5-12.*R.^3.*L.^2.*cos(-2.*alpha_2+alpha_1)+12.*R.^3.*L.^2.*cos(2.*alpha_2+alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_1)+24.*R.^3.*L.^2.*cos(2.*alpha_2)+216.*R.^4.*L+18.*L.^3.*R.^2.*cos(2.*alpha_1)+18.*L.^3.*R.^2.*cos(2.*alpha_2)-3.*L.^3.*R.^2.*cos(-2.*alpha_2+2.*alpha_1)+L.^3.*R.^2.*cos(2.*alpha_2+2.*alpha_1)+48.*cos(alpha_1).*L.^3.*R.^2-24.*R.^4.*L.*cos(alpha_1-alpha_2)+72.*R.^4.*L.*cos(alpha_1+alpha_2)+48.*cos(alpha_2).*R.^2.*L.^3+4.*R.*L.^4.*cos(2.*alpha_2)+96.*R.^5.*cos(alpha_1+alpha_2)-4.*R.^4.*L.*cos(2.*alpha_1)+152.*R.^5+24.*R.^4.*L.*cos(2.*alpha_2+alpha_1)+190.*L.^3.*R.^2+4.*R.*L.^4.*cos(2.*alpha_1)+8.*R.^5.*cos(2.*alpha_2+2.*alpha_1)).*ones(size(alpha_1))];



                
end
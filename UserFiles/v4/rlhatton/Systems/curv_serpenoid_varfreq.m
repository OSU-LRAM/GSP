% (a1*cos(2*pi*s*omega)+a2*sin(2*pi*s*omega))
function output = curv_serpenoid_varfreq(params,mode)

% Turn params into a cell matrix
params = num2cell(params);

switch mode
    
    case 'curvature'

		output = @(s) curv_fun(s,params{:});


    case 'angle'
        
		output = @(s) int_curv_ds_fun(s,params{:});

        
    case 'dcurvature'
        
		output = @(s) d_curv_dp_fun(s,params{:});

            
    case 'dcurvature_int'
        
		output = @(s) int_d_curv_dp_ds_fun(s,params{:});

                                   
end

end

function output = vector_to_list_input(funhandle,all_params)

    all_params = num2cell(all_params);
    
    output = funhandle(all_params{:});
    
end


function output = reshape_truncate_jacobian(J)

    output = J(2:end)';
    
end

function out1 = curv_fun(s,a1,a2,omega)
	t2 = pi.*omega.*s.*2.0;
	out1 = a1.*cos(t2)+a2.*sin(t2);
end


function out1 = int_curv_ds_fun(s,a1,a2,omega)
	t2 = sin(pi.*omega.*s);
	out1 = (a2.*t2.^2+a1.*sin(pi.*omega.*s.*2.0).*(1.0./2.0))./(pi.*omega);
end


function out1 = d_curv_dp_fun(s,a1,a2,omega)
	t2 = pi.*omega.*s.*2.0;
	t3 = cos(t2);
	t4 = sin(t2);
	out1 = [t3;t4;pi.*a1.*s.*t4.*-2.0+pi.*a2.*s.*t3.*2.0];
end


function out1 = int_d_curv_dp_ds_fun(s,a1,a2,omega)
	t2 = 1.0./pi;
	t3 = 1.0./omega;
	t7 = pi.*omega.*s;
	t4 = sin(t7);
	t5 = pi.*omega.*s.*2.0;
	t6 = sin(t5);
	t8 = t4.^2;
	t9 = 1.0./omega.^2;
	t10 = t8.*2.0;
	out1 = [t2.*t3.*t6.*(1.0./2.0);t2.*t3.*t8;a2.*t2.*t9.*(t10-pi.*omega.*s.*t6.*2.0).*(-1.0./2.0)-a1.*t2.*t9.*(t6+pi.*omega.*s.*(t10-1.0).*2.0).*(1.0./2.0)];
end


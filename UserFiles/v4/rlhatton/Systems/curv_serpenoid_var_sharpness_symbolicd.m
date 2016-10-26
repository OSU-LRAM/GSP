% cos(2*pi*s + atan2(a2, a1))^n*(a1^2 + a2^2)
function output = curv_serpenoid_var_sharpness_symbolicd(params,mode)

% Turn params into a cell matrix
params = num2cell(params);

switch mode
    
    case 'curvature'

		output = @(s) curv_fun(s,params{:});


    case 'angle'
        
		%% Padded length of unit backbone
		all_limits = [-.51 0 .51];
		
		%% Make dummy integration function
		curv_fun_dummy = curv_serpenoid_var_sharpness_symbolicd(cell2mat(params),'curvature');
		curvature = @(s,~) curv_fun_dummy(s);
		
		%% Integral of the integrand function along s
		output = ode_multistart(@ode45,curvature,all_limits,0,0);

        
    case 'dcurvature'
        
		output = @(s) d_curv_dp_fun(s,params{:});

            
    case 'dcurvature_int'
        
		%% Padded length of unit backbone
		all_limits = [-.51 0 .51];
		
		%% Make dummy integration function
		d_curv_dp_fun_dummy = curv_serpenoid_var_sharpness_symbolicd(cell2mat(params),'dcurvature');
		dcurvature = @(s,~) d_curv_dp_fun_dummy(s);
		
		%% Integral of the integrand function along s
		output = ode_multistart(@ode45,dcurvature,all_limits,0,zeros(size(params(:).')));

                                   
end

end

function output = vector_to_list_input(funhandle,all_params)

    all_params = num2cell(all_params);
    
    output = funhandle(all_params{:});
    
end


function output = reshape_truncate_jacobian(J)

    output = J(2:end)';
    
end

function out1 = curv_fun(s,a1,a2,n)
	out1 = cos(pi.*s.*2.0+atan2(a2,a1)).^n.*(a1.^2+a2.^2);
end


function out1 = d_curv_dp_fun(s,a1,a2,n)
	t2 = pi.*s.*2.0;
	t3 = atan2(a2,a1);
	t4 = t2+t3;
	t5 = cos(t4);
	t6 = t5.^n;
	t7 = n-1.0;
	t8 = t5.^t7;
	t9 = sin(t4);
	t10 = a1.^2;
	t11 = a2.^2;
	t12 = t10+t11;
	out1 = [a1.*t6.*2.0;a2.*t6.*2.0;t6.*t12.*log(t5)];
end


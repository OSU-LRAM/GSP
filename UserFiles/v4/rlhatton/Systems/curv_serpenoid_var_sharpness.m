% abs(cos(atan2(a2, a1) + 2*s*pi))^n*sign(cos(atan2(a2, a1) + 2*s*pi))*(a1^2 + a2^2)^(1/2)*((153949471934815*n)/562949953421312 - (1370981160259359*n^2)/144115188075855872 + (174464881467265*n^3)/1152921504606846976 + 6368462077980939/9007199254740992)
function output = curv_serpenoid_var_sharpness(params,mode)

% Turn params into a cell matrix
params = num2cell(params);

switch mode
    
    case 'curvature'

		output = @(s) curv_fun(s,params{:});


    case 'angle'
        
		%% Padded length of unit backbone
		all_limits = [-.51 0 .51];
		
		%% Make dummy integration function
		curv_fun_dummy = curv_serpenoid_var_sharpness(cell2mat(params),'curvature');
		curvature = @(s,~) curv_fun_dummy(s);
		
		%% Integral of the integrand function along s
		output = ode_multistart(@ode45,curvature,all_limits,0,0);

        
    case 'dcurvature'
        
		%% Create a dummy function that takes in a vector of parameters
		%% including s, and deals them into individual function parameters
		curv_intermediate = @(all_params) vector_to_list_input(@curv_fun,all_params);
		
		%% Create a function that takes the jacobian of the dummy function
		fulljacobian = @(s) jacobianest(curv_intermediate,[s,params{:}]);
		
		%% Create a function that truncates the s-derivative from the full jacobian
		output = @(s) reshape_truncate_jacobian(fulljacobian(s));

            
    case 'dcurvature_int'
        
		%% Padded length of unit backbone
		all_limits = [-.51 0 .51];
		
		%% Make dummy integration function
		d_curv_dp_fun_dummy = curv_serpenoid_var_sharpness(cell2mat(params),'dcurvature');
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
	t2 = a2.*1i;
	t3 = a1+t2;
	t4 = angle(t3);
	t5 = s.*pi.*2.0;
	t6 = t4+t5;
	t7 = cos(t6);
	t8 = n.^2;
	out1 = abs(t7).^n.*sign(t7).*sqrt(a1.^2+a2.^2).*(n.*2.734691973934655e-1-t8.*9.513092815295325e-3+n.*t8.*1.513241628073878e-4+7.070413230426608e-1);
end


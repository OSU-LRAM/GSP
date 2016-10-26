% (3665543810304250167*abs(cos(atan2(a2, a1) + 2*s*pi))^15*sign(cos(atan2(a2, a1) + 2*s*pi))*(a1^2 + a2^2)^(1/2))/1152921504606846976
function output = curv_triangle_wave(params,mode)

% Turn params into a cell matrix
params = num2cell(params);

switch mode
    
    case 'curvature'

		output = @(s) curv_fun(s,params{:});


    case 'angle'
        
		%% Padded length of unit backbone
		all_limits = [-.51 0 .51];
		
		%% Make dummy integration function
		curv_fun_dummy = curv_triangle_wave(cell2mat(params),'curvature');
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
		d_curv_dp_fun_dummy = curv_triangle_wave(cell2mat(params),'dcurvature');
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

function out1 = curv_fun(s,a1,a2)
	t6 = a2.*1i;
	t7 = a1+t6;
	t8 = angle(t7);
	t9 = s.*pi.*2.0;
	t10 = t8+t9;
	t11 = cos(t10);
	t2 = abs(t11);
	t3 = t2.^2;
	t4 = t3.^2;
	t5 = t4.^2;
	out1 = t2.*t3.*t4.*t5.*sign(t11).*sqrt(a1.^2+a2.^2).*3.179352449978129;
end


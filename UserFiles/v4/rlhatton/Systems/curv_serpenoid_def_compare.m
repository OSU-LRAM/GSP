function output = curv_serpenoid_def_compare(params,mode)

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

function out1 = curv_fun(s,a1,a2)
	t2 = s.*pi.*2.0;
	out1 = a1.*cos(t2)+a2.*sin(t2);
end


function out1 = int_curv_ds_fun(s,a1,a2)
	t2 = sin(s.*pi);
	out1 = (a1.*sin(s.*pi.*2.0).*(1.0./2.0)+a2.*t2.^2)./pi;
end


function out1 = d_curv_dp_fun(s,a1,a2)
	t2 = s.*pi.*2.0;
	out1 = [cos(t2);sin(t2)];
end


function out1 = int_d_curv_dp_ds_fun(s,a1,a2)
	t2 = 1.0./pi;
	t3 = sin(s.*pi);
	out1 = [t2.*sin(s.*pi.*2.0).*(1.0./2.0);t2.*t3.^2];
end


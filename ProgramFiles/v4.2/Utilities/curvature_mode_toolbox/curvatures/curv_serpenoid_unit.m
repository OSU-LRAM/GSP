function output = curv_serpenoid_unit(s,params,mode)

% Parse inputs
a1 = params(1); % cosine amplitude
a2 = params(2); % sine amplitude
omega = 1;

switch mode
    
    case 'curvature'

        kappa = a1*cos(2*pi*s*omega) + a2*sin(2*pi*s*omega);
        
        output = kappa;
        
    case 'angle'
        
        theta = 1/(2*pi*omega) * (a1*sin(2*pi*s*omega) + a2*(1-cos(2*pi*s*omega)));
        
        output = theta;
        
    case 'dcurvature'
        
        dkappa = [cos(2*pi*s*omega);
                sin(2*pi*s*omega)];
                %-a1*omega*sin(2*pi*s*omega) + a2*omega*cos(2*pi*s*omega)];
            
        output = dkappa;
        
    case 'dcurvature_int'
        
        dkappa_int = 1/(2*pi*omega) * [sin(2*pi*s*omega);
                                       1-cos(2*pi*s*omega)]; % plus one for definite integral

                                   
        output = dkappa_int;
end
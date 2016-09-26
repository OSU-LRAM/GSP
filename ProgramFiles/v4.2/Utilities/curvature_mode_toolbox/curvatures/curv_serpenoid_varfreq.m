function output = curv_serpenoid_varfreq(s,params,mode)

% Parse inputs
a1 = params(1); % cosine amplitude
a2 = params(2); % sine amplitude
omega = params(3); % Frequency

switch mode
    
    case 'curvature'

        %kappa = a1*cos(2*pi*s*omega) + a2*sin(2*pi*s*omega);
        kappa = omega.*(a1*cos(2*pi*s*omega) + a2*sin(2*pi*s*omega));
        
        output = kappa;
        
    case 'angle'
        
%        theta = 1/(2*pi*omega) * (a1*sin(2*pi*s*omega) + a2*(1-cos(2*pi*s*omega)));
        theta = 1/(2*pi) * (a1*sin(2*pi*s*omega) + a2*(1-cos(2*pi*s*omega)));
        
        output = theta;
        
    case 'dcurvature'
        
        dkappa = [omega*cos(2*pi*s*omega);
                omega*sin(2*pi*s*omega);
                omega.*(2.*a2.*s.*pi.*cos(2.*omega.*s.*pi) - 2.*a1.*s.*pi.*sin(2.*omega.*s.*pi)) + a1.*cos(2.*omega.*s.*pi) + a2.*sin(2.*omega.*s.*pi)];
            %(2*pi*s) * (-a1*sin(2*pi*s*omega) + a2*cos(2*pi*s*omega))];
            
        output = dkappa;

    case 'dcurvature_int'
        
        dkappa_int = [sin(2*pi*s*omega)/(2*pi*omega);
                                       (1-cos(2*pi*s*omega))/(2*pi*omega);
                                       a1.*s.*cos(2.*omega.*s.*pi) + a2.*s.*sin(2.*omega.*s.*pi)];
                                       %-((a1-2*pi*a2*s*omega).*sin(2*pi*s*omega) - (2*pi*a1*s*omega + a2).*cos(2*pi*s*omega) + a2)./(2*pi*omega.^2)];

                                   
        output = dkappa_int;
end
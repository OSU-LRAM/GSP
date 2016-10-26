function Mp = Granular_metric_calc(x,y,Mp_raw,alpha1,alpha2)
% This function take the shape changes and compute the Metric tensor based
% on new shape change using interpolation.

    Mp_raw = cell2mat(Mp_raw);
    % Rearrange the Metric Tensor
    Mp_cell = [{Mp_raw(1:2:end,1:2:end)} {Mp_raw(1:2:end,2:2:end)};{Mp_raw(2:2:end,1:2:end)} {Mp_raw(2:2:end,2:2:end)}];
    
    Mp = cellfun(@(u) interpn(alpha1,alpha2,u,x,y),Mp_cell, 'UniformOutput', false);
    
    Mp = cell2mat(Mp);

end

function gait_gui_draw

% Load the sysplotter configuration information
load sysplotter_config

% Bring current axis to foreground
figure(gcf)

% Use the mouse to select a series of points
[alpha1,alpha2,button] = ginputc('ShowPoints',true,'Color',Colorset.spot);

% Unless a non-primary button was used for the last click, copy the first
% point to the end to make a closed loop
if button(end) == 1
    alpha1 = [alpha1; alpha1(1)];
    alpha2 = [alpha2; alpha2(1)];
    
    % Set the period of the gait as 2pi
    period = 2*pi;
    
    % Evenly space the points along one period
    t = linspace(0,period,numel(alpha1));
    
    % Generate spline structures for the selected points
    spline_alpha1 = csape(t,alpha1','periodic');
    spline_alpha2 = csape(t,alpha2','periodic');
        
else
    
    % Set the period of the open motion as 1
    period = 1;
    
    % Evenly space the points along time from zero to 2pi
    t = linspace(0,period,numel(alpha1));
   
    % Generate spline structures for the selected points
    spline_alpha1 = csape(t,alpha1');
    spline_alpha2 = csape(t,alpha2');


end

% Upsample and plot to show gait to user
n_plot = 100;
t_plot = linspace(0,period,n_plot);
alpha1_plot = fnval(spline_alpha1,t_plot);
alpha2_plot = fnval(spline_alpha2,t_plot);

gaitline = line(alpha1_plot,alpha2_plot,'Color',Colorset.spot,'LineWidth',5);

%%%% Ask the user for a filename
current_dir = pwd; % Remember where we started
cd(shchpath)       % Move to shape change directory

% Make sure that the user selects a valid filename and doesn't try putting
% the file somewhere other than the Shape Changes directory

while 1

    [paramfilename,pathname] = uiputfile('*.mat','Select a file name starting with ''params_''','params_.mat');
    
    if isequal(paramfilename,0) && isequal(pathname,0) %if both filename and pathname are 0, user hit cancel
        usercancel = 1;
        break
    else
        [~,paramfilenamebare,ext] = fileparts(paramfilename); % Break open the filename to get the extension
    end
    
    if ( strncmp(paramfilename,'params_',7) && strcmp(ext,'.mat') )...
                    && strcmp(fullfile(pathname,paramfilename),fullfile(shchpath,paramfilename))
        usercancel = 0;
        break
    else
        disp('Must choose a filename starting with ''params_'' and in the Shape_Changes directory')
    end
        
end

cd(current_dir)    % Go back to original directory
%%%%

% If the user didn't hit cancel, save the data and create a shchf file that
% reads the data and interprets it as a gait.
if ~usercancel
    
    % Save the data to a parameters file
    save(fullfile(shchpath,paramfilename),'alpha1','alpha2','t')
    
    % Create the file if it doesn't already exist; future work could be
    % more fine-grained about this (making sure that any patches are
    % applied vs not overwriting any hand-edits the user made) and allowing
    % user to enter a prettier string for the display name here.
    
    if ~exist(fullfile(shchpath,['shchf_' paramfilenamebare '.m']),'file')
        
        gait_gui_draw_make_shchf(paramfilenamebare, paramfilenamebare)
        
    end
    
    % Refresh the sysplotter gui
    try
        set(groot,'ShowHiddenHandles','on');            % Crack open the sysplotter visibility
        refresh_handle = findobj('tag','refresh_gui');  % Get the handle for the button
        refresh_handle.Callback(refresh_handle,0)       % Push the refresh button
        set(groot,'ShowHiddenHandles','off');            % Reseal the sysplotter
    catch
        set(groot,'ShowHiddenHandles','off');            % Make sure the sysplotter goes back to hidden handles
    end
    
end
        
    

end
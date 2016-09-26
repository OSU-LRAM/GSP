function make_curvdef(curv_fun_string,paramlist)

% Turn the curvature function from a string into a symbolic expression
curv_fun = sym(curv_fun_string);

% Integrate the curvature function along the backbone
int_curv_fun_ds = int(curv_fun,'s',0,'s');

% Take the derivative of the curvature with respect to each parameter
d_curv_fun_dp = diff(curv_fun,paramlist



load sysplotter_config

% Open the template file
fidi = fopen(fullfile(sysplotterpath,'Utilities','gait_gui_draw',...
    'gait_gui_draw_template.txt'));

% Create the output file
fido = fopen(fullfile(shchpath,['curv_' paramfilename '.m']),'w');


while ~feof(fidi)
    
	% Read the next line from the input file
	s = fgetl(fidi);

    % Insert the shchf filename
    s = strrep(s,'AA_SHCHFILENAME',['shchf_' paramfilename]);
    
    % Give this file the correct paramfile
    s = strrep(s,'AA_PARAMSNAME',paramfilename);
    
    % Insert the displayname
    s = strrep(s,'AA_DISPLAYNAME',displayname);
    
    % Copy put the line into the new file
    fprintf(fido,'%s\n',s);
    
end
% --- Executes on button press in refresh_runinfo.
function [update, dep_update] = refresh_runinfo_Callback(hObject, eventdata, handles)
% hObject    handle to refresh_runinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Refresh the dependency and run display
	
	addpath('sys_update_fcns')

	% Declare a red
	crimson = [234 14 30]/255;
	
	% Read the menus
	syslist = get(handles.systemmenu,'UserData');
	sysval = get(handles.systemmenu,'Value');
	
	sys = syslist{sysval};
	
	shchlist = get(handles.shapechangemenu,'UserData');
	shchval = get(handles.shapechangemenu,'Value');

	shch = shchlist{shchval};
	
	
	placeholders = {'default','start_recent','end_recent'};
	
	if any(strcmp(sys,placeholders))
		sys=[];
	end
	
	if any(strcmp(shch,placeholders))
		shch=[];
	end
	
	% Get the dependency report
	[update, dep_update] = decide_components(sys,shch,handles);
	
	% Set the dependency and update markers
	components = fieldnames(dep_update);
	for i = 1:length(components),
		
		if dep_update.(components{i})
			set(handles.([components{i} '_dep_indicator']),'BackgroundColor',crimson)
		else
			set(handles.([components{i} '_dep_indicator']),'BackgroundColor','w')
		end

		if update.(components{i})
			set(handles.([components{i} '_run_indicator']),'BackgroundColor',crimson)
		else
			set(handles.([components{i} '_run_indicator']),'BackgroundColor','w')
		end
		
	end

end
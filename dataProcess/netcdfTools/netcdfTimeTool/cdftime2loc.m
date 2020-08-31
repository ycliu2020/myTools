function [timeSpec2]=cdftime2loc(dirc,formatOut,timeSpec)
    % find location of specific time in a netCDF file 
    % dirc(path struct): temp = dir([filepath_t, exist_names{1}, '_Amon*.nc']);
    % formatOut ='yyyy-mm';
    % timeSpec:specific time, string
    time = ncread(fullfile(dirc.folder,dirc.name), 'time'); %unite:day
    time = double(time);
    timeUnits = ncreadatt(fullfile(dirc.folder,dirc.name), 'time', 'units');
    timeCalendar = ncreadatt(fullfile(dirc.folder,dirc.name), 'time', 'calendar');
    time = cdfdate2num(timeUnits, timeCalendar, time);

    timeStr=string(datestr(time,formatOut));
    timeSpec2=find(timeStr==timeSpec);
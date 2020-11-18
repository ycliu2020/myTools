function [pp] = testLonlat(filepath)
    % By liuyincheng (ycliu@smail.nju.edu.cn)
    % purpose: test CMIP6 models(same experience) lon greater than 357.5(kernel lon) or not, then 
    % p_1 = 1:4%1 mean amip 2000; 2 mean amip 1980;3 means ssp245, 4 means ssp370; 5 mean amip-hist 2000; 6 mean amip-hist 1980

     
    lon_v.units = ncreadatt(filepath.name, 'lon', 'units');
    lon_v.data = ncread(filepath.name, 'lon');
    lat_v.units = ncreadatt(filepath.name, 'lat', 'units');
    lat_v.data = ncread(filepath.name, 'lat');
    pp=zeros(1,4);

    if ~strcmp(lon_v.units,'degrees_east')
        disp('warning: tagert lon units didnt match standart!')
        disp(['target: ',lon_v.units])
        disp(['standard: ','degrees_east'])
        pp(1)=1;
        return

    end

    if ~strcmp(lat_v.units,'degrees_north')
        disp('warning: tagert lat units didnt match standart!')
        disp(['target: ',lon_v.units])
        disp(['standard: ','degrees_north'])
        pp(1)=1;
        return

    end

    if max(lon_v.data) < 357.5%strcmp(level.model2{level1}(1:end),'CanESM5') == 1
        disp('warning: max lon less than 357.5!')
        disp(['tagert max lon is ', num2str(max(lon_v.data))])
        disp(['tagert min lon is ', num2str(min(lon_v.data))])
        pp(1)=1;
        pp(2)=1;

    end

    if min(lon_v.data) > 0%strcmp(level.model2{level1}(1:end),'CanESM5') == 1
        disp('warning: min lon greater than 0!')
        disp(['tagert max lon is ', num2str(max(lon_v.data))])
        disp(['tagert min lon is ', num2str(min(lon_v.data))])
        pp(1)=1;
        pp(3)=1;
    end

    if max(lat_v.data) < 90 %strcmp(level.model2{level1}(1:end),'CanESM5') == 1
        disp('warning: max lat less than 90!')
        disp(['tagert max lat is ', num2str(max(lat_v.data))])
        disp(['tagert min lat is ', num2str(min(lat_v.data))])
        pp(1)=1;
        pp(4)=1;
    end

    if pp(1) == 0
        disp('lon check is done, no problem.')
    end
        % plev.units = ncreadatt(filepath.name, 'plev', 'units');
    % plev.wards = ncreadatt(filepath.name, 'plev', 'positive');
    % plev.data=ncread(filepath.name, 'plev');
    % if length(plev.data)~=mPlev.length{p_1}
    %     disp('warning: length of plev isnt consist with standard!')
    %     disp(['target: ',length(plev.data)])
    %     disp(['standard: ',mPlev.length{p_1}])

    % if max(lon_v) < 357.5%strcmp(level.model2{level1}(1:end),'CanESM5') == 1
    %     temp_v3(:, end + 1, :, :) = temp_v3(:, 1, :, :);
    %     lon_v3(end + 1) = 360;
    % elseif max(lon_v4) < 357.5%strcmp(level.model2{level1}(1:end),'CanESM5') == 1
    %     temp_v4(:, end + 1, :, :, :) = temp_v4(:, 1, :, :, :);
    %     lon_v4(end + 1) = 360;
    % elseif strcmp(level.model2{level1}(1:end), 'GISS-E2-1-G') == 1
    %     temp_vv4 = temp_v4; temp_vv3 = temp_v3;
    %     temp_vv4(:, end + 1, :, :, :) = 0; temp_vv3(:, end + 1, :, :) = 0;
    %     temp_vv4(:, 1, :, :, :) = temp_v4(:, end, :, :, :);
    %     temp_vv4(:, 2:end, :, :, :) = temp_v4;
    %     temp_vv3(:, 1, :, :) = temp_v3(:, end, :, :);
    %     temp_vv3(:, 2:end, :, :) = temp_v3;
    %     lon_v3 = [-1.25; lon_v3]; lon_v4 = [-1.25; lon_v4];
    %     temp_v3 = temp_vv3; temp_v4 = temp_vv4;
    %     clear temp_vv3 temp_vv4
    % end


    % plev.units = ncreadatt(filepath.name, 'plev', 'units');
    % plev.wards = ncreadatt(filepath.name, 'plev', 'positive');
    % plev.data=ncread(filepath.name, 'plev');
    % if length(plev.data)~=mPlev.length{p_1}
    %     disp('warning: length of plev isnt consist with standard!')
    %     disp(['target: ',length(plev.data)])
    %     disp(['standard: ',mPlev.length{p_1}])
    %     elseif ~strcmp(plev.units,mPlev.units{p_1})
    %     disp('warning: units of plev isnt consist with standard!')
    %     disp(['target: ',plev.units])
    %     disp(['standard: ',mPlev.units{p_1}])
    %     elseif ~strcmp(plev.wards,mPlev.wards{p_1})
    %     disp('warning: dirct of plev isnt consist with standard!')
    %     disp(['target: ',plev.wards])
    %     disp(['standard: ',mPlev.wards{p_1}])
    %     elseif abs(max(plev.data)-mPlev.maxx{p_1})>=0.01&&abs(min(plev.data)-mPlev.minn{p_1})>=0.01
    %     disp('warning: max and min of plev isnt consist with standard!')
    %     disp(['target max: ',max(plev.data),'target min: ',min(plev.data)])
    %     disp(['standard max: ',mPlev.maxx{p_1},'standard min: ',mPlev.minn{p_1}])
    %     else
    %     disp('plev check is done, no problem.')
    end
    
    






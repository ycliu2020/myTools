function [] = testPlev(filepath, mPlev, p_1)
    % By liuyincheng (ycliu@smail.nju.edu.cn)
    % purpose: test CMIP6 models(same experience) level consistence
    % mPlev:standard parameters
    % p_1 = 1:4%1 mean amip 2000; 2 mean amip 1980;3 means ssp245, 4 means ssp370; 5 mean amip-hist 2000; 6 mean amip-hist 1980

    plev.units = ncreadatt(filepath.name, 'plev', 'units');
    plev.wards = ncreadatt(filepath.name, 'plev', 'positive');
    plev.axis = ncreadatt(filepath.name, 'plev', 'axis');
    plev.data=ncread(filepath.name, 'plev');

    if length(plev.data)~=mPlev.length{p_1}
        disp('warning: length of plev isnt consist with standard!')
        disp(['target: ', num2str(length(plev.data))])
        disp(['standard: ',num2str(mPlev.length{p_1})])
        elseif ~strcmp(plev.units,mPlev.units{p_1})
        disp('warning: units of plev isnt consist with standard!')
        disp(['target: ',plev.units])
        disp(['standard: ',mPlev.units{p_1}])
        elseif ~strcmp(plev.wards,mPlev.wards{p_1})
        disp('warning: dirct of plev isnt consist with standard!')
        disp(['target: ',plev.wards])
        disp(['standard: ',mPlev.wards{p_1}])
        elseif abs(max(plev.data)-mPlev.maxx{p_1})>=0.01&&abs(min(plev.data)-mPlev.minn{p_1})>=0.01
        disp('warning: max and min of plev isnt consist with standard!')
        disp(['target max: ', num2str(max(plev.data)),'target min: ', num2str(min(plev.data))])
        disp(['standard max: ',num2str(mPlev.maxx{p_1}),'standard min: ',num2str(mPlev.minn{p_1})])
        else
        disp('plev check is done, no problem.')
    end
    
    if ~strcmp(plev.axis,'Z')
        disp(['warning: axis not Z but ',plev.axis])
    end






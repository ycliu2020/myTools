function [pp, lon1, lat1, data1] = fixLonlat(pp, p_2, lon1, lat1, data1, filepath)

    % extend the vars to contain 0:2.5:357.5 and 90:-2.5:-90
    % pp : condition parameters
    % p_2 = 3 or 4 % mean 3 or 4D vars
    % lon1,lat1: input lat and lon
    % data1: input vars

    if pp(1) == 0
    else
        disp('start fix lon and lat problem: ')
        if p_2 == 4% 4D
            % lat
            if pp(4) == 1% lat <90

                if lat1(end) < 0
                    if lat1(end)~=-90
                        lat1(end + 1) = -90;
                        data1(:, end + 1, :, :) = data1(:, end, :, :);
                    end
                    lat1(2:end + 1) = lat1;
                    lat1(1) = 90;
                    data1(:, 2:end + 1, :, :) = data1;
                else
                    disp('error: lat(end)>0!!!!!!!!!')
                    return
                end


            end

            % lon
            if pp(2) == 0 && pp(3) == 0

            else
                lonInter = lon1(2:end) - lon1(1:end - 1);
                % interval
                if length(unique(lonInter)) == 1
                    lonInter = mean(lonInter);
                else
                    disp('error: lon interval isnt constant!!!!!!!!!')
                    return
                end

                if max(lon1) ~= lon1(end)
                    disp('error: lon direct didnt right!!!!!!!!!')
                    return
                end

                if pp(2) == 1 && pp(3) == 1% max(lon)<357.5 min(lon)>0
                    lon1(end + 1) = lon1(end) + lonInter;
                    lon1(2:end + 1) = lon1;
                    lon1(1) = lon1(1) - lonInter;
                    [x, y, z, t] = size(data1);
                    tempA = zeros(x + 2, y, z, t);
                    tempA(2:end - 1, :, :, :) = data1;
                    tempA(1, :, :, :) = data1(end, :, :, :);
                    tempA(end, :, :, :) = data1(1, :, :, :);
                    data1 = tempA; clear tempA
                elseif pp(2) == 1 && pp(3) ~= 1% max(lon)<357.5
                    lon1(end + 1) = lon1(end) + lonInter;
                    data1(end + 1, :, :, :) = data1(1, :, :, :);
                elseif pp(2) ~= 1 && pp(3) == 1% min(lon)>0
                    lon1(2:end + 1) = lon1;
                    lon1(1) = lon1(1) - lonInter;
                    data1(2:end + 1, :, :, :) = data1;
                    data1(1, :, :, :) = data1(end, :, :, :);
                end

            end

        elseif p_2 == 3 % 3D
            % lat
            if pp(4) == 1% lat <90

                if lat1(end) < 0
                    if lat1(end)~=-90
                        lat1(end + 1) = -90;
                        data1(:, end + 1, :) = data1(:, end, :);
                    end
                    lat1(2:end + 1) = lat1;
                    lat1(1) = 90;
                    data1(:, 2:end + 1, :) = data1;
                else
                    disp('error: lat(end)>0!!!!!!!!!')
                    return
                end

           
            end

            % lon
            if pp(2) == 0 && pp(3) == 0

            else
                lonInter = lon1(2:end) - lon1(1:end - 1);
                % interval
                if length(unique(lonInter)) == 1
                    lonInter = mean(lonInter);
                else
                    disp('error: lon interval isnt constant!!!!!!!!!')
                    return
                end

                if max(lon1) ~= lon1(end)
                    disp('error: lon direct didnt right!!!!!!!!!')
                    return
                end

                if pp(2) == 1 && pp(3) == 1% max(lon)<357.5 min(lon)>0
                    lon1(end + 1) = lon1(end) + lonInter;
                    lon1(2:end + 1) = lon1;
                    lon1(1) = lon1(1) - lonInter;
                    [x, y, z, t] = size(data1);
                    tempA = zeros(x + 2, y, z, t);
                    tempA(2:end - 1, :, :) = data1;
                    tempA(1, :, :) = data1(end, :, :);
                    tempA(end, :,  :) = data1(1, :, :);
                    data1 = tempA; clear tempA
                elseif pp(2) == 1 && pp(3) ~= 1% max(lon)<357.5
                    lon1(end + 1) = lon1(end) + lonInter;
                    data1(end + 1, :, :) = data1(1, :, :);
                elseif pp(2) ~= 1 && pp(3) == 1% min(lon)>0
                    lon1(2:end + 1) = lon1;
                    lon1(1) = lon1(1) - lonInter;
                    data1(2:end + 1, :,:) = data1;
                    data1(1, :, :) = data1(end, :, :);
                end

            end

        end
        % test part
        disp('check again: ')
        lon_v.units = ncreadatt(filepath.name, 'lon', 'units');
        lon_v.data = lon1;
        lat_v.units = ncreadatt(filepath.name, 'lat', 'units');
        lat_v.data = lat1;
        pp=zeros(1,4);
    
        if ~strcmp(lon_v.units,'degrees_east')
            disp('warning: tagert lon units didnt match standart!')
            disp(['target: ',lon_v.units])
            disp(['standard: ','degrees_east'])
            pp(1)=1;
        end
    
        if ~strcmp(lat_v.units,'degrees_north')
            disp('warning: tagert lat units didnt match standart!')
            disp(['target: ',lon_v.units])
            disp(['standard: ','degrees_north'])
            pp(1)=1;
        end
    
        if max(lon_v.data) < 357.5
            disp('warning: max lon less than 357.5!')
            disp(['tagert max lon is ', num2str(max(lon_v.data))])
            disp(['tagert min lon is ', num2str(min(lon_v.data))])
            pp(1)=1;
            pp(2)=1;
    
        end
    
        if min(lon_v.data) > 0
            disp('warning: max lon greater than 0!')
            disp(['tagert max lon is ', num2str(max(lon_v.data))])
            disp(['tagert min lon is ', num2str(min(lon_v.data))])
            pp(1)=1;
            pp(3)=1;
        end
    
        if max(lat_v.data) < 90 
            disp('warning: max lat less than 90!')
            disp(['tagert max lat is ', num2str(max(lat_v.data))])
            disp(['tagert min lat is ', num2str(min(lat_v.data))])
            pp(1)=1;
            pp(4)=1;
        end
    
        if pp(1) == 0
            disp('lon check is done, no problem.')
        end
    

    end

end

function [] = testTime(timeTrans, startyear, endyear, startmon)
    % By liuyincheng (ycliu@smail.nju.edu.cn)
    % purpose: test matlab transformed time(Consider a leap year) if fixed
    % compare the consistance to the raw model time(every year only has 365 days)
    % note: only apply to month data, and The number of years must be an integer 
    % timeTrans: matlab transformed time
    % startyear:choose which year to start
    % endyear:choose which year to end
    % startmon:choose which month to start
    [yy, mm, dd] = datevec(timeTrans);
    yearSeries = startyear:endyear;
    numyear = length(yearSeries);

    temp = 1:12;
    temp = temp([startmon:12 1:startmon-1]);
    monthSeries = repmat(temp, 1, numyear);

    yy1 = yearSeries(1) - yy(1);
    yy2 = yearSeries(end) - yy(end);

    if isempty(find(yy1 ~= 0, 1)) && isempty(find(yy2 ~= 0, 1))
        disp('year check is done, no problem.')
    else
        disp('warning: transformed year didnt consist with raw data !')
        disp('transformed data first year:')
        disp(yy(1))
        disp('transformed data last year:')
        disp(yy(end))
    end

    mm1 = monthSeries' - mm;

    if isempty(find(mm1 ~= 0, 1))
        disp('month check is done, no problem.')
    else
        disp('warning: transformed month didnt consist with raw data !')
        disp('minus result:')
        disp(mm1)
    end

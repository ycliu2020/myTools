function [readme,  tLin] = observeParameters(p_1)
    % By liuyincheng (ycliu@smail.nju.edu.cn)
    % purpose: auto output observe data parameters, so we only need to modify once if something change.
    % p_1 mean: 1.2000-03 to 2018-02(18*12) 2.200207-201706(15*12)


    %% time line (tLin)
    tLin.time = {'200003-201802', '200207-201706'}; % initial and last year
    tLin.start = {'2000-03', '2002-07'}; % start year
    tLin.inter = {18*12 15*12}; % total months
    tLin.startmonth = {3 7}; % start months

    % readme
    readme.readme = 'this is erai vars data all sky and clear sky drad ';
    readme.vars = 'including albeo, ts, water, ta ';
    readme.time = tLin.time(p_1);
end

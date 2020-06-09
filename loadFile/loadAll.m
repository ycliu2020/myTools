function loadAll
    % Loads all mat files in the current directory
    filepath=pwd;
    Files = dir(fullfile(filepath,'/*.mat'));
    LengthFiles = length(Files);
    for i = 1:LengthFiles
        load ([Files(i).folder,'/',Files(i).name])       
    end
    
end
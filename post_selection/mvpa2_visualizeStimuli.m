<<<<<<< HEAD
%% Visualize stimuli
% Show on the screen french and braille words to be screenshotted
% To add:
% - screenshot -> DOES IT BUT ALL BLACK, NO SIGN OF LETTERS
%
% - possible to resize them autmoatically (maybe with gimp?)

% IMPORTANT: CHANGE SOURCE FOR DIFFERENT SETS
clear
load('mvpa_sota17.mat');

%% Print the words

this = stimuli.box;
% cfg = vbEvrel_setParameters;
% cfg = initFixation(cfg);
% cfg.screen.win = this.win;
% 
% 
% thisFixation.fixation = cfg.fixation;
% thisFixation.screen = cfg.screen;

% Open Screen and add background
Screen('Preference', 'SkipSyncTests', 1);

try
    % Routine stuff
    % PTB opens a windows on the screen with the max index
    screens = Screen('Screens');
    whichscreen = max(screens);
    [this.win, this.rect] = Screen('OpenWindow', whichscreen, this.bg_color);
    
%     FONT AND SIZE ARE REALLY IMPORTANT
    Screen('TextFont', this.win, this.font);
    Screen('TextSize', this.win, this.size);

    
    % RUN ONCE: SHOWS IN ORDER THE SAME STIMULUS AS FW, BW, SBW (MORE TO
    % IMPLEMENT)
    for i = 1:size(this.words,1)
        
        % Screenshot stuff
        % Name is images.ld.word
        wordFilename = char(stimuli.variableNames(i));
        
        % Get word infos and parameters: char array to print and
        % coordinates on where to do so
        thisWord = this.words(i,:);
        [thisChar, thisCoord] = mvpaCoordinates(thisWord, this, i);
        
        brCoord = stimuli.box.references{6,3}{1};
        stX = this.w_x/2 - (this.references{6,4}/2) - brCoord(1);
        stL = this.w_x/2 - (this.references{6,4}/2) - brCoord(1) -40 -28; % for words moved to the left
        stR = this.w_x/2 - (this.references{6,4}/2) - brCoord(1) +40 +28; % for words moved to the right
        stY = this.w_y/2 - brCoord(2) +47 -12;
        
%         thisNword = this.nonwords(i,:);
%         [thisNchar, thisNcoord] = mvpaCoordinates(thisNword, this, i);

        % Blank screen
        Screen('FillRect', this.win, this.bg_color);
        
        % FW
        %
        % Make letters start at the same pixel (just with a and b at the moment)
        for d = 1:length(thisChar)
            DrawFormattedText(this.win, thisChar(d), thisCoord(d,1), thisCoord(d,2), this.txt_color);
        end      
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.center.w' char(num2str(i)) ' = temp_scr(437:644, 501:1420, :)']);    
        WaitSecs(0.3);
           
        % BW
        %
        % Just print them as centered
        DrawFormattedText(this.win, double(stimuli.braille.words{i}), stX, stY, this.txt_color);
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.center.w' char(num2str(i+8)) ' = temp_scr(437:644, 501:1420, :)']);
        WaitSecs(0.3);
        
        
        
        % 2+4 (moved to the right)
        % FW
        %
        % Make letters start at the same pixel (just with a and b at the moment)
                 
        % BW
        %
        % Just print them as centered
        DrawFormattedText(this.win, double(stimuli.braille.words{i}), stR, stY, this.txt_color);
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.right.w' char(num2str(i+8)) ' = temp_scr(437:644, 501:1420, :)']);
        WaitSecs(0.3);

        
        
        % 4+2 (moved to the left)
        % FW
        %
        % Make letters start at the same pixel (just with a and b at the moment)
               
        % BW
        %
        % Just print them as centered
        DrawFormattedText(this.win, double(stimuli.braille.words{i}), stL, stY, this.txt_color);
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.left.w' char(num2str(i+8)) ' = temp_scr(437:644, 501:1420, :)']);
        WaitSecs(0.3);
        
    end
    
    % Buffer screen 
    Screen('FillRect', this.win, this.bg_color);
    Screen('Flip', this.win);
    WaitSecs(2);
    
    % Show Braille words - later
       
    % Final screen - don't know if it's still needed. Too afraid to delete
    Screen('FillRect', this.win, this.bg_color);
    Screen('Flip', this.win);
    WaitSecs(1);
    
    % Closing up
    Screen('CloseAll');
    ShowCursor
    
catch
    
    % Closes the onscreen window if it is open.
    Priority(0);
    if exist('origLUT', 'var')
        Screen('LoadNormalizedGammaTable', screenNumber, origLUT);
    end
    Screen('CloseAll');
    psychrethrow(psychlasterror);
    
end

%% move the words for left and right
%
% Keep the same x length, butadd/remove coloumns of 0s at the begging/end
% of the matrix to creat the movement
% (easier than first implementation)

for i=1:8
    eval(['thisL = images.center.w' char(num2str(i)) ';']);
    eval(['thisR = images.center.w' char(num2str(i)) ';']);
    
    wrd = char(this.words.string(i));
    % RIGHT: AB+CDEF
    lengthR = stimuli.box.letters{stimuli.box.letters.char == wrd(3),3} + stimuli.box.words{i,5};
    % modify this to adjust: higher number = more to the right (fix closer
    % to B
    switch i 
        case 1, lengthR  = lengthR +3; % cochon
        case 2, lengthR  = lengthR +2; % faucon
        case 3, lengthR  = lengthR +5; % balcon
        case 4, lengthR  = lengthR +3; % vallon
        case 5, lengthR  = lengthR +3; % poulet
        case 6, lengthR  = lengthR +3; % roquet
        case 7, lengthR  = lengthR -1; % chalet
        case 8, lengthR  = lengthR +3; % sommet
    end
    zAddR = zeros(208,lengthR,3);
    zAddR = uint8(zAddR);
    newR = [zAddR,thisR];
    newR(:,end-lengthR+1:end, :) = [];
    
    % LEFT: ABCD+EF
    lengthL = stimuli.box.letters{stimuli.box.letters.char == wrd(4),3} + stimuli.box.words{i,5};
    % modify this to adjust: higher number = more to the left (fix closer
    % to E)
    switch i 
        case 1, lengthL  = lengthL +0; % cochon
        case 2, lengthL  = lengthL +0; % faucon
        case 3, lengthL  = lengthL -2; % balcon
        case 4, lengthL  = lengthL -2; % vallon
        case 5, lengthL  = lengthL +0; % poulet
        case 6, lengthL  = lengthL +0; % roquet
        case 7, lengthL  = lengthL +2; % chalet
        case 8, lengthL  = lengthL -2; % sommet
    end
    zAddL = zeros(208,lengthL,3);
    zAddL = uint8(zAddL);
    newL = [thisL, zAddL];
    newL(:, 1:lengthL, :) = [];
    
    
    eval(['images.left.w' char(num2str(i)) ' = newL;']);
    eval(['images.right.w' char(num2str(i)) ' = newR;']);
    
end


% FINAL CLEANUP AND SAVE
save('mvpa_sota17.mat','this','stimuli','images','mvpa_words');

=======
%% Visualize stimuli
% Show on the screen french and braille words to be screenshotted
% To add:
% - screenshot -> DOES IT BUT ALL BLACK, NO SIGN OF LETTERS
%
% - possible to resize them autmoatically (maybe with gimp?)

% IMPORTANT: CHANGE SOURCE FOR DIFFERENT SETS
clear
load('mvpa_sota17.mat');

%% Print the words

this = stimuli.box;
% cfg = vbEvrel_setParameters;
% cfg = initFixation(cfg);
% cfg.screen.win = this.win;
% 
% 
% thisFixation.fixation = cfg.fixation;
% thisFixation.screen = cfg.screen;

% Open Screen and add background
Screen('Preference', 'SkipSyncTests', 1);

try
    % Routine stuff
    % PTB opens a windows on the screen with the max index
    screens = Screen('Screens');
    whichscreen = max(screens);
    [this.win, this.rect] = Screen('OpenWindow', whichscreen, this.bg_color);
    
%     FONT AND SIZE ARE REALLY IMPORTANT
    Screen('TextFont', this.win, this.font);
    Screen('TextSize', this.win, this.size);

    
    % RUN ONCE: SHOWS IN ORDER THE SAME STIMULUS AS FW, BW, SBW (MORE TO
    % IMPLEMENT)
    for i = 1:size(this.words,1)
        
        % Screenshot stuff
        % Name is images.ld.word
        wordFilename = char(stimuli.variableNames(i));
        
        % Get word infos and parameters: char array to print and
        % coordinates on where to do so
        thisWord = this.words(i,:);
        [thisChar, thisCoord] = mvpaCoordinates(thisWord, this, i);
        
        brCoord = stimuli.box.references{6,3}{1};
        stX = this.w_x/2 - (this.references{6,4}/2) - brCoord(1);
        stL = this.w_x/2 - (this.references{6,4}/2) - brCoord(1) -40 -28; % for words moved to the left
        stR = this.w_x/2 - (this.references{6,4}/2) - brCoord(1) +40 +28; % for words moved to the right
        stY = this.w_y/2 - brCoord(2) +47 -12;
        
%         thisNword = this.nonwords(i,:);
%         [thisNchar, thisNcoord] = mvpaCoordinates(thisNword, this, i);

        % Blank screen
        Screen('FillRect', this.win, this.bg_color);
        
        % FW
        %
        % Make letters start at the same pixel (just with a and b at the moment)
        for d = 1:length(thisChar)
            DrawFormattedText(this.win, thisChar(d), thisCoord(d,1), thisCoord(d,2), this.txt_color);
        end      
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.center.w' char(num2str(i)) ' = temp_scr(437:644, 501:1420, :)']);    
        WaitSecs(0.3);
           
        % BW
        %
        % Just print them as centered
        DrawFormattedText(this.win, double(stimuli.braille.words{i}), stX, stY, this.txt_color);
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.center.w' char(num2str(i+8)) ' = temp_scr(437:644, 501:1420, :)']);
        WaitSecs(0.3);
        
        
        
        % 2+4 (moved to the right)
        % FW
        %
        % Make letters start at the same pixel (just with a and b at the moment)
                 
        % BW
        %
        % Just print them as centered
        DrawFormattedText(this.win, double(stimuli.braille.words{i}), stR, stY, this.txt_color);
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.right.w' char(num2str(i+8)) ' = temp_scr(437:644, 501:1420, :)']);
        WaitSecs(0.3);

        
        
        % 4+2 (moved to the left)
        % FW
        %
        % Make letters start at the same pixel (just with a and b at the moment)
               
        % BW
        %
        % Just print them as centered
        DrawFormattedText(this.win, double(stimuli.braille.words{i}), stL, stY, this.txt_color);
        Screen('Flip', this.win);
        % Screenshot: first all the screen, then cut what we need 
        % (PTB was not cooperating, that's why the double step)
        temp_scr = Screen('GetImage', this.win, [0, 0, 1920, 1080]); 
        eval(['images.left.w' char(num2str(i+8)) ' = temp_scr(437:644, 501:1420, :)']);
        WaitSecs(0.3);
        
    end
    
    % Buffer screen 
    Screen('FillRect', this.win, this.bg_color);
    Screen('Flip', this.win);
    WaitSecs(2);
    
    % Show Braille words - later
       
    % Final screen - don't know if it's still needed. Too afraid to delete
    Screen('FillRect', this.win, this.bg_color);
    Screen('Flip', this.win);
    WaitSecs(1);
    
    % Closing up
    Screen('CloseAll');
    ShowCursor
    
catch
    
    % Closes the onscreen window if it is open.
    Priority(0);
    if exist('origLUT', 'var')
        Screen('LoadNormalizedGammaTable', screenNumber, origLUT);
    end
    Screen('CloseAll');
    psychrethrow(psychlasterror);
    
end

%% move the words for left and right
%
% Keep the same x length, butadd/remove coloumns of 0s at the begging/end
% of the matrix to creat the movement
% (easier than first implementation)

for i=1:8
    eval(['thisL = images.center.w' char(num2str(i)) ';']);
    eval(['thisR = images.center.w' char(num2str(i)) ';']);
    
    wrd = char(this.words.string(i));
    % RIGHT: AB+CDEF
    lengthR = stimuli.box.letters{stimuli.box.letters.char == wrd(3),3} + stimuli.box.words{i,5};
    % modify this to adjust: higher number = more to the right (fix closer
    % to B
    switch i 
        case 1, lengthR  = lengthR +3; % cochon
        case 2, lengthR  = lengthR +2; % faucon
        case 3, lengthR  = lengthR +5; % balcon
        case 4, lengthR  = lengthR +3; % vallon
        case 5, lengthR  = lengthR +3; % poulet
        case 6, lengthR  = lengthR +3; % roquet
        case 7, lengthR  = lengthR -1; % chalet
        case 8, lengthR  = lengthR +3; % sommet
    end
    zAddR = zeros(208,lengthR,3);
    zAddR = uint8(zAddR);
    newR = [zAddR,thisR];
    newR(:,end-lengthR+1:end, :) = [];
    
    % LEFT: ABCD+EF
    lengthL = stimuli.box.letters{stimuli.box.letters.char == wrd(4),3} + stimuli.box.words{i,5};
    % modify this to adjust: higher number = more to the left (fix closer
    % to E)
    switch i 
        case 1, lengthL  = lengthL +0; % cochon
        case 2, lengthL  = lengthL +0; % faucon
        case 3, lengthL  = lengthL -2; % balcon
        case 4, lengthL  = lengthL -2; % vallon
        case 5, lengthL  = lengthL +0; % poulet
        case 6, lengthL  = lengthL +0; % roquet
        case 7, lengthL  = lengthL +2; % chalet
        case 8, lengthL  = lengthL -2; % sommet
    end
    zAddL = zeros(208,lengthL,3);
    zAddL = uint8(zAddL);
    newL = [thisL, zAddL];
    newL(:, 1:lengthL, :) = [];
    
    
    eval(['images.left.w' char(num2str(i)) ' = newL;']);
    eval(['images.right.w' char(num2str(i)) ' = newR;']);
    
end


% FINAL CLEANUP AND SAVE
save('mvpa_sota17.mat','this','stimuli','images','mvpa_words');

>>>>>>> master

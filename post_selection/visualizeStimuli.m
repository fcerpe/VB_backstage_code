%% Visualize stimuli
% Show on the screen french and braille words to be screenshotted
% To add:
% - screenshot -> DOES IT BUT ALL BLACK, NO SIGN OF LETTERS
%
% - possible to resize them autmoatically (maybe with gimp?)

% IMPORTANT: CHANGE SOURCE FOR DIFFERENT SETS
clear;
load('localizer_stimuli.mat');

%% Print the words
% One at the time, 5 seconds each to screenshot manually

this = stimuli.box;
images = struct;

imgArray = zeros(400,400,20);

% Open Screen and add background
Screen('Preference', 'SkipSyncTests', 1);

try
    % Routine stuff
    % PTB opens a windows on the screen with the max index
    screens = Screen('Screens');
    whichscreen = max(screens);
    [this.win, this.rect] = Screen('OpenWindow', whichscreen, this.bg_color);
    
    % FONT AND SIZE ARE REALLY IMPORTANT
    Screen('TextFont', this.win, this.font);
    Screen('TextSize', this.win, this.size);
    
    HideCursor;
    
    % Show french words first
    for i=1:size(this.words,1)
        
        % Get word infos and parameters: char array to print and
        % coordinates on where to do so
        thisWord = this.words(i,:);
        [thisChar, thisCoord] = makeCoordinates(thisWord, this);
        
        % Screenshot stuff
        % Name is images.scr_word
        wordFilename = thisChar;
        if i == 8
            wordFilename = 'piece';
        end
                
        % Square of 400*400px around the center
        halfX = this.w_x/2; halfY = this.w_y/2;
        position = [halfX-200 halfY-200 400 400];
               
        % Blank screen
        Screen('FillRect', this.win, this.bg_color);
        
        % Make letters start at the same pixel (just with a and b at the moment)
        for d = 1:length(thisChar)
            DrawFormattedText(this.win, thisChar(d), thisCoord(d,1), thisCoord(d,2), this.txt_color);
        end
        Screen('Flip', this.win);
        eval(['images.scr_' wordFilename ' = screencapture(0, position);']); 
        WaitSecs(0.5);
               
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

%% FINAL CLEANUP AND SAVE

save('localizer_stimuli.mat','localizer_words','stimuli','images');



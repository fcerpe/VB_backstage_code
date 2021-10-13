%% scramble images on the spot for the retreat presentation

clear
load('localizer_sota1012.mat');

%       X X X X X X X X X X X X X X X X X X X X X X 550x300
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X O Q X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X 
%       X X X X X X X X X X X X X X X X X X X X X X (X=25px)
%       X X X X X X X X X X X X X X X X X X X X X X total = 264 squares

% first loop for SFW
for loop = 1:length(stimuli.variableNames)
    
    % get current stimulus 
    eval(['this = images.fw.' char(stimuli.variableNames(loop)) ';']);
    
    % get image sizes 
    % first pixel on x axis
    sumX = sum(this(:,:,1),1);
    for iniX=1:length(sumX)
        if sumX(iniX) ~= 0
            break
        end
    end    
    % last pixel on x axis
    for endX = length(sumX):-1:1
        if sumX(endX) ~= 0
            break
        end
    end    
    % first pixel on y axis
    sumY = sum(this(:,:,1),2);
    for iniY=1:length(sumY)
        if sumY(iniY) ~= 0
            break
        end
    end    
    % last pixel on y axis
    for endY=length(sumY):-1:1
        if sumY(endY) ~= 0
            break
        end
    end
       
    % size of the square
    sizePx = 25;
    
    % round dimensions to a cell unit (25x25 pixels)
    fX = 25*floor(iniX/25)+1;
    lX = 25*(floor(endX/25)+1);
    fY = 25*floor(iniY/25)+1;
    lY = 25*(floor(endY/25)+1);
    
    % new arrangement. Permutation tells us which block will be put into
    % the position.
    % e.g. newMat position 1 = old mat position 56
    numRows = round((lY-fY)/25); 
    numCols = round((lX-fX)/25);
    numSquares = numRows * numCols;
    newOrder = randperm(numSquares);
    
    % and new temp matrix
    newMat = zeros(300,550,3);
    
    % to loop through the new order
    k = 1;
    for i = fY:25:lY
        for j = fX:25:lX
            % get starting position for copy-paste
            % Y
            y = (mod(newOrder(k),numRows)*25)-24+fY; % every 22 start again in a new row
            if mod(newOrder(k),numRows) == 0
                y = lY-24;
            end
            % X 
            x = (floor(newOrder(k)/numRows))*25 + 1;
            if newOrder(k) == numSquares
                x = lX-24;
            end
            
            newMat(i:i+24, j:j+24, :) = this(y:y+24, x:x+24, :);
            k = k+1;
        end
    end
    
    % save mat as image format and put it with the other stimuli
    newMat = uint8(newMat);
    eval(['images.sfw.' char(stimuli.variableNames(loop)) ' = newMat;']);

end

%% second loop for SLD (same)

for loop = 1:length(stimuli.variableNames)
        
    % get current stimulus 
    eval(['this = images.ld.' char(stimuli.variableNames(loop)) ';']);
    
    % get image sizes 
    % first pixel on x axis
    sumX = sum(this(:,:,1),1);
    for iniX=1:length(sumX)
        if sumX(iniX) > 100
            break
        end
    end    
    % last pixel on x axis
    for endX = length(sumX):-1:1
        if sumX(endX) > 100
            break
        end
    end    
    % first pixel on y axis
    sumY = sum(this(:,:,1),2);
    for iniY=1:length(sumY)
        if sumY(iniY) > 100 % imported images are not perfect (apparently)
            break
        end
    end    
    % last pixel on y axis
    for endY=length(sumY):-1:1
        if sumY(endY) > 100
            break
        end
    end
    
    % in particular cases, images are bad. Brute force those (I checked
    % the matrices manually, so it's ok) 
    if loop == 4
        iniY = 90; endY = 210; 
    end
    if loop == 5
        iniY = 110;
    end
    if loop == 10
        endY = 187; 
    end
    if loop == 20
        iniY = 115; endY = 200; iniX = 25; endX = 531;
    end

       
    
    % size of the square
    sizePx = 25;
    
    % round dimensions to a cell unit (25x25 pixels)
    fX = 25*floor(iniX/25)+1;
    lX = 25*(floor(endX/25)+1);
    fY = 25*floor(iniY/25)+1;
    lY = 25*(floor(endY/25)+1);
    
    if lX > 550
        lX = 550;
    end
    
    if lY > 300
        lY = 300;
    end
    
    % new arrangement. Permutation tells us which block will be put into
    % the position.
    % e.g. newMat position 1 = old mat position 56
    numRows = round((lY-fY)/25); 
    numCols = round((lX-fX)/25);
    numSquares = numRows * numCols;    
    newOrder = randperm(numSquares);
    
    % and new temp matrix
    newMat = zeros(300,550,3);
    
    % to loop through the new order
    k = 1;
    for i = fY:25:lY
        for j = fX:25:lX
            % get starting position for copy-paste
            % Y
            y = (mod(newOrder(k),numRows)*25)-24+fY;
%             if fY ~= 1
%                 y = y + fY;
%             end
            if mod(newOrder(k),numRows) == 0
                y = lY-24;
            end
            % X 
            x = (floor(newOrder(k)/numRows))*25 + 1;
            if newOrder(k) == numSquares
                x = lX-24;
            end
            
            newMat(i:i+24, j:j+24, :) = this(y:y+24, x:x+24, :);
            k = k+1;
        end
    end
    
    % save mat as image format and put it with the other stimuli
    newMat = uint8(newMat);
    eval(['images.sld.' char(stimuli.variableNames(loop)) ' = newMat;']);

end

%% Save 

save('localizer_sota1008.mat','localizer_words','stimuli','images');
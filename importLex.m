%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: C:\Users\filip\Desktop\PHD\code\phd1_vb\Lexique383\Lexique383.xlsb
%    Worksheet: Lexique383
%
% Auto-generated by MATLAB on 05-Jan-2021 17:56:17

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 31);

% Specify sheet and range
opts.Sheet = "Lexique383";
opts.DataRange = "A2:AE142695";

% Specify column names and types
opts.VariableNames = ["ortho", "phon", "lemme", "cgram", "genre", "nombre", "Var7", "Var8", "freqfilms2", "freqlivres", "Var11", "Var12", "Var13", "islem", "nblettres", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "nbsyll", "Var25", "Var26", "Var27", "Var28", "Var29", "deflem", "defobs"];
opts.SelectedVariableNames = ["ortho", "phon", "lemme", "cgram", "genre", "nombre", "freqfilms2", "freqlivres", "islem", "nblettres", "nbsyll", "deflem", "defobs"];
opts.VariableTypes = ["char", "categorical", "categorical", "categorical", "categorical", "categorical", "char", "char", "double", "double", "char", "char", "char", "double", "double", "char", "char", "char", "char", "char", "char", "char", "char", "double", "char", "char", "char", "char", "char", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["ortho", "Var7", "Var8", "Var11", "Var12", "Var13", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var25", "Var26", "Var27", "Var28", "Var29"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["ortho", "phon", "lemme", "cgram", "genre", "nombre", "Var7", "Var8", "Var11", "Var12", "Var13", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var25", "Var26", "Var27", "Var28", "Var29"], "EmptyFieldRule", "auto");

% Import the data
lex = readtable("C:\Users\filip\Desktop\PHD\code\phd1_vb\Lexique383\Lexique383.xlsb", opts, "UseExcel", true);


%% Clear temporary variables
clear opts
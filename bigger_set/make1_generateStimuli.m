
clear

% from previous selection(s)
realWords = ["canard"; "castor"; "faucon"; "tortue"; "fourmi"; "oiseau"; "poulet"; "renard"; "saumon"; "souris"; ...
             "bouton"; "caméra"; "dessin"; "flacon"; "miroir"; "rasoir"; "montre"; "stéréo"; "valise"; "violon"];

pseudoWords = ["satard"; "catoir"; "fanvon"; "formin"; "paseau"; "poumer"; "renale"; "souson"; "sorise"; "toinue";...
               "boumon"; "cemére"; "disson"; "répoir"; "visoir"; "moitre"; "facoup"; "sivéro";	"vorise"; "voilon"];

nonWords = ["yyqhgw"; "ghkhwz"; "hjjwky"; "kjwqzx"; "jwykzj"; "gxhwxk"; "gkqqzx"; "kyhqwy"; "kqgwwh"; "kqkwgy";...
            "gygqhk"; "xzjgwg"; "wxqzgg"; "ykzxwq"; "qqhgkj"; "jxqkhq"; "hwgqyw"; "zgxqyz"; "zxjqgk"; "xhhwqy"];
 

load('stimuliProperties.mat');

pseudoWords(:,2) = brailify(pseudoWords, stimuli);
realWords(:,2) = brailify(realWords, stimuli);
nonWords(:,2) = brailify(nonWords, stimuli);

% manually counted
realWords(:,3) = ["15";"17";"16";"20";"18";"14";"19";"18";"17";"18";"19";"17";"17";"16";"16";"17";"20";"26";"15";"19"];
pseudoWords(:,3) = ["16";"16";"19";"19";"14";"19";"16";"19";"17";"18";"18";"19";"18";"23";"18";"18";"16";"22";"18";"19"];
nonWords(:,3) = ["26";"22";"22";"22";"24";"22";"24";"24";"23";"24";"23";"23";"25";"24";"20";"20";"25";"26";"22";"24"];

selNW = nonWords([2:6,9:12,15:16,19:19],[1:3]);
selRW = realWords([2:2,4:5,7:8,10:12,16:18,20:20],[1:3]);
selPW = pseudoWords([2:4,6:6,8:8,10:12,14:14,16:16,18:18,20:20],[1:3]);


avgPW = sum(double(selPW(:,3)))/12;
avgRW = sum(double(selRW(:,3)))/12;
avgNW = sum(double(selNW(:,3)))/12;

sdPW = std(double(selPW(:,3)));
sdRW = std(double(selRW(:,3)));
sdNW = std(double(selNW(:,3)));

save('word_analysis.mat');

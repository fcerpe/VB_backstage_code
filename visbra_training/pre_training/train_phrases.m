%% GET PHRASES

input_phrases = ["elle est à la maison";...
                 "son père écrit des livres"; 
                 "regarde mon tableau"; ...
                 "cette veste est super"; ...
                 "je promène mon chien"; ...
                 "elle veut un café"; ...
                 "merci pour ton cadeau"; ...  
                 "je parle à mon voisin"; ...
                 "ma cousine chante faux"; ... 
                 "le pain est dur et sec"; ... 
                 "paul ne ment jamais"; ... 
                 "lola aime jouer avec ses poupées"; ...
                 "laurie sent bon le savon"; ... 
                 "audrey court chaque semaine"; ...  
                 "marine galope sur son cheval"; ... 
                 "le palmier pousse si vite"; ...   
                 "il faut bien brosser ses dents"; ... 
                 "il fait froid ce matin"; ... 
                 "pierre pense à sa mère"; ...               
                 "le panier bleu est plein"; ... 
                 "le chat se couche sur moi"; ...            
                 "lucie a un manteau jaune"; ...
                 "je nage dans la piscine";...
                 "ils vont au cinéma"; ...
                 "son chien aboie jour et nuit"; ...
                 "la voiture de simon est rouge"; ...
                 "il congèle ses légumes"; ...
                 "elle ne sort pas de chez elle"; ...
                 "julie ne porte pas les sacs"; ...
                 "vous ne marchez pas vite"];


%% load set, split phrases into single words, save everything

string_cluster = "";

for iP = 1:size(input_phrases,1)
    thisP = input_phrases(iP);
    input_split = split(thisP,' ');
    for iS = 1:length(input_split)
        thisS = input_split(iS);
        string_cluster = vertcat(string_cluster, thisS);
    end
end

phrases_elements = unique(string_cluster);

phrases_order = shuffle(input_phrases);

clearvars ans input_split iP iS string_cluster thisP thisS

save('visbra_training_set.mat');


save('visbra_training_set.mat');
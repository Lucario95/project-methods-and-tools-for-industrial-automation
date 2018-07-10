function [punto_vendita439, punto_vendita443, punto_vendita445, punto_vendita447, punto_vendita452, punto_vendita457] = importdata() 

[~, ~, raw] = xlsread('./dati/erogato.xlsx','Erogato');
raw = raw(3:end,19:20);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw);                      
raw(R) = {NaN};                                                            
data = reshape([raw{:}],size(raw));
punto_vendita439 = data;
clearvars data raw R;

[~, ~, raw] = xlsread('./dati/erogato.xlsx','Erogato');
raw = raw(3:end,21:23);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw);                      
raw(R) = {NaN};                                                            
data = reshape([raw{:}],size(raw));
punto_vendita443 = data;
clearvars data raw R;

[~, ~, raw] = xlsread('./dati/erogato.xlsx','Erogato');
raw = raw(3:end,24:26);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw);                      
raw(R) = {NaN};                                                            
data = reshape([raw{:}],size(raw));
punto_vendita445 = data;
clearvars data raw R;

[~, ~, raw] = xlsread('./dati/erogato.xlsx','Erogato');
raw = raw(3:end,27:29);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw);                      
raw(R) = {NaN};                                                            
data = reshape([raw{:}],size(raw));
punto_vendita447 = data;
clearvars data raw R;

[~, ~, raw] = xlsread('./dati/erogato.xlsx','Erogato');
raw = raw(3:end,30:32);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw);                      
raw(R) = {NaN};                                                            
data = reshape([raw{:}],size(raw));
punto_vendita452 = data;
clearvars data raw R;

[~, ~, raw] = xlsread('./dati/erogato.xlsx','Erogato');
raw = raw(3:end,33:34);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw);                      
raw(R) = {NaN};                                                            
data = reshape([raw{:}],size(raw));
punto_vendita457 = data;
clearvars data raw R;

end
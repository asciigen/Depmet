% This is a matlab program to convert a .CNT file into .CSV data file
% License: The MIT License (MIT)
% Author: Vinita Kumawat, Deepak Sharma

clear all;
cd C:\Users\Deepak\Documents\Depmet\Depmet;
cnt = loadcnt('Sushi.cnt');
cntdata = transpose(cnt.data);
disp('Writting csv file');
n = cnt.header.nchannels;
samp = cnt.header.numsamples + 1;
lab = 1:n;
csvdata = zeros(samp,n);
csvdata(1,:) = lab;
csvdata(2:samp,1:n) = cntdata;
csvwrite('Sushi.csv', csvdata);
disp('Conversion completed');

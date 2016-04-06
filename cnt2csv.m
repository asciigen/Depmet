clear all;
cd C:\Users\Deepak\Documents\Depmet\Depmet;
cntStruct = loadcnt('Sushi.cnt');
cntdata = cntStruct.data;
disp('Writting csv file');
csvwrite('Sushi.csv', transpose(cntStruct.data));
disp('Finish');

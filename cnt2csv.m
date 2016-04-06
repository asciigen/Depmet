cd C:\Users\Deepak\Documents\Depmet\Depmet;
cntStruct = loadcnt('SUSHMITA SET SHIFTING.cnt');
disp('CNT file structure');
disp(cntStruct);
cntdata = cntStruct.data;
disp('writting csv file');
for i=1:32
  elec = cntStruct.electloc(1).lab; 
end
csvwrite('sushmita.csv', transpose(cntStruct.data));
disp('Finish');

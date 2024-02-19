hold off;
clc;
clear;
%loading data from Excel; dates, coordinates and culture
%table_2D=readtable('Chalcolithic Dates.xlsx','Sheet','Cal 1 s');
%table_2D=readtable('Chalcolithic Dates.xlsx','Sheet','Calibarated dates second');
table_2D=readtable('Chalcolithic Dates.xlsx','Sheet','Calibarated dates third');
table_2D=table_2D(:,1:11);

%%Calibrated dates by site
%this part makes a 2D map of all the calibrated dates of the cultures

%For Gilead's interpretation press 1 or 0
model=2 
%For Dates to be non cal press 2
date_type=1

dates=table2array(table_2D(:,5:6))
Last_date=numel(dates(:,1))
Coordinates_each_date=table2array(table_2D(:,7:10))
summed_Coordinates_each_date=(Coordinates_each_date(:,1)+((Coordinates_each_date(:,2)/1000))+((Coordinates_each_date(:,3)/10000))+((Coordinates_each_date(:,4)/100000)))
table_2D(:,12)=num2cell(summed_Coordinates_each_date)
sorted_Coordinates=sort(summed_Coordinates_each_date).'
sorted_Coordinates=unique(sorted_Coordinates)
sorted_Coordinates=(sorted_Coordinates(~isnan(sorted_Coordinates)))
%This is relevant because I used Gilead's opinion
if model==2
for n=1:Last_date
if find(ismember(table2array(table_2D(n,2)),'OxA 3556'))
    table_2D{n,11}={['GH']};
    elseif  find(ismember(table2array(table_2D(n,2)),'Beta 131730'))
    table_2D{n,11}={['GH']}; 
    elseif find(ismember(table2array(table_2D(n,2)),'W-1341'))
    table_2D{n,11}={['GH']}; 
    elseif find(ismember(table2array(table_2D(n,2)),'OxA 4011'))
    table_2D{n,11}={['Besorian']}; 
    elseif find(ismember(table2array(table_2D(n,2)),'OZD025'))
    table_2D{n,11}={['poWRpGh']}; 
    elseif find(ismember(table2array(table_2D(n,2)),'OZD024'))
    table_2D{n,11}={['poWRpGh']}; 
    elseif find(ismember(table2array(table_2D(n,2)),'OZD026'))
    table_2D{n,11}={['poWRpGh']}; 
    elseif find(ismember(table2array(table_2D(n,2)),'OFZ421'))
    table_2D{n,11}={['poWRpGh']}; 
end
end
end

Culture_each_date=table2array(table_2D(:,11))

for n=1:Last_date
   if find(ismember(Culture_each_date(n,1),'Besorian')); 
   table_2D{n,13}={[1]};
   elseif find(ismember(Culture_each_date(n,1),'WR'));  
   table_2D{n,13}={[1]};
   elseif find(ismember(Culture_each_date(n,1),'Qat')) ;
   table_2D{n,13}={[2]};
   elseif find(ismember(Culture_each_date(n,1),'GH')) ;
   table_2D{n,13}={[4]};
   elseif find(ismember(Culture_each_date(n,1),'EBI')); 
   table_2D{n,13}={[5]};
   elseif find(ismember(Culture_each_date(n,1),'poWRpG')) ;
   table_2D{n,13}={[2]};
   elseif find(ismember(Culture_each_date(n,1),'poWRpGh')) ;
   table_2D{n,13}={[1.1]};
   end;
end;
%sorting it according to place, culture, and date 
table_2D=sortrows(table_2D,[12 13 6])
dates=table2array(table_2D(:,5:6))
%this if you want not calibrated
if date_type==2
dates=[[-table2array(table_2D(:,3))]-[table2array(table_2D(:,4))],[-table2array(table_2D(:,3))]+[table2array(table_2D(:,4))]];

end
Culture_each_date=table2array(table_2D(:,11))
Coordinates_each_date=table2array(table_2D(:,7:10))
   Linewide=0.7
   LinesSpace=0.13
   x2=LinesSpace
   Spacing=1
   x=1
   Text_place=-7000

    xticks_loc=zeros(1,numel(sorted_Coordinates))  
    xticks_name=cellstr(num2str(zeros(1,numel(sorted_Coordinates))))
    k=1 
    
   for n=1:Last_date
   if isnumeric(Coordinates_each_date(n,1));
   Site_cor_sum=(Coordinates_each_date(n,1)+((Coordinates_each_date(n,2)/1000))+((Coordinates_each_date(n,3)/10000))+((Coordinates_each_date(n,4)/100000)))
   if Site_cor_sum~=x    
   Spacing=1
   x2=LinesSpace
   hold on
   if find(ismember(Culture_each_date(n,1),'Besorian')) 
   plot([(find(sorted_Coordinates==Site_cor_sum)) (find(sorted_Coordinates==Site_cor_sum))],[dates(n,:)],'Linewidth',Linewide,'Color','[1 0.84 0]')
   elseif find(ismember(Culture_each_date(n,1),'poWRpGh'))
   plot([(find(sorted_Coordinates==Site_cor_sum)) (find(sorted_Coordinates==Site_cor_sum))],[dates(n,:)],'Linewidth',Linewide,'Color','[1 0.43 0.29]')
   %text((find(sorted_Coordinates==Site_cor_sum)),Text_place,char(table2array(table_2D(n,1))),'Rotation',90)
   elseif find(ismember(Culture_each_date(n,1),'poWRpG'))
   plot([(find(sorted_Coordinates==Site_cor_sum)) (find(sorted_Coordinates==Site_cor_sum))],[dates(n,:)],'Linewidth',Linewide,'Color','[1 0.43 0.29]')
   %text((find(sorted_Coordinates==Site_cor_sum)),Text_place,char(table2array(table_2D(n,1))),'Rotation',90)
   elseif find(ismember(Culture_each_date(n,1),'Qat'))
   plot([(find(sorted_Coordinates==Site_cor_sum)) (find(sorted_Coordinates==Site_cor_sum))],[dates(n,:)],'Linewidth',Linewide,'Color','[0.60 0.47 0.48]')
   %text((find(sorted_Coordinates==Site_cor_sum)),Text_place,char(table2array(table_2D(n,1))),'Rotation',90)
   elseif find(ismember(Culture_each_date(n,1),'WR'))
   plot([(find(sorted_Coordinates==Site_cor_sum)) (find(sorted_Coordinates==Site_cor_sum))],[dates(n,:)],'Linewidth',Linewide,'Color','[0.5 0.29 0.18]')
   %text((find(sorted_Coordinates==Site_cor_sum)),Text_place,char(table2array(table_2D(n,1))),'Rotation',90)
   elseif find(ismember(Culture_each_date(n,1),'EBI'))
   plot([(find(sorted_Coordinates==Site_cor_sum)) (find(sorted_Coordinates==Site_cor_sum))],[dates(n,:)],'Linewidth',Linewide,'Color','[0.24 0.71 0.54]')
   %text((find(sorted_Coordinates==Site_cor_sum)),Text_place,char(table2array(table_2D(n,1))),'Rotation',90)
   elseif find(~cellfun(@isempty, regexp(Culture_each_date(n,1),'(GH)\w*')))
   plot([(find(sorted_Coordinates==Site_cor_sum)) (find(sorted_Coordinates==Site_cor_sum))],[dates(n,:)],'Linewidth',Linewide,'Color','[0.81 0.08 0.17]')
   %text((find(sorted_Coordinates==Site_cor_sum)),Text_place,char(table2array(table_2D(n,1))),'Rotation',90)
   
   end
   
   xticks_loc(k)=find(sorted_Coordinates==Site_cor_sum)
   Cur_name=(table2array(table_2D(find(table2array(table_2D(:,12))==Site_cor_sum),1)))
   xticks_name(k)=Cur_name(1)
    
   hold on
   k=k+1
   
   end
   if Site_cor_sum==x
   if find(ismember(Culture_each_date(n,1),'Besorian'))
   plot([(find(sorted_Coordinates==Site_cor_sum))+x2 (find(sorted_Coordinates==Site_cor_sum)+x2)],[dates(n,:)],'Linewidth',Linewide,'Color','[1 0.84 0]')   
   x2=x2+LinesSpace
   elseif find(ismember(Culture_each_date(n,1),'poWRpG'))    
   plot([(find(sorted_Coordinates==Site_cor_sum))+x2 (find(sorted_Coordinates==Site_cor_sum))+x2],[dates(n,:)],'Linewidth',Linewide,'Color','[1 0.43 0.29]')
   x2=x2+LinesSpace
   elseif find(ismember(Culture_each_date(n,1),'poWRpGh'))    
   plot([(find(sorted_Coordinates==Site_cor_sum))+x2 (find(sorted_Coordinates==Site_cor_sum))+x2],[dates(n,:)],'Linewidth',Linewide,'Color','[1 0.43 0.29]')
   x2=x2+LinesSpace
   elseif find(~cellfun(@isempty, regexp(Culture_each_date(n,1),'(GH)\w*')))
   plot([(find(sorted_Coordinates==Site_cor_sum))+x2 (find(sorted_Coordinates==Site_cor_sum))+x2],[dates(n,:)],'Linewidth',Linewide,'Color','[0.81 0.08 0.17]')
   x2=x2+LinesSpace
   elseif find(ismember(Culture_each_date(n,1),'EBI'))
   plot([(find(sorted_Coordinates==Site_cor_sum))+x2 (find(sorted_Coordinates==Site_cor_sum))+x2],[dates(n,:)],'Linewidth',Linewide,'Color','[0.24 0.71 0.54]')
   x2=x2+LinesSpace
   elseif find(ismember(Culture_each_date(n,1),'Qat'))
   plot([(find(sorted_Coordinates==Site_cor_sum))+x2 (find(sorted_Coordinates==Site_cor_sum))+x2],[dates(n,:)],'Linewidth',Linewide,'Color','[0.60 0.47 0.48]')
   x2=x2+LinesSpace
   elseif find(ismember(Culture_each_date(n,1),'WR'))
   plot([(find(sorted_Coordinates==Site_cor_sum))+x2 (find(sorted_Coordinates==Site_cor_sum))+x2],[dates(n,:)],'Linewidth',Linewide,'Color','[0.5 0.29 0.18]')
   x2=x2+LinesSpace
      hold on
   end
   Spacing=Spacing+1
   end
   x=Site_cor_sum    
   if Spacing==8 %this is for spacing of the coordinated indexes- the x axis
   sorted_Coordinates=[(sorted_Coordinates(1:(find(sorted_Coordinates==Site_cor_sum)))) 1 (sorted_Coordinates(((find(sorted_Coordinates==Site_cor_sum)+1)):end))];
   Spacing=1
   end
   end
   hold on
   end
xticks([xticks_loc])
   
ylim([-6000 -3000]) 
if date_type==2
    ylim([-7500 -4000]) 
end
xticklabels([xticks_name])
xtickangle(90)
set(gca,'FontName','Calibri','fontsize',8)

%I need to somehow move the text of the site name to the right, in the same
%proportion that is in the for loop
%check why gap with moddiin is so large, the data has to be plotted from left to right so make it possible, data in excel must be manipulated. maybe I should 
%put a collumn in excel with the specific counted cordinates (site cor sum)
%and arrange it there from small to big and then the n will be accordingly
%from north to south

%for legend
Location_legend=numel(sorted_Coordinates)+1;

Location_square=numel(sorted_Coordinates)+6;
Cultures= [{'Wadi Rabba'},{'Qatifian'},'poWRpG','Besorian' ,'Ghassulian','Early Bronze I']
Color=[{'[0.5 0.29 0.18]'},'[0.60 0.47 0.48]','[1 0.43 0.29]','[1 0.84 0]','[0.81 0.08 0.17]','[0.24 0.71 0.54]']
Height=(-5850:100:-5350)
if date_type==2
Height=(-7400:100:-6900)
end
for n=1:6
text(Location_legend,Height(n),char(Cultures(n)),'color',char(Color(n)),'FontName','Calibri','fontsize',8) 
scatter(Location_square,Height(n)+10,'s','filled','MarkerFaceColor',cell2mat(Color(n)))
end
grid on
grid minor

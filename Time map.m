clc;
clear;
%loading data from Excel; approximate
%span and coordinates of sites, also the names of the sites
Map_table=readtable('Map table.xlsx','Sheet','Map table');
Name_table=readtable('Map table.xlsx','Sheet','For names');
Authors_span(:,1)=cell2mat(table2cell(Map_table(:,2)));
Authors_span(:,2)=cell2mat(table2cell(Map_table(:,3)));
Coordinates=cell2mat(table2cell(Map_table(:,5:8)));
Cultures=table2array(Map_table(:,9));
%char(table2array(table_2D(n,1)))
%for the map, reading the picture of the map
%Map=imread('Israel_relief_location_map.jpg');
Map=imread('Israel_relief_location_map-blank.jpg');

%setting the x and y axes- coordinates
x = 34-0.3:(1/60):36+0.3;
y = 30-0.7:(1/60):33+0.5;
[n, Sizey]=size(x)
[n,Sizex]=size(y)

[x,y]=meshgrid(x,y);
min_year=-6000;
max_year=-3000;

figure('units','normalized','outerposition',[0 0 1 1])
hold on;

warp(x,y,ones(Sizex,Sizey)*min_year,flipud(Map));
set(gca,'YDir','normal');
hold on;
zlim([min_year max_year]);
Last_date=numel(Authors_span(:,1))


    for n=1:Last_date
   if Coordinates(n,1)>0;
       East_coordinate=Coordinates(n,3);
       East_sub_coordinate=Coordinates(n,4);
       North_coordinate=Coordinates(n,1);
       North_sub_coordinate=Coordinates(n,2);
       if table2array(Map_table(n,10))>0
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[min_year -(Authors_span(n,2))],'--','Color','[0.13 0.55 0.13 0.6]','MarkerSize',12,'LineWidth',0.01);
       end       
       if find(ismember(Cultures(n,1),'WR'))
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[-(Authors_span(n,2)) -(Authors_span(n,1))],'Color','[0.5 0.29 0.18]','MarkerSize',12,'LineWidth',3);    
       elseif find(ismember(Cultures(n,1),'Qat'))
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[-(Authors_span(n,2)) -(Authors_span(n,1))],'Color','[0.60 0.47 0.48]','MarkerSize',12,'LineWidth',3);    
       elseif(ismember(Cultures(n,1),'Besorian'))
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[-(Authors_span(n,2)) -(Authors_span(n,1))],'Color','[1 0.87 0]','MarkerSize',12,'LineWidth',3);
       pbaspect([1 1.5 1]);
       elseif find(ismember(Cultures(n,1),'PGH'))
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[-(Authors_span(n,2)) -(Authors_span(n,1))],'Color','[1 0.43 0.29]','MarkerSize',12,'LineWidth',3);    
       elseif find(ismember(Cultures(n,1),'GH'))     
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[-(Authors_span(n,2)) -(Authors_span(n,1))],'Color','[0.81 0.08 0.17]','MarkerSize',12,'LineWidth',3);    
       elseif find(ismember(Cultures(n,1),'EBI'))
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[-(Authors_span(n,2)) -(Authors_span(n,1))],'Color','[0.24 0.71 0.54]','MarkerSize',12,'LineWidth',3);    
       elseif find(ismember(Cultures(n,1),'PGH-GH Transition'))
       scale=30
       Years_gradient=-[(Authors_span(n,2))-(Authors_span(n,1))]/scale
       minimal=-(Authors_span(n,1))
       %those numbers are the remainder of orange color code minus the
       %orange color code
       a=0.19/scale
       b=0.35/scale
       c=0.12/scale
       for n=1:scale
%the minus is from the orange color
       color=[1-a 0.43-b 0.29-c]
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[minimal+Years_gradient minimal],'Color',mat2str(color),'MarkerSize',12,'LineWidth',3);    
       a=a+0.19/scale
       b=b+0.35/scale
       c=c+0.12/scale
       hold on
       minimal=minimal+Years_gradient
       end
       elseif find(ismember(Cultures(n,1),'WR-PGH Transition'))
       scale=30
       Years_gradient=-[(Authors_span(n,2))-(Authors_span(n,1))]/scale
       minimal=-(Authors_span(n,1))
       %those numbers are the remainder of orange color code minus the
       %brown color code
       a=0.5/scale
       b=0.14/scale
       c=0.11/scale
       for n=1:scale
%the plus is from the brown color
       color=[0.5+a 0.29+b 0.18+c]
       plot3([(East_coordinate)+((East_sub_coordinate)/60) (East_coordinate)+((East_sub_coordinate)/60)],[North_coordinate+((North_sub_coordinate)/60) (North_coordinate)+((North_sub_coordinate)/60)],[minimal+Years_gradient minimal],'Color',mat2str(color),'MarkerSize',12,'LineWidth',3);    
       a=a+0.5/scale
       b=b+0.14/scale
       c=c+0.11/scale
       hold on
       minimal=minimal+Years_gradient
       end
       end
   end
 end


grid on
ax.XGrid = 'on'

%to put the names of the sites in the wanted place

Coordinates=cell2mat(table2cell(Name_table(:,2:5)));
Site_Z=cell2mat(table2cell(Name_table(:,7)));
for n=1:numel(Site_Z)
       East_coordinate=Coordinates(n,3);
       East_sub_coordinate=Coordinates(n,4);
       North_coordinate=Coordinates(n,1);
       North_sub_coordinate=Coordinates(n,2);
       site_name=char(Name_table{(n),1})
       site_titles=text([(East_coordinate)+((East_sub_coordinate)/60)],[ (North_coordinate)+((North_sub_coordinate)/60)],(-Site_Z(n)),(site_name),'Rotation',90,'VerticalAlignment','bottom','FontSize',8,'fontname','Segoe UI Semibold');
    end
   hold on;
xlim([34-0.3 36+0.3]);
ylim([30-0.7 33.5]);
%pbaspect([1 1.5 1]);
%%
%%Map Movie making
OptionZ.FrameRate=45;OptionZ.Duration=80;OptionZ.Periodic=true;
CaptureFigVid([2,90;60,30;90,0;90,2], 'MapMovienoTitles',OptionZ)

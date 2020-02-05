function finalct(p)
jpegFiles = dir('*.jpeg');
numfiles = length(jpegFiles);
mydata = cell(1, numfiles);
r=5;
filename = 'testfile.xlsx';
for k = 1:numfiles
I = imread(jpegFiles(k).name);
I=rgb2gray(I);
I=double(I);
I=expand(I,r);
I=contrast(I,206);
[m n]=size(I);
maxct=getmax(r);
I=cfilt(I,m,n,r,maxct);
count=HLS(I,m,n);
average=count;
cycle=1;
White_pix=0;
Black_pix=0;
ocunter = 1;
a = [0 0 0 0 0 0 0 0 0];
kkkk=1;
kkxx=200;
tttt=1;
for zz=1:9
if kkxx<1964
for j=kkkk:kkxx
for i=1:m
if I(i,j)==255
White_pix=White_pix+1;
else

Black_pix=Black_pix+1;
end
end
tttt=j;
end
end
kkkk=tttt;
kkxx=tttt+200;
if(White_pix < 3000)
a(ocunter) =0;
else
a(ocunter) = 1;
end
White_pix;
Black_pix;
White_pix=0;
Black_pix=0;
ocunter=ocunter+1;
end
%White_pix
%Black_pix
ssssu=jpegFiles(k).name
sw=cellstr(ssssu);
a
Y = sprintf('A%d', k);
xlswrite(filename,a,'sheet1',sprintf('A%d',k));
xlswrite(filename,sw,'sheet1',sprintf('J%d',k));
end
for grid=3:2:5
X=I;
X=gridfilt(I,grid,m,n,r);
count=HLS(X,m,n);
if cycle==1
average=average+count;
cycle=cycle+1;
end
if (cycle>1)&&(abs((average/cycle)-count)<=((average/cycle)/3))
average=average+count;
cycle=cycle+1;
end
end
average=average/cycle;
% total=round(average);
sprintf('The image contains %d rice',average)
function B=gridfilt(A,grid,m,n,r)
B=A;
g=(grid-1)/2;
for x=1+r:m-r
for y=1+r:n-r
gridct=0;
for u=-g:1:g
for v=-g:1:g
if (A(x+u,y+v)==255)
gridct=gridct+1;
end
end
end
if gridct<(grid^2)
B(x,y)=0;
end
end
end
function ct=HLS(A,m,n)
ct=0;
previous=0;
current=0;
for x=1:m
current=0;
for y=1:n
if (A(x,y)==255)&&(A(x,y-1)==0)
current=current+1;
end
if (A(x,y)==255)&&(A(x,y+1)==0)
current=current+1;
end
end
current=current/2;
if current<previous
ct=ct+(previous-current);
end
previous=current;
end
function B=cfilt(A,m,n,r,maxct)
B=A;
for i=1+r:m-r
for j=1+r:n-r
if A(i,j)==255
ct=getct(A,i,j,r);
if ct>=(maxct*0.8)
B(i,j)=255;
else
B(i,j)=0;
end
end
end
end
function count=getct(X,i,j,r)
count=0;
for x=-r:1:r
for y=-r:1:r
if round(sqrt((x^2)+(y^2)))<=r
if X(i+x,j+y)==255
count=count+1;
end
end
end
end
function count=getmax(r)
count=0;
for a=-r:1:r
for b=-r:1:r
if round(sqrt((a^2)+(b^2)))<=r
count=count+1;
end
end
end
function B=expand(A,r)
[m n]=size(A);
B=zeros(m+2*r,n+2*r);
for i=1:m
for j=1:n
B(i+r,j+r)=A(i,j);
end
end
function B=contrast(A,cv)
[m n]=size(A);
B=A;
for i=1:m
for j=1:n
if A(i,j)>=cv
B(i,j)=255;
else
B(i,j)=0;
end
end
end
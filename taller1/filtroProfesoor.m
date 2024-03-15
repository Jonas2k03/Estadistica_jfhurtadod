A1=clmMaxZ;
datos=clmMaxZ;
media=mean(datos);
sigma=std(datos);
li=media-3*sigma;
ls=media+3*sigma;
Oi=find(datos<li);
Os=find(datos>ls);
O=[Oi
    Os];
k=1
II=[];
IS=[];
while length(O)>=1
        di=li-datos(Oi);
        ds=datos(Os)-ls;
         d=[di
         ds];
         maxi=max(d);
        I=find(d==maxi);
        In=O(I);
        datos(In)=[];

media=mean(datos);
sigma=std(datos);
li=media-3*sigma;
ls=media+3*sigma;
II(k)=li;
IS(k)=ls;
Oi=find(datos<li);
Os=find(datos>ls);
O=[Oi
    Os];
k=k+1
%plot(II)
%hold on
%plot(IS)
end
hist(datos)
hist(A1)
figure
hold on;
boxplot(A1)
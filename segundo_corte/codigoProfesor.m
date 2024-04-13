colExplicar = 1; %ELEGIR ARBITRARIAMENTE LA COLUMNA A EXPLICAR
y = dataE(:, colExplicar);

x = zeros(filas_dataE, columnas_dataE - 1); 

for fila = 1:filas_dataE 
    col_x = 1;
    for columna = 1:columnas_dataE
        if columna == colExplicar
            continue; 
        else
            x(fila, col_x) = dataE(fila, columna); 
            col_x = col_x + 1;
        end
    end
end 

%Regresion
k=1
%X=dataE(:,3)
X=x
%y=dataE(:,5)
%y=randn(1000,1)
%plot(X,y,'o')
R2=0
k=1
while R2<0.90
lm=fitlm(X,y)
betahat=lm.Coefficients.Estimate
n=length(X);
XX=[ones(n,1) X];
yhat=XX*betahat;
r=y-yhat;
%hist(r)
ra=abs(r);
M=max(ra);
I=find(ra==M);
XX(I,:)=[];
X(I,:)=[];
y(I,:)=[];
R2=lm.Rsquared.Adjusted;

k=k+1;
end

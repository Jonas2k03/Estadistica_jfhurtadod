clc

%{
    @brief Tipificacion de datos en un bucle, elimina los outliers por
    lotes
%}

% Datos a tratar
A=clmMaxZ;

%{
    @brief Tipificacion de datos en un bucle, elimina el outlier mas lejano
    al limite mas cercano
%}

cont = 0;
while true

    %Calcular el primer cuartil
    q1 = prctile(A,25);

    %Calcular el segundo cuartil
    q3 = prctile(A,75);

    %Rango intercuartil
    iqr= q3 - q1;

    %Calcular el bigote inferior
    bigoteInf = q1 - 1.5*iqr;

    %Calcular el bigote superior
    bigoteSup = q3 + 1.5*iqr;
    

    
    %outlier inferior
    oi = find (A < bigoteInf);
    minOi= bigoteInf - A(oi);
    %outlier superior
    os = find (A > bigoteSup);
    maxOs= A(os)-bigoteSup;
    
    %Outliers
    o= [minOi
        maxOs];
    
    %Eliminar del vector de los datos los outliers encontrados
    [maxO, indexMax] = max(o); 
    if indexMax <= length(oi)
        eliminar = oi(indexMax);
        A(eliminar) = []; % Elimina el outlier inferior de A
    else
        eliminar = os(indexMax - length(oi));
        A(eliminar) = [];  % Elimina el outlier superior de A
    end

    
    
    if (isempty(o))
        disp("Iteraciones hechas: " + cont) 
        disp("Longitud de outliers: " + length(o))
        disp("Datos restantes después del filtro: " + length(A));
        disp("Datos eliminados: " + (length(clmMaxZ) - length(A)));
        break;
    end
    cont = cont + 1;
  
end
         





%Boxplot antes del filtro
figure;
boxplot(clmMaxZ);
title('Boxplot antes del filtro');

%Boxplot después del filtro
figure
boxplot(A);
title('Boxplot después del filtro');

%Histograma antes del filtro
figure;
subplot(1, 2, 1); % 1 fila, 2 columnas, primer gráfico
hist(clmMaxZ)
title('Histograma antes del filtro');
xlabel('Valor');
ylabel('Frecuencia');

%Histograma después del filtro
subplot(1, 2, 2); % 1 fila, 2 columnas, segundo gráfico
hist(A)
title('Histograma después del filtro');
xlabel('Valor');
ylabel('Frecuencia');


         




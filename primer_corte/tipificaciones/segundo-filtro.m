%{
    @brief Tipificacion de datos en un bucle, elimina el outlier mas lejano
    al limite mas cercano
%}

% Datos a tratar
A=data5(:,5);

cont = 0;
while true 
    %Media
    vMedia = mean(A);
    
    %Desviacion estandar 
    vDevEstandar = std(A);
    
    %Tipificacion
    z = (A-vMedia)/vDevEstandar;

    li=vMedia-3*vDevEstandar;
    ls=vMedia+3*vDevEstandar;
    
    %outlier inferior
    oi = find (z<-3);
    minOi= li - A(oi);
    
    %outlier superior
    os = find (z > 3);
    maxOs= A(os)-ls;
    
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

    disp("Longitud de outliers: " + length(o))

    cont = cont + 1;
    disp("Longitud de outliers: " + length(o))
    if (length(o)<=0)
        disp("Iteraciones hechas: " + cont)
        break;
    end

    disp("LONGITUD DEL VECTOR DE LOS DATOS: " + length(A) + " en la iteracion " + cont)
  
end
         


% Antes de crear el gráfico
figure;
hist(A);
title('Histograma de A');


boxplot(data5(:,5));

% Después de crear el gráfico|
figure;
boxplot(A);
title('Diagrama de caja de A');



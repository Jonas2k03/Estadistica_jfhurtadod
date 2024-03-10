%{
    @brief Tipificacion de datos en un bucle, elimina los outliers por
    lotes
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
    
    %outlier inferior
    oi = find (z<-3);
    
    %outlier superior
    os = find (z > 3);
    
    %Outliers
    o= [oi
        os];
    
    %Eliminar del vector de los datos los outliers encontrados
    A(o) = [];
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



clc;


%QUEMAR LOS DATOS A PARTIR DE LO QUE SE VE EN EL HISTOGRAMA 
% CALCULAR EL MAXIMO DATO
maximo = 120;

% CALCULAR EL MINIMO DATO
minimo = 90;

% CALCULAR EL RANGO 
rango = maximo - minimo;
cantidadDatos= 330;
nc=6;
ns=15000;

fa = [2 
      8
      5
      4
      6
      5];

far= fa / cantidadDatos;

% CALCULAR LA AMPLITUD DE LAS CLASES
amplitudClases = rango/nc;

% CREAR EL VECTOR CUYO CONTENIDO SON LOS INTERVALOS A CONSIDERAR
intervalos = minimo:amplitudClases:maximo;

%Marcas de clase

minMarcaClase = (intervalos(1) + intervalos(2))/2;
maxMarcaClase = (intervalos(length(intervalos)-1) + intervalos(length(intervalos)))/2;
mc = minMarcaClase:amplitudClases:maxMarcaClase;


%CALCULO DE LAS FRECUENCIAS ABSOLUTAS


ds = zeros(ns, nc);

%Vector de datos simulados
ds = [];

for i = 1:numel(far)
    % Calcular el número de datos a generar para el intervalo actual
    num_datos = floor(ns * far(i));
    
    limite_inferior = intervalos(i);
    limite_superior = intervalos(i+1);
    
    % Generar datos aleatorios para el intervalo actual
    datos_intervalo = limite_inferior + (limite_superior - limite_inferior) * rand(num_datos, 1);
    
    % Concatenar los datos generados al vector ds
    ds = [ds; datos_intervalo];
end




mediaSimulados = mean(ds);                                    

%Moda de datos simualados
medianaSimulados = median(ds);  

desvEstSimulados = std(ds);

%Percentiles


    %Percentil 25 en datos simulados
    p25 = prctile(ds,25);

    %Percentil 50 en datos simulados
    p50 = prctile(ds,50);


    %Percentil 75 en datos simulados
    p75 = prctile(ds,75);
    
    p20 = prctile(ds,80);


   

    dev3Derecha = mediaSimulados + 3*desvEstSimulados;
    dev3Izquierda = mediaSimulados - 3*desvEstSimulados;

  



    
    

tablaSimulados = [mediaSimulados medianaSimulados desvEstSimulados p25 p50 p75 p20];



% Definir nombres de fila
nombres_filas = {'Media', 'Mediana', 'Desv. Est.', 'P25', 'P50', 'P75', 'P80'};

% Crear la tabla con nombres de fila y columna personalizados
tabla = table(tablaSimulados', ...
              'VariableNames', {'Simulados'}, ...
              'RowNames', nombres_filas);

% Mostrar la tabla
disp(tabla);


% Histograma de datos simulados
hist(ds, nc, 'FaceColor', 'salmon', 'EdgeColor', 'black');
title('Histograma de Datos Simulados');
xlabel('Tiempo');
ylabel('Frecuencia');

%A
    if (mediaSimulados > medianaSimulados) 

            disp("Se debe sancionar al operario");

    else 
        disp("No e debe sancionar al operario");
    end

 %B
    
 if (p20 > 42) 

        disp("Se debe sancionar al operario");

    else 
        disp("Tiene un buen desempeño");
 end


 %C

 IQR = p75 - p25;

 bigoteInf = p25 - (1.5*IQR);
 bigoteSup = p75 + (1.5*IQR);

oi = find (ds < bigoteInf);
os = find (ds > bigoteSup);

o = [oi
    os];

if (length(o) > 0) 

        disp("La cantidad de llamadas no pagadas al operario es: " +  length(o));

    else 
        disp("Se le pagan todas las llamadas");
end

multa = 0;

 datosMenor3dv = find(ds<dev3Izquierda);
if (datosMenor3dv >0)  
    multa = length(datosMenor3dv);
end

datosMayor3dv = find(ds>dev3Derecha);

if (datosMenor3dv >0)  
    multa = multa + length(datosMayor3dv);
end

    disp("El opererario debe pagar USD $" + multa  + " de multa" )




%%3%%%%%%%%%%%%%%%

%a

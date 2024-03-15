clc;


%QUEMAR LOS DATOS A PARTIR DE LO QUE SE VE EN EL HISTOGRAMA 
% CALCULAR EL MAXIMO DATO
maximo = 60;

% CALCULAR EL MINIMO DATO
minimo = 0;

% CALCULAR EL RANGO 
rango = maximo - minimo;
cantidadDatos= 40;
nc=6;
ns=40;

fa = [2 
       6
       12
       10
       6
       4
      ];

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

for i = 1:nc
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
modaSimulados = mode(ds); 

if length(modaSimulados)>1
    modaSimulados = sprintf('%d', modaSimulados);
end

 

desvEstSimulados = std(ds);

%Percentiles


    %Percentil 25 en datos simulados
    prcS25 = prctile(ds,25);

    %Percentil 50 en datos simulados
    prcS74 = prctile(ds,50);


    %Percentil 75 en datos simulados
    prcS91 = prctile(ds,75);

    

tablaSimulados = [mediaSimulados modaSimulados desvEstSimulados prcS25 prcS74 prcS91];

% Definir nombres de fila
nombres_filas = {'Media', 'Moda', 'Desv. Est.', 'P25', 'P50', 'P75'};

% Crear la tabla con nombres de fila y columna personalizados
tabla = table(tablaSimulados', ...
              'VariableNames', {'Simulados'}, ...
              'RowNames', nombres_filas);

% Mostrar la tabla
disp(tabla);


% Histograma de datos simulados
hist(ds, nc, 'FaceColor', 'salmon', 'EdgeColor', 'black');
title('Histograma de Datos Simulados');
xlabel('Valor');
ylabel('Frecuencia');A

p20 = prctile(ds,20)

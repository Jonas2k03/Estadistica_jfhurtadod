clc;
dc = ds;
%CREACION DE LA TABLA DE FRECUENCIAS. 
% CALCULAR EL MAXIMO DATO
maximo = max(dc);

% CALCULAR EL MINIMO DATO
minimo = min(dc);

% CALCULAR EL RANGO 
rango = maximo - minimo;

% CALCULAR LA AMPLITUD DE LAS CLASES
amplitudClases = rango/nc;

% CREAR EL VECTOR CUYO CONTENIDO SON LOS INTERVALOS A CONSIDERAR
intervalos = minimo:amplitudClases:maximo;

%Marcas de clase

minMarcaClase = (intervalos(1) + intervalos(2))/2;
maxMarcaClase = (intervalos(length(intervalos)-1) + intervalos(length(intervalos)))/2;
mc = minMarcaClase:amplitudClases:maxMarcaClase;


%CALCULO DE LAS FRECUENCIAS ABSOLUTAS

% Inicializar el vector de frecuencias absolutas con ceros
fa = histcounts(dc,intervalos);



% Calcular las frecuencias absolutas acumuladas
fac = cumsum(fa); 

%Calcular las frecuencias relativas.
far = fa/length(dc);

%Calcular las frecuencias relativas acumuladas.
fara = cumsum(far);

%INTERVALOS QUE SE MUESTRAN EN LA TABLA

intervalos_tabla = [];

for intervaloT = intervalos
    for indice = 1:numel(intervalos)-1
        intervaloInf = "[" + num2str(intervalos(indice));
    
        if indice == numel(intervalos)-1
            intervaloSup = num2str(intervalos(indice+1)) + "]";
        else
            intervaloSup = num2str(intervalos(indice+1)) + ")";
        end
    
        intervalo = strcat(intervaloInf, " - ", intervaloSup);
        intervalos_tabla{indice} = intervalo;
    end 


end

% Crear la tabla
datos_tabla = table(intervalos_tabla', mc', fa', fac',far',fara', 'VariableNames', {'Intervalos', 'Marcas de clase', 'Frecuencias absolutas', 'Frecuencias absolutas acumuladas','Frecuencias Relativas', 'Frecuencias Relativas Acumuladas'});
disp(datos_tabla);

ds = zeros(ns, nc);

%Vector de datos simulados
ds = [];

for i = 1:length(far)
    % Calcular el número de datos a generar para el intervalo actual
    num_datos = floor(ns * far(i));
    
    limite_inferior = intervalos(i);
    limite_superior = intervalos(i+1);
    
    % Generar datos aleatorios para el intervalo actual
    datos_intervalo = limite_inferior + (limite_superior - limite_inferior) * rand(num_datos, 1);
    
    % Concatenar los datos generados al vector ds
    ds = [ds; datos_intervalo];
end



%Media de datos crudos
mediaCrudos = mean(dc);

%Media de datos tabulados
mediaTabulados = sum(mc.*fa)/length(dc);

%Media de datos simulados
mediaSimulados = mean(ds);

%Moda de datos crudos
modaCrudos = mode(dc);

%Moda de los datos tabulados
modaTabuladosNum=mc(find(fa==max(fa))); %Encontrar el indice donde se encuentra la frecuencia más alta.
                                     %La moda será el valor del vector de
                                     %las marcas de clase en ese indice.

if (length(modaTabuladosNum) > 1)
    modaTabulados = '';
    for i = 1:numel(modaTabuladosNum)
        if(i == 1)
            modaTabuladosAnterior = num2str(modaTabuladosNum(i));
            modaTabuladosSiguiente = num2str(modaTabuladosNum(i+1));
            modaTabulados = strcat(modaTabuladosAnterior, " & ", modaTabuladosSiguiente);

        elseif(i == numel(modaTabuladosNum))
        break;

        else 
            modaTabuladosSiguiente = num2str(modaTabuladosNum(i+1));
            modaTabulados = strcat(modaTabulados, " & ", modaTabuladosSiguiente);
        end
        
    end
    
else 
    modaTabulados = modaTabuladosNum;
end
                                    

%Moda de datos simualados
modaSimulados = mode(ds); 

if length(modaSimulados)>1
    modaSimulados = sprintf('%d', modaSimulados);
end

 

%Desviación estándar de los datos crudos                                    
desvEstCrudos = std(dc);

%Desviación estandar de los datos tabulados
desvEstTabulados = sqrt(sum(fa.*((mc-mediaTabulados).^(2)))/length(dc)-1);

desvEstSimulados = std(ds);

%Percentiles

    %Percentil 25 en datos crudos
    prcC25 = prctile(dc,25);

    %Percentil 25 en datos tabulados
    prcT25 = fn_percentil_dTabulados(25,length(dc),fac,intervalos,fa,amplitudClases);

    %Percentil 25 en datos simulados
    prcS25 = prctile(ds,25);

    %Percentil 74.4 en datos crudos
    prcC74 = prctile(dc,74.4);

    %Percentil 74.4 en datos tabulados
    prcT74 = fn_percentil_dTabulados(74.4,length(dc),fac,intervalos,fa,amplitudClases);

    %Percentil 74.4 en datos simulados
    prcS74 = prctile(ds,74.4);


    
    %Percentil 91 en datos crudos
    prcC91 = prctile(dc,91);

    %Percentil 91 en datos tabulados
    prcT91 = fn_percentil_dTabulados(91,length(dc),fac,intervalos,fa,amplitudClases);

    %Percentil 91 en datos simulados
    prcS91 = prctile(ds,91);

    
tablaCrudos = [mediaCrudos modaCrudos desvEstCrudos prcC25 prcC74 prcC91];
tablaTabulados = [mediaTabulados modaTabulados desvEstTabulados prcT25 prcT74 prcT91];
tablaSimulados = [mediaSimulados modaSimulados desvEstSimulados prcS25 prcS74 prcS91];

% Definir nombres de fila
nombres_filas = {'Media', 'Moda', 'Desv. Est.', 'P25', 'P74.4', 'P91'};

% Crear la tabla con nombres de fila y columna personalizados
tabla = table(tablaCrudos', tablaTabulados', tablaSimulados', ...
              'VariableNames', {'Crudos', 'Tabulados', 'Simulados'}, ...
              'RowNames', nombres_filas);

% Mostrar la tabla
disp(tabla);

% Histograma de datos crudos
subplot(1, 2, 1); % 1 fila, 2 columnas, primer gráfico
hist(dc, nc, 'FaceColor', 'skyblue', 'EdgeColor', 'black');
title('Histograma de Datos Crudos');
xlabel('Valor');
ylabel('Frecuencia');

% Histograma de datos simulados
subplot(1, 2, 2); % 1 fila, 2 columnas, segundo gráfico
hist(ds, nc, 'FaceColor', 'salmon', 'EdgeColor', 'black');
title('Histograma de Datos Simulados');
xlabel('Valor');
ylabel('Frecuencia');

dev3Derecha = modaSimulados + 3*desvEstSimulados;
dev3Izquierda = modaSimulados - 3*desvEstSimulados;

multa = 0;


datosMayor3dv = length(find(dc>dev3Derecha));

if (datosMayor3dv > 0)  
    multa = 500000 * datosMayor3dv;
end

    disp("El opererario debe pagar USD $" + multa  + " de multa" )


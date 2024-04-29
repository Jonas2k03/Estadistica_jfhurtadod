%clc;

% Calcular el máximo dato
maxima_y = max(data_y);

% Calcular el mínimo dato
minimo_y = min(data_y);

% Calcular el rango
rango_y = maxima_y - minimo_y;

% Calcular la amplitud de las clases
amplitudClasesY = rango_y / numClases_y;

% Crear el vector cuyo contenido son los intervalos a considerar
intervalosY = minimo_y:amplitudClasesY:maxima_y;

% Calculos para el vector de estaturas

% Calcular el máximo dato
maxima_x = max(data_x);

% Calcular el mínimo dato
minimo_x = min(data_x);

% Calcular el rango
rango_x = maxima_x - minimo_x;

% Calcular la amplitud de las clases
amplitudClasesX = rango_x / numClases_x;

% Crear el vector cuyo contenido son los intervalos a considerar
intervalosX = minimo_x:amplitudClasesX:maxima_x;

matriz = [data_x, data_y];
[m, n] = size(matriz);

matrizD = zeros(numClases_x, numClases_y + 1);
[mD, nD] = size(matrizD);

matrizDR = zeros(numClases_x, numClases_y + 1);

datos_no_cumplen_condiciones = [];

for fila = 1:m
    for columna = 1:n
        if (columna == 1)
            iX = matriz(fila, columna);
        else
            iY = matriz(fila, columna);
        end
    end

    dato_cumple_condiciones = false;
    for filaD = 1:length(intervalosX) - 1
        for columnaD = 1:length(intervalosY) - 1
            if (filaD == numel(intervalosX) - 1 && columnaD == numel(intervalosY) - 1)
                if (iX >= intervalosX(filaD) && iX <= intervalosX(filaD + 1)) && (iY >= intervalosY(columnaD) && iY <= intervalosY(columnaD + 1))
                    matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                    matrizD(filaD, nD) = matrizD(filaD, nD) + 1;
                    dato_cumple_condiciones = true;
                    break;
                end
            else
                %EL PROBLEMA SE ENCUENTRA EN QUE SI SE ESTA EN EL ULTIMO
                %INTERVALO DE LAS X PERO NO EN EL DE LAS Y, NO LO CUENTA.
                if (iX >= intervalosX(filaD) && iX < intervalosX(filaD + 1)) && (iY >= intervalosY(columnaD) && iY < intervalosY(columnaD + 1))
                    matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                    matrizD(filaD, nD) = matrizD(filaD, nD) + 1;
                    dato_cumple_condiciones = true;
                    break;
                end
                if (iX >= intervalosX(filaD) && iX <= intervalosX(filaD + 1)) && (iY >= intervalosY(columnaD) && iY < intervalosY(columnaD + 1))
                    matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                    matrizD(filaD, nD) = matrizD(filaD, nD) + 1;
                    dato_cumple_condiciones = true;
                    break;
                end

                if (iX >= intervalosX(filaD) && iX < intervalosX(filaD + 1)) && (iY >= intervalosY(columnaD) && iY <= intervalosY(columnaD + 1))
                    matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                    matrizD(filaD, nD) = matrizD(filaD, nD) + 1;
                    dato_cumple_condiciones = true;
                    break;
                end
            end
        end
        if dato_cumple_condiciones
            break;
        end
    end

    if ~dato_cumple_condiciones
        datos_no_cumplen_condiciones = [datos_no_cumplen_condiciones; matriz(fila, :)];
    end
end

for i = 1:mD
    for j = matrizD(i, nD)
        if (i ~= 1)
            matrizD(i, nD) = matrizD(i - 1, nD) + j;
        end
    end
end

for i = 1:mD
    for j = 1:nD
        matrizDR(i, j) = matrizD(i, j) / length(data);
    end
end

intervalosX_tabla = [];

for intervaloT = intervalosX
    for indice = 1:numel(intervalosX) - 1
        intervaloInf = "[" + num2str(intervalosX(indice));

        if indice == numel(intervalosX) - 1
            intervaloSup = num2str(intervalosX(indice + 1)) + "]";
        else
            intervaloSup = num2str(intervalosX(indice + 1)) + ")";
        end

        intervalo = strcat(intervaloInf, " - ", intervaloSup);
        intervalosX_tabla{indice} = intervalo;
    end

end

intervalosY_tabla = [];

for intervaloT = intervalosY
    for indice = 1:numel(intervalosY) - 1
        intervaloInf = "[" + num2str(intervalosY(indice));

        if indice == numel(intervalosY) - 1
            intervaloSup = num2str(intervalosY(indice + 1)) + "]";
        else
            intervaloSup = num2str(intervalosY(indice + 1)) + ")";
        end

        intervalo = strcat(intervaloInf, " - ", intervaloSup);
        intervalosY_tabla{indice} = intervalo;
    end

end
intervalosY_tabla{nD} = "Acumulado";

% Convertir las celdas a un arreglo de cadenas
intervalosX_tabla = string(intervalosX_tabla);
intervalosY_tabla = string(intervalosY_tabla);

% Crear la tabla con los datos de matrizD
tablaAbsoluta = array2table(matrizD);

% Establecer los nombres de las filas y columnas
tablaAbsoluta.Properties.RowNames = intervalosX_tabla;
tablaAbsoluta.Properties.VariableNames = intervalosY_tabla;

% Mostrar la tablaAbsoluta
disp("---------------------------------------------------------------------")
disp("                TABLA DE FRECUENCIAS ABSOLUTAS                             ")
disp("---------------------------------------------------------------------")
disp(tablaAbsoluta);

tablaRelativa = array2table(matrizDR);

% Establecer los nombres de las filas y columnas
tablaRelativa.Properties.RowNames = intervalosX_tabla;
tablaRelativa.Properties.VariableNames = intervalosY_tabla;


% Mostrar la tablaAbsoluta
disp("---------------------------------------------------------------------")
disp("                TABLA DE FRECUENCIAS RELATIVAS                             ")
disp("---------------------------------------------------------------------")
disp(tablaRelativa);



disp("Número de datos que no cumplieron con las condiciones: " + size(datos_no_cumplen_condiciones, 1));
disp("Datos que no cumplieron con las condiciones:");
disp(datos_no_cumplen_condiciones);



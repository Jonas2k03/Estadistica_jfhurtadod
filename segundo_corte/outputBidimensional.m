clc;
% Calculos para el vector de edades
    
    %Calcular el máximo dato
    maxima_y = max(data_y);
    
    % CALCULAR EL MINIMO DATO
    minimo_y = min(data_y);
    
    % CALCULAR EL RANGO 
    rango_y = maxima_y - minimo_y;
    
    % CALCULAR LA AMPLITUD DE LAS CLASES
    amplitudClasesY = rango_y/numClases_y;
    
    % CREAR EL VECTOR CUYO CONTENIDO SON LOS INTERVALOS A CONSIDERAR
    intervalosY = minimo_y:amplitudClasesY:maxima_y;



% Calculos para el vector de estaturas
    
    %Calcular el máximo dato
    maxima_x = max(data_x);
    
    % CALCULAR EL MINIMO DATO
    minimo_x = min(data_x);
    
    % CALCULAR EL RANGO 
    rango_x = maxima_x - minimo_x;
    
    % CALCULAR LA AMPLITUD DE LAS CLASES
    amplitudClasesX = rango_x/numClases_x;
    
    % CREAR EL VECTOR CUYO CONTENIDO SON LOS INTERVALOS A CONSIDERAR
    intervalosX = minimo_x:amplitudClasesX:maxima_x;


matriz = [data_x, data_y];
[m,n] = size(matriz);

matrizD = zeros(numClases_x, numClases_y);
[mD,nD] = size(matrizD);




   for fila = 1:m

        for columna = 1:n
            if(columna == 1) 
                iX = matriz (fila, columna);

            else 

                iY = matriz (fila, columna);
            end


        end
    
        for filaD= 1:length(intervalosX) -1 
        
            for columnaD = 1:length(intervalosY) -1  
            
                if (filaD == numel(intervalosX)-1 && columnaD == numel(intervalosY)-1)
                    
                    if (iX >= intervalosX(filaD) && iX <= intervalosX(filaD + 1)) && (iY>=intervalosY(columnaD) && iY <= intervalosY(columnaD + 1))
 
                        matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                        break;
                    end

                else

                    if(iX >= intervalosX(filaD) && iX < intervalosX(filaD + 1)) && (iY>=intervalosY(columnaD) && iY < intervalosY(columnaD + 1))
                        matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                        break;
                    end
                end

            end


        end

   end

   intervalosX_tabla = [];

for intervaloT = intervalosX
    for indice = 1:numel(intervalosX)-1
        intervaloInf = "[" + num2str(intervalosX(indice));
    
        if indice == numel(intervalosX)-1
            intervaloSup = num2str(intervalosX(indice+1)) + "]";
        else
            intervaloSup = num2str(intervalosX(indice+1)) + ")";
        end
    
        intervalo = strcat(intervaloInf, " - ", intervaloSup);
        intervalosX_tabla{indice} = intervalo;
    end 


end

intervalosY_tabla = [];

for intervaloT = intervalosY
    for indice = 1:numel(intervalosY)-1
        intervaloInf = "[" + num2str(intervalosY(indice));
    
        if indice == numel(intervalosY)-1
            intervaloSup = num2str(intervalosY(indice+1)) + "]";
        else
            intervaloSup = num2str(intervalosY(indice+1)) + ")";
        end
    
        intervalo = strcat(intervaloInf, " - ", intervaloSup);
        intervalosY_tabla{indice} = intervalo;
    end 


end

% Convertir las celdas a un arreglo de cadenas
intervalosX_tabla = string(intervalosX_tabla);
intervalosY_tabla = string(intervalosY_tabla);

   % Crear la tabla con los datos de matrizD
tabla = array2table(matrizD);

% Establecer los nombres de las filas y columnas
tabla.Properties.RowNames = intervalosX_tabla;
tabla.Properties.VariableNames = intervalosY_tabla;

% Mostrar la tabla
disp(tabla);







    

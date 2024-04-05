clc;
% Calculos para el vector de edades
    
    %Calcular el máximo dato
    maxima_edad = max(v_edades);
    
    % CALCULAR EL MINIMO DATO
    minimo_edad = min(v_edades);
    
    % CALCULAR EL RANGO 
    rango_edad = maxima_edad - minimo_edad;
    
    % CALCULAR LA AMPLITUD DE LAS CLASES
    amplitudClasesEdades = rango_edad/numClases_edad;
    
    % CREAR EL VECTOR CUYO CONTENIDO SON LOS INTERVALOS A CONSIDERAR
    intervalosEdades = ceil(minimo_edad:amplitudClasesEdades:maxima_edad);



% Calculos para el vector de estaturas
    
    %Calcular el máximo dato
    maxima_estatura = max(v_estaturas);
    
    % CALCULAR EL MINIMO DATO
    minimo_estatura = min(v_estaturas);
    
    % CALCULAR EL RANGO 
    rango_estatura = maxima_estatura - minimo_estatura;
    
    % CALCULAR LA AMPLITUD DE LAS CLASES
    amplitudClasesEstaturas = rango_estatura/numClases_estatura;
    
    % CREAR EL VECTOR CUYO CONTENIDO SON LOS INTERVALOS A CONSIDERAR
    intervalosEstaturas = minimo_estatura:amplitudClasesEstaturas:maxima_estatura;


matriz = [v_estaturas',v_edades'];
[m,n] = size(matriz);

matrizD = zeros(numClases_estatura, numClases_edad);
[mD,nD] = size(matrizD);




   for fila = 1:m

        for columna = 1:n
            if(columna == 1) 
                iEstatura = matriz (fila, columna);

            else 

                iEdad = matriz (fila, columna);
            end


        end
    
        for filaD= 1:length(intervalosEstaturas) -1 
        
            for columnaD = 1:length(intervalosEdades) -1  
            
                if (filaD == numel(intervalosEstaturas)-1 && columnaD == numel(intervalosEdades)-1)
                    
                    if (iEstatura >= intervalosEstaturas(filaD) && iEstatura <= intervalosEstaturas(filaD + 1)) && (iEdad>=intervalosEdades(columnaD) && iEdad <= intervalosEdades(columnaD + 1))
 
                        matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                        break;
                    end

                else

                    if(iEstatura >= intervalosEstaturas(filaD) && iEstatura < intervalosEstaturas(filaD + 1)) && (iEdad>=intervalosEdades(columnaD) && iEdad < intervalosEdades(columnaD + 1))
                        matrizD(filaD, columnaD) = matrizD(filaD, columnaD) + 1;
                        break;
                    end
                end

            end


        end

   end

   intervalosEstatura_tabla = [];

for intervaloT = intervalosEstaturas
    for indice = 1:numel(intervalosEstaturas)-1
        intervaloInf = "[" + num2str(intervalosEstaturas(indice));
    
        if indice == numel(intervalosEstaturas)-1
            intervaloSup = num2str(intervalosEstaturas(indice+1)) + "]";
        else
            intervaloSup = num2str(intervalosEstaturas(indice+1)) + ")";
        end
    
        intervalo = strcat(intervaloInf, " - ", intervaloSup);
        intervalosEstatura_tabla{indice} = intervalo;
    end 


end

intervalosEdad_tabla = [];

for intervaloT = intervalosEdades
    for indice = 1:numel(intervalosEdades)-1
        intervaloInf = "[" + num2str(intervalosEdades(indice));
    
        if indice == numel(intervalosEdades)-1
            intervaloSup = num2str(intervalosEdades(indice+1)) + "]";
        else
            intervaloSup = num2str(intervalosEdades(indice+1)) + ")";
        end
    
        intervalo = strcat(intervaloInf, " - ", intervaloSup);
        intervalosEdad_tabla{indice} = intervalo;
    end 


end

% Convertir las celdas a un arreglo de cadenas
intervalosEstatura_tabla = string(intervalosEstatura_tabla);
intervalosEdad_tabla = string(intervalosEdad_tabla);

   % Crear la tabla con los datos de matrizD
tabla = array2table(matrizD);

% Establecer los nombres de las filas y columnas
tabla.Properties.RowNames = intervalosEstatura_tabla;
tabla.Properties.VariableNames = intervalosEdad_tabla;

% Mostrar la tabla
disp(tabla);







    

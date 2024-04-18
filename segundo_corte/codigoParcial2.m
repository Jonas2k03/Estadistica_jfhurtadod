
% CODIGO PARA EL SEGUNDO PARCIAL DE ESTADISTICA % 

% Matriz de covarianza
mc = cov(dataE);
[~, columnasMC] = size(mc);

% Inversa de la matriz de covarianza
mc_inv = mc / eye(columnasMC);

% Diagonal de la matriz de covarianza
diag_mc = diag(mc);

% Diagonal de la matriz de covarianza inversa
diag_mc_inv = diag(mc_inv);

% Indicador R
r2 = 1 - (1 ./ (diag_mc .* diag_mc_inv));

% Seleccionar la columna que mejor explica los datos
% colExplicar = find(r2 == max(r2)); %CAPTURAR LA MÁS EXPLICADA

colExplicar = 1; %ELEGIR ARBITRARIAMENTE LA COLUMNA A EXPLICAR
y = dataE(:, colExplicar);

%LOGICA MATRIZ PARA LA FUNCION fitlm

% Matriz de X: 
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

%x=randn(length(y),10);
clc;
%Buscar el modelo 

modelo_lineal = fitlm(x, y);
    disp("---------------------------------------------------------------------")
    disp("                          MODELO INICIAL                             ")
    disp("---------------------------------------------------------------------")
disp(modelo_lineal)

anovaTabla = anova(modelo_lineal, 'summary');
pValorModelo = anovaTabla{'Model','pValue'};
variables = [1:size(x, 2)]; % Índices de las variables explicativas
%Vector de betas
    
    
if pValorModelo <= 0.05
    iteracion = 1;
    
    while true
    disp("---------------------------------------------------------------------")
    disp("                      MODELO EN LA ITERACION:" + (iteracion))
    disp("---------------------------------------------------------------------")
        v_pvalor = modelo_lineal.Coefficients.pValue;
        v_tStat = modelo_lineal.Coefficients.tStat;
        
        if all(v_pvalor(2:end) < 0.05) || all(abs(v_tStat(2:end)) > 2)
            fprintf('Todos los coeficientes son significativos.\n');
            break; % Si todos son significativos, termina el ciclo
        else
            max_pvalor = max(v_pvalor(2:end));
            [~, idx] = max(v_pvalor(2:end)); % Ignora el intercepto buscando desde el segundo elemento
            idx = idx + 1; % Ajustar el índice porque se ignoró el primer elemento (intercepto)
            
            if max_pvalor > 0.05 && abs(v_tStat(idx)) < 2
                % Mostrar la variable a eliminar
                fprintf('<strong> <color = "red">Eliminando variable menos significativa: Variable %d con p-valor %.4f y tStat %.4f\n </strong>', variables(idx-1), v_pvalor(idx), v_tStat(idx));
                
                % Eliminar la columna correspondiente del predictor menos significativo
                x(:, idx-1) = []; % Ajustar el índice al usar 1 basado en MATLAB
                variables(idx-1) = []; % Registrar qué variable fue eliminada

                % Recalcular el modelo después de eliminar la variable
                modelo_lineal = fitlm(x, y);
                disp(modelo_lineal);
                betahat = modelo_lineal.Coefficients.Estimate;
            end
        end
        iteracion = iteracion + 1;
    end

    if(v_pvalor(1) > 0.05)
        betahat(1) = 0; %%%%%%%%%%%%%%%%%%%%%%%PREGUNTAR COMO REFLEJAR EL VALOR NULO DE BETAHAT EN EL MODELO
    end
        % Mostrar el modelo final y las variables que permanecen
    disp('<strong>Modelo final: </strong>');
    disp(modelo_lineal);
    disp('<strong>Variables que permanecen: </strong>');
    disp(variables);

    %2. ¿Hay modelo? Lo hay si el fstatisic-p valor < 0.05

    %3. Significancia de las variables

    %Vector de betas
    %betahat = modelo_lineal.Coefficients.Estimate;
    XX=[ones(length(x),1) x];

    %Columna explicada (y)estimada 
    y_estimados = XX * betahat;

    %residuales
    r = y-y_estimados;
    figure;
    hist(r);
    title("Histograma de residualessin mejorar con un " + (modelo_lineal.Rsquared.Adjusted * 100) + "%")


    %PERFECCIONAMIENTO EN UN ALPHA PORCIENTO
    
    modelo_lineal = perfeccionar_modelo(x,y,0.90);
    disp("Modelo Lineal perfeccionado a " + modelo_lineal.Rsquared.Adjusted);
    disp(modelo_lineal);

else
    disp("<strong>NO hay modelo lineal</strong>");
end







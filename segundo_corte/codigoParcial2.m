
% CODIGO PARA EL SEGUNDO PARCIAL DE ESTADISTICA % 

% Matriz de covarianza
mc = cov(dataE);
[filasMC, columnasMC] = size(mc);

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
clc;
%Buscar el modelo 

modelo_lineal = fitlm(x, y);

%2. ¿Hay modelo? Lo hay si el fstatisic-p valor < 0.05

%3. Significancia de las variables

    %Vector de betas
    betahat = modelo_lineal.Coefficients.Estimate;
    betahat(colExplicar) = []; %PREGUNTA 1

    %Columna explicada (y)estimada 
    y_estimados = x * betahat;

    %residuales
    r = y-y_estimados;
    figure;
    hist(r);
    title("Histograma de residualessin mejorar con un " + (modelo_lineal.Rsquared.Adjusted * 100) + "%")


%PERFECCIONAMIENTO EN UN ALPHA PORCIENTO

modelo_lineal = perfeccionar_modelo(x,y,0.90,colExplicar);

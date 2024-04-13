clc;

%Taller 1. Punto 5. 

%{ a. Considere el fichero dataE.txt que contiene las rentabilidades de 10
      %sectores empresariales medidos en 1318 periodos%}

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
colExplicar = find(r2 == max(r2)); 
y = dataE(:, colExplicar);

% Matriz de X: 
x = ones(filas_dataE, columnas_dataE - 1); 

for fila = 1:filas_dataE
    col_x = 2; 
    for columna = 1:columnas_dataE
        if columna == colExplicar
            continue; 
        else
            x(fila, col_x) = dataE(fila, columna); 
            col_x = col_x + 1;
        end
    end
end

%Vector de betas
betas = (inv(x'*x)*x'*y);

%y recuperada
y_hat = x*betas;

%residual
residual = y_hat - y;
hist(residual);


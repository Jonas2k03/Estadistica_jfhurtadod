function [modeloFinal] = identificar_significativas(modeloLineal)

nivelSignificancia = 0.05; % Nivel de significancia para considerar coeficientes significativos

variables = [1:size(X, 2)]; % Índices de las variables explicativas

% Inicializar un contador de iteraciones para seguimiento
iteracion = 1;

while true
    modelo = fitlm(X, Y); % Ajustar modelo
    coeficientes = modelo.Coefficients; % Obtener coeficientes y estadísticas
    pValores = coeficientes.pValue; % Extraer valores-p
    tStats = coeficientes.tStat; % Extraer estadísticas t

    % Mostrar los resultados actuales
    fprintf('Iteración %d:\n', iteracion);
    disp(modelo);
    disp(coeficientes);
    fprintf('\n');

    % Verificar si todos los valores p son menores que el nivel de significancia
    if all(pValores(2:end) < nivelSignificancia) || all(abs(tStats(2:end)) >2)
        fprintf('Todos los coeficientes son significativos.\n');
        break; % Si todos son significativos, termina el ciclo
    else
        % Identificar el índice del coeficiente menos significativo (excluyendo el intercepto si se desea mantener siempre)
        [~, idx] = max(pValores(2:end)); % Ignora el intercepto buscando desde el segundo elemento
        idx = idx + 1; % Ajustar el índice porque se ignoró el primer elemento (intercepto)

        % Mostrar la variable a eliminar
        fprintf('Eliminando variable menos significativa: Variable %d con p-valor %.4f\n', variables(idx-1), pValores(idx));
        
        % Eliminar la columna correspondiente del predictor menos significativo
        X(:, idx-1) = []; % Ajustar el índice al usar 1 basado en MATLAB
        variables(idx-1) = []; % Registrar qué variable fue eliminada
    end

    % Incrementar el contador de iteraciones
    iteracion = iteracion + 1;
end

% Mostrar el modelo final y las variables que permanecen
disp('Modelo final:');
disp(modelo);
disp('Variables que permanecen:');
disp(variables);

end
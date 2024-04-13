function [modelo_perfeccionado] = perfeccionar_modelo(x_explicativas, y_explicada, porcentaje_deseado, columna_explicada)

    k2=1;
    
    while (true) 
        modelo_perfeccionado = fitlm(x_explicativas, y_explicada);

        betahat = modelo_perfeccionado.Coefficients.Estimate;
        betahat(columna_explicada) = []; %PREGUNTA 1

        
        y_estimados = x_explicativas * betahat;
        r = y_explicada-y_estimados;
        maximo_residual = max(abs(r));
        iMaximo_residual = find(abs(r) == maximo_residual);

        x_explicativas(iMaximo_residual,:)=[];
        y_explicada(iMaximo_residual,:)=[];
        r2 = modelo_perfeccionado.Rsquared.Adjusted;
      
        k2 = k2 + 1;
        if (r2>= porcentaje_deseado)
            disp("Iteraciones: " + k2)
            figure;
            hist(r);
            title("Histograma de residuales del modelo mejorado al " + (r2 * 100) + "%")
            break;
        end
    
    end

end
function [modelo_perfeccionado, y_estimados_perfeccionado, r_perfeccionado,y_explicada] = perfeccionar_modelo(x_explicativas, y_explicada, porcentaje_deseado)

    cantidad_datos_original = length(x_explicativas);
    modelo_perfeccionado = fitlm(x_explicativas, y_explicada);
    while (true) 
        
        betahat = modelo_perfeccionado.Coefficients.Estimate;
        XX=[ones(length(x_explicativas),1) x_explicativas];

        
        y_estimados_perfeccionado = XX * betahat;
        r_perfeccionado =  y_explicada - y_estimados_perfeccionado;
        maximo_residual = max(abs(r_perfeccionado));
        iMaximo_residual = find(abs(r_perfeccionado) == maximo_residual);

        x_explicativas(iMaximo_residual,:)=[];
        y_explicada(iMaximo_residual,:)=[];
        y_estimados_perfeccionado(iMaximo_residual,:)=[];
        XX(iMaximo_residual,:)=[];
        modelo_perfeccionado = fitlm(x_explicativas, y_explicada);
        r2 = modelo_perfeccionado.Rsquared.Adjusted;
      
        if (r2 >= porcentaje_deseado)
            cantidad_datos_perfeccionado = length(x_explicativas);

            disp("<strong>Se han eliminado " + (cantidad_datos_original - cantidad_datos_perfeccionado) + " datos.</strong>")
            figure;
            hist(r_perfeccionado);
            title("Histograma de residuales del modelo mejorado al " + (r2 * 100) + "%")
            break;
        end
    
    end

end

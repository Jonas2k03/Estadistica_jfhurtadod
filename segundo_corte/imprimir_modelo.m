function [str_ecModelo] = imprimir_modelo(modelo_lineal,variables)
str_ecModelo = [];

for i = 1:length(modelo_lineal.Coefficients.Estimate)
    if i==1 
        if (modelo_lineal.Coefficients.Estimate(i+1) >= 0)
        valor = num2str(modelo_lineal.Coefficients.Estimate(i) + " + ");
        else
            valor = num2str(modelo_lineal.Coefficients.Estimate(i))  + " ";
        end
        str_ecModelo{i} = valor;
        continue
    end
    
    if (i==length(modelo_lineal.Coefficients.Estimate))
        valor = num2str(modelo_lineal.Coefficients.Estimate(i)) + "*x" + variables(i-1) + "";
        valor =  strcat(valor);
        str_ecModelo{i} = valor;
        break;
    end

    valor = num2str(modelo_lineal.Coefficients.Estimate(i)) + "*x" + variables(i-1);
        if (modelo_lineal.Coefficients.Estimate(i+1) >= 0)
            valor =  strcat(valor," + ");
        else 
            valor =  strcat(valor + " ");
        end
    
    str_ecModelo{i} = valor;
    
end

str_ecModelo = "y = " + join(string(str_ecModelo),'');
end
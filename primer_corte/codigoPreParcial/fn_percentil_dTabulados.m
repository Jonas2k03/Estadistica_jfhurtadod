function [percentil] = fn_percentil_dTabulados(percentilCalcular,longitudDatos,fac,intervalos,fa,amplitudClases)
p = (percentilCalcular*longitudDatos)/100; 
    for i = fac
        if(i>=p) 
            clase = find(fac==i);
            li=intervalos(clase);
            ni=fa(clase);
            j=p-anterior;
            break;

        else 
            anterior = i;
        end

    end

    percentil = li + amplitudClases*(j/ni);

end
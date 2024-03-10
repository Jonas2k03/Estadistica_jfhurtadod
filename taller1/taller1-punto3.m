
% Simula 15000 velocidades aleatorias en el rango definido
velocidades = 105.67 + 0.3*rand(30, 1);
hist(velocidades);


medianaT=median(velocidades);

%{
    B. Si la velocidad media es mayor a la velocidad superada por el 50 % de los carros, se debe poner una señal
       de tránsito de alerta en el tramo. Determine si finalmente se debe poner la señal o no.
%}

    %Calcular la media
    mediaT = mean(velocidades)

    %Calcular el percentil 50%
    prct50 = prctile(velocidades,50)

    %Comparamos

    disp("Media de los datos: " + mediaT + " <-----> Percentil 50%: " + prct50)


%{
    C. Se multa a los conductores cuya velocidad est ́e a mas de 2 desviaciones típicas a la derecha de la velocidad
       modal. La multa es de 500 mil pesos. Estime aproximadamente cu ́anto ser ́ıa la recaudaci ́on por multa para este
       grupo.

%}

    %Calcular la desviación estandar
    devEstandar = std(velocidades);

    limiteVelocidad = mediaT + 2*devEstandar;
    o= find(velocidades>limiteVelocidad);
    multas = length(o) * 500000;

    display("Se recaudaran: COP $" + multas + " en multas." )



%{
    C. Un inspector de tr ́ansito afirma que si hace falta poner la señal de tránsito porque al menos el 65 % de
       los vehículos sobrepasan los 100 km/h. Qué opina de la afirmación del inspector?
%}
 

    %Calcular el percentil 65%
    prct65 = prctile(velocidades,65);

    disp("Media de los datos: " + mediaT + " <-----> Percentil 65%: " + prct65 + " <-----> Mediana: " + medianaT);


%{
    D. Construya un boxplot aproximado de las velocidades calculando con detalle el valor de ambos bigotes.
       Determine con base en el boxplot si habrían velocidades extremas. Justifique
%}
 
    boxplot(velocidades);


   

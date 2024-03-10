%INPUT: Datos crudos (dc), número de clases (nc), número de datos simulados
%(ns)

dc = [38 15 10 12 62 46 25 56 27 24 23 21 20 25 38 27 48 35 50 65 59 58 47 42 37 35 32 40 28 14 12 24 66 73 72 70 68 65 54 48 34 33 21 19 61 59 47 46 30 30];

%Para cuando se requiera tomar datos aleatorios. 

%{
dc = [50*randn(100,1)
    4-20*log(rand(50,1))];
%}


dc=floor(dc); %Descomentar si los datos crudos son para edades.

%nc = round(sqrt(length(dc))); %Descomentar si se debe calcular el 
                               %numero de clases

                              
nc = 7;
ns = 2000;

%Los siguientes procedimientos aseguran que "dc" sea un vector
%Que tenga las dimensiones que soporta el programa principal (1xn)

dim = size(dc);

% Comprobamos si es un vector columna (nx1)
if dim(1) > 1 &&  dim(2) == 1 
    % Calculamos la traspuesta para convertirlo en un vector fila (1xn)
    dc = dc';
end

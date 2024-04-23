%Matriz de correlacion
data = dataE(:,1:5)

%A partir del plotmatrix, podemos mostrarlo como un numero
plotmatrix(data)

%Calculamos la covarianza para saber si hay dependencia lineal
covarianza = cov(data)
%No hay que mirar el numero, sino el signo:

%Signo positivo: Hay estructura lineal positiva, es decir pendiente
%positiva

%Signo negativo: SI son negativos, su pendiente es negativa.

%Una vez visto el signo, vamos a ver que tan fuerte es esa dependencia, 
% es decir la fuerza de dependencia (correlacion). Que tan fuerte estan
% dependiendo de manera lineal.

% Si correlacion > 0.8 o correlacion < -0.8 hay buena correlación, es decir, hay mucho
% vinculo lineal. Si es > 0.8 es con pendiente positiva, si es < -0.8 es
% con pendiente negativa.

% Si correlacion = 0, no significa que no haya dependencia, solo que no hay
% DEPENDENCIA LINEAL.

correlacion = corr(data)

%Si una variable tiene correlacion con ella misma da 1 y es perfecta, por
%eso da una diagonal de unos.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TALLER:Calcule la matriz de correlación de las variables significativas 
% e interprete la máxima y la mínima entrada de esa matriz.

%Segun la matriz de correlacion, podemos concluir que visualmente la 1,3 es
%la que tiene correlacion mas fuerte, ya que da 0.8970 oviamente sin tener
%en cuenta la dependencia con ella misma que siempre da 1. Esta es la
%maxima. Es significativa.

% Y la mas debil segun la matriz, es la (4,2). Esta es la minima. No es
% significativa.

%NOTA: La MAXIMA correlacion puede ser negativa. La minicma correlacion es
%la que mas se acerque a 0.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Estructura lineal debil: Que esten mas dispersos
%Estructura lineal fuerte: Que no esten tan dispersos sino que den forma
%lineal

%La correlacion se mide en VALOR ABSOLUTO, por lo que si nos dieran numeros
%negativos altos, seria una correlacion fuerte

%Correlacion 1: Perfecta, porque los datos hacen una linea perfecta
% Correlacion 0.9: Buen ajuste lineal pero no perfecto
% Correlacion 0.5 : Linealidad muy debil
% Correlación 0: No hay LINEALIDAD
% Correlacion -0.5 : Linealidad muy debil
% Correlacion -0.9: Buen ajuste lineal pero no perfecto
%Correlacion -1: Perfecta, porque los datos hacen una linea perfecta

%¿Puede haber correlacion 0 y un ajuste perfecto?
% R/ Si. Lo vemos a continuacion:
x= 0:0.1:2*pi %De 0 a 2pi en saltos de 0.1
y = sin(3*x)

plot(x,y,'o')

%Veremos su fuerza de dependencia lineal con la correlacion:

corr(x',y')
% Vemos que hay un ajuste perfecto pero NO es lineal, entonces por eso la
% correlacion es muy bajita.

%La correlacion solo mide dependencia LINEAL!!

% Luego:

%Si x independiente y & NO HAY ESTRUCTURA FUNCIONAL DETRÁS, 
% entonces no hay dependencia lineal ni ninguna. --> Verdadero
%Porque si no hay estructura de ningun tipo, en particular no hay lineal.

%Si correlacion = 0, hay independencia?
% R/ No, porque puede que haya otro tipo de estructura. --> Falso

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LA MEJOR EXPLICADA EN TERMINOS DE LAS OTRA
%Paso 1: Calcular la covarianza
c = cov(data)
%Paso 2: Diagonal de covarianza
d1= diag(c)
%Paso 3: Inversa matriz covarianza
cInv=inv(c) %%OPCION 2: c\eye(10) : 10 = num columnas --> Generalizada
%Paso 4: Diagonal de la matriz inversa
d2 = diag(cInv)
%Paso 5: Indicador
%Que Porcentaje esta explicada una variable en terminos de las otras.
R2 = 1-(1./(d1.*d2))

% Y va a ser igual a la variable mejor explicada:
y = data(:,3)

%Ahora quien seran las explicativas?:
x1 = data(:,1)
x2 = data(:,2)
x4 = data(:,4)
x5 = data(:,5)

x = [x1 x2 x4 x5]

%Miramos el modelo
lm = fitlm(x,y)

%El intercepto no es significativo en este caso.

%Vamos a extraer los betas:
betahat = lm.Coefficients.Estimate

%Como el intercepto no nos valio, lo vamos a quitar que es el 1:
betahat(1) = 0

%Calculamos el y estimado:

%Primero le ponemos a data la columna de unos con las variables
%sgnificativas

xaux = [ones(1318,1) x]

% "y" estimado:
yhat = xaux*betahat

%Calculamos los residuales:
r = yhat - y
%Vemos si tiene forma de campana y centrados en 0 (significa que es media 0) 
hist(r)

% Test de Normalidad:
h = jbtest(r)

% Otra forma de diagnostico:
% mean(y) = mean(yhat)

mediay =mean(y)
mediayhat = mean(yhat)
mediar = mean(r)
%Si son estadisticamente iguales

% Otra forma de diagnostico:
% Suma de cuadrados total =  suma de cuadrados del modelo + suma de
% cuadrados residuales

%La varianza TOTAL la distribuyo en la varianza del modelo + la varianza
%residual:
%SCT = SCM + SCR

SCT = sum((y - mediay).^2)
SCM = sum((yhat - mediayhat).^2)
SCR = sum((r-mediar).^2)

SCM + SCR %Debe ser igual a SCT

%AHORA que proporcion le toco al modelo?:
SCM/SCT % = 0.8965 debe coincidir con el r^2 ajustado de la tabla lm
lm.Rsquared.Adjusted
%Que proporcion le toco al residual?:
SCR/SCT
% LA PARTE QUE LE TOCO AL MODELO DEBE SER MUCHO MAS ALTA QUE LA DE LOS
% RESIDUALES.

%Este ultimo diagnostico es equivalente a:
% Varianza total = varianza modelo + varianza residual, donde la varianza
% del modelo quiero que sea alta.
% Esta solo se cumpple para MODELOS LINEALES

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%Con el m ́etodo de eliminaci ́on del mayor residual, intente mejorar el ajuste hasta obtener un R2 = 0.95.
%Exponga el modelo mejorado y grafique los residuales y com ́entelo respecto a la gr ́afica de los anteriores residuales.
%Cu ́antos datos fueron eliminados?
k=1 %Contador
R2 = 0 %Se pone R2 en 0 para entrar al bucle
while R2<0.90
lm=fitlm(x,y)
betahat=lm.Coefficients.Estimate
n=length(x);
XX=[ones(n,1) x];
yhat=XX*betahat;
r=y-yhat; %Calculo los residuales
%hist(r)
ra=abs(r);
M=max(ra); %Maximo residual
I=find(ra==M); %En que posicion esta el masximo residual
XX(I,:)=[]; %Elimina ese registro
x(I,:)=[]; %Elimina ese registro
y(I,:)=[]; %Elimina ese registro
%pause(0.5)
plot(x,y,'o')
R2=lm.Rsquared.Adjusted; 
R2V(k)=R2; %Cada vez que quito un registro, hay un R2 que va subiendo
k=k+1; %Itero
end

%Graficamos la evolucion de los R2:
plot(R2V)

hist(r)


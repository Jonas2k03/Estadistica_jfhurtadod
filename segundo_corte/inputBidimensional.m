%SCRIPT DE INPUTS
clc;
%Vector de edades: 
v_edades = [48, 25, 32, 40, 22, 35, 28, 45, 18, 50, 29, 36, 27, 33, 42, 20, 39, 31, 26, 34, 37, 23, 47, 30, 21, 44, 38, 24, 43, 19];

%Vector de estaturas (cm):
v_estaturas = [182,170, 165, 180, 160, 175, 168, 172, 155, 178, 167, 173, 162, 169, 176, 158, 171, 166, 163, 174, 179, 161, 177, 168, 157, 181, 170, 164, 175, 159];

%Numero de clases para las edades
numClases_edad = 5;

%Numero de clases para las estaturas
numClases_estatura = 5;
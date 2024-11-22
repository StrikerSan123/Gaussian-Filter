% --------DATOS ENTRADA-------------------------------
sigma = 5; % Desviacion estandar del filtro
kernelsize = 5; % Tamano del filtro (debe ser impar)

img = imread('test1.bmp'); 
img = double(img); % Convertir la imagen a tipo double para la convolucion
%---------------------------------------------------

%-----CREACION FILTRO GAUSSIANO----------------------
[x, y] = meshgrid(-floor(kernelsize/2):floor(kernelsize/2), -floor(kernelsize/2):floor(kernelsize/2));
kernel = exp(-(x.^2 + y.^2) / (2 * sigma^2));
kernel = kernel / sum(kernel(:)); % Normalizar kernel
%---------------------------------------------------


%----- PARTE DE LA CONVOLUCION PARA CADA CANAL DE COLOR---------------------
[altoimg, largoimg, RGB] = size(img); % Tamano de la imagen
[altokernel, largokernel] = size(kernel); % Tamano del kernel
imgfiltrada = zeros(altoimg, largoimg, RGB);

for color = 1:RGB
    img = img(:,:,color);
    imgFiltrada = zeros(altoimg, largoimg);

    for i = 1+floor(altokernel/2):(altoimg-floor(altokernel/2))
        for j = 1+floor(largokernel/2):(largoimg-floor(largokernel/2))
            region = img(i-floor(altokernel/2):i+floor(altokernel/2), j-floor(largokernel/2):j+floor(largokernel/2));
            imgFiltrada(i, j) = sum(sum(region .* kernel));
        end
    end
    imgfiltrada(:,:,color) = imgFiltrada; 
end

%----- MOSTRAR RESULTADOS-------------------------------- 
% Convertir la imagen filtrada a uint8 para mostrarla
imgfiltrada = uint8(imgfiltrada);
montage({uint8(img), imgfiltrada})
title('Original  Vs. Imagen Filtrada con Filtro Gaussiano')

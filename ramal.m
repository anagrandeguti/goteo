clear;clc

%Cálculo de la distribución de caudal en un ramal de riego por goteo
h0=10;n=100;k=1.25;x=0.54;CVm=0.05;le=0.5;s=0.5;D=13.6;I0=0.05;

vectorUnos=ones(1,n);
matrizAcum=tril(ones(n),0);

xR=(s.*vectorUnos)*transpose(matrizAcum);
zR=-I0.*xR;

%Variación manufactura
varManuf=1+CVm.*randn(1,n);

h=h0.*vectorUnos;
hant=0.*vectorUnos;

i=0;
tic;
while sum(abs(h-hant))>1e-6;
  hant=h;
  q=(k.*h.^x).*varManuf;
  ++i;
  h=h0.*vectorUnos-zR-(0.465.*(q*tril(ones(n),0)).^1.75.*D.^-4.75.*(le+s))*transpose(matrizAcum);
end
toc

%Resultados
i
h0
CVq=std(q)/mean(q)
CVqh=std(k.*h.^x)/mean(k.*h.^x)
CVqm=sqrt(CVq^2-CVqh^2)

plot(xR,zR,"-;z(x);");hold on;plot(xR,h,"-;h(x);");plot(xR,-q,"o;q(x);");hold off;
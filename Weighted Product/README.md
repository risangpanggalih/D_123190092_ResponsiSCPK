## Source Code .m
```
clc; %untuk membersihkan jendela command windows
clear; %untuk membersihkan jendela command windows

opts = detectImportOptions('no1.xlsx');
opts.SelectedVariableNames = (3:8);
data = readmatrix('no1.xlsx', opts);
data2 = data(1:50,1:3);
data3 = data(1:50,6);
data4 = [data2 data3];

x = data4; %data rating kecocokan dari masing-masing alternatif
k = [0,0,1,0]; %atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan 0= atribut biaya
w = [3,5,4,1]; %Nilai bobot tiap kriteria

%Perbaikan bobot
[m n] = size (x); %inisialisasi ukuran x
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%Melakukan perhitungan vektor(S) per baris (alternatif)
for j = 1:n,
    if k(j) == 0, w(j) = -1*w(j);
    end;
end;
for i = 1:m,
    S(i) = prod(x(i,:).^w);
end;

%Proses perangkingan
V = S/sum(S);
disp("Data : ");
disp(data4);

for q = 1:m;
    if V(q) == max(V)
        disp("Real estate yang menjadi alternatif terbaik untuk investasi jangka panjang adalah ke-" + q);
        disp("Dengan nilai " + max(V));
    end;
end;

VT = V.';
opts = detectImportOptions('no1.xlsx');
opts.SelectedVariableNames = (1);
x2 = readmatrix('no1.xlsx',opts);
x2 = x2(1:50,:);
x2 = [x2 VT];
x2 = sortrows(x2,-2);
x2 = x2(1:5,1);

disp ("5 Real Estate yang menjadi alternatif terbaik : ")
disp (x2)
```

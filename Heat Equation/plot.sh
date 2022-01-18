gfortran main.f95
./a.out

gnuplot -p -e "splot 'txT.dat' matrix w l title 'e'; pause mouse keypress"
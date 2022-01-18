gfortran main.f95
./a.out

gnuplot -p -e "set size square; splot 'position.dat' title 'Position'; pause mouse keypress"

gnuplot -p -e "plot 'KE.dat' with lines title 'Kinetic Energy', \
 'PE.dat' with lines title 'Potential Energy', \
 'E.dat' with lines title 'Total Energy'"
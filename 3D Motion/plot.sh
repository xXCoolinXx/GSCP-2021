gfortran main.f95
./a.out

gnuplot -p -e "splot 'position.dat' using 2:3:4 title 'Position'; pause mouse keypress"
#gnuplot -p -e "plot 'position.dat' using 1:2 w l title 'x vs t',\
#               'position.dat' using 1:3 w l title 'y vs t',\
#               'position.dat' using 1:4 w l title 'z vs t'"
#
#gnuplot -p -e "plot 'velocity.dat' using 1:2 w l title 'vx vs t',\
#               'velocity.dat' using 1:3 w l title 'vy vs t',\
#               'velocity.dat' using 1:4 w l title 'vz vs t'"
#
#gnuplot -p -e "plot 'acceleration.dat' using 1:2 w l title 'ax vs t',\
#               'acceleration.dat' using 1:3 w l title 'ay vs t',\
#               'acceleration.dat' using 1:4 w l title 'az vs t'"
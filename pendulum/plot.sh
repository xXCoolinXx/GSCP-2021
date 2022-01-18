./a.out

gnuplot -p -e "set datafile separator comma; \
plot 'position.dat' with lines title 'Position', \
 'velocity.dat' with lines title 'Velocity', \
 'acceleration.dat' with lines title 'Acceleration'"
 

gnuplot -p -e "set datafile separator comma; \
 plot 'KE.dat' with lines title 'Kinetic Energy', \
 'PE.dat' with lines title 'Potential Energy', \
 'E.dat' with lines title 'Total Energy'"
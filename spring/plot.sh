./a.out

gnuplot -p -e "set datafile separator comma; \
plot 'position.dat' with lines title 'Position', \
 'velocity.dat' with lines title 'Velocity', \
 'acceleration.dat' with lines title 'Acceleration',\
 for [col=2:4] 'SHM_Dampened.csv' using 1:col  w l title columnheader"
 

#gnuplot -p -e "set datafile separator comma; \
# plot 'KE.dat' with lines title 'Kinetic Energy', \
# 'PE.dat' with lines title 'Potential Energy', \
# 'E.dat' with lines title 'Total Energy'"
# 
#gnuplot -p -e "set datafile separator comma; \
#    plot for [col=5:7] 'SHM_1.csv' using 1:col  w l title columnheader"


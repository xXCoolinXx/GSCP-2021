./a.out

gnuplot -p -e "plot 'position.dat' with lines title 'Position', \
 'velocity.dat' with lines title 'Velocity', \
 'acceleration.dat' with lines title 'Acceleration'" # , \
# 'A5 Position.csv' title 'Position (ex)', \
# 'A5 Velocity.csv' title 'Velocity (ex)'"
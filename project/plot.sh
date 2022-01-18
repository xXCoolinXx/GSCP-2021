./a.out

gnuplot -p -e "plot 'approx.dat' w l title 'Approximate', \
 'exact.dat' with lines title 'Exact'"
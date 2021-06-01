mkdir -p build
cmake -S . -B build
cd build
make
cd ..

cd research/librtmp
make ssl
cd ../..

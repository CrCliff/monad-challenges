set1 : src/Set1.hs test/Set1Spec.hs
	ghc -i src/Set1.hs test/Set1Spec.hs
	./test/Set1Spec.exe

clean:
	rm src/*.o src/*.hi test/*.exe
	rm test/*.o test/*.hi test/*.exe


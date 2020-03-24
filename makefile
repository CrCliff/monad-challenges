set2 : src/Set2.hs test/Set2Spec.hs
	ghc -i src/Set2.hs test/Set2Spec.hs
	./test/Set2Spec.exe

set1 : src/Set1.hs test/Set1Spec.hs
	ghc -i src/Set1.hs test/Set1Spec.hs
	./test/Set1Spec.exe

clean:
	rm src/*.o src/*.hi test/*.exe
	rm test/*.o test/*.hi test/*.exe


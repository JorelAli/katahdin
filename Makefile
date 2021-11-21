CSC = mcs -debug

all : interpreter debugger
debugger : Katahdin.Debugger.exe
interpreter : Katahdin.Interpreter.exe

check : Katahdin.Tests.dll interpreter
	nunit-console2 Katahdin.Tests.dll
	./katahdini -verbose \
        tests/language/*.kat \
        tests/library/*.kat \
        tests/library/fortran/*.f \
        tests/library/python/*.py \
        demos/factorial.kat
	./katahdini -verbose \
        demos/sql/problem.kat - 1985
	./katahdini -verbose \
        demos/sql/solution.kat - 1985
	./katahdini -verbose \
        demos/fortran-python/random.f \
        demos/fortran-python/random.py \
        demos/fortran-python/fusion.kat

Katahdin.Tests.dll : Katahdin.dll \
                     tests/runtime/*.cs
	$(CSC) -target:library -out:$@ -pkg:mono-nunit -r:Katahdin.dll \
                                                    tests/runtime/*.cs

# Use this for Linux
# Katahdin.Debugger.exe : Katahdin.dll \
#                         Katahdin.Debugger/*.cs \
# 	                    Katahdin.Debugger/ObjectViewer/*.cs
# 	$(CSC) -out:$@ -pkg:gtk-sharp-2.0 -r:Katahdin.dll \
#                                       Katahdin.Debugger/*.cs \
#                                       Katahdin.Debugger/ObjectViewer/*.cs

# For Windows, make sure to Download Gtk# from here: https://www.mono-project.com/download/stable/
# See https://stackoverflow.com/a/33592570/4779071
Katahdin.Debugger.exe : Katahdin.dll \
                        Katahdin.Debugger/*.cs \
	                    Katahdin.Debugger/ObjectViewer/*.cs
	$(CSC) -out:$@ \
          -r:"C:\Program Files (x86)\GtkSharp\2.12\lib\gtk-sharp-2.0\gtk-sharp.dll" \
          -r:"C:\Program Files (x86)\GtkSharp\2.12\lib\gtk-sharp-2.0\gdk-sharp.dll" \
          -r:"C:\Program Files (x86)\GtkSharp\2.12\lib\gtk-sharp-2.0\atk-sharp.dll" \
          -r:"C:\Program Files (x86)\GtkSharp\2.12\lib\gtk-sharp-2.0\glib-sharp.dll" \
          -r:Katahdin.dll \
                                      Katahdin.Debugger/*.cs \
                                      Katahdin.Debugger/ObjectViewer/*.cs

Katahdin.Interpreter.exe : Katahdin.dll \
                           Katahdin.Interpreter/*.cs
	$(CSC) -out:$@ -r:Katahdin.dll \
                   Katahdin.Interpreter/*.cs

dll : Katahdin.dll
Katahdin.dll : Katahdin/*.cs \
               Katahdin/Collections/*.cs \
               Katahdin/Base/*.cs \
               Katahdin/Base/pattern/*.cs \
               Katahdin/Base/expressions/*.cs \
               Katahdin/Base/statements/*.cs \
               Katahdin/Base/class/*.cs \
               Katahdin/Grammars/*.cs \
               Katahdin/Grammars/Precedences/*.cs \
               Katahdin/Grammars/Alts/*.cs \
               Katahdin/CodeTree/*.cs\
               Katahdin/Compiler/*.cs
	$(CSC) -target:library -out:$@ Katahdin/*.cs \
                                   Katahdin/Collections/*.cs \
                                   Katahdin/Base/*.cs \
                                   Katahdin/Base/pattern/*.cs \
                                   Katahdin/Base/expressions/*.cs \
                                   Katahdin/Base/statements/*.cs \
                                   Katahdin/Base/class/*.cs \
                                   Katahdin/Grammars/*.cs \
                                   Katahdin/Grammars/Precedences/*.cs \
                                   Katahdin/Grammars/Alts/*.cs \
                                   Katahdin/CodeTree/*.cs \
                                   Katahdin/Compiler/*.cs

clean :
	rm -f Katahdin.Tests.dll Katahdin.Debugger.exe Katahdin.Interpreter.exe \
	    Katahdin.dll *.mdb TestResult.xml

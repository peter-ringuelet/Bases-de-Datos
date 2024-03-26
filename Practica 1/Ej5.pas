Program Ej5Optimizado;

Uses crt;

Type 
  tRegisterFlowers = Record
    spNum: Integer;
    maxHeight: Real;
    scientificName, vulgarName, color: String;
  End;
  tArchFlowers = File Of tRegisterFlowers;

Const 
  READ_END = 'zzz';

Var 
  arch: tArchFlowers;
  opt: Integer;

Procedure SolicitarDatosFlor(Var flower: tRegisterFlowers);
Begin
  With flower Do Begin
    WriteLn('Ingrese numero de especie (ingrese 0 para terminar): ');
    ReadLn(spNum);
    If spNum = 0 Then Exit;
    WriteLn('Ingrese altura maxima: ');
    ReadLn(maxHeight);
    WriteLn('Ingrese nombre cientifico: ');
    ReadLn(scientificName);
    WriteLn('Ingrese nombre vulgar: ');
    ReadLn(vulgarName);
    WriteLn('Ingrese color: ');
    ReadLn(color);
  End;
End;

Procedure cargarArchFlowers(Var arch:tArchFlowers);
Var 
  fileName: String;
  flower: tRegisterFlowers;
Begin
  Write('Ingrese nombre del archivo: ');
  ReadLn(fileName);
  Assign(arch, fileName);
  Rewrite(arch);
  SolicitarDatosFlor(flower);
  While (flower.spNum <> 0) Do Begin
    Write(arch, flower);
    SolicitarDatosFlor(flower);
  End;
  Close(arch);
End;

Procedure countAndMinMax(Var arch:tArchFlowers);
Var 
  total: Integer;
  min, max: Real;
  flower: tRegisterFlowers;
Begin
  total := 0;
  min := 9999;
  max := -1;
  Reset(arch);
  While (Not eof(arch)) Do Begin
    Read(arch, flower);
    total := total + 1;
    If (flower.maxHeight > max) Then max := flower.maxHeight;
    If (flower.maxHeight < min) Then min := flower.maxHeight;
  End;
  WriteLn('El total de flores es de: ', total);
  WriteLn('La maxima altura es de: ', max:0:2);
  WriteLn('La minima altura es de: ', min:0:2);
  Close(arch);
End;

Procedure printAll(Var arch:tArchFlowers);
Var 
  flower: tRegisterFlowers;
Begin
  Reset(arch);
  While (Not eof(arch)) Do Begin
    Read(arch, flower);
    With flower Do Begin
      WriteLn('Num. Especie: ', spNum, ', Altura Max: ', maxHeight:0:2, ', Nom. Cientifico: ', scientificName, ', Nom. Vulgar: ', vulgarName, ', Color: ', color);
    End;
  End;
  Close(arch);
End;

Procedure modifyVic(Var arch:tArchFlowers);
Var 
  flower: tRegisterFlowers;
Begin
  Reset(arch);
  While (Not eof(arch)) Do Begin
    Read(arch, flower);
    If (flower.scientificName = 'Victoria Amazonia') Then Begin
      flower.scientificName := 'Victoria Amazónica';
      Seek(arch, FilePos(arch) - 1);
      Write(arch, flower);
    End;
  End;
  Close(arch);
End;

Procedure nuevaCarga(Var arch:tArchFlowers);
Var
  flower: tRegisterFlowers;
Begin
  Reset(arch);
  Seek(arch, FileSize(arch));
  SolicitarDatosFlor(flower);
  While (flower.spNum <> 0) Do Begin
    Write(arch, flower);
    SolicitarDatosFlor(flower);
  End;
  Close(arch);
End;

Procedure listarContenido(Var arch:tArchFlowers);
Var 
  txtArch: Text;
  flower: tRegisterFlowers;
Begin
  Reset(arch);
  Assign(txtArch, 'flores.txt');
  Rewrite(txtArch);
  While (Not eof(arch)) Do Begin
    Read(arch, flower);
    With flower Do Begin
      WriteLn(txtArch, 'Especie: ', spNum, ', Altura: ', maxHeight:0:2, ', Cientifico: ', scientificName, ', Vulgar: ', vulgarName, ', Color: ', color);
    End;
  End;
  Close(arch);
  Close(txtArch);
  WriteLn('Archivo de texto flores.txt creado con éxito.');
End;

Begin
  Repeat
    clrscr; // Limpia la pantalla para una mejor visualización del menú
    WriteLn('---------------------------------------------------------------');
    WriteLn('Seleccione una opción: ');
    WriteLn('1: Reportar cantidad total de especies y la especie de menor y mayor altura.');
    WriteLn('2: Listar todo el contenido del archivo de a una especie por línea.');
    WriteLn('3: Modificar el nombre científico de la especie "Victoria Amazonia".');
    WriteLn('4: Añadir más especies al final del archivo.');
    WriteLn('5: Listar todo el contenido del archivo en un archivo de texto.');
    WriteLn('6: Salir');
    Write('Opción: ');
    ReadLn(opt);

    Case opt Of 
      1: Begin
           clrscr;
           countAndMinMax(arch);
           ReadLn;
         End;
      2: Begin
           clrscr;
           printAll(arch);
           ReadLn;
         End;
      3: Begin
           clrscr;
           modifyVic(arch);
           WriteLn('Modificación realizada con éxito.');
           ReadLn;
         End;
      4: Begin
           clrscr;
           nuevaCarga(arch);
           WriteLn('Nuevas especies añadidas con éxito.');
           ReadLn;
         End;
      5: Begin
           clrscr;
           listarContenido(arch);
           WriteLn('Contenido listado en flores.txt con éxito.');
           ReadLn;
         End;
    End;

  Until opt = 6;
  WriteLn('Saliendo...');
End.


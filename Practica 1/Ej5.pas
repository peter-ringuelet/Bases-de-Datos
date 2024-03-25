Program Ej4;

Type 
  tArchNum = File Of Integer;

Var 
  arch: tArchNum;
  archName: String;

Procedure fromBinToTextArch(Var arch: tArchNum);

Var 
  carga: Text;
  archName: String;
  value: Integer;
Begin
  Write('Ingrese el nombre del archivo de texto: ');
  ReadLn(archName);
  Assign(carga, archName);
  Rewrite(carga);
  Reset(arch);

  While (Not eof(arch)) Do
    Begin
      Read(arch, value);
      WriteLn(carga, value);
    End;

  Close(carga);
  Close(arch);


End;


Begin

  Write('Ingrese el nombre del archivo a leer: ');
  ReadLn(archName);
  //Tiene que recibir con assign el procedure?
  Assign(arch, archName);
  fromBinToTextArch(arch);

End.
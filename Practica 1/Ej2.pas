program Ej2;

uses crt, sysutils;

type
    tArch = File Of Integer;
  
var
    nombreArchivo: String;
    archivo: tArch;
    votantes, min, max: Integer;

begin
  min := 9999;
  max := -1;
  clrscr;
  
  write('Ingrese el nombre del archivo donde desea abrir:');
  readln(nombreArchivo);
  
  Assign(archivo, nombreArchivo);
  
  Reset(archivo); // Abro el archivo

  // imprimo todo
  While (Not eof(archivo)) Do
    Begin
      Read(archivo, votantes);
      WriteLn(votantes);
      if (votantes < min) then 
      Begin
        min := votantes;
      End
      else if (votantes > max) then Begin
        max := votantes;
      End
    End;

  writeln('Maximo: ', max, '    Minimo: ', min);
  Close(archivo); // Cierra el archivo
  
  writeln('Archivo terminado de procesar exitosamente.');
  readkey; // Espera que el usuario presione una tecla para cerrar el programa
end.
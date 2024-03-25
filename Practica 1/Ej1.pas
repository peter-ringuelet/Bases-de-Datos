program Ej1;

uses crt, sysutils;

type
    tArchMat = File Of String;
  
var
    material, nombreArchivo: String;
    archivo: tArchMat;

begin
  clrscr;
  
  writeln('Ingrese el nombre del archivo donde desea guardar los materiales:');
  readln(nombreArchivo);
  
  Assign(archivo, nombreArchivo);
  
  Rewrite(archivo); // Crea el archivo
  
  repeat
    writeln('Ingrese el nombre de un material de construcción (escriba "cemento" para finalizar):');
    readln(material);
    
    Write(archivo, material); // Escribe el material en el archivo
  until material = 'cemento'; // Repite hasta que el usuario escribe "cemento"

  //Para verificar, imprimo todo
  Reset(archivo);
  While (Not eof(archivo)) Do
    Begin
      Read(archivo, material);
      WriteLn(material);
    End;

  
  Close(archivo); // Cierra el archivo
  
  writeln('Archivo guardado exitosamente.');
  readkey; // Espera que el usuario presione una tecla para cerrar el programa
end.
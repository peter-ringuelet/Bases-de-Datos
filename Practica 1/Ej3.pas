program Ej3;

uses crt, sysutils;

type
    tArch = File Of String;
  
var
    nombreArchivo: String;
    archivo: tArch;
    dinosaurio: String;

begin
  clrscr;
  
  write('Ingrese el nombre del archivo que desea crear:');
  readln(nombreArchivo);
  
  Assign(archivo, nombreArchivo);
  Rewrite(archivo); // Creo el archivo
  
  repeat
    write('nombre del dino: ');
    readln(dinosaurio);
    if (dinosaurio <> 'zzz') then write(archivo,dinosaurio);
  until dinosaurio = 'zzz';
  
  Reset(archivo); // Abro el archivo

  // imprimo todo
  While (Not eof(archivo)) Do
    Begin
      Read(archivo, dinosaurio);
      WriteLn(dinosaurio);
    End;

  Close(archivo); // Cierra el archivo
  
  writeln('Archivo terminado de procesar exitosamente.');
  readkey; // Espera que el usuario presione una tecla para cerrar el programa
end.
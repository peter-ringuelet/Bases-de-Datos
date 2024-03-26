program Ej6;

uses
  crt, SysUtils;

type
  TLibro = record
    ISBN: string[13];
    Titulo: string[50];
    AnioEdicion: Integer;
    Editorial: string[30];
    Genero: string[20];
  end;
  TArchivoLibros = file of TLibro;

var
  archivoTexto: Text;
  archivoBinario: TArchivoLibros;
  libro: TLibro;
  nombreArchivoBinario: string = 'libros.dat';

procedure CrearArchivoBinarioDesdeTexto;
var
  linea: string;
begin
  Assign(archivoTexto, 'libros.txt');
  Reset(archivoTexto);
  Assign(archivoBinario, nombreArchivoBinario);
  Rewrite(archivoBinario);
  
  while not Eof(archivoTexto) do
  begin
    with libro do
    begin
      ReadLn(archivoTexto, ISBN, Titulo);
      ReadLn(archivoTexto, AnioEdicion, Editorial);
      ReadLn(archivoTexto, Genero);
    end;
    Write(archivoBinario, libro);
  end;
  
  Close(archivoTexto);
  Close(archivoBinario);
  WriteLn('Archivo binario creado con éxito.');
end;

procedure AgregarLibro;
begin
  with libro do
  begin
    Write('Ingrese ISBN: '); ReadLn(ISBN);
    Write('Ingrese Título: '); ReadLn(Titulo);
    Write('Ingrese Año de Edición: '); ReadLn(AnioEdicion);
    Write('Ingrese Editorial: '); ReadLn(Editorial);
    Write('Ingrese Género: '); ReadLn(Genero);
  end;
  
  Assign(archivoBinario, nombreArchivoBinario);
  Reset(archivoBinario);
  Seek(archivoBinario, FileSize(archivoBinario));
  Write(archivoBinario, libro);
  Close(archivoBinario);
  WriteLn('Libro agregado con éxito.');
end;

procedure ModificarLibroPorISBN;
var
  ISBNABuscar: string[13];
  encontrado: Boolean;
begin
  Write('Ingrese ISBN del libro a modificar: ');
  ReadLn(ISBNABuscar);
  
  Assign(archivoBinario, nombreArchivoBinario);
  Reset(archivoBinario);
  encontrado := False;
  
  while (not Eof(archivoBinario)) and (not encontrado) do
  begin
    Read(archivoBinario, libro);
    if libro.ISBN = ISBNABuscar then
    begin
      encontrado := True;
      with libro do
      begin
        Write('Ingrese nuevo Título: '); ReadLn(Titulo);
        Write('Ingrese nuevo Año de Edición: '); ReadLn(AnioEdicion);
        Write('Ingrese nueva Editorial: '); ReadLn(Editorial);
        Write('Ingrese nuevo Género: '); ReadLn(Genero);
      end;
      Seek(archivoBinario, FilePos(archivoBinario) - 1);
      Write(archivoBinario, libro);
      WriteLn('Libro modificado con éxito.');
    end;
  end;
  
  if not encontrado then
    WriteLn('Libro no encontrado.');
    
  Close(archivoBinario);
end;

procedure MenuPrincipal;
var
  opcion: Integer;
begin
  repeat
    clrscr;
    writeln('Gestión de Libros');
    writeln('1. Crear archivo binario desde texto');
    writeln('2. Agregar libro');
    writeln('3. Modificar libro por ISBN');
    writeln('4. Salir');
    write('Seleccione una opción: ');
    readln(opcion);
    
    case opcion of
      1: CrearArchivoBinarioDesdeTexto;
      2: AgregarLibro;
      3: ModificarLibroPorISBN;
    end;
    
    if opcion <> 4 then begin
      writeln('Presione una tecla para continuar...');
      ReadKey;
    end;
    
  until opcion = 4;
end;

begin
  MenuPrincipal;
end.

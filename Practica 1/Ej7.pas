program Ej7;

uses
  crt, SysUtils;

type
  TFecha = record
    dia: Integer;
    mes: Integer;
    anio: Integer;
  end;

  TAlumno = record
    DNI: string[10];
    Legajo: string[10];
    NombreApellido: string[50];
    Direccion: string[50];
    AnioQueCursa: Integer;
    FechaNacimiento: TFecha;
  end;

var
  archivoAlumnos: file of TAlumno;
  nombreArchivoBinario: string = 'alumnos.dat';
  
procedure CargarDesdeTexto;
var
  archivoTexto: Text;
  alumno: TAlumno;
  fecha: TFecha;
begin
  Assign(archivoTexto, 'alumnos.txt');
  Reset(archivoTexto);
  Assign(archivoAlumnos, nombreArchivoBinario);
  Rewrite(archivoAlumnos);
  
  while not eof(archivoTexto) do
  begin
    with alumno do
    begin
      ReadLn(archivoTexto, DNI, Legajo, NombreApellido, Direccion, AnioQueCursa, FechaNacimiento.dia, FechaNacimiento.mes, FechaNacimiento.anio);
    end;
    Write(archivoAlumnos, alumno);
  end;
  
  Close(archivoTexto);
  Close(archivoAlumnos);
  WriteLn('Archivo binario cargado con éxito.');
end;


procedure ListarPorCaracterInicial;
var
  caracter: Char;
  alumno: TAlumno;
begin
  Write('Ingrese el carácter inicial por el que empiezan los nombres de los alumnos a listar: ');
  ReadLn(caracter);
  Reset(archivoAlumnos);
  
  while not eof(archivoAlumnos) do
  begin
    Read(archivoAlumnos, alumno);
    if UpCase(alumno.NombreApellido[1]) = UpCase(caracter) then
    begin
      // Mostrar datos del alumno
    end;
  end;
  
  Close(archivoAlumnos);
end;

procedure ListarAlumnosAEgresar;
var
  archivoTexto: Text;
  alumno: TAlumno;
begin
  Assign(archivoTexto, 'alumnosAEgresar.txt');
  Rewrite(archivoTexto);
  Reset(archivoAlumnos);
  
  while not eof(archivoAlumnos) do
  begin
    Read(archivoAlumnos, alumno);
    if alumno.AnioQueCursa = 5 then
    begin
      // Escribir alumno en el archivo de texto
    end;
  end;
  
  Close(archivoTexto);
  Close(archivoAlumnos);
end;

procedure AnadirAlumno;
var
  alumno: TAlumno;
begin
  Assign(archivoAlumnos, nombreArchivoBinario);
  Reset(archivoAlumnos);
  Seek(archivoAlumnos, FileSize(archivoAlumnos));
  
  // Solicitar y leer datos del alumno desde el teclado
  
  Write(archivoAlumnos, alumno);
  Close(archivoAlumnos);
end;

procedure ModificarAnioQueCursa;
var
  legajoBuscar: string;
  alumno: TAlumno;
  encontrado: Boolean;
begin
  Write('Ingrese el legajo del alumno a modificar: ');
  ReadLn(legajoBuscar);
  Reset(archivoAlumnos);
  encontrado := False;
  
  while not eof(archivoAlumnos) and not encontrado do
  begin
    Read(archivoAlumnos, alumno);
    if alumno.Legajo = legajoBuscar then
    begin
      encontrado := True;
      // Solicitar nuevo año y actualizar registro
    end;
  end;
  
  if not encontrado then
    WriteLn('Alumno no encontrado.');
    
  Close(archivoAlumnos);
end;

procedure MenuPrincipal;
var
  opcion: Integer;
begin
  repeat
    clrscr;
    writeln('1. Cargar alumnos desde archivo de texto');
    writeln('2. Listar alumnos por carácter inicial');
    writeln('3. Listar alumnos a egresar');
    writeln('4. Añadir alumnos');
    writeln('5. Modificar año que cursa de un alumno');
    writeln('6. Salir');
    writeln('Seleccione una opción: ');
    readln(opcion);

    case opcion of
      1: CargarDesdeTexto;
      2: ListarPorCaracterInicial;
      3: ListarAlumnosAEgresar;
      4: AnadirAlumno;
      5: ModificarAnioQueCursa;
    end;

    if opcion <> 6 then
    begin
      writeln('Presione cualquier tecla para continuar...');
      readkey;
    end;
  until opcion = 6;
end;

begin
  // Inicialización y llamada al menú principal
  Assign(archivoAlumnos, nombreArchivoBinario);
  MenuPrincipal;
  Close(archivoAlumnos);
end.
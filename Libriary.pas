unit Libriary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, DB, StdCtrls, Mask, DBCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Query1: TQuery;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Button1: TButton;
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Edit1Change(Sender: TObject);
var
I:Integer;
Buf:String;
begin
Query1.Close;
Query1.SQL.Clear;
Form1.ComboBox1.Items.Clear;

If Copy(Form1.Edit1.Text,1,Length(Form1.Edit1.Text))<>'' Then

Query1.SQL.Add('SELECT * FROM History.db WHERE Analitic LIKE '''
+ Copy(Edit1.Text,1,Length(Form1.Edit1.Text)) + '%''');


Query1.Open;
Query1.First;
Buf:=Form1.Edit1.Text;

If Query1.RecordCount<>0 Then
Begin
For I:=1 To Query1.RecordCount Do
  Begin
  Form1.ComboBox1.Items.Add(Query1.FieldValues['Analitic']);
  Query1.Next;
  End;

Form1.ComboBox1.DroppedDown:=true;
Form1.Edit1.Text:=Buf;

End
Else
Begin
  Form1.ComboBox1.Items.Clear;
End;

Form1.Activate;
Form1.Edit1.SetFocus;
end;

procedure TForm1.ComboBox1Click(Sender: TObject);
begin
Form1.Edit1.Text:=Form1.ComboBox1.Text;
Form1.Activate;
Form1.Edit1.SetFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//Form1.Query1.DatabaseName:=GetCurrentDir;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
command:String;
begin
Query1.Close;
Query1.SQL.Clear;
Form1.ComboBox1.Items.Clear;
Query1.SQL.Add('SELECT * FROM History.db WHERE Analitic= '''
+ Copy(Edit1.Text,1,Length(Form1.Edit1.Text)) + '''');
Query1.Open;

If Query1.RecordCount=0 Then
Form1.ComboBox1.Items.Clear;
command:= 'INSERT INTO History.db (Analitic) VALUES( '''+ Copy(Edit1.Text,1,Length(Form1.Edit1.Text))+ ''')';
Query1.SQL.Add(command);
Query1.ExecSQL;
Query1.Open;

end;

end.

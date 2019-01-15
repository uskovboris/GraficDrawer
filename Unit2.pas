unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TBilder = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button6: TButton;
    Button7: TButton;
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Bilder: TBilder;

implementation
uses Unit1;
{$R *.dfm}

procedure TBilder.ListBox1Click(Sender: TObject);
begin
ListBox1.Sorted:=true;

Bilder.Memo1.Text:=Bilder.Memo1.Text + Bilder.ListBox1.Items[ListBox1.ItemIndex]+'(';
end;

procedure TBilder.Button1Click(Sender: TObject);
begin
Bilder.Memo1.Text:=Bilder.Memo1.Text+Trim((Sender as TButton).Caption);
end;

procedure TBilder.BitBtn1Click(Sender: TObject);
begin
Unit1.Form1.InputPole.Text:=Unit2.Bilder.Memo1.Text;
end;

procedure TBilder.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
If MessageDlg('Сохранить построенное выражение?',mtConfirmation,[mbYes,mbNo],-1)=mrYes Then
Unit1.Form1.InputPole.Text:=Unit2.Bilder.Memo1.Text;  
end;

procedure TBilder.BitBtn3Click(Sender: TObject);
begin
Application.HelpCommand(Help_Contents,6) 
end;

End.



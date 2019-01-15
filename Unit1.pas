unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls, Grids,Unit2,Unit4,Abaut, DBCtrls,
  DB, DBTables,Registry;

type
  TForm1 = class(TForm)
    Label3: TLabel;
    GroupBox3: TGroupBox;
    Tabulation: TStringGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    StepX: TLabeledEdit;
    XminEdit: TLabeledEdit;
    XmaxEdit: TLabeledEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    StepY: TLabeledEdit;
    YminEdit: TLabeledEdit;
    YmaxEdit: TLabeledEdit;
    GroupBox2: TGroupBox;
    ColorBox: TColorBox;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Pole: TImage;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    BitBtn3: TBitBtn;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Table1: TTable;
    ComboBox1: TComboBox;
    InputPole: TEdit;
    DataSource1: TDataSource;
    Query1: TQuery;
    PopupMenu1: TPopupMenu;
    N13: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure InputPoleChange(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Query1BeforeOpen(DataSet: TDataSet);
    procedure N13Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;




var
InstallPath:String;
k:SmallInt;
L:Boolean;
ParamPath:String;
flag:Boolean;
SaveFlag:Boolean;


Form1: TForm1;

//Входные параметры
Xmin,Xmax,Ymin,Ymax,hx,hy:Currency;

OperandStack:array [1..50] of Real;
Stack:array [1..50] of String[4];
Top:Byte;

Mas:array [1..50] of String;
EndMas:Byte;

Error:Integer;

I,J:byte;

Xt,Yt:Word;

implementation

//uses Unit1;
{$R *.dfm}
{$J+}
{$E-}

//***************Тип файловой записи***********************
type
  FRec=Record
    Func:ShortString;
    MinX,MinY,MaxX,MaxY,StepX,StepY:ShortString;
    Picture:array [0..600,0..600] of TColor;
    Tab:array [0..1,0 .. 100] of ShortString;
    ColorIndex:Integer;
    verUp:Byte;
    verDown:Byte;
    verRevision:Byte;
  End;

var
  SaveFilePath:ANSIString; //Путь сохранения в файл


procedure SaveAS; forward;
procedure Open; forward;
//***********Вычисление значения функции*******************

function sgn(X:Currency):Currency;
Begin
 If X=0.0 Then Result:=0.0 Else If X>0 Then Result:=1.0 Else Result:=-1.0;
End;

Function DelSpace(Str:String):String;
var I:Byte;
Begin
I:=1;
 While I<Length(Str)+1 Do
  Begin
   If Str[I]=' ' Then Delete(Str,I,1) Else
   Inc(I);
  End;
 Result:=Str;
End;

Function SearchErrors():Boolean;
Label E;
var
Txt:String;
BUF:String[3];
Begin
{$B-}
I:=1;
TOP:=0;
//Ввод Txt
Txt:=Form1.InputPole.Text;
//Перевод Txt в верхний регистр
Txt:=UpperCase(DelSpace(Txt));

 While I<=Length(Txt) Do
  Begin
   If (POS(Txt[I], '+*/-')<>0) Then
    Begin

     If ((I=1) or (POS(Txt[I-1],'+-*/,(')<>0)) and not ((Txt[I]='-') And ((Txt[I-1]='(') or (I=1)) )  Then
      Begin
       MessageDlg('Недопустимый первый операнд',mtError,[mbOK],5);
       Form1.InputPole.SelStart:=I;
       Form1.InputPole.SelLength:=1;
       Result:=true;
       exit;
      End;

     If (I=Length(Txt)) or (POS(Txt[I+1],'+-*/,)')<>0) Then
      Begin
       MessageDlg('Недопустимый второй операнд',mtError,[mbOK],5);
       Form1.InputPole.SelStart:=I;
       Form1.InputPole.SelLength:=1;
       Result:=true;
       exit;
      End;

    End
   Else

    If Pos(Txt[I],'(1234567890,-')<>0 Then

     Else
      Begin
       BUF:=Copy(Txt,I,3);

       If (BUF='SIN')
         or (BUF='COS')
         or (BUF='TAN')
         or (BUF='ATN')
         or (BUF='LOG')
         or (BUF='EXP')
         or (BUF='ABS')
         or (BUF='SQR')
       Then
         Begin
          Inc(I,2);
          If (Txt[I+1]<>'(') Then
           Begin
            MessageDlg('Отсутствует "(" после имени функции',mtError,[mbOK],5);
            Form1.InputPole.SelStart:=I;
            Form1.InputPole.SelLength:=3;

            Result:=true;
            exit;
           End;

          If (POS(Txt[I+2],'+*/)')<>0) Then
           Begin
            MessageDlg('Недопустимый аргумент функции',mtError,[mbOK],5);
            Form1.InputPole.SelStart:=I;
            Form1.InputPole.SelLength:=3;

            Result:=true;
            exit;
           End;

           If (POS(Txt[I-3],'+*/)')=0) and (I>3)  Then
           begin
           L:=pos(copy(Txt,I-6,3),'ABSSINCOSTANATNLOGEXPSQR')=0;
            If L Then
             Begin
              MessageDlg('Отсутствует знак операции',mtError,[mbOK],5);
              Form1.InputPole.SelStart:=I-3;
              Form1.InputPole.SelLength:=1;

              Result:=true;
              exit;
             End;
           end
         end
       Else
        If (Pos(Txt[I],'X')<>0) Then
         Begin
          If (POS(Txt[I-1],')1234567890')<>0) or (POS(Txt[I+1],'(1234567890')<>0) Then
           Begin
            MessageDlg('Неверная операция',mtError,[mbOK],5);
            Form1.InputPole.SelStart:=I;
            Form1.InputPole.SelLength:=1;
            Result:=true;
            exit;
           end;
         End
        Else
         IF Txt[I]='(' Then
          If POS(Txt[I-1],')1234567890X')<>0 Then
           Begin
            MessageDlg('Неверное расположение: (',mtError,[mbOK],5);
            Form1.InputPole.SelStart:=I;
            Form1.InputPole.SelLength:=1;
            Result:=true;
            exit;
           end
          Else
           IF Txt[I]=')' Then
            If POS(Txt[I+1],'(1234567890X')<>0 Then
             Begin
              MessageDlg('Неверное расположение: ) или отсутствует операция',mtError,[mbOK],5);
              Form1.InputPole.SelStart:=I;
              Form1.InputPole.SelLength:=1;
              Result:=true;
              exit;
             end
            Else

             IF Txt[I]='(' Then
              Begin
               Inc(Top);
               Stack[TOP]:=Txt[I];
              End
             Else
              If Txt[I]=')' Then
               If Stack[TOP]='(' Then
                Begin
                 DEC(TOP);
                End
               Else
                Begin
                 MessageDlg('Ошибка вложенности: отсутствует (',mtError,[mbOK],5);
                 Result:=true;
                 exit;
                End
              Else
          
            Else
            Begin
             MessageDlg('Недопустимый символ в выражение',mtError,[mbOK],5);
             Form1.InputPole.SelStart:=I;
             Form1.InputPole.SelLength:=1;
             Result:=true;
             exit;
            end;
      end;

      Inc(I);
  End;

  If Stack[TOP]='(' Then
   Begin
    MessageDlg('Ошибка вложенности: отсутствует )',mtError,[mbOK],0);
    Result:=true;
   End;
End;

procedure Translation();

var
Operand:String;
Txt:String;
BUF:String;

function Prioretet(Op:String):Byte;
  Begin
   If Op='(' Then Prioretet:=1;
   If (Op='+') or (Op='-') Then Prioretet:=2;
   If (Op= '*') or (Op= '/') Then Prioretet:=3;
   If (Op='$') Then Prioretet:=4;
  End;

Begin
 Txt:=Form1.InputPole.Text;

 For I:=1 To 50 Do
  Begin
   OperandStack[I]:=0;
   Stack[I]:='';
   Mas[I]:='';
  End;

 I:=1;
 EndMas:=1;
 Top:=0;

While I<=Length(Txt)+1 Do
 Begin
   If POS(Txt[I],'0123456789,')<>0 Then
      Begin
       Operand:=Operand+Txt[I];
       {Videlenie chisla iz stroky}
      End
   Else
      If Operand<>'' Then
        Begin
         Mas[EndMas]:=Operand;
         Operand:='';
         {Dobavlenie chisla v massiv kotoriy budet soderjat OPZ}
         Inc(EndMas);
        End;

    Begin

       If POS(Form1.InputPole.Text[I],'+-*/')<>0 Then
         Begin
           {Unarniy minus}
           If (Txt[I]='-') And ((Txt[I-1]='(') or (I=1)) Then
             Begin
              inc(Top);
              Stack[Top]:='$';
             End
           Else
             If (Stack[Top]='') and (Top=0) Then {Esly stek pustoy}
               Begin
                {Zanosim znak operacii v stek}
                Inc(Top);
                Stack[Top]:=Txt[I];
               End
             Else {Esly stek ne pustoy}
               If Prioretet(Stack[Top])<Prioretet(Txt[I]) Then
                 Begin
                  {Protalkivaem znak operacii v stek}
                  Inc(Top);
                  Stack[Top]:=Txt[I];
                 End
                Else
                 Begin
                   While (Prioretet(Stack[Top])>=Prioretet(Txt[I])) AND (Stack[Top]<>'') Do
                    Begin
                     Mas[EndMas]:=Stack[Top];
                     Inc(EndMas);
                     Dec(Top);
                    End;

                   Inc(Top);
                   Stack[Top]:=Txt[I];
                 End;

         End
       Else
         If Txt[I]='(' Then
           Begin
            Inc(Top);
            Stack[Top]:='(';
           End
         Else
          If Txt[I]=')' Then
           Begin
             While Stack[Top]<>'(' Do
                Begin
                 Mas[EndMas]:=Stack[Top];
                 Inc(EndMas);
                 Dec(Top);
                End;

             Dec(Top);
           End
          Else
           If (Txt[I]='X') or (Txt[I]='x') Then
            Begin
             Mas[EndMas]:='X';
             Inc(EndMas);
            End
           Else
            If Txt[I]=' ' Then Else
             Begin
              BUF:=UpperCase(Copy(Txt,I,3));
              INC(TOP);
              INC(I,2);
              If (BUF = 'SIN') Then Stack[Top]:='S' Else
              If (BUF = 'COS') Then Stack[Top]:='C' Else
              If (BUF = 'TAN') Then Stack[Top]:='T' Else
              If (BUF = 'ATN') Then Stack[Top]:='A' Else
              If (BUF = 'LOG') Then Stack[Top]:='L' Else
              If (BUF = 'EXP') Then Stack[Top]:='E' Else
              If (BUF = 'SQR') Then Stack[Top]:='Q' Else
              If (BUF = 'ABS') Then Stack[Top]:='B'
              Else
                Begin
                 DEC(TOP);
                 DEC(I,2);
                End;

             End;
    End;

   Inc(I);
 End;

 While (Stack[Top]<>'') Do
   Begin
     Mas[EndMas]:=Stack[Top];
     Inc(EndMas);
     Dec(Top);
   End;

End;
//***********************************************************
function Value( X:Currency; var Err:Boolean ):Currency; export;

 function Calc(Operand1,Operand2:Real; Operation:String):Currency;
 Begin
  If  Operation= '+' Then Calc:=Operand1+Operand2;
  If  Operation= '-' Then Calc:=Operand1-Operand2;
  If  Operation= '*' Then Calc:=Operand1*Operand2;
  If  Operation= '/' Then Calc:=Operand1/Operand2;
 End;

Begin
 Err:=false;
 I:=1;
 Top:=0;

While MAS[I]<>'' DO

  Begin
    try
     try
      If Mas[I]='$' Then
      OperandStack[Top]:=-OperandStack[Top]
      Else

       Case MAS[I][1] of
         'S':OperandStack[Top]:=SIN(OperandStack[Top]);
         'C':OperandStack[Top]:=COS(OperandStack[Top]);
         'T':OperandStack[Top]:=SIN(OperandStack[Top])/COS(OperandStack[Top]);
         'A':OperandStack[Top]:=ARCTAN(OperandStack[Top]);
         'L':OperandStack[Top]:= LN(OperandStack[Top]);
         'E':OperandStack[Top]:=EXP(OperandStack[Top]);
         'Q':OperandStack[Top]:=SQRT(OperandStack[Top]);
         'B':OperandStack[Top]:=ABS(OperandStack[Top]);
       Else

          If POS(Mas[I],'+-*/')<>0 Then
            Begin
             OperandStack[Top-1]:=Calc(OperandStack[Top-1],OperandStack[Top],Mas[I][1]);
             Dec(Top);
            End
          Else
           If Mas[I]='X' Then
            Begin
             Inc(Top);
             OperandStack[Top]:=X;
            End
           Else
            Begin
             Inc(Top);
             OperandStack[Top]:=StrToFloat(MAS[I]);
            End;
       End;

     except
      on EZeroDivide do Err:=true;
      on EInvalidOp do Err:=true;
      on EDivByZero do Err:=true;
     end;
    finally
     inc(i);
    end;

  End;

Value:=OperandStack[1];
End;

//************************************************************

procedure ClearPole; //Очистка поля для построений
var
Rec:TRect;
I,J:Cardinal;
Begin
Form1.Pole.Canvas.Brush.Color:=clWhite;
Rec.Left:=0;
Rec.Top:=0;
Rec.Right:=Form1.Pole.Width;
Rec.Bottom:=Form1.Pole.Height;
Form1.Pole.Canvas.FillRect(Rec);
End;

//Функция преобразования мировых координат X в экранные
function DisplayX(X:Real):Word;
Begin
DisplayX:=Round((Form1.Pole.Width)*(ABS(X-Xmin)/(Xmax-Xmin)));//+correctX;
End;

//Функция преобразования мировых координат Y в экранные
function DisplayY(Y:Real):Word;
Begin
DisplayY:=Round((Form1.Pole.Height-1)*(1-ABS((Y-Ymin)/(Ymax-Ymin)))); //+correctY;
End;

procedure DrawLines; //Построение осей координат
Begin
 Form1.Pole.Canvas.Pen.Color:=clBlack;

 //Анализ X
 If (Xmin=0) or ((Xmin*Xmax>0) and (Xmin>0)) Then
  Begin
   Xt:=1;
  End
 Else //Если X лежит в 1 и 4 координатной четверти то ось ординат будет иметь
 //координатой X 1 пиксел справа
  If (Xmax=0) or ((Xmin*Xmax>0) and (Xmin<0)) Then
   Begin
    Xt:=Form1.Pole.Width-1
   End
  Else
   Begin
    Xt:=DisplayX(0);//наоборот If Xmin*Xmax>0 Then   //если MAX(X) и MIN(X) лежат по одну сторону оси ординат
   End;

 If (Ymin=0) or ((Ymin*Ymax>0) and (Ymin>0)  )  Then
  Begin
   Yt:=Form1.Pole.Height-1;
  End
 Else
  If (Ymax=0) or ((Ymin*Ymax>0) and (Ymin<0) ) Then
   Begin
   Yt:=1;
   End
  Else
   Begin
    Yt:=DisplayY(0);
   End;

  Form1.Pole.Canvas.MoveTo(DisplayX(XMin),Yt);
  Form1.Pole.Canvas.LineTo(DisplayX(XMax),Yt);
  Form1.Pole.Canvas.MoveTo(Xt,DisplayY(Ymin));
  Form1.Pole.Canvas.LineTo(Xt,DisplayY(Ymax));

End;

procedure GradX(X:Real);
var
k:ShortInt;
Begin
 If (Ymin=0) or (Ymax>0) Then k:=-17 Else k:=17;

  Form1.Pole.Canvas.TextWidth('5');
  Form1.Pole.Canvas.MoveTo(DisplayX(X),Yt-5);
  Form1.Pole.Canvas.LineTo(DisplayX(X),Yt+5);
  Form1.Pole.Canvas.TextOut(DisplayX(X),Yt+k,FloatToStrF(X,ffFixed,4,1 ));
End;

 procedure GradY(Y:Real);
 var
 K:ShortInt;
 Begin
  If (Xmin=0) or (Xmax>0) Then k:=20 Else k:=-22;

  Form1.Pole.Canvas.TextWidth('5');
  Form1.Pole.Canvas.MoveTo(Xt-5,DisplayY(Y));
  Form1.Pole.Canvas.LineTo(Xt+5,DisplayY(Y));
  Form1.Pole.Canvas.TextOut(Xt+k,DisplayY(Y),FloatToStrF(Y,ffFixed,6,2 ));
 End;

procedure TForm1.Button1Click(Sender: TObject);
var
X,Y:array of Currency;
NX,NY:Currency;
i,j:Integer;
Err:Boolean;

DX,DY:Word;
hm:Real;
begin
If SearchErrors Then Exit;  //Ecли в выражение есть синтаксические ошибки
//                         Инициализация
NX:=0;
NY:=0;
For I:=0 To High(X) Do
 Begin
  X[I]:=0;
  Y[I]:=0;
 End;

Form1.Tabulation.RowCount:=0;
Translation;
SetLength(X,0);
SetLength(Y,0);

//*****************************************************************************
//                           Ввод Xmin и Xmax

try
 Xmin:=StrToFloat(Form1.XminEdit.Text);
except
on EConvertError do
 Begin
  MessageDlg('Неверно задан Xmin',mtError,[mbOK],0);
  exit;
 End;
end;

try
 Xmax:=StrToFloat(Form1.XmaxEdit.Text);
except
 on EConvertError do
  Begin
   MessageDlg('Неверно задан Xmax',mtError,[mbOK],0);
   exit;
  End;
end;

Ymin:=maxCurrency; //Присваиваем Ymin максимально-возможне для него значение

Ymax:=minCurrency; //Присваиваем Ymin минимально-возможне для него значение

//********************************************************************
hm:=1e-3; //Внутренний шаг для придания плавности графику

ClearPole; //Очистка поля для построения

//Резервирование памяти для одного элемента динамичесих массивов
//X и Y (по одному элементу в каждом
SetLength(X,1);
SetLength(Y,1);

I:=0;
NX:=Xmin;
X[I]:=Xmin;
While X[I]<=Xmax Do
 Begin
  SetLength(X,Length(X)+1);
  SetLength(Y,Length(Y)+1);

  Y[I]:=Value(X[I],Err);

  If not Err Then //Если небыло ошибки времени выполнения
   Begin
    If Ymin>Y[I] Then Ymin:=Y[I]; //проверяем не является ли Y[I] новым Ymin
    If Ymax<Y[I] Then Ymax:=Y[I]; //проверяем не является ли Y[I] новым Ymax
    Inc(I);
    X[I]:=X[I-1]+hm; // вычисляем следующее значение аргумента
   End
  Else  //Если ошибка была,
    X[I]:=X[I]+hm; //то вычисляем следующее значение функции

 End;

If Form1.YminEdit.Text<>'' Then
  try
   Ymin:=StrToFloat(Form1.YminEdit.Text);  //Чтение Ymin
  except
   on EConvertError do // Если произошла ошибка преобразования из строки в число
    Begin
     MessageDlg('Неверно задан Ymin',mtError,[mbOK],0);
     exit;
    End;
  end;

If Form1.YmaxEdit.Text<>'' Then
 try
   Ymax:=StrToFloat(Form1.YmaxEdit.Text);
 except
   on EConvertError do // Если произошла ошибка преобразования из строки в число
    Begin
     MessageDlg('Неверно задан Ymax',mtError,[mbOK],0);
     exit;
    End;
 end;


  If ABS(Ymin)>999 Then //Ymin не должно по модулю превышать 999
   Begin
    Ymin:=999*sgn(Ymin);
   End;

  If ABS(Ymax)>999 Then  //Ymax не должно по модулю превышать 999
   Begin
    Ymax:=999*sgn(Ymax);
   End;


 // На случай если значения Ymax и Ymin изменились на предыдущих шагах
 // выведем конечные значения этих переменных
    Form1.YminEdit.Text:=FloatToStr(Ymin);
    Form1.YmaxEdit.Text:=FloatToStr(Ymax);

//Прорисовка осей
    DrawLines;
    Form1.Refresh;

// собственно строим график по вычисленным точкам
 For I:=0 To High(X) Do
  If (Ymin<=Y[I]) and (Y[I]<=Ymax) and not Err Then // Проверяем не выходят ли
  // Y[I] из диапазона [Ymin;Ymax]
    Begin
     //Вычисляем экранные координаты очередной точки
     DX:=DisplayX(X[I]);
     DY:=DisplayY(Y[I]);
     //ставим точку в вычисленных координатах
     Form1.Pole.Canvas.Pixels[DX,DY]:=Form1.ColorBox.Colors[Form1.ColorBox.ItemIndex];
    End;

//****************************************************
If (Form1.StepX.Text<>'') and Form1.CheckBox1.Checked Then
  Begin
    hx:=StrToFloat(Form1.StepX.Text);
    NX:=Xmin;
    I:=0;
    While NX<=Xmax Do
     Begin
      NY:=Value(NX,Err);
      If (Ymin<=NY) and (NY<=Ymax) and not Err Then
        Begin
         //Проставление точек большого диаметра
         Form1.Pole.Canvas.Ellipse(DisplayX(NX)-3,DisplayY(NY)-3,DisplayX(NX)+3,DisplayY(NY)+3);
         Form1.Pole.Canvas.Brush.Color:=clRed;
         Form1.Pole.Canvas.FloodFill(DisplayX(NX),DisplayY(NY),clBlack,fsBorder);
         Form1.Pole.Canvas.Brush.Color:=clWhite;

         //Табуляция функции
         Form1.Tabulation.RowCount:=Form1.Tabulation.RowCount+1;
         Form1.Tabulation.Cells[0,I]:=FloatToStr(NX);
         Form1.Tabulation.Cells[1,I]:=FloatToStr(NY);

         inc(I);
        End;

      IF (Form1.CheckBox2.Checked) and (Form1.StepY.Text='') Then //Если вклю
      //чено градуирование по OY и ШагY не задан
      GradY(NY); //ставим рисочку в NY на оси OY

      Form1.Refresh;

      GradX(NX); //ставим рисочку в NX на оси OX

      Nx:=NX+hx; //следующий NX через шаг hx
     End;




//****************************************************************************
//------------Чтобы выводил экстемальные значения при градуировании-----------

    If (Xmin=0) or (Xmax>0) Then k:=20 Else k:=-22;

If Form1.CheckBox2.Checked Then
   Begin
    Form1.Pole.Canvas.TextWidth('5');
    Form1.Pole.Canvas.MoveTo(Xt-5,DisplayY(Ymax));
    Form1.Pole.Canvas.LineTo(Xt+5,DisplayY(Ymax));
    Form1.Pole.Canvas.TextOut(Xt+k,
                              DisplayY(Ymax)-2,
                              FloatToStrF(Ymax,ffFixed,6,2));
   End;

If Form1.CheckBox2.Checked Then
   Begin
    Form1.Pole.Canvas.TextWidth('5');
    Form1.Pole.Canvas.MoveTo(Xt-5,DisplayY(Ymin));
    Form1.Pole.Canvas.LineTo(Xt+5,DisplayY(Ymin));
    Form1.Pole.Canvas.TextOut(Xt+k,
                              DisplayY(Ymin)-12,
                              FloatToStrF(Ymin,ffFixed,6,2));
   End;
//------------------------------------------------------------------------

  End;


//*****************************************************
  If (Ymin=0) or (Ymax>0) Then k:=-20 Else k:=0;
   If Form1.CheckBox1.Checked Then
     Begin
       Form1.Pole.Canvas.TextWidth('5');
       Form1.Pole.Canvas.MoveTo(DisplayX(Xmax)-1,Yt-5);
       Form1.Pole.Canvas.LineTo(DisplayX(Xmax)-1,Yt+5);
       Form1.Pole.Canvas.TextOut(DisplayX(Xmax)-Length(
       FloatToStrF(Xmax,ffFixed,4,1 ))*4-1,Yt+k,FloatToStrF(Xmax,ffFixed,4,1 ));
     End;




//Если включено градуирование по OY и ШагY задан
  IF (Form1.CheckBox2.Checked) and (Form1.StepY.Text<>'') Then
    Begin
    NY:=Ymin;
    hy:=StrToFloat(Form1.StepY.Text);
      While (NY<=Ymax) Do
       Begin
        GradY(NY);
        NY:=NY+hy;
       End;
    End;


//--------------------Добавление новой функции в историю-----------------
Form1.Query1.Close;
Form1.Query1.SQL.Clear;
Query1.SQL.Add('SELECT * FROM History.db WHERE Analitic='''+InputPole.Text+'''');
Form1.Query1.Open;

If Query1.RecordCount=0 Then
  Begin
  try
    Form1.Query1.Close;
    Form1.Query1.SQL.Clear;
    Form1.Query1.SQL.Add('INSERT INTO History.db (FunctionName,Analitic) VALUES( ''' + UpperCase(Form1.InputPole.Text + ''', '''+Form1.InputPole.Text)+''')');

    Form1.Query1.Open;


  except
  end;

  End;

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
// Очистка полей для входных данных
Form1.StepX.Text:='';
Form1.StepY.Text:='';
Form1.YminEdit.Text:='';
Form1.YmaxEdit.Text:='';
Form1.XminEdit.Text:='';
Form1.XmaxEdit.Text:='';
Form1.InputPole.Text:='';

// Очистка массива табуляции
Form1.Tabulation.RowCount:=0;
Form1.Tabulation.Cells[0,0]:='';
Form1.Tabulation.Cells[1,0]:='';
ClearPole; //Очистка поля для построения
end;

procedure Split(Source:String; Delimeter:char; var Mas: array of String);
var
Poz,I:Byte;
Begin
 I:=0;
 While  Pos(Delimeter,Source)<>0 Do
 Begin
  poz:=Pos(Delimeter,Source);
  Mas[I]:=Copy(Source,1,Poz-1);
  Source:=Copy(Source,Poz+1,Length(Source)-Poz);
  Inc(I);
 End;
  Mas[I]:=Source;
End;



procedure TForm1.Button2Click(Sender: TObject);
Begin
SaveAs;
End;


procedure SaveAs;
//********Сохранение графика на фиске*****************
var
I,J:Cardinal;
L:Boolean;
grpFile:File of FRec;
Buf:FRec;
begin

If SaveFlag or (SaveFilePath='')  Then
If Form1.SaveDialog1.Execute Then
 SaveFilePath:=Form1.SaveDialog1.FileName;


If (SaveFilePath<>'') Then
 Begin



 For I:=0 To Form1.Pole.Width-1 Do
  For J:=0 To Form1.Pole.Height-1 Do
   Begin
    Buf.Picture[I,J]:= Form1.Pole.Canvas.Pixels[I,J];
   End;

  For I:=0 To Form1.Tabulation.RowCount-1  Do
   Begin
    Buf.Tab[0,I]:= Form1.Tabulation.Cells[0,I];
    BUF.Tab[1,I]:=Form1.Tabulation.Cells[1,I];
   End;

  Buf.Func:=Form1.InputPole.Text;
  Buf.MinX:=Form1.XminEdit.Text;
  Buf.MinY:=Form1.YminEdit.Text;
  Buf.MaxX:=Form1.XmaxEdit.Text;
  Buf.MaxY:=Form1.YmaxEdit.Text;
  Buf.StepX:=Form1.StepX.Text;
  Buf.StepY:=Form1.StepY.Text;
  Buf.ColorIndex:=Form1.ColorBox.ItemIndex;
  Buf.verUp:=2;
  Buf.verDown:=0;
  Buf.verRevision:=0;

//Непосредственная запись на диск
If Copy(SaveFilePath,Length(SaveFilePath)-3,4)<>'.gdr' Then
   SaveFilePath:=SaveFilePath+'.gdr';

  AssignFile(grpFile,String(SaveFilePath));
  Rewrite(grpFile);
  Write(grpFile,Buf);
  CloseFile(grpFile);

 End
Else
 Dialogs.MessageDlg('Вы не задали имя файла. Сохранение не возможно',mtError,[mbOk],5);

end;


procedure Open;
var
I,J:Cardinal;
grpFile:File of FRec;
Buf:FRec;
begin

Form1.Tabulation.RowCount:=0;
Form1.Tabulation.Cells[0,0]:='';
Form1.Tabulation.Cells[0,1]:='';

IF flag Then
    SaveFilePath:=ParamPath
   else
  If Form1.OpenDialog1.Execute Then
    SaveFilePath:=Form1.OpenDialog1.FileName;

If SaveFilePath<>'' Then
 Begin
    try
      AssignFile(grpFile,String(SaveFilePath));
      Reset(grpFile);
      Read(grpFile,Buf);
      CloseFile(grpFile);

    except
      on EFilerError do
         Dialogs.MessageDlg('Возможно файл имеет устаревший формат',mtError,[mbOk],0);
    end;

    If (Buf.verUp=2) and (Buf.verDown=0) and (Buf.verRevision=0) Then
     For I:=0 To Form1.Pole.Width-1 Do
      For J:=0 To Form1.Pole.Height-1 Do
       Begin
        Form1.Pole.Canvas.Pixels[I,J]:=Buf.Picture[I,J];
       End
     else
       Exit;


     For I:=0 To High(Buf.Tab[0]) Do
      Begin
       Form1.Tabulation.RowCount:=Form1.Tabulation.RowCount+1;
       Form1.Tabulation.Cells[0,I]:=BUF.Tab[0,I];
       Form1.Tabulation.Cells[1,I]:=BUF.Tab[1,I];
      End;

     Form1.InputPole.Text:=Buf.Func;
     Form1.XminEdit.Text:=Buf.MinX;
     Form1.YminEdit.Text:=Buf.MinY;
     Form1.XmaxEdit.Text:=Buf.MaxX;
     Form1.YmaxEdit.Text:=Buf.MaxY;
     Form1.StepX.Text:=Buf.StepX;
     Form1.StepY.Text:=Buf.StepY;
    Form1.ColorBox.ItemIndex:=Buf.ColorIndex;

     Form1.ComboBox1.DroppedDown:=false;
 End;
End;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Unit2.Bilder.Memo1.Text:=Unit1.Form1.InputPole.Text;
Unit2.Bilder.ShowModal;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
Application.HelpCommand(HELP_FINDER,0);
end;

procedure TForm1.N12Click(Sender: TObject);
begin
Abaut.AboutBox.ShowModal;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
Application.HelpCommand(HELP_FINDER,0);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
Open;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
SaveFlag:=true;
SaveAs;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
Button1Click(Form1);
end;

procedure TForm1.N9Click(Sender: TObject);
begin
ClearPole;
end;             

procedure TForm1.N3Click(Sender: TObject);
begin
SaveFlag:=false;
If SaveFilePath<>'' Then
  Begin
  flag:=True;
  Button2Click(Form1);
  End
Else
  Form1.N5Click(Form1);
end;


//------------------------Обращение к истории------------------------------------
procedure TForm1.InputPoleChange(Sender: TObject);
var
I:Integer;
Buf:String;
begin
Query1.Close;
Query1.SQL.Clear;
Form1.ComboBox1.Items.Clear;

If Copy(Form1.InputPole.Text,1,Length(Form1.InputPole.Text))<>'' Then
Begin
Query1.SQL.Add('SELECT * FROM History.db WHERE Analitic LIKE '''
+ Copy(InputPole.Text,1,Length(Form1.InputPole.Text)) + '%''');


Query1.Open;
Query1.First;
Buf:=Form1.InputPole.Text;

If Query1.RecordCount<>0 Then
Begin
For I:=1 To Query1.RecordCount Do
  Begin
  Form1.ComboBox1.Items.Add(Query1.FieldValues['Analitic']);
  Query1.Next;
  End;

Form1.ComboBox1.DroppedDown:=true;
Form1.InputPole.Text:=Buf;

End
Else
Begin
  Form1.ComboBox1.Items.Clear;
End;

//Form1.Activate;
//Form1.InputPole.SetFocus;
Form1.Refresh;
End;
end;


//--------------------------------------------------------------


procedure TForm1.ComboBox1Click(Sender: TObject);
begin
Form1.InputPole.Text:=Form1.ComboBox1.Text;
Form1.ComboBox1.DroppedDown:=False;
Form1.Refresh;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
     // Очистка полей для входных данных
Form1.StepX.Text:='';
Form1.StepY.Text:='';
Form1.YminEdit.Text:='';
Form1.YmaxEdit.Text:='';
Form1.XminEdit.Text:='';
Form1.XmaxEdit.Text:='';
Form1.InputPole.Text:='';

// Очистка массива табуляции
Form1.Tabulation.RowCount:=0;
Form1.Tabulation.Cells[0,0]:='';
Form1.Tabulation.Cells[1,0]:='';
ClearPole; //Очистка поля для построения
end;

procedure TForm1.FormCreate(Sender: TObject);
var

Registry:TRegistry;
P:PChar;
ParamArr:array[0..10] of String;
FilePath:AnsiString;
begin

SaveFlag:=false;

P := GetCommandLine;
FilePath:=Copy(P,Pos(P,'"'),Length(P)-Pos(P,'"'));

Split(P, '"', ParamArr);

ParamPath:=ParamArr[3];

  If ParamArr[3]<>'' Then
    Begin
      flag:=True;
      Open;
    end;




Application.HelpFile:=InstallPath+'\HELP.HLP';

ClearPole;
end;


procedure TForm1.Query1BeforeOpen(DataSet: TDataSet);
var
reg:TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('SOFTWARE\GraficDrawer',true);//открываем ключ
  Unit1.InstallPath:=Reg.ReadString('InstallPath');
 
  Reg.CloseKey;
  Reg.Free;

Form1.Query1.Close;
Form1.Query1.DatabaseName:=InstallPath ;
end;

procedure TForm1.N13Click(Sender: TObject);
begin
Form1.Query1.Close;
Form1.Query1.SQL.Clear;
If Form1.Query1.RecordCount<>0 Then

Query1.SQL.Add('SELECT * FROM History.db WHERE Analitic='''+UpperCase(InputPole.Text)+'''');
Form1.Query1.Open;
ShowMessage('Hello');
end;

end.


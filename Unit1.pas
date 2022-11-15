unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls,ExtCtrls,
  uCEFApplication, uCEFUrlRequestClientComponent,uCEFUrlRequest,uCEFRequest,uCEFInterfaces,uCEFTypes,
  uCEFChromiumCore, uCEFChromium, uCEFWinControl, uCEFWindowParent,
   uCEFLinkedWinControlBase, uCEFChromiumWindow;

const
WM_GEOSUCCESS= WM_APP+1;
WM_MAPLOADED= WM_APP+2;

maptypes:array[0..3] of string =('roadmap','satellite','hybrid','terrain');

geoApiURL='https://maps.googleapis.com/maps/api/geocode/xml?address=%address%&key=%apikey%';
staticApiURL='https://maps.googleapis.com/maps/api/staticmap?center=%center%&zoom=%zoom%&size=%size%&format=jpg&markers=%marker%&maptype=%mapType%&key=%apikey%';

type
  TfrmMain = class(TForm)
    GroupBox1: TGroupBox;
    XPManifest1: TXPManifest;
    edtApi: TEdit;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    btnLoad: TButton;
    Label2: TLabel;
    edtLine1: TEdit;
    edtLine2: TEdit;
    Label3: TLabel;
    edtSuburb: TEdit;
    Label4: TLabel;
    edtState: TEdit;
    Label5: TLabel;
    edtPostecode: TEdit;
    Label6: TLabel;
    edtCountry: TEdit;
    Label7: TLabel;
    edtLat: TEdit;
    Label8: TLabel;
    edtLong: TEdit;
    Label9: TLabel;
    btnEdit: TButton;
    cefRequest: TCEFUrlRequestClientComponent;
    webview: TCEFWindowParent;
    Chromium: TChromium;
    procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtLatKeyPress(Sender: TObject; var Key: Char);
    procedure cefRequestCreateURLRequest(Sender: TObject);
    procedure cefRequestDownloadData(Sender: TObject;
      const request: ICefUrlRequest; data: Pointer; dataLength: Cardinal);
    procedure ChromiumResourceLoadComplete(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const response: ICefResponse;
      status: TCefUrlRequestStatus; receivedContentLength: Int64);
    procedure btnEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    mapLoaded:Boolean;
    imgFileName:string;
  procedure wmGeoSuccess(var message:TMessage);message WM_GEOSUCCESS;
  procedure wmMapLoaded(var message:TMessage);message WM_MAPLOADED;
  public
    mapsDir:string;
    htmlDir:string;

  end;
  procedure CreateGlobalCEFApp;

var
  frmMain: TfrmMain;

implementation

uses
  XMLDoc,XMLIntf,jpeg, Unit2;
{$R *.dfm}

procedure CreateGlobalCEFApp;
begin
  GlobalCEFApp:= TCefApplication.Create;
  GlobalCEFApp.FrameworkDirPath:=ExtractFilePath(ParamStr(0))+PathDelim+'bin';
  GlobalCEFApp.ResourcesDirPath:=GlobalCEFApp.FrameworkDirPath;
  GlobalCEFApp.LocalesDirPath:=GlobalCEFApp.FrameworkDirPath+PathDelim+'locales';
end;

procedure TfrmMain.wmMapLoaded;
var bitmap:TBitmap;
begin
 bitmap:=TBitmap.Create;
  try
   Chromium.TakeSnapshot(bitmap);
    with TJPEGImage.Create do
     try
     Assign(bitmap);
     SaveToFile(mapsDir+format('%s_%s.jpg',[edtLat.Text,edtLong.Text]));
     finally
     Free;
     end;
  finally
   bitmap.Free;
  end;
end;

procedure TfrmMain.wmGeoSuccess;
var temp:string;
begin
if (edtLat.Text<>'') and (edtLong.Text<>'') then
  begin
    imgFileName:=format('%s_%s.jpg',[edtLat.Text,edtLong.Text]);
    if not FileExists(mapsDir+imgFileName) then
    begin
     temp:=StringReplace(staticApiURL,'%center%',format('%s,%s',[edtLat.Text,edtLong.Text]),[rfIgnoreCase]);
     temp:=StringReplace(temp,'%zoom%','15',[rfIgnoreCase]);
     temp:=StringReplace(temp,'%size%',format('%dx%d',[webView.width,webView.Height]),[rfIgnoreCase]);
     temp:=StringReplace(temp,'%marker%',format('%s,%s',[edtLat.Text,edtLong.Text]),[rfIgnoreCase]);
     temp:=StringReplace(temp,'%mapType%',mapTypes[0],[rfIgnoreCase]);
     temp:=StringReplace(temp,'%apikey%',edtApi.text,[rfIgnoreCase]);
     Chromium.LoadURL(temp);
     mapLoaded:=True;
    end
    else
    begin
    Chromium.LoadURL(mapsDir+imgFileName);
    end;
    btnEdit.enabled:=True;
  end;
end;

procedure TfrmMain.btnLoadClick(Sender: TObject);
begin
  if edtApi.Text <>'' then
   begin
    if (edtLat.Text='') or (edtLong.Text='') then
      cefRequest.AddURLRequest
    else
    begin
    Perform(WM_GEOSUCCESS,0,0);
    end;
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
Chromium.CreateBrowser(webview);
mapsDir:=ExtractFilePath(Application.ExeName)+'maps'+PathDelim;
htmlDir:=ExtractFilePath(Application.ExeName)+'res'+PathDelim;
if not DirectoryExists(mapsDir) then
 CreateDir(mapsDir);

end;

procedure TfrmMain.edtLatKeyPress(Sender: TObject; var Key: Char);
begin
if  not (key in ['0'..'9','-','.']) then key :=#0
end;

procedure TfrmMain.cefRequestCreateURLRequest(Sender: TObject);
var req:ICEFRequest;
    temp:string;
begin
  temp:=Format('%s, %s, %s %s %s, %s',
     [
     edtLine1.text,
     edtLine2.text,
     edtSuburb.text,
     edtState.text,
     edtPostecode.text,
     edtCountry.text
     ]);
  if temp <>'' then
  begin
    req:=TCefRequestRef.New;
    req.Method:='GET';
    temp:=StringReplace(geoApiURL,'%address%',temp,[rfIgnoreCase]);
    temp:=StringReplace(temp,'%apikey%',edtApi.text,[rfIgnoreCase]);
    req.Url:=temp;
    TCefUrlRequestRef.New(req,cefRequest.Client,nil);
  end;
end;

procedure TfrmMain.cefRequestDownloadData(Sender: TObject;
  const request: ICefUrlRequest; data: Pointer; dataLength: Cardinal);
var xml:IXMLDocument;
    node:IXMLNode;
begin
  with TStringStream.Create('') do
    try
      WriteBuffer(Data^,dataLength);
      xml:=LoadXMLData(DataString);
      node:=xml.DocumentElement;
      node:=node.ChildNodes['result'];
      node:=node.ChildNodes['geometry'];
      node:=node.ChildNodes['location'];
      edtLat.Text:=node.ChildNodes['lat'].text;
      edtLong.text:=node.ChildNodes['lng'].text;
      perform(WM_GEOSUCCESS,0,0);
    finally
     free;
    end;

end;

procedure TfrmMain.ChromiumResourceLoadComplete(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; const response: ICefResponse;
  status: TCefUrlRequestStatus; receivedContentLength: Int64);
begin
if mapLoaded and (status=UR_SUCCESS) then
  begin
  Perform(WM_MAPLOADED,0,0);
  mapLoaded:=False;
  end;
end;

procedure TfrmMain.btnEditClick(Sender: TObject);
begin
 frmEdit.showModal;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
Chromium.CloseAllBrowsers;
end;

end.

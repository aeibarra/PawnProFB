// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Courses\Delphi\SOAP_Calculator\leadsonline.wsdl
//  >Import : C:\Courses\Delphi\SOAP_Calculator\leadsonline.wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (7/9/2025 2:17:19 PM - - $Rev: 116709 $)
// ************************************************************************ //

unit leadsonline;

interface

uses System.SysUtils, Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:base64Binary    - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  LoginInfo            = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  DoNotBuyInfo         = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  Response             = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  Ticket               = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  PropertyValue        = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  TicketKey            = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  Item2                = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  Customer2            = class;                 { "http://www.leadsonline.com/"[GblCplx] }
  Image                = class;                 { "http://www.leadsonline.com/"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "http://www.leadsonline.com/"[GblSmpl] }
  ItemType = (Other, Jewelry, Firearm);

  { "http://www.leadsonline.com/"[GblSmpl] }
  ImageType = (Jpeg, Png, Gif);

  { "http://www.leadsonline.com/"[GblSmpl] }
  TicketType = (
      Unknown, 
      Pawn, 
      Buy, 
      Trade, 
      CheckCashed, 
      Confiscate, 
      Consignment, 
      Extend, 
      Redeem, 
      Renew, 
      Sell
  );

  { "http://www.leadsonline.com/"[GblSmpl] }
  ImageCategory = (Customer, CustomerID, Thumbprint, Signature, Item);

  {$SCOPEDENUMS OFF}

  ArrayOfDoNotBuyInfo = array of DoNotBuyInfo;   { "http://www.leadsonline.com/"[GblCplx] }
  ArrayOfItem = array of Item2;                 { "http://www.leadsonline.com/"[GblCplx] }


  // ************************************************************************ //
  // XML       : LoginInfo, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  LoginInfo = class(TRemotable)
  private
    FstoreId: Integer;
    FuserName: string;
    FuserName_Specified: boolean;
    Fpassword: string;
    Fpassword_Specified: boolean;
    procedure SetuserName(Index: Integer; const Astring: string);
    function  userName_Specified(Index: Integer): boolean;
    procedure Setpassword(Index: Integer; const Astring: string);
    function  password_Specified(Index: Integer): boolean;
  published
    property storeId:  Integer  read FstoreId write FstoreId;
    property userName: string   Index (IS_OPTN) read FuserName write SetuserName stored userName_Specified;
    property password: string   Index (IS_OPTN) read Fpassword write Setpassword stored password_Specified;
  end;



  // ************************************************************************ //
  // XML       : DoNotBuyInfo, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  DoNotBuyInfo = class(TRemotable)
  private
    Fagency: string;
    Fagency_Specified: boolean;
    FID: string;
    FID_Specified: boolean;
    Fstate: string;
    Fstate_Specified: boolean;
    Fname_: string;
    Fname__Specified: boolean;
    Fdob: string;
    Fdob_Specified: boolean;
    FcontactName: string;
    FcontactName_Specified: boolean;
    FcontactNumber: string;
    FcontactNumber_Specified: boolean;
    procedure Setagency(Index: Integer; const Astring: string);
    function  agency_Specified(Index: Integer): boolean;
    procedure SetID(Index: Integer; const Astring: string);
    function  ID_Specified(Index: Integer): boolean;
    procedure Setstate(Index: Integer; const Astring: string);
    function  state_Specified(Index: Integer): boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Setdob(Index: Integer; const Astring: string);
    function  dob_Specified(Index: Integer): boolean;
    procedure SetcontactName(Index: Integer; const Astring: string);
    function  contactName_Specified(Index: Integer): boolean;
    procedure SetcontactNumber(Index: Integer; const Astring: string);
    function  contactNumber_Specified(Index: Integer): boolean;
  published
    property agency:        string  Index (IS_OPTN) read Fagency write Setagency stored agency_Specified;
    property ID:            string  Index (IS_OPTN) read FID write SetID stored ID_Specified;
    property state:         string  Index (IS_OPTN) read Fstate write Setstate stored state_Specified;
    property name_:         string  Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property dob:           string  Index (IS_OPTN) read Fdob write Setdob stored dob_Specified;
    property contactName:   string  Index (IS_OPTN) read FcontactName write SetcontactName stored contactName_Specified;
    property contactNumber: string  Index (IS_OPTN) read FcontactNumber write SetcontactNumber stored contactNumber_Specified;
  end;



  // ************************************************************************ //
  // XML       : Response, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  Response = class(TRemotable)
  private
    FerrorCode: Integer;
    FerrorResponse: string;
    FerrorResponse_Specified: boolean;
    procedure SeterrorResponse(Index: Integer; const Astring: string);
    function  errorResponse_Specified(Index: Integer): boolean;
  published
    property errorCode:     Integer  read FerrorCode write FerrorCode;
    property errorResponse: string   Index (IS_OPTN) read FerrorResponse write SeterrorResponse stored errorResponse_Specified;
  end;

  ArrayOfPropertyValue = array of PropertyValue;   { "http://www.leadsonline.com/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Ticket, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  Ticket = class(TRemotable)
  private
    Fkey: TicketKey;
    FredeemByDate: string;
    FredeemByDate_Specified: boolean;
    Fcustomer: Customer2;
    Fitems: ArrayOfItem;
    Fitems_Specified: boolean;
    FisVoid: Boolean;
    FextraTicket: ArrayOfPropertyValue;
    FextraTicket_Specified: boolean;
    procedure SetredeemByDate(Index: Integer; const Astring: string);
    function  redeemByDate_Specified(Index: Integer): boolean;
    procedure Setitems(Index: Integer; const AArrayOfItem: ArrayOfItem);
    function  items_Specified(Index: Integer): boolean;
    procedure SetextraTicket(Index: Integer; const AArrayOfPropertyValue: ArrayOfPropertyValue);
    function  extraTicket_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property key:          TicketKey             read Fkey write Fkey;
    property redeemByDate: string                Index (IS_OPTN) read FredeemByDate write SetredeemByDate stored redeemByDate_Specified;
    property customer:     Customer2             read Fcustomer write Fcustomer;
    property items:        ArrayOfItem           Index (IS_OPTN) read Fitems write Setitems stored items_Specified;
    property isVoid:       Boolean               read FisVoid write FisVoid;
    property extraTicket:  ArrayOfPropertyValue  Index (IS_OPTN) read FextraTicket write SetextraTicket stored extraTicket_Specified;
  end;



  // ************************************************************************ //
  // XML       : PropertyValue, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  PropertyValue = class(TRemotable)
  private
    FName_: string;
    FName__Specified: boolean;
    FValue: string;
    FValue_Specified: boolean;
    procedure SetName_(Index: Integer; const Astring: string);
    function  Name__Specified(Index: Integer): boolean;
    procedure SetValue(Index: Integer; const Astring: string);
    function  Value_Specified(Index: Integer): boolean;
  published
    property Name_: string  Index (IS_OPTN) read FName_ write SetName_ stored Name__Specified;
    property Value: string  Index (IS_OPTN) read FValue write SetValue stored Value_Specified;
  end;



  // ************************************************************************ //
  // XML       : TicketKey, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  TicketKey = class(TRemotable)
  private
    FticketType: TicketType;
    Fticketnumber: string;
    Fticketnumber_Specified: boolean;
    FticketDateTime: string;
    FticketDateTime_Specified: boolean;
    procedure Setticketnumber(Index: Integer; const Astring: string);
    function  ticketnumber_Specified(Index: Integer): boolean;
    procedure SetticketDateTime(Index: Integer; const Astring: string);
    function  ticketDateTime_Specified(Index: Integer): boolean;
  published
    property ticketType:     TicketType  read FticketType write FticketType;
    property ticketnumber:   string      Index (IS_OPTN) read Fticketnumber write Setticketnumber stored ticketnumber_Specified;
    property ticketDateTime: string      Index (IS_OPTN) read FticketDateTime write SetticketDateTime stored ticketDateTime_Specified;
  end;

  ArrayOfImage = array of Image;                { "http://www.leadsonline.com/"[GblCplx] }


  // ************************************************************************ //
  // XML       : Item, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  Item2 = class(TRemotable)
  private
    Fmake: string;
    Fmake_Specified: boolean;
    Fmodel: string;
    Fmodel_Specified: boolean;
    FserialNumber: string;
    FserialNumber_Specified: boolean;
    Fdescription: string;
    Fdescription_Specified: boolean;
    Famount: Double;
    FitemType: ItemType;
    FitemStatus: string;
    FitemStatus_Specified: boolean;
    Fimages: ArrayOfImage;
    Fimages_Specified: boolean;
    FisVoid: Boolean;
    Femployee: string;
    Femployee_Specified: boolean;
    FextraItem: ArrayOfPropertyValue;
    FextraItem_Specified: boolean;
    procedure Setmake(Index: Integer; const Astring: string);
    function  make_Specified(Index: Integer): boolean;
    procedure Setmodel(Index: Integer; const Astring: string);
    function  model_Specified(Index: Integer): boolean;
    procedure SetserialNumber(Index: Integer; const Astring: string);
    function  serialNumber_Specified(Index: Integer): boolean;
    procedure Setdescription(Index: Integer; const Astring: string);
    function  description_Specified(Index: Integer): boolean;
    procedure SetitemStatus(Index: Integer; const Astring: string);
    function  itemStatus_Specified(Index: Integer): boolean;
    procedure Setimages(Index: Integer; const AArrayOfImage: ArrayOfImage);
    function  images_Specified(Index: Integer): boolean;
    procedure Setemployee(Index: Integer; const Astring: string);
    function  employee_Specified(Index: Integer): boolean;
    procedure SetextraItem(Index: Integer; const AArrayOfPropertyValue: ArrayOfPropertyValue);
    function  extraItem_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property make:         string                Index (IS_OPTN) read Fmake write Setmake stored make_Specified;
    property model:        string                Index (IS_OPTN) read Fmodel write Setmodel stored model_Specified;
    property serialNumber: string                Index (IS_OPTN) read FserialNumber write SetserialNumber stored serialNumber_Specified;
    property description:  string                Index (IS_OPTN) read Fdescription write Setdescription stored description_Specified;
    property amount:       Double                read Famount write Famount;
    property itemType:     ItemType              read FitemType write FitemType;
    property itemStatus:   string                Index (IS_OPTN) read FitemStatus write SetitemStatus stored itemStatus_Specified;
    property images:       ArrayOfImage          Index (IS_OPTN) read Fimages write Setimages stored images_Specified;
    property isVoid:       Boolean               read FisVoid write FisVoid;
    property employee:     string                Index (IS_OPTN) read Femployee write Setemployee stored employee_Specified;
    property extraItem:    ArrayOfPropertyValue  Index (IS_OPTN) read FextraItem write SetextraItem stored extraItem_Specified;
  end;



  // ************************************************************************ //
  // XML       : Customer, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  Customer2 = class(TRemotable)
  private
    Fname_: string;
    Fname__Specified: boolean;
    Ffname: string;
    Ffname_Specified: boolean;
    Flname: string;
    Flname_Specified: boolean;
    Faddress1: string;
    Faddress1_Specified: boolean;
    Faddress2: string;
    Faddress2_Specified: boolean;
    Fcity: string;
    Fcity_Specified: boolean;
    Fstate: string;
    Fstate_Specified: boolean;
    FpostalCode: string;
    FpostalCode_Specified: boolean;
    Fphone: string;
    Fphone_Specified: boolean;
    FidType: string;
    FidType_Specified: boolean;
    FidNumber: string;
    FidNumber_Specified: boolean;
    FidType2: string;
    FidType2_Specified: boolean;
    FidNumber2: string;
    FidNumber2_Specified: boolean;
    Fdob: string;
    Fdob_Specified: boolean;
    Fweight: Integer;
    Fheight: Integer;
    FeyeColor: string;
    FeyeColor_Specified: boolean;
    FhairColor: string;
    FhairColor_Specified: boolean;
    Frace: string;
    Frace_Specified: boolean;
    Fsex: string;
    Fsex_Specified: boolean;
    Fremarks: string;
    Fremarks_Specified: boolean;
    Fimages: ArrayOfImage;
    Fimages_Specified: boolean;
    FextraCustomer: ArrayOfPropertyValue;
    FextraCustomer_Specified: boolean;
    procedure Setname_(Index: Integer; const Astring: string);
    function  name__Specified(Index: Integer): boolean;
    procedure Setfname(Index: Integer; const Astring: string);
    function  fname_Specified(Index: Integer): boolean;
    procedure Setlname(Index: Integer; const Astring: string);
    function  lname_Specified(Index: Integer): boolean;
    procedure Setaddress1(Index: Integer; const Astring: string);
    function  address1_Specified(Index: Integer): boolean;
    procedure Setaddress2(Index: Integer; const Astring: string);
    function  address2_Specified(Index: Integer): boolean;
    procedure Setcity(Index: Integer; const Astring: string);
    function  city_Specified(Index: Integer): boolean;
    procedure Setstate(Index: Integer; const Astring: string);
    function  state_Specified(Index: Integer): boolean;
    procedure SetpostalCode(Index: Integer; const Astring: string);
    function  postalCode_Specified(Index: Integer): boolean;
    procedure Setphone(Index: Integer; const Astring: string);
    function  phone_Specified(Index: Integer): boolean;
    procedure SetidType(Index: Integer; const Astring: string);
    function  idType_Specified(Index: Integer): boolean;
    procedure SetidNumber(Index: Integer; const Astring: string);
    function  idNumber_Specified(Index: Integer): boolean;
    procedure SetidType2(Index: Integer; const Astring: string);
    function  idType2_Specified(Index: Integer): boolean;
    procedure SetidNumber2(Index: Integer; const Astring: string);
    function  idNumber2_Specified(Index: Integer): boolean;
    procedure Setdob(Index: Integer; const Astring: string);
    function  dob_Specified(Index: Integer): boolean;
    procedure SeteyeColor(Index: Integer; const Astring: string);
    function  eyeColor_Specified(Index: Integer): boolean;
    procedure SethairColor(Index: Integer; const Astring: string);
    function  hairColor_Specified(Index: Integer): boolean;
    procedure Setrace(Index: Integer; const Astring: string);
    function  race_Specified(Index: Integer): boolean;
    procedure Setsex(Index: Integer; const Astring: string);
    function  sex_Specified(Index: Integer): boolean;
    procedure Setremarks(Index: Integer; const Astring: string);
    function  remarks_Specified(Index: Integer): boolean;
    procedure Setimages(Index: Integer; const AArrayOfImage: ArrayOfImage);
    function  images_Specified(Index: Integer): boolean;
    procedure SetextraCustomer(Index: Integer; const AArrayOfPropertyValue: ArrayOfPropertyValue);
    function  extraCustomer_Specified(Index: Integer): boolean;
  public
    destructor Destroy; override;
  published
    property name_:         string                Index (IS_OPTN) read Fname_ write Setname_ stored name__Specified;
    property fname:         string                Index (IS_OPTN) read Ffname write Setfname stored fname_Specified;
    property lname:         string                Index (IS_OPTN) read Flname write Setlname stored lname_Specified;
    property address1:      string                Index (IS_OPTN) read Faddress1 write Setaddress1 stored address1_Specified;
    property address2:      string                Index (IS_OPTN) read Faddress2 write Setaddress2 stored address2_Specified;
    property city:          string                Index (IS_OPTN) read Fcity write Setcity stored city_Specified;
    property state:         string                Index (IS_OPTN) read Fstate write Setstate stored state_Specified;
    property postalCode:    string                Index (IS_OPTN) read FpostalCode write SetpostalCode stored postalCode_Specified;
    property phone:         string                Index (IS_OPTN) read Fphone write Setphone stored phone_Specified;
    property idType:        string                Index (IS_OPTN) read FidType write SetidType stored idType_Specified;
    property idNumber:      string                Index (IS_OPTN) read FidNumber write SetidNumber stored idNumber_Specified;
    property idType2:       string                Index (IS_OPTN) read FidType2 write SetidType2 stored idType2_Specified;
    property idNumber2:     string                Index (IS_OPTN) read FidNumber2 write SetidNumber2 stored idNumber2_Specified;
    property dob:           string                Index (IS_OPTN) read Fdob write Setdob stored dob_Specified;
    property weight:        Integer               read Fweight write Fweight;
    property height:        Integer               read Fheight write Fheight;
    property eyeColor:      string                Index (IS_OPTN) read FeyeColor write SeteyeColor stored eyeColor_Specified;
    property hairColor:     string                Index (IS_OPTN) read FhairColor write SethairColor stored hairColor_Specified;
    property race:          string                Index (IS_OPTN) read Frace write Setrace stored race_Specified;
    property sex:           string                Index (IS_OPTN) read Fsex write Setsex stored sex_Specified;
    property remarks:       string                Index (IS_OPTN) read Fremarks write Setremarks stored remarks_Specified;
    property images:        ArrayOfImage          Index (IS_OPTN) read Fimages write Setimages stored images_Specified;
    property extraCustomer: ArrayOfPropertyValue  Index (IS_OPTN) read FextraCustomer write SetextraCustomer stored extraCustomer_Specified;
  end;



  // ************************************************************************ //
  // XML       : Image, global, <complexType>
  // Namespace : http://www.leadsonline.com/
  // ************************************************************************ //
  Image = class(TRemotable)
  private
    FimageCategory: ImageCategory;
    FimageType: ImageType;
    FimageData: TBytes;
    FimageData_Specified: boolean;
    procedure SetimageData(Index: Integer; const ATByteArray: TBytes);
    function  imageData_Specified(Index: Integer): boolean;
  published
    property imageCategory: ImageCategory   read FimageCategory write FimageCategory;
    property imageType:     ImageType       read FimageType write FimageType;
    property imageData:     TBytes  Index (IS_OPTN) read FimageData write SetimageData stored imageData_Specified;
  end;


  // ************************************************************************ //
  // Namespace : http://www.leadsonline.com/
  // soapAction: http://www.leadsonline.com/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : ticketWSSoap
  // service   : ticketWS
  // port      : ticketWSSoap
  // URL       : https://sandbox.leadsonline.com/leads/ws/pawn/ticketWS.asmx
  // ************************************************************************ //
  ticketWSSoap = interface(IInvokable)
  ['{B10B1414-68EA-7EC2-E906-0050DA4E695C}']
    function  CheckLogin(const login: LoginInfo): Response; stdcall;
    function  SubmitTransaction(const login: LoginInfo; const ticket: Ticket): Response; stdcall;
    function  UpdateTransaction(const login: LoginInfo; const oldTicket: TicketKey; const ticket: Ticket): Response; stdcall;
    function  CheckDoNotBuy(const login: LoginInfo; const state: string; const ID: string): ArrayOfDoNotBuyInfo; stdcall;
    function  CheckDoNotBuy2(const login: LoginInfo; const ID: string; const Name_: string; const BirthDate: string): ArrayOfDoNotBuyInfo; stdcall;
    function  UploadImage(const login: LoginInfo; const ticketKey: TicketKey; const img: Image; const itemIndex: Integer): Response; stdcall;
    function  DeleteImage(const login: LoginInfo; const ticketKey: TicketKey; const imageCategory: ImageCategory; const itemIndex: Integer; const filename: string): Response; stdcall;
    function  SetNoTransactionDayForStore(const login: LoginInfo; const TransactionDate: string): Response; stdcall;
  end;

function GetticketWSSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ticketWSSoap;


implementation

function GetticketWSSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ticketWSSoap;
const
  defWSDL = 'C:\Courses\Delphi\SOAP_Calculator\leadsonline.wsdl';
  defURL  = 'https://sandbox.leadsonline.com/leads/ws/pawn/ticketWS.asmx';
  defSvc  = 'ticketWS';
  defPrt  = 'ticketWSSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ticketWSSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure LoginInfo.SetuserName(Index: Integer; const Astring: string);
begin
  FuserName := Astring;
  FuserName_Specified := True;
end;

function LoginInfo.userName_Specified(Index: Integer): boolean;
begin
  Result := FuserName_Specified;
end;

procedure LoginInfo.Setpassword(Index: Integer; const Astring: string);
begin
  Fpassword := Astring;
  Fpassword_Specified := True;
end;

function LoginInfo.password_Specified(Index: Integer): boolean;
begin
  Result := Fpassword_Specified;
end;

procedure DoNotBuyInfo.Setagency(Index: Integer; const Astring: string);
begin
  Fagency := Astring;
  Fagency_Specified := True;
end;

function DoNotBuyInfo.agency_Specified(Index: Integer): boolean;
begin
  Result := Fagency_Specified;
end;

procedure DoNotBuyInfo.SetID(Index: Integer; const Astring: string);
begin
  FID := Astring;
  FID_Specified := True;
end;

function DoNotBuyInfo.ID_Specified(Index: Integer): boolean;
begin
  Result := FID_Specified;
end;

procedure DoNotBuyInfo.Setstate(Index: Integer; const Astring: string);
begin
  Fstate := Astring;
  Fstate_Specified := True;
end;

function DoNotBuyInfo.state_Specified(Index: Integer): boolean;
begin
  Result := Fstate_Specified;
end;

procedure DoNotBuyInfo.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function DoNotBuyInfo.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure DoNotBuyInfo.Setdob(Index: Integer; const Astring: string);
begin
  Fdob := Astring;
  Fdob_Specified := True;
end;

function DoNotBuyInfo.dob_Specified(Index: Integer): boolean;
begin
  Result := Fdob_Specified;
end;

procedure DoNotBuyInfo.SetcontactName(Index: Integer; const Astring: string);
begin
  FcontactName := Astring;
  FcontactName_Specified := True;
end;

function DoNotBuyInfo.contactName_Specified(Index: Integer): boolean;
begin
  Result := FcontactName_Specified;
end;

procedure DoNotBuyInfo.SetcontactNumber(Index: Integer; const Astring: string);
begin
  FcontactNumber := Astring;
  FcontactNumber_Specified := True;
end;

function DoNotBuyInfo.contactNumber_Specified(Index: Integer): boolean;
begin
  Result := FcontactNumber_Specified;
end;

procedure Response.SeterrorResponse(Index: Integer; const Astring: string);
begin
  FerrorResponse := Astring;
  FerrorResponse_Specified := True;
end;

function Response.errorResponse_Specified(Index: Integer): boolean;
begin
  Result := FerrorResponse_Specified;
end;

destructor Ticket.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fitems)-1 do
    System.SysUtils.FreeAndNil(Fitems[I]);
  System.SetLength(Fitems, 0);
  for I := 0 to System.Length(FextraTicket)-1 do
    System.SysUtils.FreeAndNil(FextraTicket[I]);
  System.SetLength(FextraTicket, 0);
  System.SysUtils.FreeAndNil(Fkey);
  System.SysUtils.FreeAndNil(Fcustomer);
  inherited Destroy;
end;

procedure Ticket.SetredeemByDate(Index: Integer; const Astring: string);
begin
  FredeemByDate := Astring;
  FredeemByDate_Specified := True;
end;

function Ticket.redeemByDate_Specified(Index: Integer): boolean;
begin
  Result := FredeemByDate_Specified;
end;

procedure Ticket.Setitems(Index: Integer; const AArrayOfItem: ArrayOfItem);
begin
  Fitems := AArrayOfItem;
  Fitems_Specified := True;
end;

function Ticket.items_Specified(Index: Integer): boolean;
begin
  Result := Fitems_Specified;
end;

procedure Ticket.SetextraTicket(Index: Integer; const AArrayOfPropertyValue: ArrayOfPropertyValue);
begin
  FextraTicket := AArrayOfPropertyValue;
  FextraTicket_Specified := True;
end;

function Ticket.extraTicket_Specified(Index: Integer): boolean;
begin
  Result := FextraTicket_Specified;
end;

procedure PropertyValue.SetName_(Index: Integer; const Astring: string);
begin
  FName_ := Astring;
  FName__Specified := True;
end;

function PropertyValue.Name__Specified(Index: Integer): boolean;
begin
  Result := FName__Specified;
end;

procedure PropertyValue.SetValue(Index: Integer; const Astring: string);
begin
  FValue := Astring;
  FValue_Specified := True;
end;

function PropertyValue.Value_Specified(Index: Integer): boolean;
begin
  Result := FValue_Specified;
end;

procedure TicketKey.Setticketnumber(Index: Integer; const Astring: string);
begin
  Fticketnumber := Astring;
  Fticketnumber_Specified := True;
end;

function TicketKey.ticketnumber_Specified(Index: Integer): boolean;
begin
  Result := Fticketnumber_Specified;
end;

procedure TicketKey.SetticketDateTime(Index: Integer; const Astring: string);
begin
  FticketDateTime := Astring;
  FticketDateTime_Specified := True;
end;

function TicketKey.ticketDateTime_Specified(Index: Integer): boolean;
begin
  Result := FticketDateTime_Specified;
end;

destructor Item2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fimages)-1 do
    System.SysUtils.FreeAndNil(Fimages[I]);
  System.SetLength(Fimages, 0);
  for I := 0 to System.Length(FextraItem)-1 do
    System.SysUtils.FreeAndNil(FextraItem[I]);
  System.SetLength(FextraItem, 0);
  inherited Destroy;
end;

procedure Item2.Setmake(Index: Integer; const Astring: string);
begin
  Fmake := Astring;
  Fmake_Specified := True;
end;

function Item2.make_Specified(Index: Integer): boolean;
begin
  Result := Fmake_Specified;
end;

procedure Item2.Setmodel(Index: Integer; const Astring: string);
begin
  Fmodel := Astring;
  Fmodel_Specified := True;
end;

function Item2.model_Specified(Index: Integer): boolean;
begin
  Result := Fmodel_Specified;
end;

procedure Item2.SetserialNumber(Index: Integer; const Astring: string);
begin
  FserialNumber := Astring;
  FserialNumber_Specified := True;
end;

function Item2.serialNumber_Specified(Index: Integer): boolean;
begin
  Result := FserialNumber_Specified;
end;

procedure Item2.Setdescription(Index: Integer; const Astring: string);
begin
  Fdescription := Astring;
  Fdescription_Specified := True;
end;

function Item2.description_Specified(Index: Integer): boolean;
begin
  Result := Fdescription_Specified;
end;

procedure Item2.SetitemStatus(Index: Integer; const Astring: string);
begin
  FitemStatus := Astring;
  FitemStatus_Specified := True;
end;

function Item2.itemStatus_Specified(Index: Integer): boolean;
begin
  Result := FitemStatus_Specified;
end;

procedure Item2.Setimages(Index: Integer; const AArrayOfImage: ArrayOfImage);
begin
  Fimages := AArrayOfImage;
  Fimages_Specified := True;
end;

function Item2.images_Specified(Index: Integer): boolean;
begin
  Result := Fimages_Specified;
end;

procedure Item2.Setemployee(Index: Integer; const Astring: string);
begin
  Femployee := Astring;
  Femployee_Specified := True;
end;

function Item2.employee_Specified(Index: Integer): boolean;
begin
  Result := Femployee_Specified;
end;

procedure Item2.SetextraItem(Index: Integer; const AArrayOfPropertyValue: ArrayOfPropertyValue);
begin
  FextraItem := AArrayOfPropertyValue;
  FextraItem_Specified := True;
end;

function Item2.extraItem_Specified(Index: Integer): boolean;
begin
  Result := FextraItem_Specified;
end;

destructor Customer2.Destroy;
var
  I: Integer;
begin
  for I := 0 to System.Length(Fimages)-1 do
    System.SysUtils.FreeAndNil(Fimages[I]);
  System.SetLength(Fimages, 0);
  for I := 0 to System.Length(FextraCustomer)-1 do
    System.SysUtils.FreeAndNil(FextraCustomer[I]);
  System.SetLength(FextraCustomer, 0);
  inherited Destroy;
end;

procedure Customer2.Setname_(Index: Integer; const Astring: string);
begin
  Fname_ := Astring;
  Fname__Specified := True;
end;

function Customer2.name__Specified(Index: Integer): boolean;
begin
  Result := Fname__Specified;
end;

procedure Customer2.Setfname(Index: Integer; const Astring: string);
begin
  Ffname := Astring;
  Ffname_Specified := True;
end;

function Customer2.fname_Specified(Index: Integer): boolean;
begin
  Result := Ffname_Specified;
end;

procedure Customer2.Setlname(Index: Integer; const Astring: string);
begin
  Flname := Astring;
  Flname_Specified := True;
end;

function Customer2.lname_Specified(Index: Integer): boolean;
begin
  Result := Flname_Specified;
end;

procedure Customer2.Setaddress1(Index: Integer; const Astring: string);
begin
  Faddress1 := Astring;
  Faddress1_Specified := True;
end;

function Customer2.address1_Specified(Index: Integer): boolean;
begin
  Result := Faddress1_Specified;
end;

procedure Customer2.Setaddress2(Index: Integer; const Astring: string);
begin
  Faddress2 := Astring;
  Faddress2_Specified := True;
end;

function Customer2.address2_Specified(Index: Integer): boolean;
begin
  Result := Faddress2_Specified;
end;

procedure Customer2.Setcity(Index: Integer; const Astring: string);
begin
  Fcity := Astring;
  Fcity_Specified := True;
end;

function Customer2.city_Specified(Index: Integer): boolean;
begin
  Result := Fcity_Specified;
end;

procedure Customer2.Setstate(Index: Integer; const Astring: string);
begin
  Fstate := Astring;
  Fstate_Specified := True;
end;

function Customer2.state_Specified(Index: Integer): boolean;
begin
  Result := Fstate_Specified;
end;

procedure Customer2.SetpostalCode(Index: Integer; const Astring: string);
begin
  FpostalCode := Astring;
  FpostalCode_Specified := True;
end;

function Customer2.postalCode_Specified(Index: Integer): boolean;
begin
  Result := FpostalCode_Specified;
end;

procedure Customer2.Setphone(Index: Integer; const Astring: string);
begin
  Fphone := Astring;
  Fphone_Specified := True;
end;

function Customer2.phone_Specified(Index: Integer): boolean;
begin
  Result := Fphone_Specified;
end;

procedure Customer2.SetidType(Index: Integer; const Astring: string);
begin
  FidType := Astring;
  FidType_Specified := True;
end;

function Customer2.idType_Specified(Index: Integer): boolean;
begin
  Result := FidType_Specified;
end;

procedure Customer2.SetidNumber(Index: Integer; const Astring: string);
begin
  FidNumber := Astring;
  FidNumber_Specified := True;
end;

function Customer2.idNumber_Specified(Index: Integer): boolean;
begin
  Result := FidNumber_Specified;
end;

procedure Customer2.SetidType2(Index: Integer; const Astring: string);
begin
  FidType2 := Astring;
  FidType2_Specified := True;
end;

function Customer2.idType2_Specified(Index: Integer): boolean;
begin
  Result := FidType2_Specified;
end;

procedure Customer2.SetidNumber2(Index: Integer; const Astring: string);
begin
  FidNumber2 := Astring;
  FidNumber2_Specified := True;
end;

function Customer2.idNumber2_Specified(Index: Integer): boolean;
begin
  Result := FidNumber2_Specified;
end;

procedure Customer2.Setdob(Index: Integer; const Astring: string);
begin
  Fdob := Astring;
  Fdob_Specified := True;
end;

function Customer2.dob_Specified(Index: Integer): boolean;
begin
  Result := Fdob_Specified;
end;

procedure Customer2.SeteyeColor(Index: Integer; const Astring: string);
begin
  FeyeColor := Astring;
  FeyeColor_Specified := True;
end;

function Customer2.eyeColor_Specified(Index: Integer): boolean;
begin
  Result := FeyeColor_Specified;
end;

procedure Customer2.SethairColor(Index: Integer; const Astring: string);
begin
  FhairColor := Astring;
  FhairColor_Specified := True;
end;

function Customer2.hairColor_Specified(Index: Integer): boolean;
begin
  Result := FhairColor_Specified;
end;

procedure Customer2.Setrace(Index: Integer; const Astring: string);
begin
  Frace := Astring;
  Frace_Specified := True;
end;

function Customer2.race_Specified(Index: Integer): boolean;
begin
  Result := Frace_Specified;
end;

procedure Customer2.Setsex(Index: Integer; const Astring: string);
begin
  Fsex := Astring;
  Fsex_Specified := True;
end;

function Customer2.sex_Specified(Index: Integer): boolean;
begin
  Result := Fsex_Specified;
end;

procedure Customer2.Setremarks(Index: Integer; const Astring: string);
begin
  Fremarks := Astring;
  Fremarks_Specified := True;
end;

function Customer2.remarks_Specified(Index: Integer): boolean;
begin
  Result := Fremarks_Specified;
end;

procedure Customer2.Setimages(Index: Integer; const AArrayOfImage: ArrayOfImage);
begin
  Fimages := AArrayOfImage;
  Fimages_Specified := True;
end;

function Customer2.images_Specified(Index: Integer): boolean;
begin
  Result := Fimages_Specified;
end;

procedure Customer2.SetextraCustomer(Index: Integer; const AArrayOfPropertyValue: ArrayOfPropertyValue);
begin
  FextraCustomer := AArrayOfPropertyValue;
  FextraCustomer_Specified := True;
end;

function Customer2.extraCustomer_Specified(Index: Integer): boolean;
begin
  Result := FextraCustomer_Specified;
end;

procedure Image.SetimageData(Index: Integer; const ATByteArray: TBytes);
begin
  FimageData := ATByteArray;
  FimageData_Specified := True;
end;

function Image.imageData_Specified(Index: Integer): boolean;
begin
  Result := FimageData_Specified;
end;

initialization
  { ticketWSSoap }
  InvRegistry.RegisterInterface(TypeInfo(ticketWSSoap), 'http://www.leadsonline.com/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ticketWSSoap), 'http://www.leadsonline.com/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ticketWSSoap), ioDocument);
  { ticketWSSoap.CheckLogin }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'CheckLogin', '',
                                 '[ReturnName="CheckLoginResult"]');
  { ticketWSSoap.SubmitTransaction }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'SubmitTransaction', '',
                                 '[ReturnName="SubmitTransactionResult"]');
  { ticketWSSoap.UpdateTransaction }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'UpdateTransaction', '',
                                 '[ReturnName="UpdateTransactionResult"]');
  { ticketWSSoap.CheckDoNotBuy }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'CheckDoNotBuy', '',
                                 '[ReturnName="CheckDoNotBuyResult"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ticketWSSoap), 'CheckDoNotBuy', 'CheckDoNotBuyResult', '',
                                '[ArrayItemName="DoNotBuyInfo"]');
  { ticketWSSoap.CheckDoNotBuy2 }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'CheckDoNotBuy2', '',
                                 '[ReturnName="CheckDoNotBuy2Result"]', IS_OPTN);
  InvRegistry.RegisterParamInfo(TypeInfo(ticketWSSoap), 'CheckDoNotBuy2', 'Name_', 'Name', '');
  InvRegistry.RegisterParamInfo(TypeInfo(ticketWSSoap), 'CheckDoNotBuy2', 'CheckDoNotBuy2Result', '',
                                '[ArrayItemName="DoNotBuyInfo"]');
  { ticketWSSoap.UploadImage }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'UploadImage', '',
                                 '[ReturnName="UploadImageResult"]');
  { ticketWSSoap.DeleteImage }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'DeleteImage', '',
                                 '[ReturnName="DeleteImageResult"]');
  { ticketWSSoap.SetNoTransactionDayForStore }
  InvRegistry.RegisterMethodInfo(TypeInfo(ticketWSSoap), 'SetNoTransactionDayForStore', '',
                                 '[ReturnName="SetNoTransactionDayForStoreResult"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ItemType), 'http://www.leadsonline.com/', 'ItemType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfDoNotBuyInfo), 'http://www.leadsonline.com/', 'ArrayOfDoNotBuyInfo');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfItem), 'http://www.leadsonline.com/', 'ArrayOfItem');
  RemClassRegistry.RegisterXSClass(LoginInfo, 'http://www.leadsonline.com/', 'LoginInfo');
  RemClassRegistry.RegisterXSClass(DoNotBuyInfo, 'http://www.leadsonline.com/', 'DoNotBuyInfo');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(DoNotBuyInfo), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterXSClass(Response, 'http://www.leadsonline.com/', 'Response');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfPropertyValue), 'http://www.leadsonline.com/', 'ArrayOfPropertyValue');
  RemClassRegistry.RegisterXSClass(Ticket, 'http://www.leadsonline.com/', 'Ticket');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Ticket), 'items', '[ArrayItemName="Item"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Ticket), 'extraTicket', '[ArrayItemName="PropertyValue"]');
  RemClassRegistry.RegisterXSClass(PropertyValue, 'http://www.leadsonline.com/', 'PropertyValue');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(PropertyValue), 'Name_', '[ExtName="Name"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ImageType), 'http://www.leadsonline.com/', 'ImageType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TicketType), 'http://www.leadsonline.com/', 'TicketType');
  RemClassRegistry.RegisterXSClass(TicketKey, 'http://www.leadsonline.com/', 'TicketKey');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOfImage), 'http://www.leadsonline.com/', 'ArrayOfImage');
  RemClassRegistry.RegisterXSClass(Item2, 'http://www.leadsonline.com/', 'Item2', 'Item');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Item2), 'images', '[ArrayItemName="Image"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Item2), 'extraItem', '[ArrayItemName="PropertyValue"]');
  RemClassRegistry.RegisterXSClass(Customer2, 'http://www.leadsonline.com/', 'Customer2', 'Customer');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Customer2), 'name_', '[ExtName="name"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Customer2), 'images', '[ArrayItemName="Image"]');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Customer2), 'extraCustomer', '[ArrayItemName="PropertyValue"]');
  RemClassRegistry.RegisterXSInfo(TypeInfo(ImageCategory), 'http://www.leadsonline.com/', 'ImageCategory');
  RemClassRegistry.RegisterXSClass(Image, 'http://www.leadsonline.com/', 'Image');

end.
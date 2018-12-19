object TarifFrm: TTarifFrm
  Left = 0
  Top = 0
  Caption = #1058#1080#1087#1099' '#1074#1099#1087#1083#1072#1090
  ClientHeight = 337
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClient: TPanel
    Left = 0
    Top = 41
    Width = 584
    Height = 296
    Align = alClient
    TabOrder = 0
    object DBGridEh1: TDBGridEh
      Left = 1
      Top = 1
      Width = 582
      Height = 294
      Align = alClient
      DataSource = dsTarif
      DynProps = <>
      Flat = True
      IndicatorOptions = [gioShowRowIndicatorEh]
      TabOrder = 0
      TitleParams.MultiTitle = True
      OnExit = DBGridEh1Exit
      OnKeyDown = DBGridEh1KeyDown
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'typeid'
          Footers = <>
          Visible = False
          Width = 35
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'NameType'
          Footers = <>
          Title.Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077
          Width = 235
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'tarif_gkh'
          Footers = <>
          Title.Caption = #1058#1072#1088#1080#1092
          Width = 68
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'HasPokaz'
          Footers = <>
          Title.Caption = #1045#1089#1090#1100' '#1089#1095#1077#1090#1095#1080#1082
          Title.Orientation = tohVertical
          Width = 21
        end
        item
          Checkboxes = True
          DynProps = <>
          EditButtons = <>
          FieldName = 'notinuse'
          Footers = <>
          Title.Caption = #1091#1076#1072#1083#1077#1085#1086
          Title.Orientation = tohVertical
          Width = 22
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'ColColor'
          Footers = <>
          Title.Caption = #1062#1074#1077#1090' '#1092#1086#1085#1072' $000000'
          Width = 131
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 41
    Align = alTop
    TabOrder = 1
    object btnAdd: TBitBtn
      Left = 4
      Top = 5
      Width = 192
      Height = 30
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1090#1080#1087' '#1074#1099#1087#1083#1072#1090#1099
      Glyph.Data = {
        D6020000424DD6020000000000003600000028000000100000000E0000000100
        180000000000A0020000C40E0000C40E00000000000000000000C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3CDD6CD4A6C4A446944446A44497149C2CEC2C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C33B653B3E883903
        A7141BBF2A3FC04E537D54C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C33B653B3A8A360BAB1B24C43342CC51538053C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C33B663B3A91370B
        AB1B24C43342CE51538153C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C33E6A3E399D3802A01218B8273ACA4A578457C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3496B49127B19117B1911831A11861A259D304FCB5000
        7F08019F0F5DD06756BD5E48B95149B85248AC5049A54F678B6A41674200700A
        00880D10AE1F17B6261DB72B21B32F319E3C3691403CB04744BB4F53C55E57C7
        6259C2645EC168557555416842008B0B06A8152ACA393CD54A53DA6051D35E3C
        B9483BA145449B4C48A75151B55B55B65F5EB16667B16E557055446B469FD9A4
        AAE1AEB8F0BDBFF5C4C2F6C890EF975ED36A4FC15B84C48678B97CB8D7BBB9D6
        BCBBD2BDBED5C0677768C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3688D685AD06471
        DC7B62CB6B5CA160587D58C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C362896258C96173DA7D66CA6F5D9E60537853C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C362876252B35A6F
        CE786CBD74639D66537753C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C36285624F9D547AB9817FB6856A996B537453C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C5D0C56E8D704E
        71504E6E50788A79BBC6BBC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3}
      TabOrder = 0
      OnClick = btnAddClick
    end
  end
  object QueryTarif: TFDQuery
    BeforeDelete = QueryTarifBeforeDelete
    Connection = MainFrm.MainConnection
    Transaction = MainFrm.FDTransactionMain
    UpdateObject = FDUpdateTarif
    SQL.Strings = (
      
        'select typeid,nametype,tarif_gkh,HasPokaz,notinuse,ColColor from' +
        ' Type_gkh')
    Left = 72
    Top = 89
    object QueryTariftypeid: TFDAutoIncField
      FieldName = 'typeid'
      Origin = 'typeid'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QueryTarifNameType: TStringField
      FieldName = 'NameType'
      Origin = 'NameType'
      Required = True
      Size = 255
    end
    object QueryTariftarif_gkh: TBCDField
      FieldName = 'tarif_gkh'
      Origin = 'tarif_gkh'
      Required = True
      Precision = 15
      Size = 2
    end
    object QueryTarifHasPokaz: TBooleanField
      FieldName = 'HasPokaz'
      Origin = 'HasPokaz'
      Required = True
    end
    object QueryTarifnotinuse: TIntegerField
      FieldName = 'notinuse'
      Origin = 'notinuse'
      Required = True
    end
    object QueryTarifColColor: TStringField
      FieldName = 'ColColor'
      Origin = 'ColColor'
      Size = 7
    end
  end
  object dsTarif: TDataSource
    DataSet = QueryTarif
    Left = 120
    Top = 89
  end
  object FDUpdateTarif: TFDUpdateSQL
    Left = 168
    Top = 89
  end
  object QueryExec: TFDQuery
    Connection = MainFrm.MainConnection
    Left = 216
    Top = 193
  end
end

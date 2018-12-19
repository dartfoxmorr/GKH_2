object MainFrm: TMainFrm
  Left = 0
  Top = 0
  Caption = 'GKH 2.0'
  ClientHeight = 500
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 63
    Align = alTop
    TabOrder = 0
    DesignSize = (
      800
      63)
    object Label2: TLabel
      Left = 6
      Top = 35
      Width = 95
      Height = 16
      Caption = #1055#1077#1088#1080#1086#1076' '#1086#1087#1083#1072#1090#1099':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 8
      Width = 75
      Height = 16
      Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbType: TDBLookupComboboxEh
      Left = 107
      Top = 5
      Width = 523
      Height = 22
      AlwaysShowBorder = True
      Anchors = [akLeft, akTop, akRight]
      DynProps = <>
      DataField = ''
      DropDownBox.Rows = 50
      DropDownBox.SpecRow.CellsText = #1042#1089#1077
      DropDownBox.SpecRow.Visible = True
      EditButtons = <>
      Flat = True
      KeyField = 'typeid'
      ListField = 'NameType'
      ListSource = DsType
      TabOrder = 0
      Visible = True
      OnChange = cbChange
    end
    object txtYear: TDBNumberEditEh
      Left = 234
      Top = 33
      Width = 121
      Height = 22
      AlwaysShowBorder = True
      DecimalPlaces = 0
      DynProps = <>
      EditButton.Style = ebsUpDownEh
      EditButton.Visible = True
      EditButtons = <>
      Flat = True
      MinValue = 1990.000000000000000000
      TabOrder = 1
      Value = 2016.000000000000000000
      Visible = True
      OnChange = cbChange
    end
    object cbMonth: TDBLookupComboboxEh
      Left = 107
      Top = 33
      Width = 121
      Height = 22
      AlwaysShowBorder = True
      DynProps = <>
      DataField = ''
      DropDownBox.Rows = 12
      DropDownBox.SpecRow.CellsText = #1042#1089#1077
      DropDownBox.SpecRow.Visible = True
      EditButtons = <>
      Flat = True
      KeyField = 'id'
      ListField = 'nameMonth'
      ListSource = dsMonth
      TabOrder = 2
      Visible = True
      OnChange = cbChange
    end
    object cbnotinuse: TDBCheckBoxEh
      Left = 636
      Top = 9
      Width = 155
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      DynProps = <>
      TabOrder = 3
      OnClick = cbnotinuseClick
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 63
    Width = 800
    Height = 41
    Align = alTop
    TabOrder = 1
    DesignSize = (
      800
      41)
    object btnDel: TBitBtn
      Left = 164
      Top = 5
      Width = 144
      Height = 30
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1083#1072#1090#1077#1078
      Glyph.Data = {
        0A020000424D0A0200000000000036000000280000000C0000000D0000000100
        180000000000D4010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0B0F9A0C119B0C129D0C139F0C13A00C13A00C
        13A00C129F0C119D0A0E9BFFFFFFFFFFFF7B95F07A97F17A9BF37A9DF67A9EF6
        7A9EF67A9CF57A9AF37A96F07D95EEFFFFFFFFFFFF2050E91F56EC1F5DF21F62
        F51F63F71F63F71F60F41F5AEF1F52E8214AE3FFFFFFFFFFFF5C71E55A76E65A
        7BEA5A7EED5A80EE5A80EF5A7EED5A7BEA5A75E65E72E5FFFFFFFFFFFF6B7AE4
        6B82E76B88EC6B8CEF6B8EF16B8FF16B8EF16B8AEE6B85EA6C80E9FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 0
      OnClick = btnDelClick
    end
    object btnAdd: TBitBtn
      Left = 14
      Top = 5
      Width = 144
      Height = 30
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1083#1072#1090#1077#1078
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
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnTarif: TBitBtn
      Left = 647
      Top = 5
      Width = 144
      Height = 30
      Anchors = [akTop, akRight]
      Caption = #1058#1080#1087#1099' '#1074#1099#1087#1083#1072#1090
      TabOrder = 2
      OnClick = btnTarifClick
    end
    object btnExcel: TBitBtn
      Left = 545
      Top = 5
      Width = 96
      Height = 30
      Caption = #1042' Excel'
      TabOrder = 3
      OnClick = btnExcelClick
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 104
    Width = 800
    Height = 396
    Align = alClient
    TabOrder = 2
    object DBGridEh1: TDBGridEh
      Left = 1
      Top = 1
      Width = 798
      Height = 394
      Align = alClient
      ColumnDefValues.Title.TitleButton = True
      ColumnDefValues.Title.ToolTips = True
      ColumnDefValues.ToolTips = True
      DataSource = dsGKH
      DynProps = <>
      FooterRowCount = 1
      IndicatorOptions = [gioShowRowIndicatorEh]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
      SumList.Active = True
      TabOrder = 0
      TitleParams.MultiTitle = True
      OnDrawColumnCell = DBGridEh1DrawColumnCell
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'id'
          Footers = <>
          ReadOnly = True
          Visible = False
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'year_gkh'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1055#1077#1088#1080#1086#1076' '#1086#1087#1083#1072#1090#1099'|'#1043#1086#1076
          Width = 55
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Month_gkh'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1055#1077#1088#1080#1086#1076' '#1086#1087#1083#1072#1090#1099'|'#1052#1077#1089#1103#1094'|'#8470
          Width = 21
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'nameMonth'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1055#1077#1088#1080#1086#1076' '#1086#1087#1083#1072#1090#1099'|'#1052#1077#1089#1103#1094'|'#1053#1072#1079#1074'.'
          Width = 72
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'NameType'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077
          Width = 125
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'summ_gkh'
          Footer.ValueType = fvtSum
          Footers = <>
          ReadOnly = True
          Title.Caption = #1057#1091#1084#1084#1072
          Width = 72
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'type_gkh'
          Footers = <>
          ReadOnly = True
          Visible = False
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'Last_GKH1'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103'|'#1055#1088#1077#1076'.'
          Width = 56
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'present_GKH1'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103'|'#1058#1077#1082#1091#1097'.'
          Width = 57
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'rashod'
          Footers = <>
          Title.Caption = #1055#1086#1082#1072#1079#1072#1085#1080#1103'|'#1056#1072#1079#1085#1080#1094#1072
          Width = 56
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'dateoper'
          Footers = <>
          ReadOnly = True
          Title.Caption = #1044#1072#1090#1072' '#1074#1085#1077#1089#1077#1085#1080#1103
          Width = 101
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object MainConnection: TFDConnection
    Params.Strings = (
      'Database=CREDITHM'
      'DriverID=SQLite')
    Transaction = FDTransactionMain
    Left = 24
    Top = 408
  end
  object FDTransactionMain: TFDTransaction
    Connection = MainConnection
    Left = 104
    Top = 408
  end
  object QueryType: TFDQuery
    Connection = MainConnection
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select typeid,nametype,tarif_gkh,haspokaz '
      'from Type_gkh'
      'where 1=1 &notin'
      'order by nametype')
    Left = 64
    Top = 176
    MacroData = <
      item
        Value = Null
        Name = 'NOTIN'
        DataType = mdIdentifier
      end>
  end
  object DsType: TDataSource
    DataSet = QueryType
    Left = 120
    Top = 176
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 408
  end
  object QueryMonth: TFDQuery
    Connection = MainConnection
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    SQL.Strings = (
      'select id, nameMonth from monthOfYear'
      'order by id')
    Left = 64
    Top = 256
  end
  object dsMonth: TDataSource
    DataSet = QueryMonth
    Left = 120
    Top = 256
  end
  object QueryGKH: TFDQuery
    Connection = MainConnection
    Transaction = FDTransactionMain
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    FetchOptions.Mode = fmAll
    UpdateObject = FDUpdateGKH
    SQL.Strings = (
      'select g.id,g.summ_gkh,'
      'g.type_gkh,'
      't.nameType,'
      'g.Month_gkh,'
      'm.namemonth,'
      'g.year_gkh,'
      'case when g.Last_GKH=0 then null else g.Last_GKH end  Last_GKH1,'
      
        'case when g.present_GKH=0 then null else g.present_GKH end  pres' +
        'ent_GKH1,'
      
        'case when (g.present_GKH-g.Last_GKH)=0 then null else (g.present' +
        '_GKH-g.Last_GKH) end rashod,'
      'g.Last_GKH Last_GKH,'
      'g.present_GKH present_GKH,'
      'g.dateoper,'
      't.colcolor,'
      'm.colcolor colcolor_m'
      ''
      'from '
      'GKH g '
      'left join '#9'Type_gkh t on t.Typeid=g.type_gkh'
      'left join '#9'monthOfyear m on m.id=g.Month_gkh'
      'where '
      '     g.year_gkh=:pyear &month &type'
      'order by g.year_gkh,g.Month_gkh,g.type_gkh,g.dateoper'#9#9#9#9)
    Left = 64
    Top = 344
    ParamData = <
      item
        Name = 'PYEAR'
        DataType = ftInteger
        ParamType = ptInput
        Size = 2014
        Value = 2014
      end>
    MacroData = <
      item
        Value = Null
        Name = 'MONTH'
        DataType = mdIdentifier
      end
      item
        Value = Null
        Name = 'TYPE'
        DataType = mdIdentifier
      end>
  end
  object dsGKH: TDataSource
    DataSet = QueryGKH
    Left = 120
    Top = 344
  end
  object FDCommandMain: TFDCommand
    Connection = MainConnection
    Left = 264
    Top = 328
  end
  object FDUpdateGKH: TFDUpdateSQL
    Connection = MainConnection
    InsertSQL.Strings = (
      'INSERT INTO GKH'
      '(SUMM_GKH, TYPE_GKH, MONTH_GKH, YEAR_GKH, '
      '  LAST_GKH, PRESENT_GKH, DATEOPER)'
      
        'VALUES (:NEW_SUMM_GKH, :NEW_TYPE_GKH, :NEW_MONTH_GKH, :NEW_YEAR_' +
        'GKH, '
      '  :NEW_LAST_GKH, :NEW_PRESENT_GKH, :NEW_DATEOPER);'
      'SELECT LAST_INSERT_AUTOGEN() AS ID')
    ModifySQL.Strings = (
      'UPDATE GKH'
      
        'SET SUMM_GKH = :NEW_SUMM_GKH, TYPE_GKH = :NEW_TYPE_GKH, MONTH_GK' +
        'H = :NEW_MONTH_GKH, '
      
        '  YEAR_GKH = :NEW_YEAR_GKH, LAST_GKH = :NEW_LAST_GKH, PRESENT_GK' +
        'H = :NEW_PRESENT_GKH, '
      '  DATEOPER = :NEW_DATEOPER'
      'WHERE ID = :OLD_ID;'
      'SELECT ID'
      'FROM GKH'
      'WHERE ID = :NEW_ID')
    DeleteSQL.Strings = (
      'DELETE FROM GKH'
      'WHERE ID = :OLD_ID')
    FetchRowSQL.Strings = (
      
        'SELECT LAST_INSERT_AUTOGEN() AS ID, SUMM_GKH, TYPE_GKH, MONTH_GK' +
        'H, '
      '  YEAR_GKH, LAST_GKH, PRESENT_GKH, DATEOPER'
      'FROM GKH'
      'WHERE ID = :ID')
    Left = 328
    Top = 408
  end
  object Export2Excel1: TExport2Excel
    DataTop = 1
    DataLeft = 1
    DataType = etDBGridEh
    DataManual.RecordCount = 0
    DataManual.FieldCount = 0
    DataGridEh = DBGridEh1
    Options = []
    Left = 424
    Top = 63
  end
end

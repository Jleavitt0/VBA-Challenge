Sub dataStockVolume()
'Sub dataStockVolume():
   For Each ws In Worksheets

     'ticker name and stock volume
      Dim ticker As String

      'the open price and the close price
      Dim Open_Price As Double
      Dim Close_Price As Double

      'the yearly change
      Dim Yearly_Change As Double
      Dim Percent_Change As Double

      'the location of the dates open price
      Dim Price_Row As Long
      Price_Row = 2

      'assign total stock volume as 0
      Total = 0

      'the different names of the stocks
      Dim Summary_Table_Row As Integer
      Summary_Table_Row = 2

      'set header name
      ws.Range("I1").Value = "Ticker"
      ws.Range("J1").Value = "Yearly Change"
      ws.Range("K1").Value = "Percent Change"
      ws.Range("L1").Value = "Total Stock Volume”"

      'determine Lastrow
      Lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row

      'Loop through column A, find different stock names and add stock volume together
      For i = 2 To Lastrow:
            
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

               'set ticker name
               ticker = ws.Cells(i, 1).Value

               'Add to stock volume total
               Total = Total + ws.Range("G" & i).Value

               'print ticker name
               ws.Range("I" & Summary_Table_Row).Value = ticker

               'Print total stock volume
               ws.Range("L" & Summary_Table_Row).Value = Total

               'Calculate yearly change and percent change
               Open_Price = ws.Range("C" & Price_Row).Value
               Close_Price = ws.Range("F" & i).Value
               Yearly_Change = Close_Price - Open_Price

                  If Open_Price = 0 Then
                      Percent_Change = 0
                     Else
                         Percent_Change = Yearly_Change / Open_Price
                  End If

                 'Print values of yearly change and percent change
                  ws.Range("J" & Summary_Table_Row).Value = Yearly_Change
                  ws.Range("K" & Summary_Table_Row).Value = Percent_Change
                  ws.Range("K" & Summary_Table_Row).NumberFormat = "0.00%"

                        'Conditional formatting  highlight positive change in green and negative change in red
                        If ws.Range("J" & Summary_Table_Row).Value > 0 Then
                            ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4
                        Else
                            ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
                        End If

                  'add one to the summary table row
                  Summary_Table_Row = Summary_Table_Row + 1
                  Price_Row = i + 1

                  'reset the total stock volume
                  Total = 0
            Else
              Total = Total + ws.Range("G" & i).Value

            End If

       Next i

'set the first ticker's percent change and total stock volume as the greatest ones Greatest_Increase = ws.Range("K2").Value
Greatest_Decrease = ws.Range("K2").Value
Greatest_Total = ws.Range("L2").Value

'Define last row of Ticker column
Lastrow_Ticker = ws.Cells(Rows.Count, "I").End(xlUp).Row

'Loop through each row of Ticker column to find the greatest results
For r = 2 To Lastrow_Ticker:
If ws.Range("K" & r + 1).Value > Greatest_Increase Then
Greatest_Increase = ws.Range("K" & r + 1).Value
Greatest_Increase_Ticker = ws.Range("I" & r + 1).Value
ElseIf ws.Range("K" & r + 1).Value < Greatest_Decrease Then
Greatest_Decrease = ws.Range("K" & r + 1).Value
Greatest_Decrease_Ticker = ws.Range("I" & r + 1).Value
ElseIf ws.Range("L" & r + 1).Value > Greatest_Total Then
Greatest_Total = ws.Range("L" & r + 1).Value
Greatest_Total_Ticker = ws.Range("I" & r + 1).Value

End If

Next r

'Print greatest % increase, greatest % decrease, greatest total volume and their ticker names
ws.Range("P2").Value = Greatest_Increase_Ticker
ws.Range("P3").Value = Greatest_Decrease_Ticker
ws.Range("P4").Value = Greatest_Total_Ticker
ws.Range("Q2").Value = Greatest_Increase
ws.Range("Q3").Value = Greatest_Decrease
ws.Range("Q4").Value = Greatest_Total
ws.Range("Q2:Q3").NumberFormat = "0.00%"

Next ws


End Sub

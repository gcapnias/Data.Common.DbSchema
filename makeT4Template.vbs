Dim filesDictionary, regEx, fileSystemObj, textWriter, providerName
Dim codeFile, theCode, regionCode, searchMatches, codeMatches
Dim codeMatch, providersDictionary, iCounter, providerMatch
Dim providersToRemove, providers, arrayKeys, importednamespaces, namespace

    Const outputFile = "Data.Common.ttinclude"

    Set filesDictionary = CreateObject("Scripting.Dictionary")
    Call filesDictionary.Add("Data.Common.DbSchema", "Data.Common\DbSchema.cs")
    Call filesDictionary.Add("Data.Common.IDbSchemaProvider", "Data.Common\IDbSchemaProvider.cs")
    Call filesDictionary.Add("Data.Common.DbSchemaProvider", "Data.Common\DbSchemaProvider.cs")
    Call filesDictionary.Add("system.data.sqlclient", "Data.Common\SqlServerSchemaProvider.cs")
    'Call filesDictionary.Add("system.data.sqlserverce.3.5", "Data.Common\SqlServerCeSchemaProvider.cs")
    'Call filesDictionary.Add("mysql.data.mysqlclient", "Data.Common\MySqlSchemaProvider.cs")
    'Call filesDictionary.Add("system.data.oledb", "Data.Common\OleDbSchemaProvider.cs")
    'Call filesDictionary.Add("npgsql", "Data.Common\PostgreSqlSchemaProvider.cs")
    'Call filesDictionary.Add("system.data.sqlite", "Data.Common\SQLiteSchemaProvider.cs")
  
    Set regEx = New RegExp
    regEx.MultiLine = True
    regEx.IgnoreCase = True
    regEx.Global = True
    
    Set fileSystemObj = CreateObject("Scripting.FileSystemObject")
    Set textWriter = fileSystemObj.CreateTextFile(outputFile, True, True)

    Set providersDictionary = CreateObject("Scripting.Dictionary")
    Set importednamespaces = CreateObject("Scripting.Dictionary")
    For iCounter = 0 To filesDictionary.Count - 1
        arrayKeys = filesDictionary.Keys
        providerName = arrayKeys(iCounter)
    
        Set codeFile = fileSystemObj.OpenTextFile(filesDictionary(providerName), 1, False)  ' ForReading=1
        theCode = codeFile.ReadAll
        
		regEx.Pattern = "^using (.*);$"
        If regEx.Test(theCode) Then
            Set searchMatches = regEx.Execute(theCode)
            For Each codeMatch In searchMatches
                namespace = codeMatch.SubMatches(0)
                If Not importednamespaces.Exists(namespace) Then
					Call importednamespaces.Add(namespace, "Imported Namespace")
                End If
            Next
		End If
		
		regEx.Pattern = ".*{([\w\W]*)}.*"
        If regEx.Test(theCode) Then
            Call textWriter.WriteLine(vbTab & "// " & providerName)
            Set searchMatches = regEx.Execute(theCode)
            For Each codeMatch In searchMatches
                Call textWriter.Write(codeMatch.SubMatches(0))
                Call providersDictionary.Add(providerName, "Provider Name")
            Next
        End If
        codeFile.Close
        Set codeFile = Nothing
    Next
    
    Call textWriter.WriteLine("#>")
    textWriter.Close
    Set textWriter = Nothing
    
        
    Set codeFile = fileSystemObj.OpenTextFile(outputFile, 1, False, -1) ' ForReading=1, TristateTrue=-1
    theCode = codeFile.ReadAll
    codeFile.Close
    Set codeFile = Nothing
    
    regEx.Pattern = "#region ' Helpers '([\w\W]*?)#endregion"
    If regEx.Test(theCode) Then
        Set searchMatches = regEx.Execute(theCode)
        For Each codeMatch In searchMatches
            regionCode = codeMatch.Value
            regEx.Pattern = "^[ \t]*case ""(.*?)"":[\w\W]*?break;"
            If regEx.Test(regionCode) Then
                Set codeMatches = regEx.Execute(regionCode)
                For Each providerMatch In codeMatches                    
                    If Not providersDictionary.Exists(providerMatch.SubMatches(0)) Then
                        If Len(providersToRemove) > 0 Then
                            providersToRemove = providersToRemove &  "|" & providerMatch.SubMatches(0)
                        Else
                            providersToRemove = providersToRemove & providerMatch.SubMatches(0)
                        End If
                    End If
                Next
                
                providers = Split(providersToRemove, "|")
                For iCounter = LBound(providers) To UBound(providers)
                    regEx.Pattern = "^[ \t]*case """ & providers(iCounter) & """:[\w\W]*?break;"
                    If regEx.Test(regionCode) Then
                        regionCode = regEx.Replace(regionCode, vbNullString)
                    End If
                Next
                regEx.Pattern = "\r\n\r\n"
                regionCode = regEx.Replace(regionCode, vbCrLf)
                regionCode = regEx.Replace(regionCode, vbCrLf)                                
            End If
        Next
        
        regEx.Pattern = "#region ' Helpers '([\w\W]*?)#endregion"
        theCode = regEx.Replace(theCode, regionCode)
        
    End If
    
    Set codeFile = fileSystemObj.OpenTextFile(outputFile, 2, False) ' ForWriting=2
    Call codeFile.WriteLine("<#@ assembly name=""System.Core"" #>")
	For iCounter = 0 To importednamespaces.Count - 1
        arrayKeys = importednamespaces.Keys
        namespace = arrayKeys(iCounter)
		Call codeFile.WriteLine("<#@ import namespace=""" & namespace & """ #>")
	Next
    Call codeFile.WriteLine("<#+")
    Call codeFile.WriteLine("//")
    Call codeFile.WriteLine("//  Data.Common.DbSchema - http://dbschema.codeplex.com")
    Call codeFile.WriteLine("//")
    Call codeFile.WriteLine("//  The contents of this file are subject to the New BSD")
    Call codeFile.WriteLine("//  License (the ""License""); you may not use this file")
    Call codeFile.WriteLine("//  except in compliance with the License. You may obtain a copy of")
    Call codeFile.WriteLine("//  the License at http://www.opensource.org/licenses/bsd-license.php")
    Call codeFile.WriteLine("//")
    Call codeFile.WriteLine("//  Software distributed under the License is distributed on an")
    Call codeFile.WriteLine("//  ""AS IS"" basis, WITHOUT WARRANTY OF ANY KIND, either express or")
    Call codeFile.WriteLine("//  implied. See the License for the specific language governing")
    Call codeFile.WriteLine("//  rights and limitations under the License.")
    Call codeFile.WriteLine("//")
    Call codeFile.WriteBlankLines(2)    
    Call codeFile.Write(theCode)
    codeFile.Close
    Set codeFile = Nothing
    
    Set fileSystemObj = Nothing

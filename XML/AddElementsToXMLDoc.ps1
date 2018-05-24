
#Company: Graig Ltd
#Author: PQR Davies
Date: 20180524

$doc = New-Object System.Xml.XmlDocument
$filePath="V:\XML\XMLDocs\Library.xml"
$doc.Load($filePath)

$L1_NodeName = "Library"
$L1_NewElementName = $L1_NodeName + "ID"

$L2_NodeName="LibraryDetails"
$L2_NewElementName = $L2_NodeName + "ID"

$L3_NodeName="BookDetails"
$L3_NewElementName = $L3_NodeName + "ID"

#Select Level 1(L1) Nodes
$L1_LibrayNodes = $doc.SelectNodes("//" + $L1_NodeName)

#Loop Through Each Level 1 Node
#------------------------------------------------------------------------------------
foreach ($L1_node in  $L1_LibrayNodes)

    {
        ECHO  $L1_node.name
    
        #Create a new node with a andom combination of letters and numbers
        $L1_NewElement = $doc.CreateElement($L1_NewElementName)
        $L1_NewElement.InnerText = [GUID]::NewGuid()

        #Add the node to the document.
        $L1_node.InsertBefore($L1_NewElement ,$L1_node.FirstChild)

        #Now lets drill down to Level 2        
        #Select L2 Nodes off L1 Node
        $L2_LibrayNodes = $L1_Node.SelectNodes($L2_NodeName)
        
        #Nested...Loop Through Each Level 2 Node
        #------------------------------------------------------------------------------------
        foreach ($L2_node in  $L2_LibrayNodes)
        {

            echo $L2_node.name
            #Create a new L2 node with L1_element value so its a duplicate of the parent
            $L2_NewElement = $doc.CreateElement($L1_NewElementName)
            $L2_NewElement.InnerText = $L1_NewElement.InnerText
            #Add
            $L2_node.InsertBefore($L2_NewElement ,$L2_node.FirstChild)

            #Create a new L2 node with new value
            $L2_NewElement = $doc.CreateElement($L2_NewElementName)
            $L2_NewElement.InnerText = [GUID]::NewGuid()
            #Add
            $L2_node.InsertAfter($L2_NewElement ,$L2_node.FirstChild)

            #Now lets drill down to Level 3        
            #Select L3 Nodes off L2 Node
            $L3_LibrayNodes = $L2_Node.SelectNodes($L3_NodeName)
        
            #Nested...Loop Through Each Level 3 Node
            #------------------------------------------------------------------------------------
            foreach ($L3_node in  $L3_LibrayNodes)
            {
                echo $L3_node.name
                #Create a new L3 node with a L1_Element & value so its a duplicate of the L1 parent
                $L3_NewElement = $doc.CreateElement($L1_NewElementName)
                $L3_NewElement.InnerText = $L1_NewElement.InnerText
                #Add
                $L3_node.InsertBefore($L3_NewElement ,$L3_node.FirstChild)

                #Create a new L3 node with new value
                #Add this last node now then it will appear last when doc viewed
                $L3_NewElement = $doc.CreateElement($L3_NewElementName)
                $L3_NewElement.InnerText = [GUID]::NewGuid()
                #Add
                $L3_node.InsertAfter($L3_NewElement ,$L3_node.FirstChild)
                
                #Create a new L3 node with a L2_element & value so its a duplicate of the L2 parent
                $L3_NewElement = $doc.CreateElement($L2_NewElementName)
                $L3_NewElement.InnerText = $L2_NewElement.InnerText
                #Add
                $L3_node.InsertAfter($L3_NewElement ,$L3_node.FirstChild)

            }#foreach ($L3_node in $L3_LibrayNodes)

        }#foreach ($L2_node in  $L2_LibrayNodes)

    } #foreach ($L1_node in  $L1_LibrayNodes)

$doc.Save("V:\XML\XMLDocs\LibraryII.xml")
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
    <xsl:param name="persons" select="13"/>
   
    <xsl:template match="//record">
        <xsl:variable name="ppn" select="tag[@id='003@']/sbf[@id='0']"/>
        <xsl:call-template name="feld"> <!-- PPN -->
            <xsl:with-param name="wert" select="$ppn"/>
        </xsl:call-template>
        <xsl:variable name="signatur" select="tag[starts-with(@id,'209A') and (sbf[@id='f']='066')]/sbf[@id='a'][1]"/>
        <xsl:call-template name="feld"> <!-- Signatur_PPN -->
            <xsl:with-param name="wert" select="concat($signatur,' ',$ppn)"/>
        </xsl:call-template>
        <xsl:variable name="statistics" select="document('Examples/db-Liste.xml')/dataroot/db-Liste[PPN=$ppn]"/>
        <xsl:call-template name="feld">
            <xsl:with-param name="wert" select="string-join(($statistics/MinvonPk_x0020_lev_x0020_dB_x0020_O,$statistics/MaxvonPk_x0020_lev_x0020_dB_x0020_O),' / ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Objekttitel -->
            <xsl:with-param name="wert" select="string-join((string-join((tag[@id='021A']/sbf[@id='a'],tag[@id='021A']/sbf[@id='d']),' : '),tag[@id='021A']/sbf[@id='h']),' / ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Reihentitel -->
            <xsl:with-param name="wert" select="string-join((tag[starts-with(@id,'036C')]/sbf[@id='a'],tag[starts-with(@id,'036G')]/sbf[@id='a']),'/')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Sprache -->
            <xsl:with-param name="wert" select="string-join(tag[@id='010@']/sbf[@id='a'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Objektbeschreibung -->
            <xsl:with-param name="wert">
                <xsl:if test="tag[@id='046M']/sbf[@id='t']">
                    <xsl:text>Enth.: </xsl:text>
                </xsl:if>
                <xsl:value-of select="string-join(tag[@id='046M']/sbf[@id='t']|tag[@id='046M']/sbf[@id='a'],' - ')"/>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Umfang -->
            <xsl:with-param name="wert" select="string-join((tag[@id='034D']/sbf[@id='a'],tag[@id='034M']/sbf[@id='a'],tag[@id='034I']/sbf[@id='a'],tag[@id='034K']/sbf[@id='a']),' ; ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Signatur -->
            <xsl:with-param name="wert" select="$signatur"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Verlags-Bestellnummer -->
            <xsl:with-param name="wert" select="string-join(tag[@id='004E/01']/sbf[@id='0'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- UPC -->
            <xsl:with-param name="wert" select="string-join(tag[@id='004C']/sbf[@id='0'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Matrixnr. -->
            <xsl:with-param name="wert" select="substring-after(tag[@id='037A']/sbf[@id='a'][contains(.,'Matrix')],':')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Jahr -->
            <xsl:with-param name="wert" select="tag[@id='011@']/sbf[@id='a']"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Ort -->
            <xsl:with-param name="wert" select="string-join(tag[@id='033A']/sbf[@id='p'][../sbf[@id='n']/not(contains(.,'(Distr.)'))],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Label -->
            <xsl:with-param name="wert" select="string-join(tag[@id='033A']/sbf[@id='n'][not(contains(.,'(Distr.)'))],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Schlagwörter -->
            <xsl:with-param name="wert" select="string-join(tag[starts-with(@id,'144Z')]/sbf[@id='a'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Inventarnummer -->
            <xsl:with-param name="wert" select="tag[starts-with(@id,'209C')]/sbf[@id='a'][1]"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Weitere Informationen -->
            <xsl:with-param name="wert" select="string-join(tag[@id='037A']/sbf[@id='a'],' - ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Merkmale -->
            <xsl:with-param name="wert" select="string-join(tag[starts-with(@id,'237A')]/sbf[@id='a'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Interpret -->
            <xsl:with-param name="wert" select="tag[@id='046S']/sbf[@id='a']"/>
        </xsl:call-template>
        <xsl:for-each select="tag[starts-with(@id,'028')]|tag[starts-with(@id,'029')]">
            <xsl:if test="position() gt $persons"><xsl:message><xsl:text>Warnung: </xsl:text><xsl:value-of select="position()"/></xsl:message></xsl:if>
            <xsl:variable name="gndid" select="concat('http://d-nb.info/gnd/',sbf[@id='0'])"/>
            <xsl:variable name="gnddata">
                <xsl:if test="string-length($gndid) ge 22">
                    <xsl:copy-of
                        select="document(concat($gndid,'/about/lds.rdf'))/rdf:RDF/rdf:Description/*"
                    />
                </xsl:if>
            </xsl:variable>
            <xsl:variable name="gndname">
                <xsl:choose>
                    <xsl:when test="string-length($gndid) lt 22"/>
                    <xsl:when test="$gnddata/*:type/@*:resource='https://d-nb.info/standards/elementset/gnd#DifferentiatedPerson'">
                        <xsl:value-of select="$gnddata/*:preferredNameForThePerson"/>
                    </xsl:when>
                    <xsl:when test="$gnddata/*:type/@*:resource='https://d-nb.info/standards/elementset/gnd#CorporateBody'">
                        <xsl:value-of select="$gnddata/*:preferredNameForTheCorporateBody"/>
                    </xsl:when>
                    <xsl:when test="$gnddata/*:type/@*:resource='https://d-nb.info/standards/elementset/gnd#MusicalCorporateBody'">
                        <xsl:value-of select="$gnddata/*:preferredNameForTheCorporateBody"/>
                    </xsl:when>
                    <xsl:otherwise><xsl:message>Warnung: Unbekannter GND-Typ</xsl:message></xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="gndjson">
                <xsl:if test="not($gndname='')">
                    <xsl:text>{&quot;frontendLanguage&quot;:&quot;de&quot;,&quot;_fulltext&quot;:{&quot;text&quot;:&quot;TBD&quot;},&quot;conceptURI&quot;:&quot;</xsl:text>
                    <xsl:value-of select="$gndid"/>
                    <xsl:text>&quot;,&quot;_standard&quot;:{&quot;text&quot;:&quot;</xsl:text>
                    <xsl:value-of select="$gndname"/>
                    <xsl:text>&quot;},&quot;conceptName&quot;:&quot;</xsl:text>
                    <xsl:value-of select="$gndname"/>
                    <xsl:text>&quot;}</xsl:text>
                </xsl:if>
            </xsl:variable>
            <!-- <xsl:message><xsl:value-of select="$gndid"/><xsl:text> - </xsl:text><xsl:value-of select="$gndjson"/></xsl:message> -->
            <xsl:call-template name="feld"> <!-- GND-ID -->
                <xsl:with-param name="wert" select="$gndid"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- GND-Name -->
                <xsl:with-param name="wert" select="$gndname"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- GND-JSON -->
                <xsl:with-param name="wert" select="$gndjson"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- Kategorie -->
                <xsl:with-param name="wert" select="@id"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- Rolle -->
                <xsl:with-param name="wert" select="if (sbf[@id='4']) then (sbf[@id='4'][1]) else (sbf[@id='B'][1])"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- Name -->
                <xsl:with-param name="wert" select="concat(if (sbf[@id='a']) then string-join((sbf[@id='c'],string-join((sbf[@id='a'],sbf[@id='d']),', ')),' ') else (sbf[@id='P']),
                    if (sbf[@id='l']) then concat(' &lt;',sbf[@id='l'],'&gt;') else ())"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- Bemerkung -->
                <xsl:with-param name="wert" select="sbf[@id='L']"/>                
            </xsl:call-template>           
        </xsl:for-each>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">PPN</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Signatur_PPN</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Pk dB Range</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Objekttitel</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Reihentiteltitel</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Sprachen</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Objektbeschreibung</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Umfang</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Signatur)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Verlagsnr.)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (UPC)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Matrix)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Datum</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Ort</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Label</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Schlagwörter</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Teilsammlung (AMA)</xsl:with-param>
        </xsl:call-template>        
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Informationen</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Merkmale</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Interpret</xsl:with-param>
        </xsl:call-template>
        <xsl:for-each select="1 to $persons">
            <xsl:call-template name="feld"> 
                <xsl:with-param name="wert" select="concat('GND-ID (',.,'.)')"/>
            </xsl:call-template>
            <xsl:call-template name="feld"> 
                <xsl:with-param name="wert" select="concat('GND-Name (',.,'.)')"/>
            </xsl:call-template>
            <xsl:call-template name="feld"> 
                <xsl:with-param name="wert" select="concat('GND-JSON (',.,'.)')"/>
            </xsl:call-template> 
            <xsl:call-template name="feld"> 
                <xsl:with-param name="wert" select="concat('Kategorie (',.,'.)')"/>
            </xsl:call-template>
            <xsl:call-template name="feld"> 
                <xsl:with-param name="wert" select="concat('Rolle (',.,'.)')"/>
            </xsl:call-template>
            <xsl:call-template name="feld"> 
                <xsl:with-param name="wert" select="concat('Name (',.,'.)')"/>
            </xsl:call-template>
            <xsl:call-template name="feld"> 
                <xsl:with-param name="wert" select="concat('Bemerkung (',.,'.)')"/>
            </xsl:call-template>
        </xsl:for-each>
        <xsl:text>&#13;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="feld">
        <xsl:param name="wert"/>
        <xsl:value-of select="translate(normalize-unicode($wert,'NFC'),'{@','')"/><xsl:text>&#x9;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
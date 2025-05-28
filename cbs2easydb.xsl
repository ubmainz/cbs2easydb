<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
    <xsl:param name="sep">&quot;</xsl:param>
    
    <xsl:variable name="quote" select="'&quot;&quot;'"/>
    <xsl:variable name="apos" select="'&apos;&apos;'"/>
   
    <xsl:template match="record[../name()='dataExportXML']">
        <xsl:variable name="ppn" select="tag[@id='003@']/sbf[@id='0']"/>
        <xsl:call-template name="feld"> <!-- PPN -->
            <xsl:with-param name="wert" select="$ppn"/>
        </xsl:call-template>
        <xsl:variable name="signatur" select="tag[starts-with(@id,'209A') and (sbf[@id='f']='066')]/sbf[@id='a'][1]"/>
        <xsl:call-template name="feld"> <!-- Signatur_PPN -->
            <xsl:with-param name="wert" select="concat($signatur,' ',$ppn)"/>
        </xsl:call-template>
        <!--
        <xsl:variable name="statistics" select="document('Examples/db-Liste.xml')/dataroot/db-Liste[PPN=$ppn]"/>
        <xsl:call-template name="feld">
            <xsl:with-param name="wert" select="string-join(($statistics/MinvonPk_x0020_lev_x0020_dB_x0020_O,$statistics/MaxvonPk_x0020_lev_x0020_dB_x0020_O),' / ')"/>
        </xsl:call-template>
        -->
        <xsl:call-template name="feld"> <!-- Objekttitel -->
            <xsl:with-param name="wert" select="translate(string-join((string-join((tag[@id='021A']/sbf[@id='a'],tag[@id='021A']/sbf[@id='d']),' : '),tag[@id='021A']/sbf[@id='h']),' / '),'{@','')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Reihentitel -->
            <xsl:with-param name="wert" select="translate(string-join((tag[starts-with(@id,'036C')]/sbf[@id='a'],tag[starts-with(@id,'036G')]/sbf[@id='a']),'/'),'{@','')"/>
        </xsl:call-template>
        <xsl:variable name="language" as="xs:string*">
            <xsl:variable name="ISO" select="('eng','fre','ger','kik','kon','lin','lub','spa','swa')"/>
            <xsl:variable name="IANA" select="('en','fr','de','ki','kg','ln','lu','es','sw')"/>
            <xsl:for-each select="tag[@id='010@']/sbf[@id='a']">
                <xsl:variable name="i" select="index-of($ISO,.)"/>
                <xsl:choose>
                    <xsl:when test="$i &gt; 0"><xsl:sequence select="$IANA[$i]"/></xsl:when>
                    <xsl:otherwise><xsl:sequence select="."/></xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:call-template name="feld"> <!-- Sprache -->
            <xsl:with-param name="wert" select="concat('&quot;',string-join($language,$sep),'&quot;')"/> <!-- CR -->
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
        <xsl:call-template name="feld"> <!-- Signatur (weitere Nummer) -->
            <xsl:with-param name="wert" select="if ($signatur) then ('Signatur') else ('')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Signatur -->
            <xsl:with-param name="wert" select="$signatur"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Verlags-Bestellnummer (weitere Nummer) -->
            <xsl:with-param name="wert" select="if (tag[@id='004E/01']/sbf[@id='0']) then ('Verlags-Bestellnummer') else ('')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Verlags-Bestellnummer -->
            <xsl:with-param name="wert" select="string-join(tag[@id='004E/01']/sbf[@id='0'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- UPC (weitere Nummer) -->
            <xsl:with-param name="wert" select="if (tag[@id='004C']/sbf[@id='0']) then ('Produkt-Nummer') else ('')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- UPC -->
            <xsl:with-param name="wert" select="string-join(tag[@id='004C']/sbf[@id='0'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Matrix-Nummer (weitere Nummer) -->
            <xsl:with-param name="wert" select="if (tag[@id='037A']/sbf[@id='a'][contains(.,'Matrix')]) then ('Matrix-Nummer') else ('')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Matrixnr. -->
            <xsl:with-param name="wert" select="string-join(tag[@id='037A']/sbf[@id='a'][contains(.,'Matrix')],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Jahr -->
            <xsl:with-param name="wert" select="tag[@id='011@']/sbf[@id='a']"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Ort --> <!-- CR -->
            <xsl:with-param name="wert" select="concat('&quot;',translate(string-join(tag[@id='033A']/sbf[@id='p'][../sbf[@id='n']/not(contains(.,'(Distr.)'))],$sep),'[]{',''),'&quot;')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Label -->
            <xsl:with-param name="wert" select="string-join(tag[@id='033A']/sbf[@id='n'][not(contains(.,'(Distr.)'))],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Schlagwörter --> <!-- CR -->
            <xsl:with-param name="wert" select="concat('&quot;',translate(replace(string-join(tag[starts-with(@id,'144Z')]/sbf[@id='a'],$sep),'12.3 ','','s'),$quote,$apos),'&quot;')"/>
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
        <xsl:call-template name="feld"> <!-- Ereignis -->
            <xsl:with-param name="wert" select="'Veröffentlichung (musikalisches Werk)'"/>                
        </xsl:call-template>
        <xsl:variable name="gndliste">
            <xsl:for-each select="tag[starts-with(@id,'028')]|tag[starts-with(@id,'029')]">
                <row>
                    <xsl:variable name="gndid" select="sbf[@id='0']"/>
                    <xsl:variable name="gndfile" select="concat('gnd/gnd-',$gndid,'.xml')"/>
                    <xsl:variable name="gnddata">
                        <xsl:if test="(string-length($gndid) ge 1) and doc-available($gndfile)">
                            <xsl:copy-of
                                select="document($gndfile)/rdf:RDF/*"/> 
                        </xsl:if>
                    </xsl:variable>
                    <gndurl><xsl:value-of select="if ($gndid!='') then (concat('http://d-nb.info/gnd/',$gndid)) else ('')"/></gndurl>
                    <xsl:variable name="gndname">
                        <xsl:choose>
                            <xsl:when test="string-length($gndid) lt 1"/>
                            <xsl:when test="($gnddata/*/*:type/@*:resource='https://d-nb.info/standards/elementset/gnd#DifferentiatedPerson') or
                                (name($gnddata/*)='gndo:DifferentiatedPerson')">
                                <xsl:value-of select="$gnddata/*/(*:preferredNameForThePerson|*:preferredName)"/>
                            </xsl:when>
                            <xsl:when test="($gnddata/*/*:type/@*:resource='https://d-nb.info/standards/elementset/gnd#CorporateBody') or
                                (name($gnddata/*)='gndo:CorporateBody')">
                                <xsl:value-of select="$gnddata/*/(*:preferredNameForTheCorporateBody|*:preferredName)"/>
                            </xsl:when>
                            <xsl:when test="($gnddata/*/*:type/@*:resource='https://d-nb.info/standards/elementset/gnd#MusicalCorporateBody') or
                                (name($gnddata/*)='gndo:MusicalCorporateBody')">
                                <xsl:value-of select="$gnddata/*/(*:preferredNameForTheCorporateBody|*:preferredName)"/>
                            </xsl:when>
                            <xsl:otherwise><xsl:message>Warnung: Unbekannter GND-Typ</xsl:message></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <gndname><xsl:value-of select="$gndname"/></gndname>
                    <!-- <xsl:variable name="gndvolltext">
                        <xsl:for-each select="$gnddata//(*:oldAuthorityNumber|*:label|*:variantName)[not(contains(.,'http'))]">
                            <xsl:sort/>
                            <xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
                        </xsl:for-each>
                    </xsl:variable> -->
                    <xsl:if test="($gndname='') and (string-length($gndid) ge 1)"><xsl:message>Daten fehlen: <xsl:value-of select="$gndid"/></xsl:message></xsl:if>
                    <!-- <xsl:variable name="gndjson">
                        <xsl:if test="not($gndname='')">
                            <xsl:text>{&quot;frontendLanguage&quot;:&quot;de&quot;,&quot;_fulltext&quot;:{&quot;text&quot;:&quot;</xsl:text>
                            <xsl:value-of select="$gndvolltext"/>
                            <xsl:text>&quot;},</xsl:text>
                            <xsl:text>&quot;conceptURI&quot;:&quot;http://d-nb.info/gnd/</xsl:text>
                            <xsl:value-of select="$gndid"/>
                            <xsl:text>&quot;,&quot;_standard&quot;:{&quot;text&quot;:&quot;</xsl:text>
                            <xsl:value-of select="$gndname"/>
                            <xsl:text>&quot;},&quot;conceptName&quot;:&quot;</xsl:text>
                            <xsl:value-of select="$gndname"/>
                            <xsl:text>&quot;}</xsl:text>
                        </xsl:if>
                    </xsl:variable> -->
                    <xsl:variable name="rolle">
                        <xsl:variable name="cbsrolle" select="normalize-space(if (sbf[@id='4']) then (sbf[@id='4'][1]) else (sbf[@id='B'][1]))"/>
                        <xsl:choose>
                            <xsl:when test="index-of(('arr','Arr.'),$cbsrolle) gt 0">Arrangement (von)</xsl:when>
                            <xsl:when test="index-of(('cmp','Komp.'),$cbsrolle) gt 0">Komposition (von)</xsl:when>
                            <xsl:when test="index-of(('cnd'),$cbsrolle) gt 0">dirigiert (von)</xsl:when>
                            <xsl:when test="index-of(('com'),$cbsrolle) gt 0">Zusammenstellung (durch)</xsl:when>
                            <xsl:when test="index-of(('dir','msd'),$cbsrolle) gt 0">Musikalische Leitung (durch)</xsl:when>
                            <xsl:when test="index-of(('edt','hrsg.','Hrsg.','isb'),$cbsrolle) gt 0">Musikalisches Werk Herausgabe (durch)</xsl:when>
                            <xsl:when test="index-of(('g'),$cbsrolle) gt 0">Instrumentalmusik (von)</xsl:when>
                            <xsl:when test="(index-of(('hnr'),$cbsrolle) gt 0) or (@id='028F')">Geehrte Person</xsl:when>
                            <xsl:when test="(index-of(('itr','prf','sng','voc'),$cbsrolle) gt 0) or (@id='028E') or starts-with(@id,'029E')">Interpretation (durch)</xsl:when>
                            <xsl:when test="index-of(('lyr'),$cbsrolle) gt 0">Liedtext (von)</xsl:when>
                            <xsl:when test="index-of(('pro','aup','Prod.'),$cbsrolle) gt 0">Produktion (von)</xsl:when>
                            <xsl:when test="index-of(('rcd'),$cbsrolle) gt 0">Aufnahme (durch)</xsl:when>
                            <xsl:when test="index-of(('aut','ctb','wst','wpr','ive','oth',''),$cbsrolle) gt 0">Beteiligte Person/Körperschaft</xsl:when>
                            <xsl:otherwise><xsl:message>Unbekannte Rolle: <xsl:value-of select="$cbsrolle"/></xsl:message></xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <rolle><xsl:value-of select="$rolle"/></rolle>
                    <xsl:variable name="name" select="concat(if (sbf[@id='a']) then string-join((sbf[@id='c'],string-join((sbf[@id='a'],sbf[@id='d']),', ')),' ') else (sbf[@id='P']),
                        if (sbf[@id='l']) then concat(' &lt;',sbf[@id='l'],'&gt;') else ())"/>
                    <name><xsl:value-of select="$name"/></name>
                    <bemerkung><xsl:value-of select="sbf[@id='L']"/></bemerkung>
                </row>
            </xsl:for-each>
        </xsl:variable>
        <!-- <xsl:message><xsl:value-of select="$gndid"/><xsl:text> - </xsl:text><xsl:value-of select="$gndjson"/></xsl:message> -->
        <xsl:call-template name="feld"> <!-- GND-URL -->
            <xsl:with-param name="wert" select="concat('&quot;',string-join($gndliste/row/gndurl,$sep),'&quot;')"/>                
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- GND-Name -->
            <xsl:with-param name="wert" select="concat('&quot;',translate(string-join($gndliste/row/gndname,$sep),$quote,$apos),'&quot;')"/>                
        </xsl:call-template>
        <!-- <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="$gndjson"/>                
        </xsl:call-template> -->
        <xsl:call-template name="feld"> <!-- Rolle -->
            <xsl:with-param name="wert" select="concat('&quot;',string-join($gndliste/row/rolle,$sep),'&quot;')"/>                
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Name -->
            <xsl:with-param name="wert" select="concat('&quot;',translate(string-join($gndliste/row/name,$sep),$quote,$apos),'&quot;')"/>                
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Bemerkung -->
            <xsl:with-param name="wert" select="concat('&quot;',translate(string-join($gndliste/row/bemerkung,$sep),$quote,$apos),'&quot;')"/>                
        </xsl:call-template>
        <xsl:value-of select="normalize-unicode(concat('&quot;',translate(string-join($gndliste/row/bemerkung,$sep),$quote,$apos),'&quot;'),'NFC')"/>
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
            <xsl:with-param name="wert">Objekttitel</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Reihentiteltitel</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">&quot;Sprachen&quot;</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Objektbeschreibung</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Umfang</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Typ Signatur)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Signatur)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Typ Verlagsnr.)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Verlagsnr.)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Typ UPC)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (UPC)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Typ Matrix)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Weitere Nummer (Matrix)</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Datum</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">&quot;Ort&quot;</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Label</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">&quot;Schlagwörter&quot;</xsl:with-param>
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
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Ereignis</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">&quot;GND-URL&quot;</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">&quot;GND-Name&quot;</xsl:with-param>
        </xsl:call-template>
        <!-- <xsl:call-template name="feld"> 
            <xsl:with-param name="wert"></xsl:with-param> select="concat('GND-JSON (',.,'.)')"
        </xsl:call-template> -->
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">&quot;Rolle&quot;</xsl:with-param>
        </xsl:call-template> 
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">&quot;Name&quot;</xsl:with-param>
        </xsl:call-template>
        <xsl:text>&quot;Bemerkung&quot;</xsl:text>
    <xsl:text>&#13;</xsl:text>
    <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="feld">
        <xsl:param name="wert"/>
        <xsl:value-of select="normalize-unicode($wert,'NFC')"/><xsl:text>&#x9;</xsl:text>
    </xsl:template>
        
    <xsl:template match="*/text()"/>
    
</xsl:stylesheet>
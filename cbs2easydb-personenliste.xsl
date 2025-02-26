<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
   
    <xsl:template match="//record">
        <xsl:variable name="ppn" select="tag[@id='003@']/sbf[@id='0']"/>
        <xsl:for-each select="tag[starts-with(@id,'028')]|tag[starts-with(@id,'029')]">
            <xsl:call-template name="feld"> <!-- PPN -->
                <xsl:with-param name="wert" select="$ppn"/>
            </xsl:call-template>
            <xsl:variable name="gndid" select="sbf[@id='0']"/>
            <xsl:variable name="gndfile" select="concat('gnd/gnd-',$gndid,'.xml')"/>
            <xsl:variable name="gnddata">
                <xsl:if test="(string-length($gndid) ge 1) and doc-available($gndfile)">
                    <xsl:copy-of
                        select="document($gndfile)/rdf:RDF/*"/> 
                    </xsl:if>
            </xsl:variable>
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
            <xsl:variable name="gndvolltext">
                <xsl:for-each select="$gnddata//(*:oldAuthorityNumber|*:label|*:variantName)[not(contains(.,'http'))]">
                    <xsl:sort/>
                    <xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
                </xsl:for-each>
            </xsl:variable>
            <xsl:if test="($gndname='') and (string-length($gndid) ge 1)"><xsl:message>Daten fehlen: <xsl:value-of select="$gndid"/></xsl:message></xsl:if>
            <xsl:variable name="gndjson">
                <xsl:if test="not($gndname='')">
                    <xsl:text>{&quot;frontendLanguage&quot;:&quot;de&quot;,&quot;_fulltext&quot;:{&quot;text&quot;:&quot;</xsl:text>
                    <xsl:value-of select="$gndvolltext"/>
                    <xsl:text>&quot;},</xsl:text>
                    <xsl:text>&quot;conceptURI&quot;:&quot;https://d-nb.info/</xsl:text>
                    <xsl:value-of select="$gndid"/>
                    <xsl:text>&quot;,&quot;_standard&quot;:{&quot;text&quot;:&quot;</xsl:text>
                    <xsl:value-of select="$gndname"/>
                    <xsl:text>&quot;},&quot;conceptName&quot;:&quot;</xsl:text>
                    <xsl:value-of select="$gndname"/>
                    <xsl:text>&quot;}</xsl:text>
                </xsl:if>
            </xsl:variable>
            <xsl:message><xsl:value-of select="$gndid"/><xsl:text> - </xsl:text><xsl:value-of select="$gndjson"/></xsl:message>
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
                <xsl:with-param name="wert" select="if (sbf[@id='4']) then (concat('$4:',sbf[@id='4'][1])) else (concat('$B:',sbf[@id='B'][1]))"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- Name -->
                <xsl:with-param name="wert" select="concat(if (sbf[@id='a']) then string-join((sbf[@id='c'],string-join((sbf[@id='a'],sbf[@id='d']),', ')),' ') else (sbf[@id='P']),
                    if (sbf[@id='l']) then concat(' &lt;',sbf[@id='l'],'&gt;') else ())"/>                
            </xsl:call-template>
            <xsl:call-template name="feld"> <!-- Bemerkung -->
                <xsl:with-param name="wert" select="sbf[@id='L']"/>                
            </xsl:call-template>           
        <xsl:text>&#13;</xsl:text>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">PPN</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="'GND-ID'"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="'GND-Name'"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="'GND-JSON'"/>
        </xsl:call-template> 
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="'Kategorie'"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="'Rolle'"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="'Name'"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert" select="'Bemerkung'"/>
        </xsl:call-template>
        <xsl:text>&#13;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="feld">
        <xsl:param name="wert"/>
        <xsl:value-of select="normalize-unicode($wert,'NFC')"/><xsl:text>&#x9;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
   
    <xsl:template match="//record">
        <xsl:call-template name="feld"> <!-- Objekttitel -->
            <xsl:with-param name="wert" select="string-join((tag[@id='021A']/sbf[@id='a'],tag[@id='021A']/sbf[@id='h']),' / ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Objektbeschreibung -->
            <xsl:with-param name="wert">
                <xsl:if test="tag[@id='046M']/sbf[@id='t']">
                    <xsl:text>Enthält: </xsl:text>
                </xsl:if>
                <xsl:value-of select="string-join(tag[@id='046M']/sbf[@id='t'],' - ')"/>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Umfang -->
            <xsl:with-param name="wert" select="string-join((tag[@id='034D']/sbf[@id='a'],tag[@id='034M']/sbf[@id='a'],tag[@id='034I']/sbf[@id='a'],tag[@id='034K']/sbf[@id='a']),' ; ')"/>
        </xsl:call-template>
        <xsl:variable name="signatur" select="tag[starts-with(@id,'209A') and (sbf[@id='f']='066')]/sbf[@id='a'][1]"/>
        <xsl:call-template name="feld"> <!-- Signatur -->
            <xsl:with-param name="wert" select="$signatur"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Jahr -->
            <xsl:with-param name="wert" select="tag[@id='011@']/sbf[@id='a']"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Ort -->
            <xsl:with-param name="wert" select="string-join(tag[@id='033A']/sbf[@id='p'],', ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Label -->
            <xsl:with-param name="wert" select="string-join(tag[@id='033A']/sbf[@id='n'],', ')"/>
        </xsl:call-template>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Objekttitel</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Objektbeschreibung</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Umfang</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Signatur</xsl:with-param>
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
        <xsl:text>&#13;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="feld">
        <xsl:param name="wert"/>
        <xsl:value-of select="translate(normalize-unicode($wert,'NFC'),'{@','')"/><xsl:text>&#x9;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
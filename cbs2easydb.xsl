<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
   
    <xsl:template match="//record">
        <xsl:call-template name="feld"> <!-- Objekttitel -->
            <xsl:with-param name="wert" select="tag[@id='021A']/sbf[@id='a']"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Titelergänzung ? -->
            <xsl:with-param name="wert" select="tag[@id='021A']/sbf[@id='h']"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Objektbeschreibung -->
            <xsl:with-param name="wert">
                <xsl:for-each select="tag[@id='046M']/sbf[@id='t']">
                    <xsl:text>Enthält: </xsl:text><xsl:value-of select="."/>
                    <xsl:if test="position() != last()"><xsl:text> </xsl:text></xsl:if>
                </xsl:for-each>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Signatur -->
            <xsl:with-param name="wert" select="tag[starts-with(@id,'209A') and (sbf[@id='f']='066')]/sbf[@id='a']"/>
        </xsl:call-template>
        
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Objekttitel</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Titelergänzung</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Objektbeschreibung</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Signatur</xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="feld">
        <xsl:param name="wert"/>
        <xsl:text>&quot;</xsl:text><xsl:value-of select="translate(normalize-unicode($wert,'NFC'),'@','')"/><xsl:text>&quot;&#x9;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
   
    <xsl:template match="//record">
        <xsl:call-template name="feld">
            <xsl:with-param name="wert" select="tag[@id='021A']/sbf[@id='a']"/>
        </xsl:call-template>
        <xsl:call-template name="feld">
            <xsl:with-param name="wert" select="tag[@id='021A']/sbf[@id='h']"/>
        </xsl:call-template>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="feld">
        <xsl:param name="wert"/>
        <xsl:text>&quot;</xsl:text><xsl:value-of select="$wert"/><xsl:text>&quot;&#x9;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
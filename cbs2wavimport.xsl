<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
   
    <xsl:template match="//record">
        <xsl:variable name="ppn" select="tag[@id='003@']/sbf[@id='0']"/>
        <xsl:variable name="signatur" select="tag[starts-with(@id,'209A') and (sbf[@id='f']='066')]/sbf[@id='a'][1]"/>
        <xsl:call-template name="feld"> <!-- PPN -->
            <xsl:with-param name="wert" select="$ppn"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Signatur -->
            <xsl:with-param name="wert" select="$signatur"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Objekttitel -->
            <xsl:with-param name="wert" select="string-join((string-join((string-join((tag[@id='021A']/sbf[@id='a'],tag[@id='021A']/sbf[@id='d']),' : '),tag[@id='021A']/sbf[@id='h']),' / '),
                string-join(tag[@id='033A']/sbf[@id='n'],', ')),' - ')"/>
        </xsl:call-template>
        <xsl:call-template name="feld"> <!-- Jahr -->
            <xsl:with-param name="wert" select="tag[@id='011@']/sbf[@id='a']"/>
        </xsl:call-template>
        <xsl:call-template name="feld"><xsl:with-param name="wert"> <!-- Namen -->
        <xsl:for-each select="tag[starts-with(@id,'028')]|tag[starts-with(@id,'029')]">
                <xsl:value-of select="concat(if (sbf[@id='a']) then string-join((sbf[@id='c'],string-join((sbf[@id='a'],sbf[@id='d']),', ')),' ') else (sbf[@id='P']),
                    if (sbf[@id='l']) then concat(' &lt;',sbf[@id='l'],'&gt;') else ())"/>
            <xsl:if test="position() != last()"><xsl:text> / </xsl:text></xsl:if>
        </xsl:for-each>
        </xsl:with-param></xsl:call-template>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">PPN</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Signatur</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Product</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Year</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="feld"> 
            <xsl:with-param name="wert">Artists</xsl:with-param>
        </xsl:call-template>
        <xsl:text>&#13;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="feld">
        <xsl:param name="wert"/>
        <xsl:value-of select="translate(normalize-unicode($wert,'NFC'),'{@','')"/><xsl:text>&#x9;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>
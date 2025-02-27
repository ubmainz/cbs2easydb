<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<xsl:template match="/">
    <root>
        <xsl:apply-templates/>
    </root>
</xsl:template>

<xsl:template match="//record">
    <i><xsl:value-of select="ppn"/></i>
</xsl:template>
    
</xsl:stylesheet>
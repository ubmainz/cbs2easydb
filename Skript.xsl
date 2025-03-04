<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output encoding="UTF-8" method="text"/>

    <xsl:template match="/dataroot">
        <xsl:apply-templates select="//Command"/>
    </xsl:template>

    <xsl:template match="Command">
        <xsl:value-of select="."/>
        <xsl:text>&#13;</xsl:text>
    </xsl:template>

</xsl:stylesheet>

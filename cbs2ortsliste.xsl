<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:output encoding="UTF-8" method="text"/>
    
    <xsl:template match="/">
        <xsl:variable name="liste" as="xs:string*">
            <xsl:apply-templates/>       
        </xsl:variable>
        <xsl:variable name="listesortiert" as="xs:string*">
            <xsl:perform-sort select="$liste">
                <xsl:sort lang="fr"/>
            </xsl:perform-sort>
        </xsl:variable>
        <xsl:value-of select="string-join(distinct-values($listesortiert),'&#13;')"/>
    </xsl:template>

    <xsl:template match="tag[@id='033A']/sbf[@id='p'][../sbf[@id='n']/not(contains(.,'(Distr.)'))]">
        <xsl:value-of select="translate(normalize-unicode(.,'NFC'),'[]{?','')"/>
    </xsl:template>

    <xsl:template match="*/text()"/>
    
</xsl:stylesheet>

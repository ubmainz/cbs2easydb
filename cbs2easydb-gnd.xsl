<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:gndo="http://d-nb.info/standards/elementset/gnd#"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output  method="text" encoding="UTF-8"/>
   
    <xsl:template match="/">
        <xsl:for-each-group select="//(tag[starts-with(@id,'028')]|tag[starts-with(@id,'029')])/sbf[@id='0']" group-by=".">
            <xsl:variable name="gndid" select="current-grouping-key()"/>
            <xsl:variable name="gndfile" select="concat('gnd/gnd-',$gndid,'.xml')"/>
            <xsl:variable name="gndurl" select="concat('http://lobid.org/gnd/',$gndid)"/>
                <xsl:if test="string-length($gndid) ge 1">
                    <xsl:message><xsl:text>GND: </xsl:text><xsl:value-of select="$gndurl"/></xsl:message>
                    <xsl:if test="not(doc-available($gndfile))">
                        <xsl:if test="doc-available(concat($gndurl,'.rdf'))">
                            <xsl:variable name="data">
                                <xsl:copy-of
                                    select="doc(concat($gndurl,'.rdf'))/*"
                                />
                            </xsl:variable>                            
                            <xsl:result-document href="{$gndfile}" method="xml" encoding="UTF-8" normalization-form="NFC">
                                <xsl:copy-of select="$data"/>
                            </xsl:result-document>
                            <xsl:call-template name="sleep"/>
                        </xsl:if>
                    </xsl:if>
                </xsl:if>
            <xsl:message><xsl:value-of select="$gndfile"/> : <xsl:value-of select="doc-available($gndfile)"/></xsl:message>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template name="sleep" xmlns:thread="java.lang.Thread">
        <xsl:value-of select="thread:sleep(500)"/>        
    </xsl:template>
    
</xsl:stylesheet>
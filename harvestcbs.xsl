<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ubmz="http://www.ub.uni-mainz.de"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs ubmz" version="2.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>

    <xsl:template match="/">
        <root>
            <xsl:apply-templates/>
        </root>
    </xsl:template>

    <xsl:template match="i">
        <xsl:message>
            <xsl:text>CBS-Record: </xsl:text>
            <xsl:value-of select="."/>
        </xsl:message>
        <xsl:variable name="url" select="ubmz:cbsurl(.)"/>
        <xsl:choose>
            <xsl:when test="doc-available($url)">
                <record>
                    <xsl:variable name="cbs-dok">
                        <xsl:copy-of select="doc($url)"/>
                    </xsl:variable>
                    <xsl:copy-of select="$cbs-dok"/>
                </record>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>Download failed: <xsl:value-of select="$url"/></xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="sleep"/>
    </xsl:template>

    <xsl:function name="ubmz:cbsurl">
        <xsl:param name="ppn" as="xs:string"/>
        <xsl:sequence
            select="concat('http://hebis.rz.uni-frankfurt.de/HEBCGI/dataExportXML.ksh?ppn=',$ppn,'&amp;iln=25')"
        />
    </xsl:function>

    <xsl:template name="sleep" xmlns:thread="java.lang.Thread">
        <xsl:value-of select="thread:sleep(100)"/>
    </xsl:template>

</xsl:stylesheet>

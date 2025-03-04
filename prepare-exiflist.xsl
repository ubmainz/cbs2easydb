<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:et="http://ns.exiftool.org/1.0/"
    et:toolkit="Image::ExifTool 12.57" xmlns:ExifTool="http://ns.exiftool.org/ExifTool/1.0/"
    xmlns:System="http://ns.exiftool.org/File/System/1.0/"
    xmlns:File="http://ns.exiftool.org/File/1.0/" xmlns:RIFF="http://ns.exiftool.org/RIFF/RIFF/1.0/"
    xmlns:ID3v2_3="http://ns.exiftool.org/ID3/ID3v2_3/1.0/"
    xmlns:Composite="http://ns.exiftool.org/Composite/1.0/" version="2.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes"/>

    <xsl:template match="/">
        <root>
            <xsl:apply-templates/>
        </root>

    </xsl:template>

    <xsl:template match="record">
        <record>
            <xsl:copy-of select="ppn"/>
            <file>
                <xsl:value-of select="rdf:RDF/rdf:Description/@rdf:about"/>
            </file>
            <xsl:copy-of select="rdf:RDF/rdf:Description/*"/>
        </record>
    </xsl:template>

</xsl:stylesheet>

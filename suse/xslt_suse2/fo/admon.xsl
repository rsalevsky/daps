<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  Purpose:
    Re-Style admonitions

  Author(s):  Stefan Knorr <sknorr@suse.de>
              Thomas Schraitle <toms@opensuse.org>

  Copyright:  2013, Stefan Knorr, Thomas Schraitle

-->
<!DOCTYPE xsl:stylesheets 
[
  <!ENTITY % fontsizes SYSTEM "font-sizes.ent">
  %fontsizes;
]>
<xsl:stylesheet  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">


<xsl:template match="note|important|warning|caution|tip">
  <xsl:call-template name="graphical.admonition"/>
</xsl:template>

<xsl:template name="admon.symbol.letter">
  <xsl:param name="node" select="."/>
  <xsl:choose>
    <xsl:when test="local-name($node)='note'"><xsl:text>N</xsl:text></xsl:when>
    <xsl:when test="local-name($node)='warning'"><xsl:text>W</xsl:text></xsl:when>
    <xsl:when test="local-name($node)='caution'"><xsl:text>C</xsl:text></xsl:when>
      <!-- We don't have different symbols for the above two (yet). -->
    <xsl:when test="local-name($node)='tip'"><xsl:text>T</xsl:text></xsl:when>
    <xsl:when test="local-name($node)='important'"><xsl:text>I</xsl:text></xsl:when>
    <xsl:otherwise>N</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="admon.symbol.color">
  <xsl:param name="node" select="."/>
  <xsl:choose>
    <xsl:when test="local-name($node)='note'"><xsl:text>333333</xsl:text></xsl:when>
    <xsl:when test="local-name($node)='warning'"><xsl:text>8C0000</xsl:text></xsl:when>
    <xsl:when test="local-name($node)='caution'"><xsl:text>8C0000</xsl:text></xsl:when>
      <!-- We don't have different symbols for the above two (yet). -->
    <xsl:when test="local-name($node)='tip'"><xsl:text>439539</xsl:text></xsl:when>
    <xsl:when test="local-name($node)='important'"><xsl:text>BB7B03</xsl:text></xsl:when>
    <xsl:otherwise>N</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="graphical.admonition">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="graphic.width">36pt</xsl:variable>
  
  <fo:block id="{$id}"
            xsl:use-attribute-sets="graphical.admonition.properties">
    <fo:list-block provisional-distance-between-starts="{$graphic.width} + 18pt"
                    provisional-label-separation="18pt">
      <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block font-family="'SUSE Docudings', sans-serif">
              <xsl:attribute name="font-size"><xsl:value-of select="$graphic.width"/></xsl:attribute>
                <!-- Let's assume that the admonition icons fit into a square -->
              <xsl:attribute name="color">#<xsl:call-template name="admon.symbol.color"/></xsl:attribute>
            <xsl:call-template name="admon.symbol.letter"/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <xsl:if test="$admon.textlabel != 0 or title or info/title">
              <fo:block xsl:use-attribute-sets="admonition.title.properties">
                <xsl:apply-templates select="." mode="object.title.markup">
		  <xsl:with-param name="allow-anchors" select="1"/>
		</xsl:apply-templates>
              </fo:block>
            </xsl:if>
            <fo:block xsl:use-attribute-sets="admonition.properties">
              <xsl:apply-templates/>
            </fo:block>
          </fo:list-item-body>
      </fo:list-item>
    </fo:list-block>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
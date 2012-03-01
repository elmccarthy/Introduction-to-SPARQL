<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns="http://www.w3.org/1999/xhtml"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output
 doctype-public="-//W3C//DTD XHTML 1.1//EN"
 doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
 version="1.0"
 method="xml"
 encoding="UTF-8"
 indent="yes"/> 

<!-- the identity template -->
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<!-- template for the head section. -->
<xsl:template match="xhtml:head">
  <xsl:copy>
    <link rel="stylesheet" type="text/css" href="/style/3col-2011/all.css"/>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

<!-- template for the body section.  -->
<xsl:template match="xhtml:body">
  <xsl:copy>
    <div id="frame1">
      <div id="header">
        <h1>ELM online</h1>
      </div> <!-- header -->
      <div id="right-column">
        <div id="middle-column">
          <div id="left-column">
            <div id="content">
    <xsl:apply-templates select="@*|node()"/>
            </div> <!-- content -->
            <div id="left-content">
              &#160; <!-- This column appears second in the HTML. -->
            </div> <!-- left-content -->
            <div id="right-content">
              &#160; <!-- This column appears third in the HTML. -->
            </div> <!-- right-content -->
          </div> <!-- left-column -->
        </div> <!-- middle-column -->
      </div> <!-- right-column -->
      <div id="footer">
        <p>valid <a href="http://validator.w3.org/check/referer">HTML</a>
         and <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>.</p>
      </div> <!-- footer -->
    </div> <!-- frame1 -->
  </xsl:copy>
</xsl:template>

<!-- strip invalid markdown attribute
 (which shouldn't make it through, but does...) -->
<xsl:template match="@markdown"/>

</xsl:stylesheet>

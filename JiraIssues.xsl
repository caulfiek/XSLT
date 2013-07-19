<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
  version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
	xmlns:myJavaScript ="urn:internal:my-javascript" 
	extension-element-prefixes="msxsl"
	exclude-result-prefixes="myJavaScript"> 
				
    <msxsl:script language="JScript" implements-prefix="myJavaScript">
    <![CDATA[
        function GetCurrentDateTime()
        {
        var currentTime = new Date();
        var month = currentTime.getMonth() + 1;
        var day = currentTime.getDate();
        var year = currentTime.getFullYear();
        return(month + "/" + day + "/" + year);
        }
    ]]>
    </msxsl:script>				
	
<xsl:output method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" media-type="application/html+xml" encoding="utf-8" omit-xml-declaration="yes" indent="no"/>

<!-- K Caulfield - July 2013 : updated for Jira Issues List -->

	<xsl:template name="string-replace"> 
	<xsl:param name="string1" select="''" /> 
	<xsl:param name="string2" select="''" /> 
	<xsl:param name="replacement" select="''" /> 
	<xsl:param name="global" select="true()" /> 
	<xsl:choose> 
		<xsl:when test="contains($string1, $string2)"> 
			<xsl:value-of select="substring-before($string1, $string2)" /> 
			<xsl:value-of select="$replacement" /> 
			<xsl:variable name="rest" select="substring-after($string1, $string2)" /> 
				<xsl:choose> <xsl:when test="$global"> 
					<xsl:call-template name="string-replace"> 
					<xsl:with-param name="string1" select="$rest" /> 
					<xsl:with-param name="string2" select="$string2" /> 
					<xsl:with-param name="replacement" select="$replacement" /> 
					<xsl:with-param name="global" select="$global" /> 
				</xsl:call-template> 
				</xsl:when> 
				<xsl:otherwise> 
					<xsl:value-of select="$rest" /> 
				</xsl:otherwise> 
				</xsl:choose> 
				</xsl:when> 
				<xsl:otherwise> 
					<xsl:value-of select="$string1" /> 
				</xsl:otherwise> 
				</xsl:choose>
	</xsl:template>
		
	<xsl:template match="rss/channel">

	<html>
		<head>
			<!--<link rel="stylesheet" href="chives-tables.css" />-->
			<style type="text/css">
			html, body { height: 100%; width: 100%}
			body, td {font-size: 10pt;}
			</style>	
		</head>
		<body style="font-family: Arial">
		<h2>My Project name here - JIRA Issues: <xsl:value-of select="myJavaScript:GetCurrentDateTime()"/></h2>
			
			<table id="MainTable" summary="JIRA Issues 2013" style="table-layout: fixed; width: 1100px">
			<colgroup>
			    <col style="width: 20%;"/>
				<col style="width: 5%;"/>
				<col style="width: 5%;"/>
				<col style="width: 5%;"/>
				<col style="width: 35%;"/>
				<col style="width: 30%;"/>
			</colgroup>
				<xsl:for-each select="item">
				<xsl:sort select="key/@id"/>				
						<tr style="text-align: left;">
							<th valign="top" style="text-align: left;">
							<a class="info" href="{link}">
							<xsl:value-of select="title" /></a></th>
							<th valign="top" style="text-align: left;">Type</th>
							<th valign="top" style="text-align: left;">Label</th>
							<th valign="top" style="text-align: left;">Status</th>
							<th valign="top" style="text-align: left;">Description</th>
							<th valign="top" style="text-align: left;">Comments</th>
						</tr>			
						<tr style="text-align: left;">
							<td></td>
							<td valign="top"><xsl:value-of select="type" /></td>
							<td valign="top"><xsl:value-of select="labels/label" /></td>
							<td valign="top"><xsl:value-of select="status" /></td>
							<td valign="top"><xsl:value-of select="description" disable-output-escaping="yes" /></td>
							<td valign="top">
							<table>
								<xsl:for-each select="comments/comment">
									<tr><td>
										<xsl:value-of select="." disable-output-escaping="yes" />
									</td></tr>
								</xsl:for-each>
							</table>
							</td>
						</tr>
						<tr style="text-align: left;"/>
				</xsl:for-each>
			</table>		

		</body>
	</html>
	</xsl:template>

</xsl:stylesheet>

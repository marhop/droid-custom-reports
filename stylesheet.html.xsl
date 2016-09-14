<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" />

<xsl:param name="reportDir" select="'report'" />

<xsl:template match="/Report">
<html lang="en">
    <head>
        <title>DROID Report: <xsl:value-of select="Title" /></title>
        <style type="text/css">
            html {
                font-family: sans-serif;
            }
            dt {
                margin-top: 0.5rem;
                margin-bottom: 0.2rem;
            }
            table {
                border-bottom: 1px solid #F2F2F2;
                border-collapse: collapse;
            }
            tr:nth-child(odd) {
                background-color: #F2F2F2;
            }
            th, td {
                text-align: left;
                padding: 0.2rem;
                border-left: 2px solid #FFFFFF;
            }
        </style>
    </head>
    <body>
        <xsl:apply-templates select="Title" />
        <xsl:apply-templates select="Profiles/Profile" />
    </body>
</html>
</xsl:template>

<xsl:template match="Title">
    <h1>DROID Report: <xsl:value-of select="." /></h1>
</xsl:template>

<xsl:template match="Profile">
    <section>
        <h2>Profile: <xsl:value-of select="Name" /></h2>
        <h3>Profile Metadata</h3>
        <dl>
            <dt>Resources</dt>
            <xsl:apply-templates select="ProfileSpec/Resources/*" />
            <dt>Date of analysis</dt>
            <dd><xsl:value-of select="StartDate" /></dd>
            <dt>Binary signature file</dt>
            <dd>
                <xsl:value-of select="SignatureFileName" />
                <xsl:text> (version </xsl:text>
                <xsl:value-of select="SignatureFileVersion" />
                <xsl:text>)</xsl:text>
            </dd>
            <dt>Container signature file</dt>
            <dd>
                <xsl:value-of select="ContainerSignatureFileName" />
                <xsl:text> (version </xsl:text>
                <xsl:value-of select="ContainerSignatureFileVersion" />
                <xsl:text>)</xsl:text>
            </dd>
            <dt>Maximum bytes to scan at the start and end of files (a
                negative value means unlimited scanning)</dt>
            <dd><xsl:value-of select="MaxBytesToScan" /></dd>
            <dt>Analyse content of archive files (zip, tar, gzip)</dt>
            <dd><xsl:value-of select="ProcessArchiveFiles" /></dd>
            <dt>Analyse content of web archive files (arc, warc)</dt>
            <dd><xsl:value-of select="ProcessWebArchiveFiles" /></dd>
        </dl>
        <h3>Profile Results</h3>
        <xsl:apply-templates select="../../ReportItems/ReportItem">
            <xsl:with-param name="profileId" select="@Id" />
        </xsl:apply-templates>
    </section>
</xsl:template>

<xsl:template match="ProfileSpec/Resources/*">
    <dd><xsl:value-of select="Uri" /></dd>
</xsl:template>

<xsl:template match="ReportItem">
    <xsl:param name="profileId" />
    <h4><xsl:value-of select="Specification/Description" /></h4>
    <table>
        <tr>
            <xsl:apply-templates
                select="Specification/GroupByFields/GroupByField" />
            <th class="result">COUNT</th>
            <th class="result">AVG_SIZE</th>
        </tr>
        <!-- Show groups where this profile is mentioned. -->
        <xsl:apply-templates
            select="Groups/Group[ProfileSummaries/ProfileSummary[@Id =
            $profileId]]">
            <xsl:with-param name="profileId" select="$profileId" />
        </xsl:apply-templates>
    </table>
</xsl:template>

<xsl:template match="GroupByField">
    <th class="group"><xsl:value-of select="Field" /></th>
</xsl:template>

<xsl:template match="Group">
    <xsl:param name="profileId" />
    <tr>
        <!-- Grouping fields (e.g., file format). -->
        <xsl:apply-templates select="Values/Value" />
        <!-- Actual results for this profile (e.g., file count). -->
        <xsl:apply-templates
            select="ProfileSummaries/ProfileSummary[@Id = $profileId]" />
    </tr>
</xsl:template>

<xsl:template match="Value">
    <td class="group"><xsl:value-of select="." /></td>
</xsl:template>

<xsl:template match="ProfileSummary">
    <td class="result"><xsl:apply-templates select="Count" /></td>
    <td class="result"><xsl:apply-templates select="Average" /></td>
</xsl:template>

<xsl:template match="Count">
    <xsl:value-of select="." />
</xsl:template>

<xsl:template match="Average">
    <xsl:value-of select="format-number(. div 1048576, '##0.00')" />
    <xsl:text> MB</xsl:text>
</xsl:template>

<xsl:template match="@*|node()">
    <!-- Catchall pattern for ignoring everything we don't need. -->
</xsl:template>

</xsl:stylesheet>

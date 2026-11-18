<?xml0 version="1.0" encoding="UTF-8"?>
<!-- matricule - Vos Prénoms -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Liste des étudiants</title>
            </head>
            <body>
                <ul>
                    <xsl:apply-templates select="//etudiant">
    <xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending"/>
</xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="etudiant">
        <li>
            <xsl:value-of select="prenom"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="nom"/>
        </li>
    </xsl:template>
</xsl:stylesheet>
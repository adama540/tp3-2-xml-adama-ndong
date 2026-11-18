<?xml version="1.0" encoding="UTF-8"?>
<!-- matricule - Votre Nom -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- Paramètre du seuil de réussite -->
    <xsl:param name="seuil" select="10"/>

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <title>Liste des étudiants - Licence 1</title>
                <link rel="stylesheet" href="style.css"/>
            </head>
            <body>
                <header>
                    <h1>Promotion Licence 1</h1>
                    <p>Année 2026-2027 — ISEP Diamniadio</p>
                </header>
                
                <main>
                    <!-- Étape 7 : Blocs de chiffres clés -->
                    <div class="stats">
                        <div class="carte">
                            <span class="valeur"><xsl:value-of select="count(//etudiant)"/></span>
                            <span class="legende">étudiants</span>
                        </div>
                        <div class="carte">
                            <span class="valeur">
                                <xsl:value-of select="count(//etudiant[(sum(notes/note) div count(notes/note)) &gt;= $seuil])"/>
                            </span>
                            <span class="legende">nombre d'admis</span>
                        </div>
                        <div class="carte">
                            <span class="valeur">
                                <xsl:value-of select="format-number(sum(//note[@matiere='XML']) div count(//note[@matiere='XML']), '0.00')"/>
                            </span>
                            <span class="legende">moyenne en XML</span>
                        </div>
                        <div class="carte">
                            <span class="valeur"><xsl:value-of select="count(//etudiant[not(email)])"/></span>
                            <span class="legende">emails manquants</span>
                        </div>
                    </div>

                    <!-- Tableau global ou unique -->
                    <table>
                        <thead>
                            <tr>
                                <th>Rang</th>
                                <th>Matricule</th>
                                <th>Nom</th>
                                <th>Prénom</th>
                                <th>Classe</th>
                                <th>Email</th>
                                <th>Moyenne</th>
                                <th>Résultat</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Étape 6 : Tri par moyenne décroissante -->
                            <xsl:apply-templates select="//etudiant">
                                <xsl:sort select="sum(notes/note) div count(notes/note)" data-type="number" order="descending"/>
                            </xsl:apply-templates>
                        </tbody>
                    </table>
                </main>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="etudiant">
        <!-- Étape 9 : Ajout de la classe major pour le 1er du classement -->
        <tr>
            <xsl:if test="position() = 1">
                <xsl:attribute name="class">major</xsl:attribute>
            </xsl:if>
            
            <td class="rang"><xsl:value-of select="position()"/></td>
            <td><xsl:value-of select="@matricule"/></td>
            <td><xsl:value-of select="nom"/></td>
            <td><xsl:value-of select="prenom"/></td>
            <td><xsl:value-of select="@classe"/></td>
            <td>
                <xsl:choose>
                    <xsl:when test="email">
                        <xsl:value-of select="email"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="absent">non renseigné</span>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="moyenne">
                <xsl:value-of select="format-number(sum(notes/note) div count(notes/note), '0.00')"/>
            </td>
            <td>
                <xsl:variable name="moy" select="sum(notes/note) div count(notes/note)"/>
                <xsl:choose>
                    <xsl:when test="$moy &gt;= $seuil">
                        <span class="badge reussite">admis</span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="badge echec">à revoir</span>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
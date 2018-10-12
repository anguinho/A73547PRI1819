<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:output method="html" indent="yes"/> 
    
    <xsl:template match="/">
        <xsl:result-document href="website/index.html">
            <html>
                <head>
                    <meta charset="UTF-8"/>
                    <title>AMD</title>
                </head>
                <body>
                    <h1>Arquivo de Musica Digital</h1>
                    <hr/>
                    
                    <ul>
                        <xsl:apply-templates select="//tipo[not(preceding::tipo=.)]">
                            <xsl:sort select="."/>
                        </xsl:apply-templates>
                    </ul>
                    
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:apply-templates select="//obra" mode="obra"/>
        
    </xsl:template>
    
    <xsl:template match="tipo">
        <xsl:variable name="t" select="."/>
        <li><xsl:value-of select="."/></li>
        <ol>
            <xsl:for-each select="//obra[tipo=$t]">
                <xsl:sort select="titulo"/>
                    
                <li>
                    <a href="http://localhost:7456/obra?id={@id}"><xsl:value-of select="titulo"/></a>
                </li>                
                
            </xsl:for-each>
        </ol>
    </xsl:template>
    
    <xsl:template match="obra" mode="obra">
        <xsl:result-document href="website/html/obra{@id}.html">
            <html>
                <head>
                    <meta charset="UTF-8"/>
                </head>
                <body>
                    <h2><xsl:value-of select="titulo"/></h2>
                    <h3><xsl:value-of select="tipo"/></h3>
                    <xsl:if test="compositor">
                        <p><b>Compositor: </b><xsl:value-of select="compositor"/></p>
                    </xsl:if>
                    <xsl:if test="arranjo">
                        <p><b>Arranjo de: </b><xsl:value-of select="arranjo"/></p>
                    </xsl:if>
                    
                    <xsl:if test="instrumentos/instrumento">
                    <h4>Partituras Disponiveis</h4>
                        <table border="1">
                            <tr>
                                <th>Instrumento</th><th>Afinação</th><th>Voz</th><th>Clave</th><th>Doc</th>
                            </tr>
                            <xsl:for-each select="instrumentos/instrumento">
                                <tr>
                                    <th><xsl:value-of select="designacao"/></th>                                
                                    <th><xsl:value-of select="partitura/@afinacao"/></th>
                                    <th><xsl:value-of select="partitura/@voz"/></th>                                
                                    <th><xsl:value-of select="partitura/@clave"/></th>
                                    <th><xsl:value-of select="partitura/@path"/></th>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </xsl:if>
                    <p>[<a href="http://localhost:7456/obra">INDEX</a>]</p>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>

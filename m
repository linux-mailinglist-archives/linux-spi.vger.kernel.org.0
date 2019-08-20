Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF395FA4
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfHTNOb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 09:14:31 -0400
Received: from mail-ed1-f99.google.com ([209.85.208.99]:33586 "EHLO
        mail-ed1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbfHTNOa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 09:14:30 -0400
Received: by mail-ed1-f99.google.com with SMTP id s15so6282321edx.0
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 06:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=qIM7DP1hff4WJ5PVmq5akQhWbafrN7JarSuD6v/Lhnk=;
        b=gPrcKQX8rhXGuFOL6DnVuNd7hs6MDh40LUiVmrmsd/JY1tSBx8Zs21fgE0NvqUQYxX
         b/ZhtB1VbHxPACGG7VAetdfrmfAT+HuVbROm+u9p+h8C8smlxpnHPa/OFTt6wvr1RFur
         tHdUBXgtiROxy1N4V8EbjEkascGz0VS0++kBu17skB49uXES8upTcEgn1paflpclsH6z
         htAoF9DrO8j/TVoXAXm5aEjP23BJoETT57EMLNJVnDe0Luho+gUEupDjaBV/ID/ZjEvj
         5ERcd8gDh3/W4USqcXH/EXvnaA6xOmkXKIS0wo/G93GFamx7bJsuEIHWkyPAWR7PurS2
         c5iA==
X-Gm-Message-State: APjAAAUWUNZ0Eh4jMHcp8K1q0NsLOIVt9HPfnJPfb/T4Z43E/79ja8cm
        3x+0ggcwjLWGitJGBEeA8z1uv+KhqG8EKp1Ap8z/t8pTusvHSBUqrJ9KI1rwfssovg==
X-Google-Smtp-Source: APXvYqxab0LOPw2P0VewWMjkGx7suZwcpKwVpCJF4rTZTrNM6vcPHadvPx2F5J4CjFyEIXQArllHHpldLf0K
X-Received: by 2002:a50:fd82:: with SMTP id o2mr31240167edt.80.1566306868312;
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id f12sm86360ejf.39.2019.08.20.06.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:14:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03xz-0002M6-Tu; Tue, 20 Aug 2019 13:14:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6C6E2274314F; Tue, 20 Aug 2019 14:14:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Change usage pattern of SPI_MCR_* and SPI_CTAR_* macros" to the spi tree
In-Reply-To: <20190818180115.31114-6-olteanv@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820131427.6C6E2274314F@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 14:14:27 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-dspi: Change usage pattern of SPI_MCR_* and SPI_CTAR_* macros

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 06d5dd29976fb49f3236b1e66142680619ea259d Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Sun, 18 Aug 2019 21:01:06 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Change usage pattern of SPI_MCR_* and
 SPI_CTAR_* macros

These are macros that accept 0 or 1 as argument (a boolean value). Their
use encourages the abuse of complex ternary operations inside their
argument list, which detracts from the code readability. Replace these
with simple if-else statements.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190818180115.31114-6-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 923ee414d1ae..b0c546841260 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -39,9 +39,9 @@
 
 #define SPI_CTAR(x)			(0x0c + (((x) & GENMASK(1, 0)) * 4))
 #define SPI_CTAR_FMSZ(x)		(((x) << 27) & GENMASK(30, 27))
-#define SPI_CTAR_CPOL(x)		(((x) << 26) & GENMASK(26, 26))
-#define SPI_CTAR_CPHA(x)		(((x) << 25) & GENMASK(25, 25))
-#define SPI_CTAR_LSBFE(x)		(((x) << 24) & GENMASK(24, 24))
+#define SPI_CTAR_CPOL			BIT(26)
+#define SPI_CTAR_CPHA			BIT(25)
+#define SPI_CTAR_LSBFE			BIT(24)
 #define SPI_CTAR_PCSSCK(x)		(((x) << 22) & GENMASK(23, 22))
 #define SPI_CTAR_PASC(x)		(((x) << 20) & GENMASK(21, 20))
 #define SPI_CTAR_PDT(x)			(((x) << 18) & GENMASK(19, 18))
@@ -587,7 +587,7 @@ static void dspi_tcfq_write(struct fsl_dspi *dspi)
 		 */
 		u32 data = dspi_pop_tx(dspi);
 
-		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE(1)) {
+		if (dspi->cur_chip->ctar_val & SPI_CTAR_LSBFE) {
 			/* LSB */
 			tx_fifo_write(dspi, data & 0xFFFF);
 			tx_fifo_write(dspi, data >> 16);
@@ -791,18 +791,22 @@ static int dspi_setup(struct spi_device *spi)
 	/* Set After SCK delay scale values */
 	ns_delay_scale(&pasc, &asc, sck_cs_delay, clkrate);
 
-	chip->ctar_val = SPI_CTAR_CPOL(spi->mode & SPI_CPOL ? 1 : 0)
-		| SPI_CTAR_CPHA(spi->mode & SPI_CPHA ? 1 : 0);
+	chip->ctar_val = 0;
+	if (spi->mode & SPI_CPOL)
+		chip->ctar_val |= SPI_CTAR_CPOL;
+	if (spi->mode & SPI_CPHA)
+		chip->ctar_val |= SPI_CTAR_CPHA;
 
 	if (!spi_controller_is_slave(dspi->master)) {
-		chip->ctar_val |= SPI_CTAR_LSBFE(spi->mode &
-						 SPI_LSB_FIRST ? 1 : 0)
-			| SPI_CTAR_PCSSCK(pcssck)
-			| SPI_CTAR_CSSCK(cssck)
-			| SPI_CTAR_PASC(pasc)
-			| SPI_CTAR_ASC(asc)
-			| SPI_CTAR_PBR(pbr)
-			| SPI_CTAR_BR(br);
+		chip->ctar_val |= SPI_CTAR_PCSSCK(pcssck) |
+				  SPI_CTAR_CSSCK(cssck) |
+				  SPI_CTAR_PASC(pasc) |
+				  SPI_CTAR_ASC(asc) |
+				  SPI_CTAR_PBR(pbr) |
+				  SPI_CTAR_BR(br);
+
+		if (spi->mode & SPI_LSB_FIRST)
+			chip->ctar_val |= SPI_CTAR_LSBFE;
 	}
 
 	spi_set_ctldata(spi, chip);
@@ -968,9 +972,10 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 
 static void dspi_init(struct fsl_dspi *dspi)
 {
-	unsigned int mcr = SPI_MCR_PCSIS |
-		(dspi->devtype_data->xspi_mode ? SPI_MCR_XSPI : 0);
+	unsigned int mcr = SPI_MCR_PCSIS;
 
+	if (dspi->devtype_data->xspi_mode)
+		mcr |= SPI_MCR_XSPI;
 	if (!spi_controller_is_slave(dspi->master))
 		mcr |= SPI_MCR_MASTER;
 
-- 
2.20.1


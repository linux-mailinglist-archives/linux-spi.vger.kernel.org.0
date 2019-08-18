Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164EB91895
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRSB2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35694 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRSB1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so1071865wmg.0
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dMd8SL3/ToircFsAHhuf7tVgDL5zEJPDGSOJvLGpuzg=;
        b=tcmk3jh/PMMkcpdkATLDos80cjAZ715jtyp1oOQqImXqEzMAp0MLVIR8qfzMHCSzw+
         XJ9nuhVXum3AQci2jC+vGrMIR9DDmTQQW95jywt4aPh9Yk+WVBlgIefIp8tXTOJ5oSSl
         mrybzeUAAaFFKW45FOhiWDHf+E/zDZRZwqofHfqZuAw3qHILgchJFlRIg3V9UnrRENrB
         6AzbE3xAQcwmy+FMFciPo9SPYaMvHJ4KZYv8Rlf0mtgax8MzLDb7yW0y5FAcEVzTUSvN
         zbnRgAPvO/hZO4qCQy9F7cmTdxPFSogjcqAlmWEcU2kpfTOYqZAUwuU5pednP/BNQZYx
         Z1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dMd8SL3/ToircFsAHhuf7tVgDL5zEJPDGSOJvLGpuzg=;
        b=scQBDyWkGT2M4H/UHKssH6sp/70kmUxP16MqoV0CG0GyINXL2UxfA8nuuJ1hekN408
         54W/xCwSbmB0x/9+Jod4C1AzzgBdpIUvrMFtHZmH8bzsKF+rbXx9gYp0fKGTnl782njF
         uTYUDPU2dr4wTey6clByqAJ71hwJOVKmVxFvY0LLFApk/pq7mbANG4H84PNVvf0cZojd
         zO5whmFTaKu2W3bLpcdYE+Tske37hpGO1SMwTkalRqoRYPG24P0Hu7Nr+Pcvo1TvfcQD
         4mb5psilCuiKjd0/MS/uGo9GfrWxHoHncLnnXj5gZfaHcDmqAYvrpVpDyV1PIKzNLV2G
         r+zw==
X-Gm-Message-State: APjAAAVKa3+SvIe0XdglmwsUY90TShkxO8OMsgVsT6rbdUf/AgdnNmvp
        /ofEUhbJ99SJ/PII7597Z3Y=
X-Google-Smtp-Source: APXvYqz7aFzTxaYdBVpAWyWOIQzde5qyZ6YqzVcel9WBTvVLmWtiYmSDtQm8EIBSZxzEPA5pNRI3cA==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr16365057wmh.65.1566151285030;
        Sun, 18 Aug 2019 11:01:25 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:24 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 05/14] spi: spi-fsl-dspi: Change usage pattern of SPI_MCR_* and SPI_CTAR_* macros
Date:   Sun, 18 Aug 2019 21:01:06 +0300
Message-Id: <20190818180115.31114-6-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These are macros that accept 0 or 1 as argument (a boolean value). Their
use encourages the abuse of complex ternary operations inside their
argument list, which detracts from the code readability. Replace these
with simple if-else statements.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
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
2.17.1


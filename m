Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1BA2F6198
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbhANNK0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 08:10:26 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:22878 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbhANNK0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 08:10:26 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DGl5X74c3z9v0YY;
        Thu, 14 Jan 2021 14:09:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gDsXNkuQusb8; Thu, 14 Jan 2021 14:09:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DGl5X5zTpz9v0Y9;
        Thu, 14 Jan 2021 14:09:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46E4A8B803;
        Thu, 14 Jan 2021 14:09:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2Ak7H_t9Jp6A; Thu, 14 Jan 2021 14:09:38 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A2C6B8B802;
        Thu, 14 Jan 2021 14:09:37 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 5AD1C6637F; Thu, 14 Jan 2021 13:09:37 +0000 (UTC)
Message-Id: <6b51cc2bfbca70d3e9b9da7b7aa4c7a9d793ca0e.1610629002.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] spi: fsl: Fix driver breakage when SPI_CS_HIGH is not set in
 spi->mode
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-spi@vger.kernel.org
Date:   Thu, 14 Jan 2021 13:09:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 766c6b63aa04 ("spi: fix client driver breakages when using GPIO
descriptors") broke fsl spi driver.

As now we fully rely on gpiolib for handling the polarity of
chip selects, the driver shall not alter the GPIO value anymore
when SPI_CS_HIGH is not set in spi->mode.

Fixes: 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-spi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 649766808caf..9e297b2715f6 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -115,14 +115,13 @@ static void fsl_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	struct fsl_spi_platform_data *pdata;
-	bool pol = spi->mode & SPI_CS_HIGH;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
 
 	pdata = spi->dev.parent->parent->platform_data;
 
 	if (value == BITBANG_CS_INACTIVE) {
 		if (pdata->cs_control)
-			pdata->cs_control(spi, !pol);
+			pdata->cs_control(spi, false);
 	}
 
 	if (value == BITBANG_CS_ACTIVE) {
@@ -134,7 +133,7 @@ static void fsl_spi_chipselect(struct spi_device *spi, int value)
 		fsl_spi_change_mode(spi);
 
 		if (pdata->cs_control)
-			pdata->cs_control(spi, pol);
+			pdata->cs_control(spi, true);
 	}
 }
 
-- 
2.25.0


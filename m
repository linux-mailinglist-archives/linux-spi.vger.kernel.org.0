Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9D3CBBC7
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhGPSYd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 14:24:33 -0400
Received: from phobos.denx.de ([85.214.62.61]:47576 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhGPSYd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 14:24:33 -0400
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F360B82BE8;
        Fri, 16 Jul 2021 20:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626459696;
        bh=TfWK2xZpHRXDlEcAqc6kAUwVsEGVT3TDYS/oVZ/+iSw=;
        h=From:To:Cc:Subject:Date:From;
        b=NqTwREvSYY04hRUbqExtwPLMUGZn0ksHtK2SfX2tJOOBaeTidrB/hzv2fwWkq0DWJ
         A+KrXakQ0bsqTgNM71BN/sCSC0E2bb/uXDpDv/w2a0Q3xeZInh933P6sWwxWPVd1Dp
         S48WV3qk1rcFqvCqOUy7k02bF2rOPHaW1XcLpk6X8ncnG9Kwp0izl73aSjAMiH/ZSS
         Ek3hm1VUZaG8BnFrMLh2QNHdtmGHrLFDy8ZAhrNgUzgzkbovL5IX22GYswYbij0DXl
         WZlhZTf9yRpEjxGtwbq8wUaMqOVtEV5fgGDeXDq91dVcbLui8m1szTTZACS9gsC0f4
         yv/3rBGrXtsZg==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: cadence: Correct initialisation of runtime PM again
Date:   Fri, 16 Jul 2021 20:21:33 +0200
Message-Id: <20210716182133.218640-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The original implementation of RPM handling in probe() was mostly
correct, except it failed to call pm_runtime_get_*() to activate the
hardware. The subsequent fix, 734882a8bf98 ("spi: cadence: Correct
initialisation of runtime PM"), breaks the implementation further,
to the point where the system using this hard IP on ZynqMP hangs on
boot, because it accesses hardware which is gated off.

Undo 734882a8bf98 ("spi: cadence: Correct initialisation of runtime
PM") and instead add missing pm_runtime_get_noresume() and move the
RPM disabling all the way to the end of probe(). That makes ZynqMP
not hang on boot yet again.

Fixes: 734882a8bf98 ("spi: cadence: Correct initialisation of runtime PM")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-cadence.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index a3afd1b9ac56..ceb16e70d235 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -517,6 +517,12 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_apb;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
 	if (ret < 0)
 		master->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
@@ -531,11 +537,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	/* SPI controller initializations */
 	cdns_spi_init_hw(xspi);
 
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		ret = -ENXIO;
@@ -566,6 +567,9 @@ static int cdns_spi_probe(struct platform_device *pdev)
 
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
-- 
2.30.2


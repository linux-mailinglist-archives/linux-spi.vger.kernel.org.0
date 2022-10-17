Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9E601875
	for <lists+linux-spi@lfdr.de>; Mon, 17 Oct 2022 22:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJQUCF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Oct 2022 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiJQUB4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Oct 2022 16:01:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D78275EE
        for <linux-spi@vger.kernel.org>; Mon, 17 Oct 2022 13:01:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1okWJ1-0007p7-J3; Mon, 17 Oct 2022 22:01:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okWJ0-0028XE-6d; Mon, 17 Oct 2022 22:01:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1okWIz-008db7-37; Mon, 17 Oct 2022 22:01:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH] spi: bcm-qspi: Make bcm_qspi_remove() return void
Date:   Mon, 17 Oct 2022 22:01:43 +0200
Message-Id: <20221017200143.1426528-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2956; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qdLvd2FgQb/E+Oq0ESxa5ffvopjSJfr6ID2Op/GvaRw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjTbSjq+Wzs7tAZHqf62uASxmZMHg/WQ2Fg0yHhiNq TOyDrp2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY020owAKCRDB/BR4rcrsCVn5B/ 95EeWuhGokejrWgOTQB/uUSAGC40syD9muxugJdiIZ9rYVXqm+RSzlnQlgnjruCRA0aJ8rLpVvF3z3 qnQPChdGUV1n9UHLjCkI0/G9HVIKRrlobE6qy3x9XkXJm7LIz0lgG74SBcVQYX9EulZ8J9qwOozN+5 ofgJsZGEnzMjl1NsW2LtpPleNDmaUH1k6Jo9jPVftzRj/aZH1ygMcvbJnF0dUPzfd7MbBr4uycyzSp 8ksfGsdqd7yMuKpwSDDzehw3XYCr/hNNwI1xpspqpqimozl7XbgB1A3Fg5cLxNGVtrxuhaysWN6pFy Qh1/Cob2TlkIfL9uKK+3h6FDh895oV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The function bcm_qspi_remove() returns zero unconditionally. Make it
return void.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-bcm-qspi.c     | 5 ++---
 drivers/spi/spi-bcm-qspi.h     | 2 +-
 drivers/spi/spi-brcmstb-qspi.c | 4 +++-
 drivers/spi/spi-iproc-qspi.c   | 4 +++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index cad2d55dcd3d..0eee574d3e1f 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1682,7 +1682,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 /* probe function to be called by SoC specific platform driver probe */
 EXPORT_SYMBOL_GPL(bcm_qspi_probe);
 
-int bcm_qspi_remove(struct platform_device *pdev)
+void bcm_qspi_remove(struct platform_device *pdev)
 {
 	struct bcm_qspi *qspi = platform_get_drvdata(pdev);
 
@@ -1690,9 +1690,8 @@ int bcm_qspi_remove(struct platform_device *pdev)
 	bcm_qspi_hw_uninit(qspi);
 	clk_disable_unprepare(qspi->clk);
 	kfree(qspi->dev_ids);
-
-	return 0;
 }
+
 /* function to be called by SoC specific platform driver remove() */
 EXPORT_SYMBOL_GPL(bcm_qspi_remove);
 
diff --git a/drivers/spi/spi-bcm-qspi.h b/drivers/spi/spi-bcm-qspi.h
index 01aec6460108..3d7c359c0239 100644
--- a/drivers/spi/spi-bcm-qspi.h
+++ b/drivers/spi/spi-bcm-qspi.h
@@ -96,7 +96,7 @@ static inline u32 get_qspi_mask(int type)
 /* The common driver functions to be called by the SoC platform driver */
 int bcm_qspi_probe(struct platform_device *pdev,
 		   struct bcm_qspi_soc_intc *soc_intc);
-int bcm_qspi_remove(struct platform_device *pdev);
+void bcm_qspi_remove(struct platform_device *pdev);
 
 /* pm_ops used by the SoC platform driver called on PM suspend/resume */
 extern const struct dev_pm_ops bcm_qspi_pm_ops;
diff --git a/drivers/spi/spi-brcmstb-qspi.c b/drivers/spi/spi-brcmstb-qspi.c
index 75e9b76dab1e..de362b35718f 100644
--- a/drivers/spi/spi-brcmstb-qspi.c
+++ b/drivers/spi/spi-brcmstb-qspi.c
@@ -23,7 +23,9 @@ static int brcmstb_qspi_probe(struct platform_device *pdev)
 
 static int brcmstb_qspi_remove(struct platform_device *pdev)
 {
-	return bcm_qspi_remove(pdev);
+	bcm_qspi_remove(pdev);
+
+	return 0;
 }
 
 static struct platform_driver brcmstb_qspi_driver = {
diff --git a/drivers/spi/spi-iproc-qspi.c b/drivers/spi/spi-iproc-qspi.c
index de297dacfd57..91cf8eb7213c 100644
--- a/drivers/spi/spi-iproc-qspi.c
+++ b/drivers/spi/spi-iproc-qspi.c
@@ -129,7 +129,9 @@ static int bcm_iproc_probe(struct platform_device *pdev)
 
 static int bcm_iproc_remove(struct platform_device *pdev)
 {
-	return bcm_qspi_remove(pdev);
+	bcm_qspi_remove(pdev);
+
+	return 0;
 }
 
 static const struct of_device_id bcm_iproc_of_match[] = {

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.37.2


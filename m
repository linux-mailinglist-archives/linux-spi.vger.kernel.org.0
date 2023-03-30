Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23C46D107B
	for <lists+linux-spi@lfdr.de>; Thu, 30 Mar 2023 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjC3VEH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjC3VEF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 17:04:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6310407
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 14:04:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQw-00028o-Oi; Thu, 30 Mar 2023 23:03:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQv-007qTS-0G; Thu, 30 Mar 2023 23:03:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQt-009Hr9-KT; Thu, 30 Mar 2023 23:03:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/2] spi: qup: Don't skip cleanup in remove's error path
Date:   Thu, 30 Mar 2023 23:03:40 +0200
Message-Id: <20230330210341.2459548-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330210341.2459548-1-u.kleine-koenig@pengutronix.de>
References: <20230330210341.2459548-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6/vEy1Mo9ElX8APtQSvIdJqXun8Q9L13V7ppH8ExTZQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkJfkp2CelunJXQ6oDPGfyjkXW9I+7Twa5DCV2+ 5oBacxQ73qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZCX5KQAKCRCPgPtYfRL+ TiB9CACySh8cTwRzEmGCQZLaF1HziDmbSwUXoV2IdNAfXxuR4BwOh9xrUbwlMfn6Dxd9FqkV/N0 uowVHsD7Lk4djwS+G4ordUzfp2XFufhHJWZP7BLk3F3nrlnoEhFxrn9VfNgmG5cTJjNMlQvbF+C YVoF22SRC29f8HUpgLkFi4XaK0upOiKGkO/pIVbTASdF3uNvGu+9xghdsLcyonfuXiS0PuHPRVo xhLlvZQMu4iFC9Y3xncbZayfruCnUOYFbz8jfy4p5XogTDx8fLYBpNNcyrfQJVDKdNnmcdcNR/Q wAi4TtIu/I8oNlgKTsB5rx6Csb7ge+zXYksltiuY21/OlbIr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Returning early in a platform driver's remove callback is wrong. In this
case the dma resources are not released in the error path. this is never
retried later and so this is a permanent leak. To fix this, only skip
hardware disabling if waking the device fails.

Fixes: 64ff247a978f ("spi: Add Qualcomm QUP SPI controller support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-qup.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 678dc51ef017..205e54f157b4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1277,18 +1277,22 @@ static int spi_qup_remove(struct platform_device *pdev)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(&pdev->dev);
 
-	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
-	if (ret)
-		return ret;
+	if (ret >= 0) {
+		ret = spi_qup_set_state(controller, QUP_STATE_RESET);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to reset controller (%pe)\n",
+				 ERR_PTR(ret));
 
-	spi_qup_release_dma(master);
+		clk_disable_unprepare(controller->cclk);
+		clk_disable_unprepare(controller->iclk);
+	} else {
+		dev_warn(&pdev->dev, "failed to resume, skip hw disable (%pe)\n",
+			 ERR_PTR(ret));
+	}
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
+	spi_qup_release_dma(master);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.39.2


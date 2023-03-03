Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215656A9D67
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCCRVn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCCRVY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB27C521DD
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-0006oQ-5u; Fri, 03 Mar 2023 18:21:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001bm5-UQ; Fri, 03 Mar 2023 18:21:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001tkm-8t; Fri, 03 Mar 2023 18:21:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 46/87] spi: npcm-pspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:00 +0100
Message-Id: <20230303172041.2103336-47-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EKybXEEf2bYsLXDaIL5zgOsRVqQSPR8/936qBvkZb6U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiu9f/FL6O73qT5I00JECgp0g7p7K6aWqxwFp JZSjr7Gtr6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrvQAKCRDB/BR4rcrs CVClB/0dgEYGWbY9R1ZBcQR9+9oF2NmJqIJt7GP4Br0Q4qEIPaAl46XiZGno6CZib8ZknyOWCn3 0umQlC6AxXoGrGABh2ODdhP594W5Q3j7dYwMZJU1IP59nx8KrGnm+aWfdxyEwVus1p3ePrRPLMp pu72TgCNGEUoHYB/3qCVJ+V9t15Q9vaPeDMYZXcKf8Dkxanw94+8ljU2ZQg2PZ3UOhG7fb3AaYZ TqxJxjTZdh/QPZp6UQlTktnW/e5wWPZ48vvHE6byk9UcoOlkEMMCo5N3H0yEc/SQlfLAcP9FC2t 94J/hX7qJ3QJdD6wQHNnqXaJNvGErf+qcSvxFAszhpfsKDcB
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

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-npcm-pspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 7f2e4d1b0d43..64585c2a25c5 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -430,15 +430,13 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int npcm_pspi_remove(struct platform_device *pdev)
+static void npcm_pspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct npcm_pspi *priv = spi_master_get_devdata(master);
 
 	npcm_pspi_reset_hw(priv);
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static const struct of_device_id npcm_pspi_match[] = {
@@ -454,7 +452,7 @@ static struct platform_driver npcm_pspi_driver = {
 		.of_match_table	= npcm_pspi_match,
 	},
 	.probe		= npcm_pspi_probe,
-	.remove		= npcm_pspi_remove,
+	.remove_new	= npcm_pspi_remove,
 };
 module_platform_driver(npcm_pspi_driver);
 
-- 
2.39.1


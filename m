Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1E6A9D66
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjCCRVk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCCRVT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C12C474F5
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-0006gc-6e; Fri, 03 Mar 2023 18:20:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001bku-Nl; Fri, 03 Mar 2023 18:20:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001tjl-SZ; Fri, 03 Mar 2023 18:20:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jay Fang <f.fangjian@huawei.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 30/87] spi: hisi-kunpeng: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:44 +0100
Message-Id: <20230303172041.2103336-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KNX/IRngtnGhX5uSo2EN1XcTXmXFtbfNvNnbw9DX7jE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAit/5rOFFU7JX62qJD50eeUSTROCXgdkETyqF qq2k5kp++eJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrfwAKCRDB/BR4rcrs CWfOB/9J9NH0G/wF2GHx18v7SlJUUkTtUkiZTNI11MlFAKeKiYodM/Qh+nOqQlLGZLVM3HXfk9E qOwAjcL3Y7y2kcf+HB6jLunTaNHEb4CCfRKT9S8oD8glBc2F42wmZEQ5OymFQNtdgOMBpoGIy4k ZkXKn+Wx34WIosL8rfKXo3xSSkRlFUjLqXryXknK187fDMYXBZTtaqpHLbvfFIv90iS1DOY40dm ANGOmB8PmXAc2voDsbH+UXbY9Pb/I0EFud0LeS73u6rH+FoNwDeWMlNoftI31SGd5eqyl8SO8A4 f1jhS0VdjRt7HPhOo0TnJ6kaH8HKKrBQqUysIVCSTb79/W/2
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
 drivers/spi/spi-hisi-kunpeng.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 525cc0143a30..524eadbef87b 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -523,15 +523,13 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hisi_spi_remove(struct platform_device *pdev)
+static void hisi_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *master = platform_get_drvdata(pdev);
 	struct hisi_spi *hs = spi_controller_get_devdata(master);
 
 	debugfs_remove_recursive(hs->debugfs);
 	spi_unregister_controller(master);
-
-	return 0;
 }
 
 static const struct acpi_device_id hisi_spi_acpi_match[] = {
@@ -542,7 +540,7 @@ MODULE_DEVICE_TABLE(acpi, hisi_spi_acpi_match);
 
 static struct platform_driver hisi_spi_driver = {
 	.probe		= hisi_spi_probe,
-	.remove		= hisi_spi_remove,
+	.remove_new	= hisi_spi_remove,
 	.driver		= {
 		.name	= "hisi-kunpeng-spi",
 		.acpi_match_table = hisi_spi_acpi_match,
-- 
2.39.1


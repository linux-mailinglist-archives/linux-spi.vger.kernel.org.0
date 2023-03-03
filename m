Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5126A9D41
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjCCRVY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCCRVL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D94DBDD
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-00071G-OX; Fri, 03 Mar 2023 18:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001bnj-Tc; Fri, 03 Mar 2023 18:21:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001tm0-7Y; Fri, 03 Mar 2023 18:21:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 65/87] spi: sh-sci: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:19 +0100
Message-Id: <20230303172041.2103336-66-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hl+QqjEe834gK9pecOsoaijTUTvz76aFIV6m/I0uauM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwIm8wzZi4Xuv/Hhp7jwbzMvYn5A/Ik+1S1t TXWfCFXyyeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsCAAKCRDB/BR4rcrs CSCKB/9ZeAHgXfGjCZrJlgI67gQmcjcc53ZOMyvCbG97d8K3vQTWbcrHdqisUAF0DxbBcCQLRXo epZe2j7rxlK0KUPzxY1QuoOblgqsS/4BN0eqq/G9yvODbG4NCXjlIm3TwsgV3VaSgvTDYq23pWC qrPAXbvHtljI6m9XkPt70Fx/c3wcV0WmvHmhrhn+aCAUKHn8LNtsN8txPT9xPzYEiLeWKnESpHn VOpHTwwM7in70wsbQpNWj2sLoyS+TeY7tdhV297oPiQixualFuQsdN1t9VQVYgDoMxQgPT7Orf/ jmfbB2oHZoXzXXEbr34kOY8toT9s/297JYks2m0/5E4prJqE
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
 drivers/spi/spi-sh-sci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
index 8f30531e1418..0fdfec2de47a 100644
--- a/drivers/spi/spi-sh-sci.c
+++ b/drivers/spi/spi-sh-sci.c
@@ -171,7 +171,7 @@ static int sh_sci_spi_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int sh_sci_spi_remove(struct platform_device *dev)
+static void sh_sci_spi_remove(struct platform_device *dev)
 {
 	struct sh_sci_spi *sp = platform_get_drvdata(dev);
 
@@ -179,12 +179,11 @@ static int sh_sci_spi_remove(struct platform_device *dev)
 	setbits(sp, PIN_INIT, 0);
 	iounmap(sp->membase);
 	spi_master_put(sp->bitbang.master);
-	return 0;
 }
 
 static struct platform_driver sh_sci_spi_drv = {
 	.probe		= sh_sci_spi_probe,
-	.remove		= sh_sci_spi_remove,
+	.remove_new	= sh_sci_spi_remove,
 	.driver		= {
 		.name	= "spi_sh_sci",
 	},
-- 
2.39.1


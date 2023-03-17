Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102766BE417
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjCQIoJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjCQInx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 04:43:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62526905A
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 01:42:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fc-0004tL-Oc; Fri, 17 Mar 2023 09:42:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fb-004jZU-TX; Fri, 17 Mar 2023 09:42:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fb-005ZuI-6X; Fri, 17 Mar 2023 09:42:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 1/3] spi: atmel-quadspi: Don't leak clk enable count in pm resume
Date:   Fri, 17 Mar 2023 09:42:30 +0100
Message-Id: <20230317084232.142257-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
References: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FFnOWZjupFGGLc/xMfIraPd8mMgiKbUHssyndztqfKg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkFCfp1VrKULqQRBRNVs37gyiSigy7MyCHRqxVA +XdGBJT9DGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBQn6QAKCRDB/BR4rcrs CVpQB/9lQWaWk1gE3UPzUT5ZhnMpKRrOVYQiaHgMcD+txbwK2+vwpGVhaqUIQcYK/Iq3CTaEifC TwLL9Lx6Qqx8EiHP9OPDDlrhsWHZzE9OyGzx6fqS+bBsWrFc4YcweKuGmM43WCcHMr64fFGVFy5 zGO49aZip2ujh39U39qw7j+emmGHpsQqUFUBwf9m+IatCoYPHRthWKnQDx4+7SW5kcBKXZqbBQ/ 5XTgR0drFmeFB4cyZk8I+PnWotn7IO+sdc9cNsiEfnWUca9bFcr5YFE9r6f511P8VWgrPJUbywE IxB6Zw7BDtC1FoxZcE/iXs0WrkqGQ7+YKAzNxOiTN1Ek0D3J
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

The pm resume call is supposed to enable two clocks. If the second enable
fails the callback reports failure but doesn't undo the first enable.

So call clk_disable() for the first clock when clk_enable() for the second
one fails.

Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/atmel-quadspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index f4632cb07495..0c6f80ddea57 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -786,7 +786,11 @@ static int __maybe_unused atmel_qspi_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return clk_enable(aq->qspick);
+	ret = clk_enable(aq->qspick);
+	if (ret)
+		clk_disable(aq->pclk);
+
+	return ret;
 }
 
 static const struct dev_pm_ops __maybe_unused atmel_qspi_pm_ops = {
-- 
2.39.2


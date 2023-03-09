Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059AD6B208A
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCIJsC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 04:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCIJro (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 04:47:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04059D49DB
        for <linux-spi@vger.kernel.org>; Thu,  9 Mar 2023 01:47:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrc-0007g1-K6; Thu, 09 Mar 2023 10:47:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrb-002uvG-OY; Thu, 09 Mar 2023 10:47:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCra-003VnN-PA; Thu, 09 Mar 2023 10:47:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/3] spi: mt65xx: Don't disguise a "return 0" as "return ret"
Date:   Thu,  9 Mar 2023 10:47:04 +0100
Message-Id: <20230309094704.2568531-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
References: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=719; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4ZsBC//oBmMrgEk5xvSD6NYRRsiV5c5ra/OtiZrxzxs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCasUb7W/iSx+xSTQlRXV0Bcy3BSJmEvj91w2M oqZhz5kw++JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAmrFAAKCRDB/BR4rcrs CeHoB/46zjiVBXgAvaDNTZdU0d0778ZqugvMQiN75MH5QGw5b4rQ0xmV7sxX/yH5GJPlp0AM6gN K3bW9q1x/6JYntYsgmUU5ntZUOmopmKOsF7PDhftbd/wxTOk7O4OfkymSKh1kni87OLL63VfjIN xg8l6/g+Pg7AyoLPHjOm7mpoWIY2shjABVXoCfgm10KNThnm5i7KibEr1kfeffJ37NEmdkshbFd oBM0brj9HrlJTfPL2qqqj0glFziojM+7BBkodl1yIv2djtWVTMo4CKlqqPOQs+hIm7D/MFcFsGX 3JNFTxgqLhgY6Obwk6lDkFo9Vn8l5j7Yyxo9uiN8zfLDbq2H
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

Because of the earlier

	 if (ret)
		return ret;

ret is always zero at the end of mtk_spi_suspend(). Write it as explicit
return 0 for slightly improved clearness.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index f744cb97aa87..2216d4e00c7a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1311,7 +1311,7 @@ static int mtk_spi_suspend(struct device *dev)
 		clk_disable_unprepare(mdata->spi_hclk);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int mtk_spi_resume(struct device *dev)
-- 
2.39.1


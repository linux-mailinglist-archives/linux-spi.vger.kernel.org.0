Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9838F715827
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 10:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjE3IQ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjE3IQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 04:16:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053DA8
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 01:16:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXF-0008MQ-Hy; Tue, 30 May 2023 10:16:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXE-003pV0-SO; Tue, 30 May 2023 10:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXE-009PLt-0L; Tue, 30 May 2023 10:16:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 3/3] spi: mt65xx: Don't disguise a "return 0" as "return ret"
Date:   Tue, 30 May 2023 10:16:48 +0200
Message-Id: <20230530081648.2199419-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
References: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=802; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ew7u2vVjRGswRnJ0Le+vSh/UTGZDw0qmYIiCRc9OzYk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdbDv3hfrWqOKRbA5eyKpO+36tm6FOWuuaFq4T Pi1bwKRRpeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWw7wAKCRCPgPtYfRL+ Tt/DB/44PJgEduak7dCLH9t+Dlt0HWOfr/wUwjV5gRjJpu54mmJ+Fc7FsX+IAcebhW7VO0iIhw9 R9ywW8VC5j3j9jZ8gjAmVyINoWg0yDoGAsAfcb0HyFmORXOyJudhrSSs5+nXU1t1gBL4LSaJ9bI BP6kOw/VhrTRIKwZCkrNNCTC7yfc7ejl/nKFIBQVjV1hPHcZJ++rONpsaDOe8a0WtCNIxc6BUNl Vwmi8FSfYAdHK1ui6c15iBcydFR90DdWHCrnPPKlrwf6wTyY1RYsbHZYEqojKrawNl8ZkjSicTQ Djp2FbivQCAauxYQu+S2UhQ84pVZJPVJ0BtSQeG3r2Wtdyu1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index f532cee3461e..5a0b04c1c755 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1312,7 +1312,7 @@ static int mtk_spi_suspend(struct device *dev)
 		clk_disable_unprepare(mdata->spi_hclk);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int mtk_spi_resume(struct device *dev)
-- 
2.39.2


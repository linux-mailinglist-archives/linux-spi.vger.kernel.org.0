Return-Path: <linux-spi+bounces-1181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB684D178
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51A21C25736
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E31272CF;
	Wed,  7 Feb 2024 18:43:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809683CD1
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331402; cv=none; b=IlQ3FQ77m4PxNQlhM7R71PFZpgaNydWXZM9T4gbRJP+1nvySUWZ/e27ZICftWPBEBiI92cdfxf49TK+NTsEkAuJOa0VI7Vl9xtOHoPdtc8qzeuEF7/xR9hORCxK1Z2h8/V6WTtuWyJqbh6Xg4wfUGF1r6ZkvDn7a0n8b/UaRwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331402; c=relaxed/simple;
	bh=b8hJWsXG7Bt5TUY+X52F0IkO1iwX1T0dZ3MvwIZs37k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmL2clCibMsASDzotxqTE6s9HzYGWp5XkcTVtC80u2mVLfqHcTMHvmY8YdhvYuF8fUJI6npJyJxjOYxkJXU3MPKvp9ht5ZNt6Jg7qo05+lVI1bFyXLELErXiSuzOtHCai59GAn34JqK0yVzIbkqAiVxmD/pcHNzqEPu54Nmmh0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtA-0007n4-UD; Wed, 07 Feb 2024 19:43:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtA-0054YD-HY; Wed, 07 Feb 2024 19:43:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtA-00HRtH-1T;
	Wed, 07 Feb 2024 19:43:16 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 22/32] spi: slave-mt27xx: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:36 +0100
Message-ID:  <184a5263af2ec01fd5ad9b8db667ae4d6cbec948.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=b8hJWsXG7Bt5TUY+X52F0IkO1iwX1T0dZ3MvwIZs37k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86+8M4z7ERGC2YgRKokbc/1ZH/C1sXCVRmPZ XTYGPhpNgGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOvgAKCRCPgPtYfRL+ TmcaCACj305jhazD0RSq3hnVuvKMFTMwKAxXuATdDX9fNjoi1fZmS/EjF5gydXvOaAb8/h6xk+W eB+R0dxz8VSGW9YMH7spESk2HLI1iB9Mx3vxHX4QNKHLQCPPkCDFVMumo4p8/WLPjVHTRIwU992 OPufbaki9gmJYvRrv8ldt21O/Zln8Iw3NDi+YZj84KbAWt2IenMbzv7fDYKXDanziq+ZwSbl5eZ ba9ybtmbZ516KNm41OUp9AXuZpET3PIlaZgq4Uvv63GG4RT5mKTMG1w9M/t6qxXfSBlrtH6WgDt WNb/XJQTPwlXyRbGO+Jxm1qimx1DIJonJ+se/v+lQFg2lqJX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-slave-mt27xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 6d6772974783..f1ddf4c099a3 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -297,7 +297,7 @@ static int mtk_spi_slave_transfer_one(struct spi_controller *ctlr,
 
 static int mtk_spi_slave_setup(struct spi_device *spi)
 {
-	struct mtk_spi_slave *mdata = spi_controller_get_devdata(spi->master);
+	struct mtk_spi_slave *mdata = spi_controller_get_devdata(spi->controller);
 	u32 reg_val;
 
 	reg_val = DMA_DONE_EN | DATA_DONE_EN |
-- 
2.43.0



Return-Path: <linux-spi+bounces-443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5545182E180
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B33B21288
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jan 2024 20:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D366199A3;
	Mon, 15 Jan 2024 20:21:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2119473
	for <linux-spi@vger.kernel.org>; Mon, 15 Jan 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSG-0004kf-Uu; Mon, 15 Jan 2024 21:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-0005gi-HJ; Mon, 15 Jan 2024 21:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSF-000N7t-1R;
	Mon, 15 Jan 2024 21:21:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 13/33] mtd: rawnand: fsl_elbc: Let .probe retry if local bus is missing
Date: Mon, 15 Jan 2024 21:12:59 +0100
Message-ID:  <978d5107646800a2dfa3299e32e2587907d53a87.1705348269.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=s+JADGlY1hU/NStvmmbQ8XZ+UID1ILn7ThT9et4DuL4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHPCEJWc7vdLUmy8+BmgzzT8evOP0zLGbYWS ciV2KzQ93yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRzwAKCRCPgPtYfRL+ TiVdB/wMSwEC76EmTubxnIK4QkQ+SGwLSbNrGj1gqo0OR0dGoYZmlUtZ4lJgy6bm7ZuExr1OOVZ +nD45sPyuvg6SusiCWNVHmV2Bs/wGWYC+rJogFEKVV1MGghznBcd7jFin7nnYU0ZA6J8MaLmlNA mNILzMZe1SuVNxrbE9VYubQh81lpfU8KVZx/GypYqzbNGLpxZkCZK06v59OSEYcWtmMNtL/KJX1 ZNIvStyr8BUpuLU4UCGrhkA498s3DA+igjki46e0RvjwKnPVPKYB9Z5lCwrut4FVJPrz+aJdpCH gLPB+jWx0B7KKeaqdtcMUayWjw5xqjIZcjLQlqeAH6grisdI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

If during probe fsl_lbc_ctrl_dev is NULL that might just be because the
fsl_lbc driver didn't bind yet. So return -EPROBE_DEFER in this case to
make the driver core retry probing later.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/raw/fsl_elbc_nand.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 1e3a80f06f33..df6a0d5c86bb 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -869,7 +869,8 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
 	struct mtd_info *mtd;
 
 	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
-		return -ENODEV;
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER, "lbc_ctrl_dev missing\n");
+
 	lbc = fsl_lbc_ctrl_dev->regs;
 	dev = fsl_lbc_ctrl_dev->dev;
 
-- 
2.43.0



Return-Path: <linux-spi+bounces-585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D306A8371CC
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 20:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55804B2745C
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B313C63104;
	Mon, 22 Jan 2024 18:08:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159961670
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946916; cv=none; b=kfAtqNgEy1XXGcBz3+C9Bt3F+wrMgum5qzt3Wgqn8NLCVvRTxgmWJotY3/zbMYv8GS3zwJvhJPUZ4DE29dgBTH7mZ+zuZ9Kxj5MRHrkEuiey2qVUZQXxAG3Sc/iMy252St55QOIWNNQg9SOrvLqwkwSBuw6QGuVHn5xYo+vAcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946916; c=relaxed/simple;
	bh=s+JADGlY1hU/NStvmmbQ8XZ+UID1ILn7ThT9et4DuL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0rP+ealXgSSe1jpMmYljyBg6PuRaGJHSQDXCicCnBEolItr/TQHk7taQ5qvGnFSg4ax71THmMKwl5JegTxLkDePODIXmZWtjPpVhZcXWeuyfVCthxM7yl199Z5DWfFlaoQUbZoyi7UCNxg3+hFzXziAl/GJ21rRv0WrOfnsPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-0001rV-Ds; Mon, 22 Jan 2024 19:08:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-001ePz-Cl; Mon, 22 Jan 2024 19:08:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiV-005ZxZ-0z;
	Mon, 22 Jan 2024 19:08:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 13/33] mtd: rawnand: fsl_elbc: Let .probe retry if local bus is missing
Date: Mon, 22 Jan 2024 19:07:08 +0100
Message-ID:  <41a042207ef791c4c5bcb46f09f63c40c6aa321b.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=s+JADGlY1hU/NStvmmbQ8XZ+UID1ILn7ThT9et4DuL4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7SqRa5xnri+sBGWXS2mxTR2+yeexp9NbmI0 L90hkTAH++JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u0gAKCRCPgPtYfRL+ TlAHB/wMg26k1Tpck9mHijZsRHTQvJplBT8Z+vC2kUhBSyWEZB0dKmES+fZW3CeCceTvoNOyFuV 7TDzPHUuzbznk6NIljGX94AwdH91fGCAnFs7MXcPZdppmViEw8kW4jG+dVtd/2vXlq8Fs+JMbBg X3rsJQGwDZjlubTx88jvefyRVTkWUObB/F62pE7+t1zSpAka5vi4w4s9TC437a89kT6z3KJVs/B 5D8PuO2JS7sqyvGPTuWxX7CKUYRb14q6ysKoafrx5mNB0ymUIcbqI4rwPlRVTHgWk6aeRto3npM JsgwpMCWKefupKmykKqsyBIf58VxW9M/7YtKjYKc/tPhJJYR
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



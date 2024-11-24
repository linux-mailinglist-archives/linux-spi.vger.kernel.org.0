Return-Path: <linux-spi+bounces-5808-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790AA9D70B8
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C262BB2A3C7
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9461DF260;
	Sun, 24 Nov 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C57r+DHJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548271AC43A;
	Sun, 24 Nov 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452794; cv=none; b=gCN0Z5zvcrVj+rQwBx9hjdlUmW9Lw3PgHi4nzY37594Q4Gq+ukEPn2TPgoDMjt1w5oA3u2pMmPmvpLh+SYck6SdA7Jv1t9beByKnclw1mpU6EANyg3/VTeA9cbCWwdHuHzC1c/kMcVsSVe9Xfe2P5Cf0EvfiZFIZCCl8Kz1dL7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452794; c=relaxed/simple;
	bh=zm4sYBlw+dcRQe2cg9YcRTsb3nX+GEQvk/csuVhxMlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5tYciP7kTSPpM3McTiShvm29BxO2D2ewWvBHGIlKd0hd9rPW45spLuFwhcW+EZQkV7EcLXJP0JQDtECc8zculCDYMk6YoVITT/LoiDlB9KRBJVseavGE1yeD/5gl+uBcR4z5VsEbicetyCRQF/UGQxkMIMBiLCH65EcN12GvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C57r+DHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454FCC4CECC;
	Sun, 24 Nov 2024 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452794;
	bh=zm4sYBlw+dcRQe2cg9YcRTsb3nX+GEQvk/csuVhxMlk=;
	h=From:To:Cc:Subject:Date:From;
	b=C57r+DHJ0Btc+J6FbVxDI9EegYX8FR/0UEfWY/6RjQQTNng73GJvg3CBDz6NpCTbM
	 feeUfj9bCTeKbK76U6IlpapMGW4L2HjVCZCQH8tAJVAFKmzHdkNgJcg156RIOedwEk
	 NFRJ1rZVwGXY96p61Keu9o43J4A8OQlW1+MmaFaHtXImlBXCDAsQKcd74GK9WxwJ6r
	 Yb0niP+v/DnHkw5aLocaCVAhDxMTslDJwB+Gkr0PakclSPz1U6TWGUZODqUBfHNqCR
	 mh452h1I5vLI4a2UY/sWhJbCwu3oRtSiJJNwJ/9aqmmalgK9KUE6raP9AC0IXhoSBm
	 gPLKWQy3jaFzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 01/16] spi: spi-fsl-lpspi: Adjust type of scldiv
Date: Sun, 24 Nov 2024 07:52:19 -0500
Message-ID: <20241124125311.3340223-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit fa8ecda9876ac1e7b29257aa82af1fd0695496e2 ]

The target value of scldiv is just a byte, but its calculation in
fsl_lpspi_set_bitrate could be negative. So use an adequate type to store
the result and avoid overflows. After that this needs range check
adjustments, but this should make the code less opaque.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20240930093056.93418-2-wahrenst@gmx.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 13313f07839b6..84881983d5d9f 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -315,9 +315,10 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
-	unsigned int perclk_rate, scldiv, div;
+	unsigned int perclk_rate, div;
 	u8 prescale_max;
 	u8 prescale;
+	int scldiv;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
 	prescale_max = fsl_lpspi->devtype_data->prescale_max;
@@ -338,13 +339,13 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 
 	for (prescale = 0; prescale <= prescale_max; prescale++) {
 		scldiv = div / (1 << prescale) - 2;
-		if (scldiv < 256) {
+		if (scldiv >= 0 && scldiv < 256) {
 			fsl_lpspi->config.prescale = prescale;
 			break;
 		}
 	}
 
-	if (scldiv >= 256)
+	if (scldiv < 0 || scldiv >= 256)
 		return -EINVAL;
 
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
-- 
2.43.0



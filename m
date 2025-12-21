Return-Path: <linux-spi+bounces-12066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33800CD3EFB
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7573005D1F
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5828DEE9;
	Sun, 21 Dec 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jARikKwv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F231AF4D5;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315120; cv=none; b=icVMG1cBK8cl+oHAicZgLbQeiVV5cGfbzhgkxddZbOD1YL2mHbLmn5RvbPtf34YBucVsgJVvLJCUr0VHicoaL3TSKBIFsRaYVqX6hKRT9Ndvp50QMBTZ8FRUD7KY4DQ2gE9dbOZ2iMHDRj/oVneelYOAKRBmKKypG8yC7ar2DMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315120; c=relaxed/simple;
	bh=FqrfUyalVJxAzWiXrYozFMpf1r6H1cm5w3a0ofVlp2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmtJE4OhJR3CY8koUz89t8+SuduMeIQ9lEZus/OooxYR49KtRIDbQTMM+F+0ihAUsEbPXMQF0bQhhapgIZXEno2xcML94vNjWh6tFyIMpTZ0G0l9ad5/l2zI2iopPvH/Joi/JGV1cm1hvOsego/dYGD8+UnadGfEoxjLHd8Ig+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jARikKwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77246C19422;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766315119;
	bh=FqrfUyalVJxAzWiXrYozFMpf1r6H1cm5w3a0ofVlp2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jARikKwv1yStu2XbSDMg6WVzslk2JzGCGCiv6WE0C7SueaB5h/PAL8VrI1k6MF3rc
	 fH8dI7Bnsv34RSdkC69NJH5Ys82ks+ADaUppeMTDaqH6ytFu/lP0/tJCwRInt4+KhE
	 WYloa9zqCYr1RkYljUBVev2/d94MOBTKL96S8FDwEQIJbIgh+33iZuG0u2arNqcl8T
	 097fzZ4/p2gnmpLCB3ES7ZkE/iE0CVDYzqrTvKkfBbV0M9WtOqMl3C+SGNw3YnrTML
	 roJ1L3ai+PTssG/ypDTFaw6TdvWFiNk0o0nBDvivfskmg/dvjgUB2U2iMkxkbI67J6
	 0lJFe9JMChwTQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 432215FE34; Sun, 21 Dec 2025 19:05:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] spi: sun6i: Support A523's SPI controllers
Date: Sun, 21 Dec 2025 19:05:09 +0800
Message-ID: <20251221110513.1850535-3-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221110513.1850535-1-wens@kernel.org>
References: <20251221110513.1850535-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A523 has four SPI controllers. One of them supports MIPI DBI mode
in addition to standard SPI.

Compared to older generations, this newer controller now has a combined
counter for the RX FIFO ad buffer levels. In older generations, the
RX buffer level was a separate bitfield in the FIFO status register.

In practice this difference is negligible. The buffer is mostly
invisible to the implementation. If programmed I/O transfers are limited
to the FIFO size, then the contents of the buffer seem to always be
flushed over to the FIFO. For DMA, the DRQ trigger levels are only tied
to the FIFO levels. In all other aspects, the controller is the same as
the one in the R329.

Support the standard SPI mode controllers using the settings for R329.
DBI is left out as there currently is no infrastructure for enabling a
DBI host controller, as was the case for the R329.

Also fold the entry for the R329 to make the style consistent.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 drivers/spi/spi-sun6i.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 871dfd3e77be..d1de6c99e762 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -795,10 +795,13 @@ static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
 static const struct of_device_id sun6i_spi_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
 	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
-	{
-		.compatible = "allwinner,sun50i-r329-spi",
-		.data = &sun50i_r329_spi_cfg
-	},
+	{ .compatible = "allwinner,sun50i-r329-spi", .data = &sun50i_r329_spi_cfg },
+	/*
+	 * A523's SPI controller has a combined RX buffer + FIFO counter
+	 * at offset 0x400, instead of split buffer count in FIFO status
+	 * register. But in practice we only care about the FIFO level.
+	 */
+	{ .compatible = "allwinner,sun55i-a523-spi", .data = &sun50i_r329_spi_cfg },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.47.3



Return-Path: <linux-spi+bounces-11007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA4CC34C21
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 10:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA421898908
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D16306D54;
	Wed,  5 Nov 2025 09:15:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE13305E00;
	Wed,  5 Nov 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334116; cv=none; b=SmEVArSMvhSLaKxQKfc1H7uO/DCeV1NMAtcUP9vO9eBwBtIGSM88TKdduVFlRWYnBYxwalcfD9UzkTBgRMEvhGQct7JMyAgg4PAbkEG8FBIYOS3wqXH/zU6v1lrysVeL/Iiog4dwfeAtiYkMQgT+wg8d5yPOGZ2jrQ0HSOqsuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334116; c=relaxed/simple;
	bh=4WKJbPWsBbzRRSJvXECMwARNR+w/WjwF1SUj7d3chrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUutY9N085XiF5hgxuJUH8awvLEc+1JqxFQq6g3B6yIAlj+UCrKF7t6jV9Uyach6G1aYTiBL/3fWaR5PPTc55mLUCz7yViQgYbvKi7t6BOhcvlJRY4eT+Sxd5Qdnv+yFldk8dwg77aFZ7+Er5GfF6ROByYPTmif6SUvenwCMe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: MHzJH/GiSX2h+4N5sge7+Q==
X-CSE-MsgGUID: 6QUgumifTK+8S5N9ESvgJA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 18:15:13 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.38])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7CDF541763F1;
	Wed,  5 Nov 2025 18:15:08 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 05/14] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
Date: Wed,  5 Nov 2025 11:13:49 +0200
Message-ID: <20251105091401.1462985-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for caching the last requested transfer frequency, move
register writes outside of rzv2h_rspi_setup_clock().

The transfer list is iterated to determine the speed of the transfer
and the bits per word.

The speed of the transfer is used to compute SPR and BRDV inside
rzv2h_rspi_setup_clock().

BRDV and SPB are stored in the SPCMD register.

Move the transfer iteration earlier, move the SPR and BRDV writing out
of rzv2h_rspi_setup_clock(), consolidate writing BRDV and SPB into the
initial write to the SPCMD register.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 45 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index a1f17ec8727b..f02f25b98ec6 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -83,6 +83,8 @@ struct rzv2h_rspi_priv {
 	unsigned int bytes_per_word;
 	u32 freq;
 	u16 status;
+	u8 spr;
+	u8 brdv;
 };
 
 #define RZV2H_RSPI_TX(func, type)					\
@@ -263,8 +265,8 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	return 0;
 
 clock_found:
-	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_BRDV, brdv);
-	writeb(spr, rspi->base + RSPI_SPBR);
+	rspi->spr = spr;
+	rspi->brdv = brdv;
 
 	return rzv2h_rspi_calc_bitrate(tclk_rate, spr, brdv);
 }
@@ -283,6 +285,25 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	/* Make sure SPCR.SPE is 0 before amending the configuration */
 	rzv2h_rspi_spe_disable(rspi);
 
+	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		if (!xfer->speed_hz)
+			continue;
+
+		speed_hz = min(xfer->speed_hz, speed_hz);
+		bits_per_word = xfer->bits_per_word;
+	}
+
+	if (speed_hz == U32_MAX)
+		return -EINVAL;
+
+	rspi->bytes_per_word = roundup_pow_of_two(BITS_TO_BYTES(bits_per_word));
+
+	rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
+	if (!rspi->freq)
+		return -EINVAL;
+
+	writeb(rspi->spr, rspi->base + RSPI_SPBR);
+
 	/* Configure the device to work in "host" mode */
 	conf32 = RSPI_SPCR_MSTR;
 
@@ -301,6 +322,8 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	conf32 = FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
 	conf32 |= FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
 	conf32 |= FIELD_PREP(RSPI_SPCMD_LSBF, !!(spi->mode & SPI_LSB_FIRST));
+	conf32 |= FIELD_PREP(RSPI_SPCMD_SPB, bits_per_word - 1);
+	conf32 |= FIELD_PREP(RSPI_SPCMD_BRDV, rspi->brdv);
 	conf32 |= FIELD_PREP(RSPI_SPCMD_SSLKP, 1);
 	conf32 |= FIELD_PREP(RSPI_SPCMD_SSLA, spi_get_chipselect(spi, 0));
 	writel(conf32, rspi->base + RSPI_SPCMD);
@@ -316,24 +339,6 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 
 	rzv2h_rspi_clear_fifos(rspi);
 
-	list_for_each_entry(xfer, &message->transfers, transfer_list) {
-		if (!xfer->speed_hz)
-			continue;
-
-		speed_hz = min(xfer->speed_hz, speed_hz);
-		bits_per_word = xfer->bits_per_word;
-	}
-
-	if (speed_hz == U32_MAX)
-		return -EINVAL;
-
-	rspi->bytes_per_word = roundup_pow_of_two(BITS_TO_BYTES(bits_per_word));
-	rzv2h_rspi_reg_rmw(rspi, RSPI_SPCMD, RSPI_SPCMD_SPB, bits_per_word - 1);
-
-	rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
-	if (!rspi->freq)
-		return -EINVAL;
-
 	rzv2h_rspi_spe_enable(rspi);
 
 	return 0;
-- 
2.51.2



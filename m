Return-Path: <linux-spi+bounces-10880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E96C14E47
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B1F3A3AE6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E11336ED0;
	Tue, 28 Oct 2025 13:33:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D45335BBB;
	Tue, 28 Oct 2025 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658380; cv=none; b=FLs5W20B5YYzWRT6HmPW7TQ+BHWbIToVicTlti4SgONIgn74cV2TGT+kATscWsvQZ/8ziFaL+lAkGgimWsBmq92NX+MK4gyUwxobe4UUhBMGZFlVdnmWXunBJpjUGTjFvLHbkRWmiy/Wn8lCzrSYPath1gGYYg2e24n7fbJTwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658380; c=relaxed/simple;
	bh=joz2msCJiTnVLJrce63/DT5n/i4l3DrrndPvJi2fclo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dklQb4QSVtqo1LCV+VAyAmV3LvNBiz4K69XRzWRb+84OvP/jnm9UtVW017Cp/42BWeVsK80Ue7cFFOMttMK7gkR/1Lxesd+Q/XGDYFxC9+Hnf8H4DznfVVpoR6X0BQj9+tQF/xe4sM1zgIm6pgChG9xye8qQel3TZ1WJwNxg/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: +4Yo8Q0ERJKyeGAbJm7kWA==
X-CSE-MsgGUID: /CG7akAvRUSLwqxwKcaEYw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Oct 2025 22:32:57 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 682C841B5F49;
	Tue, 28 Oct 2025 22:32:52 +0900 (JST)
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
Date: Tue, 28 Oct 2025 15:31:36 +0200
Message-ID: <20251028133151.1487327-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
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
2.51.1



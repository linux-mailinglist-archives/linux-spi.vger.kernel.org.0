Return-Path: <linux-spi+bounces-11338-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A81C7036A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 533DF4F8F29
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C61341064;
	Wed, 19 Nov 2025 16:15:43 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808E535BDCE;
	Wed, 19 Nov 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568943; cv=none; b=i3+hxiMgC6HKpDZwlEbAhytIJ1wZVWtUAlQ0NF2SiRT8zCbaJHQcQy1xo0iW3s6xuGbjNpEEE256XCDwjlTHl5RY2ZX7c6bnEEMIz2yvwzX05Z8vTSvOsIsH2u49yQAhez5uNFtQ8Jao6TOeLesKKlJnnsbDfE7qmiKlnWnBfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568943; c=relaxed/simple;
	bh=zqS7KC0O37iXU6ZkafAIXrDH+QRO56J5SOLz38B1YkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0E9bhrBLcZ+LfSUj390b0fjPM1kr7xiE6LQQ3AEElg1gR4CsvMvWOfclrO/gT07MCH1bb90ZlVCD/L9B7Nq5NtTc4p74399fODeSmqJI66PhjJX5Q3/F8OwOmtTVw/SnFXpNR2mP8TYxWGjDoSDkI8Q/6pr9D7yPo6B9KfDWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: vsy0+T6rR2e/jtvlNgZw4g==
X-CSE-MsgGUID: XCik1o4+QQ+TY6d6r2YQhg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Nov 2025 01:15:41 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3122A406C471;
	Thu, 20 Nov 2025 01:15:36 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v4 04/13] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
Date: Wed, 19 Nov 2025 18:14:25 +0200
Message-ID: <20251119161434.595677-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

V4:
 * no changes

V3:
 * no changes

V2:
 * no changes

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
2.52.0


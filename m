Return-Path: <linux-spi+bounces-11030-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C8C3533D
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFAB567224
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96A3090C6;
	Wed,  5 Nov 2025 10:43:53 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7AF308F30;
	Wed,  5 Nov 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339432; cv=none; b=IfsnVuqtRWsznNEjvatOPwhwtzLo/YsTtkuFPy90sLL5oJbd01CqhTDi117WrWKYSzJ9Q9taU37mnhZwUpObAT1bir4M+tTyItPLzyFB4w+RUpFcqZsLWi+1Ypwa2/ie1d6fpD39ekPy7Qcw8oyiGjaTqYXYwzW++rsosxxlv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339432; c=relaxed/simple;
	bh=UganWNkeKrLky13PVsdX6fI+hy19J24abS6vT+14ZUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JN5OAOLARZng4znSjp0ivGPWW9KS/w30hpFM0TwiV7gjfJtyzG8QGaH4IBi/IT3OcX2jDJI2JEpsEQnLR1kQWrtPOPhB+awKwb0zsbKahToEDcA2ZgsEpGlQ1Q9ZZ8A/WvrwA09pVHY03FfOmrVtcwSgHi10Ytn1vwLi9dVRQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: blj/yv6xSu+6BZwSsbL+jQ==
X-CSE-MsgGUID: oA9iNA2RS56PnU3wUS70dw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:43:50 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B3E1C4001DCB;
	Wed,  5 Nov 2025 19:43:45 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 10/14] spi: rzv2h-rspi: add support for loopback mode
Date: Wed,  5 Nov 2025 12:41:47 +0200
Message-ID: <20251105104151.1489281-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for loopback mode for debugging purposes, allowing us to
test the SPI controller at the maximum SPI transfer clock without being
limited by external wiring.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index be45269e8853..da110efba971 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -24,6 +24,7 @@
 /* Registers */
 #define RSPI_SPDR		0x00
 #define RSPI_SPCR		0x08
+#define RSPI_SPPCR		0x0e
 #define RSPI_SSLP		0x10
 #define RSPI_SPBR		0x11
 #define RSPI_SPSCR		0x13
@@ -40,6 +41,9 @@
 #define RSPI_SPCR_SCKASE	BIT(12)
 #define RSPI_SPCR_SPE		BIT(0)
 
+/* Register SPPCR */
+#define RSPI_SPPCR_SPLP2	BIT(1)
+
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
 #define RSPI_SPBR_SPR_PCLK_MIN	1
@@ -345,6 +349,7 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	u8 bits_per_word;
 	u32 conf32;
 	u16 conf16;
+	u8 conf8;
 
 	/* Make sure SPCR.SPE is 0 before amending the configuration */
 	rzv2h_rspi_spe_disable(rspi);
@@ -389,6 +394,10 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	/* Use SPCMD0 only */
 	writeb(0x0, rspi->base + RSPI_SPSCR);
 
+	/* Setup loopback */
+	conf8 = FIELD_PREP(RSPI_SPPCR_SPLP2, !!(spi->mode & SPI_LOOP));
+	writeb(conf8, rspi->base + RSPI_SPPCR);
+
 	/* Setup mode */
 	conf32 = FIELD_PREP(RSPI_SPCMD_CPOL, !!(spi->mode & SPI_CPOL));
 	conf32 |= FIELD_PREP(RSPI_SPCMD_CPHA, !!(spi->mode & SPI_CPHA));
@@ -490,7 +499,7 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 	}
 
 	controller->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
-				SPI_LSB_FIRST;
+				SPI_LSB_FIRST | SPI_LOOP;
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	controller->prepare_message = rzv2h_rspi_prepare_message;
 	controller->unprepare_message = rzv2h_rspi_unprepare_message;
-- 
2.51.2



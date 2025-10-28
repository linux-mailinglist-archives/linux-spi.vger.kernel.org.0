Return-Path: <linux-spi+bounces-10885-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B52C14E6D
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5626E563A43
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82898335BBE;
	Tue, 28 Oct 2025 13:33:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF83346A4;
	Tue, 28 Oct 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658415; cv=none; b=Bl3NP7CPiH2w2l/fZWZIhtQ+Mv53JEY/4aGZhYHFEjTMFAa9++Fbx6b6/GYJxF+Y4wfCwdDVXsOWykoCyTaWK2EA8U1c02+eya2l24O9SHZ+7QSdrAszMSMmmp3ZDmshR9yBYIOjL0sZ5lHeX6LH9GgD31p3Xk0T1x2k6OjFnCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658415; c=relaxed/simple;
	bh=gWYtvPpeXSVA7XFDqgz8mz6IOOEl6AvWy7mqQiEusmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSbrLHpZFZqQtCJdgwKRuwMyGPsQCCKvjIsGkWhTdIzJd2OOLTEDbksqSy+OLcvkjcj3KbcHpiU6FvnviEETMgE0R6rM1N+3vhQZ0dKkunhxWZsEvqcg0gUeSNwpZABtd5hS/RDuIYgvqZ/gwR5N6DRq5kI44LoLqFtKry9SabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: jGDFj/SGTcG9mHVtUv8dew==
X-CSE-MsgGUID: 7XwhVs0pTiK3JUDmX610Dg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2025 22:33:32 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 902F741B5F49;
	Tue, 28 Oct 2025 22:33:27 +0900 (JST)
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
Subject: [PATCH 10/14] spi: rzv2h-rspi: add support for loopback mode
Date: Tue, 28 Oct 2025 15:31:41 +0200
Message-ID: <20251028133151.1487327-11-cosmin-gabriel.tanislav.xa@renesas.com>
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

Add support for loopback mode for debugging purposes, allowing us to
test the SPI controller at the maximum SPI transfer clock without being
limited by external wiring.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 9bd350e1f1fa..70239fb1c03a 100644
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
2.51.1



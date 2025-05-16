Return-Path: <linux-spi+bounces-8158-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86DAB9D6F
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0227B5030
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDF13AD3F;
	Fri, 16 May 2025 13:32:44 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47761E48A
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402363; cv=none; b=IByCuwCgBX34IeZz3Mb0C0rFe3EBnIOjtdTz5rrQYMXw7VqCFvISfbxoOEVxtliDC4isWDWxLzHQJAV8I2c7oaDWGJsG/uw9/k6+b+zHvKgKMLEzAxx4UA7iSmy19m0AKn8UrVPvph4Xr65AuVW/eUqhauAIgFrHMjxzKhCLKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402363; c=relaxed/simple;
	bh=LuODtqMqNqE67UFe8dKvyWUrqUEvf/b+rEpkFnOSe+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cyk/I7mCjnJetZJLsTNuFd0BWh6R8chdWyV9RJEjOoSMOE1GhEjKD5kWcDaz3bPRZ/PP7Pvd3L2mUweZGEGT6DBSvUHwmsj32M+vSbSmtJIMgIayCpLwYJgTs5qYVmwTrnQwzVG2dfnubhCiCVAO9hJWO/VCa1h6f8cgslNyIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4ZzSgP37T3z4x92B
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 15:32:33 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by andre.telenet-ops.be with cmsmtp
	id ppYY2E0053S8nz401pYYf4; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020jL-2Q4O;
	Fri, 16 May 2025 15:32:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000153L-44sw;
	Fri, 16 May 2025 15:32:31 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 17/22] spi: sh-msiof: Increase TX FIFO size for R-Car V4H/V4M
Date: Fri, 16 May 2025 15:32:20 +0200
Message-ID: <69cb5fc48f034d37484fa127b9864a1971a83417.1747401908.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747401908.git.geert+renesas@glider.be>
References: <cover.1747401908.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSIOF transmit FIFOs on R-Car V4H and V4M have 256 stages.
Add a new family-specific match entry to handle this.
Add quirk match entries for older R-Car Gen4 Socs (R-Car V3U and S4-8)
that have transmit FIFOs with only 64 stages, just like on R-Car Gen3.

Update the (unused) definition of SIFCTR_TFUA for consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Alternatively, the family-specific match entry could keep referring to
rcar_gen3_data, and R-Car V4H and V4M could refer to the new entry.

Tested on White Hawk (R-Car V4H) and Gray Hawk Single (R-Car V4M) with
spi-loopback-test and external loopback, DMA and PIO, and a logic
analyzer.

v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8afb7c1f64cd4486..26e71fc8890fda6d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -149,7 +149,7 @@ struct sh_msiof_spi_priv {
 #define SIFCTR_TFWM_8		5U		/*  Transfer Request when 8 empty stages */
 #define SIFCTR_TFWM_4		6U		/*  Transfer Request when 4 empty stages */
 #define SIFCTR_TFWM_1		7U		/*  Transfer Request when 1 empty stage */
-#define SIFCTR_TFUA		GENMASK(26, 20) /* Transmit FIFO Usable Area */
+#define SIFCTR_TFUA		GENMASK(28, 20) /* Transmit FIFO Usable Area */
 #define SIFCTR_RFWM		GENMASK(15, 13)	/* Receive FIFO Watermark */
 #define SIFCTR_RFWM_1		0U		/*  Transfer Request when 1 valid stages */
 #define SIFCTR_RFWM_4		1U		/*  Transfer Request when 4 valid stages */
@@ -1113,6 +1113,15 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
 	.min_div_pow = 1,
 };
 
+static const struct sh_msiof_chipdata rcar_gen4_data = {
+	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
+			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
+	.tx_fifo_size = 256,
+	.rx_fifo_size = 256,
+	.ctlr_flags = SPI_CONTROLLER_MUST_TX,
+	.min_div_pow = 1,
+};
+
 static const struct sh_msiof_chipdata rcar_r8a7795_data = {
 	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
 			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
@@ -1128,7 +1137,9 @@ static const struct of_device_id sh_msiof_match[] __maybe_unused = {
 	{ .compatible = "renesas,rcar-gen2-msiof", .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7795",   .data = &rcar_r8a7795_data },
 	{ .compatible = "renesas,rcar-gen3-msiof", .data = &rcar_gen3_data },
-	{ .compatible = "renesas,rcar-gen4-msiof", .data = &rcar_gen3_data },
+	{ .compatible = "renesas,msiof-r8a779a0",  .data = &rcar_gen3_data },
+	{ .compatible = "renesas,msiof-r8a779f0",  .data = &rcar_gen3_data },
+	{ .compatible = "renesas,rcar-gen4-msiof", .data = &rcar_gen4_data },
 	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, /* Deprecated */
 	{ /* sentinel */ }
 };
-- 
2.43.0



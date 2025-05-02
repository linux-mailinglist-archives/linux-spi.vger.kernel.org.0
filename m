Return-Path: <linux-spi+bounces-7829-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B12AA6F02
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737169C2DB8
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78823E34D;
	Fri,  2 May 2025 10:14:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB623959D
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180854; cv=none; b=prMY/MUc4MAAps3LviT5RgJl69anq7C7/OsKN2m57khoaPJDCCqR0vAeryFv9oYAWbwMNuAOrczQ3/g606+YhRb13HfZq+GDmsE1EkjDXjes1nRuz8WS3cHTN+qufE2uNdglPNLrt20LCKRXHOBzZa1NVyZC0LRB6atyXguVxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180854; c=relaxed/simple;
	bh=wrNVWQAIB26zJHbPSQt+V+aYvkM5qOnkaYzzPYTugGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZegC9pB7nwBJ53RmIcu99TKt2Qju+HOjsLx5roYXa2LaH/FN5Wg5mlVsh/DbmKOfP3rOLiJdDlJ0QxAAvExudr4MgNEmZQqgCP2X5uGbSbuUU08NXU7zzIMgV7j2IoSVRSW11b8TffapsGPOdrJYdCPdPI9gz9ZgXB4kGG4iFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by baptiste.telenet-ops.be with cmsmtp
	id kAE02E00a4sst1101AE0qH; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP2-00000000WAL-0geh;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oXT-2Z1x;
	Fri, 02 May 2025 12:14:00 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 17/22] spi: sh-msiof: Increase TX FIFO size for R-Car V4H/V4M
Date: Fri,  2 May 2025 12:13:49 +0200
Message-ID: <145d7aa4e5a1ea6d07d290b83004e8dee44edafc.1746180072.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746180072.git.geert+renesas@glider.be>
References: <cover.1746180072.git.geert+renesas@glider.be>
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



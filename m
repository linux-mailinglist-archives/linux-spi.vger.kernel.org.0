Return-Path: <linux-spi+bounces-8174-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED202AB9D88
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47637B5250
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B664501A;
	Fri, 16 May 2025 13:32:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6C288B1
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402368; cv=none; b=nN8Lwfg0fawPwAPhFox+PVYELl/8D9jsMK6PwTA7Ug3apGwFvAqL/xpu45fGU06mKAzG2IOuvL93QtpghA0D4IdSOu1Nnotfu0A31h7vizbzKoy8t0PYO6IjZRWkU9/Mt/ymFiL82at+jalkKwkFklDWYO6bu11PGqN9ZviY18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402368; c=relaxed/simple;
	bh=NR9rZ3I3bj8QVK3gQZOn4ao8ltgkGFtn5GDgRLDfGx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1o/irm85m++2+wWJw0mLT5bP3rn8FK3DwnGLcMwTbMtdENHwsIMAXaIjt5vWxI0yvJIOGclslEcY0DKE4k6Sk0DJvwLz1po4vJfxPYzX0GTNBidT8aRrhV+/aOUSgYDoLufyWimhF8ZCtkfbBojsgr+dq+6DTIuWrihR9AHAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4ZzSgX4DW5z4x7nf
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 15:32:40 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by andre.telenet-ops.be with cmsmtp
	id ppYX2E00E3S8nz401pYXf1; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020ip-1TdN;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000152g-37fM;
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
Subject: [PATCH v2 09/22] spi: sh-msiof: SITMDR2 and SIRMDR2 bitfield conversion
Date: Fri, 16 May 2025 15:32:12 +0200
Message-ID: <135b92d010a71e2c224feab3a5792724b4e60ff1.1747401908.git.geert+renesas@glider.be>
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

Convert MSIOF Transmit and Receive Mode Register 2 field accesses to use
the FIELD_PREP() bitfield access macro.

This gets rid of explicit shifts and custom field preparation macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index fb83b049690e0207..51a9e89364756af0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -100,8 +100,8 @@ struct sh_msiof_spi_priv {
 						/* 0=MSIOF_SYNC, 1=MSIOF_SS1, 2=MSIOF_SS2 */
 
 /* SITMDR2 and SIRMDR2 */
-#define SIMDR2_BITLEN1(i)	(((i) - 1) << 24) /* Data Size (8-32 bits) */
-#define SIMDR2_WDLEN1(i)	(((i) - 1) << 16) /* Word Count (1-64/256 (SH, A1))) */
+#define SIMDR2_BITLEN1		GENMASK(28, 24)	/* Data Size (8-32 bits) */
+#define SIMDR2_WDLEN1		GENMASK(23, 16)	/* Word Count (1-64/256 (SH, A1))) */
 #define SIMDR2_GRPMASK1		BIT(0)		/* Group Output Mask 1 (SH, A1) */
 
 /* SITSCR and SIRSCR */
@@ -397,7 +397,8 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 				       const void *tx_buf, void *rx_buf,
 				       u32 bits, u32 words)
 {
-	u32 dr2 = SIMDR2_BITLEN1(bits) | SIMDR2_WDLEN1(words);
+	u32 dr2 = FIELD_PREP(SIMDR2_BITLEN1, bits - 1) |
+		  FIELD_PREP(SIMDR2_WDLEN1, words - 1);
 
 	if (tx_buf || (p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
 		sh_msiof_write(p, SITMDR2, dr2);
@@ -931,6 +932,7 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 				 struct spi_transfer *t)
 {
 	struct sh_msiof_spi_priv *p = spi_controller_get_devdata(ctlr);
+	unsigned int max_wdlen = FIELD_MAX(SIMDR2_WDLEN1) + 1;
 	void (*copy32)(u32 *, const u32 *, unsigned int);
 	void (*tx_fifo)(struct sh_msiof_spi_priv *, const void *, unsigned int,
 			unsigned int);
@@ -940,7 +942,6 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	void *rx_buf = t->rx_buf;
 	unsigned int len = t->len;
 	unsigned int bits = t->bits_per_word;
-	unsigned int max_wdlen = 256;
 	unsigned int bytes_per_word;
 	unsigned int words;
 	int n;
-- 
2.43.0



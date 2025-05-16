Return-Path: <linux-spi+bounces-8168-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C84AB9D7C
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7C03A9E81
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31635154423;
	Fri, 16 May 2025 13:32:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19697263B
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402368; cv=none; b=SA7Unl6K4d+EVRaAQ6xWPRU3r61BC8mI67Xbffdy7C2NT0AZWZtka0Aa/nyNsjmz7rcAgVWVuqxgiacc8b5WnwqvpVLQB38z5on5sT3aDydJeuYswrssRU/Binz+IhtKwj9uKi5Pnryq7K4ZJ24uE8CktrSgAFYhAkBq3dhvyeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402368; c=relaxed/simple;
	bh=A1zbrm/YrbGm8KIImpQxtjoyrg4DxOervDggAi0DpmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUESZa8+J/QoHBkF9SbnX+1jlfS4qdL9ubxV/7OQ40O0CB8ILdg/XvfQcYvZ7XkeGZr+96mdkXeUmimucPvbuXe+Jm1Dx6T65u273PFvRNPH2Derw+hmJ01d2LIyV6Jvri746+AMqBbaCLr4ELQO4uxSSTfE9ZMBXR1E/EnPrrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by albert.telenet-ops.be with cmsmtp
	id ppYX2E00H3S8nz406pYXwy; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020ij-1Fr3;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000152V-2sXr;
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
Subject: [PATCH v2 07/22] spi: sh-msiof: Make words/fs unsigned in FIFO helpers
Date: Fri, 16 May 2025 15:32:10 +0200
Message-ID: <a7b13ecb1811148227ec8c883079085ed1ea6eac.1747401908.git.geert+renesas@glider.be>
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

Make the words and fs parameters of the various FIFO filler and
emptier functions unsigned, as they can never be negative.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 84 +++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index fdb13dbc175249c4..7c15de08f4d8f131 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -412,140 +412,154 @@ static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
 }
 
 static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
-				      const void *tx_buf, int words, int fs)
+				      const void *tx_buf, unsigned int words,
+				      unsigned int fs)
 {
 	const u8 *buf_8 = tx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		sh_msiof_write(p, SITFDR, buf_8[k] << fs);
 }
 
 static void sh_msiof_spi_write_fifo_16(struct sh_msiof_spi_priv *p,
-				       const void *tx_buf, int words, int fs)
+				       const void *tx_buf, unsigned int words,
+				       unsigned int fs)
 {
 	const u16 *buf_16 = tx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		sh_msiof_write(p, SITFDR, buf_16[k] << fs);
 }
 
 static void sh_msiof_spi_write_fifo_16u(struct sh_msiof_spi_priv *p,
-					const void *tx_buf, int words, int fs)
+					const void *tx_buf, unsigned int words,
+					unsigned int fs)
 {
 	const u16 *buf_16 = tx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		sh_msiof_write(p, SITFDR, get_unaligned(&buf_16[k]) << fs);
 }
 
 static void sh_msiof_spi_write_fifo_32(struct sh_msiof_spi_priv *p,
-				       const void *tx_buf, int words, int fs)
+				       const void *tx_buf, unsigned int words,
+				       unsigned int fs)
 {
 	const u32 *buf_32 = tx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		sh_msiof_write(p, SITFDR, buf_32[k] << fs);
 }
 
 static void sh_msiof_spi_write_fifo_32u(struct sh_msiof_spi_priv *p,
-					const void *tx_buf, int words, int fs)
+					const void *tx_buf, unsigned int words,
+					unsigned int fs)
 {
 	const u32 *buf_32 = tx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		sh_msiof_write(p, SITFDR, get_unaligned(&buf_32[k]) << fs);
 }
 
 static void sh_msiof_spi_write_fifo_s32(struct sh_msiof_spi_priv *p,
-					const void *tx_buf, int words, int fs)
+					const void *tx_buf, unsigned int words,
+					unsigned int fs)
 {
 	const u32 *buf_32 = tx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		sh_msiof_write(p, SITFDR, swab32(buf_32[k] << fs));
 }
 
 static void sh_msiof_spi_write_fifo_s32u(struct sh_msiof_spi_priv *p,
-					 const void *tx_buf, int words, int fs)
+					 const void *tx_buf,
+					 unsigned int words, unsigned int fs)
 {
 	const u32 *buf_32 = tx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		sh_msiof_write(p, SITFDR, swab32(get_unaligned(&buf_32[k]) << fs));
 }
 
 static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,
-				     void *rx_buf, int words, int fs)
+				     void *rx_buf, unsigned int words,
+				     unsigned int fs)
 {
 	u8 *buf_8 = rx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		buf_8[k] = sh_msiof_read(p, SIRFDR) >> fs;
 }
 
 static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,
-				      void *rx_buf, int words, int fs)
+				      void *rx_buf, unsigned int words,
+				      unsigned int fs)
 {
 	u16 *buf_16 = rx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		buf_16[k] = sh_msiof_read(p, SIRFDR) >> fs;
 }
 
 static void sh_msiof_spi_read_fifo_16u(struct sh_msiof_spi_priv *p,
-				       void *rx_buf, int words, int fs)
+				       void *rx_buf, unsigned int words,
+				       unsigned int fs)
 {
 	u16 *buf_16 = rx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		put_unaligned(sh_msiof_read(p, SIRFDR) >> fs, &buf_16[k]);
 }
 
 static void sh_msiof_spi_read_fifo_32(struct sh_msiof_spi_priv *p,
-				      void *rx_buf, int words, int fs)
+				      void *rx_buf, unsigned int words,
+				      unsigned int fs)
 {
 	u32 *buf_32 = rx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		buf_32[k] = sh_msiof_read(p, SIRFDR) >> fs;
 }
 
 static void sh_msiof_spi_read_fifo_32u(struct sh_msiof_spi_priv *p,
-				       void *rx_buf, int words, int fs)
+				       void *rx_buf, unsigned int words,
+				       unsigned int fs)
 {
 	u32 *buf_32 = rx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		put_unaligned(sh_msiof_read(p, SIRFDR) >> fs, &buf_32[k]);
 }
 
 static void sh_msiof_spi_read_fifo_s32(struct sh_msiof_spi_priv *p,
-				       void *rx_buf, int words, int fs)
+				       void *rx_buf, unsigned int words,
+				       unsigned int fs)
 {
 	u32 *buf_32 = rx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		buf_32[k] = swab32(sh_msiof_read(p, SIRFDR) >> fs);
 }
 
 static void sh_msiof_spi_read_fifo_s32u(struct sh_msiof_spi_priv *p,
-				       void *rx_buf, int words, int fs)
+				       void *rx_buf, unsigned int words,
+				       unsigned int fs)
 {
 	u32 *buf_32 = rx_buf;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < words; k++)
 		put_unaligned(swab32(sh_msiof_read(p, SIRFDR) >> fs), &buf_32[k]);
@@ -673,13 +687,15 @@ static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p,
 
 static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 				  void (*tx_fifo)(struct sh_msiof_spi_priv *,
-						  const void *, int, int),
+						  const void *, unsigned int,
+						  unsigned int),
 				  void (*rx_fifo)(struct sh_msiof_spi_priv *,
-						  void *, int, int),
+						  void *, unsigned int,
+						  unsigned int),
 				  const void *tx_buf, void *rx_buf,
 				  unsigned int words, unsigned int bits)
 {
-	int fifo_shift;
+	unsigned int fifo_shift;
 	int ret;
 
 	/* limit maximum word transfer to rx/tx fifo size */
@@ -913,8 +929,10 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 {
 	struct sh_msiof_spi_priv *p = spi_controller_get_devdata(ctlr);
 	void (*copy32)(u32 *, const u32 *, unsigned int);
-	void (*tx_fifo)(struct sh_msiof_spi_priv *, const void *, int, int);
-	void (*rx_fifo)(struct sh_msiof_spi_priv *, void *, int, int);
+	void (*tx_fifo)(struct sh_msiof_spi_priv *, const void *, unsigned int,
+			unsigned int);
+	void (*rx_fifo)(struct sh_msiof_spi_priv *, void *, unsigned int,
+			unsigned int);
 	const void *tx_buf = t->tx_buf;
 	void *rx_buf = t->rx_buf;
 	unsigned int len = t->len;
-- 
2.43.0



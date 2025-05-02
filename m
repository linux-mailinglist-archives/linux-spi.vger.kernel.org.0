Return-Path: <linux-spi+bounces-7831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82983AA6EFE
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124ED9C2C05
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392823ED56;
	Fri,  2 May 2025 10:14:16 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6122E3F9
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180854; cv=none; b=gvlIqnR+Z4SVtcvF954PgmBjO6IJdlXGmF2PbBz77ZuFk3kpsvTzSPS6aQ1dOgIpknIa62Q9vkzzbHrcwIPOWI0V2IF7skV6BawuRrIsFUrpDdo+BlnKzVcIep0ONA4mlxuQmE2o4B+mGT9tBWhJnPzsBRKI15yj+MNCqHy4AMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180854; c=relaxed/simple;
	bh=pxqZFJdONaO3MXdMsejwOXvlyew8m+avrkdh3jmJV4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuDUkMk+fKRRirQt/4HPUzpjs0BjBbzj48DKJpoSAmjghVE5619dQ01NMOtMz1//soV8fAnMwK0UFkrhJWrvGypt9+UK53E/arhVywx2yNBKVKJxUE3Oi9ltXFj7ZzvqrrZlw+IMrxUYP68BOFZ6P/PIH3OYGcoQUUT7Phdjvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by albert.telenet-ops.be with cmsmtp
	id kAE02E00i4sst1106AE0H6; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP1-00000000W9h-3TpV;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oWf-17dm;
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
Subject: [PATCH 07/22] spi: sh-msiof: Make words/fs unsigned in FIFO helpers
Date: Fri,  2 May 2025 12:13:39 +0200
Message-ID: <791e7d9b0d764bf7733550d79fd2afb466e5ad1c.1746180072.git.geert+renesas@glider.be>
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

Make the words and fs parameters of the various FIFO filler and
emptier functions unsigned, as they can never be negative.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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



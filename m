Return-Path: <linux-spi+bounces-7843-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9693CAA6F1D
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22BA7B5EC2
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426423BD06;
	Fri,  2 May 2025 10:14:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A593723C4F3
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180857; cv=none; b=BbppePU/QYj/c3pJlDMJhOlADbdLFasGhqVD7DABlAFScnUrXk/Ubh9oLUnNT0xa3VBLe3Y600adyTkywkkI+RwGIrgAkNmvqgA/rNLr1dlWDn7PAqTXug8Ycpdz8e+za6zcAafBWAiy9K4pHYi9zx1WZoAdRIY+T8uFS/SyTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180857; c=relaxed/simple;
	bh=rBXLDL+Tkncfv6CsNsB0G/Z3NeKSOP7iOMnaNnuqdME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7sv1Wf0XvtHDd5t2H3Tn8ddVzlmbWQVe4jtDIIv5GXOCI+esycMyGrYXWPAdUNz6E+N1vAAS1NXsm8uHjkDEkK2UKGH6/8y47TZ/z3XmoPjVaqN4xLvjAwvp5UduYvmJl12xyaGxj+kJC0y+UWrymfxuIHF4uKCyVVN2oY0ryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by michel.telenet-ops.be with cmsmtp
	id kAE02E00T4sst1106AE0of; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP1-00000000W9X-38j1;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oWV-0vVd;
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
Subject: [PATCH 05/22] spi: sh-msiof: Use bool for boolean flags
Date: Fri,  2 May 2025 12:13:37 +0200
Message-ID: <8e3d18d685f04e3ab7761167c03b9171c12a86e9.1746180072.git.geert+renesas@glider.be>
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

Use bools instead of integers for boolean flags, which allows us to
remove the "!!" idiom from several expressions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 367622985fea2a04..11ef5c0a498d7c1f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -348,11 +348,11 @@ static u32 sh_msiof_spi_get_dtdl_and_syncdl(struct sh_msiof_spi_priv *p)
 }
 
 static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p, u32 ss,
-				      u32 cpol, u32 cpha,
-				      u32 tx_hi_z, u32 lsb_first, u32 cs_high)
+				      bool cpol, bool cpha, bool tx_hi_z,
+				      bool lsb_first, bool cs_high)
 {
+	bool edge;
 	u32 tmp;
-	int edge;
 
 	/*
 	 * CPOL CPHA     TSCKIZ RSCKIZ TEDG REDG
@@ -587,7 +587,8 @@ static int sh_msiof_prepare_message(struct spi_controller *ctlr,
 {
 	struct sh_msiof_spi_priv *p = spi_controller_get_devdata(ctlr);
 	const struct spi_device *spi = msg->spi;
-	u32 ss, cs_high;
+	bool cs_high;
+	u32 ss;
 
 	/* Configure pins before asserting CS */
 	if (spi_get_csgpiod(spi, 0)) {
@@ -595,12 +596,11 @@ static int sh_msiof_prepare_message(struct spi_controller *ctlr,
 		cs_high = p->native_cs_high;
 	} else {
 		ss = spi_get_chipselect(spi, 0);
-		cs_high = !!(spi->mode & SPI_CS_HIGH);
+		cs_high = spi->mode & SPI_CS_HIGH;
 	}
-	sh_msiof_spi_set_pin_regs(p, ss, !!(spi->mode & SPI_CPOL),
-				  !!(spi->mode & SPI_CPHA),
-				  !!(spi->mode & SPI_3WIRE),
-				  !!(spi->mode & SPI_LSB_FIRST), cs_high);
+	sh_msiof_spi_set_pin_regs(p, ss, spi->mode & SPI_CPOL,
+				  spi->mode & SPI_CPHA, spi->mode & SPI_3WIRE,
+				  spi->mode & SPI_LSB_FIRST, cs_high);
 	return 0;
 }
 
-- 
2.43.0



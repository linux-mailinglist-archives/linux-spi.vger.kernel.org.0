Return-Path: <linux-spi+bounces-7835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F319BAA6F0C
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBA99C2F52
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA124167D;
	Fri,  2 May 2025 10:14:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2923BCE4
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180855; cv=none; b=uUPT9/5m0STGy2rCEVCoxI01xmeIMTAai1ZLAHs6Bv9tWnudvSPcj4+IMupxITDSaQbpKFDkf2Yj0wIwhaSgjjmrJ3nf5rkgc1Sm9E4DsbpuEr0khEWpnZi+yGbyX3WOPTUKuRh6VtXlAhT1pbPKyNdy0Xmfousd4k3GVwnjxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180855; c=relaxed/simple;
	bh=ttVVLouJtAheS+D2jwhw8ROsDwf3R9qtA828pzkOU4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJlEZIEQGUez+D9zRGupwy38/IZ5BCFomgJn5YWI8xZRgPUxg/5XuAT3Cstpvr6KqPE0ouQUL0PFPNcjOsjpiGG01/fdobTmvaOSit5nZK361py3iMqh6syCI1xWW9XBUOgQgZb2ziyizm/pms4kLjAEp2yqKEpcTTbAp9PWXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by andre.telenet-ops.be with cmsmtp
	id kAE02E00g4sst1101AE0RK; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP2-00000000WA6-0Cld;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oXA-20C4;
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
Subject: [PATCH 13/22] spi: sh-msiof: Correct SIMDR2_GRPMASK
Date: Fri,  2 May 2025 12:13:45 +0200
Message-ID: <d304d6ea5d6e9250f2741a50d651d312b048de0a.1746180072.git.geert+renesas@glider.be>
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

The Group Output Mask is not a single bit, but a bit field, containing
one bit for each of the four possible groups.  Correct the definition.

Note that this change has no direct impact, as the driver only uses
the first group.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 812e64ea5f79ce5e..57f27040b0fc78d7 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -102,7 +102,7 @@ struct sh_msiof_spi_priv {
 /* SITMDR2 and SIRMDR2 */
 #define SIMDR2_BITLEN1		GENMASK(28, 24)	/* Data Size (8-32 bits) */
 #define SIMDR2_WDLEN1		GENMASK(23, 16)	/* Word Count (1-64/256 (SH, A1))) */
-#define SIMDR2_GRPMASK1		BIT(0)		/* Group Output Mask 1 (SH, A1) */
+#define SIMDR2_GRPMASK		GENMASK(3, 0)	/* Group Output Mask 1-4 (SH, A1) */
 
 /* SITSCR and SIRSCR */
 #define SISCR_BRPS		GENMASK(12, 8)	/* Prescaler Setting (1-32) */
@@ -400,7 +400,7 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 	if (tx_buf || (p->ctlr->flags & SPI_CONTROLLER_MUST_TX))
 		sh_msiof_write(p, SITMDR2, dr2);
 	else
-		sh_msiof_write(p, SITMDR2, dr2 | SIMDR2_GRPMASK1);
+		sh_msiof_write(p, SITMDR2, dr2 | SIMDR2_GRPMASK);
 
 	if (rx_buf)
 		sh_msiof_write(p, SIRMDR2, dr2);
-- 
2.43.0



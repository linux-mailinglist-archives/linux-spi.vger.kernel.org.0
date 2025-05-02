Return-Path: <linux-spi+bounces-7834-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFC0AA6F0B
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8F1BC4B19
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F223C4EA;
	Fri,  2 May 2025 10:14:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76098238C26
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180855; cv=none; b=p2dKMWPr5K713MgNAW/o55Hfw2cm5KGp3HPSHeO2l9RlguUVejMKbE4Rp/wXsNljetWm9t/WmmQmf+nIN8+vXcLgC/UwquFLWHUu1ASOKyoY7g6KOoFHKop0xUqLljXiYNxPsXDuk2IMChb/DhWp1TMA9sJeh9ZYbS8saBDEPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180855; c=relaxed/simple;
	bh=r7zuwlKEY2OlJP1J8bIKmvKwLKDgnRo8py2LSRrqw98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rI22imQJtkNY9S51h2faPw8bHBr+xjpDr4VOHKEeKKuG/TUohnC4bncjLgy2cEwjSULbAfdcrbmeRKmKXyrvY0FV5R8zuhJbu77o3rDX9ksk5K1Z+j9YL4DrdgOdYM4bfHIak776LFkaFxpu4lylfVZ1E84kSO2xrYIAYNO9014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by albert.telenet-ops.be with cmsmtp
	id kAE02E00T4sst1106AE0H5; Fri, 02 May 2025 12:14:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP1-00000000W9Q-31S9;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oWP-0pCr;
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
Subject: [PATCH 04/22] spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
Date: Fri,  2 May 2025 12:13:36 +0200
Message-ID: <961a52901c685b4e4e5158390cd51f1968ab9dde.1746180072.git.geert+renesas@glider.be>
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

Commit c4887bd4b35b225f ("spi: sh-msiof: use dev in
sh_msiof_spi_probe()") forgot to convert one instance.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index cf93c2ca821f84fa..367622985fea2a04 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1332,7 +1332,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(&pdev->dev), p);
+	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(dev), p);
 	if (ret) {
 		dev_err(dev, "unable to request irq\n");
 		goto err1;
-- 
2.43.0



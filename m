Return-Path: <linux-spi+bounces-11880-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C26CBA6D7
	for <lists+linux-spi@lfdr.de>; Sat, 13 Dec 2025 08:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AB2230517F0
	for <lists+linux-spi@lfdr.de>; Sat, 13 Dec 2025 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922B26F2AC;
	Sat, 13 Dec 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="l9AMgc2n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E753FCC;
	Sat, 13 Dec 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612212; cv=none; b=oMKEVtDGwOT0nuLIlMC9IHurIJMCRqWWT8n+/cnAL1rDo3lfNzsIUEiWN/IUTYy0RKEvmeIH1NvQ2NIUwycQgrq0WYAvtNcAnGweZW8PSQm9fwcCw5bUvfMpMWNJxgmXeii+l2gWnh7THybd+euxUwRqCNbaoe2poK6sJtGNFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612212; c=relaxed/simple;
	bh=zPl8jdOfErDbetfy36FhTWsLjkCnqsYiK32veHf1xRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOW65u3VnM7RRVuV//XVktMkhPjEOCc9LRM0QDSUvazV8r5jdNtbq3NxPhwneDOG63Ej+xSFU+S13ZaTYXXzbGr8igyZBM9p84m0lVYreUVe1FSMRpFZq33PtUeSB1OTiiHnG1L2HBlzurjev2z0cUjG9OdaQu6TI9Wpav5i9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=l9AMgc2n; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id UKN4vDVOgExqPUKN4vDE3L; Sat, 13 Dec 2025 08:48:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1765612136;
	bh=TmR7zwuEwzlgwCwE4av5VCifSpkN9NkXmUL/n0dw1EU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=l9AMgc2nXTMTYWOFBJ938avi7lltf9B3F3SY2CV+2HkXNbU1T2bAj8mHum36wV6QV
	 RTOp3e+DeKf5q7596u178aPfzDIHQXTw5AkosOJ0dHReiUOG7BDx/B62TIfimFtCBt
	 6AoE5gf6pFhkLhDH1Gltrsm0G4AUEujH8BFzDcITl0/grTjRkHU/0rtbE+BhQKQ1vZ
	 KQG2yyc9TvARE+YKTiOk9zKVSkG9SB2fZQmkTcDP/6vZSp2Yhpw6IyAkwr5gCZ/q48
	 yWUwhjx6d+NIiQF3B0V0EtWQdr8ofZVlc7lp/ekqaWT4R31Ar8UZP+vaxVZ/azgO4h
	 VQ2qM9GvgPhJQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 13 Dec 2025 08:48:56 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: mpfs: Fix an error handling path in mpfs_spi_probe()
Date: Sat, 13 Dec 2025 08:48:51 +0100
Message-ID: <eb35f168517cc402ef7e78f26da02863e2f45c03.1765612110.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpfs_spi_init() calls mpfs_spi_enable_ints(), so mpfs_spi_disable_ints()
should be called if an error occurs after calling mpfs_spi_init(), as
already done in the remove function.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.

This patch is similar to commit 8cef9b451dc6 but for another driver.
---
 drivers/spi/spi-mpfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mpfs.c b/drivers/spi/spi-mpfs.c
index 9a14d1732a15..7e9e64d8e6c8 100644
--- a/drivers/spi/spi-mpfs.c
+++ b/drivers/spi/spi-mpfs.c
@@ -577,6 +577,7 @@ static int mpfs_spi_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
+		mpfs_spi_disable_ints(spi);
 		mpfs_spi_disable(spi);
 		return dev_err_probe(&pdev->dev, ret,
 				     "unable to register host for SPI controller\n");
-- 
2.52.0



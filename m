Return-Path: <linux-spi+bounces-11805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C9CA95CF
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D79A4301AE33
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 21:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C4C2DF146;
	Fri,  5 Dec 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mXklP+lP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-73.smtpout.orange.fr [80.12.242.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71271E8826;
	Fri,  5 Dec 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969329; cv=none; b=ZucQoyKPNBElOshMLyjwpYQjnA/Kcobom9TbADspVhPKBF39pti7rZnS8z1h1ePrPZSUs/GDOoMZP0AppQ++V1PuYU1uqQLus4mmMnlRChbK80UJ/4mWzRsAD7+2O7wJ0Cu6CtzCzeIhvQSMN9bjI0nFoYBv+hQdwxSGKChvOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969329; c=relaxed/simple;
	bh=A9EFSRqa6HI2WxRD+kgRbf7xZRuvXvprJLa6U1rUst8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZcDwEcdn2JTzplrDTocqy/QEdMFT0Dx4nUmgmqFO1mNImBKtgMeQguMTFyZ76M0XcC4rCtFII9JWbxgcsjp41vzUAa/Fj3sRgKxpLXgII4/4JTHNkIp6Brl2y/ubBeUcmneHGIyG4G6GhHrGmDV7DlucVceR/imUfDRC2f58ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mXklP+lP; arc=none smtp.client-ip=80.12.242.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Rd82vxaYqbhd9Rd82vooVI; Fri, 05 Dec 2025 22:14:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1764969254;
	bh=NttZKfhK2PYP9twTCcSRra27sQ6CUCC8tcUg4+pKC7A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mXklP+lP0HpvShZmvt8hrvB3aaXe4Nk+o9yrQCqaS1ccCMomnDE42tf8yLmI9J7Hd
	 GKg2oUCSJDrdQi1gkodh8LGhdcRobSb73m9lX5wDbb/aEss7XbkV5FCZ/tcqr3gR04
	 Hl7Ce35dqvzFnC4wFPuJfL0ayJVdXPTcXGsE1R7/i99EiE8W4xVMKB86xZbriAGHjb
	 QsHKrjpchaJQs5vlcYm0se5M0oEbqK4N3LxSTP+53UPqkd2xBDRGcouTmCIRCkiKqF
	 DcGCYdwUR9UyFd+yjHeYMAFlQ7a/W4nvlwzRWSSB9LlCgn+YFDv4KjFzCoOdOlNAAR
	 h67wN67ArlZAw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Dec 2025 22:14:14 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: microchip-core: Fix an error handling path in mchp_corespi_probe()
Date: Fri,  5 Dec 2025 22:14:10 +0100
Message-ID: <a7aaff1f28a83303a288de2914724a874fe1a11e.1764969247.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mchp_corespi_init() calls mchp_corespi_enable_ints(), so
mchp_corespi_disable_ints() should be called if an error occurs after
calling mchp_corespi_init(), as already done in the remove function.

Fixes: 059f545832be ("spi: add support for microchip "soft" spi controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is compile tested only.
---
 drivers/spi/spi-microchip-core-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index 98bf0e6cd00e..89e40fc45d73 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -387,6 +387,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
+		mchp_corespi_disable_ints(spi);
 		mchp_corespi_disable(spi);
 		return dev_err_probe(dev, ret, "unable to register host for CoreSPI controller\n");
 	}
-- 
2.52.0



Return-Path: <linux-spi+bounces-7352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAAA73F26
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB13AD7DC
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED11C700A;
	Thu, 27 Mar 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="lplCpauW"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E417A31E;
	Thu, 27 Mar 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743105589; cv=none; b=XH4X+r53e9SOJwbpfpjMmeixI+ztpyX1QnVWZw6WnSE8G4clm0Lo4fude2q/h1G10iowzxkBR22MwxMA6HpLLxB1uDRNXUlD+diZdRQw03tMq/5QziKW/9AQlYdog9dFjoeAPWe65ZVq8BaNnEzx/sSoAEWXWu77IuEL556sYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743105589; c=relaxed/simple;
	bh=ZEXW2O7h5RH6Mp/gFSotZYIhjX5T0tvJ/uNjX7f0reM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQlpLZ00Z/SutC9AM8DyGD+tu78JXu9Io9NUE00AXi2gzSJiDEAZ5X+kdpCWBdJLb3PyHzW0FsBBKeGcHFUcTVUhTSJ0AD+AAeRfNHUkxaLWhbG7WDSVWwFErAmYLTm3G6C3y8QzVOguqo6v6X8lLWXhoyF5m4vB42vrThKvwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=lplCpauW; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 15B8EA07C8;
	Thu, 27 Mar 2025 20:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ntL/r97AdlpWnW+HECsF
	a4zjnJTd1uAw3/3VEUgoZkU=; b=lplCpauWoEdxdgEUgrZgRfCLiG3oZbsXyuzX
	rW8iUImqNjJUM3ZlwmOkB05ge+6ElpbGLTLD3bRI7xOVAvzctSNuQycbGdqy0u/Z
	ui6ltSXmpjl9R1o+pafc8bFcvCTTtiEG4UQEMH7HYpok5z8nNn+jS8gTTjsat5TN
	MLTcr1sHoh2jBL1HgPxfAhBEwwKxs1J3xGyOV2pasa2Ph33lt52iVRljGXq5Osuh
	W24+UAyb0vQcWUZ7EOQGz9g2r2pwbzJGKO5dFHJcgKJ/Ypz+Ah61ejtxQZxq7YUr
	tsC7z/L28oelzo/Iu35HdmEZje39GBmS0jGNOxClynvqs9u11M7Znel1gdvH9oPB
	f/Wne1sx25yUQroUp7X9OSYiVZYj12iGIpaf98l3Qw+ZRPufQL8zD47NY8nYvAu3
	Mg6XhZeYL3Bd93HA3VFTqxlcAmKpO4VQGqwPHcYm9n4UDghq1xWB5aqLLbYH+s/c
	8GnzBBMQTvrAobd+zQvl7wgS+wktiBn8mK8u0qGCmpFMY7ocGf6peC1qvlbZ0ro5
	pVzg0XjnIbfoBR68PAQz2H84Bv3cVxN1ekeySRAVGMRgpkElD2uijd0Qa+KvJSIr
	ZjCt5XLJzVI9h4LXWUqv1e0qATvNS7oQCekKDyubfGXmjrxFGUrqI1FNKsUEhTR6
	7JOBnmQ=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v6 2/2] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API
Date: Thu, 27 Mar 2025 20:59:27 +0100
Message-ID: <20250327195928.680771-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250327195928.680771-2-csokas.bence@prolan.hu>
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1743105585;VERSION=7987;MC=2725881566;ID=112016;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526C776A

Fix unbalanced PM in error path of `atmel_qspi_probe()`
by using `devm_pm_runtime_*()` functions.

Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-spi/20250110-paycheck-irregular-bcddab1276c7@thorsis.com/
Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 244ac0106862..e7b61dc4ce67 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1436,22 +1436,17 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_noresume(&pdev->dev);
+	devm_pm_runtime_set_active_enabled(&pdev->dev);
+	devm_pm_runtime_get_noresume(&pdev->dev);
 
 	err = atmel_qspi_init(aq);
 	if (err)
 		goto dma_release;
 
 	err = spi_register_controller(ctrl);
-	if (err) {
-		pm_runtime_put_noidle(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-		pm_runtime_set_suspended(&pdev->dev);
-		pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (err)
 		goto dma_release;
-	}
+
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
@@ -1530,10 +1525,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 		 */
 		dev_warn(&pdev->dev, "Failed to resume device on remove\n");
 	}
-
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
 }
 
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
-- 
2.49.0




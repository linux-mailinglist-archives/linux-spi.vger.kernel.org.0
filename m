Return-Path: <linux-spi+bounces-6711-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A56A2EAB8
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ECE3A06D3
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334CC1DED72;
	Mon, 10 Feb 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="p0IEjtR8"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A619342F;
	Mon, 10 Feb 2025 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185820; cv=none; b=cm6PcbMklMsv9hGJsrlOJ48JJ7BhOwn83hr51wsM0ws2InlCBkW9k0a/3p60uqU+a2wAdSKK9IrTvfznWcV3XBMWsIWps3AMxhWFQLl+iN07q0onKYDWub31MwOWGK8+aTfUH0PMOnK3ob8PXOKspEfvj+wvIiW1uBkS8nLPk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185820; c=relaxed/simple;
	bh=UDDLRUhgyFGQp3GMduI8bIuj9aPJO6O7I9E2IdhlDOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeuOkffx+rFZuphJDPgD659apXW59yHToYlal6ybu4caGPVmZIlAnA72hs+oyHk1s+422qJF3W8fBXrpegmgNTY9WUTbM6n7FEV7oalTo+9B9beTXkkVy6jNqqU+8MMHB685vkqdWZ7TrTmwja6tB0cOeKqjQGyYec/lv57Jetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=p0IEjtR8; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EB351A008F;
	Mon, 10 Feb 2025 12:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=YVFEdSumyPyLjFPj1o6M
	jxa9Ytzsro9GKpkffHBxyNA=; b=p0IEjtR8x70Vyp1pMMdSwYo9g8vzTByLY7Pz
	RV77Je9WlvprxH3V7VQV+llOqWdoS4AFcAxhgp/hFUJygRYwZA/3lUntm7HpKlEz
	2yLq/hBzWi5k0qhHg399/25a9wvN/bIOVH58USuWyLfo12ZVPUViWSGaYd4N9ZUA
	Fw+J4Mm1tUVRnXgVIli4Yi0S53wj2bmWvyy24wYwcrt1w8IzN5uX9y8nCOk7g6Ax
	rKWMt92owupNtqGqlKBNROY7aEwaBlQiZJjQWhczIYRJGKzt5GwQP0XHzazxBNkN
	+O7f9yKkB3R7HgzrB17SASKr/+n49Ho8q33ljRuIHFiuZOmfhHiNdWKdj1/G2GvE
	99eRBr6O9GZmBfgEbgJzfvn+snZMtzsPvbO0pwjnvlQ7GVQ25uRWZFvtXqICFV9Q
	bETdvQIAwWVL7J9/rxvKRwa+Egm54PCZtfZ0kynEaUn6Sg5E/2MucI2xtrKvTmfx
	07tsv5CM5DlZAxiui+twjyq4ZfELfFQE3wFOupDn7g/xg/NRx03yZK8DWvOENYxm
	vwgcGTx7KaUKTcO6KeRAmdW3+w5ktao+Av9DqBsPXu6L1cmH+CngiAlT8v1wacSI
	OCSJk98likYCrJEf4SvvsFGs6yb0HVYQai8zDz2d+S/FOgKKoMLTLjTHMXUlH4wk
	s7x/1Y0=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Varshini Rajendran <varshini.rajendran@microchip.com>, Mark Brown
	<broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexander Dahl <ada@thorsis.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH for-6.14 v4 2/2] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API
Date: Mon, 10 Feb 2025 12:10:07 +0100
Message-ID: <20250210111008.248929-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210111008.248929-1-csokas.bence@prolan.hu>
References: <20250210111008.248929-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1739185815;VERSION=7985;MC=1862294975;ID=637657;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485261776A

Fix unbalanced PM in error path of `atmel_qspi_probe()`
by using `devm_pm_runtime_*()` functions.

Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-spi/20250110-paycheck-irregular-bcddab1276c7@thorsis.com/
Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index abdc49d9d940..17dd4dd4384c 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1439,22 +1439,18 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_noresume(&pdev->dev);
+	devm_pm_runtime_set_active(&pdev->dev);
+	devm_pm_runtime_enable(&pdev->dev);
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
 
@@ -1533,10 +1529,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
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
2.48.1




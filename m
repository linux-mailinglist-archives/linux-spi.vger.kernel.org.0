Return-Path: <linux-spi+bounces-6359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F44A1280C
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 17:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1E5167F00
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86016165F18;
	Wed, 15 Jan 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="iJxIkM7H"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3C136E37;
	Wed, 15 Jan 2025 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956979; cv=none; b=Fbe8Dgdt83mFqLGzYwjVmpejp8c4PeQoJ1I9OOukcBWtLiNipQ5+7W4jWpOBybbmpOOAdl55j3LFERIJ+x57WwbD2F0eb7tkHa9dTXExeSRYBshuHp96jIQvmymPBDUBtyyZ4OKOSZwfI3rKM7bB7FRwnNst4CUaZgtX8sg3PrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956979; c=relaxed/simple;
	bh=JVtA38B9D2X67jIXePyuJQfXQd5uGhLubJJp1CfHH78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgTBfLyA1O1GPMcW7yWFMT5+zzcd12mbnGawCADW7PEfTtVBx8dcp3DdQo3lkfkgrFSiYSodCifV9V6YrwN6y6f037MoSkRKVVJzVvZJQj3hr58sAodKqDkk4z3bNh4Wi4rcOh8mLXZNJryRalzIfhJinsuX3xeu00n5sa1onQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=iJxIkM7H; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D7E9FA099A;
	Wed, 15 Jan 2025 17:02:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=VtKelQz/78A8bo8Vg0Jk
	YpThHcAAeYRmgdNPVPZFl4g=; b=iJxIkM7HY0Tv8C0GXViAA/y5NpP4ovq3qhom
	YPdXfZbhsQIaIBngULnL2S0ZtmTVWl9ETazZhmOKbSNlV74ZvhcfK+liDNBh0V58
	KbXJZndvj8wv1NaW6pZpdgQBQEmoY6UWxANrpMFMk+u9/wn/UHnsiyboEmuL2Rhr
	1/nvTbRd1YUT7id87nerGAhui88rJVOhnTJ1IqmfddgotpfJtnom8ZjDOriq5R09
	RDL4Dc1ezQg2yQYPoOyWZ1rPJ6IPA7KLy9Slv1wjeDxvQPdIwuVNZ8+Ak+X6lYFE
	RDdlpMKnHI0VFgXE2AAaghcARwfp/XVKejf/l5rv+l6M3XLkrDUiMt93pxSHzHuG
	fmBS874EBAaw/CnMcE1fiN7i8a7/kUSlhtg4cbb33ftITg3khLQidf+0KMlzD85I
	V5j9eABen5hdXpliVtcrVqgain3exWnvXgLjoNjUj7ry4cNompGmYoZfjiKPQtYr
	EZiYNrjhHP56T8Ma/ceIB4y7B4U6UJLgMnlPp68SZUzF8mvz/Yr5FQUo3dS9Id6h
	N3jXCFiN0HMc4SgXCPXsPxUBPy/i0fZ+bk0Q3HUwDEtYzteYxeDuVMEpiUWvZ4uU
	nC6ocTv+ETgYiaWoOxn3Qn4Kms3eLDsMgrMgT3IdiSYB3eC2/VNPzdIQi/jClzxY
	5oCVR04=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexander Dahl <ada@thorsis.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 4/4] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API
Date: Wed, 15 Jan 2025 17:02:41 +0100
Message-ID: <20250115160244.1102881-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115160244.1102881-1-csokas.bence@prolan.hu>
References: <20250115160244.1102881-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736956969;VERSION=7983;MC=3460317179;ID=287150;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852647067

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
index b1fb4426c78d..f2164685d3d5 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1426,22 +1426,18 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
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
 		return err;
 
 	err = spi_register_controller(ctrl);
-	if (err) {
-		pm_runtime_put_noidle(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-		pm_runtime_set_suspended(&pdev->dev);
-		pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (err)
 		return err;
-	}
+
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
@@ -1511,10 +1507,6 @@ static void atmel_qspi_remove(struct platform_device *pdev)
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
2.48.0




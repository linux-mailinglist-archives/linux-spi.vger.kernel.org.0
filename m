Return-Path: <linux-spi+bounces-7159-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C458A64789
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903C51888B34
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE12222BD;
	Mon, 17 Mar 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tFKrITnz"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15D221F1F;
	Mon, 17 Mar 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204106; cv=none; b=DwWtC3C8LWCyq+YNClyd6pAjAz1lNxbv8FO1iwXlhunIS/ZqNYchK2ChBh/cqaeoMMuICxSZuiycdzgTr0I9bXSqFkEkMGsU1fgo4Bs60wFYlQvnVCBk0NtaGccPuoG1XivjjoinrfFCUN/tqnw+TZs9MR8L0KSMebQadGNQ6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204106; c=relaxed/simple;
	bh=1yNiTnpZq7h2XJs8ppHSxpeBpp33kU7YALQKQVaM5Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozOD41IPcQIw1qDOnvw2En6lQmBZWhrMWviuLyuod2Qy7lPrH9pfZXlKAK8DpSFAQv9nYCozfTeL+T3al2ET8NBTBBJNHKxN5gAr93FlzIp8tTKiVZJPtEty/1Z/IdFKjdsVnP0+rhYnIZPSguQOW0x9sUWAJ9Grgq8Op2l7ElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tFKrITnz; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9F7E4A03CE;
	Mon, 17 Mar 2025 10:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=kNhLXI+/riZgGlyun993
	ceq6nIOh5kKXKpw5hxNT8to=; b=tFKrITnzbpzNEXu4W5eCBaP/V0hPvuMOE7P4
	RX5s6EqoZIcDfyJovFkfu1oO/Njvf3KkERfUJIxglIB+RMmiiSqNl3GUP/LIWZFV
	aeLNCdwF0mti8rwQG/P3K50tG4QLg7UJh2jWSw3a0BUCeU0LFyYGaxiTdqlE55aE
	f3aYazNQg81NyYhNMKcRsgeuYg6cUxns3uDgKm2uRSt4DiQbDVpKNOCG4Vw0eoib
	AWW5fus1jdLQ3byAvTSx/MZcq9vNn8L/v90h1PSkTKlcsr+wTyChhSuo7A5rh+Hj
	1L16fZanqMlO7YgCCiWQkaGZBR2QeqVudXuDdK9PQeo90+DwlJj6NfhBXSs6B6te
	RLX3xU/XMbNYbgZ8g+TG5kUwW6JGuc5GYnHWhjfeY6WiOUt2/2TVkkZFXmdLltwS
	5Yh/8+gt2Ky2sGujcyd8XQac7rOiuJsrduXlSkzW/DwebIKqMfdooDszIj5LDebb
	XXQB6TSjV2sfql8dqYXpFSLTRHJXRlHDTZruJifEcONPe/pqjeeti5GkqLUxtxCL
	oTg48RqS96mXvGRuCnXXn+UAZQXMDF0OM02kC7kQ/JY3kxvqYtH69ha+2BJM/a3+
	srVxDPvCo9JiMtF6Jwyze6Pqjdpl4mUTzb56IQ8ReJgOmmCvRctMlw6xkJzTTdAm
	hEO0aVs=
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
Subject: [PATCH v5 2/2] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API
Date: Mon, 17 Mar 2025 10:34:43 +0100
Message-ID: <20250317093445.361821-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317093445.361821-1-csokas.bence@prolan.hu>
References: <20250317093445.361821-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1742204096;VERSION=7986;MC=3178520588;ID=162301;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7462

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
index d8c9be64d006..ddd12600a6f1 100644
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




Return-Path: <linux-spi+bounces-6652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F53A2C304
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 13:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62DC3A9EC1
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625301F153D;
	Fri,  7 Feb 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="UhJfmbjo"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5341E32D5;
	Fri,  7 Feb 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932493; cv=none; b=JcUagJ9ZiL16rjGMO7qAk0bkpxtrBDwjXW8YqKzeMter5UzOjY7AOjoknKYmfu5kf0cEZN+e2FSMAVUINzhtirsZVxTqQDPzuCs/7SlNqk27hB4YbTFDHxPd7vtQB8RL55LJ/mylg3NzJfIHgbN/p/wCHLa20e+j8ql9xWv2QHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932493; c=relaxed/simple;
	bh=00BIKWjEFdesAJiVHawtYMPiLZHbdAdarr4Sl8y0DgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuO54xSm9v1TXPg/25g5JWTRELSmjPb0neupKByV+6hdJbGBJwh4AzwK7NpKPwa19/65kF5+EiW6VQVAbb5+Kto2PPSH8F6yblPlxojWO9oibjUBS40nHiNO7FJvNMsLcjK+S7jhJvFpV+ro67jieitRYrNUgkNJxd8zh9VCKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=UhJfmbjo; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5F71CA1B00;
	Fri,  7 Feb 2025 13:48:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=91vGKH59fvOB6uF7f30s
	PCflWM08DH4/8R/h6OH+xOk=; b=UhJfmbjox9I7Pv8JXx0NkD5Yy3+79iEgxkUi
	4etXnmKevAOaYoX2eQe3M1MYVhT/U5KVbz9ffvyyENKFiMKySEFsEcesQ3SrbwV6
	kTdVWbOgJ+4FRg1KIL+3LP00DU4CYyDN9IexLk9A2KODf92IYSP5mt1mPM8Q+pAa
	R8UfY2+Tbjil2/ajUKMvsix2qgamkOyJ+Fn0rjPezUtK2wlqIBdeo75havH6Xf3Z
	UVOj5eXOHmQUUxCuBF2vTs+9JLn26T7DzcxLDdHYjXTON78lObH34D7fhyspB51J
	aDqUwF69SCi2mdC1a8HhE0dZteoH7mQWyYsMEsF1CxzKaDQ/iMDZg1B2i09x7c25
	P+chjJcvqwJzSrC0zYOC+EHPOGF7dewFtH0qH3qsmuT45JaE0Kz2KkA0oV/+UNG5
	XsZh+bKSG13SZptKjwZFTHsEetQ7xXCiwqtvS9e2RpqU9URmgDfEWnjEtg0R/fcW
	H30+KL6FOh4LTakhseuiNML+frmdKt2hrslmXfSzVFl5PBGsY7EEmkGkW7tUIAWF
	0JpeqmcsU4Ovxi1S2HZ3+EONHcp5BrYqyQsm6uQL26g7qQuHOGT7ykhHF3LjNF+I
	CxlNrU1rDUuWVtoweC4ncaDnjmXgZgQbaRi87LFcyJqU9jP/mI5Yj/fiA+syMoKu
	1G8m5U0=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	"Varshini Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexander Dahl <ada@thorsis.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH for-6.14 v3 4/4] spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API
Date: Fri, 7 Feb 2025 13:47:59 +0100
Message-ID: <20250207124802.165408-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207124802.165408-1-csokas.bence@prolan.hu>
References: <20250207124802.165408-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738932488;VERSION=7984;MC=3743399358;ID=414258;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852617560

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
2.48.1




Return-Path: <linux-spi+bounces-6504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FF1A1D3C3
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2025 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E191886656
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2025 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92861FBEBC;
	Mon, 27 Jan 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="McwYYo+Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF21FCFE6;
	Mon, 27 Jan 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971072; cv=none; b=T2mI5FXrm5EyOgboNsRvkGx8N2kjrucUtU19RlzGSyxfI8YWx3owOd/OUBRVldhoJQZzF/AA4RFR9kTDtg2QiqlVJuouDO3rZtcCO9ZsraLLOq2f5s/Z04KyiTLWIyxT7FuW47LKhW7Iif5W39vsif2h4ISObDDEnZbVcrG2BFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971072; c=relaxed/simple;
	bh=V9RrFP+3gTTm+KxqHBwZgywSy19eJBFAur4WRQbNyUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deKfPzm6ubdQA8Z/iPlloh6hl2Q6OsZrEZrZ25zKXeRK4ICWrpCF2a8zu1UU3Ksypk5K8fZA3W4qXKLepe9PGmq+QV6hafuMJgT9iGHd4jBFMT8o4RtHO6Fn2fYDqP9qm8B6up0SNmSgzKmOVmgYbpkrbpcy8oP1XOEi40ikCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=McwYYo+Q; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A90C8A047B;
	Mon, 27 Jan 2025 10:44:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=JKOPXeX6sbg57Oy8s17k
	2ZQyCZqfoLnDjsHi21Xikr0=; b=McwYYo+QddYExT8iA+HlNAvkIIjjvupac1m1
	1lzb1hUixnG4FW6CUuIVZMnvPziv0MrS5TRofzvB3EHYNAmqCEPgcLpJVkngdTZH
	KUXcuLtnKCKkei1turpmiUipTKI2dDUdipF9zuIsfu3l0qrUaifkUja1OvS39vZT
	QFOMUr2HBx82MKWL8R58aQtXIBa5i3uJ1VR8x1LDYWg1mN2vQYw8/yDgwfi6RjbM
	2oO6ShRygpBZiXFiV2DpA8eS6Wx5CArBibm1EbcO/pERdnbF2WkqfLk9mir27XxB
	H2aNA1JHI3hcHevDymkjGKnyuOfjGsNYMQXRM2o+5Dm5kOG1SS/mHaFujsvWqIPK
	ZZRyeEs6ToFTv4vvXNJX/Ztf+iOl5lp688AhJeFUTueDtUygU3aCWsZdUCo7Sqz9
	ERVqJmIa6W127jJVxRu+N4+dX3iUoGyfI1qV5yPLfLlZNhqEIBKUdG95yi6Dz+6I
	wmnC1cWBay+RTl1haZpkRuGJqF8K2+f9KjdJ7ExY4A01f0wV6w6Fv5mJkSWFWC/G
	o3286I702pjXnvhV+0FCh6OcobsHsWgrJWmKTskZWc9aFmtgNARz61SAn4l63+Y9
	aOM8Xjb+LYNjbSFta0/AmbIMxbap2vLcXZwBE/qtSaXYgo6qlaemOmsZABosB/Ef
	R5Dcf6A=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Durai Manickam KR
	<durai.manickamkr@microchip.com>, Alexander Dahl <ada@thorsis.com>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
Subject: [PATCH resubmit] spi: atmel-quadspi: remove references to runtime PM on error path
Date: Mon, 27 Jan 2025 10:42:58 +0100
Message-ID: <20250127094258.841684-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250114172329.1013770-2-csokas.bence@prolan.hu>
References: <20250114172329.1013770-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1737971059;VERSION=7984;MC=3820151323;ID=88924;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485267726B

From: Claudiu Beznea <claudiu.beznea@microchip.com>

There is no need to call runtime PM put APIs on error path of
`atmel_qspi_sama7g5_transfer()` as the caller (`atmel_qspi_exec_op()`)
of it will take care of this if needed.

Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-spi/20250109-carat-festivity-5f088e1add3c@thorsis.com/
[ csokas.bence: Rebase and clarify msg, fix/add tags ]
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    Rebased onto current spi-next:
    commit ff9e24437b18 ("Merge remote-tracking branch 'spi/for-6.13' into spi-linus")

 drivers/spi/atmel-quadspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index abdc49d9d940..e2235d71c822 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -930,11 +930,8 @@ static int atmel_qspi_sama7g5_transfer(struct spi_mem *mem,
 
 	/* Release the chip-select. */
 	ret = atmel_qspi_reg_sync(aq);
-	if (ret) {
-		pm_runtime_mark_last_busy(&aq->pdev->dev);
-		pm_runtime_put_autosuspend(&aq->pdev->dev);
+	if (ret)
 		return ret;
-	}
 	atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
 
 	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CSRA);
-- 
2.48.1




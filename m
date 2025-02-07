Return-Path: <linux-spi+bounces-6650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A22A2C29A
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 13:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607D71884F24
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59271E0DEA;
	Fri,  7 Feb 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Uf4ZWP7r"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C51E5B70;
	Fri,  7 Feb 2025 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738931015; cv=none; b=OgXZB1u9Fn0ZXwea7qXVfI8Hewc3WrPp4r7jcw48kgyT13NsQ+oy1lEXos6gvaj3l1qnOzU0j3VbVTh1I5MzaW1lRQ75cvYjIKHZX7pX73o/Ftfv4Z0ru2AgQmWzg5CBMZ1kN3hR93f/vmW3/lbDHM22qN3ig34RevSIpcQpVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738931015; c=relaxed/simple;
	bh=JBRpPPjKTB/xaMJUyOPPnxjYd0r/6g+Njh1lJ+RMoIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jd6m0pJqTwXC5EjLBSu9lVF7WxUelQ2BRAV5iW8YtmNwylsvfiP47LDk+46NfHGfR7XJwJgem6t8vsVbo9TQdUCylj3VEw9VGKhGu0XpXWSP0rPoyZEDLyfFK7dw0fGOHJ0Mrt8QXtvsQD07O16KlGK6XyXLmFCUUwIG4GUNKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Uf4ZWP7r; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1D7AAA1084;
	Fri,  7 Feb 2025 13:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=WE3Hk7lRTT+a0M6s1YLVZX9XatRGh6ct0lOQcz7agLs=; b=
	Uf4ZWP7rv7+w7P+nZEd1CYtR2+nuOfLFPJgyfUYuS1tk108HJ/NVdm+Ix8YkkpFu
	FWpbhsPS9tGfiPh/xGDBeEEnemnbbja08uWGuzJ3kxMOMIp58TY0qF527EWy7Ayo
	dRlunxQQLcnp+Z76x+ioJDrtHUNQarl4ceAugEmmRJ4EwtzMOq8dEb6Rm+eqTlG7
	/mP0D6eQHd6BK6O1q5fHEc23dRRarSrth7c7BDIwahLre1XiPLRy0ASme18poDd5
	tThkVKWPO0GVr6CI6EGSX2TzZl+UNIt8bCMJVGypKH/f/VrmIfWXTwlGzWl5Vo4T
	Vs1tEmz4JXZ0vLw5BNJYg2fVc2MvvsyifP9Atv7GxqF9zDxB78y0FuEa/eA3iLwN
	58N54r2rkCGr0jYHJMyAWl6mELSqYu42FuD8RVZENRHT0N2eZc/v/vOSeKMjNug0
	o3Wv/XaWQEoOaK7MigJzyax7u02zr7/Kc+9ppO/BwgmGctCZqg3ZyWTdl35dbASv
	enAW47CbeYwq7e0r6ivpPxmaW8Sp7Mw+faTQY7fdCIIwwrWtHUtmSViI+YTYJtou
	D1xHU8vJTHU6kxeZZx+Ap9VzjrwGva/L0Rtf/Ea20vYT1UnMTDBC5DGppRN+cipR
	RfQ9O9CJVWcE89oOHHQd0a9HHSM0QyQasmGM6xcJ4J0=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Mark Brown
	<broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Durai Manickam KR
	<durai.manickamkr@microchip.com>, Alexander Dahl <ada@thorsis.com>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
Subject: [PATCH resubmit2] spi: atmel-quadspi: remove references to runtime PM on error path
Date: Fri, 7 Feb 2025 13:21:45 +0100
Message-ID: <20250207122145.162183-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738931011;VERSION=7984;MC=693355485;ID=413155;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852617560

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
 drivers/spi/atmel-quadspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d8c9be64d006..244ac0106862 100644
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

base-commit: d64ebde2a5acd9a516f6ea97ec2c9e6fc697f584
-- 
2.48.1




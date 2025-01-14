Return-Path: <linux-spi+bounces-6356-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B27CA10D90
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 18:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2EA163C77
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2025 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517415625A;
	Tue, 14 Jan 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Bz9Z7GQ7"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F61D47BB;
	Tue, 14 Jan 2025 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875428; cv=none; b=XIOSxNPTNM/Bf3wwH5EFoXx8IdGrl5Gg8EYwBOKGMzU0ZCbwkH5Ki1JaBlMME/oaVx7AI9UETiSUpVWdpiyJB/qgznsZ2kGXJkAnl6ajdmGytwgfILTDyXd9ADMLOhYKGyJtljf+AjbO43g8orEvm/CFCkSb0TRtkMwIjaGUEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875428; c=relaxed/simple;
	bh=TWJs1n4pgYuTXICX/9ysdNLruc2FEIpArUpheCYRTcs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RMspVmgh1OmxncUNrjKjGDsbtsNq2J3n+vsRnXKnCXjaFwssecG2xibULnybzYieuIhYb05QpABnM+3CjTSKcVyaWtZN/hZo1FWjACvVdlgSzYzDw46QqEe1pb8OnoRtISMo9Pp/JdsJ3LiJ7x6wXHr8SaoJYAwfb2yGhWPIb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Bz9Z7GQ7; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D5576A0BC9;
	Tue, 14 Jan 2025 18:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=gyIbHeHvJEOpPcU0XCY2dxiVjRerqpFepvL4DN0vFwE=; b=
	Bz9Z7GQ7NSB1HQF+gx2kvNDi5rC/r4MmelnpbdW43Mi2vULxzGFmURxJicg1npMv
	83YQLFjEShVOM+2QIl6jpwqY9YJIAcRCA+3GBs+1N8kgd3P9N0K8Dwrldq/XDX32
	xJ4fT3H1Ey04fDGwVD2oUTXBvwP2wFgPAFf8KZYFho81ImBB4EnHnznENc04VYEG
	Nlfr0wcdOPfjNl+OowtrI4Ol/e0vDvUj6bKfMoW1rmtsxoN25jLpg2p+SOrjfkaC
	9S4BiluC1v3xU9GW7y65hpnmx6oU8tz4ndlaMTk/LpgpM2Bi7ByhLExrq9TEfvsE
	uzqs4EtCYu5HN8tRMylFfcCsutW/sXU4wQRSOdRUYNUQFjPDj1Qsswm6/wWU7YRp
	0DfNI7ON1Dsxi2FFQ/dDl3DHjV1ITKQmik/2Fz/tNPj90pmjxZeSdKuR7lfc6AZd
	bJzs4B1zC5KA+02Rp7rW1oYgb5ud/QIb/gIeppq369ysmnMht3vJGwe24KSk0QpZ
	2aEV2GY67nnmisUVGFf9q0DPeBJNFjJ5oDO5gOCV3Wj8dbzkpfsws7UMm0i6ELcq
	oNnjy9UxEzHSFIFKIr3WYK3GcJPiLZNO8lVX3gPB/UvaUiTZGyO6oM9lb+HhmavE
	YWXGikLiiDsdnYv19wgQf7RPyAO2IJQyc87Lx2QSHQY=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Mark Brown <broonie@kernel.org>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?=
	<csokas.bence@prolan.hu>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Claudiu Beznea <claudiu.beznea@microchip.com>, Durai Manickam KR
	<durai.manickamkr@microchip.com>, Alexander Dahl <ada@thorsis.com>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] spi: atmel-quadspi: remove references to runtime PM on error path
Date: Tue, 14 Jan 2025 18:23:29 +0100
Message-ID: <20250114172329.1013770-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1736875424;VERSION=7983;MC=754494419;ID=290947;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852647167

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
index 093eb4fd7dd2..e62683226768 100644
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
2.48.0




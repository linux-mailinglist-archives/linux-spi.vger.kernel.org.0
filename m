Return-Path: <linux-spi+bounces-12386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F219D239CD
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5940F3036051
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FE335EDD6;
	Thu, 15 Jan 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZCNCGrtQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733435E52E;
	Thu, 15 Jan 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469146; cv=none; b=RbfC1MNreHBoCxiKaMsbUY9tSBEpfH3B4K9ChVok8udNjFVJ8XHScRYRH/FunU9bDhZRHYt5tnO6B2CWVMNPPItt0crj2i7Rt9DW0OVnPaqOzkpVq3cc2trmIj0npF5ni/tweLQ7VEyCWRFusmghx9/9hfeb56gGlE9Z8RYY0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469146; c=relaxed/simple;
	bh=i1g6FV6bWTRpy4Qm1cz9GUKgQo4Mdhxu1ddz5PGqn78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFXflXiNjpJYyhg5QdfN8lQAT0TFn45J75hSp+fkkpNM7oK2K14tdQ31p8mD2qebvNcc2NwyHHiVf0ihn5UnawKF05602FVUHWRLPZGVjMFl8txqfp+6H/Ih9bKYCh/sofP58VZpSdBQM5Mwar3dC+RkOaCGmXVMa8w2ZY07BXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZCNCGrtQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9B162C1F1E5;
	Thu, 15 Jan 2026 09:25:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 542C3606B6;
	Thu, 15 Jan 2026 09:25:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF8BB10B6852D;
	Thu, 15 Jan 2026 10:25:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TfqfY/NbV/xcFiwyzhB5ld1l7j/zKWnZt4iHWq7aaQk=;
	b=ZCNCGrtQRoTJcAkbPkTeKXN0/Tdw8Dlg13VN+SIRLsJZEfxJ2U6UwuqwNwmBjMIrBdVT98
	rH7KrgPMrGxCPgtO5QlYeAvQBTqxvWqjeq5rWj4KclZlr2oLxZwoM+Z8v2W/t4/vO9MtCx
	ycrPNmtL1qSt2Dmu86SlkQ6cbVP2aFmp92jazLaC7FyHi3wytjE8X6/dLVBbdEC67o/OoX
	Mp7sIPpNQXFa1ZAsSwANqdmHwKl0ZBm25HxuSRxkGY5PCM9DigbNp0k852axttgph2mh+z
	9TBhT81PokT9QIq3Y+cwre6hD/s+cbp60tadlAYCSypEv9A3gOek+XHZLkAl1w==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:24:56 +0100
Subject: [PATCH v2 05/13] spi: cadence-qspi: Remove an useless operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-5-7e6a06e1e17b@bootlin.com>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Right above writing the register value back based on 'div' value, there
is the following check:

    if (div > CQSPI_REG_CONFIG_BAUD_MASK)
            div = CQSPI_REG_CONFIG_BAUD_MASK;

which means div does not need to be AND'ed against the bitfield mask.

Remove this redundant operation.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 8eb80b4b76eb..06f6c5979229 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1258,7 +1258,7 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 
 	reg = readl(reg_base + CQSPI_REG_CONFIG);
 	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
-	reg |= (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
+	reg |= div << CQSPI_REG_CONFIG_BAUD_LSB;
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 

-- 
2.51.1



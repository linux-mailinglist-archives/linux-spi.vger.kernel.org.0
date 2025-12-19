Return-Path: <linux-spi+bounces-12032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 399DFCD1964
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD3D63002533
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB61340A63;
	Fri, 19 Dec 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q5KNhQSj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E833F8B4;
	Fri, 19 Dec 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172197; cv=none; b=lpnAMWKGW5YZBCioLER2bgAj2rZ8iq+GypWqfMiCQ4ZdCW6HniL0Oe39WINPt2oDaTodng+LCRk3QFZng9SqpWMbzHpXnx3tGIkVt3ivPIqfDEvOoh3DBo/XHxTWO98QnhsymOSNtOVo4XGrpM10fhlyPUhGeDZOXCo6gHF1vVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172197; c=relaxed/simple;
	bh=H2+vHq5CFjw1AO60vwoHNGa/FCI4RhTLLNSX0NwP8mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GX1OOwfM54nN9gyXCUNoklubZGTrWvEfLmaIRrHB75iRoMLmFjNYmbWbEJuGQhjfqhZWStZkuw8q27C/WTGJAcx+USkwg9lSrXheNKUYaFcOqcVr8q6exJ8YiVe/P/wiWvFaooZQ/lvHtPjRYJuDQRtnFlBNb+zBevnpfxrBS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q5KNhQSj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 44EF54E40B7D;
	Fri, 19 Dec 2025 19:23:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A8AA6071D;
	Fri, 19 Dec 2025 19:23:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4F0A10AA981B;
	Fri, 19 Dec 2025 20:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172193; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UeFyK3BHE5JEVZOBeBvHsYEaMdmJRiZh9bgX0hDLsvs=;
	b=q5KNhQSjcVugqUnwvomnLETI4nNZMM8GexS35/dG+oOuoyA5DAXdBBrYLhulrPcNZN9AYx
	fNm+rfjQKmVHvYHnlESa5n/ZNI2NsyQOIoWetdOWj/THqn+v55S5GRgv6826lMT3fwa8rW
	KJZKc+omVeAOToV+6PLzT7FyztozmDT6w5m+iUg1nygzBEa0136K7Cf5M493AmLC0OM+GX
	0/W61k2wn06LMC6MrusodsqGYTGKo7vhNL+oqvKPrbToDYKErPr14o4unecgtjCyDTfedx
	IbiJn8yNRI+pNDnhcvuIsZpt95MciDwQ7GVAK7ZfAUD3+mjmVIEZJjSvtIQOrg==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:05 +0100
Subject: [PATCH 03/13] spi: cadence-qspi: Fix style and improve readability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-3-8ad505173e44@bootlin.com>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
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

It took me several seconds to correctly understand this block. I
understand the goal: showing that we are in the if, or in one of the two
other cases. Improve the organization of the code to both improve
readability and fix the style.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e16a591e1f20..90387757fb6b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -376,13 +376,13 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 			complete(&cqspi->transfer_complete);
 			return IRQ_HANDLED;
 		}
+	} else {
+		if (!cqspi->slow_sram)
+			irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
+		else
+			irq_status &= CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
 	}
 
-	else if (!cqspi->slow_sram)
-		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
-	else
-		irq_status &= CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
-
 	if (irq_status)
 		complete(&cqspi->transfer_complete);
 

-- 
2.51.1



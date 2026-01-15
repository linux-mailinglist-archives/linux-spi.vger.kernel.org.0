Return-Path: <linux-spi+bounces-12383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB398D238D3
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9462F3041012
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E511F35CB72;
	Thu, 15 Jan 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IXdRpb3h"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C635B139;
	Thu, 15 Jan 2026 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469142; cv=none; b=tHHcvYJNW2qvVLbGBbhua/MXsO3wY8y7TtPPNo+f3Vw4JPthEXeCr3VwIF66vMD5m9ulzz6ffP8Ab0uM/JRcd4IodiZxTiX3WXPehUkaQ4cnNAVlmOVzWyYUPFD8K/3zWaTiwP5arPZ9qaGsxo+fb0g0OosJp+/LJL54gKTh56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469142; c=relaxed/simple;
	bh=p5NslQCxTSi9APH6Nu9G2/rRRMoxXVza/nVtRoQsCXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yw9MRXiPI30DkVMK64PoaOP0/34AByoxoZN9psNzllzMZTEIRFTxP8asF7ggj0VKAo/mAHop1PUg+zlSPp6jW52dXvgygghAFBg3gwiekZykZ14C5AF9NFwcEj1AM1tgIYxof255yAEuGHs1QZiBSqF+1mPMFjKanEBB3KfNNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IXdRpb3h; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C8F12C1F1E6;
	Thu, 15 Jan 2026 09:25:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8225D606B6;
	Thu, 15 Jan 2026 09:25:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7526310B6851D;
	Thu, 15 Jan 2026 10:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469133; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OeTAsflrIMlCORoJPATDkdX8lDo51A/BHMo9XZjAk1U=;
	b=IXdRpb3hDLNw/03VPINe9l2q4kqECYaG2N/C/x/1CpylaEm+5AUGjZsPo9HlCRKGjk2vqj
	dZUublrHIKYvkisLzSGaCoxL5ldVWxAlkP4n+53I99MUxrCLv6+zr7yLHY4X3oW9cf0+S7
	mRuJJsGA2EBhvNEFIcl6zD8n2iw8c9LoAyaYq+TxYfBepKaswBh4Si8VV3AuG44wz+qkVd
	E71dIG4+U0JCJiXVRLv58iYFWVUPm2pI5nkCNZcJ8TZuEhc/nrTmlXGQiIWIZQqzCA+eTc
	UdgYm0bMx5vtRZ9f4wNB+1RYxhB6CFaERpUlg+SI8S0lvrphD4hQbegUptXZgg==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:24:52 +0100
Subject: [PATCH v2 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-1-7e6a06e1e17b@bootlin.com>
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

Add support for the Renesas RZ/N1D400 QSPI controller.

This SoC is identified in the bindings with its other name: r9a06g032.
It is part of the RZ/N1 family, which contains a "D" and a "S"
variant. IPs in this SoC are typically described using 3
compatibles (the SoC specific compatible, the family compatible, and the
original Cadence IP compatible), follow this convention.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 53a52fb8b819..62948990defb 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -80,6 +80,10 @@ properties:
           # controllers are meant to be used with flashes of all kinds,
           # ie. also NAND flashes, not only NOR flashes.
           - const: cdns,qspi-nor
+      - items:
+          - const: renesas,r9a06g032-qspi
+          - const: renesas,rzn1-qspi
+          - const: cdns,qspi-nor
       - const: cdns,qspi-nor
         deprecated: true
 

-- 
2.51.1



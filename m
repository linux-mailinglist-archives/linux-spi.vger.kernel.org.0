Return-Path: <linux-spi+bounces-12030-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495DCD195E
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99C4B3002898
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE55133FE01;
	Fri, 19 Dec 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ckiBMi+5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84933F373
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172192; cv=none; b=qzrwB/mqyNCwJBxL7HbJiHFdcUfP5uplwwJHNoOOlOA79fHbP214TxhGyG5/U1OHS9M8xAFeso1kncuTVzLzYBgapvKH5c9o5qdpKetO3Gr3UVNnv8Kjb5dIlWdhErkBMPvwDMbGcYhF7XG4IH7zJ0/CAI1YDZlwXYfE2gCUeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172192; c=relaxed/simple;
	bh=sa2UnVgEnCd23b6EOC6Iyc0yYfI+fy2H5jtMEwZxIQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZrnK5RmULugmiGa3GqTB0z5MwJezOKKbT6IVs3Jh1+iAhnT+8GZhT4rGO6J0mVfzwjZD4vjTwS7e+4dcVRicng2s3xNaPzCvluq+iA0ONvl5AaPLelDV63IdFTICnqXOlgSFSSAq8mjGC9bNG7yVix0M0QN16UAPc9IKb3Ys0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ckiBMi+5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E33B4E40B7D;
	Fri, 19 Dec 2025 19:23:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8A066071D;
	Fri, 19 Dec 2025 19:23:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7146C102F0BC0;
	Fri, 19 Dec 2025 20:22:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6UUmCV1uKTvyWoCEI0vuqFzr0aPmGzmvG/9l0oPKd8s=;
	b=ckiBMi+5pnR/+mSnWvDDxB1HFEv2eZw1GJfIfrTzsVZcogi4yn8Fm6gINbD+DGMH8g/y8I
	dfefjbEtO2kp40lmCFQ0eNgDxnyLUXZEK4ZvJPgsqMIoFQHl9pTm+gQ7MH1V2LN+2LebUQ
	qN4IrHFhA4q2paXOlQTc8w72sHZuPTZH0SH+9jJGLBfG6EzxVdEvHnSs4sP8ecU9bxyGHp
	adYaBTPjULyoJ7P2Y8x1p71GPuILNybmiT4tSnstOB1Fpu7UVUHw7CZfWmqD4nHBKZCgrW
	6FuloiGpxWCQV69qYzEOg/LGJGwtBGYm5yIz2+pnnnN4HMIjyWVcNDeN4lEAWw==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:03 +0100
Subject: [PATCH 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-1-8ad505173e44@bootlin.com>
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

Add support for the Renesas RZ/N1D400 QSPI controller.

This SoC is identified in the bindings with its other name: r9a06g032.
It is part of the RZ/N1 family, which contains a "D" and a "S"
variant. Align the compatibles used with all other IPs from the same
SoC, which requires providing 3 compatibles (the SoC specific
compatible, the family compatible, and the original Cadence IP).

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



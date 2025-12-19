Return-Path: <linux-spi+bounces-12031-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13052CD19B8
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00425308DAC0
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29934028F;
	Fri, 19 Dec 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FuvItLoz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C633F362;
	Fri, 19 Dec 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172195; cv=none; b=nwe5lFfzbp0sjvMLDAOIhrTFyimbmeum4aGYY1gtg/ncCNDNXD3XonabOk1cEH08AmAzNPQCQg+w5Yb7Gw8Y5sq6YGZMfIaB3fK2av+v3A3aK8JMoRAnGbeYs2A5UfsxpL9HBSoZjBfYQCtZWG9oLPsfC/3hFRqKhtg0Ji3vPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172195; c=relaxed/simple;
	bh=6bV1SMUpcFVhm9YkKUunGGcPXiGGY1da3bBRqEHtNNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irxVZRzU931JlaXfiYT+h/DVoxU020GAvXuEzFyMFAjy8Dw8bwU9+YMyrii0mRNu3aMEv87k/yxa2tP5nV8Z+fK7ky07p63pBoWIO1Y3SuOmFHppOnjR6/P4XvlsTXDRHzp9oQRDoCn51qcuJyQz9S9VjKMW2Ancrv4U9IMryUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FuvItLoz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C4DD94E41C39;
	Fri, 19 Dec 2025 19:23:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A70D6071D;
	Fri, 19 Dec 2025 19:23:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AD70102F0CDA;
	Fri, 19 Dec 2025 20:23:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172186; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=a7Z+ejC9K/VTb5U+uLkvXhxiuwGhNojSrxEzFC2ijaE=;
	b=FuvItLozz6Y+blMkmAZCpsCrE4CihpKeHX1fn8T8JJlUGzX9/PMswdwqebHlXR3xmJEovf
	MecqV4BJ7MdU4ZKmecYrMTDY7mol7bWBKcEHQkJ89W0sAiTm/PvBSU3vK//wWezdfl5HAZ
	TuUoOvvwU++OAgq5m8RH/1vfI+x0ZXLgKV6x3/6KIljmva6tlPXGl0o1ZgyAWFKeiNl3GR
	Rnm2fB3CbUbGbNBD3c3VzDVrrqCvA9+gP0f63jKGPMBIthJjS7o45G6M8IBd2pO1qJ7AgK
	XFxlCDSaf7NDE4yFq+xFJfJtDFSSJP4ogGPl1G1O1dtFJbcOmU3ET84BCUWEog==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:04 +0100
Subject: [PATCH 02/13] spi: cadence-qspi: Align definitions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-2-8ad505173e44@bootlin.com>
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

Fix alignment on the #defines.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..e16a591e1f20 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -40,7 +40,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
-#define CQSPI_SLOW_SRAM		BIT(4)
+#define CQSPI_SLOW_SRAM			BIT(4)
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_RD_NO_IRQ			BIT(6)
 #define CQSPI_DMA_SET_MASK		BIT(7)

-- 
2.51.1



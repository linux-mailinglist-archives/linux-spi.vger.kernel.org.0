Return-Path: <linux-spi+bounces-9929-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAABBB4831F
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 06:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D181188E058
	for <lists+linux-spi@lfdr.de>; Mon,  8 Sep 2025 04:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F021B9C0;
	Mon,  8 Sep 2025 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ee2aa3k0"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341D21B19D;
	Mon,  8 Sep 2025 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304893; cv=none; b=aLpICQxtNVWI5rkExzd4St0/CD816gy7xbd5YHuA53cvXtpm0Gsgmsy41Lv3sxlkyDo560BGlKFbWIkYCR1SsOtUP2LnKH+g3P6P1QEGMTUlDVLl5H/Yw5mJnEXAnOrYkAJkAjTuR14cu3R3MCQsX69/EMs+EYFB2U6R0t4NNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304893; c=relaxed/simple;
	bh=y6SgL0SvA8lYYyF90rTpTwKWfC2+R7sLAcCo0vATj4w=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SlFtM5MJJ39laLx0R3Rzg8LylTDVOUsaRGpuAOjiMwx62sdFAtv374GQDCyZ0WYKBdOsYisZzk/9QPRUShtB5CgLlUu8lkt7xsQ5jwk5nlOOtlJ4m1tjzdZAHOq54B5K7g+xgxafLhBYhEEMGBdD4tA8VMPsZg405yvG9Yu8+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ee2aa3k0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757304891; x=1788840891;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=y6SgL0SvA8lYYyF90rTpTwKWfC2+R7sLAcCo0vATj4w=;
  b=Ee2aa3k0TOOSXN/MOU1n7wskHt92aHadEVqelv3CihEq9PdanRAHSdhX
   wAs7Ej9YPeF6PbZXNgWFl41T7RU/lgKSe3RiT1HnRw8kS+BPS9FqiQuH7
   73WHN3IqvwfWOje6qleqBFLlrfYavpgyW4tKuS6sL7AFm8Lxu9ZaY4l2J
   IrUTMei0GkLeCYxhtwGx3V5A5j2S9TKYmxSqV8HqtW9xZ1IsUR0Kv8KiD
   wxZ+ON30xm2JWtCNMssRsBRpVjteUh7J/4y0KzOZB4c4ro/PQ6RGay8rW
   nWQSPGTakP+QHIhlPHecLegbxB4EMRv9mMuUjMTOo+YuPuqdnoZM4ZhQF
   w==;
X-CSE-ConnectionGUID: YPpoJm/ATHeRsyPuBZAjnw==
X-CSE-MsgGUID: 2h/b4mq/R1mRAd5Ns6IGCQ==
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="213580662"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Sep 2025 21:14:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 7 Sep 2025 21:14:24 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 7 Sep 2025 21:14:19 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v2 0/5] Add QSPI support for sam9x7 and sama7d65 SoCs
Date: Mon, 8 Sep 2025 09:44:15 +0530
Message-ID: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdYvmgC/3WMQQ7CIBBFr9LMWsxAiw2uvIfpAnEqs2hpwRBNw
 93FLty5fD//vQ0SRaYE52aDSJkTh7mCOjTgvJ0fJPheGRQqjQaVmNjF4DwvYk0LC7r1znRSS9c
 SVGmJNPJrD16Hyp7TM8T33s/yu/5NZSlQtL0dtbHY4clefoejCxMMpZQPkppai7AAAAA=
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>, Varshini Rajendran
	<varshini.rajendran@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757304860; l=1238;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=y6SgL0SvA8lYYyF90rTpTwKWfC2+R7sLAcCo0vATj4w=;
 b=4pCMZOglzoprKTucas/IJXmT44MJpXJYol6/3hHpS0nGui4xFpvPjSPDGTnT8aYDaS1pgMwTv
 wwLOyEqU7LoBxHT2D73t1pOgRMt0qlQg2ga5/lx5jfQuOKjSfO4jciT
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series adds support for SAM9X7 and sama7d65 QSPI controller
along with the SoC-specific capabilities.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changes in v2:
- Fix typo sam9x75 to sam9x7 in commit message.
- Fix subject prefix for dt-bindings.
- Retain original author for some commits that changed during squashing and
  resolving merge conflicts from internal tree.
- Link to v1: https://lore.kernel.org/r/20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com

---
Dharma Balasubiramani (2):
      dt-bindings: spi: Document sam9x7 QSPI
      dt-bindings: spi: Define sama7d65 QSPI

Varshini Rajendran (3):
      spi: atmel-quadspi: add padcalib, 2xgclk, and dllon capabilities
      spi: atmel-quadspi: add support for SAM9X7 QSPI controller
      spi: atmel-quadspi: Add support for sama7d65 QSPI

 .../devicetree/bindings/spi/atmel,quadspi.yaml     |   3 +
 drivers/spi/atmel-quadspi.c                        | 134 ++++++++++++++++-----
 2 files changed, 105 insertions(+), 32 deletions(-)
---
base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
change-id: 20250902-microchip-qspi-eb7c94151c3e

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>



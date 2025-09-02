Return-Path: <linux-spi+bounces-9841-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F9BB3F4CC
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAB37A1F0B
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 05:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8EA2E1751;
	Tue,  2 Sep 2025 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UugYQR/m"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958C2E172B;
	Tue,  2 Sep 2025 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792367; cv=none; b=Mixq1lqEB8d/qSDQ9uiBKq9lh/YpBiEl52gGjxD7iAnoZzO8kTWQ/75kBpgymoZNdXzKYkda6cBkMPwCkA5fExi+xOEOCqC7MbOnwaYf5GaGrSrCSbGhs2WL1CEeSU1XM3u8xoQnFLxbClsF9viNmW0eSEwaj/EwMMokxJpFb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792367; c=relaxed/simple;
	bh=KsI+M7YnFhd/Oo7jo6teF3LjOcYUqnHqlXYhwF09GJ8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IpzPmW9fvFbmAC+0cFgyQNXmPkiAIEcuIqfEHDRK0BXOfC1Nv2ihDRGxRr4lQJWVXD/fOHBnwglVd8ljLj5pkrA9rgeTatyh/WLO1tQ26iieU71mV5sEEK3pFyEx5ten4joO7AToyRh3nBlcVonq7VFlpdYOQ/7qzAcA02Au0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UugYQR/m; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756792365; x=1788328365;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=KsI+M7YnFhd/Oo7jo6teF3LjOcYUqnHqlXYhwF09GJ8=;
  b=UugYQR/meTMb0iCQ6dAl9scE57+Pk9YdFjueasIi1QloCigwUPMX3wFT
   RCKTqHiBgjqMOyDKeNTkdSfSokjnPMbVRlLajgAul/a7JXcxkcoa2ykTw
   bngPR0oC6L6USLGB8AjwGev7zdfNmcTLYS53wFDAGXWvRbldU8G+25LBf
   5snRN3GeUKtXHxfe6Vno+HnHyylQEQIQwEXL3FUelWwhgTNshtA6NKGzR
   T94QrM5BWZquSps5AFbCtLaKNLPA3x/IUU3u1xZThw8VlKKWmF4S9d3sP
   g5WOBulu1iv0cAcmidYVFMuKo2xV9QE2wHH7XVPKMTCq0eTE9Fyb7Lb6f
   A==;
X-CSE-ConnectionGUID: 1ukqY7Z2Svu+qnOLrd9exQ==
X-CSE-MsgGUID: lNApHYG2Tuqr8iBNPO7irw==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="46483411"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 22:52:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 22:52:29 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 1 Sep 2025 22:52:24 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH 0/5] Add QSPI support for sam9x7 and sama7d65 SoCs
Date: Tue, 2 Sep 2025 11:22:17 +0530
Message-ID: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABGGtmgC/x3MQQqAIBBA0avIrBPUkqirRIuapppFaQ5EIN09a
 fkW/2cQSkwCvcqQ6GbhcBbYSgHu07mR5qUYnHHedMbpgzEF3DnqSyJrmlvsGust1gQliolWfv7
 hML7vBzDWzZpgAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756792344; l=908;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=KsI+M7YnFhd/Oo7jo6teF3LjOcYUqnHqlXYhwF09GJ8=;
 b=MjxsyeDrxOB1wRIZko5qiDCJGRosvkwJODv4FsB2+qTmRCjP4qx8nlJjRycaO78WfdeKx0g8M
 McqAOvU+s3zBu7u3d9n+cRcTUJU1dP0DSgvwU6IY+P7KCOHe/uaMNLw
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series adds support for SAM9X7 and sama7d65 QSPI controller
along with the SoC-specific capabilities.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Dharma Balasubiramani (4):
      spi: atmel,quadspi: Document sam9x7 QSPI
      spi: atmel,quadspi: Define sama7d65 QSPI
      spi: atmel-quadspi: add padcalib, 2xgclk, and dllon capabilities
      spi: atmel-quadspi: add support for SAM9X7 QSPI controller

Varshini Rajendran (1):
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



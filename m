Return-Path: <linux-spi+bounces-9843-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49234B3F4D1
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 07:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B30485312
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 05:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9E82E1C7A;
	Tue,  2 Sep 2025 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YH7cycpw"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B932E0B77;
	Tue,  2 Sep 2025 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792384; cv=none; b=Xdtus6V+2SvtQghv3P8yxzX5INLzKP15lCjJ6jS4QJbH7YC+vy30vtddYE1ISlG+4Paw5F+O2jYItV+ZvPwRDHdQ9wxIVs0LUr6642YlDb8sErSttP0fazb6rgYL2Za2DsrgscQpWOJiq5pQY/P733QpevdlD9WEb+MYTWHjqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792384; c=relaxed/simple;
	bh=e9VWFRSwNpYXqnNmw9kbScIHMnZuxvIjyF1UMqscb90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t4ZTTi1p6EjdXnQV/S0ro4f7giQt6VYiFBiOfov12pARg+dIOlUetb49tWZRA/ArqeMPjhelNZcoC49G+cD9lo6LkgLfYRCLZDeZOv7jn9oukzj9Q7gJWEHnRN5pmTtbyY689NmU3OjmrtWjwXaMfAJXzJEkjfaLwP1amn+LKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YH7cycpw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756792382; x=1788328382;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=e9VWFRSwNpYXqnNmw9kbScIHMnZuxvIjyF1UMqscb90=;
  b=YH7cycpwgwratpa1ZI41h1PA5U8QjBD/YXLh4kO/mbXT6yZJN4x9YQJ6
   KQszTdBM0RW+h0tcS/JSMCS573oItNWUe0AO2h1la08WPCsaa416I+DYY
   yNFKe3XUn1V3T3G7KEnyL928DvX4+hkjY6ldKiZIANfkqpI13Rc7D/bF5
   bp0Z4sT+RyBnlXlA2OkP0PJxHBqWJ5/fSv13DqHeQ//Ls6KOL0Z1WrqPH
   FGtEFtv67ZyCtFXT6vHVlt2yYizaCLIagZ+8wQpBDc+3KbxKoHwpi2ZYS
   xUihWzPx0Go6LzhVTiA15lsEKRK8USzWliF8GON/oXN3BoDNMT57d9rYZ
   w==;
X-CSE-ConnectionGUID: Yz3ewosWRva47VEyLax1Mw==
X-CSE-MsgGUID: n99+6iJ8QaW6djCFN23PmQ==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="213332112"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 22:53:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 22:52:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 1 Sep 2025 22:52:35 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Tue, 2 Sep 2025 11:22:19 +0530
Subject: [PATCH 2/5] spi: atmel,quadspi: Define sama7d65 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250902-microchip-qspi-v1-2-37af59a0406a@microchip.com>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
In-Reply-To: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756792344; l=1008;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=e9VWFRSwNpYXqnNmw9kbScIHMnZuxvIjyF1UMqscb90=;
 b=CO/fzW2/g67HTEueiWARb6WQARJam9NyTFZ58DKURxITPnaOkQ9Gdva4yY1aw6hsH3A0ZaB+z
 LQHJWeg68T2DEZZmD6ea3x1LT8SbjjXKLDnC+/PocJ2pOok16NkwDqE
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

sama7d65 has 2 instances of the QSPI controller:

• One Octal Serial Peripheral Interface (QSPI0) supporting DDR. Octal,
Twin-Quad, HyperFlashTM and OctaFlashTM protocols supported.

• One Quad Serial Peripheral Interface (QSPI1) supporting DDR/SDR.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index c17114123034..30ab42c95c08 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -18,6 +18,8 @@ properties:
       - atmel,sama5d2-qspi
       - microchip,sam9x60-qspi
       - microchip,sam9x7-ospi
+      - microchip,sama7d65-qspi
+      - microchip,sama7d65-ospi
       - microchip,sama7g5-qspi
       - microchip,sama7g5-ospi
 

-- 
2.43.0



Return-Path: <linux-spi+bounces-9842-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47073B3F4CF
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 07:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B057A215E
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDDE2E2667;
	Tue,  2 Sep 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B9CSVBdN"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25E2E1EE4;
	Tue,  2 Sep 2025 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792368; cv=none; b=kw4FbOWERfNCKm0vIS8sKKzn5aRKXHYC6B5JIpS1tpw34e3laoxy8/kqIVpl/S3vdrb+vjxMJ3xIylPEjOVvSI2t57O1fAP7F6omEyJ7LEtUBHIHk0HbpMonlwu6Mw1+/Jq3OYZ9cZloCH/YNRtXIjqqUsa3QsItc7KQ/hUHeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792368; c=relaxed/simple;
	bh=g9qQXv2V8dA8IDQzFPk9fFZ2WneEXRTGvShebfzPtjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ejeFbDXM82bQsJlgvXKoBz0JkIhyliNd3JnTVTU2dvDQfnJC1O0dh2myeA1aWV3In6owYZC/7Mj8BthOFGwtfYIpWczHsvmtMkHX0QwJFY/vbyNH88ayQ7GvMDuDWB+WjJ0O6VQX1mneUq8fxNZfuJwkAYUXkb79NtHE7weKtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B9CSVBdN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756792367; x=1788328367;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=g9qQXv2V8dA8IDQzFPk9fFZ2WneEXRTGvShebfzPtjM=;
  b=B9CSVBdNRdny/AgaA4M+tUA/FQwN/uLVKrBEszdZH1TG5kTK3HjU6AUk
   6m3ZzJDTTtJfkAMmC2WSz1tn6cX6KX9erzA+EJFGWF1stZY77cz3Y7Z/B
   qINLc1cvvQiVIyPy1UNZAVSqYYgPrE2577l7Xqnc+EBG8Hqd0hZ3B7UTX
   xStkDwOlU7zOHO02NCjbhAP6k4eNSiRkDeX2VCuB8A64otEgWRcMeXMqv
   aRSWn+LIllZwtOpzA2A7leMs+NXTq/I3c5CWewSbW+LLqzFKiO2pAMX02
   Oo40YCLw74LOLHjqaw9nZYm6e5qlRgCscgYTnlc/wOfmXTGoKzH0mtw2Z
   g==;
X-CSE-ConnectionGUID: 1ukqY7Z2Svu+qnOLrd9exQ==
X-CSE-MsgGUID: shrOJ1pbSdyVYGCiC+RoQw==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="46483414"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 22:52:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 22:52:34 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 1 Sep 2025 22:52:30 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Tue, 2 Sep 2025 11:22:18 +0530
Subject: [PATCH 1/5] spi: atmel,quadspi: Document sam9x7 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756792344; l=878;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=g9qQXv2V8dA8IDQzFPk9fFZ2WneEXRTGvShebfzPtjM=;
 b=RXLzmMxnP+ToN+Z5oDPtF+Ea94CKvLTLwp5jSikf1MtD2AeOR7+ez1eDz8FFGXArQU76S7HRC
 HyNXMhbLmr4DKegxye+QNurlMaBOIchdFnsq2nOnOmPZ9VClBFbWItx
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Document the sam9x75 quad spi that supports interface to serial memories
operating in

- Single-bit SPI, Dual SPI, Quad SPI and Octal SPI
- Single Data Rate or Double Data Rate modes

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index b0d99bc10535..c17114123034 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - atmel,sama5d2-qspi
       - microchip,sam9x60-qspi
+      - microchip,sam9x7-ospi
       - microchip,sama7g5-qspi
       - microchip,sama7g5-ospi
 

-- 
2.43.0



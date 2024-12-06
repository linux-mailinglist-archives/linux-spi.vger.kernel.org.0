Return-Path: <linux-spi+bounces-5939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDF9E79AA
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709F316DBD2
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7E212B0B;
	Fri,  6 Dec 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H9nGa6b6"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D520ADF7;
	Fri,  6 Dec 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515380; cv=none; b=KusEluYflSVsrEVve3IEAqpje1MS8/f31BYRtHUpAWW7/SozwkHE+lz3wWGtqHBAVJVE7gQfKmV/Ajfp4rgEW3wNh9auTm7Cbjs7NmqYmUtOIzB4AxVzWVtL2A1NjoQPRjc8EgQ/QvLZWrmbHUpo5BArSKUJ2HMiMhqrHXPqA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515380; c=relaxed/simple;
	bh=9Q//WdqJFVOuezi3xpmaAB5Yg0z8vN5p/2/SEsI6Gb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wv1TPdj7yJnWpUoL2CyysFF9RhsTOtDPyUChtKuKSiLWL/o4QDygVL5jZR3qQpjVpQFO1GlGMs5boGsNqKrSj43zNM/MMIFmRXis12bd8HF4A/NsnATUaYoOPUtz3CG3OTbc6qqZQYADtxkCuYkMGlwrDUACJOzM72LsXxQAUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H9nGa6b6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515379; x=1765051379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Q//WdqJFVOuezi3xpmaAB5Yg0z8vN5p/2/SEsI6Gb0=;
  b=H9nGa6b69z2dDRtKUhbPZmygUWQytWFc19lccEaddXtr3Q0DtTYJGCYh
   ErLXySJbb+8BQWrugq96bfM7DSbxt3KbCDFbAMAdQz1+eI/ek04llRRbM
   gHKERD8iuCPklaIjxbh5HFQsqYDg0ii6aLlH79Ypqd4HrYu5dgSoJOljs
   rVd02rAIqojGIsMStSvMn5e5ZfUW74Gg1jdIknsFpyGpe6aBXa2FUkfvu
   m/AOqvM0LQ32rnGd3CmpLt619Z9ti/N7wOp5xnvEt92COoaJn5RoksLV2
   EQfVTwnIQuvoxOxbukwtkkBQ/I9Pk2IS0ioj5INXlhjCPQooAOrXRFH3r
   Q==;
X-CSE-ConnectionGUID: /C8EJBR2STyJIMNyJN3YNw==
X-CSE-MsgGUID: gZvVWBE4TkKFWHD8QNBD+g==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="266436383"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:09 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:09 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
Subject: [PATCH v3 02/13] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom
Date: Fri, 6 Dec 2024 12:59:47 -0700
Message-ID: <550a6dc244a9955782c5b9d7863df4e15bba8a26.1733505542.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733505542.git.Ryan.Wanner@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add flexcom binding documentation for sama7d65.

Consolidated entries into one enum to match proper coding style.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml   | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 0dc6a40b63f4..c7d6cf96796c 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -19,12 +19,11 @@ properties:
     oneOf:
       - const: atmel,sama5d2-flexcom
       - items:
-          - const: microchip,sam9x7-flexcom
+          - enum:
+              - microchip,sam9x7-flexcom
+              - microchip,sama7d65-flexcom
+              - microchip,sama7g5-flexcom
           - const: atmel,sama5d2-flexcom
-      - items:
-          - const: microchip,sama7g5-flexcom
-          - const: atmel,sama5d2-flexcom
-
 
   reg:
     maxItems: 1
-- 
2.43.0



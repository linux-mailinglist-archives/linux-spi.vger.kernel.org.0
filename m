Return-Path: <linux-spi+bounces-5940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6289E79AC
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B69D286D5F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7EE2135DC;
	Fri,  6 Dec 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bqw7tbvH"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17F2135AA;
	Fri,  6 Dec 2024 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515382; cv=none; b=qw4uSDf+9tPwg7dtqALrOEdG5oq3L4wlDPi9T5EB52rVE/6PLWz44JCvy5jwAZByfHIUV6+BkQ5/20lcS/8pw7PCW7W2YE7i3ALbwkmJbrwI34+hy+rtmQZJXeVJLXXxXUjhL2+GE/WfPE7rBzAIIrKh+CVG/rYfxw6sPb7hMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515382; c=relaxed/simple;
	bh=rba2clRshpQ9VkACsIE74OOQZKCmryDBJCOgqbeMYAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rp9gXwiEa8yJm9tuWlxPTIuntAv7DzV3kcrm1Qs/tSiDkO1Kn9agtev6BoL69RaumUjyLxn7g46tuWDhHSCKFVtrwRWqGaNpwIt/D1QTTN199U3hxXYssm26Vv4MrgosF87+tAeL/0GMNUlbkk9klS+MwEL9iYScfBjWYP4jItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bqw7tbvH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515381; x=1765051381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rba2clRshpQ9VkACsIE74OOQZKCmryDBJCOgqbeMYAM=;
  b=bqw7tbvHCXCkr9DfHr6Us+ygP/Y2hatn5MS8qjeJCVJCchn96AZAH3Xo
   aI31Hj54AhdKTJ6viLHDvJNIFOqmB5SBF6XDxI2mCgJAU4YTZKwEr0/7v
   M9r11xZRqzFeDfVHU9T8jD1rnFo5b5F00slMZxW0a6kvUQ4E0nGdc+TAu
   Du+rqJgIEI5wc9QRt+J/ZQ3CLovl5dJ45yPGNR+T3OOT9Q1P+wIfIhp4s
   MUQO4T5sEDNIpEF21Iilx/xFrenGwAOf/WClUiNo0HPjqXYZr28emKAjo
   uEb49FXTRLr98g66N3ZHHkT0oXdLBR2Yx9u5KUIn+SmcM6NfRW0KBkzkJ
   A==;
X-CSE-ConnectionGUID: /C8EJBR2STyJIMNyJN3YNw==
X-CSE-MsgGUID: CrAWL9axQ4ytAyVzz1wMAA==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="266436387"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:10 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:10 -0700
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
Subject: [PATCH v3 07/13] dt-bindings: clock: Add SAMA7D65 PMC compatible string
Date: Fri, 6 Dec 2024 12:59:52 -0700
Message-ID: <5252a28531deaee67af1edd8e72d45ca57783464.1733505542.git.Ryan.Wanner@microchip.com>
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

Add the `microchip,sama7d65-pmc` compatible string to the existing binding,
since the SAMA7D65 PMC shares the same properties and clock requirements
as the SAMA7G5.

Export MCK3 and MCK5 to be accessed and referenced in DT to assign to
the clocks property for sama7d65 SoC.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml       | 2 ++
 include/dt-bindings/clock/at91.h                              | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
index c9eb60776b4d..885d47dd5724 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
@@ -43,6 +43,7 @@ properties:
               - atmel,sama5d4-pmc
               - microchip,sam9x60-pmc
               - microchip,sam9x7-pmc
+              - microchip,sama7d65-pmc
               - microchip,sama7g5-pmc
           - const: syscon
 
@@ -90,6 +91,7 @@ allOf:
             enum:
               - microchip,sam9x60-pmc
               - microchip,sam9x7-pmc
+              - microchip,sama7d65-pmc
               - microchip,sama7g5-pmc
     then:
       properties:
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 6ede88c3992d..e37f1b9cdabf 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -42,6 +42,10 @@
 #define PMC_PLLADIV2		(PMC_MAIN + 11)
 #define PMC_LVDSPLL		(PMC_MAIN + 12)
 
+/* SAMA7D65 */
+#define PMC_MCK3               (PMC_MAIN + 13)
+#define PMC_MCK5               (PMC_MAIN + 14)
+
 #ifndef AT91_PMC_MOSCS
 #define AT91_PMC_MOSCS		0		/* MOSCS Flag */
 #define AT91_PMC_LOCKA		1		/* PLLA Lock */
-- 
2.43.0



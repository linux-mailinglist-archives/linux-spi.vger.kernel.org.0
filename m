Return-Path: <linux-spi+bounces-5741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E299D2B80
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26E4B32BCE
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB21D31A9;
	Tue, 19 Nov 2024 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aeraKAhU"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1C1D26F3;
	Tue, 19 Nov 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034480; cv=none; b=JA0tk9xUhPs3WdjQkiIxaH2Nz/4r1tSxBb1Pikeh46zi+Duoy7hz9P72hqUSedzXzfRs5VkS1NIAl5/IJzGEgyF5rpRF92HSi9ybpnxttGoXL7AdjAmLt22v2dSxvhjWn0lyTXXj9yN1ZkOwR1aJ2Y3HB6UGDyk41tzT900bbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034480; c=relaxed/simple;
	bh=/kPjU2RV4uq/wNXU/xWY88VGBSGxpXiwd7zUh0prKt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJwlRO56GSYKxnZ8ZZqp5FDG+MogpKvuemIFHbmpCgVbQ6E/2IiTKFfrUt5oC0xmCosJb+TEZ0TD6KRTftXwZmX0li2DOUAHh2meRrrKzeYszYLzBn4OaSBMuzVNdzRHU9JGoFnz9nNWhHspCeOYB7AT2+5AdF2amN9SnJ1PWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aeraKAhU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732034479; x=1763570479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/kPjU2RV4uq/wNXU/xWY88VGBSGxpXiwd7zUh0prKt0=;
  b=aeraKAhU2nN7/O0NVexaES4gSkye4I0tQ8YliM7O+xjqpnum47mhojff
   3eMTASripK5sAxa7TYAcNUJbPfLelTUW4e+UJJqaPaXPwyRtaEoQetLpf
   kTuOc/yLvZsjD2nRFcUBSsGyxJLls3T2wdJmJLb6HKALxiGqenKoRrLD1
   CwnHi5tyaXI2hAQBE9GhzR3/dGc0VYKDHKKbNXl71WdsJgt8Fo9WUQVCo
   rXJLdrU7lBt8tI0DvxdEwMbGq83ew6QTO+2Y0uNYz8TpBUWE2iYfsJVuT
   LbZIeYekaWe57ETFvm14sgfApkflyiUw6WVWh4JMuLV4KrB5S7XOqXCr1
   A==;
X-CSE-ConnectionGUID: jnnvkeRdTYaD0RwnHEXOug==
X-CSE-MsgGUID: jSLleud5Tyu3wGvAWw1gEA==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="35018898"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:41:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:40:54 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:40:54 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH 09/15] dt-bindings: clock: at91: Allow MCKs to be exported and referenced in DT
Date: Tue, 19 Nov 2024 09:40:15 -0700
Message-ID: <726533dbd5663e95b768bd19d2d544a197e5781d.1732030972.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1732030972.git.Ryan.Wanner@microchip.com>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Varshini Rajendran <varshini.rajendran@microchip.com>

Export MCK3 and MCK5 to be accessed and referenced in DT to assign to
the clocks property for sama7d65 SoC.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 include/dt-bindings/clock/at91.h | 4 ++++
 1 file changed, 4 insertions(+)

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



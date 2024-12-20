Return-Path: <linux-spi+bounces-6144-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 614529F9BB9
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F86E7A630D
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01322B8B6;
	Fri, 20 Dec 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ppCdu7uI"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7F22B5B1;
	Fri, 20 Dec 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728970; cv=none; b=ioSJNbjofLxzC29z/zswpDD8Qrg204O3twb2a5JA5Qq14OI8GN5NL8XYz7rUPRsmlW1dBwGD6F0qOrHKEdoq6tp66dt5kdW+nzvgNmSz8Jm96SjnWfg6cl5y0RsaTPuCP3pmGgf2lZQsAieoVGQgDYDMatjduX03XmzF1nxU04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728970; c=relaxed/simple;
	bh=TI+Fl3/fq9+Bp9S16REL62Tz0AjZCk87d4UxYP8JSJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2X75qvJmwLO/rFWeZ0BLEgieaNGi+Mo9Z/0GTbs+eVnM8awObnIqIodad85Mg8ToxIFPOE3oXrx2otpWlrK3GmxUfN0/DjvH/FseY1dNE38s/ZLHXo8x7IkUrx+knso7IxL8ZIaHcW7PnhdJs1FD8d4zBsk+mKuhcIqUEuDjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ppCdu7uI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728969; x=1766264969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TI+Fl3/fq9+Bp9S16REL62Tz0AjZCk87d4UxYP8JSJo=;
  b=ppCdu7uImjbZ1G/0MBcoyAiIlqiHM+ZWrr4Flb0Yyc8HmgSsnS17r1SM
   aaFRqw5V6QGU/xVJ3aNyyizbD/DAeAbl6a5wX9PsCWBQr1CzNIUPmR0IZ
   NvEPIdm/JnKt+sN1fS+Sj3Diu7FgGrzZrT8Cy5xFjqNrPZahmNkMQbfQh
   Lg2oV9yPFGAJ6cOQ1FMkqdhZ9OPvCLRwgRTbE5yUdCtoUlwLDaWt+Hi8o
   3jTA3r2nY+EOF0scszpuzssCXDeK9fPJtNACRjzxDf3m3d//weI4xRwrL
   8gx+ZvVeMX20IrltuBx9VrYGY5UVCHdFzhiQSHzHuyp7jWPq2d7bYyYc0
   Q==;
X-CSE-ConnectionGUID: USBJ4PpbRGWL74rt+H8wuw==
X-CSE-MsgGUID: fXYWYnuZRVu6yBH7Tr25UA==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35811487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 14:09:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 14:08:44 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 14:08:44 -0700
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
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH v4 12/13] ARM: configs: at91: sama7: add new SoC config
Date: Fri, 20 Dec 2024 14:07:13 -0700
Message-ID: <ac5ee2a78309f8a21ad99f53e66206f3d163263b.1734723585.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734723585.git.Ryan.Wanner@microchip.com>
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add sama7d65 to the sama7_defconfig.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sama7_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 758276027dbc..b1dcec1a6df5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -20,6 +20,7 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
+CONFIG_SOC_SAMA7D65=y
 CONFIG_SOC_SAMA7G5=y
 CONFIG_SOC_LAN966=y
 CONFIG_ARCH_BCM=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 1a2e93c8ee71..ea7ddf640ba7 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -12,6 +12,7 @@ CONFIG_EXPERT=y
 # CONFIG_IO_URING is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_AT91=y
+CONFIG_SOC_SAMA7D65=y
 CONFIG_SOC_SAMA7G5=y
 CONFIG_ATMEL_CLOCKSOURCE_TCB=y
 # CONFIG_CACHE_L2X0 is not set
-- 
2.43.0



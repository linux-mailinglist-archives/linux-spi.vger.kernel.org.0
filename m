Return-Path: <linux-spi+bounces-5937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C609E7999
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E939A16E897
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28721B1A4;
	Fri,  6 Dec 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s+7+JFHo"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DF215181;
	Fri,  6 Dec 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515289; cv=none; b=TNRJLrWqQDcspn+Rkq1PKr773fHrLZhMbaipFLYoBoCFl+oa3N31zKU/8CgZMvcfAlyboEcQZUmlgxQ/BsQWa/VfEcjRkuSP8q5INKZmTSqZzQoYKNx5qUBnK3ntpez9g8srreTbVZrm6BQZ7CrL9Uht7TFskElwsXJvOadI1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515289; c=relaxed/simple;
	bh=EDgeR2CqOpPK7W89tJ2iGezT48Utt4/EPu+Pu86jzto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0PeofCZo/OrtSybFQTqP+xRE+CWYwaLd4kGWKWAaBM7JYPdn2azukOj5ELy+nQX54Xpc/QFtZKUUuudLBSUmkn5S0A2nh3GjMOmfOcoWfCex8sJAu2GRyvDnfm+8S7dP1DWSLQb+kkP+C2ykDtxRCgQweZXK77vScRx3aayp70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s+7+JFHo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515286; x=1765051286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDgeR2CqOpPK7W89tJ2iGezT48Utt4/EPu+Pu86jzto=;
  b=s+7+JFHo3tFfYzp35G3okJsBMa53vk8l+HVOJcXXnAKgW7v/cj6UNAQI
   wgTpWaUBduzEoksOB6iEdPhCu1ZQFSAQXMXNMXzjNhxYvsFXd569pMv4o
   Wes2EK3y0kuBuUOZ89MO8AVBL/tJQV1BLlUVc5kDMzrl/8+WuHjpUJmSq
   V75ridM2uMDSikfFjUS0GxQvvS/Nw0kU9782LGOCNA147GsJXJpKMlQkq
   UvFKk23t5QFqVPzL0iyGVcMtjICj5rfCV/IF4FUADVKlqk94NPBkXYX+8
   A3H+vQnV8aaTNA1zeL6ZTkS+f2BSFEOxeM9b5NUqhUfpSZWun3cHaiytE
   Q==;
X-CSE-ConnectionGUID: wHv5dacKTzaP3KMzdbJ8Aw==
X-CSE-MsgGUID: Tk7POqmnSfmkzx11dwdSKw==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="202686991"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:11 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:11 -0700
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
	<linux-serial@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 12/13] ARM: configs: at91: sama7: add new SoC config
Date: Fri, 6 Dec 2024 12:59:57 -0700
Message-ID: <e5a1311100a4f05fdc44107e124129d2d93df2e0.1733505542.git.Ryan.Wanner@microchip.com>
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add sama7d65 to the sama7_defconfig.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
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



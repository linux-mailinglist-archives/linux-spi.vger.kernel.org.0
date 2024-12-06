Return-Path: <linux-spi+bounces-5936-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DD9E7994
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66D616E64F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B3D21B18E;
	Fri,  6 Dec 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pq0uuLFx"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22D202F9C;
	Fri,  6 Dec 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515289; cv=none; b=diw22nsD/Dj6EjHxwXZY8xQF7vX0/d7vBTjF3IUDANVRi4GBuUNrrl2WKzZElx8foH6ThY3eDQdBMk+FRVxbw/mnyG7RSmKdKhc/pSotI58+lOqxXXtUDQEtHSNXgTeDP2z/VCEChnD3ypbLDEUvA8JJjfWIF9WrAkjfXBmwocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515289; c=relaxed/simple;
	bh=y6XXCJxHP7R+S063ODrYUxtG2dLu1WyZCtnr2qnbn14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2zPjk0CPv7w4GhpjU6K5lQehupCbTz2HtdhdAM9g5VorGJ4YnYVe4RPW57Qh/5a4K5lPe+HEwdF2J4vxMS8/sYxmYnLC6ki4lU0oXcKnEH5jQ1L6v5EFQP/qHBhFxLV/+ICkJYgxeeuxdA/yUCt8SXVsb49g7HmkO/npFE578M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pq0uuLFx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515287; x=1765051287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y6XXCJxHP7R+S063ODrYUxtG2dLu1WyZCtnr2qnbn14=;
  b=pq0uuLFxMM3evb3Bfx57ajZrrFQGsZ/O22WmMVM42r1j9YiwXktm4Aq/
   +kTLPi9X/TXMdjB6OPrexZYg79tHWhF3Uyx5Df8xkx8Q0j0HbgFpK9Eug
   PbY4KcpTaokMgSS4MJIL3Ji1Vu9QAV6MdMTleMFjBosWKMLQEHN9przTa
   Fy3Y2XJpzHvAzgHPNux63TO7+k+TGdlUMYJfw3ph5BboTP5nGvkRK8KQ5
   Y6E1kvzkzHb8v4A7Dar8GP7J5onpWypuhgNvTQyHXuYBklToD1WPnDGtp
   iSkdGgi3vwcJAO8nInIvNbq7xLxXprivsTbhcn/H2PhX1ppIxSwohbCrK
   Q==;
X-CSE-ConnectionGUID: wHv5dacKTzaP3KMzdbJ8Aw==
X-CSE-MsgGUID: Qt5jBYA3Tu+eE+ndM0DS+w==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="202686993"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:24 -0700
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
Subject: [PATCH v3 13/13] ARM: at91: add new SoC sama7d65
Date: Fri, 6 Dec 2024 12:59:58 -0700
Message-ID: <465960c9240553753e96a7f4ff3f48879ade7558.1733505542.git.Ryan.Wanner@microchip.com>
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

Add new SoC from at91 family: sama7d65

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 344f5305f69a..2c7179b1baa0 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -58,6 +58,15 @@ config SOC_SAMA5D4
 	help
 	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
 
+config SOC_SAMA7D65
+        bool "SAMA7D65 family"
+        depends on ARCH_MULTI_V7
+        select HAVE_AT91_GENERATED_CLK
+        select HAVE_AT91_SAM9X60_PLL
+        select SOC_SAMA7
+        help
+         Select this if you are using one of Microchip's SAMA7D65 family SoC.
+
 config SOC_SAMA7G5
 	bool "SAMA7G5 family"
 	depends on ARCH_MULTI_V7
-- 
2.43.0



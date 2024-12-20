Return-Path: <linux-spi+bounces-6145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258949F9BB1
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE231898493
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36B22B8CF;
	Fri, 20 Dec 2024 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z5n7P9K/"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED464229125;
	Fri, 20 Dec 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728970; cv=none; b=du0Tz4YD6ha7UTvd9+QDFh+oylfhYhyCxU9pbV+ke+5n2xVwM9UHHDnBwPo2izbp+qngibRwvP82Y4EZ8sOzAm3QIzLtd6m6KtI3t8l5FalbYd7Yn/fumflb9FKURB/xU3Md1JZc6AQcp215L2vK3qDsmumUIgiozcmtWzDdV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728970; c=relaxed/simple;
	bh=/Sc5e5S6Ark7/RKpxpSHi1yxsShKypU8cVy4XdHazvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9oZbZkMcBCKICdcPOZMnnlzKdI/alQ4j4DOUAoMsidrymWUK2PcWCPHPU1myiloyZCsKiZ7qg0RKTUtOEaJKXKMKug8g4cTvfe/E+FIZe+1a8dangRWvLDj1eSHTqkM0eEzq6ccCHIIFLm39tVY1ltUmzVBXygd2XNaIEsF9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z5n7P9K/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728970; x=1766264970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Sc5e5S6Ark7/RKpxpSHi1yxsShKypU8cVy4XdHazvk=;
  b=Z5n7P9K/K7OXo9kSHCVUk/ZH8F9Wp8aVOOtLvk2Yp/xViJfLQotbFnU2
   y19A5pZJWP6vxNwLCCqDieSbfC6qpb311YqUHsQFppG/qOZ0UbvllKPc4
   ZGm1Nw8dEl5HXDhvJaCl/kD4Kg8+gj9ZaQ7TQHt+edyOZsglsvHxQ0bFo
   L/fgAGofH07hTFPlrLmPdlqI4JzCqfE6L9Q3F4yZscw3X3RiSIhuWoxwL
   V8IiyaeToAgksEs1BOb+N7HlFbiPU/DlCULfmrbCV8Oteg05454zlwGIu
   iNuHDoO2UnyqABDJsS9s6mWDrrJrxsYUkUxxxkztIj8wE6mNeUxmuJ+JB
   w==;
X-CSE-ConnectionGUID: USBJ4PpbRGWL74rt+H8wuw==
X-CSE-MsgGUID: 6PnJBJnNSu+Dl0QxuQ4+Ag==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35811489"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 14:09:26 -0700
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
Subject: [PATCH v4 13/13] ARM: at91: add new SoC sama7d65
Date: Fri, 20 Dec 2024 14:07:14 -0700
Message-ID: <aafa6115adc52d30bc83206f8fab5964d4dd7fb7.1734723585.git.Ryan.Wanner@microchip.com>
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

Add new SoC from at91 family: sama7d65

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/mach-at91/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 344f5305f69a..04bd91c72521 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -58,6 +58,17 @@ config SOC_SAMA5D4
 	help
 	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
 
+config SOC_SAMA7D65
+	bool "SAMA7D65 family"
+	depends on ARCH_MULTI_V7
+	select HAVE_AT91_GENERATED_CLK
+	select HAVE_AT91_SAM9X60_PLL
+	select HAVE_AT91_USB_CLK
+	select HAVE_AT91_UTMI
+	select SOC_SAMA7
+	help
+	  Select this if you are using one of Microchip's SAMA7D65 family SoC.
+
 config SOC_SAMA7G5
 	bool "SAMA7G5 family"
 	depends on ARCH_MULTI_V7
-- 
2.43.0



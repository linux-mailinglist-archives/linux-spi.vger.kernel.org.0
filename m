Return-Path: <linux-spi+bounces-5745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1E9D2B75
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BC6283FAE
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4621D6DB7;
	Tue, 19 Nov 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GpJHg1i4"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29A1D0F56;
	Tue, 19 Nov 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034486; cv=none; b=s6f39vWwagPWSrHpbWoikgrFE99B3Jkg3prutFCRraSQ3d+gV3ZYU9HWCZln40tgQ2MUvzGy4BICGu/ZVxZF8DTQrrmE9BdZapSJ+AzN6RYVbws1rbtcxMMjGteuQrSbQV/2C1hzpoFLuTAB6XqBu+n+N9lBVk+TYg3VFpDqz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034486; c=relaxed/simple;
	bh=SOPsnkhwPhbTqIhL+AfAja6IVOaQyvZoZM6IJCh1A80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kke3KzjtaChNpwfuPSPo/ShorXRMD0eXUMsMwBscyPH6l7eb68SjrEQWNiGrszv1pRWxd3wRSiJgVz8Ii/dLEqhmlpqDcl8K2cx3I2CWLT1llYEcWsdIOJ6HKSchO5eVvjhePUTuEQS803ZuZGAjsqdHG8NMes9OM2WnXHWnZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GpJHg1i4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732034485; x=1763570485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOPsnkhwPhbTqIhL+AfAja6IVOaQyvZoZM6IJCh1A80=;
  b=GpJHg1i49gZxNuGXZIB8YX0wrNyZ7OrqI/RaZ2a57k0iHG6hJZ9KR0MH
   yyLX5XW5RJ9BQI2lRS791d8KDGSp98tp5p5Up+gVx4/zhZGfgXP7MFRlq
   l699adzEVUvVrgkAnAhBYvrkk2xX0A8z+Lslc7g78HLX9fuH4TJ8P9w7I
   Yb6kQdtHQCUEGrBbyhnZb1Hpok38XODYhldK1RUUD3dJhosAhQM9nHpJO
   5Px7MPCLdq2yOZuHRm/VU13+Nv57N+D9ST4vjYZvbfeefE8JqP0IdCx4w
   5ntBSAmdE3LUpYt6W/IzykR9i7X2ZS9tanPv8PTsIQVhGfvklz1ZfxpZL
   Q==;
X-CSE-ConnectionGUID: RxwVwqVBQ5Gt75b5OWvVzw==
X-CSE-MsgGUID: //v/aCFsThORs0nIaJCQZA==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="34239910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:41:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:40:55 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:40:55 -0700
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
Subject: [PATCH 14/15] clk: at91: clk-sam9x60-pll: increase maximum amount of plls
Date: Tue, 19 Nov 2024 09:40:20 -0700
Message-ID: <ea419d3789c0ef60aa7b24877d905f2e2e6f2078.1732030972.git.Ryan.Wanner@microchip.com>
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Increase maximum amount of PLLs to 9 to support SAMA7D65 SoC PLL
requirements.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index fda041102224..cefd9948e103 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -23,7 +23,7 @@
 #define UPLL_DIV		2
 #define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
 
-#define PLL_MAX_ID		7
+#define PLL_MAX_ID		9
 
 struct sam9x60_pll_core {
 	struct regmap *regmap;
-- 
2.43.0



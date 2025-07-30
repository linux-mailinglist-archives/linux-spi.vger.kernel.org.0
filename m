Return-Path: <linux-spi+bounces-9228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3F3B15DD8
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 12:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D027916E563
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC41A26CE1D;
	Wed, 30 Jul 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rGUmOfLB"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017C1C861F;
	Wed, 30 Jul 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870247; cv=none; b=gS4KwFC9davYotNQ7ZFryzyY4EsUuMaMo8HllWVKcU2YexV+G7g8WgwKkaFlkrkKywwr9V5nikAyOiIFrgWoJSjtLwjlbdB+/y1N+9PqPQrJRLRzD+XAj5XUDMmYJxYi+YKlCPEnL1zr8vn2jr6k2Tvq1Nois2l+fy6dcZG3hFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870247; c=relaxed/simple;
	bh=CEApDR0me/9Oh3mS6/WNJv0S9khVvbMWXbrANG9jKFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nErHv0cg3Gc0XYBArIB6Alz9yz/mkbRNl9vXiA5yeyJJ4zSBnYcNoWlK2tebZsxh2G31PMnF0JkgrOVaV64avD4sLS7vw276PY7g7QP2fRKuCPxm5PIBqe4VMaSy930uFG07D/Anxpw9fiQVfwNDJnNYhlu/MbAppw/WTULP0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rGUmOfLB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753870247; x=1785406247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CEApDR0me/9Oh3mS6/WNJv0S9khVvbMWXbrANG9jKFw=;
  b=rGUmOfLBwzLuLCUYWEWT0L7W3kGTHu9FKjdMkxJdrxOucSd5MsJBmofl
   KVw7IUz4D4X/LjrH3NUnP+A/IAO/np6g3G1hCFX4RL75C5X6mQYNEuk9y
   bt978I7fhw+YTEilpsymrYW3XkfCtdLvj5d+30iUsB9WrebTeUv0LXK8F
   /tCh4VpW6ekUkqLBq5Gl5Z9/wFV1g3NraGZZj7qC0fOtHMO2ZfpsnOYUw
   auTV0+oee/bglmK2wHh3VEXHAsh5y1XObBHlQgdhl6IPRRUc1wejri3eQ
   vTWQBbExA9ETcp0I64nzYXvwFY+CZAznFHBFM9CQjqxt6CpaAepf80hUU
   Q==;
X-CSE-ConnectionGUID: vbXkopccR520ORU6weHWoA==
X-CSE-MsgGUID: plcsMLO+TOCy5vR7WLXQ6g==
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="275986690"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jul 2025 03:10:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 30 Jul 2025 03:10:26 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 30 Jul 2025 03:10:21 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<ryan.wanner@microchip.com>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 1/3] spi: atmel: simplify MR register update in cs_activate()
Date: Wed, 30 Jul 2025 15:40:13 +0530
Message-ID: <20250730101015.323964-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

simplified the MR register configuration by updating only the PCS field
using SPI_BFINS() instead of rewriting the entire register.
Avoids code duplication.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v2:
 - Fixed mail threading
---
 drivers/spi/spi-atmel.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 89a6b46cd319..409f544d8983 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -397,20 +397,10 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		 * on CS1,2,3 needs SPI_CSR0.BITS config as SPI_CSR1,2,3.BITS
 		 */
 		spi_writel(as, CSR0, asd->csr);
-		if (as->caps.has_wdrbt) {
-			spi_writel(as, MR,
-					SPI_BF(PCS, ~(0x01 << chip_select))
-					| SPI_BIT(WDRBT)
-					| SPI_BIT(MODFDIS)
-					| SPI_BIT(MSTR));
-		} else {
-			spi_writel(as, MR,
-					SPI_BF(PCS, ~(0x01 << chip_select))
-					| SPI_BIT(MODFDIS)
-					| SPI_BIT(MSTR));
-		}
 
 		mr = spi_readl(as, MR);
+		mr = SPI_BFINS(PCS, ~(0x01 << chip_select), mr);
+		spi_writel(as, MR, mr);
 
 		/*
 		 * Ensures the clock polarity is valid before we actually

base-commit: 4b290aae788e06561754b28c6842e4080957d3f7
-- 
2.25.1



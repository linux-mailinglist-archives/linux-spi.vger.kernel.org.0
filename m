Return-Path: <linux-spi+bounces-6312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071AAA095A1
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 16:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF589188EF69
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46A212B35;
	Fri, 10 Jan 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dY687/Ty"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E27212B28;
	Fri, 10 Jan 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522775; cv=none; b=UtabbpJNan7BBrc7f4KqZMyXZ+VboKljwFXkDx+s1ilfofneyX8CEJrxMvox6Nd3MQtlxstACsEOi0r5W3AzliafKoMrpT4AshH3FKDMPpMSVbn6oY2pgweItqLKvVIfTK6HZzdEWkqCb0rPG9VLuFl6pqHCaB6rOPioAh6i/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522775; c=relaxed/simple;
	bh=TzosbwHEdnIy/bEAra2YOoleYUa+ANh4p0cWMT0d+EE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bb1LFS3O296gkaSC3ul0v4YT7fc0jCF2xOtChvlzIQxpFDdH4Tz03usy63GvcYGyMUjcFty9tkbaaDQi175fgoyy4QIy626qmSElam/vNpZfvNduEIWzTCWwiZL9BoYAZF0U1sos/yLUSMOX5dovKaiE5GO4PcpRvOWVz4MFxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dY687/Ty; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736522772; x=1768058772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TzosbwHEdnIy/bEAra2YOoleYUa+ANh4p0cWMT0d+EE=;
  b=dY687/Tya6nXuk/ZIGvos4i70qElBLnGNtPTrzMOksPDGjJsUXCn9/zn
   vDt6t4eSgpRzPu7+Hfw+Qj8Z4YncW1bHcBar1RRl0Ct4FS127oZc34Nwn
   /D5h085ECP3HsTS04nhxEcTWw8LJhrg2pB5MJaKTq09OOVCDHS9YOuBga
   BgePB9rr30FsLu0SRvLRpJcq6264P5zJ4Hl7wf3H31XoLq6LRt4CdqEhy
   H9vJSC1X4y1tjuOgfU823AO3vRpK3Kj5lZfj2WjVEi8eicfE627DMHEMr
   MQJ0XD/CXqBe1hbIRU1CaVXxQcesMbJqcYgPtSkSA9uYEFVnUWpt0WHOQ
   g==;
X-CSE-ConnectionGUID: 5GPtyWRDTC6ZDj4SFqiVRA==
X-CSE-MsgGUID: Q023PzxzSBSbN5Hp498PUg==
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="203886120"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2025 08:26:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 Jan 2025 08:25:52 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 10 Jan 2025 08:25:52 -0700
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
Subject: [PATCH v6 0/3] Add support for SAMA7D65
Date: Fri, 10 Jan 2025 08:25:39 -0700
Message-ID: <cover.1736522006.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This series adds support for the SAMA7D65 SoC.

V2 of this series [1].
V3 of this series [2].
V4 of this series [4].
V5 of this series [6].

For the pinctrl and pit64 timers those will have DTB warnings due to
those bindings not being in the .yaml format.

Changes v1->v2:
- V1 set was sent incorrectly as multiple seprate patches v2 took all
  those patches and put them in 1 thread.

Changes v2->v3:
- Correct the patch order to follow correct practice.
- Correct flexcom dt-binding commit messge to reflect the changes in the
  coding style.
- Add missing SoB tags to patches.
- Moved export clocks to DT patch to be included with the clock binding
  patch.
- Separate Kconfig changes and defconfig changes into different patches
  and removed unused Kconfig params.
- Correct confusing SoB and Co-developed chain.
- Removed unsued nodes in DTSI file and sorted includes
  alphanumerically.
- Fix incorrect dts formatting.
- Separate dts and pinmux changes into two patches.
- Combine PLL and MCK changes into core clock driver patch.
- Correct formatting in main clock driver.
- MMC dt-binding changes are applied for next so have been removed from
  the set [3].

Changes v3->v4:
- Collect all tags from maintainers.
- Correct compile error on 11/13 and correct location of vendor specific
  properties.
- Add USB and UTMI selections to 12/13 to prevent compile errors due to
  functions in the clock driver that use the USB clock system.
- Add "microchip,sama7g5-pinctrl" compatible string as a fall back in
  9/13.
- Add missing kfree() to 8/13 to correctly handle error case.
- Replace bad spacing with correct tab formatting on 7/13.

Changes from v4->v5:
- Remove patches that have been applied [5].
- Update pinctrl dt-binding to use fallback formatting.

Changes from v5->v6:
- Remove patches that have been applied [6].
- Correct incorrect spacing formatting on pinctrl dt-binding.
- Reintroduce flexcom to the thread since it was removed due to an error
  in collecting applied patches.

Note:
- For the SDHCI DTB error that patch has been removed do to it being
applied see [3].
- There are DTB errors on microchip,sama7d65-pit64b and
  microchip,sama7d65-pinctrl, this is due to those bindings being .txt
  files.

1) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#m9691b4d58b62f36f6cbac1d06883c985766c2c0d
2) https://lore.kernel.org/linux-arm-kernel/cover.1733505542.git.Ryan.Wanner@microchip.com/T/#m3b52978236907198f727424e69ef21c8898e95c8
3) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#mccf6521c07e74e1c7dc61b09ae0ebdbbdde73a28
4) https://lore.kernel.org/linux-arm-kernel/70d429086fd8e858d79ca2824ad8cc4a09e3fe5d.1734723585.git.Ryan.Wanner@microchip.com/T/#m918b8db23c8d30981263846a02dafc085e17de14
5) https://lore.kernel.org/linux-arm-kernel/70d429086fd8e858d79ca2824ad8cc4a09e3fe5d.1734723585.git.Ryan.Wanner@microchip.com/T/#m69b8f11536e3b0ca3d69d125d0670c90412d4317
6) https://lore.kernel.org/linux-arm-kernel/20250107160850.120537-1-Ryan.Wanner@microchip.com/T/#m54eaea3dc49c687865e3db33e286eeb29edd7cf0

Dharma Balasubiramani (3):
  dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
  dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
  dt-bindings: mfd: atmel,sama5d2-flexcom: add
    microchip,sama7d65-flexcom

 .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml   | 9 ++++-----
 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt         | 1 +
 .../devicetree/bindings/serial/atmel,at91-usart.yaml     | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.43.0



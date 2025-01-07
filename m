Return-Path: <linux-spi+bounces-6244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE7A0456D
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38921645F6
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D561F2C23;
	Tue,  7 Jan 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PfA0Wxhf"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AA11CAF;
	Tue,  7 Jan 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266115; cv=none; b=BHlhhJVtylRKmKnXANotNPlDJg4mutuzBw5SkZ7W7dXlwJGL7HbFZI07nN0yQJB4eNrmTtpAWS4n10UanOpcH4/iVB9WApuTZAJGrdOYv7yt67wTYgO+bXSI3drG6lKKPtu8+SfpdFVjeQd6MVX2kkUw9RPCdCKjlz0VRosiSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266115; c=relaxed/simple;
	bh=hXz07YNeytmjgCcuOsFJXI6AMOoGwgYaHhgrjG0nUbU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rk2cOSVJAdPQZWX3/g7cMHLyDkExtIflpyyq+GKycq8b4fvUBPwjS6lht0KUO1wC7FBLshEULH3F/AksOr+94Ecksg2TUlu4bbPPKpg7pi4+/sVisPpTXToJBRnHLCX8fu40CwOCdK0cXCpdqZcOEKKF9C0iMd/7tOuNn555CkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PfA0Wxhf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736266112; x=1767802112;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hXz07YNeytmjgCcuOsFJXI6AMOoGwgYaHhgrjG0nUbU=;
  b=PfA0Wxhfqfi+nqkpnYN8+eLkG4VXa4zv/+xnegaSX8ADdysmqCltwJ9b
   PA1Qi3KfPccFHXOlnwmAHDjPKzx4S5vcKUtsCs32iD9LAzrhWnrTbZgjl
   c4tkVV3kpCnJzFPoO/KWiGNhSFn3YAcWAPKuheyTuL3Txoit7zYxabJrP
   LDYoMOPL+OT+eDqQ8GG7MOJBo6kx+CZlUq30v1Zk9eTDTBSBTv4X748ko
   GGq+RdkGLZWNEnh9x/gHToDt9s7opfC+3FO7JmDclcMN5VJK4IGGAvDdd
   ZnLSUHWey7G4aE5DQ9bGpGPyNWmukIF5wzqAe/Poq7TVKrdmXiw6y9x1X
   w==;
X-CSE-ConnectionGUID: lqpfnJzJQpCXzb9QKpQeRA==
X-CSE-MsgGUID: OWRa46htQ1Od4ovM8pN2Ig==
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40091246"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jan 2025 09:08:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 Jan 2025 09:08:17 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 7 Jan 2025 09:08:17 -0700
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
Subject: [PATCH v5 0/5] Add support for SAMA7D65
Date: Tue, 7 Jan 2025 09:07:22 -0700
Message-ID: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
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



Dharma Balasubiramani (2):
  dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
  dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl

Romain Sioen (2):
  dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
  ARM: dts: microchip: add support for sama7d65_curiosity board

Ryan Wanner (1):
  ARM: dts: microchip: add sama7d65 SoC DT

 .../devicetree/bindings/arm/atmel-at91.yaml   |   7 +
 .../pinctrl/atmel,at91-pio4-pinctrl.txt       |   3 +-
 .../bindings/serial/atmel,at91-usart.yaml     |   1 +
 arch/arm/boot/dts/microchip/Makefile          |   3 +
 .../dts/microchip/at91-sama7d65_curiosity.dts |  89 +++++++++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 145 ++++++++++++++++++
 6 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi

-- 
2.43.0



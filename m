Return-Path: <linux-spi+bounces-7852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836EAA76C5
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44657462C21
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3C25DCE4;
	Fri,  2 May 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gRPrq18/"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA125D559;
	Fri,  2 May 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202225; cv=none; b=LpNPboJWg/xY9l3UTPwQgCaAXZgulc+MjHPmVzlGYh7k59zt4RAdrKGiXV/gSYYfS+Gqst7QRJ2W49hACZd1U+oQwI6ExxhUFKxeW4dwhNgCAQZBVEZ55F9j7JHTvNQ/ccjfBzTMM38WWcv+er5tQEk+kChzjl0527jFr4Wz8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202225; c=relaxed/simple;
	bh=r+ZFiVt/dDb2AMcVYEg7xcrsHD3O/de3GhkFxCxrqpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7/pd2Fn79rIoVwkladr7PK0g3EyMV8tqf0IOS+pDv/9Q+roLtJkVfhaPN13oP3EF0zJmcudp5qairLquhzJPPshL73Ho9zM1K6Iw1Nv3ybPIuBcI9tiuggSWSdWqWoBR7g+t8XL+GtzmKvHBdyZpfIVTUduyUOZTHSdYr+N+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gRPrq18/; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1746202224; x=1777738224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r+ZFiVt/dDb2AMcVYEg7xcrsHD3O/de3GhkFxCxrqpw=;
  b=gRPrq18/nk4U9C9XzW69EWQRAWcMw5dFCYdxgwD50b7WSkdSo1qXxIc7
   s+mEsaaq8gv1/Q18hlGSjdvduVn7GEL77JD67kFk938n6mg4U6Z1t20U/
   4JfgdLTA9NrtJmV3biY8DNic5SBOHUIgbrDXFoJMeOQ9Ah6iPBtigOZp7
   /n/L1a9XMWB1klVExK5UZihoUez1N6mD6Bb9yPdY+8bixGRBfb4dknIew
   YdEqVr1Mw9JslzqPsHhKBzJs29A7NY+3Wilfcw0tnUjqmG4QYT1vz/j3G
   7SwkKjTAeQlOc6+zfoMkct7xNqXEfiaJ1TaKXbwIQE5CeJGrnwzbbil+3
   Q==;
X-CSE-ConnectionGUID: JuVaQLK6ReSI1JeiqIMSGg==
X-CSE-MsgGUID: 0PtHX2u+QbC8wLcsV/qZng==
X-IronPort-AV: E=Sophos;i="6.15,256,1739862000"; 
   d="scan'208";a="272519107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2025 09:10:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 2 May 2025 09:09:33 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 2 May 2025 09:09:33 -0700
From: <Ryan.Wanner@microchip.com>
To: <radu_nicolae.pirea@upb.ro>, <richard.genoud@bootlin.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<inux-arm-kernel@lists.infradead.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [RESEND PATCH v6 0/1] Add support for SAMA7D65
Date: Fri, 2 May 2025 09:09:59 -0700
Message-ID: <cover.1746201835.git.Ryan.Wanner@microchip.com>
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


Dharma Balasubiramani (1):
  dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart

 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0



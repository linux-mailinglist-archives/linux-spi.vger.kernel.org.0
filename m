Return-Path: <linux-spi+bounces-6425-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A742A1937B
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8071B1692CD
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C7D213E83;
	Wed, 22 Jan 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="w8sjwGJd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C5212F82;
	Wed, 22 Jan 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555213; cv=none; b=rm4fmHhWDoxJY4MfFpLXE0D7U7FbNAZZKwWiyGj3x+/rSe6O+b0NvdDBWTzeDISMcEbieHY8fZBvxBVa7nGton2wuYA+1WrKgj8zhcWzDc3WkzAwJPVXDY65EhBm+z+MXBwFdGBDyDouQFymjW9TO0wc1dySW5+NOCrNKBZeblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555213; c=relaxed/simple;
	bh=lHKgZsOf6PFslK2JfvOp6ZOw5VlIvpqfGeJ93srDMrE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Azu9fn1HyBwADInz/xfUA3gKsQ1nDDKMVF3hoSsqpTtAbaYBlW2dYL/sR3Y1QsC9zrTNLKhcX2+kUGIHW1xN3sXaTukrAd0zjIGH0l3dV5mhuJV0VrtGQoCU1nB++5xkyHHt6tSEiSe8QhMoxuYq6JDs/NIcXqeI1af0e0/xukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=w8sjwGJd; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDhAn9016844;
	Wed, 22 Jan 2025 15:12:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=1fDFIpBF/8CgzX8vaDBMUm
	hFzM5jK4Mt4RtibyILt9o=; b=w8sjwGJdkz0t9yIV2EVIuBqYH/l6IhQT4VD1sq
	BtW0njOtzSPgblfkW6IA+RifuGZp0nTppzvGklxFRBphggMeZpnHmyMJpc5B/mdb
	Xls5fBKWO3VorPYF4ZgvnAAjA4VLoH0dma0b1m5q1eVE7TZ5ik5EAPx/JPakVg8V
	Uz9Cy56cTEKKiBSJ3RoZhJTYdFPGLRrJS+li5/VpyvGmtFXWoQgvL6a/O39Q7bBr
	iDsWIv1rmrYzUPSgODf5Mj92yGd0k2Z+XkwiesS/m9HRGX6P8Z87OrbwJipMsga8
	dRuFsSu6poOkeR1dBV3eVJy8wpaMxGj8EMpX4ZbJX2HQBi+A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44aw9x17t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 15:12:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 80C844002D;
	Wed, 22 Jan 2025 15:11:39 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A1FB2943AB;
	Wed, 22 Jan 2025 15:10:39 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 22 Jan
 2025 15:10:39 +0100
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>
Subject: [PATCH 0/9] Add STM32MP25 SPI NOR support
Date: Wed, 22 Jan 2025 15:10:28 +0100
Message-ID: <20250122141037.953934-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics,
for that it adds support for:
  - Octo Memory Manager driver.
  - Octo SPI driver.
  - yaml schema for Octo Memory Manager and Octo SPI drivers.

The device tree files adds Octo Memory Manager and associated Octo SPI instances
in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1 board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Patrice Chotard (9):
  dt-bindings: spi: Add STM32 OSPI controller
  spi: stm32: Add OSPI driver
  dt-bindings: misc: Add STM32 Octo Memory Manager controller
  misc: Add STM32 Octo Memory Manager driver
  arm64: dts: st: Add OMM node on stm32mp251
  arm64: dts: st: Add ospi port1 pinctrl entries in
    stm32mp25-pinctrl.dtsi
  arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
  arm64: defconfig: Enable STM32 Octo Memory Manager driver
  arm64: defconfig: Enable STM32 OctoSPI driver

 .../bindings/misc/st,stm32-omm.yaml           |  194 +++
 .../bindings/spi/st,stm32-ospi.yaml           |  109 ++
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |   51 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |   48 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |   33 +
 arch/arm64/configs/defconfig                  |    2 +
 drivers/misc/Kconfig                          |   17 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/stm32_omm.c                      |  510 ++++++++
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-stm32-ospi.c                  | 1064 +++++++++++++++++
 12 files changed, 2040 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/st,stm32-omm.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-ospi.yaml
 create mode 100644 drivers/misc/stm32_omm.c
 create mode 100644 drivers/spi/spi-stm32-ospi.c

-- 
2.25.1



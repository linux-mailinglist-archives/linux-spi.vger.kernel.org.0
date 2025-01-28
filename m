Return-Path: <linux-spi+bounces-6517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EDA205F8
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 09:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33491166E1D
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6971DF277;
	Tue, 28 Jan 2025 08:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PcIIKz1M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79511DED6B;
	Tue, 28 Jan 2025 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052530; cv=none; b=MC7cVKjUPrH0h/G7GtnYDVOO750D1C0abxeWmBr/7QX2N6NWkRVR/lXdS8oCd8/mJE43bgKSikYpjoIWoeGOb20LtUKuXV92PbEVXHFszSOin7m0EmgdeYpm///oAakG/VKDNgz+Mm+Td6SH3Ok1zQKX9O/1/h2XZ6cQJZo50vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052530; c=relaxed/simple;
	bh=R6ZrV2+ix9Qbr5QwmTRyMyNyCHO15WQNIC3YEg+HfqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KTzsKTuP6e7IXy7Hls/cymTYSMM4odvvXzKZd6xNWdwJMQdABmcRV+vwvmFIDO7kgJu6nE3nz0NM9O6Y+tuJa8oalhwoD6SXsGQRM8vMGNcx5kCetzu0pcJCuCJ8+CrfTFrw9cCj0LEEM3suA8xzlcah74DVRtcDBo3Ljph4igg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PcIIKz1M; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S21A1k013949;
	Tue, 28 Jan 2025 09:21:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=nxroecgL3dI/8WPwNij68I
	nsn/aM9+LI7YXe9cBnpHI=; b=PcIIKz1MonbRt8+KnMWzWp7tmAWGelDXkOoNe7
	rW7KhxB1KRcPxiRcEd/B6ptOXhjFHiidhBZ9KfFlejgQe7jxXW93GfgZQOEac3ji
	ljg9NK4x642RXBVyc3q1ndkuzCV9ZffRKKhry4qretfKjfP1BYUNWjxKbs7ivns1
	hIZsh/DOkoO1SQOgP+Decu5Nk3p9UXEURvcro0orSCWz/61Csr/WyDYk4xfG+3TU
	LaXxgeL9UzLOoIFwwvnUAmeTUF60F0RmjVz/6asJjd4y47NHsADkSP3clplYreTR
	Ju4fawsfDOh5cyBk+zV7LTramCmw64bMm3kczOBI8wVzEjRA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44embfs6pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 09:21:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2220E40052;
	Tue, 28 Jan 2025 09:20:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 623B229BCDB;
	Tue, 28 Jan 2025 09:17:42 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 28 Jan
 2025 09:17:42 +0100
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
Subject: [PATCH v2 0/9] Add STM32MP25 SPI NOR support
Date: Tue, 28 Jan 2025 09:17:22 +0100
Message-ID: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_02,2025-01-27_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics,
for that it adds support for:
  - Octo Memory Manager driver.
  - Octo SPI driver.
  - yaml schema for Octo Memory Manager and Octo SPI drivers.

The device tree files adds Octo Memory Manager and associated Octo SPI instances
in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1 board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v2:
  - Move STM32 Octo Memory Manager controller driver and bindings from
    misc to memory-controllers.
  - Update STM32 OSPI controller bindings.
  - Update STM32 Octo Memory Manager controller bindings.
  - Update STM32 Octo Memory Manager driver to match bindings update.
  - Update DT to match bindings update.

Patrice Chotard (9):
  dt-bindings: spi: Add STM32 OSPI controller
  spi: stm32: Add OSPI driver
  dt-bindings: memory-controllers: Add STM32 Octo Memory Manager
    controller
  memory: Add STM32 Octo Memory Manager driver
  arm64: dts: st: Add OMM node on stm32mp251
  arm64: dts: st: Add ospi port1 pinctrl entries in
    stm32mp25-pinctrl.dtsi
  arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
  arm64: defconfig: Enable STM32 Octo Memory Manager driver
  arm64: defconfig: Enable STM32 OctoSPI driver

 .../memory-controllers/st,stm32-omm.yaml      |  190 +++
 .../bindings/spi/st,stm32mp25-ospi.yaml       |  102 ++
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |   51 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |   48 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |   32 +
 arch/arm64/configs/defconfig                  |    2 +
 drivers/memory/Kconfig                        |   17 +
 drivers/memory/Makefile                       |    1 +
 drivers/memory/stm32_omm.c                    |  509 ++++++++
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-stm32-ospi.c                  | 1064 +++++++++++++++++
 12 files changed, 2027 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-omm.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
 create mode 100644 drivers/memory/stm32_omm.c
 create mode 100644 drivers/spi/spi-stm32-ospi.c

-- 
2.25.1



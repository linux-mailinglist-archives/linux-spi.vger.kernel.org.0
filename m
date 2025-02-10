Return-Path: <linux-spi+bounces-6719-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CB0A2ED82
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 14:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F5E167192
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062E225772;
	Mon, 10 Feb 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="iKpA9097"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C59224899;
	Mon, 10 Feb 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193681; cv=none; b=i+UeRfWn4RHKdnmtxMhR+QwKsDCa+vwgXHhxfCA/y4NJiG1k3iP05AM9lh5TfPt06Sp49AkAJBS+R/eRF3Egi5iRrDXsNhLX57GL0r/ylWN6kWQoor1JFu3dKxJX61JHgshdswzY7RlF9lGV3ua1gxGienhEBgZuVz6yM//xvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193681; c=relaxed/simple;
	bh=ohN9mnqgyFy+8zghXbtRoiTBs07oTPMtAske+nrnrlk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PYJsyxDnoI3CG8wpJ2mp38nN/DkMXtMJhwgf4kNCysX8T/pmjHtn7bpfMy9yIwnND1KHtQP0l6geriGEqif5Vzr7yitFFXMA5YegMXhlH2dzBtyu0/qfT7ud5wQoYdQ0UOFy/PQILTbegz+MlgZhRAXb9hNXw5WAvBpF5jRdBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=iKpA9097; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ACoxU2015234;
	Mon, 10 Feb 2025 14:20:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=+xeBEnkoP/+TuTHHZLeAJE
	oTX94SaEPrUOWoK3bZLW0=; b=iKpA90971GDP/8qLSl1xzvWQGqb+qVeQJecFT4
	vNlL2FkVb5VPQe62QgbWLnxSxLlL5fGAuPqQS4I19diqsn8az+gZXkLcAfJna+0/
	a8y/RRqH2h1ucDEvbx6vnz5HcxqdCBjTLEKqzKkWcyzYp8usCVo2zpU0WFbF0fM2
	mOBbhY/j7v/q810jTr/eyPRU0g1WHOmtdiMRVojlEagc3p8wZTSswbRpFjmqdNp7
	tvo/uUlKfwHFVWANSeANXwiX3bh728Ka0/Rq498QJuWgloxMYtiPLblwpHhM7U4o
	mIPSrhqlroo56NuzU8vELHx2+yllKDUB3CsgFP4iV3prScvg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0qrxh3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 14:20:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 578BA4002D;
	Mon, 10 Feb 2025 14:19:31 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2DE4125B239;
	Mon, 10 Feb 2025 14:18:32 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 14:18:31 +0100
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
Subject: [PATCH v3 0/8] Add STM32MP25 SPI NOR support
Date: Mon, 10 Feb 2025 14:18:18 +0100
Message-ID: <20250210131826.220318-1-patrice.chotard@foss.st.com>
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
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics,
for that it adds support for:
  - Octo Memory Manager driver.
  - Octo SPI driver.
  - yaml schema for Octo Memory Manager and Octo SPI drivers.

The device tree files adds Octo Memory Manager and associated Octo SPI instances
in stm32mp251.dtsi and adds SPI NOR support in stm32mp257f-ev1 board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v3:
  - Squash defconfig patches 8 and 9.
  - Update STM32 Octo Memory Manager controller bindings.
  - Rename st,stm32-omm.yaml to st,stm32mp25-omm.yaml.
  - Update STM32 OSPI controller bindings.
  - Reorder DT properties in .dtsi and .dts files.
  - Replace devm_reset_control_get_optional() by devm_reset_control_get_optional_exclusive() in stm32_omm.c.
  - Reintroduce region-memory-names management in stm32_omm.c.
  - Rename stm32_ospi_tx_poll() to stm32_ospi_poll() in spi-stm32-ospi.c.
  - Set SPI_CONTROLLER_HALF_DUPLEX in controller flags in spi-stm32-ospi.c.

Changes in v2:
  - Move STM32 Octo Memory Manager controller driver and bindings from
    misc to memory-controllers.
  - Update STM32 OSPI controller bindings.
  - Update STM32 Octo Memory Manager controller bindings.
  - Update STM32 Octo Memory Manager driver to match bindings update.
  - Update DT to match bindings update.



Patrice Chotard (8):
  dt-bindings: spi: Add STM32 OSPI controller
  spi: stm32: Add OSPI driver
  dt-bindings: memory-controllers: Add STM32 Octo Memory Manager
    controller
  memory: Add STM32 Octo Memory Manager driver
  arm64: dts: st: Add OMM node on stm32mp251
  arm64: dts: st: Add ospi port1 pinctrl entries in
    stm32mp25-pinctrl.dtsi
  arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
  arm64: defconfig: Enable STM32 Octo Memory Manager and OcstoSPI driver

 .../memory-controllers/st,stm32mp25-omm.yaml  |  201 ++++
 .../bindings/spi/st,stm32mp25-ospi.yaml       |  105 ++
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |   51 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |   48 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |   32 +
 arch/arm64/configs/defconfig                  |    2 +
 drivers/memory/Kconfig                        |   17 +
 drivers/memory/Makefile                       |    1 +
 drivers/memory/stm32_omm.c                    |  520 ++++++++
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-stm32-ospi.c                  | 1065 +++++++++++++++++
 12 files changed, 2053 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32mp25-omm.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
 create mode 100644 drivers/memory/stm32_omm.c
 create mode 100644 drivers/spi/spi-stm32-ospi.c

-- 
2.25.1



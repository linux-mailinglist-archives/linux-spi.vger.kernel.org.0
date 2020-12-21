Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35212E01F0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 22:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgLUVSU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 16:18:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4491 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUVSU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 16:18:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fe110f30001>; Mon, 21 Dec 2020 13:17:39 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Dec
 2020 21:17:38 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Dec 2020 21:17:37 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/9] Add Tegra Quad SPI driver
Date:   Mon, 21 Dec 2020 13:17:30 -0800
Message-ID: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608585459; bh=f6y2L0vwWIzt5fCjSCV+SE7mqbErr806W9fuUHqwB+c=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=f8tlarZXnEvaP+1jfVvM0LJlul0eugL+IWMnxsEhplaJyDii3hM539RtEqgDNNR3G
         80JnsveZ88BzgwF1wHMzk4uxeMo3R/E4n2QD+dPR9hghujf9h+v8cIiCZwlKcItr1f
         WMfmROozX56fn879lj3KWO0tgYYr3foiwGxAx9I2XIHw7MceSuX3wjoegaO6WWzttW
         KU/CY+JzjdnWlJYz+BKY+pMjK2qktMCX32eehhHQygn1CTKXsB+8OzeMLnaKqm/eK8
         ldlDfyAsf2hykT+4frTN/KhrUko8VnS5dgyWbblGEHMZyvB/DSXliR0UU2pEhdTB9y
         hTq20yb89gAXw==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds Tegra210, Tegra186, and Tegra194 Quad SPI driver and
enables Quad SPI on Jetson Nano and Jetson Xavier NX.

QSPI controller is available on Tegra210, Tegra186 and Tegra194.

Tegra186 and Tegra194 has additional feature of combined sequence mode
where command, address and data can all be transferred in a single transfer.
Combined sequence mode is useful only when using DMA mode transfer.

This series does not have combined sequence mode feature as Tegra186/Tegra194
GPCDMA driver is not upstreamed yet.

This series includes
- dt-binding document
- QSPI driver for Tegra210/Tegra186/Tegra194
- Enables QSPI on Jetson Nano and Jetson Xavier NX.

Delta between patch versions:
[v5]:	Simplified implementation in Patch-0006

[v4]:	Updated dummy cycles implementation based on v3 feedback
	- Added dummy_data bit field int spi_transfer to indicate corresponding
	  transfer is dummy bytes transfer.
	- Updated Tegra QSPI transfer_one_message to identify dummy transfer and
	  to use HW supported dummy bytes transfer when dummy cycles are with in
	  Tegra QSPI supported max HW dummy cycles otherwise fallsback to transfer
	  dummy bytes from software.
	- Updated dt-bindings based on v3 feedback.

[v3]:	v2 has some mixed patches sent out accidentally.
	v3 sends proper patches with fixes mentioned in v2.

[v2]:	below v1 feedback
	- Added SPI_MASTER_USES_HW_DUMMY_CYCLES flag for controllers supporting
	  hardware dummy cycles and skips dummy bytes transfer from software for
	  these controllers.
	- Updated dt-binding doc with tx/rx tap delay properties.
	- Added qspi_out clock to dt-binding doc which will be used later with
	  ddr mode support.
	- All other v1 feedback on some cleanup.


Sowjanya Komatineni (9):
  dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
  dt-bindings: spi: Add Tegra Quad SPI device tree binding
  MAINTAINERS: Add Tegra Quad SPI driver section
  spi: tegra210-quad: Add support for Tegra210 QSPI controller
  spi: spi-mem: Mark dummy transfers by setting dummy_data bit
  spi: tegra210-quad: Add support for hardware dummy cycles transfer
  arm64: tegra: Enable QSPI on Jetson Nano
  arm64: tegra: Add QSPI nodes on Tegra194
  arm64: tegra: Enable QSPI on Jetson Xavier NX

 .../bindings/spi/nvidia,tegra210-quad.yaml         |  117 ++
 MAINTAINERS                                        |    8 +
 .../dts/nvidia/tegra194-p3509-0000+p3668-0000.dts  |   12 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   28 +
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   12 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |    5 +-
 drivers/spi/Kconfig                                |    9 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-mem.c                              |    1 +
 drivers/spi/spi-tegra210-quad.c                    | 1410 ++++++++++++++++++++
 include/dt-bindings/clock/tegra210-car.h           |    2 +-
 include/linux/spi/spi.h                            |    2 +
 12 files changed, 1604 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
 create mode 100644 drivers/spi/spi-tegra210-quad.c

-- 
2.7.4


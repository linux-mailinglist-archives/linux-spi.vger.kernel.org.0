Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15C2D80FC
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405507AbgLKVSN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:18:13 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7528 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390563AbgLKVQv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:16:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3e19a0000>; Fri, 11 Dec 2020 13:16:10 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:16:06 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 21:16:06 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/9] Add Tegra Quad SPI driver
Date:   Fri, 11 Dec 2020 13:15:54 -0800
Message-ID: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607721370; bh=AOxHAQ0PR5eFzlhWQAdtwTvwlFeD7C1CGjXlEdHoVJA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=AODVEh1nc+ZUWML7TfijaCbi3fYcBEaE+0HMyIBPkXJVvt4s42G9xgYlGb9PLEhqP
         kEJu+03z3/q9bnmOdYULSwXbJfxFRpv9oDiWsHw4YosT58beqJYJ/Cgz//LIsCgoey
         OjczNRyGGA4uuijKa4T5WuhgoxD/3jltVzikLOzakO0M17bAw2uTBzI32Ly7heL7FD
         4b9DQgNYU3oKJ7L0Z71SKcz957dZyXqVCMuabxAvZSHCyKIXurWL1S4Axj5nF7tGvb
         iq5LJeuhJGRVk2WbDGxPTqYGzQZN44zAUj/HZLbSVZ5SZ0MO8sa+il8KMN5e6wewLd
         6XMuaMHrrR+TQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds Tegra210, Tegra186, and Tegra194 Quad SPI driver and
enables Quad SPI on Jetson Nano and Jetson Xavier NX.

QSPI controller is available on Tegra210, Tegra186 and Tegra194.

Tegra186 and Tegra194 has additional feature of combined sequence mode
where command, address and data can all be transferred in a single transfer.

Combined sequence mode is useful with DMA mode transfer.

This series does not have combined sequence mode feature as Tegra186/Tegra194
GPCDMA driver is not upstreamed yet.

This series includes
- dt-binding document
- QSPI driver for Tegra210/Tegra186/Tegra194
- Enables QSPI on Jetson Nano and Jetson Xavier NX.

Delta between patch versions:
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
  spi: spi-mem: Allow masters to transfer dummy cycles directly by
    hardware
  spi: tegra210-quad: Add support for hardware dummy cycles
  arm64: tegra: Enable QSPI on Jetson Nano
  arm64: tegra: Add QSPI nodes on Tegra194
  arm64: tegra: Enable QSPI on Jetson Xavier NX

 .../bindings/spi/nvidia,tegra210-quad.yaml         |  130 ++
 MAINTAINERS                                        |    8 +
 .../dts/nvidia/tegra194-p3509-0000+p3668-0000.dts  |   12 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   24 +
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   12 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |    5 +-
 drivers/spi/Kconfig                                |    9 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-mem.c                              |   18 +-
 drivers/spi/spi-tegra210-quad.c                    | 1407 ++++++++++++++++++++
 include/dt-bindings/clock/tegra210-car.h           |    2 +-
 include/linux/spi/spi.h                            |    8 +
 12 files changed, 1626 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
 create mode 100644 drivers/spi/spi-tegra210-quad.c

-- 
2.7.4


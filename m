Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4732DD9F3
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 21:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbgLQU3i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 15:29:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8554 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731497AbgLQU3h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 15:29:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdbbf880001>; Thu, 17 Dec 2020 12:28:56 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 20:28:51 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Dec 2020 20:28:50 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/9] Add Tegra Quad SPI driver
Date:   Thu, 17 Dec 2020 12:28:38 -0800
Message-ID: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608236936; bh=befDSdcuvDJN3nr2CQS9a+ky9Zu8JNjG4riD267QvLw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=mx2u2dScoaTRbDCMhZ2x7gp/ov1UZyNiXZJa631UijJ4irnMlNeIdykUUcGOBmzGs
         I3+juyjzfU92B049sGxRr7L+WZuEtK8b4JzB9k5stpDs/Y8S3zyu1qQdzwCOLVrMwx
         hu6KXh22I9BBkHEzjoGQW/kx3AsWdSWzDGJ5McW4MA+2hfvaeQ4D34E2HiZ8gWJtiS
         gdPwYzc83dW5SfROIXf4CK0OqyZNHp7TCk+CYu7EXAmvEI4IVQnow3PqmnON+Hz+V/
         G3Gq80JKNjvfU5ChBclIOZ6Qr8sf/fYqBx702ibDj/+0QYxBG/1W3uOYBq50Wx46gP
         GnR7aXKOANBxg==
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
 drivers/spi/spi-tegra210-quad.c                    | 1421 ++++++++++++++++++++
 include/dt-bindings/clock/tegra210-car.h           |    2 +-
 include/linux/spi/spi.h                            |    2 +
 12 files changed, 1615 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
 create mode 100644 drivers/spi/spi-tegra210-quad.c

-- 
2.7.4


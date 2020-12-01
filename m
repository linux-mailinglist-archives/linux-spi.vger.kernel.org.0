Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6E2CAE1C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 22:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgLAVN3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 16:13:29 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6347 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgLAVN3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:13:29 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d10000>; Tue, 01 Dec 2020 13:12:49 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:48 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:47 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 0/7] Add Tegra QSPI driver
Date:   Tue, 1 Dec 2020 13:12:41 -0800
Message-ID: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857169; bh=w7tL6QnuzjoQfGsnhBR3YMrteB+mcNdxFdHtHsE02aU=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=izDY+QluDpDh7CRvSlNwYQG7tBCIlP5eqSTLeHHTWE8BETzNAH5ved2X2XaQPB+p+
         i+IzRYqj1MyREW4PCW+HeCpuJECJV8CxVb667bwK2ZPKWW9RACxDJSZQyW76rWPLsp
         qSDRWp0WhE8lUxVQwshoJIdSAaV158t63obDvGpM1ub6QHVBrfCI0PWuLVXNYIBMJr
         sz2HctDnSM4Bu93GF75YGUFPupSoJ3wQOneKUn2GyP5cZgb5pLJ2e0qs/ALH+awChE
         DDU5r7+ZVVNg/t3B9HGWhZYA28fpHZNFpIeFy7TbyDgdUK23dQj3XmzdZ+GWcbBax5
         xKVioGUYy8JHQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series adds Tegra210, Tegra186, and Tehra194 QSPI driver and
enables QSPI on Jetson Nano and Jetson Xavier NX.

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

Sowjanya Komatineni (7):
  MAINTAINERS: Add Tegra QSPI driver section
  dt-bindings: spi: Add Tegra QSPI device tree binding
  spi: qspi-tegra: Add support for Tegra210 QSPI controller
  spi: qspi-tegra: Add Tegra186 and Tegra194 QSPI compatibles
  arm64: tegra: Enable QSPI on Jetson Nano
  arm64: tegra: Add QSPI nodes on Tegra194
  arm64: tegra: Enable QSPI on Jetson Xavier NX

 .../devicetree/bindings/spi/nvidia,tegra-qspi.yaml |   77 ++
 MAINTAINERS                                        |    8 +
 .../dts/nvidia/tegra194-p3509-0000+p3668-0000.dts  |   12 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   26 +
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   12 +
 drivers/spi/Kconfig                                |    9 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/qspi-tegra.c                           | 1420 ++++++++++++++++++++
 8 files changed, 1565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
 create mode 100644 drivers/spi/qspi-tegra.c

-- 
2.7.4


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4692DDA14
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 21:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgLQUaS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 15:30:18 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8612 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbgLQUaS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 15:30:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdbbf8d0002>; Thu, 17 Dec 2020 12:29:01 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 20:28:57 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Dec 2020 20:28:56 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 7/9] arm64: tegra: Enable QSPI on Jetson Nano
Date:   Thu, 17 Dec 2020 12:28:45 -0800
Message-ID: <1608236927-28701-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608236941; bh=dLZyD/aBfvEKW6lFi53KiLDsTnSc0dbBTCqhpZ4bRhM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=MnnGmQ1IRJnR92GoLMv/00Gi+I1lyypBEqOWwwA9eRNWzZNx6ibj+EApBhkLRpVce
         GQHAyGh2chof4HalHhE0hm3NiaZ7O8ynigLva45LoMFjfPgR8Zso3cSFXaM50Ns2VY
         wduKg0o/H6NQG8ZswN9sCkrMAa6nYxDFZ6RLsoUfthVdn2rOSqZvgmJ9IChFjjHhjh
         sstw7SexM53chyxY1wbzuueecgbIz/BBxG7o7xgP0/DJ31hr6aAi/ofWaeEWSJy/Vj
         q8CCJhuGnhHqiiwpekxMx42ZwY6SsrJrXzR5NYQx/D8B6CBmNG2jSTu1uA5Mx6+zzY
         NK1l11iM6cEmg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch enables QSPI on Jetson Nano.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts | 12 ++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  5 +++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 6a877de..a1b4603 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -638,6 +638,18 @@
 		};
 	};
 
+	spi@70410000 {
+		status = "okay";
+
+		flash@0 {
+			compatible = "spi-nor";
+			reg = <0>;
+			spi-max-frequency = <104000000>;
+			spi-tx-bus-width = <2>;
+			spi-rx-bus-width = <2>;
+		};
+	};
+
 	clk32k_in: clock@0 {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 4fbf8c1..998fa81 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1536,8 +1536,9 @@
 		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&tegra_car TEGRA210_CLK_QSPI>;
-		clock-names = "qspi";
+		clocks = <&tegra_car TEGRA210_CLK_QSPI>,
+			 <&tegra_car TEGRA210_CLK_QSPI_PM>;
+		clock-names = "qspi", "qspi_out";
 		resets = <&tegra_car 211>;
 		reset-names = "qspi";
 		dmas = <&apbdma 5>, <&apbdma 5>;
-- 
2.7.4


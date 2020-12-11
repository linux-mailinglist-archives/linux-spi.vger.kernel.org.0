Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE02D80EA
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393298AbgLKVRH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:17:07 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7539 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391340AbgLKVQx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:16:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3e19c0001>; Fri, 11 Dec 2020 13:16:12 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:16:11 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 21:16:11 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 7/9] arm64: tegra: Enable QSPI on Jetson Nano
Date:   Fri, 11 Dec 2020 13:16:01 -0800
Message-ID: <1607721363-8879-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607721372; bh=dLZyD/aBfvEKW6lFi53KiLDsTnSc0dbBTCqhpZ4bRhM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=g8IwmmXIV46Z/pwJPK4kD/itu55lo2qgtZx16BoTxALicZuoKYm2n4Fccl0b2VBof
         QGrPoMJzsWu1LFRYUfhwLHJc5uppAgStyGCsBXy/qZIch14zYotPzSuCqYcj3JW8FA
         Ic6CJ5BlZ2Za+b1lu0RCjiJZf9Ns+B6VqoQI2N/M/MW7VGlluawzO1nBVQkUGT5Ak4
         NLQyhOBomOGSyjK48nNs2ChmKfQKgujU3v0d4BcLj9WVyRurz1tC41vfEKFh5CD6pm
         0WLcyzqMSg22Tpc7ja5kfnbf2O0L2Vm8eU7qqN5N+NwOf18OQ6cRBroiQIwVJ4dA2Q
         UnPk4Axh89jvA==
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


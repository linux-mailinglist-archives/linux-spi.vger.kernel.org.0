Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FDA2D7C0E
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393336AbgLKRDh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:03:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3775 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393276AbgLKRDG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 12:03:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3a5f20000>; Fri, 11 Dec 2020 09:01:38 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 17:01:37 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 17:01:37 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 8/9] arm64: tegra: Add QSPI nodes on Tegra194
Date:   Fri, 11 Dec 2020 09:01:27 -0800
Message-ID: <1607706088-1437-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607706098; bh=R3/lpNx2FBCJJOEkaUuhQtltDaXz/t9G5rIg9EkHXfo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=DFDQJc16X2hdV1REH8A7Bw7iss9+qDJrtBW71/oqtdYldMD+6kE7njjN3wWbQJZZ+
         tjLIlj8qBZrhoZb2nLRLBH7GH9Q2yCc2QqL8BuZnW7bIEWS8ipKerxXI4ylCTFkwJd
         35bnP4LCc3B36CCTXc4evH3Arkf9lfcXsF7O6Kc3cFIxP7QckGnsPrpenyTuFwVebQ
         RWmsZG8knXeLeOOPxZAi+AYJMJwBBTQ03hrTz1jpTxi4u7wEtPrRhYjuh2iNu0Afl5
         LQLaxyhNgaShXdhAIL/SDDp0TPqVBncvg38UHZO70GcvWLOhhuMhf4tuReZIdD0h/k
         XRQJ3orHVu2vg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra194 has 2 QSPI controllers.

This patch adds DT node for these 2 QSPI controllers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 25f36d6..63ed788 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -609,6 +609,30 @@
 			status = "disabled";
 		};
 
+		spi@3270000 {
+			compatible = "nvidia,tegra194-qspi";
+			reg = <0x3270000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_QSPI0>,
+				 <&bpmp TEGRA194_CLK_QSPI0_PM>;
+			clock-names = "qspi", "qspi_out";
+			resets = <&bpmp TEGRA194_RESET_QSPI0>;
+			reset-names = "qspi";
+			status = "disabled";
+		};
+
+		spi@3300000 {
+			compatible = "nvidia,tegra194-qspi";
+			reg = <0x3300000 0x1000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA194_CLK_QSPI1>,
+				 <&bpmp TEGRA194_CLK_QSPI1_PM>;
+			clock-names = "qspi", "qspi_out";
+			resets = <&bpmp TEGRA194_RESET_QSPI1>;
+			reset-names = "qspi";
+			status = "disabled";
+		};
+
 		pwm1: pwm@3280000 {
 			compatible = "nvidia,tegra194-pwm",
 				     "nvidia,tegra186-pwm";
-- 
2.7.4


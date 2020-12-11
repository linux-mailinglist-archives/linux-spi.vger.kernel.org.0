Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C382D80F5
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390750AbgLKVSI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:18:08 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7578 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395504AbgLKVRi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:17:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3e19d0000>; Fri, 11 Dec 2020 13:16:13 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:16:12 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 21:16:12 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 8/9] arm64: tegra: Add QSPI nodes on Tegra194
Date:   Fri, 11 Dec 2020 13:16:02 -0800
Message-ID: <1607721363-8879-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607721373; bh=R3/lpNx2FBCJJOEkaUuhQtltDaXz/t9G5rIg9EkHXfo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=I6mo7EvOnec7222zxGHgdupOxCkFMNWl3stexTVjqtpEZLZm0/fo7OCgxumvoJhML
         H30RyvLP1qJiEhY51SuB9Xx1TVPPvMRSqpq8ysNYhOgfTuEvmj5Of9/qiUMv/K0Do8
         9tBlUa9FVB8Ax4irDZefEdq68v8kCRLqWs58bcPlr4vtE0yCx1Nm5KTTBp9aJW4Uyn
         wCq9lnxmcI8sCcs1QI9QhLLyass76GedYI+FIkyZpLVTSVbTgvF0OvMPAGKBUpUfIz
         AOdaX+0ZwyUuYMuDZqA1LGo05JiHBW8uYVIKIYTpO9JENpKjW6CvdDL7qa/0lB42W7
         ze4sEbMRrkIkg==
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


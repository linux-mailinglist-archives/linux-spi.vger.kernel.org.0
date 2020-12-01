Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7559A2CAE34
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 22:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbgLAVNi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 16:13:38 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18564 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbgLAVNh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:13:37 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d80001>; Tue, 01 Dec 2020 13:12:56 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:56 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:55 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 6/7] arm64: tegra: Add QSPI nodes on Tegra194
Date:   Tue, 1 Dec 2020 13:12:47 -0800
Message-ID: <1606857168-5839-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857176; bh=/LwDXnkNLPEe531V5Sqrf/lH8PY9lQg/741ZNpJCXH4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Yi/D9w3Dnkqk9MeKEu1MrMSAWfIvaAZ8PGqR7TxE54g6O/nM1ed6sMSXhykLJrDa9
         mdOeVFoqnCillAVri7/4BBR0cBqlnDRKW5qV6djD3ZTtmnqrsNh/B2gGZw4OhlzjOh
         OoT3Ogin/2N7LutY4+VFOx4u/hECSLWoikiVyivAX8GE6HthgSFRdebF5ZhtFs+SJ7
         IHSpJD9rfr/UEO1mGKIUPrrKe/FnHa3WD8n5smyDe8CdSUDNg+teGTDJZNlOYcYhwO
         Ei76nBeXxwP9g2kDLs/9W+k734x5hQoA50JBqfN/RGwJUwYmJJVvxCk/f2g+LlEBiF
         slCrDbjoAiMyg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra194 has 2 QSPI controllers.

This patch adds DT node for these 2 QSPI controllers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 6946fb2..3049985 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -609,6 +609,32 @@
 			status = "disabled";
 		};
 
+		spi@3270000 {
+			compatible = "nvidia,tegra194-qspi";
+			reg = <0x3270000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_QSPI0>;
+			clock-names = "qspi";
+			resets = <&bpmp TEGRA194_RESET_QSPI0>;
+			reset-names = "qspi";
+			status = "disabled";
+		};
+
+		spi@3300000 {
+			compatible = "nvidia,tegra194-qspi";
+			reg = <0x3300000 0x1000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&bpmp TEGRA194_CLK_QSPI1>;
+			clock-names = "qspi";
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


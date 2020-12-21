Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD62E0201
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 22:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLUVTK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 16:19:10 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4593 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLUVTK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 16:19:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fe111010000>; Mon, 21 Dec 2020 13:17:53 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Dec
 2020 21:17:47 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 21 Dec 2020 21:17:47 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 9/9] arm64: tegra: Enable QSPI on Jetson Xavier NX
Date:   Mon, 21 Dec 2020 13:17:39 -0800
Message-ID: <1608585459-17250-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
References: <1608585459-17250-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608585473; bh=fYE2T8fmJsPLDmks8zJZ++XGgYTpkfOpRR13aXBCmGY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=eNuhBz9S9mFoJT2cwCzLkKczlk3QMj5TOpd4t6d1opXydUVVN3xvWTo4CsZMn7/Mc
         eiZ+Y6Ntr6sTlkR+otNFK71oFGCNQYPCXBVCJrP1V05ghhGLFb2fQhewQlkBX9PRZ/
         jEk65zA71Kofwj/oOD49rNT/JBnJFftqkhjKBr2YrrwKOddnS2aQiG8CpofXmI7f/0
         uYD/6f3b1QamGyUm98K8qxuZVHmmPGediI1/PsaPIC91CG6HseYRkQB4dVjHXaeMsC
         3dShSJIKICYtOSz9XqLTxJe78S0A1fkDknR3DM35QhcdV8jUseCThd6PE3kLlnb4zC
         mpv9U52DtFWGw==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch enables QSPI on Jetson Xavier NX.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts
index 7f97b34..f1053e7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts
@@ -100,6 +100,18 @@
 			phy-names = "usb2-1", "usb2-2", "usb3-2";
 		};
 
+		spi@3270000 {
+			status = "okay";
+
+			flash@0 {
+				compatible = "spi-nor";
+				reg = <0>;
+				spi-max-frequency = <102000000>;
+				spi-tx-bus-width = <4>;
+				spi-rx-bus-width = <4>;
+			};
+		};
+
 		pwm@32d0000 {
 			status = "okay";
 		};
-- 
2.7.4


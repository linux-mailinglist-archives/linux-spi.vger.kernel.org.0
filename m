Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2E2D7BFD
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbgLKRCe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:02:34 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2203 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392701AbgLKRC0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 12:02:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3a5f20001>; Fri, 11 Dec 2020 09:01:38 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 17:01:38 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 17:01:38 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 9/9] arm64: tegra: Enable QSPI on Jetson Xavier NX
Date:   Fri, 11 Dec 2020 09:01:28 -0800
Message-ID: <1607706088-1437-12-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607706098; bh=fYE2T8fmJsPLDmks8zJZ++XGgYTpkfOpRR13aXBCmGY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=TMkrJ1SHGFBOJW1U3hdc6oloIRFm/cFuvKdtFgdAikZaJMGv/vD7Z0u4V4uy7UFZ3
         7ZzRAe0GHffJs4Co3GnfpSgADq504ZJ4Nhwz0bVEQJrAhvuX3Waqjm5p3AUnCLQFoF
         Zf7CQepjrAxldkI9dDNh7cnupa6y0SzdoVH/EgCk+WzZpLFftI9/7kbJAZWuIHElIX
         MVw7HnadjU/lm8/aQq68/OHyCl2dqQpU79WsZNP7dFsjDX5wzqa0cE4MnHoRDpaznX
         dY8I6xecpZ+s4KlroxcRv/zRGjytIiufGEqpUPi0d/tZuBNABqNAkR/be8SWoCRMDs
         by+CC8pVvkBhQ==
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


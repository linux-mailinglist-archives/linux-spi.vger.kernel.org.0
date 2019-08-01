Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703E87D7DA
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfHAIkw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 04:40:52 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60360 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbfHAIko (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Aug 2019 04:40:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBC9C1A0306;
        Thu,  1 Aug 2019 10:40:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F4F41A029F;
        Thu,  1 Aug 2019 10:40:37 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 131D4402D7;
        Thu,  1 Aug 2019 16:40:31 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 2/3] arm64: dts: ls1088a: Add the DSPI controller node
Date:   Thu,  1 Aug 2019 16:31:04 +0800
Message-Id: <20190801083105.30102-2-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190801083105.30102-1-chuanhua.han@nxp.com>
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds the DSPI controller node for ls1088a boards.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index dacd8cf..fe8f1bd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -252,6 +252,19 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		dspi: spi@2100000 {
+			compatible = "fsl,ls1088a-dspi",
+						"fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 1>;
+			spi-num-chipselects = <6>;
+			status = "disabled";
+		};
+
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-- 
2.9.5


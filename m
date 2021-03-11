Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76966337D72
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCKTN1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:13:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42362 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCKTNB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:13:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCos3123972;
        Thu, 11 Mar 2021 13:12:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615489970;
        bh=O1hbhr2KTh0yRrzhm4nwwGvK8OQhgZuCTONHf0rb8Ag=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QfCzBFDoeuiSH69Phe/HCtElVibJmQm4ktfYSqvbFwlnuuDyahU5PIZ5g4Kn3uJt8
         nxoJQDBpFwNKikAze0vS84/DXyHWtPHfzRtg//cM/T7TxWWwGLMIxKVBmKeIgeyIu0
         4sEYRAqFlAW4koBwCmbmctPLqLOrJYPaFLVOpggc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BJCok6005602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 13:12:50 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 13:12:50 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 13:12:50 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BJCHvX080816;
        Thu, 11 Mar 2021 13:12:45 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [RFC PATCH 6/6] arm64: dts: ti: k3-j721e-som-p0: Enable PHY calibration
Date:   Fri, 12 Mar 2021 00:42:16 +0530
Message-ID: <20210311191216.7363-7-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210311191216.7363-1-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For running the flash in 8D-8D-8D mode at 166 MHz (controller ref clock
speed), PHY calibration procedure needs to run to calculate the proper
line delays.

To perform this calibration, the controller needs to know the location
of the pre-determined calibration pattern on the flash. Add a fixed
partition table that contains the calibration partition, along with the
rest of the partitions for the platform. Also add a nvmem cell that
points to the calibration partition.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

Based on patch
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210305153926.3479-2-p.yadav@ti.com/

 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 55 +++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 2fee2906183d..6013ebb45517 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -170,6 +170,8 @@ J721E_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* MCU_OSPI0_CSn0 */
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
+	nvmem-cells = <&ospi_calibration_data>;
+	nvmem-cell-names = "calibration";

 	flash@0{
 		compatible = "jedec,spi-nor";
@@ -184,6 +186,59 @@ flash@0{
 		cdns,read-delay = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partiiton@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x20000>;
+			};
+
+			partition@6a0000 {
+				label = "ospi.env.backup";
+				reg = <0x6a0000 0x20000>;
+			};
+
+			partition@0x6c0000 {
+				label = "ospi.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37e0000>;
+			};
+
+			calibration_partition: partition@3fe0000 {
+				compatible = "nvmem-cells";
+				label = "ospi.phypattern";
+				reg = <0x3fe0000 0x20000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				ospi_calibration_data: ospi-calibration-cell@0 {
+					reg = <0x0 0x80>;
+				};
+			};
+		};
 	};
 };

--
2.30.0


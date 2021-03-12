Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48E133857B
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 06:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhCLFle (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 00:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLFlE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 00:41:04 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A52C061574;
        Thu, 11 Mar 2021 21:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgCZuM7VRp8gYcgds34ysMQz+oa1an7Lk+JTgbjAmX48mTQs36VNSBlli56oylzu0wePGoeT8Psg5CyqlQUj4zUhrYYdYcGux84KBOuqGPflA8igz2jnOpnok4cjK7SuJmn76a1+sMBsq9HrJyVPvyt10qB60dhrKFSHpMG31r1D9FgfY84Zl0hfKThihg0jR2fXBWQFw4zmIX0idYx9Z5iQlTGCIsJ+SS3NxVzXBq01IaMRSFepybh4a0Fq7uy3HJkZdjnefwv8Sqp3EtyFQjFF1qEolW6a2/VJjFgZeBNJlpoR0ahpggsoxU3P9ozXLytLBN9MZXGvmr+LRxxfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+mWa8LTX/3NgucXgvlCM9V0ah1ruGT6OzkO4UIU28M=;
 b=UFOwurbQmdMh/KxRZVxwa9OY1EKZ9RSkj12sbCdQrnbZsKEG3C6G3JfDlNtLT5aJ/ck+mh6ZoI+3tk7CQG1/1Avg2CP96FqXQkgzAXysK1JEPgjVk881UT6R5/R77wIos6Ngcd5+FsKZQi+oemC9aCcIrtv4ph2yOxkW7+9+eYnbDknOl6/s+JpTzqfPMZHGftjwPvXjGhRB7LxFoUCSmvMzLl0OqIv+tz+pPhcAvvQe+wnG1fgZP5znS0AEzO5bVTlupab2xfU4q8s1exOfP/rquxG+vdxUgzY55gMmUtrK2dT/wsEq9ZVy/R52/mdj6ZrnZYbdpcETnrvXvnbOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+mWa8LTX/3NgucXgvlCM9V0ah1ruGT6OzkO4UIU28M=;
 b=SCPTzOUbI/y3+vKVHXTfoP5fEy8hwh2XPETBdb2ATb9HvEcf3Kl4id5D7QqkSEWTTAVi+rr7awkLuHgdjj7wOrkI4VGRksslweqqs7M3saHjGF58NilhYbjYqv8ESUw4JSsEEJ9g6iYceo8l/JOof9lqCrzshLTFV2gTQvfBV6s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB6683.eurprd04.prod.outlook.com (2603:10a6:10:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Fri, 12 Mar
 2021 05:41:00 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.042; Fri, 12 Mar 2021
 05:40:59 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] dt-bindings: spi: Convert Freescale QSPI binding to json schema
Date:   Fri, 12 Mar 2021 11:10:38 +0530
Message-Id: <20210312054038.3586706-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR0302CA0019.apcprd03.prod.outlook.com (2603:1096:202::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.9 via Frontend Transport; Fri, 12 Mar 2021 05:40:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 775db7c9-641d-4bbd-aded-08d8e5196a7c
X-MS-TrafficTypeDiagnostic: DB8PR04MB6683:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB66838733EEAACA7AB1241137E06F9@DB8PR04MB6683.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eILxLk8Qzkbt8L5jFjo4hPiZ1uRw3+kb4uwCVitEzHA9oYp9KyWGGQ3SuVMwngBPGFWEsFQWfHJds5yT7y4p62RMiORQIkPlBywBVllHQBpidsYjMIjMPANgY6KPTVo/chsoh8MzQcq0clUpRQQ628dtvDKCSVLZrwskx8wRyHx88i8nBm9XyFMwhYpXcWt304M6Y8RUMNIHx/wuJFI6iO2P6OBups5JaVMrriBv7sJJpGTJm/o2xDz3as34tn+QXhb95xbpPOlrBeDTCJiY/5MfqbsmiNo7B1xJGLRHUxzwlSVA9xn5g2/Y2pWc0t7+feXoBkJ+84CzkEmOKA0qGvG/OfNdL5fnksOfecJ+ICHiMRrjHybdG52W4RX5S/kRwP4H7Kx/zyv2EV9TMxqJTjpmhrRz0jnf8swWPXdKkvWEIQmjS++wcqn6TJmHt+7gUWfQP7oL6EwC0uuLveYrNNq3xrKTlBzmY/IZXeimDrhjpffgSPs23G5g7NZVAzGrs9gZXyI5jLDNda6665zOgDE35gPOVk5J15miaMaUf9Rqb/Rb6Dc2W5EDtb5gTTbSSk+eM+0q2z62f5uoR60GAaPZhAuI2COAseWNPzHdlm5v1uX2tHjrstLSuSJkjfH1Y5iWIlFKx18HRFjo0fh0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(2616005)(44832011)(6486002)(956004)(54906003)(966005)(16526019)(316002)(4326008)(8676002)(86362001)(55236004)(8936002)(26005)(2906002)(186003)(66556008)(66476007)(110136005)(1076003)(83380400001)(1006002)(66946007)(5660300002)(7696005)(52116002)(478600001)(36756003)(6666004)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C6gflLQR3XwjqDHNx860v4GodSyjiWGwfrVFw754zpM+Xu5rYrdqxmA5cFmX?=
 =?us-ascii?Q?K0m7B3qVBkkQkDVEvwKDJvhLqSnTph774J1Kpy0MfcQWvUees8SB0wIbShHE?=
 =?us-ascii?Q?jEUI/iMBLn2Nt7bRGHYXQ2AIavpCrf2rF660T1DpH652lOjENJEAO2BZ5YID?=
 =?us-ascii?Q?05/6OlUIpHjaNCemuzRClkdk27mrzm/gkxr0Rz+0ebzFonPR5YNgqTg3Ms2v?=
 =?us-ascii?Q?Tm09j1yudmb2qsCTJZDb3W9Ml7G4p/DPmlnyR9SwxdcQRkR+OS2fKpEu6bP+?=
 =?us-ascii?Q?yC7/v1pNOm5g/kUJhf48K3cBsaSn1OnquQavWojZKKjA9N3TBJDsDc2sxwzO?=
 =?us-ascii?Q?LzqCmhc+2enB2c897r/XgUIAY9wE2hSnEZriJtsI5itAdEng1TdwwiEcJ7Rf?=
 =?us-ascii?Q?Li6zm8lXOkE730ouViRBW86fcwy+63CEdzwgciRjl/phGhGZuYk/+NDBUCg5?=
 =?us-ascii?Q?DpV8Widjf7etP+jG2Shva1Ua1XGZKRiPkEugPiyNqFIWA6q6HydNI7KcOtbF?=
 =?us-ascii?Q?iIyHsLhHlYJ/Jyj3IWM+HZFofojSN9U7h4lO5d73xl1T4WRYdF8+6ceJ3/m9?=
 =?us-ascii?Q?79fm1uFevTomzhQQ1ElrB+47derfFzjXnRSEVmDIiUiy3ZSCg7lafm1jns2a?=
 =?us-ascii?Q?WxZdgmVy9XUG+0+da7IbvD/ejCk/tyQZRmGTqsmx9i9gCYSS1e7SKmG5KAzg?=
 =?us-ascii?Q?12BsSJ8jPBCfSwJnNpAb2PYj/TqIIxiQD6mhbY2p2LBeNfNiEhXPq0UNsQ6f?=
 =?us-ascii?Q?gwpEKxv4xYNPw1sLjL+7OyA0dkMdIpTifp6IsKTVsfhN6xmhU2sZ334v4Nfq?=
 =?us-ascii?Q?zEMb+c2pEKJP3pLvJw/NBPuYUFU6oviI31aVdSO5HDoXhvYYUwcRSjX2eLBQ?=
 =?us-ascii?Q?LIhykNCzdFucmv0GB2kDkf1zLs2lbXUgKf9KQsaijyrJ+o7YSIR96kevUkrU?=
 =?us-ascii?Q?P70wuFyNoVZGwi+gSrn/KxJjYWWmDrRlG10bIC6PDc6rXR9HopnulXhxD6Oq?=
 =?us-ascii?Q?9nvXJun1dlyPSFhwMvzlsBYBPJ9SUmqIMcVxOv353FjICjDiwQiYZhozo93z?=
 =?us-ascii?Q?IsZNzzYWKNF3Ix+7aLrVwWNyukgkrzDS71W08l+IgBc7Gg+0aIjJ94MYxAXu?=
 =?us-ascii?Q?uvCSaJXPYjnoVK+GDck1KAs+iYLCz2b1Z+s1kH8THc3Z1pjiYDFjvMCf9tpe?=
 =?us-ascii?Q?VKRN2e7q6eXOaaF91HGZa5rQikE1z3rvMdmSftxlcJb4PUe0fonnbmb+dWkK?=
 =?us-ascii?Q?MuskxZUSVGNa4mWHGgh80LF/doi1w0dZJnvkwcGDSp6VQ3dV6buMWjTVWJEy?=
 =?us-ascii?Q?M1lm4oZJ7BEAuP4zNNyHdmcZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775db7c9-641d-4bbd-aded-08d8e5196a7c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 05:40:59.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdhbJW80kFdg2FNGBjxTUm3p4Sev+qE1u8K03CmDnBQc1L4iqgae28YyErrEND7SPTsaelCTf6z1NUA/revJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6683
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the Freescale QSPI binding to DT schema format using json-schema.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 .../bindings/spi/fsl,spi-fsl-qspi.yaml        | 96 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-qspi.txt  | 66 -------------
 MAINTAINERS                                   |  1 +
 3 files changed, 97 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
new file mode 100644
index 000000000000..e58644558412
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Quad Serial Peripheral Interface (QuadSPI)
+
+maintainers:
+  - Han Xu <han.xu@nxp.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,vf610-qspi
+          - fsl,imx6sx-qspi
+          - fsl,imx7d-qspi
+          - fsl,imx6ul-qspi
+          - fsl,ls1021a-qspi
+          - fsl,ls2080a-qspi
+      - items:
+          - enum:
+              - fsl,ls1043a-qspi
+          - const: fsl,ls1021a-qspi
+      - items:
+          - enum:
+              - fsl,imx8mq-qspi
+          - const: fsl,imx7d-qspi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
+
+  reg-names:
+    items:
+      - const: QuadSPI
+      - const: QuadSPI-memory
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC SPI qspi_en clock
+      - description: SoC SPI qspi clock
+
+  clock-names:
+    items:
+      - const: qspi_en
+      - const: qspi
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@1550000 {
+            compatible = "fsl,ls1021a-qspi";
+            reg = <0x0 0x1550000 0x0 0x100000>,
+                  <0x0 0x40000000 0x0 0x10000000>;
+            reg-names = "QuadSPI", "QuadSPI-memory";
+            interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>,
+                     <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>;
+            clock-names = "qspi_en", "qspi";
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                reg = <0>;
+                spi-rx-bus-width = <4>;
+                spi-tx-bus-width = <4>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
deleted file mode 100644
index 69dc5d57b1ef..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-* Freescale Quad Serial Peripheral Interface(QuadSPI)
-
-Required properties:
-  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
-		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
-		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
-		 or
-		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
-  - reg : the first contains the register location and length,
-          the second contains the memory mapping address and length
-  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
-  - interrupts : Should contain the interrupt for the device
-  - clocks : The clocks needed by the QuadSPI controller
-  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
-
-Required SPI slave node properties:
-  - reg: There are two buses (A and B) with two chip selects each.
-	 This encodes to which bus and CS the flash is connected:
-		<0>: Bus A, CS 0
-		<1>: Bus A, CS 1
-		<2>: Bus B, CS 0
-		<3>: Bus B, CS 1
-
-Example:
-
-qspi0: quadspi@40044000 {
-	compatible = "fsl,vf610-qspi";
-	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
-	reg-names = "QuadSPI", "QuadSPI-memory";
-	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks VF610_CLK_QSPI0_EN>,
-		<&clks VF610_CLK_QSPI0>;
-	clock-names = "qspi_en", "qspi";
-
-	flash0: s25fl128s@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spansion,s25fl128s", "jedec,spi-nor";
-		spi-max-frequency = <50000000>;
-		reg = <0>;
-	};
-};
-
-Example showing the usage of two SPI NOR devices on bus A:
-
-&qspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi2>;
-	status = "okay";
-
-	flash0: n25q256a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a", "jedec,spi-nor";
-		spi-max-frequency = <29000000>;
-		reg = <0>;
-	};
-
-	flash1: n25q256a@1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a", "jedec,spi-nor";
-		spi-max-frequency = <29000000>;
-		reg = <1>;
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..23d02459a98d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7161,6 +7161,7 @@ FREESCALE QUAD SPI DRIVER
 M:	Han Xu <han.xu@nxp.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
 F:	drivers/spi/spi-fsl-qspi.c
 
 FREESCALE QUICC ENGINE LIBRARY
-- 
2.25.1


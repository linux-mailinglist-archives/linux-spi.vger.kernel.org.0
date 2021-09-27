Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90DF4192A4
	for <lists+linux-spi@lfdr.de>; Mon, 27 Sep 2021 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhI0LAW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Sep 2021 07:00:22 -0400
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:61371
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233848AbhI0LAV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Sep 2021 07:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGqWszhWpjFGWs3e+RivNPqQHJ0VatNYliK9u2vjmHSmnPZJXGwfNWwpPEvqwtvrzBIa8UJItjdHRpbaVnqIv1JBPT79dsZJKRwqxTL/Uv1E0k9o8xGS1h0x35EYoARaczqr8AFWVtQKu73oiDamJVLGRQ9VetJ4iF6Yv6dtRW1ZmJmwo8//fdb8QtA1w06S+M4ugtTSV4UdII7cDAXESMJ03bbZRmGtqL0uJC3Us2mFH5Yx5XbJ1ar/9WYdB60DyeNjeEIOslQGN5Ju/EMTXtSOvnYFAvhFrwTRPejK+2uq6IZHlQ1PQ6sH0LQD8D+/NSQQ5fuoa83C3cRSuTcmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wxtVSA8uOG+mxuIFMUbPEJS/LuOpH6DGVBNiveiJuTM=;
 b=h/yup6cJKO6dW9O6IHLQWfBhiYMHXnXXigGW09lKxIBzyIHEzYNdl8EZO6vgT3yIVe/6lUn4oHYd77l7vrkItXg2LzU1bOu1SwGYT2i1UsT6o1jOAr2w4BsmxpC0/uyqasKWosio937+0lyl9uMfDc0m4E9ueqDNAGOihl/pWiqCyWA5MZ8msiitkK89RQ3Q4t+vKHUcq/Joh/Ont5pHTDMNIdOirHyZhk5j84IjzO3ynCvRDmwN7yjiCy0VykN7LCnTJvS/tBk5vMUQgzK6i2G2b29puo4+MvjjQGM5m/j9iQ/W+Ww54AQM/yQ/UekRSCntXWDZqCmWB0mHOHSUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxtVSA8uOG+mxuIFMUbPEJS/LuOpH6DGVBNiveiJuTM=;
 b=MwS78gHvisWwdjrQxNUJRoPQileALqsI9QsnoO6CuMmwpc7vGtzOVcDyD4Ijr68QXlqmJazfjstk+wsn4LBKnqflNjkAY3gTxi867BU/a9tw2gXdsWiDbcncaS3dyBu9BcwCLC8u+EJRj3cI+df0sduLO61aH5zVbDH8GvVKGcc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9)
 by AS8PR04MB8722.eurprd04.prod.outlook.com (2603:10a6:20b:429::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 27 Sep
 2021 10:58:42 +0000
Received: from AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::48d1:38c:9eb0:823d]) by AS8PR04MB8673.eurprd04.prod.outlook.com
 ([fe80::48d1:38c:9eb0:823d%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 10:58:41 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [Patch v2] dt-bindings: spi: Convert NXP flexspi to json schema
Date:   Mon, 27 Sep 2021 16:28:17 +0530
Message-Id: <20210927105818.445675-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To AS8PR04MB8673.eurprd04.prod.outlook.com
 (2603:10a6:20b:428::9)
MIME-Version: 1.0
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by SG2PR02CA0064.apcprd02.prod.outlook.com (2603:1096:4:54::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Mon, 27 Sep 2021 10:58:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4bdec53-4510-4a1a-ffad-08d981a5c490
X-MS-TrafficTypeDiagnostic: AS8PR04MB8722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB87223E26783C940C6DDE2FE6E0A79@AS8PR04MB8722.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrLyDeKBi5g/le7sp4GBnnBnCpSc9qt1m/XdBCWGvSspI2O1CE3WQMWKwgDlqFs7hgHIvlQl213u/82pFnywkNxPLHlwaxF6Z8kX8cdU/7sC5YBLCfXTju7FimVPa9onm8Egbyde616/wkQEFTmyeVy9zTyyQTLThfOc8t90UtvuRtgqSVGRcJBkiSkViwH6Mt603sVL/cBSdHqfGzkvRe+0USbUF+U+rCeN9UlFC7L/9nvrf5zLUejVTXs+BKOJM6gI4JGpBZZl5lgkzkdftPQk7NRby6FhNg7oNf3XvlUw2r1fDwU+lCx5b86I4IOeyXQpLNgi043wp03MR+ndQYBi1iDKmgoqCnNSK7Q+p0DS4RudMAXFFIhYWKUGhExBiagwpn/vd6uKHITqAD9h6WrWJ7xJ/wbS+GOZHJxTtD0hFKKRFCyTYOoMAjqjPrwR5vBAN9eDLsstWhz3cpE3u5B2MjbBO+cwmgbJQRyl/iiQNx+Lv8Oo326XAl+nu47YC2PyWPjYuqtL+6VqyhdNlGFujykcp+JVV7nF79UbcUqY48QVJRIhmqN8JQ8OS1BnDOZbcOKbX0H/pszq5OjZQZlqlA0kTBeH2rvZ7b1ltUER6j2/KCBL/Lc3IyKrP0/F04DGUsu8h2jYU4W9sbc8LvQCx+S9JQF26JVXO+Eew/pg1K0VdNiXcene5Vp91LccKRuGlvhEmSde2JENuVO7+KD8qNXloxAvpGPxrFCbi9dM22kHxXAK+YCpmSRnYNyDkdduyyMAOfXkkCUx9Lis/IEShg0AAb41z+q0kKlMsHRgo/dzRw3xo9SWJvPA40Q1frhrJdKMcwfb93WqL58AV4BAyQQThKN5Hfip+ETxts0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1006002)(316002)(36756003)(4326008)(2906002)(956004)(2616005)(38100700002)(38350700002)(6666004)(8676002)(1076003)(54906003)(8936002)(44832011)(6486002)(66946007)(26005)(186003)(86362001)(508600001)(966005)(5660300002)(66556008)(66476007)(52116002)(7696005)(83380400001)(55236004)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2J4IOYehFZkHqDAiBAjiB7y63o2D4B0I0I5WhitUrQDQ5e6eSa7ptfxXU9G+?=
 =?us-ascii?Q?+8gLsJTpnhUQuVQMEkr54cBsLwmiYlGlz2DQonbbuBi21iXetyhcQlEu31RK?=
 =?us-ascii?Q?tcmwbNtORKWnyAFQmCABfSkTnXpm9bh/IZu98DZArbvzPsKrcVZwm3opYoG7?=
 =?us-ascii?Q?4TLTl6aw8rKOTwZyrNukqKOgyL5tN69sd8IcqiNw5myZZYZ/HXjj1uTUxAVl?=
 =?us-ascii?Q?eFd64eeKyAVeYCjeTBCK93hrtw5ONG06OaPnKK2LPrn3KZwCFB5x7sbp3+/l?=
 =?us-ascii?Q?XzaXdpaCb0keM+4tjr+AZmkNLliNhupajK9t+BO0Am+3lX9bEkEkv7YC+uYz?=
 =?us-ascii?Q?CJ07vl1AdqrFSb/z2971iADPdEVCy9YpURZfvbBBxkv911wFVw4yLvS0jgjk?=
 =?us-ascii?Q?QDf8O/TB0FiNq/U1gtk71XbEx5ewL/uC8bSLN/eWam9yanbclYYGD8IrDxqT?=
 =?us-ascii?Q?yOfokQiLVgU6ePlj15Y5A7Tfgm6u6YrDF+wvwOvwPiF3dUHMakI/2cdNrhSp?=
 =?us-ascii?Q?LiyFgeuOA8woHaxbKzIRh5cMMZC+jV0/SSyOKDXiwXhE0F6R5y4Z/qOM+OC9?=
 =?us-ascii?Q?QphXMwDcolXTNk76ZQgr7gdDd3arMEo8EqSjio+C+84uEVbi1McEOC3aWSok?=
 =?us-ascii?Q?EukHf37QHrOf7HaXqvIeCzcP2xHqoYa+9S1eppniIa5Hq/OqJHGqIkgVtdBx?=
 =?us-ascii?Q?nMpNGbSKrfyPBWS8EcCE7tDfPRgZwZg4QV0aXieXzDlydpJhLjUbPvbXGmrA?=
 =?us-ascii?Q?XKfy2VsP8n7yTJbf34vT2hcHekFO4UddSBqeNWmUPsHTGORIAZD2dIL9V/wP?=
 =?us-ascii?Q?RMVgtn5FlZ8SJBpUT5S7oBza6VjOpi14K5eCK//Qg/NUG+T/MIDxX2GF/eBY?=
 =?us-ascii?Q?mNdRk9M+Ng21HQJbgd4YTPSC67knmNgOZva5HYvrbOb2EDxZT8LmGKOqx4IJ?=
 =?us-ascii?Q?KsEy7COLI82EAT6lcwlPhWKMseStVq1/mmX9Ibw0fQ0G/ov4w6lEmHJrpg1J?=
 =?us-ascii?Q?OjjtDj2Ub6y9pT/LUroTlIB5GnFBcCP7GssoN99IFTc68InS9bl95t7B7ZMb?=
 =?us-ascii?Q?fT4YAHgZuEgY4uXUs1bcrCvf73BFA5LbXNo8O8Bam3IPzJ/6MjTpqKqa2Rmb?=
 =?us-ascii?Q?pkmd5jzTa5fULbydO4o+vEazd2Sv6WeowPRuSP93IkzMSipvw0s3RJehPOFM?=
 =?us-ascii?Q?rUzvoCJ3ivMs7/JrUYayyfnKLXTGRbMDc4QvCTSccMVgUicZlzFqolLvGHoO?=
 =?us-ascii?Q?QUE/U/MOKP0YDGkFqnFcCod8YU+7jEb70n4RCk8UPPm6JFkXIAoyN8GW7wqh?=
 =?us-ascii?Q?NIp8mI3HALSFlKo9ki58fe6p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bdec53-4510-4a1a-ffad-08d981a5c490
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 10:58:41.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gdn5kocmng1t1Qs2sJ9kHRSGiPKiWQhfGQ69watJwD1vqIvRs6DG1IsOo3c6hfkjaCn0qB4fOENQ2/A0S9FuPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8722
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the NXP FlexSPI binding to DT schema format using json-schema.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Hi Rob,
This patch update description of reg-names and clocks for easy
understanding. Apart from that there's no other functional change,
that's why I didn't remove your reviewed-by tag.
I have compiled and checked the bindings with dt_binding_check and
dtbs_check and found 1 warning for which I have sent fix and has been
applied by Shawn.
https://lore.kernel.org/all/20210908065126.1273140-1-kuldeep.singh@nxp.com/

v2:
- Update description of reg-names and clocks. No other change
- Rename file to spi-nxp-fspi.yaml to align with other spi-*.yaml files
- Rebase to top of tree
v1:
- https://lore.kernel.org/all/20210428102417.1936520-1-kuldeep.singh@nxp.com/

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 44 ----------
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml | 86 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 87 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
deleted file mode 100644
index 8f34a7c7d8b8..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-* NXP Flex Serial Peripheral Interface (FSPI)
-
-Required properties:
-  - compatible : Should be "nxp,lx2160a-fspi"
-			    "nxp,imx8qxp-fspi"
-			    "nxp,imx8mm-fspi"
-			    "nxp,imx8mp-fspi"
-			    "nxp,imx8dxl-fspi"
-
-  - reg :        First contains the register location and length,
-                 Second contains the memory mapping address and length
-  - reg-names :  Should contain the resource reg names:
-	         - fspi_base: configuration register address space
-                 - fspi_mmap: memory mapped address space
-  - interrupts : Should contain the interrupt for the device
-
-Required SPI slave node properties:
-  - reg :        There are two buses (A and B) with two chip selects each.
-                 This encodes to which bus and CS the flash is connected:
-                 - <0>: Bus A, CS 0
-                 - <1>: Bus A, CS 1
-                 - <2>: Bus B, CS 0
-                 - <3>: Bus B, CS 1
-
-Example showing the usage of two SPI NOR slave devices on bus A:
-
-fspi0: spi@20c0000 {
-	compatible = "nxp,lx2160a-fspi";
-	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
-	reg-names = "fspi_base", "fspi_mmap";
-	interrupts = <0 25 0x4>; /* Level high type */
-	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
-	clock-names = "fspi_en", "fspi";
-
-	mt35xu512aba0: flash@0 {
-		reg = <0>;
-		....
-	};
-
-	mt35xu512aba1: flash@1 {
-		reg = <1>;
-		....
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
new file mode 100644
index 000000000000..283815d59e85
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-nxp-fspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Flex Serial Peripheral Interface (FSPI)
+
+maintainers:
+  - Kuldeep Singh <kuldeep.singh@nxp.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nxp,imx8dxl-fspi
+      - nxp,imx8mm-fspi
+      - nxp,imx8mp-fspi
+      - nxp,imx8qxp-fspi
+      - nxp,lx2160a-fspi
+
+  reg:
+    items:
+      - description: registers address space
+      - description: memory mapped address space
+
+  reg-names:
+    items:
+      - const: fspi_base
+      - const: fspi_mmap
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI bus clock
+      - description: SPI serial clock
+
+  clock-names:
+    items:
+      - const: fspi_en
+      - const: fspi
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
+        spi@20c0000 {
+            compatible = "nxp,lx2160a-fspi";
+            reg = <0x0 0x20c0000 0x0 0x100000>,
+                  <0x0 0x20000000 0x0 0x10000000>;
+            reg-names = "fspi_base", "fspi_mmap";
+            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(4)>,
+                     <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(4)>;
+            clock-names = "fspi_en", "fspi";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                reg = <0>;
+                spi-rx-bus-width = <8>;
+                spi-tx-bus-width = <8>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..e11d61ea67de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13437,7 +13437,7 @@ M:	Ashish Kumar <ashish.kumar@nxp.com>
 R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
 
 NXP FXAS21002C DRIVER
-- 
2.25.1


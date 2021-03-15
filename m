Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6833B257
	for <lists+linux-spi@lfdr.de>; Mon, 15 Mar 2021 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhCOMQG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Mar 2021 08:16:06 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:12209
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229523AbhCOMPn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Mar 2021 08:15:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as+ik4wuxWgAHpbFshxVg+kWH5U6odpuPnHykzCx6jxuTG5sAA54rYr5clXgAlst4lioLvxPtjZ8IcPIq57SLm/mILnhUM8PKbg2FOYYp8gNnh/CxujdGq0kzuZFOIyCWgEXftixDUEjLfTTeFc8Yqu5ZUVI/tXeL7VhZYejQ82ZyRkjObQDD0O9ACYPYlE8Ps/poAZQy3dFZv6WbeXXLw68L8hE3TjHwmQ/75ZHCNbNECNI8Gzg6O7UiK3ZBPhi8ZbNQaWJyqWk2m3PEoOz3mgMh2gSpMna7vlMVY32QOZl+LVmQOy8j95Q30hmJsv+ZNipkWnyI+M26IENmn/u5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlMm00AkQ1vWVRYP6cE6N8OhwryhEH0WBQ3WYJyf+f8=;
 b=S5xG3EJL9owQINSOvix27PeW0Oe+40oblD4ZxGmOgm228FQJZwzqRYxejywttrOZfq8dNX5jE90HjdKHH27NuTnvx161Qy7JuvMuREQEdAwriFRyq0mXSTQRJItlgx2HvK1oNbDpaiUn4OToyRBA/GPMydNX5nCp0MeChVkSdO8up2pBTDUcZ8zGpbpIMYmnqh/eL41Bd/teMAzhr1r7Bjl8ezzkX/1B7uT7ajg/e6iOichHL/nBaTp/pjJo2sXkx21IzEnGkjY/kJ69TDhmdf1Xgx/cS/fz1sb2UOTSrJMgAmKh5O1shKyAIVpNMwafV0AgcBpocAoIalYgRzfd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlMm00AkQ1vWVRYP6cE6N8OhwryhEH0WBQ3WYJyf+f8=;
 b=Azlk7uaT5/MwI9umrTgdNK+fPd+LZnh6VLWR8KbynSDnK6UVqLKXQyrbULYCetnZkzukUS0rNq0AMv9gR8h5JI722dJjgC6QpiXyawQoAcIqZX89v8spQ2Nvry+J1MITF3csd+DXlB3jRKE1k64kZpk4H5UC32zdyKqOUL0stoo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 12:15:39 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 12:15:39 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Date:   Mon, 15 Mar 2021 17:45:18 +0530
Message-Id: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR04CA0059.apcprd04.prod.outlook.com (2603:1096:202:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 12:15:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0d12724-722f-4072-3d4a-08d8e7ac0bf3
X-MS-TrafficTypeDiagnostic: DB8PR04MB7180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB718095DA86AE9204E4FC4DFEE06C9@DB8PR04MB7180.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2D4cu4EsOUv8zbTO6LSrgWBKvTle4UVaBIOtbbr0cjCC++xY+RricR7FbxBkrmv0ZD+a0aKlZxYYoK9b6gce1EL0VYQd0ERiGowNfXLLUT5JlWgT3LHy9h57OrJzbzy/KYnm+GMLztw8ij6s9tslcAjSZpSafr2On8+FjEDhIcvrcN5eWUKaMKvE/75XgZ0KU8fA9LOs+3+3HwBClK3EFQ64SF9oWevgZRCOb4rujLBpQYo8O5SvhTWsMkwUd/At8FhcP1rlbFSCaDFFGxCgZKAvia33Eu5b9zClX7m+GPQCXDA560uBb5GXIEitlIH+Gb+sn+aJTBArULNyIMAcPwj/ssctssKncWqLL4+luqF0tRuWA6Nbp3gelDuM9kbZNLE3X4Ei/oRp7Pt1nPolorXn+3BSyR01Y/jf9RciLIQrwbYSacepYnR7F7YbfRxQDWNg04d5++eH8dXYEPtFZxRA6cKvG/XK5a585uhRYpndHRvXGpYzSNwV/H2J5Yo1vXNHwVQ173pxjvlaW1e4+tFkakrOPqiJWXwhjTnLSguE9yttqjUo9fnonU4eIdgStcwPv8EXlwy+rHK59exjWhiy/KqEkSKQCUNbKb2klSGZu7c1xeHKJlHs0cbWaCGkTzWaKnZv7m2Z/39Fqy/KnaxRCfgHgl9nGlNeeRF1k5PQQ6BYRtQ+NWY1tchURV0l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(966005)(36756003)(52116002)(7696005)(8936002)(478600001)(44832011)(8676002)(1076003)(956004)(55236004)(86362001)(1006002)(4326008)(54906003)(2906002)(2616005)(66946007)(5660300002)(66476007)(66556008)(316002)(186003)(6666004)(83380400001)(16526019)(6486002)(26005)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l5dVHOuaRjfeU9gozM+hd9wThpLEg/rBkjrF1inG3nYc5XdFR67ZkbOhrb89?=
 =?us-ascii?Q?CvybMfrpaKZaUxdGogZmxIIL4WQJcy88guJLi+BO+18omUzsJ8NvuRi6/tVD?=
 =?us-ascii?Q?Gf6JKkEFofseongKGa3GeZe+WAsO5D/GKgWPsuftGAsn2567LSVBtYaYltjQ?=
 =?us-ascii?Q?yEPM9sDS7OeTLLemsR+PGRN1q1odA9v4uSPC9kl7NJr29rfYGsPngHLZBs/n?=
 =?us-ascii?Q?k9bI4+dXpC3Xrw+ZOGH2etDjR2iZ09xNRmE6MQflGQPqiId56hECT1h+NqvF?=
 =?us-ascii?Q?ID5knS3gI9TnYwlBwIbaWszcwuZK9jsGBFlwT40VRylm+eZde2FBePhUn6lp?=
 =?us-ascii?Q?TI7ZDDHMNdsJ4+nPpr3dAjnWdHgD+DY5jPvTMavSvFhNnR+fHEfjDKaEtaFI?=
 =?us-ascii?Q?yD1yP9gzPcXWsNwBiO2mvZX0VbE8l5C2p6TbD25Q7F3AX7i2pYmMOmM6m8r8?=
 =?us-ascii?Q?MQhx5+IZIRmPNtWAaJwwaiWmCuFvxUqpN6KaJHBR0km6LYUMPyuju+xT8vK4?=
 =?us-ascii?Q?9ikp46vfd2we5Hxg3phGf/SriVRsGOJQ2pC8pjEVRMoyPAal8R9pkWapTPWZ?=
 =?us-ascii?Q?a3ybDuksgjbM007dSGjhnKk2GYvRvJJdIsXchGxRsfUZX3FazOgIYt09SkLD?=
 =?us-ascii?Q?9AgWlkUdkCSYadbU2ORtLBQbUD/Q4tSQwibSmXDlcctEuFq/k0D4STQ5O3Hv?=
 =?us-ascii?Q?JBQVlTVOAj6Tipm4L9hraTKPSAQPSpYnRdIWYvxyTTRQ8r2O6UrTDCVfzEtq?=
 =?us-ascii?Q?gjcQ38T7akLe5/+irH998ZiNQXArkHTZ7+3M2yyftC9P5CJUv1+x2YVOE+il?=
 =?us-ascii?Q?4ERGJRVRBMa8EyXfP1h/FpgUmE/itITRJuaO/ob2Ij5bR0NKM1aRdi5xDjrS?=
 =?us-ascii?Q?Ef7rzt5Oi7btxMYv1j5uoff0JMjyCm17+G7NQWpsLIL3nCGIR4mm+tLJxb/g?=
 =?us-ascii?Q?NrN03+SGy1szWexqDw4QmVRtB099EvGdyPc6/eox967nSoi+/QdpOFrAvihn?=
 =?us-ascii?Q?bYmUPfBaFMoTgWsepw7M0J1zbYTLZ9OmHERa79A2jUQvlfkQNv/hQ2UzQgUK?=
 =?us-ascii?Q?UzzdIM1TXlvMjD8rV4aAm/2qU70ss3zDg2zOZObLK+LvMy8B+0xVsAHQURvR?=
 =?us-ascii?Q?6AOtYZ5tFaDc0B2H06HME1ZF+VS2wmkk/Q+afFADCiNItFD9AyyRW7POQthp?=
 =?us-ascii?Q?8RMd5lrZpgSJyMWlG8XJzvuZ8abK1ehqhxFx7ft5e5EI5s/cXWDoquQGiDR8?=
 =?us-ascii?Q?ZoZU/rpvqKciPGu+D2f365DImqWImBvC98u/AH/00/VXPIh1SD3xjzMRI3UH?=
 =?us-ascii?Q?IZgrJQHSdaY4cfJnn4slwwii?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d12724-722f-4072-3d4a-08d8e7ac0bf3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:15:39.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyPuLWaWVR+rnYjpbuQybw2ThHSBFaxzrkEHZHW5SChex7bQIZybkWME1KH6m4bIOfvpkCRaEx9FDEEqZ3wM6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the Freescale DSPI binding to DT schema format using json-schema.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
Hi Rob,
This patch is checked with following commands with no warnings observed.
make distclean; make allmodconfig;
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml;
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml

 .../bindings/spi/fsl,spi-fsl-dspi.yaml        | 131 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ---------
 MAINTAINERS                                   |   2 +-
 3 files changed, 132 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
new file mode 100644
index 000000000000..15ffc83bdba6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale DSPI Controller
+
+maintainers:
+  - Vladimir Oltean <olteanv@gmail.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,vf610-dspi
+          - fsl,ls1021a-v1.0-dspi
+          - fsl,ls1028a-dspi
+          - fsl,ls2085a-dspi
+          - fsl,lx2160a-dspi
+      - items:
+          - enum:
+              - fsl,ls1012a-dspi
+              - fsl,ls1028a-dspi
+              - fsl,ls1043a-dspi
+              - fsl,ls1046a-dspi
+              - fsl,ls1088a-dspi
+          - const: fsl,ls1021a-v1.0-dspi
+      - items:
+          - enum:
+              - fsl,ls2080a-dspi
+              - fsl,lx2160a-dspi
+          - const: fsl,ls2085a-dspi
+
+  reg:
+    maxItems: 1
+    description: Offset and length of registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC dspi clock
+
+  clock-names:
+    items:
+      - const: dspi
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+    description:
+      Names for the pin configuration must be "default"
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  spi-num-chipselects:
+    maxItems: 1
+    description: Number of the chipselect signals
+
+  bus-num:
+    items:
+      - description: Slave chip chipselect signal number
+
+patternProperties:
+  "@[0-9a-f]+":
+    type: object
+
+    properties:
+      fsl,spi-cs-sck-delay:
+        description:
+          Delay in nanoseconds between activating chip select and the start of
+          clock signal, at the start of a transfer.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      fsl,spi-sck-cs-delay:
+        description:
+          Delay in nanoseconds between stopping the clock signal and
+          deactivating chip select, at the end of a transfer.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - spi-num-chipselects
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@2100000 {
+            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x0 0x2100000 0x0 0x10000>;
+            interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+            clock-names = "dspi";
+            clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>;
+            dmas = <&edma0 0 62>, <&edma0 0 60>;
+            dma-names = "tx", "rx";
+            spi-num-chipselects = <4>;
+            little-endian;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <10000000>;
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
deleted file mode 100644
index 30a79da9c039..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-ARM Freescale DSPI controller
-
-Required properties:
-- compatible : must be one of:
-	"fsl,vf610-dspi",
-	"fsl,ls1021a-v1.0-dspi",
-	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1028a-dspi",
-	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
-	"fsl,ls2085a-dspi",
-	"fsl,lx2160a-dspi",
-- reg : Offset and length of the register set for the device
-- interrupts : Should contain SPI controller interrupt
-- clocks: from common clock binding: handle to dspi clock.
-- clock-names: from common clock binding: Shall be "dspi".
-- pinctrl-0: pin control group to be used for this controller.
-- pinctrl-names: must contain a "default" entry.
-- spi-num-chipselects : the number of the chipselect signals.
-
-Optional property:
-- big-endian: If present the dspi device's registers are implemented
-  in big endian mode.
-- bus-num : the slave chip chipselect signal number.
-
-Optional SPI slave node properties:
-- fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
-  select and the start of clock signal, at the start of a transfer.
-- fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
-  signal and deactivating chip select, at the end of a transfer.
-
-Example:
-
-dspi0@4002c000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,vf610-dspi";
-	reg = <0x4002c000 0x1000>;
-	interrupts = <0 67 0x04>;
-	clocks = <&clks VF610_CLK_DSPI0>;
-	clock-names = "dspi";
-	spi-num-chipselects = <5>;
-	bus-num = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_dspi0_1>;
-	big-endian;
-
-	sflash: at26df081a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "atmel,at26df081a";
-		spi-max-frequency = <16000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-		linux,modalias = "m25p80";
-		modal = "at26df081a";
-		fsl,spi-cs-sck-delay = <100>;
-		fsl,spi-sck-cs-delay = <50>;
-	};
-};
-
-
diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..e2c5b7367db9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7060,7 +7060,7 @@ FREESCALE DSPI DRIVER
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
 F:	drivers/spi/spi-fsl-dspi.c
 F:	include/linux/spi/spi-fsl-dspi.h
 
-- 
2.17.1


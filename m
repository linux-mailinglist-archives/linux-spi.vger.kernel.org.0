Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031B6332326
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCIKgE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 05:36:04 -0500
Received: from mail-eopbgr30089.outbound.protection.outlook.com ([40.107.3.89]:28406
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230436AbhCIKfz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Mar 2021 05:35:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG55KxtXiwbsUkRyMEol9Pz6DDxiClv+8Ekao0XTq+kwvUCNgzY7rXE1NoFds/YrFo2RU3WTgHxirOhCCkzIjls4JiKJDsl9yKbgabNvq9068PuQg6yCz88aFPFOlbRHhIFxuVglPqPZcNZexZ0d/igpXDkcYG9W53bBGgX8078JQNOvf+mSdUGwEqwcx1dftkrMrt1d9p0WVZ5oI2teCRmS6BU2uE9rI9duaVNXvBPfEvhNGgBAoGR3KFvXdhEHpHQzP1ZBrEoQ/UAIGb8ghsLzBQigLUz/9dCDRlAbMgXD3VTM1iKnHL1xhR+NtUrrQL1tK1OeTH6lTCFOQGw8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgdImo7raeJf9HrCKuQ+i0aYH06nQjpDY7Jqc4JgBuw=;
 b=hAKgS+kB//bBggv5R8/iw0u+uQIGNC7p+5msWhpCr96XRJVmkqp05K1EGNzLuWiefEpKJpbZBeIFajdbQjFUKNHoCC0Xqy+CCzpDtayREqx/OXfspfvLks2lgVzcz3otIlzhFqZWTT0uk7HnvVyY15CKRWGV7thWEOJNmi6tNR8MVS93XgZt65miIsg3GNONnkodoq7kUHQj0IKbmLNEbykA/jAK878spUQlS+4ce8Ur25+nPgJMI9yLFJ25Zt6kbtxLzrBO8Hwz2GJD8u0onSBnSC8NXUxbRIu5yQZSqpTnWNOBNuEj5VRhYapbNN34kONn7UVKy6Jax2p4XOXDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgdImo7raeJf9HrCKuQ+i0aYH06nQjpDY7Jqc4JgBuw=;
 b=VXy/oBDtHI62/MMAmjY7F/7mz/e/BQfzk9MepvJGkCJxumDiW1Bg6A1vqnMrLWgwG+NEZn6Ink7nXopK3iZs1xXu35yzkEH+Ve4j0dza4JqsEz4MsVvM99+W7lEAZb0htLhnAMl2ZZNMr750gz9g4ZgKrI8p8VdwMp8N/1UGO1Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 10:35:52 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.037; Tue, 9 Mar 2021
 10:35:52 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] dt-bindings: spi: Convert NXP flexspi to json schema
Date:   Tue,  9 Mar 2021 16:05:28 +0530
Message-Id: <20210309103528.3538910-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR02CA0201.apcprd02.prod.outlook.com
 (2603:1096:201:20::13) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR02CA0201.apcprd02.prod.outlook.com (2603:1096:201:20::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 10:35:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e16f3fe5-1ca1-4c81-fc82-08d8e2e71d00
X-MS-TrafficTypeDiagnostic: DB8PR04MB6860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB686007FC478B4AD84BC6A066E0929@DB8PR04MB6860.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maeEDxr2ambRu/XQPRLaTlaVUwvW56+5pUYsRQSjuXeDDERZOxIL/av9aiV0pjUcxmzppWcscNDkyzVriRsCGso5muPHIzguqvE4rr/+BhBbQmy4paMnLsIZaeml7/4gZGZ+HZkGsU6xEibODytA6ik3BuyhqgebIH+miRi536912tJh051rXH1TLlUPXeO0019OZdEsw19CTaDIRf21kZeKQTKIu3tqRsgN8mQV3t0ye2+lkda08K/dhGyuhw2XOdfxVHSz+0iDp9x/N3uwlT02ZRO+wh6wr1cjtYg34CEZu7+fkpMkKP841w1mkQSRI05SC6x7t124NpWDFn8On5YBgh60eCQmpP4MArnDjAy/+VvNBqj9dhPOKDwqKj8MskwNFDzhE18LV0VNb3sYQRuHcjB5XRQvMeeOJYDB+oo5sVr9Yi0n3q/t0clOTR1VpyVkekvRQ8Y+7ELlTXkdGaaPGj7Q0zgfRQxOFWpqiO5a4Xr2MAPZw4R/WW9D5AGAYYi1VfVro2AH6TILcFGk2fo5Fls4VZ2VwlmJnPXoLhC14NVRqR4QSM7YQexMZwVYMYwl/fLEWw8d8XJ2E0KIBQXmbVx8zhUHXL7iN31Ix8jUzTwNkmeQGcra53tSZP1ohAwFGcg32vg4w4ClaQW6tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(6666004)(478600001)(66946007)(186003)(1076003)(66556008)(54906003)(16526019)(66476007)(316002)(83380400001)(4326008)(26005)(36756003)(1006002)(8676002)(7696005)(966005)(52116002)(5660300002)(6486002)(956004)(86362001)(44832011)(2616005)(8936002)(2906002)(55236004)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MSYzfCKeUx63jBGJWmGDj2G1AIlYlxHNGEPnPmRCJIxfLyhaQa1KUXZJvliJ?=
 =?us-ascii?Q?aHrGjPmzRux98sya5M6TefVRnX9lokdg3FbCBHMnyfsLzdelK46WgC6mwHwW?=
 =?us-ascii?Q?F7KT98ePNYeAQZcmxhtIt+/YyGKr0Fi58Ieh4xBrsnwVDXiZT+BX/ArXtTSO?=
 =?us-ascii?Q?cckOdOV2HVWQ082N5hjhqw8WNxIOxEb3Dfjw7X/jwC1hZc2VYH/gQPFaURPm?=
 =?us-ascii?Q?eRh7miQMdBufauQu6ZnRsNPMNM+CjdePNkfs35t2SVih+v4kTrOzbBMUynEO?=
 =?us-ascii?Q?3utEVGDsFeeEJ3oAWJNjiTq3egmL65IOenFK6capeAkefIcDxzK/C52kj6xb?=
 =?us-ascii?Q?ezFYCNC/dFCSIkkdwxnFOmzQkdlBzgeBQF3V26hTBh7uq5FL6xyYjFTssRue?=
 =?us-ascii?Q?NORxkkYmW0KZsC0nu2PeonSptPf0Nqk7uZ+CfWd0Lof6kwJj+FKQDYyyRfsf?=
 =?us-ascii?Q?lcfHqgEcE6ewS9YiThKH0X/VEW7XM5dci7jYXA2AYbx+OTSs++0y40F6/Fky?=
 =?us-ascii?Q?QEL1f+at3lA9CeLbbFwv2YDILiPxsX93iRqbvjMOBpk2GdUXVjA/rTtQleY9?=
 =?us-ascii?Q?HJiZwN6jkNY/dqyPVn7R04tsjwTWDbhMyUya4cL+sHJgspSjKEi9FpwSYnCU?=
 =?us-ascii?Q?W8HyZj2sOYhJZvW/WcSofD5ApgIXTVmJn6NKQyU2ZKZhLV1US80mgjQwOLYq?=
 =?us-ascii?Q?SJZPptUarFKfycgDT8IJcUqQztFzW6wQisLFxMVU7by4SO0EyAOx+uURX6d5?=
 =?us-ascii?Q?FJs7QH0uKNSd084gUUY+f5poSVJsDP9WvsJwtBS5KQ1dp7pDzew8CuQsniBm?=
 =?us-ascii?Q?ECoevbC6/02asLFgR9zsarx7PrnK/lYj2b+qYjO5Q7jfVkP4TZ6W1nXkimtS?=
 =?us-ascii?Q?L1V0bPUYBz3xmNgYbdg5Svw8xTYGi9rGKD5L1vk8gU1M81h85LsaPDEVfoPz?=
 =?us-ascii?Q?2EfGISNHruz8QNTmzl0GpZSF2f343FX883lDCzvj6h1uGVxASLbqfHE4BVbH?=
 =?us-ascii?Q?bPc4e4a7F2POdeScELdaaNrfnSdHyhDUrr/+ZEY7/nGQRC/4fVGZQ/vwydPH?=
 =?us-ascii?Q?9lcXvNA6XMOgFiJnOKQPKeDklmgdOZtiO76kCeHD/PhZiFG8qomU1+sAkvTR?=
 =?us-ascii?Q?/2pT123B1nbvaXqmBntrRnH9rCCnTRQcebZKfMnsKBWFvMTp+LGYqhQwloGN?=
 =?us-ascii?Q?EOIIKcs3Oh4odQart2CqfZZOme8xSWb48KV63HpIESzFaI1Bq/ZAqN2pqzBW?=
 =?us-ascii?Q?ytwi3A8L0Cty4+XVXBgKbJFIdk2aLeJ1BaG/aSoThi/EMP81bpR6Yz+OvRun?=
 =?us-ascii?Q?UBFFYiVC0RUVR6hpXbZGp+vH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16f3fe5-1ca1-4c81-fc82-08d8e2e71d00
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 10:35:52.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJpOfv+fX4IDvP6ifYK8kE1vWq/gx/T8urTazEtWNvZefWUqdOBFys8e6q3wCmVEi2QC0lW+Qiwj9NlgjWoU+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the NXP FlexSPI binding to DT schema format using json-schema.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 .../bindings/spi/nxp,spi-nxp-fspi.yaml        | 85 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 43 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 86 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
new file mode 100644
index 000000000000..e3f2c5aae847
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,spi-nxp-fspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Flex Serial Peripheral Interface (FSPI)
+
+maintainers:
+  - Ashish Kumar <ashish.kumar@nxp.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nxp,lx2160a-fspi
+      - nxp,imx8qxp-fspi
+      - nxp,imx8mm-fspi
+      - nxp,imx8dxl-fspi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
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
+      - description: SoC SPI fspi_en clock
+      - description: SoC SPI fspi clock
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
diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
deleted file mode 100644
index df178d1b62e6..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* NXP Flex Serial Peripheral Interface (FSPI)
-
-Required properties:
-  - compatible : Should be "nxp,lx2160a-fspi"
-			    "nxp,imx8qxp-fspi"
-			    "nxp,imx8mm-fspi"
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..8729f7b50945 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12832,7 +12832,7 @@ M:	Ashish Kumar <ashish.kumar@nxp.com>
 R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+F:	Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
 
 NXP FXAS21002C DRIVER
-- 
2.25.1


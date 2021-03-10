Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA23343B4
	for <lists+linux-spi@lfdr.de>; Wed, 10 Mar 2021 17:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhCJQxQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Mar 2021 11:53:16 -0500
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:34114
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231961AbhCJQwy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Mar 2021 11:52:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNrrLhCCRacH3D6Q9Wdisw/J4aaNT+vj83moKDR1/wsVqAizi7VApVE6A3z2gIlOtCS/yprgAIbhBRg4jQVDbCXQEWGVOpC0u4l3xas/dw8yTIU5/ZkPJ4jnhji13xAOZuMv/TQU3s2flglNepJ9p7GGYxga+K1zMCQgcCnUBXYPNGuMUa7r2xE+6Q1oXLc/djtYJlNUPORlSGIZJ6L/VO3rIniDYAChbxDdUHwuuhx5MJbfMowVkkqA9OVSjrzYLEqkuaV7Jl0+wVHWetTRAuW7q6rUGbFOwYcxNnCw4w341iou8dmO4PAjSQTnz+tqH9oFBKULnd7fHhRAUCptkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgdImo7raeJf9HrCKuQ+i0aYH06nQjpDY7Jqc4JgBuw=;
 b=l2FZaSe6Hfq6iEhf8QdS2XPPznbRDNvFhZ9Vjty6KlC8i8Yj5Jac0ya6ZV7DnPEqKHQtGZBmVOJB3OYjNpmNgpeNNIBHjPCAeuCQA/LwoqXlEgWUqZzeRYsuvGnx6EZ2isM/HNYCkaqX6zOctpJsuwuGOFM1yZvHg75LJa5JoYLzOi/d7rxuH/4LbBs1rGEvKJqVCYtxvxUaLGsZof7VTd28gv1bNn7QuJKbLcIa7kkpg1130hI5l8ThMWMvmW6N/DmG/4Lk35vRWPJyEgF7HYBKFQ5hgGt5+vI17d37zZRnjrb5EUwFWF60gMsaKY3RcuUPC/jtrd8XCGm4qhX6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgdImo7raeJf9HrCKuQ+i0aYH06nQjpDY7Jqc4JgBuw=;
 b=Kv5pq2CA17AJugIfLnDZWCfwM4v/VnEghT7hov7kuj5sVTsHuAsZ++93Z62ne36YtjgtYjbU6VgT1J0K7bGuUD4C+AKlJJueBFNkIcza+wkgyTvl8Iyptp6ej9aMJ0cZMH64uuD9/je3obh+8duBhGAQo6H4aRdR2TIfUlN2O28=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DBBPR04MB7595.eurprd04.prod.outlook.com (2603:10a6:10:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 16:52:48 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.040; Wed, 10 Mar 2021
 16:52:47 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [RESEND] dt-bindings: spi: Convert NXP flexspi to json schema
Date:   Wed, 10 Mar 2021 22:22:00 +0530
Message-Id: <20210310165200.3560970-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 16:52:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcb1cdaf-03b5-4d41-f424-08d8e3e4eef6
X-MS-TrafficTypeDiagnostic: DBBPR04MB7595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB75954E5A5447D7DE30A15C7CE0919@DBBPR04MB7595.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMgy2WOe8QcA1vES0Jcgjoc2kdAFKm6rhZvzcBobzqOuFNxsLh3fj/NMcDODjJiYXt45BKsHvaEAjsGZIs+jInNpv7obARXb4toYT2ewj/mSez8kd6ATUTi9BKkEmMWhB7p/59SN3iDz5BH+8yYGGCA9GClNgO/HLPufhlpyAugXVwveoOo8+030BADgLLP4Q9Vk8QCVyZsbq5cKZUrtCBvPzYh0D7u0D23jRSsgIaWzXsEvkX0ghD6hMPwClDNyMA+iJOyNnBzG6zCNZa4mKGD+EXDu6dkKmkI8/ZhIKcBeDYISY9bCDgX1nxDfI47RyGlLIVgW/GH1CdTbDqsGA+ISWK68Sa3Mt8LZ491w/G5KlTAfJyJUDolbPPnaN9op3vJIhrespNn0jGKutnohvJccRHykLiKWGE2hnvE8tcWVi71NEHa8kj640ba5ziLwwr2li9O/9ysiguAleLxueGMA+yAEBgZGu2Ge+ZnKe9xbfC3dhrpL0eZKRdSOSqDMS3tss6R49gBWROFq2Cp8C/MlXL/g3pTETrhMqr9WXwvejMoLqlxU2gvTqx7cXKvh49yS90jp2bwWQPQvipjchgAjhmQy8T0rq8zh7vjQmVpKbonsd/Oo8mG3GRElveSAnBuGKnIvJghDX1h/DvdF7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(1006002)(1076003)(5660300002)(966005)(36756003)(186003)(478600001)(956004)(26005)(16526019)(8676002)(44832011)(4326008)(52116002)(54906003)(6666004)(2616005)(316002)(6486002)(83380400001)(2906002)(86362001)(66556008)(66946007)(66476007)(8936002)(55236004)(7696005)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w8f85/HD3EDBgiHnUR+mho8KwCbrYa9pcIz6y6oTlM9wprzffnTaMXqqot5C?=
 =?us-ascii?Q?8SennEuAam0FJjLunty/j/wTZsXOf4IIH75S3sdi0B0/AdnNedMPcHeKMM89?=
 =?us-ascii?Q?7MW25em9fDm0qnyxZ83D2XBxVVk9GYo6IXGGnIGXIuPzihZ5FngJRT8hJSKG?=
 =?us-ascii?Q?gs+bShLrohU/YSpMupq7Yd1jOVbcw8uqqhND6YMfWTOSYRA2OoK2kdhyrPEr?=
 =?us-ascii?Q?F05LEpnOr7jm4ByP1dZRrCESTeKB0AJvsRxU4KuKG23T9H0kRnGnueEzWvmi?=
 =?us-ascii?Q?wxfXJYJuVaJcajmoTpgCxZioKUs4bJ2v+OdO6R4JlkBZtBvELeDntoVLfP1/?=
 =?us-ascii?Q?xuY5PSfy0wHso5uJzPMpd56+kLq2v2FOtWKWoOIfnREwj0IEwQ4Fvw6wSa74?=
 =?us-ascii?Q?cah0F9CbXjhzEpWBhTg9myi98qwl8nyesnFERMtEbQb6aqBu6qPv8O/N7ERQ?=
 =?us-ascii?Q?Z4XSsvdQT4W8jGJ+DyvJbTdB6/LWnmZV3WaV5lVvd9uGTc1SeknRRcpbVM4F?=
 =?us-ascii?Q?9xv2+PimJKv60YX7IBC9/eumY1Gah32QTB3qJJudjmIFoUUig6bxbmAp3Je/?=
 =?us-ascii?Q?UKi3d50DSYZhzC2hcI5ujmBmnIZY7ov37LLrBbGQGGGv0olXxlAUq/gQxAl4?=
 =?us-ascii?Q?z65OGn7yQLYlV6l2HfsZM5ysG/rVq47ZQ4OL+XrABvQmTl+qlYfdNkErY0Lv?=
 =?us-ascii?Q?fjSogSFHsvmsM/xH2gfz1KbJO1t3+mqEXhT1o12h36B4q6PxqKkHrnz12cp5?=
 =?us-ascii?Q?V/XJzO0XKMKr/4ALEcDXcI6T6TItVnDaadHdUkZ8kT6t4htwq5IZ7ZGR5GQq?=
 =?us-ascii?Q?ZcNFDqo/Qxoy2OgADZKwtrDmt+a4Ux9asHQvumqAzjED9ozegSJPpCEhf6xA?=
 =?us-ascii?Q?qvemNWqoAuOaYuqbXUIAoosHwmQKPdq6knHPGBXRBHlMYVhdzjoT75C1X3cf?=
 =?us-ascii?Q?1YIQBc0/ckZK9EF1xoLAcZvwAkVFd3bWc7YV8eFIbw1qqFDI8sIT+6KfB/ZW?=
 =?us-ascii?Q?KxXcH9bZ3fWUJtjEy3n1i0RImo/JwKWrC/7Uxyu9NW7aoga9XK8j2j5jrROO?=
 =?us-ascii?Q?rxvgm19z/xHd1GCKbUkTITEvga/qJWFPBrog/A0At1KVjPJ3Rlpojnf8sJOO?=
 =?us-ascii?Q?BHjp7NlBFrmYolo0LKvSOImq4nT0/kkTydBo2s/BFmzMIcIY4SZmcXFiHfse?=
 =?us-ascii?Q?MeQwMA3AWl5qXPe+sN2Nyr0wZg5IFM/Pnhw8bqtuBY+DRwDTBVqJeuW/WyNo?=
 =?us-ascii?Q?t9WHMJsH3WBIZMekqO1WlOdggiMQf1PqKpf8mf2tR35mQF7aomZD0SQkeV1g?=
 =?us-ascii?Q?9ldTD13nKAUCcwn4NQv9IKtk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb1cdaf-03b5-4d41-f424-08d8e3e4eef6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 16:52:47.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6knUZOFaMhJi8NtmxmezBVF6J8CkvqmdDEBzo2Q0bZJRS0QcIPhwIOH4y/st6dF1vyiBZGaimdgmvswksA7YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7595
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


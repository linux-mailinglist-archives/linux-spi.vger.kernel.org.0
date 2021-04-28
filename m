Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4436D5BE
	for <lists+linux-spi@lfdr.de>; Wed, 28 Apr 2021 12:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhD1KZd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Apr 2021 06:25:33 -0400
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:20768
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236055AbhD1KZd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 28 Apr 2021 06:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpfoHWlawMj1gKqjRU7T1XlNeWUlWyZQ6ZBcCH7YLUNSeibO452Lp0CMr1YfAIesuRmFmlRkrECa4jTOk3VW9IvETeeIIC4t+bNtwnyfrCCfN2/18DRE04Un1ThNTak1tnFMt5GBlpw5WFZPJQIHSOmQVvZK78XPBJ8XZdpecU/UloOG6m3fELAF94bC7PmUij141d5YK4VXMfYuAsY3p1vI5SYEsx3EnbS3gX1cw2+XyEZPp7ZLvXkPlnlh/whMm/NIKBwgAnQ8ShF8xQddZ0+D6PbTmhJa1h+nQ4Ga/iMUBVthBL2E/vJIlIHQRMdUEmbyoADcN9juFdV2N3VgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaL2GU2eR8HQ9mX+Qff58usbXZQiFS2x/++okQQzCak=;
 b=Ee0yzurF1L6fHvi+xMFIc+EMf49znKg2LAXAIAetqcvZ9EUUlstFKwvPODZC+2jtiqSRFzhKadOt1Ha7E/6vWgM+SxvhL/2GR8D25WHdb6Ae+TtLa2lJbVra0MDiXkrC2D7HBEC2tZ8T5MsuxA+Zm4ShUoKOnZ5LgRM+ruWwcg6U/A4vEgC/eCoZTXCl+wDgmsyP9Jx/EpNl1s4i//sOJyTF6cQAaaBkfYxHHPv5y8Y1kS6vUySKbxKylvROPLwahK2bpGM+cUDHHBl0FzyFcj9ehbCkVMnGLyLFjnqB0I6yH0mXIzjMEXMoyC/I0mEz7hFhptt8/awEEtaJHNTnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaL2GU2eR8HQ9mX+Qff58usbXZQiFS2x/++okQQzCak=;
 b=mhk4LiLiO9gfQlovtKi2E3AtVyDL0w37XAGyrOv27JeLGw7BbsR1FuMyn9kwwgXTVoxwHkNzw3+lpXl9QQyYhvjCLV1z9Uq6V4d3fBV4KdVPlaAdoEfD/7dSgjw8GX4re0Tajtpcn1Mk4MtecPS92sXo9GwX0vkMZEihqMQnlSE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 10:24:46 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::a08f:6c6a:cecc:163d]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::a08f:6c6a:cecc:163d%7]) with mapi id 15.20.4065.028; Wed, 28 Apr 2021
 10:24:46 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND] dt-bindings: spi: Convert NXP flexspi to json schema
Date:   Wed, 28 Apr 2021 15:54:17 +0530
Message-Id: <20210428102417.1936520-1-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HKAPR03CA0036.apcprd03.prod.outlook.com
 (2603:1096:203:c9::23) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HKAPR03CA0036.apcprd03.prod.outlook.com (2603:1096:203:c9::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Wed, 28 Apr 2021 10:24:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4fc9fd-18b6-4bde-e9e1-08d90a2fd892
X-MS-TrafficTypeDiagnostic: DB8PR04MB7179:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB71791C071E9CFD13D27F159EE0409@DB8PR04MB7179.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gmQyvXKp9poMlezKFKoU+aurhcdB5Ijc/Db1jmClCof5dJClS/koejOEkgRBZ9Kc1MUzxHOZVw9NNb+IS80mknXoZ7+tLpTrhvYSNPMMGNRxPR/pPKleUlLK37pscCbfHuHnz/I602UngX99B2YqjWtVuOj6N7yLIdh7LwDr9khz1EZtjAfEkAjYV3fNNw/x4tSjtxG6c+46ZqOQSNkGpZFJRYw1/pg80X/a00DbZY1PHJPJXW35EnDIEPDqCNAPwW3sfJMQU+iqXJHI4aPSWbmY31VT9aBZXvOhaqmVd4TCUjds+fHB+w9br6APQoxwZ9dcSOiLHYN7qpMa/+HwU134MEgmm2j9TqVFob+M77duGLQUO37j8td9l5GMqGHwiamxOiwso7SrnRj+17n24TPRUup4gksypivkVGMYC9KjETJrXlsQ/WR9L1TWnJ0RHEV/m5YBd3pHxLnXrg0LzROH2YdIL47JTuWwo0aH0RWXTmtADgr6oiZdParT8Lum/jQwzCTSfvw9mP1wmDWjFSZXsHhVdXEZcqyz7H3CeSwhQJy6whLYv/BcJO8JQD25BadDS8u+dJELjpUS2/lEsrbslkLnn/Rg0Ahg2QUBRJ0z0U7Ee4n4dx4uzXvS/UJkJPd2yVzc6pMmE3WU9rDAhMkp2B/27khcevWwZ3ULpQ+Bpg+WLjoePWkmoq8956lleOJGXa3WvkT4VpWBotNd34fysFVgGIl5BKnPzKYHAe8sewJjkw5biJQDB4rwd3N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(38100700002)(1006002)(6666004)(38350700002)(26005)(110136005)(956004)(6486002)(2906002)(5660300002)(8676002)(44832011)(36756003)(83380400001)(966005)(7696005)(52116002)(478600001)(16526019)(54906003)(316002)(186003)(66946007)(2616005)(4326008)(66556008)(66476007)(86362001)(8936002)(1076003)(55236004)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RiRkvDv/a8YYRXWsFhzR31yYswwDJHjB/FPShsrX6VA7Rz/4aSB36u4R9eR6?=
 =?us-ascii?Q?OhWAJLxrpinxDU9YfbVoEvCinwC+VutVit0xi8rz3uhnajDkkbv5NpC9Wggb?=
 =?us-ascii?Q?ASI+of4mCiHrGxTdZQDnMgNAhDpiyBDUeYxU4wKwF76LiJppXwJLFfykta72?=
 =?us-ascii?Q?TncFfcJytGQ1bPzJzaonx05/mO6bjOHCzKASGEtWrG2k1y6XnM54vktCowW6?=
 =?us-ascii?Q?bhYdA8slogy/bNg85Wp8ilzoRyE+dHlMZUNCpLeBRulQAzgAxoF0Xbvvwzcj?=
 =?us-ascii?Q?0/4ZXCN6yc/BDtv7vLeAkpMvacJ9anpFRntgPFTZuqnfF3wpPKqTedJNBsPP?=
 =?us-ascii?Q?2k9Kw0Moshc+SzVI6A01uJtiuM54oSBTb7zTYb0tdZrqww7yfi+rQLKnaszS?=
 =?us-ascii?Q?pCtg0Qta0XOF1kg/ygWE/z3628t49Pzi3OyvC8yGWzSfiGV1jxqeTIGJVHSY?=
 =?us-ascii?Q?YvWNn0XqGGkxABFar0iIUdS2/uEBZFIPpcyiX5tU+M4unfr5aGrp52Xm8a2L?=
 =?us-ascii?Q?haE8YGjWm3vcZhtGcW3X9sPhmeaFBk9pqRT1CHmvy8B4BXQU0GRvbv1kD/CB?=
 =?us-ascii?Q?d/CmhGpYVg8NI82Ur4TjtP249UXn7t+jaOYTmI3rErE1OhfRmw6OMIWdC05E?=
 =?us-ascii?Q?2kf2xQQx7mcp+cHbF2S9gmCPLUIMdGvc7xUQt3PCYbbTztJWZwDkvzywMkNc?=
 =?us-ascii?Q?AxmxhUEx1wqkiNsDulb9KEMFmx74f8hawTY4DE/P+72ohjfavAH7BG4MEgS/?=
 =?us-ascii?Q?pozZr6J36Xqf9T9XzPkpc7v9ItJKhE/96NgWsBTKxkg77wZmbx9tukcTmOjE?=
 =?us-ascii?Q?TjmuNEUUchPyGnAJiM/Bpb8wQTHdKF/L6m4kUcDFmWtrsaKxm66poa/i8xOZ?=
 =?us-ascii?Q?2mCxM6nV8F/vkOrqrAs521SSQgBpJtr+avDc2vJqLEnpIHGq0AVoLyDcVaKj?=
 =?us-ascii?Q?87MlPBMXmfsNo2iFWKj6lHZufcKRuwpi3bZmCw4YsY3Qng1fsrfCPm2SpkUq?=
 =?us-ascii?Q?2lrTm3rk0YJQXH3jzOrE+TuMt4skg+k14tUOQAJSfXSeSzMkebHkPlkuKEMZ?=
 =?us-ascii?Q?rB31vY3lhkbPtdnBqfIO+SpLVs7ZBOF1g1pIs0iznPrxYYsNsEQ2lbj/j2MC?=
 =?us-ascii?Q?vghlNxOwcjwQYUbxbx+0QNvXG81JlJ6/iqRmXWT4pVUX8Vx9rUhXb1d/oATw?=
 =?us-ascii?Q?SXM2eGRatX7wwXODr6OTzjn2IvtmJzHBPRpmaCFqmF6neNQFqDQYAdMt3qSq?=
 =?us-ascii?Q?pX3u71fDa1SSUEcIof3br+B17iIaLHXvQAmnOUJO2j//L0IsdGWwY7UQ6vq6?=
 =?us-ascii?Q?VrJjGnDI8vAt+DAHloJXhy59?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4fc9fd-18b6-4bde-e9e1-08d90a2fd892
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 10:24:46.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 876+TDsIZXWX53K+zHR9sC8GE6eszXwZ8C7F1VjuCINXXkLgDnRebumiKj4j19A++TFaW7Zmogj/7V6UqfVUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the NXP FlexSPI binding to DT schema format using json-schema.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/spi/nxp,spi-nxp-fspi.yaml        | 86 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 44 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 87 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
new file mode 100644
index 000000000000..b1d2e399a437
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
@@ -0,0 +1,86 @@
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
+      - nxp,imx8dxl-fspi
+      - nxp,imx8mm-fspi
+      - nxp,imx8mp-fspi
+      - nxp,imx8qxp-fspi
+      - nxp,lx2160a-fspi
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 299a9f458e3a..4b2736df358a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12847,7 +12847,7 @@ M:	Ashish Kumar <ashish.kumar@nxp.com>
 R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+F:	Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
 
 NXP FXAS21002C DRIVER
-- 
2.25.1


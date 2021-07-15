Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B878A3C9A91
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhGOI3b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 04:29:31 -0400
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:50144
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230310AbhGOI3b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Jul 2021 04:29:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPHzaKtiApogPvMq5DJP+A8TymVoyO4AFeQ7MfEsrMCKqSHmNpa9DjH47qGTMa2o+HeODHLK4g7gkWphlc3QGla6lcEzNQEingYM6Zvqn4dhUbdPLj1deU5HSQuFiiGeaPc8o/aEAnfaUyZFhJjV3sQkKqW+0GTIMrzeTBizr2yIYt/Bz6J6ldNwt6B0G1LIp3IBYVEeubrdgvX2uG89l0SmbYPaoQJl4Ejx2T1hLCZqmx7TyRyamEpKXpv/ztfuzHHR7ccV+HjtkRDXXkSlRHkheu0B+SnJregOy9RMlCGFMU9/LuxWlmNrctFtVvdVNlfx0izrfKu55NN8sUIIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3lpX/RWIy5F5UJ6qX8uNxAj4FWBw9yGLlvE13rIhew=;
 b=XkRhH57gAEgc7uMB3wJFBwm2XXG4f4O7bk/uoqSgbDWn9bn9MAb2rdbTxKae6qclNti1tXtZwycHQQAdyiIMhdHYP8nEFDkbgtvsFuyhV+vaKXoO3ZHl0ZxOT1fdCIf44+bu+KDMSiCzO2vpxwvboeu/WOSS009jH3VXC8rEgRKPLKQDVZllXn+Qj6uNSDmwejV0aAT8K9ExS5sfQMBU6YALCY6dJIhWRJNoBcTJ+1v35Ho8qvWSbVbD7nCHTAOLIfyWFOGvtHOPTViXC0lzG6xLbl4aG9I4W6WiCMaiOubbYBfmx3rUh3V915qjPkanoTLYPEYDyDNSyDIC2fNfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3lpX/RWIy5F5UJ6qX8uNxAj4FWBw9yGLlvE13rIhew=;
 b=TLD7HafHi2A/pbJsmDqFopU60yI3qZbnSgVtu2eWbY8V3dAjjrDB1DRK09kandiCySps5REJt0lfA99IdTllACL53IaXa5IId3QbBZ2jKJMhd3NL4iodbvX5zhpHxGrEHloxSh1ItQMFv+BU4F1PTydQTxlLYmFxk78uIER0onk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11)
 by DU2PR04MB8680.eurprd04.prod.outlook.com (2603:10a6:10:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 08:26:36 +0000
Received: from DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2]) by DB9PR04MB8477.eurprd04.prod.outlook.com
 ([fe80::9daa:ab21:f749:36d2%9]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 08:26:36 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        kernel@pengutronix.de, aisheng.dong@nxp.com, dongas86@gmail.com,
        robh+dt@kernel.org, shawnguo@kernel.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: spi: flexspi: convert to json schema
Date:   Thu, 15 Jul 2021 16:25:31 +0800
Message-Id: <20210715082536.1882077-3-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715082536.1882077-1-aisheng.dong@nxp.com>
References: <20210715082536.1882077-1-aisheng.dong@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To DB9PR04MB8477.eurprd04.prod.outlook.com
 (2603:10a6:10:2c3::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR02CA0083.apcprd02.prod.outlook.com (2603:1096:4:90::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 08:26:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b05327-02b8-4192-d5a4-08d9476a4289
X-MS-TrafficTypeDiagnostic: DU2PR04MB8680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8680D7CF2D4F1FCE2D581AE180129@DU2PR04MB8680.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zO7wTOaWqW9BzmBFeGq0pTysN5ha5bqgzgY16ON+d36Xf2GQBScTJF4UkmXM7VReV9+sdgaBmosi/1PMUEyOQ+cOTmeGflCtummTwDJMPPEdQB8CjqqFG8VU79LsjN2RDkyDJxjf+OpKCtsHoaoufQKbIaObrihD9L13TIhqXGnd8p8UyWTpBHcBwtFZMS0RC3IDC8PpXzDXEuy8T3MV4+XFERH/+5870BfFDgDrHViedADSOp2oXTWtDxMJF3tTZt8loK6GC5NsUTcNVaHDrG2M0g4npHBYzeTnDbuhigji485qhb6hZ0FEiHr3dcR9s1/ZeG7ZJDI899wYGEOUO0oP14tgz7tZuyffYDxaG9n/pgkWwDdC1uzAJBsyz7YIcRy1yq9vaDG502rTERqf6c/GyA7a73Ba4VpAmMX57iIS9MUCogowFByAt3VXuQ0reighHsbEyGB9+RnNIitWjYr9ZivtaQoCTW8GEuSyImEeAw8z0dneb+zQzHSLlArc1I+eOhMwN1mjYAh1MEiSk8DTsu+vcINFr6VqeYmH6yrvKXzG0bP2oRtZ5aNhET0hyjjGA/PkHGkdydm42KMhW5WM3kXL96XZ1x2wnjwXrUgxW1ye+t0UqsBjWjnt6v6NcxIQAC37HGqrFzYVshrJ9ZAXkMLxjc+L9mDJQE9fDl5oIto4sgsaT+egN139GyXCsozq242P8o9Q3nmTW4vgtusCD/ANc/Dq7un/UTqh+Ezy1BIIXHYI5VFiAbkFG9XQSv2lEg2BPG3t2BuvHmDStArQME4plCXlW3Zheg/mMWblUO51BD1QilAbl6SL3uM9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(6506007)(2906002)(52116002)(186003)(5660300002)(6916009)(4326008)(6512007)(8936002)(1076003)(36756003)(8676002)(38350700002)(478600001)(2616005)(6486002)(966005)(956004)(26005)(38100700002)(54906003)(316002)(66476007)(86362001)(83380400001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFuVmS+FntrGu600t5oiZ+NPKhgI4mxGFf0gVH3BTPr/irDzs00ByaCbd4bt?=
 =?us-ascii?Q?zUsU3iTqheVwL+DbnvZqcFfJwyevtIYp01trd2rYO6JE0gFCROBdoLVbFBAm?=
 =?us-ascii?Q?YtuedDTP20ifLV5k18lkbsZHq6OaOeVrclSZUvHupDlZk3OqDocDj5SmdoFX?=
 =?us-ascii?Q?55SBv2MF2PJ413AuUKfF+rCTks3KYmGnpTfsEukIhlHzuYCpN1WKhC4bc3f4?=
 =?us-ascii?Q?idhE9FvASvWdF/A6wCwFI+Ko6qv0g12X3NcmibiNFFm+XMZdAdpDUpcFK9dB?=
 =?us-ascii?Q?ZTS2wlIhS51uhkH+yFCFlODLcOUrRtN73Fr/uJIxRMW4Q4npK3bdXGa1DfRG?=
 =?us-ascii?Q?roWsa2jx4Y/h61ll0p1PLOJs5IB7cInhpj3+6RG6409dzpZRB311xfwD95pc?=
 =?us-ascii?Q?SKbD39Jk7TO8W7IjmPWh795Sj9kqlWDLBGVBPpc3L0Chtds0VzgKueSnK3iG?=
 =?us-ascii?Q?WmzxMdqTIgBqEns/TN504+l+nDYPLQ9YQUuZ3yUwsr6HYTIhr+BtnomkFnLW?=
 =?us-ascii?Q?6dasoyjYyL20TI/sCPqs5N+ztklOSMOF/V4HPuuJ4u3ePs5Y/w1bV9DFr5sf?=
 =?us-ascii?Q?EF9b99bB3WrHeOGwnswd7j9MatbfnAIh3cWSUbmvBRvr3HSRenZkE+pjByzB?=
 =?us-ascii?Q?y9LI/bpn9+ZGoZXA3D2ZYZdbzMl2tDARNNI8Jeksr91Ylb+Q0nqvogB5h4Vi?=
 =?us-ascii?Q?d3ypECYuMdpearGSCXFpsbae2nVg0kzJyhQzxlsqi8CUulFHyHKkXVFv+2N9?=
 =?us-ascii?Q?cYhB550n2T3D56Q/Tq09B4LLShhtD6wkNWfcujLeeiRmtVTbbfNdnXlQLYUh?=
 =?us-ascii?Q?qyWdQMock6KRfNlkZzwgR3FQVyFvy+ZkmCqElc3O3bWZ7M7yf3qHrlNpNcKe?=
 =?us-ascii?Q?/rq74JCwfGXlXcUBWnDJY7nUPRVQnmA8ZNSFoqsjSPrSFXt/Yi4X+T5nznI4?=
 =?us-ascii?Q?+bumemeWIS56MUSrx7ReXT8sasgHDCGIgrATJSbMDpVwl8nU2/HKSkeoDqt0?=
 =?us-ascii?Q?DgTcgpET79GZqkjMUQBJUQ20KCzAPlVQBQbahDpqTA09FcLNpBf/xCB0oYFr?=
 =?us-ascii?Q?1xprwFlTcQpVuhz49UicmfI8j13C5HwjRfOgEiIDftLBDHwhAmOHnqPzvN+r?=
 =?us-ascii?Q?rHSL9bS9i8doMp9f4L8iM33/a9StptDu0YBduqeXknWecXWcSgnKyNNvuhfI?=
 =?us-ascii?Q?FuHENIM/zXkg0RnY2SMv3Td02IfoeowVlY48VdLtxKflYxnVVaDdUg1zwphG?=
 =?us-ascii?Q?U0i5CJ7QNxEdlUT0IWVMZUJdMTnMjRyokEpKuNXrLOddSeb+xLjziXyShijq?=
 =?us-ascii?Q?0HTck5sV2J3P5cTm/ae+rSFv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b05327-02b8-4192-d5a4-08d9476a4289
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:26:35.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tH+vBsWdCEtgRZhJjnd1n1vckbd9VW/Gq/jhLVMEPRz0YCGTjGw3TvWOJOJLhqHIGv5zwWxaUQqKDOjpyJsVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8680
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Besides the conversion work, also added the missing clock property
in the original binding doc according to the current dts and driver
implementation. Otherwise, make dtbs_check will fail.
Also fixed example according to new jason schema.

Cc: Ashish Kumar <ashish.kumar@nxp.com>
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 44 ----------
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 44 deletions(-)
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
index 000000000000..ca43583947ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-nxp-fspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Flex Serial Peripheral Interface (FSPI)
+
+maintainers:
+  - Ashish Kumar <ashish.kumar@nxp.com>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nxp,lx2160a-fspi
+      - nxp,imx8mm-fspi
+      - nxp,imx8mp-fspi
+      - nxp,imx8qxp-fspi
+      - nxp,imx8dxl-fspi
+
+  reg:
+    items:
+      - description: register location and length
+      - description: memory mapping address and length
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
+      - description: SPI Bus clock
+      - description: SPI Serial clock
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
+        fspi0: spi@20c0000 {
+            compatible = "nxp,lx2160a-fspi";
+            reg = <0x0 0x20c0000 0x0 0x10000>,
+                  <0x0 0x20000000 0x0 0x10000000>;
+            reg-names = "fspi_base", "fspi_mmap";
+            interrupts = <0 25 0x4>; /* Level high type */
+            clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+            clock-names = "fspi_en", "fspi";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mt35xu512aba0: flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+            };
+
+            mt35xu512aba1: flash@1 {
+                compatible = "jedec,spi-nor";
+                reg = <1>;
+            };
+        };
+    };
-- 
2.25.1


Return-Path: <linux-spi+bounces-3131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E248D3EF9
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 21:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A361F23386
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206DC1667DC;
	Wed, 29 May 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cxQxOIFl"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9750515B573;
	Wed, 29 May 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011435; cv=fail; b=m5+DaJrs/ja31jJHh/LL2tad/XKwiqXATv0dUab486V45afoXy2UqKzMIoxd38bUx3fgYz4gijDBf/Hm6ZoQkV5Ab78WV4F/zZ7Gkkk8zCALz76pK6zNrBuvxAXR9UyZIPOCqbzoIWjHHZ2Yq3qrY47Qc1XPoEEKEnTnZzpHQxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011435; c=relaxed/simple;
	bh=78y6owJf/6kQvgJy8xgdIWalMSoQai2qVhOK56ujX/E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D7FP4R9Ga8iZ2zo1FiFCEKQQZpT58q4Xvk6mvXWH/Gr7zh36sSEbMQotzxOQcYQxc7whxxDw7l5FhnrrAWofI5c8ffKYxlqr9//5bCLXghMN+DNk0TWiboE6THG+IAZ5xEKvN8hhOVT+kaGwzTRvCYyH8E2SbcFz2xssPy8PwF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cxQxOIFl; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilXwMnDjKcz7RfDbisSbBa7ZdYDgROdehjDxf1IBa6s5GRi4k5SFVTq/xC9wIbK9lvvZczFt4pQNLBuwJu6W7+LaGbPZ890Kj+tTofajE0Pp2Ra++bkDLrrga3REnT7jhJ3tj9zf4LJH4grbhdu4WbQA3fHeKUzlQwRGs1GBqVA48IYcCXuYpgAmBh98bzbLEm/FoH79yphiNUCci41Bl85MxLvKjVHg++wYB81xjtGrYVV2clOr/EyqiGt5CM7F7KzJaF6lPG//3jcqUgI6azAVgqOw29nmgsm9CDdKsu+L14EFAzisq+tZtBJqoAPbkMHb5QP+fn0g2YIkU0biZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+i6Q18CVQUbsgabYWX1sdl8SAE/noRujsFZ6a7czo8=;
 b=mgqaWRJJjo1WlbgkgmheShZrBTL75i8VPyxq6mMIDZXV09wvwFKLmE43Vj+jvAVAZltiZsqKFJzfRe0OCX2uWOsXpOywzvJMza24gXEEphCb4E7p6T9UP89PbeVPA4GyG84uhFuGN8i3HjCzRvsmwjsSc7RNKevdPWl2pNiOs/RTvlOeoaEISJrdAP6PllwA3cfXOwIdjTEms4v9C+p82VFshtsIlL70Hy3gt09PXhNasw4x+k0kw8o1f1/u/YsT9Wn2dPQZjyyvkLN1q1yUtqTiTzJc7wDOmBiI25+/uFVTxiq+WYs7+ho4YROhZJJZdn0HFWKXPtrNaCOrjhbl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+i6Q18CVQUbsgabYWX1sdl8SAE/noRujsFZ6a7czo8=;
 b=cxQxOIFlT/Wn7FYmFVejREO03yyoXULk0RfEwhRP/J1nh9oWS/T+NOl6Xpyy1PtsKq6TxpZWvSfi/DDITWs/nL+ol+DCDoFP7rnpxwZY22QPrN6QvN6jsVM6evj/lVzeosrYV7MAEVAogVx5X6SR/kljkT9xyvhv4H7H4HV0Ugg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7023.eurprd04.prod.outlook.com (2603:10a6:800:12f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 19:37:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 19:37:09 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] spi: dt-bindings: fsl-dspi: Convert to yaml format
Date: Wed, 29 May 2024 15:36:50 -0400
Message-Id: <20240529193651.1029840-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fabf339-8d90-431a-155e-08dc8016bac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?arsDpqDlv8/to9DOlJm8du+TRbF81fAMhY9c0gXY9aKGfWVqGV3hRc1Ru3vu?=
 =?us-ascii?Q?M4oLrAR19205If9MAbKVWs7QBYtpsK0AZpm45Hl69RXuy9XJJkQ1BpLF2PH3?=
 =?us-ascii?Q?JP4u0bEw0pf3Tyw9aLa7CCxK72f7iXEdM13+yrhdl8MKVxTv6uNd9110liVX?=
 =?us-ascii?Q?VRR+telbGerjH8/v6gm6IqEsRe+B85z/7xbuBxMgmfJbFxDuBWmfQc2s3oVH?=
 =?us-ascii?Q?if8ArS/UVCFsBlGwPse55Uupgd9+jlBjE5qJ+SABVJfigGhwkTw3/rcXuMFU?=
 =?us-ascii?Q?CgnFlUVJ+4aYWqETOjjWxXCA5RKXmQctu6Z8lyTaUyLVeE51ypjO8Z95y69o?=
 =?us-ascii?Q?8u2S9G7pyjAQ3731aUJc/MuArdXdyinEpi2MsXrU5MPxfmYM3McTWAJep9BV?=
 =?us-ascii?Q?B6MkvwZx6m/56PsrBrbURF/K+dS3bo8yLIfIKsjsoAhuAhxp9PiYGxj4KfNz?=
 =?us-ascii?Q?Y7KIpBv2RhgTeSpGgjdrC6cf9E0/WS/yWlCTIabFqRL4Vuk4SRwxH9JC2IJy?=
 =?us-ascii?Q?uNZFnXUnpJgxAL3CGSMcDtw0Uqy7qAWxrLeU95Mp5fSHlSYpGJeLHD6c/zZ5?=
 =?us-ascii?Q?4iQlE4mf8RSnb94/u/YJvxqrkJq3wwrTjjKeuR4XAmQvfWMjQ2ju2BKkWPeb?=
 =?us-ascii?Q?h1DZkA5yzTRHEdMMmJe89SoCeeF36oOKMxkpsU2PPPMmg3vFLPQJ2cLQxTnB?=
 =?us-ascii?Q?EEOGJrA54pLhQ0UV+mVX56gOCRJ18hQr1JZMTauKLk5A4SqzFiITUpks4k6c?=
 =?us-ascii?Q?tNDTPqjjAK42RQyMa1Sgro0em8dejZV896lc01oBBYUorB3lh0nRunbr72I7?=
 =?us-ascii?Q?JYFVW1gvCTOgJoJJ1nLpVCZjVlVEgvNYtVMEu1qOA8SeN8FGiG6aeBRQkxT5?=
 =?us-ascii?Q?z1FtJG13GrV01Kmot6gR9vt565pObrTIul59zQeKTRp3SVC9EO9xL0vrgXru?=
 =?us-ascii?Q?0GjFWpuH5+Cnzu9YuaeGGF1aev203khHekE1LuPSrRPahVvx2TxXiOTv/+nv?=
 =?us-ascii?Q?k6C375+6Ut3h124LfFMxaCG/XMkUK//RfbEu3MU6qtwmGgGrTici9JpSde4U?=
 =?us-ascii?Q?a3Z9tI8vE2lcoz/iaN+aLvhx9ZQVk2Srq+3wxK81cXdfBVBqReMBgJMZUJlW?=
 =?us-ascii?Q?f3XfG/+EMAn3t5Q/IrUUTPC9+hfEca/gWxHTcjMTMXlRy5WI8K64mvkm/ARA?=
 =?us-ascii?Q?QWsa/lVQpaNhO8oyL6yh86mj6llIHRwCjx/4nf8f/+TA2DXYpXn/N8lOu71H?=
 =?us-ascii?Q?S8WUfrQwWDlMR8w3OnB2yqYCJ7zDSyWNzQEDorrmyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3fWLeX8qZYNZNqxzwBrCdFkVAclMn77NIbvOixqMg3qzHbDyCFMOx+ldONg1?=
 =?us-ascii?Q?8qJh4viRDaTWDr9DC3qhKxuXDPjIllskoTFZirLqKk0XAiiNpnoGaSqryQhV?=
 =?us-ascii?Q?NqohmblzWnZE/SQsps1gwWqD5554zlxzACMf3sMH4tKdivDmasn50H0OyIvB?=
 =?us-ascii?Q?efSYeA8ZrFlkxewRgkRPcNpBL/O7JpjcOVhiUFCaW/jVVsD8/aoyKQ0AMvPK?=
 =?us-ascii?Q?ySmNAjnbKPay0v1T9yujxljfpUPKXtSI5o/0NMIoS4pS7pC53XidS7rGa2Ho?=
 =?us-ascii?Q?jjqtpp9J+GC58AvPNIrlQ5lHgh4WO8zTUT2A2LxazrVhE3vT/J8tcCt7b5rx?=
 =?us-ascii?Q?GV6HGUrSe2hj6FbY78feAfoTsJTKrtm+ZK+bIyflit2ejI/Mv7vyEcVC7Uua?=
 =?us-ascii?Q?t2nFJwqP8qeemi06RZ80eL0C3iskjbnTLXhAYXZXm1eextzUpilk71E4Pn37?=
 =?us-ascii?Q?iXCBAqFHFdn5h0zOEFb9hMOMyi0GlS+kRStWZ3j8F2gh52UipuptPoJjtAkM?=
 =?us-ascii?Q?JRXE8aoPpLc1SMy2OuSfyObuDORgBsLxaxXH5t6Fq8dEBIUksD5KHqJbZ08i?=
 =?us-ascii?Q?Q6oL41/F0X6Ed8I8PMVoEzi3DTfJ25L7l+bxejWEij3gXGGz9CMD8Ajjw3AC?=
 =?us-ascii?Q?LWwgmgOMx9RMnTmybtFUrFTm3vsaURL4+/brsSc3j1mjPTHtHHekpDimAJpZ?=
 =?us-ascii?Q?kGWbpTVi9mPvqXxfV3K2f4ya8VlPHRN6NZ5jp5CobaauyOAkAKraOLFCN7xu?=
 =?us-ascii?Q?QzQQEUpug27v3eiWlTU5nEe7PQFUiEjx761KtiWZL2iLw271S7+9xummbTF1?=
 =?us-ascii?Q?PAlxviIK9ev3QNPjdmrBW0+//WQGOyo4pxpG8WgIF7HFzRBhwlqN/NqIvxtl?=
 =?us-ascii?Q?i0KxwSKagpTB8wg3oPkLp+DCA7MlL0JBDZv2kCHQaFkRHNyphjqpeS1XsuXC?=
 =?us-ascii?Q?CbuOm8mhvzJBKhfkFyixyhGHkzjQtsXXvo6K9kz+b4jyoQ43mrWwW6wUxZHa?=
 =?us-ascii?Q?8w975Wuh3v6WP6xDV8u9KdD7Z9U5nJFG/mDDskvmwGuJ4wXOsayu4bDftIkl?=
 =?us-ascii?Q?i/9bXp9SlSKddVuLAFDp4ejiY0PRXpyPPJQgFc8226uKlLBUext6zkmfVGCe?=
 =?us-ascii?Q?FCADh8MJGtze7R7j/SW1pdF/r+RFytwYK6E3yEGZjJ3F4fGSooOOk4rAzNuj?=
 =?us-ascii?Q?jLs21qT4zWduOP26jYEQNnmYSbURQl9CjHHcNwyWm5+hSWfPuACOdGvEE9r+?=
 =?us-ascii?Q?x+bxfIYAqiUHwCFgxMonf5zMDwcMeN8z7Ok35Vx0Ax8gLEhB21PGx+yq+BMo?=
 =?us-ascii?Q?e6Q6SVgHjMBSAc3m+QFPxCtnFOrG/pHQ20XXKVJ6xMogTUS6VTdFamTTULm8?=
 =?us-ascii?Q?CSISrGqc47Mu9z1zdp1RdxFPxfhXKVoLTbKvYrLLmYatIsRHeYJF0k2ck3sb?=
 =?us-ascii?Q?+5JafIFFH8OqxridPYxtwJ83z51rpt177rwxgvC3PLQmudv6iwlcj8s6+1oP?=
 =?us-ascii?Q?EbKCp719eND8+wcuM6bozzVMGVzASITuDBe1VwRHmGehFQb6iYWLKXAx/3Q5?=
 =?us-ascii?Q?HOUm9+p4JbNr66Y8yM6iQXVim6r+Uthp2VcuJnZ1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fabf339-8d90-431a-155e-08dc8016bac7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 19:37:09.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujmAd3J02n95ck3B6BRD4HkHND13ohUNg0RQmQwvT+XjV2QgVzEg755T8Ka9Fhjbgc6W22SDxfM1De8xp9Ibjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7023

Convert dt-binding spi-fsl-dspi.txt to yaml format.

Addtional changes during convert:
- compatible string "fsl,ls1028a-dspi" can be followed by
fsl,ls1021a-v1.0-dspi
- Change "dspi0@4002c000" to "spi@4002c000" in example
- Reorder properties in example
- Use GIC include in example

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    pass dt_binding_check
    
    make dt_binding_check DT_SCHEMA_FILES=fsl,dspi.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/spi/fsl,dspi.example.dts
      DTC_CHK Documentation/devicetree/bindings/spi/fsl,dspi.example.dtb

 .../devicetree/bindings/spi/fsl,dspi.yaml     | 126 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ---------
 2 files changed, 126 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,dspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
new file mode 100644
index 0000000000000..12a67b2cc25c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Freescale DSPI controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,vf610-dspi
+          - fsl,ls1021a-v1.0-dspi
+          - fsl,ls1012a-dspi
+          - fsl,ls1028a-dspi
+          - fsl,ls1043a-dspi
+          - fsl,ls1046a-dspi
+          - fsl,ls1088a-dspi
+          - fsl,ls2080a-dspi
+          - fsl,ls2085a-dspi
+          - fsl,lx2160a-dspi
+      - items:
+          - enum:
+              - fsl,ls1012a-dspi
+              - fsl,ls1043a-dspi
+              - fsl,ls1046a-dspi
+              - fsl,ls1088a-dspi
+          - const: fsl,ls1021a-v1.0-dspi
+      - items:
+          - const: fsl,ls2080a-dspi
+          - const: fsl,ls2085a-dspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: dspi
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    items:
+      - const: default
+
+  spi-num-chipselects:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the number of the chipselect signals.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present the dspi device's registers are implemented
+      in big endian mode.
+
+  bus-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the slave chip chipselect signal number.
+
+  fsl,spi-cs-sck-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      a delay in nanoseconds between activating chip
+      select and the start of clock signal, at the start of a transfer.
+  fsl,spi-sck-cs-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      a delay in nanoseconds between stopping the clock
+      signal and deactivating chip select, at the end of a transfer.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - pinctrl-0
+  - pinctrl-names
+  - spi-num-chipselects
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    spi@4002c000 {
+        compatible = "fsl,vf610-dspi";
+        reg = <0x4002c000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks VF610_CLK_DSPI0>;
+        clock-names = "dspi";
+        spi-num-chipselects = <5>;
+        bus-num = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_dspi0_1>;
+        big-endian;
+
+        flash@0 {
+                compatible = "atmel,at26df081a";
+                reg = <0>;
+                spi-max-frequency = <16000000>;
+                spi-cpol;
+                spi-cpha;
+                linux,modalias = "m25p80";
+                modal = "at26df081a";
+                fsl,spi-cs-sck-delay = <100>;
+                fsl,spi-sck-cs-delay = <50>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
deleted file mode 100644
index 30a79da9c039d..0000000000000
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
-- 
2.34.1



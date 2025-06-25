Return-Path: <linux-spi+bounces-8777-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4575EAE9081
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 23:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24413A4961
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 21:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521E1E2853;
	Wed, 25 Jun 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BIhU+dtH"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011022.outbound.protection.outlook.com [52.101.65.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28651E9B04;
	Wed, 25 Jun 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888390; cv=fail; b=h2s/cH/L0A+x1vg1m227rARxix7Hr36C3J2okjvr69nUlTa/77FQmk6Qp+7ul1ZXfzef3kJSAkxYzHH53SuDbSfpGzAHuoxtwc4JDM8YFV1g9Ll06GwHg/SRlMAKqYYai0ozodoEyYXS+iscgM92SRBUXKflhZpM4f+FPJkJKXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888390; c=relaxed/simple;
	bh=PYK+aowzIzNOwRYEDvmRXs4MEeIftWPL+ZLZB8SdhOM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sq6NKqtinNM7fqJ+2MHf3fr/Qq1PwH2pODfcpuOzfDy+0MW6HSc/MW0Wu2le7mBNgUzE09SYIBMciTtct+ZZS0Sc/yxXjfikjgv6hEIYCVYfIU2IxzfNldHzDwHheJ6c5bQSWA+Ur+TRGVAkAPakgiteijyZMhE+gzuS6xEbXQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BIhU+dtH; arc=fail smtp.client-ip=52.101.65.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADwxC/NT2mzVGzlxvfarC9YrupnvbUkxKZjm9lrRxDnujNnmZOMkuvbF/wZQ8nl467dgHpCNXMhZizzsCk8zSrfZKfEWhxmFJGUaO4M5cDxnBLMYCVFWsY/8cmApUee8YO23Nr7eoYqu9qM3p45ssZc5RzR5iF2Q5qXAHyms73GgvESfPePrSNjwoiYtAMv6At+iQNpM8LbJjKb/uB6AqyuY2eRTEeq+0GZzcJBXfKDnhohE1MvgWra0HUs7qLwUu0SCqJFXdZ/w9aR5KgLK+kdleDsairzvJ4tff2zLrtqOPXdjLuh5tTNFTIkNeHItD44VhUFXgzX9d2Gh+ZY/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKrEM0v5UeYiPpwAwm6i9bN+E5Q94TGEfBo0U0OK9vM=;
 b=VCQ7HiHL4+0R84MZMUwxQiAUTeZhC/vTFdV7RFPbcSMESb5LNkwoCxmgc6jLIgk1AKOVV9whlm1dj9fDUSsOWJTItcWvhb01LzKn2NMK6hT2XwuMe2eb1OmSsmRNa+INp+OJVlBkb3CS4LlvCMOgz4tDOB2zfb/rMB+BM/JkQ74QH+5wDZKSVs+mmp8u1t5vI99rSeGc19aIHW8gFzdZuLphg46RM+g5jmc+9RXZdwyK2lXLxjs1Jm2A9K4I+iVJv0tefOz2UijUmwXWSRWBMQYa8EZWQgIWTksQAb88F6X3h84E6hbyTlN4N7Euwz34DU0V0tK9QUKzcu3zLg20Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKrEM0v5UeYiPpwAwm6i9bN+E5Q94TGEfBo0U0OK9vM=;
 b=BIhU+dtHRc30QRuwGAvTVKDBnqv/lCHWadSwHoY2VTRQpli9m6jsxm82Psj5Bs7kytqf3TcjWI8hDd13TpfCfyK72HcK8B5MHVaVMQzPUH2LR8lB9/OzAz3OglbBc1K/2vCpr8mMfkvZSkbRyX7vD6yzv1acvYV4pXbcogOTr+5O3toWAGRHCMV1dideqtpah3sli9lQSEfTuGqvTVAeUExs+xbIRRm6Eeh//5v28eOocHXusCA1qx3WfrzFF5EvkAwN3+mrwqYm9AkeaBKzhnIUtUD1jMZ8+siLmWMGAASxE0IndzvbYVkaoUiPwwpFoPn45kH3r/U+iMbLxoZSRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7723.eurprd04.prod.outlook.com (2603:10a6:10:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 21:53:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 21:53:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] spi: dt-bindings: add nxp,lpc3220-spi.yaml
Date: Wed, 25 Jun 2025 17:52:54 -0400
Message-Id: <20250625215255.2640538-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0024.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 19228463-ec12-4aa2-ad0d-08ddb432aa2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWeRo5EBNb7/cs41j3reS937ka+6RMJJgibptiVGncEbdUkADkznRyMj/dQk?=
 =?us-ascii?Q?thmFwkr9WssQf4n6xj/zsTJ8NhOCHCKM9lLApfBkgcdpAgWu4JkcnvB17Gpc?=
 =?us-ascii?Q?zsXndo6KobS5A82hEVYbblngtiJssxRG1kSRbgBbbHFvRZZ8ySJbWv0vxG03?=
 =?us-ascii?Q?zHdmQ1DE1E3MQ1WY5RMv665fbhxYtoVeLDWDIrGSGFrfwNtcC3cclkIvHLTh?=
 =?us-ascii?Q?8IdKp86T9bZbHMPzS4g4uA88DL8xHyCyJycf2BeZl0/+wXVs7r7FOOq0FESt?=
 =?us-ascii?Q?kqQv/zeBMIx9DgOQxjaQ7bZ3UBrT37JmTPZ/eZNCMimQ/GJZwFv0iEWdWsL5?=
 =?us-ascii?Q?pp9bbZULa22HV6HQ22DGiPGm1WNM0vKqS5kxY7AhcHJKcNaUN2373VOu4388?=
 =?us-ascii?Q?pum7E+izOyeqcRUxmP6tP9bxRAxaWKOv8eoX8642bl+UdGQK5bTczxzMbeiT?=
 =?us-ascii?Q?FScXwb3z4skly8Qg3UBI9fLfFNGr+ZXsBt/2wc68l4GpXfMaQ8yiOvEHY91G?=
 =?us-ascii?Q?9sfL0rlSH6ybknE2FgmJrfbRwrNNjQ/8a2WNIdQsJERaTFI2+3/x9wCFiUZ3?=
 =?us-ascii?Q?S1xuG2HNKl+X+U0zZVOBsf5G4JcX91kxfCP3BE8v8md7k1lRpaE6I9VZGub1?=
 =?us-ascii?Q?rwk3+XNliUnnIOTEm8SJrsiwijLEgVZd5xFTRnX11TWpcInny8QTORK/AGYB?=
 =?us-ascii?Q?a9wRPsdnKsMExOKGc7CKZ5M/J49RQsygWxSVLFOzp5+J8hW1RFteuvHQZasB?=
 =?us-ascii?Q?KcPskdpmFAY8caeba+eSvY36pZbX7IdHCe9wwhZS0MJWOWUYnDgeVFVo/OQ2?=
 =?us-ascii?Q?rhGcNQeqkHvQCDb5xIVN1xq0OJKU1q2a6d8P5uL0CAXoFSa3WekyVGRRtDwc?=
 =?us-ascii?Q?sV6Y5Iz+gMKvHvHsap+pK5r/F84UEvvfj0FfNufuTyzBzBWClXb+RfbT78H2?=
 =?us-ascii?Q?fXlLnUVzJjwGXu7jnr1zgoM/vo0yibYxaLbd5oP1HlTB75OXILNK4sFWWh38?=
 =?us-ascii?Q?tLG7sheCB9lDXR8Qg+5B2h5e4kIRswaWLTSE5ZygzqDZ9CShMYE+wJp9/FPp?=
 =?us-ascii?Q?J49SHpxJfRM8W9G41Uim/K6d/mSCOkU9cNElbBzIKbumda/Lb77QSoqxpmLV?=
 =?us-ascii?Q?PxychGaH9WakC4pu6Gg0tr7NPInRAu2Krxc1602qEWpjgLsbpkorCF1+z7+r?=
 =?us-ascii?Q?Lfu9YTpvXUyD4iDgkC7tsOyCNbXXsLbD3YyydyFt+tt3a8xB69o6TY5sTR1T?=
 =?us-ascii?Q?r0JdOzejB6auvIYjadD3HCBFDmSxOPuYFJVZNM3jbfpfssFPicitHpM6/Ywk?=
 =?us-ascii?Q?yJzpMp8zC+TxGPVDYHR9XvLIeUaTVh1ButoJy5ClYoTXgBPxj3F/TJlWOaRh?=
 =?us-ascii?Q?9/B5gs8VtBvFZcSLMpN6KAwX5vzbSwu5aiAY66Za2BIUw27vudC8FcaVT/gj?=
 =?us-ascii?Q?HtHGqltwgXdWoP5NcjNJUI2Fo4IXIVRp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5j/AgYW57n94s0THJF+u7MfeB+Xgdv5OMqjVm6v+/kVuIDefB1n5sjhd4WS1?=
 =?us-ascii?Q?VtLj/Ygclbt8VaTNT6VEoFJMQUE0+ZfM+uO39GafR9cBKzcxTj7uBGd6AjDS?=
 =?us-ascii?Q?dZHGiJ420l9Md80gPAm5VBadb8FK04iXHK2VmLeNfifWXLX7ixeHjanDFNfM?=
 =?us-ascii?Q?vadsiuuaHBdJSLqzmFC57OCk8g2IfNlWCdRhLYK4Ojm20hy4E92KhWByBlm/?=
 =?us-ascii?Q?s1StMqQJ/eIA5S4LGdzxeP6z9jgcPhR35ggrfDi88EST9xcfZbd7+e/Lnh17?=
 =?us-ascii?Q?EbSDQsmvJZ4eq09t1uc3w/h3Fm03SXUIMeDI0KIhgpytt8xD3EpYi0UN2Uix?=
 =?us-ascii?Q?EvW5uhvcn3Ck1KJGeOJ7p/ZOhqgF74kHKzoSd00/yv/BAxjqxnQkiFmBU0To?=
 =?us-ascii?Q?nLQ+kYHlSrrntUFh3PthbZLd+zLh1/4J6f8TO7vFDamLlpbmwGD4XMbj0OhC?=
 =?us-ascii?Q?O1/SWxrHYgfeoEAx9Jq+T9c72diX5u5nk4/zIJI8j+jStrcT5lNBuUmHJ4oN?=
 =?us-ascii?Q?gP+/deMBnVo9v6Dg/CsGiHglOFGyIMoRoYngDLROAO+tgHYHYcN5xU13x+Zf?=
 =?us-ascii?Q?df4geW17oBm1DqTrnBpB7sOGU0t0ZsNXlnaknuFbESPs8tNi+p7JKF7Vcd33?=
 =?us-ascii?Q?QOFPnlKb4Cr57DTw7xFDLftUgCmNxj/mTmoyhTY7T1z10/TK83NuLLh7+kSW?=
 =?us-ascii?Q?PdIN64bEi/sj9iDZPdtqcQKjwBWQNf+6hCO6U0jJ/LBtrp14mIAeDwEQ+heF?=
 =?us-ascii?Q?qQVDAK9lTpB0TWU3DksjQhIL+DNoJJ1OJdYZJHRy3hmincgFSJ+GTzfpE8Gi?=
 =?us-ascii?Q?AfGkXyYlDOlpZ4qq8nyXntnpdnIQT+9J6c7C/8EW6sp6U7zBUmiuv70kD0Hq?=
 =?us-ascii?Q?J+u9+MG/ywvtyLYajXPRU0AoMLQATwgVIjoKWL/qR4DynfhguiSrXctQpXB2?=
 =?us-ascii?Q?flkqVdNHMpa3dCAxnCfT1C6CBE9nUstQ0qRLVqVANOH73RU7Sv/B/m4m3v7x?=
 =?us-ascii?Q?NPAv9r7tEvGiKHBVexfCWwYED6yYhtXotpoIrEuEMdNJ4fLjEp5M/49ecNtW?=
 =?us-ascii?Q?LoyrZRPMyAX3fA6jzAlNtka0bhNaaieyB4A7jILZFnDj39i2jfV/mTbJIRT7?=
 =?us-ascii?Q?h0CHaOZmn5hoRJKbHHZDlx8GZRHg0x1ABmOftnlT4p7FWh+jMSL0qeJXxCiT?=
 =?us-ascii?Q?HQqiaf1RjiYi7nh4d0t815wIhbo0ttJmVwktSsiHJMcpn2YDNnfQnGDz3sAl?=
 =?us-ascii?Q?ffxDQGbjeyfWmTxMNzHqw3mAPAGIpiG4DMXASrWP1gTfPquJCpQ/qjw4FnJa?=
 =?us-ascii?Q?J9CSKRa3o4OLWWGyS6OhZE0MHK6MQswAsrextP4zwOlugYg9xFpIXrYae2Eo?=
 =?us-ascii?Q?oKnrNwCib949N/9ueO4DJBov5wQZWI8Fufp7rkfyAqFoFb4B8Y16vRPG/Xl8?=
 =?us-ascii?Q?Tif7kDah4tQr1E2f57xyKCeYnL3WWJ8yO2QTGN+SURBCUgGEH7qFX5zbRehI?=
 =?us-ascii?Q?y2oDjaAwY9+3NpWZBp1QhmGcMnsJa90jOISfc9gOr6MPA7mjf50TdiiD80q3?=
 =?us-ascii?Q?wFZ//5Eh2Db5inXpkyy6w9WtjUKKc2PHhU8/dnGo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19228463-ec12-4aa2-ad0d-08ddb432aa2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:53:05.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pkx/GQdjLngE/6VQ5PlaSHnOUvS8zIWPVRCHc5Jri9MakB+UwOJbzRcgADs/csxvTyA26Um8bp3QCO6iPbsOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7723

Add lpc3220 spi controller binding doc to fix below CHECK_DTBS warning:
  arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: /ahb/apb/spi@20088000: failed to match any schema with compatible: ['nxp,lpc3220-spi']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/spi/nxp,lpc3220-spi.yaml         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml b/Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml
new file mode 100644
index 0000000000000..d5f780912f21e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,lpc3220-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC3220 SPI controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,lpc3220-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc32xx-clock.h>
+
+    spi@20088000 {
+        compatible = "nxp,lpc3220-spi";
+        reg = <0x20088000 0x1000>;
+        clocks = <&clk LPC32XX_CLK_SPI1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
-- 
2.34.1



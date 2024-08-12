Return-Path: <linux-spi+bounces-4172-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578894F83C
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF76B281F99
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE6194089;
	Mon, 12 Aug 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TpPklIff"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013042.outbound.protection.outlook.com [52.101.67.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3A14B978;
	Mon, 12 Aug 2024 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494625; cv=fail; b=BSnAUTymkUDw/pzs50KQM10J4LJLq3/cT7gxHkOBbnzbgdscmCEPHsaGT2ou0Yn/zrpMmXYW4eY3XgMUxY+FyZefQV5DnPipGm0wEXifpSGO9YejGvkV4Kv366ybJXbN8Zwbq2bSNlcH1TqsFiP5chv9WXVZtjTI9+cl9ZHqNhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494625; c=relaxed/simple;
	bh=RG/J6lZkeW9nJCcGyQ3nUkUAeE8Eciwa6FQ9X4azfXc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E+5LIflfEx3psHoOjAn5L9zDE7Acs6JR33/5u8007YjSrfbvmfGDBVWp8uEn9qHUPBCxSRtLdvnnh4usuJ6zQAG84G3mFz3iy4F89u59vO/APtaY6FLTLEN991gTpUKIMSdIsW72rLTrqoi38OWVeyku8SfWVCHY7LrjcPak07Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TpPklIff; arc=fail smtp.client-ip=52.101.67.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLd4gOMiY8MSFP1c6xJD3vtdJBCgBV5DwSysZ6cz8BnSA41i7I+FZRAwiasweLhQUsBNOjEKbPN0D6l/msTMkVTCFBBpB+slNHaaQHIq67vaImC+4IWn/id2myUpL5KJYLX+MQZG9G85CB826jABYnNj287NoBCtifyL4qW64LqD3NT4iCkzueswzRNiTu1Cr5UzTJ6h1cf8hPc2x8z7JBBAi9huSGTPJz3VXfseRiwN4f0AoXLn54/FsrcEXeGEmZkn0s5pm1822P//Xd4WmLe4bncJzO4d0plsn4Qd3Ewj/8eowL+Gz6X7dzHwnjgffMYiX6pGb9hLxG1I6a5uLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swF0eufgu6fkg6M6nrmI/ksFOgqT0nwkzJ6YMGRs4OI=;
 b=cxiOYV5ZrRujvNKzQY0unX+YR9ovV8As0m0Ar7LVFAP5nzG8aDTfZV0oebicZDFpkn4LUdVcKk0OpEeQzcjhs0X0Guhn3EZ1ffflt/jFTwhfnpkSbRAj53Sj5HuXZm3p3ThrNpv/gbS3X6pUmQUkXBHI6aezt5hDNlUfSVlrv+83Aga1qYuw9QbbW8EZGpVnWuAGyZDCPZw/NDDMBVyTKtSPSuSzM8I17jj/NHPtbWOqToAPNBnCNo0W9+/AH/LFt6saA7IfqBdVAkq187oFVRjTQxFOoCB7oTQTAm0rXBwBZ6eYgWNo+ELlrvvRJyIyhHeB6OURKEjfTqznu0fYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swF0eufgu6fkg6M6nrmI/ksFOgqT0nwkzJ6YMGRs4OI=;
 b=TpPklIffdlYufuPSBpYTjD+3WoIN84uSjBWvOwuXio6MTkeb2qG+ZRUqVTCTMGdHrcjnccpemKF43R0kY7Y1lhqTm1MdVd6EDskICafcjFn7DZPhSzbVLfysEAYdhnP3m27KcMaN31QsWG06cynsTyKQImVUSMIBe9Mc2wJW4xKjGrO3p6vuh0af/3KFNexUFJEcVGPITd9gmUJX8Lz/GSJHo+lCXAlCMFZ6D+cdvSktzIR0Rq3wdNSoOjY+A77Vi0kcRv63AScrS8HuP6ja4YomanSAkKwnr9R22ks1LKVhTeyotJPzUEJ91SBOsAraaQ9eIBvEwny1xcrc+KOwzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 20:30:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 20:30:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] spi: dt-bindings: convert spi-sc18is602.txt to yaml format
Date: Mon, 12 Aug 2024 16:30:03 -0400
Message-Id: <20240812203004.3831481-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2a60e0-0811-4114-c8f5-08dcbb0d954d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nM6xFsEQfjwNteQ4njnmDaq7+PhbCiw5VJB0bs3bdz8QWjTGTUerS0b0BL/X?=
 =?us-ascii?Q?w0jgCKW+g9skM+SR2rYGLCQIbQ/+MWOUQ+rCiK877FrIEJF7JWqbL6WX2phg?=
 =?us-ascii?Q?Ncw4B5JIaRZ1UbOxevL2CYMVMKTtXlQJpk7cHIOuRVJ7RsjDviI3MYgvTSmW?=
 =?us-ascii?Q?CAJ5Wi5el6iKODaxIGVnvcVk/30UuG6B6HzBOw3H2NJs+eyq257HfabmhXaK?=
 =?us-ascii?Q?XDYT9N6p+d8UVLer6Pp6KhHA3qm/DxdbSanLDp8FhjcHSfINKq8nu09J7A5X?=
 =?us-ascii?Q?mO6BSRPWCZBs764BNBm7gxPY3L4xTsb0Y+w98rT7O2v9lqTTFXsNNkB48Zwc?=
 =?us-ascii?Q?yNmzE90oBS28bF0lio4dVlYASSN59Cya2kfIqHTMKKem4IXxGIcmL6yVxcSp?=
 =?us-ascii?Q?Ewn6nQTWMzcNSvlDjiw3Itz7rDLnKwbnq755ypSx93AaFqnnXJNdwy2EUYNK?=
 =?us-ascii?Q?UPdeg1W2f9Oceq4s3zZGDUqVI2zzisua/+B93kV+HBSi5JQIbCBY3F0HYjqU?=
 =?us-ascii?Q?qKN3vVi3jbSiUZWBvwWKxFkdiNrg+UhEVoXP7kq+74wypK9w+7UMo8jHyuEL?=
 =?us-ascii?Q?rwPDJZRwEX81SxLE2qHE+DWHaRn0AJCJe4JF4TnW6dDd3R1TqNJublSjzaAL?=
 =?us-ascii?Q?M18UE2T+CArPa7DcfqIA6iQTvMXRmn/tXhwRvCeMvRlruLjnXLaa5KSbXF8d?=
 =?us-ascii?Q?z2jjwHXZaF6BLA8CxVs2N9Hc4dEyPS8oni69ulx7eS/zmOYGPZREHXg5+6j+?=
 =?us-ascii?Q?A5TXTen4NDZgrwmiJ9qA4vFnIag3aSsh4pA5lLMjiVKdQdpA8Oh1zgOytHOj?=
 =?us-ascii?Q?zKDhj1Z1Vp5649UYVuTOoBNklVpjVbnBYoop/RZ0O9uJ0zu0b5nLBzj6qEqW?=
 =?us-ascii?Q?FMzhRKAihf1vDwExH5t1wLNrUWeP/h1ipOxTYdf1+3brgCDRwYow+vAgdmcv?=
 =?us-ascii?Q?XmqedxawS6wf6BtgmX+XsYFqh6ihhrssuTOP6jhWRk/rZGzTorLYTzEdSa8B?=
 =?us-ascii?Q?8WkGTWgwfGk/sxUMZ+1BL2O6vBhA3jWx5UkpRM2FtswKrW58B7zzUdUfDLrY?=
 =?us-ascii?Q?FzfOhYbDVdmaGFNt1qmjiz7uR7FsspPzyPB5f+l70JByOuNwJnm1NXhiy9BJ?=
 =?us-ascii?Q?voZLDMOSYUYvidHChjDjdDrXkf7fTWepM7AuvX212G8UizM8WMVdD5849J3y?=
 =?us-ascii?Q?34Ps394RS6EwcNldY88L2YBj/ountetk9dMoSIWklkGjRANCcDelnLUhHtqs?=
 =?us-ascii?Q?CsnOTosX9dfByTutdv0bzay3A6O8gsF65ieCMWrcKnpF9+GKA70m1njpyoWR?=
 =?us-ascii?Q?/z0/kZ7I1x6EXDTl3bOj5ew5K9kTpU/aEKAUTOx8mb0XRgKZlNsXVb1/E6oj?=
 =?us-ascii?Q?VxlobKA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5yFJgaQxR+VgWqgcpaZ4NhH3C3aYDzfEO858ShxfzITE0Yipsa69ON2S6cUs?=
 =?us-ascii?Q?zjVyj+U9qCu4ub6cwA5Uiy47otVnBs+YHdAvGjH3bsJGsM/iGjfapfiqwZk4?=
 =?us-ascii?Q?DZph/xhopcxazR7QxUf1u5oryaQmw9dZEq+yGJvXRPf6wjaa4UsMJU6ead7o?=
 =?us-ascii?Q?/6L4gFbHtN16066sw+Qh3CHooGLTa+FhqmCQlLPVcLzgm41j5ZalitUmk7Ct?=
 =?us-ascii?Q?AkU3BUd2LOsUnq8nqXYyA8De5x4KxKxs+znB37M5XYk0HCpK+xyLjhEarCFf?=
 =?us-ascii?Q?HJrnDNTXrDhhBsrz06UztExI1Tf1/3QDsR+RtulQca3XefzSrmRFmo5LdLfH?=
 =?us-ascii?Q?SnXzlLDIu2a333GwEl2k84RL1Aqli779XxkYGi8+K7FKqehVCCJjHOrcztTK?=
 =?us-ascii?Q?6K6QPVRuIMJP37gd9qF6mwA3OpG1lNjdKTShclZGc/v17YbyIUGbojuxXLyF?=
 =?us-ascii?Q?Rw8ojfLGdmwXWuj6WyinlJV9vU7lIy4gOXYpmSSl08ZD+5O4ACx7Z+FfJZkx?=
 =?us-ascii?Q?ktktK1zo8qppvAUNO2nkrCGYPkufkpt93bUeCatEv7mWeifEnvwHdvujfsjO?=
 =?us-ascii?Q?YnmC8PYcORzW4AIq8ufDDloBoIUpBJPIR0utaySv6gWFUTiz5kMNVuo5h5l/?=
 =?us-ascii?Q?xNA7DkVVKBFQ2wL8XOeoN9qLUMfYJtL9o1DDiy6KgSPTPzbmhNR76XXuOjjT?=
 =?us-ascii?Q?WTcgtMf0RdMvgjVj75853125KomRBgRfZjLEgzb3uYQ9H5/180QFygaTFMkD?=
 =?us-ascii?Q?DOOFGqNrPXbS3FibzX6Og3MtioUOy/jHuH3bylOfQPJ763d4opq5k0SdnCXW?=
 =?us-ascii?Q?TzpyRcasXuRHMa+lqt/oWBtmnGZ+4fppv1ndmVvQNzmOgrCjM6g315ZgAiXo?=
 =?us-ascii?Q?Hr0pGqtOfv+pIe4kYorKvdBo3hgcCZuIO43SnDP9JvlvcwF7U+LT1rd/KgHB?=
 =?us-ascii?Q?qlahjP55BEwHbYTEAPK2YXMmZNzkVfqG8m/Ay2v2Ja01ayOK6OdKZoHH9Qw/?=
 =?us-ascii?Q?RRKJaqbm5jKgk0A1JPaRmIb/K2MefSHu5cQF9qkBtqiARYO4lPc+ELxfaxK7?=
 =?us-ascii?Q?ORGcOd4RqONEYyYwqDO56OyHfuixXmfJqIqHZmPFPeB9b8lctvjwEKJaSNJw?=
 =?us-ascii?Q?jc8hmgo6RDYypKrvlHAk/Icao3i0lkjRGRtXhkPww9sWMWUT9DowT3U4V44t?=
 =?us-ascii?Q?CXgGzub6o3ykFkzG9huOZewR0emDkyrFQkqYIFZpSAqajHeqk24i0PwMSxJf?=
 =?us-ascii?Q?P4KKUt1FjP8Tup7xhuN5kfz3JlwQO3kPzcWQGPIKUKbn1uaeW9kUDaLZaheH?=
 =?us-ascii?Q?YpgG/57IXFT/3WuppTtXm+m2pqsL+xsrnJC/Ttz3vjpl3rM7V0S/dFEyZ4jf?=
 =?us-ascii?Q?7N9HKnLr0IF24QWRhIlCLgsnTk9mS6hxoVBPQveAwtqIBqYqB6B1f9wJ7fY5?=
 =?us-ascii?Q?68t0EqanqrfXYSy6v/iMEDl+4+1xS7TZSl/JvpTz0OsXdfQSzJevxTmAtNKM?=
 =?us-ascii?Q?46zdRpbWNLJSspT2MhHVwnlRW53wFYKlUKhxT9RY6INTC4SjX3/nU0W8nmQJ?=
 =?us-ascii?Q?iit4M9npY0h9ZCWjYerRiPta+Zg3C9jOsE15PMUy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2a60e0-0811-4114-c8f5-08dcbb0d954d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 20:30:19.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FgRHsojrYT2WfhRsJukMTbg+mulSJWTEYpnYBYB/Me12ukNqL3z3NzcaS/TyC1Y9x+g8rqtfIwu5UI4Jz2j0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

Convert binding doc spi-sc18is602.txt (I2C to SPI bridge) to yaml.

Additional change:
- ref spi-controller.yaml

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
/soc/i2c@2000000/i2c-mux@77/i2c@7/i2c-mux@75/i2c@0/spi@28: failed to match any schema with compatible: ['nxp,sc18is602b']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/spi/nxp,sc18is.yaml   | 52 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-sc18is602.txt | 23 --------
 2 files changed, 52 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sc18is602.txt

diff --git a/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml b/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
new file mode 100644
index 0000000000000..8a5d45d976984
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,sc18is.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SC18IS602/SCIS603 I2C to SPI bridge
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,sc18is602
+      - nxp,sc18is602b
+      - nxp,sc18is603
+
+  reg:
+    maxItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 7372000
+    description:
+      external oscillator clock frequency. If not specified, the SC18IS602
+      default frequency (7372000) will be used. The clock-frequency
+      property is relevant and needed only if the chip has an external
+      oscillator (SC18IS603).
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi@28 {
+            compatible = "nxp,sc18is603";
+            reg = <0x28>;
+            clock-frequency = <14744000>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/spi-sc18is602.txt b/Documentation/devicetree/bindings/spi/spi-sc18is602.txt
deleted file mode 100644
index 02f9033270a24..0000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sc18is602.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-NXP SC18IS602/SCIS603
-
-Required properties:
-	- compatible : Should be one of
-		"nxp,sc18is602"
-		"nxp,sc18is602b"
-		"nxp,sc18is603"
-	- reg: I2C bus address
-
-Optional properties:
-	- clock-frequency : external oscillator clock frequency. If not
-	  specified, the SC18IS602 default frequency (7372000) will be used.
-
-The clock-frequency property is relevant and needed only if the chip has an
-external oscillator (SC18IS603).
-
-Example:
-
-	sc18is603@28 {
-		compatible = "nxp,sc18is603";
-		reg = <0x28>;
-		clock-frequency = <14744000>;
-	}
-- 
2.34.1



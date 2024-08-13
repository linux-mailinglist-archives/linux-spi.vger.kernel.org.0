Return-Path: <linux-spi+bounces-4176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2D950955
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABE9B263E2
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A091A08BA;
	Tue, 13 Aug 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BYIRN66d"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E851A0725;
	Tue, 13 Aug 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563906; cv=fail; b=eFvQu9fj8tOZsHwkDr7o/ai91IU0I10JkdBrkKJJtAPqNmkBoVJCxodttP0zSH2VTJJnRJISvuFNkuOo1jeRG20kb22NpbxA/2v7UfnVZg5tpHQlNZempIr96k1LbX4aoN0pBwCgtm5O1Y9Z2JwkoHj7SuPNLD5Fmm95xhFIdDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563906; c=relaxed/simple;
	bh=znoUT3a0ItjRA54BoCSzmvklPP3svTnW33HvMApCT6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ubu5nODY7tlpW2jubd0g5Nk764AH/eLTwxWun3dsxudBctHismvSamcWViXJtbHfko5RBl4icraTEOxbYZLBPA5NzoLisuEcgTxTpus7uvP1Q9t803Ip/DSBrT1nCZqWCf8nhj/zOUlyl93E0s7XhS9XlLnjj8FqGAhfdveZtM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BYIRN66d; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMWpNmLUN+Bq4hTIIUshqZf2OGbkMG8HGBTOHKkK/DzQt9v5Ysl0b3Y5+CFKDqe4VgUSVVc3Yy133vToFeqEc3eNWPU/O36PD3nC0HojIRaDtejkG1T8gEM0SAGjML0GwENSVSpNTmiOriW+0GB0gclryGQvD2AnFS2Lrz6LSwnBTYuVYCxJlUcBa7fTdaJmfDssuGz0I0fm3fLjfyyZBbG8iJQtH7YBwJ8bPmdj3dRxVya4h0zda/e7VzxWuyxUveZFigq+AsOLZxwDbEtARQ2jDVTJwYdXJ2YTgxtdnyPJDdTm/dMsMb83XRwOuTpiiWJNU+BqPCoIR0PyLB4uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpT09PKC9Dw95QKP4+2QLCXQiQCx5sTFMe7qU37SFqw=;
 b=HDt4LxycdG9phxFCFmpcG5dUkanffxdr45vpGziTqG+/0hb0pJh/Gqq17Sz+hGR96JY1wVh446mPP904r8HH8n0DsCS2SefnJuAAmYauqS1j2+O7kemNO5gpGVcRyEP0jUpTbLzVDSpCKq9TmK8uWy2MB8sS2LRyrQYlcBjpfkvPiP6U+kJUoQnzJFgaN8g3BVbfWNfVl9ZHKm+6Muw9PluwxlEb29jxBncdsdAzjprWN48O1nrb4hvnaSzmRWJJvARKXvTpjGJBVaUn6CV+qlw3pHLspss/v+rnxCgPNn0ZQAOfOuMQ3Ddmg7r/mszLXWsXnxUio+Ypo+3GNBEzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpT09PKC9Dw95QKP4+2QLCXQiQCx5sTFMe7qU37SFqw=;
 b=BYIRN66dPNnugM8aSwEYeSp+pPGFlfAyFF2/Tu1CBGe7jEcSlWzUVi52axbwNo8SyaiALtzfesZfheSGXLxf1zwayLYYduMaol32BS6qHzypgzdDe4M2uyeDH8GBq9JrrRnJ/eVoRGW2LGi/ICh44qOthsJlQP9ziTkbBu8+xvyw2le9mG3m2Rjp0pA3T/rrFcdxlSmNATJARvMiC//YlbWGKU14hDgTeNJ6GyfEyjGmxFW11adK2P9XAwIX9h9YoH2Td01J5x5TzjKg99MLrUwRRkY+YTrqfGf7nOp2qHWl7oXHL07lkDEoQiS1gBjksjmgDvCFEWUEwlauW3c+zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:44:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:44:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] spi: dt-bindings: convert spi-sc18is602.txt to yaml format
Date: Tue, 13 Aug 2024 11:44:43 -0400
Message-Id: <20240813154444.3886690-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7737da-3a73-4c01-4f48-08dcbbaee393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XloeWluIEQqQxtxxmbsfqDoCtKXI4OXQjDed1ZfIu6/R7fUsi1CWEmKIe2+y?=
 =?us-ascii?Q?Tvi/j1FFnSUg4y85IpgNRX2NighNi/lZSedCmIzS+beq6FibHpjwk+NtcjOL?=
 =?us-ascii?Q?V1XHtuYwFIvLJF3l3Dh/v298Tjt3GXBt0MnWmHVxe6MW/QpzlN+LVhbJ2UeT?=
 =?us-ascii?Q?aaWxhqEjaxvqz1kGVJ+5FWBacprWgM2IxPmD20B4JwOpaK8cuoy5lSfK5L4o?=
 =?us-ascii?Q?LybDUbcaM8dXuUtq3/OSfp+6t4nY9P08fCEZDoUS3T2WxK0+PQGjJuXrPfgx?=
 =?us-ascii?Q?OjQLb9sqx8GzSaI6yNb7PrUaktYiLkLJYwOEnRKLCOjnJCjppYr1wollFlix?=
 =?us-ascii?Q?vP8WPir11kMLYC8nrry++Bq5j1txfFacGhpfAUBvHawGsKMWFaJSHN9RedMi?=
 =?us-ascii?Q?SgcwJL5jsxdtSsHKTwOR/ZzlZf4Nt/egQS2xPMdRDE0gGOddyYl7oEf6Yur+?=
 =?us-ascii?Q?ZU66LzVed/2pIcAqEk6rHaLa7rvS1AwAfixF/f0zccvsg1wnOKhVN9rzGbYm?=
 =?us-ascii?Q?MdmMWdvypNc7HnKDSuVSgFU9V6fQRNoACu8RsdPCArVgOPg0tCeXu7mGeOfp?=
 =?us-ascii?Q?u8+OSkbs4mYWqKZIH9P6GESKXqeXD0rTAofw87dV3S4loAo/XvtlK3EUtp3o?=
 =?us-ascii?Q?TDDPpbgTIygA8aktZr+XpTXd88CgKF2zM6VcrvlR3dwYb2JHiK9aYDKpJS5T?=
 =?us-ascii?Q?P0dDSxT5KSLGuzy5/4/4jZ7SOQ6hleYpEkcpnM3ow/yUN4fwq0DyVRoXBFBd?=
 =?us-ascii?Q?+adNipGUT9916AWFtW2LRZHN9bMgZU4KkUkhuwkloTse6/NJUs+Xis9++xEM?=
 =?us-ascii?Q?BwVAfn4xJ+8wJYK6PfUt9rrdBjv3oIXuzJ+j8Byetibl2gsHf1ebwTWxnD30?=
 =?us-ascii?Q?ICffn0B9oYyvj/baY6YKK5aWYktN3gQXksJpsW5+LX7V+YxZSJWA1ReQWzqo?=
 =?us-ascii?Q?GHMCob58ZoaDfhar0KNrRxU64GKez8A/KTZm95126FqemYeRJxiXYJbE2u6g?=
 =?us-ascii?Q?Ma4nIffGwbmK+zDdt7UCsqErEpVnMgpueyqq5qZdea450Xy7jJeekEmTJCxV?=
 =?us-ascii?Q?hAqZgepXE9Y5AZOOb4M3zU2UL89bSmmlXRvfdngpBjjUEWAZauyyJeXmTsM+?=
 =?us-ascii?Q?VPVAo0iKhw6z94FxoFAv1hL0e2Gig0IoXQsb6qxLAUKNb6O9KvPtcM/kpuy/?=
 =?us-ascii?Q?BHmYg5r19OWJ6/s/3BMlzSglhRV/kYk2z74jQJJbxHtYUD9dnW/TpOnkX7iA?=
 =?us-ascii?Q?81Vt6wKth2wFB5RUbalNKqQv/ZUZq1n8RYxetqY+0+sUj8Ma4acb6aVLc0Dg?=
 =?us-ascii?Q?TMIrR93OTypbhu1TrOEAK4spGNMVdo1s7LjMSbX0PJGOH4k0NmVgAlyF1Htu?=
 =?us-ascii?Q?0jwMFLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g7D6k+OKu1qxAx+hrWjd2tRV88KOjkGGorlKVsdFMm+PKcwm2faFZhOnQcIh?=
 =?us-ascii?Q?a2ntXa7hmcWJQvl1+MZSK2r89ZEadLzngEPhPcBy0qYZVxCFr86AkFNY0NrU?=
 =?us-ascii?Q?NCTqVqkk+aicQ30yN/VwSYyz4bgkX2j1f/Pe0OEztgdrDE3aiM3cie2erc6A?=
 =?us-ascii?Q?HEQ+TZgt1z1qbzypQ6natjwB+RjvAzVIhwwZ4xpv2i9BgZBBoRjqADirJXiK?=
 =?us-ascii?Q?44m24/LTOyb+j2Qu27ae8vCjMbuSNyAtIPPmHT00/FhbKlJHipy/hdu5gkJ2?=
 =?us-ascii?Q?jT2DezAVuWILIhCPBtcdthbFCaKxg5T9FKrQNYZ0SwrGKPXVKIs2YaBhnUOr?=
 =?us-ascii?Q?nVZb5BZ+ibvQ/MBB8l4a3+gCFq4L95iMdPZTLpkELyfOHzmGyNCxbD4kuAl9?=
 =?us-ascii?Q?cLQlPSfYlZrLONtaBXNS5VQ1a7LK/lmzcapnQs+iKIaX7rjtxbUWTzvJ7G+p?=
 =?us-ascii?Q?Vm7n4tt1dItx5VLo5Gl/ciuXzRztkggsNaiRM/0HUzKPSEw8lfvGpGZ/k0Ry?=
 =?us-ascii?Q?2GROFYvHAtdS/04E5aVu4fKpTWG6u9lLb23aPzFhYQOakmwp/5NlmnqKZzrT?=
 =?us-ascii?Q?c1RX42SPFLfcpsHgFNYd8fjhKvPvlD5rURMCw4GLPoaPaa3hk8Kst62xdjEN?=
 =?us-ascii?Q?fzmX06p0olR8yHR1qZ9gjJVY5ImpOrgmfZAtsD4VHd/UNAOjD38JvPEoA5GU?=
 =?us-ascii?Q?CSkN/i+YWEjHNmM38EFE8MJh1xQTJKHBJqLlAOIO1U4ADngY6qIsjd8at90A?=
 =?us-ascii?Q?h/ogKZXZ2QnVOcT5aHmjBL0bcy5hCd8jnwC4Kgdt7emgXgbwmXPkIsaWhlIU?=
 =?us-ascii?Q?JPEtPTzGfA1rfpk/nw6WGz3JYAPSx4UJI7h38HYEmhzcggvvaOQJyFZq7dV0?=
 =?us-ascii?Q?jYZGQkC8m1ixHiJL5bIRrDTt/yct5bQycoPToFAWixajdjzbZ0PawZmhB719?=
 =?us-ascii?Q?XnQoTPgilbk6xLXrP5iMY60QEXqXe7hGXfVSqDLJG8RWsQJ/2Ub3Stif/fBT?=
 =?us-ascii?Q?+Su4+VMna7nx99r0aZUE66DmBGfxDcIkRtwwq/K+VQxmu0vNNBsRMzg3eqaf?=
 =?us-ascii?Q?knwez4ATpu8FnyH8DM5By1Q0j5oEDC/en4kfVaXm89YOIWQEB6+QnVw07Qyf?=
 =?us-ascii?Q?badGzW1WcxeHwT9cch/odL7FaAyFdLg8mXThKHPTUdVoZpdP6b9XPSEkQqtu?=
 =?us-ascii?Q?6VgwU6zm2idXdKDp0Miv2QpeYln9lqnTeZQOFoarkcffpWKlOngL4X4V7f/y?=
 =?us-ascii?Q?GgLYWNgtb+Q41WO33Qn72Wys7jGHcZb1DWcqUJH008pjaU5OfXby+UdMUbTg?=
 =?us-ascii?Q?slvjrzaItb2FssG5CTAukCuj0JgBMerFS6HBiLWa3bkliwVYiHiIrE62yAaN?=
 =?us-ascii?Q?fMc1Pe5rpZTfsTT2PpX1kESuI7ySrVZRI8n2UIylx4q5gYYBj/fGH1AWsUDs?=
 =?us-ascii?Q?WP3lJpa09YQC6DTfD5zro5CFhFK85+BQjRGzw/7Itdwp220DSSwwQ4eT5s0i?=
 =?us-ascii?Q?vwXZW9nzYXquLZpc7slavnWFp8w//2YAKyVEEwpFRjR/9DpxJZYDJ64tEaHv?=
 =?us-ascii?Q?+THZHpgzXmObJ3Cfp5YefaM5NkF8WKUPPp93lsqj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7737da-3a73-4c01-4f48-08dcbbaee393
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:44:59.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VquFubMgtHRR3R89u9mr+mNEVmRA/jyBitJBXjOThjJOhZDHb7XVvqpk8GXYgay3AO18qXMpa5vuYG6jymFd1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

Convert binding doc spi-sc18is602.txt (I2C to SPI bridge) to yaml.

Additional change:
- ref spi-controller.yaml

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
/soc/i2c@2000000/i2c-mux@77/i2c@7/i2c-mux@75/i2c@0/spi@28: failed to match any schema with compatible: ['nxp,sc18is602b']

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- fix typo SCIS603
- drop "default frequency (7372000) will be used"
- Add Rob review tag
---
 .../devicetree/bindings/spi/nxp,sc18is.yaml   | 51 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-sc18is602.txt | 23 ---------
 2 files changed, 51 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sc18is602.txt

diff --git a/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml b/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
new file mode 100644
index 0000000000000..43753a94837c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,sc18is.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SC18IS602/SC18IS603 I2C to SPI bridge
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
+      external oscillator clock frequency. The clock-frequency property is
+      relevant and needed only if the chip has an external oscillator
+      (SC18IS603).
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



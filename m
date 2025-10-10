Return-Path: <linux-spi+bounces-10502-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ECABCB852
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5DB1A60DA8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847152701C0;
	Fri, 10 Oct 2025 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="AQyPeTzS"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022141.outbound.protection.outlook.com [52.101.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE826CE37;
	Fri, 10 Oct 2025 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067121; cv=fail; b=dJrundcgGz98lHMlnQN5DB7WFkNzp8qxnunTBdr+b4Yr5JqKt/p/Ey/mxOM3lJyKqcMT/7l8ZsDYejh1sJpFBymgGSDaYc4wK8PhZQgx7aPXgxTtio052OmwrhXoj/ggqNX4b5COnjvUZIrP/baWafwuUYf3Ofb0zHZ4rBuV2OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067121; c=relaxed/simple;
	bh=obHIhFUcGxmWKO6movIYZRxfkEvNHpdj1r8QrGoJf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gleUoSWzjSfqlBjMG4lFemesgVVIAet4jdytv0DuLO6jj6kBR3qnDsUV1f+uF6cI0wERfnLs7aanfRErkpqW5LewezqRkx5aac53OnZR6E1FFJok4dNZo23YwwnEAALCV4bZpdPnWpIFm80agSQuZt3PoLEDcH4BdEUVOi9+w7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=AQyPeTzS; arc=fail smtp.client-ip=52.101.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/ve/aodSYigB4SYaoQiwAZfCGxivfhJDr8NvKDguCyALEUcbyI4irAaVhKD3gLtnj4a7hlVnCytjx7L0PKvzzNMA6nvFoQ+rEmJH/PNqv/tLhK/BnbIabdj8gNiKv23EyJnXzW1dszreqYH5Zv1d56tRNXDDONw4dgZg4abEbuhWDTUzkYKLXNtj5c5Gl7jIz2tw5gGveZAiOTHIMe8dI7LGaOMaf+C6Q5kDwsSgKnOCQ3f/PoXoba7hq+6UMKNisfyYu75m6ooRlsfZYk2CfIP/dDMCC1hd2qvBXNdD6UNk07MHiHORaYQI46lPdIRfuoSXnWIqjmKcS1djMlnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=QxObpDnpogyPKyrsDXqRioMff1pKheth7oHWvA/oO0AHg3VA/ohGzcE3viGEFllCywTPMzcvLoPbHAyPdziFG/q2KFzq6g9kEpn4abXxLcB6D2Vv1gdWTafHv9kqmwlMLsjaYLk4ZNliJnp8WBVT+6do8g/SD+7SxIfnVy0LBNgXqvjUg8oacLJSbavV4HFYMJq1v/SENK0JLGkLjN4AcPVWgJOQG4e6WgJ1eWay5K6aZB6YJ2mr54GUqRIgwbWKUkQxxmAq2rUd17WznmwNIeH5wDtvFxuB+U0LowCy4vpmpuqczTOeYFTrpB9pK54lq9GlpgDh6DwOYuf7ZwvqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=AQyPeTzSyAhNDt1idk22CnLWM2+jV+Wi7Hm62LLSmB19muf0ws6YOC8ojuQCM+riUExU4Bn6ygfLsI8IF97mUjFG5l/qAxOtgT4BmzuxDl5Q6nlH2TaX7vq2TZ0Bdiq1WgKLFNXMySK/3IshPZ42KYvrknP/l3XquDhCEJLkDJdATUMuuQk3iIKAQaNHD1AZTa+Ik/TDZhThXGKq9J/PbGhXMLizbW4T7lMd0bexamaNu2OJfqF0Q85lkfnARLoPvJ+2mTVoTzQUHpX/BDjDyB26Iupw/cSTHmxVpfOvum143FD6IEOP8OWwvUL4orYJ0xs9jU77PEplECPv67L7zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 02/17] spi: airoha: remove unnecessary restriction length
Date: Fri, 10 Oct 2025 06:31:21 +0300
Message-ID: <20251010033136.1475673-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3059d7-8bf3-46f4-e142-08de07ad8b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XPq28jxFn1rdJmolX61e9V2mdimTOPyQRR9iAfyRoKPkQaVPcVghYauHdEe4?=
 =?us-ascii?Q?Uc3KbRxydl1Mv6UiCzwyZ2qj00GacC0mot6cZvG01BHYhoJ0Kgq0ORe2lSpv?=
 =?us-ascii?Q?pcT73WyE4uZNA6CwCYLtJzydETANJsH4TpczgLR3DBv697GFdnimfqK9k8Ir?=
 =?us-ascii?Q?icFBmL2skyblJvGufCrp4jGdHzeONJuLaFToFdkJStGzWJUHbRKe76arJtn2?=
 =?us-ascii?Q?dZlksI17hGeSQmWUn2e+0klMx6vzgcQexChLbvz/xOk7PzG7SRtW13+kus6X?=
 =?us-ascii?Q?PP9IArT4Ldtt201/gTm6AKuOgGiTABZDRd79tv12IUrXSuLlkl9jkFk+IA0t?=
 =?us-ascii?Q?T3TOgubmwT5+7CPFX1nBSR8gDjYhmToC+31C486nTKQlnfgXRU+gGvxcyUuI?=
 =?us-ascii?Q?iP4zTvUAkUhorKpvoPJUINQD4tFDoyDmZXoNBkLkpxUetgwpgQisd3yUK8bz?=
 =?us-ascii?Q?5a0ETKpVWX1IMcal+T1GRxLn+hkldJhonY4lsBh9yHVpX7o7OUk/AD/pUnJf?=
 =?us-ascii?Q?/GpSRa8BqWz08CzV8szQlqv12ZjtYZefjKcYCxdmPzq6c0ZMjVEstwFbc4vr?=
 =?us-ascii?Q?8Ztghg9Mz/a0nQiPjtKtBQdbtqxAoxhhYoYth6JFM0V73AJ+9CCxX+U4Nth+?=
 =?us-ascii?Q?tTUQ9puSY+4xeSSjv4WQew1hNANF0EAr6YvZ1uCA+kCK64BfZ/QkBgS1odv7?=
 =?us-ascii?Q?xjXsUp6zuIBEZko5plwuwCginq5kIEvrMiSzMkhRHnV7vdSwgYN6dC+VYwRx?=
 =?us-ascii?Q?lVKUtPEs/ml3VKfmqgJPT2n+/ngaz29FxOHbgQJqyMSaXtlR6/lYUG5a04Mo?=
 =?us-ascii?Q?Lcfc3GpWF+raGPIrn4G4/cMimIa831j+wwWCSkoIXCLaqfzOPWXH5dXcT1a5?=
 =?us-ascii?Q?PjmI/42vLddbIr8nSffUuwmrKOLOPGYrDNWPQfGltfu3NZwYWdpSBz3Ykvos?=
 =?us-ascii?Q?G7ez5jpTcOZZ47O9fr/3W4yzL5MiAZCOSPI9hRq25Xr1erMaqkRPdUIS3kPQ?=
 =?us-ascii?Q?+7FKTVmTZlegW6FG5Vf18XxCFRtVSDuw6aXIy/6cxLMOTrYz6xFi6p2/3Scw?=
 =?us-ascii?Q?Gcysn8yPzVlwH8kB/fZqld9cMDuh0NOioGaflZX5yoHe8fTZuDwteWHUCTsO?=
 =?us-ascii?Q?haFr8ViTRCobtrHTizw+7BzR9x+4igqKu1PqcsqJVXLl/PWDii6uMvIhaMHb?=
 =?us-ascii?Q?kI+CYEHuCb3QxYT1MYvS/ujpn5DYpd8eVEUvEAb16RhxG01LfnCFQItrxb/S?=
 =?us-ascii?Q?1W/Spwm1tXlDqopGnSS33uA99RY3lPPhs0SgP9P+l0bzsXCE+UwmW5EHohkV?=
 =?us-ascii?Q?8F5N7ODhwhBsKkweLtgnTnDHWPcgC84+EF6HDntUCeHOq8W7g566GPLQ62jN?=
 =?us-ascii?Q?wkuGaWaT5l5KXL2I2Bm4mVP+nHvvWv8BWTw/X+9hRm6zNEXHmJDnn5gvb5CR?=
 =?us-ascii?Q?EITIsE4Xloinz2umXD/guU/rZwh8DSURI/BdbCNYbRvDSDhr1AQQvHIC4ZN8?=
 =?us-ascii?Q?x/T6Z+EbXaitT9H85oCH3QW6BuBjnryrl2cR2XeSC8nFsP2jPTBK2d8bcQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oDc2quUnSkDvjHqPRN2b/woTuw/2ezk6+f1rv9XBqTduDgsws39+/PxPp/CP?=
 =?us-ascii?Q?1wGE80ZhmrDn9KGhd37yQHs3ZznzjOgBENJoRCmkYAw5TJkTNP5QP2SgItd1?=
 =?us-ascii?Q?uLkAEcNZFU5Yp57nbU2UlumtDH0GBUe+roGqvN+kYM0wSIHYYibXaomb5j40?=
 =?us-ascii?Q?XbgJ57ER1NaZ2g30VDT+uUd1myCd8vpSK1TIBAkBywn+ZojhhAJGnOBpU2ua?=
 =?us-ascii?Q?4+7Edi8tKrCFelASKi518qrZWYa+Rn0INDHvuMKrCrrhj9TJw3lcqm3kioGN?=
 =?us-ascii?Q?Qhdpr+/bqAMWTZWHnTHDR2SCHu7WG59oKnxC4ZFa6BM3yJ1YOcRN6oA4hXH9?=
 =?us-ascii?Q?pD50YA6uELK5APdcL3kaI/6ZM+avNW6L4B40I1RvytHO6Rsozd+c31RFHULc?=
 =?us-ascii?Q?SoKcSYVYq23ETYKhCyDKdU2oXeCoUFWlpYMzVd52dDnAh84PHbsSnKIjUtp4?=
 =?us-ascii?Q?rQEV26q0gPd4eD+xGDf7GiZKXWHLXbSqHH5DE/18hhMvn/uxSs4Dup7J1RMG?=
 =?us-ascii?Q?9vc2WJqL1wl9jjASA3pG/44XyvM6YfLPOaYl1tO+PGyg28rs8l/VcS7GQv+o?=
 =?us-ascii?Q?9DWF5Acdkfc6jsDZvEmR0+Dv6e0Qi6CGVsB75c75K5OzXeI9Kx6I5GkYqie6?=
 =?us-ascii?Q?eVBxNnlx7Y87a3LwRcxv98WkdyxhmKjb+T7y7spljz04QhogcosmAJ4P3+xC?=
 =?us-ascii?Q?5+Ucco6mKPcED2JDJHVwRsFlTgpBDTo6LJregRT+PbZNY/vSxSiBovmT5GBN?=
 =?us-ascii?Q?AuAdEY4Mv86PdIObfDce2ogNJIxHS6WwHwI6EcYh9cCz7dHtDCNTdb3pnKvd?=
 =?us-ascii?Q?tSnuAcKIe8AuwmxzUvsuefy4s7CaHNAFT/GUxLe9NlaaYLXu8wxCVCybOx3Z?=
 =?us-ascii?Q?ITVnmzF2ADakWjHVNgTXW6JMY1y/oYHRkUcETu8vFmP9+AuXhACZeYVViGJ2?=
 =?us-ascii?Q?dATyK45VLNPu8D4vO9w8D6HTAdqpN9e31STU1lscUA+5rD+zXjKW4pKOXLtS?=
 =?us-ascii?Q?foWqWzNpM2wUjD+TfAv5YexE7EZ4hxpxuYvi+aiBhGzzi+jJnAu+FtIlHn2a?=
 =?us-ascii?Q?9qPLeh7g5Qxg7oQomfwwmBA44DdqT6XCIpfXyWqOjHS1uwxuOq/wAOBJ/W6O?=
 =?us-ascii?Q?vTkUz4NjrzJcrEfuvxjpoD/wEeh61i1Ez/TwhhUFyBBMmfyEHWq4FJ15fd1S?=
 =?us-ascii?Q?j3NvqQuEAWFtxeEA3c1iCMM3SxOc49vfupgFn2lySsFHzfbQ8jQZNMzJa5P3?=
 =?us-ascii?Q?cTtVluLOPFGQ37hIEAde7Zd57pPv21ffqH3nUxs7mMikxIoFeZPgYim1ov9b?=
 =?us-ascii?Q?7IBFGcZgF8s77gWE9MBzcEpFBPPMq4cDafaXSuES7NB7/1rewb6hdbTOrdDA?=
 =?us-ascii?Q?GP6rAzxNDK5wQIa027P98PInlYvv3Kt+tTrsKrrwQDdbiPHUMluqCUSm0TzE?=
 =?us-ascii?Q?GcOXDxoJW1slRVz/dsIcLLUTMYiL/MtUgk7DHPIROEd4Nry8A3eQXLAzS73O?=
 =?us-ascii?Q?ghFmYx5+NI6AZALTK8K9xD0YR4Q6KrSnjBXuWO8+uwIxfxbAdcn4hTqpF8FV?=
 =?us-ascii?Q?nNpw8alop71EgkgJIDRMg7n26tTu4d/59CMQT0tTwPmI5x3UELCh0aU/0VUG?=
 =?us-ascii?Q?jzSc3fkw/sxhtsyd6oMe5yc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3059d7-8bf3-46f4-e142-08de07ad8b75
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:48.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uC7nPaN/soQMX+RZ/sk2zhkja645Bv0Nn4BbhoatXQkbCn6mm8Nop20u7a61DRCKEDtD7+9/4g3LyCcAd1zhZynzrknm6Huf2Ep2js4VACk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 043a03cd90a1..bcc464ec9c61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -579,13 +579,6 @@ static int airoha_snand_adjust_op_size(struct spi_mem *mem,
 
 		if (op->data.nbytes > max_len)
 			op->data.nbytes = max_len;
-	} else {
-		max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-		if (max_len >= 160)
-			return -EOPNOTSUPP;
-
-		if (op->data.nbytes > 160 - max_len)
-			op->data.nbytes = 160 - max_len;
 	}
 
 	return 0;
-- 
2.51.0



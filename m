Return-Path: <linux-spi+bounces-9556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AADB2DC9E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C6F5C77B6
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAB311C1F;
	Wed, 20 Aug 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="xJS7GzT4"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020141.outbound.protection.outlook.com [52.101.84.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7E31B13C;
	Wed, 20 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693219; cv=fail; b=LPUmEAsd5WlSK5Hc/P/Ku0Gegvo8xCojotn6DrlYc0qNYTKIALWDGLzCUMJmVYHKkoVUL0e+AOxbtKWY80clppwkvB6mWCG1SFOS01yMAUsbSMgwEGZS4nIxo/KM+H7D8M191JUAm+0h7BCI4u8sP6JQ2JjmAMQ7fIiQSTtWEDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693219; c=relaxed/simple;
	bh=B4mwrvksUNF8Cjo4NWZ842jeo6iVEjmVFq5+95mp/JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aas+6g6vTJrvrGG7LGcLPDeRqdrCXyPnjZL7vbHseZA2wD6I7VIiDTnVRO/AWpWxW4yMKBJOakcW+w94FqBR+xpYkPJp+vN5IPFXUcVUkV9BjRI9oTGAKfY3X52VHDDWCJ+7om3HwKyjMAPdhP8jQgurXs7OlMFnyrEyyg6m2lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=xJS7GzT4; arc=fail smtp.client-ip=52.101.84.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrSNSsKVLYbYA6S9Qlk8qUzlMpY8YUx33GsX2ZEUiKjf/GXKnMOcrERiiQqFjgzLYac35STWyR+tDxhRVogTMcChoO148MhPOhOl1rw8ru/roggaPgNLeId0D1PbzCDse3sQMrTs/MUOIuP9qhLvIgD9ZwBK0PEMUuZp2ZDFmtYz+atDvVuoMIiiSGT0ZZxO6yZigELIaqwasBcwlxhPEmxl00D6+76HxUkWPZ8Fso2If8mAWLEKIOprjChuznYUB2kUan2kyuAozEuF9/ELgBgBxUgTknB2MOP0E6++bk/NmT0YLiow7nEPm9K0YUubPfJ9yV3i060Psved3YH4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRiUtcHsQ6yiSkGpm2e/VasBHVzYFUftnsAiGFE6nbs=;
 b=UtAuVvNI6us7ogoqU482krwf6XE1DqO3hYgHChOXSRjxKAr0RolWyHzL9TQ/EX2KIv0N0o4G+YsS8rI2WJ3E1tH+JAVO4LwuGDSEHPCl6b/VilvhUuOFRa2ZNYAsRTUqQdE3bvv6qnUDTV+54Cs/oUXQ939eeUL4jeRX6bwKJ+69yvgjQ4izeYkxfc/GVa/hIMAhmRE34vVWBbSti1YPuPsLSHT+0ByUYtS2EP0Oy9cJBNICx2XlmEXwIKISc/EDLe0thcabZ/r40QeozGe3UPJGy0vKqhXScjJONyJjm7UkUi63QixAexzBGjUfi/OgHal7ATWUIi0tHyYnFH7wLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRiUtcHsQ6yiSkGpm2e/VasBHVzYFUftnsAiGFE6nbs=;
 b=xJS7GzT4O5ArJ7iF6o7z5mdKA8PSIhl1YOh1RFFC+CuU9EbLBdUpzMa75W0thyN7BcwOx6AXuPW/kkYrtSMvpg4/SHewaSxaWS7kxrnHRA30DXKPXoj7MjxzGp4qlM/bRoGXlRRHhLFYuEoMBa1mjcecoGZCA8yAtUO8bYIiJYh+ZLEgwWq+1cZgzNilKHRuNGqQlfPr+DehQm5/ktdkXHEBUYEliLvhiCYGrrGywhO33Uwdxzep99nHkr7UoWQ3a67sb7Mxy1j7Nz+YjeTEO9xz9fy4xBJEzFtslKd7e6KkPr1IFLHROS3EOjhwNQEBGuMVPCaqdxoea6HPE7jMVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6355.eurprd08.prod.outlook.com (2603:10a6:20b:363::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 05/14] spi: airoha: unify dirmap read/write code
Date: Wed, 20 Aug 2025 15:33:08 +0300
Message-ID: <20250820123317.728148-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 0851c434-06d8-476e-a6c6-08dddfe5c411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?umIhFv6IElzA+6gsM74ibdChjp/8aNZ6q/DSIABR2+pwgvsBXeZ7ygFOIkwA?=
 =?us-ascii?Q?hPYoKmyFGAZkDsrOj8Y2ozwuqYO17sMrvMPB4kFYHjkQFNwAC3Qw8bUsZNKg?=
 =?us-ascii?Q?8hudwPtY31Je3SX8SGQXdd60Ab40m/yRL57+BwYvYOO2Fx8/T1voiwJczvrs?=
 =?us-ascii?Q?P7uemLR0vMOxsKcsKfUMinT7d/mLQr3ncB8pERQkUGbN9pjAOMRbykXP4nvU?=
 =?us-ascii?Q?lnXtGaZWARwI9oAOfmGWogtuKJa6VbvQTCmW8VKxS5tjyhP5Vmk496Uihga5?=
 =?us-ascii?Q?O0JqxjiY+kwhPIF8wbKw3vwLmjgZeBPZw0BNDCXqgIXVgTRY3x5Ee0KRajFL?=
 =?us-ascii?Q?CV/3A7ReSUb/U3LdWnJKbADSmU8JB7ul16Q5GWYC1Ulf7Bu3xroNk5ql+WpY?=
 =?us-ascii?Q?KE3DxM++huI1WnB2VAJANK88Q4g2wiG2f3SP3Q3XGOQb7Ts4u7p/Mr8yAxXI?=
 =?us-ascii?Q?51R7Dmjz73M6aEBvtiCH5UPNJpIqK3lNqHXBIH1VyMi4MOLcp5gX5OmS7wus?=
 =?us-ascii?Q?2Jq4ffalzvBXOGXnRk/TEgyPy/wcYjEuYsfZWMeAeycgl+Ju4yMZOscxoFHj?=
 =?us-ascii?Q?vCMEj5pcpqCLDjyDYTeJYEfdBkm8hLryKs2Ye9qVMf89Ml0cIXTeJ5VnDYiL?=
 =?us-ascii?Q?GkvD9pj7QN9Yx76KosAD04scRtbonuIseMcvfGvWBtLRZ/Tb1CFpD0E3/t34?=
 =?us-ascii?Q?BB7hsJ3XLh+Y6DiPtxT7P5nydiOtEx0Ef7VjGqGm/UKK2u8x7DvwQUw4kGpp?=
 =?us-ascii?Q?an59CfsGjQysnLUMtsDlS+zUcEsVHRi35FCCR375Gtf0IZPYCiF2BP7LoUbA?=
 =?us-ascii?Q?a8nbWU4fCmkbpR4YIxhhdj2qHpqUtVbVRJqcvg50LmsomT2V10BzVorSV7/L?=
 =?us-ascii?Q?kdF6OJLeS5NeqDNEAPnF8LM72Zp8/trktolO1H51rGurXRQNY4cIor6MLDcT?=
 =?us-ascii?Q?Lf4AOaQqLCpkU1uVlrwkl4dCSA5KMKRRkpcg4I/CNnw8GtIq2p4X8gATMkq8?=
 =?us-ascii?Q?sqBqSNNFRbsLrQvm3pJTuQnZaD4nrFffAcp3BpS/Hs0V2ip0vgglyj53CY6u?=
 =?us-ascii?Q?nBBYquKxhTKLBDwedK36ccmPOI7wxJCmyEN5Nd7jYRcW3j7tJ/y9qlTSNyKs?=
 =?us-ascii?Q?ebmFmP7MxTQmfP/zm+6N6RblnaHX/cM2Exul+B5ajEXFfLJkHVC99DIHLcwC?=
 =?us-ascii?Q?oWiQfxTLSbJ2w6rBSkdei0Nf9Bd8sCk/a93ZdqocpFVz+EJEQBkausLHawp3?=
 =?us-ascii?Q?hxjBT5mPaUSqR/i0INzXsGE3smGAESTbchO3/eGutZmd6p0QC6pPDkwEb3pB?=
 =?us-ascii?Q?I/yFeDLJyvDy5dW5JMaOgsz/l5iqjYcU+XMk1saJBnEMUh2MJiTy+q2D+FSE?=
 =?us-ascii?Q?lBaCXvZnZ0VZnfvC0Vg0G4IHOYbE6iPsWeYHAtB80UAl6BTtwIPAaKO7yWnO?=
 =?us-ascii?Q?/TFFiku5eOiNzBmtB11MJLK9pDdTs7uvok4VKmS0rZXJMiQLEwobFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+G+C4BIXrR9hycp4TJUHJEHGV5n+bYKDTzMAfq36Jz1Rw3qBtLygPCuPUNwu?=
 =?us-ascii?Q?nCcZE+1spFMVvEwTjGj7l5NhKuS5KXQSta0y4iTEFnMWcwmreWgrQJWj7If2?=
 =?us-ascii?Q?tTb8IUHGX6X5hjYDZCA4ta+taeaZAMIUMZq9OSas/yAdK9o5wEk+GQc5YkxU?=
 =?us-ascii?Q?1iOQJrns6NVi+zlbJkZNpLeDM5fpc1nLa4vL4eGntqriZrfO6KOp56sPQVly?=
 =?us-ascii?Q?WA97sVmDxj3lj311jj9S3WoUM7s/ll1G6lZ9sz4vw/0jFeCy1B4dmvlbrAjo?=
 =?us-ascii?Q?4ypf9lJy5YlIpH+Up/vSjYDbgx9JY5EvOQfU15F56aPJhiuzp44ZYxx5Uege?=
 =?us-ascii?Q?HfZxs2p1CLcH/tdyrSTElCy1cF3JcULmXSpAb2GXczbArCZ+hHUvYYpvRrfZ?=
 =?us-ascii?Q?AwKhb9zRtrTRzXmBZ+99Nz0u/RkJRrwZeFUrjrBp6L9O5IE7OObYu7oD57yS?=
 =?us-ascii?Q?F7ZY9xxhgE64FksDyi6HFjZenC+aceCkR22FWBdBcozYzLGryWHwfsx1Djpx?=
 =?us-ascii?Q?vE4JKTMStMLK426SDcXkps7Rcqafo198x7wHQgIgA5rAUgU+P3zpWfmbGdoz?=
 =?us-ascii?Q?zOBwh//+uGlC+eKGZsk+ie32LNZbFPaiKQiDsOPr0F15pK/0aAc0rX0Ekrxy?=
 =?us-ascii?Q?FgW1n9Eni7xS3ytlDWsZUH+IotO78W1YlDMUrg4DKzOUXYML558e2JrR2Gn1?=
 =?us-ascii?Q?6Yg2kL+A/HcNOPAcdsDZd/3/ivhgYfnqpM+ZZoQH+4tcI01V2jbIIt+23nt8?=
 =?us-ascii?Q?WAAu1DY+Ad34aVsKSQ/iKLteDziEyclWEuptOvtBxAkO7NmnzT6fHKIQMj4s?=
 =?us-ascii?Q?mgwJ5LrzFgml/0Z96tJEwIlWbIGkY1ZQHSx4nH/DG3WFy2KHcx8Kdfu2OMOf?=
 =?us-ascii?Q?3N33nt6VhA++2h0EeVUHc5BrvTsmQHdz/E+VUBPZy9UL5FYVSOCbOzEr9zRE?=
 =?us-ascii?Q?zVHPbMGHfA66RRLvSYdP7eri916VHlaclR8TMgnswVBgjfHkj0grdMAHhr+S?=
 =?us-ascii?Q?J4iLYnKbG1h85/9i98io8rpVreu74pI4zZUQfYYvqOM/02OujiiqN8RjbxhU?=
 =?us-ascii?Q?htIIlsgMhtVr5mW6l1QzQ17px3/KIzZ5LxeiNIRsYGUX/1czJ8nlnmt17N95?=
 =?us-ascii?Q?fES+r9QivAnHMk2yZG94xW2XgeJnCkoCbZ4jto1+kxTg28RAgRiyrEcBMcbV?=
 =?us-ascii?Q?zkJye8LM6Iyf2A6d7XzPpBSrsX2RZs8CxJOzSl+O60fjkUbmAAFQC1pOLZoy?=
 =?us-ascii?Q?6/EgIEJX6QdK3sYGFw6n4dOtzLzfPojfLxKf/Wk9pykMMJHov5cKl+8sBYCU?=
 =?us-ascii?Q?8s2hyWpxGpulnkwzmv4lVhRdX6fqZUk4EVzo8dNKQgsaOpeOcwtB65YQA0qp?=
 =?us-ascii?Q?VZCMLod1Y4Mg6YSML5nxu0I5jktsmgufUN2Qsx2H9mlprn13uES84IFnqB26?=
 =?us-ascii?Q?xw/S8GJxefbQsXS7SzbOdRoFvpqTcUkFon41JJS/yLPhLQvGiLw52tvl93B2?=
 =?us-ascii?Q?F5kWaHDKO2VmWf5+DbuEcynvvuQx7bXoXEBqrZF0rfgP7I5nQCcn7re72wXA?=
 =?us-ascii?Q?g/oleonmOWuYwRPm/g8cB6XnUFZy4Uc+OHhqxhg2DbO+EEaXcsv2Hjk7Xz6R?=
 =?us-ascii?Q?/xS9XjZbMYAn4MGtj31XtHk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0851c434-06d8-476e-a6c6-08dddfe5c411
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:28.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFlK89cD4G7sCeTWmPBdOFG8PseW5uyVjkOPjlRyFPpBtNl73QFoQe4HMPLzI3i/U7gxL6JGX7konAzDFFtU2TCp2Fd942zxdIs/nUxg4TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6355

Makes dirmap writing looks similar to dirmap reading. Just a minor
refactoring, no behavior change is expected.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 49 ++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 7f33131fb6ee..cd0fd5c2bc98 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -670,6 +670,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 val, rd_mode;
 	int err;
 
+	as_ctrl = spi_controller_get_devdata(spi->controller);
+
 	switch (op->cmd.opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
 		rd_mode = 1;
@@ -682,7 +684,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		break;
 	}
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
@@ -745,7 +746,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* trigger dma start read */
+	/* trigger dma reading */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_RD_TRIG);
 	if (err)
@@ -801,37 +802,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, const void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
-	u32 wr_mode, val;
+	u32 wr_mode, val, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		wr_mode = 0;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		wr_mode = 2;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
 	memcpy(txrx_buf + offs, buf, len);
-	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-				  DMA_TO_DEVICE);
-	err = dma_mapping_error(as_ctrl->dev, dma_addr);
-	if (err)
-		return err;
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-		goto error_dma_unmap;
+		return err;
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		goto error_dma_unmap;
+		return err;
 
-	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
-	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
-		wr_mode = BIT(1);
-	else
-		wr_mode = 0;
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		return err;
 
+	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
 			   dma_addr);
 	if (err)
@@ -845,12 +856,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
-			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
-				      op->cmd.opcode));
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write mode */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
 	if (err)
@@ -880,6 +892,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* trigger dma writing */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_WR_TRIG);
 	if (err)
-- 
2.50.1



Return-Path: <linux-spi+bounces-10410-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637C2BB1F80
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144B5179C80
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736131195A;
	Wed,  1 Oct 2025 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="HSctmQZB"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABC2D9EC7;
	Wed,  1 Oct 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357447; cv=fail; b=qwPCbw58Ri3lHWZrvj168Ia1ywZdRjiwE+13Vh4e7QjAAIUQagONMoiP1cCZJ2sXULGNhauGkRqBhL6QWP5M4qUbIpFJzXUS6PBFkxIw5dZQEt5I/j1R0xoiiUoAeTqwabcs5bq7wxopk0Ce/djM5sgNwo7WuSYeGeMHniL19BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357447; c=relaxed/simple;
	bh=ln9Uv+JjcDjysM4q50VJX3fGqO1QoWoTBi9g3lH9b7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3EEzp3BUcWTMUL0GzK1LDFnhax1U8idSsnrFKHuSNuzA/Gu1e1xEYjDszkt+ZbAewLinf9lybn/xYDJPB5rAlQv52JjjRn/yrLzF1bszHJfhkHvkN0qDiaHek0TBLJNJ7+3X7SrkV4BMqeboh9ImvWMtr1FLJnEkeZbFTvs9b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=HSctmQZB; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoQbSGyWkPU3gzRTzMTzlSL3kRSr7wNtgF/NM1WPTu2mRQKZ4dhH8e1ebgpDd6VV5qIJZ8Cxi58Y87gwShpPAhkc1zsdoD9/eg5owROs9u4SvWZyvgxFQeT+pqTRLKHCNd+geIvwXtmGyGfXDyhIh3t9dUzpc1bH0WlIFcN0DbEjAJF9acOdE9/xMydLpOol7MLzbHfOVB6Ei+sWTLKZm6HYjtxG6URjQCi5lplIMF6fXMFxvj3EYLIKFc93xh8LLMVzIOW966UyNh/ZeeDvwmSlMJTw/1mly5OcsRZP4g1ntZs+4Dy0xplmMY1ZddxR9p67FZt+uCjuLqFtfRt50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=CtLxFGoWKfcR4dNUnEtI54UoKSkwnlhPi6z8SWzgac6hQPxNvD3ymm2Puz/wz6INR7OzJFBQygtms19yvNYNnPVWv3+N6nJ8ZoktsMfVfQhbg7saHuw2cJk6PnQLi+O2U+f3kRJ6A0aCltEDuBFpk9qXh4F41aJUQ1+6ujNOSWN4C2DcN9GC0fKRj1E9Qjt3M74Q1VdXFZA5Pk0iZD2cuEh3XekeR6gThTFpV3FmR/1dPBKSTtWBdHjDxw8xq7lc4wSqoPCGQFLfpEbrBIGJjqWDULtdz3iQ8s7nwr+X+AQ+4Q4S8QqCpLQBtr4y1893+5/S0a7Nh5HJ586RijM7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRs3E6XYJFP2n905LhT/DxgKVk6bbVkUK5bfx5yHGus=;
 b=HSctmQZBW8UZdXTzZSMTL5C9NvUNJ+AzIinYkPZWuAuiRDMhPRMpa6Jh/mXoIBrOXltypjGKlCuRIp752HGOxVKWh0V6tzNTJ1Rte3cAFsJ6njBmPPVrxDxMCouoddIEoR2eD2SW96c/hkm2+h7gj3mIlOeAF0GoF7s/RMRZSXiBtYjvBIGpv3oN50UG7J5CunGgK43iw7gfzlzOIqL26G+viWPUS+C0FbLFaAMCTzzLNDkEzxwWhHQJYHBfLoaP8iKkRBaHZrrOLXlOQhHXeft78TrbtaXUNBhGGq1tAps467N83cOZEufmj/B+Lr5M5f8tMMMedUg8wYWmsAtlKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:23:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:23:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 04/13] spi: airoha: remove unnecessary switch to non-dma mode
Date: Thu,  2 Oct 2025 01:23:37 +0300
Message-ID: <20251001222347.3386506-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 5039b2dc-f225-4861-b946-08de01393761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VJPsiw7nybdNAqATjrRw5N4EKN74G2Zj+++Nqa/azlmqHRMLTJA5ePootN4Z?=
 =?us-ascii?Q?ojLO8H8Y6vW4fOksD5CHOADZgmTu5YHN77M5FzzM5E9dmb4oycwTVgseCI8y?=
 =?us-ascii?Q?gf+JDNS6mKESCV1vtCAD3OYU2lV/WzBOjtWx8pKcOYmBVExJq39TqMyfqBtS?=
 =?us-ascii?Q?f9GZKZPb6VALeKcsrCFA2MPcXUmjU59JtLQ7KEa+Ina27N6muW5m5tOYvczg?=
 =?us-ascii?Q?45HyDr0hX/EMnXGKb4029zezhLbOLinDPE29H746vi6NJjccPKux4O17fVRN?=
 =?us-ascii?Q?tBiqeE/mM3Z1sdP+5vNBPNeHFdGcwuWvfzJrYZtHLVYJ00q0CdfNaBhC4dwV?=
 =?us-ascii?Q?zcVWiXcTxFsUiZSO37pHYr1Wu8+zZ9dToQ0ndl0Db1ZQuE+wmngVdL9yilsK?=
 =?us-ascii?Q?gUVs1NJcyS+bGL5/MyiWSqAiKWdapRrg36CHBBhY+ofuJxqiP4PdjIQlccDC?=
 =?us-ascii?Q?4ScrPDDgGCrXRAzVn+kun3ornEnrtqWFCXKQtijSsmFZXLBZA1dL2HUQu5C9?=
 =?us-ascii?Q?sGNEOPrqbKseGLiSkE8joJndNFGyq8H4PR9yxF1slJIOGlNyiChq5ieNPjtb?=
 =?us-ascii?Q?ryUy+PktO6fDp1ygfOfL9noX628iuh/DnknM+QYW0syaEP6T/QxjBkVLMYDx?=
 =?us-ascii?Q?r7pQvyD7uOSm2pjPVb/ZqrFh+01wHIOebTgIOrDvxC+xlKfyHyyCZiFT5p+x?=
 =?us-ascii?Q?OV/8cEzmNuAY+IJwR9RSA3oJ69rNV12VaxtN4Bem+pr2wPrzEvtY62Fbh+pU?=
 =?us-ascii?Q?lvthcXY2APEqDf+a29F9DB4XCU53QIPQpIr5D2IbPIE3ArJPPTtgXOGppvlu?=
 =?us-ascii?Q?dX2mUL9f8ytU+czWa9kEFUbXypWDHMETomxLK7Q5inwytrzuTWHYlpV4LDyu?=
 =?us-ascii?Q?hcv750AlA3EV42YixzmIk0jV01fHaJXCMdXjP1TyPXEK2EnQ3tmTP7Q3AhPE?=
 =?us-ascii?Q?OMFsqFW7cxduLbJWwtGoxgiAbNLl9picEn16Q4fZjKKGXdDsGP/lq2HoefO3?=
 =?us-ascii?Q?BvaR0lk0HjKZk60hbisEvibDfkyVIh2WoK6bjCv3UY3HSWasEEliHv8c8keu?=
 =?us-ascii?Q?u91sS+lw/GlgK+OQbSqs/p6Okf5qtcrXO8Bk30lPgc3D6pb6Q+SIweu4wkuB?=
 =?us-ascii?Q?7TMsNh1uk4trVJ56yCWLEdsul5IyXKCBzb9+8n0/js/rg2lhQZ7Mvm5HbF5H?=
 =?us-ascii?Q?J9z7E2sNO+k4yCFYw6zi8+KxpQjnZbastpax4g0xPrT1kwjws3Y9Aij5B0n+?=
 =?us-ascii?Q?9cPBJLTqOyiC4qADWT2v8DzS+6EubMbmqvC92MFZxFhfMkX86cxfsZd3ITxr?=
 =?us-ascii?Q?PUA6SaBGUUUnaWRzQ14Y6/haKl4xVdFmzFuV0bzlvhYZOgyeFuonEWLXaGDg?=
 =?us-ascii?Q?+XdoDRvu9I5X838eutDPQvvXKt7tUfrMpDAz7Aj9HRklYkAXFCc35HskB2S3?=
 =?us-ascii?Q?hpBix+xsb4LdtH/9YHTQLWtjBeKqIphsaG1VebD+g5pCOZ4EBDDD5NYwQGVB?=
 =?us-ascii?Q?VSdjEhGLJfWSomE1ff22xt7/80kmh6tjy7GS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c3RrVsq4IKOCjTd6VU1LqvlwFG4r8eqvQa93TkhDvX7oQ35F2JVsedWxXiJL?=
 =?us-ascii?Q?fwXHLNeGFKLhm/ZyvZtB8vi8D2/EzflkBk2Ze3LO/9E/ofJDkgTlNNyc8m9h?=
 =?us-ascii?Q?zzmzP8djARbO1h8dJMQ1jPcWnSoY0doB0GHhMHrTGbIF7k8EG/cNzgQk/kx+?=
 =?us-ascii?Q?QVQgQWrLG78XwPzAHjNAyqIYKhObhpeZqgK+4NQ2QijZqLtp9QOPZSg666po?=
 =?us-ascii?Q?NpVVmyiRKugLDZODOBeNRNAX1nhN95nuzjSOXJcfHJDFRNvcx2uc8wnTVAwP?=
 =?us-ascii?Q?bs8cDAPg40oJa3I2Cb0UwQNpy6X8reiFyqY54SE97npTYY3jqx7u/hrxIS2k?=
 =?us-ascii?Q?17GxCVnfWfSe9RS1izA/ZQTjCYrA3NjYwA8ddkTYid9+RFdAQ9IXehEvKyY1?=
 =?us-ascii?Q?IwH18OfJEhTWFY03vaYrp1KnMLwdnsqo+CpD94e7SwBxncC7JmhPuMlgrUVW?=
 =?us-ascii?Q?ZeT5JCFZq7ZRjpgDsLm7wUKImtq3IY9OgCdwiybmywOTP8u2dwV683pWL9GJ?=
 =?us-ascii?Q?jEgZA42VIt1xo2X7LdCoR581sC8aQppUoDZpLVAPn7BR2IPqBEmVU7RSloBr?=
 =?us-ascii?Q?dyqKm2SEMMKg1PcMEZvHS7ulRfuIrZl2EuebHztTHgBrdAPztRU6zjrIxUt8?=
 =?us-ascii?Q?SRd6LvSkbsSWpwySVS+jx+A+mK7uT6CA7oxUvNcxdOpwJPxaQlzu6xeIUSvd?=
 =?us-ascii?Q?2AZXZ9ZcIVwXudLUhSUHL76D5y/zZw543eyGKQf7eWXKQmFcvbh48Rj7aHq0?=
 =?us-ascii?Q?fx2XmwEpvb/Y/0fIMi3GUmwwwRLtCTW0mo8E3B3q9PvlBS7F7zNYNZdGdqJE?=
 =?us-ascii?Q?5cD/jD0EiAASuZ+FpcCwYfTZ+/BXHF9mpXOLuUddIV5N0nsib0Bjex9Uvjzo?=
 =?us-ascii?Q?GIOvaYqf1WaBymifkkn3mYg3gqiQRqsQcG8DPSZ4+9pOgDIyeRBMrvlCA4cV?=
 =?us-ascii?Q?nMq0BQsNVp7Jr6ubuw8dGATAxpbOYwrZ0BuIDnAk2JkwpDxRKHXDh49TTrWx?=
 =?us-ascii?Q?jq/kdT1m0bV6LCKB5YiyZGOSt8Lqn6/01Px6mBP2HERsE+DsyTHimsK6h1D1?=
 =?us-ascii?Q?xB6W+6R2rm21JSw1cXWD7yauXSM6ULjWAXzPSpIfTT/P3UDERYTqk/REutfH?=
 =?us-ascii?Q?bdE9DthtzARSJFMN8o1JD6NhSHVaZYMgWqhFz2SCXE/evq1TCaJ+N0K7AluM?=
 =?us-ascii?Q?SAnNh76Ocu8AveTji4ff/oFYNL9i6F6/YvbOPi0tEADtcW+gxwcn0DFrCgDc?=
 =?us-ascii?Q?Ipjk9wZQHuWRUZIU7nWjSapUX0E8qM9Sa5AES0Ji7QHKqILgeTeOc+7S1iv6?=
 =?us-ascii?Q?zJEeuihijfr+cWXGG8RwklIo1IjYTW9Jop8LaAKdkPdLXbbYuJPdG7DqPH99?=
 =?us-ascii?Q?5k5WDO+zcOUat4QCUyrkvQF+fjLA+utJVucs0Sy28NFYi3sN7O2PpYKunOoV?=
 =?us-ascii?Q?eWGCUvXn4M/EeTW1ZYfWkGkoV62i96gL1sUHBJ//04BK9pr5hVw30zqlKJgZ?=
 =?us-ascii?Q?wFO2ZANI0VYIopsAZXlno+2SzcgSdgLSMnKtcx3Nsm/TO6R3K0BM7yEv9mvB?=
 =?us-ascii?Q?Zn7i374ZPTa/SbkMJ1zJFpcohPD/RZfTo361iU7H5qa8CF4Zjl+ZgqOvWxmW?=
 =?us-ascii?Q?FT5mMJpYKKfMnXBygF1I5rQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5039b2dc-f225-4861-b946-08de01393761
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:23:58.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spgdjfTe2yGtGHzQw8UQWN9Trr+sKM/jht39YhiUKV+ngc7ykDzRS2UTySRC7MSqXm5D92XdEuwOFgCmmBSNIknLd+OFGXrLixkjOZvpGas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index fffed26ff990..2d86dc62dbde 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -812,9 +812,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.51.0



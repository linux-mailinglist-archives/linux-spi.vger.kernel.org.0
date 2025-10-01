Return-Path: <linux-spi+bounces-10412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A375CBB1F89
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1FB4831C5
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CE3126A2;
	Wed,  1 Oct 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="aEejbtrc"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D8311971;
	Wed,  1 Oct 2025 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357449; cv=fail; b=u945HkunO53xTpXVYoj1cgDceC3nAY/MYZ3IAaHvbyUs7gjp5LRAuPijhrXcFfL9pN4dbuJCu1ktudZIG/GXO8Ul+5JD5yL9FrAWOjcD65v/l/DtnPWDSjTKE6dzRtb9YY/stgnco9zKQvR7tffCxfwBUZJ8tCnj/cIhjyalVgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357449; c=relaxed/simple;
	bh=E2M8lRG6zN/Y5R2EJPWZ8XXbtiAD084miYqnGi5jqec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJ11VwGV98P9m2BCT75s/o9UXiUQ6FtZ/eagW1Oxg1RHuqkfQsmi199IamtaocpVEm72fRzqOOafAgCvy9yHQCei/kOpHmOI9tdzgy6PFDBOUROvXSZxU2pulF0sS/YWjk/DIibon1onSzqPosKfoW1ueZ5CF6h60uM428SnUG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=aEejbtrc; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzxAsi1XqxRYsSKTo3zwuk5X0gmXpfr+nsZ57xAhuL0+jFVsu+a6BRuvvvmzf5gRsAVsG34oxiYgVQCPqmyiCunFy+R/7sf9TwbaDkLPYdm0RDQyKibj/fkzicZPatezaZpQkWEwIJv44v95DfV+IcwsrzGuXKJR2MirmI7E5zVMQsi6M7cFnAuwtdGfisVcwoW3neickyse8BgJmm6rqh/r9cyZ2F0tB1PRu2OTzvvPo72hg37KnwyWXkOAzNN6WMs290/0cr+Lo5FQZPvMRVwRzXdhL2Des14nQ7gpmTsvUcha6UGy+rNMhG/5k5H8IamWn3YG/v0xgUPZsVGy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=snRpV1re514AWLBh7UFlIMD+0N2X86C41OAUJP/+Db6R1x8Vq2d4rjz0FZWW54NTUF9zNVvrUeMT9Fy3UPs5kGihwwim8rbHc0SdP6wqSpKSEVB75ZBcw7iRFtqUGFWW+OZi7E7IwiO799zHqtNF8xCOmy7ogxNxTFxzt8qsmxKIlPnfUJ+qpIIjJtIU3CZKJm0W8b+7Rr0GHbNMJ57cVqFjDhLlpnF4LzuD/H0M9C8VYCajOKz2kQHHGkGvUSLtqZjZVfIA+gd1ZZUELS+7Wc5dyrVkuig4vEDQ7BffGVtBUmpYO5o9mrVxSvUf8xZWjgpfJXXnxbU/vUB9wp3CuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2snrpNrzRAzTOeqpJ8KPLiTOapJVIgdfhM9IUrv732o=;
 b=aEejbtrc39eZ51o+lW3hkjegiPY4U5H5v91I/euMpuJVOMrPkn0ZbbIYshbKqBYIGEwT/xN1tyV00HBgg1Uk6hBQBuIJiq4MVaYy6yZ38SmUSM+wHfNMYYsHL1AqsrpQvGag0nE7hC84XlIiuiyC+OxtxrPiWm3BPKE9a7C+0mr7ERpsVj/ghXOCtY1bcDUrBimbc2MZEP2MIuqrvzVjeK7uuO1/HR90ojiDzfjG8DbSUlloK/j7UEqCdTu7/EmD/kmbEo0f/4kmHCZH/4C0QWidLiYkDlbUxWe9UAQOrTveKa0GtN4wEfGZ31KgmVkfa6Jht4kGi3j5qCHgQS1+3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:23:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:23:59 +0000
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
Subject: [PATCH v6 05/13] spi: airoha: switch back to non-dma mode in the case of error
Date: Thu,  2 Oct 2025 01:23:38 +0300
Message-ID: <20251001222347.3386506-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: c2b8a3e7-8582-4572-7cf3-08de013937f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GHtdUTCXWkZKxeN9QiJjUBp1Z7IpqyXfSV2/aBEgf0xH2AyzaqbmRc7IGXLv?=
 =?us-ascii?Q?lMNTqOz+MOhYofJAjkOVa8AvFNmp8dysdkeIQUhrXv2ikDIY4VshocJBd8qN?=
 =?us-ascii?Q?GvbYwVfOFXsD0AJrzcMWE+1Ywz25K/hypgZI83DR/c6CTdWi6Mz7PsNlR5T2?=
 =?us-ascii?Q?Xd2xokxTaDfePsMob4ThmxoVguAggLbfsHbKo2iYuEBNuIc5y/weSv7v8J2U?=
 =?us-ascii?Q?JlLp4lAt6kLN6tlR8069tiyc/M6Sdn23tSGG83+tzduIUZT+HUkspbm+OzlO?=
 =?us-ascii?Q?eDO8Dj6IHns/c0MjIs+2iWdHOyZ9d9MYlb1igaZjlsi2usptDXtIgJ76sBqb?=
 =?us-ascii?Q?HMikBDhtVoPKnMyp+hJ31hWnAh+V2G66p4ih9lSGGH0x/0LaBcJd/39J+GiN?=
 =?us-ascii?Q?gqPYHliJGpncws4pEfoU5B8gimguSC1PxVb0XJOtCXZ6/LOr/ORb0LBGTuZv?=
 =?us-ascii?Q?4j8WqnHpRJBKSNQaKPgUQ8MKA1jgqA7BvJkKIW9QlPm+qJATrM5AG7nlXbH4?=
 =?us-ascii?Q?gGbYPjfqsItDNhcBl+a99+UHZ4JCYWS0ePJKFEecZ4CZlNfJ4HWoEHxaPult?=
 =?us-ascii?Q?pnn+b0XUyVU4rvq9JluzRaX01QJBv+ezi+PSvSzmNnXoeSoT2fPFgpTm/0S9?=
 =?us-ascii?Q?4mypgfTnyWltfDv4epEujqOjB6J/2rd1kTBXsG1TKMaW6oxs2y9OdQrKdqmj?=
 =?us-ascii?Q?JKCTzbOlrjbWNv4tRuIh6fVHCDj5LIV2l/XyMPsTrTsZ6ccSDdlmQ+hULLSq?=
 =?us-ascii?Q?kdhERZktDGuwuCwYRM/7AiHmcQj7XrVt37YWgqIXUV34tC+i0xOYeXdyTC0k?=
 =?us-ascii?Q?THjnue0qalWDMVUy8QeQadkvNhZ0ppJRp1nHeN4mN0B/sqw8YcZnwqzq2sNW?=
 =?us-ascii?Q?zDoYxKIfpETLsu537YTMHHNjZcMuvWHr0cljLn1ZrDfkKRzn5hFyaqRJk1I7?=
 =?us-ascii?Q?YraxoqbyEu0GYrfiY+M1HW7ruML9Zexw8XGY8KlGpkKZRt9QkhQyC7yawG4g?=
 =?us-ascii?Q?lOWOC1UdaXbFxho/lPp/EaHkDic1IEvHQ9gp6QrUX/Iuu8R4F5YyIoes/kTb?=
 =?us-ascii?Q?XXIOyOkXzZdunpcEJF6Pk1i4UHKUj07qmADeNhSSipjIkSo2CSXIzZgjCLPt?=
 =?us-ascii?Q?sFezpkWxJ/DFwk74kZG7u5y2vPJKw7rT201teQHwxhosPKLsnK6KxcVmeMQH?=
 =?us-ascii?Q?s5I+ASZQwVFzS7VbL4SpndrPan2O+cfw88HUunwYs0j4MtKR0ovkGweCqNqZ?=
 =?us-ascii?Q?ZDo2BbmQe8hMVtMVeUgO6djL+D7nXlMllYlE7MRJyAZVKjcxAkiS5awn1e+6?=
 =?us-ascii?Q?ZvyTcIh0W9ZjsoCgLAssO1QXZkz8nzgCPdOjmd+IhOurWe2P+nX12nRV8Kg/?=
 =?us-ascii?Q?o5+xv+Psh103oqkJ/Mmz9+usWg/3ELLPH+GvPjAqNNBh2DTR2i3bsZsqJPw9?=
 =?us-ascii?Q?AXJj5qeZXG0CNvzcxZRoGRRc8/PJ0ChJafR4stmz1b94ode3TMxRJLzYblO0?=
 =?us-ascii?Q?1WXf+ekScekXjUzrzbwKvXk38zpKo87R9Z0g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFpycQkiNyD149rPhTZu3uifE7seofs+QPQi5QHWatBQWDkuknykZ5X85cwE?=
 =?us-ascii?Q?OTiEaDUmVgwsKEZZ6Cch+fyrbINrKSZWJcAgbqZM3iL8ZV+ZZOYyQsiRvTjm?=
 =?us-ascii?Q?z2krRvx6/rXIPolQwM9uG5oGI9CNyvgYw4HvwocUNybiW5QYwubxBl1+9EMW?=
 =?us-ascii?Q?vJBlCQxN2HEF28SEs0ypp+XloXNVxchmAfABoM77Cx7ps8nQhC3YvFBS0XAh?=
 =?us-ascii?Q?31Muj1bqUMM3lFPZch4H0SBzG7sShrYQqp2qZaGhVr3/Yz7Su4TFQadXFVuF?=
 =?us-ascii?Q?1SwBRQownRZPopsNhfMDq3sQViTa2yC12fAYO2Pj6maCMcZTJiLDP0wke59c?=
 =?us-ascii?Q?cBcg1ZQ38JFXN1Nx4KAVyndR1BN1DfKRzT+pH4wFy+A2SwoYRAC5q3swzdzK?=
 =?us-ascii?Q?FIC4ofVTdbgVnhNj4Ds3PkE6F3ARM4d6EAUW/SNPpV96bvmvaXm7vtHSkyFW?=
 =?us-ascii?Q?Tr/QuCMCegdIB7rj6SdKu3YxBs/B54fBqcBlzgU6rzJeijlrrPsO9w8WL4qd?=
 =?us-ascii?Q?P25tK3qZVplWBMOr0OMFWyXYdjFK1NJlCiASeBdYpmJHewC58xRKeXfOgBN3?=
 =?us-ascii?Q?CDW8AkIgZKSj5PTdAN+VKbDJ++XMZgT+TQ+ANudVC1zAOg9XunMVKGeSqDSZ?=
 =?us-ascii?Q?iTPT4agxaEefziZ4vocYQc7KNS+OU7z0dYtcFuWAmSs1KyXnK+2lTplRsbBO?=
 =?us-ascii?Q?YFyc+ha4caO3aFiVib9zS8K/eXkmvXt1MSoF12v1Z0EN11IeaUF2bAQzVD4p?=
 =?us-ascii?Q?zCUfW0QJY/r5ojDUqJOv/gq5hnV8W67hYQNlPXYLCrqoB05zv05To/Y38lUw?=
 =?us-ascii?Q?g07X8eu4WrdG4AlqNdJoQ/YO/ubGuAmYxiSq8mDu0ZqxSJpFZ9H1xPGRVS8q?=
 =?us-ascii?Q?JQynjvNlD4sL+UIfcbib3ztbyU5ODrBV+tAQS0GwT29yHBNswtXF9qVCfHPo?=
 =?us-ascii?Q?QqiiFj4UPi/67qrjxw4T0RFDzOC1k/fiikX53f2HtAIIpuzRoXXN2MZ8d2iu?=
 =?us-ascii?Q?UDLPxQO8UbEia5s0YHBcsoe+GeOMNwlIO8qaZs3WRsvoFo5AzUo5m2nqHPbO?=
 =?us-ascii?Q?6CKg7Brrcxe3bJywuewNjo/vPPjoK2VBmWRFQhZk84in4AMH0jKbSH/SNmSE?=
 =?us-ascii?Q?fVXBaRkBI7rcuPWj4wEM61HCa4IHjmjIFqbm2KSb9vfDUOn/bkwxbtFwgd3V?=
 =?us-ascii?Q?tM8WZQY6HW9wsJglpClz1ww6+nCwx3srP0HFHNFUh425y12zZqfuzTOKqMBS?=
 =?us-ascii?Q?OwhYXC8D3NikK8MpDi8K2I3AVirH3d6pxwmMMZyhcRExdAxpP+hyAiER5Eh1?=
 =?us-ascii?Q?/kIFU6q74pY5ZwtMCStjP66pqq7le3mWVQdtIZvNXBpIisxgubAFDgvq1cwS?=
 =?us-ascii?Q?5iAc5caUIRmZwbitfvGNtR1V1HiKYvR1+kZceQDVxLJUdDXGxtZdEdvc/V7B?=
 =?us-ascii?Q?2Hw+z8v5m0F1k303q8JhDh/KU3UCaq0BWIlim2Wu3a8tvedEutyM0LQdAGIM?=
 =?us-ascii?Q?sj2Fw+Rw8UM2XSNC0CoKeW+LCu9p9ueZdd54AAk66e6azm5n5b1A+X9w6q7A?=
 =?us-ascii?Q?yOgTsHK/IANu52vAri5HGK7lqmlaXmBRiim7FYxDoNuGeEEnArEEu4ZH201Q?=
 =?us-ascii?Q?TzgmTgRWb21GW6lVTvZ1CIc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b8a3e7-8582-4572-7cf3-08de013937f5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:23:59.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBetxVK20f2vkOfQsCUJ5q42CKIQmitvU2CPmJFUK1wAtCp5Y+b883LkBK3ZoyEQ/mrPgvzfT9NCg7jQBTkwa9F5BidSHdPoikwMCOJYkmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

Current dirmap code does not switch back to non-dma mode in the case of
error. This is wrong.

This patch fixes dirmap read/write error path.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 2d86dc62dbde..a39c3ab4af5c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -691,13 +691,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -797,6 +797,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -926,6 +928,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
-- 
2.51.0



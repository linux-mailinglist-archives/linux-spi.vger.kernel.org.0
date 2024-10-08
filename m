Return-Path: <linux-spi+bounces-5138-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DC993E86
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 07:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100BB1F22C85
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 05:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D3B1442E3;
	Tue,  8 Oct 2024 05:57:26 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2093.outbound.protection.outlook.com [40.107.222.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5901419A9;
	Tue,  8 Oct 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367046; cv=fail; b=RFz3sWvhWxBg8iztuMGbfns4TCwkwRvN/9MPfnL3CNjFR2oJ8bDbmH9r4NODxwjoSyz+UAFI6I/aLZGwtpXE3vL8l6eeeIRU1YMQxX/BMGDtomC5hEUwm3F3eoag2WEABs8L+dPcoOa2p3dulDpv6O18Fe5wANcZ8PFasFE1ppU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367046; c=relaxed/simple;
	bh=X51J45QabFI71Uov091eIshZEfaN1dlg6Q54QCilZD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWtn0CEBftZGtmtP4I4ut4mHQBQiN346TVHKmXM7D2itmL6dyz06TAHy4clsCWqSYSbI++v/pCuVXbVk5zcwsqm4PrVf9ZKmgTfEIlmazbVXKKV+ykw7eFpY5w0faxQOT2vcVuCYbozfzrtccE+NLPiNdDRmEoJf0qK1jsPT7tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGiP9FcOBvQrzD6Oh6C1ZA3NXKEpktn5eLeUcntYpq5jctFJ6SzHrJ3RpXigDfr3UWTXqIa+B4rIS+DUms2n1wXUrD2z7F5i4LJGhJPD/tOPp452CFfx/WQ0v1VF7HpdSLSmYpPTegj32kuIFAMVohtdBIe7o65oUypFDobNMxjHiqrOTV34TK2p9BbMUR09N0sfHHpE/j52FNv82X5plvblq3OMP373P62i7leNQz1wrsKVXerVMkLTt2gCN0kIr4QD44qONqEbGaalpXwDOhWEm1cEe91dy72JzOGlgaw1GzMLls6HJcCwnPBR4IWdWjIq/Xot+bd7fk97pR6/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKuRi71SLF418fDZMOlqher3E5JqtU3BAIZCWmKv/z8=;
 b=fRtp9OHqpdkp/RhaIsH3puCDEHrLXlHD7aqyLDdufwxHPALigV+I1GcrNTa+7M23rtM7H0+GTXo0SqntD5Swz3pfrmRBD0XQmsmyFqrbUrgsBMKTGJEnqvyPg98VboQtLEg8WNR8cscdoNH2Y3FfvWemgYzOpkPi0WHyv44XMbrzmq1XiAgBfO2XHDRmYsH0NEyxHX4pFVnjM36bK9CrHHZMzbDVLNGYXWgci5YwZAaUhRdVXMBw6gvfk9wpaksBIrN5ORV4x/pW+crDrDlABebR3RTZETv9RrXY8iKDUlNfcZXT+1v0RNqXTcFZfVsN1HiE4VyBj5/sZBFCcrbc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB2160.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:57:22 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:57:22 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: olteanv@gmail.com,
	broonie@kernel.org,
	frank.li@nxp.com,
	shawnguo@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] spi: spi-imx: Fix casting warnings
Date: Tue,  8 Oct 2024 11:25:46 +0530
Message-ID: <20241008055644.4900-3-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN2P287MB2160:EE_
X-MS-Office365-Filtering-Correlation-Id: b35ded7d-835b-485e-2893-08dce75e1382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOJQ6cRZXn6Ku+td0pZYIdj7hyx5bzLeHLEKU8R2zGjS1NE4EzrsITiBjlNX?=
 =?us-ascii?Q?ZRBzQPogzO62Dt4clmKhDh1ONIyt2Gd+t4hCcq3OeVWpJTbsE+Gzpi1WciV1?=
 =?us-ascii?Q?8l72dShNL3gB1ZGC4S2rlSeFcopq4hcAgb5KMEfpX2nTnDMsJCRCXyfOQD3H?=
 =?us-ascii?Q?SpnzJz60lDjVGtPbB5/pnzQnt3XmNCyoRdSrTQJZB+GcBcvRwA3+wjULcniH?=
 =?us-ascii?Q?Simua5/itpIbCiui4d6mlvwk/vZlNHK464sDcNZmkD6s51Iskd4dMDYrcXMc?=
 =?us-ascii?Q?ykBk5DEbH3EnTL/PhSCWpyyq5sWqhxPImRfVEU7II2r4vIWkqxPVCPbxTUte?=
 =?us-ascii?Q?6ajEZe6100Z3TZEmP1H8flyqUcthafBdYxeU/EJgL8CwrnXnkTmaixT8hM6e?=
 =?us-ascii?Q?Ih9lDGhDxsSaZzq3hxM6oH+bLAHy2XFSuRqjsvt+XKZHSTZtDNtDymaX1Ypr?=
 =?us-ascii?Q?TG49u2/TZ7X38/hgqu+OeJtC68o+Y7eI8Q+Rre6CYvY0TmDLYXbU28+88zqP?=
 =?us-ascii?Q?ycGrOkPcOobzRIyHt4+p7G0gG3yIzzqBnhT28O4vQDdsXO9GWPNrnZ3N/I4S?=
 =?us-ascii?Q?hRbT2Qp+zXPnyUZqRAioT1K9fTlc81B/k7C+1MX0eTYuyqDxfPxDaGvxecym?=
 =?us-ascii?Q?4XrrewNnE2uL/GyzjVUM+H7Ge2mxg9f2CbhRXPKezeYl75xqOzRzqTROBh5Q?=
 =?us-ascii?Q?7yAV0yZ0G87EAxeFmbpT8mZlJJo1QKMVaiXPNjIyZZGE1Yrb5tuuwD1JxcN+?=
 =?us-ascii?Q?j452OOsP46apN+vhZeJHbyq4xot7IYSyKo2RV0l53eMjB8WoXkZvQHhrLJiE?=
 =?us-ascii?Q?NVh89WwtQJfwYPhAAQFFmtNlVJ0rcwXxWnOtGEmoIQS5yV0QUhufsOL+6CDQ?=
 =?us-ascii?Q?a3cCDu7mS0k/pifZ6LMvoYxyBE56p6zPuR+r1PR5cFqD9JcrumdOUczjpJzg?=
 =?us-ascii?Q?Z+13ByWFP7lmu1QGX56QXjbvdctGW2fL8aWNQSvZqqRVw9RLEBt86jAlJvI7?=
 =?us-ascii?Q?+9qhdHXLJQzU6KzuL8sVgrG/jufUdlRMXpnlc10O6XpMsOO0bzXyLEKxOK/z?=
 =?us-ascii?Q?1bLdCcKBN4zHAqakoEcsUvgoW5EjFU1Vf10Y8yvL3zPLSqevfRPDkmbTZByH?=
 =?us-ascii?Q?IpC6hkNs2kwXsmk0XihWxLnCWqLjGJkZciN9O01x+VbqaV87rt8GYu385ip7?=
 =?us-ascii?Q?EsCyCGFipGEDRb1tyX/MuPN3O4DS9pbHr8HuQdTOdXiDJvVl4OGT8A8uxrNS?=
 =?us-ascii?Q?iJvCKaX1hzRAN0tgmSeX9LnQaC5Y3HJz8pZQHeLYhyGTM7NeCP8lY9xNyfVs?=
 =?us-ascii?Q?kn/fyEr4GdSJyJ0iR56P3p1Pdzy31uQpf3Bo6OXc0AHnRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bO1GtZM4pAwbnyv90wp0A0wTheEGMHOMkj6Db1fx/ZkpoCi34x4G/UIS8wdM?=
 =?us-ascii?Q?a8QDMNhlv1aaShIyANHtW06R4D4qtZ7Hxc1U8jrMLNPWxad0gr9v8NGnZeqd?=
 =?us-ascii?Q?33chaJve3QEeojJ6FtgBMsyppExLDAXUaWRRoYkDC5qCl00FYsTTHULMaWrg?=
 =?us-ascii?Q?2dJLVjJIBvQNe4CkwxbFjWcuIzB/AbkyR6nnK3bqzHpkqPEaVDciRXjFtZg4?=
 =?us-ascii?Q?CiKjWVTA8vj80tUggkd2HSLk1xQpXbetIIp8xH27R5hI51TPItrtFKiozBte?=
 =?us-ascii?Q?zII8VoQx+/U2svJ4DRDpqdpZztRP0qn30TBGpJV5N/cqajU+aGaAXOkq+DCP?=
 =?us-ascii?Q?jwXn/RUc8A9/S5geT/v61qlvwpPMoRZMibFQKIxLDnJuTwPKg9GL269vwYcg?=
 =?us-ascii?Q?8WuxROnz3xlQGAzyOn+NrejDfab0bsNEA2+tR58eMA2PI/GUmAiU6yJZ+sPr?=
 =?us-ascii?Q?G0dYgv979oXxQCCxHikgXVS2mAUETNnCr8jXZzlMS6z9kqcAxExe5ahmVbxv?=
 =?us-ascii?Q?c0/ZX3iNKyX/YC9/EMclHOvOufOS9eAPJJM/1sOcrzZN7QpuLJJJ0+hs6AgF?=
 =?us-ascii?Q?H4IB9iDTyf+TBj7SxKM1sgoNTFNbOGPF+djJhu4cACI4Wf/Crs36zlVB542P?=
 =?us-ascii?Q?YmZcQ2XNG6j8WkwEoBrsN5nSfQbXoboKBZrJhzJTHSW5c/H7u5K+Nz/z6bFS?=
 =?us-ascii?Q?PRO7XCHqSS7KM1FOfSV8sp80pJlkkbHLojggGz4HY+zvHnAvgY7nNPSTNQMY?=
 =?us-ascii?Q?6ucLvQ5RQTVrHleBmloXvqSKtigskrK/dyaYqZYniC/GrT7CWWTdNPvSr0Rv?=
 =?us-ascii?Q?CATbY+R58wEU7lBupJzf+gNZxO16x9OmQuDZk+iJ7hWpt3kk1rRrkCw6MzwW?=
 =?us-ascii?Q?bgf3yV75246g9lr0PAiIFru7xR1g183il0/uZxSimqXPm+DElE99vKgo51jA?=
 =?us-ascii?Q?JGwirNA8KllwQi/gy1Dof6EypKifMjFZIyh6nwzuFZM7P9mZNQvmDqJjeeqP?=
 =?us-ascii?Q?ow1oYYAEwGseG1Cq/9OUhEwEyMjnB+xI4exfhw50V2ntdkrQAHF3KY+GvJuV?=
 =?us-ascii?Q?bPIbH19Iy47d6uw9tQiUTz3Mlw9S1r5x+qAdMY4m4zHYFAOXq5P5doyVbVH5?=
 =?us-ascii?Q?nNflSgXZ2C2T0sbhXRfM1WRFgmOc3Fwgalw0Atez21YndFerpXyRALwf1Tw3?=
 =?us-ascii?Q?eHz2Fijs/0KaMr98yi8fQ277kCkHUI0QXJkUAuCXnFbjbjq1KOS8ffw/Sir0?=
 =?us-ascii?Q?Gj0DNnc5nYPrOQE6ED/67XtkvD6iP2Jry7mLLVDlNSGwxWv7swyaHL6uIypz?=
 =?us-ascii?Q?pbG5gmxoEfYjvfi/v087wUO8uQHAZ3rIBQuGnfypUSISDlg8P/DHqAo+wLMU?=
 =?us-ascii?Q?bnXam+1vwpU+Ht4xcrLXY3931jYt76hKTeyYUAar7gDcQn8MH5pzOta9Sp04?=
 =?us-ascii?Q?rPCE8HzTFpTt0wgOd+RfFKqj6OAQdbYxjiUw8BH7Q3lldzkypOxeg+GoisMV?=
 =?us-ascii?Q?4JvA7ZqESZp64yuWgTqmL+/XKpvdcO7E/6e6ueEtmnt4eYvydkqdzgxllEVd?=
 =?us-ascii?Q?XIKpktabqscJRIxpF0zoiwEly4sMP4oixqNCHATNp2Tb9EB24Hz1rimJSh30?=
 =?us-ascii?Q?PbfgGhjd2/COIJNu+FTNqc4JYwZ44450Dh9flnMm+s2e?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: b35ded7d-835b-485e-2893-08dce75e1382
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:57:22.0728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30sng/ykHUZXf7Xks8gHnQYUTdjBsOMXCaFDh9txlPZtsZJKcDH04j+R6/vcyU1VmFrFFfkKD38xVpnPT2KZvEdIVjBX0YCW8d0mvN7gnkeH6dWXa769SjZQufo1yEy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2160

Sparse warnings:

drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:439:21: warning: incorrect type in assignment (different base types)
drivers/spi/spi-imx.c:439:21:    expected unsigned int [addressable] [usertype] val
drivers/spi/spi-imx.c:439:21:    got restricted __be32 [usertype]

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 drivers/spi/spi-imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4c31d36f3130..fefee771b042 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -407,7 +407,7 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 
 static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
 {
-	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
+	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
 
 	if (spi_imx->rx_buf) {
 		int n_bytes = spi_imx->target_burst % sizeof(val);
@@ -436,13 +436,12 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
 	if (spi_imx->tx_buf) {
 		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
 		       spi_imx->tx_buf, n_bytes);
-		val = cpu_to_be32(val);
 		spi_imx->tx_buf += n_bytes;
 	}
 
 	spi_imx->count -= n_bytes;
 
-	writel(val, spi_imx->base + MXC_CSPITXDATA);
+	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
 }
 
 /* MX51 eCSPI */
-- 
2.43.0



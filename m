Return-Path: <linux-spi+bounces-10414-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F4BB1F95
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D179483297
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD444312820;
	Wed,  1 Oct 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="p3gm0NLq"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13E3126B3;
	Wed,  1 Oct 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357451; cv=fail; b=NzmWw96pwdiLYeQJ4TOCFatruWYgR/Rg8HDc/MdPTtreQ0KC9tqSHABmOim6yDqt7vqMSetYWj3BJh8xDmHEFNEU5Wgw55EhufcAevmIx82pUmyyVv0QUxKMHY9wvwN0Wnz5BQ5nXMjiZ49LUrYEQMuWcsjEg+AQf/p7mJC5Wao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357451; c=relaxed/simple;
	bh=8l9JymTCgM+epgUzk4VcWqTdwxznhd6zcMGkq7eDAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRF9fEXO1EbQjDQwlNNz9kQ0REeOKo1vHHHK9GsQEaywS3OuzZRn6WtIaZV/HqLcO8j+qcC/X76dMx71Jdwar5TkxKTiobc8hZgGG3NMsgC8j5Ex60R3RCZMV/WFIsJeOIMqxYtt8t+/cBVnlEfqJ6UYZwtFoL6sWAbCeHx5bXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=p3gm0NLq; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug/KtfsmWJ0SXCsH8xuSxzsSjqXqJSCdHK3HY+nffDPDQy8AafSllwFV/67sn9Z3KLsHU7VCYxgPG1WQKQtVIHmIqj0Xv9k1y19rCODY00gyJ0nJJTiLVCyACGjckipRFW7CaYOrFGE7jCp2tAUudbgZVsPIZKdiV2wKk32mpJoaQN/QFNsSCwiBKjpuu3iLp3L54SMPzoHgkFZBDTiXyZM6LDte1rWEL87UC/VWd8WdL4vJxDGy2ltwAnjDwH5zoIHuRKYPk/jY/GhFFW8LjQzGba7TQgACDkkZjismheFIHdHhAygYbyXDbSWRdESTKzI5FWz+c7gByppQoVXRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=rhWzu2B61ZHiIKBb3URSiGZUee3fTOznv3W08cIBx9v8ztMSnnyKmeN26kPSNiC+ZxNTgwvn26sv5YC2I4yUo+I+BZiFlvlBMr41Xr8e1yhuZcVu882MqFO+tlb/0/wqdQ1PLXny8TH9tPdsgwy3hytaxU/Mq1zhO7+ElLlDGI2n3Hsq+zHi7nbs9YIBujmoVNIIXFBpnzdaS35LyDN6AmVmqehIQbI6Z4yposqPvwuYzf8jOyPjnmNQUV+3yfna0Hj8om1ndvPm5ytoZ92nRqZ2aQY9Df867FeJ+A+9WwAQ41DmQpanjUin/CI7J+2MDb5oFn9DycWXNr7ntsb3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=p3gm0NLqSAjHuHFv+lKHDlaJadb+6A/T5WudQBxWoNn1vy6l6VbtqoKZNw1bvbqa9lRrc8cJ7MAe4JbpukZGjc61P/Uq6w+lHSY2c9czXYDnbvxiTD9D15d8nQrql9/NrRCziMN/xVkeVdOHQAupwnGWFfbEHQAxPw0N8S5h6vVXkEjfFxbXZFyvh3wO36umQeSgdxXMZfj5QGZRyzEPXXEjJRmlPRogg1k5+ZBN8jCsHbRK8vrqGrj7Zif6cprCwQRe+VzokRhLLC4JRPYYaVrs8m/Bdb3bxvc1gHzHPpm4fSFS4vbSxBSBU3USpu67YOiWloiQTxQ5Wsezn+0Uxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:01 +0000
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
Subject: [PATCH v6 07/13] spi: airoha: unify dirmap read/write code
Date: Thu,  2 Oct 2025 01:23:40 +0300
Message-ID: <20251001222347.3386506-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 1a87d7cd-f451-4ab0-9571-08de01393916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEq3zSlNy3Yil+NtQnIgKyDvUzUjXnICE5CY+yKtkHrG5vXb+Kl1Mioh8P2j?=
 =?us-ascii?Q?BI3cl11imtZZ6A5SDJrt/UsiFqAJp81pu08SU8S8I5FgbvrNgOl2LNPZ5Us3?=
 =?us-ascii?Q?PIG8JFiEky86gUFOxUgh7cY2micoW0P2nMe2zWqGEhG4kTqyTbTSBpB9OtMd?=
 =?us-ascii?Q?3Xl6gpbERB7XhFZnSYJRFkpQceytUiiDPJXcU1mSx5e3zghuzGwrrw+AQzCT?=
 =?us-ascii?Q?KWztaq2fucTJgCe6EYAoO38yo+vaMRVEJamt9WwITJudhXyWSZB+dBlOozCG?=
 =?us-ascii?Q?u2ZFcABluOsUxe8kxInxC648YFMYRJYqkAGHtdGKopIZCqiwoClW7cK/qQec?=
 =?us-ascii?Q?ZAazH52qsuaZXwK/A5mG+b0LKXu31d9gBxaacP59Zd2gbOSFeZdXQDW9dkLk?=
 =?us-ascii?Q?yCLnGy5XnKdkl6m3eouKRJX4A48LPqx2ygef3w85wLZHvUqxQCIEA+xccNL9?=
 =?us-ascii?Q?uaxvUqpgj7VFM9Ergrit97QpxGysqP3QfsGn365lwRIrn4dOuOECDtWPKAzj?=
 =?us-ascii?Q?S89yhSfpvDotAZEPUBoIwjz34lklaVgtk2+PRlDzmR56Antv91XLHvSVdZJE?=
 =?us-ascii?Q?+gIah6xtu0UYLD/VdH1vNfAjLZYAAy74ARVf4l114SM69F8w8kePr5J5qrq8?=
 =?us-ascii?Q?kQdknhWOX9WmO9hizhmx0p2rBjhh87biVnNOSo6bGWyi3KtM0+OXWxAsqIxr?=
 =?us-ascii?Q?fmWgEPXEiRhspoU//uz+oaOqXvFTQvWgGgCuWQXskDrKVcs2tz76Yi4A3e1G?=
 =?us-ascii?Q?RiZS+WNYukrsDaSL+uh8i4qitZuHGSDI2nP79u5EGrij3WV0/K8jDyKEduwi?=
 =?us-ascii?Q?fPip0lteRV2R/+zVM8/QAs6OR/Dvy/S/60hy21RQFlscAsUdfaGynxiLNKX9?=
 =?us-ascii?Q?mDFSVf9JcjqfkzEU+INROpQ5ib3ChEHDaTqm+XKa0u0kF9iVDOyMYbemHJel?=
 =?us-ascii?Q?FHWk2bfgL00rec00TMqWzkws8J4qdNGQ7Yb33dQgcGuz5V5aTzlOQEk6wX49?=
 =?us-ascii?Q?AxKICBctaVLNhboo1cnaPdA6mULzqKaK3UExdm50cvdFaxUad0tQ9FJnbQ/l?=
 =?us-ascii?Q?+ZYvZ/wzoxc65Oc0AfFpZ8U4j23rnMC5RREHppcmQG+RFTIv4wIAakhAsyyh?=
 =?us-ascii?Q?kOEwfipnSV50sV6IT0F2nsv1Fqs6u8tOwhQ7q7em27LbridFxJuzZ47BLnrH?=
 =?us-ascii?Q?T2F1TaMh0pzSrZom8wvSTikitJlN+KZYelo460mbq52fBvHSlVlsnGk4jZ/C?=
 =?us-ascii?Q?oNAXeXBI7OyxN5dMDEUZJd/jcwoHMjTctC0KLWToy4x7rg70lMl5NsE8ZuvT?=
 =?us-ascii?Q?hoOX2Vx+PNHObUj7cB4taOECkT3k/ntRGUvB4QbpPcuvY/9gDHONhkqcitYp?=
 =?us-ascii?Q?ASY55hhhFVFkSiSJoKvjJjZUfN8Hn/6GgGckvAzw9tcrpVxokRBeN1Qie/j3?=
 =?us-ascii?Q?KYDeSJTxeKes4qN+Fcwdk7JzSH7D0AFu41rqS+GXv0lQojb+YoNRzF1ooBEu?=
 =?us-ascii?Q?9s1RRK9Cgugv3KVdvFgh1iZTL1fBbHbMCFRz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbxU7oPMZuw6zl4B1BiSYU8ksulPorXGum4SnzxQ+eDvWnq5tVLSxuPPTe71?=
 =?us-ascii?Q?kpouiypGzIz0dU6VqhSXccdLkSQq2W+GJgj17V6bb5HfxuaeV7EqMfj8LBIb?=
 =?us-ascii?Q?yym5eYF6ezyoMm4XsxO8uomUPGATbScKM9OIIZ4qh0e6uWimWWlXVYaBsaNP?=
 =?us-ascii?Q?Tmd1Sa2wKTNOVy5ky+l1AUxwk+nemv92RkvMrSb++QsNSPXu7fAHj/rNCqbi?=
 =?us-ascii?Q?/6QreAfLk09HNo+B7pXuoZTWSp3g0351eFmqek2lGrDyOgVTYW/PzTyUqa1A?=
 =?us-ascii?Q?7wP8TzUGd+oLQL05TUdO9m30CLoq0nsYJy/AYFT0bo8ZoAZdNOie0OA7z6T7?=
 =?us-ascii?Q?uwGR+PclF4GWPV8womOOheJCh9Sps7U7eLVRrum6f+/0apFV0kLc7/+S64vf?=
 =?us-ascii?Q?UxHiyxFANcybO6ci6+VpPTfiVY8DhdCC01rQPS7V8HcU7eRmOhTRFsxchUsm?=
 =?us-ascii?Q?KozaaRaSgbT63OrntQEZe95ptd5Zc1NG6I15oHGYoYcxOWwBo4zmF8sdT9+v?=
 =?us-ascii?Q?ijLEbz37StTOmcOhAC/n1+vwTB2J6WeF2TfwGq99kHGwKx9tjLq36unlI+Iw?=
 =?us-ascii?Q?pX5ccQfFeGSxsBkPINqvH6fXST2nDzF7+56iREgecjJ8+jn5Zt9fryJaoMax?=
 =?us-ascii?Q?nrttMOGoFpfljpTWTc/DtGVcRtpAz2a8PkkTlvnBaoBy2yyE1d0XNBG1FyKz?=
 =?us-ascii?Q?ZEOZzW9PQEGYjuODDSpHcXRQRIah8xP7L46uYj5i/pd22AyCpvJ6DipvyyQ6?=
 =?us-ascii?Q?XsUVM5LCWekok9TeUU9V9VyTiKJXrWWbdDS9Xc9a9Ae8I4Y34DxyrS+XWPWQ?=
 =?us-ascii?Q?r0LPm59ciWN5rLNxBK8+yfoGR9N8QdG8zg3SLRTx4X2y2m4UzCNO34KYe77R?=
 =?us-ascii?Q?muc/F88qfbZZEchZj8MTpwJY60tPV+1JoO7Jp9yE7VHZXoXm52x3vPB9/o8o?=
 =?us-ascii?Q?3fQnts9YUBCd8E5TL0HZdJysLiMCl1guWUxm2Vu2NnECLJNc5ZrZsjPpK8zO?=
 =?us-ascii?Q?HTowaCCKiZuQy1mNYfsdpXlYOTb82RR9pZau0rqJbB+mVQ0OoYfyFBYG2SMQ?=
 =?us-ascii?Q?rLB2o31qSbBbJZVeAnJC58y/4EhBxCMs462s3Fr0tKIImI9hI0pxMudV5g20?=
 =?us-ascii?Q?rKajzWWk1P9A/Ew2yknZnaS/tZkcq9MMEfNWJKz8i5OAHAFdWYSCy2aBPAfN?=
 =?us-ascii?Q?yi35it/q63phTat6Z9YtKO/PsWtpfrYZ71BhBYAwOzrCLHidK62vkC88lJGY?=
 =?us-ascii?Q?/zqq1kSexeupXrXIphnfXiTfIT0A3Pm/G5ecIchZ14C7jIXeIBrz7UEcBGnV?=
 =?us-ascii?Q?cWXVgh1s+SmAXt5ylAKzVxjj6WXwenat1ljrmVdxsn3WCoaKgnIqdBFOFv5m?=
 =?us-ascii?Q?0qr0uFIb2Ie5KIizy9B8rWigoknOpOTOOpP/re+sGgsF3WHIQmhnc2FZdTbT?=
 =?us-ascii?Q?BNJHC4EeXJtE7z/WInQxIEfiffpJECu4r6zkiIPkeNq+WihaSQ3I2p6PO4yu?=
 =?us-ascii?Q?esjjKr+1QV2HgTEVUdNnzYFwCS5HG/SHVYCstzT4JdxryzU5DPecXWiqO/6+?=
 =?us-ascii?Q?oCbN2oP/6dhtHu0bnKcrO3V84G5DwpilwKsDJZnpx65Qq6jMz/OvVb++k1N7?=
 =?us-ascii?Q?E2WUS1+otsfArsThVCGvYMI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a87d7cd-f451-4ab0-9571-08de01393916
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:01.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOtxPKQNM0oN0Cr+APxBzlcZeZktK0P/Ac4JyFfBHvvkPDZG0jKn8PybfZFhQeFdApKyGIAo09rMfXK2m2FvfNhcbzeiyVO+nDr/hWGU6BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

Makes dirmap writing looks similar to dirmap reading. Just a minor
refactoring, no behavior change is expected.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 50 ++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 5ad3180ac6da..e90fab69d81e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -672,6 +672,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 val, rd_mode;
 	int err;
 
+	as_ctrl = spi_controller_get_devdata(spi->controller);
+
 	switch (op->cmd.opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
 		rd_mode = 1;
@@ -684,7 +686,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		break;
 	}
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
@@ -748,7 +749,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* trigger dma start read */
+	/* trigger dma reading */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_RD_TRIG);
 	if (err)
@@ -806,37 +807,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
+		goto error_dma_mode_off;
 
-	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
-	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
-		wr_mode = BIT(1);
-	else
-		wr_mode = 0;
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		goto error_dma_mode_off;
 
+	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
 			   dma_addr);
 	if (err)
@@ -850,12 +861,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -887,6 +899,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* trigger dma writing */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_WR_TRIG);
 	if (err)
@@ -931,6 +944,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+error_dma_mode_off:
 	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
-- 
2.51.0



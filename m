Return-Path: <linux-spi+bounces-10362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA0BAAFED
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7EB421827
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE45238166;
	Tue, 30 Sep 2025 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="zQIuOXSv"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988B235061;
	Tue, 30 Sep 2025 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199240; cv=fail; b=cwYyXIuIqJoXstsBD+QIc4jbLjzB1h41XvgLp+r01oxrd7zx7JQpFuXgYTvAfkjc63ZqNihi97M7feCosHOoDb5S9CKN02SBeH1hlLWQq7cWA4/rNB8/B0TXCShjg9uAh5XzZYu4mlMcz689vi5/ysYA+WHP0uTFZrRnXJF4dR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199240; c=relaxed/simple;
	bh=F6NRyc7/cX+BSvW4To1kseW47f88kpIUkdwIffKL54w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPh62vUw7yfiPUfx+/rN3pygUGBXUJ8SDgjQcXpQCwRZCOxBYdY9dH9LUJbofYId/TgL+/361Z9wgeCyKJjSZrmNtYpK9CGl/VA1nct8VSRDUm9sZa3Ucp5IVrZ8RLADbaG61LDgE50BP0OkEw8OyieOK7H9LkDiYX5n8ZIElD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=zQIuOXSv; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbJX1UqW+FnJI/Fr4wfdjY0qXKC7FpzOoY5X1YjQkkaiyQ0/YD+chiXsXXoXXdiknSdtQQxsVRnfLbR1StDF4EjW/d5O8rsDC1ZzpSeYHLhjevs3aWsUmYJtlw0aNcQn3lKZTgUw4AzzzhaH+4Byak12pUDnTgFzEe+gEN7yEef9/32Ep5EF6qIGfcV+/USzn/rnQ4JTNTnNuQ7vvGP2yW53VqEFuZPdaoBeM9RuCdeFRouW0HcwsdB6HxWiYnUtZp+W1BlvHFnpBGAz0YfXr4spD/BH+zDaZhBsRF3MpLo/QCbej7ilkQ+Nn0SMVy/q9oKiunnphenSvJMg/0Q/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRDCgAwD4yOLL/rPcqJ5VW+75KQdSeHCdcKAZ3Pv2XE=;
 b=JM0iX5Ivc62rPBK5QivVejnRhAPjBj6QDdBGSSuTJXzP4sB0xuPHUYCKnUQNoncJJV4BbZZIZEpIM0KMxWfcv3BSyVA3PtZO6wQD7J7oY6H5ZoXFam4+Zx8xtpMhZVPMpuopE8QtxwKAeIbje38XzqcP8YNRDSPbYg+YHtS3DmG03QrTPfHO4bHCiTrA8oPpQI8NzQWBdmX1KlBeCwjHVHLHHKV+DO930BwGx5Arek2+g0l6/ungdz3jD/b+zpxnfDl6y7q/SNqZrqeuotg/MuJzWWistySdOadO/oM5VlyBD/qD2CPeHN+pgwr4RNKL3wroK3KBix/IUuYJGENE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRDCgAwD4yOLL/rPcqJ5VW+75KQdSeHCdcKAZ3Pv2XE=;
 b=zQIuOXSvMiwMFMuBo7FGb/7qpVR9W5z6Rh4XAhPGENMVkU3ynWOFMVxJypvhoVDlJB+dNgSNln/TMwNhBEfoWKFYYYl2oPR91MXSBdUOJ8RQelEbscZ7AWdKxDlCHvK+P5qYV9GiUHig5xXZEA0LNwgSVQreGyZc6W8uaQ9JwvOxweXyulh1HA4rfBo8lgZfqGX8ouDV88f4eUeFEE96jk4QFLEngyxaS+ElVPNejWVRulZol3HhK5/PMcCJreXJFIxWuukFJq/fUNR6GyGw6FcquwQsklQ+nHABZ4YU1EPE6iLS8JWDWcx7PXiklAc92Z9yDZ+JkeFMIkC2EKCwnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 04/13] spi: airoha: remove unnecessary switch to non-dma mode
Date: Tue, 30 Sep 2025 05:26:49 +0300
Message-ID: <20250930022658.1485767-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006627.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3cd) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: c68c4c63-c4ad-4bff-79b1-08ddffc8db96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rK/jXDTaZsQPKnSsWlou6i8KQ0kPmg9SNCboZhHO+ueBIZLZkX0IaVyl1ZDv?=
 =?us-ascii?Q?1Ed3TzX48Ljp4FBP0dfdS0JEPZmdUlj6qr6S45JOy7G+Qj85UVVrX/Iqnakq?=
 =?us-ascii?Q?fKuufQsTBbjjZlUdLH8a2Tr1F2jxmoZn3uiuJyYzwDdB6oAnFiF9lV5ygiPu?=
 =?us-ascii?Q?O59OL91/WxBeQqIjaPht4Cj7DsNfxp9GFMcH1PHpjJ2WrDz1IHKbV4AjG7FW?=
 =?us-ascii?Q?hVLikOU92MEpYQHqX9yi4QK7MzkkoHjtlG8QOTcvDlouaPB+RzmsQz/UX178?=
 =?us-ascii?Q?9k6U+Hmbfq5LVqUA+SJvGymu44h0rTl750sgXSakOkuGW9kYqLwveGmit853?=
 =?us-ascii?Q?5EP5/nMlzvKBGaQDPIZaiAFkjx+N7p6Xqe6F9oq70VO7XT9o63j1l97+vH62?=
 =?us-ascii?Q?N11WVtSlI9B04DKdP2cul68fq3IrZmuSYieCicNC8aDmKxrmGBio/N1kN+l8?=
 =?us-ascii?Q?hSevxRwpKDGRWdciNvfrGOHxH6vXSNg0gmJQuy8cgbENEHJjDAmrcbx5+V9+?=
 =?us-ascii?Q?QrxYWlmYjQqw6fTJdH5p0DEYi6P/8yG5QNGSx7awfWXUxeEYUr39A8/zVzv3?=
 =?us-ascii?Q?LZxV2P5svrE5PN3+rFdyD1SfElHQBwwVW5kzdKNH+8fsjYJRVP3AY9gpk4m+?=
 =?us-ascii?Q?Pd7FYEx9YNjI6i6WpsZWLjcU/UYp3nrKC8qVuCGufok2dKUnHkuX/7xfbqwg?=
 =?us-ascii?Q?S4N+g4rzcIa9szeJRur8WHgrCch/IRXyF2qZnD2jlK4ZtNs1PVCoeBU/XQxA?=
 =?us-ascii?Q?eBVDlY1GpdY+J3RslM8XKcTjX4DVKb4DYPJvAGozjHVsAQRF1+7qEBc2XXEW?=
 =?us-ascii?Q?JjJ/nrMBbadN1IokqnYAdYJD3wFzW7HiLn4jjF8FkV5bfoJRNCHxhJ/wUzDD?=
 =?us-ascii?Q?x78+8xqmB4nvCbcc7X374bLvHviLxUMczX4aCvGVKEO62NZoMSJ9ufAssiAf?=
 =?us-ascii?Q?PXM5fh4qH7cWvXecFQwgJapN0571lY2S1UuFzAgZB4h2LqNIixi9aqASnQMR?=
 =?us-ascii?Q?AJn1ll4Ox515G0EXd9AQrQ0sItZKQ6ilN76IWg87oRIB+8KlLtTPv3VLKOnT?=
 =?us-ascii?Q?bhJbgnvzpFaiKbwqjowFCuGkpIPGTc+CBakkcvMJWGZWSueJIYiDKIYpfJKX?=
 =?us-ascii?Q?Q2IH3uGa3nbKUXXHFN7V0+Bj9/mvwF/ocxlK5/Ws/MQUrzGj58KxIEyWb9hq?=
 =?us-ascii?Q?sYhEya5teR72c1OzStZUP2xohEt8dQ6zonzju5Dp662wehCzlLXWQQPRta84?=
 =?us-ascii?Q?zwFEQZCJ7i9WxOZEVZiTMeYEZHJxXKuLZX+Ym1g6o8qMEo4+UrnWUnee1700?=
 =?us-ascii?Q?JD6JFq7QXg3X78VkQK3MDF/0vloifgOS5EMmoYDXEyYJtK1MA7fPejOE7CjP?=
 =?us-ascii?Q?/vXk28zx/SABZy8iXTf1xtw1e+Ea+tb/bJvDUpMmHnpW+yB68qcagYWXZ+SH?=
 =?us-ascii?Q?0DYEWU/5XUJRllVhW3NtelMd+0lmb5j6Vthn9yX85ZkxxRetKxyKaBxf9mcp?=
 =?us-ascii?Q?J6Wr4ghfo5wnRjXRhrEK6wkA03S/byxlNGba?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RmceylUyWcLJzIq1hWMhUwl0CIeuHkVQSdsBueJojJhVy6CNrOqPg6lpg0nk?=
 =?us-ascii?Q?xboXEgH7FKzthEH3eXCdFueLKnH/8o/lFpPofO2uTCKlcFZS1rhj1UFtPt3G?=
 =?us-ascii?Q?oE5/vdPM+P8yN8aGr7INuoMDt6irlFOREUu+3Bb2BRVqwulzqlQ1ZSCNtH+E?=
 =?us-ascii?Q?TM91Z/yEZVMIdczzrqpTPFPv5InH9Cw9S2SIXXCHwoL49eBbJB+lwt3sV2pR?=
 =?us-ascii?Q?Lv1sAMUw8ovDMHC17zsqtQPoedaSRWXJr6rfcRkx97OJ1+Q1okMapnge2vej?=
 =?us-ascii?Q?QwulHXsq3IDkyJA8GhKpDDbOdq8FsAfvtjIFt1kyn+Ga7OQlVnCd3UNvKzk3?=
 =?us-ascii?Q?1lxoRukjsWCgDs3sX0CvWo6tXwk4NSdLj8kSu+PM3iCJYJ/aOesk0osBRYuN?=
 =?us-ascii?Q?UlRwoSwtU7sboBVricEwO+g1pJef4y8bTE4QULyj9hsWzCV4Bh8MmqjxLt5C?=
 =?us-ascii?Q?cti5giTVC//A//dOS4mRRU1/svKJIbD0sNRMIweQQdfjTqW/U6x7xvZkhQxW?=
 =?us-ascii?Q?dK82wjlj4KlsTKc3eACtxUbIEXeZady8sg3gAnQMi5+aliJEMV8BNTrjjsUh?=
 =?us-ascii?Q?XDXMHh3q05kl2ujnbyxiQw1XNYkGFvqtDE7kz5aABurJTqaiBkhd+YX16QIb?=
 =?us-ascii?Q?+gNDB/0L5ZyKgJPkJb5ONx6EYz3yRJ8a9RBwwUWQNjYVQdPTe3ghwMfpzBDA?=
 =?us-ascii?Q?azIIpRCwa+snFY2nyBcueBGDjPaomGI4uokXSvfLbl/pohShw1hJO+v1OnKc?=
 =?us-ascii?Q?TX5onN/0iYB3fXz08Nn9ZwBwEVh1noo4HS44R1yFsA0d9dbzE1mgizUGDhwl?=
 =?us-ascii?Q?1/FCM5NCg1Z5+TFq8zuBL/cRFEJn0C3U4A3f+xPtFV/V5a1PA6wNnZoWRgcI?=
 =?us-ascii?Q?BE5KO5gPEnKm4UDFjA3Ek9YWupthPfBuqZCqm8NfahB5nI77jqtm4ryPWdED?=
 =?us-ascii?Q?iJMGfyLz1K2UG4liWmJ/v94IBKt8VE+HAtgmN1nz4oOZFYO69N+lcCa+PG4r?=
 =?us-ascii?Q?55MLP92j737GBPxiqZU6FnVqwATu0ESErUZr7FLpTJ6YydrXRK88dQ3Somt8?=
 =?us-ascii?Q?emKoUgETIPRPOLS+ViL8n080Tef74SpyB9YE/QFYzyqYld+hThoPkXobuNOp?=
 =?us-ascii?Q?XxI38WDuSz1SPaJ9bQ9uGmHY5IqI3CBg8b861x2VEL2nPuj0d3vycYuiJCQl?=
 =?us-ascii?Q?5pfo+0xYFplotaePseAkRJiG1KhBxtXEnpTmAvAK4M0OO4OvGrmFYKgUhBSn?=
 =?us-ascii?Q?khSv77AW4gsPTQLrfj9r57vQaAS52dWkO6tNJd5WlGMs/HKpBMnMA5mK0pk3?=
 =?us-ascii?Q?9LMdYR0WdGYV8Qnwc8tmzkOvW1ksbGF9dFwSweOiGR5P2DmB4dyAOV4KEsui?=
 =?us-ascii?Q?SgwJ6v/1jpkXfjZp1fvont6zurjeTqHFBNkv7rZ99D/g8e4EV9WSJ94pEHvY?=
 =?us-ascii?Q?qk/J26sO4YUH+XdUHX73Z1CLuJ/u7yF8QT8nuF9a70RDzAuiSMWssxBlcO7T?=
 =?us-ascii?Q?O+3HQENbgsTyaUXx2qMvrub/xzk4YR4KDkfzkBUputdAW+RcikcT45Jz6XsQ?=
 =?us-ascii?Q?NerXn7C5Vngj1QyHQF90zT+3DYLLAmZUH0SKIbkCbZfqr15tpYe+o7Ueyjj4?=
 =?us-ascii?Q?GMiIO3fVw8pb/m67MHQM7NE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c68c4c63-c4ad-4bff-79b1-08ddffc8db96
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:10.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U6DJDbbhkF2TXWbg8hBjUpszq/k2yKvmjYGvvqYKOy6Q92BThCngahAb4ktEmb3epjUOcc/Eo6JpeNfW4BpeY90wnf20hmjaioHI8YGIL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
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



Return-Path: <linux-spi+bounces-9637-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801BB32A43
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA581C23B76
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340EA2E8E18;
	Sat, 23 Aug 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="SM2sSNNO"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021097.outbound.protection.outlook.com [52.101.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDC238143;
	Sat, 23 Aug 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964895; cv=fail; b=dufu8otIZe2yA/USZ2WUzJ+wLT2JpZqEak58RlDbi5nx0v2wnefH9z7QPBGqHqk8Z7C1FX30PtwrDjWVkaZL/xTICilC+PhKoqdk3ccgioF/r1wJFnYRlVAzoqTVdNtRa8Z/Lp0br/Ui4iXiX4lFU9/Wf5SKqGrlMVoAkBeLO+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964895; c=relaxed/simple;
	bh=4dfx/SFoGDV6AFfwoXXXNtAuAzdZgI5WfpnEnH4J7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpGTPEOdBTyxHLKI+1OLxk97N6on6vw+PQ8My0MhYKh1j7lkVHWU42P7slVCUUvROprvJyUS38Wj54r99yIoMs2EIWqdna0E1RcblECTMSPZXMwpqE+FwvkJbjio0HIvyIRPIKqd4Ik1kE0hrcTsCeOmc6hxolBT+tEx0F6lqV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=SM2sSNNO; arc=fail smtp.client-ip=52.101.65.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vq4lnGOaOeG6TmSVjbn6WiohPj6wF/rWqOr/2ixs0ydfJ5dxVEmlm+kA9bjOfYPPwhYdx7eFCdF5euBcNYtcq7i813021MxcrzdswcltIFYwIGWuLxvvxWUTt3XVty0jpcQEHzGJgLFVX1m+qXVLhFD2Ypz2zB5sQArRVdcqoldrqZnGPB5uL/I9UJV6hy1mtqNt7VmYM5Zle7k7XZbhec90gma7a3aCg2NSTX3JXmnNL+gAKKkvrGi7bamDkLM7RKfWlJ4KzR1L3bnuycp+//pdN8vOI8r08SPyYobhoipnsyTGJBSzUVrj9tPQOpcbwvz0mE9LLxuOPingaGEp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHmDOPbnpVlBZN85+1DnJ5UG5L/VqNy2oOxWyq5NUIY=;
 b=uGFg59I79++68iho8JJZlU77AMPwBD32T/AcUcQzRzkURl6517tRRQ6BXi88W2oGGKpysiTDly0Foy2dEJ5J8rt5yOWcd+jcsOnoZHWBygI1TS54gILK6GCHYcFgaJFkIJWkubauiRV7gClTQrQxsqK3dsUxWvMOKZlDT1HOYEmT4KIajLYmC6qgSfqDWANso5OZlyoxWnoJjm6Q2AXHf7aGCfqsMzjeeKFk/pgZw0HZZ8iW2esqvRvaf9QCQq7Nd0Sj4DeIDc2ChfjfP6fBMp4IOmJIVooSRTkvQmk47yYVYSrSXM9on2B762bD8sqQWr0caqqnl9xSgJi+Vc0JSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHmDOPbnpVlBZN85+1DnJ5UG5L/VqNy2oOxWyq5NUIY=;
 b=SM2sSNNOqONOo7RtoxdRduSAFZdO+Du8xMYXhYHeST7WoysETckgd/Z+JNxSGepF4silvXfBNkb/ofECudcoENYUofyfzNXiGlYo7v0oRLH/jgEQMtpA3xf605ijq4UH8WSF0iq+nCs5bkccas20R3YeNkKO+cSzeQeuQDOzecvnXHZQ+XpskFSfcLol0pc8RvWcYmsbxuQPkWVqs/XBA0rxMAb50bzpKfUW2q4AjRuZU2AXm1FO9Xv6QpjAe1zZk37peZduG5q8/nQ5VUW0zJAU8xtLv+UD1X/rTc2FbMcoQmSI4/G4lC3SKfpwjUzxj5kkd+l0pcdPdhDG+20enw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Sat, 23 Aug 2025 19:01:06 +0300
Message-ID: <20250823160116.3762730-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dce5b94-ff63-4c47-59f8-08dde25e5114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FITBamlyWbR1ahr1m7T5rP37T1w9kGOa7oa1Blnu3P2Hey1h7DIFlEob/h17?=
 =?us-ascii?Q?ECm7o/4OQ3o0O/j41lxCRsD8akYbMrG0fjzsXypV8tSAfrMgpl2lICvLU00N?=
 =?us-ascii?Q?+8r+b94OHlVg1tYZu1U5xaAPT9nccUO0zj7vMJyU2tRo+hCpqg1AigxFx4CB?=
 =?us-ascii?Q?Uh8aCz7yGrNhgK8VemMdU8CD4O3i3TQjU7MkDkezxb/dAEGtbE/O1G6TS2B+?=
 =?us-ascii?Q?AU07GOBZRH5bVUI5BuliZotXzNiJOIUfPQ+Esy7tPpsyqCsWIqjP3mUbZDDG?=
 =?us-ascii?Q?SlO8m4mCNLMeCvvQ5YmqwDtt2GlNj0av1pcxIQAr5Nk2jUEIhCbVr7Qbd8dj?=
 =?us-ascii?Q?Z7n77XfLOnMPKMV7ibafs7izXGNcPndUnxpjCJDaEqX0QuJ3zXBdAuv9/Hdi?=
 =?us-ascii?Q?UOuhJ/dlGMTAvbxghrHaSqgzy6pI8i1oP9nkhqpFp1a4CPrmDSQTEO+eevHd?=
 =?us-ascii?Q?iU1uX+1xCfGOGdshr08I0pWKRcWEYlxgIe5GgNhfGfFH71AAQkM6oj6t9Fn6?=
 =?us-ascii?Q?yar9sPd8f0BpOE0DCkhnbI/GpjKJVMWkwRQSfTAplKbv1XZytLFr4nJeFTmI?=
 =?us-ascii?Q?HNyN4C6QtN4aT5Wgmw9jAhnKun0W/78Bu7v0tSsJ86Xt6c9/soDVu17V0LKP?=
 =?us-ascii?Q?X5eqqZO2RN8ZP8xLW1AmCTbP7WOe7RXjDm/Jip9VB0PcHyUUv1MP5twnkmWE?=
 =?us-ascii?Q?8a9wkGidJxG7VpnR/Imd8zCQtQa0SIchoZvRrA7TmQB2YuCQ0GC5rFhUjRsN?=
 =?us-ascii?Q?kCN62t9IXi1END+NMUZoZqzRDU8rL7Dg/OE5To6uWP6Cix1hbZZYcbhwD2SS?=
 =?us-ascii?Q?cQ6UQ6yQ28iHabXPtSeDigxUpv4p8llq27jtQh2r37mAar4Ld+fhg1qIx2NV?=
 =?us-ascii?Q?rKAp7SP1HlTHtCcBvXi7FSlSHq6Nxcpqn+kJhjf81yraK3CpZnzdOO7BJAIf?=
 =?us-ascii?Q?BxV2bP/nU3OMNRIYubYDJ8NXJJ0FImy4h4uuU4+T1IembJhun9i1bOCnoR9t?=
 =?us-ascii?Q?YBsebWBxQhlvb5F0NQDa861wqOwUJ4n6QViY+0bwOThzd2LFHvyCt4JN1nHB?=
 =?us-ascii?Q?vkoEln5quSyK4NmTYrnM+lnP2RiqBNgAfpicndBCj/V7XP4bG9jIENtIkPm3?=
 =?us-ascii?Q?HXmdobXQwDghFawvJTWaiiOUlgQT2EtZeKHdS2oSHhYTwZkNHyy0W1WhqaU7?=
 =?us-ascii?Q?PFOEvHl7RgUyodZ+j9RqE/vsagXXu6/bi8MqZq1+R3Gs9Oo5zZQ/XFxoaPg0?=
 =?us-ascii?Q?XwmRLFTMLad6bqYgwR03uSJ8m3cUDHkIUWQN9g8PX6oQ3xpXCZWnWZ2tO8A5?=
 =?us-ascii?Q?Zrlp65jXq2pASD09OSdXG5nY1nC9TIlss6vp9OxvOnHuEJZSN9QPNaRi56gC?=
 =?us-ascii?Q?dS+A9+Ca/kAevCQh4yfhwHLnNKVX/XF4hIba9+h8TpynKb6mw6Q3zl/P/5rA?=
 =?us-ascii?Q?r1lbapVI1H+86qqCRxMlugyk2c/m33whCv8kFKhgobeR2LTt/R1XuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uo/vPCUZJAqWyvNiLxn5Y9spHQQXdy2DtP8805egsnNQU4BbYVNK2cDKwjSE?=
 =?us-ascii?Q?gyX0txxRPs1sExDHCAQfAvOZqLDPHVKl+roCKgfJw/wny5KoGDHdVxYbK+jm?=
 =?us-ascii?Q?iGrXdNLqAmADmRa7JAbQ9WnirD3NQa0OKq/7IwaOFn9jLcaK2VukB4vbAyZa?=
 =?us-ascii?Q?5DxC+Rb4l12AHidBCilyMrgXDMgdOsIPdqNkEhpDpCbgA0Eeg0r71FR4oxLx?=
 =?us-ascii?Q?Y0qrhwpBkjuJAs1kyo0AtZsHKBftSh6iucwSHQuO1Wcm49btjeRrTO4GUatR?=
 =?us-ascii?Q?oVItnKb6WCwkRxYc+RUqKeeUmjnwkUhMNYYBJgOZrkcUROa8n4QKyrQz/onp?=
 =?us-ascii?Q?DJJmcFBlIf0fjbhEl+vcthxPz1rXV5ZlkBJGyIanObmX2+Fy+zupXy4n5hqB?=
 =?us-ascii?Q?+7+Wf3edpFKmAroZQzGcZ2eDAEU54q60yi9YjoN3JHYbJrD4S4DBE0iE9Bu+?=
 =?us-ascii?Q?5/j7JWJXoFo+wFGSqRtG4d1U9GGXDczIOTadCYmXDIPuDZfl+Vhtq9/g07sP?=
 =?us-ascii?Q?HI6x1GvqdpOiOkMGtT2NNs3fGdlJUHeZSs2Gg0ZBXge9DDOKG/N5mKZ+tkMc?=
 =?us-ascii?Q?883gg0wvE4XBl/U//q79D3kJfTrUlm28RD867QMUBK93K9ez9Pmp+wUBXArI?=
 =?us-ascii?Q?Yiy/O3U8UTzyLHNGH+c3VAJ39b+4efxNj0axw+KtdpTue5Ea/dfcc+epDlw7?=
 =?us-ascii?Q?tENXM4Gthv473CJUOCGKhvTxpVlbBTzJC3SoRUE0vw6eaVrXsPlFrmzx8nlp?=
 =?us-ascii?Q?9KkLuUS69N0bpnjlv5/NLEFDCVWOuJZ0ZTTNtf8usJ7E9ag2AC8xcsoS/TqJ?=
 =?us-ascii?Q?VNh71gJ9AvukDKACR+JkHJABMrrK+SKgg9E4zPj8MTQdXL4e3UaL7ZNrmLho?=
 =?us-ascii?Q?HzkZgXsP+bYOgCC+XEf4WmkMMR+29nesU/r6knMFEDmk+9Kz/4kw5nRo5SoZ?=
 =?us-ascii?Q?hLwMmz7myr18KafVb1NUZ23jOLCb5z5fOwadeZjaGjkCJoEt1P1cVxa5+HNP?=
 =?us-ascii?Q?q+wS9NBuoSyOlsS/datxosEDhJQLfIdbygYT9kPWA4Py5wnxRBrUA3tvMqha?=
 =?us-ascii?Q?241w455+rFQLzIsbF4j/YiulanggKaZAWHTOsDcDKs/Up7HUJUkd+pRnZvbZ?=
 =?us-ascii?Q?9Fg8MSZ7OI6xKHP5bM2VoZ7rfc0KtwhDBok7y6EX8bNeoONb1IXtMEv27iwd?=
 =?us-ascii?Q?GrIyUUj1wm5GV5cRVLQ5CWqOOszG3dn0StPU7Txl42gz0eSxuJ5y+pnIWNit?=
 =?us-ascii?Q?cbhACRcGzqdkbQdxpT1DXJixdnRq5IF64iFlSurKwUzrTkvfq9235FT21pqT?=
 =?us-ascii?Q?uBK1wdUI717p/niAbBH6uRZf7l2SvoAtLPP4Ce+up7n2R9gqLYv3F/954NQt?=
 =?us-ascii?Q?viPbRib/JuGV3gKTGZBSAqsvehWp8yAAmH2pUeID7fdmbtdsNgFRV2Wllp4S?=
 =?us-ascii?Q?naTucov51rZtBgAxrWf8h7jEivGk6Ba+ZA6M7R2x3M4KhqkUlpOmf+yOGLpm?=
 =?us-ascii?Q?dOnSu552dWm5HyKlPX9+8FNKMGthhGYhGLsGGC1GEh5c9dJoJSHYdubA28Ef?=
 =?us-ascii?Q?O13KADNXCRUlV8Xa3UCdQGX8Mgj/daFP/slyPuHWxXL0TlqyqaYwJ3OcD7WY?=
 =?us-ascii?Q?3vQyaUAuJbFnAeVziIH+Moc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dce5b94-ff63-4c47-59f8-08dde25e5114
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:27.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BuiILtXLncho8bQMaJBJxeZxcCN7WCOZks1Y9n30CsShDGYxTg4cL9iKR8TjuCS07sxl3ITma0OG/zL7ERbbGo2dzknjIV67u7tY7N0wn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 108 ++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bcc464ec9c61..fffed26ff990 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -895,12 +935,28 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -911,40 +967,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.50.1



Return-Path: <linux-spi+bounces-10077-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39698B820F0
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 23:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CC34A33E7
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7830EF75;
	Wed, 17 Sep 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="0c/9ei+H"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020087.outbound.protection.outlook.com [52.101.84.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA930E0CE;
	Wed, 17 Sep 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146350; cv=fail; b=nwCSSjN+hX//J4Mv+joUCdsh65lMUD7V18HqpzB8bSMJYvN/hzDxFD5HySGV14bc9T3S+iJdyA1y/RIu+OzrlQTkOXne2k3Pvhuwivveap4WE/gvqIjGZAQmi6wlzxXhrAu8pY/bWPNT7j3hgG1Sph+BQHukYq6y05jPjgPqdqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146350; c=relaxed/simple;
	bh=ZSfaTr73xb82h81CRPdx/vCke5Nz17gC9LcUQ4Wu2us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dyI/lYMw0q7cXXyVVqAuoS36giDYseJ0BGOAikyWYBywRhaqywbDrkv7GY4I4xfpa1Y/dzTGEr7VluDM+Id9lck/WT3ho4ZStE4jaHmSSgx1+3BsB0D1EDG4KrXc6+gt5Q7g7jSuauBc+xHjw0c8xq/TDnAXuOiiNGLmoxzTbTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=0c/9ei+H; arc=fail smtp.client-ip=52.101.84.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfGk+g22NuroEdg7j7kNkW6Ek5vVqao60DMVzn9natDOzuEDwiSWGWc9iVvxW93oTVMDuccuwK5n5BUVR4BOd/0ZdXeMRWPcLkoXzr/KhAAmM9eFD8f5l6jwQudXM8n0TSr2Hb/MXN0mGO9AmTCB5CzDEs5h60wrSDlivDEoBs9/L0SqrP8bOVOUmTsy/QMDLC7tFohDepIt79izwcBGZYovlu9wzxVi+eXQ+Tskw/mZDmJCugcddVvQTC+0o7rMYTq3hASHo/O016lSKHRyhTY0ZyZ4FblUOCRIVVRNPV//gtxg0KAiMCOfkD5y6p3WsV2Y8oot66v0I6MdFBvxbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJXIl0t0fJk0U6Copt18OPzvBzJ9Zn6LXXRLWBN3UcE=;
 b=g9df9Q4Vfcy48GIbOLxzM7I+yZGTBMceAQZF4R4+FzKifW/CPKzVm9GO4DpD2WycUj0DSHUyJkC6bPAOyBzu62cIdtk06QX7QGNOJhry3fKE5p+id8BcTa54Oqt4STApeTiBela7IkYLVtguBmRculGe3Ya1pxfl8PCK3AqnwKOQqzy7pvKls9DtrT/VmVHjduokwD49HNRw/M68ii+Ivcefvc1lXasPZNeJ7ZWNIhAv0ifobt/0/WGlSjKpvfnt0XhCaQQK5eGTDpAiBhGAkPoOKmC/Wr6HMwA+RZa+CorOCc4E5VVRtlnbRKF6jcjwvUggQf4XKcXKTk5ZeofTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJXIl0t0fJk0U6Copt18OPzvBzJ9Zn6LXXRLWBN3UcE=;
 b=0c/9ei+HVZC2+aMbJsu5kKNyqHZMxxcxfT9pA88RU7JCR0gnWEA5Z5u+Z27rTRyjlN+8cOg0uFpB7Do5Rg7Glta1KZfnJhxo5fLPdcNW8dKqmJguUZRbmaB4P1A57yiAa5Aiai3aj8LmIYpbJXM7j2PA25IEiQxQ4zi6F4T/HdH1w8xW67D45CB36oQYN6gKBaD10z/Wh1vOSOvzbX9tsHSFl/8h+6Kr29iBCAm+Fi+/6zvpSriFAPrPjyNyh9L+7NP6rxgp1xoWb19B78s/xXc+LpmVVvbDzazsZMZ14RIif50ep3L6Flc/3joGcnWObiqmF0qtf2vbJmjAtuoKOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:03 +0000
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
Subject: [PATCH RESEND v5 03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Thu, 18 Sep 2025 00:58:39 +0300
Message-ID: <20250917215849.19720-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c65a0d-ab48-4864-d7d1-08ddf6356a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udfVIYVnPC+EzNHu3Rfm0Zrx2KwdigdfRtyUF6KUaLGai072j0Xmg7JT6eje?=
 =?us-ascii?Q?x6TdrPpsU+xE7SwFORs8pcvOidoqW+HKTe66Ic3qb1woiu8s0ISZwDNEeW+y?=
 =?us-ascii?Q?aHP3Xlf8yrtqZPkcoGRhh/7FDK6W/Bok/repGRbDvACUoxiI/fyTFOU0TuQv?=
 =?us-ascii?Q?edO4t5C8A/Nmxh1pvesS4rkflvbs8/Lh4vMnR7TPBb/gQqGpnkcEOVrDQ2NW?=
 =?us-ascii?Q?kQd8XFYgwGIjn6Q5fAeL2/xXcchLoK73nqxHlhq82EHgPiG8gLFYVqFB4CbS?=
 =?us-ascii?Q?SScgoJSc2/NdGB6rkwleRD7Akp9msjh/UcONoEjuYfQiSjETXbBE+9QNPpKK?=
 =?us-ascii?Q?aXVkaKIbq65VMAi2TnmC4nsEfTkdtmnnn9aFhpawzgVYEF4pmv4CRKgqX7Oh?=
 =?us-ascii?Q?1u3bbXf4kb1wQHKNNzbXZWLagXJ2/vFSyMyktEnmCWlngOqPHC5XEF3Z8hJb?=
 =?us-ascii?Q?ZDOCPXSUGfIUO+7THHpIiIewD/jLtwBeXLohYhH7EXSZKdrlsu+hwbaYpX0N?=
 =?us-ascii?Q?LWN/cHrTOBDKXWvijsvD9ruZndk2MzdK7RDjAU7I/aq3OWoebyVTBFFxk7mw?=
 =?us-ascii?Q?+HFSeZooQFduj6z0r03BkzX7HAMp52uG3T9kGOHKmG6kZ9T7l4YVGsV5MqlA?=
 =?us-ascii?Q?mSX6rXaCQZK2txXel+1u375B7IEC2zDzz8kCpddX/V3bF2FMszBw34HriVg1?=
 =?us-ascii?Q?nnMg6VEA5UZyjxwMOCBK8XbjP2VroRb5ZMs1opMGApFrvFt/SGOcIppFnVw1?=
 =?us-ascii?Q?4NkTZu3/F9J0pH+7f3SdXibJs/yy8Ag+8yk3pty7E4sBczp2TYsFxmh+aWKh?=
 =?us-ascii?Q?yRLxg9PBG8Q/+BvpbwBW5syqrlqtaHqR7w8nOuEG0rg5vc8sch2Z4XoYxNgr?=
 =?us-ascii?Q?+qhDtD9UZOgDmm0lnG/siDkhJ8cl3/FC8HCAihnXpuMsylAD+gwouERfLZqJ?=
 =?us-ascii?Q?hSoeLm6yO4GxJe90bqBuB0j+A+GNrMebdJeLBpFCy/x5PJYxbCHWVC2TwJCz?=
 =?us-ascii?Q?1fFKTiJDDtAz3P6Oflv7Ryw1YmvQ1HduZ0+cqWSF7bL6Hyv2LP6dVADdy/qq?=
 =?us-ascii?Q?30+/aDNCzY0DvyqO/QbhSqmdQ/THy7hJgOk9titMx4Lb97k/spCbvLEdUUpZ?=
 =?us-ascii?Q?/dbyzlnbDIEWUL3a+V1+rv2GpXbenX1jBcDscfLpB3iazit5bQdilX5BkIXh?=
 =?us-ascii?Q?sa0fp84UGCawgemSQG3g6LpPHiFcQsmXXz83lmmuu7KuRcOLJjPG6TU7MKgx?=
 =?us-ascii?Q?0zOTqwNHnntyw+Q/6UOlA2QsU0gsV2djG7MjC5vxBsfr3PgHMf9YnJlGdhp/?=
 =?us-ascii?Q?hjYuctIyQRtnx5OuoOFz2tMgEajRHn1OoFimCpSJ1cqGotMngWOKGKCDdhyO?=
 =?us-ascii?Q?Rfy9iUZvtZhcz0KOBKnlhtvZxzXxTeQ3I+6a+Z334mxvUP/7QqdgiVNTD8E+?=
 =?us-ascii?Q?gdvGpOZJQ0thOMvasjdOwfZUeoAL6FHRchz1PcvKqtECr+eL2xMfmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uacJQob4H5quwIgE3xmK66WmufO8awLek0p4Y+4S7n5JpvqCvc/dHPl3eez?=
 =?us-ascii?Q?CkA0PFVt1X6FgiGIjmviw0BomS0mpRjRa4hnwnHGviAfoH2ixrcVYMBnRAPj?=
 =?us-ascii?Q?+jzgJcRuc0xxqKy2tG3gqze0CHgiq9v15mP1Q9G0Poik4oO3JCRHfXWT7lmb?=
 =?us-ascii?Q?WNU/1uOcbQZpbAypgmSmqaulclE9Ku7sqJOAAg7UhpEKT910WgyMWGh/wJ3L?=
 =?us-ascii?Q?+V0ozLm2E0BuUztSNB+IsPXpR+64dJQxO4yjbXW97xZFpizoHrueTLMwQPgc?=
 =?us-ascii?Q?fp8coR51XE8BKq7PPPHtsswFxSEDAIBOr31I0MYKCQ6Q56bErTks1j0GHB/F?=
 =?us-ascii?Q?fmICLqcWNDI8V9g/gN+Iha1eCUhmmXYPxQYRu7Sm2JWk3QYYyrWFMBXUWKJt?=
 =?us-ascii?Q?lBCbax1HNpn1ZfpctcNII9IRgwwQkTWliedA2pE9HYc9kJnHJZQWvURa+Hv6?=
 =?us-ascii?Q?EKglgCqPqbhYZVKFrVOUim05UlNK+02kxvdPLkisbPJZh52ZZIWQEyXMuVCS?=
 =?us-ascii?Q?TiAQxLsjy5x1zFsyVAjDfYFEAhygfDNgWAVgZWPXGOmgMIgkqMEzfA+aW5JP?=
 =?us-ascii?Q?ZgCd+BNC/4SPz6MpI9oCom+ppgxT/xG9RBf1o8oVLRoaiRkLIyvzUV0f6P+A?=
 =?us-ascii?Q?maBK7+E9lG0VpO+9BR0BeEShwXvyo4rjM6MCd4p4f0j9FIhn6SnBqZbktM+J?=
 =?us-ascii?Q?HVGuV66We6WVl74MtOcypVr64rcRgUVpeZu0i8L3s6blEo1bjqoADopfnGWR?=
 =?us-ascii?Q?Bi7g9fsQoQMMYVW7e9kI+ElD9z+88cItuS1A7nOW5d2exBC5r2xGwMXXtIQC?=
 =?us-ascii?Q?JfMHL1ig9iJ2GGA8Qh2wdt4aOObQ7cZ3jNvB6VCUk2S8rAiAZDnPW/4up4bg?=
 =?us-ascii?Q?hBvGiZztHjIViKI/H1XiUqfPumP+bqu1UB/5+e7OiowjkE41Jo0njRC4nhpi?=
 =?us-ascii?Q?3lT9ZmjTNo+rkTMun2/dA7w9HfHG+WU4Yyx9TZ18SHbe5qJ/cT0xCDfekVPn?=
 =?us-ascii?Q?7M6Wf+PsS2AwooHbwPGbjvbqro8hl3n/s7rDmnjWCplnl8TvEZxfOMMHlTVG?=
 =?us-ascii?Q?WAmqpovP4mOTxyFmYWws9HxN3YK113TXC8562YQuR1eALJ04/5xqCE5wYG70?=
 =?us-ascii?Q?Bk+dc7p6fbfLJYevvVRRqj6FNJ24y93tXScLRf6XZkVoeFfWF2FXMLRXC6gW?=
 =?us-ascii?Q?5IgMaZhvCzh6gjNXIaKxBtUDRDcuPxHdxs3GOxVtrMbtyYDSEFaRRzXuZFV0?=
 =?us-ascii?Q?kHDG6slNUfRCiFijCBKQnNqsuX8ShtOsnJwqH4ZpmBvO8MkCG2vCvJXvXEEY?=
 =?us-ascii?Q?ct1kk82ie3O/cSbcCZFLja3NldsJJawaI6Cg/N2iaqsVdsRe9UTNuzvomhq0?=
 =?us-ascii?Q?VC3uafYy/TIQoFvXR4YNg4NaZ65GdCsZh/EE5j6YXQBm3ZfOJT8rtSa2URWB?=
 =?us-ascii?Q?AdyAr8atFh4rJYeI8qeDcQ/kQHlbi8lPkPMOGddOq0srZYvYQU5eOZbWOWIg?=
 =?us-ascii?Q?5/zeCWuNohgLL5rgMYL7lprxvMdKixoJcOxqBR7Gm+P2eft5z8SK7zgdm1ny?=
 =?us-ascii?Q?cia81xjkQXZCEYF/GHUgC9Z2YoSYWPt8XebsWEIyor2YrL7oQByc2EyrsnBX?=
 =?us-ascii?Q?qRIPic851XeE8/CYNkB20Hw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c65a0d-ab48-4864-d7d1-08ddf6356a6c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:03.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NV4srttzw2h9+5PxikmhD9CZIi8xnW/LLOTbzrQf9iwZmmyj8crJxTVaTsXObbiK+w+hMNgvccKySzX+M19qOQeVglbe/+aQ5K7C8COuAOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322

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
2.51.0



Return-Path: <linux-spi+bounces-10080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B5B82108
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE7A526658
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB230FC0F;
	Wed, 17 Sep 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="AoV+ocn3"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B0630F92C;
	Wed, 17 Sep 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146354; cv=fail; b=j9r6hHIjFnQMu95qcGqENv+IGvbVodKvc5ihnKuaDrDU5WYhKwYEqDJvftipau7M9hXgDqsXiFREJXvMSZjYrRRL79I6NoDukjDIk5s3Ut+V0slcrOv6fx/caGfGoszouEcMlSJ+7PxnmSpk+kNubZvinPprx9qDfiVn2rOG0Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146354; c=relaxed/simple;
	bh=1qKEHUtdbJ/reXDAJKuR6Bbq/Q/lM9+58Aoe5dXn2QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUu9bbR5yiNd8qKEPgG4xuq9eY8HKogsgHAefB0tTXGDpYuxLnZASkxn6H+tdOVbR7eYvvVNwrj0q/1nOSRkEAIlJQywQKdf6FSmlBy9q6qLKwn4Cu+mdqyQwE1ck5B8AtvYYvsuKeGYYPgehQUsVb2xexpofXLKTBKEpw+Olbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=AoV+ocn3; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiU1JTtgzVzt+33bs5vc0eTbvKIyAhSmn9GPhOb/O/Wj7NIPNCK4GRTk25o0bEanUGmpZDtxbJsa7CCsa0SIqSZNytJBBrJcNpCXiZbpzaX8kfGvU4Va1Bm9KNBrkuI6ccwlMVvua0GylWyN5X5GJJwf6SEViH6QRuUDU4MmNue11LjkG8IK5mq5Nx1+vdBXiP3H+VNvTiRYDozEzcR1G7rg4tqa2lPOFnB7TqGenlVA7K+1U/L6QQFeokC0OZ+rkAFjpW7Ass34HaYUgSt/6AtBNRfcaGW/rd+UU95Aq0HgQwEH4LbjpbuECT/Pqa4sl88MiyXcH0zkTX6FBGVzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1EzVNM4c8dANwE0Pew6SQrCtWxLqTQHZIpuJUbfj5k=;
 b=Fu/oCW/ICNSAvrEuLapbOpV1H+KhsYzIBS0czury+9Vt31lMYp80s1H7ThK3CmMzRo3MVRRPn8ahiMZ6OALpl+wDmT+jXjvP/02goxHcap4I64BmwnMS/DsJlFVTtvtvvKKFD60e+X0wWjUmP3vkb139Y4fvhGoTsWJdcMcaWWZg/4SCN9kC9NeiXC1530RDFi8BWj98rgEHi2LDNfbIcFNwxJaan8Y4CDzzllyO1597PMBjQdKbHIZZcbvkhEjesdpEoP8m66xVSofD5C+NSVuYycJT3QA+zBS50dLZlL0AMwAqe+H2aKc5YbZrz5nxkRkgnqCBsmrntQbpRJO4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1EzVNM4c8dANwE0Pew6SQrCtWxLqTQHZIpuJUbfj5k=;
 b=AoV+ocn3XlKnfSibcQLuKvt6FFZfiK51NEHlfXG0prq8rW40U8f0iPcYaLZr8vRvzGtBg/yp9SySmDw9oVsOgTUvWaIiyqUAX82Kyk+3HZmGNp2eI016U6DXRt9RNuhtm1I7cGrV6SBLNZf6pWKOkHsnN2OzVNu4LKXIbeh2t0N0JjYzMa9HwF7ML5Hu7Brg4HhoMUqDLU1z61ooop0qDy8RCQ0Yxy9Gtbv5ReNQHNXXtCgav4zlV+qbEpdcw27HkCDf//iZCTKBZJNk3Gr9eppm63PKYrkCHZP7dIDg5mVzXPeV1cVnkmLUJUgSPttpNB83HNeWxSAjE39G6eGgCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:10 +0000
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
Subject: [PATCH RESEND v5 06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Thu, 18 Sep 2025 00:58:42 +0300
Message-ID: <20250917215849.19720-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: c3272c3b-d3ce-433b-6250-08ddf6356e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljZ+b9cIqe8Gllocdmk2iKeueE/if77i3zEnpLb1qLLW3+N3EEN8hIaHvrDf?=
 =?us-ascii?Q?SOzBGoyvFhkCEwiH2VrfE5FqWh1gH5FS4fek7xYxJVqDBdYVScKG1EXhC3vq?=
 =?us-ascii?Q?XyH/gjWi+jC0xRLCCu7IrxouhjUqh2GQloT7gpgJEVlmazXYF2Gk2xZbXn6y?=
 =?us-ascii?Q?3FOSeVUdZ70x5kFfodDUx+7YUtLbc3SwOgUmjEjfbBweo041x8eZhrTTKXLw?=
 =?us-ascii?Q?EImnv7m+Bw4LfHoOiMRv6ScMuS7RvcUXaVGjun2Fu1P9VlCXe6fFedUlXmNn?=
 =?us-ascii?Q?igMTw1Zd5xw+ILi7hxni2iHa37oNztTqlU9vkSiv4kNtmxmrpFpDOYialHXB?=
 =?us-ascii?Q?+uyjlXZuVQADubTJq7JaEMFubr4DYAjXtc4NC4r2R+N79Qgg5MvzaSM3Dpsf?=
 =?us-ascii?Q?mWX10XIUtlDqKFe5/FHGvvFixGQNTKBcEYnJRZxccW6DHtYSdL1rrtyLzx2+?=
 =?us-ascii?Q?BSfG4B0hAGgvAcjT+bvlRbKrpjR/qzhWv1r6DGECUQwus9VhhEEnuPfURpaR?=
 =?us-ascii?Q?gKEwE2RAslCNr9ChPV2Q3QTyxX+aiRm+4tnHFKC/c+WLB4hcq2rB+A4V0qgG?=
 =?us-ascii?Q?tvF1WQqT780hvDnd8KSmY2lmy1X+k3csFgFh7fB/hfClmnDO5poIUbk17H4Y?=
 =?us-ascii?Q?QDXszxaSjQ/3NYVmbKnD+llHnOXLJ3kFYUdPjwYgE0QOVT6rfzoM8cyYZWvm?=
 =?us-ascii?Q?QCHOTc9oO6BbdaXtjFc2kvjSmv0wc49Y41FfHhRpkllVMjkpUn6UJznnIT5V?=
 =?us-ascii?Q?6pLlIRmnlfiW4TRvTaHe6DzH8GoSeblVTRGZsU2yrmGrGWH+rOKj7xojEoG1?=
 =?us-ascii?Q?Hc3Chwe1jy7GCWXUDbl6RDnW2n45tiEB2i7aCx3UUiXAsX8MS913+YrqqQpX?=
 =?us-ascii?Q?CU86mRzfP0jKQMu5aPEE3BJ8JPDxGbMyrEqNQoz4aOW2i3sCpVTmE4s1q1S7?=
 =?us-ascii?Q?ynzFtsprGhYLIlzjpj9Oo7HLMHEAfSqWutWDQXTVIc77oY9JXI/XJY7hR988?=
 =?us-ascii?Q?bbnBzTM3Oi5TPeNwZqjZKBJu7567qhxnWCaw7v9CpLUZegiUM/vkQOqJFQYU?=
 =?us-ascii?Q?YKv4kZU4n2i22Scr3oQ0VUTPeAxQ4m+Pp+BL8DVsaQd1ahWTHpHOHXWQuI2z?=
 =?us-ascii?Q?LmCH5Z2jWfG1E7N8xpmJC29luYyNXNZh/EjiGaGdA7qJ59c7ivcT1ENpd9TR?=
 =?us-ascii?Q?rI+2p2fjVOdSxSC6fnrVx9lbEafF37Ctab89p3dJ3hgsqmsmSrdB/vSytqxc?=
 =?us-ascii?Q?JA54e/P83DLILoNvzhRLAsu20TrFtpU6xm8OWnvvd5fFhNQw+SFeyHznH2QS?=
 =?us-ascii?Q?rfifbEw2FGKJ9CXUStiRCvoGnaw7XiuEV1f5oh1HvboSX2ptEXLcljbVPL3v?=
 =?us-ascii?Q?/e95P1nrnY7G2UrojZIrY9IhOCXVzMlvY5mxZln1UGuN1RW1X0+ZNvjVhg9J?=
 =?us-ascii?Q?bvH2pPBA5XfaPy2s7fZrQc0nA+3gtJiImV4SbZI7XoiZZr/Q/cQCbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stCJnEQON0ZlGHV8zXciI8BifQrdhElSEbKAojn2QdiYzjNOb94xfp180x/i?=
 =?us-ascii?Q?Bx21oo3VfKF8n1SwvROIfq4/cwTrf4GTIBDhP9VbRqLt4waBXZJYoitayUgA?=
 =?us-ascii?Q?j9tpBUGfutojr6PFkSP93wlRzSbZkAwYDAg27Hje7/l+MLc9SU6Q8Qd8oLGk?=
 =?us-ascii?Q?UWlVnpVLxRX3Ic41gQcv5u6xfsBWYMbKfi6Hsoy+2I7OBksee/xkiIhXz1pm?=
 =?us-ascii?Q?noHV7g7sR4sZhl/HEubjk5RAPr11At+l1hfO/k7wEmSnxN3jWG+R1pDsABWt?=
 =?us-ascii?Q?KHWL7Q7LV+JfdqmpDXlgXDA0i8XVr7d/EyOtnKuGHRTEkEhyeArYvpJGSv/M?=
 =?us-ascii?Q?BH2Ihuqf9hkcC1SY0tOjYDy1m0Q67JmzJrPtWiN/2nsihcKLBkvryCm8PlPk?=
 =?us-ascii?Q?J0W8F42KG2qOmjBpzpHfg+zseD8SygKvg+FdSfdrq33wINF5F0/rglidrUYV?=
 =?us-ascii?Q?ry96VqDKpGRPzAxjA2lP3kSrsuy2FjVE2ZJvuhhuc2RRlUiug3mBCbfzFTRu?=
 =?us-ascii?Q?BTXnl/zUtANEX/PqINXS3oD7jui7EDs8lNa3AlundDBw0BLQUGg2S9+ezeIJ?=
 =?us-ascii?Q?CYKql71VeqN2wRPQy9lLLGn1uw8mILNLTR56JRPUxRRC5PoebBNfNK5keFcq?=
 =?us-ascii?Q?xQ1w2hiOWI7jFIkZFHradgwPyIIqPaC8jXtJ3G+1zSbiLJyD7WHmxrQ/W4C8?=
 =?us-ascii?Q?F+ULYDuTptOLTfeeODgkkCGTVwVoMuKYqqG/fopWE1mPrA3+KyJ7xU9yZlzn?=
 =?us-ascii?Q?JzUtiEHj1E8IBwOHwvkJDUYPRsKgAW76Hz4uaKHLt6muZQYlZjmdu/E56qkC?=
 =?us-ascii?Q?GW0+DpIkLQHBCs42UpI2Gk19g2I2kcyCXM7L6j8c508bqrcrkFlaIwGIe30e?=
 =?us-ascii?Q?b4pvAM8U0xdpQSCtB/kZ32BB4rJa16Y4WdVGxnNZtTg3arUPxichbiTA4q1+?=
 =?us-ascii?Q?N/+QIAkeccbZmZ4o3kh/GIjw3UNe2lzKM83DFjlcwfyBZCdXvIpwdvXAEFsi?=
 =?us-ascii?Q?iv/37JNKM0SZ43GeneF30fudT9tiQ4kHuyYMXr4d5le6zr3E4tDjYW+13nsA?=
 =?us-ascii?Q?X9TWaIURkwhujvr/Ve2rIsLztpv8kohB3bbFobGQqJeR2S3Xy+vnm5zOfQvD?=
 =?us-ascii?Q?xl8GF77z5aTULDOJQPed+3qlCnvEYkOrkVRfP+9tJq0yiN6zObRepwvFFQjM?=
 =?us-ascii?Q?/X9dGGdOSc8ZycJCW3caJmgT7YG8b4rItoHo/PFlYGH86ZzmT+Oq2PLpgI86?=
 =?us-ascii?Q?zJDItcsEfIgz2BSJCWJ3oEpMZRw0Q8TggPfUTeXkdxe96UdkpD99rUMtA0Yh?=
 =?us-ascii?Q?dE0MR9gQK0cd+BVjVZdmg7bwoBswzNpWEUpMV8tXJLQKBubJmHd+dakFk1Z/?=
 =?us-ascii?Q?bWMAaLTSpQSBEkZl3YP95gFDNvsSRdy2Dj45wmjE3xCPdOXrlRKhp0vXK/Yx?=
 =?us-ascii?Q?2Zat3yv5zEt9Xf0c3CuD7yI6mLDAPctpM4Ofb/RZ1T4iFTaIpC/6WSlqFB4N?=
 =?us-ascii?Q?OrTf7TM1pmcuszBI7YaAMFwXnBT1sfvN5N2O4gARy+GMxaV4ydqrrH7Axvuq?=
 =?us-ascii?Q?vAHDLRL4Y9PZjBF6FhDNpKl1H1t5jurq30QUMxWUEOTIW8nx+Y7FWy+NxCGj?=
 =?us-ascii?Q?rFU6ac17O99PQV05u6jAj+A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3272c3b-d3ce-433b-6250-08ddf6356e23
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:09.9636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAjevIMAT2/rr6usbZ8Kx51hOEcE+vqcZyIPh6xLolajbk9jKBJq1wiOaOlCv8TnFeqRuBCQmOpaMsOxUIJgXvbTUMipDfHPBQyzO7Y1xhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

Attaching UBI on the flash with more than one plane per lun will lead to
the following error:

[    2.980989] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986309] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994978] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001350] Creating 2 MTD partitions on "spi0.0":
[    3.006159] 0x000000000000-0x000000020000 : "bl2"
[    3.011663] 0x000000020000-0x000010000000 : "ubi"
...
[    6.391748] ubi0: attaching mtd1
[    6.412545] ubi0 error: ubi_attach: PEB 0 contains corrupted VID header, and the data does not contain all 0xFF
[    6.422677] ubi0 error: ubi_attach: this may be a non-UBI PEB or a severe VID header corruption which requires manual inspection
[    6.434249] Volume identifier header dump:
[    6.438349]     magic     55424923
[    6.441482]     version   1
[    6.444007]     vol_type  0
[    6.446539]     copy_flag 0
[    6.449068]     compat    0
[    6.451594]     vol_id    0
[    6.454120]     lnum      1
[    6.456651]     data_size 4096
[    6.459442]     used_ebs  1061644134
[    6.462748]     data_pad  0
[    6.465274]     sqnum     0
[    6.467805]     hdr_crc   61169820
[    6.470943] Volume identifier header hexdump:
[    6.475308] hexdump of PEB 0 offset 4096, length 126976
[    6.507391] ubi0 warning: ubi_attach: valid VID header but corrupted EC header at PEB 4
[    6.515415] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI format
[    6.522222] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[    6.529294] UBI error: cannot attach mtd1

Non dirmap reading works good. Looking to spi_mem_no_dirmap_read() code we'll see:

	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
					      u64 offs, size_t len, void *buf)
	{
		struct spi_mem_op op = desc->info.op_tmpl;
		int ret;

// --- see here ---
		op.addr.val = desc->info.offset + offs;
//-----------------
		op.data.buf.in = buf;
		op.data.nbytes = len;
		ret = spi_mem_adjust_op_size(desc->mem, &op);
		if (ret)
		return ret;

		ret = spi_mem_exec_op(desc->mem, &op);
		if (ret)
			return ret;

		return op.data.nbytes;
	}

The similar happens for spi_mem_no_dirmap_write(). Thus the address
passed to the flash should take in the account the value of
desc->info.offset.

This patch fix dirmap reading/writing of flashes with more than one
plane per lun.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index a39c3ab4af5c..5ad3180ac6da 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -726,8 +726,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -860,7 +861,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0



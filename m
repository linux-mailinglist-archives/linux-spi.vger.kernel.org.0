Return-Path: <linux-spi+bounces-10074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3B9B820DE
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 23:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651DF4832A5
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 21:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7A24EAB2;
	Wed, 17 Sep 2025 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="T/eJGb5a"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020087.outbound.protection.outlook.com [52.101.84.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6A3D984;
	Wed, 17 Sep 2025 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146344; cv=fail; b=PQdFLtAAX6NdxF+d5b/LKa55HB++wqxTQrilGemKZ8XusUwa5XvNSj2EtTRoH11+nCjmmPh8htMjJ/YXhkaG60Ea5NH/R3zfl90AckvE2/6aNHB0RRz8qPM5AHnt5VEXGpCvs4fe/61UP2BXRmCuiDUTREJCJGHf1UYDVdTk3KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146344; c=relaxed/simple;
	bh=EuxwFUXoK25Hin/ix141+TvlynSyUjYHdlQ6Ugh1SQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CP88IV/yczEP8H3gDZBVcKt3qWGotzqsQ1QYgLjjqvDQYM8Huwu/6IHtiM3XOsRp54rNg2q0uk3buGZYOYifbB1EpSmppdGmF5u+wvDG4kD42i88nqzuDYnpytrOSsPYVjCs1WYgOaYRB1zbUIrNW+t8zjqIWAqnAJbkjpGpwp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=T/eJGb5a; arc=fail smtp.client-ip=52.101.84.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7T2kj12cgO1bZr3o0QQLLbKUc75iHP7DkjmaW75poTwmeI3uuGJlCohrp0V7T5xcZJz1S2lHNFzGBlNSudG+L8YbI0ek3R466jFc4ZyMvmQ1zJvGlHiRCL9HOSWIo55+HdwBym7oOL9lTVXvR2gpWYXf2BDamU9fcwrUE9OMZBhYbnOssfnQp/VBKxBm4nFQQ0+j+O8VvHYiQKv5H/IIjE6ifyIxeKtyRV/sgGDs7XBNhm92wWbGrHuOe7uGmtrTzfrcibiBd/0vhpfLOT5RqKYh6mvRwzNHiFdo4SzXwNNm2vtzDfPI2abUWu0e5wZou4VkRnrO2mCx6L3fJHRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ngo1xoklprnhBQL9Q4lHTkdxEIxN22JA02I853XuAU=;
 b=FQwlDhGD0U57tHBceEwgDu//BkKnHlaROOKM9Gr6eiCrV2q2dCAaxoIzV3L4XW51rF5SFXEXs7UHRHP2ySfUEuPC9XtopjCxddW08PkqDxTHn7ZBdjuZQUwjDvqO/FMZINfl1mIFlew7EkcTl9Qcr3UUFrzbkRGdoRqIaBk6dJ0W+rClNQ40xNXa1oge61ofmq+/lqm3AK+gjoeEXA6dza1CAenz0TNr+Pffv7EUkt/9essveJE+tdRm9bcyjP1AqWo2oaXENyRLssng1Bd0/EPCkHOI20PWvnr+N4erjUg0yRpTTO1PlIJVsBP1yEfEw0uV6wPgFPiTN3XQE3TqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ngo1xoklprnhBQL9Q4lHTkdxEIxN22JA02I853XuAU=;
 b=T/eJGb5a1tx66E+HGMd7tyttfd0XQSqFE6NFLNzUvywhTk26GtUn6Kcl5h8IGBaWu+vdRMinhBbvpXFJSGXM1nN0+JfSPXNx9+ZA+x73qiZhGGnLY7AKhHqt68BpNRbcdFIX/B520jXLBh/LGCByx6BV5jKJtJquDf9m4kKWB1zs1zayErD2hRlVy01/T6EOyZ3UtWWu//JBc/AwB6uPCcKVv82mRZMqF7022T+Xqiz1N029nXYrPhYA2skl4xCCAkujhRKSJO0gC9GA+MD0hP0gm+XFHyUaZNEH6oAs5A1g1DS3dLORiPzbmDpwNAGGOxfDka+RgihR0KzPiro7Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:58:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:58:58 +0000
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
Subject: [PATCH RESEND v5 00/13] spi: airoha: driver fixes & improvements
Date: Thu, 18 Sep 2025 00:58:36 +0300
Message-ID: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
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
X-MS-Office365-Filtering-Correlation-Id: 93c24d87-bb3d-4813-2b1e-08ddf6356700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9RAwY2u4G4GIHijXBqn76X9Tf4QKIqXQ68hd5+x+5L12HlwC7VhNPIds/hi?=
 =?us-ascii?Q?9ezTuX/dg3ECv0k/BM0b2FKQYzdONfbmT4yTli2Xtzxmwww0gGrcQ/UFT335?=
 =?us-ascii?Q?Bmuh5DfAHCsAlpo4Urd3ybgWcKo/YlkdjD+qpC3XuzApXPF4F2vYRvQGVm1U?=
 =?us-ascii?Q?lFdVrWw3IeR6Ja9dKX4M70wkw7FO0jVtyeF1nK1qIlgtDGbvhN4yKI6C6oDF?=
 =?us-ascii?Q?YIn53Qn4igvF/DQPkOEReYhi653lQVuFPNnG1QE3JrpM2ChLOSx74wFuaHH1?=
 =?us-ascii?Q?Pq7H5qxclggaSriWMgtVpKexvCxK4diyRfEitnCAiu+tyLfNsitdmWsZe+1j?=
 =?us-ascii?Q?s24B1y4/cPbfYolPbzbpzZ+F0VJY4tHsHzJ94OhyRoqkiXeC1pYZHripmeL4?=
 =?us-ascii?Q?2FVt2El9e3Oi+kcvHCurMcGPfvc7X+Stq/7y2LxfP/TBM6skVSQWghfNkCrl?=
 =?us-ascii?Q?vEH3HOkYqNzpGaKcxvgyn2KzOOWacpEi0/k52zdG0vhTgIgdZoL5HydPSjnD?=
 =?us-ascii?Q?H+RcD32IYiNtujT4dvVnpl5lnQnWxS3exsx1dQaq3ZaKTcSkeGFC+nCt/k6i?=
 =?us-ascii?Q?Q3SYFSWxegeUYeLe7EuvukQNVBK/fMgggn4ltK60cmqz3L0x0LmntCgeqGhf?=
 =?us-ascii?Q?JYnFR66QUlfyvMbgjedetwH4mcpxsBthk+bP7JQXJ4QmwRGXzfltCBJDHbi/?=
 =?us-ascii?Q?h84EcMeT7G7y4zxOVtHuh3GBTMFextSC0FCLSXgj7FRQ1hBnBZIFEuirWyab?=
 =?us-ascii?Q?43nVi4WRsU2UYQJgDJML3SYrGpoWn7pdxMCLIg6N2LAMn2BQq7eVc5jYTUxg?=
 =?us-ascii?Q?35Q8c8RgbhevJFZInpvnUqLzNkwvoxyy3NdAJzytSgmaz5rm+o07ayCTEo5T?=
 =?us-ascii?Q?LSIfZGep3u8mTvQ296fFu/JYnPBs31W1OUxx1o3TQ/T0IaRnHWBVmQB/mS1g?=
 =?us-ascii?Q?CAxdu0656POE8orh5o2EJryct/D1FOtRG4e3Z+TagjY1kDJdEOCd00lJ8bVG?=
 =?us-ascii?Q?jaNZNE+gUCod4pCeKLLl3RQBVOlz/wQ/jAFIpdsvETadk2ypV1F5mEKON+hj?=
 =?us-ascii?Q?/yzokRkkVQpytJJUdIqAyRV+JZZAT8+Cehr7zfDnoRatdSDm705jUpdQRZuC?=
 =?us-ascii?Q?h26cVxvl1AY3pTVv7ALLxBS6UmMWvWFZ/iyZE8GhZn831RW0F6KCwklPCP3o?=
 =?us-ascii?Q?xjGFW+32LJ5qTwzvoJcTBdtyqybl+aRiXS8fgOR0ohRjsqNaNCtE3cxS7c70?=
 =?us-ascii?Q?J8+xsO8cMTa5qAQg8zY+4c5nIx02wxG6vDYoR2/umhj5o0nonn0JX1p6pBM8?=
 =?us-ascii?Q?sMuXJ3mD7RCiHEumoyQMkspjx08QdKAxo6HTYATq7UmJIJwhvWjGeg59Werk?=
 =?us-ascii?Q?YUrnSKDwip0T7JdXP/uPwLoo/P6BhHSxlZdpfXpyXFs3x5wLl+5dYNGGuXF/?=
 =?us-ascii?Q?XrAC+kOmMx+fHbluK5Uap8UM1CZxslMYWTYLXMNp6pkJJbu0oMvnkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8IFxlfzYSjn32ZJdWuLri5C10VMXIrjlMpWwo1kmooTroG+YRoVTX3fe9b82?=
 =?us-ascii?Q?7EwLLss7wagwrjfFz6l8vfcUd6NqF2t2ckt57uDPhO95vjfUWypgp23WM8hs?=
 =?us-ascii?Q?XW60PQNmCzGCIKh0XJHCUiFNR5pQvZC2bT81vKPbuAuqRezwPpPX+C2qHITb?=
 =?us-ascii?Q?mnI8jYDYVraeg/nJGU7tcPO6JD1ygpPBl1/HTyQu90S7v/yFerrcHi1MS66k?=
 =?us-ascii?Q?8xL1xBC0aOjwmAcd17eRgkMrukI2/JuvehkxWmvo6WlUV//xDhvCfFeiBi9A?=
 =?us-ascii?Q?HoNuVCTBAb75d4XJYbnPa4o2OKC92ymw5iP9IU1MS6FuWsvCyJmrPB4m+EXa?=
 =?us-ascii?Q?EuzJHWYzWB/L0NRbiZWouljNSSGYciEGmbcvh/HsEZgeZRY2kR4Jm31V7jvX?=
 =?us-ascii?Q?fAf+ogMsaz2B5uBdrXgiiX18oAdwmtmuBWUU0kLK6+xftwefH/DikwNxjOi6?=
 =?us-ascii?Q?oWYCmPa76sr0lDEfkuhkxG6f618CvR3hzOB7vOz9WAGEumh7mjK00RlRI5xB?=
 =?us-ascii?Q?POXnt1Hzj4UPWdVK0oXkhPqIYqhRF6x3ANKiWueW6Efx+jYwUidjh0h4mx08?=
 =?us-ascii?Q?z9jiodVg5w0sM28d/gSED7e7qkwnvt/6/GqdtQBsCcqaOflUkSOPKfUArGK0?=
 =?us-ascii?Q?89aWfp1llPokOWXgj+uJ0jQz4yA4T2Cj/CXjUPfoyOinSYbVhQgoNlvtlo4x?=
 =?us-ascii?Q?wpzVTJ90WcXls8igi2TSurVqlgqM4rfVdvkgE6PkLZKUCTtlSZmdTRWdLE9m?=
 =?us-ascii?Q?S/NHVx2zD+ISMMKwRjFSlRYOympkv7+81AGpJemh5wr04Fx4xlu6mafpI5ZN?=
 =?us-ascii?Q?9xCtGy2ZK7ZdCFAPFCDaFbUAcSUTYr2fcSanvskf/o6Y41dP8VRhdyEHnm6c?=
 =?us-ascii?Q?9yXQU5BsWCJ9DL1W5fTKnAVK6yfWotPBit8sLHqZetYsRdzfYKombkqsg+jR?=
 =?us-ascii?Q?rf7eOWs551DglIWeunA+eJqO+fsMo45fSLhjPG4T9yDif/DUoyMhtL/hi8Mq?=
 =?us-ascii?Q?9IOucBmocdkN8elRE0upoAzmszFXClbZlSOrC0yxqSrFWSIBwpEaJUTK0mTN?=
 =?us-ascii?Q?4BddY4zZCYvFdl9OZUsnTDlY02bqNU3CjvsA8+584ug5I+OXSfX17uVDzA5g?=
 =?us-ascii?Q?5AxqPZlnH5QzgKTyqAlkFKsDJL0MUmtj8nE0Dug8iGCkWKBh0RsvI23+CpLq?=
 =?us-ascii?Q?9SJyO4INERcoQTlSEm1eh/g71OBan3KxnIOvAqfp3BC3zgcjPB3JjH0gH7uO?=
 =?us-ascii?Q?HUI1Ti690QAbvDi7mNkZ2kJQc9YSAPrNHC6YfnMrRD4kzvqlONCbY1HkJkPc?=
 =?us-ascii?Q?tdyjIIpDYxphomjm/4zKoY6B1+wcsK514ADVhl4H8l9vYnVdXtUO0smb3VtC?=
 =?us-ascii?Q?dAiQQPyd/yCgdlErD99ZQgSUZM2Ob5TGRjKiRddtBw5KmWDfBzpYoaqe4ap2?=
 =?us-ascii?Q?8PBmBQANwB+ZoxRerz8+Rxy0figoEyIwuGa8N80WWaisJj3rTMECjoF0M/I/?=
 =?us-ascii?Q?emi/i9BlqnascFi2k6lMIiyNX/vDHyO8gkOWjiemLsoT8QwDLmaFGWcjWile?=
 =?us-ascii?Q?39a8dbZQXazasLVDyp5wXVuo6I6BixrqP4NQZ4efbSiYqVFAC0o6pHRIDQIY?=
 =?us-ascii?Q?9SfrzId+Y3kR6fULdSBA3eI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c24d87-bb3d-4813-2b1e-08ddf6356700
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:58:58.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHzPT114LfcR+5t05tlIS3Lh6fEsEaaTcKA4ETC/UO25wnVU2cR7RMwhaqpwWRdJaDO7GqkZNprdOW+KWls4/EU3phF1MuFyKSVeRRTy6HY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322

This patch series greatly improve airoha snfi driver and fix a
number of serious bugs.

Fixed bugs:
 * Fix reading/writing of flashes with more than one plane per lun
 * Fill the buffer with 0xff before writing
 * Fix reading of flashes supporting continuous reading mode
 * Fix error paths

Improvements:
 * Add support of dual/quad wires spi modes in exec_op(). This also
   fix flash reading/writing if dirmap can't be created.
 * Support of dualio/quadio flash reading commands
 * Remove dirty hack that reads flash page settings from SNFI registers
   during driver startup

Patched kernel tests:

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_oobtest.ko dev=1
    [  263.191711] 
    [  263.193218] =================================================
    [  263.199014] mtd_oobtest: MTD device: 1
    [  263.202768] mtd_oobtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [  263.216791] mtd_test: scanning for bad eraseblocks
    [  263.221956] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [  263.227361] mtd_oobtest: test 1 of 5
    [  265.077216] mtd_oobtest: writing OOBs of whole device
    [  265.121767] mtd_oobtest: written up to eraseblock 0
    [  275.174147] mtd_oobtest: written up to eraseblock 256
    [  285.210279] mtd_oobtest: written up to eraseblock 512
    [  295.241724] mtd_oobtest: written up to eraseblock 768
    [  305.280167] mtd_oobtest: written up to eraseblock 1024
    [  315.326883] mtd_oobtest: written up to eraseblock 1280
    [  325.364049] mtd_oobtest: written up to eraseblock 1536
    [  335.398609] mtd_oobtest: written up to eraseblock 1792
    [  345.358981] mtd_oobtest: written 2047 eraseblocks
    [  345.363694] mtd_oobtest: verifying all eraseblocks
    [  345.386088] mtd_oobtest: verified up to eraseblock 0
    [  349.830833] mtd_oobtest: verified up to eraseblock 256
    [  354.276245] mtd_oobtest: verified up to eraseblock 512
    [  358.721496] mtd_oobtest: verified up to eraseblock 768
    [  363.166881] mtd_oobtest: verified up to eraseblock 1024
    [  367.612694] mtd_oobtest: verified up to eraseblock 1280
    [  372.058211] mtd_oobtest: verified up to eraseblock 1536
    [  376.503820] mtd_oobtest: verified up to eraseblock 1792
    [  380.914843] mtd_oobtest: verified 2047 eraseblocks
    [  380.919660] mtd_oobtest: test 2 of 5
    [  384.202620] mtd_oobtest: writing OOBs of whole device
    [  384.247584] mtd_oobtest: written up to eraseblock 0
    [  394.305121] mtd_oobtest: written up to eraseblock 256
    [  404.342199] mtd_oobtest: written up to eraseblock 512
    [  414.374204] mtd_oobtest: written up to eraseblock 768
    [  424.409891] mtd_oobtest: written up to eraseblock 1024
    [  434.453378] mtd_oobtest: written up to eraseblock 1280
    [  444.494321] mtd_oobtest: written up to eraseblock 1536
    [  454.534480] mtd_oobtest: written up to eraseblock 1792
    [  464.490962] mtd_oobtest: written 2047 eraseblocks
    [  464.495681] mtd_oobtest: verifying all eraseblocks
    [  464.518015] mtd_oobtest: verified up to eraseblock 0
    [  468.955635] mtd_oobtest: verified up to eraseblock 256
    [  473.395502] mtd_oobtest: verified up to eraseblock 512
    [  477.834373] mtd_oobtest: verified up to eraseblock 768
    [  482.272717] mtd_oobtest: verified up to eraseblock 1024
    [  486.712148] mtd_oobtest: verified up to eraseblock 1280
    [  491.150704] mtd_oobtest: verified up to eraseblock 1536
    [  495.589439] mtd_oobtest: verified up to eraseblock 1792
    [  499.993138] mtd_oobtest: verified 2047 eraseblocks
    [  499.997951] mtd_oobtest: test 3 of 5
    [  503.404228] mtd_oobtest: writing OOBs of whole device
    [  503.448822] mtd_oobtest: written up to eraseblock 0
    [  513.480773] mtd_oobtest: written up to eraseblock 256
    [  523.489361] mtd_oobtest: written up to eraseblock 512
    [  533.506896] mtd_oobtest: written up to eraseblock 768
    [  543.506268] mtd_oobtest: written up to eraseblock 1024
    [  553.506503] mtd_oobtest: written up to eraseblock 1280
    [  563.511266] mtd_oobtest: written up to eraseblock 1536
    [  573.519567] mtd_oobtest: written up to eraseblock 1792
    [  583.455111] mtd_oobtest: written 2047 eraseblocks
    [  583.459837] mtd_oobtest: verifying all eraseblocks
    [  583.499358] mtd_oobtest: verified up to eraseblock 0
    [  592.382953] mtd_oobtest: verified up to eraseblock 256
    [  601.267297] mtd_oobtest: verified up to eraseblock 512
    [  610.150907] mtd_oobtest: verified up to eraseblock 768
    [  619.034702] mtd_oobtest: verified up to eraseblock 1024
    [  627.919683] mtd_oobtest: verified up to eraseblock 1280
    [  636.821168] mtd_oobtest: verified up to eraseblock 1536
    [  645.705487] mtd_oobtest: verified up to eraseblock 1792
    [  654.520336] mtd_oobtest: verified 2047 eraseblocks
    [  654.525134] mtd_oobtest: test 4 of 5
    [  657.578146] mtd_oobtest: attempting to start write past end of OOB
    [  657.584336] mtd_oobtest: an error is expected...
    [  657.588974] mtd_oobtest: error occurred as expected
    [  657.593848] mtd_oobtest: attempting to start read past end of OOB
    [  657.599953] mtd_oobtest: an error is expected...
    [  657.604569] mtd_oobtest: error occurred as expected
    [  657.609450] mtd_oobtest: attempting to write past end of device
    [  657.615367] mtd_oobtest: an error is expected...
    [  657.619990] mtd_oobtest: error occurred as expected
    [  657.624864] mtd_oobtest: attempting to read past end of device
    [  657.630715] mtd_oobtest: an error is expected...
    [  657.635333] mtd_oobtest: error occurred as expected
    [  657.641043] mtd_oobtest: attempting to write past end of device
    [  657.646966] mtd_oobtest: an error is expected...
    [  657.651574] mtd_oobtest: error occurred as expected
    [  657.656451] mtd_oobtest: attempting to read past end of device
    [  657.662277] mtd_oobtest: an error is expected...
    [  657.666901] mtd_oobtest: error occurred as expected
    [  657.671774] mtd_oobtest: test 5 of 5
    [  659.382333] mtd_oobtest: writing OOBs of whole device
    [  659.388056] mtd_oobtest: written up to eraseblock 0
    [  659.393526] mtd_oobtest: written up to eraseblock 0
    [  659.704525] mtd_oobtest: written up to eraseblock 256
    [  659.710187] mtd_oobtest: written up to eraseblock 256
    [  660.021093] mtd_oobtest: written up to eraseblock 512
    [  660.026752] mtd_oobtest: written up to eraseblock 512
    [  660.338427] mtd_oobtest: written up to eraseblock 768
    [  660.344048] mtd_oobtest: written up to eraseblock 768
    [  660.655718] mtd_oobtest: written up to eraseblock 1024
    [  660.661462] mtd_oobtest: written up to eraseblock 1024
    [  660.970676] mtd_oobtest: written up to eraseblock 1280
    [  660.976386] mtd_oobtest: written up to eraseblock 1280
    [  661.286858] mtd_oobtest: written up to eraseblock 1536
    [  661.292587] mtd_oobtest: written up to eraseblock 1536
    [  661.605397] mtd_oobtest: written up to eraseblock 1792
    [  661.611142] mtd_oobtest: written up to eraseblock 1792
    [  661.918754] mtd_oobtest: written 2046 eraseblocks
    [  661.923458] mtd_oobtest: verifying all eraseblocks
    [  661.928812] mtd_oobtest: verified up to eraseblock 0
    [  662.072499] mtd_oobtest: verified up to eraseblock 256
    [  662.216152] mtd_oobtest: verified up to eraseblock 512
    [  662.359956] mtd_oobtest: verified up to eraseblock 768
    [  662.503238] mtd_oobtest: verified up to eraseblock 1024
    [  662.646847] mtd_oobtest: verified up to eraseblock 1280
    [  662.790603] mtd_oobtest: verified up to eraseblock 1536
    [  662.934269] mtd_oobtest: verified up to eraseblock 1792
    [  663.076329] mtd_oobtest: verified 2046 eraseblocks
    [  663.081114] mtd_oobtest: finished with 0 errors
    [  663.085647] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_pagetest.ko dev=1
    [ 1142.213082] 
    [ 1142.214590] =================================================
    [ 1142.220433] mtd_pagetest: MTD device: 1
    [ 1142.224278] mtd_pagetest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1142.238388] mtd_test: scanning for bad eraseblocks
    [ 1142.243536] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1142.248935] mtd_pagetest: erasing whole device
    [ 1143.962562] mtd_pagetest: erased 2047 eraseblocks
    [ 1143.967301] mtd_pagetest: writing whole device
    [ 1144.011729] mtd_pagetest: written up to eraseblock 0
    [ 1154.137933] mtd_pagetest: written up to eraseblock 256
    [ 1164.265201] mtd_pagetest: written up to eraseblock 512
    [ 1174.393365] mtd_pagetest: written up to eraseblock 768
    [ 1184.525700] mtd_pagetest: written up to eraseblock 1024
    [ 1194.650920] mtd_pagetest: written up to eraseblock 1280
    [ 1204.773676] mtd_pagetest: written up to eraseblock 1536
    [ 1214.896934] mtd_pagetest: written up to eraseblock 1792
    [ 1224.942600] mtd_pagetest: written 2047 eraseblocks
    [ 1224.947410] mtd_pagetest: verifying all eraseblocks
    [ 1225.053133] mtd_pagetest: verified up to eraseblock 0
    [ 1250.760034] mtd_pagetest: verified up to eraseblock 256
    [ 1276.448242] mtd_pagetest: verified up to eraseblock 512
    [ 1302.138825] mtd_pagetest: verified up to eraseblock 768
    [ 1327.824020] mtd_pagetest: verified up to eraseblock 1024
    [ 1353.532178] mtd_pagetest: verified up to eraseblock 1280
    [ 1379.234385] mtd_pagetest: verified up to eraseblock 1536
    [ 1404.943865] mtd_pagetest: verified up to eraseblock 1792
    [ 1430.468816] mtd_pagetest: verified 2047 eraseblocks
    [ 1430.473702] mtd_pagetest: crosstest
    [ 1430.477717] mtd_pagetest: reading page at 0x0
    [ 1430.482328] mtd_pagetest: reading page at 0xffdf800
    [ 1430.487469] mtd_pagetest: reading page at 0x0
    [ 1430.492084] mtd_pagetest: verifying pages read at 0x0 match
    [ 1430.497668] mtd_pagetest: crosstest ok
    [ 1430.501409] mtd_pagetest: erasecrosstest
    [ 1430.505323] mtd_pagetest: erasing block 0
    [ 1430.511511] mtd_pagetest: writing 1st page of block 0
    [ 1430.517166] mtd_pagetest: reading 1st page of block 0
    [ 1430.522505] mtd_pagetest: verifying 1st page of block 0
    [ 1430.527739] mtd_pagetest: erasing block 0
    [ 1430.532565] mtd_pagetest: writing 1st page of block 0
    [ 1430.538229] mtd_pagetest: erasing block 2046
    [ 1430.544181] mtd_pagetest: reading 1st page of block 0
    [ 1430.549498] mtd_pagetest: verifying 1st page of block 0
    [ 1430.554718] mtd_pagetest: erasecrosstest ok
    [ 1430.558900] mtd_pagetest: erasetest
    [ 1430.562381] mtd_pagetest: erasing block 0
    [ 1430.567208] mtd_pagetest: writing 1st page of block 0
    [ 1430.572858] mtd_pagetest: erasing block 0
    [ 1430.577680] mtd_pagetest: reading 1st page of block 0
    [ 1430.582990] mtd_pagetest: verifying 1st page of block 0 is all 0xff
    [ 1430.589279] mtd_pagetest: erasetest ok
    [ 1430.593023] mtd_pagetest: finished with 0 errors
    [ 1430.597651] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_readtest.ko dev=1
    [ 1478.691648] 
    [ 1478.693158] =================================================
    [ 1478.698981] mtd_readtest: MTD device: 1
    [ 1478.702829] mtd_readtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1478.716939] mtd_test: scanning for bad eraseblocks
    [ 1478.722072] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1478.727475] mtd_readtest: testing page read
    [ 1548.352125] mtd_readtest: finished
    [ 1548.355553] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 1617.353002] 
    [ 1617.354511] =================================================
    [ 1617.360332] mtd_speedtest: MTD device: 1
    [ 1617.364258] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1617.380150] mtd_test: scanning for bad eraseblocks
    [ 1617.385428] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1621.021861] mtd_speedtest: testing eraseblock write speed
    [ 1700.915306] mtd_speedtest: eraseblock write speed is 3279 KiB/s
    [ 1700.921250] mtd_speedtest: testing eraseblock read speed
    [ 1734.931886] mtd_speedtest: eraseblock read speed is 7705 KiB/s
    [ 1738.682742] mtd_speedtest: testing page write speed
    [ 1818.818644] mtd_speedtest: page write speed is 3269 KiB/s
    [ 1818.824058] mtd_speedtest: testing page read speed
    [ 1852.913595] mtd_speedtest: page read speed is 7687 KiB/s
    [ 1856.674492] mtd_speedtest: testing 2 page write speed
    [ 1936.437284] mtd_speedtest: 2 page write speed is 3285 KiB/s
    [ 1936.442869] mtd_speedtest: testing 2 page read speed
    [ 1970.498124] mtd_speedtest: 2 page read speed is 7694 KiB/s
    [ 1970.503624] mtd_speedtest: Testing erase speed
    [ 1974.343389] mtd_speedtest: erase speed is 68316 KiB/s
    [ 1974.348479] mtd_speedtest: Testing 2x multi-block erase speed
    [ 1976.068855] mtd_speedtest: 2x multi-block erase speed is 152811 KiB/s
    [ 1976.075309] mtd_speedtest: Testing 4x multi-block erase speed
    [ 1977.790232] mtd_speedtest: 4x multi-block erase speed is 153301 KiB/s
    [ 1977.796693] mtd_speedtest: Testing 8x multi-block erase speed
    [ 1979.511905] mtd_speedtest: 8x multi-block erase speed is 153273 KiB/s
    [ 1979.518367] mtd_speedtest: Testing 16x multi-block erase speed
    [ 1981.230700] mtd_speedtest: 16x multi-block erase speed is 153539 KiB/s
    [ 1981.237249] mtd_speedtest: Testing 32x multi-block erase speed
    [ 1982.948381] mtd_speedtest: 32x multi-block erase speed is 153648 KiB/s
    [ 1982.954918] mtd_speedtest: Testing 64x multi-block erase speed
    [ 1984.665992] mtd_speedtest: 64x multi-block erase speed is 153655 KiB/s
    [ 1984.672531] mtd_speedtest: finished
    [ 1984.676054] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_stresstest.ko dev=1
    [ 2190.651750] 
    [ 2190.653263] =================================================
    [ 2190.659087] mtd_stresstest: MTD device: 1
    [ 2190.663105] mtd_stresstest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2190.679846] mtd_test: scanning for bad eraseblocks
    [ 2190.684981] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2190.690389] mtd_stresstest: doing operations
    [ 2190.694655] mtd_stresstest: 0 operations done
    [ 2214.262705] mtd_stresstest: 1024 operations done
    [ 2239.019612] mtd_stresstest: 2048 operations done
    [ 2262.820899] mtd_stresstest: 3072 operations done
    [ 2285.061376] mtd_stresstest: 4096 operations done
    [ 2308.297322] mtd_stresstest: 5120 operations done
    [ 2330.530459] mtd_stresstest: 6144 operations done
    [ 2352.651759] mtd_stresstest: 7168 operations done
    [ 2375.188275] mtd_stresstest: 8192 operations done
    [ 2397.738174] mtd_stresstest: 9216 operations done
    [ 2414.792572] mtd_stresstest: finished, 10000 operations done
    [ 2414.798257] =================================================

Speed test of original driver (with patch to fix support of flashes
with more than one plane per lun)

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 2894.142208] 
    [ 2894.143719] =================================================
    [ 2894.149556] mtd_speedtest: MTD device: 1
    [ 2894.153486] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2894.168888] mtd_test: scanning for bad eraseblocks
    [ 2894.174023] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2897.500416] mtd_speedtest: testing eraseblock write speed
    [ 2977.807233] mtd_speedtest: eraseblock write speed is 3262 KiB/s
    [ 2977.813171] mtd_speedtest: testing eraseblock read speed
    [ 3013.906597] mtd_speedtest: eraseblock read speed is 7260 KiB/s
    [ 3017.440320] mtd_speedtest: testing page write speed
    [ 3097.833394] mtd_speedtest: page write speed is 3259 KiB/s
    [ 3097.838812] mtd_speedtest: testing page read speed
    [ 3134.004981] mtd_speedtest: page read speed is 7245 KiB/s
    [ 3137.538423] mtd_speedtest: testing 2 page write speed
    [ 3217.906288] mtd_speedtest: 2 page write speed is 3260 KiB/s
    [ 3217.911883] mtd_speedtest: testing 2 page read speed
    [ 3254.049757] mtd_speedtest: 2 page read speed is 7251 KiB/s
    [ 3254.055254] mtd_speedtest: Testing erase speed
    [ 3257.599146] mtd_speedtest: erase speed is 74027 KiB/s
    [ 3257.604213] mtd_speedtest: Testing 2x multi-block erase speed
    [ 3259.320945] mtd_speedtest: 2x multi-block erase speed is 153139 KiB/s
    [ 3259.327413] mtd_speedtest: Testing 4x multi-block erase speed
    [ 3261.044585] mtd_speedtest: 4x multi-block erase speed is 153098 KiB/s
    [ 3261.051047] mtd_speedtest: Testing 8x multi-block erase speed
    [ 3262.786520] mtd_speedtest: 8x multi-block erase speed is 151479 KiB/s
    [ 3262.792979] mtd_speedtest: Testing 16x multi-block erase speed
    [ 3264.509898] mtd_speedtest: 16x multi-block erase speed is 153130 KiB/s
    [ 3264.516454] mtd_speedtest: Testing 32x multi-block erase speed
    [ 3266.233403] mtd_speedtest: 32x multi-block erase speed is 153125 KiB/s
    [ 3266.239961] mtd_speedtest: Testing 64x multi-block erase speed
    [ 3267.957985] mtd_speedtest: 64x multi-block erase speed is 153029 KiB/s
    [ 3267.964525] mtd_speedtest: finished
    [ 3267.968039] =================================================

It looks like a patched driver is a bit faster

write speed: 3260 KiB/s  vs  3277 KiB/s
read speed:  7252 KiB/s  vs  7695 KiB/s

Changes v2:
 * minor fix
 * add comments to code

Changes v3:
 * add patch to prevent continuous reading

Changes v4:
 * removed non-needed patch, other patch was a bit updated
 * treat zero buswidth as single wire buswidth (thanks to Jyothi Kumar Seerapu)
 * changes were tested with linux
 * test results was added

Changes v5:
 * reorder patches a bit
 * improve description of some patches
 * minor fixes & improvements

Mikhail Kshevetskiy (13):
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: unify dirmap read/write code
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup
  spi: airoha: buffer must be 0xff-ed before writing

 drivers/spi/spi-airoha-snfi.c | 510 ++++++++++++++++++----------------
 1 file changed, 263 insertions(+), 247 deletions(-)

-- 
2.51.0



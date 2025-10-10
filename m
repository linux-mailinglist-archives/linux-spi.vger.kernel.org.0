Return-Path: <linux-spi+bounces-10536-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F62BCE599
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6B944FE507
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374E301713;
	Fri, 10 Oct 2025 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="aV8E/bdv"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021136.outbound.protection.outlook.com [52.101.70.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DF3016E5;
	Fri, 10 Oct 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124059; cv=fail; b=hQib1VGXHcLYiaJQ+grJO2tUU1XQ0j2pikaeq0M6voFZa7z0ADSSBK1o7oJ/LAMbFNk4jSFbWWoWXDs57Ve0cdII6ZjwUDCCfUBHF/OCky0sBc9PDE8x88A2qSEpLI6qG0pb6CDvJiyPCwor9wEfXJxWOCLNRWVFp5HrIIUhNmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124059; c=relaxed/simple;
	bh=F1rwU6j95QGCJEc9qv/gzTgjO421uv8zLeWMEavQSTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PouLYlMAejsTFbY7SHQZGTM3lB9UHP6PzkVBy99BbsHosirAJ71z4BztDrIlh6IuIJkYCRcI6l/cVi5QAT58AGQ7037TYc/65kcirA4RTDxl1/IOohULWnVYXjPOH0wSZPlzpzG4hc+hmlAYd+qnxgwh/xl3RK9GSsA/YSW+BFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=aV8E/bdv; arc=fail smtp.client-ip=52.101.70.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUkwYlh23oB4YWXoxp57mFl2ZLW1xm/HSmdlUqRUXQkauU0l0ap25WS1I1VuoWT4KR3WinPHWrVxkxiffb0245BWzkdx4xZ7Kg2S5nrHo7TAFg4bi/5QBnA9Z7z1mz5aQgiAHJ4VMIAYE3C4iWTAaxkG1QWImsQJvZQYK3ZaNzaQehaSHR/sfsu9fbHpjjgq3CQIEAeUHnVeBCYTJZrJ4Kszr12gg7iSB3RYobiKKtY5Ht1JttIlcqS2x24izJ4PwyR8fK0ljBRbbtRi46K1zrsQa4xukiSBS15QOlaGx5mTYy+GoTr825Q07JbF3bp9YzEwEQ9CnqUMJ0R+0MvVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dv/Wfk/v6CevHX4p49ZHxRqA8jrsr7JIou6SbRI/uw=;
 b=wweCM6/1B4ZLSqls1T4tABonhN8kZm9BEH3BBtQ4E+/wDykCz/EpHd+aLx+HPBqMPr9ha2T1Z53HS5EtdKsDn6HnZTT9pvlSsYhCffWN2pT4hoCVmMMXq8Zx8Ga+iJKJ4ssTYVMGIiLOKwCLLorJKZLQpKg30e2nrpHgZEeMmOuJBoN5QmXBqAmff1M9VK1lBDsbXmW0WDPV39v2XCd5rnntLWWDm4T5qskDesubAHxE4OfhJquiZTvKKhLiBy1SrKz+QY6UFPVa1DIGH1xW21hpRAifzoUi6Jlz7kCc6hSjp0XVIxdI4R62kO58x5cYuJ96acXFkPdrhezUTwehRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dv/Wfk/v6CevHX4p49ZHxRqA8jrsr7JIou6SbRI/uw=;
 b=aV8E/bdvmsuTvUONqO64gAdsswUAZ7xL+qdOp0Jk/OebCR2NlS0su9N+vxgaV1fMNlACJpSOiYy6eqLjFfM+f3scqJOvM/zPbxKjTzt2MYiB8do5lufbz12BdVx7aEx6A7+w6yx0PYS9/5iX4h2cgexhPcgLdUxM+waAGfycLngAY8NMxW0SH2QNKs/Q42+ggLTBj4ycpbvSHc8NyDo++6MjsxUmTcsGbKwV6u18OrMM86+iDH5wQMT0IOgz/pFgQMCalfacDHT1l+FCmZsX9wJ1WwKtsxnLxczvzCNAtacgfam2QCWZkau96d+rQCPqElQi7OhX82eDGho/5B7neA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB11352.eurprd08.prod.outlook.com (2603:10a6:150:2c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v8 00/15] spi: airoha: driver fixes & improvements
Date: Fri, 10 Oct 2025 22:20:23 +0300
Message-ID: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010185940.GA715991-robh@kernel.org>
References: <20251010185940.GA715991-robh@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB11352:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e9cb30-4c70-4299-4164-08de08321cea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?utXN9kmdctpO4jkiMgdMyfzAcx+Vb7wVVveGD/OkUzksFF64/4IUVsXXeM5B?=
 =?us-ascii?Q?c8H29bqR6c/BlC9pB3dBXlPSKAgfc9pYgYRrIbeQmyRDX1HKAPp+2DJ53vVX?=
 =?us-ascii?Q?0rMQACMD+GPpSpWeWG+h+9ZdSjeHwSm/UP8TWZ92tnnr3OdqqcF/jfXMw37P?=
 =?us-ascii?Q?zdFQpE/eKikJzYdAtWRHzOTMRO6MPPZ1vCqSSe3efd+Pl/73ZIVNrUNgLrox?=
 =?us-ascii?Q?84vuho2kL+QDQwIUwjmU7TBSm2XQZWeSxkMdnkOoZKiW7hk4kDQPaQzL70Qk?=
 =?us-ascii?Q?iLLfSWL9IEBE+vBqYvL9rbq7f2WUVwmU/6fccHixR8DO2YtbqpO0LcRPE+An?=
 =?us-ascii?Q?VYArKoUR8Idy3/yS+UBWlDcf21Rex1HtJ3C61sTpD+I/+y7xAy0xsSQU/AA5?=
 =?us-ascii?Q?SzQMQ9E7TOO0xLeNpgKlnalzD2M8KrekY7n0RI6RwMWE7cW/J1amvuzYDqxR?=
 =?us-ascii?Q?Zrvc0jddtGHHWbUHQOZ65hfqmnAJvEYbq4ZJhysre5uQ5Lcks+1zZ1C/JfkN?=
 =?us-ascii?Q?ejRbPESAgkyPc3qrhELTvREQuDtfFH0U65Zsq5Hw0ZMc58DvRN4Q753XQg0n?=
 =?us-ascii?Q?VGMO/Au3H2OCK3eUMVPLbk32gvnqju4HsvSF4K7sDOd0yHVhJbu0/VIbheed?=
 =?us-ascii?Q?BJwr43ItB40xSCcbIM4EmooWUnPJxj1Hek7ogwEWAtHJTWS3n24ErfrZIGH/?=
 =?us-ascii?Q?W1HgVmTLYrF44dBBCZvltuMQoP6lk1skNuQvPjnuPA1n9i1dOsXUxTMrFI5L?=
 =?us-ascii?Q?OAg7qU+caAM8pFHTyTed67ir7Xh2CuuYULNhmex1iJDYm+7LtwXHXFSjtca8?=
 =?us-ascii?Q?3wDGXChXaDh6z2e/gVP4XRirAGagWlFNJ1nwhtxnLXbC52Ptrc7BHBxrGCCa?=
 =?us-ascii?Q?8BQs0dVQIZcJmVIskv2fRoqn9zw72pFla90fiS0OETzvKxHFECgrdb0L4FPd?=
 =?us-ascii?Q?6w150zUGr8y1K+7yH2znfeXG9OHqwggmGvQa5Uc/LWJFWBYfJ570Q/FbluUB?=
 =?us-ascii?Q?HAMuMkwVDs7lOzcFLrUIqNSrAf4Iwgx07Ser2K/SsYkLi5WAmgYqk1vm3zjZ?=
 =?us-ascii?Q?8C5BS9ORsHNayZwCNX7IKsi4UTeQEgLz9KCcjq86evcKoNP/yPz6vu47LQIs?=
 =?us-ascii?Q?2xwFQ0FFSxExvERhlvizlbhX95vD6womOmDhikuOhXL2HRRwKgg5Er5qrfDd?=
 =?us-ascii?Q?2H71BVIcRz3dKQ6g0AXolgymDpz9xmXHF9N/3BxMfSJjod+8y/wBk7dVnX/u?=
 =?us-ascii?Q?DwgBY4FM2cmch9zCK1xJGZ8YU1O1p82DMKRIFWqcvjMA1L63I+3mTFaITveK?=
 =?us-ascii?Q?BuQKbRY+Husd4VvgPnOcxVIlIsKJjYcfIlMpXzFHwy9eDZsdyLv2U064sBR3?=
 =?us-ascii?Q?qrxLDdc17JMOTEzhmyh1XLu77NSJpoeExuxHp9WZtnO8HpYzkPDbKXeKRsqp?=
 =?us-ascii?Q?xfY8tM4O2HP4BeJHOMxzNaMMYYfKimGfyfRlmh+GLuI5Kk0gu5R0FVuEA4cB?=
 =?us-ascii?Q?qXg0xbUOK9wO53o6n9IkHN71dUShGJPy4NRnrynZJo23XBKgQiUy6/7TqA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pcTKrpdUr9ceIm7ovcQxsWvJrVLflQa/nogPvvzNy4+kGxKOPxX2YPTrhdUX?=
 =?us-ascii?Q?58vVzB0Nefd9LX23c3g+rE+85qb4bLbGANNDNP+665UlkqeTy7DnmkRL+5jG?=
 =?us-ascii?Q?VDv9wu1tBJBHwT0UY/AxYX7DTkxss6YoI64Baqk/ZoOY55RSBndT7adZY/7y?=
 =?us-ascii?Q?HX3HlQ/3GsnvsF08gCLNpvpG5gtEzQiGWW47RP2MH+biM9PR4HORmArxOq/4?=
 =?us-ascii?Q?8fIXDGajpLP2yeHb/J0/3ODBr0xyehmBKH4K+v3r+Ik5QUdPA7BeT35Eb4tl?=
 =?us-ascii?Q?0pv96eFORzyCYtDMQPj/Y73k9DMt2G1eC6IVhCuPTRue2G/tBwwCVe0PeWRB?=
 =?us-ascii?Q?dIaCMQdGRUo3KIl0w/M7KMrgEtVqyRRvgRAEUCSpiOrC1sYwrOATrn3SW1YW?=
 =?us-ascii?Q?H9h0HzS++watmuyX4qHBIP0v9rhu9ACv+CJADL5MZY0DzEeBJ6fqEjotWqAK?=
 =?us-ascii?Q?dnjvpAqBoC2jHZheRw7UjbYwSieFu2eseoBJumvlz2CSAgTuFAavFvCjYRMR?=
 =?us-ascii?Q?IH8wzOA1G6odMMGezsjqXBpQihDlFG/z8wqmHCgj1gHWuOlfyMdmLOY4cUgW?=
 =?us-ascii?Q?rQbe7v7zJSnul3WGTZKU4r2dQqVtvM+tNbA6ZoH2VWKhl3XMmzdGvTT4qKcL?=
 =?us-ascii?Q?O/lKPqeU5AEJeWvu+QZIMwcdhyd0zzbs1nEF19Nq5iwtQh+EmrJFF2ODM8Yz?=
 =?us-ascii?Q?VBcshowuGTA8YbH0NIj9IOOHglTcNea8z3oNaUdHRNFXd3Umvywe27F03ynm?=
 =?us-ascii?Q?KclZbI+Epri55YvsN+wk47ftfXKhn/CSWi3Tp93rTVronVawaOVpr8nGE2Kv?=
 =?us-ascii?Q?zbfTDctwwkYSTzSj1NNot2N/WihBxrygvPExH2542jIucEOo2Yvw2BL4OH90?=
 =?us-ascii?Q?tVd4pUWWRnKSiSXNkAy4i0UK/0a4iI1SP2/0cbO1XM+hEtUm7ZZgC7ucXrHN?=
 =?us-ascii?Q?TulN+8gYdsVKAvv9pPXIBVBhPbl6mBowQMm+HjxYWmXzoaAt3VbITGJklL2l?=
 =?us-ascii?Q?3RcJccllK3Kq+0hwHdgSL8oZUtldEOT4k3KI0ErjZqozwZiR6wn6UQT7xRPO?=
 =?us-ascii?Q?IK7V/MGF+CTerK2ZRDFAY7C3mFT8z62+JLUamA16IAL96A6YqZwtG9mfiP+R?=
 =?us-ascii?Q?57h3ib6MBv4l/ydqlOJ7m2w06mQhRJGb/plATf4BkPP3ZGKij2zjNlCVP8ip?=
 =?us-ascii?Q?56reWl7mGM4xlw/yBoR8fMHCuPo8PcyncgpvN2YOACHr4h3mpE3AhzdP3wn0?=
 =?us-ascii?Q?K2XAocSFfmABitbDhBrc5+esy/xhA46R8ADcsrwQ8dWhnaBadcKTMUxwhtEv?=
 =?us-ascii?Q?DVbSGlKPskmM7Y4InSzyp1E4WSQgdFkIukhDooOziIu2jZKHZ6BqbZvyoclt?=
 =?us-ascii?Q?ceOAVbyn2WlTg1JSuIMY37CwY7YCMQy0W51rPi/bAKdRJSWoiugni4nMls9C?=
 =?us-ascii?Q?L6w2vt694rwv8eUhDP5gmu0La5w56SQPTpHze5PRyAfv81MW7/rUtTCWzfkN?=
 =?us-ascii?Q?NBHcG7xqgZ72vNXEFB3Qeae3ykddIewTkXJGaxO2b2S+j8zwkXYC46MfteFq?=
 =?us-ascii?Q?Vpj/Yd89Dt0qvFFd6jyOljme3AO3exTooCDZyyOZwRX3FYYpKIXSYc9zCY7Z?=
 =?us-ascii?Q?euoHOvzCBkcXazZcWvH4wm8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e9cb30-4c70-4299-4164-08de08321cea
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:46.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs5/6jhRXZjWZyyK7kT1hIZMquMv+6tC7AaQdN7VusnHbSFNATJIscLkvISur3MuNthAGkEdYDjOSPiGZhmrgUMNzFwYu0cpvUQPybo+850=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11352

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
 * Add support of EN7523 SoC

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

Changes v6:
 * do not fill with 0xff the whole write buffer, only areas not covered
   by user provided data are filled now.

Changes v7:
 * add EN7523 SoC support
 * add en7523 specific hack to avoid flash data damaging if UART_TX pin
   was short to ground during boot
 * add SNAND node to en7523.dtsi
 * update dt-bindings

Changes v8:
 * remove dt-bindings changes

Mikhail Kshevetskiy (15):
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
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  arm: dts: airoha: en7523: add SNAND node

 arch/arm/boot/dts/airoha/en7523.dtsi |  21 +
 drivers/spi/spi-airoha-snfi.c        | 551 +++++++++++++++------------
 2 files changed, 322 insertions(+), 250 deletions(-)

-- 
2.51.0



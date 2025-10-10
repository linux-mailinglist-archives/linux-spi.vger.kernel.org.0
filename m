Return-Path: <linux-spi+bounces-10513-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3671BCB8AC
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D521A62B03
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55274283FC2;
	Fri, 10 Oct 2025 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="2vhyTpv3"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023102.outbound.protection.outlook.com [52.101.83.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F527A442;
	Fri, 10 Oct 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067136; cv=fail; b=bfcI/v95+cYYqUTGGTZHbEjK+B3snrtzdTOw31C8HYO9crPk7aZRv3gMIamM4FIwnqHDuw1gq3U6gOX133aEzpmGNYOW6Rrk+BqMSlHMoUk6lefKGTZ7KvrZM9kQ//pUo4rUbMcfMQgRQdS2AL2+fJufpVwsMJhpcWOK3xpSs0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067136; c=relaxed/simple;
	bh=TW0r7ZDi5Kpc0NOqesGU8kDdpINxRHGh/ajmzO2PuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvqSZ5MF2CcNydGH8DkDJTGc0BAUsAPCgIfSWe4LptxxfmmvI24tq+36p+FlapoU5849QL+O5+KWb0KiiWQ8CcELdDXjopoWw9gtLGjjtzEG9TXx4xWsSWbQZFTe12F/bScISOUaZMdQmb3IdchERwFNfNz3gOB2NICT4Na1pgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=2vhyTpv3; arc=fail smtp.client-ip=52.101.83.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkXSo2YBEg+kyT0fOutCSQdhwUmGOGPHp5AZmg7g9aOVC4Kt+XRCWofEuXjW3xXzG3eoad2jzH7Izlgc9p7W+gOlo2/oj/bxIMzL60r4KCcqy2Ij0Pvi9jTN/0nyiRM/ZDFDUQ3mar5MDQuxseShCZX5Is88zM7E4tNE2buZ5rwcvYfasmLhjmHAICoWsuU1bIWpM4pBjD/9ga2LNOAWumLwD3ewLEgIzO+0UiJxaIe2OaV9HIwp4hThV47+8nU5WPRbUhH7+mAiHex33df5dYgkzNSbaqaAOGr8q1MgkxiDCln04zlzdK7VHadOmm6xd95DFiiF4ZJrzppo+qomKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=LGW2gVe92vpITIrZ9I0mCd81h/PzYt/rDdHmP/doI05c7fUJMiVVmHEgP0P/QCA83fbVMh7hwkdy1uHdiapRkf4bc+npfdOFgCRsLYqNA6NYrDu0q9aWBOYp7rhH6u2XWu9UlSw/RAdXUF9BX2pL6GHSLxEmK/Hh5AP7R2B/q9aQzMrQnQRpvyFK8WXi6WkINbUK/UloaqcPI6DXEcjMr/MrTSNWMA/TmeMUQ+YV6bNfbxlvwhnwfMOVcF9SaV3Ur9C1R43Z9x8q/dcX3ueWa9ABud0IlNVhhkSdLioJfWVZZD8ZO5VGzOrLw4M7oabiBBAMOdNCjkITYYEDa6pdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=2vhyTpv39d+aElDxS0OLcaRdtR2Zunp9xjravPK6ZOEegHtxXa2myCR0JUqt0nQqcxBUgr2LLqO7ZDn0PFf1hoOp+UenARqP2hsn0fKzoGlPjCF/VFdsM3YgB8yfU0F8wIO0A3Jq/xC9ShRZPFeFF2CBkstrsHN/DnxvNqp7gEMOAgK1OFCVo/Dx/zgAViMzmmTVq1LDGM1b9bemWBwouyvVF4FzBswOqXP9p/aQbqLC4GVTWgT6DgB1AnUvvUFKfPQtvBaRV2sCVQIgG35mXOyLFj1aTcRkwVM0CxAFta851ROHS8LVgsr0Z76kD10BVV4m0R53YWMNOax9s+PdCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:32:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:32:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 12/17] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Fri, 10 Oct 2025 06:31:31 +0300
Message-ID: <20251010033136.1475673-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1831efd2-4544-4524-9248-08de07ad94cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l3Lp74wAamGwqwboJdpCo2chD6urchat79xZSnUZ3PYIQM0eS4y9ARo2OgKE?=
 =?us-ascii?Q?pvO0HacGSA3LXkmfyS/ep9+0XjGqcxiENBzPlvjeOkjWWUaTkRXPjilYqfZP?=
 =?us-ascii?Q?R5YGUou/iBJ+ArmUQ6A1DvW6/u5iOCbVxlU8Eta6mGY2IQFx+7c9shH6SkB7?=
 =?us-ascii?Q?h+U8VHdJ9o552RaUSol2eXQDGG7tR7FX3JuW7HipcqsL2T1a3Ty0KO+D9oCM?=
 =?us-ascii?Q?TrbCTM0iP7G+Wq8ZWfDhzq+DU9tNhStA1NNkFJpjjd6hfc/t6jsgMyv+Fv2p?=
 =?us-ascii?Q?+v37F/8ztKc/ZyjZ+UFoG1F+luyfU+n/R5YPaGpjiYZJPjW0DupZ96di9txw?=
 =?us-ascii?Q?Iu4YxmN8TNIZAo76SuahnxeZ3bZfQ1x/Hvmt9rmUM2COE2rx2vHtanujjhSL?=
 =?us-ascii?Q?oONLvUFJ/VdVmC/1V68Ax+ZM8MaUM+enSzz/gqNYYmrubpHwK0G1hq3hkRXW?=
 =?us-ascii?Q?z9PV/ei5S5mCzw3+D0dLEHJlWzhk40LQVc1FMWW+NzgPuK1gofY14J1BNiXi?=
 =?us-ascii?Q?5i3bFoR9jrbezjedLUEokqiSevSNduKUYheg0dJjVU2yj/zkbISwYK4HYiEa?=
 =?us-ascii?Q?cAMfW/+s9hIjiH7lG87TIutMn8BJhrXQYPL9Xd+1v+9pUYnkJtXWYo4ih6lJ?=
 =?us-ascii?Q?nNJhG04Dbdh7xQss/aXtqOyPALUpGvuKejaiRRwPqVPfhY0U1FqbGM7DAUva?=
 =?us-ascii?Q?DT9FHOT9bp2/uzdhuC9P5eeYLKF4WR7zQdyypOygbrSnRTjCWztjoejZNjer?=
 =?us-ascii?Q?xwHJFHLWA9MpG45GpisvD4mxzD05ivIznr14z9EkMXzBFH76l5lATX+i6838?=
 =?us-ascii?Q?3EkuD7qOSK/oRLQhX0fCNS99V5BZwixa6jVpaJ3moZ4CrVbHh6dAwfYRNGZ2?=
 =?us-ascii?Q?dPjB0lmBH5Ds9hJzxT/aVIfIqitG5VS/dgIcb8PyKWdMz7VZYj4ys4odjTpl?=
 =?us-ascii?Q?3rk6lgxZ7eKwq9mkrTS/M84MG6l1RuVyLNKt731YPvl9caqYcrk7itbMKJhm?=
 =?us-ascii?Q?cDgMkuEnaVFgDylwCWGawn4/oAIpIs/7Pm+RsJNykZSL5o1qbhExQT4gpOi2?=
 =?us-ascii?Q?XODTey1M+kjDWFvhv9rxK3foDSfdgaWXMKzQ36BGAlTcEtSIgZ606V8DZk/k?=
 =?us-ascii?Q?I85VUylMq+HS63LIhp2ReCfas680fHK2c3j6z9gXh69PSAhxEX5IlgAT65Lb?=
 =?us-ascii?Q?2/rqE7btV+GVzK086C3fcBkWf7SKgeHgPErkzrmRuQMO7whdgXi1XzYhPDMb?=
 =?us-ascii?Q?ll7nz8dXID9Xz56tFTsT8WGWZJNz520RZ0wWryQHsd9PVFfguEbXPSMBWGCW?=
 =?us-ascii?Q?FZHBmQBB7l7X7VtQ3YHcErHSHCs3pZzyYo9OG9HnNlwTWkFCa4Ztm6H9eIeA?=
 =?us-ascii?Q?qXrOt2tIvnHoxBRHRQ/qm6IlItTBFOZRefgCPwTMX9nX+PkxZB5y5QgjW7f/?=
 =?us-ascii?Q?6MMFNhr1jWNEh6I9lN0F+H9hs8HhQgyyfdpd2jKa/5O4U7THxdQEG4tiU7fm?=
 =?us-ascii?Q?k/Wx5aYvMS4e2Hoe8vw82utOAcRIJv5Q7oQBp+xrXiKtTqJJK9uvbOBVTw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hv//3uL2nMP257K3Med0ea0MjFqyjFRr334hD6v417YOiqdUI05Ewpw8hSph?=
 =?us-ascii?Q?QF0rmMMePkJkGNr6Lq1W8I0NURhn5GxKetF6ZVzd5tszQJoD+k/Nt4t7jV3E?=
 =?us-ascii?Q?n7EC53IH0euloKZgOzLlZQYU/QHH69e9EXdtCZFvfe5OMPX+/6XES2eIGsx2?=
 =?us-ascii?Q?NST+TB6lNch2mqsnJxEEHZmJbtQbeeQjoOfTZasXVYFLTXPWjpt5OyGh+PsF?=
 =?us-ascii?Q?8NqfvmPiezQeMd4tZSph4p5zSs4a+Svl5ff3LKHbatPdEG1pUssNsE2bXgdv?=
 =?us-ascii?Q?VR45qksiQXB2KBkDWIPVW65aI5KQSVqjgvAtRfzJ8j2Ma+5U7VpmHk2E4UMT?=
 =?us-ascii?Q?/4Y1F3gakax7bBY0GyAEDDTTF+vWWzK9IoOaxwznXiG5SCflVrdSTJ1pq7S0?=
 =?us-ascii?Q?VTi7zXhuDTry+DECBBcFTpDjqnlyOepNRmypL/EZFeIVq2ns50CqzeKCY7w3?=
 =?us-ascii?Q?zk8gTrf5fA/h9zZX9cnQ6R2iylwsLeJr+j5QctTobj6Jlj5pYycATLuNgqgQ?=
 =?us-ascii?Q?j2bDtzUXwzlUC4vnYpgc8SJqP93o6eJCokP9eb0vY7eTHAoCgc73D+oKaD6L?=
 =?us-ascii?Q?UAUaS4pe4Qes5nTUDvQ0dc9zX3mfpsrHkvr3h/LQrSbpGlw/pS2MwS8EUlwa?=
 =?us-ascii?Q?r8LN7eBzJ+pac+cXk/yTLw4JSFYaZkLZNS4k/mA6NnIh6GoWSq2rvLs2RK5n?=
 =?us-ascii?Q?Zx7PQrVPr3k8ZFCZFSozoLc3DWO1lZIXIaqnFonowTDC/BUdiDRbelREHpZ0?=
 =?us-ascii?Q?kLTTrHXJ1yfkEghoPMCKRFWY09NXOa/nm1JZFhJ1jLis3ZEWPcCpC4t0Lkc7?=
 =?us-ascii?Q?W/A7mzv5EkbExp06K0nP69YOWj6PeWW6HF94IA9Ihlk8ApeiA9r/yIWVNm5g?=
 =?us-ascii?Q?edjdjeW6SvbGDBltVicDBYk+rnQAgJO7N9fhe7KIUu2xvlPiHB69jmHS+Lky?=
 =?us-ascii?Q?6kdRTU09sS22cBPIqFsX6IYoBQyRzKx3vbRUO6+9bjG5tCKdIML0aJVtu/gr?=
 =?us-ascii?Q?Rn4KkfcagXURdTWGFB0drjcmC8t1+hNdU34SRAfZ1RoOIFoR+M3u11PQ8pyc?=
 =?us-ascii?Q?WUtiMyCU35A20e4E1Y7txXu7hj2vgUq4ax7cBcFrFA+qJImLfqI2M9Xpk+Jh?=
 =?us-ascii?Q?+xW+qSLUfcpVno1fggVzAyUwyaGFGn9X+8bQ1G2RYXm8gWPK6fLIg6NnC6+S?=
 =?us-ascii?Q?SfPojUBYatEtYztj/VA6K6YYc70sw3PZ1ufjDddbl0bG1GbWeVEQRA0agI+F?=
 =?us-ascii?Q?YZlL8TJOikUvNUJE84vFID1qNByVcEKEhr4AKp3qmIErJtQzmTfV7Ve1kevZ?=
 =?us-ascii?Q?WBDH/xfjNVGyw7JkeITge/HBX5fE2v73gzwg4bLicFdeobj/PrMqKOAHqlwf?=
 =?us-ascii?Q?A4rv3R1MXNQHid17Er2fBmW3vHnyXNpwVGg8kyJWc3GvmP+wyqRWvobYUe6T?=
 =?us-ascii?Q?eVZCnwjTe/NDQRH/+aH88K1gNMh93o8PBZUJ4zG8csQwbGL84zws40XVoskN?=
 =?us-ascii?Q?bI+qEmJChv3GjZGtFquAlrNx2VaEi1ehuE2UAVPMWVaaFq1ILXRn8SSnMGjo?=
 =?us-ascii?Q?t2iGWcf0JBtNuj/cuVHpyGR6hO80xfA/zZ/xKvNTGDb5P6KPsQkgrmkgZs9p?=
 =?us-ascii?Q?DK/8QGDRlbDo8E/YazaTyLg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1831efd2-4544-4524-9248-08de07ad94cf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:32:04.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABc+3O3I/bLj5CECAVHRvCHe3RLDWMQfdj2+4R+UTxncsLJZzTTXcI82zhIt8OhLp4jNGdGa1RJMVbBqJqDFRKtrsP1llLf4GGvmSwt5Mh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

The spinand driver do 3 type of dirmap requests:
 * read/write whole flash page without oob
   (offs = 0, len = page_size)
 * read/write whole flash page including oob
   (offs = 0, len = page_size + oob_size)
 * read/write oob area only
   (offs = page_size, len = oob_size)

The trick is:
 * read/write a single "sector"
 * set a custom sector size equal to offs + len. It's a bit safer to
   rounded up "sector size" value 64.
 * set the transfer length equal to custom sector size

And it works!

Thus we can remove a dirty hack that reads flash page settings from
SNFI registers during driver startup. Also airoha_snand_adjust_op_size()
function becomes unnecessary.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 115 ++--------------------------------
 1 file changed, 5 insertions(+), 110 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index babf7b958dc3..437ab6745b1a 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -223,13 +223,6 @@ struct airoha_snand_ctrl {
 	struct regmap *regmap_ctrl;
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
-
-	struct {
-		size_t page_size;
-		size_t sec_size;
-		u8 sec_num;
-		u8 spare_size;
-	} nfi_cfg;
 };
 
 static int airoha_snand_set_fifo_op(struct airoha_snand_ctrl *as_ctrl,
@@ -490,55 +483,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_ctrl *as_ctrl)
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
 
-static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
-{
-	int err;
-	u32 val;
-
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
-	if (err)
-		return err;
-
-	/* auto FDM */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_AUTO_FDM_EN);
-	if (err)
-		return err;
-
-	/* HW ECC */
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_HW_ECC_EN);
-	if (err)
-		return err;
-
-	/* DMA Burst */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_BURST_EN);
-	if (err)
-		return err;
-
-	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
-	if (err)
-		return err;
-
-	/* enable cust sec size */
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
-			      SPI_NFI_CUS_SEC_SIZE_EN);
-	if (err)
-		return err;
-
-	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
-	return regmap_update_bits(as_ctrl->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -571,26 +515,6 @@ static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 	}
 }
 
-static int airoha_snand_adjust_op_size(struct spi_mem *mem,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	if (airoha_snand_is_page_ops(op)) {
-		struct airoha_snand_ctrl *as_ctrl;
-
-		as_ctrl = spi_controller_get_devdata(mem->spi->controller);
-		max_len = as_ctrl->nfi_cfg.sec_size;
-		max_len += as_ctrl->nfi_cfg.spare_size;
-		max_len *= as_ctrl->nfi_cfg.sec_num;
-
-		if (op->data.nbytes > max_len)
-			op->data.nbytes = max_len;
-	}
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
@@ -641,7 +565,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -833,7 +758,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1076,7 +1002,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1101,36 +1026,6 @@ static int airoha_snand_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
-{
-	u32 val, sec_size, sec_num;
-	int err;
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_CON, &val);
-	if (err)
-		return err;
-
-	sec_num = FIELD_GET(SPI_NFI_SEC_NUM, val);
-
-	err = regmap_read(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE, &val);
-	if (err)
-		return err;
-
-	sec_size = FIELD_GET(SPI_NFI_CUS_SEC_SIZE, val);
-
-	/* init default value */
-	as_ctrl->nfi_cfg.sec_size = sec_size;
-	as_ctrl->nfi_cfg.sec_num = sec_num;
-	as_ctrl->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
-	as_ctrl->nfi_cfg.spare_size = 16;
-
-	err = airoha_snand_nfi_init(as_ctrl);
-	if (err)
-		return err;
-
-	return airoha_snand_nfi_config(as_ctrl);
-}
-
 static const struct regmap_config spi_ctrl_regmap_config = {
 	.name		= "ctrl",
 	.reg_bits	= 32,
@@ -1204,7 +1099,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.51.0



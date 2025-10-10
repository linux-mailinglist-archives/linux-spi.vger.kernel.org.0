Return-Path: <linux-spi+bounces-10544-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE8BCE5D8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98E6434434B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA969301701;
	Fri, 10 Oct 2025 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="VUFlf3LE"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B3302CC6;
	Fri, 10 Oct 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124076; cv=fail; b=aKsvjUsiRkxOtAU+JvfqiaIwiZ0hXIKWZd2+Nxm1AqdJ6JaVDtNOiSaIfGnkuwFFvJfEYHeTt2OGvJoCUdU2HLEhmt40gLREdq+8LRA2J93oOV1TV/hsFNM34irT1EIF++jdGq+9dZgPIH6Awg0sEBNrPpwn/B9YKRckKRBlL8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124076; c=relaxed/simple;
	bh=TW0r7ZDi5Kpc0NOqesGU8kDdpINxRHGh/ajmzO2PuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBqci/Feo9qvy59S/Vaox6le/1uYTaax0195ek3xH8xtsDbD4S0o217fAZoB9UUdFYusYlR1P1GlR8HbJEpC96n1Utsj6yBRDP+B0ETdvsAFEmzWigPqTupuPeLVJ+iwgOVotLRS+ITH8GM9feYA7dskQgVanG12e6sdyS/fT7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=VUFlf3LE; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIVhe/CTlug0f/y1HGWbgTDNtw3Uj6RrNEbIVr7dFMfX7NqFWggN9ABxurB+udyN28twVnf0mcunc3PJmiDgRvuvn2O9irL52iO0euQohlifUUDmOzjxBN5s/yp8O0FN1oi7Vk+1RYswFQQcd00Q2WF5K7RAK92nB4LkiiBkytTwIeCu/o4Oh32d1x8SV6UGsQwlnnmdlmQ8QvKYKplxGGHTX6NH4gICKCPZOxIiV5MubNlzmd8RuhM8zp9bVCqaYSp0k7XFFmNW7uBPplJKd1z4Z+/UJyvkx7k5+W99JkoXgUGKJYwcXzT1Ngv+Vi/+Pwu5E/oNFqwT91OryENbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=BgyvtDcjarjNHtRvUyp5lNp3UPBfld/LGvhNhgHeM2Ow1UNPFtp4bIahgCgQ+SP1s175dpe2b5+i62B+l58Aa+xYKmD5RiMkglF5bfbW2s6XV4cOt2VaSWuz3XYr41AaUOXzDqzOFyHRBo0l/vHSanSUnLvl76jDQMg1B9AQ3rFT0Q29O2AS29uK7Ojfp7wYVx73vmO3hCLrJcUplcljMRbjCWUuiLg3gzQHW2MORKQHs2bxc3040lfIMWnfQCFS6O6bEn8r4ikOyC0vKjCE698MblzfmVCYR+EVk66HcvyXw/O0e8VUyY6y4a8LSDogUonfMS/1vX0uEKZNX4FLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=VUFlf3LEEZeuJt+49/9UUy7Y+FEl2uNzfDUGRRgfPsgNoL6xBahA6kMJs82oUWCahnrbbIhfeWtc0Rpsv++lVBqk3V4rg6Lq0qtNj8Y+FlNygRsZIzlFgMi0fKWl9lqIw3RxsBwIPEw+mtUkMy7ds+wy/UEc9cQKuM8tHHNklsvq4YAxuansmJJHM2Fo8p6hBV03IutiKJuJpDkn25GOWDvhALfK+Za68LNbXHn5oVOd14FfJFvAP5lJ6q5KsCyvAjcZLqqU74bzSug1r0NAeJRPcuNznr9cOtCykmC9YCPzA52fV0srerdG4fpZtPuliMzPuvgyXQZYc7sOr1eCpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:21:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:21:03 +0000
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
Subject: [PATCH v8 12/15] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Fri, 10 Oct 2025 22:20:35 +0300
Message-ID: <20251010192038.1592889-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d029f6-21a8-4088-831b-08de0832275d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FcFii7a4E8Lk4RgE2xPUSwdZvllUNr2PS/WCCejGn/5XMdcPd/Bwjj3lAoRB?=
 =?us-ascii?Q?83UTMkT7fTfIoCK3uKwaQOJptMdPBimOCgMqIo1iz2Ba2jMpQcrTOCDQcehq?=
 =?us-ascii?Q?8XQAIQWNSe3F0r/I3dzqStx0xauJo4/HQqT+8C8hXwVJmm0/aTs9Okx3vFla?=
 =?us-ascii?Q?fcZvYMvTblI3x5/CQkDNVWcHxSm4217/GIIUX4t/zkDmWLTM7AeqdCjzcqbA?=
 =?us-ascii?Q?25Wmz/QszL3EQetZ4Mv2qnhk1P8Ai9iLnYN06FDtLVxM8sAAOIaB7vmugAn6?=
 =?us-ascii?Q?6FXTXTa685xp8UgOSqReCxOQwGrkbuk3f00VTnVqHZ3QBm2zQ7je5RVfLZid?=
 =?us-ascii?Q?tUjDIgVjIzg2RLKXwrrsrNuIoVR/DJk+krQh/faYCZy6B2sFTUv9Nl9hoTnG?=
 =?us-ascii?Q?uINnd08ZHfEBKw8bHnNEW5ufbD/FYPb6bjY9FXFzCoDqmBcyKSoIqr4Osg13?=
 =?us-ascii?Q?le7HxbqnR+2rHiHF/qEFeepzgdb7oyYqI4UWDjR3e9BLrib4cme3DrPvRo4r?=
 =?us-ascii?Q?sKk9PshXFKTWadnO36QJzrObupkwnwMtzsMOqO7+WK117jMflWhL9HbEWdwr?=
 =?us-ascii?Q?O9qtManIbdNsSiZgOijAuuqgYSNdTt73OWaGzDEDAdJUZBSCnloQ6cx594q0?=
 =?us-ascii?Q?dyIp8pSbXkwf04zsfQKJXkwybpCK9EDKjSknNM6aeHQ87H/j7qTUXBKoryIH?=
 =?us-ascii?Q?3m8IFmfUIO/dr1I4xbvpe7+CS0zBfWvKIBIpt7G9UJh0ezN5h/v4jPMLslmn?=
 =?us-ascii?Q?WBV6Ttj5uQVnlMLPX2LRvrA9nSz9N5cen4AJ8SZcTbHjnUn4QDhU6rQ73fZL?=
 =?us-ascii?Q?IWeyhCXvN/leGyGdpQtD6Zx/T7vCSKpM4U1N51/yKGlVsHXNl5H+6Ksq3WHO?=
 =?us-ascii?Q?ysR0z5AgOCbh7TPFnaI9NtVl4e4jwqeojk03GmRavp/34Sg1fo5nL3jQ5qf5?=
 =?us-ascii?Q?AtsGC5SoC2j4pfkLlobi1ONTPnOhX6sqcXwAz5RGXWOBSX4VDDICUyLs8aNv?=
 =?us-ascii?Q?eEq0dfxgStJd9efKilMRiqCxrC1QytQhNAHYSD27GeNh0QwsMpgkqqii0chC?=
 =?us-ascii?Q?pQgZWwlx8PZDSDNf7ZO5OcdELa8BadW4poiz3V5BumwgjEcvYW6E78kIvJOt?=
 =?us-ascii?Q?BTHE38FaN1Jf3CKxy09X98A+7rvvEoC+vaMyQN3lSkbkwGebilbabRzmHF3j?=
 =?us-ascii?Q?Y97QB7UHDcbQRUlkfTJItNjdFsQAi7IJMd4rn75FgcKy/pNtgJZm6Fqo+XEj?=
 =?us-ascii?Q?1DfmU8wshTv/tytyNJMOMhW7+JZe+2sEy4GTyGF2sa2PKf9ai0gj9hnjZ52Q?=
 =?us-ascii?Q?nqDAgZVskdPWdKb0fL/Z3aCiSMeDs7ds9hU9Qu0JfnS9fbaEhZfQd7b7jyW/?=
 =?us-ascii?Q?nCz/hCTbp61QpwVNVFvGbsOeSxXJygu47TlBog3CkDIYeTtrLI1bKkRX2iwc?=
 =?us-ascii?Q?rnvAynlCII25HaMHYrM26BI9lUvSDTV5cGL/h6d39IGEeEp2auqCkZC/ozfI?=
 =?us-ascii?Q?8F3Ss6VT6iJku7ggiHqBokdlia0wRKZWN5WvkN1d2hUDfRt5zlHaKijDzA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3Kjqb4VX8blis/HqEXxCcGmeu7dUIk0ia81onebq5rFnV5dmqze23nZXkkD?=
 =?us-ascii?Q?uO7ClyOsAbGDhG0p9Csy8+BSOy/bZCbbxb3OVFIiWLcb05lpug1zpZotm/jG?=
 =?us-ascii?Q?sKqPdqVY5AKw+GTRXxHtI7SPZJFwSvX5EvSD6ydwxQPy+KS53exQ52SbFlnL?=
 =?us-ascii?Q?LlxVkTd+hlypLxpF7yaotxI7NK5zVHd4j1VMotmcSyl/3UoXNyI4ioLr3GlH?=
 =?us-ascii?Q?S+Cbjw80TrBdtr/800BU7zNRrtA21xVBmIiqXon9cR64SsZkl6iBrkZ0L6Jb?=
 =?us-ascii?Q?jOT3cpmo6vKjnGEZZ93aqZd1vCfJF4DwWvtLXYkAY79wj4A7hCW4sbt0aGSb?=
 =?us-ascii?Q?yiVuyooMbp6k3Z4IRgTHZdqPCD2wsD7ySlfib7IzrNbLHOMPMww6BeMqCjUc?=
 =?us-ascii?Q?HA8rh/YSN6OrsVZ659pIi9MlivJkcfg7BJjmcBfTCm7zrRl4saNcoeRyRxcc?=
 =?us-ascii?Q?CzLtytw2oo1XnMt7a+tJNx+kR1MYpoSPwGuLPcvFxZlH1nCumxEC68AY/ByY?=
 =?us-ascii?Q?OCuvPlxqwS/GlRaC/jgulU6H00RuLMuaF1PbQwIrExSKPwJqdJ6iZ057rRaA?=
 =?us-ascii?Q?yvQncQ8nJcAknnaK739B4pPm6E1n1uTKP1+vC9mBwZzBOYEb4MfJw06fMzM/?=
 =?us-ascii?Q?rolv6DwJHE8IYTnlc9uinov6APhWk140sK8+TAuqf/tRA/VBATTB7/+Eg3IQ?=
 =?us-ascii?Q?Z+emxeGykKvvV781upYbZNxdV6Yb0Wee+MLZbyiGSg/Xwqx1fxuOQqohoUth?=
 =?us-ascii?Q?i+tcmcRuedDEcVDH0cUnId5yofVr+eghINd3R6FmQBlAetF5uCH1f6sJkjoV?=
 =?us-ascii?Q?ga9ZULTIbPz8i2ZDBr8qqXNy542kUIlC7VWtm5nZMIgogSDQ8FR5yLIagye+?=
 =?us-ascii?Q?9QfaUarclwM/IGMkheG3j+7gNX5AyO/tD68PWZfM5jTRfHIW9Mmo/qnwWVu2?=
 =?us-ascii?Q?8ZbIgwRUqsx1gJNCbRJmYJ1PI+7my5CuI3oomEDQBZRFDLZsohkPUZjuWP0e?=
 =?us-ascii?Q?aLIDrCqK2ryAEZj2K7QXEnAKlF16H3s0X1xUUeClYmW/WYYFuRd17zMSvxEP?=
 =?us-ascii?Q?XXRDDVHWWazvnv71cAo84p0xFtMuwKbhBKgff3RmvcD7GaatJMEW7uam17gx?=
 =?us-ascii?Q?FdUF19U7Ct4TSGFxF0E+nyRkrkJNKs7nJQDxWt10+LpBdJsut/Uk3KMOhVXw?=
 =?us-ascii?Q?qmVbJNkoag/6FLkzRlWWYJfGaWggsNCL7Rm3fKKpEs2j8OHjETtH+EmoUyEw?=
 =?us-ascii?Q?BYBMYISNFwXAvtO/4aH1tqgUO60Za11T866ivz+fQOyDJXxxQpZbk5bHfPJX?=
 =?us-ascii?Q?AJc/hpSnSU16ocCFy06+nlozJJfwmHA3wWsvY/374tCvSaiMUPzkwG8nDWnW?=
 =?us-ascii?Q?XRsh/k8doJRlKtrLueH+hFPmW2IxhBS0GbSDXwjv/gPgfgMxN1XMQxUTGGHp?=
 =?us-ascii?Q?ILqAPrN+6KqQkApHVsN6JXMjac/0GAxwXd2ak5A9VVJ79KEMO68387vIuKdl?=
 =?us-ascii?Q?DY7uNMpp4jXo0YkWjpfuKH8QV6ck1NqjtkoZrgnd/JZmn3x6IBzZbyfWFTza?=
 =?us-ascii?Q?tCr+KDeNAgQb4urpMAD8aZvByu6ivc76laQW+aSo7HACij3G9K3Gd1cNGhid?=
 =?us-ascii?Q?xqXojrQ8ywapFgX9BZoVEYk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d029f6-21a8-4088-831b-08de0832275d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:21:03.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhdx0VJS+n+sOzakm54Wice4RlATDGEFIFedCE6YPevEL7qA3PZuy3BteAO4shG6aGIObYBRNOJYXoH0sac0CUZLIWXPgciPaoi5h1piZXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

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



Return-Path: <linux-spi+bounces-9636-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD1B32A42
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70D21C227D3
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF11F4180;
	Sat, 23 Aug 2025 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ORy/y8Z1"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021097.outbound.protection.outlook.com [52.101.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BA1EC01D;
	Sat, 23 Aug 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964892; cv=fail; b=opwPUEYBGmgpYhr+OGzR0ORfOM/3NL4vTpyTvKdExZU7Wia0c+ZlzIVfJ9coPdmVhxuiNVx01dCD+jJER69/HBfQJrzO2dVlakCNq3pw7IAvZUDiifh2D0/969B9N54ZuQRe6OPGh/xnuA19AWHZcpz6zO1y2Eq9pCWS4VCv/mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964892; c=relaxed/simple;
	bh=yfVgRyVAlRoU3SzK1GEy9nQvaGLglKASwFFrlb9QsS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b388eUiRgE0eviOrjGH87JEAjkCWoUnVXzGopZc4eRABFIroxP0ZeyUv3LtKj6iYa43Zg/T+kPwzDiPoTEqN1WAczWDked4ptviKnLUOG139uOUzyO2RwE19niU2XU3WMrH53YC6PwwkkgnpWPbASVXjANL6vYSNZPTc1TwhOts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ORy/y8Z1; arc=fail smtp.client-ip=52.101.65.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQtDQkFSqGhwtQsaHouCCLttPUscilMKrewe5yZrEnifPoMCXXWcQ36VNg45m08WK9jbLJPMVqiRbaPU5HlSuM3BHKc0yB2h5wY+k/DvVIL4hfhW5JqL1QKC9ecujqL0pFtBXLR0HtDTqlqhrFrefGSCMmLs/WcTofTxCSNjbLlVZh3rmBtBPugpHx/gSUhd9QYPBtXN+b5pQ398BTZK8pyFN+26wAAahzFXYhUZfvmw5OsOIZ2Ybdgzqzy5XszTOYryTldWVWsHkIG097i4+kaoQWkM8q8fv7DhfrpbtSE+8YKGfK8ArcODhY6Cx53DeKPw/zdgFqlZZMY7NuB2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=lXlKHViPdDJNBN+lm2itsSdzpgIgepwAihEikYGtFpI0Nu8p5onZY8pQxwyXvUl2Hh/fhrrbAf74UsSWROOsFbIug5hxbC+9dQszGippcVPHoDLkCJC5ty+8n3SoY99EsRBB83j72VrZHpTC/mMTVUt+f2zkkoGEVIlIArGoiWZFuqY5R2/Qlp4OaFomEgtmZOmJh6b+odO1jWPcHtp04+8++GXmH9rD9xSc5n6k9J5+2ngyQvVSMhhCtScfE3AeSyaz/gUpRLD5c398EclIA2S2N3g7CPUT6/VhNC7JSlWuj4YvQFoUVa7N+Jl8chc8TqYVRTvftLqgxmWdikPf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afEq9bHX/2s3KBTTklyPlyvAIAF9EeHEPeuOYA/bDc0=;
 b=ORy/y8Z1gRc3sQ/5M6XcKwuaVlwrF4ETiv4fIEumWF1+sp/Oc7wfjCxy3uCYWvZ6rSaPgjMDPpckylGmi57HD0rFhDUKOJaeA8GGpPF1hxufw+lSJDuv47weU0R4bV8h1q0+wC+yeomnBYz2rol5iVldfYwrmu1llpIu2UCWPLaQydQpkUW/Udg9FwboDV6BKbZLSW/xdUvBh/QymCRl9qoi/YpwzkzwGLpw30xB3CcZu4xwO7kD4HBYhPzEIk6nuUHYOpu+LEllAoqz5oKLm+3peWYSTRIQxdDdZFQSo4i2GkdRl0kYwIinb9FY54T6lwWNOItxVlrEy26Yn2ZafQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:25 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v5 01/13] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Sat, 23 Aug 2025 19:01:04 +0300
Message-ID: <20250823160116.3762730-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 2b58ee96-2ed8-4337-8bf4-08dde25e4fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gy+PzYtzEqjyyOKkMI2mNV3vV3qnpvw53h4+baZ8LS/KGiVt8I9hEqn2qgeo?=
 =?us-ascii?Q?6LzkgQg+AEwDltjNuAdSg3C4Td69a/vyxU2kKkLLoMxgrOqKDkY5n3mQ29sX?=
 =?us-ascii?Q?6a8sBlpbd0CnswPKGjMpIBZA99OgStqLYIpwPWAtcyCwH7Un35WFZ/meaWyJ?=
 =?us-ascii?Q?9hZFgmB93BcJhRcM91tbLCwDuOFC1qri3plpMH0Xf1SDHVSeBjW1jKUVCLyk?=
 =?us-ascii?Q?XVuaNTk2AE4tpTZFiYUxT/lCgmQ+etb/L+xvuojlZPFVhgNmMKBiiSljrfzs?=
 =?us-ascii?Q?vEQMsu8qycF/P4q9W1we1vFl3JziDXt7KnyemU1MBgX2tGKDxqvoZ8XKQkV1?=
 =?us-ascii?Q?L6f/YvsbQLy97eDTlKzICqjnb4u5sUuj7pLuPbdA0q4HemGE6tnBw0BKvbbM?=
 =?us-ascii?Q?TAR0AudyW0zLuMx62MEjQH1Ny+YPvqk6Ma5VmvIYiddfnv12BqZe2UZGKpTU?=
 =?us-ascii?Q?46NEexmzw2jixF3kDpFpDnCYBn+oL1Y2tVHgjSXxWMi+5zAGVGfh9tyWE8xb?=
 =?us-ascii?Q?GMVjj4v+PuiojG+EFJI31KDI/wuDv6aReVuVTWdsuMjEqjlAClrjIjX4IOeQ?=
 =?us-ascii?Q?Ob9OHiUFP6TNCWkPrgfey3bSCdB8/QPzB5XqxC/mVF+i2Uq/i55n11QHoAXX?=
 =?us-ascii?Q?XeAw/CK4JcpS0VDmZk2a33yaQDnDbwXTso7HCYUpLOZemBng6zbhH7GhEP+y?=
 =?us-ascii?Q?dyAVeprG3uPZss5UsEwEcuQBhr4dodzjBy4ftwpSJbdpKiBxbmftvufjDBqJ?=
 =?us-ascii?Q?CTyKc2Rnb2IPBG9k47gSuOaG0nHqGtD+nv/K5JiqvRa5EwBeB30CVniFC+V9?=
 =?us-ascii?Q?gmw8EQLGIiCGLLruPcabzLpm/23fNRDyruhxZ8FsxN7EfEy8KcYd3BTsaz7u?=
 =?us-ascii?Q?C/wlE7QTqDEI8YuvZ5396+zDjEbqGNcz70Hf5M2HFaA+Fqq3dvakKMyqvajq?=
 =?us-ascii?Q?1llOolBFONI3WwflGNx4GTuiuMX3eLqond7sniVry0r+YYFB8wYF+VgdWX0V?=
 =?us-ascii?Q?cvNkB7yuRQtHaZJM9Z/K86TGfmEDBZ5BPB+dTSy4mOdhnL63Mqc5ki8nz6vb?=
 =?us-ascii?Q?L5il6ehfgMn//hRMpTzQtKsei/C6SM2hXeRZMlJuTfrOXknBQepna0IF6USi?=
 =?us-ascii?Q?SelJyT7SSrKK6lsCK4A5Hq2QZ5VH/v4Wdbpt9djZ16u/oBr9wlBN1gGYp4Cj?=
 =?us-ascii?Q?JqTfETdsvrSPJp46ZECyGMoEVzVd8lDh1DlnpY6BSgJLR9m8sMVvL9jvbBEN?=
 =?us-ascii?Q?wNRzyUeKlG0Z5yIhq3y7S33voxZD9NZGyRXH+6Roru/7rhYUfgUtBDbzaEi6?=
 =?us-ascii?Q?ArIN6WbpWQdAvB45mteAILBGGLP6iNDGqp+9cvIEEq981uJ8VvPtEa2p5cmw?=
 =?us-ascii?Q?RIglaaewk3XkOI51C1dutHJntsdABEA4LMfdNeq1r9is4XHY2coY92xwj9oj?=
 =?us-ascii?Q?bhLrRkLKA1he37bHfWQZwOwKHrgihQFJuW/43bHKP5vUylVAVnZFlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IL8TqBN+ARdFtjAyTxwuGiFTQHSL7fs8+T6kvnvSsucZY9T6wpBfr4G2h2aD?=
 =?us-ascii?Q?t+x+7CW8fPP6IzKqFB7ZzY0+ENZ7jTeXBiooKJgN7yVfDoTbV/OUNZMmttvL?=
 =?us-ascii?Q?NvesDhgcmLhjfIPsO2Ke64py0u+56pOebKOxhBBQVR9JimTqN7gTPtOKh+x9?=
 =?us-ascii?Q?4fDNBE/qdMs90A7DqYEEZCLsf6MiOwVpC4HHJtCNwCXssxCPl0aboYGuaCW6?=
 =?us-ascii?Q?bBregL6u8tqMeonegOrkzMbhnBjhtl1x9f+Dphpl9eGYkkeC1BJwtQbpneG7?=
 =?us-ascii?Q?YAy/c9ZlOiTQUVWJHQiD2q+HB9LXDDn1ZrH1n8syHXS9z53DY9QZpT2OdNcI?=
 =?us-ascii?Q?3kFt2CwJYQj9zgSIuAm/xoiR56YHP4bq1GMtc3Y/BNCZmv6jLbV2FDp0TJIA?=
 =?us-ascii?Q?lniZ5A3gz/CotLQN4ogwSxNRqxJkLMPTtk9n74i9ixg0j3ylbrJdCvxdIwgx?=
 =?us-ascii?Q?pKTwKPe1WER9tWn2hcqAtXBO7F4L8KS774WrWDVzAOZxLQHeHlak5XltaN3z?=
 =?us-ascii?Q?YO7BNLEJFRA5ZGd0ypCMimtnXuM6U6v1lnTr/t0BjSrSpewT9/4k0WbYWUu+?=
 =?us-ascii?Q?zLSyV38HdeSXhkdNXs4/VoDgwIe0d4RV/p4b1CRq0vmICmsd63zhIGlp2JsQ?=
 =?us-ascii?Q?3I7jWKHwfSWsNhxYi0mYGFM8dVKoOlTqGSp1NTUWSy3mlaQRklQtjIEt/qKc?=
 =?us-ascii?Q?BF1iKd+FRCTI5sXBfIbu9HQfFjdn1b+I+OHiIHgOFg+k+S7uR9J6fAF1yXDv?=
 =?us-ascii?Q?RRQXL+Ig6s3unEsqagMm50pv4KhK49EjXK3+0pagvaKkPKbont7gpgD56pC2?=
 =?us-ascii?Q?IeNaZJhRPtfoCcT3TocKeSCGeIp2BbrmmMRkGikKmgS85R4M17QM3qIvbNu0?=
 =?us-ascii?Q?iZWSvLgRBWnSBDq4F2YciKRSA+On677l/z/jixD1SI5lSozH6Ze3kFgm2/IW?=
 =?us-ascii?Q?/7/hvBZUo6MfJLZEDM/1S0kTqF//SQkjh3+estTuCrWMVpKaO4OrZ87zMlYA?=
 =?us-ascii?Q?X9cqCWBcBM6+0+rHwpYYYxCuKVBdk0iqIydMvjnAt0CRGwoQiv5G7mpCpd2v?=
 =?us-ascii?Q?SguAHrXpGPEoJ7vrcFlUw5Q4ZmwzOgHrI1JinfYnhFPA8ZAEuISJ5dC6XPjM?=
 =?us-ascii?Q?ox+raYKG6okGP2fYQ5WTzWeajOmQik/7krMCvFl3adbRwVVRVcY9zMxOPznG?=
 =?us-ascii?Q?8xyHUYtCFrAlGIknzSBEnmbTFIuOdbxiXW/VOvLh5dwRV7XkOXS0JOUKw/pG?=
 =?us-ascii?Q?PZFk0VtDybtgp8RHcIuELHOIrKB3p3xZk6ai3F0NUj3HbkwBb+gcIXkIsfie?=
 =?us-ascii?Q?diJdVQbK4d4/JRPD4otJimpBeJwGRKzK2Ky4ZPFc0VyZGHuK4/yuIvcdXZJn?=
 =?us-ascii?Q?nheSxoXuUBizRRyGjr0MrlozQtZzpAqvHL/7dfOSDpChiDNgHqcDHv+X+DA/?=
 =?us-ascii?Q?jK70tlhU/HIyaPthKef7jHbPAFi4JZlMtP1lfB6eZbOYt00wGoufvUfM/lZi?=
 =?us-ascii?Q?bSO7IiCS9mi1zewxA2BkzFem3VvYDEN0Sq86kKAX1jNsMQQGzUCpZnn5kX6A?=
 =?us-ascii?Q?0tHAQWBemzrwrZUcsdIXqO7N5qFncrYuXRU81ze8hZVeuzYJw1xMLT1V6zwt?=
 =?us-ascii?Q?vk9spUgmOYTKChw4pZ7SnDA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b58ee96-2ed8-4337-8bf4-08dde25e4fd3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:25.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/iGKHJ7JzWn94pI4Cn+sqplNCHTbY65dXzVOAQmnmbXhIoixSdWJK+yJGteK6KWEz1/DWl3ZWeL8rntk+QFDHMiRX0CLQNpdUpnr/yD3WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.50.1



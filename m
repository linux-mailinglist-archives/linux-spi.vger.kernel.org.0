Return-Path: <linux-spi+bounces-10552-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26782BCE835
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C973C4E4788
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E978125F78F;
	Fri, 10 Oct 2025 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="RIow36d6"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276525C81F;
	Fri, 10 Oct 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129118; cv=fail; b=nyz2tzJB3rcbMee+fVzKv2qZ5VSNiGwpO5OyTc3mpBb7V7NCLqeZQdcfYviXqKlJFs74rIlbM6yQ9wr04gpFMfGVn4fco5FMtI3ci+nnwAbMCmAYVVilfF0lDqahUZ4Il2evbk11hxE7Kdq7VXecnjpCKIhrVsA1GN2z2hOxTQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129118; c=relaxed/simple;
	bh=obHIhFUcGxmWKO6movIYZRxfkEvNHpdj1r8QrGoJf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdLRFKIn84fDENEDTonX1f3cML3RamikkDXpJKMuUvjK/KBWDaharKenH5w/AE2G1DOAjMxQF44rKAen/JZJ1xLVa4PZFPtuYZ3NbFKj8H/PHmYRXzAb1orgV6Zj/BnrE0TcfGJMz4FcwOZ89AXudXDoPTfcC+7525ug8gW9osw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=RIow36d6; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edZwt49LZxReQT2AjHBdBpbw7Bsivjk997Q6tJvkFcql9RtBd93VE83uLiGufMlnmU7WO5aZXky8/LVcrsyaEnwAnfbxtQZPZmxsVeJdHmRZhSFz83XPe6jSYooYaF8BbodQ0b26FsJ/4qu+sgsmuigNbBs8/GWgQfdcz3T93kRuH/uRkGJ+RO2uAHzoqZgK2faDAAu1XkoOKw+YeiEJJwhoSqiw7ewtr6rmEIek6cLdwrTSaHobUVAWHTFlj/2bSH5McceTt3PuiKdeaoY0zvDoGarVyO+6h1q5Fyvw/zuTNo5yAutBHTLolOdH9ZFMDO2qk6AeCRHBskwUOrRI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=luM2n65+AQM8ugR/oSFlxq8W+UjHGlM4hwJpbdL9+GUsJocQfwIQPmyIXEX57Y5FgYG979OASR+rL3AlbH39OyBlEk2+VyNvohQFPzjEZMJB7YGhSZoSOE7Hp+cOjPblJywAysBtgwhCZ0sK4mc/MRkyX/fqmLmredIjCm8XvQpg9kRBq0PmGqOQEr99+oxSSV0hydxqZu/J073phKkqTGyH6mBZMGMbcZkokuUpE33H8qvq/edL9MkHkDVcjcSfawVTzjxHTV0goM7rzeDQAz31++XIDsiFdHuXTceKSWUGeBfT/yakogIl/lPXOI70Rwt4RMEBZmEBU0PbDrHmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=RIow36d6Q5j0j6ZI7RvYT6xHz0OyeV6yQWqlXEDnSOM6yJIEqK7uLYjpSOuRynEUQx4G7NGU9PqVtFQ7SHTkaNItJOcwtUInpEBwbCzOqFwR1BB48hmMB7Am3iI7QlCNc6Fs6Zy6FTN171LymV4UwWwHba9IUO5dJkP6+x4gOiajBJl+I7JzkGS03/iFz0XMr2BxjeFHX3f5BwZCqcS5bie9BtI17f+cSdrTpIu87V5+u/LoOaS4Uzjaua6Omsb7w0ygPAgfSNIF09mKZ1GzjSX3wjbR9yTlo2wNnW7oDSopn5X9kk18rvMNqmBa/hVG/l+feCQsoJATmZOrQpTikw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:11 +0000
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
Subject: [PATCH v9 02/15] spi: airoha: remove unnecessary restriction length
Date: Fri, 10 Oct 2025 23:44:47 +0300
Message-ID: <20251010204500.1625215-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eaeb00a-0cbf-47e7-a525-08de083de7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XxgksSKl+VrIq07WSBfiZZbnqaxfexTQGE8ZUWbl6CCZim5d0oSK0V/4AnAk?=
 =?us-ascii?Q?d/M5IJYBjzAZQZXf9fNOdz9jpb2hnD/VYP+Kc5eCAobjK6gOrATwqJgJSLbv?=
 =?us-ascii?Q?oa2zGwTfbetyozWeRlr2H+fKmslHV4Ut7PeC5i/k9I10cbNJybynBvXHqT1y?=
 =?us-ascii?Q?1VpX84d18QmUCSOV0AaQgQwpjbBBMnwVtPxh4v1lWBRd83+pTmlChCZ046lg?=
 =?us-ascii?Q?bagWkE5CZ4XZG+NG++qjjTsRAqRBj3Dix0byaINsP+a9dmxa/6FGVKh4JZu+?=
 =?us-ascii?Q?SiHSpkNXIyQCDYcfJ51aSEPK3UHaqZR7E0PIt9E9IhGqNLA2m6wvuSsGL7Fn?=
 =?us-ascii?Q?i1GFy3RERzYaFKhE5xXlr54csdsWwrXqh8A7BPJfAmP8eJ7gvy78ZIOrwnKt?=
 =?us-ascii?Q?BZgjL5t5GMvMKJaxGqEZkgWyjq3vEYD/D19xI/VovhoBg5ebFEmG6yfrSDyb?=
 =?us-ascii?Q?WXLoh3L/wB4RUojii3HevFAt+hBGZmbUYuVIIoEJu0cmvwjhjf6afh0W29DD?=
 =?us-ascii?Q?WliwLtgw3btXxUWEAlvrMIUZuWJ9NJ+DYjZOOQE02kPE7iAXU4I33c7ef5iS?=
 =?us-ascii?Q?3hv2Ok5YnsKgDeD8hwgu5gi0ZxKwBmorn9ygq97HJaVKFB/mWg7ApJwKLd2s?=
 =?us-ascii?Q?Zb9lc41km+/fUgiqOs9JtW1b17YCc//I0SxJfS3TnwQmRZ8cvtshKhC8VLa9?=
 =?us-ascii?Q?Jbl9U9+cdWpbo7FqmPIO5yPYS+sgBsKe8vgpE8ekNjfMPUuMOR7twb/2yP6S?=
 =?us-ascii?Q?jgCTej1PKEPa/u8imO9mzBr8xfr5DiL7+/fLRN0yl7p7UIjQKf4KcjGd0n+6?=
 =?us-ascii?Q?TwRL6urtJoJWJ+nUxiJA8KmHsATBDSBaxFnj3YnhFsdY+vCWpnbA/E1pQpe9?=
 =?us-ascii?Q?1iH3pgv83AwJuuIPp8AHewuqG6Pqo4/TLKGVABMIbgyl1q5nfURK2NX1T+nv?=
 =?us-ascii?Q?f/3lYeo9Rd1t3VQK1hMy10eR2ub3vIk8oVJ0P24eC4htNjHdYW+tP2y9yZ5k?=
 =?us-ascii?Q?eLUWbKqaOrp+3YZ1q8miXqbL2NDRHAKmpBorvy0FddAQQE10X5m5afrHE0BE?=
 =?us-ascii?Q?xahIczS1rRIx3sJvFwnM8PkRW8TVwyB+19qEI+u2MYGMYLnvkb0PP7xYo2Jg?=
 =?us-ascii?Q?BLUBrafEQrq3Cho5/tARv+4kTeUReQK0PBnBawMQbbqP9kV1RgO78mzMXkBy?=
 =?us-ascii?Q?UlNCaz4bcetL79juwISC7QhB5+BMtqR1ClLhagEVSl0feKUvsI2ZHNTafiVz?=
 =?us-ascii?Q?tdsaMyvhvIX0f8z0pJe6qxAy9hcNzHI/1vyuRaL3GFvKD9L/d2nGRv0C+GdV?=
 =?us-ascii?Q?jRGud9rX04rj5qPIsKc+pwqc6UdSPWf03lQ2hc7DGl2sXDfti6PSzrZqQ4sK?=
 =?us-ascii?Q?2Inrit3LZ6f6vwYHnCEXBhsP6bLdkt1b8FkntCJ1XYrpMPU7ta6kOH/QoD5o?=
 =?us-ascii?Q?SbQCWKealpmCsUxa8DF6UYtvhO/I5ddjp4g2KOlWDIVWGqWVfdp0HMQfJx1r?=
 =?us-ascii?Q?DvBnizThfS38tze/z18agwA2halv5PIw3sQlNM1JNDTlgeO7YwHOGydS5w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0sQycOEOT50H1GWmSmuAGR8UbCaTMlqCaaPhDwo2VRgi5GmZUl+G4amgHVD8?=
 =?us-ascii?Q?Tq7lRrUBQr0SIxzaIThETLWbJegywOD0sIdEZEYqmnx9QOGdFUlrOOvnOSCZ?=
 =?us-ascii?Q?rvP6c3Ie7+yZuHBnjLtWz6ta89guNxMUHw5ZtrHKy2rkTHVviWzNDIYkXu3v?=
 =?us-ascii?Q?8ppvFHPAGP40R4QuXlJ/yWZFoyfi6k9dEyZZsrSkPdVl5UNIe1ipPjpsLDrR?=
 =?us-ascii?Q?mGiY1DNru8XSXQemqdz6ZRK3Z7O6vxSj8A6jpMofB6ZG7lwoDOrMQXvSQZTu?=
 =?us-ascii?Q?lRvNatBgeTzlq5eLARWgTpExRcrT7VIbUNh2msro+uOq9HrTxQypZjakIsqf?=
 =?us-ascii?Q?o+gBiSNuiF7KIFvKOPde5PYW4yE6CjCbHTkp9AzgtgsjZmRGWxNFCbnKnFtr?=
 =?us-ascii?Q?/UP0XdcDq5J13AlhSgSKX8sBcXV+Aur+Dpy/J9oDUbX0U/qvwet13AfZAyCV?=
 =?us-ascii?Q?hVFEGhwToSrLMK5WOqxEKHsuWHC76PxKwxNE69aeMxPL9D0Vc7JRbzRYo1fW?=
 =?us-ascii?Q?dPd3lrYfcu/Xj3z+ri9LhQhEBRunL/VqKbHaISuVqfdOaRiMhodjDJZC8MkI?=
 =?us-ascii?Q?4sJZMvLrnexVzLGsuxw/yQkwNs6uB+KSLqCfZLU/61ZfCQ2PYoJxBAD8ufP5?=
 =?us-ascii?Q?9n5c9OOTCZq5K2rogRrvkDxvra44hbqDhhqB9iF+PRBZR5e0LQqVhFHtkzP6?=
 =?us-ascii?Q?U+lEiWWk2kKkZ2g3s5zzEClqXpik83MTnkfkaSRY9N+2ycLWNNx2ByC0c8P6?=
 =?us-ascii?Q?9Zl802Ce1WUubAACvP452W7mCGRVwd13sKyVfNBIO0H3+HRRtD42aFvvLF2k?=
 =?us-ascii?Q?O/SYZdA29NOuxqppH+6AxVidT6oQF6UosHWLmSvGcdzPXp7u2qY0qY2iQz24?=
 =?us-ascii?Q?pmGXvnEDweTpd3rBIW59cIHi3SqiZA5XR15e52DxzV0IhNYnaZt6Uo6ADA0x?=
 =?us-ascii?Q?gm62jTu1SYtOQtcPiBarR81mmTHeE8UGJ+bO7Kp8Kw+A12oKqEY0XLo7Fcon?=
 =?us-ascii?Q?IPnNBih8reijNBe8EUfhIvrXsgj3xcXlhoYLYZ4Xg0Lw3A7JpUugEDMK8CMw?=
 =?us-ascii?Q?dso0MT4qHWljB3jSjjYrg6U5lRh4PO6DLz/ffbUt1Xrjx435lVLMt9GKNsi7?=
 =?us-ascii?Q?OXn6FzUOERPQKs3BCMGQhvPrj0/ZcvQ9owRhaELmms80f8VbkUDgPbO6BRKt?=
 =?us-ascii?Q?zKbm7kG9itENlT8Ub8IvGDypf+4OsuUsXiCZVYk/iI/1Ky2TrHopQlT/oQ61?=
 =?us-ascii?Q?K0t4orX/s0Njp/dgOmjfjI4uIF7YNgfTGGCQue84s303T2hSpWCnmrSED+Jg?=
 =?us-ascii?Q?VKM93g8gcummA+aGpi5FUows3+O9DICe58yowqyog5t55R471/2eoNdye8l/?=
 =?us-ascii?Q?ooMK7dD+xxERf7/4YP5y4DFcVkUnFH4DmFlOzjtGXAs+eflIikIpwFMYc32w?=
 =?us-ascii?Q?eMYdO6xBxJNpKCyV9mywjtDomCtLxGjvEFdVSr662MGpPa6NNVXPVXLr58/6?=
 =?us-ascii?Q?7NBHMSVMsQLUTJaZdKGKyIbeVIdqDLqm/JyqfVCBpjn5dqLVqGYdttIRve86?=
 =?us-ascii?Q?ww9VnjG3kBRD7dGOowJjfp3RiGR2aCFsBDBAfFoWTTvOGyBitZ8p9oyBT+iH?=
 =?us-ascii?Q?qW8TfrJF6CX2F3Nl0XeNdVo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaeb00a-0cbf-47e7-a525-08de083de7d4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:11.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDS+5hAzF4Zl5YL94Ib2fdGH6+pTrEaTqAHOj8pcf8rRV9KnMmcTG1MEATn3QpVVT2tscg8fxDcpU/fNAnRpsdB/jzVcf+utsXcL4NzduRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 043a03cd90a1..bcc464ec9c61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -579,13 +579,6 @@ static int airoha_snand_adjust_op_size(struct spi_mem *mem,
 
 		if (op->data.nbytes > max_len)
 			op->data.nbytes = max_len;
-	} else {
-		max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-		if (max_len >= 160)
-			return -EOPNOTSUPP;
-
-		if (op->data.nbytes > 160 - max_len)
-			op->data.nbytes = 160 - max_len;
 	}
 
 	return 0;
-- 
2.51.0



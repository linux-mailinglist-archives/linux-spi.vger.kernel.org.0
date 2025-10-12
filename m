Return-Path: <linux-spi+bounces-10581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5DDBD01FD
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7D13BCD1D
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048CF277008;
	Sun, 12 Oct 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="1tdqjRG4"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A45276054;
	Sun, 12 Oct 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271456; cv=fail; b=CqcBEpphZI3sS/Pqq4uUryTKBqZdyIbsDZW4WuNG2B6c3y7OxLwtWp+22DMPN1qG9EPL+ftrfFc1Q6nFYSxPn202eYgltxKONPkJiAZpsJfIjTldZ/U+ifrvYj2wdklAdicqHe9lwSmbLHl1Atj117ylO8hVNggV8Ot40YPjbrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271456; c=relaxed/simple;
	bh=FMrVF5Vv1XqxxA6IzimgjaqpoFwdt1ebmex3NhH4hkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fjgBZOsoEp8ZDoyRuVjxaivJ18rWgcctrkNzfbEk32nx/7R5dNiMejGmSd6OjbVhILTw0XiM6ptGO9KDxN4X+BrY+H1H82+bmPaCj5mh0pdaARzrex3YjDw6z4glZCN9SZKLpr9pzSIfbW1dcdLG7ExgXgzAc9TTp6e4Y7cso3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=1tdqjRG4; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtM2A5QmLUkXfPR7Fqj/UIyf1zRKrYFyWdzQMigTMX220Qbqn6MyU7jSVKz5xq7VK40F/EGFXHl/NM4irEIyX8DTi8Qd+Qqdvs0hA4EnoaZTZV6ITJjWQLpkI254EBloVUtAh0nnREZ7iOduvyGK6urqO2Av31VMxOY8yp362tNZ73Vtv5ynT7zza+HGHTAPGZru1xrMvuOME4y/AFS+KcWOZQIJt00FN4nRFVRO5vgrS4b+BmSLspnIuaYIrW5sKLRKUngSU8WY9a3UUsEkx+SX9DjETxNcjw6g3epwx0/OReIjcKsIR0I0RpVUJGfSk5uODZmLXfJO7kxT/1s4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvX94nIt6Ushebm+TMBumijXPGW+xCDBR3BCYJgUfgw=;
 b=e8JVVZV/MCrt5BENsrnSASub40eHJnN+56P3EYdK+ISUQuNLZsMJUvlF4zoTCV5iU70eeDyEHCTXO68XEt8H2X1tFeQ8WTSTpqkc+GozUJ8rS6O/6vrIqNewrIPoLVBGezvH7HzbjQjpBhzethuXJR1heWT33knah9EvpqjEku3nkoHfAuoyxdUO2J7/R1wyForM7QGipvi5OdnP2ZPgvKB09zSqudxGyWAyg3cSN7oZsgM5WP2ETaxoKYo/K3i16cwdMEV33FN72h/GKd9j6Y1t9ZRA/GJp3jCq/3bB1/ROPpt+fz3gXqQUzg0bPeWJq6Xe8JY9BZrg+PwlNaM/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvX94nIt6Ushebm+TMBumijXPGW+xCDBR3BCYJgUfgw=;
 b=1tdqjRG4fAEgfQr2FoQUbqfhz8F4iD/aACGZZmt0MZhw3ohYqajkAwQ9a5LkTRmu7Tl7zw+fkuCWWuKc0RzuTym0dNu3fC1+eNJruMkCl42lHFnC6t8t0DMbILrCtIAHoiH7UgE0L6DPL3hbUO2P3MPWgPlc0ihMPEd0eJNy6zkfg214yEwxKscgmIi5qBb/yo6f2BjjnFIl9L7or3VsHr3F192xrVHZkVazehVPXoBeRR3Gzb3AnHoRo9b5xoqxnWKv4u6RW3lg9LRqtDVVAdIVeZXWDovf99pEexasMoaNzlTdxXo+dYsHQPLIkPMqUmdxA+Lcl6JNz8Qh16kOCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:27 +0000
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
Subject: [PATCH v10 06/16] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Sun, 12 Oct 2025 15:16:57 +0300
Message-ID: <20251012121707.2296160-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2f9563-045c-478e-8d34-08de09894ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ldyRpyiJWBm0b/vaLUM8Lnp8zeUv+jYKW9FYJopA6OCCKr8jLInbDJMrY3el?=
 =?us-ascii?Q?rUsS5VbMq+gDjLj8rkQLfOqb+OHKB7i/uBpnVEu3tqJlreb9l8EfDdBxsJ0K?=
 =?us-ascii?Q?savsYBgsowlRdVX48y4riwoDj+iqIa9w3mqxvnX9NqZJbMI9jxoM9Rx0l2qT?=
 =?us-ascii?Q?c7Zs0AlKUydop0th+O5OHqD2x5Bl2d4/xOaSWSpm6NO88biJzQr9HZKY1xDk?=
 =?us-ascii?Q?/pG0EcwpsMOZ/lts0m/4p+czLNXCTvwW8Uc43gQgODhg7PJ7qrf6pVyIv3M6?=
 =?us-ascii?Q?ch8Mnf6wrKj89zkuPsDZ514mjuxCm5KSmgjgZbAN5Wj6OYrLuXhX00Eon4z5?=
 =?us-ascii?Q?yvs2cTwtTr9yeaXumbhWpO8LifwuCeD4MYMY/JBO4c7SOcK6t2UJ3FJlEeIM?=
 =?us-ascii?Q?WhR5bmSllgDhz7cbQ65jG5QAjF4SyxdQ5gOJwQfCSSOi1Rigbg4JUtig6jdK?=
 =?us-ascii?Q?AD4jJgCT1K06JtNq/KBN+lyWtHgIU/c8jOi/Eim+Se4uEfH+xqlUixQhwCW4?=
 =?us-ascii?Q?RxzAMCc7+j8/YGw9MYU0c5AmqOJWmYvRO4DKULRS5bjVgvz0fQd7TWSVF6gU?=
 =?us-ascii?Q?+jAoFHqFlBZI8UrObOYpPdSfyfO7sj8kLsQLafFCUMOohqLU+k1i8T8h0R/L?=
 =?us-ascii?Q?hY1G90b4IGzS/jsoWIaa9I34dJ/iJORcXeRQkEbixgyJtylSXKc2yutBJYYN?=
 =?us-ascii?Q?qb8GaeUaS/ORL7VH0na9J43+ySsCDywBr1zccyMaPeCGTdnvbkF9BtmTklty?=
 =?us-ascii?Q?x4tLJ8px/bJ45Mr2GZZvS2swYFbDpbXKJCD+DOFXOOvoYrhv2Uib9vSC7xHj?=
 =?us-ascii?Q?hMjEvigbZgCitAZBO5bUj8iELKXpO6/aKM2PIl0gXJG/WSiueLoSgwVtTvN+?=
 =?us-ascii?Q?4LcAjnUClNHV9/dOISNZaMzM9L3AqmI1vo3H37JuuebBfz63mz8s84YTQKIU?=
 =?us-ascii?Q?m5D6wKY5kSnhqTZvSTlQ2gmv5J7ZGVIZfYFmiPVjfjbom8JilkGj2Ub/H0B8?=
 =?us-ascii?Q?59lQxGLLLXENnV2T2DX6zKthZNDsy3IuLAxwADXtLj0ycg0ZxemKCLRkgFxj?=
 =?us-ascii?Q?xRch36MTpFBxMLo9Xou7Xa6vHxVC6IxPshddKsR3+8pVyNVNNko5o3hii15E?=
 =?us-ascii?Q?hSy8EFZ7XBcp05XPnE5M+349aiLnFxhQB9skqojyp2CXo/JSRpyNZ1sXCJt/?=
 =?us-ascii?Q?cXG7KsRDKQJKUENLPBmPB405pPfe+g69rPAk1123Up/0R5QbDl06JdXbSfbe?=
 =?us-ascii?Q?otz0DkuPMlBcr2l+Y7nEg8UY/XTjvnKEZd2iZfaTUbpiLbIVeBNZYYFcvOxN?=
 =?us-ascii?Q?bTiLk0ac7BbUeJHikrExaBqHPUvhBpgqqNlglei+xnAa9V3oH7YTz0u+taNI?=
 =?us-ascii?Q?Pk4VaWILJEBvwlbFa9JGdKAQDS2f1g/PkOjWa3MH+bfxPURq1mLpXIdXC8fN?=
 =?us-ascii?Q?QACz8v0DrcryIoKw/tiSU743xkR2+5GnB4ne0W3FcTHk4Td0MW2g61JrP27f?=
 =?us-ascii?Q?qBmG3bbGmiTUZ+EYf2GE3QM8v8zHmjFkTubCX9PKofgE7C+iaRUi4lkzRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pD6WV8fTlofk5Uq3bIXLzaHYUq/HqXY1sDH53RFJczqf1JMEYEejICFKkx77?=
 =?us-ascii?Q?zeNp2RKao590n+bs4qsQSdszvmMJHAWH1IJ8Ac7doqfVrMfSPM1KRKTvFPcU?=
 =?us-ascii?Q?q0Q00cSCFAoUzcU+4sSkodGP3eqK4sFvCDAnSa3G3JWPL1GcStaL8QUQVcMy?=
 =?us-ascii?Q?Br1FG56gI/hCzALAkHA7gChwl/hvy1cQVgJBQQ967MtwrC0ZHZlsAqxxUFGg?=
 =?us-ascii?Q?zl6nnow+oLIV/iDjvIRZnRqi24zvBd0OmOmUMPVTpKS+NS3hQ4lId0DLyp8B?=
 =?us-ascii?Q?wI21nTIhzvlBY7G8MAJ277ZDKh60VCVrwKLcHx0Hm1Dv813VRHhPH3UcIvsZ?=
 =?us-ascii?Q?1qXruG7xf5rv7HceZFXVXaNXDN80j+PDMYEtqZtw9nmvOyU2n96zQLAbzp3y?=
 =?us-ascii?Q?Np8mM0dLo9GRu9+Ny5m4BUl4GPvHNC60ssT7Yv9DbOXf+Lu3RHdxHBF3QJYP?=
 =?us-ascii?Q?tIR6mDwFHZOGlVr0GjYHfg5/T/91TZnYn08vvmb6Wel3978OH7MAlI9OPnjP?=
 =?us-ascii?Q?3ZThOXaCN98AZz4JcyMLXx0KphXkvamLj+R01mYVxPaUm8eYBz0LyKmel9wd?=
 =?us-ascii?Q?vf6AFmBDMj5P7BbjIiD6Wdo+Iu2sXIDg5yS5lEIeW66i9KPh4G/ef0x/vpZB?=
 =?us-ascii?Q?B5QKsHuTYZBxzPzvhVkWYG0QbsabH1qACaMZFC1f0/mWEGyiH5kOLVoE0+gh?=
 =?us-ascii?Q?xcKsaQiNM2Vt8OS8XpR+tt5L+4EnHGGpOtz5RzIyNR8BOyn9432A1qrOwZ2P?=
 =?us-ascii?Q?u+ShIbOMy1fXw+j1jBTFSJsikBg5qCmNT8mnFRRt7iJzf4UVZ9c4gS0RnVqt?=
 =?us-ascii?Q?tIW/fbDOx0r9tRYvVDOaX0QBCr7GM3cyZ1GTlslFrKo8J7ERsnNEAIAuHgv6?=
 =?us-ascii?Q?BV9g0qgJjeM2cvFumO5EzQr2qafhtBf0DQs7kkB7IeQGMmzsNNlrHI63/4cU?=
 =?us-ascii?Q?e6U/6vZbO6bCxmAW6i6VklHAqZY0aNla8YHIkcbUI7YXcedaskS9jAd/JUt8?=
 =?us-ascii?Q?4MsEE3cC4StINc8fkpaWmNd395b51ux0MWQYlVrEdnR7e1il2cG7/Md7rnEd?=
 =?us-ascii?Q?tSS+xQMeO8TY66+u1eqyXpaTivtQe2yaZFnStNGQHrg0gfNKph9e+NgLdvK0?=
 =?us-ascii?Q?3abOdlEMwiLZjZP06cg8tPIU6IfuPkSzNcBc9GO4l3Y2At6NMrq5sKUtPGry?=
 =?us-ascii?Q?SMAtRl3Tl/IK7QdIAH3SdH6zEeTIxupBJlB8dZWkUDSWaf6pgulEr1MCqFV1?=
 =?us-ascii?Q?GkwTaW1sMjF/iJ9VVU65gVzw1zJuqf3vtfpjVWNWjzvvzOvTmL75cS7H/svM?=
 =?us-ascii?Q?6+OiQpGleSlMLxGT+jJYfF0+q6uqPPNl04d0kljtkoWK7UGZV1b6IWWMPD4u?=
 =?us-ascii?Q?JqyJQmtpJOhJn3JpTD8CZdfIxajw74TzalboF6wrljBriwaedZd65C6bD14Y?=
 =?us-ascii?Q?OTYd0K/RVf+YpmRmUNe1JAGEGIg8irBhzGmS47hko1AVy6oq4c/jpnInxA8b?=
 =?us-ascii?Q?V+ARVbmBh5O7Q20ZZdahsc9T9aWB6CgNDcZeIMEE6mF0nPw5Mz577KlaxDQO?=
 =?us-ascii?Q?njmiDe/nBbJsdujPS428vNjWt5xeB6dBPv5SqmBs8oWWVnctgj7qlyfNf9sf?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2f9563-045c-478e-8d34-08de09894ee1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:27.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsWMeQgvej352Y9zXBA4SBF9c9M8aumYOcWlEgeQRzHJcnBGF4SBw9AF8FGC0H8HH2s2z4vWumVP3p4JXfwTXVp9b95uNYrpSrbw41mixY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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



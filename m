Return-Path: <linux-spi+bounces-5136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CC993E83
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 07:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498381F22B80
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC02905;
	Tue,  8 Oct 2024 05:57:20 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2113.outbound.protection.outlook.com [40.107.222.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC913C9CB;
	Tue,  8 Oct 2024 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367040; cv=fail; b=QdZXtfSVEbmJZHplO7GJmnHWtmR6dxtc39CETCUokvKwTp/rZcsroS2siTMam8RLxa3vYcACe/G5I4AVnA0fFlAZTpBtUyHVRfRzpY2f0kw02EZO3+onsyITlZmOLiLDpJicCdw10+mYrFgIBHkJQaWhQSnggwayFi83meQGLy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367040; c=relaxed/simple;
	bh=i8w/Dyh9tVTikvPbJ19XBh2oTskZ5ZftrHT6kT6LYuc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tDozzojklam453AJod1eMuqeY6sjoQ8FiKBV3gwf4UFkitk8lT4KRdCa3avOzVehRq/ZSaLbxto7XC+DWHo+EOFDh6JltiukpZgBAqmlo2OH4lJ8X26fcAzwWcPqFZWuNSOAYh3x48mHbxhq92KCLn9+87uYPuS0kPBvlvIKwZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElH1XcvwQFGj44oXAc3/5/sjzp78NcgMAgU6E8Tt74y8E2TTSkZ7K/LWuRyx+IZCMaO5pDQ+sc3RcdRduZIChYewwerEXnz30pICdQeQoh4CllNyW2h70Gc+xqXAdGBJa3g7MM7s0hLRRkxYgopzsaR/eioK4CPjPPu2IulHveK7WGU/Csz4YjFCB+L5CpGocrfgfKu5rSVfkcVIusrqBn917CYfhyLi2mTRhIN+PfzjxWRhycfCjsH3CHjjitvu/W7cjXo4EbgF2YXwumUZWya7D73SPbzftIIJtPCc377C0k3/dn14qXsC7SPD+3s4twfKWGrN2Up5F9yoBgMqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDHud8V6gfHmEaYjUFPqA5ILVZrwi3wVT53QEESuPJg=;
 b=Z1irsGv9YcurLq7wnFriAygBC3j7Xz7G+Mc2/Mq5fYFcGl8gYy7N+MdA+FT+Z0Iyl5qOa40DTkHHTh0Tqy6cjlY5FMp/rQkMqm8xGyME8elstFGjp0VcJMCwOAVt7ANt6JHFv6dhRi/UcRbKG57CiBZAeibujpw0i5TQ1dw4K3adv65L0U1RBgWvMhwe29Fq2x18hyIbhL+kFKIksj8AtujQRIWNIhJfFo/QvZBWcw9rRsxpxMQzIBgF75JAXCAgJMGAz16+xKUJ/emNXysz238gDzfNgrM9VtMMAKtgN/uXALWk8yOV/2eUOe3J2cMgaX4YU8L2z7dJWglHEvZ/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB2160.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:57:14 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:57:14 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: olteanv@gmail.com,
	broonie@kernel.org,
	frank.li@nxp.com,
	shawnguo@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Fix Sparse warnings
Date: Tue,  8 Oct 2024 11:25:44 +0530
Message-ID: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN2P287MB2160:EE_
X-MS-Office365-Filtering-Correlation-Id: cf665030-0c95-4f25-26f9-08dce75e0f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7F5Hhrozh9dEeQ7irQYZmcp5JgfX0p71a3AMYgbwq9Y3NppCLlwwySknOlf5?=
 =?us-ascii?Q?EBR+e454meXyN87ZQv9ncOEQLGulZUz1/3WGA+Vvgd+tS7BKtoklodqWzXAy?=
 =?us-ascii?Q?D0sPeEDt0ZE10YFSxdvPep6LdwgMd/M7lN7+HNrwmeyqZk/JT46FhlDnFLAj?=
 =?us-ascii?Q?1uDCImoZgdyxJFZqc7qOofeB9J66u77yl4ged+CdsS1+x0ExIZH3O1ldGEzl?=
 =?us-ascii?Q?ml2ajQ4BBzUecauVU518xdj5udXkeAbb5YczfyhgYPBSn5JHdGoSAHhhCA4u?=
 =?us-ascii?Q?n4Ugjj3iOtkwu+kPWY13c9ofcd6fM9iZdoMIrAU5hvECMUZ0BW/Vpt+7vzAR?=
 =?us-ascii?Q?MMCMOixR6ZaO4sowExP7pkfb6VmY6/kMNxrFDi9DcsFKBw3TiLR5FcEKXZ74?=
 =?us-ascii?Q?SQQ4w3LkvAoUyzbNqvZTxuoHp8g/BJQ94xFFEYnycnBoLkqZCHwiEK+xnBa/?=
 =?us-ascii?Q?N4iEEQBLcgmP7yDDybUBw+K1HQCfP6hTQCTxNFW9vs4+d2o3912uSj/Xz20R?=
 =?us-ascii?Q?8woyMJ5/SKpTFYkztPlWuJmT930LTeoGXpVoTjTz156ZkEZ/YTI7mECvvtHx?=
 =?us-ascii?Q?thSIB7XJ9IuvW8Jnoy5Cs8sNMIw9BKDuiP92xamunY5nnQUnYGCDSamA6O3Y?=
 =?us-ascii?Q?PIlIbVUjhJdMKII90DseeGZvRXhq4zhW/sZTOMNlKLzzmcagtWlgonuxOZzY?=
 =?us-ascii?Q?gi+2Vo2xlh7BDFGEi4ZMsIqadGfCOXUrHyaxn+AOPhv/4uPDx3HZaBlogRjT?=
 =?us-ascii?Q?Yi91kknRNlMqqu6dtSncCtrHCQF39hjUh0yfLWJI01o+EMJroN04ESpGHnMG?=
 =?us-ascii?Q?K2nE8grqgSgiN/RuWk93J7SQTDdN74JOejiJedobRn21hmHKwCw5pNT2QG0N?=
 =?us-ascii?Q?f0JP06p4e5iJPptYMiJgvSY3lG3X+fPUbueqOPui4ec5N2GzybzeU2wLEJph?=
 =?us-ascii?Q?82epUpyGkEahpDQhqNDyVnkY+ozByHi8E5+95+DaqTsI3Bi8h9EK/+US2j9h?=
 =?us-ascii?Q?q50MyvEtyBd3TIiD7wN9NPWDGCyCLTX2ayJRI4uWSliuvV/lkLTHLdOsweSA?=
 =?us-ascii?Q?ldun5loOfzI0Mn4wUyMzSPWSp6v9nL/3JiiQdnC3/hyOCXitclk0IPgRz4iV?=
 =?us-ascii?Q?hSRkxCPQDpNUf2+VmrgGWTahLNcKZbQiKg25BsHi9bmfEStj9ZEh/yuj4Brc?=
 =?us-ascii?Q?3E031H0OEI+bT6Yohy3INMtLZ/wc6HTJjhK1xojD4Ya1kYcRkhDnHYL1g9n8?=
 =?us-ascii?Q?vskJIaXgIq8mN1kKKOXruplM2KdVUgPTGnbxUaJh0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/amdVZV0GpluQ87gCKz3PWA8wnB5KC2igUHcxWH6eqwRa3Xj/pLkp7EjaBlK?=
 =?us-ascii?Q?bAUNIPryhsNq5Pwayi9slZ5Ib+5mMNAHfFXXzvNqnDTSPZPsW8K+93jwrpxI?=
 =?us-ascii?Q?8hsdtnOoXorPMVtsBozLO+JHX9W11fJQPbdOO3H4EsUQ2WjnL7LyqLcn/hWg?=
 =?us-ascii?Q?0dXZ8XsYexTSQ2iXFr0S8+TMCvKIf+ZxpKtnv3+hVurSIIZ0lrPo4slCeOYI?=
 =?us-ascii?Q?dk68o85bZSF+fTDbrtiGqszL/K+X6B/DIAP5LQDxU1ORTL76Cqawim8JBz0i?=
 =?us-ascii?Q?R2ucuJejHrbdzhNbYv2YPQPgqZBfRxjRam3EePbEbZUZAvTRu0VAlFNs/x3j?=
 =?us-ascii?Q?E94FLR3069f1khrYLF6SyLYIdlzGwwwlV/7MD36jG9btASBTULob8prCe5WE?=
 =?us-ascii?Q?Qhqu4hMWHEBoYAbj+PrjYVt9PQhUBEt7BUBF8TSP7AjdWq8on/9ZfI8VWUd7?=
 =?us-ascii?Q?UjDh0DJznJHCFb/DCAJpZme5gG0+snAwjp/eKUs3rrOkbnjPa6Od6B4/zGwj?=
 =?us-ascii?Q?u/jL5EQbCck/aAudxkO3Q3j55bvQExeHXBJrhRS4J7RtVGQ4RvNtZ8ZmNwnH?=
 =?us-ascii?Q?2jaWLbDsI0Zfz44dY58w959xboDOp6wr4G7iCOtTHzSfmnIm11tkLoGQoEO+?=
 =?us-ascii?Q?C0Pv1YjqIrDXSmJEEaP3ViEqtbOAX3rIbVdGKsZRzTXmc6SPEh+HIKraw/Py?=
 =?us-ascii?Q?81U0n1/dFfpN+M+t9FaSMjFItxe8uKrmAHESM1Eeuhr+ztBVb4KYZZKpWvjD?=
 =?us-ascii?Q?pnhLKzqe0KJRz5IV+n40pxOUEyeMRzKs0gdsC8m7aWDUlD16bEt3uDHC80yM?=
 =?us-ascii?Q?SCSC2N0y00S9jUodkvIN5gEcZVNOk1F3aEAezEWjccTWsveT+c0gV3Mr5R79?=
 =?us-ascii?Q?tcbaNnTSlo7u0coVtVp6Lf9Ml/Xq4oreym9DhAld15ZjTsDze/k3EQH4OSFC?=
 =?us-ascii?Q?Wmz4XgEm7DY/r0UTZdt0fFkZ3+flrObubKPZYtGGlTzTKxYgX44l0pCd6Veo?=
 =?us-ascii?Q?mAxOTQ5n5cXpLMCIl/D763SU8vGppTseJEyETOa5D+aGilGCx/0OaXJ9kA/q?=
 =?us-ascii?Q?dxLNOEVZ4mq0CgRRTNnzPk22EXN/G8tg9RgXnkSIY2gUJKKUrnQ7OBG63Jqq?=
 =?us-ascii?Q?qHyXGNrW91D9H6bAD3w0YkwleWKYp9JvBg3tf47h2zBMcTXn6pvKzxp50slK?=
 =?us-ascii?Q?qBl3WjpBBALpNWAbKyxJfq8MwdFLk3qUUpGG9DSeYVQwI0PEXkgVQEU0iXeS?=
 =?us-ascii?Q?9sMM/SWHEcYpuCJcjyqcgoFE4bTS36RP7hr344N/YVw4uoDXtWM1XpD3VJWR?=
 =?us-ascii?Q?MIXtXWwnvBJFVAGXRCsbfUTMGeFHgcL0/e5GLePpq5XDE9XuS5QjRUmD7rkW?=
 =?us-ascii?Q?0ajyqG982/SWszD0mfR1MulJnRVQTlaAE0Ssza69yPgj6nEFoQdAS62fLHdV?=
 =?us-ascii?Q?zm6oZf4eTbSsqlpuHGd+By6LkcEzk6S59NQEJCQDhktP8TzMjtYdxbgPrpYQ?=
 =?us-ascii?Q?aNwMd0vEAOi70t6VxRR1I3kog71z7v7nRypoOVWXGyI6qD05hrTNXDzPA3ET?=
 =?us-ascii?Q?wOwzjMvdI3nC9jpe1PJcJ5aCWddq7BDl61CZQn6a4nZV/GoGU2WfRQjjFuHi?=
 =?us-ascii?Q?0hqlhlmyCOp+bd2bTr9fyicsV76s3z9ucD0Tco8eMhVx?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: cf665030-0c95-4f25-26f9-08dce75e0f20
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:57:14.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlK8uxHublLEgGC0kqfgEStZyjuMZig8BE0ywURuYNv1hZO0R1kTNjUK5TnOilVjV8RrJMV5Dqn01yU0PBJ96AysHjv1Uln3Y9oiLkjFoDS7JKOfePN6PfeUNaB2xjip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2160

Change in v2:

in patch 2/2:
	- Use ioread32be instead of readl
	- Use iowrite32be instead of writel

Note: Drop 2 patches(patch 2/4 & 4/4) from the last version
link to v1: https://lore.kernel.org/linux-spi/20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io/T/#t

Hardevsinh Palaniya (2):
  spi: spi-fsl-dspi: Fix casting warnings
  spi: spi-imx: Fix casting warnings

 drivers/spi/spi-fsl-dspi.c | 8 ++++----
 drivers/spi/spi-imx.c      | 5 ++---
 2 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.43.0



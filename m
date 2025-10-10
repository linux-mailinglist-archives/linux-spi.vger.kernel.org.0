Return-Path: <linux-spi+bounces-10562-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B7BCE892
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85272188A3E3
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23503043CA;
	Fri, 10 Oct 2025 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="vJuEUkv8"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020089.outbound.protection.outlook.com [52.101.84.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A68303CA3;
	Fri, 10 Oct 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129135; cv=fail; b=jm2mU6R2Ly/DYah7sxSebxG9POwzmOu/acFfJhis0VgxsAkofworT/lVIM24lCkqScG/bZiKEeBcBMcNZPVxN9CCbDCDrPPvZMqKWoy1UDQFIeanZRIcH8WA/fd8MMEQ9FqXogTSjQ/YUPtbEl6HaTd/HCi3BQwx+8bRr3MEA88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129135; c=relaxed/simple;
	bh=TW0r7ZDi5Kpc0NOqesGU8kDdpINxRHGh/ajmzO2PuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q02MWIkLTGe6DQynBCFCIAU8knmqvB6YxbdJ2cW4hgG76Oapi/btNXREUqJulXI724t8K79xyj9oP+ISdPe8Grsgs5T3EE+oEalyu2eBjAkTViCiqfrqDkkTj6SllNqPVZtSCZ55A2JM827Zu9LdqRhr7hIxH5O5cMbr91I1dUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=vJuEUkv8; arc=fail smtp.client-ip=52.101.84.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRpQftjoNHq2qoXSWnCXH5Ap0DxA1RcGWrmNUIdbkuQHgalYISZLQGyaxSqRsUKQisKD5FAcvctMNc3sG5Ab+dbOff19Dw3mAC3O+qcTOwBrwZgA6QaT4bm1SdbcveLEgeosVH01bBwhYcCGIH2cCe/3tTbfa6SVENgZaXKBpm3iYvYNAqjDcTuodykcMUzzT1Lrzd+Ap0Of0sWtkPiXpeQ6Wu8wzAu99M9C93r66JfEl50eAx/lEEQuk2WAagk9UyZ0eQSOKbYYogx06gEHwZiY3w6uzfabSfReme88Fgtj9AHWJ/cIbFpFNphN3xwl6FYqJeh33/TtffWffOQ69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=bX0vU9uWOKhr3XX3RD83Z44S5QEqpE9Bqex4mGrIzaCH5KaC//rlv2851NciHT+8zR7ctYnLyIHQHQxV6V/caCKehcvpnYRITuKORK0LhxXzV1LAyATnqcY04UOpckaOb65+w2K0r/fNXQ043VkijTavniEebD/bCutcdSavBEUpi43PPtEJeHaUXNltepLsgjEoteFxbzUllDlLz+RDZPX1ljPepazxO7oygGDNCjl2tP2sdAQDSQFheknM0n0TETdZ8Ece6RgampYbpLCd4DkLvS336ZqqrzFRirWj4OtsoNg7D1Chf3wUcekah6eWnxMAC117IvbBCeBSTVpCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=vJuEUkv85kul2rYDBAx3i0374/JwBAZb8c+vSG4A3KtcGCddYUCEWyzjpYeCoNwJFWUdVukr/tD9otGF0MGsAKR5/j1LQaTIC8BV4cPf2M7nMm1HS1YXeuL0vPNw6sJ5SXUpAiTKGtzkwGKoi4g4OuhHKttb2KhPO+G1lLYXq7erSQKJdPdJrSUEZ2wI/sHhEJ6g1+REf5Wrbfc4D6CpCOw1mNNfvPwc8eTrMWG2sHkk67ETLyGDkN5WX0zqqm4Lo8lKELyOQ9CFYToK8C5zbft6eHLaMKH4Rbr+6P6IUO9l31oVaTqzT0goHss743MxHnioG67aB0kPoVxN4BvB6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8619.eurprd08.prod.outlook.com (2603:10a6:150:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:26 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:26 +0000
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
Subject: [PATCH v9 12/15] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Fri, 10 Oct 2025 23:44:57 +0300
Message-ID: <20251010204500.1625215-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: d55ddef2-f61b-48c7-2696-08de083df132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d+GQKMVMjDDImE+QND4oB+snX7T2xZ1rmB38aPxYy5nZF+12FBnOowaw3N5G?=
 =?us-ascii?Q?yennWAJSno2/3R99XNKgC59g3vU3iqqlSr07lCEOnXOC8ns2nST8WMIA8eUS?=
 =?us-ascii?Q?32rhRWTlju9hXMrNYbgQTmrKsiHBNuVqaufR2/sCDHLBVkb23fmNYyjQsyLS?=
 =?us-ascii?Q?qT5J49IKesEfMbyDwsRvZTIjPvnbympTMgpOJwoq/NP7pcZ+aM48rMzp9pna?=
 =?us-ascii?Q?jD9Qo0vzcPfEhwciM3KppHXRzOXKZ/2DbAIX7IVcL4VrOVXj3IL7NL3xDssa?=
 =?us-ascii?Q?ZRBvsL0vhhtLgOZ/fuxOIr1/2K42IXVrOgVp8tMIAxeOfgZOb0VVDLZNpUuo?=
 =?us-ascii?Q?PRxrzaaFS1oUqBdrBiYA/cS6gQZyiH+OgJWqeVnNdTNZ/lknA5avIIeMm5Pm?=
 =?us-ascii?Q?N82xrVRuFG3c5oaMsORJPnUKypGVeG+1exmkndj1WIFKsAzu8mY5chwarsW9?=
 =?us-ascii?Q?Y79YfGhaWxq/YY9Un40ZzHPU1G0A3YMPPuI0SdGhjCD5vE3vb3gQfrnzlQmt?=
 =?us-ascii?Q?pR05CRATI6zvw8vot6M1lVO3FxtgD9Ae5rOdagUWrm1g6zkFWYX3ba+Ndbim?=
 =?us-ascii?Q?8uRIZyKG+zo/5QhgJYYZGyUXQamRSIDQiY99jLnjBuJR+9PeNkke8FeGCuP7?=
 =?us-ascii?Q?9nTbWNVVRdhk3j1gWslDihaSckNpGfkNEQm+1QM6UPV7m16AfjrvlBIaQ41X?=
 =?us-ascii?Q?TgwWPbY/cSH3XtqHW1eD6IbI/FyamGJghtuxLXJw3qLFZ7zmNWryd5voovOg?=
 =?us-ascii?Q?TNzY2lQBK4Kx1xbvlJXeWa433RANu0nEeI4Y4NsZpfzVIcWugWK5Jfzt7mmS?=
 =?us-ascii?Q?iF7AWiiYhnadRX62UAcaPEVJ2hdwnN8/clMCJQ0agtQQlvyU+S+Ij2/zGCVB?=
 =?us-ascii?Q?RFYkaMyIrbaLO2KTRfEVJuSfFXqt+MM7c7KzOMBFBA/BJM9qmzmrXMiCikqY?=
 =?us-ascii?Q?gu67VDOZSu1oyZOn7IsSSg+LqANusE5bxrkinkj4yTTbFVRT/e+hxRygGTyX?=
 =?us-ascii?Q?+dmfRhs1sDncGB7usVCXuEzoLuS8ODb3WSu0/nurUYjZPTLvZc8B+wXQq4nL?=
 =?us-ascii?Q?MyKu2QCI8slE2BCuQS1+9q38VEaERe+gkHTZj9NgCECItmAvbWe9SUgHJw+m?=
 =?us-ascii?Q?vZ9QLLLx9TLJ54fslmqpfIgVMOCUulJXiSz/vS9pybTZ0O1RXZ8K6kVPexWu?=
 =?us-ascii?Q?e8nd+7bprzU7/H2XtGfxIGAy/KdN1xXwAcuaVp4Rb+Z/AiTNWzuuciXN1L29?=
 =?us-ascii?Q?Ot0bfTiHMv7X4/X+A9sellZI/tk5rPcX0s7LbVx9PqcZL8mYU7dIwQoYuUIY?=
 =?us-ascii?Q?IS6Z0aRXDbsApgHQUjZM2eDaMjlKaUeNvrHx1vjaxDazBCfJ7cHmOY9UFh2j?=
 =?us-ascii?Q?ZGG136KiRohe8gTrj7n/BozZCHgofx1dd0niFxC6qg9GQu9UXYTPhDtzn4cV?=
 =?us-ascii?Q?gHAcXWkpaYmkILudD5/x3wBINW6XdUy0+3IJaO5lCgXddx0NFZdZwEUwH6/F?=
 =?us-ascii?Q?F8qqzWWUy7I4ukkaV2uCHCTH2eJoNIEMDWE1ICQvjCOXjja1M9JRExN8fA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?auKFYx2y5T2/Pgiyx4mWJtlZz4xrUeqfVdLVMxpqlJ7JAKMYWiFZ44SiubKe?=
 =?us-ascii?Q?Sxr2LFNf+bqfDlPLaExi5iugbFH4Ph3h108QvtjzJvHPn8RNdgiRHGvEvmcD?=
 =?us-ascii?Q?aJQhWtR4K17dRFNPNc/1GlMSJlaX+J49YigAr8WQbF7qg7ybu12R2qoZ/MqK?=
 =?us-ascii?Q?6NMiQuKBMKMPz5q78ShwLvdPv/ojJKgflHYmd5pRpQVycshbdeRYKXn/VjgJ?=
 =?us-ascii?Q?HviDJGWrnO7cC+YINOPOf4oy8Fyvw+LzO4Ihif9QJmvwSkwZsHwmHaCsK1I+?=
 =?us-ascii?Q?TCyj8yZHuXpDaubGO5AHaJFSO0V9Rq94mh/LQ82sJGgrs5aLbZQKaDB5BlnV?=
 =?us-ascii?Q?zCCdHZ1+GjCOjw7FW9x5VZOzNG5Aa6ogjBBIwLOumopTRVbCCdxHrLm9xQp3?=
 =?us-ascii?Q?hJpbmTlvs5CQ8/J3DGzGD4dk23/yHue1gGJES4ooKMyV8+ymsIMOmvJpC1y8?=
 =?us-ascii?Q?KF9ClaKIL5LQZxU5K1SkedaKkqraWXdxDu4ezmQLc9Gz/WREbLYdlO1F8TS5?=
 =?us-ascii?Q?RFR8qQxF5dchgSjnAQDFfw1mEEIkF2fFna5wgfyMWdogxaIQJOnS6RxNMNx/?=
 =?us-ascii?Q?nf9uK+5cAGD7fXoDe5xeJedkigizOAOiJWpGkhRrEeu7xTZYmc6Fxan8lfWR?=
 =?us-ascii?Q?6otzC3rh/vhmuTKIGBxV6XtKr18cKDVGs18WzNDZE4DKivoDmtkXAcpfNpra?=
 =?us-ascii?Q?lM6tIwHKOAWCGx8VqwhfSSSIYCopnOiEo8A2eBtt1duHSgJSNWg2ucG3yh7+?=
 =?us-ascii?Q?OJykRPPwLxpdPV0CARBw39sJ7u9wnAGkrL6nhCnp+EEqPDoNxjEKZ+9ZbKnn?=
 =?us-ascii?Q?9QnOqf8WXIzkNE3+phNr4209EpdNAkB/5jPo8q7bjE9iwox5Ze95OdYfuxOy?=
 =?us-ascii?Q?1zclvfBGbl7mGm7jXKQJ4MHfIW5fRkv4jB6OpLsGlvcU52Y54f/wPK1vydTM?=
 =?us-ascii?Q?Jwa867uKjDGWeDjwLd9BFEZU1cWc/oCU3PPUcz2zy6YeQuMbLtBBbqkWXp2t?=
 =?us-ascii?Q?mDPRkBxQ2FF1cKnVIp53MuHW35dYh9KZ+W2B7+wECmT5/MCZRljyWJ1tC1a4?=
 =?us-ascii?Q?6nyqO0olMiXu33QkjRaOXS4AWb28x6UBtss1rxQSv6I8gAv5re16f+XGLMUB?=
 =?us-ascii?Q?n8SEMs1NGqOJUuWxcNBG0+0vEtyA28iKIUg3erYtCUDaYKeU3A1U7hYJkYlr?=
 =?us-ascii?Q?90c94ma95JJqFeJTrgEzz9RjXaQyzpQ1I+igRNKLHxUvlXQU1KylTP/JeRuG?=
 =?us-ascii?Q?sXyTkMzRSGymNfLzGV1w0oyVAEkUGO2hhGPUzgWpIJmWupLWDQfDyvPAcckL?=
 =?us-ascii?Q?2bPAys4ar7EyUDC0//5HDGwupSJnSadjxekfP5v76uocKACRBQxgduKs+vFg?=
 =?us-ascii?Q?j8gfFZP3XXFosAwSql71oOMGAmWEQHIvh4wPX1HQ0xtK0nK/OF1J+sXXInm8?=
 =?us-ascii?Q?MMaLGom0MX44zO1ny6SGc4VFaFlBK+3llS/tgfbXruSu49IK731avUpnoAC5?=
 =?us-ascii?Q?YwISGwdT2ItA7qXVmDhbcZVMmlbf34zrMNeDVEWW/Fv3CE4zdIlH46AZfMNI?=
 =?us-ascii?Q?V3U9DkbN8ssuncRbI7s7vKfYXT3iVbv+2lnrVcHnTA0McVEehGR0JJGcOlyR?=
 =?us-ascii?Q?jL6Ay/OAz4A8uOpJqyM8NDI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d55ddef2-f61b-48c7-2696-08de083df132
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:26.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUmf396B0PZhGvdquNH9R1zD6TWoOwTprHVzQsTOGBEJmUtDly+n/5uN4R2ubc+9pd9qEn4OedhkGeKwjN9tkJvwT0xe7C5N1AR68zx5BnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8619

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



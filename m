Return-Path: <linux-spi+bounces-9562-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07DFB2DCAF
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460CF18978FF
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466143218C5;
	Wed, 20 Aug 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ELNZAEc3"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021135.outbound.protection.outlook.com [52.101.70.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33226321436;
	Wed, 20 Aug 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693228; cv=fail; b=nd2jadRW0R99hFdMmBD9oIjmlD+HWkt2ONGqFO5bNFXdvMAPto0kuItBHP081Ebmi1ZjgcE54glieJs0OuUtxLRCPS1z8nWDQ05kTEgjQOatafcVzO4Pn+x+jdVllHw0db/7wHbJF2ulC1R7NPfhcb7dSJl2nhrE1crZ30yLuX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693228; c=relaxed/simple;
	bh=AKunWEmjDU1s8Xv4obEWwt+zJ0vN5IQTrTZW1W8oh24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTzyn7Bf54paUAcw1sJTzQ/LHgHW6u+UuwV9vP5ZKJAfg2eWeYcBUkk6GMUgRINA+VyV2cMNkHPqx1r168xMJebA1dN7qYEvLM5iUsXcJileqw7WixggA1FcqHLsa44e7lHd5N4gSrPfjZU2VmqSpe7YYb4dsBTDX32rjoNI5Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ELNZAEc3; arc=fail smtp.client-ip=52.101.70.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smHtIXbgiDTmndGA+6U8om6KLZ3v1BDhS3W0plOu6dMk0g2oGGhgLWfts6d6d72fUPE8CZv2pbbvISvL9ZfKifl95Gt21r/n3KVyzjQlIYri8cvQ+7TcJ7+Uxk+kvH0RF6NvsmG4iV062UN3J4/ZsuUjDlUpH3jmVfQpkLjtyclwBR3Xb/dDOmVrxO2OpZpToPhxW37diiWrBeq/zeTaZsKL43Twqi3pCyFss0HQIPpWF4YGYl3jac9okuox9J8NkqMJm+Dm4NbXQ4NshaUR6Ex1cYVov0b07e8C+rd9KtnlTFK6nSryJNrBcvC76j786gYzWQebMEA/69nV0bmnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5ES5517ty02jDSje7nwVWZwUr2ltvbvBKvNErbhMco=;
 b=tdNDZT0hkvZSre6diQb7dF0hiCrUH2MN6jMhnkNarsiYN9Y3e8lKRyH1ZyWZgyNo4RZTI84qpjQZz/UF97/seTlAj7uvYVsP25E/rx0QCTKP/C3ILgMfT6nRuovBf4fYYBO2sEwgB4lxuQKGXVb3He3fQYQh7HPuaSCT8NRgTSt7CUvSogZ3THQr8lZcqWjunqlIAoo3plJSldSBgKiZWQU8KgDXO018Vz+P3UijnHao+aObtRMPeWkBNRbQW23dFzP+HeOPbUujzFANyouR0CRC8aIsvUZJqAn6e1BvIy5i3nmBzw/QkNBIfqX4dN/JquDGVDS1nGA1AmAItlZb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5ES5517ty02jDSje7nwVWZwUr2ltvbvBKvNErbhMco=;
 b=ELNZAEc3LNWyp3SjgqUqnjt538ml+rMPycV0RQsWEd5nZltx/ZUZvUzcKKke/xudhXd7D4m8r5EZNP8hyKiq/xlVwZgM4qhZZJEU5W4xNJCs5JgfGJ5fBQA+ZPDrts1lGBrPtdQL8VhlQEQ5xg95DM1Tft28L+iccctBT+Q6Ccnyzoht7b54X/P3sor+pZnGJTUjUz42OUFBTBMxCmDGBfgxPfr00xXmyaTBiPi2nYmcemAn51dW2z0+zSoO0fwTMzNJXFQQA5xuIUU7jPGG/ESl3EYw/11luUUMIwzKYhazXd+18K4Ym54cIrnjfE8VKmqcdi8gXEV7CmdwXKZSeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 14/14] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Wed, 20 Aug 2025 15:33:17 +0300
Message-ID: <20250820123317.728148-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: bed244cf-930f-4a1b-53b8-08dddfe5c8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B0kVJDYJXxwT6PPeYWByT6SiQ4tiJ6Yj/LVzXaERSzaubT9Q0j5yLoIu/1Bg?=
 =?us-ascii?Q?OfytefE6FxJ21D3a0Ow/R8xtjCqWw88GKhJINal14ixHrh8mOiPWa+BBpSaw?=
 =?us-ascii?Q?0J2dGsKuYliASWfntSw7FcYJRMXXRZU4V/2apJZPluESQ/sllH7+qZFMhmJ1?=
 =?us-ascii?Q?uZtadbpNyUhcx1idwso3PL1bhz2NWHZICBQjmt9x6mmbCv3olPGHyEGFiAQV?=
 =?us-ascii?Q?FGn/hZyuK3bCyO4ma1OtXsdGh7DU6NqP2rCBjboCeT61l6cWB52VW4SozMf7?=
 =?us-ascii?Q?n2hIb6n52W1ooJ6cnuTnkxHmzvuNYJOzYaEKQ2WP/zzKIE2CGz+iNfunBnLx?=
 =?us-ascii?Q?6kW0apYfezoNRD4OUiykTXYDhskht6dJ5l5LrDntlObUMEFsX5mxC0SvwOv1?=
 =?us-ascii?Q?g0gYJAHB3BY2yN+9ad/0vkAatkgRKMPaCPtjRVztgzAowOOYKM/4/h6urT6p?=
 =?us-ascii?Q?gt3cgIv0yimhvme2PvsuH2UEqnqvIAOwi+/GIvGBS5l1YGyn+Xf2buHN2Kin?=
 =?us-ascii?Q?ci5r38h7U9z0p4WubzS6eW3ycaHhD9ablor+TqdOGBqG/m7Pl8socY2VhFQG?=
 =?us-ascii?Q?hXi/f2fJabavSOtfVn6AWhVzyvp0eStWVlB+ALpDPFQVW1SHWJMgScOBMDa1?=
 =?us-ascii?Q?z7Xx8NZu+gtDMg+CNzdh2H48dhXreFglR7SKzhclGmdYqPdKdZDPc3luBk7g?=
 =?us-ascii?Q?i7y9qDf01/ezoi1R9P5rbQYe0ESKgZck5ZMdFo4vZw5hEkgf5ww1o8fURxs7?=
 =?us-ascii?Q?MU0KQXL04i8O7f79bYI4q6b7ju5vekvFmXd+2wm+5mGlmQCDktSzzmwbGR2y?=
 =?us-ascii?Q?8oczcgOE5FvMTYEtN8pl1y4jnzVCm0Li2guFdVza+Idnwt7opsAYSpDLF0fd?=
 =?us-ascii?Q?vyXluB74aPsc2bV81Mwsz5pUQxPdzpDRqa52EyEaJroLg4K5LAr9SPj6oRPW?=
 =?us-ascii?Q?4JR/7iXKp6Ato3/adI1wHJqvpnFvCZs3LUJ92gyvbdlUeTsDHofCfi3GaTBy?=
 =?us-ascii?Q?PFDvXbb3P8uaBz/GEQsX3F0pbulBTjbKABqS1klZ+AY+OBw+LDjwdPbyf1IU?=
 =?us-ascii?Q?+RqfpbIb5rNHrq77nq6CAWsIhoMEJ1QJatTgMKf7dFUafBSq9fZRJ60C2aXM?=
 =?us-ascii?Q?cPfbcYnm9H4keZ9WqfN9H5vZRiO4m1e9fO3KdFe/Cl9RUVN88y7BzvndvdZA?=
 =?us-ascii?Q?W4zVw9UrYe2dndARMaKeE2CPSMEoOtC9ix7MIG++aFwOLXVecd60A4jegUoL?=
 =?us-ascii?Q?+LbHTpoN5ZH3wIM40Rn1ydAS9biLBlfSSRTsqtTeuD/qSVeyPmXDhIr+vXkb?=
 =?us-ascii?Q?kntqVWOOfczSY1J+94/uean8hyCNU4s9CtQ9Vo0C4o6bsCc6Yi8Y8e2+L0ou?=
 =?us-ascii?Q?MNdraezaOzorKGpLENEU5GP2X/jQllhxzv2Ia7JhAQmrqoYBeFcZeI8BF9BV?=
 =?us-ascii?Q?M7xn0muyAu6ftW/7Ezrg8XiVp2FhELb8F2eg/QZbmxw4NYTi5F530A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PalnCE2zczrXWKM5c7rt9x4YAHuWoPcBXqDw48yzZb4p5hpmFJUnCFjwRglb?=
 =?us-ascii?Q?JLiHtoH9F/d2DubUCINehPN+4n3O2KEg6RRlQh8/H4hGSK1mSSmybWXQO+ch?=
 =?us-ascii?Q?StLr6RHNnfFLqyKuN14RLW0qPI/GZl5xZa5BdtX1+LWIGR2KCx4O3WDa31Uo?=
 =?us-ascii?Q?GDYEQZMUmMfTVuHrOAZaKY2oY6596VVJhwS0fezoG958qBgNgNWMW/nbrpMj?=
 =?us-ascii?Q?QBBxlCstCKkQtQGvV4CjPk8axRlSOEc2p6zLbG9eb2qMtfbLwjg1XvFFRkYQ?=
 =?us-ascii?Q?T/c12Vcka5xNlOSdRkdjLUz2PCl5Lj6NhCXLzsasdUdyigyU0jHrLLR5T8Ci?=
 =?us-ascii?Q?/GUaw9OgHNiXQsHDazpOCz9T+O89N1yBJEezhGTWSoIUfk3Hk57pMmCzdsJA?=
 =?us-ascii?Q?8VDhVHkAfzOprTS5HKwrfhqQMj0Lr3UjfF0fLjz9QdZKgIGUOuh1qfhtcEE7?=
 =?us-ascii?Q?VJogKGgn3H3WQswpXPNczdU5/uFxd23dtqrh7tup2x910pEsVG+BZlKNwOa7?=
 =?us-ascii?Q?1vCapsMqbauWZUYFzHPXXBOqfxfEDgeFcHfO9dCDTa1qsxwcTaugogWjGIDS?=
 =?us-ascii?Q?ImFcPKg4VGzO1Zyqv7cH/3ISpUMU0PTStWKhg5Lx7/qXQMVlLZ9hKYuvFRhN?=
 =?us-ascii?Q?rYVTCEVh2z7B9Jo7wtNWcC7+0J8jqLcuuzdOFS18kfOvfBKx9cFN3jikcdaf?=
 =?us-ascii?Q?ur4Q1zOoBjW3ErqYb6ISfh2x4Th8ZBq5wGJ0bQ1sVFscXsHEDXyMoIfI8/zq?=
 =?us-ascii?Q?g8UkjWLiqknYgsvWJ/MEuM/2MWAaw8er+MjkPRFmWMy3WSJiDpPXMV0Lt915?=
 =?us-ascii?Q?/F1DYk41hba/DqyaFrxLIoCimadagua7R/sdlpAD8q2MZjmrRthDjH1EZZ/q?=
 =?us-ascii?Q?xWhjEAXBaPUo+Ph039u2ptwSW02SrsnnggSygJ3IMIUpAU0cJOr8v4u2r2fD?=
 =?us-ascii?Q?LI0I8En5G+TtpXUvF1PnyUzZxlfmaZ0XfB5gOYDRzmDExVq0hqj1AyOYIn4b?=
 =?us-ascii?Q?Mmh4nK0I7qgxIlt5S9KFBMg1yvfvAngPQWNscGAATsiYxcMPAsSOFkaBRseS?=
 =?us-ascii?Q?MNbsiw6weF5zzuoQRt9K72rlnHpkrEbDpi/q190VoJIlwmgiTT5XdHgwlbP0?=
 =?us-ascii?Q?4qJwRBoHvsOc+E527WBWavkj8h3YFUbmjtbLu881vwpf5IWHsneGx3lVazhV?=
 =?us-ascii?Q?ni4wG3P++AeUmtpt2+T5ChH3z+JCiaRxzuPIwBmfPQepIu+uENoFNbH2DIIN?=
 =?us-ascii?Q?8cYYkGB4VszlO3KNeFcRl+NoAroXvzGTxW19Lg8EYc6C8F8WhbM1PpT1ec85?=
 =?us-ascii?Q?MA+6M3fQ25LmXVcbLnn850YzmII6hQUhYVmfq8gn08IKNCErLWIiNd3KBZQr?=
 =?us-ascii?Q?e+9QEL2VCBDkCsAfqA+/OqUO2odn41DiYVH9geFWVeYU7erbmKgukK7jpo/Y?=
 =?us-ascii?Q?OTKZw6A7JZnTcaNkIWmDz6HSUTKSAHD44VuLYWuxmqFnzL2J50CbmWhj9RLn?=
 =?us-ascii?Q?C2HZOSm8dE5urilddUgSIabKYWy290UDwV1nckdx2phUp+LYJRqGGKm67tEp?=
 =?us-ascii?Q?O43YqoMeVWL28XasDIcrNo9n62VT7tQxGhxNGiDQJymzxBy21FVtodIOuIlr?=
 =?us-ascii?Q?5bb+vPRs+AwRPQoyJ8OgDWc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bed244cf-930f-4a1b-53b8-08dddfe5c8d1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:36.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6dnNd9eZXjhBVVN3lx7R8+HEGHcsT+joEOIrxJ5fEIgB7SvcHOqHEMvnYrlKvFDVxF1kl0DR6xDXNBjsRD6pBEEGTHc/NHgg9iuJetU5+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

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
 drivers/spi/spi-airoha-snfi.c | 136 ++++++----------------------------
 1 file changed, 21 insertions(+), 115 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index a02dc6de5406..4974608423b7 100644
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
@@ -488,56 +481,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_ctrl *as_ctrl)
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
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
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
-			 as_ctrl->nfi_cfg.sec_size +
-			 as_ctrl->nfi_cfg.spare_size);
-	return regmap_update_bits(as_ctrl->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -570,26 +513,6 @@ static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
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
@@ -640,8 +563,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num *
-		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -727,7 +650,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* number of bytes to read via dma (whole flash page + oob) */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_READ_DATA_BYTE_NUM,
@@ -825,8 +755,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num *
-		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -906,7 +836,14 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* number of bytes to write via dma (whole flash page + oob) */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM,
@@ -1062,7 +999,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1087,36 +1023,6 @@ static int airoha_snand_setup(struct spi_device *spi)
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
@@ -1190,7 +1096,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.50.1



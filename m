Return-Path: <linux-spi+bounces-10419-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F96BB1FB3
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEC516F216
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4F531355D;
	Wed,  1 Oct 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ky8UN6vp"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020128.outbound.protection.outlook.com [52.101.69.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1B313294;
	Wed,  1 Oct 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357458; cv=fail; b=T3qxh0olpy4innAAm7i5uULEW3ZeXINws6qis/VETmIrUNfZDyk+VERijbzn2tZjbrj3cQ+0iGptLRVK10d1AHYTRKZzWJg6YLBfXHuK3X8mRwZviHjD6BspZSwPCZVAh4nR3NAK/EygaICs+UxupBdtTMQITApeHMrUy6UFkZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357458; c=relaxed/simple;
	bh=TW0r7ZDi5Kpc0NOqesGU8kDdpINxRHGh/ajmzO2PuQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FsLt+bhla9sziR1Lyfw5G5NP++myvv+vabztKf+vsbHx/rVHgeReC3+FCzne7NPu1Ew5j9MR+RVAkCJP2FRZZ7CP0u/g96aOX1PEcoHkLEfjbrAXa8rljFVy/KC+Og7a+0jzORfj6g1/m9HUB3dTAdG5XzJthLjfUYXHf5K2H8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Ky8UN6vp; arc=fail smtp.client-ip=52.101.69.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfgP+u9ZDB6dDX7JWm5/VLX9nPfTiPJK9xWIP66J0DY0M3v7Y4RCSFLsWBZ0lF5hGPhRme3iyZpex8hGAwQ2JTzGm/of9fzaBeEOSi3mLni/L9LkV9xKIw830TgjRMt7y4cdhSEDlyV3lrhWF/VeuotM8qlOAcSiqRTvNOugXUV6FEkmmGkS0CPxMJhz0XpZxc6DWJKy7FuF7eKEPBHN7R7WAUpqvWSGhe2ZmU/MCHcZw0HEKUE3EAlpoXE8cvLdS8mm+VqiaEZSylm8E3sAdtwn7pUS2Ht0sgBwVU5rrDjViH5cGh2EJig2SeTyubMWpn2Zd+g8FRhczjuwWMrehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=l/FO/VA2iFsFQdPjc4dJYkwKDAC/hoN14QlZw/z7ADAGPDhcPcXqcz/n9wfZpw/6OCT8uyacDI5nJKa+5p1iC74sth9URSERQWJmWo/H45C1JFv0m3FbB5CC4HseIeThEITEqF14qjxL/v4N7G5Tcxvzd2hCv8vg6CinJk7TnW/g6nGgVTZf5tOJpYRUSHpV7b6umsy64w6I94upfuGXkpsDs5zdWse9qFRRwE6wvRNhsMKawzTQWGwaIwZyEtCeyGLGWUvILXQvPA/7HfyasmFSENHLwsFYFd8IPT8TaER5an1Nmg5HenvT+ABPGArX/1ZeHl90yk7F+76aVOS33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEk8brtdw5W01o7qoOkKslSSjbVNlZcNRZIgXO6c4j0=;
 b=Ky8UN6vpmIKdzpsMb0Say32aITEZvwxzHo6IByNOwFVSQcH/VOzNu08D6YM7yREjvrEyHo8FylmQhb1vnHHt1yIIBqPDhjCRSkEWa6MlX6BMi5rS9nSC0h7Hnb0NDvlTpQPs2p2DtRkO3LjClGndmm+w5Um69MJpk3sQZDXXbjgF6Byyti0ZZ2pjuhe3oEgxlNuf1+Fm8QiH6UQvaCwtucx1fTeO/ZYV/FBnwjceOIOTopVSjqcf2+3BvOfU3WJoy/XhuudN8hXagGK8zHBjnR4VrvOOXHwpgvDck31P5AkZ06eTxlXSQoapcSfGwdCcoVT0rqO6OGaYBMtqgAq8AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:06 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Thu,  2 Oct 2025 01:23:45 +0300
Message-ID: <20251001222347.3386506-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 31025cb6-c85b-4de4-3722-08de01393bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkWcIJ8XXai+tVSM+7umAULmfhGo2HgvO3DcRjdULsJP5Xrz4OUGx4R/SCeN?=
 =?us-ascii?Q?1qs7QqT3AWr2d+D/PT0KdYlLDybPyJ32trSTybBsCxBgsqLigNGzqBFxgZVi?=
 =?us-ascii?Q?vCgJy2VQIld3hp4MkPoMBy4CfJSCI07vPxeLjjjBeQGJibdJKfmhoA0dXyFp?=
 =?us-ascii?Q?4vsZ8ji6Jo4vtdGnHJ2Z1l7UsBU+jS/ryga2Qe2FccvJ9HTx06pf254K4KOi?=
 =?us-ascii?Q?uf2XZmxlMU142KoOvGIxBcwiO8ITvHyDn+2g1RYclrC1JW/eKYpk6KYXZf6t?=
 =?us-ascii?Q?9E3Q5rzJmZAkCmjjG3jBCk4CtwDNG/4vwqF4wNrLuLBqFyc5jnmHP7DksCcq?=
 =?us-ascii?Q?jJPTTt2e4jSSPR0PqpnBCKN4W5hZ7VtQVVSgWrzEDujMUSolaKRp3vpmb9N+?=
 =?us-ascii?Q?sF9LGsAF7ySEcD1Auhma8ETSiQ68xOkA/220P2k5yZ+xpa9OhDvlNT1Hu8Sl?=
 =?us-ascii?Q?FJNg54rDP6HoSovYVHwmpWkzo97v7GgQiX047jcTXEBuctJIKy4JxxGrVBKW?=
 =?us-ascii?Q?Oh/P05G/2nO+Lxn8WpWsti/4e6Yy1atUkwWtS+dm4kvKiRUnu+rdQXO+PtAS?=
 =?us-ascii?Q?ZZPn6lAb+nMpo6ad7KMOL403lDoSIcLNXRvMzJVViHgypLx7Y5N+ktksynSk?=
 =?us-ascii?Q?mlD/UicoQMTTWT3PQECMKNblIkpdnBrtawzsWnOQvnTR8hwGGgxS5cOrNovf?=
 =?us-ascii?Q?H2Iklk5CF4K1sFmG3UhEQgxeoXk+ugWxL3BGwBhq+0gUBQLEHnrLSrCfFCCb?=
 =?us-ascii?Q?qehLbUIciKn74IGRzXCcqcaLJSbWh0IrKnZK7l79UcR2l0Sy6GBqtAIwD/TA?=
 =?us-ascii?Q?o+Or0GZYre68PhFpzUrwHpGztPCopDj9+aEBGUY7egWXrAUUg1ixMgHpHXaN?=
 =?us-ascii?Q?+nGn+wzwFA90nYUc/Uf+sRj2gkn5zajBvNY9UM7ZlvRcVa/RuqHObu3vE4t+?=
 =?us-ascii?Q?Qoc2IglMjhHp4xUQk384gmKyJjMZ3WMDZkllTN/OS+wwwXW9+bQ1XM5R92y6?=
 =?us-ascii?Q?wDTl66joRwZeu4IXZNYIDuUqkqtfb/rsW3qqK1hN5THRFDglf2/CuL68LEzh?=
 =?us-ascii?Q?MU8kKOEHchtQar9wA9JcrwvQ7rIf/uxhH00W93YHKFtXxRpN00d+i+vtcl23?=
 =?us-ascii?Q?ZPKegJigflXdD4qqPhAUJP1COWNqOHyDl+SzOBpeHFzEyIU3Q+PouNFr96rv?=
 =?us-ascii?Q?6q9e1EUrFcwCEqlbhdTFmjkNA3ae5p6CnPjvCV8kjOkr5W+jO9x3SDh/+/u6?=
 =?us-ascii?Q?t1FH6pGM/A5MXexODKFMdVOJurYdlpFwwXfutatoFsLD/mQ0eIQQl96GeF3/?=
 =?us-ascii?Q?z0yTjOwupc8KpdXAgrLBaDiH5KlHEqiw0kghGZRLzEDeUksPQ1952NruJPVx?=
 =?us-ascii?Q?jrZ59gXt8WfNStU4nStQUEDCyHuPqxGru3jpz/8XhFIl8rduxKEAlmuAL9Sq?=
 =?us-ascii?Q?GLo75Qaepa+aPY81NfwI7V+bRsuF4Wzu36Ah9ogI+uTrfZtISMT+LqM5IiDE?=
 =?us-ascii?Q?esEl3NtrF2yqns9PIy0MqOXRjPULI+/SOh0t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W3ihe9PcdUmjQYsPkSCDCoFP9F3kGNg1f0H6shDNqXimgBtLRnqtj2YVu/3B?=
 =?us-ascii?Q?k5mxIQcbTfnr4Pr4uwvTwZLPe3xso9mUSOQaV6NtChMXGfVRpNnEkpGwzZZg?=
 =?us-ascii?Q?yHD7BjbgUpdMf3sGyHDzZmSsIvvsgaqezWw6Y4mYQL/yNVVPRljuwPH/LW2K?=
 =?us-ascii?Q?cSulgOOb8KUSnqkL3Wp61mvlruPmGglv240d1bHsDEjZG7Nbq15THxT88qFo?=
 =?us-ascii?Q?9xuzn6tkKWDOVpN1qPjC0kdibb6mqpFir/0uRKIeK1m7dujLW++vS7JgUfFw?=
 =?us-ascii?Q?HryAYPCPPIEu58pmNNiInm3k76pv01a5pgWdUXMmpW8b7OK2OFr0/XSj4mar?=
 =?us-ascii?Q?oEXUhoMSdVOpAg7Mi2350xu1dNmVeUEj2xGn1rkaYIrMx/hiVzDQRcK2cudI?=
 =?us-ascii?Q?SmKUliSN+qExnQFjbegWUxGkGMwC3P+frBr5LY6/EesfH2fzLX+7xmMelBVj?=
 =?us-ascii?Q?Je1IXm9gxOdJRzO7EAbIWWCmkRUDbH0ORhvZf8/IGwZKbJAIzwi7+VRhdepj?=
 =?us-ascii?Q?C0n8fWPJhGpCme/EiJbuZ7eFkjZ7eQyeXj3UWYJbaZUl0pmZnrKT1CcBceYV?=
 =?us-ascii?Q?gfP/SYiOXKIkfXCBo3OaItoDWg+v9r7mBB6l+UMBB4HGhKe+mHyurXocr8i/?=
 =?us-ascii?Q?3Z5ZsxYKXi1V78LB8dEVFoWogjnP6iqgETuVckeD3Ss1wxkcUlanBLlJDwjo?=
 =?us-ascii?Q?w1/Pfkpg1l5zIXLqv6KPZKRMvU4eQqFPMMtPno0ZJaZeo+kP0QvRQvWh1Kfc?=
 =?us-ascii?Q?v+ppEx4C3dTVoTf0938yExbCj+nvF3gQGTUY1ddv/ityQOpCBJvapbB371Du?=
 =?us-ascii?Q?8ZemVqJbpKO/yz2Q1JtG7dymPh20QDGQwwS1AoOADvRDMOkdUXHN32nbuXuD?=
 =?us-ascii?Q?FsMQ97hl8pVQe7uVVr3jBBZ0ITPF1hByaAqgeuikQOfMuoIOQKT1WJxXfM6P?=
 =?us-ascii?Q?OPwOCG3uohO7ihTNfF00xetUGlPi2rnLW08PrkGgcXsQtllb8g30ind0RmH/?=
 =?us-ascii?Q?IccFALSILuTUk3kL3aF34j1Xyexs+zSdCfc1PCrW9uJWISG8dGI2Ai1QjKLx?=
 =?us-ascii?Q?tNUu5SdcgMLKtdyQBc056m/8XcKH+GW4PGhoHymQaAdbXpfdSQLWv8Z747Qs?=
 =?us-ascii?Q?CPYPjSzQt/Ed1zC1h9x1l+O+Gvj3A6BgSnbUPAnopIWD0BbR19U5zXAM3CbV?=
 =?us-ascii?Q?iWKHIew0OG6kDzB20e4TMTUlexfSsMb4SrTJOwI2hTxodBLwuQMsBbKcH4SR?=
 =?us-ascii?Q?73+GnpPGBUKr94PH6rDb5XFmeYNCmUaY59jdr5D4Fke7Vx1ZQmXbVOqlfbkw?=
 =?us-ascii?Q?/JkoC1Zfrx+Zxm/IR1hW3FU5l4ULQyeE6ie7Wpk24I9TDxXR7MwImjATeXeI?=
 =?us-ascii?Q?jw/VasFXky514qbQPggvyUCYzp3Xa4NP2eZB9ZVe2A1jye4u0yI/6IlfiEjK?=
 =?us-ascii?Q?la4A98NqIoABqqwl+f/BNQFpKk4yfIRQac16IJ8xsv/YFhPIiD1FdvXH//qH?=
 =?us-ascii?Q?kYkcC3Tti9ApywSjwYtHZ++y8MmzUvozB/b6cIUapXrgNH4geWPBgHE07Dvp?=
 =?us-ascii?Q?j1FhBGJ9StCILVK+IFQqsleiTlqp+BM3skNP6ZvenxMA9/NBWD4JtduWecCH?=
 =?us-ascii?Q?0yCzP0cwzck8D7pxD2ZSkLs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 31025cb6-c85b-4de4-3722-08de01393bf3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:06.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWkTDZG8OJxEwyoFCmHJfvGZp0NKiWHu1pM6E3opf/F71X+lD7WpGMeRZDtTEuDkKFOfXYs5NYpYsY69GqutWuiacBc3zKRvDlsVAJTFZHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

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



Return-Path: <linux-spi+bounces-4602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D524996BA2E
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0630B1C23EB6
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16611D221C;
	Wed,  4 Sep 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PCoQS4Ai"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DA1D2221;
	Wed,  4 Sep 2024 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448677; cv=fail; b=avZjWWtlPjPj+rBHHqHv1ondk7Z59yTlgQukL3RCRIMZ+zLntJu2qEZv3G/yj6obeEx+R/mVNqGVaQlkuSw1En4ixdU3LLkTMBAexWxmxOry8RfGcHilFhsjLb43Q1wwx4wR+8+2GxZduD/WxUMAKpYFdt4WGqksAE4h41JebQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448677; c=relaxed/simple;
	bh=yOSzbUM4lkr9Ys4Quxu1jcTwA+8si8hJi7jknG1AfQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KaAi2PCktxNnwzBiw/Rl4f2M7UyKWSZfRqHBKAlvuzrG5KSZWFf+SyDjm8yX3uuAxx5Lue/AxFXyc2dAf9JFMYGMxx87mkJLTMyEBxV/Ra/GwhmyHpTM8bT/HUKnyPa4/J+WXnmyx5CLAwfm8NnUlvUKp8wUEtMVrtQPHm5nV6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PCoQS4Ai; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMbNpep1upd2sVrDpRb/S1ClHn/in4dokgkANruNcOwOImBM4Ko8Ly1/cfye29wIeiEwo3ZZVB1pcEsc6HAvgplbTlKoKuZG/nBzoe4DkHcbxyGfb8bEh+T+mW7nmMLx3QlUk46aXljyw3JOz5iH3V/FsbnK3iHcboiRwCvPgaINP0jaDo7sghas2ZWmhyWo4+zuXtKophdQOHFLFpIG1z8A2edAmBYuUNpQ0ylilXarEcWq8c9fCW1gW+VP7o2ZzLHGhv3tfUDJCreMr6Bpk6/PISeMF+Bib4E4AqbgC1QaYF64GJrf++SwDry1rUJ/Jg/IW/LrbMrHeWe99jBQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scfmB2ZzTsy9ipIFZMpR73Jq8lm9gaTiIu7fKzeApxQ=;
 b=asD0ZATvjcMF2J/oHPTxlpg07l9MNZ5NcyLfic0xAEfiX7Tct4QuksHLjGkTvrk97SvZg2wbtG8wOvR/Y4sKMe09OPs3Jg3C4XXZEJ6dcYazEPWV8aBhI/Xrk18yu8KGHW2ysIdDmdeY3P5mkGyNn7fc2VpJpK7qPHglWdGCT4AfhsnYzgBkkfM5gdMkwOOhIHmW95NmB6C3T56WI9box+O72XF9Pb3fJsoFV+myAIIBNtrWDgN/m32t3c0jJ8JuQZI0nUZx7ApI2b9PD08KutMS19tVjTW8yNL7/fmuKQB4zvp+V4VthirBIl8D0OAv2V5W2Gmp9DZgZvnDpvf8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scfmB2ZzTsy9ipIFZMpR73Jq8lm9gaTiIu7fKzeApxQ=;
 b=PCoQS4AiRXiL1LmD3ddY9XXiv1BqYE2XS0YDZtBFZXyKUWccOBE7j1ZoSMKtqlDDkmaGJ4pyB2Hcihy3+aNMoswrnc8Ll8lu7NA69l08SVDUsV5TCHdlSqPfa5h3S/C6B3cNHwR3Or0o5vP8W4BHaiMiLOqfhewhTmHtaDAVrtrVNqo6qc+GLdlkAe1pJfL5i6JWftwtl/JlH0k3ix+MIAjeUKHeeIuoI0eDFVixrzVa8yeoryM1qUoJhYEy+YZOk5VD3Z565fAY9KKQCiMKNwmTUy6phhj08XkyJ6Nj2Biw7k4yibRQNHhsxkFAm4eap1qAdXU5M3laA2vapJbJlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10607.eurprd04.prod.outlook.com (2603:10a6:150:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:17:51 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 11:17:51 +0000
From: haibo.chen@nxp.com
To: han.xu@nxp.com,
	yogeshgaur.83@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	singh.kuldeep87k@gmail.com,
	hs@denx.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	haibo.chen@nxp.com
Subject: [PATCH 2/6] spi: nxp-fspi: remove the imx8mp compatible string
Date: Wed,  4 Sep 2024 19:17:23 +0800
Message-Id: <20240904111727.1834935-3-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904111727.1834935-1-haibo.chen@nxp.com>
References: <20240904111727.1834935-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e2222b8-a6d2-44f0-0e5e-08dcccd336c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdLp9dVvnKyLDA4YfokMEDVX1Q+z/Nq6jCLWA/bvarUfuP4jpLZYyLtcVPw9?=
 =?us-ascii?Q?ovS9yJacTZIIddClF8KOveE/aLNBFC76enVrij1xxakZUq4CE3ZmKAOkG77W?=
 =?us-ascii?Q?eWLL7u0hnCoAufQuYlcIo0xFTOOEZPCAlzDI2DY+xNfcKl6ORbgmVTKl46fh?=
 =?us-ascii?Q?AGN9qqioRzK/20s78YiVfEMc5C+Ym9zmqXkTOItsVw/bWTM/wowddjma+q+m?=
 =?us-ascii?Q?8jGJelHcalXIC9dmqW++17IrG9MZaD0zWPTRSlPolNH3HxpfsA5oAVrBcwR8?=
 =?us-ascii?Q?MiAS/jQAwHY7icIrO5PTqszY7KKITgO/cjrS0sNgJLfJTJL+90t7yQXIPiO2?=
 =?us-ascii?Q?7nWJBerJR1mYh1MWm3rPjRhOw9VecojaB8Zy+hsTvl2AeWJUKWUy0b0L2Vfo?=
 =?us-ascii?Q?ZHue8huVNj0tkTyPznJc80Mdl6SNlYuPyk4rlcTwvogl4F4v5CaQsI4tzsAQ?=
 =?us-ascii?Q?JC04NURWlcTXiXpKSYfigXk8HT5kj2XvwR9WlQg9mpd4H1P+skGEYLnQDCIn?=
 =?us-ascii?Q?+vACsZx1KvJtTo65Vso2VzJ8VME+QmBW0M4riJPzmepec+DEorfVIqa0nCez?=
 =?us-ascii?Q?cx3MzdyBKqDkaQwK1eyxjX9DMiL6YeWLjWNl/Eq2KYILB68wYxghhVLQZoIC?=
 =?us-ascii?Q?PTDDScU9PckJ562nu2cS6fuCWikaNcm/IS9MkjweKTbDBrchr+4P7L5vymvx?=
 =?us-ascii?Q?Z8FFRdrSVmtMoevqhjmy2BKsDHgKMFhQoVvNDIQS/asY1xTxkVrvQ0czo1u6?=
 =?us-ascii?Q?7asOBXupJqLRCkCCkL1cia/vNGwiHsyMJHRDjCi+sj/Z7cOvaRg3kxJ6iFk2?=
 =?us-ascii?Q?N7Kr1M5xsJtPnqMbB/SzId73PNazh7lwDOvN3UXMnidpDw6STDaQ7yfrJD2N?=
 =?us-ascii?Q?dhocjyk6NdBsVqK2EnKp6jXpE+mkeuLBQ1fEhUFcGyEgtLZabp3xKjMqUGij?=
 =?us-ascii?Q?QtmQCg/wU09y2GYo19fY45W+Z56eC/7bJAhbloEhglEQnUHxTbYtfkZVVyFz?=
 =?us-ascii?Q?kszz/nWYA/HSAtx8iS0twt/Dvkm9I66pYy3LW99SVDgKxEcBzTkHzSwR6eEV?=
 =?us-ascii?Q?QLOO3Xgd1l+5geOfKfwThBkrittESa3593bClPDr/t+6zM0vtBva102NiIt0?=
 =?us-ascii?Q?wthtl2p1eqnfE7pquRDPOwIkOJ98fAnL2mau+vh4MaBplKYb7x/5pIPfdG0A?=
 =?us-ascii?Q?mzxlwTvsFDeMdCo1WM9Jv6yKOlhlMJQkHoCEI45KdCE1CoRR+tpoLyvnqQkX?=
 =?us-ascii?Q?Vfynp5FjpQ0Ya6TTZ7X1pCLZiF6jBrulwy35uqhkGWqdOuoFnuE7UF47Lrf6?=
 =?us-ascii?Q?adYhiB3KjemuUtFCzQ9t2EfrkDeN/Z1XE9MGaiOa9BSVWN72UL9mhsZpAx5N?=
 =?us-ascii?Q?GJ4W+uH9REz1pjIUVDY/2Z3JxC7tgZYHxsBIa9N6Y+o4t/PJQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEDXx6Ap4Y/WrtAeHsojIbdw75MpLIj3rtckX6yGrnRViiadBv8O6CCUv+fU?=
 =?us-ascii?Q?IBqEIwasulCYcBz2iG5v3MddrS9il1B3qB8j33gRyjDmEh+5qNCsf94jaAJs?=
 =?us-ascii?Q?hx5LeMrfWv7eYXJqA3cwRp/Y+KVdCPsfR5jycW08hj5Sb8q8kZpTwDvAQ6xy?=
 =?us-ascii?Q?hwV6MnlGCbcK/rIIkp0wfxJLlLX6dsgU5ru03McucpkPpcS1nFivwGqO1+FN?=
 =?us-ascii?Q?qog8Kqa5ptCF9Lora8+GFODBkZDrZL3NvP88cQh7xpmkWDhOFDL0rAgAGWP1?=
 =?us-ascii?Q?6Drzz52/v2Kszf7ofJjE4GkWuGwGzacabSTVl0TFLlHyou0H3QnpeDHsOnIe?=
 =?us-ascii?Q?ue0XOf5YIGcVsq9qhSahS3vfuy6ywIHgszlvIZoxOPZa9Gy1QsrtqcD1+gEm?=
 =?us-ascii?Q?BBVyDXGReX9HSY6cT+O8WAEvtlXNFQ9MjIUzjLTpWkSJMoN4GqXYLTFj61nI?=
 =?us-ascii?Q?RtIZSP+6BHakHluzL/BrZBrdv/GpArFwg5+iI48fhVObvds55LNxN7wf548Y?=
 =?us-ascii?Q?PGQHzcnNArQuT8s4ultijVvfnavGDgJ4r/dBTzCnutjX71/xr0d/IsljuJ56?=
 =?us-ascii?Q?CuNPKhXmGwix3Cpm8Hl74Nl27VuuJQm721XyELsDW9AWDJFJwJhtcimI+saP?=
 =?us-ascii?Q?qO8KLHjGrX8AQJ4M9oRhRvvAPz2KWV3vA8h9x/gGBsl0E/SimnRjyIMhHHRc?=
 =?us-ascii?Q?PU6Ub9PdmDBhJFOf+uNN64lw22CIEmUZA4pcYhwk9h8dK8D7KWjesZjBkO3b?=
 =?us-ascii?Q?LrwGx/hRacrktuogsPXfdD0kAcy6TrznCYY3s2LjpbLv4rbzHBl8UrM5s5QD?=
 =?us-ascii?Q?34mpOo07nN5Ych9bWy1+fnuIjYw+xfSdvpdENnLlTqyOm/fzjNszSkBb+9wM?=
 =?us-ascii?Q?joBLQ+LTV8fmLmd+rZKP6mD1MSroyZz3UCZ5mazSFgEetWgDQz4wsvIfKfjF?=
 =?us-ascii?Q?/oCjPlM0rs4/40vgoDb1oZPXcaTr3PY61DQgGZb/jOoG4UF1j/WUfa4ic5Ik?=
 =?us-ascii?Q?xvug4f8eIqaLX+TtwUTrq2wrDG4rK5rZ/rA9wf5khm5Bbjjl7Sb9W/y1n/uO?=
 =?us-ascii?Q?arBL0pHLgcaDEaWGC8nrLk6xtrx7xjuPxJNqBjJ37ROV/3XmEXYbdhxcqHq2?=
 =?us-ascii?Q?xRkoJSUFAWx+I3COfzIoooNsKRB+10mUqYqF9mztqI1ed7Vy8g766T3zOY9J?=
 =?us-ascii?Q?wQYci9ENpNOQT2kR7PN1vRI/d9u8OypvK3MeNhje8zrJG+QSHvsVtAQGTJe1?=
 =?us-ascii?Q?03oCFsVvWxSH8/bFe3NkJPVonw5Jo2KgyherJhDw2dlN1PPajcb39BNnj8so?=
 =?us-ascii?Q?ntcFakC2IVJT+ZPJjCAuKsCHETjYab5ztykjHLBMTqwyHFEskOSei9Lt3ohl?=
 =?us-ascii?Q?pHInl2whhHV3QwTQDNWvdI6v5kDvl+xHqFEwChE4tyDznTI/C12QG4WY6P0A?=
 =?us-ascii?Q?q/6UuIgDiUpvrjjEPU0FrRCceEl0+V6klRo0LurahVlsjHF9uGU49vWaE3OX?=
 =?us-ascii?Q?jegQnJiCK3gdNLGZwMPCHF1jnLsUcFUr5WAlJyOC3sNk1fx1GuW17v2CJWgB?=
 =?us-ascii?Q?limpG0E09aVSH9SnjHdqjNjw6uLQr96YnpKdIE+k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2222b8-a6d2-44f0-0e5e-08dcccd336c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:17:51.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1ni/qCFCWd7TXVRV7hosydlrwynVpEBIYkYw4GGMUYAgfMhkhZC+ptJ7lu6EqAdVIC98Ars7vjszzjfe/c83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10607

From: Haibo Chen <haibo.chen@nxp.com>

According to imx8mp RM, the fspi is compatible with the fspi on
imx8mm. So remove this redundant imx8mp compatible string here.

Fixes: 0467a97367d4 ("spi: fspi: enable fspi driver for on imx8mp")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index fd1816befcd8..da110188bfed 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1286,7 +1286,6 @@ static int nxp_fspi_resume(struct device *dev)
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
-	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
 	{ /* sentinel */ }
-- 
2.34.1



Return-Path: <linux-spi+bounces-9529-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4FB2BD57
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 11:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3229719655E3
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C93218B1;
	Tue, 19 Aug 2025 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="F7nP+KC5"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013058.outbound.protection.outlook.com [52.101.127.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E683218D3;
	Tue, 19 Aug 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595322; cv=fail; b=aZKwgS2/gRvfyx1gnhqrPub55LBlmf5OEgNvH1H/6wP7MSIJlbouDZ3MkZbzIzVRBECd9ivqJLpoMR5ZJUMYvVVTvGbHVJsDaRKuMg5JQCNB7+OjLZyEV+gPjbRRUGEE7tYhgTMTgeNUhbAzHDNfYgOtYpylkw9WYI97f7gTSYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595322; c=relaxed/simple;
	bh=SnmcTZzhjRkH3wk511e2cbo7nD1JBytQef+iGEAaSjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tasiYuhAqHfIwperkzE23+Uv+nuzQkRW1GE3sY+3O5Yvuj2O7NTj7iiaV2QYdxwOw6AR9gVGbkiHzwpvZWSOuX/qiFQBExKDaCDlyBJzM4jR4hI3i6wIZRPp6WwKsJ+XNtBaBT9d1wihbGp9hkPeVfpOqDP3Q6T/+EGWwyrH09c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=F7nP+KC5; arc=fail smtp.client-ip=52.101.127.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXf5MXZZo+D5BsN+G1Wi6OrZRbXleJQWedl5lDsMbZ8fz7GxxR9HH7Y9Tv4ePDhj/bQvQmo5qt9zyOb3GOpNOJRSReXc1iN0HW9brFs28dEvK8Fa1/vA4kMqFfkX1FZFFypjeM+69/Qhnfd5yOi6T9eJ9KYFr/uJffgQN1MR+/Nfgw09y+Ok72OJpvl0Hieuh+/PJXiXKJxnsQ9c6vzfBBrg4M5C2tSkP6KRxXboXFNsFu/vUTq1EYHj8erzpYsuTc/xSxH65mlUuUugxXNbEc+zAsvqDNz9ti7rvr6tBqXsEB90AIRycGoc5EKG8bquHGfy2byIx5auYuyW/Gc+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwlHh0HNKyu/59eFD9lsrMnnR8EWmFnhvD+zHwNgOIk=;
 b=Kfp/UerlgXzzIdkrI2+cfTkKqGGOtXR7TfjuFBzZwDhA4VAnNEyPz15+3P1jMxXjbP4CeUlpABuzy3nvAIvTbz+x6rLz1s8FXidUauTjOZAsvPqbUp/T5z0IDIcKJjP6N6qgorgw/og21Udn1fKzvERHnnc4wPkrJFf/Ja1/ti1UZTSWojtPLO/iBr820C89Y6CHxty0icfU/1hrWu5PckuitzRdpc7tZcAjhnEE2yKvnJOkd4rdWbszvjufx01bHo2pxH1LO25FJEi1f0alUAh1U9lMTAdDbUxAJe/d+nb3M160RuOlACsh2VkifYGAVlPSa0a4fDSsKuvf081FLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwlHh0HNKyu/59eFD9lsrMnnR8EWmFnhvD+zHwNgOIk=;
 b=F7nP+KC5Y0YaO9s30OJLsZjSyXFrqjnLz274q6bST1gjlkDGGBLBRZEpNOKZkX0GsGZ7v+QHMox9CNstOYFbUrBVjZr+kUjzjecDEq6z/pulw6Ips8oc0Mvbn2ozOEtlQxmGJOJbDkfFP5rVi6mBRah0Jbp8nmbTEBFfOsaZOqNjZxOrtct2u+unwv6DwBTJfmZ8lKT7TyNaYxUwIv3fqNp1dt1mcqMIpnvIuzD8SzXvp+S/suA5EvnQ0qf/oFJrqlWJG9tjfE0806sGaNYx+BLc/NVZt20qrA7l4ZnoXGE9oFIg1uFl2wR7fTx7Ro4vdWtKmRC0em5BGH93i6Lb8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:21:57 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:21:57 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-spi@vger.kernel.org (open list:SAMSUNG SPI DRIVERS),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SPI DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v1 6/6] spi: s3c64xx: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 17:20:43 +0800
Message-Id: <20250819092044.549464-7-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819092044.549464-1-zhao.xichao@vivo.com>
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 89065d31-7a6d-4d1d-1b55-08dddf01d827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYMp6eMXdiMXnaCAvQP+m95IRao7jw0qtPHhuG0S+KjvYsDqMGLqaCoDtbTI?=
 =?us-ascii?Q?TIa6upd+30aJr5u3OSFOLUqJYqcTOH/NZ2G5yCA3x2p58AnsEyIbi4KVXoMD?=
 =?us-ascii?Q?zn9sFDbb6s+SwPveGw5zOCTTmnnVPxOL4d9YdwXIduOvuV6P6ucTU/5cfHPn?=
 =?us-ascii?Q?uzsMvLiOnK0HqB5ZR+jScAAXb+e9PX4waL8DK4+oF4Q7hDKAGC1MKR+j87Vs?=
 =?us-ascii?Q?AqydH7aE4qWaqEY1YXfhkt6tZNm0AhpfIY3sfBmo0QwGw4s1hPfy5KA40SvO?=
 =?us-ascii?Q?HdsDsF2VPYsU2HIsO99waikrh+gVO69Qo/lrZJxoAAXzPvhC7FMiMwKh41O6?=
 =?us-ascii?Q?7twT4EeY3Ff9GlNimz8rWiusXFpW/NZWxDoZo4IaZ1VAY8+N1PfkLvmDhQsn?=
 =?us-ascii?Q?hCdPsNymFPZ6+vQf7vv+elbINPijSgRR184DX5awjnZNwhCksl14z6UXilAb?=
 =?us-ascii?Q?HYwGg/Yrzvwxdyr6ZlqZzklAZVMC68D4xhr8ckqPkTrOUVZxNFHX7ZHHzX8s?=
 =?us-ascii?Q?Xdhsj97E3phDFIld5dcDjZTbtIcDnJkRk7bAx/1Vjf36kN/BlKOQWiqfZbwg?=
 =?us-ascii?Q?E+dZ13o8Tm1BotYPB8CFo8NzoRhtKtrf6/U5gU4x169vQQP9GOyNAQ6fkxvz?=
 =?us-ascii?Q?Wc3eZR6dUiLjACcdKr4bxuTd/qvx9x6ZRfNrcfdYhgKzJ1Qx5tydiPsPhcCa?=
 =?us-ascii?Q?Kd0vRKHG2bxa/HZbDRArc51sXDu+9/ac+rFnjNqetLyaoARgLBDFeE9LZmPf?=
 =?us-ascii?Q?b2ZiDZ3KMIDGQJKANO+xVZarXRoCyjOz7DK2QYt11vObYUNlz7IJUXDetOSd?=
 =?us-ascii?Q?2VvIz9T6Usb0xHc3Kb97h3oNlDh0HVPdoKKfSC0KHKBTHXx4hhGYEJ594Cme?=
 =?us-ascii?Q?oTxI8Y1IS0EZK+I+783ijEfqZWdJkooXxeRB/dnuOj6X59YFeQ5rx0yR26Gt?=
 =?us-ascii?Q?+NGt9sq5ZetQdR7UhPic6DIdUNc7JEkPBMr5OR3W0H8MDPyo2kq3pu6BTR7x?=
 =?us-ascii?Q?cz8CpEbttWCK5x5O3lXjcMwXpbbWEEnSwRWoEQqnOCQKmylR6ShtPp+eosu+?=
 =?us-ascii?Q?DCbgkq0gwzLJ72g34BXfdRbzSppmKJD0+IICELX4TV8O4IvpHruSMFAK4qzA?=
 =?us-ascii?Q?DMgwIeeg/RC1FHJO3CG5APh9N1/9sCoRG5iKYN7k1x/lByabZHI3WMLw5LJ1?=
 =?us-ascii?Q?cuIWx8tBafu5EbVKxuC/y5uMq84Epoc95VQQh7K95xqna+xBCup7tSyr/QDg?=
 =?us-ascii?Q?do8u2jfd6qMZWP4tUZrvDiUm5hZyy0MwyJH3uyfz/ipvmOTWciMS6xp+0FTB?=
 =?us-ascii?Q?VrfbSLpUGar2pwqtnNVAGPUDyH/0F/RT0Lmdqwzy3BmSfDwXTEdCUWyNzwWK?=
 =?us-ascii?Q?CGydfgThZ0OoHWVNyN1oGb3YL6hP5N28JymYN6nNH+HPriW4oqVR+7b9AtU3?=
 =?us-ascii?Q?uK88B1iT/5rTiH/cqQB+fMomC/7BMekzdQl+gTySxTpb7O40ENRaMcW7/wNe?=
 =?us-ascii?Q?EaAmPOWYhtfIfxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N06PmPeCvo87TVEEsdPemKK4kOjrLfg5qodDrP7vQM0ggG6DMixvJDcV1d2L?=
 =?us-ascii?Q?FaU3MJvzchrGwOTae7T14gyp8yN4AuDoIiYZ/JYqNJ7f1XPB579/bIpJoiIv?=
 =?us-ascii?Q?F1u7V0TPE+l07BOrXUsO+IeTs8Cu5dJmX9RLQzgRVaANcfD4UdtzkpQMfYBo?=
 =?us-ascii?Q?hdvV3iPoSYBGt+y4zk+w7aq6Phn1YCaf0FTpxnunSw5nq/tvDsWbUwN1n2Ml?=
 =?us-ascii?Q?iyh8i2PQO1EFTnd6DaVt5mt74iinkKVdRWhvWuo+/ZypVBw+Wdpam0pZp5QI?=
 =?us-ascii?Q?F/oRrKe8kxai1TTcTJA0v2+oSORIs8q6qJgMPM2jBZr4dt2bh0L0Mh0fTc6K?=
 =?us-ascii?Q?/OVcr9tRUxuYTQQ8aiYVurXAiIt4X4A1lRBS7SQ16nyFa6ZZqOiFmCqJr37n?=
 =?us-ascii?Q?RWs9oC9k62FquHmHRa3es82t1UIN21/gz9LoymMIGjkuxQQDGFJ6nKtfsJlF?=
 =?us-ascii?Q?uVaLiQ6UPPBjJgOPQazKcyPxSkINTnVCl0/jHsP2F1Od3nO7xQgMD+ndEgTi?=
 =?us-ascii?Q?MdqX44/vRSHHLWdfjRpqvOjGgNPiBWthnqSI2NuWWhc8nD2NgJPM8mCZ7zCc?=
 =?us-ascii?Q?klCvkZeqj5unyb6k0UtIVqD2AJI4QQ7Ngvdy8YnR77zOpeG9l0UGeD08uwOz?=
 =?us-ascii?Q?XmGDVuVQo+Gw3lpf2ZvV0uDVQQ9aUw8o0qUiM8190ZyIcRglRcJb+nxYTfJz?=
 =?us-ascii?Q?MGJDPZWNS60B+cyCFTimOjMMNom9fNbunT7iDj1fJ0gJs3drX53oxFPjHInB?=
 =?us-ascii?Q?a0PUsewiZ0KZWVNPl+7olImgRDJhmgIsgMl8qUeN8WprEmybIBzjF7xAuW5Y?=
 =?us-ascii?Q?aOiQW2kd0FHNHRBSp7HyJx/HZYcILQxKqxoHzIlbjOxYA9HkFLj1cl1O+lYA?=
 =?us-ascii?Q?mgal9iygHebSJtNz27P6k/YM7xK3boRn3Ui1RQ7viZDV8cevTv0zLFi7XGQu?=
 =?us-ascii?Q?IVwq0Lnz1Jn3Zf7ewq6RyDPDKV50ZXyGBslLP57L3ZjTlERG6nN6qKV5aqR/?=
 =?us-ascii?Q?6D8jVQ33TiTEvIl4Vq5kojVtm5LJbT45eznSgSGmDKMC/gn79khYA0nVbVsY?=
 =?us-ascii?Q?xK2651Dc1KAzRB+oAJhLD78z7FOoz/6fFpiCRd3pnnmOQ5b604UYCHVQwPxY?=
 =?us-ascii?Q?p0ipac8UmwJG3jxtTLUZYkAfI0lsuBuWb4c1Kn9ntbFKZSr04/El3OxII4sd?=
 =?us-ascii?Q?eRZyVlt9QeMSuHO+nFCiX7RIKxaD1Tk5d3pz77FoINvIzA+DQ24E0naSxwBX?=
 =?us-ascii?Q?RyhqsARwmNqgwIdtpMfrHNQRAv2ObyCdHaEn7zEobiTdiFhe2dm4EQtNWxPT?=
 =?us-ascii?Q?bFJwewGgCTeB3gGlW+UMCVvKU+FMZs3Dt67BiSsoYS1QXXdDOyli/wUhv5SM?=
 =?us-ascii?Q?q3EbtG2c+qXiLVTchN9t3anxL4Gq2AT0PPhJdqln7x24Ga8p3B6xraEENDdh?=
 =?us-ascii?Q?/ZenU+VMZsHF//2Yy2TbxNiAw/PtU6GeLrha4YtH1PeitJJ6kBkk1VieTCQ6?=
 =?us-ascii?Q?XlsJpB6j3t7Ri9dYaOTLpmq5EgJnLEY8bZt2y6xHNoeKVudgNHkpMe8uY+7Z?=
 =?us-ascii?Q?GeKDAjQkKBROAP6b2TCQdWibXBZQn2j9HK7tCuEG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89065d31-7a6d-4d1d-1b55-08dddf01d827
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:21:57.3058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFtcR7oWFSD1kmZwnF6mqeTRYE5t677IehEBg+/GqULNoxOjbwcJKwbSWWRyAsP9J2rzWR/kQGk30Rbxime4Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/spi/spi-s3c64xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b1567243ae19..3a00f9e480c5 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1268,8 +1268,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sdd));
 	if (!host)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "Unable to allocate SPI Host\n");
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, host);
 
-- 
2.34.1



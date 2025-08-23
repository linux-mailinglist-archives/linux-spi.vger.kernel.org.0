Return-Path: <linux-spi+bounces-9645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21655B32A63
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA8B68161B
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DD2EF671;
	Sat, 23 Aug 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="u8W+HiXe"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021129.outbound.protection.outlook.com [40.107.130.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD52EDD7B;
	Sat, 23 Aug 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964902; cv=fail; b=ouuwXmltb8SD5ORDYPDPYIRcb3YPlqr5OyirLHPbxpBgf6JzqzXvgai7Yq+AMnx6Z143NLAl1M02wiI8v/tQ2DrMCELYuwrmn9SiyzUzAFn69EnOqs2Vr234KBsck73bBoDsCVXwDXwRRGwqxjv53871/dqYAC56LWD9NEny4PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964902; c=relaxed/simple;
	bh=5SgQH/uaqvidW6paM8TanGKMAKKB9rHBM9a4ZGfQnmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNAMgU2QhemozRyZMNWXqYIW7cBw0EeERn7daihh4Mcj1rr8RqLINQ91bA47PXmkDYFZYbu81MGRDkKlOeVTTkhKLmCyZikonaUa+3m+HO8B17HUWQDIM6uAm7scGgi4mqQHRrOudmmmTibArSPnlTdcFIrDtODlXye/3WR7QLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=u8W+HiXe; arc=fail smtp.client-ip=40.107.130.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ub1QNj/u4eQlw/yqiwiS7ZPc9qZNX/TCpnFLeF6JwEU9iRt1BinKJWAWCMEoFhBMEgG3d2PTQJHGQJem82VMdpbrV4csCWMZIfw+iQ3spzgwlSX5BTY3gtyIELC9plr7/0FmI/2np44KIydQiXx5Fgimunzdg+bBEf5kbr+lca3i5gbQ4U39+C3K2dWzPcdDlJ6QQbWWvJ0/moxsOiOluq/3VZto2PUYkJwjLodGYKiQlbEjSyfIbQ5UNZ/HKhj2lSJe2AyUn9WgQBxgprQRizmh+Y/kUJvQ9lz5d/rqk3Y/HYwr/Olg7gH7+8uTJGpx5or0ElN4aTR1AOSDGd9HZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkVNZj0jFdDtAG5gJFFaIeYXJQOUMqCt3cPslB11dp8=;
 b=defH1lPvdsFjCTdxHlwvZPczfCyHT4tdkrWly8vSjCOzNVwt5wSMbbrjVxZdeDv2cy8Q9FdJEVSl2y3z2K0ov99+Tg+JFLm7W7Xwd1PRReS2oxmLU3Fc5U4zjFJn+QUfOyYul26CbbZXI97GsvFap5x2+TT0PbQXEusZuvK4WfzSdLEaADomM5cdKm1cv3uF7nsk8mLL/R42ZQltd/nkCtvKZpdHLnKlOXh8hsbGrmgqzl2CChrEXiXuySoT03gSZptyLv/Twk/58LxAAB7ml7yQZDyKbRa5teDVOWOErfRdU+Aag6gmVHpp2oxpg/1Jf/5tEDIClcDvvet0gtilgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkVNZj0jFdDtAG5gJFFaIeYXJQOUMqCt3cPslB11dp8=;
 b=u8W+HiXeQ06KcjnPG3k/6MABLC0o1x8NewqxAQ7W5bKYbaHJnbfqQWUtY5liSPAEq+WW6QrkOw2IwIMRCCnlVmM3pujZveJjEjVq+wiYDC+c5qawKavAAbCuBCZYoarN19u2uqaZCKu/KfBleZEmVswxqPFsu3CMy5IlVV//xSyw1/J9uD4tTE0ugRoAoYxLwJwmBQGYzJkIf6DSjkH5i8xVSa6TfyrEv36UtW6awVpuh6Wjngsl7O+MB9XZtTJi+6+kfL518SMu/0TfCzKXnUNrTkruQLJee+gDi1UzT8xbOGvhs0DJSL7crWV71mdTuCDJyO4s1zLiWY+4YZvFLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6399.eurprd08.prod.outlook.com (2603:10a6:102:158::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 16:01:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:34 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Sat, 23 Aug 2025 19:01:13 +0300
Message-ID: <20250823160116.3762730-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: c5def0a2-0a0a-44a2-b247-08dde25e5586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GZHOUCzc9VucG2Z/LQUvRZfwX7KfQoa7M7WXR2i9W0saiOCb360Tswz3jMnH?=
 =?us-ascii?Q?VFYr9jeTL4jfeSRmQLXJ4MLrzIhxNTAmt6quQwLkRuyMq0dg/CoLAC2L0+6a?=
 =?us-ascii?Q?386i/K4l/8tIdlch12g4Ckkb3pzIJgwW7I4frgsoXXzVEXwGCZXLtFZZzOVC?=
 =?us-ascii?Q?/VdDuwlvJcX4vNbzBdPhb/oWvrRT4yqf7aXbM3ORdTRfW4N0nd82C0qOSajO?=
 =?us-ascii?Q?8Lwz9mjWShr8aLGBpMA6vo2Ma0y2yTUg+d1uaufy+/DTrnsA659L1EdIeQ1S?=
 =?us-ascii?Q?r3ozffGJZnTPXuD7Zs7ceWVqGuzofqKGsPZD7/ReYTX+aEdahhnoxkGYCada?=
 =?us-ascii?Q?jkDeoq0K3Ahhisiy9BtJX9T//6WLfZB1090OBzptM/sFyg6I7cf/YwAxzjSx?=
 =?us-ascii?Q?rAvrwbYTUTdRRltezCNawMMZ0lpIGwxdI0ecKGNHIgH+T77GwFFP6w11/9X6?=
 =?us-ascii?Q?CnqryInmPymgVpKTfEMy2MIVx3GkhPD2dt0BylzvKAhuq5ecAInC4fwLLcjk?=
 =?us-ascii?Q?v1gZrp6+fbB0Z3G2Aoz5IFXjIs23oFWACZlkqXTvWPJFCVPqWmtzqCY8ft6a?=
 =?us-ascii?Q?6TW73DssOfHg1CfzbK8g6YunsVa2KdMPcRc9UTY2uEJ/kCmGnniSvGaUQTW2?=
 =?us-ascii?Q?MzoQ1b46WBK7VeELMqZLzXDZuUyacBcdZnjHjcKQQGshPVX9o59LTE+H40He?=
 =?us-ascii?Q?PfdE8jQjPRklZAQfXGDTncAyJT0cOnpEWc8+hNEXNtmfU1SctSTbwclJ8hsK?=
 =?us-ascii?Q?Yxc03ejycrZwV/2FA2CYlSlB+ZYWEP5NDEQzY/AcuCN3sehDsEOWx5NC1Iyt?=
 =?us-ascii?Q?ObvNvsXp9ytbcVVEmc8ss98PyUiIZgOPlLMM/5Lw9YrhsMQCH8NEkxl0nvzZ?=
 =?us-ascii?Q?JLW7cZHj2reSkfNbWfE3z9wCVsIK6l5F0xhMUzGQuQiJx522GBnz8YKniy/f?=
 =?us-ascii?Q?S6wz9ylbbTnrBDH62/4h5I4bKgn1MgOt+mAM5Bu2RQKedgwkr3UI1Fy6YtKm?=
 =?us-ascii?Q?RaN2exV32tbo1wQo12685KctS2LYoTkZrUZtmhhpyXI+QXaTVUnHL+pwiVPT?=
 =?us-ascii?Q?1eCYBUNBFtqlzYqMnyMMtRRHq4dp6qkLrsRinjxwHmT/PSEy8JfS8w5XlXWp?=
 =?us-ascii?Q?KOkBY5Q0bMkIvqtIwIPIco7jjyMVBTIDNGAoK/nmDcgjuXvzC22chZ7aYgOI?=
 =?us-ascii?Q?fe3AdXabG/e+9ccmUMj6XLu+MklBqMBYhGI+fQ7yPMMlPQhIjYG0s6mELJhu?=
 =?us-ascii?Q?AWkK4bLtfdHbM80o9G/wYFhS4YTteAnbmRc+I7Dmy3IO6I7UAhuMJhu0u8Rz?=
 =?us-ascii?Q?+fEP9UDUp3h5lrTTpkUlARoy7K9JLvrq2RN35sByvpg4KQXB5R1ZXbVv4RvG?=
 =?us-ascii?Q?Z8KPOxrLvUT8G/ZNZK8CGvK4Co+XS3U/soe564d1o+udK5CaAlvpLyakTQss?=
 =?us-ascii?Q?Wb+N+ySdvjc3eQnLOJ6615/w7laMe8kIcfMGwwLHOhtY6U7SzUfD/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEnbUJOaHqHYaKlGBiOyfcbK0PxjzbehBz7IaIJpAhHWU9Uk1ZoXWCoLAwxo?=
 =?us-ascii?Q?EVU+BpcsyUs2bvjoa34pmVWgKhdz9a9PkeXeGP8BkXjP4vPfwqOGu0CtlKGh?=
 =?us-ascii?Q?lktwJsg7kEPMQstpjaoULpwlDTd3N6CSGDIVXxUskYc45P9lI4K/i2YmcgkP?=
 =?us-ascii?Q?FQCMYPHK7G2kGTGXXF4uKf6PAKiWuWzlLtMApyNsm/mp9s4Bbp0SJ+KzStzU?=
 =?us-ascii?Q?5mn3ek9c9HOXb3/Qj2Equ7XnYeDOXFCJiuKBRtjl8Zfz19nbMbKjV5cdUe1U?=
 =?us-ascii?Q?oS/LyUI5BVamZF3J31jb8pX7msGIDVlAKbuu8NOPqlpC33xfPJ+6pA94Lj9a?=
 =?us-ascii?Q?T54JMBNLSHhewFXAcGDVrQ3c94faQWKaXVAO1M/aB45LRAzsIsou8YSGCWgV?=
 =?us-ascii?Q?m2CQHzxVn1QtHGz5k4Aa4Wnr9OC2JEkFdBFON0rAJP1aO9fsv43w5/CmVqxG?=
 =?us-ascii?Q?LjVSQAYwexnna9xNGDNl1mpLyJWsOk077cYYfXsScnnF8dYcPi0OXKjUdnWc?=
 =?us-ascii?Q?4ohtguR/NhDTEcEZlR+N41g/6l1KtGZX9XaYpPxqCdIGB4oSFaXHXc6b16O2?=
 =?us-ascii?Q?dHorTUGN8NYmafvcDs7JYoxjEsfz9opYgmPb5ZUWR0Axh/trCrgy8Ocb0yaY?=
 =?us-ascii?Q?WFOljBN1W8dFh0mr2WNFW2ixFR6cLVyZ/2FEOOdAHIFlmwcFFc4divucELq4?=
 =?us-ascii?Q?1Pjx90OtBTIJSmY/4L6gnOwIAzSlMHlZTOiSz1jMWXkz5YLVll4pND7p1bmw?=
 =?us-ascii?Q?JwW7V2TnsIjmiIvnwU0D0RnoFIcMbePAbzW+Iyl4WPWbdCr0ql9eABKHXPmn?=
 =?us-ascii?Q?qguDmmmHUt4Vb+GE8Dwj0VxoG8ZUVgMLZwj4iWRF2s0QuWQqs5a9+pfqtLiS?=
 =?us-ascii?Q?zo/bZf1o7H2qBPgRdpj1cRifG473+biUDcMxo2oCyqxqbZsIJDTWGhVgeLu5?=
 =?us-ascii?Q?g0k8Ffymxsn9xCx+Hd5guxurW39YluG0cVHMBhtCwZ0s5Le9ZwllH08EhALj?=
 =?us-ascii?Q?0YtHMjojFBHXMAgnc4W8S0d1xJDMktGO63mC+rDYcsA41jg5FYjozBOec/lI?=
 =?us-ascii?Q?1IrfkgQFvdp4xR+DsQoFPb7bA+jDiEmcgpm+PWnsOAzLkTenecTXqD/CnILx?=
 =?us-ascii?Q?vmnP/hS39XIRI5Xi/z00W9KHe4pvbQ2bwK5p5MnjbxPq3ppMzUEjoof1pzlA?=
 =?us-ascii?Q?yaclJAz6/3UFjgVAB+BzYmiM/a8EY9TkuRi8sAEtO+HOqBpz2LR/b5ElidjF?=
 =?us-ascii?Q?dOfTVVjVwhHkQCn2LawQhxyC1VjIUZLMhCSAh7KZhoD5jO3hrXFrlfunlWcM?=
 =?us-ascii?Q?o/5ff3XMc6boifCe+3HLQy8ckOOr8T+VnkShfB2XqwCk30r7gQHcY7HQ7s72?=
 =?us-ascii?Q?yYJn0zVOlhtgyvpGySH2zJm0lQnkNb3Qs917KpS81PcYWuq+c1Zqu8+ZbrmP?=
 =?us-ascii?Q?jQol04fk8Q73A38ZKCAuuhwa/Sn56u43Um/q226F+ZBT4HkrOf3FDWYDPHrC?=
 =?us-ascii?Q?wVEmm1hgAGHqjSpOZP5+RcomwS6mqc/iZyCGa3rMf9Z67bt7dxNqIk7dZFnz?=
 =?us-ascii?Q?BflVRbVVH1OPwr1Guk2gvlLT+zpw5w1rQHf1JaYH1xB3imw067TxEH3cn6FD?=
 =?us-ascii?Q?6cxSC5vmHE/X5DK+aknrqp4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c5def0a2-0a0a-44a2-b247-08dde25e5586
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:34.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOA7XHsxixsKhSjB1cN3BCPZ+NgqqjyOsUmOCOUSqaQMsfz30ot++XRju2vw/9eWuVIhT3hnP++u2DbKlxweGcxMtPnvXJ81tk3LYLYcSF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6399

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 135 +++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 719b424d4cce..3fb76e2dd5e3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -668,7 +668,48 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for reading (SPI_NFI_READ_MODE)
+	 *   - Setup reading command: FIELD_PREP(SPI_NFI_OPMODE, 6)
+	 *   - Use DMA instead of PIO for data reading
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -684,7 +725,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
@@ -711,18 +759,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set nfi read */
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 6));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
 		goto error_dma_unmap;
@@ -815,7 +851,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for writing (SPI_NFI_READ_MODE bit is cleared)
+	 *   - Setup writing command: FIELD_PREP(SPI_NFI_OPMODE, 3)
+	 *   - Use DMA instead of PIO for data writing
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be written */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -831,8 +908,16 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
+	/*
+	 * Setup transfer length
+	 * ---------------------
+	 * The following rule MUST be met:
+	 *     transfer_length =
+	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
+	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
+	 */
+	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
@@ -857,22 +942,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_READ_MODE);
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 3));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
 		goto error_dma_unmap;
-- 
2.50.1



Return-Path: <linux-spi+bounces-9558-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F7B2DCAB
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC82C188F3C0
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB6B31E11A;
	Wed, 20 Aug 2025 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="FErfkhWG"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37431DDB6;
	Wed, 20 Aug 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693222; cv=fail; b=FKd8GIIDC5RhJfd7ScvOjmJSbmBFpphZShzhH4MZkppF2DhVOGz3g5bH+32xo/EGclgZAoNR1zXiwjY3hiR1G7NJS+2p0niBHGwK8w5qWi2FDjG8ERsvsjiPpjlLqTwGeyUoQU/4wtSH8wQ+1tUsEMHDFFlIPVQeACiFg6NAaTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693222; c=relaxed/simple;
	bh=FVGm3mceCUZpN95wDP33kES4s9AZm6PF715GAhavuck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IElJryaGvMcjYLvro7/Cnc/sJLsHDiRX6t5g9vwFGIwGPtq2DhG6ivA5RgI1Tmw9bW4KIa/yLNMUHaN5gV1TSPQsOvtrPuytJB3v9+AFkXoF8aosZarJuTJusVcNRv25bhonEwvan6Ew1S3Iz2LQ1R4U8r15NS0/4J/9jmFBF9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=FErfkhWG; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq7O2AORIJ2fQ/cOJNMHZUGoxjLiVWLXvQwwECzaxi/sWUElnBJDXrapPr9aeSPw5+X78sZbaG9WNpx5GYSwjmvDf7mGRZwsVTcm8o0gr33VjEt2t9ooiif9wsQPM4XpJ6x7zFHJc5qcw5rLPVt2Zf8X7HFY+a7nmKsv/DP5aZwgbot/miU5WzvsJA9H5rRe/EKjJBkCV+BJY3d/q9rP+KZhmmukFJET1gDD2wP5rE8a+aTYVVKtBxd+v9GpjYocoAZ45y/Wgkl2tdRhDLBoOTtrPPIPrF8YB5oPYTakl2p/4qoMHv4DO4QQ1tum8O4Ev2BxIW3ZMV4qW/f8AGk2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=552BNgYXSE2V56qFiRoQA15bstDMAp+x+kpR0uvOljE=;
 b=tAeQmvDpbsg13D0Vc4g5aR++ngUtYUMIgkrVTUN47NdANCY0J0GjJZE4vUADLbKZPfF0e4YMayL3v2VA/KpwFWPEBdsipvyMwgr1RSJa+ycDGnIpOnzrSOftndkQkE6hSSw8ZRyAmInwaKT05YWvFmzH/ZX9ffrBkM3OZSzBUnAgzwY9JetC+Q+kVOvd24djCUB1pELDk1GCYuFqTZ39AeT4oJbdpoYICJUyz6xv2+BRZ1r1RVcTz/wxb/02YpFqVTwZOQ/6kC+kZVropCixDee1kZ7KKdVv7y+uCaTBoLp+9AuaEgDe2WFfwlR4Dm10h49hRE+OtuefQ3/ow0PB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=552BNgYXSE2V56qFiRoQA15bstDMAp+x+kpR0uvOljE=;
 b=FErfkhWGsiZAIMeK+OypsCQrQdbffnEmcmZEAyi+uorfhnkq5NIUVmU53+BwiUOgW0G6R4hKFqC3Rm7CM1g9tXMh+DgJ1vR3Guux2PoQBaNau/xC6npf5mYj9eXQkj9bfZBiXh3sbV1ezdPOT8/bXL1Yydn6d7d1uEcWdJSYmbniWMSskVdYwDdPZXuJVZX2cX0Rz109u4qLBYYDUeNKHavF2DO0f8jmyCx6QAEI7fao00GR3+1v8SULpmzeAKetoOkgUxJEtfYjm72ziHx1+KqKR/WFD4+vocYa+QfwAxbP7n7roYcj8Lfkk+X+pIuVDRIkEOVzJn5tO00uQehr+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 11/14] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Wed, 20 Aug 2025 15:33:14 +0300
Message-ID: <20250820123317.728148-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: baf069c8-8f01-42eb-9915-08dddfe5c73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vMzce9oPx41U3ozJRfyfSZmPTCmjsmSGDO8AMAXQKFgsb1mNQHLVGzi+2E85?=
 =?us-ascii?Q?EfvhpmMbzHavkWBH+mvoZ2SaNFDXUK8AM1FcU3WI1yY9ic9xpFk9OPmv2GeO?=
 =?us-ascii?Q?ttB7LM+2u7yMYPm7Ud4BR3zzquGiNkC/YfDN3j5X/YNr8/XtAuQJqWY8DE93?=
 =?us-ascii?Q?6lYBiYxXZxV1W6OiToxW7wTvVuWGgqJSPLALkoMx1zFTNqlnzWxBEF3TWa/2?=
 =?us-ascii?Q?A9gZccL8rtcgmdz3tWbu1NdgJLoQwxgAW9X2ONajWt31seVMq1T9B8EqyVSz?=
 =?us-ascii?Q?0fUZynz9aZOpusN78HrPwfcvmmRDJU8wmxNpeV2Kmei155z/WDXXGBFA2/W/?=
 =?us-ascii?Q?UPvOVguZda9lzZeaVODYRT2AJCml5Lh8woC5YgAS7aEfdkpoEYse6SuKc+Pb?=
 =?us-ascii?Q?WB9NHbR0zCpP+NXK6svPL/cM9K+no+Nfv6L661O+smQjx1kzbYWLcJyB49aj?=
 =?us-ascii?Q?lRqvDWy2ixUUpZqfnTwB8T5yAza3eAnJ9b6+PF76WV6Iy+NR9lD7phI2kif3?=
 =?us-ascii?Q?ghcRuiU00ZOYOUgp/KrwsvQmIkQA9g7Oh27LfOmt6ccjUEcKWP2wNhGp9RHD?=
 =?us-ascii?Q?Bu+QZceq4peURpWrIIC1wNOTn05y14H7RRn7icq+bmg4fOlBkO5iBnpcsOsp?=
 =?us-ascii?Q?/u2EzoR7Vyw1piTgd9SlTmXp7A2p3/uAQu0neIVYWn7saXJjnG/HHov7T9Dj?=
 =?us-ascii?Q?PEJGijTH3SC99d5Dr9nL5o6lo4KsS0cNSJ1t9Ps6K/nSgCmD2Dd8gIoabGG1?=
 =?us-ascii?Q?XYWMxMwN13oV92OEAtMww7HCi8OIuphrMSMcSk8J7A/bGhxhV8b3oeAoSfby?=
 =?us-ascii?Q?NG0XMCg95WLYctduXNsCmxNwEnhz26AwK/qmGJyUStWjdYpbB3t6DvFIkEqh?=
 =?us-ascii?Q?aBXVDFTvJQKN5ud7yFR3+Ad7csPCdsOeR68W3DNggW4mOx3TKOEXTh25B+Si?=
 =?us-ascii?Q?qoa/U49iJ8kaHpH7/W9HttUcxDSXw5aeEcbJdLybJQ3RxeojUuSpCZ+8F0iY?=
 =?us-ascii?Q?T0GVFvuByeXaQuaVm9SfEpu1QnxoThT7xgi6/+z02nk43JwVRpKsLlm5vM0X?=
 =?us-ascii?Q?xMm+A00lKtUXkzDH/zOr0T9ZZTyCgKruZ5eAXnCAJKPdmvN8GUK/gWUpdHCm?=
 =?us-ascii?Q?/FVsDCiuX3UkeBfKP+Qc9vvnI+bw282LdOw0Nj1aSG5D9cO5anc87+yD1Tz4?=
 =?us-ascii?Q?sjlB8MJA3nVJgdoIBvAIAMd6xzY8EC6ttpNC46/rV3umDgJ9AED0FfG6Y1yW?=
 =?us-ascii?Q?GWNy8OB44ut5P0mIQSLfWLvJI42hqfHxwPqVq+64+rRlW84fz5oZk3J1m0TY?=
 =?us-ascii?Q?+fb9erc6M84w0wmXuIp8PkFVtMB0jxdBtwyGMVmlfVPHcvZT9BegWKoLd0vx?=
 =?us-ascii?Q?V/Nvy040486UIrojvwWFOXrrXC/l2OXCZ3N/+ysAhgzRTHLJ7/Wn5bUmB2LG?=
 =?us-ascii?Q?HVc2DJgQxSxjC0s33jQCT8gZoMnNkvCpsN+eCymyzHrB2M9U91/ytQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VPy3fCIUlpJ5enbS9ruPSI9/aueBoSeo8BLYUq4fdmdcQ4ITQ1jSfSyFHjKF?=
 =?us-ascii?Q?ceLIOCe4kXhWRX0bg3NgqkFOFf/lCyqnD3gGRfZvPblk/o1M/aBMSRHrVC03?=
 =?us-ascii?Q?0ygrvGBqHGYt7yjNHKI36PbpF+nTB+8+rMzbk2d4zGAPp4qBb2e6SLH0RkTX?=
 =?us-ascii?Q?YEzWHmjN31+u9PBO7RAb6/znFiQ54SaD39FvDCnBuP+itgvwwBDvFjtAqF9V?=
 =?us-ascii?Q?3XDUFCfDWag7nmuDg86v1Dc9EFjxYPs5A+mBA6WUCyvaTueOZOJYlu16/CZy?=
 =?us-ascii?Q?H29a+8vGsZlM2QxCFql6efvd5Alb99gVxctvAeCBHLiwz9w3Pydi7D/4ui1I?=
 =?us-ascii?Q?YJ2SBy+c7or4CfFq5NH923cAfGjdUG4eqVyI1QrW0fGOrNDck6cBct4bTz8B?=
 =?us-ascii?Q?eC2DvT2uaIu++MqBS2iFePR+a2ZiSzu0xQJOTJ/AFXY4jCI10p5ObQTlZEyB?=
 =?us-ascii?Q?rtb5UrkNf6DS3iGz4nLpzNpFbPadvF3wz1NBf58sJiJS4STurkXV+Ijt1qfz?=
 =?us-ascii?Q?HVUwKrbYgB/ZvX+Yf/UALiEhXmmv2nT3DeN3yEApXvo/KyAAa+bJgFXvjmNQ?=
 =?us-ascii?Q?yU7O4aYi/i3+tKW9NH/HuVVXc+g2KvqGzm+TY2DSFLkYrRjUQRMRt1GcX/5T?=
 =?us-ascii?Q?J1d9FMEy0ya8B6Hd+ksAf0rLVNFBFLM1wvC4YsOKVm3N8xzmV8S0w1gI7aB5?=
 =?us-ascii?Q?lMQoU9j/6vddGmO5DHMBKWtBA/RfaqNl48tGiFOUy9CfQJEfu8O2qhqUPa5D?=
 =?us-ascii?Q?9OoELv9Jv1aTVc6eSlpq5VqvRF7wx0mYpEFi1GEbOYLXRymmzUpmX2nCY7oR?=
 =?us-ascii?Q?fmKkM043Z1l+8AVGC+7PQcjsk8U+HZ+QsOHxQsI0WYh8plXLAO1RnxwPAwM+?=
 =?us-ascii?Q?UwkovKH5s9ExM0K/aDdyprSLp7/fuxkMfXxe6SZiq805E3Yi0i4q3JfdGhr5?=
 =?us-ascii?Q?UVzn2A4nmwgsXo55j2HPzUOuauB9hDTHHhtQtAU8gLYntSdf25YQRy37b3bZ?=
 =?us-ascii?Q?/zb79JP0zbfJvciXAE9kpeMMMYUvnQTAdoPP2mRU1ujj8+UqrGPxTfnTShgc?=
 =?us-ascii?Q?tp0qJxPS2pw2pFgHeZI0z70dv8P+rNT47KA8u6ROdygyYN/deE+ushypFvUP?=
 =?us-ascii?Q?C2yWoU/YMpiRkmHNEdpOy7T/Co4YZNi1TEObY79JyT9X/RnIQM/kGZyAg766?=
 =?us-ascii?Q?ip9rCe1BQOVtVQLdm2y2apSB/xFd7mPDkwv9QtXvLWNAOU6QeC/Dkx/oJbRl?=
 =?us-ascii?Q?IEnrcAZEbp9O8imyxr/p0SQ5P9f1pt8n2pXMNt189Y/rgOh9AHu7KzObFgAv?=
 =?us-ascii?Q?BBXidcC+BQNPdqlSolZrjOhGm3NJrVJYcbKT9vITKw8+5mG7KBEeLOxJI6Ff?=
 =?us-ascii?Q?sAMbMAmr7Mu2hqmzRFjydMXnu8cwimiwaNWoCcKKMOaXh4deoxYf8RKBSu5G?=
 =?us-ascii?Q?BSeFYxrkcO0QNovcRmWn/Qfm0AClmz8V4QY/g5d1Y4GQpxJHwsYMyYmcckrF?=
 =?us-ascii?Q?ZAvIcdz9exP4zvbzcwTFFs1q7n/ing/Y2ZZhdgdxayUvPsp0+b4r6+p/IU7C?=
 =?us-ascii?Q?ViyaKg/7NaB+kUMhnza/jX8EQOci/2lI9mnpOBNEfyE0UvP86eMXxle6tkj4?=
 =?us-ascii?Q?hHvvWMhZqsB0E7giaDIOqs0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: baf069c8-8f01-42eb-9915-08dddfe5c73f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:34.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/T1CHmTR8CtaP0f3VahaqkeTDUNTUSAahjZRX3IAWVJi2qGs/SxCH20aLBf5J7x46+2yEUTdkGJbqrPcZNBdctydpGaLoGxgPX4sP0JEME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 57eee658fb30..5d8e1a233d98 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -516,44 +516,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.50.1



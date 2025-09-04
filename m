Return-Path: <linux-spi+bounces-9906-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D157B43EAA
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF917AFF6
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8113112B3;
	Thu,  4 Sep 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Y647jCLr"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021101.outbound.protection.outlook.com [52.101.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA130DEB8;
	Thu,  4 Sep 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995849; cv=fail; b=LGSlA7/emwyxZSwP6+EgRc7oJguAvYOogEgE9CBFoYL47TgItyy+jsH69BVONjcXiM3LQKYxHcRQSq7BVwoKa0dTx6VpCGgIwQ23aF/DBIdz1gWnkfe0WrmBJ9YniLEeHObgRfcAISASZ0m26A8A+vLVJHDtgYduIw2lRzD0vV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995849; c=relaxed/simple;
	bh=9XuiH50tKdVRvzSv2heLofF2LN/sL5KWv9/5UPvj8Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCLWsKsuYLLf2iB1u4Lg6Vg/w9nMwcL97XYlsQVXZ3YHT8/wLetq45r5zCENUhegiGQp5Zm1fM+e938Iu+3D8AdeOSAjPMWOwmseybcvBJZ1JlY7lK8UGFBfZwuUgwDx9+1aj1Fjw9oFX8xA537Uiqiy7skd0m4nFjw54K30TWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Y647jCLr; arc=fail smtp.client-ip=52.101.70.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvixLLY/CzPWIpaCt1WmyKr0nGEac2fhSl853PojS9+lB0hZt6SdSo+sg7CdLubcDzokOox6JxIG+3o6t/EdC8d/VouUlcaP5CHD4QP2MRoHxwU2ODA9WF+ocHZwuoH6MqDsTTtBlanZWyPmM0wEAlqWaf+kAVIZsahwxosrad90LgYZ8lZ+M4RiaIN9v+ag3wd8oIkNTBjVmRZ0Hit/8uEU3CM8Tfv7rlnmFKKQJ5KOCsZNnziza0dP9ujeISeNfpxHdLp3JDFiA37kbXvYw9IAw6yLgLvkBMwP6aofY9JPzD0jhOVUHhLNgKu9bdaZOMvCrBizRa7N7P1A/NhEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9aPr2dVgLydMAozF3g0hYlfzC3ZcQd6UmrwXJ1HUSg=;
 b=WOUVgTqjl/LZdCIHcX3gYwidBBioDT2kOfvHw2uKfzeaFtMdU5MQWPOT+YAnIIQdCVTPE4/YxZqKGsGUkkaGcnQlzy4Uu/2RjwoP5/jO8URGWACytVbWSo0ycHiVFCBBP8neLIlL+7fx5hmLQun0SygLxWoIKAp0tNThpgf9B1pUzU3b9angJ7S4l8QIlh7gtkMWjy6sxpff9hpNk32XOoCFDOJTFByhzR2PJrCMAJPx2SlmdVzyVz634f4tw+QaE0cLYo3FemmyAZehoNg6SsAve+RuCGqZu8ntqLQ3TVxTRf8nsm8e9a++IBjNR0f9Mlc4pV1JDrr09y7ELcEN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9aPr2dVgLydMAozF3g0hYlfzC3ZcQd6UmrwXJ1HUSg=;
 b=Y647jCLr+pu5FnthtB2GzZd0XQGqEoJBIkugYamlHrhgtMamAQQIHjJZ7z7pznf+1pG7he4qMBIuxzKJ6WGQJwV96pZ4X4ww/lg4dgfa77p8aPRq2iSkiAsrd860HPnnMzF8lgAh8nfs2rvZdCq/+q9vI0bx7xQZR+PcC+uNzyHQ85BsY1pw0sTmpCZM460lUgTh8x6o7MUIX6kn0YKK3Ei4wmzjGhcdjs1jkSfYM1BfwGylrHgno82N6Cz2RqSjpZ47Iz2uMkrCn7UlGuuYM9+eEcxuFu5TmeyHNTCzvl+GxLepMedmeSDPMEh20Ow4yohQlD5z/isK5TEsB2A5AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6436.eurprd08.prod.outlook.com (2603:10a6:20b:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 4 Sep
 2025 14:24:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:24:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 11/13] spi: airoha: set custom sector size equal to flash page size
Date: Thu,  4 Sep 2025 17:23:37 +0300
Message-ID: <20250904142339.656346-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: f1236f71-3407-4d75-3525-08ddebbeb186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDyBLzZH1zUkC9u7ld/OVVSH3Cuy6MKO/ha+n5mfyYb4xKhk2QsRGBVbLmVD?=
 =?us-ascii?Q?cCsj26r1kwYXVX6fBNkcf8WlU2e1en/tgOBSYhRQKroz+Wxnsn8m/V8bdFmO?=
 =?us-ascii?Q?bRBEdTvSllsrbQ4N0oe4MiW+iT8PVYLD4W30b3mzijoLVP6oeyuj+6tsu1/H?=
 =?us-ascii?Q?3jJvXe8wybmvSYFEgy7cr0F559GxCj7bBs2XbZr4DIca3rTeX71qFRk5WoQd?=
 =?us-ascii?Q?si0nNTJmXYOHYaT5DM6U8Dxm+ZSELPjq+b1Fllw3+T3fe/YrWzG6ox5KvF5f?=
 =?us-ascii?Q?qKBisV//PN8gi/nIUpFBuo++Ao0R6CZaKg/+n8HkSClwc+KXEMnlLttr4c1p?=
 =?us-ascii?Q?aWa1q1pXZ2xCbnh2ZMNpX8fa7LwMNpM14rYrjk6EWhctgEyEZx936j11ymAn?=
 =?us-ascii?Q?89SXBqBbu+mixUiLUrRAwxOcWMpT8ehOk0+2fWR0dUI8Z0zjKRhdRr4hWAD/?=
 =?us-ascii?Q?cM232ZKfYLPAGFIkwRBYgJl9riJdrA+IFGrhE+AXs7xS7QvYoj4vLTmLvTfw?=
 =?us-ascii?Q?XM16jpzXkuy8Q2tBcP1ROdn5QlgU+a2v8WeMRqZeFkc6BlDjHMFOBImvqjDP?=
 =?us-ascii?Q?HjbklEq89ru4Cuo8q/mI2378y8uQzAoOvZWWR/W0GFAkuHuousfho8ssdVOk?=
 =?us-ascii?Q?3kYha046mAalPauWZs0myBff4LJKjcFPec7XnH0sS2UfWfkivb9r/FacV8ZZ?=
 =?us-ascii?Q?3+EIJTGIZpqTaEX50WDKaOoyxzKmh9wEHI+ICPdR/VtVEEjZ0lTiLFoogK11?=
 =?us-ascii?Q?05splqsyDAWWTj3ld8rSpgyxyotwLHzrJdd7bf4SVtqdWmD7UBdLtg4rVYPV?=
 =?us-ascii?Q?nbZ7qOL/13O4mtoXu7rAGQbBCIdPB2MAcZoYQNK6S5kNtKS2Im/cAiWdYIOs?=
 =?us-ascii?Q?6a9nhY46houZArLVmjgi2bJGC6Or7sCn72pyRIMgpLSBRCtlfsMrlESYRHQ4?=
 =?us-ascii?Q?17+AaP7pDWCYHISmg7Yus7TueSjlU/Vxdyj63YJK1rbVJ5GPm/PR0NjQQfde?=
 =?us-ascii?Q?HSvTRt5tvZvjehkOHQEK4BEGxe3JXk0JP6/s3h2zRDlwB8zIU3v5v2Ij0jhk?=
 =?us-ascii?Q?7/OdC9Oc8Au7RLUmO0RzpQ5vXsQysvVaH0ULRFz8r4C6BfX/nxTHHVuVX/Ay?=
 =?us-ascii?Q?NMj57Lpp0a7Jb5He5FiYQquuYkVCC/0/Lpn6UU6vDSf1BaidfBP8EfCz40PH?=
 =?us-ascii?Q?EldzYXvGccL4CTuau9NCpM2jKRrdAnLXWxZpZhB/8pPqWS9Y8/KENEjfeA9I?=
 =?us-ascii?Q?fonuiXwuPZeQ2L1aYKNPh450KMMuzUpebbEX8y7bOwltxbZJge2a8CgW6g7r?=
 =?us-ascii?Q?73kn0cQM5v/PS1dFJlZqAH5NGQ+gu7xbFT3+ZOQRvGsb21OFmQG7SXBdLYF8?=
 =?us-ascii?Q?SaAkm3E5/S2HaCa4zi+9kILQt2f3F/dMTN9dlQp3v041otkDfPA4u4xKZYTA?=
 =?us-ascii?Q?NbgOwIN8HfFx+KSeHOsO1IVzJdwHKaIJdysDvCEjHe6gXatVh60Lgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Omuq+mfz0ouCL1a/VyjP3Ort49JU39OMd7iIY2Q+4F7UczFZI3fG9phlWG9q?=
 =?us-ascii?Q?rtW7hNS/qQkpolrTicaP7Cd9YU8zHsU4V8MRQZHmN5ZteQZ0icqtyjvCnHOa?=
 =?us-ascii?Q?RgIDSx4WXrCHJs9e5snX0V1z+BH9dYqT1hoohs7sH+2ot9mALkOUh8eRO+Pk?=
 =?us-ascii?Q?s+Ac2VRhdmUaHxSglLwaaqBb3DUmoR7fDDMG8QyJ/Kd+/4qjjzGZRVpPZM+8?=
 =?us-ascii?Q?Uc06AyneNwbYHoM+LWDfLM2hAcTdgzGMXWTJZ0/qSNLRFsvPGl9CD/L6yLD4?=
 =?us-ascii?Q?kFAy8F1fEsZwqfQgeRm/JH3WfE0WXXpI8qyyhqm+oltAgBn+yq19yqjJwdYC?=
 =?us-ascii?Q?rgFSBQjfqnPTwZwm5D3/6mjNOgKtoDjAoeNKXX82cDUgixNBHwK/SScReIA1?=
 =?us-ascii?Q?jFFRfM406dOFXIFz2+HdDYNZngz78RvjUQRyFPQ8MCh4daUSs7meks1HqVYd?=
 =?us-ascii?Q?V8Ppt3PJsOTSHYEdbW0/XYIQfR2Mf0cd1mm6xe9mffsMK0rICMCtSliejytr?=
 =?us-ascii?Q?6J8ENSuhWZUnVq02HTZ0fEi/aVIyXZBOzRin2U8VJHvmBDRNNIAYyMtvWKJI?=
 =?us-ascii?Q?c9QeH6xFzsEF2geqcsR4L/qCM0hUSHHKGElT8+nFCm9kDwx+44xaF/2T1R9h?=
 =?us-ascii?Q?dm8F0NJJwOxKBGOpISFNCpnaC/oQ704Wkd2Wir/iMkJrJNUAONaHpOes02B7?=
 =?us-ascii?Q?cm9kkpZw2xNkFnwImN6JBJ8Twpo8HX3a9ZkT/zkNAwACoUcg76Mskb+dwKdc?=
 =?us-ascii?Q?tv6EUFSdX+dZyIygyAXTdxr9g2wYW5ZpX7aHfNCz0spueYWiDy6fpl6D+GuF?=
 =?us-ascii?Q?aW01kIZfNcawXsg3FVSDckNcSuqh6Q7qdvd+byLSAZGdFsncl76Hb5pLEIRJ?=
 =?us-ascii?Q?XtiuqWv80JP6WgXaoYgymg8EfUqu6rU8ryb7qbT21oOpPgXyUX+nUNa3THrm?=
 =?us-ascii?Q?GL46IE5U8Onzz9R1UcTCBLLwVci7orzikFfGuF3y88cTSXM2AHhpmqZlDyCS?=
 =?us-ascii?Q?6NogyONddnk1M1TKlbgdNbVKjycT6MnQX239CDFPBH6m5hid6zZeTSlxGDey?=
 =?us-ascii?Q?jMM9zFVP/5/APwfoMYiApKNqjMODK+csu9TsG5ybRfvV+x0FOWJOIRYVA5e7?=
 =?us-ascii?Q?H0NMYfMHVKVglhlHS9IBL8stLM5nRK27OWS7qLi+NIoNIlKVypbX40TSHBsM?=
 =?us-ascii?Q?ynjs9T97IXFfuyZQjoWmEErn2lsbwDF663TREj0hxBd0QmO7tZrr2XmMLxGE?=
 =?us-ascii?Q?e96JXiOQpeZnu8RX6usWvnAjv1x9I9ofVRjk2Z4R0HWTezcJCeSZAmQ+WqI4?=
 =?us-ascii?Q?EB+9A9DSUfFPO8iccGnQ27Wpayu9wZzUTpeLd0bOJU5CVJ3AgM+q9DJP36VT?=
 =?us-ascii?Q?VbR5hu4Ih25XVn0H1rXzzRQktuOnw1R9JoNN5CfAy9cXxn9b7OFZwt8KBuoJ?=
 =?us-ascii?Q?QHJZmVcmLyIVr1//oPYRNQleNefCrfsFDVr69IoJHkrXlYjbH1xcSXHoVZex?=
 =?us-ascii?Q?2pyDfemUAMAtRPodVX1eQgNyLdyhMLK3Gfx41T04q+2arMTs8CvFqJwIcZof?=
 =?us-ascii?Q?qpaItM3t84av9Nt5pCtnHD9yKPMQOj+RJUrIIosnqQowQ5VeKIxbLFiSQh9s?=
 =?us-ascii?Q?Dg9SWIZ1sWOKp9EOH3shlfU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f1236f71-3407-4d75-3525-08ddebbeb186
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:24:01.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ucm/bRgJZ48Vq/ffV+szeyV5X/HF2eZm8nWihfz2OjIqLnhsiHiFuoH7fvYJFbtXL3UR0u62XIBWAXMdn6RZ7+4/UtAy6midvQLz8joFk0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6436

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3fb76e2dd5e3..babf7b958dc3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -519,7 +519,7 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				 SPI_NFI_SEC_NUM, val);
 	if (err)
@@ -532,7 +532,8 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -635,10 +636,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -697,18 +701,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -733,11 +736,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -826,10 +828,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -880,18 +885,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -916,11 +920,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1



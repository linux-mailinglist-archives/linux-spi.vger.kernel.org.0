Return-Path: <linux-spi+bounces-10369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6693BAB01E
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27A0189E620
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203582512F1;
	Tue, 30 Sep 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="4C8hXBpu"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103992475C8;
	Tue, 30 Sep 2025 02:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199249; cv=fail; b=GmkoxsdBoEtQ2/tpxc2PefdtgVNL3MdplhOn3H60iAbd1gDiTy1on1C6Zy7446AGPbl0cI/xBJMvB1ON9d4BID3AsINl995msPtoQBn/9mVByNK9wjbN1GigaxNZRJkkUDzdYwUbkDP3JU7Z+J+gc5m7CnK/VFRp2+6Bon7It78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199249; c=relaxed/simple;
	bh=iiNlxnVk+XHjgvSizldsOXrUqQfg6o0YcSIFFwnN7rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0h808EtEw66xoOHsn+5QegY06jQG7qtCtDrRpgqhkKqDD40jIQGUoYkra55elVwZycFtGV8ovSMmPbhq1LBrPBDYOXIX+oLCJwUhHtIlGefm3UxjC5Tucxliajg2bhUkgOQ7M40B4M56tgEk17QLme01EpwwN9TTZDDU93Wo98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=4C8hXBpu; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqCbZ8qddesHfwVqqOiaM/RcRlv/CrJ7bIvRz/y5wBte6ezNkkdLtbdN7qW0sDoPxHjsmNQgw2SPpHa41xZbi9OI1UtQUdlgrfQQbyZvyHUsBuDOf9fVTlEnPevf9QluD9hiXvdM275tOy3K9pfzapZ02LZ069UYcMRAxASRSB/e8/lLYXNfdZYmGIS1k/2XkHkXR2jo+VKtuOfl1qlQXcuH4jePansvVy7Nw7CRzBcm8GbyRt+bdlebCFiVI1MsrwOmrHVjufgngSUpM5cCVI6KCxYhBKHlP75opIbpu6mtqsNeORdT1zoDS00KGwhEoe4ojWQ2Y3dScPy6Adr9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra/m5hu3mvjAKPyQz4VCksNIIyG3RTGX/ZNnybROd7o=;
 b=js/eGol39rJCTmj5EuL4avyk0YEhBm4qYq5eHF3f67n+FZO7GMGOCSi/nf1mQPxMEl2Qb6GDwLzW2J4NYyBLb7CvjlxklVZrky/PXTT+Bmh7MXAuznjvpSvwocXJE9JHaU8lgEI+V7v5zNFENauwVtC2pv+Ck626XXBzJDepTRvhnLagJVkkHZRF/hO3Xk/qAtYjURjgOdpASbdc1wrGQieJJ86vti/UrlRE0x0unDRrjMZ7qy1crha9toU20AMREbCvdG08M9016XziFeTL9wJUHla9U4Y9/OAFAfzWfxSlZtrgIMhVj33P0UfH/Wq0ijbiKaPgDW2BjS3/M8xWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra/m5hu3mvjAKPyQz4VCksNIIyG3RTGX/ZNnybROd7o=;
 b=4C8hXBpuKaysn9bKtQENaufJzLn5LqtkUHPNtrbbTyHj9rngdX3rdNjdMZnqUnQHW9V6QRpt9fNQiBqlMy8ALyKQ8yj+O0IOvBhxLh60zm8qcNNrM3kOoeWtgo4+lfOg64NfbwY1kFt+4sTCOhbGN+T62v3bcF63vtGfWED/ypoxoDvy0P79OZPMTvHRtm1L3Y6koJgDliuv82XgtcpCXB8A9O4slQGFeh84WXo6okShk1sKaYW2E0tHJpTLn47W5XqllH5iZh6s06sKoaOZ5P7vAYrkj3sfKDCJhpRQiSYi1NO1edTr7boIZBIgdkTZYxPElcxMDukNq8hoBHqNsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 11/13] spi: airoha: set custom sector size equal to flash page size
Date: Tue, 30 Sep 2025 05:26:56 +0300
Message-ID: <20250930022658.1485767-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006627.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3cd) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: bced0689-2d90-41b3-8861-08ddffc8dff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvfu5qFzPYEnBugbT8o+p/gCsOEjIBCMStXEiea0EFEO0YzD3LW6rrUHGHxd?=
 =?us-ascii?Q?oIc7xPN1fDXNIsE8VatYJq8GEbI/IHHcql9eD9j40TqUEmrHmAY8jKiPhR35?=
 =?us-ascii?Q?ww97MLLK0zHjhzP4TkcBaPxUiX1LfiVRzfnyUMF3sOL5kLuzsI1Adp3hFovq?=
 =?us-ascii?Q?EpQFHquCzkLsTX40/NkDzG9ug71m6T81e60Ln7HzXth2IOsFVBrI+aDbT/AT?=
 =?us-ascii?Q?l66ScN/umZNjwSAj3TYiAmjythbX4GjDy6GS4FzTpTiCgEgGFnd+BdQQGDqM?=
 =?us-ascii?Q?VJVBUDpSYx5f0wnLxUNK8Y+djLvYz0JEIdecl9+GdkPcUS8Il+uLv7XNvny9?=
 =?us-ascii?Q?8QrRQT17jyQUp4BK7EJrHbGSkPa/jJWK730hZoTwEN+aH8WBy3txcFz2qQLP?=
 =?us-ascii?Q?W5IChf8lMatTEj7jvU6iJS/x3g9KKYdhjQV9UnbDL6Hhk++tFaPocOfyMpSG?=
 =?us-ascii?Q?o5mwW9zLvuW5zPYtwRvF9ZAh8WVdVhfm/LH4bHJrYSlNCOGlqxwUXlxhrIE2?=
 =?us-ascii?Q?Y4kUHHSUasI6Qjqm95V4tLiR5za/B7N01NdvQXH62N3rt1yJcdOe+Vd23H0S?=
 =?us-ascii?Q?voh3icowASLP9o8K5+gG7ipCyElYuSr6Q5EHuOTVAYviT2rfUej0RpfEG5KI?=
 =?us-ascii?Q?1UOypJ4FqfPqlZQQoSXE2Sr5DVFFD+h1gANqbl2G/8YHWNk/Tru4Z5+HQly2?=
 =?us-ascii?Q?Kt+wKJeoApqEzf2rpjL4VEOIF07dV9tkKIjZb5VNz8qQUktUik1oq/nv/d0j?=
 =?us-ascii?Q?zR6b3Cr470kLeJ+1hap+qmaC+ZmRmah1vFmbRbH2EpLKWVTzznmy8d6zujW5?=
 =?us-ascii?Q?f25dcgAzRCErkEqXUW6Xr0Q7PTVl1tfioMws4Et+udd/n9CwIra7BkNQ42ui?=
 =?us-ascii?Q?2Gso1ytAff91KlaZkVbabDeL987U7a6kWLG5vGTnZQl4iSMICCb7JsBOUzyZ?=
 =?us-ascii?Q?LR3ZYe2kOQ0mGMYvi31OelZa9W3emLd7zMZAF01MpIM1PTrb5Z/yBe5Hskuq?=
 =?us-ascii?Q?z0XUpjiC4PZpN2aChmG4oK+3cH0FZ5KwWO5IKzmBd9HFcROIyZmTktiq/F01?=
 =?us-ascii?Q?hfRq5FAAQi3FPX/rYawbZtVI5V8zgDokUZk34NdQ6Ge9lBlbGOwuMqyK1mxG?=
 =?us-ascii?Q?bCuStL31ZhDJflG48zpFW2SHeL1mjlMK9AoI5UuN5jgpnk5fRakucnpVeJyP?=
 =?us-ascii?Q?EFMmZGZpZFggbFdNMxUJh8+iM0XLI7hSUze7XjvrccWT4ZyQOyDW19ky062i?=
 =?us-ascii?Q?oAIY2oD56M0op7kR4MQ3o3MYxhsqeD+5yO/eb0yBomGlj/S/WNbwNgjqO0gX?=
 =?us-ascii?Q?SMUZRV5o/8xtlbLM5rujMfO9R59w8M6VFaPngWIKywMPmIQHEix50Mw+odQP?=
 =?us-ascii?Q?IoA8W1KBedwChdCTS331KvUnjPUGqdU4N+AiwWmOROr4D6ADxbnkIApGz+2l?=
 =?us-ascii?Q?zjEGHGX/3pnxrEkOyb4/01FaNxXLB9lqKfLh4/Olz+z0rOCbjyy8BlNu6Ll7?=
 =?us-ascii?Q?7/OxYbAsf8dByKkVhDxDD0UFDv6MY37Irsai?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b0Ik/+x+0d9Zr33N7wYSSugVORiI5rUswQiyaESbeidNKtYNUUmLsjRuyoJg?=
 =?us-ascii?Q?kgDScUsTCooMUGkaruaaHrMmbDnTgjEaSOwNZYhj22fd2+Fa7NDPTlompsgT?=
 =?us-ascii?Q?iv9U855oFHBhK1erk9igHsVDnxLb52ZGoP0OiyLfqwhFO5u14lBOqOVl8Kce?=
 =?us-ascii?Q?1p2ajlbwwXlZRLGYgyIHmDvCSWiK0I35odffTz0l1OlInvuApyMhO2/Bh8Sf?=
 =?us-ascii?Q?TodayZDu2CC89cdNoNRJbh95/HiWIk39dUBu7cO8BVHAupSi5Lgdw02sPY1l?=
 =?us-ascii?Q?ruDFfMfp3inhiEwVypO6bYTfCuy+7AdwkwCYJMMNZ1DLM/clZsihuQyz3IVg?=
 =?us-ascii?Q?qriOcMlTCc3eAq7/jd0rDmup+TYMXhmKHDxO/D5zNxsCKIv94EHkiNEkcSzt?=
 =?us-ascii?Q?puupFb7uv6QcyIkmCnOb0M1anW1SIe3qxi5RHETcHPiZP90CZXQV0/Ei+Ytn?=
 =?us-ascii?Q?JLNKjVpylpesBRCpG5penxwTPwX3d4poYl+3x//hXRChdU54WfPa7sIxpBAh?=
 =?us-ascii?Q?naMrk/833AJuTeFXxrdq7MN1bB5slfmpNIhN12j+yJI2Rdnc3O0+yUQ7rxc3?=
 =?us-ascii?Q?YGFYsOwZ1wY4FBLei/cdJFSQeDrWTb5APRfOf7FbgCFpUCbROB5JFFxCl/r8?=
 =?us-ascii?Q?NwW3CDg5qCQonwg2LiIKfSrenxbdPyByC5fv4oVxdYmwFMt5gGkpaZ1Iy2sV?=
 =?us-ascii?Q?0wXQrgS3SWVweefcEWaq7n8YEMEyX/l2XLhnEA5fMuMO4WySA77fXJEdjQbm?=
 =?us-ascii?Q?wcDWZxFy0uHxWzVK16nGuK8wlvtwQUUiY5MZpOeLnPy8vbgpts0y8b/KPw4Y?=
 =?us-ascii?Q?Cgaj2BlZHdXAq0rknp3hPbL3cDAKjeRGXdJkaO1l4QS8Zu3iD3ZCN1nFgZ6N?=
 =?us-ascii?Q?42i2p54igZXH10ABntvJb55P6EavtsnLbtjnlRvcfLd6PiAjSOjqoHAJZQCp?=
 =?us-ascii?Q?hqSjebnMzY11k/FJqQBRhe6FEdOi5gqoPgCLGVHDUpALg+e30dDTMdbEkkW6?=
 =?us-ascii?Q?0w3X6HRPmosngVpRWhz+LyfRYB7ViBFSX0fLwsmaYAO86EmMeNnzlxYBs3ua?=
 =?us-ascii?Q?1j72ddAfEx+bysoWxDj91ejN89sQAothlr9HkStlr9JoJyIGvS4dlNEflySO?=
 =?us-ascii?Q?8dEl0zHk3HtziTLhw7lUyTmrym6ALuv1huT9zpX9aLDPi14LzJAnhO16+8KF?=
 =?us-ascii?Q?8t/36IrF0TKUNhTTqMFTASCw6o8XcaSagD7RH22CNOpX60GQyL4B14Vszjjk?=
 =?us-ascii?Q?roDnTPYsojwXH+O4Xtodp02sBsWmbk0csQ3vvziDuounISoLImNK14sFv4Um?=
 =?us-ascii?Q?XjYlvQvp818KL8g7ije4UD9zwfeNeYbyJA4EaAOpRSkEdpWFkahhHbsQTGk4?=
 =?us-ascii?Q?rEp0A6PrgFky0eOCzMdEPoknCDxaPpepNgf68xnTlnkZbgbe5aMAs4elaUIb?=
 =?us-ascii?Q?9S74Kv9pEMrrPQxONdpWiaP9myIg/bhDKGlfwVsi6+sB2G+/om3OM37tKsG5?=
 =?us-ascii?Q?LPdQZYbBu/7obM3SABrXc+pKlBhF+AwlwBGZ99ix3VE8mkCkkmh8SZCckOiZ?=
 =?us-ascii?Q?D4gIouc7PbCmwatipkYL47YcW95s+r7yHuJI3nHjtwx1ofRSxPy/D7S4jztW?=
 =?us-ascii?Q?BTbNrXMlXzMQo+xP5SO9WPc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bced0689-2d90-41b3-8861-08ddffc8dff5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:17.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvcgzWzpD+jnXtf9DVChW1MCZs+ago4V+Pn3V/DUSTD5tBPdah7tN1oYUh2t5HH9ql8snn0YgIxktmLdwGP1igoumDqRHry1QnzjhpgYnzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

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
2.51.0



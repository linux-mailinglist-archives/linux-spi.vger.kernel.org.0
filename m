Return-Path: <linux-spi+bounces-9624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2315B325B2
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A7FB60AAD
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0971DB356;
	Sat, 23 Aug 2025 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="BZnjJOZl"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022114.outbound.protection.outlook.com [52.101.66.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414522E413;
	Sat, 23 Aug 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908215; cv=fail; b=JZbPbjQIsoa61/0MAlHCy2op+OjYWu+giUvJ5KJn1RoZZ1DH5ar1a0lmNekdfqkiRsIAk97mPWR8aLwdXEOq08w7FKTHiNf6iuKx6M4YE9ieOfUCRX8afbQ6Mzzw9x9pQU4gcYP4bYuXxxKr7vQ4p3EVt3bud209z8KAwbCGTLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908215; c=relaxed/simple;
	bh=9kVDUXlrwQdXiWoJTFuK1J7P+QGBGj448VGWGoEQmsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MRHkYzNQ65ZS4fA+hlluahNcNpnwBg9Cqj3Cs6jSxlQSeSAe4tp4UoRVrJ2Z9wkSwrYwtGLTgfx2UvV01KZwkhccbPUPFJ4HwjFN5oapZpwc2/z2XK8GQ8p1hhfWd6UGRI7nnjE8HN6MTj12b6Zs0BU3dtNE5wG8NLUY6/GHyts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=BZnjJOZl; arc=fail smtp.client-ip=52.101.66.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+ZbawH5YE2QjFRtJCd1QjIr1A3nIzqbjrGTRWm71UH/JW/ZkmcI/EuP2XxbPsbUTw7EwbREKIQmcF/VZ9zdH8cMVG8Wysgu/D4b/RK4aXGiWyaNDkt4GfsbYUQuCi2xguxIzw/5ncA30QrYp/qty7V2BgXbQPYibPYdKU6j23LPQtQLRt3JUE3P1DRJRgydPW65SMelw+SPO3913UuFCehVHGO0UTj+d7uygd2FlRjRvg4hO3GGRh1YFMcjUBeqE1C9NqUVPui5Ts3jgmqC2rsGWGGckd9D8O3oUk7oX291yOoxL2/dcC2JsgrcZilal0rULhLWFITAQUHqE6Hrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkD7GiwOI7V1Iftb0suEfTUIGO7EZhVRd2g9r3hdzfE=;
 b=mvXjjfd1eJjEyHN+qMgOLVJQ0VI2K30NDs4vp5Rno8sGUTsGn4ab/9yX072Yq3Pcuq8ObFx+aaCzcj0kVSjXMwWt5dFSpUq58nMmBBR9A4ZVCc1DCFmxmId9Q8uzKip+LpVxmKSZpYXUMCBm0rLHo3zBw50gMZEyNtu4VMRMkSGHkiCeM38f6GAMH0IBqMTK2a8VgK3Qn74JpFsJdpG+EU6oNo8zlgWwgKp6B/CPDus/+S6Oh+3CIrxgkz7dFQPxrwvcONIp/7DbFVurgybGrz5xRs7zNOz0HV1GSoVpZBo5CGb5bgQClW5YBnhD/4TWH87c/i30u0VS7qG3N28IAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkD7GiwOI7V1Iftb0suEfTUIGO7EZhVRd2g9r3hdzfE=;
 b=BZnjJOZl9+SXZ3/ABVFZNr2fdSx6q1hnwbCkIanvWVnMz6QR5YlrDXJCNVAVvcQQVFGXcKBrVNC20jDCiKSlDRf9rBuxHX/W3VUDHUXf89medn0qNUODUFSr6KcHxm4Y/SU+Qwd5Zj76P7PmIrgqqWTh4zbWgBj5N1m0lR0l3jcNHxClLz0lOiLke1oLzo0cGKFm9GazPlsEMsrjUwoSqa41nAJLzNN/4y6WMbkfimjmzbKgMhJNEdKSyax5H+fkIYOAkcoUFbAC/uKHEKIB4pZxjlhnIxT6mEVxw9FTBE9D+lNHob9mJrNbXcTLeL+2Z1higFWx1/Yel8NWXTV1Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
Date: Sat, 23 Aug 2025 03:16:24 +0300
Message-ID: <20250823001626.3641935-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: db426775-009d-4f7c-733e-08dde1da57d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g2ZazV3kvLSiwkgwfvIIXH29NVy73yVGccuG4J+jFfjB9RoO2+iMOf3BpGc+?=
 =?us-ascii?Q?Ox7yrtuIusKnfCD6ltCkH5tCzq1AxNNblc1D+VxxzKfVZVomwSiVQPfG/c0D?=
 =?us-ascii?Q?mHpdsMyROzYzyT2rZRZhEkKL5NINA/H4SK+G9rlEP21QcQLs+OXJRFaQJR6Y?=
 =?us-ascii?Q?+GlUlF3tvcsVHQ/cH0wxVnyCZMQfKynbEEgHc/pHtuxuSUErmtCwu/aCuiHh?=
 =?us-ascii?Q?A89guQu3h70g3D9PJRE6kKvu1MkGE2AhKKveok5I+BSuBaheg2PUnqZLso2B?=
 =?us-ascii?Q?89q8ECrNNcflRllcv4LGnWKPdH1u3bYaVOnzsOYRoA0i2QzSbl3Vuvjuqz4+?=
 =?us-ascii?Q?wC3C3jXGh+IcplxRL06q44IbW00RbiuoR7Soq6px2fR0EktzkWv5bWlXAN1x?=
 =?us-ascii?Q?2ziGR6jFKcS+gfa7Tq6vOPmdzCjLf0/q/+wtS/oGOXJDhfr4fKSAMD37vHWq?=
 =?us-ascii?Q?qTwy/dDOgQm3/FE6nlC3jyDmn/g8UDkjBMOffxe2mgSJMM9/srqoO4EKv+Ee?=
 =?us-ascii?Q?sa26qIMUze4PutD/Dv0RTeGpxY8HcVJLFqnJJd9EwJiNyHWQ53ro6XpGpBxc?=
 =?us-ascii?Q?cczB7mdAQHqPCtP31iF9owvFRcnDIA8VwkHF/t/2trKBt6h2XWlXbvcvBUCN?=
 =?us-ascii?Q?X5lI1Q0tuV3SaIK6MlxvQz46FaoXX+7BLzytA/3tcES9PLltuC0W5Ft0rIXg?=
 =?us-ascii?Q?AHSpkTULYO95r/7c+N8G6boBWb8mOcaMa0Bd+ZQj2VTDgkpMjnMwtoASQEEq?=
 =?us-ascii?Q?/ICvs7e+sA6u5/7iIg9Z3WzA2uV3el26BwVrNv9VnxGYLYiXoPqaU9T623kY?=
 =?us-ascii?Q?yb/Zm8nqmPR1LqobzO/lD9b0+QSlk8hvUN3xEvWOVLuiKNWc99gsNixWMJmv?=
 =?us-ascii?Q?cy7gSGJI18u/c2ovYtgOUzKP0SFsGDcDpCVV4cO0uTiRk+EI1Igphu/BT3aX?=
 =?us-ascii?Q?pxizNcm/SLzL1HVXQQpsEPSnRoBMaqnsx7YNjFdtH4ufjUqXdlEyWUBszDIq?=
 =?us-ascii?Q?Zt8AQKFMuj7W5bHsDBaf/k9fcZbIIt5gtAdlrb3ePA9elcvGTDxwoRkc9NGX?=
 =?us-ascii?Q?kIlQdEX4pY+tTDP0lQcx3PGUNCSh/jX4D/yA6zi+2rbDimsCoa2wVtQISnrU?=
 =?us-ascii?Q?YMpJu3r+cwCo/C0zGQMhpsUCcQJWHGXG8KP3QPnQm1u7VZU0bA7n5Lz6MS9y?=
 =?us-ascii?Q?CYxmt7ZMd1Yk/PolZYz7RFGKw2KDbAIqYZ5Dmp79vE+wcYnrC5GlQBZLfZgO?=
 =?us-ascii?Q?ExLpKYq0j+qngiLIfjnXcPvdVGA8AVic28+juYEYjU9N1a4BUwMz7c6vjr/x?=
 =?us-ascii?Q?rkHBkaOQqjxJ5wpTHdR/Ivmx6ntzzuRdnWqWR0f8cOkiiM1Ek4eUj1GZJh8U?=
 =?us-ascii?Q?u1H2pUYYnZ4tvOJEXIldUMjrH7AUTATC4IVJET73spFipO892q/R6D7yvLoJ?=
 =?us-ascii?Q?3efYVN+sXByzc2ADKVALTCqXyz8rv+Mo5IHgcaF/QCQeCZRPb+Fzeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ykt0z0q9pEYP92VuGnR6wYd4fnq4ORvuyeE2InqZHcoc6WP8HgO2o8pX6Hul?=
 =?us-ascii?Q?QGZGFjg8inJjW/EnpaixESIyjFsJ9zSeKiR27fUhyveObpUxx3GKcYG4Xn3m?=
 =?us-ascii?Q?iKNqQmUzO/4rDU50ZFJsXE6aKF+V2ZaGbWcdFpd+UJNuj++eo1vO0EfrX8cX?=
 =?us-ascii?Q?HL3pdXPo1ArypJLFyI++Lq/ofL/UGcuCjpFHgqluYRYDkVzPMxyV7PXU66yM?=
 =?us-ascii?Q?KDHq5tpOhpGRP3U9W3ODk6HQJeMYbnvdf9Lhv4mUbIvPFgu6WhcRv0HBPWI9?=
 =?us-ascii?Q?TUh+M5fYcCahJHJxf69zdPraEFXAc/rqQH8N2FOWrS5UgZzu76atRc2PmGMC?=
 =?us-ascii?Q?YGFe9BTyYa1yIiYclFZ5vbTfual2padgQaBoHwH2/mdzF8jEfigrAydbQgpq?=
 =?us-ascii?Q?96ybXO0bSDPAO+gl8fGGbPVyD+OIxE9GlN0cPRGoSpVdFk1lOCHEgcdUm7kg?=
 =?us-ascii?Q?pdPmbVZtM6TvkWupcrz3EtpNPMYUf92xkimestalxmzZ8wtW/zpzfbYahf0V?=
 =?us-ascii?Q?DpODMrQZEiqoJfDq+BQmvZJcD+GtZnRYq6Z6qlQZUIFGBz3oju2dhuPhNFCC?=
 =?us-ascii?Q?Vm0zWnnAfmhIOVYo+yfrt1KIexlnYqWZ21AW7kRPj56QxR2OOmNfq2hX2aWz?=
 =?us-ascii?Q?4dSXzRjbKeGH7LqxND14Nib52rrCPFYo8SbITysZ6juJnXriydYk4GGc7afg?=
 =?us-ascii?Q?ZTocwm6t02w/S3kQFLDvk02656yQUvjiR2NTtLLnFUunq6nnzIefSXtJVuWs?=
 =?us-ascii?Q?Hw/YhZdqFnxC85npngART+HVcO4XGubcuPhxMPJezmYG5wWf2kKkFt1L2Q5/?=
 =?us-ascii?Q?lC1g4+n7uF1nQCEv9lVOxWa0GiBipupcLGHvesOv+xlvxlFUu7jyGDiPE61N?=
 =?us-ascii?Q?KQtmfBWyQifpRNwx0LVwhWIYnJ0evNIMLYDXjeVyY829Qbk8UPm9pWKyEivF?=
 =?us-ascii?Q?nZkfaOVQXlB9Q5vGj2V8zRo8F3TwNf15TEFf9YkUzkLAGoY2M6HMyC6Ivr4G?=
 =?us-ascii?Q?AhIFIGGt6dOP2CD0cijZpr7V8q36KlhzuDtpW1HVQidqtbrEbY/OLWUmHMnt?=
 =?us-ascii?Q?7Zkhllt2hF8tg8HOisZXBrsn2EsonJ9Mr4lP2fpYwHXGK4y4MhO6+x6QMG1E?=
 =?us-ascii?Q?dyF+CwGlELLeJ5FL+u7/XtrC7BeX35Dfo/czzRXMFug9qIJV/AvGiJDQFUQR?=
 =?us-ascii?Q?iNfeEPBKvf+mBlQ6u68+tKlZZuhlvIeN14Uyouym1WQNLvWzMTKnaNmyous5?=
 =?us-ascii?Q?yKjbwUcOuWE2bxnEx+r2bP5+MquRcjig0+fPbwOGLEHPw6Rlsp6pXu6WhXYC?=
 =?us-ascii?Q?Nvgvwx8vIHnaaOYCUuRezqvZ0NDH50opS8ki3XUJwd3obdWCSSuxJOmJukzJ?=
 =?us-ascii?Q?0vylI9zfjE6b8ZXjXDrEHaWlAtGPor6wawJ7hSKGLTmUa4SiEKter9OfEHNI?=
 =?us-ascii?Q?oE2OpnHXslEi7PdrvwCa1HcDuthLt7PS50MwTk0+R6gkxPtm75pBkPRlMQlv?=
 =?us-ascii?Q?aiQYbO+FiKZjabFvxHgHsjF469GFs7+D9W0sShHGKPgMg/W/EsA4PbljLwjG?=
 =?us-ascii?Q?xIYvW7WmBbXcX2pTKeNndLoSvVwchwz9lQhAGjEJ2MwXdc9SEbFFYjbz+h10?=
 =?us-ascii?Q?Z2hKSTnbfBj/cbwvRr9OpKE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: db426775-009d-4f7c-733e-08dde1da57d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:45.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjaL9L5D5sZ0Nn/7771zZjrypjbnQCq3UpgCgu7yBXmsWGGZC/x6Il6CCIoabQZUus5BgujEJcGJLLgWIi0ZE8TyryfwU6lrJc+fhNO/yts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

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
index bcecfb02497f..2388392ab5ea 100644
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
@@ -832,7 +757,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1074,7 +1000,6 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 	.dirmap_create = airoha_snand_dirmap_create,
@@ -1099,36 +1024,6 @@ static int airoha_snand_setup(struct spi_device *spi)
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
@@ -1202,7 +1097,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->setup = airoha_snand_setup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
-	err = airoha_snand_nfi_setup(as_ctrl);
+	err = airoha_snand_nfi_init(as_ctrl);
 	if (err)
 		return err;
 
-- 
2.50.1



Return-Path: <linux-spi+bounces-10085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8CB82140
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA491C8051B
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78353312809;
	Wed, 17 Sep 2025 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ta/kfKCI"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D323126C1;
	Wed, 17 Sep 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146365; cv=fail; b=BdILqVQAQf85Xwq+zz2BEkG/SGz+SEiQSzM5sVplR/ijWuiqbABtoDuGK6sJ405wjnDdfwbnLZLxcMvEewp2qbm3FGN+eFuYIMeEgi4S93dWRJRnl0jiKmeynZrdv8q6npxgby9SIaRHv3Gw4YsoLddCRByWhal/RzTHDqJg5CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146365; c=relaxed/simple;
	bh=iiNlxnVk+XHjgvSizldsOXrUqQfg6o0YcSIFFwnN7rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OsEV2UYcySS/BjwY6MupPoThlxLZcXivOOc5a14yebswxce2IkbFxbZ6PRX8NYsdu7IjuWYubWfU+xXyW50pOiRO9R5kj/IF0PccyDe8Y1DILMskzA/A+3EEOIDu6IoOU604RY73casieXxEiUxsH3/FR3ziah78HpNC8Um5ro4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ta/kfKCI; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWUT+4vt1r/NwTXAy2BhigqR8eNfM7SaTyEOdpaeqEaLt/JEpV28qNIvxqPJU1sm0cuq33u/gd25m40ibwn3Okp8deRMDBgDtHGkE0U5nFyPCANL8SgMpLlE6YeWB0VnLSvKpboKOF6++L9+L40koqhmQwRWFAa+zmJdkR3nlGdfnXjEpsv5O2BnVOrHZCfj4EZDu3cpBQycvQhdrh1BPNuf1R6qc5NqmVeZ0ltY8oG5T6F/Gjp399Kv9cvXRQ7VMuLhBOwnZcT/DU7P9/c5Zx1k2u9hg110PPzR+jZfFgrH8csRaR0IPfQ7A0y7IPKmtoW/Mzl9Fa7AzXrvX2dEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra/m5hu3mvjAKPyQz4VCksNIIyG3RTGX/ZNnybROd7o=;
 b=w21YFQrRm5a6zpy54UER8LEehDb8zxUy8kMCX7awE+DY3vqCSWT8PQIAmhLy/JpWnmIEzVbTtj5dF9PLeijTbfizl1RZ/EzbOOi1ery3LhInWZ62vsymtvnLvQMCgINH9f2En3Ity+7RFoGAW9CnBHYurzbStruu4rhaqEmVv/TSAlQFYtvtgHDc06fa47TxAIvgjxOwZkMbqblcCmE4dM4TdyrFTbCX7yDHZBH50KY831Hc3eGiAEqub/0B2D4Q59mwh7+9ROmW9KK5nTbGp0d+ZWtKrhec3kxHqum2kadBDZxrRGC2zzmkXNQiWLApeDznZU6LKESPX6YswQPhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra/m5hu3mvjAKPyQz4VCksNIIyG3RTGX/ZNnybROd7o=;
 b=ta/kfKCIc1TIzA7prvTlJIQXeCKgpQqM6u/F5f+aBLkyckDSRc4ATeOJpFgudlMiey6q1cIyUQ9VJUXXy0Ex4ps5N/BEtkVUh0FJkGpq7zzBXVAfa+icZcF84aZqJjjeP/RBlcbFt/26330S3boskzZ62Z6VjByk6XpqBY7pTRPncKoaYKjk/J19nxW1nQgNJQzn+MGK15zxPzyj1jIGH782OrOeq/qcBv9SsD6SahbqKYe2HMye5mwW5Xq+PO/ztl+LGpM/0SzyOrHwJ9nN8IkZAfGVMEkJFxqEq0gnAj/pYU2MWk4flKZmU9ZfK1zMBn7m3QjSSLoMUaF/oHElfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:17 +0000
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
Date: Thu, 18 Sep 2025 00:58:47 +0300
Message-ID: <20250917215849.19720-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e46586e-7245-4915-eecf-08ddf63572d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zndWf0NaQWkaq73mb8ubQi9P5kTZOEcBLE87MtDlUstOd1tBD6m01ih3GWbk?=
 =?us-ascii?Q?q5BCEjHYei1fgHTocV51oA+XtF8fMybOn9fIAqCap0lvMEscac6J84HrKiHA?=
 =?us-ascii?Q?KXD30rG7YyRIphaRT2eDLbQDF6nisAAYtnzf7iUtaoFFZxyXxNZ8mGyJIcOo?=
 =?us-ascii?Q?bQmwHgtmte08+ZFqkGf+laZG7/M1LfREt5nszjxQizNRLtON3vdR2N93angK?=
 =?us-ascii?Q?6EOjt4ijOaoC0pKnz3/2JRvsratkmruvA6T7BROStSz0gkwKrjinSyIdvxP4?=
 =?us-ascii?Q?ky8/6EIczyVje6q4A4Rv2LvHmY2MlNLDMSepvrg3R/gvy7Jmh52S1nfKG3Zu?=
 =?us-ascii?Q?GBKAMXHEKI0GL5ONpPu3X/14kXLR7wxJ6M5fhaMs/vIStIFuRAZ27b3d9Eij?=
 =?us-ascii?Q?gSrWAph5DYEsz7PMXng3WYmmoz5Uauf6icmjCmE5FNiQAgHXVVESrjY0qfAa?=
 =?us-ascii?Q?3vd+25pARdCJ3UeygqDJutcxUPqTeUDlryFBLR8aa8b+Jj3VIW/HL6WXZQlz?=
 =?us-ascii?Q?2bJwk6rr2ESUhMGEt352+QL3FDXeu3jsyElOWNYoZBYvR3YJcUBaMkLODAuV?=
 =?us-ascii?Q?mrvEpyNbgw7zTw7GVv6qjE5tC0MdfZzshCbxUPnusqt86ELwyzXWIe4Jk/SL?=
 =?us-ascii?Q?DwMkCvSVg9Tyx6HRRVd9gDZCYrCIIxW02OKfIFYYy6yqWxGpM/BOwd5Ti04B?=
 =?us-ascii?Q?CIFRHakYF4ngOURsY5y8ScRf+dTrnr0ZKUCZhabJ4JNqr3rCSlaZjYiMolLb?=
 =?us-ascii?Q?vlXDV5lHMhYo5VkY37b/L8W4Y/sHNkACryGL5LmE0RFisaS5ZcRAxWvoYkFI?=
 =?us-ascii?Q?J2NVtI9Q5gzZoC6UUzxS5fGsWvbk4rbTQSHUuQzLoh6vTVLxlSnPDR6guMTf?=
 =?us-ascii?Q?4iKuHCysjdIJlTLhOukQIwthqI5avmmYjRjSqwZi6zL2Czdwhf4i+4EcK8F1?=
 =?us-ascii?Q?TikkcH8lQd4XF21K78JtWgywd2ABkb1ZW9sudDySBKfId34N3IO7iv4V/WBC?=
 =?us-ascii?Q?9dXzOGNtTxrRMx7TrG8AsMg+dtcYjzJNrJWBYb+pu5CQBWRqRFZMsrFOO/5g?=
 =?us-ascii?Q?CJamrEDC7RLq13VjqUuA+9Tle8AmGZ7s+t9fxkO9yyBvw6SaS56gypdOniYF?=
 =?us-ascii?Q?XwPKE9cXxQLrb6kkQ1yyP8ygh4AiRYS8stXKSAZUbKa/i6HXe/kDNADqFsfg?=
 =?us-ascii?Q?hVI3rKKxK1ePg9nfvWvJgT5gp4zY29NFWw8fjxv2+VqJXyUPFDBrIaOlZDRJ?=
 =?us-ascii?Q?72EuALWUcIEpMte0gfRLR47yFByE25wVJfG5DWZdjcoQ5XcXQA+Pq+hC1gGJ?=
 =?us-ascii?Q?WWqcF6eatVgwEbRiJVJMe0dao6nL1WwSnpGsaV+2dY3gJypA0o3qX75K9146?=
 =?us-ascii?Q?dOqdYz9wqx5NfiZUNu6Gx7ogy4xS+Xj5AGVzZwFZUt9VWNRAdnzt1D7LZeaV?=
 =?us-ascii?Q?ej7+KkoZj4aeRa/+oAV5KBXPI3u7a+kGLXg7ipx0lKNlbPE6SKB3dA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RifSkgRN1Q2jTwD3mVBTiqMMSL9k2mbNkrU+SLJm7UcJcF7lCHSdyqoERwHT?=
 =?us-ascii?Q?f42PnAKlXWweUTuAOaqx927fUnOBCI1r5+dGPABZLu7yVx80YN5PZYXUEHir?=
 =?us-ascii?Q?/MlEGGM9dxP8rbLA7SOkCVKPafTX+MFarqFcnoZTMYhEv00SlB0GK4LA0D1y?=
 =?us-ascii?Q?3oJWuodxSo8bdBOEG9oSJon2qILJkPQwzrwqaLhPgE/GCL/w6JDsxm7zG4DE?=
 =?us-ascii?Q?Ngg4oKs1qHKBPMHI1krEUBVQszQMt6nLGD3SciCReOzimep58d4zh8tTa0ch?=
 =?us-ascii?Q?Xe2qVoF+NImF3bXBVbXacgCrj60eHrhcgOjh7ETi4hA/vIwNmMjFzCO78E44?=
 =?us-ascii?Q?5wSrEYvgv/keHLyCUrUlvLx7KApFfxPAIwNnrUDeeX3cNTRyNkyZuA/NtuyY?=
 =?us-ascii?Q?1QWxXWNRzjmG1lM+LpYeyp81me2aiDiocJylBh+NpdHWP3fWX0akRhll36Ox?=
 =?us-ascii?Q?iaibwsfgTyYzHrFANzYY6rHuATcVjDIC7ukMnHMgwmSOH9Ub7hTSTSi9hWKq?=
 =?us-ascii?Q?Q8ol9tplp6p67f7GFMHntla54Zb2KtTAtI1kEXp8JwPci8qxii51kZ1ZW4qA?=
 =?us-ascii?Q?3Ml/UpwytVhrhRBfdz7cbwQI2uXCqm6AIsD/JjxMN/YeNmjTrkm6jZRjoQkk?=
 =?us-ascii?Q?yhSy3cCH3joHd/HYnw9MZvdTX2UVUx7JtxrV/el9q7AuBfelOyuODs0uQqrx?=
 =?us-ascii?Q?Y8aJBD6gbm6D5UL46QSu1iDQnf0ZMuNOBwIiZoGH84ATKsCM8zFySzXA0h4T?=
 =?us-ascii?Q?vHltXWI07VK1LtG+bC7s+MrPW3EU8cmsNjTptLktNcPoFg+wni/8/N/6UBUt?=
 =?us-ascii?Q?UqGCz79JnNqrEsTlh3g8ug9XSqcExtf/f5uFPvBznIHedDwq5GQF/5RQr3nk?=
 =?us-ascii?Q?iRxr6d6uqrl1w7B+L74u/a5hGbT1QsHQVKqrytz4RTYy6yra9TLvdJIHQdpS?=
 =?us-ascii?Q?qWoVs3zWsRHw+RqHnC2+nKz3BrnwsiOj50NbHfpx69ArDPhFbmyZdnk76G9/?=
 =?us-ascii?Q?0q2DFdSWXui++iDfTPacsxrqrBP/lRlEs13tvdgOLqSx3S4UR89919s7Msad?=
 =?us-ascii?Q?FZ6+UCO4WXkBgaejuPbvA1xK+YqMdILFVuda+6WrpSzjlLGwEuVwTCjTl5kR?=
 =?us-ascii?Q?tuojJP/ADbzN3qAdYJy9kYZS2jn8CYskZehbPzRfPVpV5x8hw5tPYINi/3B9?=
 =?us-ascii?Q?w8XgU651rXLAioEBDEt3Q0f9jmxbIQoxLYvy2LE74gCceFF6OVfJ1LuHWWGt?=
 =?us-ascii?Q?hNR5AIxalkEKTOAFcFAxrgUOGWsHoiOGaaAvwA5PC6jUDrSLsLxHR9egtirw?=
 =?us-ascii?Q?jLHfou1J5RIY/cdWmEC43Zl0rGxcU3haVtYW09daWQBVywEv598grVLbFWYK?=
 =?us-ascii?Q?gV2yYA20DZTNEhSpRsXgLVZwUCX+Din5Q8ca2PhD8z/RdiJEW3dN5ncyB3UR?=
 =?us-ascii?Q?Uj5J9Yrubb4QpA0vsJHkE5bVuEyf2SWJlW3TskO8EydMWMjD7ovXoDFP+yjk?=
 =?us-ascii?Q?DzRmW9OMgyfSX0rACqxuG3GqAJSqqu4Yx/iw5KuzO+eUzUadrSW4TjRmnRxl?=
 =?us-ascii?Q?WeBVSX0rvpVH2TyJvKbjgjmnpYSqTHBYDjt7dWIaHX1sLeYmv1JeLvGu3iKg?=
 =?us-ascii?Q?fXxy0Xtaop6wJmdzQjTWRZw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e46586e-7245-4915-eecf-08ddf63572d2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:17.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRmDRNBugkatMkij9qn507MTiWgYWUCflSc9HSoal0qMfOSId9oWZv+qeqA4KrRAa3qAivhDL5C3h29rmzF82ntjKUz34poLf2Ty/fg+ECU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

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



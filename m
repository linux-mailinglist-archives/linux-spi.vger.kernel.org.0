Return-Path: <linux-spi+bounces-9457-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751DB272E8
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6060BA263A1
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE628A71D;
	Thu, 14 Aug 2025 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="wxu+uYnl"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6305288CA7;
	Thu, 14 Aug 2025 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213155; cv=fail; b=S9IsTEVhUG55+/kY+rwrBvvXmUowresDEWL+xn0q2qGbsO54tNskGAiqHpUJMtcF9gy6UdYW89EEjiGPbkRmBUbhiKWRt4BdvUZ79C/NxNoncZ46itVb+iQfdKAhuspXdUHOZAubbnlIQTfAmMMjbdE0nYIOSjMyuWYP6gI/kec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213155; c=relaxed/simple;
	bh=0M1CmVXp6DK0Pxyt3A5VLxsAY23P9lI6i3wcypIRsRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJ7wlSqgB309GD3FtscfCTsxVqcKh2DZgrA11U2w8odqbvTY3zA3AouZghh/cCR/y1Olbz16Lp9E6rFmnTB95hEjAV536/myOHR6G3YNegNriXGhKVHKcFxeP9qCTyJWUa2wNkBpI/B+5YMe9Q/xaXvcqD3OxB2cuoxanMNVpH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=wxu+uYnl; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AO8SA+nk+p9VMXFFwC/weTglSXxc7kX/k+wfIEYoa8jfXdpBT6AAdbodcYQDjb7vs9g79h2PqggZID6faZieLpqG7uIm4sI3AfmYheQWt1K0xW+ZomLO1H4k+5CqeXnjVaMHXZqAoNxuj1qAFx9ScWRUAuQ6jZmreu2xEz8p/McgnEmW6hkIvZFo0gPmO0hhFw+9UWC0OfZKXMmU2AeQrQ1Iq6eW3Z/QpcraGp0uhDZyFy+Nnzb5ZlW7guwUGvQCwScdGzLfRP1HdoIBg7M1rrDV9tVkzUsdkiKWpIc9dV7/o4JO+oPlVeJ4W6Dx46b4kYIp+4Hn4d1xPxniylkPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiG4lE6no4O9DDFFJzYADanoSUSnkIiq6xoe7uOcDMM=;
 b=NnQ7wv3691d9WqMwaYsYGJMlshD81pmRrBXTlLaqq/8KqSjV0+wt+UI0quVhPXRI+ljDKllKc1fP/wVsCnlz38ERAjLtpc7GsM++yCx532vWczDUO8Sv6JJCjTqXrzDshQjnTK6HBgGBjJ3ZMyPA8Kz9B97tU/zhiIdtD8V3NUVAAgwQAuUp2oFjT0DF2jhh0pJN/nPn8GAPbb5Naj6mBbnqYzT72ROPYSSWUxLjrVLoDVK+oYnR2AGbNZw6iBvfj6CO1jwAu1uFSv3akVxssdvWPbbTaE5mYCbjbb8QCoMRBC/KcVlB+7LSdrqmwGykBe3sUhqOk+cF75Xp4FxUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiG4lE6no4O9DDFFJzYADanoSUSnkIiq6xoe7uOcDMM=;
 b=wxu+uYnlnxF8U4mct1SUJbPa/iNCTHLS9Ll7mxCrs9KNlVxclPVdw33DuWb+iUQFqTpXtOP48lib/1Mma+huudVSRlotzzit+Tkxgo88r6F6JQYDdYvv0yU0j01XFfjlceZRGIJxycQiqR+C9uB9Ht+t8AmlBq6P9+ciLaykNIdbmZiFUJmqFRWj2qUdn+Np+o533vz0j/9fYd4QFsMPiTgGJCW5aVmYK9SjE8Q94HJTdawHEtTlBOGM/n3T4gKpwtHVr8hgZLePp7fhKlLrnjAqi9XD3wDmhm/ivzHKZO/9hyjOUquj5VMG7axHJLy1/IECK+4EM1M5yXrtTsCExg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 08/13] spi: airoha: allow reading/writing of oob area
Date: Fri, 15 Aug 2025 02:12:05 +0300
Message-ID: <20250814231210.4174427-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: dce06208-f971-4813-9f13-08dddb8807d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iPCLAYhm/m7ueveqrqpM7d/qROzGKIVbRpd3KqHsZkVhSdEKib04tkhQd6bK?=
 =?us-ascii?Q?evfgVZ/IR2U17EO39FJ6NI+1/RxOHeCHkqSotlgSDAWFVUEBu8/zs6l3k77o?=
 =?us-ascii?Q?uxCmSomWTCUrIF9rpTrTEXmY2QkB/ZDxytsLUPqKb2trcpZXpNxY2zvuuqxG?=
 =?us-ascii?Q?FrYh4j+8YQEiiMxTOMa2dOObeFioyUBk7i4ZFbc3ywtG6V+ooCLEtAzBHQus?=
 =?us-ascii?Q?cPMtTHS5ic+4yu+iNGt6jLDmZSYT4vkWy9q+cSaPbxkDuiD6zH9jVkhpX3ss?=
 =?us-ascii?Q?RnQCIueDk0EXrLYx+v1JRoD+2t90AyZyWsAZU2baiq900a3X4khzJiAp/Q1a?=
 =?us-ascii?Q?iTMLcm3q6gI89QqYqIZMSxnP3biimiRqxvIJsFRAlWztr0VZ9JXKoSSS4mdI?=
 =?us-ascii?Q?dLKiLItCTRPHIBjFu28MH9Uy2FWi51Zgyhb+4yafjyO1XatYEx/ymPp3+9Q/?=
 =?us-ascii?Q?bIyA2ToYGO5FM33x+qf523PSgdCiMFt5+ki8/NpGadk2GLktYBu8z3YUHcTn?=
 =?us-ascii?Q?ooxC+XU7mIV6nL5fyZYfUFwddUMUGBWGpXQIk0847K+CNvARp4rUDpyRjXYZ?=
 =?us-ascii?Q?lP2Ime/iBhauDXSiJLvSMGKiuyi/P6IciiiGyc8bAbqK8BRhjqUDGA+SGVw8?=
 =?us-ascii?Q?EppK3l45QBPI3Mm79igUPvoMT9BF33wICoJDncVkz3Oxg7bswkNrnHtVe1tB?=
 =?us-ascii?Q?4mzM3yuWv/E05A8TYe0Xh5mHJGeXxWO5Zs/F7oR7Jg0IJHuTfJnnh9m+5kbo?=
 =?us-ascii?Q?q+5nm5wqEyF2LYZJ8KqoDNwv/W7Csk2Ls6ys4BSNbcKkVTpV51gETdDUW6YM?=
 =?us-ascii?Q?iM28UhedvwDMr3Y3q9RektJuM0RaNxSOO25hev0+weARb9pbT8EL3rVhUs4t?=
 =?us-ascii?Q?uv+cJcttrfFODpw8tRtksqPXYTPWSZRZOug+hp6lTFFdEZZIPJ3XEFaYX/zX?=
 =?us-ascii?Q?qFWTA72uBo8DxJtpGBdBnTJMWk8k6cG0UZNs2QXrNZfybSqZeiTS9lgyKV90?=
 =?us-ascii?Q?PA1NCnUgoL/cjzHMdLtDlCqm/YEIWAORW8khhZMPUBNUnmN63B8FuZ164iqi?=
 =?us-ascii?Q?slTJhKcE1FXHiMDML3g4D85njLoGomv2ak6yktqdopeRt18GQqtiTF+AavyI?=
 =?us-ascii?Q?kWMc+uB4Q2+369f1Zsc7p9qjyNvMxVnUb3g43kn/qUVLLfSz9zX+ivAv70Mr?=
 =?us-ascii?Q?fgd6raAqn8KS6l/8Fxxml+pNxSxhClaGRX3G8xI3SQq0eDPfaX7KRQIqxoKm?=
 =?us-ascii?Q?enVmfg5UmvJpYZ98oYFvVgtmMFvK0p6QfoRLXCrdMBwib7DVoZGsuIW/NWOD?=
 =?us-ascii?Q?Xek1ZxftbCiEBzPNRHZrkeAuWfQEVcajGq7IreW3K5FHINkcAhdhTxlf7xr6?=
 =?us-ascii?Q?S0bKA3N0ZoT+r0GIQ+7RX/x/dTM8OK0MwAJCaoTqonOIpYJI+5v19Rh4X4bl?=
 =?us-ascii?Q?27fqD2QrEN42sUq84PWxTpLUhfwMs7i+j3+OfYubp1lgNnkmpc5Gvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJJKaCZRcChtPbrWL8niU1YGFg4ElqkicxrtEHLEAZKztv8O7/OBQYiAfArF?=
 =?us-ascii?Q?saZZoQx4ot6nlX/jSAvaMpvFXeDsGJ4G3drA5vXpiprH57j5v9G0zx4RmdUn?=
 =?us-ascii?Q?BKElJiJHN2/SXJLDoapsVlIRT6jX3z6sA7omexc4cFIGNn6JFWXn1vVPF8En?=
 =?us-ascii?Q?PPXaaDg3fOQrLTKY/atqM8EcOMX9pmK4QWdzFr3semsvOlNwpG50AQaZCyDy?=
 =?us-ascii?Q?rRAiLAgZk0pApY1FsIRxrtLoDuha2+fpr5yLdCAXEj4vpANkDRJVzSAsUo/H?=
 =?us-ascii?Q?ZwnF+cOFEAfWOHSmanGawzV4zUZ5VCm0eRgB/GyVggGU0zqUOXkxgHmE0uEO?=
 =?us-ascii?Q?X4Og5iZciWzVJpwjtnKVgt4qu04ysBqpAWt7vLqjd6PiQCaVMloY9t7wURo9?=
 =?us-ascii?Q?9J4J34KGzZe5ePeUKocTzD8EHbC8J4y2fBrxOfKoobtE748GQs/dRYXPea+J?=
 =?us-ascii?Q?5l0ogIBUl+1xaeOxu/6C6F2ysH+mcZvU1Nu4shMH4ZsbjMhwIwLNL9CB3O9h?=
 =?us-ascii?Q?KntMfCv2AJ4oCG4wmj5bdbkltYsh5s2Q3KHEB/aF0OzM5Ong0aI12WbKJJQb?=
 =?us-ascii?Q?/j0lAXJcFw+O9ZBbVqs3CrDw5I9nuCjSOYEwYXFeEN2izBTtJm/n4TVFMKUe?=
 =?us-ascii?Q?aNEwPxnOCLUHQ912lO8vLO9s4pnESaAM20orurzgEvDONuQBXDZ3IHoQFtIv?=
 =?us-ascii?Q?4HLFybdrtTe4do1DNE6QGx2VyWSFczc2n0bCmt7d/jEneKyf0LTs/emUGEJv?=
 =?us-ascii?Q?QeRdGclkFSYE5uiAfSLAs8SG9/XW3JNMaGehxNSZ5fBVnUcsA2e1Jn68/97F?=
 =?us-ascii?Q?XC36+PRPoeZq1Cz9yGoiPmO+vjwuN4TCJAolomcCepq35sF/qbvDXQk5qDzA?=
 =?us-ascii?Q?g61RH7mVfTjqUqKY/etiYv6S0pFVoY1+gyuVVYhwetNjJrwTDn6ZOvghZM73?=
 =?us-ascii?Q?HMrf1Ux7RcTCPz0S4bLnEElbdjfujGYGuqiIaFUrk4qCZeQVSLEeW/+WQ5gg?=
 =?us-ascii?Q?n0NZnw2qPMtoGQZf2G45v9eJgDIQBM+IByX5SYGYiFTMkzYBY9HcORhZ67Gk?=
 =?us-ascii?Q?cI9GnFarLy2RuTzX34YYcRojHBg198sgTf2rkQ+Nah7h8ZMcS/fwl+lPkFjw?=
 =?us-ascii?Q?ijZlM5B47RsS3LT/XIU764aFw/XoB6URjtUfNPKcdU0m7Ojnn52sh4gw3QDV?=
 =?us-ascii?Q?U2MwdB5AbYoC0KzgHQvIP4R4ZJVlt30bblenEqqLpKbVx4511vy32Rzqj0Rt?=
 =?us-ascii?Q?BuDYQgGldGAC/Q+ccCxr6O4M/GBy3JUfACeBRXWdzV/f8AvieIYQQsUda8pi?=
 =?us-ascii?Q?/7dh8CMCDE0O/H9TGdHr4XwOxgDXmBiic4gZBLlBhLbjvjMd6ZrkEhO2mpfN?=
 =?us-ascii?Q?PTgrJOdkzLp6MG3bZKqJvFHsCcZMwGZgTjX98BsglVt5xuAN5y1+2vDMYRAy?=
 =?us-ascii?Q?MyZjc+YbnWx9s5jOANwNsrfegeoCN5I/YxScSTBAdfW+1QD0U2k5MjM08RF/?=
 =?us-ascii?Q?yWZ2LG+L4IE5fcp5yzP88Hikb/3NMyT8rYKpAPEQE7OItYFweOgOBR1qA2Md?=
 =?us-ascii?Q?aNvkxpTybk0t1+1fOhdUIeFRgRhnpLRKL/vnJFBgImj51WjBpdY7LyGmDuYp?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dce06208-f971-4813-9f13-08dddb8807d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:25.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/JU6Obxpf+bdqM9Sdg9+ZHSL7eS8+MVGiXOiY0qv8stxPw4zSfJdtGe0xbAJCmk04Syuyoc81gKxWZ4O+UzNEdhzMgMmLx+n5n2Rn5pI5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

Current code does not support reading/writing of oob area. Thus raw
reading/writing and bad block support is broken.

This patch fix custom sector size, so oob area will be included to
reading/writing operations.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 38f2397d1bc4..bf29de9dad7a 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -568,7 +568,9 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size +
+			 as_ctrl->nfi_cfg.spare_size);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -714,8 +716,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set cust sec size */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
+	/* number of bytes to read via dma (whole flash page + oob) */
+	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
+	      as_ctrl->nfi_cfg.sec_num;
 	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
@@ -860,8 +863,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
-			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
+	/* number of bytes to write via dma (whole flash page + oob) */
+	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
+	      as_ctrl->nfi_cfg.sec_num;
+	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
-- 
2.50.1



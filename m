Return-Path: <linux-spi+bounces-9623-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78FB325B1
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB26AC73FC
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571AF1D88A6;
	Sat, 23 Aug 2025 00:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="1AhpuixW"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DA1BCA0E;
	Sat, 23 Aug 2025 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908215; cv=fail; b=AM6x9zxSx+BbLMEaMLOR8nlUusYvoQdlbZQCqrs6VwfnHgcdlgYJv2nV7wXgcAI8VzvwoIQ/uqxr9UioriCocJ3pK+tQpnj4EvvuvI+a3KzsQV4JB/lfmTA7qMsXSClxlunS2HA+IOViYfaS0cWzDe6MaF0rAzDmrmYBvkHyIk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908215; c=relaxed/simple;
	bh=IPhOc3nwyC4/qctOdUD6fvu9tRqLC+V9NLFg5leln68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=itoAHg0piS55d8MKDAZLP2efazYTnnFMvV8YOZUvY9UQbItQGd3oljQMN/7ztFt47VnSovgY9hydeDqKtEAR1kTVKWX1/HQDWv5DK6vQswTUL7qUuWPZHQ1n7u9kyBKtl3Fa6FhnLWxih9f4mmBZojDBTECCoFd/Z2utBqXfA20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=1AhpuixW; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6HZee8sI9lBAwx4tVfPeuz17lQkl4i34i53ScGfoYlO7at2WYtvE/42SVxPzfw+MIv0/ZFr3RUfrI8GZ4vACkED+50yuoSZHZPSxP08dl0xvez+lrM2oFAL7QbQ7R7KWMNNpNSnnaDAXAuSvB5qpAzD2K/TfZaavFVWC5Uswt0qJG1TFfJjuov1U+sFeVmPSS1nLY6nvSLkt6lZT4lUBisxoZA0akZRmXqOYl0vKgnErsMS8DZ2k81wNkiAVr0vP3Z7sqQboodwgZKkK5GHp3+itE2JsQ4wdxa3E8UhQssXxBPvfXKSrmkPR9ntblVd0NrAuyaIwlFs4OOY3EQkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAko5hjXPmD2aEacmCrh7Zihx7fzD2ZIOcSl8qq4+Qc=;
 b=sehgbDXHge2rzJc0tNWuk+C9ZFZz3emrdCVmD0VWdORr0t6jwSRb5CYGRHmhv/Z5ePwAZW3aKRPswWNG8XEgh5F1gWvN024MmFaDSLhlTuc3OML2D3iqBCKUZQFdFFcvCgTr0Ueo56N2xQFoDLYDDDhMuAraIYwJiofpm5y7cBEC7Q0bkBMm627s/Te/TT2qnMPKMpt+7Gqyf0zUGtsTCWNgL+KLci1rOgI1Qq1DC4ZQ3+w8mzGtKF1535HwgCILLN7ptTDTpxLNRBKhNmb01d83sp+NzygsexkDcIZcbZDM1ziVJFPq9rgiWG5N+Tq44MJsDKyfKf6cjtm55ipgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAko5hjXPmD2aEacmCrh7Zihx7fzD2ZIOcSl8qq4+Qc=;
 b=1AhpuixW3TSzQwqZfgKRDfW8uh/J0BgFlwjApIYY5E6xOBRj4uQ+N3TSkuHbo22ciWYzmkmSMOGp7LNr6MxZNMpqJZT6L+BcT69ydaPDTkr6oWfQ4NKdW8ZgGvYs7P/PVkULVU1kZIWZVwVyNwNz4KTtjlT/iYkObPCOMgMw2FeuIDONIXY1q+B3DRnROwrWuqBccv3BPFYPCseCp54oRMS/7vlEc23M5nPQgeF8k/vTQzdKJFHR3CJWxcFHuLo7AvwMzU4+fcWvDYLf4xS+VjBXUTLvGPZAzPmY5RHofa3uqXIpsG1OOt9wQEqyMXx4jqZLAONKVj7eVLeCgi405A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6398.eurprd08.prod.outlook.com (2603:10a6:102:12d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 00:16:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 13/13] spi: airoha: buffer must be 0xff-ed before writing
Date: Sat, 23 Aug 2025 03:16:25 +0300
Message-ID: <20250823001626.3641935-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 5b91eebf-3721-4dd5-201a-08dde1da585c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ju/qm04IuVDfvA2KgDkZQMNd0cwA7t5SLutsaHpjtzfRtYESYTfGWkVhTREO?=
 =?us-ascii?Q?Kvcmk/ngxxbYQY95uMrizRseyhnboop6gwh5iLQQ7y9slc1wfE85GdavtMdy?=
 =?us-ascii?Q?t/OZIlR3xJwD3ns8wk/9P32rFiJ1m3VcPCiqixd6/mJD2BHwjFlnV/sQyJq8?=
 =?us-ascii?Q?wp4NBr68FfIJomZJDO1jwdt0/ef0y8RtofF47MWwWdEU/KkzZmHksDjDm0Jl?=
 =?us-ascii?Q?mFx3RjpAJmSh/TcsnjHU8LPoA4umDPe8VfhbAGLK0XSLw+goB1nhntJPu96Z?=
 =?us-ascii?Q?WXSg8jOjXTTmUXcFwLw+TObZUB3eYTnL+1o5h4LMvXkrSXsMI4xymIX27seI?=
 =?us-ascii?Q?EdeUHPtY8FlJLFdiynQib8wAs4nzxDt6my2Tc1zduoHZEZEF+ZYE8x5lJiT8?=
 =?us-ascii?Q?dyyy6m4ziGr2dVJkOX1uE9LioLqQyzMN5YrUbj3iNH5+bT+u1yVvcT353CzA?=
 =?us-ascii?Q?uldd0h3ARM35OgtY499ZkCkV4MBjB0MgX+YIjtlspXJ05rOzdMfmwPKv5OnW?=
 =?us-ascii?Q?yOHzkFxDFByln6Dx8tMz9iMQOwSJhzHu/HydxJ5ELlklu5q+aakO8dReZyDY?=
 =?us-ascii?Q?8piHbbPwZ+CUE1wynsuyNMY/ilGaSepUctv8VAFuachZfyEJ5YtXYqksTlx3?=
 =?us-ascii?Q?uMjD4he0o5rtybBaqRvvfn21D3ggUwuEwOyI689qrtBXGUMiRvCyCrNllJEG?=
 =?us-ascii?Q?KbgSsfHeVINIExzKo27Wx2syx+0uXaJV+bBQYrs5crpM7zKa0bJyg0zBQ8gk?=
 =?us-ascii?Q?RssLkZx8bCGBWeFVRJwKIEkE49QLYQI3fiB0kd15PcJlD9rB4UgHJfTv2poN?=
 =?us-ascii?Q?R2jFFTsXd36mp2nB5KSkfSAYi3osQYLMfpQjleGt/m6Bz2SxWZ7XyOQyn0EF?=
 =?us-ascii?Q?LyCnzw41lkdfHs6+LYKTfdmFZdx+68YA+P2kjElMsUi+FdYtrYMyUswLki/3?=
 =?us-ascii?Q?hRg0ROeVwyrlKW1UCAsnSrO5cERIsCNK2A29Cx+1+3tEIeKdcPOEWPPT54pR?=
 =?us-ascii?Q?w5LgHfLA09K5d7yw4POhTJiDpAZnnVT80TG3i40gfES4HAyfHks03s+qwAH6?=
 =?us-ascii?Q?p/Q9hu6hssTaL/z7r8hPOxdm1X2q+HbhNnhEhsdprXNXKN/6tIsH4MXvUd6N?=
 =?us-ascii?Q?omTl6OFmMJHZx3ALObS/+L2cp7XE8PN4o1TwlffMbIfX8a/ANBilWKNDCfio?=
 =?us-ascii?Q?RveAex3cDI6SAslpIwr5YrqXo5aQBqRraU4k+eKIbiAhGhOfgzjFwI2sy0gc?=
 =?us-ascii?Q?mt439taGb9kY4y23gp3wkdwZ21+QOxrBY6LcWcaabvjUjXxB5owPgNta7otw?=
 =?us-ascii?Q?9KE1+/VmrXo9VDHrHJ6V2KU5TEiClUks+x1DPm74eUyLGZFhPQ1zCvHrd5Mj?=
 =?us-ascii?Q?5evQDc0ctn8Rmp/A08+eW6qWfly8T1MChTat3Ycu3f/Mj3Ktf/y8BBGEge2n?=
 =?us-ascii?Q?8iuzwO9XcZgAN8LlHqtVeIRwdtohdutBfFqcBELgleWDqzHrQRq/NA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqXh/PX2vviYtG9ow+nzJrJ/2vY0ecjZ6++li9rE1Yc3e9SppohBAFC6On3a?=
 =?us-ascii?Q?2+nJHSgItjJ+IqeP5kJsNRkjArNocur22/SmwcrlTr37FKNadasOiCb5P1uu?=
 =?us-ascii?Q?OJb6wGx1ZmijccwGagmmVPQWAyGDZmsZadTLWsrvM2tyfnPcTeAifFNvTi2y?=
 =?us-ascii?Q?w5m49R8xZnLlmxI6VhPeSKHsp/N4ksjR62P//73Qeqdb6ZFUOyyZ8rZt5EuI?=
 =?us-ascii?Q?iworyOkAufOTpKwdCNpx7N0eGc+lg1WP4Ep5Z6amye49z9TBZDceuB6HLPJx?=
 =?us-ascii?Q?LwePrVZSjA3a9NId4XMYXvV8S1fgWbwxaAuKb8KF7Hb0l446S2Pt5OEOUKep?=
 =?us-ascii?Q?Y0XgWg5wATr6gWvlYdem2BNj+3f2Uwkp05OBxUIeDtnwVBtCzHiFKGoOIieg?=
 =?us-ascii?Q?7Zk7tojqNUwauZQ5p//LzBIJ2a3Ts7f2x94S8j2O6IY2bxRpu6BIpzIppqRu?=
 =?us-ascii?Q?6UOK27XxPLbgworguoQplgIMzBFVL2pYAQPFKTG7zex0e24fUjDeQG0a7iJ/?=
 =?us-ascii?Q?5nbOJINMBYhFB5CrvcM61dVpCULRJ1px94JS0ZondOM/dwmBUKXphHmJ6t9/?=
 =?us-ascii?Q?h6mMY11TWXICza/enWB/TyF05/jqrRsdn8UzklgIxk+NCEjNTy5ec3v24QNK?=
 =?us-ascii?Q?UsRowpKY9ybNU66zzhpH3ekvCAZyipcbU8zs+9QycXTVPqeuLwFENiD1Sfgt?=
 =?us-ascii?Q?saimjRWc56J2tHEm7A0sXfvliED9aKEM9LKQ3nA/EglP0pIztwmSwuGtBEXc?=
 =?us-ascii?Q?ek+2MQtbi0XqfPVl+ZYZ8o7geZvHY6B3qOkAiorAGsNn7kBAiq9AIPlytwrX?=
 =?us-ascii?Q?ABSU60CrOAcIQ5bnHZz+GEOsla5CTkqxouEfhV4/HM/rdOdTMobgjrAXX5jZ?=
 =?us-ascii?Q?0c9ez5gA4S5OaqcLURofXmZ82POjIJSevfb1pwcJiKZ9zZaGK0SUQSkkebAf?=
 =?us-ascii?Q?7cj+o0BSJ0soB8ONxlOFx7VJkWf0BZ5+xOVnK+uorlmId+MwUeVlSILJjzQ0?=
 =?us-ascii?Q?AbB7Pib/0H5H2ETVFIVlRYKY8QTDgWA5neUacy14wEtEfoVVxhBKqmWPtHq+?=
 =?us-ascii?Q?Hql9Emd4rzck5vdydelLXrIEjC9RQNKrsJpKiO+2Yc9wp1VWwZMtdVLXsIXO?=
 =?us-ascii?Q?sDKD705IYhZ3GhZnfo9Mx347DHzw4Hf3lSM8AgrokJ6H/zr2OGLKtoiXdbqY?=
 =?us-ascii?Q?5DVCMKADE9P4wWtg9iOxlDBsZn0/JFj9WU1KCGlt2Qs1cBXUEMcreWFOzK+q?=
 =?us-ascii?Q?rqwQe0cagORiqNQWQgP3NYiwl3E7PJJach8Yh3TpYUwgazHpR/VqbFvnoC8F?=
 =?us-ascii?Q?b6U7yODYw5JnY0XtCuFE04oe7sxSfXtqa19AZHj2dG2RoUco+cHkGHuv39KP?=
 =?us-ascii?Q?YoF3cMdOkZYrfl16XRHC7/AhQGMVyy1C8juceNwrPumkaQZo0NLQmDD2iRT/?=
 =?us-ascii?Q?sIOygRSZA1p5nW6cjiDgra2HIKkuk7HeX2L229YE4nsFdUK/UMPkujDDg2XO?=
 =?us-ascii?Q?ACRp213PMaB3aiFzLS6NtUqnonS69br4SA4y+JqcXkF90fUxIC5gQq2Jelz4?=
 =?us-ascii?Q?fOaf4O58xFOBm2s5eJnvKOTXABlinc72ypfcjdMPX3NljiTzOSiEtYt0VFof?=
 =?us-ascii?Q?aIwqy6BWAN9ucf/rPd3gKSM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b91eebf-3721-4dd5-201a-08dde1da585c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:46.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECgaWQdZmRIoJeJceQPTzkA6Cv1EcdQbKSpqrHAxkWy6FCAmBcRAs+DW22qKoO0VWbas4H6PSFHQGLdiWd6NkeKqTTHtTdol23aKSv9r0ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6398

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 2388392ab5ea..096c99347983 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -775,6 +775,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	memset(txrx_buf, 0xff, bytes);
 	memcpy(txrx_buf + offs, buf, len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
-- 
2.50.1



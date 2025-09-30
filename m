Return-Path: <linux-spi+bounces-10366-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF2BAB00F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF4619241BD
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCC22332E;
	Tue, 30 Sep 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="kZhgUl4S"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021100.outbound.protection.outlook.com [52.101.65.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDBB23C506;
	Tue, 30 Sep 2025 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199246; cv=fail; b=lAVcmBblJnjAzw3GFhfAcGZWwzqabiSFohCnGHGK1m7kqsSxVzQ54ErkQMiLosSoUy6NXrLRHzWN8OB4oLCsq72Pu/KDHE4UXm/NWehn3/AIGQzP5CkXXrC5qiIoyD3hOqTRZDQIQum3zqf/9htNscaAxkz3Ob64fQdvsmhlcNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199246; c=relaxed/simple;
	bh=xR+bYVNiNxUkG4ZchX7eM4FNMzVH1PcbxVFdHvTmeyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seVbSKSlbOgNXYG6/gDkLvblauFSWgXGUN0ZO3tH3moHK0yzO2XDITwnS6WupTfeNj2GNZmUEn0OZ2RpyAjdvJjV2RBz+Gsk2KYlsskFQxJR6CFyUpY6PtJjTE1AqpCwYCh8/9Lw5Kq3z0MtYkZ0SINp2uFuBcvaZkyxYxwnlP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=kZhgUl4S; arc=fail smtp.client-ip=52.101.65.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZDQ7q4zbuTu4Nwo8TBpyRS2VF2MqMlnLBP1caZatgAU19aCOltXPrf8o7nOBiiSvaLUoqTt0uKmcS2xtg4i/kPPmYC14fz2pDYCIf+nOTt0L5G7AukK1uFMUfPYMDyxchqDvAjaAxaMpU3IdQHR5IZwreRRG5ObSsnKW/fS0webOdoNTx49JywWM3EmfyazUI1tbTCacYxxQhRpksDa4XPPI0RHrlGr1sAJkiZPGVFFQcqBYmd8pZGCZZv33COgGf9b7tkGy/TjT3qFkarEoeZ+mblInfMC7B9zofphLwSSFoSF2T4F4hZh5W4kcWrOKu1WvnaJQVv+ZwRywzWodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNkuwADrXIUOg+tbFhpznhQg9CEhEJ9jAs6MAvJORcU=;
 b=eC2dWJ8/lTi47vkJyK8T8ii8ehjo1/mzNmDfAb4hYXp8AufwY/4AwvAzNNDyedX5srF0evcxdlgT6PuM8VyHyAnyful3csc6NOAbYkXQWWnXCsbkh6Y9cecXBONBrRGqt9aCkWUobDksuznkGHh01gwOg/bnG5LxHJXnVEEiBHeBdwMQqRH/qmJVvaOwuxVzU5tOHhEFXKeYwnMvp+Cx+1Pa2i4OhnvULvirQirkAr9UZ7f2N9wyf6sekD7j0NC44Y1FieOY1ARXun02jqwmafgKZUJ0VMVcr399deeebe/yBnrzisXH8f9KsbVX0ShzyPkjlCGVZbx3JaF0S0eFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNkuwADrXIUOg+tbFhpznhQg9CEhEJ9jAs6MAvJORcU=;
 b=kZhgUl4Sw+NofOthseSR4rLt53O3+A8cdLLSJQ2wJKHh2gsGl/Q9A8YRJRPi9jQOoUMQ3CfBp71cVxRVyHrehT3KpdwnnXgAka3GEXZu7ipmL+kL0pbpR3xfQyEKYNz3IKGX264uuokS8OmZwDfMoXhQvek22HmsZ/fjI8v5itsRrDwLaoGn3bnKJVEr9/gxy7cOJm725ySd2ZoiXNT60FNiVfGE55T3KdvjFqLd7zPZJnDyXAu4UwVJa8eMX7VFQ50CqzqNJXjf1tfu7PXUftsI6J7X4MYJn2v9zzPV6IjJc1TOmQLV+Yn8gUnqe3D4iAzlm02gPoNlUW2v9I7n9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:14 +0000
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
Subject: [PATCH RESEND v5 08/13] spi: airoha: support of dualio/quadio flash reading commands
Date: Tue, 30 Sep 2025 05:26:53 +0300
Message-ID: <20250930022658.1485767-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 83388182-0da3-441d-37bc-08ddffc8de12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKtzHDAo1pTxYzS6rVLSULLJuBBwrGxNYlLdCxPCafMTdiOlSiks53MSswkB?=
 =?us-ascii?Q?ANDq02fhHrziHZ1R7QKz707WdXGCLUomFG2vSpisIMSLy6/O/G/TdgvX6rhr?=
 =?us-ascii?Q?Ya2OtzkRzJt7JOBs0Dx6yXfmvvPYjlDfA1Zyw8EW8p1la0FpFhHecZf+N/J6?=
 =?us-ascii?Q?E6OLADnbI9L6QDlQrTp9WBh27tCLVnfwulcwwMGopdR5f1o6r52KLPmleV0A?=
 =?us-ascii?Q?MkkCOVwtRMwayit1RRL/JtqB7aGHc2BDlm+v7TbqBFZXIWCAciNtMUmQ4ZHL?=
 =?us-ascii?Q?g+ULdjiOZ7rzdp2FG/VlkDZWlW4JLrqx/ZOVpawHiyYX35+/t435QRUQQD36?=
 =?us-ascii?Q?uk8yqwnwEDLJHVXf2vx9boNMeiFWvrUVpxLU++KUlg7ocEjeogPA2mwfpMoK?=
 =?us-ascii?Q?b6WQ2i5JDpLg5TaFFyoxU59mz6KALJJFn5NAZoACoCnYpcnmrxYP8JwOs+p1?=
 =?us-ascii?Q?fVGQQJl7wwVSwfE7h53sT+c+j/92vEKWdt3G8INLhCZrYDKPqhR99pHJM0l7?=
 =?us-ascii?Q?y3XCaYz6fqAVko/kXwEonaoWVWRDfaH2gGK7w0BgRkfWEStrqxjK4iPQyg6j?=
 =?us-ascii?Q?9qdmqz0oKNnHCgkHNfKgM029d/T6vWeVwYA3C/fodBWQiXuzj1076qAsRMi6?=
 =?us-ascii?Q?MvzcgAkeuSP3Nf+ikDovwr00+200meFu9RN5FJAym2qFH3Hwi0F2BZwQuZZ1?=
 =?us-ascii?Q?lwsocdaOqX2Z+2i2nUnLno+Plf1GgAdK453ODFAtUS1djoychcqZfyiDC/Vk?=
 =?us-ascii?Q?y1fD/z7HHBAewnn8xinjyyZOjDJIlGboHVjCzPD5cd8NJr1i1ypDIyIjRBFe?=
 =?us-ascii?Q?pwGB8V0oDj4jviN3DCqF19fq/EI0SrsRLdJtyyQJBkIRq0fR7hEDKMeRxYl2?=
 =?us-ascii?Q?xuXJEJh9KuPX5trfzb4g3aPN2MrwyuzRDvkLJBXEpFFhPpYOs/PmEO5I4nxU?=
 =?us-ascii?Q?Lb0kDRSCecJED7VVFZdfhRJW8g94Ey+6glW0UVVYNbdjH7rmFLKadCGtCArc?=
 =?us-ascii?Q?KND5hUi2aWQRBYvER+4uhjfWm6f53snNUjMQE3eFwd2fzNYs3zVcSeVdYkF1?=
 =?us-ascii?Q?Mvh8RrMH1HjHHz+fe2Llof16X89b05JuD6gmyHVKijIc5+nNwcnVUHTbTeU/?=
 =?us-ascii?Q?uYgudxIDtJZvwGUf/d1koPtt75lc3Lnx2CmUvohJEqfyIHim9MFTnSezHOxc?=
 =?us-ascii?Q?5tf2VX8ixeTKn4dinRR8Zl0mQ5jKUWW6GLgnu9xPuQuE91orYJho6H2/nA4x?=
 =?us-ascii?Q?GOYS2TFoFinIbRovKFYfDBus6qwu056lvmfZ3drCJvUrZwOXh0ovlkLG5mZo?=
 =?us-ascii?Q?hMWm7c10WXFudAerpgNZh/9nvUsV3ExpPFtmyfFmV4u2Z4oo6Bfz0uwFsWrs?=
 =?us-ascii?Q?WDrKct/95N3jxywNS46Z8T2jWZXRXolKQViw3IZrFCRkp0GtujfaT3Djjd3D?=
 =?us-ascii?Q?SSrn2EYzgldPWh8B1cAW5dhjJd0mFUYUEWJKiBsRMg8GgeCeyTCSYxD6OKmb?=
 =?us-ascii?Q?EwEUXXZ+G1Ez+kjdq9iYG0ZW46GrBwdY/4nn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3k8zh4TiF6SnsPtc24zQ9SQYEsQbmTO4ydibjMiv4eZj7Hb6ixT8yh1Bouyy?=
 =?us-ascii?Q?pwzwIwqs6MzRxpSr9bhsF/p5n5ttb9vV+k9cKj1xQMnnyqk41yERBiLqMBLE?=
 =?us-ascii?Q?0OqKBhNuxTfv0oyFlMigMb9Kgy6mMEYrJC9dxrKgxOVnEVQbgnIi4HDq6eKh?=
 =?us-ascii?Q?6JPMOQGjxC8694PqYfn8ClxPYZ9qbrQx6Bk1wXFfDS3tI1PhRLvrbvq7n5l/?=
 =?us-ascii?Q?mrlU5Wi9ZXCcDGaNMz7kcpmeUIKPnYRQFRqhVMm2Op/slUMPm04sHzMK29DR?=
 =?us-ascii?Q?Q5K1dCC8W6vhkiqlWd3vNTC3l2788yXbe3BP1P7ENJSMK2rf4wnWoZEPQvGs?=
 =?us-ascii?Q?ugLmcJZ7oCb8LC3s3GW9UxWThuJ46TpFlf0XwQh9V/Iqo3JYt5JChHGVXGlk?=
 =?us-ascii?Q?TPI5XOjP9QdGA+2wm0gCXduX83Uk2RATY5R+RbpRl3oQp7U7evZTUUl5n6Zr?=
 =?us-ascii?Q?VJlZUarLDoZStG4bqTagcnZfJ8XM2DrgWR7kCXRMYYzbiZoYtUw0lRWra768?=
 =?us-ascii?Q?mzsEFhJts5w5EkCqRPbkmgeGQCXEyk7IJusUwnh9DgILBzcgnlGg65RzIPX2?=
 =?us-ascii?Q?s56ndXrojU2JQqFTmt9c2i/3OMZzIHbGqVHg4PXm1b2ClOpUxa8DREpLK/W1?=
 =?us-ascii?Q?498pr4jCgXCWg6oV/1Z7/gxIcpN8h2KKns+/mORXT5tD/dJkPruxMy1XtgoX?=
 =?us-ascii?Q?YjHzMQBoaH9xc9Vp3XDUQ0Kk2CjY+ZX9eb4kfKxctYown/zDlGlYxamudY7P?=
 =?us-ascii?Q?L0XMzoi71UhQVBBAQA/390+LNMZ8mUeuMQGwTl8yE8mObSC6odbdlpqh+Yj7?=
 =?us-ascii?Q?VFViTgcj5ei8XOrU/Alg3j0cUJcyZ47faS/CnKaJ3xiLRrHyhhOxLI/Ud37U?=
 =?us-ascii?Q?TiuFSUFebgpnzmvq0AHsWfSQlKfE8C0x5Jfzn+KXkoocNGsTqhTwP9HoLBxO?=
 =?us-ascii?Q?EIVgxAlJkOuGm46JpMMnDykzWF2GCPH2B+nKuTo+sa8ve/DFrTejvB8iTTBj?=
 =?us-ascii?Q?UzhBYn8+hRTnHU1MhbgKud0CGKhk5ZDRwDA92FdNBRhykfiielBR4T5gIWhy?=
 =?us-ascii?Q?GLsK/pSVfSboyoztoi9sbicmt07+CMq4uVrrd5/D909NHrTv2rEBAD+scOkW?=
 =?us-ascii?Q?m/CJzy40RrgYoZO2MGViS2poO73slLTJsgHW03T7kqQq90i9RqcHtQVc3/e0?=
 =?us-ascii?Q?dH5+o5g9W9Jvd552vuQLdbeeU5sm8UxLwix9e7cSGCWgK8dyJC7lhhgsRVK/?=
 =?us-ascii?Q?s/CAIdEQ6SiOC4AnLTzUDe+JwpG8ZXakaNXI6KQgOzZQ2Ebg58CfywXEW+Q+?=
 =?us-ascii?Q?5hEx+Tb87bOLtDShsoLPkTadYTHfoqhcka4Ee62osFDrOMhp23EYhl9cIEY0?=
 =?us-ascii?Q?aq5X73A5Xz09b9/MiAAw+yyD7QpDKVWCwJNh2ab9chBEqGkXQYQIOZQGxHKn?=
 =?us-ascii?Q?4vriPSWEP6RhK7m643Qr0nW9YFxUWzDzHL+OjfxvwI6rrfukxuRRekqxWV5m?=
 =?us-ascii?Q?gf5zWs/3tXhnuJ0WtUYlA9YmjHSYDmRP5SGHpTU9siBgBZZrIGCXQ4FYsa+E?=
 =?us-ascii?Q?xzM00ojopZ0rqgFS44ZptN/Cx69SWgI+GAJHR7sGL/vydqEpREcDPU+FK5UP?=
 =?us-ascii?Q?t1KCxBM+bY8BuqrxRKpuJko=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 83388182-0da3-441d-37bc-08ddffc8de12
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:14.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFP16Iw3FmKjhn/cOJBR43VGS4Anxs0AiecYWts+2SAw/Pm551A6YuiGdw8FKp4+Kny3JSN4D5uKeDvZOk8R14LrJVGpGrCz5bcExX2GgnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index e90fab69d81e..744eeb2b24ef 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -147,6 +147,8 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
@@ -179,7 +181,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -664,26 +668,38 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -717,7 +733,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0



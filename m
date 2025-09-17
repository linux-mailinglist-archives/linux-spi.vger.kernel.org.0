Return-Path: <linux-spi+bounces-10084-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27FB82126
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1014E7AEE75
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58676311C3F;
	Wed, 17 Sep 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="EftlUJsB"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B813311956;
	Wed, 17 Sep 2025 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146363; cv=fail; b=Kx1OIVzL5uvXCtdJwsxlgN3QA9yICDn3SOGVBTGPicF0CcMg0BzN0A1Pgqqga5GiVDVTeJgx8posMNECdMtMdPwuC7+KZWJ74NzdUeXHI6FLbu1dO5KSQ57CwqFqiE/c/DKYzf1E8Y6ikW+25iGXe1aJ4xXEmA0Yhd1RSPOtM0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146363; c=relaxed/simple;
	bh=aEkMJuockb9sl1ayZ14mDGdzCAIk1Cj3U6CPoNGrEic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omuh7mF/AaNuGDKefg/zO/5RqSTy484PyJssAqtFnu07qhnYWM2IHy6i5f+HoMiGAXzWTfwrIfEhUNsrBNN4DFlmvcif7GE2WQGWOVZADSiG3eaSaXZr7g3754FoJf7xKTEydntK8a4Lu6hgd8kAI7o7iu29JpjIazQsx8v6JFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=EftlUJsB; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sD2gO7cH8Hg6BGf83KSs2TAMbwU6I5+Q7Czgi/+rVObQgRjRD7kQcc60tSWbwHwCsR9b+owcpqqPG/dAFVwdpsWTdPPIqbb5fJGipJofyWz1V21b/BdJpUQ3o4on3cIVNDE65+qcDpbfeYUyJ/UtuqguhNz2Ol4hfnMgRfCD6ITCgxYaY+ndPsbKDSPjD6eU3Bsw1+EWXuYFnR02vCPwUjgrX5nCKatVimsVf9dmnWQY9JTLg23yYM2glVy70nzVXZ4uBXa9TkaxgVw94C+CxihMdTqZcCCC8jVtKHEI1rnw1zNjuwY8o/S7KZuAzHW9qD0dFVekl5Uu8GYEj+MpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjf50/FibphiMtIUv6AZlH8E5lbJzuZyKIxZtjBkHlY=;
 b=ohNJwDso+lEv2dXhJ7/CCZQuydyD9mvA5Yry6pFoWsvVz7d+wdjj9Egm1pVi9feR5NCytj15XFggIE5hvI7e8XMyIOK0tMX3DOoxmlPQLK7URKiEAi6uoGVhWxFQ0zUCIEm9m0Zza1pF0zN55xBUbjXB278IrzVyKxZc27z5N+bbQ1CoO4MsJWpP5qjFL1G2t+0OpfyqV3Fjo4wbDw6NhkITpmFsl4Nr05HPCJ7yI2SbZCu/agLI6ydg3yLECoAViosBSBk3g7d5MH4eHX3kXccmBV9xVQBOUgYVFdOacNiRZU1KaH5wQjPog+FhvQPDT0AidRgnqNPZnoTUTihjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjf50/FibphiMtIUv6AZlH8E5lbJzuZyKIxZtjBkHlY=;
 b=EftlUJsB0XEQXvjGCdsuFOpym2RxdLWAhEDISgLckvPvvH5aiPgPjz41W32uh/lZfUahXHWzYGmvG8QR7IzzVeJ5QGreeHTbGcAUIKzWZDZ0GMlTVBzYN903QGdm9AcYLNEZBJSMDlfofN9te3LHm+UcOyy99MJW/ykikmfdXpv1+xVzjkIW0MRUK1WmnfZcOscwdSdCiRZzTyEvl6F8FvZTIDWd6C4JRqxJvtZFxqrAtJp/25rHz98pozaiOvZ03mlhc1qMWmHp/xm508IXeUVBsaFdzQatmYeyE/VUuNNUOCZel3hil3U0W4WwQHDI8amZuZ6rT6ATDEkGs/j+wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:16 +0000
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
Subject: [PATCH RESEND v5 10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Thu, 18 Sep 2025 00:58:46 +0300
Message-ID: <20250917215849.19720-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 4a02e772-67b6-4f4c-26a8-08ddf63571d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q3efZ4rBtj62oaNi+mOLFToVP4O1X733/hRVgaS60YhB3nG77Cdzq1GBtXr3?=
 =?us-ascii?Q?cxqBThHxuHdokN9JUV9kuvfONB97FOBc0g1dDd6VRI2Y5+rqP+ylyqOIFS8/?=
 =?us-ascii?Q?eVWfSoVCN7V+YM9zvCnBRb9Ko3QbrULvxldCy6FS4AqiyAJ2gOLbIX61MYDX?=
 =?us-ascii?Q?4J/eS3xqC//AcECQd1VjiLLQYRfAYcnNci93IS4LVpA21y4eX6W/KmCsxPRb?=
 =?us-ascii?Q?p6R3YNtvaMTePFJcxTrrtDWKA3QQLZ8/+bkODBmZaKEsNfm/NcIOzVeHh3L+?=
 =?us-ascii?Q?mC3bnyFZk2NwGXHmadeCfADxg24c9DlsL2dJkb6vQf19Tvm53oZG1px/xg7l?=
 =?us-ascii?Q?7Q+GsGRZ1A7G/0IrfREWxxi6f4vib1PZcMwGRcQemhUiebABdRCfUSqvaT/j?=
 =?us-ascii?Q?3punfk+mqqWblXSFkKpFecOQsECAdLfm/E9crBihQ6+ssbJQb81Mh7Q6G2hz?=
 =?us-ascii?Q?LK9ICw4eYDHF9c9c66j8aElivOLNfLlkgqHkZnxYampGDbBbynrE3bLU0aJy?=
 =?us-ascii?Q?6VUCYob2LVtwQDYK4nfX3OTiXHV4CstmFLW2RIyH8qPUIEszoKu1chVD8Qhs?=
 =?us-ascii?Q?/tKdP86E6VKG4+L2SA23EfV7/qIT4gJ3rTuNhPSNHHcJ6U9acspS4cTh12TA?=
 =?us-ascii?Q?PUMBfRPxf9ahd4K/tN0LeyZkvs/bGYZBNY/h2Z5rKFKacW9YgSN1vsoulOY0?=
 =?us-ascii?Q?L+BgE7/48HhxgjKAkdBNnXJlHYLGPwGsUx0dwUBMWCeS1VJJTYRI8qQGdC3F?=
 =?us-ascii?Q?d1wiRfpoiGLUMGrP2sbAcHrXaiGsUS/uinI4xc0EFTzR4Y9hsH72zuPvVJ1q?=
 =?us-ascii?Q?GNP0F7K8WLLy06e9oWZcbqAeKillUcIu49UI4HBy7veP0hKD2wvAc+i/ai9/?=
 =?us-ascii?Q?2H9S2aamGI7oL1v8htoaljtoZ+aQFR0kLGdc7zjmITvLXWFrUbJSr2yDGWJr?=
 =?us-ascii?Q?9iFAuR8yCrkP9g4sppFISfCVyGWbVfWUoISBD5+9IJt9rpOePRH01MYD8H6e?=
 =?us-ascii?Q?2FkIG8IViimM3WbuDd0X9xRUt9lswjXtr/DFuKRCzpsAwunyk6SoHPdMpD3m?=
 =?us-ascii?Q?2a9YmK2NnDpxLC3pp29rJh30inzOLQcSaXMp2vD3Aq6gm3v94S2Upi0RDGWK?=
 =?us-ascii?Q?VH/+uaWL74a633z/Yuf9pn9/8vIoUsSlNxu1zAVwPJAsOw8pIVdpgRJObSZ2?=
 =?us-ascii?Q?qWTTo6ifqpIuqBM0ctnFjsF08D1UhhXZbjNmZa/caoA3aaf6d9EKSP43F9Zi?=
 =?us-ascii?Q?rjtL9eoPL3POXdSfHWjVH9RYL83qXyV5vizzg9VE+sYGn57cWHQpewI5HqpF?=
 =?us-ascii?Q?PRWMikVIetwsDKwm6QhoDQ7wUTSgf5cNUjBSRHQ3cLIveBolcDxZIjvBEt/7?=
 =?us-ascii?Q?X9HTy0Ct3kFGfL5sdwj+R2w8fsdr3Psi0pLVhJYLJ5DjRnVOL1ugW2RpCmcO?=
 =?us-ascii?Q?hiOBiF01RVaOqzdH1kALm+VQYOh31P2IoKi4LJ7sg6tCVx8+iyYysw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cV72LNLkzdczaqtJxNTSUpfrll4XUzlykKK2QG5hsGLwOBY9SB1qfQTjVRnK?=
 =?us-ascii?Q?DZzI2/5OcDbqj7cHJI11LP1iVSr3n/HGYnfeQEWNiDArILytO/iVAp7wQKll?=
 =?us-ascii?Q?DuKpG0NQez7YnosGoPFtB8+ZbLlPR7DmHccTMLTY31VYVT7V6wNDvG8Vq2cc?=
 =?us-ascii?Q?lcbFKbDwQL2ZPIGxTl1AhZspOusyRjAXS1G7Qyet2EKPoeQwkkZk6UWiCFln?=
 =?us-ascii?Q?jJm1AqNiaCvYTU6UdVa28Ln3wTDy5Mj6bqr3CedSQRrejAUa5y9/hHxUoyf2?=
 =?us-ascii?Q?RenEoFqxS6G8EB4rZxr7y/PFPA76FTOnjrSJf6jpbaAMdb6OxX1yRMPSMfVE?=
 =?us-ascii?Q?tx1pe5m1AsiRvfcNwYVMzRTF9wact+FZLkJ7b402q5xVHNN5kNjzpCqeqDkO?=
 =?us-ascii?Q?4dYrY2laSv/MQjA3YIVeOXlXNU7W40hI76iJ+yN9H14UpbIqsv5w16QEEyf0?=
 =?us-ascii?Q?LCLLs1wJJCjSvFxzHshjLOZPt+/n6d+xivoLpSLI6BVJ3n89yYAOnrYeeqRz?=
 =?us-ascii?Q?WKkdgtMxiBe/qnSf4C1GMvziqfb97VAr+CAjMNHjspteBDSLhbfMNOnj7Zx9?=
 =?us-ascii?Q?Wzh3gvQjsdOLpq4+kR8ICH+53f9nA3gWmIj2gArI4biOBCmmvMNXRX7/DW6d?=
 =?us-ascii?Q?W9c8HizWuvppecd/e/QSVupmm8omomf+qdaBtyfHTM7QtufXKWic9Kr0roaq?=
 =?us-ascii?Q?7IW26NQ937BQFKShk0HKBdWdkTbNAgjZiTR6zxumjvv2OQCURKkthAYygqRr?=
 =?us-ascii?Q?9UqHBraCeloLarsC54FdIkOhUDl2CszfWNO4p9k2IJytk3oRCEwIIMshrgRg?=
 =?us-ascii?Q?kcW+7qtriCZBlfKIs0NpxBgrNqISkHYa5yvT76MDlCVTYiR7WGJJuccDLthw?=
 =?us-ascii?Q?Q5tXmKZ+be2XGh/XifrWPciUp7/VBcQqBL23SnFYbblpgw5ti1z83FxKLgaF?=
 =?us-ascii?Q?FWXYfdpkDFCEZt4A+K6rvOBpmkOR31D6M4tY+C1hWU6nGU9THStPfr83WLC6?=
 =?us-ascii?Q?/GxpiqoxoKereSvTgoOu6YBPdqwavAU42zB5g1LlNrZWEZOs4WmFLDcE95lx?=
 =?us-ascii?Q?1Cgn+vMYFruxK0jguEWKUxRj+9DQ3AcyyajYPdbyQ5U5JVyAm+QY+JW7/CAY?=
 =?us-ascii?Q?mA3fLS2Ss0iEFXhRH8bOBR9GLezTyjWL73zbmIu4ZIFXR6+ulPs5dFqZZCnl?=
 =?us-ascii?Q?bnlGTDX54O0bCqm2oqf71bZCDakuBkipgOkyAgo2ZHtZ83fkTBYXePacm8Ny?=
 =?us-ascii?Q?6tk7z49UiZwoJXrCy3qzCf1zArApuFVJOdCzefpQcb2xCO7siS+duJQZopXe?=
 =?us-ascii?Q?Jau63b8zW3nLaruk/aUD2bYQYOoP84SQGXzN62GNxGJwtACqM9SAvhvLGq8F?=
 =?us-ascii?Q?e7Kwg2tMndWK+/1avsy8fb5DRUvEngD7fPnZFaw+wmuNniLvxONY7S5/ZWvf?=
 =?us-ascii?Q?SVk9ckeJpVD/0LaOI+yHOh5k3/q0pUX4rv9SiTCahDixjwN3xjzCUOlY6UTv?=
 =?us-ascii?Q?9RHs5/Qhq1aeotsoaE9lgVSrnBWJLBgWLd9X7wsMPdJgpDaiHbxLXaI3/EO/?=
 =?us-ascii?Q?VD+HxaD52XfXGETR+p+0nWXwKGakel8oiOITVPWVcaqztCFipuPGWp5HGHTq?=
 =?us-ascii?Q?ZVIIOO/jL5cq++TsNSg2Mk0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a02e772-67b6-4f4c-26a8-08ddf63571d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:16.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8e1oq47xMyf+3TU2l85KrKMwZlL+IP0AndNgBXriWIXk0PAI13qchlLxQfUj5SHnV50yphvpMi1NutoK38qQo5Cnx9FT92Gax8kbBVAhCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

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
2.51.0



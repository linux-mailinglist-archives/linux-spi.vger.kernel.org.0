Return-Path: <linux-spi+bounces-10359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE3BAAFE5
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C484420AFF
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901522CBC0;
	Tue, 30 Sep 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="cHib+Dbs"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021100.outbound.protection.outlook.com [52.101.65.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD52264CD;
	Tue, 30 Sep 2025 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199236; cv=fail; b=EZoCaxAG9U8scB1jORQXtPWOxYlfBqfHP6eC6vishEZrfjzKqV5LD9tQ49rtyZeISrAafG+gbFxWOYFzShtklBgJQrumciu4bIOILIpgj0+Fnz4M/MJkbkdw5nKY/E551bzCAq8lRBuB5DNyjg5DZQBXISdc20jDLOYGhxQFAkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199236; c=relaxed/simple;
	bh=zH7wyDq+KpSDXVPGlFtvwtEE1Qbyz8oc1riXjTJR804=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6iHGt5EhY51K0lLItmxcUpWj0msj5zbVj2xYyg7SaF9glGDoOgaWimtmQvao7CQ2gjtWFaXu2f0B2medkpmaDXpURwUFlNioynHudcFmgycIXPITBieivwfRl8KCVc8QB8i2z7jY7zI+WTadCsMeOWGHiKp9GJQaJmZ8tYizfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=cHib+Dbs; arc=fail smtp.client-ip=52.101.65.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTkYk4UjsKXYTFnhAj7oO5a2F/iLzDmDngWQOQfssht0UKjs5N1pxT1J7arZT6SKgNpDDAa5VsZ/11onHaL93FmhkH0xG53lKl2abkYHhmi4HK9UVjbHEjzW+2eB4SFQnuRMbpdFk3GPdvJwEoxK8ID2ey5BkGWOhpKB9Yco/xr5/vEhLKttk+TUKxosBAaseZikTelRqGcaYFgss0APoGmKwEAigrKzTtGWUaUFukfmOJviUDp9SxKueFQZfOmx6MIZKouP5617OVPOyTlLm53TnXs1JQ+y1TyFI5AvwLpDV8k7uNA5cvgyT2D1Ob1O/m+fiEdBUwWtm3bUIGvkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K88grx0y09J3/wf47GVoGuVjwFlXUQKbW57enA2smmw=;
 b=yqc3iU3IVJ0RgBskaAvUDDM/USEAHshLkHHH38JAT6GIAshH1zkb9JvUcLQ53Zogz5O4qSBrNXAQR8/uihE4hCaXOgMhDOGt4xLxogUuvvKY4JbWcp41LVM+Zf0MrRkJ94lPk8Oo5HeLJ7igUwRJlNQpMQkhQPcvhtozuzZ9kaSs9Y2GI7GSXOoY2kBqg4axwkwVm1TfWurAl9H3Tc35cgOoL4nY9tW3mTp5P17ibYrKcGsSz8+Q0V04bHcuaqIw1RNc4w9PbXv+7i/SR69qXyiPnUsdR2UMHZe5V4gxRmH0iqHURC/QnB8ggyuQ7NPdiP+BJfDkDKcvHwVa+wGvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K88grx0y09J3/wf47GVoGuVjwFlXUQKbW57enA2smmw=;
 b=cHib+DbsGe3YU8CKa0JeXlNLi4C/HI98GYVffx8KlMk30OmU4FLgf4Jo++yMTCh1eJ0o6KfBLgchpcVjxun9vE3gArG+rMtC3zEfb3ZRVb1JsqXC+42TeXCPCequDDy1j/4DhNOsw9Zyl9/lQHjCJnzgEwNIrjC9dYr8qrLt513vTIJ/T7iyw3LgDxh7z+LRmrEs8xdhwa7DDiNj780IoQwQPoyngmslugZ8YLhLaFajQiUrDFNyOx6zlVhayihY7L6eHIGkFwjRgkw5qa1TDocKfLu5FNgW+FzktiXJggPMmsOK10EWOXX6l3O237bopQ3tnVRPdyMvSNBARTSqfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:07 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH RESEND v5 01/13] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Tue, 30 Sep 2025 05:26:46 +0300
Message-ID: <20250930022658.1485767-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: af92b734-902b-4bcd-f5e0-08ddffc8d9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NuKP7OaIK2MA2NoJ4PvzWKpmy3822qqtfwJ1Y9WlGB58cg16bbgbOwtj8sz?=
 =?us-ascii?Q?q/oJ0SadM5+ISJ+vNfIIRTEP+9jpsT1GtBDUzx5brHvlvpk7gAZo6y9O8qLp?=
 =?us-ascii?Q?IG7osrTtFDldjXpvZn3GikOs1/q2KoVv9QqfxnHOQOfvc1UbKHDMSmkr5yWn?=
 =?us-ascii?Q?bZETpbNPO5IBRiL44chid3UwZoTrEnok0zKnoRGbu0+v5IfX+xl1aaalvnwx?=
 =?us-ascii?Q?i+baKE2ZrZsToeCkIaPj6ayoaRe75T3uwJYmT6rZHG4oFmmJBYVHsvYo8aDf?=
 =?us-ascii?Q?t4+riC7m85221VYK2MVNQnLsaTt1vwqEaR7eiOAII++TaUCjZV9XfymNwG3p?=
 =?us-ascii?Q?KQeqIKM0u8TI+36lJOOn37ZNuBU8n5tRH+5tLa1H7hv2o+XyxPU/IjWoNMGH?=
 =?us-ascii?Q?P9c3XJe+oYwInILu0tay5aQgb7Z5AaICUfnTYzz9jonYzNYj35J+8dPulpiN?=
 =?us-ascii?Q?UcfwiuYjY0p8CbMq00t4QVELoDYEYkgCCin+V2kSChkSXtlXjwKLXxLmXLY+?=
 =?us-ascii?Q?6X1vwQHkVJG+r8uKoNFw7FiqCTGwIq7B0lX1CVaO3zCB4sYb9CztGuHurT+M?=
 =?us-ascii?Q?ulgT0hAHn4ZkjtwfDcxhgPTGSHspGNBpLVD46KEtcmfNtWJ3cscaj8RzTd93?=
 =?us-ascii?Q?LvaJDrk4KBXxvvJCx0BgfvX3oN8yPeZAI785AWift9RiBFuWVToPpSKmyLTh?=
 =?us-ascii?Q?KpRKkR0lRLt8Uh03J1bsyJQTz+01dttVxDpL9NB10vZZ6r+ecLlmfPfUzafj?=
 =?us-ascii?Q?kNkRK5Goa4jDceV75qfpfCVPGhicOw5Ro5HlvZvnciB3USmuLkYCoIpCi4QE?=
 =?us-ascii?Q?uEa11Bgj4kFxlUf7Wst23LSlOmYgej2t9+bRhadtHGhCJc6O6Z2fRDgzpOVN?=
 =?us-ascii?Q?0e27hV3GlsGCEie2+Nh+q6hpu0bKCuQ6o7Yv7VzL9BTeSS66+WrvchM/1jS7?=
 =?us-ascii?Q?FHzxphPJeeKAkxWYoHixhAbqZdePZh/SdRxA6ElZ5KGbAlbS1CHG+RqXpvTj?=
 =?us-ascii?Q?CfWFwTZcBNkBOb/ZOur1uTLmVvZ0+R3nPaa0DQ9pMK2AoxzyiEl4FqulnqEX?=
 =?us-ascii?Q?giy2wti2V3w0K7lH8tBgeIW5LSjACwmh+NHJqfieCYm+V9jtNOidsXgyeGNg?=
 =?us-ascii?Q?kyybKiYTelgwh3/dcWyhL61ZT0Q/Uwi/Eo9Mwnh01701CWL45D3lWrkUvBFI?=
 =?us-ascii?Q?bOW6V0BOddf+khWL+MBBCU+QXS3AS9JbLx+Y2Bm0EotQMj3pK4QFYCfRzFRG?=
 =?us-ascii?Q?p0FwiSZzeHttYhhsP39tTvTqhdGwIg9YS2KvvAgcaHgZvyl1cEQiB9sTIWW/?=
 =?us-ascii?Q?M11tvy3jcshvv22CcJCL74INZDH7FrGl4tZtLzR/ktuzrz4eS4650yc0kq5f?=
 =?us-ascii?Q?laxFb06AxYMpF1rOW5+QnE2diGsc1g3EPOde68n6nEqK91UC7NQaakKThuSR?=
 =?us-ascii?Q?NURglfM8BBAzCbKBwqdJH8gytnQtezR7tVC/PxbmstGRJrJkpbUmAGZ7hFaJ?=
 =?us-ascii?Q?f4wKN8qjF6wvVWfkbCH1H07rR/A3FE5Qu7Ke?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CexKND4G+pa46xTarmB8NFW6FE3iqONweky0NToEezNfCwKyT88KzdcwAGdd?=
 =?us-ascii?Q?DGVREI0WP0p0cFjUfjyyIUXCk//8o+TI1r5hvnweTWZNCfAqSbZnvYv9/Y5r?=
 =?us-ascii?Q?32NeA/rupEcsiR7UqhFEaixTF+lboqrKdFxECSiA1eAQbiQfXyArbmK5FtWx?=
 =?us-ascii?Q?EUWcNZfbdXpX8OszXfMkYwwMjyv5crhfuoIDGWSEX1nvCti58am4EmNPkn9X?=
 =?us-ascii?Q?yiC7jY8m9qTm7euRrj1b69MxBWh47Jktflg7nDz20AZOqbZWZQzaFxa3lsi6?=
 =?us-ascii?Q?ElpLxEgibpFjswvnpcneUkKuXsoDYznLHD8gqiV17fD+iWrvvEH5OL49xWOT?=
 =?us-ascii?Q?9ZdFB7P22dwTZyf90q3hDdh8B1COnz7izcepfRPxX1HbYmjiIDUwEoIidk3B?=
 =?us-ascii?Q?flpAbdYNZl8LffGq2ck4HYB07VsizaSA1Qw45t1flHb9yic/LzTekIbfi4sw?=
 =?us-ascii?Q?8Ae06PNnocgqI08HYZMBc0b0GkpaSaZZxpymNhClyPWa3J0hRUvOR2/IJ+Q5?=
 =?us-ascii?Q?AA+mmRMdVumkyEMpxYS9lL1OJT5EuF9fB2Iy36i1gVOpQMrMIgnDM/OZ8nou?=
 =?us-ascii?Q?K4qEeDKQZBe/XDNkjoykiwS+rQN2wktf/Go6FMp1ZSdkcWpOsLAOrzlVlbub?=
 =?us-ascii?Q?nYF07KTziHYIbNDHrLLfz2FwlejHE2hvnzQC0cF5USmtIme/gUJxoJM3lRDu?=
 =?us-ascii?Q?fMc66lfcP16ia9Cy/2CzqLJPK3szbG9VY8gGvSC2Mzk9syaHSFRWJhP7fwF2?=
 =?us-ascii?Q?bGz1XRP0IRPQrb7G6ABtxoQPuoTd8p4JZeefpR+DXu9dqAPjEB7JM8cudpUA?=
 =?us-ascii?Q?rdl2gNDkuktNqvi9zIf4EeF8GBmRpZieVlH4t+hHCiQjVSnlp8/h1Zi1BlCp?=
 =?us-ascii?Q?mKQGbl0gBqBrHVn/xC3T9q97+xpdxGLh1/yAXShyLJeSRdhNGrKSiwHBkVBc?=
 =?us-ascii?Q?C0uXfwuLswtv/whmTbo6Xi1pKn9jULAR9SFtlFdW8eedVVWBk0/i3eMKUjPs?=
 =?us-ascii?Q?S97r7PKylkmVUT6asFz5dgGflxKxWJzYW2fk16f1LTVxXmLY47xCmDGkh1qu?=
 =?us-ascii?Q?Jly0DzrSqIt1VGlo9i1QFg6e5Pd+30AuPFJcPQH+bpi5ONEyf2zlImbd54qN?=
 =?us-ascii?Q?YYyXp5Y+dCS9c839ihkh6mFlMoiOvNqyJBzrK3fRBq2qveoWbtWRQUtBpr4y?=
 =?us-ascii?Q?wCkYhDNozU0wZWDnIzXIKqXgEh2BQo0rDr0MTqKESJSwaisGhS/Sj3AU7a0/?=
 =?us-ascii?Q?e2eyTcNUQjD1mStqZW/m4OeKSQMbW97kqwTKf8xpxEB3ZCAKqe3ua2z1I3lC?=
 =?us-ascii?Q?dG5ylALC1D43uD19Sy8OtzOvowdF5fxbsorQOQMAuW9UTjFKJ1GAls/a4NjH?=
 =?us-ascii?Q?gOgreR+1nYf8NdDgWX0gUrxVaVW+FofRF0uE9YcPZrKQJYG9clWQ8tFqUgQD?=
 =?us-ascii?Q?nwxEtPg7+4xgTMZBh/8AEIBHCXVlg5FxPk+hNjVMen2QNwbIjBAhVlLyLWal?=
 =?us-ascii?Q?CAFPViDlh6I9c8wHc5hNA1jd5C13qlKrairAbtxSrY84N54Yn2bs7E1XQzX5?=
 =?us-ascii?Q?EVaitOQ/bwWpZGcBcgCTPWCSv6oA8ajw99Hmf7Mkmuo1gOIlsCWWnJcTg24D?=
 =?us-ascii?Q?OWX0zNtQeD6pEWxdm/bD+i8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: af92b734-902b-4bcd-f5e0-08ddffc8d9b1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:06.9351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIOVUc0A+F5jlA/f2Czj//dOlX8g+W9N1kqjUO+JpaSLryq3EaVPaPVCtEh6YszodBDtwgdOGQqTbfcfIeH4hiObEgjdoAeObfL9TqvsQcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.51.0



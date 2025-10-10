Return-Path: <linux-spi+bounces-10508-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B213BCB888
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4211A62759
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F332798E8;
	Fri, 10 Oct 2025 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="2fHtnSS/"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023102.outbound.protection.outlook.com [52.101.83.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89C276041;
	Fri, 10 Oct 2025 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067130; cv=fail; b=k993QdSbPLmVkmbGOyiHqpPikkSTA9vJTpKda7T9luvCn/V+mZUUfQg0Iob16UHK0IDrm2ztlRK0X0ET9B/2Qs9nPh2F0i8TSMOo+l3KdJam+Mr11Bt+e/jz2091yx3pQY7UINIAZTdyOuhG7/VguXF0uu2PTdEeKwdMonhEIO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067130; c=relaxed/simple;
	bh=1Z4+3ky3F5ePAz1LwMNxiUe87RYnFEz9pATQjAUyt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fu7hR2e4mCnzjIznw7LPhAqSBv52aoEmIROvDvduyCNd53PCwJ7mP2NDsa3RTfsCNviaOplXSEPJX4MEv/a0JadYoNbivlb4nj4695iwExT7avfnXf8pIpKqz28xB/td5sIavXA9VsJY5SoggjqWKuG92pW9CIuMPyQWnKw1NmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=2fHtnSS/; arc=fail smtp.client-ip=52.101.83.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpmnIfODmYUfB0DVq0boiwekeYK9naw6sUQr5aFrhUt1nOccwq3MzDVsXEVeQt5ZMz6X6A9SpxmNt9B5Qu/wzARPn1PeFKJFiOZJimFrWeGLUoLwbSFa4T9HJRlg5kLl7LIRhDtIhTm8pqq78hQyahe5TLcHTHtkyVCFh1UAazlidgHj7vDR3o639KVAgQRpFCLj0cEZhwmvojMMI2f5XhhvDWZfMQCiFAsqfEt+eoSXqkfg5DPIxCWnI/54hVOiJZjqHzQAKLi828oI19tgbsuExq39xLnvikWh7V1rQYqfvqwuGTCmP599Zb4B9fIG1REAFApO85l8jMQzklxQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=cNUJ/53ApWnv5eecO36AMdi5EsFz2mZB6iYGAoSW8IVYGzhXQtqehbjR+SKdLZK8gBjHyEcnyaRzcALBD8BHFPVWogFoiifzVBFpmUZNKQHfE8fBdZEAplohU5HHTq80IvBL3rfWlSZy4HTD6EbCN+t8C5UdKN8cbs8u6aNLvxwOffPybC2sOL3E+3uHMKGnby3Ip06H48CGXVJKtNODrAazHxyDsqhZvXUaYASrXkkr+wa0gHvlTACq0rDwybM2essSL8sKrNRC7r5DAr/dW++MlPYmoVo9S5gPUyVQNpS8Mw0pAtiewpeccB/7otWNAHbaeajTZfs9JIiFdcxj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=2fHtnSS/uEmX+NsPzFDtCivuZwn6HaaBuYSO69rqzbRaBBXTzfIQ8l0PzyZlQFEKzj8wb7nwIyxCVve8FbDkDBxKm1tsmnPYYvdBruCQ7D2PEI7k9CaS87Q9DP9Xwgx6qEDc3HNTKj3TYnUGuBpGytPukpWymYRc0wnTerODpyouD+zbQgP4f3EqiAcyqtaQWvXHoLCS0vt9FuiPORHhDju4nPACk/OWlUHHWEWO+YzI3+pbzEbV9/bi13sg+EONLo2mjl+IjunEg9hVYqvj5L7TRytH6gWVa8xUwIVryz9qE2T2t/6RPEN0JyLeMWm56Lv14jkOQ86WQROHf7Zk+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v7 09/17] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Fri, 10 Oct 2025 06:31:28 +0300
Message-ID: <20251010033136.1475673-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 900e236b-fc12-4f7b-e7b9-08de07ad9209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i9rTne3ADbahtIPzygXF7rHqyCEUQ9nOLNYlt7Cw8Ua2R01fi02UtypQoNDs?=
 =?us-ascii?Q?ykhs5jttImRUVXQUjLgonp0Yljp3wHeGYJ8o+atZggznSGo4/VzNjc5Ni7oh?=
 =?us-ascii?Q?u4rclGPs7llUW5hNeWYagbHIsn6sQn13/J2pk+fCx+Pok5MErK9XnSBrYbiJ?=
 =?us-ascii?Q?RpcBTL8bl2yPOAx6m5nIlIyiOGOvv2W8h6CuIh3+4rzStASS6Su08V4OiE85?=
 =?us-ascii?Q?zO1RKauLrqrDdCIPINUqWPbj/9/Paw13UBTHiCd+0q73BzZY8AQ2730oL1Qe?=
 =?us-ascii?Q?exz8spRmllZw+hRMseQL3nzHHBCnec/dANgavT+n0iNSR0t9q9OhNGpldR7Y?=
 =?us-ascii?Q?B94l/Y8wvofLITAwRPShYtat/kM/TYhrVaDYl9OIMTe31Y7fk/aTke8fX+yg?=
 =?us-ascii?Q?O11v4JQ9mCqaXTbe+QsHw6dzu8ZJZdP+t/CHKRkPeQwLNFqtvKwQlyx17O7a?=
 =?us-ascii?Q?Hxgl0GADH+EQV5F63b5Wv4GR0NkkBSPf1tlYlgupk/PETTVq0eqw+OW2ayym?=
 =?us-ascii?Q?SAmdr384Bhksw/pNKdqg9ow3N+z0VKhQpSW9WKVXWSP2NAxZJ2/6daqZIh/y?=
 =?us-ascii?Q?OHINGdRPm8+POtrmFcl6myu22x1pF3Vl3dyLvawcJNv159agcy6u5GIo6FZ6?=
 =?us-ascii?Q?4hd+ED53I/RwEuY7U6TKbK1ARE4MaXOCyz8d3+4cQiK2XVfXWk/zzvO7fv7L?=
 =?us-ascii?Q?eODd3nBuXhV7TgUv7qOoNjYiMWFXouPZD6JQ4F3lWr8Fua1uoqbqICCMYsu9?=
 =?us-ascii?Q?vsbXPEFaV8fYUbfWU0hJM7jkyAZg9ooQCU4AlyHWpRvW4R2RcFku/ymg9nr2?=
 =?us-ascii?Q?99h4LVPB6AgYNDAPqZBUlrQP7mdHHVnZRZt5JlNMcX7DAN2oUMksoKJgYVQu?=
 =?us-ascii?Q?nZKKGPILEGujnHLr3OiIZlvTqI+XXpkHYeQwOX2PYydVvo8f9bU8bQouZGAC?=
 =?us-ascii?Q?R0SNIYDlyIfnO3R3nQ+zPkfn6u92S0MY3syBfOtysy2O4EDbEf+aWnL2arkG?=
 =?us-ascii?Q?2OxoUtFIVsbm1EDUuxe3qKsDmPuZPodGe81N9uyRP6tYTZqw5reeDRoO2X5c?=
 =?us-ascii?Q?bD/dKiL0qDBIgkB7HklAQAqwX5pwzOiX2pLc0pyKcHp9uxcyfulhytQ1Lh3K?=
 =?us-ascii?Q?NWTLdbzN1dtD2TOVTuLcvkd3SUGSCIQVEJso7EV1VkTGjZAX5rI56eKsdA9q?=
 =?us-ascii?Q?1QeLuAGoWVZnHFPVvQ/iT/bLZp3+HaqLtPqV8Vluv9JyaSX3BKpR+RzJSj/r?=
 =?us-ascii?Q?em7VdrfIOtzq4GERz+99vybImzwJ9Et39RaEEHrBlQ8bpvr8Evr9n93djHMW?=
 =?us-ascii?Q?gzn6A9ybQOOifr0AZX5BNggPTA7ScHhPxlYjz1erdFshMgnGcjtmgeCmYlb2?=
 =?us-ascii?Q?Eu1HHZ4/dz8A7Gt5ZgUvRjUFprLxhudAXsrtZH02uP9HxL24D/0/IyPadn5+?=
 =?us-ascii?Q?OMO6OnxZxaPGGIy1hCFS+fvuJKDLiybLngWLMuiNeFarqBjwJrocfN4kkKB1?=
 =?us-ascii?Q?1XgM29KowpRxhfDaa/pzSSSeuRQyJhJRVqtYzZ4QMTmoCibUOMI+rAVk9A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zYTHe15wt5msi4kFnpA+2CU1XUFqaG12EzrGQ02Fs8G3pMCO9CuCprc/3dPR?=
 =?us-ascii?Q?RarTIORsebILJMQj0Lwj63Nl5zgwMxYt/nC23Fpc8TJVd20YjfeGIPh0iEaC?=
 =?us-ascii?Q?7bWuC6kWLcwrxfmZFlrR4gkQck1QpjkX0Fu9r5r/OUkAL6zCHbTyuDdYtQMX?=
 =?us-ascii?Q?6YasFPs0Ib3BRfvsQNcu730L9SnZPNZnIqaZqhU6ET4mLwJ9r9OgUTlJM0xH?=
 =?us-ascii?Q?yMa3fAsw5rbvdFDhh+DmyV0Nn41n68CSdfqHlwBqRvOuZtpDXTzw/mWt75gA?=
 =?us-ascii?Q?W/DP4cworevaA5lEaBYo7M3btoN/JzdDp/6ljmd/mF92i/DKhtdUw5D9devs?=
 =?us-ascii?Q?yq3K1DhpTH/2PreqOd3AH5cY22OT9ZpoUfHyIXXjScyadmUi8AKpfY536o21?=
 =?us-ascii?Q?3TdVeS1//D8Uqd7ylIasQ/7Y1Jzbb3grk+vVkRfoyrriBW/c8py9alRc7J2f?=
 =?us-ascii?Q?SJdKdxVKEx52mSKnZk/HfqqHdI1aoowx7nl2jF1mykS3NsBbIV4IFV+9FLIm?=
 =?us-ascii?Q?ihSpTbpzFgG4eurWPXHbC1//ZwxSIlxKRYDlbwUhHDJIF3wIQHwoSjn1xioD?=
 =?us-ascii?Q?1r+rU2n9IpLp1P2g2fCeNNFc4gQ6p/I3QplASbpwsZB18cEAV47DUBrKLjpp?=
 =?us-ascii?Q?0KYAZE7Mmj2Cmn//ueCYtLJHLyaTPaS2Cw8WpOlHZTHOTp0djhJS1A0pJCli?=
 =?us-ascii?Q?q19fi6zjPA2It05vAyNlm4UptOTQrwfZa61CGGikpiqSZWI2SR2BOUlGhe7I?=
 =?us-ascii?Q?s5Xwiudl4o7ppq3M4+z3dW7F0zXrW89idKXm5E3w9LbhMkWG8YKqQO6CN1tl?=
 =?us-ascii?Q?o5HMkN+CgwdoKzJw+k7aCzieher1xR1lW/GgALsLFlU5+reVk79orct+Khq3?=
 =?us-ascii?Q?34whNxswFp4msRlp7Q7zDM11vYrKOpdrx6xi46wnCcNHbQLu/ArS3IT5Mcza?=
 =?us-ascii?Q?1D8pnwWkvTzUYOgbxw0hDkLW81WWHN9ZHEWIGDsJlZyw6SC8NhHjJqb7L1k0?=
 =?us-ascii?Q?7kst9uMTR2uZcpYJDFMQ6TLAB6r1mMxnapDEpF54L2M7QxlVzZ5x1OIkp9lp?=
 =?us-ascii?Q?gIgqPCQNwqV1J1eO/d+YPrSHfFKvW6oAeS1vbHcQIBYehQlYKjNAPRXwJ37l?=
 =?us-ascii?Q?xBKHRq3uAotHVS+gwRxGW6vnOr+f7XxXizzRqV2zG8ii2xve4/frezCH0EgL?=
 =?us-ascii?Q?ITIVLZutAi6P2HvxmZ7RRYiSNm8b78NRmaFkKjSD2OnPihiuUkmvMULAyFn2?=
 =?us-ascii?Q?zg95jnFvIquAoreSspNFGAlgwol4H5YESJoVaHf+/RQWM8IjOoBcqDd4lsor?=
 =?us-ascii?Q?IpKJ+MQ8bzb8F2CwRaiBwadROboE2GuFVgA4gM3ourYKsagKHvqByU6ZeCuJ?=
 =?us-ascii?Q?34FIbQQv9FzOPhflgmYUcz78BhnRmT+49ZheXGcCjNJMFBou7Mf2oIQITrTP?=
 =?us-ascii?Q?/WDMXws+Z8TTeOWd+psCOgtib5m+p39zW1VnuVkxG8uFKRnR5JhJWBZiPg6w?=
 =?us-ascii?Q?v8ELCumgmg+2zHnDzFVjcqlpschKAYdPoQM/WDsDsAvppR8Jhyp3A5rJRrOM?=
 =?us-ascii?Q?UfGeM9nRQKdg6x1MV7wKt17xtyp1FuL5057St3m+pp3R5+x68tQnLj+KvR7U?=
 =?us-ascii?Q?yhZ9NG1NhbIviIu4AC79L1Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 900e236b-fc12-4f7b-e7b9-08de07ad9209
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:59.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS+DbdLP6kNbRNSu3gD/AvT4gjOsQLes0eoHdzen1fB5yr5giqOQGigw12YrxOnlkXniA++54juAcV5i8lQ8LAzK/E9eIawn/TTZ9OP2FW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 744eeb2b24ef..719b424d4cce 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -518,44 +518,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
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
2.51.0



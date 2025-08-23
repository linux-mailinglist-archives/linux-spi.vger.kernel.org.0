Return-Path: <linux-spi+bounces-9643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22FB32A39
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC2A04E2675
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770B2EE61F;
	Sat, 23 Aug 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="mAUi9NKQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021097.outbound.protection.outlook.com [52.101.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C32EDD61;
	Sat, 23 Aug 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964902; cv=fail; b=VixFrqZv2O8J8ZY/gPyvwPT11tntXCvpGNOwFYfU5ONxMAXBCvjLds2AAlc/hwf0X3oDZE/dHqC+VhMC7IWjpDOioKA/36g4uJj9uUl3DsInYiEKH+3FzUXsTrQ0UWQKBSYL5RJZBbhLldMI5DWqmII+V0FPJ0eqBtlSihRlTiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964902; c=relaxed/simple;
	bh=+Nm3fELD9WL0sP7I8SgBwgxRbJ7HPuWkU9SZTeZ8DNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csTYWe7oscUCQh9Wchh607MaT6AHX1vx4ACloZ+CbNb9jfXSDpLswCinWOQt0QGmpI1ten/RcUXRxDnlaLtYnFQcDVC01RYXTd/uWSQ9OF1lrYmyI9NKYjMTvAa2wvk2qiFPiEHS+xOXOrsP6h5XgPZI/uHHT7izH9q5THszNug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=mAUi9NKQ; arc=fail smtp.client-ip=52.101.65.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sO/mWP0dMfJ+hETF/swRcwsLEAKfd9Ovx7uNDc0IRAaH2M3ZRKWqmDvKk8tRR0uGQtfQRT194wy4z+zgJ1kH01PhWfhsM/gqyTFBjTQcCTPVj+RjdBXZxhdonK5fFS6OUtzzr/wZd23ykUq/YCBxmZe4C+VIEYORQCuFbc+K9+/X1bNnAAqaNKreAUxuvla7gUTEelwRrDnoRDunh6ZTF5JywW2aYJIIg22riG/hBk8qp7W/rqvHMF5ABjJp3XLx16oB7ZdstIiVF7LoJ08CNfzi6Eu0o+KtI0r542glSVPg2QFfJuu8btFBzjUW3HSgM6ftLqJP4s/CW/ehX6iMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLW0rjS0msSp5vUdllXYkdkhmO9FyNWos6T1VzkkTWU=;
 b=JlubJQmQJG7qrdvZM/K8NOlhrhtzCZzxSOTmrN4rwNhaoP7FmjfxF7KzJvSdiEQdgoRW7c9yx34Pxzn78jhgEqppVBiB45Ox0/5/hcNYCu8JRsmkjAGCaME9zSiQVkJiJfNwU+1O+phSgVGNgb+g5kgrmcKLrTFGlXEBnS10jyyjKia9+2Zgtrr7S4M6mxAuOLVcEfoL5g/pZ6sTPL32W7hxPBgH9eQT+pgvosnirD1FZQprjizOAryUBO4eG5rwoIqHWKC1ZNyMCDmAsmY3dwp8YiR+lbawn3rwlrh1209F4U3pTpp4KG86dMipja2o0dozLPCtSeDR4ngot+V/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLW0rjS0msSp5vUdllXYkdkhmO9FyNWos6T1VzkkTWU=;
 b=mAUi9NKQdSvOZvfb6yJA395xerP4CDUNXqcTfvfI0qBQyOVPn2N6mk+rgYlwKgh78cKSQX0XKRrIzrrSghfPUSeD00uzrIDANjj1FJRkfDg/ISs9bIEvTQK+A/CZSBu74vXhTPIIw1T1xkrV2XAVF6456fbnqNl8EMlexh1hJ7Lia+Logpixz8tQkmcGHtXz/egZLF//5hDiecv1RtFhki8unB3aipvzOqJ2DSRZV84k7LQxbQrZvsCawPjgyj5KMX47HQwrIGpbTisSrPpDB8AtJwuGdT7b9zrVYHFcr4wNIC0LoOjdbVGJwu+19P8xls6cx2/TG2ppYN15onAC5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Sat, 23 Aug
 2025 16:01:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 08/13] spi: airoha: support of dualio/quadio flash reading commands
Date: Sat, 23 Aug 2025 19:01:11 +0300
Message-ID: <20250823160116.3762730-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: f61805cf-6c3d-4ade-b193-08dde25e5439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfAyP1gMungxEGCU0QDGNOUQYoj/TEP1Jbeq0chVVjz0wPgKiSGuYh5X5K6c?=
 =?us-ascii?Q?8zpoQqplsNOL88C6MrdXx3gCfIU3kAz1MbZXF6/YW48xXpodbTp5G+KohMUM?=
 =?us-ascii?Q?/GXPW4alF3fwCLGcbE2q2bkI1vNpFnYZ+xndbrl28nvhbPqEDOkjaL9I2KPZ?=
 =?us-ascii?Q?mXPVG8HeoBgAl28WrwGqXYdaYP20z4W9QU7FyH8sfZFp9BTFPHdw7SP88tu2?=
 =?us-ascii?Q?Et1PH5mJHKcT7fCRZc+5ym2WGopUMpGc4NXy+Zj7dLEtDpvFTQCIkuMx7+cM?=
 =?us-ascii?Q?iejfGaZaY6nAMMKf6Gk1A17x0LQ6Sq32WzRV4wZkqbWhQS9cPLJXU5gJ1X8t?=
 =?us-ascii?Q?HIrpNlcH+AbgsnN039poGQSbJ+OC7/GaATVenvcA3QP/q0JVAAS/VTTymxDg?=
 =?us-ascii?Q?MNaR+kZ5ZtgVwyaXgiDJt0uCQBfW70Ziz5RRlTsAw0HhTq6m9zFqgEEDcTJO?=
 =?us-ascii?Q?9ET6EhLUaLEXliT3+H1Z+PIy5r+Cm9J7cSPgUYbZTnO7KnuflFyIIxwoOLKX?=
 =?us-ascii?Q?e5O5jwuF0RZPQNvaKTvcrjmhEu+ldj8Lun7ldlgB0oAss35+6sFcko5eyD1Q?=
 =?us-ascii?Q?JiBc6BUGR1Mrltiac4VcybF4+qObFy12YraPVupHuu6/PSno4kscfzoQP4G3?=
 =?us-ascii?Q?MImv4EVwTqx+ZmozQE4VwrnL+7PcDytjTDZAIi5BOGWeGv+tcvfOYsNaIKHE?=
 =?us-ascii?Q?BuuWzmvQZn7OKBtv3xSEZIJi9WWLvg4mdy9z1ZbIPzj/0pUEV/0ctAP8fxUs?=
 =?us-ascii?Q?sucF0HgTG1hM5Ld/r/FLtmEKJ2mhLHd8dksoIC3uYBtkBvzhoRiNXxMVBZaH?=
 =?us-ascii?Q?waMfoOYr8sqQ7sxmbeQ928xLqqNe7sGG6wdApa9L3A69x8pI6OczUztQSitB?=
 =?us-ascii?Q?4WoBXqb5z2/nDaZ/hrv2c2sVQ58PboPfR9yNG2KGrrl7n6gGgBiJJXIIivWP?=
 =?us-ascii?Q?cq2bzlYfdFp4DJtOm1u9ezKS97GKVfIy+hlgRh9xrMr/uqYMQDI5TCaN9wSO?=
 =?us-ascii?Q?CPtvEhNxWIB99E3oyK8fCMOAdDVILBDvevy7tDn4rNHIwgygBS6P3uT8MtXB?=
 =?us-ascii?Q?EXf8AYfGuSS6Z1SYUgzn71DFfCm0zWsJkBBy9LIpVIzzKWNGPvMmTEzGKvPA?=
 =?us-ascii?Q?/pPDcaLmijTAhzkG0z24hXH0QeiIMcEk/EF06alkkeTbCeV/eQlOFFkFUzA5?=
 =?us-ascii?Q?0bwqF6gjbVsyACbYgEV5V7G9JCJsVu0h/hMxl6ixpEypa9D1hrD+HTXMCECM?=
 =?us-ascii?Q?d7PcXKpCg6ci7Moauf8HnPHCDdlxP8kdH+4LEnJt9HtsNTiQbmDV3Pq54hcv?=
 =?us-ascii?Q?7YHLsNfHiIHwOWXEU/FYmCv+4u3qAe3iaEOrbeCZNyYSKMUsfEIS4MK2MqxV?=
 =?us-ascii?Q?HDYQDVC8Nr+ehr3t/y8afjq/grSZol1XOIlx4nttK0BCaycs3lqziITJL7ik?=
 =?us-ascii?Q?2/0ok6494m2d6HLrpvNWyeZbYFciGeHx6gsOarRujPe2b/DaWambFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6qdTtsazVGCcERxTgmj4F4g0b4/VUbqRx6GHWlKbI4SyyzCdqFnexSVbphRS?=
 =?us-ascii?Q?04//oqwvlUOtBD+Jq0GD5o+UORlXe9oIP9JWjsre1q2wj3ypybf3qpN01gIc?=
 =?us-ascii?Q?6OJ3sbrnEx0Hm5arckRFNv749kPQmllif8IdKRayGg8eShx2U0QRk5eXEZ5J?=
 =?us-ascii?Q?kobwaTJRJyJZGUh4FZESWd1fjIAy5TIT4RRf/QuemUb21H/fXnxJhzPp4Z6p?=
 =?us-ascii?Q?w2BUoJDc5d568haYnpnrYa+NO4O44Qov4FGg++yWXNb6ct1VZpQp7T/kvTQy?=
 =?us-ascii?Q?jOqzDGkApYbUVe5vf0Gnt14WWIuiWKCkTJORzjKM9Hi2/dtcWlcfKaiuafTY?=
 =?us-ascii?Q?RXz1Zz2shiP/d6s/i8keFTq8torEpsyzxEqhA30a/7QWt8qwCAHsBasw2cPy?=
 =?us-ascii?Q?v+dc3tOMb9YFSx7luILyoDaZtsHOuAMg+nuf4LZxGXHXsoutaWBa79ri+lsI?=
 =?us-ascii?Q?2LATxYB2QL4OEJdXalRLHgS69cCT0PuFpKgIZ9yUBY5aUz8ShPGLp/weggrI?=
 =?us-ascii?Q?4oS4MpTL4n13fBp0zwbk2H9XW0PH+6PTkfV9AjUiO66g1xTAQMZqQyqfy7hL?=
 =?us-ascii?Q?rwTKoB1N4vFoDNNmYUFXqbo7Ahbl2lcDtjnLDCVCiIVEeOZJdOEPcyqVn3IV?=
 =?us-ascii?Q?divEOpe8Ieu6A9XLHkD03QUdY41SNo2DRCYicMr2gH716+qX83yAjqKpwlme?=
 =?us-ascii?Q?RF+jJXh0DQeQNp4RdfwzNS2Y1g9BSVcoWtWLah3ivN2TiiKrzKdzTHFONe6G?=
 =?us-ascii?Q?7+Yv7wrJkjaGVDa8bMThIh3gh9Fs084db36M1iX6iQdAE7T0kA/IvTEuoDo5?=
 =?us-ascii?Q?ULez/4+bUwuMBufsHBlytOHbAMOIzCNbpq007jKxd/rxWBZV03qWB62L5n8l?=
 =?us-ascii?Q?oi/iMGqcTP2JGF2HClBA3ojS5zeBxIrdrrISWyepuTH7fD6Ny6zqNmLBNNb9?=
 =?us-ascii?Q?RGConqEZZeD27+49mqJtHG0j4ELwOjMLD4HDwlRzShstBk7z7wNMyTpCjcOR?=
 =?us-ascii?Q?FD+dtDojc2RP6fqs3KEzCHPf5tWWwSVPOWyZuZ0jYrrY7suglV1bGba0hZ/i?=
 =?us-ascii?Q?9SMBs9ghtsQ5Mx0E/+sSC5sG/4rZwanYVLYzPLvK5p50kx4Nscgt3BtE91RI?=
 =?us-ascii?Q?qE02UhEe1DnJ0FfYsMz9a12l5egd/jI4Oz1kw5nCyz2Zgf5dKvO1tlrgZmUR?=
 =?us-ascii?Q?o2PnNh0Ef7pydhrrhR78AxL9CP8jYhabMudUviaWvrYa5ZmS2E663hqaOFQc?=
 =?us-ascii?Q?K8GwIlXjcAXM6J74QY67CPxMY76qKE4B7gy5Dj/h3zSJgjDC0HPbBj67T7Hd?=
 =?us-ascii?Q?2dvPRzF9qGnBATwdjVRzzEiYuk5/YfO05lq10+28KjAXyM16blwXJFMPfJxB?=
 =?us-ascii?Q?pL9IlA8fT3dFlzZidw7V7ls46D459k1VZ5y0AgDlAbvWzoeb/cgZyH/VD93B?=
 =?us-ascii?Q?RaKEMtDQuH1Z+GWXm30DOqAaGgnb02lKbOJd6njvEbKUhzQEaBRSL2M1yeb1?=
 =?us-ascii?Q?+w85EGqGwelIBC9InT+l5NMVyxFpiWZJU5i/DCk/frq/IwlLVj9+MIQO1IBO?=
 =?us-ascii?Q?VfIN/iqxgtaoIsbikkFu4HNkbWQRQtsEuTA58OgK4pN6zSQxdaLx9dFjkO2N?=
 =?us-ascii?Q?58t9l3CSvAkVF7LydECz4n4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f61805cf-6c3d-4ade-b193-08dde25e5439
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:32.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKBfrXK6NtMgtS4Erdm4T7EEAAa4rQnqxkcTxuxpmvmdxTmPG4KNaBKdgWDPTA3V3aahFN0TkYGEQsEtKb4dDCYUN481zl7lkqi4gfGYPc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519

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
2.50.1



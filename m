Return-Path: <linux-spi+bounces-10368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979CFBAB01B
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40671924203
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437F24DD11;
	Tue, 30 Sep 2025 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="3hqFtXi7"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021100.outbound.protection.outlook.com [52.101.65.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6124677D;
	Tue, 30 Sep 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199248; cv=fail; b=EJpvVWC5yR1a0D2JZE6urUU/7PARTsmnZfmi6PDDH1iYupsQt+58IlJaP6Yq0DPswg68eYFoQ83m/YiY/ghrr8U1hHj2yMyFE8f9aDuRb0P/LhbDyzUDvlwpj423NfxmFwCtYKC5Ap5lYJWw830GVNXHVmVJlDeS7TUkW/XMLvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199248; c=relaxed/simple;
	bh=aEkMJuockb9sl1ayZ14mDGdzCAIk1Cj3U6CPoNGrEic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxXEK6bABAi4kuN2FsY2nAzRaNKQxKmCNL7gfeElwlv27rAxfHt8zRiWdUjAb9HTVkFo3gVjV0SmsXMWY/jinF1aAZ9NfHwMakDNjC6LrVCKm/qqlxOs1zSUZEQZrsQ06uPEDc1+lUIl7IiW4xbH9jI6biAx658AbVA5uKpaYcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=3hqFtXi7; arc=fail smtp.client-ip=52.101.65.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zC1YtKafKMJOyd1JbguChcFI4cZt8SmRjpjTVHcPGqfHuiHRKEfSUCEqyvnZxSNLIUnwgP1/VqplSGTE5hrTgEPoejGbUYCBsg0S4oEEYf8xI6GCGkcKulqlXNqHz+k4iPRzzeL8jX/oQ3X9S6HS5K515K3opn24n8r/GE4L4bK8EJVA+7AzKmOOX4ezEjP5AnW35PM8xD6q08LGFcv967u46fvWP4AoGMK9mZb/79PoddlclwPGsAElvez9feSRMqAvaLPrrUIonEsm0o3ZU3EzCB0zsbKmyuCXWD2ssvO2ADUmo/Qas/ANcMiJ9afITAG1tIKFToBZpNAZPLf4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjf50/FibphiMtIUv6AZlH8E5lbJzuZyKIxZtjBkHlY=;
 b=Ns+XjMaH81izONZDq/7lUZ5VtzLk7nZWJenojjf7+oDGIWuHBi3dmvbzvlq2u1/tBiPDSqyXd5HQOO2O4N43AfgprHPBICEHZp7I6qUgd3xZ+egftVdc9RosVn4swxVSl/Adg/ZJMXRhBrVU2znftH+WaajqckcRfLIm6x26rT6kurs8Q0P3jnGJ1rPcapVzLDv7sTGTy+l/CFZ5nUz3IxMhjF+caliAsQ+RxhXWvTYeMpM6idvAR6iuyNZuQYTynaNf2KMbTlGqqDIJqWlskck5H3sEHzrCOquZeF0loak3QggSg4ARAXC+WGQcRQPpmj3OR+u7aKKhnD404xOTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjf50/FibphiMtIUv6AZlH8E5lbJzuZyKIxZtjBkHlY=;
 b=3hqFtXi7eFd2kcnbokN5STJm59OeYdTvoFX0Knjei8lHHTW/jOA5HhA53HhB5Pi+RTNxvBGIvDsJw0umX7o3Dtt3P5R1a4hbp7KuNO+K9aPH+S8WXcYyqXtnK/XW2ZNThCBmVpeSnosPX1boJ+u0INubm8ZoogJa1IcCAcV0RJ0EpfWvPb4pAYM/L77sMIcZYp6i8SwbCkkYp/+Q2cwe4kduo46ElGMR3VOoI75SP/w+4S16hgZDnVL+JBBblmGJliGL7PSt9wAx0VwyAlH/kSswoG52GwNTxMfnsRfoJN3ZpGdLA5gkq2qN7+Me8iZYLHlR11+JnqnoSQ/8WXCAlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:16 +0000
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
Date: Tue, 30 Sep 2025 05:26:55 +0300
Message-ID: <20250930022658.1485767-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 75b1e3f2-0732-486a-e4fb-08ddffc8df54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBIfAjgus67p+H3cSoYhOYT/DBPDRT0tZNKYBYlJIFK8uBg9dgUK30ZuSYTg?=
 =?us-ascii?Q?oCD3yC32gd6yazyifpzUIBFHU+rK9OxymhVz/4p+kL1tXmDjQLJOKNGJFYMg?=
 =?us-ascii?Q?GwEXJwqTjn1A71LHCp/zebtfiq4dtHFAXwRkm8uPHnGyTVeVGV4vfz71K8kv?=
 =?us-ascii?Q?VhsTGbzstrUdlqSxzTD2CR8U3JK2LyjSp/W8kTXgGad2fgkcF9slg4yj1FAm?=
 =?us-ascii?Q?6rOTo4ALISLPkAuhfE1IUboxHKglYdmt7tQg3lG+Pf0rOy++CHbetmmdZhYv?=
 =?us-ascii?Q?lVYBsEk00RCP8c0vFCO40+C8A46K3vZCsH22kPxW4azZRSZLynRACLOrg0FT?=
 =?us-ascii?Q?cRJZrw9+U3rMbuZW3aKkAy9/wRq1dV/9MMljs1deG9T8MOF6377JMZYj5re8?=
 =?us-ascii?Q?vKcEj53aZs8RgEyhev6f5jHHDsoqxH+chRcl78SkPLEtJIC3mA0u6tY82xk5?=
 =?us-ascii?Q?9255RMgMVSp4BgYW0vIYTqh5iA2GZy91xCokD0AKpCcXGLMxS3RDqJzcC3Dr?=
 =?us-ascii?Q?UnrC+xyhF1fNqp1SyFgzuqQKC00RvS998gK7FprvyLWB8U/N2dENpZji1jp8?=
 =?us-ascii?Q?6JdA08ITHFlrksidnugm8V2RondGolu+86ApFIVRS8w6yjpFllvg4uRE6dGF?=
 =?us-ascii?Q?N24E9rBgJVlbmxqMZnVjqvpHATnRrR0GbTqeH/OEdCRhUEd3cvMGKSK/Kp/c?=
 =?us-ascii?Q?ynAZ/eeL3wMo927TbsWFhgflNO4ExDkxnVQVzzbetGBRCkKxA6YdZoKF7K60?=
 =?us-ascii?Q?Prz74dFk/zyOUPYDvyEmn+7QAQQz4pO5VvJbbt2BwQhg4XbDvSmVVLWOyypR?=
 =?us-ascii?Q?ar+R8+wBZVhiQWyZi72VhU9miTM/ixDldhDgAngF9+/s6Am7AR2QpaG8jDMK?=
 =?us-ascii?Q?oGnXhuEHR6CL/HO2gDURaqIlwrvuHXZ0lLjI34en45C+MhNUmZuDQSc2wBIV?=
 =?us-ascii?Q?PwEc3FNPwhDWnoeZ1Z65JSZiFM0Pf2fyJ10SjmqbQuIwBGC10+MxBah+StZP?=
 =?us-ascii?Q?E8MP+dJKDjW+AgaIuAH6kUF7hNwajZ+SwHSRCLXcJgxjpU5cbRvQC/jIlGmC?=
 =?us-ascii?Q?0TA/KeAm6P9ZOVywNnVP3vszj47uzrjFr+WkjLm/L3VuJCcC3Mjg/UjLB7qo?=
 =?us-ascii?Q?MZNMo+f+d9O/ya1r5n1qRkoKg6II2DRjaFCMc3hArcIbjXLGfuYIlnO0JPP/?=
 =?us-ascii?Q?PQQ3x6w36yFnarmkUNhI1gUzpxD4stnjznSPp8/J0rIXt2YI/EihHPv8Jg6L?=
 =?us-ascii?Q?xuFfbsKaW6GGeNiv7jPNa5BC4z58YV3DA+AXlJvJvsF9Q3TwqGH40vyko8G+?=
 =?us-ascii?Q?0I3HXIwDTJ0a6bd0SbFVNAKCOL4wcNigsazef76SIv581kaz5xzS5rYLrMsx?=
 =?us-ascii?Q?Z4X21wboX9LzqtcSMEHF89onyndh0vQAbT5x++UshLrrQMytjmT7xBYptCMX?=
 =?us-ascii?Q?/ySyralSgbPEkhGY2HBrtgrmbbWKI/3p9Qg5LB7Bj81esRme59hXrtnw7SCq?=
 =?us-ascii?Q?VuH5Y6L3yoNJTdaYOpsbFeGDzQfcl6Ev9rLl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ra/4KPRCQCbBN2SSH9C7UNZms8mriTyZf36D5bFP4YZhOAZ+4yD7a9JQ01E2?=
 =?us-ascii?Q?JGpCSO1NsgQD7hfTRU3hID6qbEz5QhcSe4Sj1m4fC7X1YR7V5cR3qic8n+be?=
 =?us-ascii?Q?gPQHKxWhrD/V4dS96Nx4ZCZaLX7IbAH38D+40f8OofG2eMEtlmxUeeFymfpv?=
 =?us-ascii?Q?MWEsqcSiLXo2e8MA3ywRIqCTUR7SBsHMtc1Ocl7jS1p0sXAL+vJ5A2jpKbyg?=
 =?us-ascii?Q?CgMn0DjqqmrEAmIn/fGDBteYeiZm/MkgNtvoiVYBr11iNbTPK3FmyOUVWWHO?=
 =?us-ascii?Q?EVrRrd4prrvkIwzs2ZWEm2kjat7D4mBQM2f8LgBUKxKLtOTAyn2M1vvZNnC1?=
 =?us-ascii?Q?zSVp9wHd220WT//KH/qcDQEfuYqoGHpNc82QnHwGvA0ACBU1ymC+3gWgAmlb?=
 =?us-ascii?Q?ux5uz8WFLkSjIalOljgjDKsJSKWFa3v6qaa9itHeVuDayhIGWpsiv631b01C?=
 =?us-ascii?Q?t8xsaKFqRDBE4dMUQptpnvhWW6QDNM6NGlouI2FHlFJlsrYvsy+oCHg6R38o?=
 =?us-ascii?Q?PMPf+3aEhlxY2K3imuOLkjWQemheyCwF9bntyHB6/9TlMDI2zBZ+CLeF3yRB?=
 =?us-ascii?Q?Hm6k6FoK0Z27YyEU304tnGdtPgMrD/XgHI/DW9ytLTb2nzWQGYf1dDHcUg0k?=
 =?us-ascii?Q?YY6wS0Yu+8YdYG5K57kYYg16FJeVNk7HZUYrze4Ef+Au8qNOqtMuNEmj6HMh?=
 =?us-ascii?Q?dvyPXhhTWtbvZAwgzQxXeClJcEVODjCfyzvi+iN14mI+/P2dL6Aiyu7ifOTy?=
 =?us-ascii?Q?XkEknDbZtvDBZGkQVXhqH3M/K+SbyXlSH886AirE7xMuS9uoCquYVOjk0lpB?=
 =?us-ascii?Q?GeAEZujNMEjS+Hk5/Mv6vEqmSH+bAHYKJq+N8zVOCQEq+0mV5SDF416Kag4s?=
 =?us-ascii?Q?f7nP6nVRV1Qfc7na9GEV2atef3zB+51oSlq3iVxzrFfmTdy/BzfXOXxB2ZYd?=
 =?us-ascii?Q?+lSwgX2L0szkUOqWnpcMMBJtZQQO+KXj3wuaVR0jCqJ7drRSwHQ2fIjL3QPv?=
 =?us-ascii?Q?AAtabnNHu8ZzgPlJMIovbIabtWMw5lQhgqRZ8jQtIy0/yEei88yKPMnsPJ+w?=
 =?us-ascii?Q?4+Sa+kkbQVH48vWl/58tvxitYuS/PFXLPxnTNm4wQcrreGWze+OtsEIR0BA/?=
 =?us-ascii?Q?Snfm6/QCw1hTbTYKoI68N3TmuhUtAwegqT+BMRLEw8ajqeGX9UjFEHoKi/6L?=
 =?us-ascii?Q?RzFia3aFbrO67uE24g2D40wbmnqlCRXbhnOVBu2Q09hcXbDjW6eU7Un6X0wO?=
 =?us-ascii?Q?1ymzstxxypfW9ZWQIUdVEbFJjrtxm1ZlHwUMd7amW3oNegaaQa8DiPtCDOVg?=
 =?us-ascii?Q?iUB+Mbq3b15drwl5+hnny0hLJ0bKD0J5A6yk86OBVauXDYKoH+t28MhB3ty2?=
 =?us-ascii?Q?yaqKWiqZ19nVqczIeI4f9eatRxfOqiruaKnUUvhL3mZtWYIVB1RbTt4Y7+UW?=
 =?us-ascii?Q?Vfi7jR3QI44NunyKWpdWGboOsI0ZezR9UQTBY+alzhlk45DT33nIWBi1Z42B?=
 =?us-ascii?Q?Z6BiX/fhcwCq01xqxBudOHMGy8G4DqTrw3FqggCn0JtCIYoyHG7u9CLPDELN?=
 =?us-ascii?Q?p58nw4pS4eOIccC2PYSaX9NY7jRYTvbI0+ZyGcSFC5mMh8FqLX/FMHJYCDDl?=
 =?us-ascii?Q?YAGQQTay6UmsfNccaubTJVw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b1e3f2-0732-486a-e4fb-08ddffc8df54
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:16.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC3bcFaTpxSz0+J0ayLhP/6JigLS1h+yVx5FLTRG2N0KdpE4y2BN987ICQ34zIWSLczsI9RVQh6+qYar9DERLAHOjxF3LTFSQKDJBgbGeV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

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



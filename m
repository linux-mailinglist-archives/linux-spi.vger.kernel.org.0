Return-Path: <linux-spi+bounces-9905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070B6B43EA6
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABA93B653B
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F66F30DD29;
	Thu,  4 Sep 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="e/GTILU5"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021101.outbound.protection.outlook.com [52.101.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DA30AD14;
	Thu,  4 Sep 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995847; cv=fail; b=uUAE8BLT/u0ALvq3SriFsFAoCnF11Jg06vCEdJGeydOF+TV4pbzywMaM2eHMaxpN2gyTFvRG4A7lmU9C88hKQCuWnnOuDmkqJCnsAj3IWZIRgQP65OnyAMjBgEZr7kRzQmQ24LLK3D/bW3IaY8Zf6q4zT07Y4rmu0QoXUNjaGT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995847; c=relaxed/simple;
	bh=5SgQH/uaqvidW6paM8TanGKMAKKB9rHBM9a4ZGfQnmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMv+OwBt84CA4PZfUY8OkomWgG1RQCM773eDSYCXVVV8H9RxaHzRmveblB3qXXaDn+1Lti5+YZDdfJ9KxO4Rnxw2kdGYFge5A55P4k5d+ILfzPtXOy82ybFXUJqM/e72EOhs5qbNgHsZtNrdmt7G0sfi7oWearfdWHSbSTD3Xp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=e/GTILU5; arc=fail smtp.client-ip=52.101.70.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rET28ck30V21x1Mw6765casiE6NbjLMUoNXXSgLrpq3LVGzqhoxnzjpG9fPO4bsoWIpjRWYJsA9pYBKP0EBy3osokZcRG8GaPQRmIa6TuYrqyAbkpirXSaOiQb757UKt5j+883QedCfSI+8KZz1+/eGpeEJeyNjLFB/+IRqnVXGXdNHcpHa3wbgWYyMJTltGQe5euaIpOeHVOrFCY7e8KfgIZ57hCzwskhATvfALQxTq1eIouUSw0T7V2sjqxtLlD2aGT6sVU4/q1e4d90OVySFtisP5mtMB6Rdxu7OPBpMvgZpMu0l25fpuTTuIMvaQ37qFpQRZOut4nbpCLWAFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkVNZj0jFdDtAG5gJFFaIeYXJQOUMqCt3cPslB11dp8=;
 b=pLxvuJWrUHvTyYxBKrrfMBtd4LU/9DICiBAL7wAeZoBZ1aHoiT5ai9Rs1Va9SrKUlsdVaJ9AX3g/tH6Ldk/zL6b2Zw7IiGNL7lwQhldmVDwIjAtvWFITRnGqwWLdwYDZduFSZHHEaDoT0zkVyUdYporpGc2gJDGGC8mhHCKvtk/qWOssnoeE0QrHr5jhlwRifj7+Vwg2MASPVOyARfQN1IVGlCdYoM1ZQ4fO0sF9Hdw+ut/n6F9VpjLBaYjVt2hlufbVfhlsrE6eOt2NW7iykizqfewmnGd9xP3S0qu0nXUAdUShP3hKzw5WBPfT1D7M4ofDrwW9vOE5e6788aWQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkVNZj0jFdDtAG5gJFFaIeYXJQOUMqCt3cPslB11dp8=;
 b=e/GTILU5aQLUPYpDGm3nFBFqOT6kIaEwo3gexJcplcUw8aqmwRue3sf6t6wzf5oggWLQAL2zq0aO2471QL+vZdYxkobq9TaxBzvOYhihFspR0eBALKefkO1O64hrD9yHobaGQOxZ6gPMp7Of/VCOTi37xHOM2ES7ntXuanrc+PakwLy2SJTWJEpb9RX5pJq68L1sVdultDdldC2wiTSCsib264R8cyl18W8Dz7tnJooJ0G2RNLj44rLrbS0gIRsmL9qHsZG9tLPcbjRCTKlAkILJk49eN9SqKSgaI4/w7dCjFLt/zfffeWxurPCRpwl9yxMdIbHHbT0CKX/ADwoRcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6436.eurprd08.prod.outlook.com (2603:10a6:20b:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 4 Sep
 2025 14:24:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:24:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Thu,  4 Sep 2025 17:23:36 +0300
Message-ID: <20250904142339.656346-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: e1839281-d842-4429-a006-08ddebbeb0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m+cTZ9lFjCQSfzq8Pmqsi0rLlNivTXvoeKNsAjzBJ3NCL2FiF5gJvcDLzGtw?=
 =?us-ascii?Q?FDB9jZDDlDStB4KES3wh1BwJLFPZLky3SRdW2cD46fXwFwzbeI5yLuhe9tca?=
 =?us-ascii?Q?ETEFQbiRaUO0NTN5xCb5ywJZhl9RSwgyHDpVXdE7IsLX+xWIqchNSX9TDSiA?=
 =?us-ascii?Q?tmmFCT0FbRUYbvhSDHxhbcHLMlGoEcTFQihGKASqVscBU2g6rAMTrn6iJWH2?=
 =?us-ascii?Q?0944IZIFyW12i82Rm3VjUXnzEewMcViJwItyKB/ihKJgleaUUvru01ynCXQ1?=
 =?us-ascii?Q?q2Qv32/hYKaguCJ9dz6YpEENIJPSDSIfukPJE7RUVzNgFCALP0uqY/YHSjI+?=
 =?us-ascii?Q?tUaVutjzV1n+B68w+9xzaP4QFsRM/cVsnDo5FdQefj8TcX9+QoX0BoPmwNt1?=
 =?us-ascii?Q?uWM/f2rD7Be5T0Cm6x9n/6aehEvxTFv0i5q4antt5WTE/1BaI/7VLTnxazCK?=
 =?us-ascii?Q?6mcIe2a/e5anjA/hBh0ov4W2W3cb4P/WY64Jhf3bY87V/xb2umtpvaTY0eA0?=
 =?us-ascii?Q?2dj6sT/JwAkZ0/ptX8crtq4eP6F4YLxxUaZJvlkTd5KEMMJyDAXaG3K1+iEZ?=
 =?us-ascii?Q?b8NN0BMv9w2JcA19ZrDn/ugiSoC+C0zGOEs1bnSUEiANZF+H+/aFM4cFhCse?=
 =?us-ascii?Q?pd1mKLdT102CjM1EDrCZJchlUP5GS61G0CqtAzaW7CwZhWh6VevjJ1iNIL7G?=
 =?us-ascii?Q?aXMcbsJyIIVW++FOTN9+6JnCzTLXb5rN0XtY7la777caGxnnLsmu4pJGF4SU?=
 =?us-ascii?Q?GGBWYyfezU7VhBhH48+uF2rcb+BVy3L1yV9xkLqDVhYNORSbvGs1KzKe1fII?=
 =?us-ascii?Q?TPmHFGIpmIE3Gw8vB6xPrO7yDkX0KKbp251yw1+70NN4LttGrFmd3BCLrbaT?=
 =?us-ascii?Q?luMhEZJhLJeJfHrW+jiB6JS4v3k9czaX9kXDJ9NB+WsRVTRsm0cdlJfGH7B9?=
 =?us-ascii?Q?CMv9eaxkanO+pFEkbNTRrI7Y8b0/fCdfDE4/WaSKKrz8OxcfWlODgR0EWYJM?=
 =?us-ascii?Q?/I4K1lt0+zKCQcQ9QfvpNi59P5iEbQ1qsVAGJJnCrPkzZtWUemRDHOfmU57+?=
 =?us-ascii?Q?KWoFvNcguTDfWexi0q3W6Nr4prPAgp0P4BjzNDndqf0S+RslRkaljEJhzQh8?=
 =?us-ascii?Q?9MaFhfEpPhQRMYOrjTCfPCvl2EvXXuEUENNci+WWKVNOEdDBDGsTQALlwBYw?=
 =?us-ascii?Q?eYl8ohWtn50sFnDPtZXLgyR5lbJay+FHxCUdC9P0gUo0kFsJkR4tOxyIaO2b?=
 =?us-ascii?Q?Z28HD3xruiZBbtaw1vn6T6rMExT9YhV80hAy6ExQmR2toyoyEv2HyxnUxHrk?=
 =?us-ascii?Q?Q19xg9y2a1jUje29kZ79Q6GN97fVrdNO32KmZ7HHg46R6EsQgZF/nr0ZY9Qx?=
 =?us-ascii?Q?jzGelS91Jbxf6J72pGJRLcWuzt2FanbbE/bv1vUeTnrtXdFQpSNCOSxW3YWd?=
 =?us-ascii?Q?APy0O0q3aAP62aCc+0+tozs/HEkw178hWfe++OIhDxZVCYwaqL85xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C3vigwqFnecwZ4Eszev8XnjsU58+gC75fD/QCPOi8VEWdjAX/4JiIUo4GN8L?=
 =?us-ascii?Q?aBPSWVYaQvBY4Uqv7ygdij50BaqDZYFLCXEjKRUmFw/2yeMxUHMwIR3l2VtY?=
 =?us-ascii?Q?+1arGjh3ADWSN+ypghiY/0eJSMLoN3vffmcg0FZoJ6fn3Tw2TzBcf1Cj/tzY?=
 =?us-ascii?Q?1ghtcWGl7U5Vs0UzCET1gxrHD8xwWjzvhU+mwGVoIuBzoT4mhV6CCtUB6e+6?=
 =?us-ascii?Q?BvpVQTPP9St+0S/2OA1LsPXmoa39tDFtjCf/rrW1AUfOTcLO1qSFWR+mJPX9?=
 =?us-ascii?Q?P0baaGbbGjmHkf+tU7AWVxBzy42z/fWaK6NaYWsDwsqu8RVvalkpFW/+xSHR?=
 =?us-ascii?Q?gU/vzzCai3vkpUzTpzYsgiSe7vfpxTImQO/ofEMTdF4/gTyv9N7B7sLm4KLE?=
 =?us-ascii?Q?ZQeQhrz3E8RlBV6C3HFgkkmyptSLNogVM2rCuwANpHtxq5kI0agF9wVji02R?=
 =?us-ascii?Q?G0rXljQefZ2YhSQBtbF2TZ+LqIitKNvTFYnzzBgm2RPgqfrQOhgqTMyODo+D?=
 =?us-ascii?Q?n4/prx2G5si0Fuk8KR5XOzv6piThwynouz/BDh5doXrelgsK/I5Rw2ye3M0o?=
 =?us-ascii?Q?733ds/0Mm4z6TfjZk+BjFI8bVCbE3+cvzeNtiybL4V27MC5K2ZyLPm/WSDx/?=
 =?us-ascii?Q?nOigDID3wF6J60NtDHdCwMEYtkl+qabT9MGx7rba+QJo6eug5RUhEjWIh+cC?=
 =?us-ascii?Q?26mR3BD6DR+sshDAdkjJW7D92UsEpD/J9befdc1sonEDyqhvUzqRVF+gGmDF?=
 =?us-ascii?Q?rfVYkhslYlDpj6CFjUmP7kGY42xYxEsiTfFJvP3rB/uDEamqFoXoQNGwMyWR?=
 =?us-ascii?Q?Pz/ODPr9ZBpNtGNAi4AjAbVWC+GpjAtzzTnlOGfs7T7oFrqND4/pOWUn0hsn?=
 =?us-ascii?Q?7+2FXcVgCosCZ0gskR0ujWVXN985q+wqe/o1jfrWcZtB/O9pAf1EMBkTcuGN?=
 =?us-ascii?Q?vpL9GkQdm+UzKLPiIrKjdKHcDOCUJIFm1cjohSWqFgVSWLtaZaM90wGO5Jer?=
 =?us-ascii?Q?xQAGUWPt8NTUbgl9HgVxExPhoU/OVvVv+La6N3Puc6Cstqdhzh+v6aXpX0qM?=
 =?us-ascii?Q?11pg53VCe+fPo1CE+dq/zHs7ucMTK9GvskZcm2hq+KED2RPs1y0f6gPYKiNn?=
 =?us-ascii?Q?9so+TbC5sbonflJIY/hXFpYr8J1KA3hD+ANPcrx2nBvQMithWVluQa1r2Hw+?=
 =?us-ascii?Q?ph+YeZRlYnMwgLRbGh2qaYXyoFFBNs86bkDk2shI2trmDtlBQ5lnNcS4vs5d?=
 =?us-ascii?Q?4lP/rd4PqTgPmf2otQ4yvCh+Ep7xjDWhzqOfWkQGuRLFgqTfE9AphAJPFJH3?=
 =?us-ascii?Q?DBellh6aKEjknwqqRdtcwovFTB7wTrkNp9PCwo8f7Ih0IXLkecjWocScALm1?=
 =?us-ascii?Q?PYSeiiqSxWB3JULja6nYDuC+36rTCDNbXZKN3wvu0kcyWwjMAf0K5BRuGAPO?=
 =?us-ascii?Q?UiU6/Fd3SfISwxVfBrDY60VRVgj4UDEVhebeMBhG0xnKFaD4h5r/jtLpm23/?=
 =?us-ascii?Q?gT1644Iz6rLjLR0FkpJTDfVggNeQ+IxigVNvS2dqS8A5KVdggkiFdTw83wFR?=
 =?us-ascii?Q?ZBiYipb2HxgvgEa8zeadfFik3r9nnSTaPCu0PQIzRfX9JJ3J5rcdLHBB3vvj?=
 =?us-ascii?Q?CzbCS9xBOxlemAimtZsrCJs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1839281-d842-4429-a006-08ddebbeb0bc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:24:00.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6cz+LkHVOKCh6v0m4VVGoedKjpGdcDEYi6Mh+JNnF5BKdD07eN/oh6o2He+0WKYT3YKItRK7g4v2+v6f1uAkKmhnF4mf0whJBTHYV9vr2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6436

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
2.50.1



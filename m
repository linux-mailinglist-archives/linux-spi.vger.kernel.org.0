Return-Path: <linux-spi+bounces-10577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E2BD01D3
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E0F44E5850
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF92274B4A;
	Sun, 12 Oct 2025 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Z3IqYL2v"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15B2749E0;
	Sun, 12 Oct 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271448; cv=fail; b=JddGGnSbj5J/cZONLhLMMgkrenKLAZPbSkkABslCEMru4WmvMryUAkpCjRhTgzKi9u8OxcYHS8hwt37TQr0U6tEHabnwkZCVIjtxR1GUtzdrpTRqJK2PekdDJ4I0pOxUDZNI6sMqIFf5wIzPlQr2P+Xgt8CKf9p3qdWLy/+jb+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271448; c=relaxed/simple;
	bh=obHIhFUcGxmWKO6movIYZRxfkEvNHpdj1r8QrGoJf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NgeXknEKXQwuE6ew38hvS7rmLXl/dcy+pVQtUD1AmVTHCGLtMzHn/jtC8jxnTfnyxSk/k8hpzbsnevYutQIhP0shl0At6Rjpnip9XRmQWKB/9FlMdy2YnDyd69b1kFSsxWSckzH0sRMss6AoZ9u3l/JQsIRv7IK1keHNar/rLtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Z3IqYL2v; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFzi19etu0UzQ30FmOxQsTRnfN1jvOAAyjw1kIrpDYMoEiPDqoyNx9ndVnh6Y3FsdzaOUlGXx5WmZXfVDNbief/LhEOdmL5um5s6BuTHpdEPCeNw2FYUvH3wrgWfi5/LoQfJ+B+mwdmewqRxZq2JB28Ttljg6GFPUmXi7we65kELiMd1hxjOtP9BVfzwoWH1kDSvJvmqwCaI807EI+wvcwT4y+u3owuRDTs7QgfaBoOOvfXT0OF3olxxZ48t5i+BiyqcOBvkDMz7Yk/TxPbi/+iGFtei5Z57PbLkpmaJqmYgtUepBQDrjF1HrHluyUJr6osQDvDXu2q3t9J6gYJywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=Wf8hIwGr5KL97qltW8zK/7aCPuV7yYWrI5x8WRozk8BjJwuwJx5LLEc6ybJeI/H90ewtP6+AHcD29/GpmfD3eSwxz73bgnOhZgJyblj/1yXbWO/L4OnUz00HWyT7YEWv5RnxDXQFiBoErYvb34icc6n/kJJ84jOObTXvkVV7ZPNjDG/W+NBk7wjTEDXKdJJ2+G2dOmYkNKzRLUlYfwYS2tJpGihzR37QM3FmzmuuLJiOrpLn9IL0q4tA9qpDc4cpR3DXe4IY/1ikt843E2DYSUn/tNUWLqKkRJ/fgbMqujEPT/PPUuTZQVvoLj9SPy7E6l8q9Y2KQ9/ecwbLhaKHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18eqlHdcSvn8mzWmPDAf/8pve1cI5mVsrNxED55XZZ8=;
 b=Z3IqYL2vmNEmmLmyS0a4KOOJdwtN3UtmxCFMJ7lHSSduaMmtX9tghJOCPP2xgEbBCBW8n3k9CAE/L5b5iGUpGByQ1BRAV7SdtZzUQUufjg8PV3pZHbWpVsHoxBbVMbWmsNLGM9pQkviAEWOnAhQPjnFQQjZlez7+NgufPvJP7Z9ubPEoS+mVbMipkbUKIu/D5XXGD6gAQ937mWUuRbmGH/9DZZDMO1yFBWK2LtVuLDfuCpEMrd4LutJQER7kTDIcH26XW6hguejjRIr9HCUWFHOiO3L1+t0m0mFjHcbAAYNUnG95HhLESsHwl4Ks1JgFMmypO+gST/5wi2V2+mVNlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:20 +0000
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
Subject: [PATCH v10 02/16] spi: airoha: remove unnecessary restriction length
Date: Sun, 12 Oct 2025 15:16:53 +0300
Message-ID: <20251012121707.2296160-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 910fe365-c7bc-411f-8d96-08de09894ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgxY7+QIP2Zb7eZEIJLYt++fUR/4GoKxaOGqwx4qKVZ0bx3bngez9Uaw6pFt?=
 =?us-ascii?Q?+OTEHGhOlTnJgHBmqZ5hBi06UhgmaLbM8gyah+aajjG88UhfwClhYMPw9ERv?=
 =?us-ascii?Q?lc2m1yLZ7WPRp3OX4+Tqv5d1VeVr9EBXpOd+gE3c6v+BSE2+cbsSQVQcxCj8?=
 =?us-ascii?Q?LCPf/gDmtSJ+Rl9mTwsN9akoHspQ4GQr0OF6nzIKbNeB9drcW9bN5qvLq04U?=
 =?us-ascii?Q?8pfEo260TC+0kKpIH3snxL8t3FiP7AxPxK0Xi8vnhcmWBCog9lxg+LqTm79d?=
 =?us-ascii?Q?YJ9zaqzv5uJoPk3zMyucyfqkhzxF/vJGE2OJMgYnMUMWz6eV6EHVMYoFVf72?=
 =?us-ascii?Q?IEO5yWNQhs2gEhYqaJs74UtLQW4Lu5QzBBowM/4r3nC7U/HUcuP81BmY6mju?=
 =?us-ascii?Q?zxLsZJHTTJwloz3Yf/Em79PaRsLnxxsSdaUYCcwGGO1kqY9GCfGiL8nywbgv?=
 =?us-ascii?Q?0wzZ967e+fM1858kY3HToKlnsgZY22u6C1RdV62swh+htLdfPnjjlFex8Zg9?=
 =?us-ascii?Q?2ZhAosb9X5+X0/Sk2UGQcwCqh0Bd3GKWmvzzEsgqsnGxlLS57yFQoKB1d4Lp?=
 =?us-ascii?Q?DdDaBQ56H9zZCRmDtaoUGM3ZbnBLqL5fTundDo01X3VyIGs3lw2hcLQOjS2X?=
 =?us-ascii?Q?ELm360qCS4d9OalUt90lZQCP3NwnlCY2R8CH1zdHRFK/6Lskz7jST+1p+88D?=
 =?us-ascii?Q?5qHxGuJ6FgLCNcjpzcpOMcylUtMcrqFbR+Qj9LPbHyg3JqgBTJ1yGEgxIIOc?=
 =?us-ascii?Q?tmoEOLwHSxgUxDdxStVeP9JuCuO0vNCdfU8DHf+FjI1ZsKE9Z/lU6xn/r+9H?=
 =?us-ascii?Q?N3O+xE9N55p/VXT1pucVYP6gHEefxxTKC2amswPDneO+/rL4YS98rv67I/kI?=
 =?us-ascii?Q?WV6rddGbhz7VU3Z/OF3x2NoZC+aSbIxAhxjmkAMgBZytOQg6hlHXgEvHsPwV?=
 =?us-ascii?Q?f+1GtzJEoABq62U/DbtinlZyKNSozkNpT87RoN9kwQOKkTDYYeoEymrJbgJo?=
 =?us-ascii?Q?CoMPlUlc+XUwv2HGrmdX9DU4dsWL6td+MZ+wQohhx42NYoXP0adHT7MxJvkf?=
 =?us-ascii?Q?Bsh6mqFvLDWCZEWmmPg4i2MfgHRGUtGGs9XPLc+8QXKJA/vkf2b3fl8GOa7M?=
 =?us-ascii?Q?t7WVfq0NxX2af+gMT+BjkRg0SXEWXJEONJEfGR43rkK9v1dnTTzZT1/nrz9b?=
 =?us-ascii?Q?paDKgKWQRm0uM7D2CdFMGYkl6iONGK14+ib6RWlFdctxugoxcFWz1AtTrGa+?=
 =?us-ascii?Q?bXgLvwL7Xydpz9WVQ1NJ9Z5iemRCdXwFrfZ+s+PmEzfEJK6XefGmWubWdgaF?=
 =?us-ascii?Q?06HSProycTuVB41U4rPd3aef20z9brdO7t5db4rx22hHxFGNuFjXeDO4A7uE?=
 =?us-ascii?Q?e8j/dfwvZAM5JGx5eysRSsgIZNMOM3u5ChCATTPMudk3YM5kNtlob8lV4bmZ?=
 =?us-ascii?Q?CxU4e51V3fwCb8rHUgipEpRyQZOP3dY9tD499aNgxFFH7fkTQAgqXU48LqTt?=
 =?us-ascii?Q?T9+JHxLdsc5DYSS1lqQyIVaFrG+KMS4qfNFi1CDxnY27pk3cjyesXYz6xA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVp3424DcCGSuH+MnbATvY7B+K+PuVt2CTArpeiyHNRou7y7Cuh0t3WqMIi3?=
 =?us-ascii?Q?OW2cQOJErPE/AXp1tj0bpVlEp8ZetgwurGFaj9ObkvIWcjTP/oCHdy3Z2was?=
 =?us-ascii?Q?dOJ0BmB17MjMBO9KhtzIGkNjmVh8FC6bjF3v3Ohrg2sYl3gHuUNP3Pb+qiIr?=
 =?us-ascii?Q?MK3I+nhDW3b4lQu+fg4RsTtHvFrTsByVksHWWj73W0qSJZ4g3BP6sR5vGM1f?=
 =?us-ascii?Q?8w58W3hvbYmOd2pAIvGQnzOeLRGYyRaTc6qhI1vHEq41yyl0CyXpTdQo45jL?=
 =?us-ascii?Q?b0g3K/H4hkGPMiDTya8yQSktrhH4DzIKb0u80rY21syvnbxsH6coylx9tifn?=
 =?us-ascii?Q?0BtuigUX24QtJzkV+z0nwsap1FpP2Kr+LRsls53A2quikdJ5h4I6L8gUsByb?=
 =?us-ascii?Q?p00qIbZw/qXYcZ1tNyf+n/w9xAhm2tGqhupUcb99DrFaXFlS1grmhd7E64sN?=
 =?us-ascii?Q?o2SEc5XNoCnUWaz/7Wo2Bxf+pAmlQ9MGFJVQLysQFSHyNps1fT2guQ+Q4jKu?=
 =?us-ascii?Q?wPpoGBuhIk5sqkm0r5AHzzTqyvn1oc9twH7Ft/hmzqrE/cQKtUVsSeAyQgGF?=
 =?us-ascii?Q?E4McL7OZxEwxvo8XiO5miGPChRsDOKBC8S0dkx5Q9k7ykCCLSTTMp55wryXz?=
 =?us-ascii?Q?tC97yruiLEh4rNzLFDm7tn800JwOIauiEGwr5ExNEJenVpOVfxCRc411fZ4Y?=
 =?us-ascii?Q?lBEUU+1jAq5ex3EmvwK6rFyWCIBoVU/nT4CWGh3DSnXVS3w9RUR4i+uVOQdT?=
 =?us-ascii?Q?7rThZ0a/pVe6o7qfQaw88OnZ8YHBmaoiuxQtiFpI9VB1S2gycQK+Y2P0Iv5a?=
 =?us-ascii?Q?9b40FexXYmLeSTAAfRuS7Vr6mUv+lNt3rN58e5iBHOxpB1Wf4NcaQuN9Rijs?=
 =?us-ascii?Q?YngLf0I0cenfLrFqRXaZ6p6rF5TLkyA4yU6Ak8nnA+pGbT63PaTurTVDwrkL?=
 =?us-ascii?Q?2QsprYX8jEouk4S1EuhDEMuvsE3j8waouTIxKKYEA8FMmh0nqQYI8EhGtXn5?=
 =?us-ascii?Q?8oEqOpsnSXc3hDoXp2PMR3U9zDVlW3H9dncRKVUoYAZFmfphOqtMbe+i0qbC?=
 =?us-ascii?Q?va/fsEAHa2xwN6LaDlLd8iDJPg357AksIS6/GrRPMZm6lcNaGg0KNX/L32sr?=
 =?us-ascii?Q?TA1lfR1ujV9UHpRf7OjBg44lfg6qVPZUteqJ8XjjuSKcrxduJY7Tk2DexOdu?=
 =?us-ascii?Q?DR4cQ5+3e3Bqrbx/ZWWaW3rS0v6mmtOj/ILFI7Mw5aW4XsdQLPrd8LIDFMv+?=
 =?us-ascii?Q?Zd+5H3QX0MRIrFdEc7YufBxkDhcQtcxAfKA46fp/eWNbOfeSTYh1I77seIIj?=
 =?us-ascii?Q?YsiC7qw9KvdEb3ixdLN6kzSjb235rfoudoRHIJgIAgPFUXhiAM7H4GneWO6k?=
 =?us-ascii?Q?TuJ0njktNuAzxedhdcxwu+J1No8dbILUPDDQzwyVaqu2sSKaP+vIciOZiNry?=
 =?us-ascii?Q?tK/nfBrn6JcVsEHTvXcEbzN7HT52ziEZgm9uPJWhIdtC3aN6CJ1yZ+BbKVlH?=
 =?us-ascii?Q?k/wWmTOeWjQYVif0sVQlzgxgVz2QJi3oCI6S1y4GiHc4rp9sgHMqAIHwewhf?=
 =?us-ascii?Q?SCyUZnfQiv7/uj3evpPieCsCbKVBfdJtoS66/UpUxZrYM2kHVJd5cUu5saMZ?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 910fe365-c7bc-411f-8d96-08de09894ad3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:20.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odyRwSsT1Cd/k3sKS/sUFB4iM5EkJjGYZs15wKHotURZX8jK1ulBXNAzn4gpztTyjd0YMnyJ4mscDVvolm3tSuMt7k7ja8oybEQ0TjUV5Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

The "length < 160" restriction is not needed because airoha_snand_write_data()
and airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 043a03cd90a1..bcc464ec9c61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -579,13 +579,6 @@ static int airoha_snand_adjust_op_size(struct spi_mem *mem,
 
 		if (op->data.nbytes > max_len)
 			op->data.nbytes = max_len;
-	} else {
-		max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-		if (max_len >= 160)
-			return -EOPNOTSUPP;
-
-		if (op->data.nbytes > 160 - max_len)
-			op->data.nbytes = 160 - max_len;
 	}
 
 	return 0;
-- 
2.51.0



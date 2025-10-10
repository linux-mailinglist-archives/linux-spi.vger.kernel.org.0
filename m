Return-Path: <linux-spi+bounces-10560-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136ABCE874
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C202C3533F8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34E303C9E;
	Fri, 10 Oct 2025 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="OjMf+/zH"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020089.outbound.protection.outlook.com [52.101.84.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5B303A25;
	Fri, 10 Oct 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129133; cv=fail; b=XsfhixxByVSXqMEWr2vK1acfp5VxoEtcwMU7P6OggIg2a0n98h/K1wysq5i7OBlYjyzpAi+Dq0+Xm+vgUK7yfGEsWwp4kMkezg3Lt9oxpqjrGQY14+179Yza4KIpM5gNXDLOag20iSrdIhCq9xmTorNOebhpG71kBBL2N41RSlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129133; c=relaxed/simple;
	bh=cBHsnFZtmlxn0wHvSPe8hsUcctWdvufB77xOkfG7jHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUxlCZE5AuJ/JCg/jC/eCmbjtzxD/Bk8tKKxncqmWvuTXWz6h7xi7G2qrTDmBp418lwmH4fjPWxUzzPcgKeGlY+/eX0CODKjPYK/owfhfuV0GeQGci0955JULbk2qf4OXiBSP1GeffQhxR9XmYWnY0sz0HqDzUZDth9MtPMCfrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=OjMf+/zH; arc=fail smtp.client-ip=52.101.84.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+Ot+9RNouaX6rQBCNhNRU5EY1SXrD/DAd9JWOInXyyYXvNDH+ZInaw3HImAmE9u1O7gAixhFfOWlGtiyOn0eWLyGzTKDgYXvGjyR9w0/MrAMdXTQfwqx+zoFcl5VRXBkoHodRW+36VMmVbCSLcFDUylo6JfMeoALtBft9m2nhEcpkA08Ehd24CslAUG57p1w6Zla61Ri9xEvsyqutW73rY8xzw5tTUXCB5f207EzPgmpBVnJxGhetHYqf87PqkxataTzfuA6bpwfCAmOa+ler1njPh7HgvxelW+Tz/FRfFZeKwXk09TiPM+k8dKB2hO1sk1uOtcbNVztJn4dR/tNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=q8gFJn37H8zNyaLwHQqT7AbgK4xkL+gi1XfsXR/vkZClz6tDwAugXHbGedhaqr/WruZXKIUfHvPu/Dtzy5BLKrCnCB97q6j+N/jA8704i3/IC/P0zJu+TLMuoLud6NTQkLWR3DNVGvg2UW2nasri5qfg/TOrADrbsJvogyumGUQvZsLX12tFlIUk4hWW8bbVak30n52TQ9cGLte3V57ptuxBHKc+qaqXh3HVSm7RfS5l1e6dmMPS7+p82rBApttEmhLEIQubAqU0qP8jpnzAGkpT6NUMz7Ibre1xX14Ca34URCZIlUAl31DOEYzg9JLh+CyEwOA2xuoaCJSJbgRc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaeR23XjV99KyKxtEKYRWyvyl2v/64v49i3KS/BYe9E=;
 b=OjMf+/zHifc3DSjoP1fbJ5YNo7fd2GfW6kECN4pKS+vcZUzxdXAlnboZpeYXwJS9uAYDJ3rWnoeg1j7evKfj2jOacZ6irekUiusSUVAC+1Wn3/UUxxd6Rg+xVqvuax7KiZcsU6Jy9ugLelkxSUFRd+rBlgxDWYonrSDIX3/lENKAJYnqPI60zOasEJjtobaQJVjueV08BijRbCeY5eOMfW4N8sJTayHAB7Y/N3PcF2yAqavHw9snrMDdPOhq6u1vFfWCAPpTIENWUVZNuhIcbuk2d3dPfAKtRBID28a3MZnsD1CfquwuSDur1bhCtajBj4oCcMylcTdny+SgknL01A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB8619.eurprd08.prod.outlook.com (2603:10a6:150:83::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:23 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v9 10/15] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Fri, 10 Oct 2025 23:44:55 +0300
Message-ID: <20251010204500.1625215-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB8619:EE_
X-MS-Office365-Filtering-Correlation-Id: 771a2e61-f6e3-473d-b325-08de083def50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXaJ4oqacpm4A4bhhdJBZBqlsZKyRX82f1+ETtK/J91ZyBnufW3RjMzwjrbe?=
 =?us-ascii?Q?B4dmWe+G6iKn+7YZM8aaUfyDYa9yGMpnEGy7JzkP8f27hkrgckpp0slr8cT1?=
 =?us-ascii?Q?Wl0XjqzrUI7rYS9LUo2dphz5qKwEVkEZRH8k9aJHiZGrWornFgUaY/sI76Mn?=
 =?us-ascii?Q?OCjh4K9HbX8E5Oan2p07OvmbnSnOInYHND0UkpbXcKY0aBaoWenSY8A9/8G+?=
 =?us-ascii?Q?EzmPwBTotolAzLvg2G8Ke0+rAw7fAz+r497DMjLX26Jfpc0OwF6K47kf//Xv?=
 =?us-ascii?Q?ctI3UN2LXnDhHpm4Ky64NK5LI4MMwBman3YPYtAjgR93Kk7HUfCiKpfzlZlh?=
 =?us-ascii?Q?wZfzaEWh2DiK0l5bjm02AFtV7Hji1d/nv+WP56NsfvqCrxbSn8Z8/6iew1Bs?=
 =?us-ascii?Q?2HsFEi6YTeI4n9ADiSBoS80lWRHaRS4mSRgGBcFuG45NwLVN6m5ypt9ThV0g?=
 =?us-ascii?Q?rUCUlEb/1ZQ33rcbz9AuYEGaKdakWRiiiGMB82vhgITXKTxRcbqbeCsClLzv?=
 =?us-ascii?Q?0ZmDJlmjMAeSmzYyjUc6ZTgSxOlC3eN+pr562B7Ez6P2gzyY1GRSx8iqidd+?=
 =?us-ascii?Q?OXE/Q+vlXmArdKC9+eavlW2Os6pCCnTzoTx3KczfqaOE2vpl19cPTfd5+LBc?=
 =?us-ascii?Q?81cWAfmezWj1nrCQFGYkOzYUfL0NktH7KvgiXMOQgcRmm/gWXktfNenYUWj0?=
 =?us-ascii?Q?FtpVm0thof/2/QPOGhyzb8hO/S4mBaT2x3b7TfNt05hv4DPj1qw/hxeWldEj?=
 =?us-ascii?Q?MrSqsXG1gPhIwV1q1LOHcfa8sldZDh3oRryeEpcXo0o+QttmQ+vZRTNITOqG?=
 =?us-ascii?Q?ak5d6+EtnGQJKSd86siFo6JfrAyGKfBHGZN265QrPzdYG6GIwTqHD6hcgV1z?=
 =?us-ascii?Q?QK5aGkuASJJyJlpDtlYP6ZtAi+BpBsa+AfCHv7/9dlXPWIZdWtgdtGFFebKm?=
 =?us-ascii?Q?CxZCRWCu2rwHjiicIRadAS76P8b2Bj3wiKaXRwvmN+hY8mmm1WKF7yrMV4qg?=
 =?us-ascii?Q?Nr4WSoL8h65Wvgvn7QUAZO7NTljWnqEkySkK2iZCtOqlzorSjjc7yq/6VAvT?=
 =?us-ascii?Q?AjfeZ32+fKE/1ZsOFGzN/zlevqn2AI/ahpWEMW/lr8efc/v6DT/4Otzzg+LX?=
 =?us-ascii?Q?gUIz05SalQwL5dMSWT2kBKxWQWeG7Bha/rlHsV7oPC/iq7mfrC5dEiuJdvDv?=
 =?us-ascii?Q?uxfVDlvmbpHdX+8gIupxIPpq17OiM10dx6PQ5w/PpxqVQKJfS0DecIV0sFZm?=
 =?us-ascii?Q?TOYOpiLgijUQp98Y3TC2D556HjcDhzF0CIZQANcV2gOma3O8+BwGT5K03jz7?=
 =?us-ascii?Q?HPXnigfkTJIoVNruZGLEZKzD8QoQkpjhj1kxsUzaBTm/xJ+PkTxUDUD0t4E7?=
 =?us-ascii?Q?KbW+Ntjb157rf7UkuocZhYO/s7+fiS7p04NAS/30v7DyRnP6qCs0leFIjSnQ?=
 =?us-ascii?Q?/iphnqHwUz32HTTQH6D/lHe7LL3XyO7bgkTx4mjDkMCTaf5KpLIGpwblFGff?=
 =?us-ascii?Q?MHE/jwmMOZ8FO1SVKNGmeGotEfQ1tddCi541aLqlZjdMaOqtcYMOobkvyQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?23PpOXOIL21osr89/Az6uDRqKqZ7SkDV9Wb9M7PCPc80OKtQeLb31i21p+Cq?=
 =?us-ascii?Q?FBv/JgEkZAl5049/3BAWO80no65BXhslYjpnjMT3lCYj2gSLs99qnfYWee+P?=
 =?us-ascii?Q?M4CiHD7jGsFmki6/VnFEzNiI6iRbRuWOzm1Eu7MDmYPCSXaIVRPSy3Mw46L2?=
 =?us-ascii?Q?MVMBp36QPVeyLkN3D1eUe/uOlLw99suiQMdu/e/XFCO9S0HMiPb5Wh/2CHrY?=
 =?us-ascii?Q?chsyisdIk/vPvnfoJcd5tJ+fICsSIBFry98UHsJ1LrJnNS675xKeyelEnDG5?=
 =?us-ascii?Q?G+Ydry79hK7mbvHYvbE9ZHLGlhvYcAGVBCRfcJGS9Mca/HqZQX3tSfh9YMAx?=
 =?us-ascii?Q?9xQLmdV4TnH6bYz5jVP9amjc1t5rAJsWjIJL5sK3Xf8LuGPAWjixckoqLvdX?=
 =?us-ascii?Q?Ps8wqUkwYrn/nhDo2qnWXS7pzNnIZowcryHkBMK5joc6cEDQHpfjoUEzV0AT?=
 =?us-ascii?Q?UnAvRcuYY03+v+96o27ri68w5PVlhblOxGe7g6ndFhtcdyyjQ5YBheLXKZcO?=
 =?us-ascii?Q?KnPYbRoFCax93rDgKYwtB4NPKnU3Z641ttOdqAY3+Kf+Xq7knBfYiTFyg0mh?=
 =?us-ascii?Q?oYWsHLAFFmCT2ouUaFC2/4cUVSXOBwvRABEmP0zvTHDdIquGm/UD1mQYWWoy?=
 =?us-ascii?Q?5jNHNHv3HSRnf8eYwoY5hzgccHEKFxdV5JLSXhn1edfGWdIX1FbJpjZQkJbZ?=
 =?us-ascii?Q?MA0ccG6yLvQd4kubKBqK6j4C0HijSqeNrPfrrBHK+iHkKmtlbeH0QLu7hFD4?=
 =?us-ascii?Q?KYmhiRtNg08ODyGj2misSTxPvfYczlq0dKQ5J+BZtYVfRa9x/Ksg+6fD0+3g?=
 =?us-ascii?Q?jnOWysTs+5jcYuh9NF0udSXWEfDa8Sj41p//SOan3zEeVHdez/Rp0NScmW0z?=
 =?us-ascii?Q?yKoZWGzlDNa14vFOqNt9UUFssCWP+Z6BZdL8e/gbB4tYw55U99zR9Z66vEhT?=
 =?us-ascii?Q?Ax27TgS8fnXTISn3LUa1rBJ27fLuZ2I/Uolqubjg12x8umv6zWuyfW0sy50V?=
 =?us-ascii?Q?F0A1CY8rOVhgM45002V46Vmz7biBelzcPffIehaS9HU3szr5ze6a7Zb8Xgiu?=
 =?us-ascii?Q?YtfRtATvYxDr1+9ExZshnJDqKxbYvANAWX0JwHz6wZn3a2lYnQUaR3klvxrg?=
 =?us-ascii?Q?iW2ALVP6qxTkU0AHUDqiOY74dJ1BYp0jopsCggoJBXcWMDe2ffCP3P7sgAVK?=
 =?us-ascii?Q?9YxDV/x10JkjfopCj5vrCa8XxpOcjoZXfIugzXNlwqlbHv7ZyzsXsix6fWvV?=
 =?us-ascii?Q?0OkzQR7ixxZL0M/KqTuGnsIAX3zY7MaCKUCDhcp6tbq8pUoru5NYSzcJSEk4?=
 =?us-ascii?Q?CD0t1B7b7dv+lslbvJ8/yhFmnN5TX5lHlCvhTM7c5fQqwGSTI/CjETt2jL+i?=
 =?us-ascii?Q?hKqtuk18XXWGTlnY9UJrxoGpd4XnmHcrbrX3OL6FWwQXhJ71h4ZlEu3PpES2?=
 =?us-ascii?Q?puwsF0YzGQkswI3bd8zZ0wCIIsO2o9jHMFdPGSHj9Nj4v+nWnQ/+p+JlWhK0?=
 =?us-ascii?Q?CerLMG7VyLok0yPZHMSpqB65IH+2rMO/9BKACvCmAHPVIpnwyQzZ4d4Io0Nu?=
 =?us-ascii?Q?xtTSmcbKSGsW/52E3vB0lJlKOv5KdheCAIE69QX40fh6tgwXV1pSOCCbaiDd?=
 =?us-ascii?Q?mvn9Wk1rLN3MQumMSAN488M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 771a2e61-f6e3-473d-b325-08de083def50
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:23.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJN80Fqz/ggy/vtnwULpQ7H5rfHM+J0JS6JJiagIeRLf7Omec1ZHje2+27rl2LIjoJBirzj5VgaYEvBOFSyTROh1sl6FJsvTpH8D58REe6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8619

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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



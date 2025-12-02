Return-Path: <linux-spi+bounces-11709-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE750C9A95F
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 08:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D57E44E3B05
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF7304BD0;
	Tue,  2 Dec 2025 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TwIID5/m"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BE305979;
	Tue,  2 Dec 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662161; cv=fail; b=Gpr51oW94P7e/uTpmuupLcvdHhzi0vcJR8E+5W/KYEYFap8YvrYuKN+ROO7DdpzCFC3ereeHDV8XjcYcTFN+hkYoK9QnIFnS7CfPYGS1QIKubo3O6ojMCrh8GXVcXQLPSyceyBQhBC+8HQt2ijMZFArBL8ivSck2YofCue2bP7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662161; c=relaxed/simple;
	bh=tHPSUI70wtJTRDAlO92OiqkMJqUD841QqoTgE0vlMl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qq7LIf15ly69yiXFO6MmWf74JBmbPIc57NUkS75hV94VIhLleAg02EcSfE6esg0K7dv8lEM6tE7Isa3hNGbLLuavUyzw2xzTsmZHqn59WBCsdTPsXuzNq1jV9Vk7gZhl/NKD3fPCJ+aMFFFFGODPFdrvmeVdYy33Gw+1imRQOEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TwIID5/m; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1hFtUk85Y5wmjUmOqRjx94VOgHZiGN9JeCSwJTbjTomnKwgqsEpZxOy4AfQof+dc+bHsc3B6wiArrx1X5K7KmeoNdQqJYdq/8YDl14Pc3vt39iMnpAoVvklipW/ntMXXD7YbsYzdXhfsfn0uiwZeykLaByl7ER3ZkwwBomMZadgl45oAmqcOfhq3PWbZN/e8zKkWl4b6RDBxWBiKuCWrSHD40c6uiFIhQ2i/SV+QNqiyEDEP5fRJihRQUaOuE3LfoUl2IBnkpX9EW3UamE6gYUDi2fDLWkQIIrow7trnUeisLLU8HVJjHkcGz1C0+GMrxDP/aROzpJbkxZD059XZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsjHYHNLwrkWNxGNsJ2qgEZe4Qdgqq+BoLSOrD9LpHU=;
 b=SdAwqswmLeicLV+P3Jne9upaxaKNEA8nFJzNrPEUEV6+wL9qcEkuC3zofAV37nIxUGfZrPbDEM9MSfvmNzf+U6QpKHDZ40Q0MAMxbjAvvsA7bhj2aI16xVv+7CV29kxQdGqwRag761hmpFBBZO5bP8cfLJG0YDFA0OX3DU4eMcxdB2tq+w2YzS3menTpCA+jBtFdYekNfDi8YzwULGr3UTh2pTFLqXI50h7KhpNu1V97cdKQCC2r8JTDM12FOKkX28ZN26MlMXE2XhVvU6VPwGni82alaQ1rEvKoB+cnsmYFNzn+xnZ7cUHW+qnFIUmCP5lVb3rE0MNfVlY3KC/ygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsjHYHNLwrkWNxGNsJ2qgEZe4Qdgqq+BoLSOrD9LpHU=;
 b=TwIID5/mCGFvW8iTW7aq2ym/Q6x0Fj0KPQJcFmF8QTpLXNEJnPchxTOaphH21uxW4KFBvrQ5mUiXeSqqqeFMMRkpbzJOS9dfIk9TRVE7vesWa4WD++5WXkZhtf98OIYpg0LHRKVYa0UOF3FoHuPcBGrlu8J0gsJWRSWmZ8izZx/3f6Awx/2hqDzUnCcYSJXttpUN8HKcKenV5HBS6sTTeBuk4WjVo7P7Tx2mUBp6M6Tn2G2TxmbiGPxfC8FYmuItavf5Jt94BSNDXn9/YgRdFNVhYJwHE/y96ItxIzE2v9pw0IoKvOtFRK9K4CnTugH/CGBAPvvOpHTRN3MBsC/WDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DBBPR04MB7900.eurprd04.prod.outlook.com
 (2603:10a6:10:1e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 07:55:56 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:55:56 +0000
From: Carlos Song <carlos.song@nxp.com>
To: frank.li@nxp.com,
	mkl@pengutronix.de,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 3/6] spi: imx: avoid dmaengine_terminate_all() on TX prep failure
Date: Tue,  2 Dec 2025 15:55:00 +0800
Message-Id: <20251202075503.2448339-4-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202075503.2448339-1-carlos.song@nxp.com>
References: <20251202075503.2448339-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DBBPR04MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 620fc7ac-d382-443a-8eda-08de3178390f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pNBLPBr0otFmH7aetpKQO1DgUh1OKp4wOxVreFy18nWC1K7M6kw6DC/Asv9W?=
 =?us-ascii?Q?kYysyW0BXLYx5gcUvz5rGzInCK72hFVeTImsMCWS0ITfIQmt37bJunadP424?=
 =?us-ascii?Q?NRGre3z24EmKZreHGvxZvBOkG9rZQ9RQruqRePnHo4sBD+gBTfDNrV1/n8yW?=
 =?us-ascii?Q?iW33+Pbc+cyul1rysmG2Bf0kk63taY5Wq4Ky6KRjUmdwOpcxdOaCJBR8kr1E?=
 =?us-ascii?Q?xpj6i4Cvwvn3x3VXKdtVlFij8jB7PJKkLqKE9IMhGxntR/Wx4siWAH1eIaBh?=
 =?us-ascii?Q?YVZfcyaUfYS6v6RfdpuO7BY4O7jj9SwOcityL/2ZtTrYzr89I3zfGw/QJGMX?=
 =?us-ascii?Q?uAv8XTYAlTlHTWyrrLpS/TqTZr+p85VlCaM4ef+pb0VFfM1LiS9tlkkzP3K9?=
 =?us-ascii?Q?TUuXqrS1zzce0dCfhYOSYmhvTyU1rs9/1zCEOYpIf7+FTHKjIQ1Rg2NWqdnO?=
 =?us-ascii?Q?tq5B5mcjsZwMsEPbu/3wPntc+utv8Z1BMV+BJ3hExzM+Lt9wMdusHcypv0pT?=
 =?us-ascii?Q?T1HjT8Ct+1KLTqtnlRcp+xEKCTdXKSBnXBv1YZN2E6WGifYOX70yfYAdNWEP?=
 =?us-ascii?Q?7DatxYJEoyEx07mJaMAj7nuPJ2g+LbtI0y4TGtoMjUAfYvRPt4xyOIKNwr/h?=
 =?us-ascii?Q?KMfcGvT5qveK8fI0lS7GMrqu/tplhDxpxvE9oOxfKh3STVklEtI/cHU8n0+r?=
 =?us-ascii?Q?fjEkAdUOYbsPCSE+zkjlC5Aobkh9qXIm5Q7nDyS9KY1/jCyBLfrTF7aYLsHH?=
 =?us-ascii?Q?n9DStZpEAbNGIfm1lyBIap8HFQTNtBa5i/5t9YNKC0gqnB5pP9FM+gK0ugoT?=
 =?us-ascii?Q?k4HA+uMAgv2PTrTlRa2qEHGhFP2a0fhKyCw4yheQTvAm2jWqIE8/K/rDaD0k?=
 =?us-ascii?Q?vYsaFT0jo1lymAGQ2ZPHZM867+lU6Objj2V2YohIjlbwoD2r7qwmnJqNcL9l?=
 =?us-ascii?Q?xv5IjLgva1Ii66IGGwoQXYvLY4uFmcfqGurfCZ5NBTBE+vPCi9OWxI1hwMIS?=
 =?us-ascii?Q?YSGW7dt1rIxwxAR8YKtz+S7sUqtgDRyEC9dVTVZBjn2owrA1YSDebOyQvMHB?=
 =?us-ascii?Q?pxi8DcLsrwX2wFUSsqn4L7BRQO6iAu0+gGFTGrx7eLe73gYXOjjUHHnXdk04?=
 =?us-ascii?Q?whefpJ+oxZMSGhdquaIbvqoDxhBO2Ud1epzXO9xISWk5wmlxZJSHBGZceTHa?=
 =?us-ascii?Q?IAyRLjAhxrnIx8JCxnGgsp/01QJBZA6w5GWQ6sCdVy3C27vr3KimhhwvD58X?=
 =?us-ascii?Q?goWMYZcFPdN0MvnZ/V+8Yqdlo8baz+J/XnTIWXnQHEbNB8xKueMu+1j+tM++?=
 =?us-ascii?Q?eoGWeGFynJ2WP5c34Gab9lCSlLEvaYe+SH7GV04hqjl6nqA1TwL++G7/IcPG?=
 =?us-ascii?Q?9KWJkjUCDOCxXj1uwGgsvyzBPdzLTUe5gIoNhUuuGpcUo5v6vioHUVznSlFy?=
 =?us-ascii?Q?JZVKALinhJtT3QqR4a26HtjM0/iUM/X9fd51G7B7J4IfyYS+foUFeTRhB5cj?=
 =?us-ascii?Q?fimKAouBzjAWZ6rhKjVSwZ5rYCajfQ4a1jAd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4RRgjIG3Lq54BHgT+Rwl0K0bTxRvpLWvw7Z+teWVv65dN/VyBWBZIIxS/0n6?=
 =?us-ascii?Q?uo9GhDj8DIwU5YbNOKnlWVLKDWQu2YHG0S6a5qXmcuGA5XBaqoxMxASrlsvp?=
 =?us-ascii?Q?tropH3/QB+ZGZvwUealYYfML0iXTHf3X2+VO/a02rXR/hsac92/dF+Lz8M9l?=
 =?us-ascii?Q?7lhvUg5P5BFCB6RTKgNj4uNkejUQ4VTaE++imtgrJpzajRAJuOavZo1L5kc9?=
 =?us-ascii?Q?LJ+8EcLUzG26Gwl5Wh0h9NnwjK/dhg+rY0SzNzXYhAFczCf/atToJOQfg1MM?=
 =?us-ascii?Q?lznSLAXAE+rQI5SgyP5KTZp3sAXpAc481oBppvmuzAIIDrhYaeL4ulDsbXcb?=
 =?us-ascii?Q?tJ6oWgcZ+/zcbyby/UdqVXLVZ+8gSTBaj5lLtpMcxED/SGmdD9Pw0AdzdmRu?=
 =?us-ascii?Q?j4BpkuWdImrNUsGL3fvowXvEECtYRY33Z2WNBkxcjS8O6wOByaZ1HfGY3l47?=
 =?us-ascii?Q?qaavd4Eai8yFhY/ezNrmogGB5sTHNd70cJU9sfFPaew1SkdTABnmB4et83Dn?=
 =?us-ascii?Q?yvtotlnXnwhgNpLMZRs28opMEGu8d/ZfBzgWPDfQvNQr3mKhbmcNR6Qr6NN7?=
 =?us-ascii?Q?fXhRJDozmbWu4ijIc0a5mMmkhxY3NHmUTsbh3rxKNeIX0rl9eKSqTM8VJo6w?=
 =?us-ascii?Q?AcS0MIpKxad7EUlH+jw/y8ulPDJTB09Q/M2hvUfb8PbgwBg58Bs8j9tSUeuH?=
 =?us-ascii?Q?lnvjYpjqGXbguU4WLs3aPxGP4BI0ieOx54gQG/7MbjGVneMFHCv5rqpDxowR?=
 =?us-ascii?Q?zWcigqUgVkT0soOaQp+kT48fd7wPO7JbAsRgHJKRtDH9Buawc+w2GpeqLMu2?=
 =?us-ascii?Q?XqiFXFhOHODMnNflT+gQcVAXYN1HZ/v4Oaj5Yz6lN8UZxzTW7L2zEZBSU75C?=
 =?us-ascii?Q?4pSxiOzM0wpnNZoK39cYa1xinVR+lSTs5foYF3J4g7iSsSaWmFjr1bm9Bltf?=
 =?us-ascii?Q?H+HRaIWdbmM3CksSn90Bz26n+kuoPWQYDKCtEK+6lEFRgq7PtBD6qC6fd8bk?=
 =?us-ascii?Q?7AQIgQX9LzAZEXB6Tf5LwD+OseRWOIPtLW3hgdxLzyi7OcLtFXnsx9smp5ir?=
 =?us-ascii?Q?Irq2cChFmtEr339rFf9R9/IxDXMRXxTge9cAYel6OG5CXNLc6+AePc+XLa8K?=
 =?us-ascii?Q?4/KXTlh1Jq/leLuAa4rN4CBZMD36YTA4v1qTYvcffl/zdy9+BMfA5eRAJjAB?=
 =?us-ascii?Q?uhnhlmaXIk4l6GPIlPDFCHI7Cq8yX/tUv9113wLlOSVjSrkoXEsASRLoBt9p?=
 =?us-ascii?Q?boPo8etKT1AwuMf23/qe2RYhtRhRXOxUHmosAp77jnUKr7nmacLmP0ddhixF?=
 =?us-ascii?Q?n98nP/5QQ9lzRz3Hy24YdtmZjHQcAhEpumPChWnOxMgg1KLJCGxYJ21KFcze?=
 =?us-ascii?Q?Pc0PQl4frC550JlPpMOwmqocu2zI4bR8TKU+1uxSnY3opbG9AZH5QBDecjmV?=
 =?us-ascii?Q?m7cmDUL4tq/lpXnDwZvjirSmeHZ6n5GkqCPf+Ekqh2uAkhMcDO9VVUCkLq5o?=
 =?us-ascii?Q?wmKnfCJWKDQDy3N85ABCPE/D3g/CWs6RSSz6ZyKyTQTW3TP1pCzWIhbskuXl?=
 =?us-ascii?Q?txhibzZ2iCg1EGg6r1JQgqYRUhbykMd8cen8OYcx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620fc7ac-d382-443a-8eda-08de3178390f
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:55:56.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqg4MWy50Hc9wFC06tk/3kVDFVQpBuTus/GmxCJmXcJLfTpRzHf9FsAPwPfmXU4GJhfZ0OpDkELW35tar5USxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900

If dmaengine_prep_slave_sg() fails, no descriptor is submitted to the TX
channel and DMA is never started. Therefore, calling
dmaengine_terminate_all() for the TX DMA channel is unnecessary.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-imx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 012f5bcbf73f..186963d3d2e0 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1468,7 +1468,6 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 					  tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
-		dmaengine_terminate_all(controller->dma_tx);
 		dmaengine_terminate_all(controller->dma_rx);
 		return -EINVAL;
 	}
-- 
2.34.1



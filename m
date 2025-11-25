Return-Path: <linux-spi+bounces-11491-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07481C83117
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 03:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A38034B5CD
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9651A08AF;
	Tue, 25 Nov 2025 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="f052gDtU"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020129.outbound.protection.outlook.com [52.101.69.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665718D658;
	Tue, 25 Nov 2025 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036673; cv=fail; b=IJDy/s98lTckBDXUhDmiaeSlv+uTlii6ZCgV2K7td692UMBrD5/vINB0lWRoiNqV16bMSlxegqDPTxaMpiqPhv1haPbu780nCi1eIrCUjpVp6XehqQtnq2pN9LOK8kbu8+NA4xMM0Gpa/QZXCAPRBxLmT0GEyxVd6E5dXm5Q5Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036673; c=relaxed/simple;
	bh=CeTAXTX4cq9sAn8fYJyjhuXPxuLjble3frbdrwO/lpY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hBYopCwOcGivLGosYGHAih32jBIujHbjzgXOtvDQQODGulR3Oxq9EJ+hcl/llq8+PAgViaTPZbSQtJhFfThCaEpE6XaS1cKFzy/DUqWZpIvwpjTT2LtpU2oEem65/IajLgnUBr/9tiUmMCuU0OYPbZXVRGjL4XPhYs7nzeqExPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=f052gDtU; arc=fail smtp.client-ip=52.101.69.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0IO9pnN+5xGAd4lUHJXgW/T8113k/UFnVM7SpCyxCgigZ0w6AZLsMf4LptokE/lJwpvDZfS2qx8SPBYgrYyJMxd40epNkiJH4sy4dq5Aetm3l1WmGJEF2OiJGrqip24AjuDXBQoWtPGZjmeQ4g00bCyC5YL2/JY+yNQnVHG5k3PuNWuK1nbaWM51rktY1uz+J638kQOgEXlAJcvjIYXAXELf1UsoBnThzDjBYse3e9lIqk2vuvE7b97bGU5wTfrjXnuHTeGYpMZzS1ZPx2hsUJd9A7fDl6l1gCtgSbzilj2LmBERF+oi++E1F3soetSFiLOegiS0Yhqs1ATaBtF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz53KMss4AxZO/tOna3TMjo3QKDwozA7LQiIUQKAhTU=;
 b=M0sCHYr4RlU5/ikJXwvkggqSy2d2K8tvtxpCI9lCmMSfHb2YFGFufVKIFxVO132eXKRe8jElELiKgVC7B6rB3C5cqAzugpuOy263ooq+rT/gQcu+J/GYBNLsIVwjRxBQ7DFH1Yhp366ogqaMDBo3IJ7ml2SNugLaMyzkRUPjMdC+vO5uhyvcwBNC+WTjeDm5uBCReQUpI6BfPGii+xezy0euF3smpqXoB4x+FkPHv+scXDlF6qGpjKHppzxKPKVkKYYbJfOopN2K4lA/sU6ajElM+z6oG6ma20/bFcPbuMqbSVmsK3BocPq7X4/FiyD7aSN+IEMtu0YLDjPkjsSKLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz53KMss4AxZO/tOna3TMjo3QKDwozA7LQiIUQKAhTU=;
 b=f052gDtUbLKkbSFVpLEyuWsIBBrhBrSrGKyaFIBJUMtbHNjIPoThJiSWsEu/XVy6Eo162AO8x7LeGHGTT64RcYCX8COOg9qEKlH+aFnytcj6jqz5JnSRO8MWbabTTH6Ab4hnhtA1zvFowdEh5WUP+S64gYWHTYXKaPkHMo/1cqV5ub5NnNBVz/IY0+r4vwl3Sn58kLtY6J6jvl5nm1ViJVOBT2XDbh6m0pExz8EGs91BTvHaiyX65OipeMI7az9ImzRlVmQKT9HQWEfX+p5OkJXzOmdKIW1/e6O697sV/Sdb03BLDyfV9Bb4DREhDo7B1vQeb0Er4KRd4intFeJq4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10638.eurprd08.prod.outlook.com (2603:10a6:150:14b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 02:11:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:11:00 +0000
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
Subject: [PATCH v4 0/3] spi: airoha: add support of en7523 SoC (for 6.19)
Date: Tue, 25 Nov 2025 05:10:48 +0300
Message-ID: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::34) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB10638:EE_
X-MS-Office365-Filtering-Correlation-Id: f2236cbe-f1a3-40aa-16df-08de2bc7e0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJfn86p40Xf7TfJGIfP+nLfXo9btM9y6vx7OIhtsFLyK1iaXcabPeEljMnnd?=
 =?us-ascii?Q?FZTxELkOquTuNb422XY1fk5AqP8p77kqH+0Y2PqQ21MblkP0FGSYr1Tgc8uC?=
 =?us-ascii?Q?tQH6vJzaYS+qDl40XH4C2U7SZFzAvy/GUVR/3NMMmXbtVNxuXnZMhriONUcV?=
 =?us-ascii?Q?rAzjbm49WEdpeqdF3Uhps/g4u6aqjU4+ralrvQwgIyICEM6+Ycd03N1s7Xyf?=
 =?us-ascii?Q?mBH0DbiabL7eWtgPgNGiM617tN8qP5dkq9j/rIy/gfuqozHYoiV1ozsN3oNg?=
 =?us-ascii?Q?CpxQNkFVF0Y2mE6yHxWYxLgJSGhDGfgP0+rMv04Md0CrD6sWL0gtlX/TvCaE?=
 =?us-ascii?Q?ckyuy/4EEzYLXHJogEmXjyxxgj73HL7vWPF5SCGdpWHSYGrQuS1iU+Xrq05H?=
 =?us-ascii?Q?P5Mz+69SCCdKyVe/xWhzcmMg6qGaUAASlwwA4GmdDb8V9HtzzzmmarexG7e7?=
 =?us-ascii?Q?6Nm+sMcIZ9zoxHPwDk089T473+qkMRBAM8gu52kbRUxT8HN74h42n9zs4hb0?=
 =?us-ascii?Q?bsakX6i1hcT9iuf2BtHw1D/rT4CUoPpe1XP1rAsIkLAnmyCvivndhUWv82a5?=
 =?us-ascii?Q?CQ51C66zZSUjmU/pgZrCRb2gqvlIAGkLXDRveXwFDmFG/bOue9qI1vid3/wf?=
 =?us-ascii?Q?nfAeBU1yjofEuzXwFeYLTp8W1pxdRFZQPdU7gFWmQpN5vARhjCR+R2Q78c4F?=
 =?us-ascii?Q?LhMTpIEDoB3WoJ5ALckOZOLRkWESN0kCbR5sDqnhapzaAamK60k0/X89Ahx8?=
 =?us-ascii?Q?mg8ohNb6nIclIbusBMjYRHpqbj+gc5G3kkWnCnyIaqKAS6NcrVUpTBQMpVc1?=
 =?us-ascii?Q?hZAWRmPUvFTYWcZKr7O/A8yHdU8FO5r1ylYWaMoBV66p85KkntjQKN+AiZgC?=
 =?us-ascii?Q?x2VI/SlmblAqsd1/S0DEQT90YM+4zXgURjVhITEnjGU4jv4tludqIAL+swk7?=
 =?us-ascii?Q?hvYb3X3qzsKzzlTrzuqY0qMaqOQLW9r5FHaiF0bO7m5RcEK/6+OV80dt1eq8?=
 =?us-ascii?Q?VfxiAgRKzxMlUhqbBH1Ps5sA042vYiMEWRRYNvQR2BQK7NoiykXnNqZuXxbM?=
 =?us-ascii?Q?En9/OKSMfoR+uJyhOu3glg9ISVJj6mubXzMpRZT9+pvwCus04vJcLu68VZIv?=
 =?us-ascii?Q?nBMs6UbkWIwud/zY7PNt03eTOmfG6ghYgL4papxZaEKHsmCnDr3avFFniGYx?=
 =?us-ascii?Q?mPV+aYMuIsyAQvFFGZjqq2drD5Ad266OC0gD5RLTW9UoLNxskEkssndYQ7Sz?=
 =?us-ascii?Q?PjluikT6p/vmvGGsPHfVI6dOwx6ZIKfKEBknzQsK/83oj5lozJ/YS2Zmcv8L?=
 =?us-ascii?Q?3kd2SxoMdKQoBS/jMqR/ajpnrd49J7CeKhn5mqXAxar9gAxV50ohKWdFWwD7?=
 =?us-ascii?Q?nM7DWEnb4oAmtDf8DSvabYsT3EzbQiwUTo3tIyeNUkkUfK8niYJc+OzxUjM3?=
 =?us-ascii?Q?LGNL+hnUJ1jglSpLs8/FXziYSR9Z6zbqouk3qYSVnoFmwxG0If48WwBccTLm?=
 =?us-ascii?Q?UIZ4fLBu2CtUR2hGhsTWKLcdl6jEhnGQFfTxEgnL3VO0BK7lL3u5xWIuFw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hMBofpC1Hm9Yf+G5SxqvJWuIo9NtLGopfmHjLILpL0cXjXEeFaDC/fgqgxhS?=
 =?us-ascii?Q?QhjVveYidusK47dOR6r3KAS21vRS5fULfy3PMMX0TD7NvREgyMB3zV1uGDII?=
 =?us-ascii?Q?aeEKL3pboOZLBwn5LMR6VWZLvDb5TJHsTx5qmRxJuUwaZ8uVMqS5BkynG0Il?=
 =?us-ascii?Q?wJd9rGM+s7/fJ67RRh8rVCEDr7W+Xs6A0BUNyvSP4uImxGJYh6GBFi4aCoL0?=
 =?us-ascii?Q?rwr2qQ1u9QgGF5b/psJL9+B5Dy64VvpL52x6eF/Yf0QB3VuBjXyAmYPn/aUE?=
 =?us-ascii?Q?RDFHQc3WW5cy0agvKKbQtxmD+pqc/4qlaKy0WIiA37DO9eE68FdyjXA7qvIy?=
 =?us-ascii?Q?iQPG+/0T1jAu9lGfO0u1h7oakZ02sQ2NBBO7iXSEv/4nUBI73o9sA2WCqPZN?=
 =?us-ascii?Q?/L4KDvZtMqD4sLtsC4nmCjCELRfQ00F7PRsMVcuqtriYibjqDymqEDEmfogy?=
 =?us-ascii?Q?uaF4tzi+nqOio0Yd0RgNwAXi9W3rDIT0Nsa52Jm/Y+HSydqGuqUAJkn20v34?=
 =?us-ascii?Q?BD8CCl5d3EE9hJGo1cwIUDG7VSm81i7Lfq7oP4ItZ0On88pRusxpRognaLIS?=
 =?us-ascii?Q?2EVvVo5qGPegX2jnDKnmBea2egfePnTDpBZhDzsQ/l4t0faXZ9NifkB3EL1H?=
 =?us-ascii?Q?poeCJGOSNRSkoygZzl/CpkQB0ycZb8B+mkU46ZjAkFjJ3k41srLUdftmkrMk?=
 =?us-ascii?Q?jNVTqn6rFb2HYvwwJBOeZmmHHYtM38AdzTjrMPrka0FuQLIaZ6go6GvUjXwy?=
 =?us-ascii?Q?JBVkrz8CRe1/Vkk3tTF4olf0cv93r0lOcdRTdj5IIxVN9zxYQQ683QKOr5CV?=
 =?us-ascii?Q?6As3HEH0Kv6XvcFAJj0IEeQbfvGBQdqCgTj6OqGbFmFv7MWo7pFMtETzLoHK?=
 =?us-ascii?Q?DbkhWSL6fGVtYYoyzLeX1f2CwVm1/LxtMNbjMVnhPgpezjPzQUYyxbAy0G66?=
 =?us-ascii?Q?euC+RpCnIrBKZxOfqUt9eA8O5TQv0d2pxMcS8ax5pCqTHl8xDgAfx8GcXMyL?=
 =?us-ascii?Q?JShpJJ5ge+1SrFNVZdDbo9AoIwswU2Uzj7lNhrlIi8D5yd82OBTU+j053RpY?=
 =?us-ascii?Q?aoPZJpY53rq2RUENvtl3NACj/XN5JwhwUaPg+8p8ahnInJNNk/8HE6kIHess?=
 =?us-ascii?Q?uCvjlOz/ccDK++YUhoZ2ebO+i+eh4S28phJqvQvKElW5TpKyZMIi8JItujIK?=
 =?us-ascii?Q?eAXYjDkig/kmIaBPJG/hTqrsleLPQMgIBF+VqGoa78Z6zfRdHWNmZzzz4O6x?=
 =?us-ascii?Q?IUXARYZuWBjKlkbUvmgNQdw4ri3/ngjM0Od1W6q/YijPPJskUwzZJpIN12p+?=
 =?us-ascii?Q?3WGqmntnejFqDzdT5DNBjxVuzcpmec5ZZWWVbZh1f1+3AVmI8ICB8bSjGyUW?=
 =?us-ascii?Q?D7wsdRosDX2Dtq3fT/Wi/rAei/RaelcgsAaKstJU623GilA7RbeudWXyJjWh?=
 =?us-ascii?Q?JEloMcX48tgJQYvjBks86pjR6o+WW8mBRhCZ4ihh1j4wSTts3Ia8HTK9h2cR?=
 =?us-ascii?Q?Cfr1drqkOM/7cqzBRFWw88MbReoIzJOvLxTTiYb8W952gMjDj/2VutKie2eS?=
 =?us-ascii?Q?WhT7nek2Z0HEnk1L42Is2D81YHNlKzL0Bfr6igtL55ocPqTw2kABwfJF7HCx?=
 =?us-ascii?Q?M94iy4NDrMXxoE3cwrXgctc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f2236cbe-f1a3-40aa-16df-08de2bc7e0a6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 02:11:00.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3+Fnh9XxZh9Iu1jj5bNs4K+DIGkBj8DfDpbDlgmuQndt59qNQW0ycOzUtkrR0ynefU5urHQXa13n8SgtZ5zKCR2a/HUtUjjPScO1/KKZxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10638

Airoha EN7523 snfi controller almost identical to AN7581 one, so the same
driver can be used. The only known difference appears in the very specific
boot conditions, when attached serial console force EN7523 SoC boots
in undocumented (reserved) mode. In this mode dma reading of the flash
works incorrectly.

This patch series:
 * add support of EN7523 SoC
 * add spinand node to en7523 dts (so spinand flash finally becomes usable)
 * updates dt-bindings to mark driver as compatible with en7523
 * disable dma usage to prevent possible data damage if booting in
   reserved mode was detected.

This patch series was a part of a bigger series:

  https://lore.kernel.org/lkml/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu/

All patches of the bigger series (except these patches) was already accepted
to linux-next.

Changes v2:
 * small improvement proposed by Lorenzo Bianconi

Changes v3:
 * split multi-line print on a series of single line prints as suggested by
   Mark Brown

Changes v4:
 * improve description of Airoha en7523 SoC specific issue that may
   lead to flash data damaging.
 * add fixes tag

Mikhail Kshevetskiy (3):
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  dt-bindings: spi: airoha: add compatible for EN7523
  arm: dts: airoha: en7523: add SNAND node

 .../bindings/spi/airoha,en7581-snand.yaml     |  7 +++-
 arch/arm/boot/dts/airoha/en7523.dtsi          | 20 +++++++++++
 drivers/spi/spi-airoha-snfi.c                 | 34 ++++++++++++++++---
 3 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.51.0



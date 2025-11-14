Return-Path: <linux-spi+bounces-11228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD8C5F9A3
	for <lists+linux-spi@lfdr.de>; Sat, 15 Nov 2025 00:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BA194EA834
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 23:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A8B1A08AF;
	Fri, 14 Nov 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Qdj4QZvi"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023078.outbound.protection.outlook.com [52.101.83.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E62E7658;
	Fri, 14 Nov 2025 23:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763163287; cv=fail; b=qxO5uhYr1O714glgcYhgc0G3naXZANgciUO6ogLGf96R8bC7tax4QmsNfMNQBCata77y6Shm6PYxW6PYH5BYTcPc0lhjl3Zi7dScq4tDZaf1drr74BBpZkmIklo8feKjYiGcRfWv/r8r1fAmJq0yDX+HVDYl+oBEGSUa73S+nVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763163287; c=relaxed/simple;
	bh=c4+yCmYeH24D09rl2CMeWVH6r/EaJ3oGVdc9MMmbB+0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z1x1nOJOC4d9Iuwo0bn5kV6Ur+q5Tn9SJbYDf51X8R7biIA0G8bcqgQVJNecLclixHIFT+y8HIobnUFGl22SYtSenpKKsriu9a/E5JKQwKegNmsEUrMUJdFoTctr3XlODJe5jTZwtzhUatQYiM2qnps+b33Jj734Z+SQY1N9JfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Qdj4QZvi; arc=fail smtp.client-ip=52.101.83.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ad7wrS3WJqCsNz3at0E5uLsJib2Fmx9l25KA/M7j2Oi1SKqggNXUuNhjRX8ENPMA6mha22++wvR1V6vwrHY9o0HJej35IeV44O29Mm2mgr2cE6/RMbnIDv4ULDgwGKHGSFMXKkM56cruU5kWOLxxForztBPUiBgKARSz1y0ax1W2HJ4yy0bOZslNyNJ73EukTaKgAFZWH2GSo8Fqcx1nE8ZylTaNRDBrXkU6EtR8oZYNna3Pqkm3ELP5oJptFhJ6PCpPwiCzGxvGDVATOBEET3B7RNgtXCXI5PcBcij2n6e+AQezyEa1MV//2CenQoRms2LyKscxaEmK7MM0MVQOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1I4lkR71qgHMVsGijYLavpEmPmh63gZvSAP4fvo+2E=;
 b=jw97VSiYZjKzvUSFu3EGfJv/fuIvG9Wqhutl8sR6dVlAZgNPFhZ5F+aDJitYBdZtpjwvvz/rla+2OLpwfVwidC7lKIGk6YqgFh/3wCS8e0oj1VGw+9vl+CdOnTsnx1QVoviCv/z5dCXejcZILIiqYRQcjYYjY1CpOPDoCVIsxt2sJ/VvmEhJkzVZhvapK35hTMXFqmu6Of2JtWNfu73FMXrGZX2vk913N0ldgZwn1nZgrtPZ5ZK2Qop2Ftb5EkKPpn9AGsnNWXKsg1oB19wxLTyBwG8wIn8uF2M9jlGbJ6HEVQyyryxxWMEiTgv1j3Bfg15BsYgYPpqE8iSMtsav5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1I4lkR71qgHMVsGijYLavpEmPmh63gZvSAP4fvo+2E=;
 b=Qdj4QZviX8UuxbDYf17jvvihZ8+ay13HBasanxtOkCQdo4lwEwxJtOY5ipZPuPbL7XdITt3BD8fu+RDBZJgyyhaayon7kQezqDqrb3Yus3pFZ/ye4/pyq+KylHZEC76gp8e7cbdb9OI9UW+t5bZnWcGvA/oIyEGJlLz0wB61kZ849XQqV2E9eFAW+qTIYRBzKZetDfMXV2xTm92Wdy/VJeduxLybHPlbqyTEPWQ04KGLk6kwGBRFaZfi1grdRi/NjH1qd8mMU+bsG1ooOgy6GLk/gFwoVxbWLtrrJ+lr9P27vlUkxl3jZH3Xcb1Lmn5hC95Ic6RtxIhhsl6xKQ5pdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA6PR08MB10739.eurprd08.prod.outlook.com (2603:10a6:102:3d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 23:34:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 23:34:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 0/3] spi: airoha: add support of en7523 SoC (for 6.19)
Date: Sat, 15 Nov 2025 02:34:28 +0300
Message-ID: <20251114233431.1920015-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:7:15::43) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA6PR08MB10739:EE_
X-MS-Office365-Filtering-Correlation-Id: d565e3bd-a5af-41aa-e0b4-08de23d661b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7/0pS/WsWihNuc0sx5u6Hnuu6KUqqF9I51IDgf13xQXYaQBe2qusDYTC0fJ?=
 =?us-ascii?Q?wzmHMwPUFyt0KsaMaKeyfDqOlZ4ll9MWWgVFmKN8UtIYJPi/myWtCcUlSJzR?=
 =?us-ascii?Q?48YvEOvz6aS5DKAZMlQfNr4XVmzHONlgJOWXOtzzRPb/92asknCbYA8bs2ye?=
 =?us-ascii?Q?SaVXqC/YM2lpiwnMMHTBxXew05BccOYrOOROdRTFkMlBPnzeXgWNGZV87I6b?=
 =?us-ascii?Q?Q3ivnKfN9gIbaR9d32RMZnCyzePH+dfUkPXlj8kL245uShr2K+4ALZ3CduEO?=
 =?us-ascii?Q?bVmAOmA0HnI34xk0noe22Q3qvtLskvHBxJpEGqQ0R8PFrXpgmwRBxr/1OxB5?=
 =?us-ascii?Q?S1Ihn9cdj2867QLaMuoLBWNZlkc33caTS3NyU/g3/pjJf15SrFwucvYWTXmJ?=
 =?us-ascii?Q?k7eqyE+og9rm4uC4FSeSCtk8CcTIqK/0ysRHypkDCkQ4nZC9uNG+Hz+hZQt3?=
 =?us-ascii?Q?L1fH6KEnfrRkpCnVhyWUYFI/suAJ37+k/0dDzCHpX0ZoYXinnvVF7rC4n4St?=
 =?us-ascii?Q?FHg1St/oGISE4C6yDZGxsl9I7c83xb95tf4eeqoNqHoXe5Dh5lLUK8JLnmNv?=
 =?us-ascii?Q?TvYNw3x9xwhgGVVBF6h77NO+a2/LMoGp1jkiibldfqW4nL/0NvpR9mC09JGU?=
 =?us-ascii?Q?21SxVcd/Z0rOdqw0kLVp+zsXJH4YaIDOcyIllBNK3L4kxj9Qs6GOmcs941fA?=
 =?us-ascii?Q?mrNVFCD+R29UpyifZLWrlzu1dZDW0c5jYx3pIroGAJj5xrqFNiUPKqKCCKZY?=
 =?us-ascii?Q?CtV8hKGS7GMBZA+1cNrYqFv56S4MY3/LZq/d8ZTspwlIHQxZ86l3h+AuqETu?=
 =?us-ascii?Q?y+f4XPxxa0LX/sxO9DlM2of6jIS+MGb+VzngJGdG7cw+2183a8em433Y12Rh?=
 =?us-ascii?Q?1gZyIbYz2NmauUt8siwqsI2dldB3hdWvsAGGxO8AHmUbvA5eTWPDS7G6PPii?=
 =?us-ascii?Q?1nlkYRb11bQH8hfFbT+9fGgsm093Z6xpFLBSnP2rvmW+I8x0APddbQnkRScF?=
 =?us-ascii?Q?TnYubjpxuQxumAeuSk76v03iP+4wJGLRLWUYnlU9p3U2HpOQ6ouVXvWXNCWF?=
 =?us-ascii?Q?r+YMYynHCz6oLnzGcfsPxy/cJuH94fvcHUl5WFwQCUicKdANFkszrE7FfFa7?=
 =?us-ascii?Q?BChIrFK25aXIZsa5aRGL2UvW78JjB5WU1e95bw358OZSm+NKDPqFt+JKIOUx?=
 =?us-ascii?Q?Akva20IKfiRoUDvxpnr4MeWOOfc4o0LE0MpTIoQStNWWo1f30wwdt2/jLBHU?=
 =?us-ascii?Q?TzCBeon3+u4bY1bo+dqhDlPR/5tIL/koHfJCjZ1V9w44okROK4Sofgvk9aYU?=
 =?us-ascii?Q?ID5MDIoaiDZm/ELJSn0YgILUQEdeNDJa/8eZiQQq3Odi1waQJ4vdfj89qp3r?=
 =?us-ascii?Q?0ofiQtMtx9vCJ6UwaTWtiXha7AE+neV7L/BeqD6KEQl7Gacx+JXHJJSqsFAq?=
 =?us-ascii?Q?mQAxU+AILM1MWQ2wsNjexQIuhDnNv1NjC1m8cafg3M/p6q+iyDIyJUA/IEUy?=
 =?us-ascii?Q?rLUIvBtsLyDARZz4adDcz5b2YdXDVTdUGg3ct2bX7IC4/RXt+k+kchpFOw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6TdISaWC+AYfeSk5TDbiLP9e1gcUM9sAHa981lh50SNU2tkg6bfN16Z/gR+Q?=
 =?us-ascii?Q?GBS/shVZB8eQf6nY2GRNK/dagtWbhdRtqyHthrqd/D9DTOqFoSYpe0Ex69yi?=
 =?us-ascii?Q?6RwefHEafHcV2ECS/Hvc0X8UtqnleG9yry62eNjptp671lq4fDCDjySyIl2V?=
 =?us-ascii?Q?Uw5j7qFAqDhTVFsVzwNC+wBNblyBdK9fy/UXmR4ctcZZkRHn5I3rkaK9s5Ke?=
 =?us-ascii?Q?2j1Jj5D6HEmkeJYTJxsQnSFr9AZhEI9NCY1FTSzQCtnNXKsz0616U6pFsRMe?=
 =?us-ascii?Q?Ki9fXTcdJB6bqDBVDb2AHJ33npDu3ujWcvihMxLD2weC4qTFn1GRNaKb2QWU?=
 =?us-ascii?Q?3zLZfflY0WvhJm4OrMai3BrjfI+VclMbKZwgi6IWchruSse8A1Arym9GFwO1?=
 =?us-ascii?Q?JEoHLIxANfZM8m7z6IXVZGV1EStxqFAXxM7IeFMeSIgrFjpHf7oYDik27EDI?=
 =?us-ascii?Q?/2vvbNylif+AViQ0f5o2dxsemb1cxb9ry3ZnnxIqpDqAzHAev1/huvRuglzH?=
 =?us-ascii?Q?En/r/66b5/61KlgzQu9hyiNuVLHj+/gTPOTNsXKqy4Eb9nf7phC9XTTMRKhB?=
 =?us-ascii?Q?jsfBlVG8n8zN5Nnd7OrWNnX8Anj9upPXykp7Ne8HC9uRHMvSpSiEJcBM753q?=
 =?us-ascii?Q?6qDxrDnKN3GpvgDOL/nkAsg5hEqItcABivKIK4P3unoT4dy8n72vMb5uNOeX?=
 =?us-ascii?Q?SbmcYHhkJa9B0FpDj+Ks8QDqYh2f8Xop3ZgZz03p+OP9PTw4v8bQFeUxWI2I?=
 =?us-ascii?Q?ofqzbspElvjUfHB4qjoEYmXDuGtCki2fw/32UB2OLyOyHT2lULTKLv88KGSh?=
 =?us-ascii?Q?8BptDELrti0yL6wcBmc0tKW0sc5yWvM/s+21MPe0S7GTg+ijurGkCM91o34F?=
 =?us-ascii?Q?eWuCcp8J13pBRnag9ead8sj1NitH3p6xw4Chuo3V7zTsEcL/9Hg8vI5OMugE?=
 =?us-ascii?Q?OzTGK8eX3lm2WRNW4CLvFk/nQNeOVgs+gvNH3hIhhKUGY4bx67ICkDFxbH8H?=
 =?us-ascii?Q?ASsY2+CCSLUAqtUP+WaHRikcqerfrBAFd3FVzt6isqg4OFOtBjEcHvmtBHg5?=
 =?us-ascii?Q?epRr13Hw07iuRpcdjKyvMvSaXKR+7w+1dGjZoUKLBiQk3mUKYKuX/JKgi2pn?=
 =?us-ascii?Q?eyysiPIa8X+vHFvMFXsFnemI9GcDHiVhnqG3R3LFuLNSinzcNxE6Rw57DEoO?=
 =?us-ascii?Q?xi1bYwkkyl0KgOyBfOA7VGmrritP8S7BU+vPXpkP62LYI38azKVoHPdkFqFE?=
 =?us-ascii?Q?xW6EWtOsOICfIL7HEnFleLrYCVNqqmf/fLGfAtSIBOgXx1XR1OmpoDVdU7uG?=
 =?us-ascii?Q?wd2jyy0LhBWBzY24ukFQ8oczlBAaH2Ze9oRWWyTB1IrIiHekyxOZPWhVPhIR?=
 =?us-ascii?Q?SMlRdi/eFwAPwRs5EwGA0jrbdfSyLTT+D/ocIU62JTUs9FVrLGaVjj+kRssA?=
 =?us-ascii?Q?sW3mjOSAjRAKk0KBNASK2ztVqUM6WKYphvWg9HnpPj3L5CbQbytA2au3Tp7+?=
 =?us-ascii?Q?y4QbF8gdwLe+YBw+fUfrwgg86fWAHOxtog0SQhquKGfXfla+yzXnNbMQ1BEY?=
 =?us-ascii?Q?aU+hH5sj7KTGwE4rt5TNFGsYXCEbQ748zaW6DBl9VfAGbP+c8lOpvrOj8E0O?=
 =?us-ascii?Q?+oR7vkaB4IWFxosuj1gkwjM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d565e3bd-a5af-41aa-e0b4-08de23d661b9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 23:34:40.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AkYpX1LphgkWs0eFt8PQJVihtGHAOm4uJOvkqCzYcCBG93JNS7fM+3Q72kpL1c7PnGc1y9T56Te3k4ofxixIunuYo0IyZf6eeOmx0mWcSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10739

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
to linux-next. The was no any activity around remaining patches for a long
time, so it's time to send them again.

Mikhail Kshevetskiy (3):
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  dt-bindings: spi: airoha: add compatible for EN7523
  arm: dts: airoha: en7523: add SNAND node

 .../bindings/spi/airoha,en7581-snand.yaml     |  7 +++-
 arch/arm/boot/dts/airoha/en7523.dtsi          | 20 ++++++++++
 drivers/spi/spi-airoha-snfi.c                 | 40 ++++++++++++++++---
 3 files changed, 61 insertions(+), 6 deletions(-)

-- 
2.51.0



Return-Path: <linux-spi+bounces-10533-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57DBCE57D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B24F4E0213
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85C71DDC33;
	Fri, 10 Oct 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="dLzH8F0R"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021136.outbound.protection.outlook.com [52.101.70.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B18EEC0;
	Fri, 10 Oct 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124054; cv=fail; b=IRDLsP1Dik0KdBjOSmdybzIbhPS5jELheiDWviGq/lTmHBRtd+20y0IYNj8JtYlAM0/9tvVpGFIuERvfhnlYHFgJQaz7YaDPxhiOpaczvuQPWb6Pm+QEwDSE0obWdEblYz2D4CNh6cFOy/nDTJMfSgiISXNdZW52LDE4zRhosXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124054; c=relaxed/simple;
	bh=A1bSBGy2kZH8EFv3WwQRHeaHSvuGuDCdM/uEwJlCwto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxgWDmsHLtSvSAim41l7C3aFNGd1zu9u1QxVX2/WrgCbs3diAOlVbfTvbXRZahVIDBbFk8va0tGqjUrZZHiN85df1+9zS7+pBhsK8B9P6PkmbJbxjvMgYvbkmWqgjDvjW4fArTYqHfJyeADN9QlPsX4FJSHTw49TW3t4a5VNFr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=dLzH8F0R; arc=fail smtp.client-ip=52.101.70.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFjZ8/wECJ7OBBYv7XPQ2QY2SyDkrDRftw9VddgddqqWxSXfl3kULoLeDtWZH1yQMvSvQj8Z+sxB9/ePOWI+COzr+0zXAMRMA7iRHuC8veNLVl65SomI3IsanSWl0o7YxVhFZM+rXGWG5q5YaSevLOCiQgoHx5OjMmUt1anPaqfFhhlKJkDT/AwCgIvBrySYv6UWIpTpncVaaQYwTRaCzkCN23hwp/m+UXTUQUHKJMcluaLRaVcVicFJAOrqP0mOzZvyIv4XRPXJJBaBddDlbyQtBz8CXVtbabGrZaZSx1rLgtJmOxUao/bCF7xUslRJl64P4U0U/sEOaAG1So9r2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=AVJR4z7g6o0lv7xRgTOgwsL1aWzWNPOHXryZzuq0RG1vKjG8Rc8H1zktQ69+4jGq+UURDlO1tgMpIUHSbf99Vlsh+Ih3N+6CI2o9nhP5d0C+xH1nqi81CS9etzVmYqwoIYNPjHwZ4blQMliJrIj/immqetXweplOEgqKdRzFQXskDjGccnztlhAarTtUseJGaZNtNiV7iyJj5EvQLG8zKnNboRtnOpZ4Wi0cLpvoh2KpcWWdXajefzrjAj3As5Y0jFbC3AVFsrHl2c0kkhdwRPs4175MLeUtGgKNmnDkSt1v3MlpRgVv8YtxIzkp6GREuG5xqs7QwCcXTJdXArRALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHZ5zpP9tC1wl8ucs9JOwOjBMT1xIexdwM8R+ImbukQ=;
 b=dLzH8F0RQLhgkBfnuWQfIDrIxOZULFrDHk+Q5AJvEBMZYXguOWGbnw8zJreOnfwvqLEqq0fN2t8rJ7JRFLN1CBsrtkN2Ooo+KGVA8g/u+7qXsO42PU8nM6e0AZXaaU2Y9WeKuBrcmrlI8KRKd6MD+EGbIZg9PyUVO7OWbHOaz+r0abdNVtxoesnR1aDbFDWpg6mhDEdBA9zQ0p/6RvURrkTGrMkuaAgjsoDsFEPmBOJ4rbDwWGVr8KE9VSNEfG4HrOnTFwFXOrdGOTxT2GZawgYylmHKC8YJDLS8psCFo1EXLQJsD6NPKazjNPjkB8Bimhr7BrMuLyAAp3UnbD9PDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB11352.eurprd08.prod.outlook.com (2603:10a6:150:2c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:47 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v8 01/15] spi: airoha: return an error for continuous mode dirmap creation cases
Date: Fri, 10 Oct 2025 22:20:24 +0300
Message-ID: <20251010192038.1592889-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB11352:EE_
X-MS-Office365-Filtering-Correlation-Id: 53eef596-fa05-4842-5e9e-08de08321dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9MnirBU5OHGsHTRE4VavCANxvVj8x1tvpYXdnUsffU5DgjAWF7/xpkRN9y+n?=
 =?us-ascii?Q?VVu9iwHl7qUG+ohBeAsUi0oPBP3Vc2nRsXmBCU2/Ky6XVt6fZfo/tAxTeMP7?=
 =?us-ascii?Q?uA4yKOlBqhr/LvbxJYJLwgrvV/EbnUhMmNZPwzMvmXd4CwONMgFkv0vg47Zv?=
 =?us-ascii?Q?OdGompqIRfpCLQNXRdFY16llfKYctmbjG4pIhRuLcka79i4mRtsX1g2LXWcD?=
 =?us-ascii?Q?dgBB8uyNdF8Wq5h5QTrhDel+xyrc4ycPQP1xJP6u/MDmRNago1dqbgWL9GmX?=
 =?us-ascii?Q?phRHILwE001Ph/CpImdGQu59o/uliZoN1N9OC84jzWaSPFH+KRniqKjwPLda?=
 =?us-ascii?Q?UOnZgs5lPFaMKirB609arVS3DibNoo6HNdF0D1bf2RFAKJiV48ZHUJOAFZjC?=
 =?us-ascii?Q?YlXwYLqkg/rEV0Il6UVMUl9RBwlyjzD3uxSBT4X02pediIW3aPWQYPrnQAF3?=
 =?us-ascii?Q?VgTVic4yPGgBjCQMp6uyN8NOaRxn4q2MLc38PUp+IwmL91tzzTP/g7VlGuHY?=
 =?us-ascii?Q?h2Wg8GDfCcLKTK6Q0xnJgcgYQtnMc0+iY6QlFFWW5kjLjskI15ZcoToiIzjl?=
 =?us-ascii?Q?SdlzCkhWxxzqltuMTCRzRfxND8XCb7xCtjq0g2kACBFeV25u3i4Qol4Tc+yr?=
 =?us-ascii?Q?kYKdciQ2Sy59RmT8/FI/287bgk7HsUpPQWAUEIvtcW+YECTci+aJLQvqcaWc?=
 =?us-ascii?Q?7eX1NQJpf5INztFuK4dNFowg7H3cvfiy67ErXqKPlxq4MEAdNgIXNr3gs2al?=
 =?us-ascii?Q?MApVYzx5aqkliWeTptLmhXxPw13pN/eFeaqh62SEEFkZWYoRWA88RE3tDERs?=
 =?us-ascii?Q?agFpUNNGtFITkoAvo69RMfr2coq/hkfFzvGRvKtJC0nPUd+IWWdRd78cZxT7?=
 =?us-ascii?Q?EVNbTYelhc7snwmBeMJkTTHTBOj3rGyh0iQyhgjJRzdxiCri1F/dfwsREJ9m?=
 =?us-ascii?Q?qwCF0xrnb76QiRY7CFhgVUeaQGllNWjip/NrPMdzOULBndZ9+7Y3KnP+vUYq?=
 =?us-ascii?Q?NHxl1AIBT7Cil/0+T7Qtiwj6UAujh6k6z+e3wnQlAe7PX+V3pwDGjKeyjppc?=
 =?us-ascii?Q?jnBQ9ltoVlCfukd4rrYiLVC/BLqTQJjciZTKyaUpqu+DcZDMmMBVXygY7BO0?=
 =?us-ascii?Q?OiC+bBDLQwY/nHDBTGezd8nPPBrLm9EcSqfoMfoUzgEi1PgjLw9GqH7WyTE0?=
 =?us-ascii?Q?EkhViuCYsx8UHj3/D8OmNVyi6LlBNZChePmL7GbI3Xi6I8QbOqKR1NIHRx38?=
 =?us-ascii?Q?uyxUHv5YDkVGUk91VZLPY0nL9VJIkqDFxtx1TYCnuJyM2tR/HCsEtf5271Bj?=
 =?us-ascii?Q?X3MWMq7hpI7hXxBAiEVJZYDniFABNZuI+NKPskoqR2Hy9ab6UG1lmIhgO1U3?=
 =?us-ascii?Q?Cl3zR/yyVwFHhEHYvdgthzjcvsUapj7huZ2KQInjb/T/fGf1V+X7tPVv5CFt?=
 =?us-ascii?Q?WutHccZU1/lJkQhrYJOOFMWR0IaPmAwIerxJSnEe3UtwskJLDbF/+vSU4+XI?=
 =?us-ascii?Q?6glDHKPWNFMBFvdRhLHHFuYVmLD3bXaJDufKnRFnWlo/Uv7bOO9gseuIbw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIrxzMwwQmshyk4oMBNakxJknqkMfeX6OcWCE+BBU/3avjKrV6GGPzJWeKRE?=
 =?us-ascii?Q?kvCq1XtfqO38ARZ4UFi/TZKy/i5NMVc5YbIAc/it5BTQw7oH9RpVf3RorQ02?=
 =?us-ascii?Q?/womvEA2YTiPoGHZrVGDYXMl08HRQ7iq6VL6UpdLlv/hiBbPscJJT38Fsdh0?=
 =?us-ascii?Q?diUwtl8673kCDSpHlZyLCBnYVAx+Gu5fksZCV7PLynBdxg1oB54czveH/MV2?=
 =?us-ascii?Q?jQer64wP3MmOfjNKS3VBHFqIyLFYOu68N+4lyg3E9qoWpafTCyKb1ioP1afL?=
 =?us-ascii?Q?FVLNst/+73l0XaQkZjLDibAVV5RDX1ju6PxgtGSf7BNvdoDyNlbUvtS+NjPO?=
 =?us-ascii?Q?j8unjp1Ma+6jF4OTma2FIwQrU/jAR+P+jghry0Pf/OitjIrCRZ8pmCqBGDdK?=
 =?us-ascii?Q?YuyVIr2mZ2FQS4ZA8DxH8N3/uNr1kXbLiJI7ERRBvIRhCebpqgFuOldq03o/?=
 =?us-ascii?Q?U2k3hM59tyNuGzLOMjQIcVWgikgk+9NIL/FKWMg/MFk2LhY4QjX1qF1rgZcc?=
 =?us-ascii?Q?SSmcrJxnUZk159HiVH+DryZFfOCjyLlmcLJRVofwSd2TMwt9x7UwlkoI2nYW?=
 =?us-ascii?Q?qIEFeGPSTvKIBzYaLcJYs2QltFxLz6k5XFruMVy3RD7XDL6c1e0kho8lhud3?=
 =?us-ascii?Q?MuWgOnnILkPo68OAxWhafu30nlAL4eQ9KQTSPa6w5iTS3wuAqEVCW1AuH5dZ?=
 =?us-ascii?Q?8Rh4uCahJ32TTxtkxeUrMw+nbSAs2IN59wcCkk7/qza5TBYA+Mqhd2dQ5wRr?=
 =?us-ascii?Q?2c9MP+jnCBsCBusm5YpwgxEaPTeZpEq8T1xY5oEVXg1bWxQAoYcEyMKaRfWY?=
 =?us-ascii?Q?kh3rvizXrUy3OtiFlRjpfAi2/f+8lvRLDutxkDvo7BDwGKBl2MgHOT8rBNjY?=
 =?us-ascii?Q?N3JqXs3D6j1F9Lj/6MqDnVXQzxNhbkLEaNV4zCO/fvrUkedBzg2gQrCxB97v?=
 =?us-ascii?Q?rn8C29PMfDInLCMiAHoT7aKdkH/De0uAXfFcIO/XkOm9aTyRcNj3M4VZoQAN?=
 =?us-ascii?Q?wZMn0EzmA1aAmrFkNNLsWglR7TWBK1QVd27R9hfg+ViEyg9ElshMe1ZHEKBD?=
 =?us-ascii?Q?6b4+Bw8TYkhZCJ4rpCSc8Q8kfU3ED7TAp8+0SYGkg3W/snJWVU6UkPf6MSXc?=
 =?us-ascii?Q?lKkyNwa90s11P5eSkSYsmrXYublP28WnXtkbcS55V2yUKZ3+QrgaBRzjcole?=
 =?us-ascii?Q?e/8S09E47roAxwyZiCbDMBzYBQr4hfCdAiX453swAFhxVjOosowNpGleDmL7?=
 =?us-ascii?Q?2WZUtcBd2x+JHYk8eYYZ+NmFsF2o5gDeZZQZUrl3bwkPWZv6lLg6MMEXJzIN?=
 =?us-ascii?Q?Hb5fJWs4rkcmkOLHsiYDteJGxiGBpNNQZMqbV3zPTgPZoDWmHd8o2MYYXPV6?=
 =?us-ascii?Q?QGXEJPqcF8Y6G/TNzbvYRVuptbNrRcq2AUcxFAsLu8GU2PSfoMu5bDcKShgw?=
 =?us-ascii?Q?0Gjhpzbm/5k2PEmh+7uoBBeEJphf/eyC4BjCk3tf3GVWX3hYG85QfF++i1mb?=
 =?us-ascii?Q?pbfwm20EzBaAp4Sz/nJUAqCy+K5k2JpMlIUk8jzpQEDJ2Ylcb1ARIYznYpFP?=
 =?us-ascii?Q?fYEuL+tePO47tG8iZRgZ5QfnS82mWin/tT/A6+WYujWKAcVWnGb5/DsgJdU7?=
 =?us-ascii?Q?WATu3pG8IncqSz6A12OW/fY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 53eef596-fa05-4842-5e9e-08de08321dd7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:47.7045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A67gS2SUbkBAnicFW/nE2fU5EtupYc76Z9sh6Z9PYZ6K3Mz+n9asdd9XI7LKqcjR5UGUpDr+rIRS28GxGMG7pGUyQy///1LplorwC0dpDv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11352

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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



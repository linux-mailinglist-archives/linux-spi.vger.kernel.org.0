Return-Path: <linux-spi+bounces-10541-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FFFBCE5C9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6689C543988
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B87302171;
	Fri, 10 Oct 2025 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="JnfUB5Ce"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C1302140;
	Fri, 10 Oct 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124066; cv=fail; b=esjyYAk0K1NDDGgn+O1jLEdnoDzC9mPIz0Wvm4DrMVvi/LgtmrCy2qWs15cAQKKbLIGDEXJcqCjXgSvajtiVMeTBVOpNaB088HsG33JYFBn8+LN8SlbaVbmPZbKO+nSxzlV6DiR3J9Lw8Suy2WY20G7jmHeXYtulwgtWhKStyxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124066; c=relaxed/simple;
	bh=yls5E1AQJW8UjaQIdkFn4PFMkKchlzz5HVhY0hyRl2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Np8HxAD6+9uyEsXrYeAS0WI35tNVh00i609LFQu7J0oa66fJapB91Z95eXoC1u6Qi0z2BuNFXWxfJE3miE1Gr9thvP34vNygDlzg0x0V/byQwOGfw6HWMPZwv0nc/ESWOJ+BkKpFQEDL1anf21bYL4eczzuk/py62hosATwR/0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=JnfUB5Ce; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pod46BRAhL5DdW8IhX6JJgMGQtd/L0borWsuMlS5B8t5LzIftUe4TwW7YihXNV7jecWmdDP/UMhUrSOa6R01ZEyVjsVCizY+0iOf+8hvSR/PrLzdqXVA88JWSxDfRQu08//Bbp6M9JTQyNtHRTIDK+/N76xfDLNPtHTfvln8eh3ievSaJYcxbUySwgeRx0dN9b5Jzeu6us0w4y4JV6+OZHZpx8WxyvM8LcMYZZQP/J4oB6BgY1BFu0LvOV7QQ1m1bAUP1wZWi1iNf4uW4/gARYq1gGroHWs44RHk2J4/MSTKvXPrkIs2tZQFXWSG0lO+5CXg41Ii7NNp26lrsktVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=MNxXziInc4FqLUacordSPio/ioPkQ20Ay1RJKPs/plbd/iBsPWpl7pCZvfX/CoWh7j19DgkV+2FG9x+GxK4bK2bZNd6QlvAwTEGXIsVrIpI7BA3NDw57KihUw5PIf/mqcFf/TD9m3BL7exRvMF7YAMJ+W2kM+kwHV0fBn4g+1s0i2dMP8zrwx+pkv0Pl/sVhYnCJ69WrxsJNvYyIR6VYorC/j0q9+ymvjJtnGIZM5C2S7aJk/lAPNqUgRL+xusKznZSw4M/bCeyjGgTYf1dxBuIXHcKwDsLUH7cQScH6Fl6nqqFhZ0Rae65OAzaFCEmh/tbzlSprQB8WqHiahneTlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFKNDFk6oF+S+8lmQu7ZvbBpT1DDV81X0kaPUpu4tAg=;
 b=JnfUB5CeWs7oKcL3AzAIvu+27DBwsV+IvwyInnO08b8i697ZjxYsWIJJZzFm/Eh4PA2HXnE5E82KG06TvOxN1a3Dh8EpX2Oxvf7hps8dNolj1t+TkqfRk4XUZ28Pzgpvpc56uY9krWQCZiyKLe07gdTkUO6acOu7KLe2yGVSmStAPe6+73XJzFr6UB0ntEUcnPjhk5PGOHl+8U6SgXxCt1pjzb63GBPR2Fc7TbqejuVw7qE8PCCdaiTIl6DGLiCndi81NgTcqgTA2PLuuTQL4QIufNt72Gg3WORlwLTt+2R5VveiRbHaLpXZK+aBBmzNL7B4kzAIByxTxld4ITJZPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:57 +0000
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
Subject: [PATCH v8 08/15] spi: airoha: support of dualio/quadio flash reading commands
Date: Fri, 10 Oct 2025 22:20:31 +0300
Message-ID: <20251010192038.1592889-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 28281924-9cef-4768-428d-08de083223e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wOhzxPun3nz1WNRAuA9X25qlzhX1O6mKU/PeC5BP01MIrPZhk2YGM1q7rqm9?=
 =?us-ascii?Q?uxGBpUXSJqasUQiIxeQnC5ENseqK2J0cQ61tOeCsRVF9n2k7yPbr+9G8ixip?=
 =?us-ascii?Q?l2Ix5IBrFJD81/rKlr5A3UU8zNMtBJtrl1AhufP0NNb7W5Uz1gi6PLGAP+ec?=
 =?us-ascii?Q?Q1wwcHuNe4OAg0DSOAB/DnKus2CIjn5AK02BTNl8e6h2QaOslFboKgs/Gbwx?=
 =?us-ascii?Q?WkIIYjuDoWDDzDDjVYO3Sk8QAqBmBd/BVKxNkF9H4USyQoKk47Xq5/uCCb7D?=
 =?us-ascii?Q?+5nzATZ481d2oMpW3H1h9ncu8ftDcQm7GtTHHnLc/cvDYbZTSPP0PoEuHykC?=
 =?us-ascii?Q?OWKSDi+G8clkWmCRJkFvHGtvepJGnzunSl71D2ri0MihXgkK4uFCcl2Q7lH9?=
 =?us-ascii?Q?d6EUUS8muPcpLmD8UBkp2QjmKBT0kf7C70piNfVuw2gQqcSPW0AKSrSAlcRf?=
 =?us-ascii?Q?w5AHVXXmOTS9TtfXpSMFwL0Z7S9qiCICoCPj8wfdJtTltnG7Zf45zIMDJFgF?=
 =?us-ascii?Q?y1x+fcHFpuKqaNUzqvryH3pKHatCymN2Oiuw/qDIlIoKdpH4yrM55tCBN8AN?=
 =?us-ascii?Q?/wg0L0ok8hbKjDKGLO6LQ/hW/NStkZ4XYggYAi1wSHoTDDiDf0IvTjwK7k4I?=
 =?us-ascii?Q?84X9aC1lGSNFE2hBrBRD8j+KRC/mhd/Sr8BdrmFds/zIpUbBjUBBWlxUWxx4?=
 =?us-ascii?Q?QIVyq935sx9FMg2OonMCoX1t1QpjAS72dWhqGb4CJN53E0ObBmavEQnLDYtJ?=
 =?us-ascii?Q?hizYlde6J5AW9WPyZodE1fFu1WFOmqc+QWKGzjCTE3HpxlgceaH7h5TQcrlt?=
 =?us-ascii?Q?uEb9LUFbypLgv2wPhWxdEGzr2w6ffAZa3ygTPVMQlxjaqgcKs5p3S1/4Jsij?=
 =?us-ascii?Q?/Yh6XqB/XpZbnTt8uYnQJmZMznor4tbYk0kTf6zsk+QqS3Z4+z9UJoIfhKTG?=
 =?us-ascii?Q?imtzTAXsi/y3EEPPdm1/xJGM4gnyDiVctfzGKGuuaoMeDHSyWhbYm7cyDR5f?=
 =?us-ascii?Q?gKSDrsIc/XOzoS7PBL4mqdzOC2446neIQ4MATJWiraAefpiee4pcv5ktT+jV?=
 =?us-ascii?Q?05WMsbXJG0gVzlJA05tHbjOKXU+b4XWk7PLO6nUqhcXX8kxMSDI+L/xjukmR?=
 =?us-ascii?Q?IblpflayFH+kd9IWjxPqYycG6ifnFP4rWWh/3pAqtDJQvUHhG29NVbUIP/xR?=
 =?us-ascii?Q?BL63pyqHkeJ7h5juEWi2D6Uh0U+RLF7nNQZzwkEbQ01zdcKUIi/RSWlmV9wQ?=
 =?us-ascii?Q?yuGX7BTE+vmXIswTJqoSH3Rm8UVvjlZHO3Ffos86p6ECjs+/MTIuYb/Zk+F4?=
 =?us-ascii?Q?+4txEGr/UCRWqjB28dfQ9VxND3dUeaNfEOcFzZhsyKYog0c5iv+5e29aPznM?=
 =?us-ascii?Q?bHoIm1zOeExWjih5T0FOs9w87xRqUjgtxHPbB8bDSo1Hp9yq15udt6pCjMPF?=
 =?us-ascii?Q?iRix9BilMpxumT3rsUitDBmkYLtPcaMOx1c+liCIMqkcl+JzNkxhrMG+z8bA?=
 =?us-ascii?Q?BwOmyqqjD+EzOGPaRymp7gzKjxThE0J3AHFzghQp174fgdu439r/TnRyBg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3vh8MXHOyIR9zpwLNrtj02vCBW0zZ+9+kpjvTEHnVRoz8AZM9qQllp4NtYXS?=
 =?us-ascii?Q?XPTqY4QeiDIG6Vvtpn5SG+zKHOkCFCOum3QVQpMhB3b+jNS3Qr8ubxIrfENu?=
 =?us-ascii?Q?L25mliQ5kvtTrPwJt347IGlJiDHHyPEOWh/TY+Md4n0taDvPTrDCSjNRMIZU?=
 =?us-ascii?Q?7261KJWzRQRrujoFwHtwYaK2DWrqXLuxOb1K8KCRa5qt4ug0PyghaijBYrjh?=
 =?us-ascii?Q?/NnQk2dFDeIyRQXWaGcvo1kSY7yZWWBI+zb1DukeoKa6UwcKB56vK1/cVFkD?=
 =?us-ascii?Q?vwDmMr3TktUuOz6G2W1AtSJLg2YjBJyBbMt/2Dj4AsIsMkCe6UyEI44bfxQ8?=
 =?us-ascii?Q?M40JXat5WkT3YFaaEeQvscMVWwdDKDkp0Le1FMApf95zY6wWAeFff3D2ZGGw?=
 =?us-ascii?Q?JL9JSHqmogyg+aK+caaiIgJN7LTYoeueHKWE5VTulMHyr01lgHh0Z0Fm8y6+?=
 =?us-ascii?Q?VMqbK1Zd6OTm5e+XxWapm/m57RkO11f7THf+vIZ2dDXwQ7yea/wvkP5/ub3V?=
 =?us-ascii?Q?+N/NyU4hYWMrR5lwuYE4ZqSUwbni1EtjJfUd9rY4gPTI5PKTvBvy0mJqV5i0?=
 =?us-ascii?Q?dlHXAeq1+YlqZKVTzdbvv+dqYyiWgRSmf8dzO7hD+QkXmHfURt7ydXJh1RrW?=
 =?us-ascii?Q?kKgCA5sogssSDpAA1FZwPEsNv05oXb4uKZbV+KroAs3/P6j5XlwseOfqJ6Ve?=
 =?us-ascii?Q?/+qLer9q5h8srnDoaGAiduv2N8fGqvetQdw2NibTfOSs843dONhRETRaeE6D?=
 =?us-ascii?Q?kTSx9J0NJ6dpgttninyl24hQyduq8EH553Gk3ichAQ+HUwlHDtQGzXr/KS+D?=
 =?us-ascii?Q?vqJQxS3Ol5xaIA7eaDwPoxQIwzL4miYiF0PeEw7jyLTMRIo8qkh+DQxVtbi4?=
 =?us-ascii?Q?2DOg1Y8R/6i8t4ZSfvW3PHx967QCUyOYB7vLeNtiba3js368La88GjiVDw11?=
 =?us-ascii?Q?9he2H4QYVuFJugKLLZgqKIF0JsoqXj5gbMLr5wa2OnnxOTyqQ4EqDX+VKdbg?=
 =?us-ascii?Q?osX1PKoe2hmBRRhZwV0kHDbKOp0UtccEHWwKAxu8uAPD1YxO3lnMVuzpQ24T?=
 =?us-ascii?Q?7lx2/XkZcIfpcGQtCIQ+RilNjTWB3OhDzsbsNRn/FcL68der8UWN6Bl0lIe2?=
 =?us-ascii?Q?Rx6AHsQ/T/WeIaCkh4bUh+j2Pf0YJ/dVaQX+adpjLa2CR4vvCgS64jROYWSy?=
 =?us-ascii?Q?i2kIpdhGP8tVHGyKFKIk8/RIk/GFlgo/1Rwh8n8UQU9Ilv56YGX0609mM3li?=
 =?us-ascii?Q?t9weTka+t+eH91SkeztKhRBVteh6p6gxtCJn3Sc5VcNCOMsAxiQ27FhhDBYX?=
 =?us-ascii?Q?P8xQynLZZ7s/MXXQjAXR/2ORDmiYYGs9AAG64dXQskACbDtXsS2KE5Xs/QIn?=
 =?us-ascii?Q?qa463w9ap3t/X/dba2mI9B3l+v0UcdbMZ29A5G27Er80qC2H0e97dJ025MT4?=
 =?us-ascii?Q?GICExPUw0HIODcp9YEVykS3AhHo6NKRfsi7N+XzxUJUOCCNMbvYVrpuGgjZl?=
 =?us-ascii?Q?7Joquw6aGNMCrKlBScWPv6n0942TR1nClfcb0zhpd7MmDt8feW12Sg8P01lb?=
 =?us-ascii?Q?aQx10QMKfRfg0ElZ+/DRL6/MWHoG2Nbwef+UNkev6I/XM4r/z4kiNtC5JcAx?=
 =?us-ascii?Q?yHN11Me34DEuTVdlFFY4ey8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 28281924-9cef-4768-428d-08de083223e8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:57.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXbvX29ew6SyarEziInrp15CcDzx+tsAgI1aJ6i3YVYbYW04/gYU7danppuMcFLPTHQuR5ALzBv/qNUfstve7AhVlAJkQ0z6RgD58toNbXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.51.0



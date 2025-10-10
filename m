Return-Path: <linux-spi+bounces-10517-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71597BCB8D4
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017A84238DB
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA228C01E;
	Fri, 10 Oct 2025 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="zhFXeYC7"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023102.outbound.protection.outlook.com [52.101.83.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377632848A6;
	Fri, 10 Oct 2025 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067141; cv=fail; b=NLGD3cdupWNlFVGX5mzzm/y4JmdJ41KAmPX3kLvB7oiGmS+KjVKKrATV7TflWES9ZMM6K4awo4E2ENgb12CRpokEJdYG8l8PKS9qKUgs6m8U8rOHh7rjAtiQ1jI6sonQBB5BHZCeRlhrYCJ57AOU3JDRVJ4XXvUbv7El8f0oJBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067141; c=relaxed/simple;
	bh=37r6SC0DPIXD2kIUrJV6zX3kiv9WRPAubGka+xFgz44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RzGchDqlIx3It+oWt8DVwTYjLIXHiBAxpNlC36waTu4Z/NIVIuEtkfYKHmS+7qWtj1z8GkF2EPruiZjfUGlsnFh01rM173UjeEpOcz1luSy/z3gJdHaGi7ZoQxZrDEP4I6MC5zlMpECbe2FQxKu0JymQRGozhHJ0p4tShFGq7Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=zhFXeYC7; arc=fail smtp.client-ip=52.101.83.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwyr31KkS24zUTSq7JYop3apUzQ8Kdxm2p+B6T6ZZuowN+45PtcHbRKqmDKl/7rz1s37MLosXjq049UWuo48QQSlMq0oznOvF9zGNWDS5x2/IyIUcnWfa2ENpEUEn5qf8dzx8WzTCSJG+uOwXes2pMK32IdHju0jIhU2E60L56BlqjYQIbU6LpAMNidyEqI+3UnTvA+KmX9rKDkSkff1IOV9BxhHOgn5iBK+UcLlCPrfGttVvdInDvVNGUmVZ2rgZW2HUaFccJOJw6WtVKIN1PjlTehjDhmy2Gw1gy8gYjSu2BnOCVMzwMuPyFqtXR3yvhskuj0JnopjLtvlEAoJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1r4KRq1qXcMpxXAYf0Qx5IGJIVG64xEbKQ9nNqIQqI=;
 b=GFuCgRU+F0WFY2dlcJ+3R323D4VFvbjd3mIK2DrO35iN9Rcu8LZNln/WodYo2cO1Z0BkghAsrTrEl8RI6cvcMpbt4GpnFW4NKMvP16iz9GQa3ADptMSUIkpskSzQODcy4h1UF9Csdq/vRtI5yb/mHVmJVd/xAoSRUDc02uLYw9nKn/PXmPLUuPLmu/n7GZd9Ex62iiSv6PFffrRC8q7uBeTe1dKnkP1WPXIbmv7q+L6jwReF/y7SLhSJrKcZWnQe5Ejnl5kMSXbxnZZknK8KN6CWCOXAtqB8MebQ57Aoz3X3iUAnvKxm5s7kLnk7gFPlGPdrWWP8QaPaIpZpMHx28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1r4KRq1qXcMpxXAYf0Qx5IGJIVG64xEbKQ9nNqIQqI=;
 b=zhFXeYC7Umweu2P3ozFTNyqwvPot4vRNZwgTX/vW6PGP8eCvj+AqnIYBHUwqzWQCHhGvimDgaOY8n4/fAbMs78ZrzkBzmacbX3IU/jT4s8U/BF9FCvuEDsKDQgPg9V8hfOIknLjkB+TudpegnyPt2ChseNCqkzZTL6pnIOsMlm1pisfaEoGS3ipW8T+fmk2ZeZQ1GQGOWlxbhCe4yOvbRz8N9Kc+zeX/pOBiBY3XbCp3Tz0vBgCCIkrvYAFjvg6vbCMOL76DkrgslD2F+rrlVTJH7inCAuKBy0Et6dXSmuWv5OW57ntjjHmlZrFYDc3yHOoZIbd+mldmqOsOFdxQQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:32:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:32:12 +0000
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
Subject: [PATCH v7 17/17] arm: dts: airoha: en7523: add SNAND node
Date: Fri, 10 Oct 2025 06:31:36 +0300
Message-ID: <20251010033136.1475673-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: d032f9db-037f-4673-f361-08de07ad9971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BssNPYt2/+HNqUjJ7lXLDnkU1oU/0rStF2TgPThGAVM0abHIZRXVx876F8+c?=
 =?us-ascii?Q?PqCsVZR+96b+ESYnj5y6NtqYjGJg8+uR3Zz7DQTL/x6ysVizZeHVB4tdrdy/?=
 =?us-ascii?Q?Q5zWZBRxFzRVrkEXtotSezdlLvs8BadwqSini5WMNSSQTRKIds+wjSs5vxyV?=
 =?us-ascii?Q?b7a8swm4zChbQplMCf/viDPIBU3QrUH7BR+W8Dosu5VW85oCOdMYo8wHN5nL?=
 =?us-ascii?Q?7mz07k0FhakO2u1tgOhTSK7CxtkCJlEASOkay9o9t5a56pvkrq8k/a/Xerqw?=
 =?us-ascii?Q?cSFlq0ItlmcbUmHXZbG9LeCoUwOZGcU6M8UEyiVd+pfzZ733MtKCf5+KBPng?=
 =?us-ascii?Q?fWQaDQrUbv/ZhexY3YJWjqTYB7Yq+8k2PTUXt8z1qyQMiRruUnJ8uMwdcmOQ?=
 =?us-ascii?Q?H5FYNfBFDMD7nLVR0sVA1CjSTsV7VljOit6xzpQgTYsYBqMOWVMhVnewZQzd?=
 =?us-ascii?Q?pZC3VAgzNzn33bGRe/uSUf9Ypcu3VqmgzK/xUf7uR610vAwpEfma96+znrHf?=
 =?us-ascii?Q?FpqPGS5ILmhrP7P2EDJujHeXyAosvoFpSsVt7orn4HDbW/uqAqE3j7JfvMCD?=
 =?us-ascii?Q?prCf2CGldi3q76IoDfUtEU5HWXPcuOdELMR84D1ycO+FRshSzr0fI65TpwZr?=
 =?us-ascii?Q?/Tb90blA2FL2JTevTDoP4XChRXBhpE3CE7EnfNFtZHq1w6RNWcMOJqVs2brw?=
 =?us-ascii?Q?ttopBQe8FxDv7nFbUD929GyRoS4GcGP4oUxuTTsSMQh2Y/qHe6cwlJncNo2j?=
 =?us-ascii?Q?K5unK58nfrjE0V8NwWmgauWsKbVT+OrEzvr9AsgJhJ55uV1OviHJvZS7R7bz?=
 =?us-ascii?Q?98NioM7T81G3muaWW4gdtAWjaSUlcDggNFbWU4PnoIugBrnqekBIS9wCNXCU?=
 =?us-ascii?Q?Rw06Grz22MI1UTw02R0kkBwVxp90BarTRFG4gikNtId5z09BN+VegCBtIQAd?=
 =?us-ascii?Q?/YYg1d5TeC6XrweiMxC4mLXKgZ9xpWb/1VZTWja0JBGmxpobZjCTbvyQ25GZ?=
 =?us-ascii?Q?me5HkJjKi6yPVvnI+/ZuaZdpy0KUxrBpTF2jxRJbSaK/iMOQmjhWtLEdigTK?=
 =?us-ascii?Q?AIIsLHWXAOXwV4IPofmnEaAQr0dbx9cFuN5WzciXgyFXDk1CaYD1XYUiFb8l?=
 =?us-ascii?Q?97iUis+ZDFFVUGs9GlRDnH694a7bqr9dAW/8f1hk4Y9zh4/tzD2UU+pLXtYo?=
 =?us-ascii?Q?wPOaeqfE9ox6T+C8zYhJplo8zVcXkonpBCCjML3bg6uWmYkMzulmg6vvm7xm?=
 =?us-ascii?Q?UZo58n060rz9l/xjkTuECUhMVl6vkNhjwu3lOgybzXuAsJd9A5htRWP6bG/c?=
 =?us-ascii?Q?BXzDSFx/8LM2flVfTdLQICK++rbhLZuYjMLks1fMDrGvHhEfDSEXuiIXwvnE?=
 =?us-ascii?Q?6ONO20kGg/hJn+Z2ZlLPi4+HjdDsqEVExIo1cc6JQ65qrQU0tjFWOvoBOain?=
 =?us-ascii?Q?QfQyusdpBJTIc9b7XeByl/rpP9n++yGEov3TOiiVPrSTXUaXo4uAmDHhqSAj?=
 =?us-ascii?Q?SOrozYwsUuRnQoC4WbFlwiDUs5xMVQFqsGBivNENhQrnnyX/UbWNR9lX/A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BFGx2o1m6kEZFD2o79zjOsLUUjpI7JaOk4tQf2HbNkHnHyUYBa8OEN9FH1iz?=
 =?us-ascii?Q?r3b4Fyb0IAof9ggIxIhPft1NQkfVlY+nh/3o5yaeZbylrmBjp6yY2V0M5zFB?=
 =?us-ascii?Q?/PC+3CPXbP7CRodKUsie5ZwD5hbOiJT3bRTlz+cX+mfceLzsPjBPT8XKCU55?=
 =?us-ascii?Q?uNNntY+sbKZnpVO0b1ulkuq8/uRQaAdP4M/A1hDRTHgnb8l9LRmg2iBv0KPo?=
 =?us-ascii?Q?q7oFuzvV2nx0rwuPV6r6DwN/dZzzqSz9+Jg2W8fROjdihndS9uCZFjBU5Xtf?=
 =?us-ascii?Q?M1lq3A0DCVIoX6Fz5GwcorRa8mrVKBALl35nITozYdpt4Ec3qkzY3tyy7LKm?=
 =?us-ascii?Q?CIDGLMEYCU2vU5bkwc3eDt7qbiiJWjsfix4GLVShay+EXBaHl1gfRER61cQo?=
 =?us-ascii?Q?AcBRSw75goDYlqyCCATvH/c1Badlw4l3BYbFjmwMfm/Y78ZhWFLdOwDmumRa?=
 =?us-ascii?Q?ZTIOqqmNJaWti1DEJp9TasOl0l9XVTSdW7V143VKirOxEdlpRWztWplsBG8U?=
 =?us-ascii?Q?TxqYgPbw4vOg1rHr/9n4/6MpOn0m20rprt75VdKvguSDmbAjCJVF79JkYlZp?=
 =?us-ascii?Q?4C2g4i535f4cMDb8oWCashEX+dDp44FLUEkPi6jzjvPi8Oy/tDlTaMu4piL6?=
 =?us-ascii?Q?qpB8NYThnqI8Tknk7wfSPA58BdCR7bOWDHAscix7IxQWX6l/K4RCn9pWxKqu?=
 =?us-ascii?Q?G4JwdbY5lLy/7BhuwWs5QsvTpTxmjRoubAnQPH1SD2nUNrCvjigOxyE9k+Dj?=
 =?us-ascii?Q?ufFnLK56XyczCOoWV67vISJr+kuNIGpQt55w3Y0UvvHEqi2bG9rVnv492XrN?=
 =?us-ascii?Q?SRFbxmSH/L7OjMJvda6bWl0OZjezhiNnbC1kS/2NXBGPkHlRt1rPBZ6ppzab?=
 =?us-ascii?Q?ib/HeGUkRAdfDNWI3pJhbLRb7PVg24a7iiTsvCQ+8+8mPoR8Dlu9mW780Fg1?=
 =?us-ascii?Q?MPbk4NHogGgjM1uAg8kYgmavXmTNBiVHUOxLj2ZIUZHB7tguIA4nS00b78YU?=
 =?us-ascii?Q?hxU6xVso1KhJqDl7i9MkZE6AXiXCfc1WFLOocdStTUMtNx4EtKweHK+F9Jj2?=
 =?us-ascii?Q?G73VhFYqokzELvrm33x5fYLk02yhmsC6D5aqe40H5c1/5fnGtBscW512ZaMn?=
 =?us-ascii?Q?Mr6zS7kzODYsgsrtE0ywxs7pqAVdsMKrJb30L9HdClU7hDGxE7MHFp7kvNUZ?=
 =?us-ascii?Q?iG21Oz3NR+RHj+ZpJZ1ad6lZvlrhj4EzVIzg4uDLZWexaGGS4AqcMAjZgICf?=
 =?us-ascii?Q?sete+zLt1fgwVbygF9AII6bAkKXg/Xf3h3X0GgXL6ToSEOsE7tA8wT4Jg8C5?=
 =?us-ascii?Q?KBeHKvMFfnnqEsy5YZYOXumKTH6Vty5oweorUiTIUk/io0AGTZ8QUgRIQMXh?=
 =?us-ascii?Q?MosVQOgEITSK3S9b75vdaML/25VeE97/rwoJtE8muHoo/c5lPM8TrrUtiHHY?=
 =?us-ascii?Q?YlJKejQ+DkSSNpFMtDE3q7JtR/ndUadsKAndz60BSd52SQ1/R+iT/K6YJ5CO?=
 =?us-ascii?Q?BDy0y5inx2V4UjRPqz5seEw5+cdeTUrBUeljOOeFpWHRHfz1FzdmQkoW+0Fi?=
 =?us-ascii?Q?iyWoqbctsltuXAjayaA4QM16LMhfGfJWICOGzjmUTsamjLlqKGaUj4VB7GeI?=
 =?us-ascii?Q?LW6/8pO1tUQZ5fZ0FhwPsyo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d032f9db-037f-4673-f361-08de07ad9971
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:32:12.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAjje9FWtCnk1p9NZ898yn2JMg7uRaP8tAAApN6TsXQLLuib671C8AO0X0A50xMUXkKOJ2FN4+rKyFGG5XLKuG8TTqQsu1f/5JD4cNqSKcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

Add SNAND node to enable support of attached SPI-NAND on the EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..46e7edc11d6f 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -203,4 +203,25 @@ pcie_intc1: interrupt-controller {
 			#interrupt-cells = <1>;
 		};
 	};
+
+	spi_ctrl: spi_controller@1fa10000 {
+		compatible = "airoha,en7523-snand";
+		reg = <0x1fa10000 0x140>,
+		      <0x1fa11000 0x160>;
+
+		clocks = <&scu EN7523_CLK_SPI>;
+		clock-names = "spi";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nand: nand@0 {
+			compatible = "spi-nand";
+			reg = <0>;
+			spi-max-frequency = <50000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <2>;
+		};
+	};
+
 };
-- 
2.51.0



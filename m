Return-Path: <linux-spi+bounces-7545-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C91BA850E8
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8086464BAC
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8340126FA4F;
	Fri, 11 Apr 2025 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TvUZnkbo"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2DA94F;
	Fri, 11 Apr 2025 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333446; cv=fail; b=Cdw0KnIWJMeKQ/2k50wbmy9pM9RWDUs1X20Y43m/w45yl6eTVWHUW4ewZrZKS6yefY+6P8SI/b1w5WaxTRhw7gRTjjQ70OcQajXuarmWsf9mZMZYU61J3vwT4d1GEuO7YU1ExHlC3YycfSwO/NjtDkcWHqQAZnS8lmZYDRkrVFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333446; c=relaxed/simple;
	bh=SOFobm56Cvo9O+fPsupaMweri68gmY2Fnv1f4i5tYpc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cb9PfV6szrLJckfIElPL4JmeAkFEGPhFu9z1asAzHIsetygx8Qp7QWt8e6v2nZMYcynrrFLnKLA4NGtQYMEl42OrnF74MbQzIvxXFYlbL006mwbWMeunA5gXXLkWU3oHyy6iYNKB7uwFruoIC3KqYcXsBuaS/ehaVhPD+8wX+6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TvUZnkbo; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ5dOQ6JLBJj4mLK/3vYck+NSekst/MxhUJoZf8QnR57FBOvN5CIVeuxWMd6JEK0MzsSULM3YCe6/ogPKKz2S73VNG+Jo4CTeFlOC4PaDV91qMp+VxeIVB9QbpqfGeNQQzK6GB8/JSUoU7cdbKjAvb1CHw70XRZU3mhv6M8CVDGLXMUOUvTiq8PgttD48d9XIe6rdDGezX/5rPPEhBwRhtXjC90OcETB9t6zKjscem/zn+MNUKC+c1XyO4EMCAVsznuHW0EVPaIsHKi/rdqzOM7bp2wuKG5+cONPYW+P5nhzMvU3hnC8nDwo25y5usd3UTF0QpK9bbzl6qkAHblB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATQRfMgNPZefPwyniI+aWhOYpjOeFi8eCA0KdcFn7LU=;
 b=qA0krwRSDigZ+Nm5LruIZSz5alwLvBLGpSS5hfVOMSvgEcWaRo+Y0KM0tnjLhzNqHjr4yhPdlTf1jEffC39Q6+YBhEOp07/c+pznhaw/1IBMylYEliuic576QPRO7q547lT+kEc6wgCRkrxPH0MdxX5IVvKOvkh2zpWva+opsKDnhy5TTaDQ+CykapRqthQ5X5FMXgGRDyFB7cdbhczWtEjz/LuWrQbxksvZ/1xo15S3GgdS279wKAEss8a7zWB7/im5cMqYDn7wbvuUK/VuqXG2fk4udTVs/tcEcxtbkxBrdv9+qM7M8SuWHWnkAOnUF+BUXyRevHUW2YKZaeI6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATQRfMgNPZefPwyniI+aWhOYpjOeFi8eCA0KdcFn7LU=;
 b=TvUZnkboMmBfzwt8rvubVCMKnEWiqjDQmxaYnDu7Ubr6bOkCeGg00DZc7vbtFkwFWLWou6Y6fiwyhY5Z/Z/232RL86WSkakOuTvZx525uSXyaKCCtONqTBR/M/QXRuefez+LlM40nJljo32svb76w4JJcn/jOBgzhAxx4MKw5Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:58 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:58 +0000
Message-ID: <877c3rh5kx.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 7/9] arm64: dts: renesas: r8a779g0: tidyup MSIOF node name
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 11 Apr 2025 01:03:58 +0000
X-ClientProxiedBy: TYCP301CA0069.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: c81fc3ea-829b-4235-6c04-08dd7894bd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V5GYl4SQbOIQjl51OFxeprJ/e/XEYIc0zqHxf01ffyYC6kjzzJLJx646z/Wb?=
 =?us-ascii?Q?sxTBF6wF7a9XqUSkLSF4xWwDe9dF9C9C8ZqAqVJlKnb1yWSw9xpvS4df7xQF?=
 =?us-ascii?Q?1Zkan3pB/D8+ubUSN+voNa8lr+12tB7Z7lYSwdVM58S6xDJTGZwXbESW+YxT?=
 =?us-ascii?Q?KNgY3VJQzDx+O4yZW4BUNnRlpN4/VHBBxnzGH06vZhGsJZ49GGd9Ie/WZNj1?=
 =?us-ascii?Q?mTZCRJiLs9ygaG4PVe6EAABD1Xgp1PEouU7T1aX70N0VUT7uMx1nZZmWcL/b?=
 =?us-ascii?Q?/H1cfqgLGYld8f3vxQC7lavzygKlbUYWDpX3Svemdz/dya5J6CD3nDxeli/1?=
 =?us-ascii?Q?DvV6/63Bl3ktiqsQoaipXFEU1/CAsAwoZcShPU+ku8TgoiclW8cyWisvgbm6?=
 =?us-ascii?Q?Kn9DnUkwKtFlYHjgBraSozZivqRyInVD+l1qiO3mSnUvCK/flB0rQ+k19gf0?=
 =?us-ascii?Q?PkqESrC0X18mXtlPfoBV1EKAMJAv5oBU74DI+b2cBMoiPq79wE6KfAPzJjnq?=
 =?us-ascii?Q?PbGkQltlsxZGknt8Bdf8UXzWax2stqxIaAnhnvXk8CKMNcqJC5dsz8uQ+qs1?=
 =?us-ascii?Q?2kdZ4X4P8TTT66qLolbAdngy3vW9imyGPqZAYbXGWi0y01OpkguMSONdmboe?=
 =?us-ascii?Q?S8IMVG7EcNLwbvu81DpWZ3BWtLGob60fFT3sIeojBc7kynugCiR6Jv4W1ucp?=
 =?us-ascii?Q?lE7NgHVWR2rZMLxj/u0+hTKCcGC3aQPJUirQ7lSHxTNdahexd3liatdlPvVZ?=
 =?us-ascii?Q?YVZyZ+4hkcQ+74K+l8OodIYhN+Vbdz6ISqP4wkfx/FTD+YBEa54tSbFKv69J?=
 =?us-ascii?Q?4067+IBiwyRTMlM9BV2Bbu7DkNYprCfmmKhInfGY8vgffxnV3/zG/9so8XTN?=
 =?us-ascii?Q?iWqldczyQFIkj4JeJzJ6isjhPd4UiL5pZ+ZLxi0EvOgqBazqZYIc2nTPA87O?=
 =?us-ascii?Q?TlwTgNn8YjF9Hh/q09+j5kcv05xRKw4CZ7oNGbWvLaiAXIuQ5WSYGhaSzeRr?=
 =?us-ascii?Q?n9zHd1pYD6bgqxFr6pop/Ewo4JzabKxQMwBxR7inBEeNxorBwjnY3njrkrXV?=
 =?us-ascii?Q?1VLaIiZwf9uM0uXVdzZCTiq1rPmnM712ymNR4OsRGeIkrYOR2T+1EN0kOCuP?=
 =?us-ascii?Q?b+tdpgqpqEZqZ7LHP1ZsnlDGluuHsIy3jGp4HCP8TcgzXxonXxTMtfKLH0ts?=
 =?us-ascii?Q?MdP+jWB93fIHf94dAKLpNbTWRBWz8Y2uCyylTFUSfcMZvCQCQ0226KdayInl?=
 =?us-ascii?Q?fyu1/Hqgq8b98J320ohXErTtV10REbW8P4WvaRbvMQRmdkDGQEWn+EsedBXw?=
 =?us-ascii?Q?szkPELA83MWlXGXeRzZUCrknJR3T281FZQqroqogZqT7sd67OS6jUtjOSx9n?=
 =?us-ascii?Q?2D6lpym8qfdvVYM0+SjtHeQJFHXtxD6EURO30Wmw1VI4cD8HVFexgbJz3mMl?=
 =?us-ascii?Q?JfK2wTYseER6P71AMOMMp16TQLkthEFO59sP7Z0ff5h1HwwyX/ZX+SP6kqd7?=
 =?us-ascii?Q?+BQAt1rPvVBQ67w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qh9EMLovHvUGNUScW9aLqgP1a3Pcyx5SSHd2CBedELcitXvHXP1BEHZMgcHa?=
 =?us-ascii?Q?QvPW08OP/+B4vsJ155x+l6qZEOcwUrTidZct9GtYO0v2n/cR51WnrjDiewZp?=
 =?us-ascii?Q?C9n314cCPhnUDLr0RExgzj36hoI/WG30u0RADRoHYibAyjVsMEBK+Dlya6rU?=
 =?us-ascii?Q?0Q/CRSQw7BWVUsodNlpZlEIRvxHfh5+UykinW3AP2w6nPuKHDsT9QYo1gEN4?=
 =?us-ascii?Q?znAtmrPYa6WKfgZqzL2m1TqE/Jq/K6Yjkse7z0JXT3IVPJu8YOS9jgOR0hXA?=
 =?us-ascii?Q?1iDmNo4XCDI8M/W8qCfmm1TkhfZ2+YjNr1tMzeCVWpShI2+RargjEcG4NBzG?=
 =?us-ascii?Q?CHOLK7AZ1mSBEdyKAnCXb1Ih5I3j2UbQ+xd7EOd07sshUn3hez+WegyZtst2?=
 =?us-ascii?Q?ve0lCvKyIZxzI+ezfautM2ZUjwcOaZfDNg+1lTBRZezJzVFNVrc7yXuqs2NP?=
 =?us-ascii?Q?3/TOf1eF187kWmzQ1LzGLruyZYniFvlLKo3sNvYF2k72h4ggYcKp3bc4HdJ2?=
 =?us-ascii?Q?68c+QWRBluBX2bkyuWpCfEErviPZISkfXxtdh3R5LBiXi/cyLn3Uyx1DPrCh?=
 =?us-ascii?Q?5yoAL/TvfMEQ/qaGS+pymOX1WpyInbXrMKLQ7VLJYFHS4bACSF8+N+krEoNj?=
 =?us-ascii?Q?DHFkJ/3GWPnwvxQ7l1s5aR7EsGd/G+E+sIBX7J/8bXQ9FM0E+paft1oI6PtD?=
 =?us-ascii?Q?n4nzn8rMtYtdMLHx1YQtEDfGGAQ69yHeDFG/x1Hkf9PGxnK9n+kOlnj8mGrY?=
 =?us-ascii?Q?ddUdbDJPGpnZjr6aiLuVYUjCPP70Rs8iVQU24BDqV+fIGUQM2RM7QBYzmBkz?=
 =?us-ascii?Q?P0vn/55GNwEchAjGVBW/Kmg8SOXEqL0SlE78pj1ZglZekQDSP/iNgfAzAwjT?=
 =?us-ascii?Q?chJqZxDQK50dYfLOUV3eP0M69Yjft7jjrB0thOQdOj8/vVHpbvtDM/RJYq47?=
 =?us-ascii?Q?APZLgMLsaB+MeLdZ20cskhc+eeoF2AwOIxiVaY7wTN+w32ZIyEYWmDvQZgTA?=
 =?us-ascii?Q?HdLRvOdn9die2khOHDIuZzGqk6f7dedvX7KbjzCukoGozmg64hw4Qq3l96a4?=
 =?us-ascii?Q?0NEwmSaQid0hJAFFFaSc838wy10ELdYV35NpBL68lKwhuNOlPUY1cpzrzsCM?=
 =?us-ascii?Q?xE/15WvHBzTND6yzVp7rIHem4wjk+42D+Mvp8ZSN0BdOR/rYcjgi+8BHHW02?=
 =?us-ascii?Q?A78i3Yk2I5fzayFPaUMkgI1xRvuwcoSzZqW073hYFvDsb3MrXtwyh1pMX9LZ?=
 =?us-ascii?Q?KxmH3mJqsYkpmkOg+hraO7kOQo8gRYpM9aLn84zZAbdHEC/O3SENxeOmOWs4?=
 =?us-ascii?Q?VtdrgOJrBZwLZ8c1+HZsCODnDIsDIF1Xc3/PX1MiodbFPgylWBvxUXrg6WPV?=
 =?us-ascii?Q?Qwqnh74981rPrz7gsmOeLHQIF5zdqZeFh6SpqNnKugFddUB55NzG4FTNgWSw?=
 =?us-ascii?Q?8VHtpkZiZdSjF2f0O2qbtbeE8fbH96vUjruALFD9eCvfBNby3DSizDE7qtc5?=
 =?us-ascii?Q?0/8l7LKMz1/dGMixKk9ez+NyHM1p+hrqTxVeFMZSGuPx7s9DqMaBBE91w2m/?=
 =?us-ascii?Q?tWqVAwUSjmMTHI4X02O7AqwEel8bpokrbnrzOsiJOOZDtt7/ylqrghkFiHeP?=
 =?us-ascii?Q?p6Fx9DjkUrJHh1cARs+9SBg=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81fc3ea-829b-4235-6c04-08dd7894bd8e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:58.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGVZQ/kBuMdzFb+IPvEuNLs8tQvKpke9FHCMBOEP7LfClAtYKpC6Ao0Xi5rgd1417AEbtqDbcubHiu0T3CiVhIk8d1f9907fz4cCdAKO6GAfuChxKLvMsBPBZMnJiOHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

MSIOF will be used as both SPI or I2S. The node name is not "spi".
Rename it to "serial-engine".

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 1760720b7128..0b85fa0d1f41 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -1250,7 +1250,7 @@ tpu: pwm@e6e80000 {
 			status = "disabled";
 		};
 
-		msiof0: spi@e6e90000 {
+		msiof0: serial-engine@e6e90000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6e90000 0 0x0064>;
@@ -1266,7 +1266,7 @@ msiof0: spi@e6e90000 {
 			status = "disabled";
 		};
 
-		msiof1: spi@e6ea0000 {
+		msiof1: serial-engine@e6ea0000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6ea0000 0 0x0064>;
@@ -1282,7 +1282,7 @@ msiof1: spi@e6ea0000 {
 			status = "disabled";
 		};
 
-		msiof2: spi@e6c00000 {
+		msiof2: serial-engine@e6c00000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c00000 0 0x0064>;
@@ -1298,7 +1298,7 @@ msiof2: spi@e6c00000 {
 			status = "disabled";
 		};
 
-		msiof3: spi@e6c10000 {
+		msiof3: serial-engine@e6c10000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c10000 0 0x0064>;
@@ -1314,7 +1314,7 @@ msiof3: spi@e6c10000 {
 			status = "disabled";
 		};
 
-		msiof4: spi@e6c20000 {
+		msiof4: serial-engine@e6c20000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c20000 0 0x0064>;
@@ -1330,7 +1330,7 @@ msiof4: spi@e6c20000 {
 			status = "disabled";
 		};
 
-		msiof5: spi@e6c28000 {
+		msiof5: serial-engine@e6c28000 {
 			compatible = "renesas,msiof-r8a779g0",
 				     "renesas,rcar-gen4-msiof";
 			reg = <0 0xe6c28000 0 0x0064>;
-- 
2.43.0



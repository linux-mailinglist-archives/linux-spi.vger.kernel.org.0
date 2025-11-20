Return-Path: <linux-spi+bounces-11368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C2C72307
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 05:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id CD6652A259
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 04:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530222F99A3;
	Thu, 20 Nov 2025 04:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="aSehXRUY"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023115.outbound.protection.outlook.com [40.107.162.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B692F1FC9;
	Thu, 20 Nov 2025 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612899; cv=fail; b=SCq4Qg4uEoZnfxFUQzg3GrIcR5zP6NCy/5JfTvVIWFDNe2AoSmHgsoAXHi6z9OzlyN9GeC7OWwSzp868TKRGZ9SmHdUXb9CGxUb/3eMWxppoFMXaPafUtvTZnvEvkBsxMdLfHfl6WxtnlImi/IbgYtNzQWXwMEnuR5lwOk9Lp1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612899; c=relaxed/simple;
	bh=PzAEtVC1OAN+ZsbmD15x5iHLCTZxgoR9+x01WEeARqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEXOfjntVQ29MzXm8HN2LTSxgIQBskGVp0j5a9vpZWipYnntVwSsm+5DSx3VPALoq8pc7qWTA+U1ebrltqrNtdyr8JOlsgqABOFVYMI6trhoJV71YscdqIQVvlO5VAy/Z9hJaIkzA9slk3tNJ7sa+CFwWN/2TojjZq4jpnmaojE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=aSehXRUY; arc=fail smtp.client-ip=40.107.162.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9i5otKe1V68Z9ZWPKI/eKvCljLnudDZJ5po+3ehm4nARhi5lmU+WL8tYPo+XKgYVDrvwPK5B0+ct0fsomGHlnfTPRNmxdn9pimuBU5HZA9gj+jqcJNljBkN1Xabj3e+nR6D564LfWm0PnseaUdx+P4GmEKmBhsKZrxEvR/wUPXZsv57GHJNasp4KkdiyMmtFo1Mk0omuINK1BkjDwZcrvTWCWENd3NWlT27KUYKGIxX6RtwXfgFzg6+qN+YME/arQIXCJ3qd5Igq5HCliqPZ+u4YZuDyD7HbH0VPYSmdrN3UAFoWnSwGiE0BZDHM83kxCpI41oO4fzeBHDy05wBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcjwgzJuu4GKdW6MOzMtH4k6Gjp8Fj9ec0RGvqyijPg=;
 b=R8TQL9IpJvNXGyQx/kRs3++X/SbuLfCvWYc2GYWKn83A+HyaQ6bY1BQvwxdd9Wz1E0EUKvPVvAY4UKeTv6ZUuo6lHGTQEtO+pddAwL7gbymvP7Fk8SNCEFSa66eLPZl0lb2D9FDwUEAmQ1U0v7ysWyR9LFvp4ujrV+poOx29HyY3/gtIVsHa03KXLnm2zpADz9Be+XM1HyxUKvV1Nq32Q68kOrXnlaDjrRljtBqiZf/rFrYpC1/hoz9gStzSfer4i9ZzYwiXHjoQxIvNK9p+TYETOwH6kM71Uh7Y4LiU8s2nbndTKo9965WX4TIBMIRbnE/tmsBa5d1kFWlSCKnldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcjwgzJuu4GKdW6MOzMtH4k6Gjp8Fj9ec0RGvqyijPg=;
 b=aSehXRUYc5KNmj+lkSw1guSumEyUxwe8iFSxhIYc7+fDbOzMkX3Dl9ObayJKH59Jl7+g6UxLZ/NR9fP5GsVns8MViDh7mE55Us0p9VUybRdzlRREfoRk6r1b0dNHcIHng/7TqzGm8d4B7GTsz7bUST22Ht3njZCATgD0qmsT9BpFccPeSrAf+Zgnno39n802Nk1pFmIpJBuBlZIAAZn1+O++j7de1lQLhF36srHYtiabPPlRI0huaBAJeZ9RxaDEUwEx2LEBDMR9JBUnJxmzIIWuco9JSmxE6B2ILMO+5PfvBDabVgFyI3H2beHBmpKjmw+R8xOa6d5+EFMsLrT40A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6541.eurprd08.prod.outlook.com (2603:10a6:102:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 04:28:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 04:28:05 +0000
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
Subject: [PATCH v3 3/3] arm: dts: airoha: en7523: add SNAND node
Date: Thu, 20 Nov 2025 07:27:53 +0300
Message-ID: <20251120042753.640492-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a7e4ba-f27f-4ee0-ea9b-08de27ed334a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iKwFnpIcfG4jT9WStReFZpyd/F3pfzh41JXkowJEwI0OGU/JpZt9kaC+o7JY?=
 =?us-ascii?Q?r2+bg6gRDHsPv8OPMwo7MuKmId9HONBuP7qiI6Sl5OjBBVD9o0OqxK/MF7BV?=
 =?us-ascii?Q?eeyzzX7W32kO8vnAnQWyR06I+pFo5O7ZK3X7Vtc39/Y+xJsGFfVQOxSiE1AH?=
 =?us-ascii?Q?N38MW6CRYCJrAcJRrFZAGMGLnfxtuuYBATv9aJDc+bzO9+7ijLIyO0K/pkY9?=
 =?us-ascii?Q?WEtjvhCytUc06fg6bBvAkCU4I92HJIrGcz1lX/FDc+veYFAsM4dTz14p//B9?=
 =?us-ascii?Q?WWD2QbHMO+aVQyJl6Yb6iDjZauVHpxNXManAbmQCgdYRoQDLZ8+ILTVjAypA?=
 =?us-ascii?Q?HPiPsOdNNqRVe7R30BiukSrEprd5O6LJMeb3VMc09ASwstVkenpg+mnV+n+V?=
 =?us-ascii?Q?j0ipwlBshhebi4wAL9nUvSjtNkx8oc1I1BY8sgLluYXt0OZmYd8tg9Rfwgav?=
 =?us-ascii?Q?M93/4TAuO39QRbfxbUC7La9OVV//nbu8QIDGn8r/cWdd+XZBq6PnJAzh/1Z4?=
 =?us-ascii?Q?sNcFiDPenaafoC4hv+77VfF721ZFKDt2EcT60fSwCQMwRluhCHCIh1W1gdm4?=
 =?us-ascii?Q?oML0zoEuegEBc9gaHaQ9xxO3S5gPXQDDHNL2FkqFXHgaoRAJsiRMlRIZNHBI?=
 =?us-ascii?Q?lMexRGn/vZSkjUESO5/PZmvp6t9vOi0zrSSVMhzdvHoQQ6X+wzEhuJJ+55bv?=
 =?us-ascii?Q?Cbt7AFC7hdf6b54evG9ZNO9MpDxryXjL3XrbgFDMqNnEvCCCFcR0l9Ipd+KV?=
 =?us-ascii?Q?Pjx59MxS6u9wusS8ZstlC0jSo90+b2suYwTqL6zc92kmfXxta36aS1VcUkst?=
 =?us-ascii?Q?3QAKIlzaJ4SleIJu5bN0/6M1wH2ioDLHhk1pjQWq8VqIw2dhKl6+IHZk9mCm?=
 =?us-ascii?Q?zkHZ3q3oXpsOW6+vNU5iwdKuI04hbPrBaGkfTpj+BfLlvZJycHphCLuK7PIg?=
 =?us-ascii?Q?jWAFv7YrBtagO2dm5f3AaVxux7g1oc2LIMRqRM44lqclx3mBCszqJna10v93?=
 =?us-ascii?Q?qHV2MIx6FTmrMhWozvWJy/MWGYLLSLbWVPL1UuY+MPNs7p0wZSkdYzzpwLDN?=
 =?us-ascii?Q?egibE94j0ePJR8OxkEERY7TvvfAwjHoAxjZkNd48TRZyTebgmys8ev+LC40e?=
 =?us-ascii?Q?iDAm1qmzUIPWKhN62kVUAda3p1ePVloiDdhigwexI5bOYZ0ddR5SpE1ZF1+/?=
 =?us-ascii?Q?V+y4IKSPIV2eEhq1D6eoN87sc9FBWOSeMjt20IBj6SkwhwwOw2noPNp30Wpt?=
 =?us-ascii?Q?S0XB0c7jW7iEbnxi2Q188UTk9YkfRTrvAYSjZOs3k0a864sc7Ns56QxjRADf?=
 =?us-ascii?Q?FPr7zH/0ZR2kgQ1DzKsVqTAawRgZGeR6zev0JqVSg+FLg2FJTf4cI48ofFaD?=
 =?us-ascii?Q?uq5Ae2enH0jPA7xzjeVLMcJa939Vd/C3QYVsIOPZWRb6bpudsBmbgfuDcxEO?=
 =?us-ascii?Q?heu5LJ8NKFbYQqohtuANeWBhuiKIKxOc9bvddFLmhRx6BtiN5tpoaZ29/47L?=
 =?us-ascii?Q?t0jBO1eCsZmW+00ARofRYViPsNBk9FH7y3SjyXie87v3WnyRlPfP9OZ7vA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jUZpg4oMwQ5YveYNGNJCm+1JHWG+g2z+0hEB7jCJA2uliu3u4+1UwbdPRNUB?=
 =?us-ascii?Q?qCc5pjB/vU2qQVGpbDsLgwRDsCbjwWeu+4fVXEcNE9r/6MxaTHTmOfOddLzG?=
 =?us-ascii?Q?CS9M8jASQ02kge2HafQ9133xJTw8eB1ZqTsEhMaIEJrI4Mdy/mikfJYh3M8m?=
 =?us-ascii?Q?RowcRDZJ30FTKNw7CEI1a/cZ5Cy5bYz0rlCk23xVz6uXe1oo3syv4V9e4e+w?=
 =?us-ascii?Q?kJ/fPyNB2/eOHusZzlbcVOsW1ereMmIpSjwMe1RSQyBLR5hvHo2pqnYBOGAz?=
 =?us-ascii?Q?RB435W/sCea6b04Ff067fMsLpT7ACKsfsrN779m0xstw0W3GV8wQOBrByOo0?=
 =?us-ascii?Q?dNofJ7+C2g7eYFlU87uB0cFihOtPNRc/MgNA9G5qZKD6HEfVVN0YduFOJGdX?=
 =?us-ascii?Q?w4kDxPRhAtI0Xg7W7cvZ683lNBkvDwavYbFrm45A/MmOxtbIylnWx4934Avd?=
 =?us-ascii?Q?cBa1YR+anu1bI36cN9Iml7eAUL6zM6N8LCor3K+/dRVWCRXh4MDO2/MJg2oi?=
 =?us-ascii?Q?RR+7xTstcHzmMZY2U8IceaN3PdrzAUZHQ9iHFhxBx06D9FfqVl2S3t4krMIf?=
 =?us-ascii?Q?HDr5b2cCxcM2/4CMI3YHWrs0RJW/610nb9Rx3bWt/GRpOCQhnDnVnMp7tlus?=
 =?us-ascii?Q?0KZ/H2PZUZBXhxZFuxTBGZiEAmDndU1jpax3F6mouNPlQAm8rb/LtzyqYCXn?=
 =?us-ascii?Q?tfrIWauB1vLvgywwfUssGGd1HROEAUR1r2o/1uonmbU897sp4NJb2pVjSDcX?=
 =?us-ascii?Q?NHXhYTavo0r5ISlQdS+A3xpuFjHWOkYReuAwznqvIJHoLkvSb5o1exoz5bvC?=
 =?us-ascii?Q?ujrDqVk1YS+vCD3RRvHINeuel7eOHMZ/a+K1RgTs/U50YUskkAV2VdWsGl/b?=
 =?us-ascii?Q?SqPn9sobHUzAVlpyT4V6kPUM3dTgdvwZGcesHo4Q/2/kJLmMdGHNPOoX7kAI?=
 =?us-ascii?Q?ZmwKdkhYbOqtjy9rRalktlQopv0xut6pTx17zEWNI44x/jBt2PSyhFLirevX?=
 =?us-ascii?Q?CDiapqDDfLjcitvLBSSUGzNivXoG0zHKJoR0rP9plZufD0w8NlZrKm/8oDaZ?=
 =?us-ascii?Q?vLCDt3mYDj6hdyrhqgqCBy1EQDl5sOkkaDxU7zi0P/GQ0r5anklCy+SOQ4bo?=
 =?us-ascii?Q?3OtaCfSqD1c96rLCOQ6W+YVa8HTK4YUc7TkvtMJFOxbze/k3yzI/HM8aQneV?=
 =?us-ascii?Q?7TvEnqCKmlZoqi55u246wiFi3ukABkClqDu0lFd7bS3CC48UhCx3UK3iqDLm?=
 =?us-ascii?Q?icMp336NbM8nBr/SHFYHqlVvlBb/yneUebiPoWQ0Wn6CkCbDi9yrR1QzeElH?=
 =?us-ascii?Q?zA88BaTdze6+/JtcWJ8qhGH/1G9k38fC7Pj9CPTS6IRuxJYMyzgSPmXN6k/9?=
 =?us-ascii?Q?VKusuIcQpyP3YCQruCEj6Jf/xCPXTRZcBkfVaxHg8WcE2krs3seYF9zNgsd3?=
 =?us-ascii?Q?KtQsFBVM3zi4mE4jWEUi5XCZojzz+KQQe2d9m/l/f+QzmsBzBWtdTy/tmrnj?=
 =?us-ascii?Q?R6+GcfNpTLgionB/fgzop19M1qzh4AeeNdwx8cCDmhUgh38XBPk4xddnKtXu?=
 =?us-ascii?Q?Cjwg1bvKRgRIpTPr3whjo5Jpve+WIo/E/VLtM2wkk7xAUx+egyoemSO8vtqu?=
 =?us-ascii?Q?Zo+2Ls97plsIW5VHBRUZXVE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a7e4ba-f27f-4ee0-ea9b-08de27ed334a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 04:28:05.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqQyqTBGPCrwEdsm/LXv00S4BR7g38T4dv/wxsSHmDMtrnZ0w1HJgGGOSa0F6/hEP1QbO0DCszUok+HjcV40lMes72ed1JcSrKtNyoCZU6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6541

Add SNAND node to enable support of attached SPI-NAND on the EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..31191b8d1430 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -203,4 +203,24 @@ pcie_intc1: interrupt-controller {
 			#interrupt-cells = <1>;
 		};
 	};
+
+	spi_ctrl: spi@1fa10000 {
+		compatible = "airoha,en7523-snand", "airoha,en7581-snand";
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
 };
-- 
2.51.0



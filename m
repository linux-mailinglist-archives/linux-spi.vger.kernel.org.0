Return-Path: <linux-spi+bounces-11367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA0AC72310
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 05:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0B693467F8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 04:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2452EFDA6;
	Thu, 20 Nov 2025 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="koZI2bhs"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023115.outbound.protection.outlook.com [40.107.162.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3402E7F25;
	Thu, 20 Nov 2025 04:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612897; cv=fail; b=RR2vawGrL2jhL60ltZ8AlqpRQxu7fKWKnwkCMoXdPfxZsKnrv5YFVHTksqcxNwUPo123kYRl82FbF95Ko3RPs+8G581JPK2LfggIoZS4VfpRgOO37s75lW/i54PC8f78hEZ7DRoYHs9vDC0l+pEadVsv24OWKcbvNnHbM0tHFyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612897; c=relaxed/simple;
	bh=nvzSbP9vzHqZ9BdvDElbSy9zjtNy+EQ+e//hLD4/DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcA2UrE1jLS250vasRNQ8/hIO6gUAML/aVA7yWZWbBU9uPW2J7H0odBzLvj4zSa9IT3rEuhCQvGOtPvJqhk0zeEp7/sbe3ydY2Ii/sEFIykZIzfImgl5Dy0ff3EnoLayMu5qSE+/x1czXErD4jtY7AeibSqoR731pkxNmypzKyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=koZI2bhs; arc=fail smtp.client-ip=40.107.162.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNUg9rmEthPlVGwlqhxSD5aDoeLUZPZ6LSnOYtvzOOArlnMIvYmIeu+lPNhHBPNXoGUZhLSWRIm2RzEaR7Nh3+iLykJMTNi0wacfVfAKqZpfPukW90Kss86Z2ewoooChvU5gt1omw2m7iYFSx3SdM0//b568BzjqhZjaXkboA3ZKJWR9rSwNWqkJQrMpRrb9pweFgzEHQ4zfCMbs1+2fJxcazNoM0ka/3EZE/dz1YfEHgIw/3L8fksm9EiA/OhqDQo0/W4TdXhnOpQ5f2Ho0wpyaCueDwUtczc3DLXOTNKlbykIPDandQX5qnuIdjACWz1NX/TLboN/dlO+bTqcRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=R16YdHUFJ6mzVg0PeB0cpUHFWtaOfU6nzW7IAWGnoojSuDlz22VYkPkZ8U+nOF+My7WbWOAA8hIppCnYMTaNUPwuadcLTWjqrjLsgbfI3f7TOe7/MlbasdSc1mgC3BuA3ItyX1FSHAH//rP1ZMJ8mFd+VpWGy4gzGNuaUmBgJgJcuKa9aDsfOB49BNjOQoOOJD0TndnTRf227jZ8N64vPqRtmUoaIxKW7v0/EbWYJvcuwwqmqrudSqeB+HAPJqn3f10VHANCmNnfWcmoJR20BJW26XVy5fo6BEtV8kSFvV27O2I1qNJmm1dBvrA24egsLCs7IrIOJNE3MayxzTy4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj3KXet9skYYmZuJ1RFhi80JF8Ngy4LwP2uvVKLNgRI=;
 b=koZI2bhs/NraDIbW3yMmzUiuUK1+AEKGjl2CwH6V2wFRc0w/3H67ph49Kzr+9QiN505zwplc+8oD2ezkjdePNGoqV6DU4jIYW3gFfsCB/B6FjsrFtU5oqofsIcqJg5KmOSdWnD+Qe6RP6UW4uFppfzIPFSFOlKbXh3dnGxX2ysXPaA76hadhVnMh70C2knNxFE1GKTnJ2lBu1Q4mopnz4PVDoCzBtK1WKmG4aqJJfBhJcQ24AXdEcMg/oNE0oAj0nsZD8IY1oQoRvRkd/Lrir5r1wSqkRKM802MmLxiCUg+bLkZc5VVcBF8vgsN7E6+FtgdUtZhJ17OkjCBSd9GYoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6541.eurprd08.prod.outlook.com (2603:10a6:102:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 04:28:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 04:28:04 +0000
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
	Andreas Gnau <andreas.gnau@iopsys.eu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: spi: airoha: add compatible for EN7523
Date: Thu, 20 Nov 2025 07:27:52 +0300
Message-ID: <20251120042753.640492-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7ceafc8b-62d1-4304-18c3-08de27ed328b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uhnxXMLQG+JRAS1KJYPxiNpkKgzkMr/Q4FVBYuM+GfXLGv/ytPsjT5ugXQQr?=
 =?us-ascii?Q?4lyq2DDm19gvguR+Md1tyH3kIBJoJnIpijfvqk0hIHaXzn6D/dLSjg8F2vZW?=
 =?us-ascii?Q?1CoJDjIFhsL0cJuHhS+3udfSC2qbnleB7vxxkiMhi5vE31p2T3246gER1rsK?=
 =?us-ascii?Q?SjDQPWJufxuMRzqokOFrllpFPE0xh1HSbklpM89iTYYGNUKCx+18duv0lmdT?=
 =?us-ascii?Q?StD15Vs46h83O63/8Nz/d6GNF/gJHe9GTm8W3FJRK/2f0pJdwbFvwOondyfU?=
 =?us-ascii?Q?/iuy7M06Wvo6c3OVwFeYvfMga2E3IVCLaTr06xKxVtQ74a1Y+52xI4xxozV4?=
 =?us-ascii?Q?PMge/626ekImYxNOSdNEAjO4KKoZeQbF40KFJxlvbgcSdYPl9/xQXadQLcBM?=
 =?us-ascii?Q?uNtIlfoeJglC78Jwa4xnpt5FcpIcYfZ8F2ujm+32k+lSe5Hs+gYwz+SBQa8p?=
 =?us-ascii?Q?6XeVgiAUMgCoaj/ZeqJmws1St/TSSFYefMy186zRpJFgmMEdta2iY1ePSznN?=
 =?us-ascii?Q?15df4bJBS5QHAvP6NlXml3fGZ7tGz5XlVRR8P7lV3eqkioyo1H2v0Ey2GcAc?=
 =?us-ascii?Q?cqtlqm5qsmDL3lH3d6M+TPeNMXHtHGL98RbM3z4Ep04agPpWR2tAr6ic1CEi?=
 =?us-ascii?Q?f3lWJiSqlUCe7Dt8H6DrVKI4llHzI7PSo+1U5bW227vuhFqC2ZJmh4vmHdOH?=
 =?us-ascii?Q?M2XRN/2IHwAzlLBKRXH4wZXKeKUCoxd5GQhEvw6oa6pciwzI6tE09igmvlr3?=
 =?us-ascii?Q?utlfFD9VSzdX5qmKEN3iJ/vWBhLNTlkbKwpJjTF6kNAjT4xlDJuPOJgxfPqO?=
 =?us-ascii?Q?QYx/ycB4bQgLCIHFJWDcUYvAGY6fhCsuFsodguJCXSqWWRhiQkowgjGlOYh3?=
 =?us-ascii?Q?09An5T+d/sNKFQJbblt8Hnd0mGb3OavhnBCyyX4ci9FenSqizjzfNl82RFQF?=
 =?us-ascii?Q?8k3BK5Bzfxvw6jBtL8We52vMbflQb/PRCJ0Ir5XjVfuSt33IOjVaSMPsHOeL?=
 =?us-ascii?Q?9kCE375+t+3ulCDGQZGVNMroyWXmNAK8Z/qaP0L2NEep63eJJneehnRHxLZy?=
 =?us-ascii?Q?SaRSPySyDrk8kJ2MJF5mVbvNFov7WcsVor4oCGFLswB9F3SND7LPYugWyPpC?=
 =?us-ascii?Q?PaCc1iZVteQgwt0H6BtcQ/8XHU9LcfLjRuF+tYjmbmz9MPooEnT3oPCssJOU?=
 =?us-ascii?Q?PaiQPRJic13TDJgs5EpXbWAwm+mSgoSM3bVq9kFKc9+1c+on7amXpUCLVl/t?=
 =?us-ascii?Q?myMJxdhQYVi5JoK8IFq3+1423ysqVvyMukGqmPkgvXMwiij2vgPMuprPU8pw?=
 =?us-ascii?Q?giTRZ7zLhbuRdXCxTIaWA3TtxcVCVvAodV6oek1B5aKDNbFpS/bLWh8PxM04?=
 =?us-ascii?Q?+7h8Ch/p+JhHmTZ/9KFcx3dujklUppF4U/4N2YUlR8/pybG5tcyZ8oDPWMel?=
 =?us-ascii?Q?A4d/59vSvEXHSx89cdnOFW7usca/uJ+VrMUQpVhblb1n/hXVJWUxP9NUU3Hh?=
 =?us-ascii?Q?j1dgekQkuzaOSJ8jbx4YEx+kfB9WahSk8MXZh03oYchbFK9AiFDTxNXdRw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UvI42KdmMJM8gZfHWLYHT5aDqTyWSdh8cgaXUJ5QgtWrhrWK0Z/qIrTbAkKP?=
 =?us-ascii?Q?40xVdYAmGG1JUNtfqeebuoa+NC4GY3al89OO9ChDH8X5kLpR/Oz/9PUATo5M?=
 =?us-ascii?Q?qE84wRunLppXViHhSlhUIwJs4I1A4g2xJ9/R14MLg/ldkxmrJIUcdne4qftc?=
 =?us-ascii?Q?5Ai+vsQR6JmCyGdDBUmElFH2DzAe28f8wGzyw+gL3U0iZB/yaP1jsupm3G6g?=
 =?us-ascii?Q?O8okYKkcIFOswqlh7GLAYNaMBUu9mtSMprweQdgHXZuJ06zkhfRbQ6D7buk/?=
 =?us-ascii?Q?ozpM+/zJHxzawrCxtDTQEElMjm0E8PSVPjN1If8EEzqlWlZNbOUFeSEPsekI?=
 =?us-ascii?Q?fIQf+jmTWtIQM37FXwxRlbVToqjY6Y9WLkFfBSUnaHqScse/cYlSxwd3dC7H?=
 =?us-ascii?Q?N+tgvRuIKLRIIVYzv2ktRhE9zS9TRmC1AjxQ2Ul60ggweKQnk8mi1eyBhivX?=
 =?us-ascii?Q?KcnT8nAzYBR0q70pxdF6NqoUN1rbaF7h+P7OTFm9aFCUNkwPeDe5ef/vW8cQ?=
 =?us-ascii?Q?AFDslW9J+c7ILhLCp4cc2nnbXRpkoDoEDG6D73uEi3x9DxwPvXA+LjIix6c0?=
 =?us-ascii?Q?OU6wxxCTQ5vEVScde67f6Cf1bQZX6Eqx8IR4fcSMzXT/Zpis/FIATuL80wYs?=
 =?us-ascii?Q?a2SbhYnYx/EqwBf+KxAu+/yJO/ui7PjfkylVyJqycGp/TSgO7NgvpiN9YMHJ?=
 =?us-ascii?Q?cj+aPAiFppyDC/DeQBXAKJjVw3/CN1fRZdVfEX+lXi/gEFvi0bQwD0s3MrMd?=
 =?us-ascii?Q?LnnUrE2qxU50IcFQ19n1EID0qtIuKUyv++np7pa95FcMKD2VZjjt43MfQODJ?=
 =?us-ascii?Q?OqbeIECDMrQKnKObiGOQrSGA3VfUg79rd3F9RAR+A6BtU0BTIS4iwwB2mMV4?=
 =?us-ascii?Q?i/q5KxoRpPDMioq4sfn8hVQCRSac+NkWGr6WH4iQhXZcNba5YzTAQWWOTPc5?=
 =?us-ascii?Q?LkRSeDzDxGtavsC13bcEfHzHdj29bXUzlaRgFDyrYqXhhFHdZWunhagHdrjd?=
 =?us-ascii?Q?WeqUeM89k7066YiFc2NsHZlJeMPxyMTZWCGcz/2BLZfrrI9ZhUUWEAtnDXPQ?=
 =?us-ascii?Q?xtI1LHA1mvj1H6tLkD3xW8lB3FR7yoU1c9J4KJiLl2NvF2nqMUxqUdygFFE3?=
 =?us-ascii?Q?D6qA6E3qOIB935d6dbQsQ4i9W92QygM0AgRjKV7OZq/0RwT1C3a+XfbQOKwm?=
 =?us-ascii?Q?PlL8SIxHhW+0X4VD1IzrWTUW1FcNrxHs8GSNOkalgxyA/xlb2OQ2VbDn/C/A?=
 =?us-ascii?Q?4BnMdPruYPmVNQpjP2A3RTQ5krrSQspk+0plsr3USXvncQQINlSJh7ryr1ab?=
 =?us-ascii?Q?L1xf7bY7e7NMENhLT32IGp0OH1RSTL6btcRN+2jyaigm5iN8w+XArHvqD8XL?=
 =?us-ascii?Q?vG410C+UTKTMHYx5WxqJAeD/x3B/62THVhrY2S/sqJO4Eku7KM/7gHsHKc6S?=
 =?us-ascii?Q?IKYW2ZVNqY+rlsIqZRBzVPiKKdXNkD2q4vBcTzKHQrIPdbIDvi2/snN9wQsl?=
 =?us-ascii?Q?wEnr7OY5BSR/N+BtIVTBhkruRHjCN93rA0RgS0tQ6ci2x6MaS0ajdHGt+WPw?=
 =?us-ascii?Q?0iS5KGr4ml5UR1PeR+HMcYyTrA58E8aLBo11FZx4Q5FyIU5dREbg7Ti7Nul5?=
 =?us-ascii?Q?wYlx2XhxBetNHsflbnDNVxo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ceafc8b-62d1-4304-18c3-08de27ed328b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 04:28:04.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4GdG3BTrKrx3xjWdOXunIT8PMl31frk/qc3KtpUasuAEUFDeaX7Yd2O5nmEEB6zFKdDDY0UqCwCyn8uhRcUluUxdb6kUuq6qMbpVG/r1Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6541

Add dt-bindings documentation of SPI NAND controller
for Airoha EN7523 SoC platform.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/airoha,en7581-snand.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
index b820c5613dcc..855aa08995b9 100644
--- a/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
@@ -14,7 +14,12 @@ allOf:
 
 properties:
   compatible:
-    const: airoha,en7581-snand
+    oneOf:
+      - const: airoha,en7581-snand
+      - items:
+          - enum:
+              - airoha,en7523-snand
+          - const: airoha,en7581-snand
 
   reg:
     items:
-- 
2.51.0



Return-Path: <linux-spi+bounces-7655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B8BA92E31
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72D619E6427
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D228221DA0;
	Thu, 17 Apr 2025 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="N19PY3Xw"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010006.outbound.protection.outlook.com [52.101.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57B22171B;
	Thu, 17 Apr 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932187; cv=fail; b=FfIvZe4uffCln6ZSuxo1W7bljRJbwmuxNcGxsJQ9UPhOdIc+FI0WWJVHLspJvqsdtP3qt2V2TylKPylgfiyP8msvluZe1MHfRKtVwRgaVoQg21DOtlqTLoDgtNlFBAbdgVHLubnIMculMWOJ3dcmf1IN+L9EgcxjBLFVgW6NlVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932187; c=relaxed/simple;
	bh=kHPzPGcso0XSjJOhgHmBCN75r9gxX+f4XyGqOFVorfU=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Y5z0DoHIkkksXU7hEl5A/LHKvMMGNhjH87kJS4TV9x5m5T8Le3tIdOtaTHwoGMZbv84FSRovMQ7MjWutgF5AkwtRF0JE0AiFM6Z1l0bFOBrs/di8ncsDUjsH30ZyriW/IwZeUKC5Y2yOBTD5DJmrweUWCiXAcTy5j/T0d0eI920=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=N19PY3Xw; arc=fail smtp.client-ip=52.101.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNKKoiUY2mgPrm6ZPXGIBGLvcB0oxK2197d+4MPdv4oiyb3nnwut1v2kMXLgp7kbqa4rfMX2BCUMeARaDv0S9HXdtG3y+/DSG/Ht5vJlmH6FmBVxeIzKkcUuIKq+a/5SqoWGkcjH+AHG3/8cOLsSS+MVbZUPg2QBdpOLr56oxShksmErLasNx3GfsBzf7aNeRIxCwH3P9s80qFx+LWXt3gCXhyBpNo3g/Vz1VLdG9KklKGlZ5/VDfQ3v2XA2t7ymPvYOHcc1vUW+sEJoSZZaPBs/c3TKv3uQboFeI2ykC3+II1SXDgIj3dUVhptlhB/GcEHW+b1q7wN4DQ5UXIVwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V25dyR+7RAM/AZnG7ejegYM8RlVwwpNNNVxnZRjhrA=;
 b=EMmJP60RtMvuVnrwfuhNp4P6nVrPF9T2WAkzMH1HqUj8sTJORoD60OqG6Aad6faQ6Am7720hsWXBu0Vv2prQXWwMyETGtQxs+bU94rNeNYRG6XOebgwDox3SFtHwe9sMNSKALzB0qbIoxFD7TpZFUEWtuGMK7+gOUv+CE9mcvJrrUgTJX34ZcI2IJ7jdLp0Qw+V/np1XLYKNDMPvS3uxJo44j8EoKo6/QlLg4Jd0CunamQ8apMWiEUCFnsEwIUaYQPYC308uWpWudVw4BjjCnWG4A8lHLWvHuOjChv/Aznwi3MJPLs80OIm3p8CRSzsh9i/veTWsGN/GeuydxnVdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V25dyR+7RAM/AZnG7ejegYM8RlVwwpNNNVxnZRjhrA=;
 b=N19PY3XwgI2eaqvax/j/GEHPk3NIvI3LUp3wPtZkBxpwWkbI7GziU6zALQTan7Pd3gD+w2/GUvR6/6sbxheLGv33DIMg+9NHvTfe+BTcKkA9Yn+JPdPZKU2vCNbPhVNJQxU+D5ZCcsVTwguAV3q14pUHVeLyFi7lZm11YwoxSsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:22:58 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:22:58 +0000
Message-ID: <87zfge2x0u.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:22:58 +0000
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa43c3f-d353-45d0-24c8-08dd7e06ca1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?isXxRNM11OIHKm7TXToLyxUl6s9Y4W011M0Jv8H29JvD/kdT/nyomdjMRY5q?=
 =?us-ascii?Q?/CMo+eWBqGFdhvsdHN0mX1iSQo29D/3cJ0nvePLBLP2bcWCbRLds3PK7VaEE?=
 =?us-ascii?Q?6gL1rFqgtonv3T7WtqExjbXr++HDIsMsioFNlMw2JkeZji08wZt8gL0NWOFi?=
 =?us-ascii?Q?rMRHT8vwJYQ7GxLv3PsQD+b1Uk1/x6GpiaFkqgMy4e/4JYR7tYx61W9tBYPi?=
 =?us-ascii?Q?thWv2zRZRa/w/+ZjqqkwUPzaf0/5mf9cUd42GzQGoQtKfEt7JEvWmWziUHsg?=
 =?us-ascii?Q?Ey8lA7WeG0+Z7Ew83pte1yCjKoe0JW2IMJSJ+ChNogvhpQQM7QIpPskE1t4l?=
 =?us-ascii?Q?jM2rnapQWGYfKXtouHL4FoyOrHQN1BtY5xI92yPo36pCcoZSDmfFx9gwJRuv?=
 =?us-ascii?Q?dL5u/S6uos3nZCly/Aqk8KKTjbqDiTD6UEACKJ+h41fY+Ro6xBdnCNz68Y5D?=
 =?us-ascii?Q?n/hDMFGVbV7C9zgHPRUx2PEJI2QG5dUAB5rcZH3zxiE5n/PPj1Nw2m+S+Ll8?=
 =?us-ascii?Q?mkENuxQhnrNjlJ2+PUlXtHwC5M3qm0vha87MjEVc2t65Z4hpOzv3wGrq9g7O?=
 =?us-ascii?Q?zK+/4QaBdzyjYUyS/E48+BJVPsemoiMWEHPcyvvtCh9m20kEgIYOOZ75gh39?=
 =?us-ascii?Q?wjeVmalTNBbIdBy4MKg9XW/3l4bmh/aebBfO2uTZ7i9H6PPhsBSLWyWp5fhj?=
 =?us-ascii?Q?TqW8+pdQ8CCwRGt6bAhyujzrViyEtRIcgO+kxEvElmdP9+YKtLMk4Lf3zbHH?=
 =?us-ascii?Q?KBgyY7GxG/8sryCp9j/Do3I3gf34FvpWfo9OLzFACpyhUFGFnmrYI4XxMFEk?=
 =?us-ascii?Q?gH42I6S9daTPxAwWSHfF0KtARYqBBE6MVHRzRNEa2JMX3EPtU8r1jyHciaZ2?=
 =?us-ascii?Q?p6JneMvfYIqyjv0Op+EdjQBa15mAUfISCPFI1mtwwYFh4k+YIDmHak1VTQ2q?=
 =?us-ascii?Q?6hxUdMBY8iW5kRdlxz/pV/3Sid+BQ38CSKQlfED6FSNejFRqBapNHQH9se1L?=
 =?us-ascii?Q?GuD8ILMvZVdWw1o1uyriv0bhc/VRPZJ6+2I7O70YxHMCNBof/XGULmPzbE1z?=
 =?us-ascii?Q?Zz8+QDAmHFTVXkw2Rm5s5VOrGcmtXd0Hpl+exRKpLYle0Yo5Y/wLguzB03nd?=
 =?us-ascii?Q?rH9cvqvcI4VlRb+fdpgcDdCLvCavDjY8uZXwmEr4dmbGdbZrJPjFCR2ai6C9?=
 =?us-ascii?Q?I8GItzrayMbeiugwpF09vyHK0sMCwGa/YcC0yy3HWj7Xoi6vGxSdXcSn8dDj?=
 =?us-ascii?Q?QHxXc5WQd1iTRrQDzWMHaX7jpjgOkTgpUAwZROLfPkhi2KXmB0GywULPvgaq?=
 =?us-ascii?Q?SRztAgM5LngIucT1NwfPeMK8s7Y1hxnMQgbiBjfUAb/fDAOEYWK/j4/zPjLI?=
 =?us-ascii?Q?1GpS1Cb/dBGeXtuEvGFGna+oDhJzkFkEcxMSBPQxmDMKqZlkY2gmyzxqilz5?=
 =?us-ascii?Q?6iXt/mJioWpnyaxloeuxVCYplnfI2n0g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/p+TVcmShJAmYmdlbvZ8Oj3sduZ4wSEiSBPC7JyGXjvMS1zIjDjgqYL0Haah?=
 =?us-ascii?Q?XBQZbgz48+HN7TPEhSVYg5h0UR7PJA5/CZ48BqU+GC/H0DWi6E/++QjEH4jH?=
 =?us-ascii?Q?XNBlFe5x0tZ61ENcfhI5KJEyJok/sryx9hWG8QlzzdwUCal+Gl4C1hvA0e/H?=
 =?us-ascii?Q?T7h7mtgc/56Bxj09Cjlcy8Ir/JvOcMzlDhGdRDrNOeLHkTeMnO8/oQlMIJGc?=
 =?us-ascii?Q?TVwurGN0m54heFzyXSL7dMbvDKBOMU8fixoJ8sV98TMWLlN2qwyRKCMHjRW5?=
 =?us-ascii?Q?nRgZiFFjle67Tc0Iod6VU1gwEfN1XwOYkTKGywBGUBMn1O79AzcSPdnSuRbZ?=
 =?us-ascii?Q?WPNBS1xGhSYpwGZIrBjm631o9uNEHzpNuk/j09vhET9zvtpvy7YJJE0sss7S?=
 =?us-ascii?Q?KKfc0EMQhiuheTPywu09e3yi7VSF4v3Ih5l4RGLLGhkZHZH5uBCOdrZt8TfR?=
 =?us-ascii?Q?ZGci86+BtM1AV8l9+yyeJeHkH07mHFT8S6Z29l678+XtmF9/bvW6U23FRMBw?=
 =?us-ascii?Q?ILdLhy9S8Rcx4/NOmmmxjzDzUxT4JflurAScRc7fc1AgS/0q3uhSPKOeEnuH?=
 =?us-ascii?Q?gnpmCMD90d3jhOkhNhac3MOg/fxo+YDT5UMGbYFXTf5o8fNuD3cJ9NrNm77l?=
 =?us-ascii?Q?SwW1u8P26J0FZ8OS25s44BUNuxEjNTuaq03MOf5t/QdrlpmO+X1wXtOswGev?=
 =?us-ascii?Q?vQbj6Zu9zX82SZisTZl5KnPa4sMaId3AUZzG63pLtl3hcXs16VxVz8+TIUUH?=
 =?us-ascii?Q?KPKjGznCJoSXgueEk8nXBu39Eb6zFoHqrkfyLOxpVo6JiV/Plqoao561/0WR?=
 =?us-ascii?Q?Z1gvNOgG7Z+duSeB4BiZnWHhU3rKbvsbdbxFTW5DuPI+HuRxwozTBeSWAS9O?=
 =?us-ascii?Q?asOcall2G4bO/lYNUJRvjLxES5n1sXIt6xifFxA/ZAMA5NwDwZeSie34xGvw?=
 =?us-ascii?Q?4DTgeVQ0N+MxONQJFYoZafrDLrC5276pFeIXJvxLeMJOHj/iRo2LT/Ce3EKK?=
 =?us-ascii?Q?2wrdsHKBTPZm2dU2OQhXRyYTl0ziM3yRGi/YjP1qzXQdJ4E6WAxaFYkJlzOr?=
 =?us-ascii?Q?xNlOud6iKwG15E5RxGO0DaiUuk4tegQcvLQXrNDuqz7zykWmTTUlhDWnydYc?=
 =?us-ascii?Q?dX0M1RgJTa35FC2k+QV5nl7rNC571Y7kCQKZIWUxHUbWjFEsSlKWVEp6zPJj?=
 =?us-ascii?Q?fNXWZWll8SqT99NQWqYY7G/EjVRQv112USorntZJFpwhDeoIajmJiXVDxBDt?=
 =?us-ascii?Q?NCDQN2isfo6AceM7o1hN1ojx/vHCpUNTZ93hLf6Hh/atbERshzN2LCjOWHjP?=
 =?us-ascii?Q?LhNVy+GVF2nTCd8TVAtM/RlcpyUUMAmBfapIYnhNyNxtme3zFdvGyuxicjUQ?=
 =?us-ascii?Q?rTFccH3ZiAyEDlETGmIg7kDUWBkjiUAp1pheVY8cukB10nM5tKS0pC+M3nHv?=
 =?us-ascii?Q?3micB/BeIEYD/MmB/MpLlgYYOr257i5s9MakelCFxENxjYekzD1YA5FROzVb?=
 =?us-ascii?Q?avXRF8AuN/EEiuGND/Tix+gvG/YIeDbcTjfM57w3Ev3TLQZ9tUuO6GNdCY6I?=
 =?us-ascii?Q?MTWtxSC5276AisERqBSH6zwHv+jCHCF3vQgPLUNiVWAeGn6NoMMEsK1KklEO?=
 =?us-ascii?Q?wrl0WJm/jQjj6it8+ZZdS0I=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa43c3f-d353-45d0-24c8-08dd7e06ca1a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:22:58.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BZB94FF27okebbymA4RT9lxCJF052bmw2YWlx7f8w0xjMYswNqPRnJKPzVvsNDeF/V5fS2tEVyY8BNtKMb0jrujNA1phjXO/ehlE+TGBCyP00CZsVbxKvdp1g5D438v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
uses Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Adds schema for MSIOF-I2S (= Sound).

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/spi/renesas,sh-msiof.yaml        | 43 ++++++++++++-------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 49649fc3f95af..e0c7047ae8adb 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -4,14 +4,11 @@
 $id: http://devicetree.org/schemas/spi/renesas,sh-msiof.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas MSIOF SPI controller
+title: Renesas MSIOF SPI / I2S controller
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
-allOf:
-  - $ref: spi-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -146,24 +143,38 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 64
 
+  # for MSIOF-I2S
+  port:
+    $ref: ../sound/audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
   - power-domains
-  - '#address-cells'
-  - '#size-cells'
-
-if:
-  not:
-    properties:
-      compatible:
-        contains:
-          const: renesas,sh-mobile-msiof
-then:
-  required:
-    - resets
+
+allOf:
+  # additional "required""
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,sh-mobile-msiof
+    then:
+      required:
+        - resets
+
+  # If it doesn't have "port" node, it is "MSIOF-SPI"
+  - if:
+      not:
+        required:
+          - port
+    then:
+      allOf:
+        - $ref: spi-controller.yaml#
 
 unevaluatedProperties: false
 
-- 
2.43.0



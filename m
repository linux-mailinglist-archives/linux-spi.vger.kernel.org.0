Return-Path: <linux-spi+bounces-7579-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C42A8914F
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323DD3A9337
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB513D891;
	Tue, 15 Apr 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Qe4G9cTY"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010048.outbound.protection.outlook.com [52.101.229.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587CF9DA;
	Tue, 15 Apr 2025 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680838; cv=fail; b=BUrQHlbKyJ55nHUGZQwEQtACN29XLY6zti0xo9QqNp8VI3S+LCGJ/wVsA/mgTCaPkBnGF+xNQLzF6CaNQb6L75F6zLEQctOVUQKV9TfiVpNoEUAODTpjYdcsdXXD7I6XD8cbjEVLkf084Uf/FjWV/UBLYTNrUv9plNCUAZLBUT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680838; c=relaxed/simple;
	bh=rzWtZrs8JryPR2siNfxvOF+r09/ErdHgt43ZfZBzaJ4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=MxnXxBOSmxAhqaiSvyoAg1h+J+PT4wnMyI1XmS48w7I/fXPc35h0HX0ITZvdts16gdbGVG1Z2BOUKVpJcnZlTzAr4ATwT71Bn5xojzN5XPFDhQLpO32zIedjtljtFhZ4+mnOg5t8A50QOkwCLjw5WqSi/0QLvYbHbdOZRI7zW/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Qe4G9cTY; arc=fail smtp.client-ip=52.101.229.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HszQjpUYWiVPomzrjAWFoCaAWpUjzgNKxG8YBAPvW4yH06leV3evTbzwaQjQ9yoZmomH09KM2f8Wwd93LR+y7dh0UggIWACU2XlsWKKxNB1N1UrZ3fkPrGfrANbSmG4r9ROuByyCM7fNyPZTYpwbVgc0qJnt6zeDwn7AnTTzWzXl9gZNIm9MN6oO2Ib3Hpt3D19pnkoH+E+2jvn7w977mKFD435FaQuOC2xW2BbC4tylGDV1gstHjg6W2xm0BlEobmy67Z/a9DKtiOIE9i797qUUlTP7STntGmoCBvaZs1e0ROtOWxhKBNeCL7hVJNsT1iN5nEc5mjMcJq+RNemREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg6iU+xYtE+AoXf+HVdS724f/Oegt0WTB++ifMjkN8w=;
 b=DIhRlcM5ztbvKqYW3JUZZmQ+ORqjJObHHYly8urF+F6IfnEDR7JTnQ+Fk5t+ZFERdaNxotc+jE74LlZ/F58c6Bad8n2nHgkmJ9L8ONiugm+CjWsyD6NljlpmdOD3vbdq8sWEJKigzpss+g7Ll7TQV1NiUaszN4rPvQ9Qdf3J2QCSJWnn3jbWNM87ICwGeMDZZmpe5s0OixxvLsEBhuRzHfQDqymoEcxThLoPKwavGtb9cWXttyNmrn13JLL9tJ5ib6737JWKrZ+URtCE55+u8TT2RBm6KNFeaoXhU73Z/Le0Svd9p3WBgr4qEn22re26fr6BGiU8erqg2bt6xIrHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg6iU+xYtE+AoXf+HVdS724f/Oegt0WTB++ifMjkN8w=;
 b=Qe4G9cTYig0kT/S1vcx9e9hMT1G6eN7PewREynuzB0j3hu+8I20qP5QhOKE4JYbF/yw+KtXRbXNt/4X9UN3BtwKeXiTArCJi4NbPMkPTd/03DFmxCte2gRe0dXHloCWTa7ksuKFoz+bxIL33ow9UUd4AIRrG7LNsJYSIKc70cyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:33:50 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:33:50 +0000
Message-ID: <87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 01/10] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:33:50 +0000
X-ClientProxiedBy: TYCP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::17) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 926c40da-94c6-46cb-0867-08dd7bbd9325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWxP9Id1AsyU6dTuPqnFjIH7/QMzNHUxPo7xn8XCYeIsFDl6xY9woGuBUYZs?=
 =?us-ascii?Q?zId40llf7zK5dfcDlaMA+DmPTwoIy3EwD0CaMlBs8hhrBMf/y3xkTKefTKog?=
 =?us-ascii?Q?S/NnDD+7st1wkOF2N/kLBrOpT9BixwsMkPOIWNEig43AoMRV8J7fxpsBjLRi?=
 =?us-ascii?Q?JZxQ5ipNEhws+L9G+DWAr1dN1LDtyKdmJZAc8p2USQLRFHqCwHUlXUQqahCN?=
 =?us-ascii?Q?IjKht4OWzePRdv9KM9Wop7KqlPgk4cJEVj1//oW8RDF5YQ6P1hZG6Xo7qxhX?=
 =?us-ascii?Q?npP/zNqS/z4rOZZQ/A8mpl6C4H3T8arLZri8M68GJNwrKorjYuNZaO72Rxjl?=
 =?us-ascii?Q?MrvRJ9xy7EFQHib72TLl41NcqL5tMk5wYElvhIVbmgM/eBplxrlC88Pzc6nG?=
 =?us-ascii?Q?Ym+kK5JlqyUn3Tqm/0Uv8urCkFReGtezpxmxnFcuAzhkks+UfvdoLdLtQonR?=
 =?us-ascii?Q?cZQKJW/WVy4vrs3G5mDHHSWpJji8qyDDd1BLg2+PuMSAiSxqoXWdWm5VU0VI?=
 =?us-ascii?Q?gJmLb09B4WVHvvnB3CiV3mdoAIdMDHdumPqNMQZW7exP7LRmvZRXu/uCgfts?=
 =?us-ascii?Q?6b1vH4hcpqT2IjeVDN9d9KilmTwH1L6FoiE2edeGCF8iUvB1VTppflxi02wp?=
 =?us-ascii?Q?O6NNzEZArvMRM9SkocY6VLIXT0dUxmHmSr5dM9T1+Jk24L9o8RtJ81nGL29c?=
 =?us-ascii?Q?juBZldsT2HEdX2l2so89oEqIpxFsA+vdnfkahF4mJ2icSTewyJs8EN+FO1o8?=
 =?us-ascii?Q?TMlc7QaA3quvb/j4SRvuFT1MBWztJNrQxwRQBhQyZm7WzHs7pVoIDywsRFsw?=
 =?us-ascii?Q?QgozrOj53amkjj8rd5agUKV81aWKbygBtmCZ1PNPPZV8hJr5YWn8MLjzR7XM?=
 =?us-ascii?Q?eKMFp8rOHmbB3c4oAbr4OTjTId0C+3fehicGYoD/BkVBhKFp47L8yCIeE6WY?=
 =?us-ascii?Q?0GMumNbEBHJDZ+xlYzcAd7T/vC72FlgGl6NalS7AyT4h4V4JAj310BZCzvaV?=
 =?us-ascii?Q?SzpksowUy66zQy933TKW9NlLuRs14pinHSoKwqZg8ek5AdOvFuDPVEZCCoLv?=
 =?us-ascii?Q?EqsGAAR8BUivsKY0OVvQYZPNzk5GmFEQrBvqLqYvnj5PB6thSMMoFE2YDlbk?=
 =?us-ascii?Q?WR3+nDpnBZ5BQa5hKAI+uLAbhDxxu53Dodd12cMsSDMCDOj6LZ6I0QTe0GlG?=
 =?us-ascii?Q?xyBZe3K9NULMv4w8BQ3ZoCMjMOkdLXW/kJRBwTFrSz1KPJzT/DxF9QF+dACq?=
 =?us-ascii?Q?KU+3IhrT2WupBEShhFqWUITemU0ppAZczDZ4CquEj+NsIwdplklZ2CKzmfvT?=
 =?us-ascii?Q?mRoEKg3o6vTi9EtgD7R9p2HFfwxpEsYAR4e58NirCkK5mYJCZfaGyHwaDP90?=
 =?us-ascii?Q?9CeUURyDRy8hattuychfo5eSXlegaC67f0rfU1koB1OptCXq8jr8N5ruWRsI?=
 =?us-ascii?Q?Nc23KCptTJ00F/NSQzChvkIU6baoimC7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Grs47cNTpbPxf1aSfGLBc8yQQrOlV/YRrFPMO6t0KDqfFE66HYG02MXSYreu?=
 =?us-ascii?Q?ANL73Sy5k7IM2/8PsV9Bwpkp/viCPCQcLqZmcE72su3HaDLgsDqFlDu69Uza?=
 =?us-ascii?Q?L8/0we9ZKT1RHYlR43NvdjWFa4mmy/h0qgIgR8wnEwuwBso4hlJ/Q0HjHNJp?=
 =?us-ascii?Q?EmGAF5qNO0ON/2SmkqA8vvDsVNZ5XCmxeCQjDYUbbqa/vuo3KDXp3KswvesH?=
 =?us-ascii?Q?3UJGuVTxpypkyhjy1ZluV+b3zRLxn68+HyLEg8Qb1QQZHlJA0mjQVEHsFpNl?=
 =?us-ascii?Q?ZCVi8oRv/Z9FFgOQEeccivmQj7Xjg6Vjm0uc2YXC9QyaM5rlCaq7gJMa95Yf?=
 =?us-ascii?Q?5tOQqPvNl4GjvCJe37YgLNmQWAJRN2qbGaXlSh5FPb635t+AfHxBiss0da3M?=
 =?us-ascii?Q?58o8TmzCoMmv5RJZ548g8ep/s1YUtBZgvwz0PG3h3usY/sX9ihe+gVBe0ody?=
 =?us-ascii?Q?XJYbYmfhOKOks4JiE8DEnAAUf1s3Pm++Nq5SPQVSI2BQhn4tY45HLUEKhcsi?=
 =?us-ascii?Q?YyDI2ZWb3CYDxK/9uvw0tFSKps3t0AVKcAb42EWZhN3CYgvdT5TtJ+EpMhfF?=
 =?us-ascii?Q?3UE9q6JuT7wXSCAmLx8ZZjzNYeQEmmWm2OwiET0JiD+SbjRGrRIFOOKDz/jY?=
 =?us-ascii?Q?951EQjpn65ydc2fWqRrEVKRgxKeyFx5Qt3+XrscTl3XWC8O4+tDp2mLP9mtp?=
 =?us-ascii?Q?X3o43Fik9OnaOt49SiH3PMq2Vhc0FVRFxEr3KHb+qB7aFJC9NgljOF0fNOIR?=
 =?us-ascii?Q?3Mb+nKiB096n9OCOKqrHTvJkK2z4dEV9G//sQA0KvB9T14YFyZmE2tCvEbAF?=
 =?us-ascii?Q?RoZxE+LiqcaFD7uzqxvtVXJAzuF1mf//2zjLm9qc42OinZGvu6eFpVHbiEjH?=
 =?us-ascii?Q?51daMCrqxy4SEx36fEAULzU8T7RdoEbXSEIEh291RLJQSkfcGOzNc5mvCnSY?=
 =?us-ascii?Q?/HiZT3Ao4GVr8BNuDcY9BMhmezxH2nfrIaZTKe/+Vw+j4dnpfEJD/QomUquI?=
 =?us-ascii?Q?x0L/R9lxx9Sy7UUC7z0T+7dVGBWwRfkpWTM08Ykd6iVWnWRSFq84R2gq5nYj?=
 =?us-ascii?Q?84Hwh/G48Wk6qfD71vqPG/vx0YYQxcid4Ac4fgUthMX9RzjArm+yuUC7VF7P?=
 =?us-ascii?Q?LEZdr6dPLFqkZFBeQixlcjBSCkfCOmCPKrCCNyXUyzN8eUoPQ4CF9/95+SJZ?=
 =?us-ascii?Q?5zpV2IhiYgZzjhRvBTzGg+VeZvD36JvtOAwshQ1S9Dp4nK4kZrj36jsEhbmw?=
 =?us-ascii?Q?+70F2780JfarLOR8VfC7WK1h/jGorhJexWnrLM9QGEh2tfzEGwQ4doNVplP6?=
 =?us-ascii?Q?ZVzFg4ARJnR2817D88W5Z9rjCgnhuweB8uk/gGrYqMMw/WkGCSZ3HTdXK+1W?=
 =?us-ascii?Q?29hE8KvMTfV3vmzectws2nYDW8qcKWoRaU9H1MPgitUzzwWnqG6vlofoz6me?=
 =?us-ascii?Q?uvlWA/v0NDmf+DqMjiUuVjAolD8bd9rDjoafkHnQIGo/0LTd6Sdb/1atyGuv?=
 =?us-ascii?Q?nohCtu4II8fl+UNNcobfX/7s1DtmXUt0LLhXmylWryWAAUdWOmM70AJkAGoe?=
 =?us-ascii?Q?vwY0HT9924p26OKm0RvOy83kPWcw3gZtAcIGjdVRv9WXPDqig+sFD5Yk86SV?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926c40da-94c6-46cb-0867-08dd7bbd9325
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:33:50.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAcdtlozF0NTNk6G9XqiO+YaiDTbLWPgh5p5Xx723VaJlAcVR/W4/vZ23fmO2MntlIyAeHEngQ8B7C5FJArFC/qm6yWvDZLr4109g7K4dJjh9ZJsk7Cr9tF9bvpgrF9l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536

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
index 49649fc3f95a..880bd854d196 100644
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
+  # "MSIOF-SPI" specific
+  - if:
+      properties:
+        $nodename:
+          pattern: '^spi@'
+    then:
+      allOf:
+        - $ref: spi-controller.yaml#
 
 unevaluatedProperties: false
 
-- 
2.43.0



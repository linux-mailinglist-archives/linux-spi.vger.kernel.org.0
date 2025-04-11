Return-Path: <linux-spi+bounces-7539-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7878AA850D3
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A5F19E6911
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074F235BE8;
	Fri, 11 Apr 2025 01:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="l0OE6jUr"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011066.outbound.protection.outlook.com [52.101.125.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA76B652;
	Fri, 11 Apr 2025 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333416; cv=fail; b=ooZPb8hKE50TwN8IkZ1u6z5t88HdeEmL/MXij0I7BFCq7O9bXwNEb784gy8lwYEuZBLp1YskkVeJwPMwdvnZ4fsLFg5Db74bdFl3cBJYiJ6gycsPO9SNtnvHDPkqd+E5FJNpj75s9aLQnuA2XxjzkenTOCdvK/vnqjHO2i/QZBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333416; c=relaxed/simple;
	bh=tEKSxyYABrjsc+wqim9wo9Ti85WJNRGQk6XHWy1xeB4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lR+O4MkXC+kLy6hy3xJkTQzu+OPsYdnB0iH7/ItNWCJpdgPtrUf15cV4Bc6umEImwm53KTR1um4D4q8dscVAFfQsW6q55MGQzfejd1czDnmKmrwqF0ZFvsCM3onMXDeSY88yJBiPXOC4Zf2nnDRoivn9JUJmMjOeDHkmJ6vI+r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=l0OE6jUr; arc=fail smtp.client-ip=52.101.125.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+Sm1HJ2WJVEwYiuiXASvJDl5b7WoiAArXGoArrIhRnZtl9Gup9OySg+zsWCGY3421kX/zzr9/6oQUumDe+se+CzEyJ50+s26vgNL3t4OdsBlWMKtEN8Jfj7EWjwAxOomHtcJNuY2hUS/tEtxZIszYlfaaaKXngaDWIkLycDMCU8vwjv2bVV6eFb/AbJ+KHz2bORPqCIqrQYeAIB7Bn19XlzRT3SkAwG9DwVQSjwVi377OPKMnX4lhg22SXyEGSNQ/ixxeh8gakTn3wywlnXceo6LOPOY536Ig1daR6wfxgG2afTGiczxsprYUYjTMneyzJMosxFroG0P2QQcE5JAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOIGnq4esSGMQ7DaVFPccUYVqPdZMkfMAZ0A6u8yejY=;
 b=Wg3CHKLg1cpZJgr6IyM+Won9jKNh5flr+Zf3BFPcyUy95crBYFdvaBsUqPr1MnPeP1v8GZDcmcT81j3HR9B7U36dtgys/j7KKsijodI2bpv9IQIjpsQ97UrwX01djuBtTUeQK8d4/syaRi3zn2ulPYruwk6iMWcmC7pIey1X1bpwsuR08SJX8/6sKkQJ5H4xd/+ppqYeN5lX4oLAR0vtEHsL8r2quVbcc1GDSY/xCJt6eBNDcCW1YTs0HCrdOGPtcCyUj900nqLeFiTcrlxhIF79fXpVaEW4tMHix3TTPIBpfclT6h2wkPGyKRv4tQ2qYBQulbLGIGqJcYLXTwZ4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOIGnq4esSGMQ7DaVFPccUYVqPdZMkfMAZ0A6u8yejY=;
 b=l0OE6jUrTVW1KGxCNkHOOeU7p9jRb8slHft//tgGn/vtGyWIq0PSoXvpwLBp3a5589C/FuUO4xUY3aNwv0Z/qqwD0oC8yjcDFAdxRcThUG4XQy+XjHAWbt0TwfzSzKJixY6lf7Nztaj5CSf9QAWtPhTuN3eqtyzzGGcGv91BvrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:28 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:28 +0000
Message-ID: <87frifh5ls.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 1/9] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
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
Date: Fri, 11 Apr 2025 01:03:27 +0000
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: ef68f2a0-2c92-407c-f99c-08dd7894ab4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I92NjRrWQbSQARBMAE6+lEvbkf6u1CYxDsXRbe8dGboXgN3rkIKMPqzhuk7m?=
 =?us-ascii?Q?MlKP3vi0iz3XOqvaJwrsUa9EOfyfTzlyVWBLirOcrwQkoU5ATVOlXdQ/SqWw?=
 =?us-ascii?Q?TsStSoao0lYK7s+/my7j1WI0sVM+zMMv/LTHCklbEOdY1YggTImp5plp31ZE?=
 =?us-ascii?Q?wIkW+St8O2Lz/JtxxNukIAiJQMPc7LNDq1kyqySUT21Gi0XVHaKW073XcyJS?=
 =?us-ascii?Q?YTYCjI6tbRoJoXyHfbwMeBgzj3emeXxH5Y7kqPrNHaLENHwQo/kXL7qQyiDK?=
 =?us-ascii?Q?rNZVDVIgnFilXEQEcskUFb3aji0ce+nFszp2cOt/imNFJoSqt719U8FydTLX?=
 =?us-ascii?Q?wbVLZzMGZHobDNg+qZ+TQjFMO7LMpx4DDP/TVne4fgkLu1G1ybxcOz/HZFKG?=
 =?us-ascii?Q?bFx499YUSQMNttvqzFWiRFb4vQtADyOx5Nmkl7MDOLH6g95zJQoRqxu9isvE?=
 =?us-ascii?Q?B5InOuER17ku1uSnzCZzvEBjblymelULcrFk2rbafKtebUGrytY3dxQnSNoz?=
 =?us-ascii?Q?GK6Q5j3BUe0wtCfiFqY2URw81ackIskcHdcDSMT8JaokwbFgN7uh7mpVlKRr?=
 =?us-ascii?Q?RLZ8GD+wzDB4UfHxknMFeENyECZWDB/1OTyEUTgHtd9djgk+JTRUDdKPpBOi?=
 =?us-ascii?Q?k6cKj3VJPtO4F5EOIdtYFyKRAPzPRYgC4ADrjxPIDE2+3xBFj3Wo2Qy3KLah?=
 =?us-ascii?Q?qaaRbglwjHgupxrEkkiRSItZ3A4f6AouohPs2ljH/h7yPDtaDSwYg9cqhSMu?=
 =?us-ascii?Q?l3H0r0jjfBO0YBiUzvvpP/Q/ojcXesA5pEvNt5IcoR8cqr6nkJ5zgRGbrQuv?=
 =?us-ascii?Q?q5vuu9YHXnOkUxjAYpIwLECbWFbQpbYCclMlYo24+xls55t2GlYGc7NJFyR/?=
 =?us-ascii?Q?wkfgx36E6WI0+qleetibTMuFpZDwTnDTbfGh/FxBZxQG2T7zHMISVx7BskaI?=
 =?us-ascii?Q?lJabadwuYALH9QOvMFXgKcKIUlsQmSYWbfc2XWDjFZzVmVCIY0gBlFESR6FI?=
 =?us-ascii?Q?+xyE8ZjDkCs3cmgzatz7n5eLbnYw8QOWKTuG4Xa43xcYoan1ELC7tMgwz/Hw?=
 =?us-ascii?Q?ZndwNpqQvL192A02CdVQDwLuj+XfI0kH/RGaBjMiQAP2NL4LL2DwNxrVna4G?=
 =?us-ascii?Q?DtUEnuXQyNiVZ09hHL4ASP9Mn3mZy3JBLKTvsypGDYuBuKgqcceemnvtMFiX?=
 =?us-ascii?Q?gr1sqGTJx/EcnukLmOVUfijB9KzV+47gAuiVUYjzHTm0Smog7+kNH/IUaGIi?=
 =?us-ascii?Q?TWuvvlA84Ww/s33c1MPUYs8p84Gm0DzqArFNiGb8z90f8BkEqd/4Ve8y71i8?=
 =?us-ascii?Q?g+SfOM9W9r7Sl+uGse3WAotL4qrHLBGh9stzNhwflds9NOo2zEnuz9ynQ/kp?=
 =?us-ascii?Q?EryqaVVQLa7C0ItyPq4W2wMS7OjeCH+JD+8oQte8qRjxUv4FH9WkoexG7RwB?=
 =?us-ascii?Q?xg6s65p1Sd1lDSll4w/nRcYTzxYiNzoi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nK7WPQfj6mdcvOkZTjgog87/AA+puQ25zvTbNni05AubCpeAnQ+g6yq/mRnb?=
 =?us-ascii?Q?eZKc/DEn01fhlXLNWhMOpigFSDgxGvZLkV3rzaPcEGMe6sH4KIB7CgqusNnJ?=
 =?us-ascii?Q?L6b/xGClEipwFEJhdD2Ul32xcdrFz73ty0Y6PA03K/y/invn8fqS/ZYSvGYs?=
 =?us-ascii?Q?QxRdjGbf7EZ3GxSrUkoV2I2IuEIJejxzLrwzyICqADqaVaZjrAx2kLOqjT7G?=
 =?us-ascii?Q?Oay1Ev305xzXnwaDXIzmLmHudJ0aae/IxeIjhEjISx3RDpCh8LEFnrQ5SAvD?=
 =?us-ascii?Q?Tpm4TSLP1Zi8+kM7loW7NsE0EaFT2Bgxyl/cF3Cfkx2zTvTAm57n2reU6+rT?=
 =?us-ascii?Q?M59cUyQ67Ysmt8QAQZGkdnsL4tn5C2QknLV5M3xNe7mCaDZ3W3js9ZQaFYA9?=
 =?us-ascii?Q?LIIOBM4M26rWfAXzODtSPQizjeN4o3LAIdnrFyJIDBFFltc71SnLMNdGFIYr?=
 =?us-ascii?Q?EzUi49h4og/U794rY2+VSvibpOI0GIhFVUjAb+ggImt6f039ILBxskGnogb5?=
 =?us-ascii?Q?62UdZFgiDWdSJnI2B6eotabs0kbI/RTFaqWcgyLUhCzJ230x0i8O5XfENtat?=
 =?us-ascii?Q?2YZ/p1WVm7HXCrNQjwRgut7B73fhtUbbsJ+M32nCZTiJO/xlQ6QunvpPo26n?=
 =?us-ascii?Q?CS+YyIkZCzXbQsILcJdYaPSuDtQd6E9gsauwCdm+hyGUDpNEachjR6E/BCxf?=
 =?us-ascii?Q?Q2aMsgkAC5/IDHmMoRF80CaFBhRsxTEKVD9afRzMqlW8GeQSFoMchlpxrS1D?=
 =?us-ascii?Q?15VryPF7E4iamfW6eCUcjmU5mbl8ekuDVg6V3XspmqsqIrGp4v1xOXK7sFUK?=
 =?us-ascii?Q?+J0hyvlpc6A39R4j+fIOd3OeW1SnEBdjZPSe0c5oSvOFz3eRSD3Vz2JP9mVU?=
 =?us-ascii?Q?oxhWj8Ueb7/RQxpflmxkkQnj0AvIc4Fqql/gAuGeH321Wsv2b75Nq+ItURw3?=
 =?us-ascii?Q?700ow1a0BtgSku2MmFJUHOTblazyX2NJd+r99ZHMkNSr9BL6rsuOpFecYnxO?=
 =?us-ascii?Q?e+Arhf1gu0IFzS2aCglpKAV9MD6htNCYjzGIuePniIg95vT+1fuwHz3PqNlz?=
 =?us-ascii?Q?uDRsu1L9FQjoeLuK+gBb6V71FACo+MXXjPNEdm9g2bIr6BxzI7YM9rMhrdgH?=
 =?us-ascii?Q?Ibavrw+pqBmEz3n79SJRRXUUzh7HLDiZ9s9IQ/AZ7Y2H0seiglrKWlM/GV5E?=
 =?us-ascii?Q?/OZVRiW+KMLtphHG7YJVtnynfgOAMKSB7ATN+n97aiG91siahDLIX6ER9FRw?=
 =?us-ascii?Q?gb8+fWVj5ybPn0dVcvNTotSWZSvNWiuXM5nWbgnbYpYGQAgbJWimGqMj1h4c?=
 =?us-ascii?Q?/f1k6yeoSRmOCqWq6u78r/J2xxknU+mbD/ZK/asGEhlvl+jpMEDecF65ym8q?=
 =?us-ascii?Q?tOgrGMczQ3X8aDzQEiJ+KMITXX5fGARZ8ffzbC5dGPQ/yA/ArYTCD36gt3z+?=
 =?us-ascii?Q?c012bvC5YM6NlpWlRqMdWani+4LhBnk6cKSaS7AjAlOVjccu4HplNyt7tEcJ?=
 =?us-ascii?Q?43142iZatp39wpSPh8t33zVAW6Wey7hqtma/v0Tu0P9BRJ+xMDNIRKFc3mIr?=
 =?us-ascii?Q?fI8NhsPFkF9aSerlf9PwNFoxf5PDo6GZ8PfSKnwrrHxX9T8U3mUup/Ileh0R?=
 =?us-ascii?Q?M6xfvsJJRuusb5mZEatuty8=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef68f2a0-2c92-407c-f99c-08dd7894ab4f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:28.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wm88uI8dFkbC9DdCdbeFEPf/12ztSSTL83qmzTlQDP9eYwTG0oygwTL2PzGmk/QBc/6TF0u+6byuy/pZ8IeEu06aKoOJ3sJQfbwwdswwrn4b1YC9BgvQ+BHzpZnT9My0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
uses Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Adds schema for MSIOF-I2S (= Sound).
Because MSIOF is no longer SPI specific device, remove spi specific schema

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/spi/renesas,sh-msiof.yaml        | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 49649fc3f95a..9f73120e97c1 100644
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
@@ -70,6 +67,12 @@ properties:
           - description: CPU registers
           - description: DMA engine registers
 
+  "#address-cells":
+    enum: [0, 1]
+
+  "#size-cells":
+    const: 0
+
   interrupts:
     maxItems: 1
 
@@ -146,14 +149,20 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 64
 
+  # for MSIOF-I2S
+  port:
+    $ref: ../sound/audio-graph-port.yaml#/definitions/port-base
+    unevaluatedProperties: false
+    patternProperties:
+      "^endpoint(@[0-9a-f]+)?":
+        $ref: audio-graph-port.yaml#/definitions/endpoint-base
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
   - power-domains
-  - '#address-cells'
-  - '#size-cells'
 
 if:
   not:
@@ -173,7 +182,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a7791-sysc.h>
 
-    msiof0: spi@e6e20000 {
+    msiof0: serial-engine@e6e20000 {
         compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
         reg = <0xe6e20000 0x0064>;
         interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0



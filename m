Return-Path: <linux-spi+bounces-3650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBFD91B076
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5971F22384
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 20:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404919DF67;
	Thu, 27 Jun 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBcC+jVC"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57079195398;
	Thu, 27 Jun 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520410; cv=fail; b=RJJ6IJ9OBbXqzYmYRa6QEZVFnuU7OPfDEeQHJuYsLtl3L+HNzS+/SWcJG9w4eYFmwZYpyzOZZRQFC6sbWI12E5Kj8LoOuUbMfAB67urXJ1WTr7CMxuyIemAcRkEZYFAYAmC9qEX3Wzu0sT9RJG5Ylc1R3JwwSpUbxseTU9IA5bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520410; c=relaxed/simple;
	bh=bBppWf2CY3rIBH2UEH6m/AnDQ3b/eO8daobZ/fyzy8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Pw9cXw73ja+41fUvBms1H3/fkESi99fPUK9DA6SgC5ztB8F122Maz+mpRYbgR0cluSEY+6Sxv1TqMZSfFVn/lK1A1NcZsal6PGvMoArAAOX2DtOp+mLBaqyLbb01Tuk97DNkiW5JMh0L7v/INXvZNOtPJhmXe+2lnB6hKsjdMes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CBcC+jVC; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaXpuw5fo72XPyEKGSh0viiU5HTbLWxJrxK/swXWfjHaqdLiyS4pTtLQB7qxfGsy1kgkEtZV3Wnm56EPzp6bhjyzmwf1vn9U7tlnJca/JzuPEWR+mJae7bqOhVJHq/cqbrFFu0RkbhJNR9gEvqycJzbqB3Zbl4zvz27prTQXbKO4pJ70/jv0LmMdzIkqqBGDvnCpgH6Mqy6Zs4n1k2m2joArvUEpg3ZIQWgSfGCFR/i+14yt6XL43yqUyxu+ucToZxY8eNXq+Z5HRKQAAUh64u7H0QV/BJfvlcycIMtQVbuoGH2jdVltedH5O66kb1aA5XWBdnoDHzba4pqLF1QjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgvJ2aJjIwfHPL/u2BxD1U37Qcm+ZiSgLfn5xuiCDTk=;
 b=aQsZAHnpZ87wkjbmLZ0EH7wK8w2Md5E8J8+tCxs9duI6ajHEUrLAxK7Iu60ABQA6ns6uDBbJxSy/lsBNSiZ6HE+UZxHMDfFrXRbbGdpu3SdjayX6eISMkXtMb85hJ5CQ6aCH53x42St4rCtXR+Z0bVP9QTlKtgeMoLEuuHobeulnu9lkY05olzNyTdO3iQa7qnyA2SQWqwU/LIPbX73nFTiyQYxrTU47okJXfcW3ZVedmX/dnVKwcGcuum5feIqPFTZVtHMKPKBbYI/p/I3LprcZWN7b1ibwVFm520qL295EHsP/5CgLiBsXm5Y2EiqqGZVJ06mX6QcPRV8vKzqosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgvJ2aJjIwfHPL/u2BxD1U37Qcm+ZiSgLfn5xuiCDTk=;
 b=CBcC+jVCDe2/F9tGKTPzq7MOJOb0sqDQRJGiyCba1mlgr9dGvnPT5b4WX1eZS4by4pcYWR+JxDnUZCy2BeXNrIJq9UToOzpAifTm9EUlPNf2YzL3MIMgyaQYvj92zX7lcj7pV6fjrmKbbNuCoky4yHOTHHX3t6F9lmAwC86ijVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 20:33:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 20:33:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org (open list:FREESCALE DSPI DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] spi: dt-bindings: fsl-dspi: add dmas and dma-names properties
Date: Thu, 27 Jun 2024 16:33:08 -0400
Message-Id: <20240627203308.476437-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 51073622-d27d-418f-6145-08dc96e86473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5oT3Nuk8Ob3oJIJTUJXdhyEINL2cdy8ZHGHXqRDhM7XRG9QqBzU7oUbC6rS?=
 =?us-ascii?Q?gOK2oae1mkYUIOWFxnqz59SagRo8n+zyBkKNS6eCyvb3op3tsAyfWW8qxC8D?=
 =?us-ascii?Q?7PKSJaBHXG4ivYYsF5JgyZ4L0BF2awoCRFwajvh5jSiPEtK3udBR/f2AUmWM?=
 =?us-ascii?Q?jGnS8W0WpFUHtNUwroZYJHVcP5nzcnayj0xfEyOs3/tQIxTx1/D4eFecoBMR?=
 =?us-ascii?Q?a3rIsnF1Oe+exu4QaYEHXyg5FM4y7fpEH13cchkx8NpnDl7LXZPW67HxYtAh?=
 =?us-ascii?Q?ZA6yNMX5KwHt6Tiu9wsa8dB/B1hzbz6buHeU7yJ30emY6mZaG0hv/FXuYdnD?=
 =?us-ascii?Q?C50F6IINymhmSVdbIqa4FDRXt0Sq/5/ezvx/a/h8zXd91kJZV5ke9VfaFOox?=
 =?us-ascii?Q?rdgwrqvL1JzM3UOqzyrPhTUCGyu5GMpgF5iZ3t8cFDqQNI+ssnwKCf4ZV65C?=
 =?us-ascii?Q?+rRGavwQVzISdmDATUwtZpnSxLc5lnGdRtWIhv8N69aWWMTZpxhLGztPl91f?=
 =?us-ascii?Q?jYY+Cwp4qx8/ZfZIjUVwOgvifqIC9g3RupIIS6MCfQ74dYqCIKyN0H7Ioa4g?=
 =?us-ascii?Q?TenbLXJfBcnWeee5MMl7yaj/f9iR1PyUS64fMfpvIlS988gKG3fV3Hb8lOSK?=
 =?us-ascii?Q?pHPzNeVBJJ/MWbNZxzLs6ZjTnnO+dx/j25/qZvMKycZPtvhcJ/IwHyvJ9t3O?=
 =?us-ascii?Q?4+KkKe5QWAYa5jhyi7LTl7mx93HmRIUztQNwZU2qjWmiHQ7ellf3SaPvMNWj?=
 =?us-ascii?Q?Zh0QWc+YqwbmU7PFUmOGzh1lUesD3fFRqkHgkOYztLjped5RDWB1aoffvr/3?=
 =?us-ascii?Q?cgDBinQaol6HJwBGJRYTHdG9jFqGTN1JZn2U4QQRMBteaiqTycctG/fw5uWC?=
 =?us-ascii?Q?zpL6S6vdDvKfmFIAkmfv1ZyYQR1lGKMLRx3VYPTvJ92Nm/RxrvQpTCTcnkKC?=
 =?us-ascii?Q?aCx6+p+vNk1q4R8Mkeqsz/xz1kHNVThcZcerZwtpmHoxwPUkK5lGeCjdGXf1?=
 =?us-ascii?Q?JCp60/mo4RGlgW98yePmhtAsx+ATPU2tIs5W1Kf0zAWCNQ9PZ7CeLV/NTfCl?=
 =?us-ascii?Q?qPs4yDGMS26aqyNFiatN9/k+6U7O4LH8HqW2VNgN6n8dEeeMlAVXO8seUA2F?=
 =?us-ascii?Q?saXIWWGD4lORy50vnI8RRt6GjmWhlVGwUCXKPZ9WH66ky+NZUc0n+iyDE1uw?=
 =?us-ascii?Q?ypH+JNRK7nNGOQ1I0AgyWueT0jfeTe7BNn+GstIPto8aa59vCDFnUXKHFCa2?=
 =?us-ascii?Q?tRgNoU+CD09m0pZssL+Qk94b5Bb7FBb9CAEC7PkJP7uew1vHW91gwnbrpVlw?=
 =?us-ascii?Q?8NGcFJndROZkghm9MWIN1lg+xvabVHob7QIJf1KCaiW2tyOix15BMfx2vDvz?=
 =?us-ascii?Q?CbBNqdY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QgRhlMkCaYCliI5AZml/5Doj/TCaUU814YW//HraSiteBoaPjcFzskNHA7lX?=
 =?us-ascii?Q?VF9WiNiSTbxzsBw10oykA+hJ5WovPMayeBFNMJS/jb3fHbhnDbsr3OBAmfoP?=
 =?us-ascii?Q?V/awidFD7hMKV04FlbAIv+Toc3Mttgv6Tf4aLysOrujTbP2jzNmVy2C27ze7?=
 =?us-ascii?Q?Z5XJLs5ohbUqIBSF6d5bFqUGmReXRSnzN4lExzGXaNdr+zSq1RjE0m3cRK2l?=
 =?us-ascii?Q?9fSqUgDfaXBlzGBOjVHek8dqR6Lqgi2Of5diomBRA0Pf4LPocTAyHlWPU3Ea?=
 =?us-ascii?Q?jRdSCg9us8FxHFyX/ycZLpY5GNjbTRujtyLuJXlpvRfXIsL9P6zWKgLxdwWK?=
 =?us-ascii?Q?y8NEpoV4mzXsI3G6rL4sb1UGK+xk0zmQ5GBhqEAik5kLnIs+Ilabjtnhj2w1?=
 =?us-ascii?Q?g7ZWUmxE/RxtIpBUFLqPt2+Ud6NH1PQyNG2HsbrD70NfURgmh4TyxNR5OxoO?=
 =?us-ascii?Q?2DvAxgqkrKg09+sSGDCj1gJdZu07QpZxdpBdHVrrRrSso4pTG3m+GfgSBHDC?=
 =?us-ascii?Q?UAHJZDTnkR1gR7mKPvMRerlxm6mVTzxZuGsePZpoRlSxfFJQetOb5FEcT7Xg?=
 =?us-ascii?Q?KGB2vfoKHoHexCVSByk7+a8UFwzabwltzhTsUn2PuBy+seBhRsJC5TqsLPKX?=
 =?us-ascii?Q?i2JgGgyVw1XwRS0Aw9ncyFOMNsTF7aw0c4wVRfsv2j4YatjpkM4BjC1x+N1F?=
 =?us-ascii?Q?RGGoJ2KdsdOsT5mFGNcUoWsoIdF8YANQjoadRB4s7n0BkoAy5klvk4bG1s5P?=
 =?us-ascii?Q?xKbGmr+2Y1SNZfmwjyZ2gyN11SMNZaaXQHo9TSJgvTVhFOUrVMz/KMcGApPF?=
 =?us-ascii?Q?3EfqGQDJbx3Sz4HpP5e2Ia4wYD96yr7tekdbKMvZ4dcv2jOnlDWMTtfshjyg?=
 =?us-ascii?Q?lLsB9NbfztVhgI2sK/5X0wF0TVFvyP83x9j+j18cvXgpcwAi8/yOu6+XG9Yk?=
 =?us-ascii?Q?0zZ8+OByFZqLTZgb09FfZz4Wm1wq74kwJQbc1repJWiYaOBleskJKmdVijLR?=
 =?us-ascii?Q?oDwJmCmvBaEtCNsdVmrqPwQllv6cER+h05kUy1sOTe4vIhPSqKqzgb5JnPZr?=
 =?us-ascii?Q?/4LE/RJetg2vOFHP5zawBjZOSc6rptIbuX/tPfsaBAjE1kHLjj9XFFQeSOyo?=
 =?us-ascii?Q?siP6e3kFOO9uFNgjV2PlzjiIjqx6HN3OtLEqfxAUNH4ZSvwoskWb7TZU0L3x?=
 =?us-ascii?Q?4JsrHV4zJLyS0xX60bOslpmCPzb3MfHJ53InGMbPt9mnBlVbSKzyS4SjMIF5?=
 =?us-ascii?Q?h4LcCITVMLdSuvKw8Ao/sJlG2rLwzk96m84BD7+ipmFG3BK8+6Hifm0LZfWd?=
 =?us-ascii?Q?wnzSqFTuuXjoltOQLPfAwx9CWdMQE1I2Ps8eWbArI+Frtnn9SJ/lISog0HHv?=
 =?us-ascii?Q?xiOYtJulLf/GsjWbfpvABhSnwS7qRtL3RUuT0iamGeqSu4UOYWeYxzHIzhiV?=
 =?us-ascii?Q?jLweCYJG05+3eckJVsGsPFU0vTsaBOt5IUfR198tbVkpzUwr2lQZJ/lXnWpB?=
 =?us-ascii?Q?Hwz56/KbS0zVYlJRxuHcmLilkzRD8ve+MUCz2pV837G1ItAsY8cXvpMKRkxy?=
 =?us-ascii?Q?5z8T6dGH7bjM+pdVAIg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51073622-d27d-418f-6145-08dc96e86473
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 20:33:24.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed1IO+XXv10fJ/mFJUfHZ6wSHMrFeONZBowEWcQXbg5jsyIY8XTsf74cETP7qHA2QnNnrs+G50G37J8uc9OzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827

Add dmas and dma-names properties because dspi support dma transfer.
Fix below warnings:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: spi@2120000: Unevaluated properties are not allowed ('dma-names', 'dmas', 'little-endian' were unexpected)
        from schema $id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/spi/fsl,dspi.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
index eb3deac49bb1a..7ca8fceda7179 100644
--- a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -51,6 +51,16 @@ properties:
     items:
       - const: dspi
 
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for TX
+      - description: DMA controller phandle and request line for RX
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   spi-num-chipselects:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.34.1



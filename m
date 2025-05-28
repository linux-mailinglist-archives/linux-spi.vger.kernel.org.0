Return-Path: <linux-spi+bounces-8323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C35AC7414
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8229501A63
	for <lists+linux-spi@lfdr.de>; Wed, 28 May 2025 22:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B25221F2F;
	Wed, 28 May 2025 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="edJmQ4sV"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D5221FDE;
	Wed, 28 May 2025 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471319; cv=fail; b=iMvap67lYcsQz30fxJe58evfPPDkNSTNLgHHuMISR1Ip84TYHhnqL4V464XabdcTJjTgqHJnsVFL1jCgF3VEJYDNxntFXdsGYbH3laE+v/bXu2M5HWMJ1jacXV91yzxFiivxuyMKK90hooPwVP6wDCkwiZHEgWfH2h8E8SAoY0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471319; c=relaxed/simple;
	bh=yXszPji50tagN4SLkFSyDXzMGRZIVYUATkPN0tml+f8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SMrMOuW45R5Imc/YVVtb8pycTtacJ7uskpAuoGVTQW4zhTA0gh+ONjLIiNjN4w/C2/ogiFfMPw/74LILt1lz4xpaODvEUNz8LAxWeGdHlo7J4tq5OCoFtSX8n1nnqsvtPgTWNwJYpG62fUxFD669SKyWH0vbOvHC4auay4kcKMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=edJmQ4sV; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK0AttAuJVw6ebKknwcskTvF06lczC9aDL+GWQ8PN1V/FmoPmlUui102gXvB0Izm37mAOnhWzzz8hPh/Y+cDX/5cphL06G3XOnF0l5gBzdyoioNuAAWn14VcLpbASADq3gvnPHCLGMYyavxmyIz+MhhWqZFl6BxYU+xDTl3R1q7IBG0Jdy9p33T4ykYG77yt8uipL57AgMn+OzaZ+uJuPkfikv1ikINdcGLLT0I5BmgUjNSBSTr2Ml4i1eOP9ryCqZBLnffYZ4VwVGnlZF3jnEnJFFTNRMP8pV8hx9hGwPnL24QMLxPWel3bJKOWqlYvi6g8VNXyy37mVbF5AY03UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJLaCQruVPuiuZPROgAFUL9ePJ68TzaPzq0HEEEgKho=;
 b=IM9++aoM/LBxRznw56axUhk5axKjdi/+xI+FBs5RRn07qAElff+5XRvWCLgc8ELQluNbH1wBMr8NdNLtPPaskWHMb5PYhW0MhqdZx28rSINJtREr5iOwD7W8ZxAC0axk0lTj/DmJlq4V9XofcBuGE9MffxNU80xSquks492oH2lTaVYvAEjoP7NOpTOpvhOSOZSAENdaY+9Fqd6QfmXy8IEqcg3vCPmMsW88oyvzSXlJ0bGcmFpmqLJDf1DB7ANNvAw98TIruXSw1jgSCyiMZpMyXCOO0fcFlnMEDQ/n0SL/xxAItBjHddsucchD+nvCgVYmEMC2tsZfJpjYsYq4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJLaCQruVPuiuZPROgAFUL9ePJ68TzaPzq0HEEEgKho=;
 b=edJmQ4sVPQ9WCg9VWW+ksKk48cuGmbahxOF4OPf5DcLbQ8s+TYjR4O5++SC5aPVLns52KFlvtMIvU/TB57BYQ1tBQDK2P5oY7Fytl3LafKzo+tzIDOu/EL8AufvcxU628fzn7QijAxQvWj1qe/CQqEpi9pqqSWfVdfeaPntUK8LrqzvJSACLf3fC5hJjO72XtiT/Ii0fnJpsr6ZLB861YT4fdI03QdD0Dos9vYcVKiHbpyXbFFrU9bUXFpUlwz0OgfAGwIL7VZN57E4rp63w6CAbPHyhuLktw+aEW0hqfL/s7IKaWCNbuCA1cWnqyKt1YHdTJPOfuOJOHCPx/SdMrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 22:28:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 22:28:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marex@denx.de>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] spi: dt-bindings: mxs-spi: allow clocks properpty
Date: Wed, 28 May 2025 18:28:20 -0400
Message-Id: <20250528222821.728544-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0167.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10989:EE_
X-MS-Office365-Filtering-Correlation-Id: fb86adf3-a852-48c5-5158-08dd9e36fb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JN8vUGhDKpv7rBy4tkIrVyl4JcVX36NE6EefG8uYfdQFf/A/PhgCBYzfRQP7?=
 =?us-ascii?Q?joJV+nXMqto7kjExZwWJITBiMKNtksQtmgADBPqd1FdBkOf22cK5EXPUWAPt?=
 =?us-ascii?Q?oqjUXBedXdN3oCBczEttxIVC+75HTuUaBTCSAzwA5mIfBpDFjfs1VyIdK91t?=
 =?us-ascii?Q?zQD/b94AMfKkcovNKPtyP2BX91hwZA8ohWhChdV3Nn9jRO26dI+sobST8hpV?=
 =?us-ascii?Q?OBnibyiCHd34YW7IzORPR+k5bzmCv6lyaxBggimr5f6jjCNisNbVxNjCpgMr?=
 =?us-ascii?Q?uDXJnRrKBRNGUQ4/513S0XiOGdFlVMlPsksN0kjsrJnZcH6dtvFLjsqSBSzW?=
 =?us-ascii?Q?cwWoews8JlkRx/CCCMPC/FaWZ2CvrXppqqWpvD7zRJF0I+oAoFq6c3/Wp4ar?=
 =?us-ascii?Q?PZGk+MJ5NMbzROrc0tyDM8nPEBZI76F1n8NPAl0rlP65xNwMVdVBxP4NFcT2?=
 =?us-ascii?Q?2gDGvKXyjWSt7Lj13o0LsPhDlFcN/U/DX9ub/C0pA4YY/0VqC3MFDlKgnB09?=
 =?us-ascii?Q?aj8YN0+Xgrv/ufFXV4RGu/RKb0UYi6HiYVxpr6Cj+plmgnkeY/1OQEmmoMmo?=
 =?us-ascii?Q?GApaoDFxhhqNc5fBQZ8fo1tUv33JN9IoHSvLatdWR5kCx0DqsuQ0+KoFsFUf?=
 =?us-ascii?Q?4v3pjp+tDqFMZmrSaAp+O53amsVVXzV7uJdyxjbTVGRiITAKCxEiArUfDdb+?=
 =?us-ascii?Q?tJY1IjWhcrmVuL85LKI+2QkP/cEi9w6DofhBoWUO7GSnXD1Bexvx+qItdxRj?=
 =?us-ascii?Q?c1LNHlz2cHjXvIqktxhKMzqqsyKRjQSyY/CDVomQ2p92exC7pkP6F14akppU?=
 =?us-ascii?Q?5MDNusiBaMe/tMbDw6HHGTAiiKUt78KEpfmHl1TzOU2Uv94ALA96b98FOo9U?=
 =?us-ascii?Q?EFjLb/dS2c0Pta06hhHTwyKQGEakWlDzDgK1wg7OPVtSKvVsjx4Oq9d40z7J?=
 =?us-ascii?Q?GhSUDJOl3ir5FZpHX1JJ0RKLLM2L5eU+1YyDYuqxNcFpYMIjClfbmaMqHLm9?=
 =?us-ascii?Q?M8dQJJW2kUnIZd4pTDYZq8aNKgLOL5RpdfBcsjDyzErsqI2HhsXyD+scdd6/?=
 =?us-ascii?Q?hawKcu2pWGieHaVU4KX9xUE4NXHi6RCw3pz+4vEIY4IUlLbcwDIzX+UfY4Eu?=
 =?us-ascii?Q?DxCVI8xagjSuffvV9IpaBpxqs+Z8mE3hKeO8II7fYmOXirpr/ith3xCmyc7/?=
 =?us-ascii?Q?JLVXTIhBUwOrlrnttZUgr0kVNLBwfLdHLwlqWhMu9k0RbCamV6R6Om/cv1qP?=
 =?us-ascii?Q?K5dneJ77jdx3Q8v5cstf2pHpi59p47hx+5hBSLymo3kWh86hRZCyD+vpefcJ?=
 =?us-ascii?Q?hI/pi1FkuwsL7R2yx4YG1lM4kHcjSZ9XsRVZxwRDj1/sCum8VEuJV0XHQB9Q?=
 =?us-ascii?Q?kfVGKWNlynZUfhUpKfvvHekIFFyzLpEwfdqencNSULVpfGTbjk8GHzuX12aB?=
 =?us-ascii?Q?MDWUws2yICtaoyiVPO4RugFxOHmRDm+b4oeo2pZzwFhhlBjbv0j+Lr3nbVbP?=
 =?us-ascii?Q?ose/BT4FLI2Bc78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YE3XE1UiB61xwJCAtxjbQm/rJhCMk3pfBrDnnJMKoxpiAsik7B94Gb9JaqCV?=
 =?us-ascii?Q?fRL+JryzVJ3b2W1NPNiU2z/NrmaIQVV+30lSO1Dy/8vo9ZWdDC3DExBvoAyC?=
 =?us-ascii?Q?WlZIOh7Bnm/8oogp4MP2j7XV+qAJhZZbYw8Ch/J+hCFjD7/MHfE7d/Zt/spS?=
 =?us-ascii?Q?nsQQ2JlgzRDshXAz2RXUoC0/ClUHQODlFTsxNOlJeBl5aEj3AOWuhXFl2/w+?=
 =?us-ascii?Q?nGDsS/EMm+KYRC+fxlL60b3Q8czOy+is5yLXQN61NKzAvi7oyJaizycRaSrM?=
 =?us-ascii?Q?QXYmdgGqBVCI/yUcgSnsl2E0Ud35cAbTGB/HKePS/CmlmINoJrx4CY784xn+?=
 =?us-ascii?Q?1InCIDcbMF8m2rajVWRoYSOCDasMjAdWHj2xNh1xIbTEXlyLcfY+LJ/I5F1Q?=
 =?us-ascii?Q?OSHiNH8ejtykhn1E9Cme16zo2gFmq7RAbo1OBl5H7gHnoVFgNgZa854Ofakc?=
 =?us-ascii?Q?9BJShx5A4px+278jCC3L+jmzubBarouJnr+K+jd57bY1hyxJabvsz1EeVMWc?=
 =?us-ascii?Q?24a2qbQA05MyZbSSrqEL3aL+pnejBuptS6DMqS+3rB60b9kEbg7NSOeixSMW?=
 =?us-ascii?Q?oF1Jj1MGbEt8IbCL134IzjoVLsIyZp0sdP4yv2pzikg1xTZkT72O+HRFM3sG?=
 =?us-ascii?Q?N2T2kCd2EmqPzJvWM7ah87cfU4f3espLqI/NRrfuMdoCl4dVd3sPEKATqsX7?=
 =?us-ascii?Q?WHmldfEG2NJVehMwsY0AJknjFLvE7XkyUd8Mk8LowKDVULGNHiroUjj0+LoV?=
 =?us-ascii?Q?jtDVjCa0RhLC8Nytyxwdfo5dd2yAIQrpW5thJJZQYk1vTL0kermxcgRyuZbO?=
 =?us-ascii?Q?6ut80Sz5ekrck+9WyzDiex1lA9U43/IqubfrCrra054ijy4Q7JAwVGbpjT04?=
 =?us-ascii?Q?BbByDQghYqqCf0jiEb/ZDY3P8R4opN1Gy9VURwG1RFVlNDygiUMFqwhFQX6K?=
 =?us-ascii?Q?5/jQuBuyyIdDuX5LIA0lJAHI7Jqo40T49zHwnf2Oxghhrg7Ei9O+XKuYxhFL?=
 =?us-ascii?Q?527px/KOXle22SyXELIXqaOszc2VSJa2lXHc+YZsb/wsRaOBGO3IBaxLafDj?=
 =?us-ascii?Q?/071C85wNx/JZ3GTT36qTS9B+DE82Dq+jWBEeiQPOy+JxNkKs/iwKQJ4L+tx?=
 =?us-ascii?Q?Jo75xzp41qTdGB6Nba4kJDVlw/J/lRIDOEwiQ92EM8ba7vW10UKKvgI2Vx9x?=
 =?us-ascii?Q?qu6h0KpAIhqZ4aqEIkM4Yg/N1Evq1p5c9ywZwUQrF+Vo5byP68PEKfyH9aTq?=
 =?us-ascii?Q?ZZzGBLmE/ZGiCwpeklHv4p9tmAwWCz6Pvet1jYoRe/iWHPnuB0LsfJzLU5mH?=
 =?us-ascii?Q?3m9Ohxxw9MJXC9giSaTEfvcJKrFQ11R1o1qZXLOe+0DPDIrO42JCgK3C0tfI?=
 =?us-ascii?Q?HZyvqMFm7Co+NyXWdQcwWFY9OThHF2Si3HUhWNSC/kdey9wD1xo4UvRXl6Uq?=
 =?us-ascii?Q?LbgXHi7gn5I6sLkKGeKSeDxuVHsHvSF4LCTG0ZPZx33fjsULNNZINW9I3YCW?=
 =?us-ascii?Q?aA/lWAzd8vaXb189xGjCOmAvGyvDMIbaquQD0F9qVmRmV1Yd9zBj2FX9ARkk?=
 =?us-ascii?Q?8jU4lawNkDRczqlz944w9Aa0RUsHcAjrU0dM1b8D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb86adf3-a852-48c5-5158-08dd9e36fb49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 22:28:34.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imwE5vuFMw68aryUMiTxFTv/44Pk+qOnBTHe2vqwCIFHJvn3b889pc44ebWIrqzd9C0lgizZUNYjh/jan54O9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

Allow clocks property to fix below CHECK_DTB warnings:
arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80014000 (fsl,imx28-spi): Unevaluated properties are not allowed ('clocks' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/spi/mxs-spi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.yaml b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
index e2512166c1cd9..0cf8e7269ba99 100644
--- a/Documentation/devicetree/bindings/spi/mxs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
@@ -24,6 +24,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   dmas:
     maxItems: 1
 
-- 
2.34.1



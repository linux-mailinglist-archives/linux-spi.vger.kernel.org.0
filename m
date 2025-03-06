Return-Path: <linux-spi+bounces-7067-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF3A55282
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A9E3A6D95
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E923DE85;
	Thu,  6 Mar 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T1MdMGwN"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DF25BAA1;
	Thu,  6 Mar 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281012; cv=fail; b=S8e2i1fzae1F8QSkwBUqlo4tOHH9Jv43FlkUyIoaZDguGIcEloWLR/3ASH+AjsyrDFyJEB6oR+p2iV8fHz6hucc7jccobxkSJN+MJ++WzkWgizDGLnml/SqFtw0bS/FUTXu3D6MLsXklRznNMfDJP4YR9aNMmNVpsnzu1UqonZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281012; c=relaxed/simple;
	bh=fERARpObr4i3C5n6FTq6YQGJBpYN51S8tKUnLLpv6dg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mrl0IVWCzb6W4xTQMkhQJzp08JUJI/4FjyP1iZ2aBf1BhDlKyuzijQMIz4yKcI5vMQOd49WA3KzVChF2VOjQdw41vTKKGWX+sC8CilyPZPEOarHlM/zAsB0hEqwHkryIqTRhexvJMuEldtcUqiPpGzZCUubfQJGcHc5TJ3xDT8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T1MdMGwN; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAQoaLMEJ/s+XWx6/i1Su03DZnlAugiUaAhzaxw4eCGoUzI/FsyHxpGOZMtVjQ8MzEXR76S1P6D1J3Tov1HBGMTad3l0ov+Pok6MwkJEKBUO36jqJKb3DpAAQthWebX36odaNIRqvGkubrKcRx30SkfEfcEU5XAeXLoNU+qiqGD3Ibkwtt7vdJGUIlQIWxTOEeqWSYaTcqQFQT3PRjZBn3PmjRdTTLlkxj0fYdjtd3UrNs0mpG6EzOJlQO0A4mZfGQuam/EM4Nn3+Gzhp++JqcrZUMW1EhD+N23uCihYm7gV7leAk94Q9rAg21s6kkoXbjkH6LfU3M70cR0GbNkDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9rgyXxhg7irswsq60sH3qRZCVaFWxQ53vPljrat2P0=;
 b=h7mxUckKDAqRyFJyaRVKkGElROtXqh95f9vGdKDNAQHcHGS/I4DbmDMoNn8YJ8ME9nUUmzRYO40W7bTACqyjaSetiySk8PUxGtCsJujhPEOT/CQAyj3e2JEjqHyOKIlk1RfCA18kIuICZ7pRFuDOaD/DBny1lrpvxpHZNr6eY2CbVVRY8BKR+uiAjCIM6DkqXzDzzN5wtIxVbKKRJGy3WoEWwvZL+uRMLXfvuakecWR9FGWYKwUoO6VTz+xqg17q/ttFHwwcHl+Ta7s+xGqVZW1F2XkZWrnVkQbX72iJDJ/gRaiWR3d9riTA8BqlpLaTKF6G3bUCka0nX20Z5KB4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9rgyXxhg7irswsq60sH3qRZCVaFWxQ53vPljrat2P0=;
 b=T1MdMGwNBuiBI/os2ySJrH1LSFj/GjVvMXYbaDwTyAtT9clBRVTCnV3Cks360pLZHUwJqT+KcCG9oKuDXynNIcLergcQpCtJQbgVVSGmJ3cwwWv4DYyJVaDl0lYySg00GXODQodtk6oAr4AUqvI3BPXF8GwJoFHpbJD9EVCKV4HXa144WHD3sMzK81oRnhwrISTG6Dzl1htcC5Y4JHtJPyCwwP3Mt0W/75k1ZE9WuUg4kxoPzhKCm6f9N8YRqJWIrq3bwCYbuLD4LdAlLhA5RQ4SRCfKKO3jOihCyGOBf6w43bv9Ih5Mgxfn5fp89LyX9aCWTv2fqNyBI9DyQstNkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9179.eurprd04.prod.outlook.com (2603:10a6:10:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 17:10:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 17:10:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-spi@vger.kernel.org (open list:FREESCALE IMX LPSPI DRIVER),
	imx@lists.linux.dev (open list:FREESCALE IMX LPSPI DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH] dt-bindings: spi: fsl-lpspi: Add i.MX94 support
Date: Thu,  6 Mar 2025 12:09:53 -0500
Message-Id: <20250306170954.242707-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc1171d-ff74-4630-19b1-08dd5cd1be58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NSXkN1AZs2wfC/1m07lz107wzbOytTNPwi77BfhhenC4i+n7R7CXa0Y2BWmH?=
 =?us-ascii?Q?nLgUpk5P3OAqKP73enCjjfQ4hQkNTOarSpCyvselbUERKMnXNGNFOdssncM9?=
 =?us-ascii?Q?mfnokz8Pr9h8M8tbDZnQV+f1m9Xd1mIpQxX16i3sKLEKczUGq+VihRRQVvBH?=
 =?us-ascii?Q?ZI5k62ihfpWwD0Z6eQhYD/5Jfv9ycqG/0MNvEKbbufcbLJnRPGbbq6K90IRH?=
 =?us-ascii?Q?DGpL3yy7Xn9fnmGJ2YSuUx1Ue4FuSXheFkp/gZ7x7FVbHxyT6/l1hG09mwdN?=
 =?us-ascii?Q?iiJCGJIWHcY1EY+IkiRdaWaHEjnzcEpzzmyqFuJ/HuV2Vy5ibrrnPyvhpobB?=
 =?us-ascii?Q?rd0/IBiIwIv2m2Dk1EoBs8uRTFAeb2bZe3jUx9SZ8usM8Iwvl9BWSMaGBkEg?=
 =?us-ascii?Q?rOh3sw7JhqAo5U675kvoY8Ko0G3PKli246IBDdjJZ4MzaSfiAT/Jh9ZqeKaN?=
 =?us-ascii?Q?3KehOkkklb8/nFqKtsRP0IEIxyoLbmT0JzZZzw7VMHro4F3D+7X2LiT7NLIJ?=
 =?us-ascii?Q?21betALmwiaiT8gSzXnVB8E3ejxNv/4EdrGZXKB+g2CqGaDRUqf4B3GUsIiI?=
 =?us-ascii?Q?odxoOcABo+o1veano8KUUO/+dAbJEvUEOdKx3HqM2Y6Aobi2nmCL86/1tper?=
 =?us-ascii?Q?OlWXfQswTIvdY3yL2XkkADmLdNWNlkzcI3zpbTvW73yVfoa0ekGl213aLEeB?=
 =?us-ascii?Q?5/aIuRgOerqwJfhWSHro7XlcmObI1QMWe3XU4IMLgmmDhpZh/dhTl/EOTUAu?=
 =?us-ascii?Q?1lB0qP2Wc98IxDZ1f2Ie+a4rrPP1pv0f3ZKlyCxxJlgN2cbg4+s4k0nd9Vnb?=
 =?us-ascii?Q?NMcbc7IZf89utFD1P6oBaUUOQiwZ1JZFEha9IHbdfA+HnVwDyMUhZGgrTDS6?=
 =?us-ascii?Q?6+njL2SryqfZS2kUHzvAIZb60ERNlGQRTKHAYi8vhg7TK5F4PdkG56N4cGmu?=
 =?us-ascii?Q?cKsXE1dFvuLdaWf+ZrLr7lDu7PKkJaSNaLvNsGTFUifi0udzUBg7ERq/Axji?=
 =?us-ascii?Q?6C8+a8nFxsXJ5PwbjzaFopW+Cy4VF6YEVipmSvmLNLJ98qKdnZisv6RaptD+?=
 =?us-ascii?Q?vvWKHn1xLlh1rHw0G4j8s9+i/NUC20XTs/nGAAigtpqQpIFF30cWm/VmbIta?=
 =?us-ascii?Q?QZO040yoqKoiBWoVZB+1rsK/PyH8vJX6yKhWZKBkr+MmTpIdPnr58Lj5MaL5?=
 =?us-ascii?Q?VFdvMoYKaghIMyYDFpmOzqMRX8b5Imb6mkWD0OZKMw5T2wWL1BDFDhOssA38?=
 =?us-ascii?Q?c3XoVa+XsuSJArEYAYWAkE5YInvOz8hPGZTyUp3Qn6BNbVHbQXtXluTLRZTS?=
 =?us-ascii?Q?wTwTfSMvyOVFXzkxcYaYITkJaBA1g6AztyMvAC2a6PeI91RuCRG3trnFkZB8?=
 =?us-ascii?Q?r005IpqFAD+J/inUNE9WlXPger/sZR5eop3Z6a/hY90vRluoqBFlWVsOKovF?=
 =?us-ascii?Q?LMdA4fgArPZst3COJbqxPSqg3VpmZjQIJpSrh8Rjc8TAewZ/55IeSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Su5/tySLPjKLe2XdDAMtRvmdd2WLWCav8CqrZWwXsM0CajheMe5Ed4RyO3D8?=
 =?us-ascii?Q?eCygidYA9lisTS1KCcuEDliYA2qd4GZsrnjPGY0UQc/OTRlKWrChMi/giVbQ?=
 =?us-ascii?Q?IBe81LdyY/qyKj2LdHNJY0Gw6riSHPkl3efEnz2tiuMvmNKmwDfrl2U+ScVK?=
 =?us-ascii?Q?xPamXnr4WC8AdLT0hJnZdHl85lspqq79EwF2s95XYl18JjDkNXrKz1ZdQVAs?=
 =?us-ascii?Q?5oM6tF9lLibkvamV71HqZrZRiIFXWRoek+x/ohSOfaIoFXnFRzxMASKD6Or6?=
 =?us-ascii?Q?ZDVxf1eFdzWd8ZjDt4YqoRuxldyZLKBxu1ZVi7CuuUlfrTMmkcAnG4iF0zJG?=
 =?us-ascii?Q?xBgq8E3kmvc+SihjIx7SzA3034zDN7Mp8nM8fIrqJ1ryLZdbmi3Qr/V+IIGG?=
 =?us-ascii?Q?Qj/nk69Bk6/FlLEIaENpiH628UETCM5IYfvIw/l4sZfFxMnDMp+1V9NIqkkR?=
 =?us-ascii?Q?Bz43sWOOV/dV3JYiQMAaF1q8UNmFXqHwZPRfmZHZcmvCs+iwVbwYxH+92YVI?=
 =?us-ascii?Q?hB0c3ABUYCXPmWP9r5qLyRJtcZVSu8rQrnch/rcO6fCVRGdz8dj8TfrGXIDj?=
 =?us-ascii?Q?WmLoT6rX5MPuBQsolQOffgfsuu7mKH528EHJ0sSJCbUZ4z9aUuP4mA+HuG3z?=
 =?us-ascii?Q?or9RYFLB8q1Z5TlDyUZOp/CnRufOgfZYaT0FjY7ypzeJY5mf1yPo5ABUcjTu?=
 =?us-ascii?Q?Um+lAG1rbSwgXxHKqTnPwdfADpTYFGfKA33uxowlia410SilN67JJ16MHDnw?=
 =?us-ascii?Q?fCW12tCNG4ldoQ0o/uLC4AXGCwR88dGmKUpBq6CbM/sYXd6PadHZq1w1pblB?=
 =?us-ascii?Q?xb04WoxlWVioyV86U6g8VEDlT7Q3ze9iP80+O5aYFgVRLJKmBlSDh2EpMKcs?=
 =?us-ascii?Q?FFfRf2TnlxBDx7Xtfw3V6q6hIcUl6cd5nxPDb0XPyTwcaiMQGlpXNmF2QnZq?=
 =?us-ascii?Q?bV1z/wfS4rcEJJ4NVllmke+ZObVxi4Kt7+QcR6NjQJitaWqNjGRFN2mqHBjV?=
 =?us-ascii?Q?yDasryhHzgJxcMIPhUogQxR0WOdGL8anWpECoTbzpdlX0yt0fsg59m19K5gF?=
 =?us-ascii?Q?12rlNgM+zBUUo1hazguqs2yc1hbnUu2/OUckP1vhxt9wgVYooyA/X9VVqGbq?=
 =?us-ascii?Q?3s3W27zMtBu99YFcEuOZqt4bQMGvj/7VdSIL2R9zIOvDCDQIUscE0JU+jNpF?=
 =?us-ascii?Q?iiUfw+D1igdthRu0ktI25H3OAU0c2dPc3p5PleNL33eqsF2q/wFNS6xNonWl?=
 =?us-ascii?Q?IlbYrslfkhu5P8mU4efTIZkBod5G5OYOMXOWs+py0hmzNIj+R/Flsu2Iep0L?=
 =?us-ascii?Q?4OR3nTeR+MXf2C0b4bi4We8VW7JaP5fRQeVAXbAd+HnCzytBTSkJR060Vues?=
 =?us-ascii?Q?baUZMrIT6OBl0xHmYyvC0jZA9wLmZILTf31QDc5AAXBTw6jG4xV0FULN8c1a?=
 =?us-ascii?Q?9ddug3IY39ls5MqmMuOXsOBupT1ZsxWbwjl4fG33pzc98ClL6erUD8C8kqIW?=
 =?us-ascii?Q?SfyYcfhKpuMZ3QQayLuOdiGTwB5sUXzA+8GsniQdSMWnQKCIkQOO1t0oLYkC?=
 =?us-ascii?Q?x1F1+EVyXlJe43gKgCtCY6paHoTy1hYZEi0itWfM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc1171d-ff74-4630-19b1-08dd5cd1be58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:10:07.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vvbGX1oaqJDl4w6bM+VZY3YyXI2TfWqmyA/DLoyN5lWRxwDxvac85f2j4/VRylrdxu5rDyoKFxxEOd+6RSy4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9179

Add compatible string "fsl,imx94-spi" for the i.MX94 chip, which is
backward compatible with i.MX7ULP. Set it to fall back to
"fsl,imx7ulp-spi".

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index ed1d4aa41b8c6..a65a42ccaafed 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -24,6 +24,7 @@ properties:
           - enum:
               - fsl,imx8ulp-spi
               - fsl,imx93-spi
+              - fsl,imx94-spi
               - fsl,imx95-spi
           - const: fsl,imx7ulp-spi
   reg:
-- 
2.34.1



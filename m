Return-Path: <linux-spi+bounces-4644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3953196CC3C
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56CE287C74
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D171DCA6B;
	Thu,  5 Sep 2024 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UhjJkvID"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4933BA49;
	Thu,  5 Sep 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499571; cv=fail; b=q2gKkYThhSQB3eDFWvm+KtBYto3Q6mYWn7Mzc34dEoeNhoeAYktIBVe6BbLZ1fYG543VWWqIyT84aEDXTsBdiUK7gPv0MtOZcW1wVGYOwgDhZ5GUeZqbtpodTJ9C/k9kYd/hzBx3/xMQyicN1zxdgNiRXHEsnRyjfhC4/BlMtRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499571; c=relaxed/simple;
	bh=5utcvPEfSbFGVK6m3qXpI20ANQCfKgNApKa10MwBziQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mg65KUKZDoTJGlm+mX8hKg5Dby5lzLRYPVigIiRrxO2mF4PwEkV/CtbmkUlafMfQqb6Ftv9S+KplWs7kVbwi5Dvx/HPazc0lXWj+rgc7Z+XBaAVl1+RjRQxdhUcw8lrCcc0R3UFHnuspIdnD0RUVvWMIQDJ5YnKBG6l0T+lGWWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UhjJkvID; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNkjADfyBenrdpy+20VSprj09de2nP15Dqfkqvt6Dv2JdyCrqTGdeOsncm8VrYYGKfRKJJGbSHug0bgTQ3P3Lr6FnBfgvBTiuu4RFJiganfYx+wQAgaayW/Mpx9crhdcX3MjJwxS6wQl7jaty9qvSxHe7Qa/86R9KVzxjRW0bn9FSnZbVxx5E4wpARIEibe8eIXWbJQnBQ6gaY/hmKEsVB59eKqa4X5iuftEWsoAdsUwL5WJ0vrURp41/N1+H42zKqh4s7KBJrjM0QkZXuURLrHJl/iZJfiF3MfG3eYiLNF3yvuSeT+s6R0rHsu7q3y6VtG0CqkpEuSGBT1XsDilTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkbIsKKXGOzqsVZkTqHOk3FD/BkwCPhkzIbBbB8eGpc=;
 b=cekXUtANS9pE1k9SMDuLE6Lz/ODr2g+0Dkms4OWGEL3yBEHaNEdsbuVDv+YztEMNgUyhWLLuDMhoY00EzDKfNHxbwmQk4v79YbMJRiURx49XfK6ISTcuVC2wT6oWv+4sNQ6dsWqRmciJGfPpW5wkW80hciXpk0T3mSTzIg/w7ZdeFm18gtDfkWW+6Pu+3tQp/mZUJ/tlVpzKFIzAYe+kcJt48z4XYmEBhx7RUdCmjgqH7+RmNdolGp8Dw4omALPhgw+6ej3C01RJ6wPM/tYjw3c7rZ751Nv9KdOtz0EgZM3BQdJ/j4xNCJCODHYRiBsz/+WHjplTvHFP+K/lIyKyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkbIsKKXGOzqsVZkTqHOk3FD/BkwCPhkzIbBbB8eGpc=;
 b=UhjJkvIDiK0P5crXzU17sFpvk2tHq1EMXF2qN5hB1CpjQ9Hk5TCDG+c/prImjbkWkEJGaLCS42qRPSzpB0T3SCP8MRckGF0jWkRKlF2/tWWU8aTuFevASfc+C1fE9wnUnzUkeYHEkip7IVbNJ1BWHt3oXwgTR0RzCj1WUAImOImu3/UaFMsWIYStzuPU97Hvlv5jgbKDzuVmmDdm4Y8hkGUz5qqXqpX0NT959OqOO7HP3do29iLwmRR12I9MJXwN11bs3EBqYxLBKeQFcpMRqwlIjLzMfSrkZWoFObIYREWxXu6Jh+DyO8PVPjQO5Z+MTwmhQq4AjKAr9HKEEXDebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 01:26:08 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:26:08 +0000
From: haibo.chen@nxp.com
To: han.xu@nxp.com,
	yogeshgaur.83@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	singh.kuldeep87k@gmail.com,
	hs@denx.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	haibo.chen@nxp.com
Subject: [PATCH v2 1/3] dt-bindings: spi: nxp-fspi: add imx8ulp support
Date: Thu,  5 Sep 2024 09:26:15 +0800
Message-Id: <20240905012617.1864997-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905012617.1864997-1-haibo.chen@nxp.com>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DBBPR04MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: a740cd7f-229d-4f54-ab0a-08dccd49b821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bx8wjhMVIcmHaL5TGnDU0EihK0CigozSnvZtABMnYsWZLUFQfQ+jbF/fhqN/?=
 =?us-ascii?Q?+3CxiwGaoD+DmtK0WvVFAnRUrougkalxGVE9tbcdWaLSkBlzV+sUdAJwEcKX?=
 =?us-ascii?Q?26+m+C94bvHylO9YmYF3HFfiWfyAHbwb+cC1+t2+kLiK3/qWZ/E+LHE4ZYQF?=
 =?us-ascii?Q?qkQjnJo63qo/ReMcQlkyZQvJ6rHo6GPZUKbo0hg3mO3hZPOoi46EYmvF8gXV?=
 =?us-ascii?Q?3V7j7RMAGn6gpJzNYGQAYQ17WYMeD7P/XtE4+LqCWihwB2gNXeKPaLp01itT?=
 =?us-ascii?Q?iM5lItP42hWkm8Y/a7HYv6JhvxauuyTD6M/taddY5u6E9X0Tw5ouSj6m0ujE?=
 =?us-ascii?Q?oeM4qc7gBovzZv3+k7CgjIEl+70EQmUbXyCKXnkna/envBLHxn6BfoAokidv?=
 =?us-ascii?Q?D3Cpy5aEwPJKgrr6bx/AtW4Jb5nkLKi34cHs9hxbmC+w7BHTiCUXy5I7flO2?=
 =?us-ascii?Q?YOj09TCtehIcY+AHmZ2GO9IRNzU6ulhYwCNYONakK+ivp5VhSroLz9SXfNHQ?=
 =?us-ascii?Q?7HSDn4gu1opsVh1CoMOhSSZiXJ15D8ID7YmaWgqewHXPhjbc1p44F8YmvidD?=
 =?us-ascii?Q?Jd2+nBWIoxn2pQCRNU5w+zyVBg4GwrkoFTWcP4iRyjkZkZD8Wrrb4tHZfhUs?=
 =?us-ascii?Q?YZBnMb3orOa6OHuJ0wBSxKjASkeg0SfUS2YT/1vl6dHtSyB90Hf+SE/VKOwI?=
 =?us-ascii?Q?0j5SJ3BYcWXalrT6VLWtAoohE4GGMNV0xpuG6d1Y/mXuNoM/9/bJ/p+3IzIK?=
 =?us-ascii?Q?j04DlGjozzRSxhzEBAiBg07JDoY5OwRRgKnRow2tExKjIyhe+jqJ+jSXdvpc?=
 =?us-ascii?Q?EagVfbpSlmZS/jfwhJwG+kNgWyxHsx9suBRgV3cDgTsxuWy5Qr2KsV0wNPVG?=
 =?us-ascii?Q?LXPnUDeDI4nbwP1PmlvFHtmJ32GrLkLqnS775vvaZqqU+UNcCqHCaSBEASD/?=
 =?us-ascii?Q?Q0GFVVn4a5lBGFy9Mm4A4COn0P3vOFZD+WlhpMK4erc7qM7oP60M4D9y5odx?=
 =?us-ascii?Q?kLm4LKdYi2ZqOo11ZmlyO6qPW5iwttW3JLURW2ESyL9WP/CBR2jfQ3RL6rzv?=
 =?us-ascii?Q?yh0215RhFalrmwPfj6nn5ATXRzFKoN6E05VD5JRZQhhsgfr/GAv1uqQoGyFv?=
 =?us-ascii?Q?8+1HJqi7MZTFdsUHw+sGfYFcj7refD3KPEpLLgFFkTZh8pTOTD+HHPIPRx4D?=
 =?us-ascii?Q?XV2ROfftOrz9CNfjfuBHN8ataM7riCs6nAUdTemP01rg4ojfoLB+JKDJ7C3N?=
 =?us-ascii?Q?AETz45W7Nisu7dLi4dAh9fH0KhM0JJsvDsTwZ1a5jyUqSsJq0eUJFg+uEfn1?=
 =?us-ascii?Q?co0oYMZXaIRhE8HEQE/6/RfLqrbFYrQcYnUWnbl3fjL6Y2T+wso6H1IAzmS9?=
 =?us-ascii?Q?+pW0g777VhAdMoTal9kWbeWIH6rmUBRPeNpLhSkSVMR5GIdvtw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aFKk1zFhbVPumrDshqP6Yate/Ku33Xa8xbyg8nVJeYdtugoVgXy/DMKMDhXe?=
 =?us-ascii?Q?GBQtda3HCjcNOH/rNYDg8MgAaHhCqn1iyTkcyyV6jXNl2bLzAcucqoiwoaxv?=
 =?us-ascii?Q?vs9fPqatOITF5gmGJZIfqJHD/czHX0A1qGiXP43zjCxL61mKixGsV6FFZfMs?=
 =?us-ascii?Q?LF1qEyOgi34M1rRyI6UuzI/78zFFIgf0BFh2tejGTVLGTYZSQUxLo6Icv3fu?=
 =?us-ascii?Q?/cE6OVBMefUF8b4Hal4/8mF5gijkw49v6Jtpo7A6nsZQbBKno/j6beDsOLRL?=
 =?us-ascii?Q?PDIFOSToIjWH2JXjjbXrVhc1wglUkz81Ba+oTeZLKle5B/M53f2l5ht6hVhO?=
 =?us-ascii?Q?lDvZBgNI9ol8BJ+dngmAzIDVy0OmYLOyzEOLGZYmj8StMT+mOr885zHRCA1X?=
 =?us-ascii?Q?WCKEtoALLtY8OK2EuGnrpRUb/bQITOWpOj7M302zgJEdXpLZtS+XbmAUQImd?=
 =?us-ascii?Q?tt/edfnZvOUjlM/n4vDI8z786WczgFTpLkZcEidL3nftg5xb6WC0ir20KWVx?=
 =?us-ascii?Q?azXUrU6B7jtwzQGXdcvJs1xOuFtjy0oVibPflkSgPzXDsdKW5++cEK9KBbww?=
 =?us-ascii?Q?4dP4CYkbQZAfi1//RBUrkGJxqMoSIGf6aQloSHBYm/T305b7CaFAoAAecPQl?=
 =?us-ascii?Q?xf2s2++sJeo87H+PN527AxH2+UQUV6KwSBGv16bA4B0yTrfZWJMdyVHvBw4R?=
 =?us-ascii?Q?hK0fQy29olgVZxEyHHeFGkXBXjYVgH1hY+j+gZIVA1kaIbtOhgammqRKtmcJ?=
 =?us-ascii?Q?qtzKthRc46DlN+cGIq3Seklx8YTneXfXJDL/tEQtvtE5aPx/1Wu6Fo9Cn9fM?=
 =?us-ascii?Q?wfHvmR4X+atrahzLQyjYQOD7aQFbwHdYogM06GVd2oShOoLdulZ/GxKSUug3?=
 =?us-ascii?Q?l6N6jdzBQWV8NV9uZiStNkQ0VNH/aECSQLqxF5myiuisvSO2+7qLQKLmzhsB?=
 =?us-ascii?Q?S5wvH5zj2CWdnROgj2nLjRDrO0nAcn65jGA7B41OIyTN+qWWhu1sdjqLbO8J?=
 =?us-ascii?Q?pitPo1pHQP49ehxxbnCtyof5ly5JsK40OQSGFsnKPMLKevQChRx0t6uU8BzC?=
 =?us-ascii?Q?eWmDaeN4cXO8tvRe4rMS2SHrxVgdKmztofWNDfmNrL9lUJY3qTbtuXRavWcp?=
 =?us-ascii?Q?rx808ZUcp+6tPbwa152sVHxlBHcoKQxOIiOQirlFBfe/JasoiDBFXjC55e+G?=
 =?us-ascii?Q?b/d3vD1GCWfhMoUypXm0Iwbyg/wgzpyrG3mzfOw7Kfenb2tvz36sLwZEKCff?=
 =?us-ascii?Q?Cy6y/eBZsDYr/tEKX3ixPFBcs4V9jzfT7Z8Jevvl0csdAZzYMJ9dxwcmF4+x?=
 =?us-ascii?Q?G9R27mUF1z1DfXwffS/i2YvwSwepxQ/4qe7hn7GE9qe1zlA2aWmA7sC88KH1?=
 =?us-ascii?Q?boUQOpcHjkurg7k1ar1zRXdjUJE5trBrhs5aTum0t6huES93chWRxSr6jEFx?=
 =?us-ascii?Q?hOeYWwnmgev9ZUFQaljV24AHuiSMyaqHwy/fIRGj4kp6arx3swXdIE9BnHs9?=
 =?us-ascii?Q?OS6em4zTa0u7TNqD5WAUgCL4GT9pPfFdzSm/S2W+tJGoWj055fI+sh1IXTR3?=
 =?us-ascii?Q?KOBm7803ihIIvNe86WTnJxO6gjwh0KYwWYMp1zHr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a740cd7f-229d-4f54-ab0a-08dccd49b821
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 01:26:08.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKrBfS/99V3fL6Os8THzp/1fO3nEyCM92cgDxwkXMYcGQyFUrPGyXwcaFUEEDpKVdLK1wbYFsJ8/bgdG9kqM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7497

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 number of LUTs, it is different
with flexspi on other imx SoC which has 32 number of LUTs.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 4a5f41bde00f..902db92da832 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -21,6 +21,7 @@ properties:
           - nxp,imx8mm-fspi
           - nxp,imx8mp-fspi
           - nxp,imx8qxp-fspi
+          - nxp,imx8ulp-fspi
           - nxp,lx2160a-fspi
       - items:
           - enum:
-- 
2.34.1



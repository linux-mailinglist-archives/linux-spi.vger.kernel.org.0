Return-Path: <linux-spi+bounces-10845-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A12C0D0A7
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 12:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C735B3B89E3
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0882F6922;
	Mon, 27 Oct 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A7blTARr"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DC2DE6F5;
	Mon, 27 Oct 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563069; cv=fail; b=GDMy3pZULfBuvuxdQB1CNzkTrwWPrevsO7Yjv7fXbf42xwWSfTaTnsMXwWkxH5lhOTbe3v865CUe07/XVgxk/mnLqHm5zj/ugCGOZ4koy1kqtZTFnwlZPYK0cIck4EaX84zB/osWWW+PAIZt82x3bZcMF/znPax9EYeBXFevNYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563069; c=relaxed/simple;
	bh=KEPsNHEVaSrAMFLHjvzSwBfgE8fwxgDdRheRaKvFoJk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IsnKnHscLx8Eg9CiU8umpN50mtPuGzqzyysENTrmkPzkqQY3CKTSr13vq8u80a5mOj1Opkb8cq9lCzO1fR0daEtkAcUfuEpAw0BYY6m/lGoLFf0jmFNSvtEBQebUTG8qZTcKbtJ0ClqRl/xdzoVrWiiaepDQ2OKO4chGk52HLk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A7blTARr; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWrzEr7YYoicMzd6Xf2cnt3m2OtLDWedHlS4Q4WO0hutSpN5+vwRqiw3q1S0psj7DE22qke2rVZJrnr4zrwlhN2X6AdXtgJvPxuPLjVfvghmXOj1SV5oMOYlDIzEBMb6tMdszTJtoccg7971qgZCHXqaSggc+c3SXizgmmVAQsSSbO3aVBjVQqMT6y+IeAiKSfG3ysb7UWNDCbVtJWXGO5oMLnZ40jzWKQJIR8YQhWI91g8ina4F1U0caKPpynEPqrZUkf22ZasYSiRyIMBtMJFjzHbhH8y7wGVVOHv11YXMDD32pOO32DA378dO93a9VydMpuvsxYurQ7APfsc7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY8KTf/SKIloNouMH5CvNEIHgJ6dIEi51RFyjpJNQss=;
 b=Fy6PdfprlnFKnV+XnTUwGql1A4VOHOAVMkpbWtI/jI0clPsNpmke8Tr4FcIDALiFaYMf4Rtd55bvWkBS12zVvx1+VtEINudtA6RWeb2eL59q2qV0hb6RJ95pi8DCd+Q6d65CDwjmUuu0anAjQgQTAGThXKwQWOcgV+4E6VXh/AnSvD/29+A0wUK6WEFXWWODUgWscTsC8YLaOKZ4Ac7urHKttHD7fey+JFYbZFqdEvDHIrHkaN2R3UAboOjgT/oMwHqcS4P+FgrhlWEcnhSU2119DdC2xyuALZxnKOQQVa3Z731ruciqvdc7Bs76xxn/QSY4OwPmpwfftz+u8qJq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY8KTf/SKIloNouMH5CvNEIHgJ6dIEi51RFyjpJNQss=;
 b=A7blTARrPqJTAUcQSCFY8vLi8in/VulY/fuyDKHyQoTQREhGeKFex3BUb8+KMc7iVwIgugXctvlAPflmkPC/zS/gl+hJWL4MlKCFOHHGjG41z6MZYS/R+BBEM00BLOJIktNk7KY0p+obXt+nVqbOCq6YwPOHBW7keulJ5JNuIEC1HpIzMzm+/oBqGuSuYDASV04eX2GevH1nhY37m9OkGGhuE2sPM3mV4FOJshNJKMc0agBnV7osGPje3BP/xhqKc1Rj6PajL+BWYDTAyq9xWQNm1eSfjf7e56LHN6NjNwQ1HzjXnET0UN1iyKXFPZ/WsX4/6l7HiJeRq/HOStgFFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI0PR04MB11955.eurprd04.prod.outlook.com
 (2603:10a6:800:31f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Mon, 27 Oct
 2025 11:04:24 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:04:24 +0000
From: carlos.song@nxp.com
To: frank.li@nxp.com,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: imx: keep dma request disabled before dma transfer setup
Date: Mon, 27 Oct 2025 19:04:06 +0800
Message-Id: <20251027110406.543370-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|VI0PR04MB11955:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f799f68-01f8-4626-ec4c-08de154896a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?THqGuEx/pfCqE8nzEv0vIOUq1m1V9BbIIiWWxIoEDRJJdIVgT2l9E1aEQdZK?=
 =?us-ascii?Q?b30T5RLqgf/5oY5k4phx9SliccY4m4UrqY9z/W8KVR35A/mKw7JG3vQznrBa?=
 =?us-ascii?Q?xNqeJStkmam2s11cX/fS/iPs20yydJwWm7XCrtWwzj1JycIypbanXNKmQDXw?=
 =?us-ascii?Q?u8ca/awu3G5prBVdLgH3bzqo1O7UzpqhYp9K0B+TZUgdhPiHIwSq3aNf4NMy?=
 =?us-ascii?Q?3XjaeidxSQ7hOTlaVpOLLJ3QGvpI26aYl6SIV504a77k1nFiVHCl89oL6EEE?=
 =?us-ascii?Q?9O/fFKnmQeTmZtQ/rrvcQo+x7CeqhOCDAdQGi1Smzl3wzSl5WAdQT00IEwrY?=
 =?us-ascii?Q?DiC/oGn4tXNFCaaf1u1wAdfcbVu+je5coHpc4ZezQDzJp4NqIU/B3bvweb/l?=
 =?us-ascii?Q?e2Hb9KyRTkEK7x04Yk8OrERMu+ov8qC6nB52pFOEg2JfiAoViwhfc/TzxSPc?=
 =?us-ascii?Q?Tgj0qdRAtBuGi1Tm57qOwDG/jNJQyidOASgomAah9mhf/gRwmFMx8E448cKz?=
 =?us-ascii?Q?vs+AHI4agMMuaiv4C6isMKnkqbnKd9UmHilLyS0gVWE6CyuYGD4wd3Iwy+O/?=
 =?us-ascii?Q?OdqkXGAKlzK1BvUNfe8FJe13ZVtKtqZMVcvSurfdnaOVikLVrcpjR+HV9CrF?=
 =?us-ascii?Q?pdNnGIiVUjNrNsqQNiwdpcorMSolcCNiAbsVf5Q25Oql7LO+QxSnMgVH9s/y?=
 =?us-ascii?Q?eiW14QfLydVcrevvIMO3ytiYaFVFbwu+fZ6JrNOvthY8F4ToiWDT+CLeGtNA?=
 =?us-ascii?Q?+SG8YUqK4VI4tMwquktQm5I6//35s3YKcmhebA/+MIT95qJtfgkEbv3o7jeL?=
 =?us-ascii?Q?bgvw++HNctBBDb9GTIwhMmqXjfB7HqXGSDxOtYg5dfSU1lR006x+mpgCYvCM?=
 =?us-ascii?Q?P4VkblArRViVdkTPRdoNkBW/SONYke4MgVVn0ZZjI0RBfBHu9++c9j3wFRb/?=
 =?us-ascii?Q?stR1MrSuMrkQqysTSqSRsnbV4GhsLDU5ya2NErRYj+N2imxA3ryx5JXKzz6Q?=
 =?us-ascii?Q?ZNxbzQwvvk0ed5BRml1evog/kK9nao/eZo3kY5+ta/zCSEhBrR3ew3oYTRbj?=
 =?us-ascii?Q?M7H7marPuS6/i1UvCpSmarSxwEzTpBdzOaEdO+c4TUd3oORs+SffxJ2HJO5s?=
 =?us-ascii?Q?KIfNonU7DJ6B7NFvm4j8PsiiOOhdWmMpCRuhTR9cfZxvAYK53bQa7LtUUMJK?=
 =?us-ascii?Q?WnJP8w/Khghw7z+yYwHaCp7A3ww4uUqzG54svcP7NgY+bThmzV7u90L20/iZ?=
 =?us-ascii?Q?ksyFTrmPhRp07gc6Lpq7N8wLayv6TCSvoPFPSd+rmeDnW5uvxDHFjy9b53RI?=
 =?us-ascii?Q?iU+PSa73K7hRjz3gz7OWy/49rOZwLbnqG/36bdgwv6f7iG8txTHdtNb5P8pf?=
 =?us-ascii?Q?hHYXsCayizKtzeQxU12RkngYToItc0Bt4yhw963TiKWX6QcsT3voFc/RpwgK?=
 =?us-ascii?Q?Jrbfil6rlNba/VW2NpuO6jjQCrQZMR0wkj1wmBTfmyiVu6VnRbKVsN4qXW1i?=
 =?us-ascii?Q?KWm+aThMp4c1hY5SUAkzbro3qTfi7bem5oYY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zn/7+WjoOw/81O47MPdetGEQXi73QARhy6q6oCP0KjrVwQ8S2jtoT1STivrQ?=
 =?us-ascii?Q?gNsMf9WuhrrDsDPlJJtvAz+dor5i+Mrn3I53I46A0mSLLUSmRHfbGdbev3P8?=
 =?us-ascii?Q?Ir07n9u/1i+LEJZdDXL57e8ceXCfQXkKtEZyOtlzaihGvbBuLg39VEGKpAuy?=
 =?us-ascii?Q?2ktT5X6Ap3+h0aPLZMEoZVuyzWgVe+tpZu2PEwkFE9DMxrsymthkxIrTNGMQ?=
 =?us-ascii?Q?1JP3HY5y5xb3ynbHvj1ZV1AZ8zCmPQiRmNIaqdijLgtIpnuXkbGeAqWs1GUw?=
 =?us-ascii?Q?8cYNQRan3fIVNuNZsMEAcVUlIXPvbX25tsZtqhTPzdDCXNh9PvxhZLGssE2h?=
 =?us-ascii?Q?OkF3pOgWbw6V7uffzf/zWZML7bnoRBJPQi3bIUBKby/BF2GvtyXLPIpVAxQA?=
 =?us-ascii?Q?6+DgDl292grYlgLCoFjhBZjZnr5IQ+YkZ56zi+nqf5smk16UwtzsZUpso/0s?=
 =?us-ascii?Q?S9NjJSgvAtnJvFQ/wxrGeOeiRJlqu/8PwYgp67de989zPqAW1dw3h3ml88f2?=
 =?us-ascii?Q?1aCC1tmI1K4H7rwktsVwNSCyUL6sXg2fN1WQjkqenUaAjNVSA+mZeRudbT+w?=
 =?us-ascii?Q?TVZMOrKpOTrOqy5+sxCD3XEGanL6NczuxZe0BLnzTrdzubcKPs78+JINr5sy?=
 =?us-ascii?Q?09mq0yNtEhcHtbdu7XEwpMAc93/TavoFwRFhi+LshU+2etAWN7BSUWp1izJw?=
 =?us-ascii?Q?BU8iXrelj1DVnqTqKQHqRcoM6+IuBcNCGqzJqjxc+b9yp2Hf/reHufAV/yvG?=
 =?us-ascii?Q?sDfOpVUFjAF9hK2iYgxvh29VJ9yp3ZmLWMybJJj9UDLQ+Nvx9CT3X6DO0Qkj?=
 =?us-ascii?Q?48xQJe4F9nYOZVZ/dYGDenESzWGrThdK87oaF7frJrXVTkr93N3m9v+n/aPa?=
 =?us-ascii?Q?9QPF0ThbsjXHuTgsl5CvfGYDJ0k16s+DG2PIzAZIn3kJa1HwPT3s3Nin/zNO?=
 =?us-ascii?Q?MpqAtgJ3bcBrQsdyykkVoRxhQgH2EmhLY59X6JC34ppsxS5lJ9dIWj5WP6lJ?=
 =?us-ascii?Q?NRUHBdk23nRcNjTEJwiHmbzDdGC0VMgDqe4pbyy/RE2ZL/0+TKxtQ+OsNu4o?=
 =?us-ascii?Q?l15sB95jethoaGW8cuz6qJNoW5Mh9A5BZarfUOSsZMzwZkNAFP9mZ2xThjJm?=
 =?us-ascii?Q?bDmvlbVnhj09Ard0xzYzb4eiqtDrkJ1tXcfSVxSk3TNHKJZEB8hL10emhiId?=
 =?us-ascii?Q?LQTgXc9YXuMY6skvsVPg6G6+S+RVmtK3U52J263SpgzTyDb44ZbLspnR7cMU?=
 =?us-ascii?Q?stiSsw9UcwgLuKQF2pGf5+Fx2eSLYPK8tRGGA1E39VABxWQdNR475JkViA1r?=
 =?us-ascii?Q?fKVAgKKwpStuWdMG9re9sQQ7oc9r0/jwBQeEylJxbyoEn2euWT2vUZXM9k4N?=
 =?us-ascii?Q?d+KudWGYfLzv1C/upekNV5LLkgwn0FOo6/zXlLKZTZwn9b4F2kSmZPTPXwPU?=
 =?us-ascii?Q?PI40QxOZFFJJ0oVq6dm//i7HZdBWBJ4XgbyXno35t5IhgZo5jMJgr8iXkGno?=
 =?us-ascii?Q?ONwx36JNrv2qhHYqWHTP+oDXurp8Uxz75tfWgl+uv0RnLLppiIXhW9O2stJ5?=
 =?us-ascii?Q?OfB211heMkXuf7vIcku3fR1FCCMxmkmX9aForpA6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f799f68-01f8-4626-ec4c-08de154896a4
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:04:24.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKPArF7ASMDx3Hrvarg81fd6uIsihhrmu40fxRj7M8s1kx3qEvmSmDj6tDJN3WloV8wRkwAMWUwOZjBfU0EsFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11955

From: Robin Gong <yibin.gong@nxp.com>

Due to a hardware limitation on SDMA event enable (ENBLn), the DMA request
must remain disabled until the DMA transfer setup is complete.

Refer SDMA 2.6.28 Channel Enable RAM (SDMAARMx_CHNENBLn) section:

"
It is thus essential for the Arm platform to program them before any DMA
request is triggered to the SDMA, otherwise an unpredictable combination
of channels may be started.
"

SDMA hardware configuration is postponed to transfer phase, so enabling
the DMA request too early may cause unpredictable channel activation.
Then keep dma request disabled before dma transfer setup.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
Change for V2:
- Change commit log with spec doc
---
 drivers/spi/spi-imx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 9a1113ea4ba2..00132f300e38 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -528,9 +528,15 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
 	u32 reg;
 
-	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
-	reg |= MX51_ECSPI_CTRL_XCH;
-	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	if (spi_imx->usedma) {
+		reg = readl(spi_imx->base + MX51_ECSPI_DMA);
+		reg |= MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN;
+		writel(reg, spi_imx->base + MX51_ECSPI_DMA);
+	} else {
+		reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+		reg |= MX51_ECSPI_CTRL_XCH;
+		writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	}
 }
 
 static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
@@ -771,7 +777,6 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
 		MX51_ECSPI_DMA_TX_WML(tx_wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
-		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
 }
 
@@ -1535,6 +1540,8 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
 
+	spi_imx->devtype_data->trigger(spi_imx);
+
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
 	/* Wait SDMA to finish the data transfer.*/
-- 
2.34.1



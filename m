Return-Path: <linux-spi+bounces-11706-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF69C9A944
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 08:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29F2C3479D4
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 07:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE03043A4;
	Tue,  2 Dec 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d4JIUxNJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE0A3043B0;
	Tue,  2 Dec 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662136; cv=fail; b=RFT/Ep0jLlRBmbEye0l9o0GwSeH14NuPcSL3bjPMwupWscT5dPO4ENm2AtDu/lBGmJzRyHPuMSo1I8maPBCzBxj24cJCGO9YJk3d4nugnL1POt67D2C1O485KEUjpenkGMk+FGlOpIMLuS4kZrmvb/H0FrF8uyk5dlv6j2sCGM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662136; c=relaxed/simple;
	bh=No9C6TOGMR1Fel5hEehkr0+srLGR2l6yTDRXEyoXwNw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=axUscrDQTHYyL1oTGpwJkAl4abmoWRPK2m2SlnCgbnKwFtFgkmyCQhUUfDf3vfn2V+58Zl2VvgEy9LV29tvZELsCobe3IN/nTYOi1qzVXUvroTxOFlc2KzgkVmWd9S/COO5TFS7h0W6IEsravyWQtqDOFhHp5TsZgvkdyWOWWmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d4JIUxNJ; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygoq5JXEoHPmSiCFvGTPUpTaMG0O9ZksZD8yWmApdwTziZmrLyubEmTa2VXvbXhNjImOVkEhhP1CMhrcHnqtfNXuRqySNTtf6BzVqvA5WZpgnCO5FnTySyOpPf/MrsuAcrv2UexpU2gBe+7a22mDYqpGu8Jw7n57BMKnBbklSDYo/4/rim1tJK5RUsIoU5v/xHQYPOlT4q9tuw42Oqxo+/XFPrXQzQ5h3gZyZLI4iJg9euFEXwd2ujDjZ+1/yU8WumZsds/mN3qY5PoFOXv0BEA+dl21o4cmN0vfvnReiXI/mM6W7rUUKsvkfb9wFfdUH76HjvQju1edEhTBBqOuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3hZtGxn+CsCqcnCM9WSy0VfTL0wEi9khXf6KFkaRTM=;
 b=Q2CFKf8/OJ4syrmIymL6h+hP+1+s2QdxRS7kQeP0O8XSVYDD76cmEg4ZUJZv8fdiieXNXFeigsAgNW5SMP+c6FOMCVD3v6/qL2WnWsh5QnXPIgHAR9BnpC6V8cn7UNlONy3a7cdxYrFtZRuCl6/zYO8n+/enBZE/vqm/Rtn8Q6KkahcJ/+Zv9y0NZu/0LDswhPB+wKeOANCZOmO4UIVsNrVcTlQEP9GM8TacEYnUwZBZOh86InbE3zxZMkYFIqBQ4UGineJ/+k6Omm2U7SmQ7v1jDP+uE1Io1JyeEW1C4sbGESdtPL00fwT0W6XzVKD57RZUCamj6hEWYss1A3DLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3hZtGxn+CsCqcnCM9WSy0VfTL0wEi9khXf6KFkaRTM=;
 b=d4JIUxNJLbw7B5CukmWDIPPqcXaA0njy7OYOjHGjExQqoM3g2zbWjHmRvpgA7pAI97Woy0fYVREJphAj0rx71nXG/sHeRk5dYbrSLdXLiIDyqY4JHE/R7wRypW6SvAPQDzPx0GED7JflcQEth1XhtLgEli9yePWso+tDntu/bapjUb71rfj6RQhbpnamRHuL3d0jsqIhNZHa6nzOBWrNV1rPnQQtqJJ5ztqodlaon9OruE9PGNaGQ3iyl0+tw7FKAw577w1laovQacU54HhohS7OztwqgnDlZN/mx5pVAqks9hGP8YnbAUOq/XiAt3LsAb2ZYMmhD67lR8VJBf6mCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by OSKPR04MB11390.eurprd04.prod.outlook.com
 (2603:10a6:e10:96::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 07:55:30 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:55:30 +0000
From: Carlos Song <carlos.song@nxp.com>
To: frank.li@nxp.com,
	mkl@pengutronix.de,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v2 0/6] Support ECSPI dynamic burst feature for DMA mode
Date: Tue,  2 Dec 2025 15:54:57 +0800
Message-Id: <20251202075503.2448339-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|OSKPR04MB11390:EE_
X-MS-Office365-Filtering-Correlation-Id: b439c94f-3f87-46ba-b957-08de317829c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zr5UHFLo9v22H90WIpCA2UpzrGhcuOopF2eN7xyGo3nC9IHgOgJ4tP3xtj2B?=
 =?us-ascii?Q?pXarPQyiv28MXmD2lY/sDMkcbFVHn4fG9MnUrDanyEjHE5U5QNXdfRUpKbW4?=
 =?us-ascii?Q?DwIyqKxmyf/j/WXRElySZtfbmsU5sVp6vWy1q9RaeCrjDJQeCTaO/MPUTznB?=
 =?us-ascii?Q?XK1sFZKpjRrIoGE+bTZIHBX6+Hh4QTICxiJb5lI/kevHwVJUsN2ZD6XdjeZi?=
 =?us-ascii?Q?JTsgYIARZJYFnS9IqyRlXVZ1NbDGtWumiCLvPfMVSVvYEFfCzzNYgy6PjMye?=
 =?us-ascii?Q?ENnP89qHYUtGhln69xFny3BMo6LDlD0ziSg2dI+R+fXjHVv1eu5awEBaOxZr?=
 =?us-ascii?Q?al7mcnES/n1rdBB1jUquiOYiQwmDJ8zbl4YI3hNlgM8hpbZYvfb4XGjLCk46?=
 =?us-ascii?Q?b5Fu73ibK+fIEQEqTqInopINJi2nx8sY761eimobC5LQvatm/J5dO8QRqNQK?=
 =?us-ascii?Q?3obUlysHsunb/sifEVuM9SlecFYO393Nob8O69FcrYoJ7JIgiHWJGbK5lx2P?=
 =?us-ascii?Q?4X2fkD2lsNmhp9vnERniAtQ2yFcyeqx4Xh7RFMDV/+UhFb/YnmMPE8VZCl4/?=
 =?us-ascii?Q?c6qb3dNl0Z21cSq1FFy6mFOjuZqW4iRxZl/fhklAIBCCpm6PGSutRoe4j6sa?=
 =?us-ascii?Q?KoXlPUu37oetbOjvNr94MABp6PAIN2/jKcMfNnvjlK0BXhjAssPcxPq2iCb1?=
 =?us-ascii?Q?qvISKm+vIKp+jZM3RoWSbaqlxWpiUWIcWOWSBMd7Ubn4Oq+7dPOtCmPCWSlc?=
 =?us-ascii?Q?C77s3A/jqPddI4tasJl4EDW3HGBQQ1P/soAupCQIe3dK0efpmjNHXBfDQi9X?=
 =?us-ascii?Q?mLTESi6BPkTVMeI1nHAR5C2RP5h9rFwFFYonJHJACPpseJz4DrXDJ9Cf7Y5D?=
 =?us-ascii?Q?aUSlpg52NDS8b2Q6U/p73lSm0zUB+19Ak+5Ur2DDcFkytscN5OP57S+no+us?=
 =?us-ascii?Q?KJGiRd/OiYa+6jUSYSVsz25Nl7FWtGB8GrLNAFsMhfr+O89cuOuSmEyBF4PR?=
 =?us-ascii?Q?NXQa7Sk8kZjzYcwtPbT23oCpYP+Z3XGrm+MeJxuui05pGAXO06sX+QTg6NNH?=
 =?us-ascii?Q?L/nE7IFbsRT8RCisW2Fi++90sYHaLtskhbATXqX1N11r1jiOIeL2yTFq+/Iz?=
 =?us-ascii?Q?41/NIBdMpJm1TvkWz4Y1xlt4QR85x/RE7pWtQERGi4he2X8gOWOcHIuIPz47?=
 =?us-ascii?Q?eCimiT489siALL0XtyNuBt7T6ftVHfoSxpns3dtpPOrAk4y0ma/gyPLAI1b9?=
 =?us-ascii?Q?S+GsDuh0l1modgJWedn0NLg9szRhqhw0EdLyEiU510EuucOxMH6UdVs9Gkf7?=
 =?us-ascii?Q?ZaNRmddO+9M1SAgb9hCCicJJxVoU1XqcAcD/qMWrrXv/sjRS5wWsoMXuCFWw?=
 =?us-ascii?Q?tTYUodYTkZh4hjLYw/RjnV2kDTrBLIqHFPTf4HqhIIqquLSkdeIQExskJ8wl?=
 =?us-ascii?Q?JYJ34BjPT08p0zD6XWqXOK6hTwSQpxpNy9qsmjefB/jl7zZRKYujf8Tphez0?=
 =?us-ascii?Q?Nl20ez3+viNajC7kHrMBvZf4nRevZ8OEeNok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BoyQL5yUnKgfJg4a7l9zuFTjneSLklXxmVHUc+EAttR/PGV2AAlwgr8ACSEK?=
 =?us-ascii?Q?OttTkVfIoik3GOdm/1sFVO7syfBpBH+VWJKr9jjngENbSpBvMsfnD5IQ0Ijg?=
 =?us-ascii?Q?FJywgErAtRN3ReJQcwg9W5tz90EQMs+ijwi7zJaLY06gKml9BTm6r0icrBSm?=
 =?us-ascii?Q?KN1tOvHBwTMH6oReLKOpyYEmDs5jdSUvQzd+n/6Flg3YpJOxMvXDiw3HAyP2?=
 =?us-ascii?Q?+oKhTCXLOlBtHZvPJDL3J2xvOQHneZUm8810R22hiNICgGDS0YMl89Yx07qP?=
 =?us-ascii?Q?nJpPaXAs6nZ1vXiMCGojnh7igvM04CN4QPIrspOwrogDlXbFzpOdc9h4nzqQ?=
 =?us-ascii?Q?h0LAdmUlaJXm2TcarPCQ7XRSKLDC1blC9gYIx7VCY8ffKCjRcnTzIOyCBwIZ?=
 =?us-ascii?Q?XTGvNnGJwSsMzV9nR90eZ2BmtT7iMcrGGxDICy0I7YcI6BNE4fn2yWSA9oHA?=
 =?us-ascii?Q?s4KWssIjKXobpU4L/+RCA1JBlgeMtTZ+BNzdOwaL/a2wKxI4fpdH6RBTWm/b?=
 =?us-ascii?Q?72INa+/gUq1/U5kK5LisSTfNizckNO95EjwliHRT6a/VJDCihepLWoKsxtyo?=
 =?us-ascii?Q?+6tWmI05Itkc7fHL8IyNRRxy5HT+MfPKNvQoifFAA0DWt80jYqV2p4dQECoA?=
 =?us-ascii?Q?Sqdg3yY1K0ACJUnFwOIPP5+P71XqizSizmZvdWVtFgYQaifa1UBQnaegzyUF?=
 =?us-ascii?Q?NZwnHfjswSQt5KTbxzasQChP+Hr8SxP/vD4D8sRY/Gg8wIYxZvQ3+ts/Q2aO?=
 =?us-ascii?Q?YWOmGULno39axcL6dWMXRm8ETSfPQpuLEu+xPd5QesL9ixtle84OFfXq0oK3?=
 =?us-ascii?Q?5suMrySx6QPJXlSlc+f4R2F00aeY/ayrYe2EOYNdtXEwpe+ayNswryQozJVv?=
 =?us-ascii?Q?GFydBU3F0z0M+UQFlV15Ijmu1ew7/Q5Iv0EMdRmei+2fEkFbmu0BUBSEAxS0?=
 =?us-ascii?Q?vOd+h5O0SAVyas16sWKIWDGUZRlLRPHTE2HfBFnG6N3tbkiSNyTTmVG+Ebv8?=
 =?us-ascii?Q?l+bnBoPULHpXILYneQh7L+iKV0pKfszNMmISynBGbzzNv8+TEj1RTV+D9NVY?=
 =?us-ascii?Q?jlNpTAUGUAF8Ih6Ktn6dPCQADeBRKuVWwkQ0WZHNQY/JXSX6gQWhkXWBSS1d?=
 =?us-ascii?Q?fogxjeH+N9yvtxcy2qQPs7PtRn64h2JEL+MjZQxwWk5XyePQ/ZPKb2agHWTd?=
 =?us-ascii?Q?UgMwtoGCWTzgODWUuQCJzUPRZ9ZXEGTU09UIC4ZuZlwvpJXLFS4BP3RQ08M9?=
 =?us-ascii?Q?bCv4SvoOQXtkfxtUtQJ5HrUBxdqGryFwLt1eGwfaBzj17AC/ncKQdSIKaKHz?=
 =?us-ascii?Q?rjDfOo+x7VoUA3qzcX3DzJlrLje3ZdYYWqwlk8OQgl1CGhPmJnHmMVyGqN93?=
 =?us-ascii?Q?rCWBGrJYpVSVU46+FRXcoAnIim5XYFLfBMYb6VJpgAcw2/jXOOPTsbN+tuFx?=
 =?us-ascii?Q?3ud2XkhBL8iF4TzUgf6KwSyccBcwBALnE6uIsHXoLumULaYLVOsyPe87YeCp?=
 =?us-ascii?Q?xIomDTPCaj0Ekt2GRGqsORQeeSnLp+GDgOiLwGgUKqz4y7WKAI3yCN/46xr3?=
 =?us-ascii?Q?33fYuiQy88kgMOG3iBMZy4y6k3OtFvs2j+nWUbhG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b439c94f-3f87-46ba-b957-08de317829c4
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:55:30.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qQePjN9y+mXmPHZwTLxfNDpL4fG4qzYGPFJkPK0Nf0lg4quQcC8HHclT/qs2DmjteBIEqyAtljrw+76em+qSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11390

ECSPI has a low throughput because of no dynamic burst support, it
transfers only one word per frame in DMA mode, causing SCLK stalls
between words due to BURST_LENGTH updates.

This patch set is to support ECSPI dynamic burst feature to help improve
the ECSPI DMA mode performance.

Performance test (spidev_test @10MHz, 4KB):
  Before: tx/rx ~6651.9 kbps
  After:  tx/rx ~9922.2 kbps (~50% improvement)

For compatibility with slow SPI devices, add configurable word delay in
DMA mode. When word delay is set, dynamic burst is disabled and
BURST_LENGTH equals word length.

Also support target DMA mode with enabled dynamic burst.

Changes since v1:
* Patch1~3:
* Add review-by tag
* Patch4:
  * Add review-by tag
  * Improve patch commit log
* Patch5:
  * Clean up tab instead of space for dma_tx_addr and dma_rx_addr
  * Add  __counted_by(dma_package_num) for dma_data_package *dma_data
  * Move temp and bytes_per_word to if()
  * Add comment for spi_imx_dma_rx_data_handle() and
    spi_imx_dma_tx_data_handle()
  * Use kzalloc instead of kmalloc(x, x | __GFP_ZERO)
  * Use sizeof(*temp) instead of BYTES_PER_32BITS_WORD in suitable place
  * Add comments and fix comments according to discussion
  * Propagate the error value of dma_mapping_error()
  * Use round_down() to replace DIV_ROUND_DOWN_ULL()
  * Improve transfer->error |= SPI_TRANS_FAIL_NO_START judgment for
    better readability
* Patch6:
  * Improve patch commit log
  * Add READ_ONCE for spi_imx->target_aborted
  * Add comments for data length limit
  * Move data length limit to spi_imx_can_dma()

Carlos Song (6):
  spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
  spi: imx: introduce helper to clear DMA mode logic
  spi: imx: avoid dmaengine_terminate_all() on TX prep failure
  spi: imx: handle DMA submission errors with dma_submit_error()
  spi: imx: support dynamic burst length for ECSPI DMA mode
  spi: imx: enable DMA mode for target operation

 drivers/spi/spi-imx.c | 625 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 519 insertions(+), 106 deletions(-)

-- 
2.34.1



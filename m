Return-Path: <linux-spi+bounces-10813-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25EDC046D3
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 07:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC711A65A89
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 05:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2912248A5;
	Fri, 24 Oct 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ShMGs6+1"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0626AEC;
	Fri, 24 Oct 2025 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285191; cv=fail; b=fe0DltTqMFm6yk8QKD5MPXUHA+54aXBMoOqRJlndQSg3uMII5HnGY5JTcfR4wgrXhdpfRWm4V5anK0jmhvPgkVzhaimMSJNgxh2ze6ZbVJD/5SAaJLHfegFHlyPvFE9u0ie6PozfrKcX9zQiDMEIjEgxT5hq7XWhQA1SYFKT+X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285191; c=relaxed/simple;
	bh=BVnRfjNY+G3T9//q0xuQQzPRkGDPTaS5ssWxqrrpUJw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hfAfJ/6//EjmHoildfTl5xz3dAdAwd5zoL9z/nmghHvaGeEmz7VOzInHruU+wYgXKjmFZuSxvL8OXiOHGMPtSKnHka9X0zSgcMGFtbt2QHon6djaleGJm9gPLFZjPDQm5dHjjySctR/lsDgdkY4nBmGqE/FqeonHpA1imJMaajY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ShMGs6+1; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3b+aoh/x/jTDgCa7zrkqHcgeA0StBs7Ht1HfPkDY3vZL7yFIgkwJTVscugzOFIfvERvSmiNqtIdr8w39etjgg6KfsrCPHkdG90jJEp1mJs2/xBS4+zb3nPc9jIRAHvowvkWNydsgEiUOZOJXK+oFJljxaMHE2eLJ74Bgag68yXLVG9/Yo7sBVqUgYiWFwqhphw1o0k/KMAa9q6VCbKUwx6CdzaWDj3D5/FdzmQzbxUAvMQoEbrrm5c4lyUVO96d9GSUnCl3Tr9S9GZRtJH2FNTZ7nCMSRHqQ073+awU6QDkwGc9MYTfdOG+YvQ+MA+j79Nwza4d1UfcJiPlsOZ0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9Jcwnf70VuS+E93GK0rKdIwK8HAXx0eXQ6TsOBg+Mo=;
 b=xGVZLEj6NQnLOYWvk8438iWv1rtN8Rdop2xb9M+QyBm6G0rZY2j38HQI0i9o0ReNeEwRnQRqbE6JF98Dx9VauPSO+1cAtf+bkNjQmCOzT8mCLhAu+9LiWktke89+RWZBNkXUdOOz88T5Xy3TONGXFV65KpwQGZAydTkrkSpGy/eSutEhF4Sc+uDjDc2w1/lXjHO1VfgNu4c5qiq/KCHyoohTkFecRfAeHfS6+8x4hOZaw/9ZPdzGn+MlMjYHLotZT+PkqyK+BvI1arm9oEc2e497Dx7sNLVgaE6hpL7vsGnX5nFHjqRGjgVnwL2cadY5jErFJ5oAXUEhUhRtbljuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9Jcwnf70VuS+E93GK0rKdIwK8HAXx0eXQ6TsOBg+Mo=;
 b=ShMGs6+1rFHye5PwuFff+wMrWlCVzcV+D/XEH99UZcCthZ9CRhQgQj5d4B9/8TDCAxvhnE4QOviwLaP6YH887ZZSpMRkidWMutLYGWG3AehUOY/vimw0Hyb/MSLu0yzMTfl7xMa+BI29eTaJCdYl4uBHTM2ZI4QOWT/XxMJXbqNumuBozOvOW6Ocm16mjH6h8gLuORerDTiugrjsAvuuSvrznMtugOQT5diKMZt9KsWdF7rC9IOF3j5SrbTJVe/1WgoMBgBuo2ZdfA4suYrQOXtYSeEM1VqrbEYhtwEKTPo0tNgDNg8kf7plR51SXsr784ZJ6q1u9maGJXtYw3f5aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GVXPR04MB9758.eurprd04.prod.outlook.com
 (2603:10a6:150:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 05:53:03 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 05:53:03 +0000
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
Subject: [PATCH] spi: imx: support SPI target PIO mode for IMX51_ECSPI
Date: Fri, 24 Oct 2025 13:52:43 +0800
Message-Id: <20251024055243.408461-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|GVXPR04MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 914ccb6e-55d5-4cf3-2527-08de12c1985c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tY7OpLBzCIYGlPGuIxljNNXWav/J/8lUzsURCPjw8wXMi6TufRW6Qnwn6Mj?=
 =?us-ascii?Q?YUroXsGRXI5SUEoXyi2HWuGDnC0FBJqgOFNjHu4MvovI2sn3fT7RDnN3KLX3?=
 =?us-ascii?Q?VjIM7eGDHi1sNP4/8yOovYsI8kF2rhqrH2FWoqMnAXpO1iId9ZDim3M1S+tH?=
 =?us-ascii?Q?FB5z6ph2ADa+Kn2xGYS4mYv3jYEQNoHfWrsGG4cC2UszeyWZDAFP+URH6DF5?=
 =?us-ascii?Q?DQLaVKDIxcJ4qt94LrCAbpnXZ12zImtI8SULXCUPbwBvfwzfwLxPcHbUVyAT?=
 =?us-ascii?Q?5NA1QavrnURbbCVNjpN91SXL5hMwK9YdQ5F4bBkl4icgPkrIOvriQArpRPLj?=
 =?us-ascii?Q?kkm2hFBMxnbbu++Ksj3F/tAZ7VzqldlxbtZku43wncjvOXaXPvCDc9O8waJH?=
 =?us-ascii?Q?uQzHrwmybfxCwI5RSPV8MCH9pWg09+1uj3pU03Ik3ezsRwZzrZJ9tQ3SLOCz?=
 =?us-ascii?Q?hGrj2hK/GBuHr7IpNH92emUAclWMjzi0NW6wpr4qP+038fS8d4Jjwk4BAsSZ?=
 =?us-ascii?Q?+xmhNMeox9Kjp57aUzcZn1Afx+HyTQDrQhFI/r//L28yxlXkchZyS7d5flll?=
 =?us-ascii?Q?J7aQjMNozEbaLVm1SCWs/HEvYphkSLKbthKEEnAEJKSaXZMTuu1j/TK3wUDE?=
 =?us-ascii?Q?HTJRotakuAp1Y4Oa020jLUrbSnpqEU7fGschitqAzyivamHyeXb+MIpAlX/E?=
 =?us-ascii?Q?PdM4q2CjjdE94QF1XAhfcfkAta6yUJX0BFf/s7lr6zXArbuL4kR12QvlW13c?=
 =?us-ascii?Q?TKos7Q866oQgeC54HcXn9ZGZyKU1EMMxVfZPqyOKwv78YqjF7TxkFap6fsOi?=
 =?us-ascii?Q?qDtGcMxhvYFj75gt5CUGY54HvKu3Z2g+tJ/tnMRAZSSmd1RI9EIdCjY6jsl6?=
 =?us-ascii?Q?YagbF6MahcJovVDNEWmKIWMeNAgiC1c2MH/YZZ4T9IJKPVxfXfrRrgfKpheh?=
 =?us-ascii?Q?GW1FO5e2KqVU50hwKKiqDLo2qGRhp5aZBpEtJmsZgvVfUGU+lcrPY488ofKt?=
 =?us-ascii?Q?56gpgGx6QMwcBxDN0681haUgJl1+P1tbnsI2wHRoReRnt4Bo2DZVlJ9ZGrQ8?=
 =?us-ascii?Q?Ih1kTr4FD9HZYpuDIi4rPvEqioqak6ydU6V/nuWIrRhb/VC2oEFl9PBeROxt?=
 =?us-ascii?Q?new+DBGsfId6hWrAnY4AIdw2gpim7giT+1m0mhsUHSEbaxL9W34kmnWU7GTz?=
 =?us-ascii?Q?IJYomYgNwWjq57ZEjG228D9/Zia+eUOsb4wZkvG4bMwoUGCowJuim65U/lef?=
 =?us-ascii?Q?SbqoW53dH+VAw9UpyC1+367cj8HHoD4yfbr2siQnwEB+1ir+OkOzhxoARkdC?=
 =?us-ascii?Q?Dtm0bLzh0x6ZPIRbfHR2hkr+V9iLJhIf3Z35cYWm/XyZWb/JAq2Di4aAvQ/Y?=
 =?us-ascii?Q?UPoQ0wVxh9vpYL9a4wMlDUkf45KDaBzfoKHo++p4TbORFmvalkP2JwGvnJ+0?=
 =?us-ascii?Q?5EyRtkMg3Z61hUiq2BN5FspmuJsVnFEspw8m2bi5pnScZw+8xsQrO1F83H27?=
 =?us-ascii?Q?yCg5Uf2kMof0xjx6Vxc60yRKul0DFKGnUEIz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hdNFVvktDwCfpJyZ0vyIVlsDR0mV8pTBNxfbtdgrPiwbOpRcHJ/ymgsD5syH?=
 =?us-ascii?Q?lxAjTOt7gpmNK2SQl4yAP2xk419osDN5xO56C+Pb2hASEQHEOeHnHwoltYuV?=
 =?us-ascii?Q?ziUUtVvMWAupqfyAIQUIIvZtuDEUoesMSPqiM0igzfHGS4ccqPYsO/rTxu+M?=
 =?us-ascii?Q?sag4OhTTJBKBBE5oP+OIEAOFu6g85XujKkgyScv4MIcacV/UhgMbadmaywGx?=
 =?us-ascii?Q?0CprP9P8TID8FBaaFP/58ufBFaMjRhXUD6z7UfgFajXIp3irPm2AdR0y2FCo?=
 =?us-ascii?Q?lkbWPlj+uZYxRwpOhl4l8JP29TKE3stygUW3IWudRejzJOcVf+nr5VlpWrLU?=
 =?us-ascii?Q?tviBzW2zlzKaLBgLd96No/1gS0IV/mQIvTrGskd0VXsjEgm3iuqUKFwOtdPW?=
 =?us-ascii?Q?u9IYN2it0YbSXX47Hp6wSfmynXAofCxz7ZyBoNnXztsDmDfWN3D2DKz91NYr?=
 =?us-ascii?Q?waUPq/dj67wPQKTyQ/VJWzi1H7kEd8s3JSJFgOAmVrTjILBLdF78XJ2+9YfA?=
 =?us-ascii?Q?s4uv7SPLEausKEtLvfSwWY6FIZmRv+r878bAsTXlMq9WpH2p9vZIGzNQMELV?=
 =?us-ascii?Q?Vmhxb5lHuiyiIN8urdPSxhgTFo1lqXcZbluAGtVAGWuOe7hQsf4CYtBnLvR2?=
 =?us-ascii?Q?NoqZrxtYHlLJb2hR4M4Gs93RlSbxI9gIBWqndyqMoCkHmFXzp8g1mhD+dPjS?=
 =?us-ascii?Q?VBhFTfGDXSitY2DmVGj7h7d5i6OtAYcq02KxlQkUzNeIW9hdcLYZl37mUdUW?=
 =?us-ascii?Q?649mXVJWOWTa+TKODFB2HHO0pDC/LQk0bz3clNODW+CM1LDY+X69f3MU6xH8?=
 =?us-ascii?Q?fXF3DEpgRCdZ2Y8QIVIZg08A2znHCeqMzQ7uxyRWuqM4f8VA8hqMIlPDKMn9?=
 =?us-ascii?Q?b3/vsEqi51mm/e6AnKLKr5O2hfc+lWWl614guGK1XAWFUPbz6pr39Dvszipk?=
 =?us-ascii?Q?HOXs5UNjnxRBLNHfofTnttdOwANMyw9G5Qi2Xk5sVjKuqtCpWxgv+nhzMefp?=
 =?us-ascii?Q?xcIuVyG7G1SNPUItxtCoryakHYuSkk0M+yi7SUzSAOARHnuqgfz7fn9rwXUz?=
 =?us-ascii?Q?Wztb3Vxhk1U59thRPlaH1lKU/JmtRFPCFztLYFAw4x1yWkoM7zrDBr4tkmlm?=
 =?us-ascii?Q?eOrVSKL61VfFV4qteikRLXmD+Kj0wr2NKrcZPpME6tIxthikRkmiNM6Ti98j?=
 =?us-ascii?Q?f1ayaHFIGRIpjZWl8VoGgkO28BxZ90UeSd4wqCe6m/d1FTwWbvUfwVjgTsD9?=
 =?us-ascii?Q?jbUtqjU9Md2nZt1Ux1bk+7fzSXX0ak5xn1lBWR4qKfqttbl8zuu6UGL6QWeE?=
 =?us-ascii?Q?FyfsL/UMMd/52hGRpMaVKB0+hcGOZDnl7C9xOAyv2s9La/+XnNjyPvUMIK+7?=
 =?us-ascii?Q?Eg7PfLxnlBLnQIBhjyP6G+NW8wW3y4gPhbCErJH4yG2leA48UScPLGThtpaJ?=
 =?us-ascii?Q?504oevVQxYu3Q8TV9fWc37I+trUSuMK8fuJtBnhTSfPnCgG8j0AgTuDELKI3?=
 =?us-ascii?Q?DDRFeSkAAoaMWgIDSDURZOFtbNwUeazmjR8gWnw1NXeGK5w4ORbpyjgCVFGV?=
 =?us-ascii?Q?lQ4wD+J8wkADHsCc5Ppk0OTbqIX6mc1IHsmEMlwl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914ccb6e-55d5-4cf3-2527-08de12c1985c
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 05:53:03.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzWs/fFRHv2wVTVc8DFYrMhWO11+oTeYd6myh3/uwSVty+K4BkDQlCB3vpG+1Vhzm5blEMfh1ZgrVs0NEnO8Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9758

From: Carlos Song <carlos.song@nxp.com>

IMX51_ECSPI and IMX53_ECSPI both has target mode, but now PIO target mode
is only supported for IMX53_ECSPI.

Support target PIO mode for IMX51_ECSPI. It can share the same functions
for data transmission and reception in target mode with IMX53_ECSPI. So
remove target mode restriction only for IMX53_ECSPI and move target max
transfer len to devtype_data of IMX53_ECSPI and IMX51_ECSPI to improve
readability.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6eb4bfb7be4a..cd40db61d8d1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -85,6 +85,7 @@ struct spi_imx_devtype_data {
 	void (*disable)(struct spi_imx_data *spi_imx);
 	bool has_dmamode;
 	bool has_targetmode;
+	int target_max_transfer_bytes;
 	unsigned int fifo_size;
 	bool dynamic_burst;
 	/*
@@ -594,7 +595,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * is not functional for imx53 Soc, config SPI burst completed when
 	 * BURST_LENGTH + 1 bits are received
 	 */
-	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
+	if (spi_imx->target_mode)
 		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
 	else
 		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(channel);
@@ -682,7 +683,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 	/* Clear BL field and set the right value */
 	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
-	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
+	if (spi_imx->target_mode)
 		ctrl |= (spi_imx->target_burst * 8 - 1)
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
@@ -1140,6 +1141,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
 	.has_dmamode = true,
 	.dynamic_burst = true,
 	.has_targetmode = true,
+	.target_max_transfer_bytes = MX53_MAX_TRANSFER_BYTES,
 	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
 };
@@ -1154,6 +1156,7 @@ static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
 	.fifo_size = 64,
 	.has_dmamode = true,
 	.has_targetmode = true,
+	.target_max_transfer_bytes = MX53_MAX_TRANSFER_BYTES,
 	.disable = mx51_ecspi_disable,
 	.devtype = IMX53_ECSPI,
 };
@@ -1170,6 +1173,7 @@ static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data = {
 	.has_dmamode = true,
 	.dynamic_burst = true,
 	.has_targetmode = true,
+	.target_max_transfer_bytes = MX53_MAX_TRANSFER_BYTES,
 	.tx_glitch_fixed = true,
 	.disable = mx51_ecspi_disable,
 	.devtype = IMX51_ECSPI,
@@ -1375,7 +1379,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	spi_imx->rx_only = ((t->tx_buf == NULL)
 			|| (t->tx_buf == spi->controller->dummy_tx));
 
-	if (is_imx53_ecspi(spi_imx) && spi_imx->target_mode) {
+	if (spi_imx->target_mode) {
 		spi_imx->rx = mx53_ecspi_rx_target;
 		spi_imx->tx = mx53_ecspi_tx_target;
 		spi_imx->target_burst = t->len;
@@ -1649,8 +1653,7 @@ static int spi_imx_pio_transfer_target(struct spi_device *spi,
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	int ret = 0;
 
-	if (is_imx53_ecspi(spi_imx) &&
-	    transfer->len > MX53_MAX_TRANSFER_BYTES) {
+	if (transfer->len > spi_imx->devtype_data->target_max_transfer_bytes) {
 		dev_err(&spi->dev, "Transaction too big, max size is %d bytes\n",
 			MX53_MAX_TRANSFER_BYTES);
 		return -EMSGSIZE;
-- 
2.34.1



Return-Path: <linux-spi+bounces-5009-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBD98864C
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1114B22D8E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A518D649;
	Fri, 27 Sep 2024 13:30:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2123.outbound.protection.outlook.com [40.107.222.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75512282FA;
	Fri, 27 Sep 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443832; cv=fail; b=AsBiHK5oyXqv1W8XGDN8bln4nUDdQiy4x0D8I+yfo02avKgM2MQpnTRj9cgiaMQq8B6OSU74nj1UzMoLJLVCnb9GnBysnCKR5/T3MWRZbfvkWSgLo1yJLpcwBAPK2gpu7CjqKhEarx0n4zzjGYTCPWjY+jUxtmTfHE6uQLcmGLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443832; c=relaxed/simple;
	bh=VLidko9XAWY/6t+iDh7YVOD9QlgjOsj+OtU5vuztUK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tgsl1cKiunz5GiGOq6Z3VHetNrpPkz9A7Mw9W+p3ml4YhpfwefaZ5CBPVuyr7+4cqGuKlTR18ghdD9ogbeRoLnEJeMUnU99PdM3O6ip7gWtXDbfOYTSahvVJLZRlK1CrO1dgBLtgvYtrQTk9T4FlO4z6i9AlWpWdE+JWguSis7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB/SbsGwRopwuyGQs0UFHiffeK28f4asw3IssI5XvpCMtBd72CuFVBHF27T/qnH6Nh02PfGTOEqpKxgNAVf3rTX0x/4fk3C9XH8IO86trdKTnJ6D860+eRc/HlttcUb9bD73lDQgwWHfSwteqkw6t7DttNBola6DrgvVCG8npJp8nVwak3jROVVu5/Su+L2qi1+qb4B3yaPePveVaIsG0txoVRxspFu/e61F2NhA2/BPrJpxKLLibn8e7AZLXofcomSM7gyPT0Ab5hwyt/j4xB3F5qDIHKOajiJfM6hzpCdfd8pmmIro9JI81zGSot76kv4c6AsXKp+7JbCdFevasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdDqcPmH0MkP8SXsGARMMW0RJgtCReQj2lz3w9NFEbA=;
 b=XcwAtar6d5DaVu1GXSZYsizZ2p3T7QoXlSTsRI7jjPn0DxE8yDZlngRKrJBaVI7xy2WbPmoBn6sOSm10dCuT25Tl0bjYwjXKU6q1QHb5FULkK0zeV1PoRpSdnDXmcQqqpCwxGt3Ngn4VLdqe8cJZPikIZWIXHULjjJY9CFJlNhq+hf1sR9CaoU3i36sQSYPAxtMQeNxsY8wxR23O32O11ZZb9w4I6MoHtTHswgbcqqX2H7yRcdbheFoOd2QtH135xb7ZAtRhUJqXEasiCXoCq+whZmVHSLIz306A9EPk5K5a10oD9DqIAXzCeT64mUilAqU/PTqlhOIcNYtg4TEQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB0416.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:116::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 13:30:27 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 13:30:27 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	broonie@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Han Xu <han.xu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] spi: spi-imx: Fix casting warnings
Date: Fri, 27 Sep 2024 18:58:34 +0530
Message-ID: <20240927132944.19285-3-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::19) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN2P287MB0416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7751fc-0586-443f-ceee-08dcdef88cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DoXkRprPcU8ikZhBikkcMvthfb8+94XE02MjBX3Ytv8WY3P50QZYX1rCsNys?=
 =?us-ascii?Q?3rsNT7lJ/TLCym/q6j6k4Cb4PXfTnRU0tzi/la3W9OeRRgnn0Rfitg4e41gx?=
 =?us-ascii?Q?LrYpzsVFypUZJKfvGy//S6/iEhumyqGtPvg/f2YgPZq30lbq4D9N6VeM/zYz?=
 =?us-ascii?Q?wRymUzks/p6ANg5T2y3tCDtKD6OQINGtWGb2D2BKm1AD4hVG0urt7L2OlG6s?=
 =?us-ascii?Q?ER+Hlb0ADSzXVKadkkDcaCBjXLJdx+Vwsr4Ly+EmsKIepoxLWHTJGbFYqixg?=
 =?us-ascii?Q?fr8xRHb0MgSbgGFaq3L6ZHevwVE1PL4o6Kys0ehKcBQuiWL3vnaSFRaaAVke?=
 =?us-ascii?Q?OZ8Asja3UGMYFqOzpAT/XKQEZKiGMYj1fGsMGgF0ov0f48wLLTMSDCFSO/gL?=
 =?us-ascii?Q?HmH2LEhFsCSSa60j/aI5JbceBmsVXoHVqCnfctpG5dNBGigg3Fl0CNa/DTZs?=
 =?us-ascii?Q?9vMqseUvqblGQeyGZ8yln0oefTWsvAp19Rm6+GyZFX++XpPhjLw3HGMJuHzp?=
 =?us-ascii?Q?1WyRpfPrzyqsYlNcOjZvUite1xkY0t7Hw2WSIDBgTxhLkWcMUFOqVuUHwx0l?=
 =?us-ascii?Q?1ScI9twmirAoClqi/kSTiY7kbdLAIFIfRTcVoWL+XPjX2lrldnPx1Y14VC4W?=
 =?us-ascii?Q?RHN8pQih2qDzK3EF169QVxFq2E+77WX6g/h/m6xNhMV0U28nE5cUwOIaqjqc?=
 =?us-ascii?Q?y8SQd6JWUDDUI4mnuA4IEAwOLcqGzfLDs3536rB8C5+6zTunkcQyi2uV/iTP?=
 =?us-ascii?Q?2izKgDh9bA3rue+Kf+L71tFL9P1Eak/orl2cDYPv9WI97j/CYuWbl2IvaI2e?=
 =?us-ascii?Q?b0WItSgp5Yk+N7G3ya9b+ct69tnqLfnAb4RhqZZwGGn8zAGIK8VrtTIwOADP?=
 =?us-ascii?Q?IEC8ITTNsO1KArAECyx5f6ZjC9gHLwRm/m0HlX+wcA2WYV70RDTceyfGfKWa?=
 =?us-ascii?Q?unpIpQFTZkQ3Zp74GK8fp1xzHDoWU6/P6LLK0OPb0mv0mY5Yk1xZFtl+N5wP?=
 =?us-ascii?Q?VYHrOOEt3wDE/zgBPmxjhrytttnIHNhm2LtSyNRoUZSVp6aanV6UwzC2680h?=
 =?us-ascii?Q?WekhyS9mUug8LzygjSXVsZM+0MF3LtWcn7ZeezZFqMcWfJItGx2gX9LQdgi/?=
 =?us-ascii?Q?fz83DwMHwRmbG5NspQg6h2sQaZo1hKVSEiU0ko3mGRrnwHbDmylKfrX0RQDq?=
 =?us-ascii?Q?aESSh9LgY8eaMyOvbfr5daticaoQmPSlelNzh4/IYIdRpzujiuTioC1h9yPW?=
 =?us-ascii?Q?gt9ebQTpLassYEDBu8bVJms5VBmHn2pOSNOfXc2nDB5rggmTJNjuxg+SBlAT?=
 =?us-ascii?Q?+RyqJ4vnx15rUEW7VtZ1oFA5T5JdE5b+HMNrUIzvC0j63pPxf2NUnUVGZtNg?=
 =?us-ascii?Q?0pL3zTkaHV2qo01ehFJnZQk7F/jLc4tWkAcpovn+AOwsx5l2bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWGFAbtwMPJHSLoIJ1/smLr1z18rfcsIgJJxpdrDNLWwYrJGP2nc/oZGIlQV?=
 =?us-ascii?Q?2Hm18pahaoZwfuEL3aciNFS57zWd8ibhGo7b81nWTMwyYUqQcUx+t/qC0PWG?=
 =?us-ascii?Q?OEyffIRCs+/Vn2v/FZWxTKOStwDUsAkBFuIcaes/WMbBtiEKwXpyvgj1LVTz?=
 =?us-ascii?Q?0kXk3oYBctBG5cncXATFsgxb8EmaCK59CNMdVQFJyedj1vHEE7WJo+y0Dv1D?=
 =?us-ascii?Q?gcP6AqHF2S/cQ1RWs+PqUr2VMNh1lvwlFRHGnx/fkS+0ow3qgybEuJKoZ+8l?=
 =?us-ascii?Q?l7Qq3sJjBeaq+RqY3MJ0H0NNKu1uP64MeS0ZUileg6RJGJZ190zvlu9YOpkz?=
 =?us-ascii?Q?lCCXcsJjRqlJO77IilRq1IOPGH8SgycxTTgE8Sk8F8rjhUF/4BnojQRTTU+Z?=
 =?us-ascii?Q?HidBoZl0y5cT+ECCRAw0nyHFnms1Y3PmMkk61NHRxShok6o3m46qb4H/HyOw?=
 =?us-ascii?Q?a5ufdZ/8lXUtIJMl5aOz12QFPbXe6qK9N34xMEi+cP4VGqtObrTSQcJhYg7P?=
 =?us-ascii?Q?gumMD4+g0C0BL2mrcpflPiZ5KAoaRNT3c6O0mie0CmKHn6uBxi0JmMdazUkV?=
 =?us-ascii?Q?Wxv3COcXvl4D/UsF/Z+EXMawjOPT/N2cABgqRJCIoiralGi8LWwTBpD5VraA?=
 =?us-ascii?Q?bpvSRttHQO68kdZmdKyk6E/yfNLNwwhTSqCwtqXz+x03cXNmBnBn2rmQauJR?=
 =?us-ascii?Q?sXgEJrlVxtYQUzskXaBVvgLew8TVIpphWEYjzqiPu8YCzgO3FF9s5Yk5Oskg?=
 =?us-ascii?Q?INl6kr2MZ7H1INDvIgbaHR4BxTTYegSi3dysshOgx/gelBN7jBT8C2MhZbFn?=
 =?us-ascii?Q?A8rPtOsq+ZmTvQgjd8QQIlUEULn+sNGLJFFAuHXfYr8kr30Cq27RsgMhG2Gw?=
 =?us-ascii?Q?l18/Up+lFlpS1gqaVEvpXCDXQDSXdSXKWO8YuTiuKjEmteBbi74rOhhFx2Fp?=
 =?us-ascii?Q?OdhZ3x6zQyhCL04qwHZrwK7N0w78J8+5bFz94DyIbtS1k5r8uNQxz5ziJ60k?=
 =?us-ascii?Q?/gSk0TvMEQ2vD2mp9G2NW5RCQN/K0fZOkZtgZrB5XZEL9NrksNUERsIhiaTA?=
 =?us-ascii?Q?QXWW9NGelVHzRPOIE7Ib4ruPvIVQlrA6L0nm6VK+pGqDIts0WmNposp6JNLM?=
 =?us-ascii?Q?5BPl0ALxBTKyDFZ5aj/7mIXo7ykz+XvQI3etCproUss/NaQIozd7EpYMhiWj?=
 =?us-ascii?Q?96qDOE3u262Ywm8n23OBKQ59NyECJaCsTFNIeAjdvzLTfwAgvxa9aTbQEMw9?=
 =?us-ascii?Q?2ldKFlbjZ9uxt2NZSFYRWGld4pY290i68aoIWi48O/iABBHxI5BUqOi74yQM?=
 =?us-ascii?Q?YbY0qdsZwiy7RG7+bN+F0JkTeHyUjCs4gfi3GSAyyJ/Y6cBgZCCrs2Z/t762?=
 =?us-ascii?Q?rEFKop3Xeh6kJpkTK4hdT8I0GAoI7HkX0SHy9xFlM6mfKAxLbPsVdoKOfjEt?=
 =?us-ascii?Q?4VQLQMd2OL4PPqy8//4EPmg/jrpCazZ8/XovRjJxzrllb+ZTn4LXcxLf8HJ1?=
 =?us-ascii?Q?fUrpO42KLCScMKl4LY+ZYqo6/6IS9k7tzF6t7snZG29oHEg9xcYnCJuD+bvL?=
 =?us-ascii?Q?9jbLm+HxdPFNnialkDC/+w2ZzersRjn7EYnEtJNCr7gEt0oPBBm8lK23BY5p?=
 =?us-ascii?Q?ENDjAdJYGEcCowqD6y3ajZI5zR5G0Uj75FOxPHUniynu?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7751fc-0586-443f-ceee-08dcdef88cca
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:30:27.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIISMz4QewPvYr794fygthkDaLKEuvAmSmXsb1XU/OoPNK/TcwJMnB4sx/IH8SdRWVW5av3ELquymZY3ZpdH7OlXsihPLIPOwXvv4kpelBGtHY3BJgGXljdNiqs+rewj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0416

Sparse warnings:

drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:410:19: warning: cast to restricted __be32
drivers/spi/spi-imx.c:439:21: warning: incorrect type in assignment (different base types)
drivers/spi/spi-imx.c:439:21:    expected unsigned int [addressable] [usertype] val
drivers/spi/spi-imx.c:439:21:    got restricted __be32 [usertype]

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 85bd1a82a34e..8d09d9c1c556 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -407,7 +407,7 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 
 static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
 {
-	u32 val = be32_to_cpu(readl(spi_imx->base + MXC_CSPIRXDATA));
+	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
 
 	if (spi_imx->rx_buf) {
 		int n_bytes = spi_imx->target_burst % sizeof(val);
@@ -436,7 +436,7 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
 	if (spi_imx->tx_buf) {
 		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
 		       spi_imx->tx_buf, n_bytes);
-		val = cpu_to_be32(val);
+		val = (__force u32)cpu_to_be32(val);
 		spi_imx->tx_buf += n_bytes;
 	}
 
-- 
2.43.0



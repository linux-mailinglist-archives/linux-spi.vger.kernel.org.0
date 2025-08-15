Return-Path: <linux-spi+bounces-9466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C8B27AD1
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 10:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548864E4495
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB923B628;
	Fri, 15 Aug 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M+6Qz0HM"
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013064.outbound.protection.outlook.com [40.107.44.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB85226D14;
	Fri, 15 Aug 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246097; cv=fail; b=kw07v2LHNw0mKYwDwGd+XF2pAGIQtb4gTHBEKo8IUQFt8tTYGOtCK8/ziDKKWHsPAgEgtH2JqfWo+txZkaarYuILHeFNuACNCFBAgPucv4d07bimSSYNj3Y9wTwUrv6vBrjXlKH0s2+d4VGg5SCBD4w9iaqxggZY5ny+Q8hvIb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246097; c=relaxed/simple;
	bh=/ka9nOU6YzKkL/Uh3UK48azw4FCWqqM5adlOgZRDy6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+uQYbNp4Ynud06hA9lsXJr2WGgcDJ/8ciSwHvCKaDFs8G2R+raVX0ZJ/Ut5gQzO1gELNPXPh0mLSBSUTjFeedKEuNYx59NFL2+yLMkkAJrjpqMq9bg6fnR7lLCaVO+Po1QswfruxUtPKHQlJ+BNWSaMBwiUbShJSxJ7PYsTDkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M+6Qz0HM; arc=fail smtp.client-ip=40.107.44.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifg6D41fNYsPCx6taqr+QdHu/HT7GEWpF2AOasFtP1WVTRUifFwdotcBikRB5icnJUC6zF/I76DbsWHZN3qw+wr2KQFXilqNVLC7/vsxoVNNFrdIHJXZXmzMu5r1+cP5AKJYp+UIdRhKkrkSHBb1Np+KdOvBBZgo6sEjKZuw/6VxBjxLqtVLgtKP1Bk24dbnS0RYMqOEDRs+gfWuf8I2i7fJk334N9UjTOu9NYhgihunBPyuRw2h2kpv6hs5iBKcKHmgpL7J19JCoxxq4rAqMwTvGacw03kLUJV6yI2+6+9QGJU0Qaz1sJmYuwrh3Af4vUfePGDrljw7ANTNzta92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH553bEdNwZdH69EM9dWLqt1l01n6CkF2watmRUG724=;
 b=T84elBiiDsuS6JwmvvIWgBSGQ4dceFOzRatjboIdbfxqF54uFtpJiFk9sRoCIR94qawloEIKwy4gxb2o4kDMG75xvN3DnTPR1zDA4ENoGu80xvJcDVIROfNDtpnED5X3ANn1EwjS/ktlE0Ew8eKnbdifk49rqWbzuT7mBjawP43VahKe5WMXR/YZ6JzCdbryT/T0h1xrj6Mm++l0ibcHWmqDlasRIO3zkN89Saxqy66GCfktLk7eX35M2AM9IOBM2GMrd+VaUaJzFDAmZ8eYosesQ69N05hf8ELHtWS5psGXhdsR7/jst8nOXwhDfipBnKkxNPGM5YQHyBavDpscDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH553bEdNwZdH69EM9dWLqt1l01n6CkF2watmRUG724=;
 b=M+6Qz0HMvz8qcBFhmw9QID1NvcW23FfSV1jzzP/KUCTJ84d5Ci/Err1gFqOUMvsMJienZk0iTwf4FjxU0WjRpVbDPHHm4d0NMuI+++08DWYeCU0G3x9k55ojOOB57PVLe3/kGqNXatpNpN6wMcyBhMGNJMB6dsYQVRhTSQV/BLuYu4W15QzZfePJa1H4nZ96UGAJgwipuz5e/p3k+gUn+kQi2mUsrpHiPM+4th1yPC1QuWax7icQMMQ1z2wAZTCUdvxe3Ic4bjB73eAfFMPvSp2iSVH0qVt6v9uirbYwdWxOlLzX/+nKQzD60GVYZ6q0SmWmaKbihV34FD1bgqoWTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB7169.apcprd06.prod.outlook.com (2603:1096:405:b7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Fri, 15 Aug 2025 08:21:32 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 08:21:32 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:FREESCALE IMX LPSPI DRIVER),
	imx@lists.linux.dev (open list:FREESCALE IMX LPSPI DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 1/3] spi: spi-fsl-lpspi: use min_t() to improve code
Date: Fri, 15 Aug 2025 16:21:15 +0800
Message-Id: <20250815082118.586422-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815082118.586422-1-rongqianfeng@vivo.com>
References: <20250815082118.586422-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 71761997-ed0e-441a-ff1f-08dddbd4be11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fd1bi/7L2kx8wtgEVcxDt3fXSq5QqQvACS6C86HWN/zSuFMC1W3G/urhd8Tq?=
 =?us-ascii?Q?vGEFSTRYePM8e/4ai7sqTNhdm6O8ZeNlFHCTBsOj4C2zYkbSzIPEIWPiW42g?=
 =?us-ascii?Q?Y0RasvbNDDptuZvd3m6KxbrBxjYog09smU9wyE1w0virYCdGTIkvWCGkmNod?=
 =?us-ascii?Q?oSyIgSx7zCPZ34/FXKV8SJNsmvfGQztkqdaV+RtsJARu2MwkCYEt9A5SqkEU?=
 =?us-ascii?Q?qj6f8DdAGD4TTR0SgTd3GLe/0P8QU42lunyHC3kjXBplwyS5Ob3q+qQROd9f?=
 =?us-ascii?Q?PvnbgEp6Xyp5Ue4w1qdjtDWbQR4VMLeif6kET/TleUY927cdG7myLXaydCD0?=
 =?us-ascii?Q?hgIE6M5P+Yb7lzNvvHElRN0PuHO7jhRjgu79imUUk7Aa8r6AlsSZtembrmS/?=
 =?us-ascii?Q?JtuUb+wfhGdrQFzKEcpSN3qquaxE5+vQ07NpeTyM0VoaAz0m/0eepBsUzOrj?=
 =?us-ascii?Q?uoxRAcAy2Tgu6rxvxQ+oLjxTVsovTrwFOpFHXGxOwaL6LmwAAdWbnEWtp46E?=
 =?us-ascii?Q?Axc2jOmBP/UZZ+nKDHhxgGfyec256c93njygNwfuV7D7DgADuYtdrYoNYu4h?=
 =?us-ascii?Q?bJ/rad4AwdgbovYll4LA5YDaqQb6o5QIa5HGQmCYpyts8yaWVUsIYInV1OQZ?=
 =?us-ascii?Q?i59XWPQLj61xynTMV2CREgugjSs0v19VoQgw5DYiA1+CpoxlaY7jZ2jgKFPA?=
 =?us-ascii?Q?1MOQigFEP69YwtzsJRcl+YsDSLHuQwzGkUe3KFyTP/9Qt8trZUBS3LCW3YVK?=
 =?us-ascii?Q?nBS946jPAtIqcNxGG+ex5rmzP56dgLSnxxOVugc2FnhckkRxjC8JH5x1hsWR?=
 =?us-ascii?Q?nF3yfhWPXlpTOt+VFfaBFwrGsabKC4oZD96uJMuk7Y4tH0YbuJh+UfSa4IVL?=
 =?us-ascii?Q?DN59CDfsgfTFAfDWBWo2qbNwMQNZdLT3XiscKywm0KZJiN/EQF0DdcExS+st?=
 =?us-ascii?Q?5z5T3AtQytIZo2NQTHbv7wbzdawVPa7txgmaFQzwZcrwYpXtWiFfm0t/069/?=
 =?us-ascii?Q?yE+AIhiOMBZinfjM7ADcTM29JulhfQUImcRK7r2fsewgnDU4SNedIsPoKuyY?=
 =?us-ascii?Q?3tN4yYB3xF6gW5SyEJf2QWjjLI/Si/bRZ1yJ4FrF/YBIiIt5c03QNvWweVm7?=
 =?us-ascii?Q?w075DGL9DDHVMK3cB4Jp+V0pQ7Kd+Um4fnekrFT2Z0oO0MhjSXyDYfQGxfci?=
 =?us-ascii?Q?2KLNPlY92nMTILq8VKi9P+QWMn3yBrlg6KKbw11uV/4a8l/twW4R48Mrf2zH?=
 =?us-ascii?Q?E8j9hv2KbLRx6PAzvhz04vtw4gavE0VpvH4+qMcQABZXNnnazyT9f3a8Abpf?=
 =?us-ascii?Q?ZX+dFxG1os1Y9a9j8vJBLN8Maa++zBiilucawEoTjbvyvT8/tiCtnQXb9t9L?=
 =?us-ascii?Q?ijqbMbR2IFwYQJRR81xrgEZ5Iiym0mbKLRfPRBBIS2Z3F8gawBJIVMp4qH+/?=
 =?us-ascii?Q?T4ad4CTEig4yPRhnoTdgQKq+7PXDSOY32vVc4n9H87MY0899w7D1gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+3exH+uqsqZcCopbHuVYBE8bKKh27r3fm5hG1t99g0ES/fs+rw/g0L8xkyog?=
 =?us-ascii?Q?rxzWtUaL1M9ysfdq+l5EuCs0nA5oCf2Z5gjPM1OgkESSXykAdPKUkttjPlzw?=
 =?us-ascii?Q?C5i5pKKRUnT2JvxwOPTKhYTOxY57p479j6abxYxlwQWdD6BvInk9Tg6IUUNd?=
 =?us-ascii?Q?6cG9mOWJSirS9PavSRaqI1VLBhyWeaOWicHldlopgfhhJVEn4TiHrjVlYQXE?=
 =?us-ascii?Q?mR+3RemxYu2srgGMFHGfIxcr4upTWl6kahTeVUYP0rn58SlL32ax1mRjjbO7?=
 =?us-ascii?Q?1rLLo/qO8BaDYu1BtnMX6NkwlCy3DkQvqTLcpanoqz7NlbPsV2Fh15UVyI6I?=
 =?us-ascii?Q?gnBlQwW2CNXyq8FO5kYHNlD7JmNc0TJbU//6JpBrvMyQw+baAlM8MiCPnl79?=
 =?us-ascii?Q?PdRJMYS0N0Dc2TeF1hB1juGLm9p1YpYmQ+jyHC8x9s6QPHRVrB+oE8byDUC7?=
 =?us-ascii?Q?XVH7Qm5R7bKt0GSecG3lJEBKPa/omH8yZJH0xDXwy5RfT+ejxmR1zxDtfpAh?=
 =?us-ascii?Q?g2aaSFWu55r58jBlox6ElhF4P5vwoiA5nNwp9xrBt5gFpo57Tgwc8myPU5HS?=
 =?us-ascii?Q?wpyrKxBWimGhYt+CLAXm03PD3eWKXVJKWcQZqygrTONW400jr5CEEYBhfb/S?=
 =?us-ascii?Q?yI9PR0ntwX9/CPZvQd+yk0vb8586x3dj5TJkaI+v/kngxQ0pqDARzWaDcdfT?=
 =?us-ascii?Q?V8DUbzwENygMyuYTnv8SMdZptZCioi1Li1qtpHuO1qC8Z7ulGfE2MouSdWq4?=
 =?us-ascii?Q?xY+9oyVRpI7WSp4KpeiJytcdcFjln5jp4X5FYSmgRdS9Z1SjdSl/ravlEbnf?=
 =?us-ascii?Q?k0bbZWK+ncrcVS6cXHCd2J51f/M4o+IxsHAphKPB/RjUhws5f+B6uj5JfSMI?=
 =?us-ascii?Q?W8iaDCNjxGh8BWXolcNv2MstP9CsRKB2OlzXOxECIjVsbEAmf3m6JLghxQ85?=
 =?us-ascii?Q?mTx98xA823fxsVIpcQWL0ryVTBtlWUWvXwlACtJXuq4AfEN+GomMJxV/aPdj?=
 =?us-ascii?Q?Mpef2hAYZrEsLpgLBJt75IqsL8f0ujKa3yLW1fmy4v8MxUOM0CiW12mcipQN?=
 =?us-ascii?Q?95CGVA46P/ZgkGaerRP9iSBYF1sEkw2aQT/hvpEeYxPFa71zIg+q+alRpjkh?=
 =?us-ascii?Q?CprKw1C5b3q+uCyvT0uis67nAlQuaVpVMxIlpi1LMzcxvgMZ12vpP1+5/hJL?=
 =?us-ascii?Q?9qxnEUa7dZ3mAdAmEztvr9LtkXf+brcOJzsqNIu0CZ8rwhWymRK29xmdDQaY?=
 =?us-ascii?Q?BbpPG9AIneWuHcRKnxDed2gjM5KJ/rEkZPkCFQPuOj2c5Zn8bjrBFc2G6vNg?=
 =?us-ascii?Q?O3/NEMEnfg5jKUFKiWQEYCRZ4EFHc+0nSktIfrN1r4UVX1rdDHosrwieWjbA?=
 =?us-ascii?Q?69J7XTvrwlm7+fwY5QY2jwu6/yiiSut0hYZHE6sGhOCBOyHfIPC0vOI1A43t?=
 =?us-ascii?Q?toHB+igtvODrj4RxjpwfbOmwWPNCd30Div3Kn3zyIq8zEYbPlXZkqr7iT96o?=
 =?us-ascii?Q?hLK7iSc4UVGN9Pq9QvT7p5/W5nDQjUcf0bVNgjgaqNqmsohT+VvCLNRpZeah?=
 =?us-ascii?Q?vIJAo/pKu82XdRXgUtJUa8yzA/SHjLtQXRPxJUnr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71761997-ed0e-441a-ff1f-08dddbd4be11
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:21:32.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+kI4SZ/mWn1dX4qTjEHF/fDhdnGQhdY2jIzWW6WdC1hDBMCo+hYiLU9eL6SDRNTpT19FJScaMyYQGgVjaehVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7169

Use min_t() to reduce the code in fsl_lpspi_setup_transfer() and
improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/spi/spi-fsl-lpspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 313e444a34f3..dbdb9e114022 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/types.h>
+#include <linux/minmax.h>
 
 #define DRIVER_NAME "fsl_lpspi"
 
@@ -473,10 +474,9 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
 	}
 
-	if (t->len <= fsl_lpspi->txfifosize)
-		fsl_lpspi->watermark = t->len;
-	else
-		fsl_lpspi->watermark = fsl_lpspi->txfifosize;
+	fsl_lpspi->watermark = min_t(typeof(fsl_lpspi->watermark),
+				     fsl_lpspi->txfifosize,
+				     t->len);
 
 	if (fsl_lpspi_can_dma(controller, spi, t))
 		fsl_lpspi->usedma = true;
-- 
2.34.1



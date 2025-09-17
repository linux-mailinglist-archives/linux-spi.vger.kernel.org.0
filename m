Return-Path: <linux-spi+bounces-10087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D37B8214F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538EE3BA164
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEA4311956;
	Wed, 17 Sep 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="S0fGqsHJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC33128B4;
	Wed, 17 Sep 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146370; cv=fail; b=F1KbKmeUJowJe+N19Iw12tbk/HdgiENbmmkkYo7xU+MoruomNfivA75yNwrf4CpFBwHhksfRz7s3YEXqHQ+CibQNTxaj+CeBB73ziPwRc8nBYOaDDCCvVhN+EgtEfT1Af8K1crPfBWwqeeNbaBDIFa6peaOSF5EFrjIhaWfBXHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146370; c=relaxed/simple;
	bh=cJOgojh/RncezIE/1naFdIHp6cwHxDMrvkkEdCOwuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdvj23VQjvYUV1SY1jqQNdRqvn0ZRKXHEc0VHYVTEJmFibF2pMvsO+hkLqSA2LpnPamxbSlw4XFO4QnbMsCAklHGHlwXKr4Hi2HhxapxDLMjhMhCYAmpuQBr4k7YL9Q/fc9da2YhK3nraAUGgECSUvBf9jKL7ql816clMlUCalQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=S0fGqsHJ; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdQh3+I8DqegrkCvSq1VCNS+Fonzrz5lN6iY2Ik7vBrA/fz55d9GT31KKPH2w/NrfL6VWVQPOxrRahU6ba2uQdZzJhxqjxA8jZ/lyGtYCQDzM+kW1DcYtk+4N1pgreY8DPi+2dcHyIJ2EGCLUSfvXB86wuxQctuu3lTMWM9WbWb/WUvzxphOj2DxYi6eJA4+gkarkTjKjVBIsZg9Y8psTRShq+6BvEO3BYLIBXkCqxtZe9aevvrhdVG/4NyQs1s1kzThSQA3cXmPNtUOp/GELmDMI1n1s7t6WYLe0oP6rWTkcIvM6y0d7CFYDfMrZjJzClnNnEkeYMJ9ElR5pVuoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfgrS+X26NFk1wZ2huO34BoCZf8y+Al5DMv9+1OL9oc=;
 b=GUi/J8tKPC/G7c/Z6w2jTWymciFLkkePxUUwYhoOKMxufgSoM3vjOj1h9GJYhLkW3xVDMLKbtXKvrZvYjcKbE3d4oC9/zV/MAOnF0SJLkmz6F6aYcacmYNMUcVmxDygXFcU2rNWMv4Xq1sxq0rLzzJyVjyDjp0urx3KK+r4WZHaQ5ipnfYkC2vGR9TGHuCqFZ18KV4sSssiJtFgfrrY2d1avn6PIcNwWq/mAGgPPtQ+Orp0hQWYw5FtckSBndCt29r/pnM76Shqh+XsMMuaGmaG4N5bTNC5zR3KUFA5Sv0ZRlWZYR5tARiKYGHkW0SsWOjUoCFnMTXAJLjHJ223vEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfgrS+X26NFk1wZ2huO34BoCZf8y+Al5DMv9+1OL9oc=;
 b=S0fGqsHJdbvQ6A1uEoQJqVgHubLxlyLSfYuyLTQw/4S9sazbOj/7R+KLUelTjb7YoZi87VZHo7WMflL5221Yr/aoUAN0PEZHlM9mRYlDKxW/+BQlNfCv03A75h3MFDt9xsNMHzRhE6YYPl7scKx6gLg6wwNsW5CIumA04Ad+PvJcQC2ZxB/XBwERtLfBgbY8109t2UcZLxlewzKSA3sV3d28S0Ndmfm101y6xvrFbi7VoYtrzJCVrHI2LFuewFkQC2fahIGteI0Kgy2mmfZHK6ORZ/eWiHk/3EzEbrSoLM44CnrEZnvP9y0TdaaZbBKsWL51bygZ5tUW+QYAZH1/sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 13/13] spi: airoha: buffer must be 0xff-ed before writing
Date: Thu, 18 Sep 2025 00:58:49 +0300
Message-ID: <20250917215849.19720-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 3acac680-661e-4271-eb93-08ddf63574f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zI84OboWJV6oxNKLher8Q3rz8hIWFsci3AKwW1it68sb7cCwlmJl6qCtW7N/?=
 =?us-ascii?Q?dUwiuCfXay6KMaCS1LKPp4HcpyL8EZOcSSLYM6Ajk0hAwWCuAfL73STFQU0o?=
 =?us-ascii?Q?8BqmFVQ//iIky4LteoFqrGSjmvg4fRsiav7zNVwTbGV+v0EaRAZ9lEETkKeV?=
 =?us-ascii?Q?YUWLW6xGzipJ3+jNEu6qXtCGNzDcJMtHJDw2pnbGF2bfHz0QPvGMMWmAUmsa?=
 =?us-ascii?Q?1HwAqNxRf8YkQWWAKrIeFQerQlDjMH9iWXuhE+CenBHVDri6+UIxnPMsQt5F?=
 =?us-ascii?Q?3mu37RyuUwDL26R11SWoBrpNBobQgN0INXOmAHq8QUbPBFQwMQLYZc5r0b+k?=
 =?us-ascii?Q?gTTN01N/aXoy7+hawsuC3lmgHI/UJgHQionENO3AR06SazOqr1mQXKLDyfzd?=
 =?us-ascii?Q?RRilHtys/Pg60FVqWmcUfWxEox+bQQ9olN3ZbnUrhV3Zmbdt+0Yt/evhF/oA?=
 =?us-ascii?Q?LJQuSGrLoD8Ko66uQPizhgBskmw5sb1Zib4Bf3Q8I3bcF7uQsinwal4pmt1b?=
 =?us-ascii?Q?d0HvowIr6E3CtIuTlx7LkL5yvkBbvvUH0hepmg7hhs2l0kQcT/nRLeho06+8?=
 =?us-ascii?Q?/9j3rzVk5nsZS4p/fNM4dt/7czs49A7wc8YAasyYbNkermrxih89fDUA8FF7?=
 =?us-ascii?Q?XHLmQPG2sjWabhZLhpES1icowLp4FlBw/ItGlmKeytTYVzQ2+HC+Da+tnKVZ?=
 =?us-ascii?Q?5BZmQ7QeKjacWGzGkXejsOY/LVfnEBzBUbbHVgi+mFYHr2p+xLPlYMKDoFK/?=
 =?us-ascii?Q?HQVNYALYOUMSIPh9zyfe6wX7LNUzpeXOFZ7E2wn/xHPiPHCm2WkOwe524UPh?=
 =?us-ascii?Q?cYJTA1bOliA/qJNB0YWQPJ1I8brIRsd0gUBoVXCIpB7TMqEUwAdJcN77Qfz2?=
 =?us-ascii?Q?ZMQf9hVq09mh0O5f/HfDtv0+zGkwR6KP7IoBuPi3qjqTGnQDNP9szGt+dRxJ?=
 =?us-ascii?Q?PraAYie3LGI+Abd/onNK9uWXYwqzfg8nW5jq/an4Iv4xCmWITnVjNqQJYwuJ?=
 =?us-ascii?Q?TWRmji8Ef/2w+wvJi552q6f3kZMeqlDYnELiGW1I72v2SFs8VPAcex9rC4hI?=
 =?us-ascii?Q?jXRmBUnVZxhB8H96VqC0MaNu9PIKg0Kda6wLrbwcLffw3ntXV/g5zC52MyIk?=
 =?us-ascii?Q?sGEXPsd8bZBM/sfATO2X5aLbQ4VqpFVjAkUalWWp01gAKCBVKDVdvWv48GXn?=
 =?us-ascii?Q?JND42kgOKIkJQuodFENszsCMVKI+DHMuJBbaFJcgtFd3jzVCe3F7z0C9Qzmc?=
 =?us-ascii?Q?7y1qz9Az4MHX+CQpVmRXmmt3d+Xfa29nvLsa13JOLBnMwHxYdCLfKSMVYyN0?=
 =?us-ascii?Q?mntQsN27wFjDaUSXT3FbEPM1AVbk1tueWibka8ORlR29bor8Ytv+PsLKAYBX?=
 =?us-ascii?Q?f+fR9N49oT7wG7v6jl13IeovaYZuNQX1nDkVU0HtmuSFIhzF0OtRfY/EAZPs?=
 =?us-ascii?Q?YTBmrg/VX+MKpk0HecfpF5xr6ugW2lUXZqyOJwMYzUrv+Obr388CTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AnXMawbyXYS0wPgsqyQjFvPa25T1ry2b25Y73sxnKD2fsi2z/PYjhfw39XVh?=
 =?us-ascii?Q?5Sfq7fXihbv5zS5haFowH8wOaTLfq+O6OH9+BHtgtsTcPBnqCNcOENb9kwee?=
 =?us-ascii?Q?KiV0q/tve/4Z3c79g2pF7QeqVvPciHAugwfSyXqR5m1l2yBxZ4kOQwDrKdzS?=
 =?us-ascii?Q?ViH5whsB5TsKyBLA3ucdOe4Pg4sVd0pWrf+DZUD9MgNXyGQNzUILFlgM40YF?=
 =?us-ascii?Q?99ZOwc3vytK+zz2YmhevM6TaAPJvWS0DLkD6aeDNzYPCItVbPpfur3LwWi+c?=
 =?us-ascii?Q?UiKlJz56EE/slhUqCceqML3a2esDEq2VAhTWlET7sX12ya+zdSTmZcxxVTql?=
 =?us-ascii?Q?4yt3uWeSvSBRF+TpnYZdd20kg9r5qqT3oSegit7zjugq9SmuaQrc3FB/+r8F?=
 =?us-ascii?Q?6HWKAfD85r+sZO5Eo+C4mpbX2UAotnYZfIpijWwe1bz6q3kW5J1uHqFMCHT4?=
 =?us-ascii?Q?5brI8mkiuZ5QOELCUalD9UJk+JgEzzILofjlimeJfxyEUsqNRhZYVwUSeHYX?=
 =?us-ascii?Q?rHnt3CcB+OBvB9NzvXbh+7Ks9hUsBvxMQnaWN9IwPvkNFh+s1ltJvlatwng3?=
 =?us-ascii?Q?wiBIYVCH6F7YurGfsB+0X6fJevT2jVipqputZeUpBBbeUprFikIJmgSZXxjP?=
 =?us-ascii?Q?YNmukMt5xVu+Hbjw9DV9aoaOJAmVNT6pRIbNM/JY7l8GkrdchgQ95MjgszAt?=
 =?us-ascii?Q?teh60DpsLTDI1WVo+gARY8x2Kg0Kj96OeLcq2YpKpIPA44RBsvYAAE/B0CGE?=
 =?us-ascii?Q?gCcf951ZCPNJdLkmQ+BDBeUwW6TaqIG/AxfQYR2IuddjX0JiSFNcoHK/ZQRI?=
 =?us-ascii?Q?OQlRg0DCDT7AAEUniyRMTGV/OXJCiRs6uLut9iuqKSNQrPtJvdvWz3yWMi3l?=
 =?us-ascii?Q?7JJX6+oXMJRK7etrfTu4LnifjtwAXEkSwfNj4wBa7gVMQPcagEWn7aS8Mp2+?=
 =?us-ascii?Q?65kmoC+S0STk1qFIJKBiioc839wh7rESwuISB7h/+vzGEHuCRYZROrQgVaDP?=
 =?us-ascii?Q?HIt4gZ7to0AEQALJRCXsNpJgGfDc1Q8Ta25Ho5Kk52mRjEUPpTE55lL5gR5F?=
 =?us-ascii?Q?GWQBHmtjNGU0UrydzXIbiBJwW3nGpZBt04WvXQt43LPrKBFI4SibXcrYQqyc?=
 =?us-ascii?Q?+y0U1JmiXVFQn8Pg8Lp5ltghZwyE53JebKdt5RB3CcSy4pYoZI79vcYUFb2z?=
 =?us-ascii?Q?vVc0ldqOfddQq6mAVIhLwK8xqFHlrY0opHKklKtRhPHNc9mR5NWX3OEfIh71?=
 =?us-ascii?Q?ZExn6dygGbELDFBIcdmpYDe4n3l8ZZ4+Wy0GQvcK8CnXh8sUDnXfb6+g1LmK?=
 =?us-ascii?Q?V81d0QqJJEfP/HY0YMk66+qvdZt40YG0OX9AApF7UELZ4h/hugcqx6ruxnHm?=
 =?us-ascii?Q?jk/TKvbvQ0YUnSASRp+ohvcwbXGpsMpFPwiEd5mjnGE+HH7LIHukgIhgumpc?=
 =?us-ascii?Q?qpoI9CxE7jQvCYYhVt7ZwcMwl9RiYOgctKH+4OUI5xXAkAD31Xlsm51eRwwL?=
 =?us-ascii?Q?8djdFXmxrpotqMqRI/wqpJ0W/ktDhD+qGPtKtphzG8VVOVMpDifa8CqO3x5+?=
 =?us-ascii?Q?//M+fKgpIfBa6rKShnjYp0pSPg4TUJXKEpLpVMmePONaIPWSTk5ky6FfY1je?=
 =?us-ascii?Q?ZLBVcTy2fChn6tDiiTaRNs8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acac680-661e-4271-eb93-08ddf63574f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:21.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJkzbs8GqwoeGcI7oWHXEN4i+mfJ6XwOH+9W3hpDGtu8kywt7I51Df1uqD6ih9XTTj+kF1pXZhRexcZBkJJ3eiRy7kRntJFZjHBv4fACvds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 437ab6745b1a..57b1950e853f 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -776,6 +776,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	memset(txrx_buf, 0xff, bytes);
 	memcpy(txrx_buf + offs, buf, len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
-- 
2.51.0



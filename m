Return-Path: <linux-spi+bounces-9898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D684EB43E9C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4694D1C86C6A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36103090DB;
	Thu,  4 Sep 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="kL+gmG0U"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB8C308F09;
	Thu,  4 Sep 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995841; cv=fail; b=BQ6tD+Keu2jNSWfQ1/hlM7xISmZidRbRokJTqKIgYZHWhEjMWsfzUHayN2giUuJxPVcdDjLPFOHMdl8vXkYxO7dXOTDA1kLKL8sBHV1OmTnr/qr3Ix9zdxDCQYPEh/zcQfY3Y7f59VgWAhcbirZY493VHUd1o8cplQNIjxVBGUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995841; c=relaxed/simple;
	bh=rOhvti17afSfWnAngUt50Rm6gFJDQhGEwDap2DhobyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7I2Ha2BrpVRjVG8J+Q00Wf2QFJCUF1SjFuPOAGnmBZVVuKDJV4QrZc+/ZdrFN6rQFK1LZsUztG/QcwiP5Lv9r6S9oEuYqL1jC5Zf1ABSQTul9ygkrtvQHaZnCH9vuLlzCseShGnshAbG79yG207TXy/oq6s+dvMzhMcy9ClJR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=kL+gmG0U; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3xq+7kM0J4Cfq9akR0R59xk4rvBjNxD+rBO80fGS1yxqXgmKqyxJ0EAYdquQNP5uoEFPRf7Mb8lIVt9TOkYwl2MiM9tqAOiJ+CVrf6Te7OJ9oeEdA3IPrGNHhr60Oi3qw37S+af5lsUwExEwcpblRdkga/CdInV6LhXGusBIebYZvTexQv5AqT9j92tqkP8qPhrVITaFx4emC72FmZ2CgkVHlQ9q+J9ICdQCEsqOvpq9K4zRWggghp4b2LLKnqIN/O4MtO5FSBPX166R27qRoiQVlLDp6nZ7c6qW9JycVx3SbqqqW+imeu2bACKLcgZRmzabJda5ADhxnSZmZgV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pylh3AIQv7CnZZnLCL9zO7QTjtGibxLoBWcIYdA5hZs=;
 b=abWkpA1FkrxnhbhZW5GPE7bgfPNpJzAgqHl8E9v32wCKXOuAkSTJa92Z8zqbx5n8NEb6GMnzbUjeGjJup3GN9II+eV61pR/p5dSVaA9GoghGyVQqw0jpeOTFl6+PK4ajKT6Nqn3dEI/rfmX3Kn6AW/LU3urfB6DFj2XlllMjiSb3y8F2V0X7Pj22ut1r/EFU3h3K/4nWf1OcteD2nh/7wQF7AAC3H11CNVzQBXqdHVgtAZa6cKolt8NRoLI1KNqmf+Ihm1EG8K9x+JxoXScp9Xchp6H3QaZ7PZzWkNvcxQIhgzAeQK/0ix27r545UbcHNX6VCGpHXVmAGuBSZ3h7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pylh3AIQv7CnZZnLCL9zO7QTjtGibxLoBWcIYdA5hZs=;
 b=kL+gmG0UDfTvN9ahlhULJWg+wzZ1DzyH4RSJqTrGxQP9BhuIBpSof/N5osfwM6X5au0ur9rBgqw6vJB+YIdAJgb4aM0tebIXPsG5dKsicouW3gvvCxL4Brz2XHped2ZKqyj1sdGlif5Sg1jp5FvukbNw8JB7XiQEA8cGYihfjBBunPKXrcjKL75baJAGbVTxQBg/GMXKQqOt+aM4ov9Kdm9t1alyr+YZ8j1xgLwmfS+TnUWDFjX7zIfmdpUnao4B9yv2R41X+rgLNqH1McDrLDO7KQTB4RW4Ns1xfZWCE7p7guTIsUa/gFGvo6jqvQ5jvwlvGliHuvyvCRUYf2/UHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB8992.eurprd08.prod.outlook.com (2603:10a6:102:325::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:23:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:23:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 04/13] spi: airoha: remove unnecessary switch to non-dma mode
Date: Thu,  4 Sep 2025 17:23:30 +0300
Message-ID: <20250904142339.656346-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: eff2336f-85af-49dd-5ede-08ddebbeac36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RqbOilgp5jjh6pKUBLa32+RGQ422edzUTOqK0nfdS4v/MSBmSN/MQCCVjL4f?=
 =?us-ascii?Q?dfPcyhmV5dpl1OmfZcbrdGPH/3fs8l2ZpBVB/YsJ0M6M5j/HA2xzqqq6sdQo?=
 =?us-ascii?Q?B9CuaYUMW7DEAthCzfyBQplLiKBmBTTWnMA/7G+Ue/2l9HIDUUXie36H1RlI?=
 =?us-ascii?Q?WCS0dzCWEilgn4jJQRC0DctPqVWuKxDlCiQNm9C2754IXwwDMBxOR0Tnlm2X?=
 =?us-ascii?Q?POHQxdBjvXULAE9OcoChgJnc6JSrEeJ6veMWyRzmE3XRSvxUZYZuvbHn/57t?=
 =?us-ascii?Q?iI+wPX/71Q4hk2V7ACAkmGNhcr4DhgMswldgYTxpQQAe7S9M+mnsdXfoh00n?=
 =?us-ascii?Q?GUKxcoa4RHPn66cB2uTzi3v44v1bx+od7o8ABGInmrdBAWbDYVDvSbAb7/7u?=
 =?us-ascii?Q?mj5yNKqhLBLVQ+GvyfahA76C3T4JaIl0wQlfGJv+dI+CGpUo2+XkuYBN6Mxd?=
 =?us-ascii?Q?tphIKP5nJap194wCDB04yr9N6SzIYDbY00rxOlRVo4bucflgNv7d0VNZoiep?=
 =?us-ascii?Q?J7lIezk0+RyPVjRgF09KIp3W5gtp7J80/Ha1VI1NZBD5ZPUdc/LfIUA+mRic?=
 =?us-ascii?Q?Xj78725ddbwwbCG+66EUGc+7EIE8ctIzoDqOf5htyfc6Gl5hfa03RWJkBNj8?=
 =?us-ascii?Q?h4pDP2/arZoK/Du3F10u+J3zbfbgaKTPgw0Rax7Pmm1y8y9kwhfhUK+LaZ9/?=
 =?us-ascii?Q?gMjAGMd4UelAdFElF28vJj8PUssBVPZCXM1+P2yb5pjlba4tRFrXHDoEHn2S?=
 =?us-ascii?Q?6n3CLi2Un3Sj5Hqnoj2JHXmtpuyIXKJHorpB0ph8pS2LbKTTe58BQharNvWf?=
 =?us-ascii?Q?/JJDQjEJRX3WJQzEci+hJubS8pUnrENr/XEoKkp29kYn+SEeN+pMN+4CQCtl?=
 =?us-ascii?Q?ZofjiM6PVCr3ZaWSzfGFQuHEfNumnc54u+kRZT4xztbb6nsUuLtX2W9r1At3?=
 =?us-ascii?Q?lR0+LjhIX8tAxtmdZLG/tzxH2BquVgTxzll+/FagnyRYv5C8yEhXiO58ian5?=
 =?us-ascii?Q?2TcMa/scgyOkpL5ALDLGcV3bDcNwO/jPUb/2eNlB9LgE0QwaeYxfYZgpaqBf?=
 =?us-ascii?Q?M5lyq+jndAXOp6wtTUcbvj2/TYON8XatDvNZfVdyZaIpNc3PsbU7L4KMkTt2?=
 =?us-ascii?Q?DkYRqNknbDxwVxFBwl+lUz3vT7MV7aVXymr68q+Qx/sOGg4r1Djs7wlGX9sP?=
 =?us-ascii?Q?Fb4SwQnwLwR/NPAEipDDGleta4Dlj+Wez+IlqS6nDJXAYLe3rq68GQS4IT7l?=
 =?us-ascii?Q?2hHbHD62+CRq2OcaGIVXKsHWwCQVacZxIFbFk3KLA2DR/HKfckrUrbqCVp5/?=
 =?us-ascii?Q?OIbQs+Cx03PBCiicXmiomqZsJg2B+V1sr8FWRWGCCX3lIDUHgFOUpV/zKtd5?=
 =?us-ascii?Q?ag+fpfMA0QfRR2wvyorlkrtd0TLyBkJjb2uOe3RBSDMlm4xI847OnMPnnafs?=
 =?us-ascii?Q?MJEc9wYXVqSV3tjSTBBF9zR1ZJTnfK+9WhytG6qQ+ySF9SB2Q9bwog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6VN/cdpRDO8basjzD3DCQTL7yC5ReDfG4g82XEGWW6clyFRvRUk9dBipzakc?=
 =?us-ascii?Q?brDGUKV9gkOvzNrvfepbXsijpahflQ4tBrUER/wuen9x3yeGRT2aMXOa2M5K?=
 =?us-ascii?Q?UeqUX9lQBYKngZ8+JGAP4xQ2T5V/ZiJudrxCLCgmdnoeE5zM3cwW2AdbIdD7?=
 =?us-ascii?Q?tRIeQvwAA3npvJ2oIDhIW+ecnc1EkLQyDneu9XZTnTSTm8dEpT7iPzjM8Bwh?=
 =?us-ascii?Q?r8OV8kMapVA/RTeXk8mEdPHLLvJ1ev/w17EKOftiBL/Tr2Fz5USh7UKwgF2w?=
 =?us-ascii?Q?C8aCTnBzLTsH4tY9hOgVT4E1USMSxfN5knJ4VLAPQ8LbMlzdiHtnARFpcsAi?=
 =?us-ascii?Q?x+m0MfcF1wdZdHWDlVu5aQcCF5KW+jEBOheV56Jyef+LBdhl7FpTUfXUoxuy?=
 =?us-ascii?Q?ipumDF3PWMXa639xIghywjCY7JC6hN4z85nN8iT9o57n+PgatU8eDL0XYPh7?=
 =?us-ascii?Q?7gG8ImCfh08Gk8I2oXXrVe0NfdFfS0rV7hG8u1Mm24wTUXJzy3/21zaAejrt?=
 =?us-ascii?Q?lBi6RnWcn4PyPz0FyErj1ES6xeUMfHQtQ8Mz7ygWi1kW1vGs51PozlFKPOwQ?=
 =?us-ascii?Q?2cwqxcrST9zdVZvzeCnAkbv5K8KbupRRTUk/HB/MZ9NwbSIG09RT+qV4k8xB?=
 =?us-ascii?Q?q/2Na2/9PZth8lDifw0FM3rxYFgoSOKC7waKcIX8c721gkfIX41Uh3FQU46J?=
 =?us-ascii?Q?7KNGjZQhxV33FHKVY3XhgIqPnK6B0RLKtJF63f5qyuBdZuJFxr2+kpf6eO1K?=
 =?us-ascii?Q?1NUfODADJoZ27VgkRAoEQYCmUh/ZdKcVVDHN+/oUvh1dz+MccAPX/2GZStr7?=
 =?us-ascii?Q?UD/+rETSiaUq7Tb7URdY+FXd1Bcu+yoiV6UhuHEOY2oNI2S446zC3Mr2tYZS?=
 =?us-ascii?Q?fE0i5EDPvj/2YOkyP3vRgpzobrVu0HydFx36B/u1KdwEs/8vA8fyamfuabdQ?=
 =?us-ascii?Q?kxWG5xSWGCaeZpPAR36XSPbWgJnh31NoB+6CwDCUBRg/XNxOSA8JLQ62cElF?=
 =?us-ascii?Q?I8pzoeykgKNiEQ5ZoRvEMurzigDt49f4v7lE4wN+9LDF4nXu/SQ4JrZHO3iw?=
 =?us-ascii?Q?ObADR2xfSCLKBClNfetXBEq1jNJ0A72QJ7FS23RGCr2dHettCzRtKk9Eulse?=
 =?us-ascii?Q?0VtEnGBX/doaN/HJSaX20q2ykzcegtZns8lTHdrKZtg+kS3SFWSxEf/Ih5Fw?=
 =?us-ascii?Q?r9aVqoiFywkDqbjWTMf4cpoEBP8zu1cgr+R2QE59J86KkcqMwv0lDclUFaMh?=
 =?us-ascii?Q?BQsS8Mq6K3fsi9yDGIukQqj7vvC+gCr6VxSnn/C62gPzLahHuAmaXBsTQEMg?=
 =?us-ascii?Q?JEClOl55AwjRTTrKsjdabyis5UDRmv72RpnLNUzlpzCs/BiF0tKQuqI0sK3K?=
 =?us-ascii?Q?WNjn/7IDfOp+IrntZJYoQ4j3qnv5zoL56QxR1auY9JzeAODmzoFasd6Ao+H1?=
 =?us-ascii?Q?Ww8t1G8SlzdabubbgJI8a8EeBpI2XliTJaGwUus4qVp72MmBTI3WzZvsFlJY?=
 =?us-ascii?Q?tS1pcl85Nbkmj71QqtA5LDotQ/B/XTHJ1wjORNKySxyWOWv4m32cAyxyct6q?=
 =?us-ascii?Q?BZwpnMunPx7slXlj8xOhchKgvGRWqNKaQTgvk/mRQfzQHXRM8Ei2eC1L/let?=
 =?us-ascii?Q?th80wNGauKiIlTQz1RYAG08=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: eff2336f-85af-49dd-5ede-08ddebbeac36
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:23:52.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFL43RswGDEDK9W66WF5Z/0v584IaDINMjTIkOfEzu8DeJJGdbzhK8x5u6/20hPIvfvjXzPqvc6hJVu1TY8NjJzfMUcaLQ8kBE3eC8xb+2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8992

The code switches to dma at the start of dirmap operation and returns
to non-dma at the end of dirmap operation, so an additional switch to
non-dma at the start of dirmap write is not required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index fffed26ff990..2d86dc62dbde 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -812,9 +812,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
-	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
-	if (err < 0)
-		return err;
 
 	memcpy(txrx_buf + offs, buf, len);
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-- 
2.50.1



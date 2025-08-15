Return-Path: <linux-spi+bounces-9480-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3716B27F09
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D66C560346
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6A304960;
	Fri, 15 Aug 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="KT+NICuk"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020074.outbound.protection.outlook.com [52.101.69.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C1302770;
	Fri, 15 Aug 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256608; cv=fail; b=uO6nMeeZbX0V+pt3SOpyF0a0QbjLlmFQ5mSsQXXhIP6ObU0WSNFQxJYkXRcooi71n99rBLDquVTVsrNyiXVZiAueFdx++vrXRNwa8HSizkVVFZIn3pRIQyFPhEqncBABgdILDOaf6Hw7Vv94QMqqq/APNwcJ6nmoVtRIiyFcMwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256608; c=relaxed/simple;
	bh=HiIws3otBPX52JVaEPm+l5q8kp1AyCnfOy5GEPIa1Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJTsgTonz8rjh/s/jGmwxomZyw2SbER/6uFbIya5QJ4zG59M5fMZGVRq8o7TjDcBz0zxMbBfNX24dpM//KMZ8ZW97vbucZ/56rcDk6fq42nJDSqDvSRmb4RnIcSvZ8/3L+gXKekQiPIHmc2OGxNi3gbUxqLP0fIZI5+aMLZGv7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=KT+NICuk; arc=fail smtp.client-ip=52.101.69.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY8Ezq+11+jDCrDbtRn6fh0cK3x/LjRzLFYfwp3K3pdj8sv0jp2odWiQPkjJO8AmjZ23XrEULqRnCiyh/iXSWCeLiQXtfMPVF63N94a2c46rm/Eu3dGp1LWsOV2nBp8qLyg0kfSosEvWRxj50EHux91rf31w/CNdM6LeZBScUMjYKOQIthUKPmik+zJv0t2zKdc7sU6V/Bi0ZGcXiQNQxFEltQKocCTGj6xbKVD5bd0itBXlSGOrGsJ4WTNJ5mPtKPUEBCkwsR+FXuRCYlRkE3fygggPAzDrDfT1NHysQTUbiEwh0t+caWI3prQP9ujZNM+s2MiG23KTYiLo7365ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPam4L1GNlqu+CfTWfWMl3xajtBYVCVJfx4vfDPlX+Y=;
 b=KVA0+RYbZw5Eqq45wY5z8/juWSo7e2NsGgYde1D3mHefL/Gz5zlIGGTtJ7E3UqE2peqAnfwydK02/LzSYJhXCaIaiZp6ICNWO/kr8k1CvL6zi1vmysc/parlBrMCWcDeOK5HzoEy/4hKOUqQ9AnW5XmA2Dy0rl7A8EHL3PTZshitMdpvRc/T/gWYQ3gus6p2OOMoVwW8GZQGVwG91fAq+nJ+RIbRi/bVxHiCB0c1edPzjx2mTPX9V3F/w6N8iiW+y7r8IloQ0rXTi5HVIos8ecH+U5XQZI5VgMSXsO4Ii6LFKW9F5jhX8X3VUHoyYubbMLCJ94t2Kr5JjuHesBlAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPam4L1GNlqu+CfTWfWMl3xajtBYVCVJfx4vfDPlX+Y=;
 b=KT+NICukG63jqIblYxQDomxU09KfCL7CoZ+DbWGCLgGcPCgnAkkCC11RGVQjf7ukFbnHHpG5ImvPKZuwYGUTEfvcDR4J5zTiDWN5BBQ2TZ2IEPu4ik6kOm0zxx4Z0oz/f12HdgcUp60ilg5bHuIEWYoMYbARinQYV7sE+mjUDeWSsXqXfbfJZqbpCpMpk3OCWVYMLWAHuZXQ1gokTGf27h4YaT3VLOgOXy9saa8TfV1nc0Omd2gp6M82nErd6huWhUO4bd25ur6yHC5bv55Cj0WsNEfSGVdo5khwaKKwemPRchFAAMsrWE/+uF6zs8oT7+a54GsnqMviLk8p4BHFOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:16:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:38 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 11/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Fri, 15 Aug 2025 14:16:17 +0300
Message-ID: <20250815111619.45001-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 12efc11f-93fb-482e-276f-08dddbed33d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+Mcot2/qVbeS7mh2X7Hqm8VJgI1/GSwZfaDVFntKaO+O1qR4gmi5ivo64qN?=
 =?us-ascii?Q?roFYCa8yOx/gS7jp/s6hJBhLa2z6LsfmQDS4HdkwJlo23SGxiDY4IWoaVXvz?=
 =?us-ascii?Q?CXo9b//9jG8kxq0yIzpMp2L8D9k1YcXPGf1G512MHj+UeNb2rZM5doafQK1H?=
 =?us-ascii?Q?LgUq7K9pvDGS63IQe4wrA197uB2JnSWCfBFPYR8/duRzfPxPUAADXTJUh50Z?=
 =?us-ascii?Q?oAdke1JFLIwH38SvQnLBGlrNQfhk8ortqc7oJ1PxX0A14OFgcBRB3bfCxcxq?=
 =?us-ascii?Q?EGb435QlXHW9uKKbQHc6MKJyNJO/UHk1n//i3CBbHmJAC2qk2NoHfBSKZ13H?=
 =?us-ascii?Q?RwWGCLU0b7N1uUS8vdofPt8WHjkFL8RW96S2oJr/6ZvNBM6Ta14O0omPDjav?=
 =?us-ascii?Q?MkR8CS783lmwmRa8nC5m+dXZe4FV59e0JEBOtvCaxJ6GlaSDjb+ERXXr3hhA?=
 =?us-ascii?Q?AmRvMWi5Dr0uftA2AxCWy/vAO3Zv6p0faEWNtaY2f3lf9+YTKy8q4ZJFKFwj?=
 =?us-ascii?Q?5Nd1UGjrnLJzDPtgpw5rNfiaJm3SgsUjVjBKq7Kd+hmpr4aCzr4FcjWufkDs?=
 =?us-ascii?Q?1Aa2xz0mwkjoBd6Z0L8fFywje/Y5gvX2dX8kQFPTa73JZQl0eOKIzRLQ6n3N?=
 =?us-ascii?Q?4nF+sB1JB5g6JBsApYm1sSuWWAZOXpOwMQ+KKKXnIjO1dc/Rrv8ZPPrDmcM4?=
 =?us-ascii?Q?TrSmt2MR+Xwbx68y1rXQfB+mEqk+e4cyjzS8RkhlDQUbBCoZkaFOMqnZOt+3?=
 =?us-ascii?Q?VYX4psGw/r/9v9/8i99WS5sJQH7Atp067hsjzBuJbzrSaMXTo9rCkWy+UErp?=
 =?us-ascii?Q?KGi+fgoWMibx5HLuZbhKwu/OsrO3Qq/FZpiSD47WXRw1lW4iOSQKbZTVEVuv?=
 =?us-ascii?Q?CdnNu2ATvLLWW4O8p2NRIrFc6c61FggTEJ+LcWYvy++V2r4Gb08FD46i/GpF?=
 =?us-ascii?Q?7jL93UvqGWtuCDUvs4NHx2TXztI304PkixEzpvewGkx1VQKEWwyCA5yHQJos?=
 =?us-ascii?Q?sQRqhi+TjbHIXdQNuNMMpybcbLNWxXl8W4pcILZ3NzT7e2sswzCgRJczza2X?=
 =?us-ascii?Q?mV9sQEhz7RCwTHpE0IxfYQeJmlSSJ9lMTRVTopqs0ddU4nCbnvVOAsBIiHi8?=
 =?us-ascii?Q?IYB8uWB4QvwMmNsii78n1nutUijxqbLwmKsBIAoi/9AFk8pUs2/X8hRnc8A9?=
 =?us-ascii?Q?yB1AtzlQwWTAcs8e/zlEhPG9pexZPN0Q5TuhuW1UQYvd+Crra5y6owVGopyB?=
 =?us-ascii?Q?wTjnvTVV6QWC4bmXE5cxXfZii7ELzMSHWsxzj3gCibKrm2zCaVUnLCDR1kiS?=
 =?us-ascii?Q?bAqA2XsGWrAUDEhNalEeRYsREsI3CtO6cZya5dJlTRmRMyRI3bjAnZXpulIX?=
 =?us-ascii?Q?/MalQbLR8+I7nNKCU0KiY9ug62nEYXgAWsiCy6osD8w7RAIHWgTqHnife1Gw?=
 =?us-ascii?Q?CZxARaLx3kIv67JENiSSoNvlkbYu96E8CrGKnAhZuUUtU1UlBsFU/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdMUFjEBRVvfjgeLyAllfZwdWRSlzVTiLk6wIJkMwuohaQRU1Ez2AKn7VLCJ?=
 =?us-ascii?Q?4E5T4wrucfjb2+gSD5jFOvlhzDfkxWAgd6otTnA0M1JNlMpW0+OHE2R1Woaf?=
 =?us-ascii?Q?2o7yeC3oa6kyvKYKsKaxYXL3VZ7Aq4JiseKbiGbL5NpXSnhOslBQ4slybzuo?=
 =?us-ascii?Q?uHMu46b9Enz9E1E6wQ9t9jMtfGHMJUWA3txJdE3ojEu4HhclPRDyPuwqKc9R?=
 =?us-ascii?Q?e9D9EczWKLiRyXilNOTqE71eku9tYacjCiO8EcNHZN3Wp2Rdu/HqwQHaqjGY?=
 =?us-ascii?Q?omjp2sLJFgrJ2vD2GgkTLP3AhZ+NLJbPh/CqfWfk626kDj+tyTJRa1a0YsjN?=
 =?us-ascii?Q?0pyub3kecKxL9Z9zMXU/n1AVAPLtyuBwoeut3D4y6jjmaC3vK7IS8WM3jArd?=
 =?us-ascii?Q?Fyq/6PSx+UvJdG4CoBON4SOBLzSta753G30T9ykUNGS2bj93fPWU1Hmft6CS?=
 =?us-ascii?Q?E0cmds6n10QLmRDipZI4QsLHPFuRvzbeAXV5d8SsSxctJKbx3Vsfpn5VdJWa?=
 =?us-ascii?Q?VB+PneC2EVyBID/Gc6tPkIdfEzVx5lxPSKZbLYLO7+bYOpfT7w0KG/csIBmk?=
 =?us-ascii?Q?L4Mu/WDH6yRs/oUJ91DiEj9r84mtuQ+s0YEqhjCPLS1ax4T47GeBKC/oBBZh?=
 =?us-ascii?Q?3+6lj9wk03qnYgj2/D0+vEYcomlvR8Yw/g7DI4u14WHzkXBuBmUo+QZWGZPe?=
 =?us-ascii?Q?bsY/oPiM6acfcDpTKlTnt907dwr8j4f7rCLb3ZbTIgGSFWC5nlrPxyNnvF/z?=
 =?us-ascii?Q?p3VmqCaX48kcDox8EHzjo5PrKUW8R4T6B/zPrH26BMg6F6dnPz6aULyyPZho?=
 =?us-ascii?Q?8DhzTlAPLeeycP533Y8k8yYivmrtBEIcur1HDULu0NIf7iPeqxe3wQWS/lnV?=
 =?us-ascii?Q?bYGn+z8f/I9/EyWAcPPyTuyLOjKOUKEjZuWXRB/tNUIqQrPnBNFPF9L1+u5S?=
 =?us-ascii?Q?zjXrT8A3Pfa0P1s8l3lvnKL4Axwuazeo5LawOu8h4sRXzzZmCin+ik7HaCCO?=
 =?us-ascii?Q?d38FdsFWdUPQ0usazRS+yNC17f/lv2HWH7L55FaarD6mOo7N4SqQaf7CjVHk?=
 =?us-ascii?Q?BDDQuoDMOd5h4b0LlHS+XkX2gZXDpLHz3W6p2H50vyxEsrtFswI0zADGFPLf?=
 =?us-ascii?Q?/9lb4mTpJP5PJXRrsmJsEshdXMM23CdpbpOYK/VmJGzkQRsiBrRcLgl0+yTI?=
 =?us-ascii?Q?F/wLie6SEGbgFFlInfof5A+W41Muc4wbhD8hmjxyeCjleBHMMUWnC5fSdetl?=
 =?us-ascii?Q?MivYs7jrhK4nvW7ZZ0Fw50NxM5OYB0Kvq9uG1kz6+0Q16ERNRWXaMmwKbOHd?=
 =?us-ascii?Q?FXjNQSQDHDLOoMPKnUOMrzxB8a54v3tyT3vuhV9VTIIFmxwogxd42Mfayjb1?=
 =?us-ascii?Q?/kuF29UEiRjmyO6x2n0vIvGSnobZhOdFNEk0E+CDpD+4W7Lw52e3GV4lVPmk?=
 =?us-ascii?Q?jlnnc/wV6sGCTLOhv11xFi9nixEAxLR3Z+Ngd2/DB5ip/Im7k50SJX95Rp/g?=
 =?us-ascii?Q?1Mpgd3XcXz2fTmdcvUpZX+RqqDkPwMYiJgu+xbkCqbAzYqZUZO4QOk3wUVPm?=
 =?us-ascii?Q?GOp1RZl9OLXlde7s7JvI3+YvvC/hrNn5q0H8xDNslV7+bGjMXtngTCTCJZfy?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 12efc11f-93fb-482e-276f-08dddbed33d1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:38.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XahGVsjeu+zMlIsOCDguc/lcrHwuIfZEqmm5uXGZi+BzQdmN53acwHMJUV+4Pj5BPCYFl5NK2JL8ScDD1SxJyzIjcmWzoCvyssBdRCzj0eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 113 +++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 78695fdeab8a..0a95e469ed7f 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -664,7 +664,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for reading (SPI_NFI_READ_MODE)
+	 *   - Setup reading command: FIELD_PREP(SPI_NFI_OPMODE, 6)
+	 *   - Use DMA instead of PIO for data reading
+	 *   - Use AHB bus for DMA transfer
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 6));
+
+	/* Set number of sector will be read */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -708,18 +748,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set nfi read */
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 6));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
 		goto error_dma_unmap;
@@ -815,7 +843,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	err = airoha_snand_nfi_config(as_ctrl);
+	/* NFI reset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
+	if (err)
+		goto error_dma_mode_off;
+
+	/*
+	 * NFI configure:
+	 *   - No AutoFDM (custom sector size (SECCUS) register will be used)
+	 *   - No SoC's hardware ECC (flash internal ECC will be used)
+	 *   - Use burst mode (faster, but requires 16 byte alignment for addresses)
+	 *   - Setup for writing (SPI_NFI_READ_MODE bit is cleared)
+	 *   - Setup writing command: FIELD_PREP(SPI_NFI_OPMODE, 3)
+	 *   - Use DMA instead of PIO for data writing
+	 */
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_READ_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 SPI_NFI_HW_ECC_EN |
+				 SPI_NFI_AUTO_FDM_EN |
+				 SPI_NFI_OPMODE,
+				 SPI_NFI_DMA_MODE |
+				 SPI_NFI_DMA_BURST_EN |
+				 FIELD_PREP(SPI_NFI_OPMODE, 3));
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set number of sector will be written */
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
+				 SPI_NFI_SEC_NUM, val);
+	if (err)
+		goto error_dma_mode_off;
+
+	/* Set custom sector size */
+	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
+	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
+				 SPI_NFI_CUS_SEC_SIZE |
+				 SPI_NFI_CUS_SEC_SIZE_EN,
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
 
@@ -859,22 +928,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_READ_MODE);
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-				 SPI_NFI_OPMODE,
-				 FIELD_PREP(SPI_NFI_OPMODE, 3));
-	if (err)
-		goto error_dma_unmap;
-
-	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_MODE);
-	if (err)
-		goto error_dma_unmap;
-
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
 		goto error_dma_unmap;
-- 
2.50.1



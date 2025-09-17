Return-Path: <linux-spi+bounces-10078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F21B820F6
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 23:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604AA5839F5
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 21:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760EC30F7E4;
	Wed, 17 Sep 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="rOGKTd+/"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020087.outbound.protection.outlook.com [52.101.84.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313830EF80;
	Wed, 17 Sep 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146352; cv=fail; b=Oxs2EoPHJsx/yEK+pwme1hSDYZWKNoL2d4HhMQyRKZlyvA40t4rZuuoeBNh92EBCAM8zvwXwfcJoGeHzp7CKXaviuaeVkaowUJQzCVlcmQqx26lPBGOfo9rjtUexMsGJ0M9H2DaQVkhJvEXZLkrxrH5XHeB9vB/K1nWrGB3knLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146352; c=relaxed/simple;
	bh=F6NRyc7/cX+BSvW4To1kseW47f88kpIUkdwIffKL54w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArFySLHgGR+WcUO8CbzzxMoTGsnbxTeCXuAckDHk4r18q7Y1fQJef6NUb0eiAgAMMqrcia4EdHjVQm4Wlrnry28ZXVIC89pRNta7Qkv6fP6jw5rAv7TzWQcpEgYO3OfeZxFq4QFAN0UTog7OZmHTupms9EeZvZrfVW/ysoQn68o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=rOGKTd+/; arc=fail smtp.client-ip=52.101.84.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDZGnXkPJ6dEXAizmyL2LCqurOTAO+MgYaD8GfzvX5y1TqfawluNLuBw57DjYpfrnlFRe21jOzzQjMsd73X4KI7krCmzfHCHdxFEUJDnoSVfZLVkrxdnpFxl6I+3kSD8cKoN0kenD6Ft1PZB0bbFVdWLGxa2tPXH2qEUaraFfMEek8RgVfJn0kxYIbQd6fiJ+Ds/RbXBzvabZ33g0sIw94ERkpLI0lu9qqIyBI5lqXLGh8nmEUFm5x/2Jy9kSv1jPJizG8wuo6lTebhC0c4NA94hcDOc08rRrapqeSdOC0KLzWM22noZw980pjwKZS6S8p79BC+SLlp9zRLy7SJ6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRDCgAwD4yOLL/rPcqJ5VW+75KQdSeHCdcKAZ3Pv2XE=;
 b=bm+3nalU8VvnF8ZgfGuRNEPeDG//+QKS/Hu/qBlc0Et8R+jeQb3OAhhny2ZWOKJgswan0XM3ki0xYRBiE/C8pE5/RUiJNl7Hk0yTzb70nbX6waysZI4LX9nBGvJmor46PKf+7gNsRkVkm2fzGEF07Gv1K6CFvE7p8Bzn7WzltGoQIpEXls+jpezt3NJqBxybNpKuWVGdgQQ0xlQ8rtI4Sbi3dQGD56PVB4nIDWTenpvoGkQ9Z/HIqfw6WEdSXGep8SypZr1ewDCMYElJhNyv//8+jN3H9bft+5vhpX0JrvrUy1GU2kTbvRZT5hUGW+zUH73GUJSB5KKiLBC9XUF7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRDCgAwD4yOLL/rPcqJ5VW+75KQdSeHCdcKAZ3Pv2XE=;
 b=rOGKTd+/PHzH5nHwpHV3f6QdLy5r5LV2IzUBPfJrdWBKpKO7quWV1wEvdJt8XYyV33BT2r0piL8GYT7KxnRsRtvo1orp4kfIAAkml2VtkZmv7v9HC4nx9Y0NbhcLxVdYen48EAM5xGA80VX5fB3OvwDy3EberKLNQMZWysFW+pfToChBVbqpgtuJCsg4UHNnHjK6Uk7DGiAlvf+Ss02Ztsi3sjpj35T77/ZwJMwtyXKFSHJE9WP6nsqTepUj2E8+4j0v/B6vcwiIyWjgfA9odqJu1iOwjlVYLvQB9Cu+B5INCebUwpluAAkRAYC5Xp1AvqrPfTAonaZaS5LEjLPHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:05 +0000
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
Subject: [PATCH RESEND v5 04/13] spi: airoha: remove unnecessary switch to non-dma mode
Date: Thu, 18 Sep 2025 00:58:40 +0300
Message-ID: <20250917215849.19720-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6d7847-6d5a-4d57-a396-08ddf6356b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdhHHuQvm70GJYCZkACv6+M4DYI1xhaBP+lqkWYjdvBjs1MNrv5vejI03Q7H?=
 =?us-ascii?Q?z3GYJeI6oq6fy3n/HxaO07N67eA4ic8VMBRQGEAotzGa+HKoabBtw4O4rHWu?=
 =?us-ascii?Q?LztwYISQ2WkBV3dTZRjz+xq+kmYzAxHM0+0D+O2/bCI3XXCHyCWoaROqqcKO?=
 =?us-ascii?Q?/WF8l/uT7V4EEO9v77cnV7cZ7tzM0EHFfZcm2JK/0m65AvrvQV3fG9RIbEDH?=
 =?us-ascii?Q?xGWqwSKiPPesdp51C6iIalNz6KTYGUjqcnwuqZ5nDiFAR5MI8kjLDeFzdYqG?=
 =?us-ascii?Q?prLhB0p6HPVRzbvRLTlD9Q8JKnnEIV3TE0c60BcBxxwmor3/bNZhzt2mIZGK?=
 =?us-ascii?Q?In3mF8wJsOkf/6+wKpLp5QxIT+Js60KVFQswOV4pipgZ8BLtPtbOW9ncI0i/?=
 =?us-ascii?Q?BB5WkTfmZi/T+zYVchnjHFTpX/yUktpbAOrzk2vEvZ5tPEupqNbo9jUA6nlf?=
 =?us-ascii?Q?kocIl09xRCOGly0edxoUXalH7ckUr9HLG2qa3hVHkuNsOlW+Sw8gTttA6/qm?=
 =?us-ascii?Q?gvaVRS2ofRor8NOfLQVa46VV4l0NXwIpkd9r/IeF/SUJChZcsmt8zcIER6TH?=
 =?us-ascii?Q?h5lA5KdZQmzZBQSjLXcYGpY7YstHbvkxbVThZAv87KBYuiooiMDe9DjrWefe?=
 =?us-ascii?Q?9apnvG00/jFg+oU/WaxRrJKvHLMPsYv6sYgWbk0Kw11E7iea2Z3SQvYqt14u?=
 =?us-ascii?Q?6v9gVmSK2JiuXecAwOq6AuyRlWIWMZ96EVhhecrKE5kgHjFoTn62KM3YfirA?=
 =?us-ascii?Q?r2w1xOG1P+U6vcl7UHiEW3qWQaQ8ElAW5gJYPmsHyE94Sd5OW2RF/qIfZZa5?=
 =?us-ascii?Q?JaiiOmF/QjRi2v5yL4Hb/GwpW/PFx4HuQozfgzdFEH2bAYKSuL2rGLzWcx2b?=
 =?us-ascii?Q?Fz/A5k0fxv0IRTsrm69goiKEsFoXzjRg9hnbwa7jR2gP1eUdDG9LOlG16gVT?=
 =?us-ascii?Q?3krvMgZ3IgE/nkqzKSyTUgxDBlV6plAC25g6N+azJRGUMav+/v5vV1qNJB5r?=
 =?us-ascii?Q?MWMtGfSVzptJJyhgomwCBNvD1SS/FIajov2Av5/V4osHpj78zeZrGS9PD8cg?=
 =?us-ascii?Q?OTOCuv8O5MDU4XVcqMxcDfei2n5dMpRxd0m9H1zJWt0atIa/JTdEO7Z0yWst?=
 =?us-ascii?Q?+JKGol5XE4zAukkqoyzS4jVr+vaxwpdnUAtIVcplvxomjhB0ypm0S4Idpb9M?=
 =?us-ascii?Q?2ZNB64F8oJQrg1dXp2zQ5ufSR/DCY05iJVRa8qRufWv7hBROPbk7uJRnGZv9?=
 =?us-ascii?Q?Ij6o33tGP/WHrY5y8CUwE3pJ0jMW86xsq5U0nk/tK6xbX/2DX1q1RHF5b9aI?=
 =?us-ascii?Q?mth/aDVl2o0GjxZBjcsQTLBjE/8f6q1+coe+28YCKPlPsDds1gH1dwAdxqKB?=
 =?us-ascii?Q?Y7oJBGvbIolkglOsBSCy166nygGbjNiB4joB8OH6nYf8jVpjyTrBldbxogCa?=
 =?us-ascii?Q?kMjBfISAf2zvSq9eQLZuEPT0bp/sTX9uWI3yvRgKH6r/2PDqWPajpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lBI2CzmoVPwJoJFMbSek4Vhfv0ywklIppG+682DtDSDNAPOieTRDLvkL795h?=
 =?us-ascii?Q?h84ynvp/YVP6qKPyG9wxuc1MRVNwmdrlgqBWsoOtvpU7kEQxm3dnqyW7IoRI?=
 =?us-ascii?Q?WzP56HJZ2pzZf9bo5qXAamqTSYFDToq/0UBTrKImYtFwyxXRZgYHWWNSVKrL?=
 =?us-ascii?Q?H8/2FAad0PqKMGLFuwLHdCyUpW+9ZO8tuukfgnFC+Ch2k6v3DDhEjLLzg5Gv?=
 =?us-ascii?Q?D1CaBGlh2063G3bJIsaCtWsQp637NgYsh711YG9hErRd8GoM2kFNYHFiQCsO?=
 =?us-ascii?Q?aEmCTjN9KFvgQPCG+drJOK8yfVfTCz7+z0ZAOEcfv3KMSvMSmVrdnw/EpnkT?=
 =?us-ascii?Q?e7c1XGbYd/DChEyLA1Cc4Kwmsv3+n3kub6ooX3q8GJR/luJNerxEGvOLiqER?=
 =?us-ascii?Q?zUFcITfPAUYT9uKaisdMxKpMaFxX1ujgR8CLR4NdDWDk9ImC3GQ0cMzQ9V0x?=
 =?us-ascii?Q?wMH7ZZDHXehqIPHrh9ZNVJHH/DUNUOZ9fni2mxYbb+0qrPOBr6FUOFFdZnSQ?=
 =?us-ascii?Q?9WrMSlUpvIA7waRd/37zXg8AXCZRKJkbkyJ1LIeuAqjQqmrbqzbERQ/EcLyR?=
 =?us-ascii?Q?wteOu58E6GEkO1qfPKi7XGUmGq/AtGTt1obYaMZKWfyo9++cAsiIjvuoU9KT?=
 =?us-ascii?Q?DXGGEV/AgpcWAW2TFBc5WQ9aweGnGEDgZdToOfguqvnVFzjQOIXeKPnurHXj?=
 =?us-ascii?Q?r7FFG7ngac33qI4zyYr18I3yffQGGhT3ek5a0+wBLs/WwVDMcUPWCVw9YIfe?=
 =?us-ascii?Q?664u05lsMT95jaQSV53KEn0TrHWRBGoyIyf/+P8hUkGfl/BeDOwXCJoIyWCK?=
 =?us-ascii?Q?TADiNilr3BKBe8on00lID1M0mQOnOOi5vkFbIw8kH3BUj1uE2CmJYztz3ZbH?=
 =?us-ascii?Q?O0ktLLNp7ZtUsRvgEu1aaIHsGmoCglx5NOhsbGiRjNwxNUVsyrFNBFvY8WUg?=
 =?us-ascii?Q?aZBOpfRFqvgGnO3rffq636tOFW9QAw/WlZBPHZ1U6g04b4YyxOvYext7IO73?=
 =?us-ascii?Q?Po8Y79xrnaOroF03bcOfocT/5Qn0MjO5sxwUKWZdp+ewpYUQsACFoaUVPNkG?=
 =?us-ascii?Q?f2JTTMHXVLm4hqriG/KbNmvxT4JQ5ekofIMD++nh1o0PRTK+wTNGfE6lXFMJ?=
 =?us-ascii?Q?72WoZvzwFd3vpB10+BOzxXOeQ+ZerdstgtAVfbp9h0zldDLowg0EFRhlLCrs?=
 =?us-ascii?Q?/ECrBAfSCnOHHO+8TGCyVJIX9N+JCfEHYM8WOrnEsUaTY4SFVwvWcwe3J/5c?=
 =?us-ascii?Q?GR1ZumFD3hJ3LIVhZAseSqLd3slmVERJI8Lj0Om2+9lG+AnSuuxN/7UBA7zS?=
 =?us-ascii?Q?AXoYPs5RuA6oJCOcP+s1+rEFAk7JVTLRS5RcvN4zlE/iOAOtneqLgR/J46Ba?=
 =?us-ascii?Q?1KwSEbtRKzL0wBuKen0PoY0u4cgDJTdSaALHD1L7JClUsZF1gxXrWkeNST4D?=
 =?us-ascii?Q?8+wX60Cy2ZL2PUK4SCaleTrb9maijqYths+KDQl8zf1S3YjK63ZuzxQA+AgN?=
 =?us-ascii?Q?Povbqoh6wT8vrpt5dv0W1q2mM50RFoHQdQt20oNmcKP2dgoPKXKMq5HbX0SU?=
 =?us-ascii?Q?rTV/xAn6bi5QvTaxW0h6RMUn+DdaDZDr82n6xj7v5dXuj6S6O/6hvrQt73pC?=
 =?us-ascii?Q?SxQ0X78dMt2b61X29C2q9kM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6d7847-6d5a-4d57-a396-08ddf6356b6b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:05.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiZYefC/M0CJo7zlyWlKXIrFFLvHz2pXJ/k/Tn9wRzwlL2iI6DB6vuxdDlIfAlfymp/Gg+KCX/FIn0imU3UnuCasW81dco5NV6v1QIPGLhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322

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
2.51.0



Return-Path: <linux-spi+bounces-5008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924AC98864A
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09FDB237EA
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2318D629;
	Fri, 27 Sep 2024 13:30:27 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2120.outbound.protection.outlook.com [40.107.239.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EE282FA;
	Fri, 27 Sep 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443827; cv=fail; b=Cbqw/Ei50zwuYE4BrMoH49NtNGP72AL8zgwOzJQ3Ndy+3N3seK5pR30HbobIlQ50a7BzTzmOuJvrA8BNckfuIJxKgJfZYrWL1CpJmiuoNMGr0RV5KAI9Cxy+DLmL0YL7e1mnCJhZT0s1ni9eBwlNr9xbMLMGQf7+eyg1ukQHquQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443827; c=relaxed/simple;
	bh=sC3u/JZ6EzKAf5NGXqXFmTxIwXabFsp5XKGQLYZdALw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5WoEVN0PC//vTrnk/CuCtOQ1t7kl4DdZAA1im/e9MFY/0K44L6NaBWeFIigvFeJnvOXZ7NnKVocbFuEKWDZMXkLxpmdkllmmV2478pJWxELeEy5TTaT7770HkZUIBXAqddD0klh8s/peDC55a5EqZdMdPIw1sZOU9h/ScbcKw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL2srfy9OE56f1n46WEGbvjRBTxnuFDe1HsovgMJPTCGIBTlzlDWc9e0UkeJYQBg7kO3zl2K4gLGdx0eYAKeXe4/DPiEpQVE/kpIkDya4EN3x+M+4R9DZR8/tmlfsHR4VJVLnz+dJBnc1rvm5Wi4YIwldCbr5Sm3m102dbusuNn6RE7Utp+sTskDMO4lyYbUv88jvZl9Tq7Qt1sGHqOftnak9mBBOFrwFo7ml3j4w5oHzrxWmYgNgHWS4ogbPXOYqHR+IDO/duecyWO+Rzr85oH+vuelwDXx631lnk9Kqa4fLGoLQVY0YOzYBrxrRUy3fkRLipQfmgPhaqbF+Ua1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B+ctj4wnj1B8HkzVG4H9VH0Yeeb7LHUmfY3cablIj0=;
 b=tPHT029O/uPdO19wH0uPsS+MI3isYhzmbkhNoSuwi9P6YDMYIIzZrdK1PzOi1fiOTQJL0GGtyLN/AdFNPUAU9hH153Dh3gV/cVBJRLpMGv+x2i+3MGVBI4L9AFa/rS09NDYvC2Cpd1KZ8YKjIijODDNHzO0ExnCWokYaLvWyayFeElzG7UUjxNQjk/cySrVjnaXOCjqo9bjSq5W7Ys2uMQ+trAUxM9Hw7TGL7iPn7BseKocU38xW1TtrxmiWLrkA54MsFpW3zJPNrJ8FSMhs3SZQH9gu4tt4cBx+Wi1VEK7zCG/NBsFr7hB1nVtcfniZUJKow4i0pWID0+U8Y0ey4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB0416.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:116::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 13:30:22 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 13:30:22 +0000
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
Subject: [PATCH 2/4] spi: spi-fsl-qspi: Fix casting warnings
Date: Fri, 27 Sep 2024 18:58:33 +0530
Message-ID: <20240927132944.19285-2-hardevsinh.palaniya@siliconsignals.io>
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
X-MS-Office365-Filtering-Correlation-Id: dcebe16e-98a3-4e8a-6569-08dcdef889de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVLg4mXO8TIK+QSlOd23eCAHfSR6o5A83RsQMtkbxJj89seqf+7jR85DKzwc?=
 =?us-ascii?Q?53gE1CIZqhG7J/JGRyI74+LXmdtd6GGG3W7OjFnWJpFmdiV47q0zABmHRFEC?=
 =?us-ascii?Q?pyc+RHYEVRljSplAfcEjg8XQqPqHC/sqFXBzPiZepH3ZvH7Y2/DUS6XhSTcA?=
 =?us-ascii?Q?9rAo3NUPvDnoW2I0Fwy5FkRHg6WXMp59ze1mD7VdrBaYJNa0LYVlyo5bfRmV?=
 =?us-ascii?Q?9mR2HrQnnsm+fWiOACxN0YanIDLVZtpHxB5hGcpC5PG1I276vPjHtq0h7rL/?=
 =?us-ascii?Q?hEaKWjPyBX9SdkXTWy/jlkj6/KSUe0Hm2wQgP16uo2m92UZjAqB8KbcsjnDI?=
 =?us-ascii?Q?k98A97GCJ5nKaKCOqbaKlUZ5fCSrMdgIDUW7se1fodeEwoHkqjiYL3sGOpXx?=
 =?us-ascii?Q?/tqvOPMfYsVQLdNBkkOMNZE5zsb2/qLNPhy0Y2ZHWuReg6Ajasoe7KcDihFK?=
 =?us-ascii?Q?O8fnBQlhOh8AkarGUdWDfjxMtVnNBMs5d/J9pwptM2XPYvlpXGc5pZL/cSrr?=
 =?us-ascii?Q?08cZwMuaXRW398mR6rtr8Ze2i56UOxTIjHNFNEvw6iptH6nDNLcx17IypjN3?=
 =?us-ascii?Q?g0CzX3d/lPpgLmxxOb9nhsTM9hqCseJCrgXyJRgPoU0Rxz4wfbQVoyI2vbAC?=
 =?us-ascii?Q?gFc04AT8U479qm0Sw9LPBn+y1UMhcUvufL+wDLCy+oGx9Kt4qip8CJvh4L1n?=
 =?us-ascii?Q?0yNBuxdld1yuYRAw+D7R1hIlIzoZpr83eHgzyFjDRCukJxBPrMygAHb4Ua4m?=
 =?us-ascii?Q?vqCgSYB+ipxvoDrhsiM6GYGJsV7UjrPsd6hQI3IDIP6sn8S0x6wjNgkVayiE?=
 =?us-ascii?Q?l5OmtElWvSFW6nUJuB6TDC3ZEBpElaseKuvsETVZ3AOpypbcUWhOBXm6UDaz?=
 =?us-ascii?Q?H39Ifps6uhqffTuXQw+V6Th2m0PQ8I8yP07RRumttTshsFKQT4o/rAParWSK?=
 =?us-ascii?Q?LmbAR7DitQfSyB9Q2tJ+ZNTM3C6PR5AvvQra969p5+HojSwJbEUeBI/TzyGN?=
 =?us-ascii?Q?GaeYLrdzz4q8dUlApc/HozmRloN9du30xdzepiF+/sJoj35eoCTo+MbAkY2R?=
 =?us-ascii?Q?vLjnqwy0YpYjsgW8u1BKIbk6tBkovbPeqB8V5JcnLrAIzYE1FnzD50uds2cX?=
 =?us-ascii?Q?cMhRa0XS8TH0/X5q/UhZK897x8uuAtawvK6knxTmMXtzKlKzddp+Ep6RJCcK?=
 =?us-ascii?Q?4CMPrRdXyY4nsrgljvuDDofwCYO76Nm//3RRIkFFfBQwOWtf3vuUjyMi6wm0?=
 =?us-ascii?Q?1F476mAoFifeeix457DzcHS/YG4D358VqnH9Par3uIAmYTIO3FC3oDkPvMUt?=
 =?us-ascii?Q?IsIWo8KJReLQy0IlJcAmMkqoQFIdUZY4LMKG7blRSKBpQLCEaLqdpM5qMO7H?=
 =?us-ascii?Q?2+Ub/PqxvX4GxMpCTnsJRLL2nHXOqr7BUrFhdcFdzz9X2jrWDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hi7DaCLQo0R/MP94T0K+ZnL37zhFnWesIUERNAsFWRyfHhBfs+mJyw5Lqk3o?=
 =?us-ascii?Q?303Zwsal0aJhaX8ci92GTBSbtcF2ir11kXuS3hv0rJ0E/IX8jnvk0oNhqM1w?=
 =?us-ascii?Q?CNMJkmJoEpyEblBAQMe8DyFPIUiv4u1pH2TWx6xh/OQ5ExPCTJXFpJ0+hmR6?=
 =?us-ascii?Q?O9ZLnvL/hH3esy2tgUi31yG1VZB3x42YkFfScOoX+aSgwYNd6n7iiHTtnORS?=
 =?us-ascii?Q?31VEsxCCdYJA4iWSd4P2YOp3pDULTjeVEC/1e9MAg9cWDHMevrM8ECndyZoy?=
 =?us-ascii?Q?E/MnmacYh01mTgks3jD4uDY7B+g7W8FFTI6p27K9k846TxTOMU8FpRrO2gsD?=
 =?us-ascii?Q?5FxNOdG5p3zo9xGCsdHhfqvSiu/5kM5VUkhllslkMmDmf8PVfCpPbKkIHtrS?=
 =?us-ascii?Q?663W0aRgissCZFGoipOJmH8weyXRUsLY7BU0JkTDaS5lK9PGaaab9amNB6FD?=
 =?us-ascii?Q?OU67DTT+M91I+ikmovx22n+8O2rI/Hp3abkqXbXXhGqECPFh1eQboi3CTdUf?=
 =?us-ascii?Q?Z/I7YE9Gih5hytWZgKKLFB0JdfC52oqFd75XzRHWAhtkxV9+f4tx8+TVIEFq?=
 =?us-ascii?Q?UgJXTfvU2ij1JFiFuwAy+hBqgHEwmZeCz8u8PVU1uxz9bQD3VU5QbmYbYGJb?=
 =?us-ascii?Q?ofx/iBHeU/IcRNU15LLswdQZB5Cd68EHAkKWYO7DoHzVMXz/NmeLgK/hqRfz?=
 =?us-ascii?Q?B5xyHciHPHkUlTUs+jiA+XzSahbDfiL4I3xAgTZAFXOY4hkMehpewCqDGVJ+?=
 =?us-ascii?Q?7ZolNo5xW54Ph7mMUi3HcGCQQXzjT1qrShAJRq8sEXm6kS3q/LHBpHvL/qXX?=
 =?us-ascii?Q?JD3x/dr5p2Kzn6b5F4qQ/Iu7ElOG+mKyIJOWnr7ClwgnqB2tgEej/taHUrX7?=
 =?us-ascii?Q?JEQC0rA5mPRdZj90tIlf/rX8ekD5+IkkcZd30Fo96K/kb2OUlSSJVkKIAl1W?=
 =?us-ascii?Q?JUp5gCRoaRmcYCZh6HWIbdI/UwqjG7vgO+4xD4BXyaSBeLqEkm4cpqEBccmG?=
 =?us-ascii?Q?CosI6zrKzkmui1lEtpKFX3wynxip0J18NJYNgctyrfjzDgSRXbLdGfqpkhgo?=
 =?us-ascii?Q?dptUjXrhZ57iYJL2sVIbMyT9RxFlZDV6Vq3mpIKXjdsEn35FcO90GCekQodY?=
 =?us-ascii?Q?r68P8EdqC41VX6K+PtW4/dvGCD3n/QEoLmueF++VfYlXF9GrhvshWEtt2Ir2?=
 =?us-ascii?Q?V0epymYIQNzL9Fkw9AWtrOVTfqnTgVoC8+0rhyE6PKAQXAkKbiltPwmUK0tB?=
 =?us-ascii?Q?7IIJZ5zABgajLTgwYSg/Tfw3qksiMSbPW45dE8R+FQJbmwboj0bMqNSW6t5l?=
 =?us-ascii?Q?4o7EwmOCYNLLfdJu7/x7N1kYQDoKSirU+k8VNloBS/vZjQduTgYG0/PGmgRX?=
 =?us-ascii?Q?/JlLcspQCFpL43sNOyseUrlWG234YfLSYgYx0gv5SLaZZZsU4/aaA54aBjrs?=
 =?us-ascii?Q?gSGZUiGZFToH9pKYwOJb/YRAPBpaXsceNI8W+lJNHm5c516QEW9ls+BaXfir?=
 =?us-ascii?Q?R7LFGrrWavEBjoxWfSpZeV8rU0BWBkW6m2o+SZfNP3vdkXkBBDZHv8B8iVjN?=
 =?us-ascii?Q?2kTWk4OUk8KQyztVgYKJaptqHJ2af4lFhnYewGD5yKJ9UPt4fR7ieQSTHepX?=
 =?us-ascii?Q?tUMtmCTwhKBBK824Mj6XSBBzkAx5GW/yTpOr4pnYt6xM?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: dcebe16e-98a3-4e8a-6569-08dcdef889de
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:30:22.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olaUcIAEo5Ui5sUbdo+7B1VvzP5Owx+G4KE7L21izKk3pK94b37MevvVj89sfFYlL2dTvGtNc8VNI5k1J7LOK204QzD5T/JlC3nGCbX6Hl3CdHte+ETYkyqJBHxcAOte
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0416

Sparse warnings:

drivers/spi/spi-fsl-qspi.c:635:25: warning: cast from restricted __be32

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79bac30e79af..e4a2a6049e33 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -632,7 +632,7 @@ static int fsl_qspi_readl_poll_tout(struct fsl_qspi *q, void __iomem *base,
 	u32 reg;
 
 	if (!q->devtype_data->little_endian)
-		mask = (u32)cpu_to_be32(mask);
+		mask =(__force u32)cpu_to_be32(mask);
 
 	return readl_poll_timeout(base, reg, !(reg & mask), delay_us,
 				  timeout_us);
-- 
2.43.0



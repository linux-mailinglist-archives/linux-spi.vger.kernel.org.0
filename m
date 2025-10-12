Return-Path: <linux-spi+bounces-10582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276CABD020F
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88373BD6C8
	for <lists+linux-spi@lfdr.de>; Sun, 12 Oct 2025 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4CE2773EF;
	Sun, 12 Oct 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="0aS6p1jm"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021088.outbound.protection.outlook.com [40.107.130.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E727703D;
	Sun, 12 Oct 2025 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760271459; cv=fail; b=EYHmIzgHcsp4NZlZj+yHMnwDL1FmYzUjH7gVVRUBxO2nieSO2ok59jxr/kOgcDhMVfdGhnn8XaTUrIB4RFTwyt40WUhy855jwTK2Tyjts7WRPOoJ18XWokpKXEIBX4KCJUgc4ZhixdaW/s7eFCwgM+MaSO6qaLEXHXZ2R7MqDFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760271459; c=relaxed/simple;
	bh=8l9JymTCgM+epgUzk4VcWqTdwxznhd6zcMGkq7eDAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u2NZXXnaRq6hAkAln1SoTlvYoJ5m6jxvxOMPtSR9ZHuZaM9qnYmdsM/uB83PuH5qBi6PiiSS2bX/UgS2BFAHGd43BlSw0+U2smX7qt1aP1Sa6KicWNB+mFSfewszlGi8T8ARkotBufmEMr4kB3T6UKkl2m0krtjMx4OqMrpE2rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=0aS6p1jm; arc=fail smtp.client-ip=40.107.130.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asF7cJC6q3wXl3I8VgGEDz2g8fo55MEUyWCh/7HY/wBpo1qn0skY1Mr0xx3Dpj8Z/v+erKai3WehkM0ExNZM4MsrTpFPAhdQjlsfPaFswtO2S/klrJhjFd0siQfCzRC613TO+6of3c3TmP8CEX9jO4WS10Huhovltii3vg7U8FdUtupLzFKdUErdWMKzJqyNXexcpRHzFNdVsWbuyp5S3B6qFiZvLQRTWJiS7zA0l9lkVlO5g7WqRuyvjgtRQtz8fa7nOih1w7ysr8idtMvdCkD7iyDd0FGP44cu1gYjj3i4gyUG74DhYxmy//wOIaZbJluDfO/p6crX4YuROkNc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=KsL45sJj6uVP9mjJiDOX0Qn8E0X6Ddv0CZ3NyD3GKGjmIcl+dY1Oepk808e84oZNEOn0lbbWn1//c8iv79ilM33SrNrBA/btjftfNvihjrMY6Q3cfWQ4VN5d4JFbFULBGH/mcwHx7sjNo3ADZonfrLbgHwo5FRRm35KGJP9k4jrGUQy5uNEvFVgJYdv56gA1etFwJRby+idl6BFsi26m2LxKjBkCKc3CWSiPyYJ+iCWpGuTLFwrpzjjgL/bSkkQUgzobqgTZqC0m8GhIlf08Zvcx3amSaLNxSdhPg2FVR8I8RU76gEG6lqFAbz50K/1w/qVWn5KYNhW7OzMW+lD1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=0aS6p1jmjiVkUc/DzjtxgNeco8LBZz0un4jCbXEotGyGfewWHSHCsrIBP2R/CGTKPwXPU43zXjkXr18P/FZeH6sNa6V7rn0aNtMQn1izxeq1qT3XV2NAar8azeUkdrOmmO8EFl13X5rskvMAimfeH9oIYnByuVGnlerK/WnNhawJHS0N6FW/4moCEj13aKVuekOnNiSB1a9Cm9LL3O7bp4CRGH0wzbgLIgkQb3XSUNuCTZkRPtQQKxOgRa4J56UTOH73/gT6jYBxixmJaZLH5qRW+ue2mjYJBe6OiOBE9WuqEtvTGpkHIbmsZyLzqhilK0vgozsSsxQx4KUyBzElFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB8056.eurprd08.prod.outlook.com (2603:10a6:10:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sun, 12 Oct
 2025 12:17:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:17:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v10 07/16] spi: airoha: unify dirmap read/write code
Date: Sun, 12 Oct 2025 15:16:58 +0300
Message-ID: <20251012121707.2296160-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d417c8-fb0e-4845-cd61-08de09894fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWZDXgRMokTsboPmMN3Yb6Jhm+Qf/TlLXEkgwAWLDV2cfOecFWk3FP/x5/ME?=
 =?us-ascii?Q?YlooHxr6GhEcqHJYQPRmzvZG9yTT/1T3orI+IOSqhJWd8JBIGKjCsuL/x4He?=
 =?us-ascii?Q?sAp8iLKVOJPnYpa1PLie+HrBvkXiK9i21NwinOwQjDz89pRO9eujPc/jMy2N?=
 =?us-ascii?Q?0WiFWUmAWGlXnKarBZRAzhGctd61qwPlCkwZvdT8v9VQ+jQ/UYYeims2UD+N?=
 =?us-ascii?Q?t7y7IyKAmD0P7FuIFsHcSXO/PWK9PjmkTIL7DFwbEcnoxyDEKVpM4vH2JIRi?=
 =?us-ascii?Q?9pOjp7lFclXa+dlUKP/T4pJqI3EvhnZAQeV/vR+UZ0yn7VhJf95R2Z/uij3J?=
 =?us-ascii?Q?hMIVI9LrPMfa9dDWO5BIq/OVcw+nugy/5s2kREw5tsGvwg4xauX9jly0RJNv?=
 =?us-ascii?Q?2LKb+zhDyRdd6O4Uhegvdr7vLCa2hBB00W+LNewpMN2NW+IbejghRAWGVXNV?=
 =?us-ascii?Q?8zlQiKmDW5StYSIbC7X+17KJM1mLyfwriGUrjg7j1dVCfMEjz2RN+olozA2x?=
 =?us-ascii?Q?5zxuohkE9xrlmhrH4AtdPFcvnd8EskIEA/D698Z1PEbIIYWKDZa3sfd/Hhnw?=
 =?us-ascii?Q?pJh5Icvkpo5e1tRxFNrBq+PcMIE4SwqL+os2DDzvjFApgJvC19jxhjetWS+N?=
 =?us-ascii?Q?JOJHFHYtXL3gYb268z7YQp7junwipBEYGRdaPs+sJnTKDTe5hV/biHdQTHkV?=
 =?us-ascii?Q?NBFRHMpMDRP6QnqrY7656SAJQclmifxnhaAB+bjJ1xymC9s2tSarEGboU9sd?=
 =?us-ascii?Q?OmfqzYUODd9mksT0gt2VM5ZBrW/3iX+T1SJPcl8TFVr88VnJT5ogz5VnzThb?=
 =?us-ascii?Q?acdDEDgwSNktgACbWGI1541ZoCOBDiUKcsUDfrrZK6n9N+y4DgBavKEWlOx+?=
 =?us-ascii?Q?Q2Ge3I2ILTERavQ+fgeZlhldCKt9b7hUwYlMGlyhnTHiWkItmo2osgVTsFv5?=
 =?us-ascii?Q?b71nBklp4jpkW0y7q8F/SToKHtUDuRD1s4L5HW4cXyplG6iXa7JJwzzjciIb?=
 =?us-ascii?Q?4K1T5ImWLE3GLtZgYisRZ5hMb9gfiibfZnhA6wpnir/MR/61w11Y0abSP3Ag?=
 =?us-ascii?Q?LVYBgvfTxve/gpuqsgAX1/XHBr8UwZBJUIEC5xZ8cznoK1KSJiPOev1nvjt4?=
 =?us-ascii?Q?lHjHEmkbrWRhump7yEQ0MdSirSryQTHQYMLKbZAA7BaAFv1oDZX7D5vauLI+?=
 =?us-ascii?Q?J6u7e5Btyrz8sxoO+TEcfz3bsS4y0lAcOy0oQ4O4k3jHe9MRQV8cfv/yxdUa?=
 =?us-ascii?Q?1PMAILT7jbxlNO6t2256spVnorvp7ocUeE+ehTdBjw/06kEvDOEaqUt+r0GU?=
 =?us-ascii?Q?PLEuhK2OioazrEodguvda8QMQ8vb5KqUV5MWkPsnBbMP+BiodnjX33dAMASQ?=
 =?us-ascii?Q?HxOw+D2LnfrnNZpfxQZSRwUfGoqrQPMxyMyTdrK+UJlzfX5AofXiJBY64xLV?=
 =?us-ascii?Q?FZOqJwNqlzJqBYvRi7804fv4SeRw4Z2eQFTPmGKwGn36S3sd8q0DEpexVGoz?=
 =?us-ascii?Q?WuvazlrO93T5uSqxiuiQpYQC+HZ+6CKDw9Ua2SeV9YO+hY409TVZrkpeKg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yFMHKhAXCFoopGnYtbGX9tDh0/xbBiajAXxc6FCn/6A8fgsyXAY4MfaYcmqS?=
 =?us-ascii?Q?cc0b7sPF5ws/xjqerQkpjemBcnyksbYlnuPhfmOhP+wWfYHYhl/q4ntPzvwE?=
 =?us-ascii?Q?kiYWRwVKeLYfGPqN4KmVl96mIjV1Rr3ddxaw/4yt3OS5BknFM/G2CO65Nde2?=
 =?us-ascii?Q?Y5f9MiaNmhzyVzGmmZf2vQNg2nWfBPBPrnusiFCKiRLiX+RpWM0c8Rz7UiaF?=
 =?us-ascii?Q?MHk5/Ant7usrxAM2PoMW6MmyJ6OUANGLVoeXf4pb5knanib1PMyb+9ekVrNN?=
 =?us-ascii?Q?BJv1JCn0F8Ecb8XOp2GAFWS2dE+oXHk/Jsivq0b+69P/ELri2HMu6x6kKVDO?=
 =?us-ascii?Q?VCoKJDHNMAFkScSOEYxjEgfjM+aQwXir39JwldgfMEQee9FPfhw3q8cir1eu?=
 =?us-ascii?Q?zP6/TgRYqCDlO1sY6bnaFpec5hJGR7DJN+QiD+ZA1KFU+7Dr6pxKe5uw5EwK?=
 =?us-ascii?Q?E9GXBuRZeSM168NAOOdkukhudUc7QSspf53d03ysTsGG5IoAIH4bhj4chr3C?=
 =?us-ascii?Q?90OWldr547YfhI8sGRN6k3MpG5xCI08m6fMKyx3o94W/0WlNKiU5hrU2cgOu?=
 =?us-ascii?Q?a7R0FC9Eh/q2DvFJoi5FFcme2og4AgFXfOC8ONwqIwr1qmOPLat4lbaPXcKV?=
 =?us-ascii?Q?yJ43Q1DDFal7Vj92FkOLjsVCh0BjxjxLpYsCUvNMf1lRUsy+bO3HsjEUmZdR?=
 =?us-ascii?Q?Q4MvyKX6xX9vj0rswVHcdXZpzGremcfm4l1e8a58WJgcy4wqckjolhSW5c54?=
 =?us-ascii?Q?J49IppcSKmpoLyvxZkIsIm7l7+ZswKAKgOhqqu91m2qIy/JjKwQQue1Jao7A?=
 =?us-ascii?Q?d32Tck8Z/CBtMgg7jGQD8aLQMjzkju6EncLZTTiHreZxwuXLZWi2EVigNGTL?=
 =?us-ascii?Q?ahVAKMxUkDZH6xJC7LlyMDlFBn43s/3Q4dPDrMUJteMxUKDx/H26VFnDFBpw?=
 =?us-ascii?Q?5CmbRSNoHakWwMkm0iaJy3wblPQ4i89VQOS2v/AWfa4YL55W5Ohs/4DQjevK?=
 =?us-ascii?Q?AoAsyjWHRidFb/XoI5jFO0KerIStM+rUMuOXTZQETm0NMVa7bh5e6uM6GAeZ?=
 =?us-ascii?Q?qfe+WvY9gLkNsDh9lFbpVdZRYqtV4gPCbYGeKDaI5zrx387zAhhrrxtkvv4S?=
 =?us-ascii?Q?dIxjgn4JreqmIia3NhE5e31g9M7ZUEmm+gx/xzMybpWjdwn0fvUjfghCofdT?=
 =?us-ascii?Q?QI2128P67Zl9wXLtSJXrF13hFljV1r4cSGY8cddMVa+fGFdpYWDi0eV6dKrr?=
 =?us-ascii?Q?z5j+H+6SJmZkfEJ55zBI9W92SXYUT8fvPoiQ+5sKatqspksRCYPXMu3xlPCJ?=
 =?us-ascii?Q?eX1VArc5pHRZ3gAtGsLKTGvTsWsLxlIbXf+ESCmvqsJH0M2OpvUZvTsK0vuz?=
 =?us-ascii?Q?L1250A924aOHSPmSod/MITDRgSVH8gXu4EM8+CH649IPFsUuvPX4uDnDfMz7?=
 =?us-ascii?Q?yTbw/KhQxTFCaeXE5f8AVwz15EP0T8XxGCoTe/3e647KBbobpU/VmdXmiG4R?=
 =?us-ascii?Q?ACz96SW8AIq8WOIsD5b8ichp68URM6HfsJY2sJN1EEUnayZ8u27HHuMmH0tb?=
 =?us-ascii?Q?QV3zOsMBvC+W2+/0ZNLtmhGBLO1MzqcjUxCgphRm9IFZFDmB0twzNtTzgrF9?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d417c8-fb0e-4845-cd61-08de09894fe5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:17:29.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP0GkeV4ZT9fNrKMIz+L032LEaZP5HOJfdyHLVCK0s0Mh1DKCdiL/ckOQFYaqanlamvEkxf5FL21hIyuhYt+vO23CLSf+lsvl+jkUOltc84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056

Makes dirmap writing looks similar to dirmap reading. Just a minor
refactoring, no behavior change is expected.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 50 ++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 5ad3180ac6da..e90fab69d81e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -672,6 +672,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 val, rd_mode;
 	int err;
 
+	as_ctrl = spi_controller_get_devdata(spi->controller);
+
 	switch (op->cmd.opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
 		rd_mode = 1;
@@ -684,7 +686,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		break;
 	}
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
@@ -748,7 +749,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* trigger dma start read */
+	/* trigger dma reading */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_RD_TRIG);
 	if (err)
@@ -806,37 +807,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, const void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
-	u32 wr_mode, val;
+	u32 wr_mode, val, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		wr_mode = 0;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		wr_mode = 2;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
 	memcpy(txrx_buf + offs, buf, len);
-	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-				  DMA_TO_DEVICE);
-	err = dma_mapping_error(as_ctrl->dev, dma_addr);
-	if (err)
-		return err;
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-		goto error_dma_unmap;
+		return err;
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		goto error_dma_unmap;
+		goto error_dma_mode_off;
 
-	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
-	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
-		wr_mode = BIT(1);
-	else
-		wr_mode = 0;
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		goto error_dma_mode_off;
 
+	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
 			   dma_addr);
 	if (err)
@@ -850,12 +861,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
-			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
-				      op->cmd.opcode));
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write mode */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
 	if (err)
@@ -887,6 +899,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* trigger dma writing */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_WR_TRIG);
 	if (err)
@@ -931,6 +944,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+error_dma_mode_off:
 	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
-- 
2.51.0



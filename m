Return-Path: <linux-spi+bounces-10367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D0BAB010
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F63E422146
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394624678E;
	Tue, 30 Sep 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="n7c7GXuk"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021104.outbound.protection.outlook.com [40.107.130.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1DA23E23C;
	Tue, 30 Sep 2025 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199246; cv=fail; b=Iq4cV6lKjk4eTOUHmsCW2fVYIIruV6eWV747R19h8spsJeXV7yrh7+2yBn/NWBYKawY05Xa2pBAb76VYGQgesp36UUOfvlmJnvC0URZ3AUeBc5XKhtNv9/nkvUXY9mQS0Emhnxo0ABwgc18Rqn7obzDJqIr12MEUU6iBQ9/B2ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199246; c=relaxed/simple;
	bh=1Z4+3ky3F5ePAz1LwMNxiUe87RYnFEz9pATQjAUyt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VG9lKVCwlVmagGQTEaX5VNDQYeXET7YFXmLgtnhTAwQYOMt+JxMgt7LLsSeIGLn3stDDotyVl3mptQfmACCgbbyOqufFL2eRxxr/hAR5yDRiLRU3qL3m0g2ebi6UXNPjpWxbU4jAg7S07S3XlEvD4TGr7YD8JgImNjR4bcpqMLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=n7c7GXuk; arc=fail smtp.client-ip=40.107.130.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kom4XPacmz4aCb4AVtanpTbDDVoz2EV0p6/GhIJe0QgWD+KwcJSe9EKfj85fByA4PMTIRJHNxsISqTjD1PrKXKRks1Xs3Rhlx0gP7WF/VKOsjjGSWZ01P/uaBhNSDs6wmiLCJN766U8w9bO3esIMX5ynsTixqg/AVEgXimoCxGhoQXFKb2hPr3Oo09EmlHu9IwkKOe8WOPhejHgss1opSCTMoOi171HnaApFR6+pz5Xg+329FXhItaO2vFd7LiCpNmAU5G2h0TNlNAIe7QuYRLpqd9j0l8U4WYlGzsKz+kBW19CQG+QsGdxTNvgeLHW9RBwd6OVyYJkjO7IFvU6E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=CtHwqcs9rMN737A/Jk4l/pHzlHb92U0MKMlEzPYd5ySGrOC2Mry1uLT1yEajwLS0MnyN2HIEeB3sZf3dZo9CEuMFRJbpHQqG80dl0RiFK7GuWkiQbjSWY0WolJaNvLiM6+F2E4Gams+HsVLlLbqoQczMuVxDaagZnP+j+YX6lZsHVSVtt03BZjqtQyOLUq8fANxvhiHPPF9xPj4cDs/s09jHi2jLVK0IxREyDzJfU0uZgYn2wX59LHn6Nm2eMtE0D8WxjQSJBcZmbZBLVjpXB2Gs/7QnFC/PqsS95iP2Wrd67walQ6vPAJpoIvfAZTNwxEZ3y4QH9X/wE/6r9cQ49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=n7c7GXuk54IY1DpxcuL4lDIaAH+oUq5EbCWvRkoM1e9HHEaPC4jlxY0s1t6t0ySWvneGE083PN1ZCJt+N4PI0Hqgu3VYCahLw0S37D+nYv1i/M95juwAvgBcq1QHvRINey/hNN8HdfyuG0ADwI/7nCNPygybat3O/pDcR6fuQdC5GWnTFFTHVchir+I//xyi6B10nBKWPJTFD1xvtWLGXae0BdJMXQOkRCeGAndSgxTLvRKrhaPmEPPLK+rDNYzliAiWXDxkjOgNO9Tg8+0Os5PMcdQmtn9Ges+jFy+qTHYRJ1xTMTdboa38uiCGDBP1chhoOqRl0sYofiRQ8ywo6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:15 +0000
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
Subject: [PATCH RESEND v5 09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Tue, 30 Sep 2025 05:26:54 +0300
Message-ID: <20250930022658.1485767-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006627.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3cd) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 044d499a-4ec0-4de8-f88c-08ddffc8deb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?azdtGBaR/tFPR1OSjiH776H9lXio7XCBGhsPlhboEWyifoZhF/+1JPrpJ2Kl?=
 =?us-ascii?Q?T/xORt2pBt80x5XbD5n02KBSnkl3cfah54XoWQcnUzgqLcdz3rUnCXsqA/pH?=
 =?us-ascii?Q?uzss1jCyX7S24Fp+CKNV20+xqEVwWGCqvRgY4wjT27Q3Y9jxKia4vr9F7iyI?=
 =?us-ascii?Q?5NUC0EscVfPRf/wxjSC/e9HLsgAZw9HeIauj3kK9+1yqLYpkzIJVActztmrG?=
 =?us-ascii?Q?Xkw7HAgPCoEDdJ6aHwyGzf3wfu0QmZ+QVPTj8YUeoVel7ULhXUHIbQ4bl7wz?=
 =?us-ascii?Q?w78MM3VxNO1gBCj8vuhE6eHAXuV09Z3Zz3MtSZ1zGXLd6OaxT8G5ySLgDYDz?=
 =?us-ascii?Q?3Tt4HU319vCVZsNhN6QXX/Rl4lqFgv5YvPh1vMIyBKRK6VNTIR5hY+DNwPVi?=
 =?us-ascii?Q?Vz4BmpOYs2xb9nNj1RPs7LfwP/ZDXEqCSbGvhpRoUf+xnha7lU3ANcWU4ynA?=
 =?us-ascii?Q?7eP+TPCsyeJmAV9hItQSRo2nPG/uf68CsnoxO2FZPlTwslUfMqg5CDOArwyr?=
 =?us-ascii?Q?Hz64zHT7aGoDm8vYnSB83OZPUWpzh9G87FNq9OhgljwJNLcyZPbM3Bqdh/oW?=
 =?us-ascii?Q?V6scE3WlzE7Cr461raMw2EoOclqfUGjKrpRQ4DwAG7KqEuXtmFCjfSZ/mn7e?=
 =?us-ascii?Q?WO2zRL9hnfKjKrz0iHAWdBC1P6l5qvQgrO8ysX6MBup1pEaepWhQUGyva2o3?=
 =?us-ascii?Q?EykgmhAcTAJ3QSKa7ZFDrHOggHB3ALctxgk6AMpqqxNSDRymwPulXy+jUej8?=
 =?us-ascii?Q?tmkT+i0QmYCVBQ3eWircvv6+t1WTD4nq7JU/Dg8maK8DTK9muPPrwDpKhsb7?=
 =?us-ascii?Q?tLFnQlf50DMa99AQzblOksJH3Nbfxp4hB4c2CExyNNnEEJRaAsg5jJ1H2aPa?=
 =?us-ascii?Q?AAm5WyUOl6N+cZk4jDl9G/+FtH5nekfL3ZJzJkzdw8BVVzyqpLu/NUmUC9CY?=
 =?us-ascii?Q?Udr3CG+WkGXuLv8qJzsyNGaKsMTEPMB0sFZVXrVIjXhfvJFrOmYbe2FFAY7k?=
 =?us-ascii?Q?g3L+nUlVXI6nQNY1jOsvBRgnJNkVq7zbkYaT70xulrG8SU3f1oplz5QEluy/?=
 =?us-ascii?Q?uef7qznYmECZmi/yP/84ETnhBrKQnKrcOIU+XFDCLYCqv7NWkiky0aTqx2Sm?=
 =?us-ascii?Q?81FEA6x9V915X8XIK7DUthGa+k2VvVRglZ4bpga4AmUMSVS0ABU4w2jJuK02?=
 =?us-ascii?Q?3eHzKMfGgy2fyafchitSKlzKtW9+/LT2cqIJR3gJ+HjZWr2FP7Z2t635yOHZ?=
 =?us-ascii?Q?SgqPYKzqVsQD8i1I8LZ4uX34c1+8fb2Uk0TUsi3RzPP5r6WTJnHsKgyWPqPW?=
 =?us-ascii?Q?1JvKvg50HNF7N3U1M7hxrzC4Zu93yd8zJXr4Y81pDK4Yaq/H1EfsxcjrZgRd?=
 =?us-ascii?Q?+2CuUIOYbfiIo85NSuNDKlSwsTBI5f5xMKdvzleIi4cUJiIGyWw8gX827aS7?=
 =?us-ascii?Q?hgsyd0J6ZTfBK0HmjePaW7BOu0b26JbNbG2I24s6VOreDwJKjMzma3gcY2r8?=
 =?us-ascii?Q?ifnvD8++E7wY9JB7WvyY2b4nrZf1N9YMUl4i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nlcCVGcABsOPlsSeXdAceKF2ctMlrvdCWPmxlY+v3mwIedtA42kT5Q6cOgH9?=
 =?us-ascii?Q?Yahtexzkzz7ES7o8UePMtKDegGc/U8J8Cn9Aw5R1sfi3T1UP67zpHrXrJHzd?=
 =?us-ascii?Q?rGFSORlLx7zd4o9TfcSLk2rkK9vNPgf55vYTddb2sI/TN+NHUzz4DreR9fgK?=
 =?us-ascii?Q?mnD4DAqn+M8tZrVinmXl28Mgwet8HBehBsjYmf9AE6HfOssgIQRekoDWS4PW?=
 =?us-ascii?Q?KA6UiyGvIc+5PebnwuzNJjep94P7eOpJS6bBgFrhX7KxWBO5sZk/sAApqyAJ?=
 =?us-ascii?Q?q3wnwsxriiJUXJoXgSm4STWHWu0qbOdO9LkVddzokgioCUXL8L1YUzO/KbG0?=
 =?us-ascii?Q?XlYFvP4Y8YQh600QSop4oaGTXKOQQ8yW6DiXLFGROYAWC5D4Ve3u8jSXcf8z?=
 =?us-ascii?Q?hhDt+gZ3MwLIwB3TBFo5BBGxbFlRl7zl54pGhS9fIEmR3854bb5K6iYLluY3?=
 =?us-ascii?Q?HPr9TTexW1x9xiDuBp5P29quOrXEkSohqEIMK865a7HOMmfmFWb6UdBFaPeg?=
 =?us-ascii?Q?IMzGdXoBcj9mW8FfOIgcrPbbxTg/PoIeHJy8a/0/xQrrdw5lq6HYaES/rfwc?=
 =?us-ascii?Q?l+47DkIa9ZKQhQMySvGW1x5cq73qbfIvGwXLPKeOcCbZ7UnY57v7VOvnGeIv?=
 =?us-ascii?Q?WGTo/q76z6uwRTL7gen5inlIq1humPZtmhqC6+dHsqAn2ury6f+Fkr3B3eBv?=
 =?us-ascii?Q?lwwl3KMpBcEeX/qX7CeI5aa2HIhBBkrLnjoi5fI/mkhfVbYbKoWmbKjMBXo3?=
 =?us-ascii?Q?+ZdGRhzz9MnyeSSqPxqyI1EYf4EsIJrGkKa3I0lp5B3A3CJJy+gWMoviYRym?=
 =?us-ascii?Q?mGlOW0AqxKwds9S78tcw2UEtOFsavuavM/bUYXRdb2VJpgnwM8lU5uFxTEQW?=
 =?us-ascii?Q?z45Kthi6mUkJOKJblalE6YmsU8OhA3a4flgHLVz0uNxW/9Lr4QBZQdKPqP7+?=
 =?us-ascii?Q?5r4yBAkwptPagK0gCjMoDtRl5FqTyXDXRkgUYO3+pp/n1HFtuVc6PGWax8en?=
 =?us-ascii?Q?us/daiBxhrvP9jorBjpawTqYGPXFffGr/SLl6WTZ4B8BZedQayQYBVMWnWnD?=
 =?us-ascii?Q?Myl96+lwygjzJNmVDu+To1jypzso3BfaU/SAWkNJnOuS/PjwFGXBDTFECNrp?=
 =?us-ascii?Q?INV+s2ttL+MS5XuyFEa0b8wVu6MbJLRS8H6Wfesz8Rtdm1W+ulGenreaAZqG?=
 =?us-ascii?Q?uhhG1usH3o42DKYxDP0mHx0ghX3Bwqeugja8hOH+VJnAKE/TTSlZNYOjstwA?=
 =?us-ascii?Q?9RW9n6l6Kiqi9wCbCffDWLFeH0aBtxmQvoIpMty+sNKaO/6L4Hgpdrx9kntY?=
 =?us-ascii?Q?UUrW4qkLrlpEPlP604jeKznnJrsqe7C3FAleWy7DpVTicRtd7AhFeQo8xvp/?=
 =?us-ascii?Q?4cVyUODgtDJ9IbfX8ih1HHLpz/OYhkkW2TQKBYFv9IJAdBIKeMZTDC0N784Y?=
 =?us-ascii?Q?U4yOiUD7ES6VKL45WyHSzd3Mq1kmB0CfA6+DzInEmIYmjvk9ZgYNISDNaZDv?=
 =?us-ascii?Q?Orl2TLJjM9SwOKagjqygXYn3LQY/6628cJJw2401g5pyLZU7VNoEFP1piZxR?=
 =?us-ascii?Q?60K09NrvQ97aWgYoIRbUdSs7jYnUdxux/eDi3fU2evCaJnWyJgv8ZG2ZNSjD?=
 =?us-ascii?Q?Jw5AfWyRFcCuhh0wrg/1+Cc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 044d499a-4ec0-4de8-f88c-08ddffc8deb2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:15.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUHOU5GUcNFUNS6d1jeFcK7menAJWMC1ewDLVoZW2TuRLC0nMPOem6viGS5Uz6eLxlPl7X5tfzAD2WPoqWPqidX66RQ63mSPCH6WuvSTyaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 744eeb2b24ef..719b424d4cce 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -518,44 +518,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.51.0



Return-Path: <linux-spi+bounces-5007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05391988648
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7ACB21350
	for <lists+linux-spi@lfdr.de>; Fri, 27 Sep 2024 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64002189F58;
	Fri, 27 Sep 2024 13:30:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2108.outbound.protection.outlook.com [40.107.239.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228E282FA;
	Fri, 27 Sep 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443822; cv=fail; b=FiM7cXJKgeoIKFfnhWtZfxJam0TmCO95uJXLpDPK+AJj43rP5Zx+2vDg766SMAnvxKmXuP6NCFV26Qutp7taW0zMGtl6vzGNkFmHP8ccCNUfMq+SNKoztpUKNcIfoyo0OyzNxjDE+93QurvOuQDpDcVg5KLrFMo/f9DhbEI9Ves=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443822; c=relaxed/simple;
	bh=4chnCKyzv2sEXSKHSTb4BCQorGpo5sKPLmYZg3Fy43g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZmhIRq81Bv4vzUkNB7pCrf3PQ9T4wq3V8Kw0g3uWcqpYTnOJAsTQq/0unPxpQgFcsaKmxrR/jsD2AAnaouffS3VUjZuG2HV3SIMrzoh24Ds6rV+cLVkcLL2ZfwCfvhSockZYol+ZVvLTe2XSoU2dGpl0vqJUlZbmHoSoHMCkVww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgosJhtkBttDe05nDEVz3wt+T07t5qp3VAyROcV2ZEXSBoVvsfUy5Ggj1L1pS8mgX2SwDhchmBYJ5K3NNq/GYj2EELLPUBcR4lGHXFvxWpLnMc+cFwct35Ymba8tAsMpTnTiUlu69wLeBfuLPoKVhL7V3oJGF+L82aydaIe5QZaZcyFNclv4GbuF8FzahN+SwNnvH5xhg5ckM4+5iyt11iRRQFmJ/dA9tgXa8kvGKVqzUbHKGVMYOZcm38lrbZ56jpUp7D3/y4H29P0V59G/5/0su+bJV2Xnil76iSkfrwIMmUGcFOAsjTWYzBr3+efnL3TfXbdsMpoX7WOZFpTv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHWe78rzSD6866GSL3KwDIyM6RpSgfXpWu8ZOMo9KfI=;
 b=GMlhHl6FfUAuwur8RAuaD9m81wBYagT4TMxEtdhiyaWPpOR2Hthr9QPsvOqg0lVab1z3q/h4f0exJxDApS4THC+hrR+YAYEemoUKpOMiSphklnqSOeLVbBGla0VY4jz00mpRfRqyF+lCu8ZGg5495Ru6cwZ6r7Gc3jipsm+KfcLx89PWd0q1JUAe2MvMLL2kidaV9dDrHCxOZgnEAPfcqvEokGGtbBuwVM07RIQeiV1JfsqomdyUf59mVrJzmylZCGXd1BTyo1oTSLqTzcCmrCP09vB738xZas29jQ6aWU84anjhc9k9sNxrwgSffSJWBpDCymXf9ikXQgvSSQ8hIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB0416.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:116::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 13:30:17 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 13:30:17 +0000
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
Subject: [PATCH 1/4] spi: spi-fsl-dspi: Fix casting warnings
Date: Fri, 27 Sep 2024 18:58:32 +0530
Message-ID: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: e2fbfce6-f327-4b9d-20f7-08dcdef88674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJE5/o2SIl8/70tAtfI8R5FJTvemps7lsgHb7Ihr5V7TvQVjzPIQJ+96GQGh?=
 =?us-ascii?Q?NoFERoKyHrgmQzLx9aN3lLyxRGmbogX9svcyyMz7ISs9wYdJqbxI+i7wvUzp?=
 =?us-ascii?Q?nxAN7RgpspvFfttcKoG+4NFogntf9iQLYkZZAKa5KOAs4gltOEnKcdRzpRTE?=
 =?us-ascii?Q?JBuD6koFwDD/JYV4/W3reejTss35ZXMYxCuWSFc4gs/bVV7FFumc9EFLigpE?=
 =?us-ascii?Q?tV+M6Hv60j9oHQsqMtfhbmdKwum+XgExw5VBHUMKLQGG+avjCOQgWwjxz/8O?=
 =?us-ascii?Q?Jx4uc5Ny2mXZyaGOpI9wKXHjdFkrWMuyVJbkk/JpurtJNHgFCnzRr36BntK7?=
 =?us-ascii?Q?EIT4/kayGtTnng0tfcCPIjvzkthDTz6pQBg+LIxAyQo+cIHsDKcHl9tofFTZ?=
 =?us-ascii?Q?dmTLArartlbc08uFfgrBALcK6NBr/+I4fSfLIJDKaX0hP3bFYw0ADc6zfx6K?=
 =?us-ascii?Q?bv0kk9ttWYE+bNU/rWAVdp8hI6i4dz6iYciTn8bCehGtj3+mtr07zISGXDUS?=
 =?us-ascii?Q?fL8wBMqe0xdR4OK2kD/cTGsfZLj9OACUjpmeC3zEWf/tRSb46YhnId3k7VXB?=
 =?us-ascii?Q?Y0YINEdf8aoZMUsslb8nUyv08RqHxdp+tRbhb6n6+KcZBcpQWtTgS7F5AvDe?=
 =?us-ascii?Q?2Gbww15jwmcEzEmSWNih6Liffrp2CoafYLYgOy1Phak8FjVrM2PLxu+FmhsI?=
 =?us-ascii?Q?6zNNI6zOWpWkUuUjGKFNKaU9KH7U2rKy6D9S0Pe9MmtmWTwssdVibTII5zwC?=
 =?us-ascii?Q?xomMWB0Zz0bNWZdzgkwbhElpV53fvtaFOqCvFPz8oo3S/BcH+aJJU/69G7lD?=
 =?us-ascii?Q?/0FJ2kVcSbAUs2dkcxHAYIXfNGozOcz1A4M3WYUHSi6rC0xYbw7U51lvaNhb?=
 =?us-ascii?Q?M9uihPKZRL4svoRP2WD8LCmoCkd4kxzR4ccrirKEEEhzB+yFaXHmoFRyaQOT?=
 =?us-ascii?Q?xcu8hbsSTLqS6/lU/AhrMSltNsamINY6HLYcC8koiM2eZouq+o5WZFHeN2yo?=
 =?us-ascii?Q?jUxVI5QCFEgRHXbrRvDICoLVzyw817S8m/3sIfZNzXsqFpBIcVOm5P/X2Tj/?=
 =?us-ascii?Q?Syba9lfVgpxUMrGkAiTqoXVwPX7qoMTewAPJNJlqRLO+A/FgLuVjgIbJD6S/?=
 =?us-ascii?Q?18cM+JwBEcKq27Ent4yQUFQe/i3I+o8EnwX19cS/YGo+v9TI3WVKTecL+10z?=
 =?us-ascii?Q?VeYQJkcqkvYELsMlFWObaMCtqYiUn3JaWyIsHCVPmR6/M3eUDrLwCfXbLmHF?=
 =?us-ascii?Q?4INZXTGIbSwSIRJWhWvFosdBV7Pf/DpRCDc4Azn6TNWlhYxQt8k1nY8DnaKK?=
 =?us-ascii?Q?lBfQh67LxlxQ9r/h8SU47Y598Eo2zgqkn4zPitYgkSBbTWVyHZk3XIProCSL?=
 =?us-ascii?Q?4cj1TEnmPJG58sfsShF15rqM0u6wDmdXoSSK+4vjzy+NBUHsBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tGg3JI9YJ+x8ch9laoLs6J0gdxCv/GoI14Q4PhrI1sLRW6eaZG4hssorrrA3?=
 =?us-ascii?Q?r51hBXOVjZ+18qyPZeBMTBb6tBQ2aAKGG3DOXytXBJ+bJQcSAZjYParWP8SV?=
 =?us-ascii?Q?DUCPpYof3R9IsnuDqkQUN7nzhK7KWYEWEnqHcLJfhymvib6sHHYJbspKsk7l?=
 =?us-ascii?Q?2uIwDd7cRzLdKpUE0Ur77vib7bAerDtByAN3lgQ2YuR1YphXPnJEsClT38lW?=
 =?us-ascii?Q?TT+tlJT2rQXfymg42BBGHthVzd6Qruxsj3Gx/A47N+6Po02kZNNYfxynNlHu?=
 =?us-ascii?Q?EJ1XolT2CZ+334QefPkjTU++NCVoVS9oPdL2hr7j5a1HIm7fLYDx3+F3xOna?=
 =?us-ascii?Q?viSBLeSyaNrXvpsbKXxsaZxMpl3pKqsL7CvFx6ZcSVs4m6xQxHo4WsKSUIhg?=
 =?us-ascii?Q?uDhsAox/9vUaJKIodZ2jf++XPpHl2KmjnBdU1JerSxryr8M0hdXQLc6rcmt/?=
 =?us-ascii?Q?etL+3HlEombDTJumYg1sarLKak8t+4ezcAaqVAAI0rXUnAjP4w6bgR96gO10?=
 =?us-ascii?Q?AtKWvyXfDOx7npMetT2fkBQKeKuv7Ei33zEULJ8MCN0vlvnW0CZZ7VLrLWCz?=
 =?us-ascii?Q?lSZHiLxnukmOO4hH8TFzAGtNAVa08T5LnjV2Ledkfv9s54ox2al8qFLHE+xA?=
 =?us-ascii?Q?rUpm/+Vtnw9NPc+5hjqJTHhrxb7CYaM8e3YN3YXscsLN/FcLToEclpHxra6R?=
 =?us-ascii?Q?cpZN8JcmUUjHom9eieHhvnp43mjF2H3yAOuXgW9bqsA2Lcsmw08cXFpS7i++?=
 =?us-ascii?Q?QO9sWGEP/hHYsaZT+TaEd9zVrfvtedl+bb5gDBz2I4/x2x+oFSoLw7eFDFOj?=
 =?us-ascii?Q?G3zGCa0vMq+noqnzzNe7EGxA59Sr172spIgo32I7Ri2prZiwLlsDHq+fbGtc?=
 =?us-ascii?Q?H3TctSjFxPkbZublh5OubyHpwG36QTf+s2rz3cNg1lRjiKH3UGA1xGcK0qq1?=
 =?us-ascii?Q?jYVw59x8Z5GBTEG3+DL1uN980Qpa8n7ogMldMw4wdNWl5tiW/JxYK5i8BQof?=
 =?us-ascii?Q?OlwBGYVq4YaW7V3nnztbsVkQym39MZcZJ6e9oaBinzXGhs5vsHUcMqYi/AZP?=
 =?us-ascii?Q?97dr2Ji284OcmjRqPwxVdTCeFBgLIZnDFB2lRZWj85RQvEU2arRieFo2qd9Q?=
 =?us-ascii?Q?CKBNyG1Kjze2B4KF7tVUhqlKxRXJY9uCAmrVFUIy1VehmlyVapjcYLoe7ahJ?=
 =?us-ascii?Q?qHsuTRySrFKJGDzXCBBQIyK/9fWkZeAwSYl9QTZDt7NzQ3gwGJz/ed9GfhVu?=
 =?us-ascii?Q?YSUdtAgK6onDPsv9tJyKqSjP/6AquDHA7sSA8UiI9WJ+4IIqBQYFI4uz4Xzn?=
 =?us-ascii?Q?VEqdx8xC++P38NVXze51uaN1K54/wUiU2P0lG/XWGIeqbWhqpWg+gY7jVpeL?=
 =?us-ascii?Q?yqrMBK54N87dR3GWykupyEsi6BByYYiNzNPXld2nEEKFJhTqZ8E6H+gK6y0v?=
 =?us-ascii?Q?wDJQTrloJPiMs5lT1NJYzfalbk0axrUMHuB4XiWkkNAn9D3USqMa3Ug52HC0?=
 =?us-ascii?Q?veM3Ti5mxHbnpA/DyBAEf2fr+z8Il+QAG7guj8uOwBqj+qETja8xlM1MkxPk?=
 =?us-ascii?Q?O483kASiMLbukL5oOPNzzcz9Yadg7HRwFrevw5jEJG5Apdr7hlZz86/SZaaJ?=
 =?us-ascii?Q?2Arh6AcR3fb7MyFjBtKc0zvhBkzUbx/d/c7DIy1Z8BhL?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fbfce6-f327-4b9d-20f7-08dcdef88674
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:30:17.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qmwdm+ytDueCqnoMm4Z67HR5xszrqqOpMuHV3WehjVQw6dfJaijnKBr7X2Y2YGpnoFX5fbbL2b1mYj15j6FUnoq21eZANWjhZEkG+n78SUalDZmgD5DAzLOZata02ekN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0416

Sparse warnings:

drivers/spi/spi-fsl-dspi.c:283:17: warning: incorrect type in assignment (different base types)
drivers/spi/spi-fsl-dspi.c:283:17:    expected unsigned int [usertype]
drivers/spi/spi-fsl-dspi.c:283:17:    got restricted __be32 [usertype]
drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
drivers/spi/spi-fsl-dspi.c:289:28: warning: cast to restricted __be32
drivers/spi/spi-fsl-dspi.c:295:17: warning: incorrect type in assignment (different base types)
drivers/spi/spi-fsl-dspi.c:295:17:    expected unsigned int [usertype]
drivers/spi/spi-fsl-dspi.c:295:17:    got restricted __be16 [usertype]
drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16
drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16
drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16
drivers/spi/spi-fsl-dspi.c:301:28: warning: cast to restricted __be16

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 drivers/spi/spi-fsl-dspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 191de1917f83..e34588679514 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -280,25 +280,25 @@ static void dspi_native_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
 
 static void dspi_8on32_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
 {
-	*txdata = cpu_to_be32(*(u32 *)dspi->tx);
+	*txdata = (__force u32)cpu_to_be32(*(u32 *)dspi->tx);
 	dspi->tx += sizeof(u32);
 }
 
 static void dspi_8on32_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
 {
-	*(u32 *)dspi->rx = be32_to_cpu(rxdata);
+	*(u32 *)dspi->rx = be32_to_cpu((__force __be32)rxdata);
 	dspi->rx += sizeof(u32);
 }
 
 static void dspi_8on16_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
 {
-	*txdata = cpu_to_be16(*(u16 *)dspi->tx);
+	*txdata = (__force u32)cpu_to_be16(*(u16 *)dspi->tx);
 	dspi->tx += sizeof(u16);
 }
 
 static void dspi_8on16_dev_to_host(struct fsl_dspi *dspi, u32 rxdata)
 {
-	*(u16 *)dspi->rx = be16_to_cpu(rxdata);
+	*(u16 *)dspi->rx = be16_to_cpu((__force __be16)rxdata);
 	dspi->rx += sizeof(u16);
 }
 
-- 
2.43.0



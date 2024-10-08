Return-Path: <linux-spi+bounces-5137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51221993E84
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 07:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824191C2114E
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 05:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED013C67A;
	Tue,  8 Oct 2024 05:57:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2093.outbound.protection.outlook.com [40.107.222.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098F13E41D;
	Tue,  8 Oct 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367044; cv=fail; b=d8EZgTuYFJUj2IxIWb10+JkeuV14VYa7sqUnw7XVT56RbUxEFsRn+pbEpviSsOUXq9N7q6f/cgHNlxYqd9JOzDAxHiN5jNjxsssDpj7z/xtYLe4CFqwMJF2vswRqDj0pQitzINajZFEr62XLaCPJ/oPBoiSp+UzmnUObPmNgzG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367044; c=relaxed/simple;
	bh=4chnCKyzv2sEXSKHSTb4BCQorGpo5sKPLmYZg3Fy43g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RzVZXmFJNUTpllvbQgp+BmNOS/QsNTS2Rj2+Irh4HuDGs4g3QDhvqTYjZqofSe3NRDIE+MGNR2+bP1opfKuFs4h3AR8u8oTSZQn4jeBNhkYbMHvOGrlGY7RE2oy3oC98PVLeqUKlCdWtlnVu51UPPmb1fuxbVKOZzwEFS+FrEOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0SPfis08AiouOucDpk98Sz9XZ1n+CaXtuQ9JeHPgQiiTh2Ns0VWaOuq/h3l8+n2lJ3a9XUPFQn4TiaWi908zXPBBg/qzcbeVjOfMPSyeNebuqGMjsiRK5nL0e7Vw2OEF1Ce/wLjnRKEqCxEHnJYhIX6rApnoQ8vk6PD2nkLVAg1CZSVBvptgI2PKx/iEbj6o89cOEjllBXTYnPEgbg54ZbLyVxEyyc5Uopacbd8KACBjWou67QP9AQWMwZsiTZVvyrXNDY1ClJiUXtpYd0HS/eaWdJPiQirao1ahEyMl83nfVRWLP3j7ikJWGZZAFtDR7buLkxH9TglR8KMVhIXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHWe78rzSD6866GSL3KwDIyM6RpSgfXpWu8ZOMo9KfI=;
 b=OwO8a15c6NjYNBIH0x+Qab2IiC3gAt1WuHVRWYJ3bhPCFfK2t7dfCsbALDFVGi/pa9UL1tGT/hGiavQZJHrnRcuav8+q4Wend8GL2S9YjAKNwzsX5bkoN+SzkkWWUhNx8VtctZuAn1W4TNSqp04W3LMoxoVQrJNfKxKB7p4igHwISvCdKyzaCmA/rH1KwfW3TzUmo83D7KvLLTFkUiWYof2uK6F2gPmeF58JUKF6AxuXFFxhZ/lveti6B0Q0judHJdDFicoA95nOl9+N/2wHDSKwqmC/skSIfRnOQswoNp1m2sivlViIdgqeUXeL6Oh7swFSGx713y50v8c2G1leVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB2160.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:57:19 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:57:19 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: olteanv@gmail.com,
	broonie@kernel.org,
	frank.li@nxp.com,
	shawnguo@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] spi: spi-fsl-dspi: Fix casting warnings
Date: Tue,  8 Oct 2024 11:25:45 +0530
Message-ID: <20241008055644.4900-2-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|PN2P287MB2160:EE_
X-MS-Office365-Filtering-Correlation-Id: 451b03f5-ca67-42de-6068-08dce75e120c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8LC7g6yx1OMeF/ZzkFTgsqdoi4+2epRpra/lLuRnffNkrCmfyWWt8KHuWnlC?=
 =?us-ascii?Q?HNdz43zAV1y3xz+fMA6BAoT60tGISd+zbW3lYcv+RbdMDIgal2YGOfHqL6vk?=
 =?us-ascii?Q?NCmGXddv/pCau429jgc0JDQekfbQRutHbO8uYSU07N1FZLvRWAwPhwz3n7A+?=
 =?us-ascii?Q?VPMUMcc5cU9WqPEYRvr4a/mvK9OQ/HvGSTFPXlPQfaRIv6+XSE91rxc42rEB?=
 =?us-ascii?Q?5F1LgffDigPtRnhN6oZTeufWnP2T1KGLT4HB4Afc4kS4OwG0Gd85xU+NcWYe?=
 =?us-ascii?Q?FMcpMR3Hkz3m74Z0QppZB8KXqFRGq2KgjCOQxrDDc1zaTblKdozi8m7vDbYM?=
 =?us-ascii?Q?vrAHjdRFHIDjOjjoGmURbu5PS0FNBQKDsnxCCtisylmxCgyEGZxFjfY2+WYC?=
 =?us-ascii?Q?TOWHD9HYdrxJmVqwNV/zbPyOsXoEb+tdDFVIucedWcy7YirkTGIA5Hvh9Xjd?=
 =?us-ascii?Q?CCwjXh9DUeV+f36EdnOpncnF8/kY/br/0PseWs8pmrJDVtqxZGB290Hi1169?=
 =?us-ascii?Q?jB9lGcHFT3on9YuX/xlrMuKnGeZSFeXKakilkuDq3fO/udONspZVBTNM3bNu?=
 =?us-ascii?Q?DDVbWeYcy3f/ZeNHfW1puk/K8QcaqZM45jtVY1NCB5QonxYTBKyqqHurFb7+?=
 =?us-ascii?Q?A3XgC1eXUbw3V1R6YAvc10uih7uzaidKyuFoS6dbwkwwBYs9Yt+zfZ6IHr7E?=
 =?us-ascii?Q?2kq9nMr8MYxQT8YKC8vkGVt2bayx1jZJ+tnJXJLvWR6Oe1oQ55AE3e41mRy1?=
 =?us-ascii?Q?NniddI34hfyZWzZainMHqmZYf1wOZzNxSfwKrLB9HsUBjC7GjZis6rMSXe1u?=
 =?us-ascii?Q?GBdOBhUhmXWEmZqoVL1X9LOCXIEujlPnXJdrYyfZQiSEpgj29xZ3DpiYPC1W?=
 =?us-ascii?Q?MeAHjkk5yF9mcN/ulJqS2tGW++tSpZ1wg68hPWFJl6w4XARUWESYdOm9HMJk?=
 =?us-ascii?Q?JSFFIovIdO/w7CafbyW8iNK+E8zsDS4F4AFSaDmbb7ULwlK1Ygb9fuHKgppO?=
 =?us-ascii?Q?ZzFCSVCst8YJsor2iiMS6g1wEu6Rt3KyhHqWLO5z0S6l1YUe3pjcEnooz7Ob?=
 =?us-ascii?Q?80QftW0DNUwicEMNRCXlxCSEotVdQkcV1qnHefShNVprnZ1+4YNkXl8EVStP?=
 =?us-ascii?Q?f/1aU9TttdeZdEqRy8NAqWhlEAtHY2peckO5nwEajt8dgDCS9KeSxngjJAaE?=
 =?us-ascii?Q?xiqkBMYId8V/chE+Z123an8q1nDrkAFwsuNUSN+/+XVbcp17BBQ2dsktEQc2?=
 =?us-ascii?Q?tAjRTAOJmXOmgOQuxG1ULZnl3cdc+MrfNa8MYQ6aG2OxqAPv1swaUQwQfFXg?=
 =?us-ascii?Q?hIRMdTvu+EvX680PB78WwDGOM7dkmpxN0Xym/G9LTQT9rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VQNFJ5WJS1Q01UteSEsBOrJwHJOAYtUCmgysqHUWVz9n7CSkuBP7EIaCzGPg?=
 =?us-ascii?Q?MpbbvRh9u/A8CmPAxkFMgvvDbyt4W8F5l9aIA9w3cRT+1IuY5NFKGcs2AoSA?=
 =?us-ascii?Q?hCdbdpRisjngbtTXtg028p1/hz3y7/vVWswufcxy5g8Xs2ahTZJJL2wBKnEy?=
 =?us-ascii?Q?NtGkt2qvZXJOxiTDLdoqe28eATT7eFb5DEuZ5Z/B+iWlgPJEhk5A4pbUj3gk?=
 =?us-ascii?Q?5HRjjATVLzYXT+G6E7f3CULilhH1Wrytt2B+xNNixkxk0u3w7N99bivppC9v?=
 =?us-ascii?Q?WkNyZ4/mNBN8O84qvA3PHCbPueQQ3FVfGttdBJyyBidz9iC18mkN2YQCmmDy?=
 =?us-ascii?Q?1f5HAFRzAO9Q+Qxh/M8exYRR+13yfx5Zd/qskMD7Yihkm9JqtMNiEA2rrJ0+?=
 =?us-ascii?Q?Mg5yLGdw5A1PcpLo7tG9mFQUqZBszunGLOv0JKYGGjwjPVxQzv87PGeE21Mq?=
 =?us-ascii?Q?SyLr69zAHuJMuorppYCJeXxjQ1DuB1DW9U3b9NEVYIM5sV8g7b1KqHSHNhmR?=
 =?us-ascii?Q?UoQjGXPAHX9b5AhlWI1b1zo3kbqzqhHYSrTTUzbeUYKaJESqO8XXbYS1bx8K?=
 =?us-ascii?Q?YIjMXYkxVaDleIyVxL8z6ij+HTEkJa2x4Ahv0JmZJS6hiOzaOU1ONrO47Pg/?=
 =?us-ascii?Q?XTLBIG/nPJNDYChlu1rU++5z+Oz+4qo1BHHbYTsAHYgmc1Wq+ZmwPXhfWNpp?=
 =?us-ascii?Q?ktRtgo0x6BekiYDnt0m41uH1C9s5p1Hx84Ne1XXaocqbI1S4iwO+x7YNfrCX?=
 =?us-ascii?Q?SsXQhLSK1T88lAzMemHvzxmH4jsTO4hdsJBVUN4KiYWQIw1VsOCAvB0AB0uc?=
 =?us-ascii?Q?KfT/Pet4cRwZZdO/R8FuKytuAIr5+FYl9RuAz+jiu2ZPntQTjsKIxY99iwK8?=
 =?us-ascii?Q?ki+kPLFRlrY1iGHd3j1H6eYp1/0glzt151pqoPNzAAm9rc9FtZyTe7qwkxGo?=
 =?us-ascii?Q?ZDMV7fVaXH71E/OCwlGGzr/cWR5NrEgXYsj4UZnGrTVQDlNpxwL9fROA+3Kn?=
 =?us-ascii?Q?3MJqggCATNoJe/w9YAjq8zjXE9l/7OGEnjjQzvbhPnfuc+c/aMxiJYxS2OnX?=
 =?us-ascii?Q?A7P+GT5UIiqfMiord4toZvnAF2hSiX8QkamXn/8d1G7BcAFCxuewhcQId/kx?=
 =?us-ascii?Q?Ilng1U/dGjn95AACYlNdwOBaNJwsS8lCk8wuCde8G7EPOzT9UvA9z3SEg7dr?=
 =?us-ascii?Q?FMV8Kp6yXXpCiXc+CIMUD8zPp7sSGARVRrFrfHDWmg9hv7Kb57AzSXJwbJIG?=
 =?us-ascii?Q?qTeGIAkXDykOjgK85zLG7vE23MpBkWwGSlb/GqhkFKbmIAY648wYcCjvOQsT?=
 =?us-ascii?Q?Oqk1BSbU1Ciwt0f02digUI+gAf/1jK/h4UhDgyLgBRzfA6/YrFgsCw0Z4cOQ?=
 =?us-ascii?Q?RnMSzXMUoN2OdxkFfEE8acgMFit1ntXs8X43wSkyQjQuL2YyGOrwoWcviUC9?=
 =?us-ascii?Q?f8ZHHOVASwLeWsItjzeagg0446SjOT5Sa8CMON5XBjbkO9yDjc9RLe5H2VVS?=
 =?us-ascii?Q?shyF4SPT378zJJILr/0qjd+VgzGWuDfBr9rD4L3boNj7IhGJk+eaoHCIVYoK?=
 =?us-ascii?Q?CN0gqerhPCrpUY3nWhsDgdW9RRscStyQhNoIimP0R0lse2dqRa2BUoIRLnjm?=
 =?us-ascii?Q?N4OdsYdbbObJ5tV6VR6MQDv5mbFmA2eCmLWfEzxye15t?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 451b03f5-ca67-42de-6068-08dce75e120c
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:57:19.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jqa31avvNkGa6cv6FBeYZY41nJQG7qEF/wPf7QfsC67eufMbk6KH2BWA9NBEjaKXQ+Vx7TU8GcCapQsF+xEGxJIz5MzeH61BooZSNEGbYTU4zy9jma+/PUlnBOYjnR5j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2160

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



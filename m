Return-Path: <linux-spi+bounces-11248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CD2C62371
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 04:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C65254EE5AE
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD681922FD;
	Mon, 17 Nov 2025 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WI+LnueK"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4905189BB0;
	Mon, 17 Nov 2025 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348659; cv=fail; b=nmOjKjoL+Cwwcw74DXWAty4Lt2YZi+9Ka6BNcDQLKK5PczbidUMh51xkm7rbxA3TkjM8EN9n4GjrYp7ztIfxNbuCyRgBUL/vHcEYdUM31YDOdM3KS00rcOB9MtKaV+fxYScredAaUoxkmCEEfQaRlu7g6Nq+UDr6KdWm3NIM7cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348659; c=relaxed/simple;
	bh=lx9ENUN/5NK6KIJf3QXklxRPOYit5i5KSaG7w+IFCQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GuSe2rmXtM40GAbB9EeWokVNMdPRg3scZIZOEBJ5H3lSjCiWWB7iKOSlxIkNmkh6ngB7SdFTftMuEsIhQTWYHZ/omZXJq9dQrtsm/byNrG/GaEzESVJ8/cRz+qfjNIrj48cLirdVr0OCaLtLtAOtZOTZchW5uUXAFGpKsnDj+4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WI+LnueK; arc=fail smtp.client-ip=52.101.69.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXpimJYETZfVNsrBa/NVR6h5oCRJvYKXSHAy5AtbsGrjMOp5K3oNuYYVgxZjKKpFWuH9XR78+C0zCT8OyHg0LwHAjgg2xPLzkSbzIT68MNG2CUwLxnobbb7krzsFMA71ZG6/1TM8JUV+6OFIy1LlQ7lEMYaQvSp2+B1arIJ4GRl5bXVWEH4IP6AQtt/bNwU5rAQB7IRUUXqmkuQBAWScUefkiVyS9mftaVGPGCqRx+NVu4EBhqWQgpaGh49QOfiWE3B5q+eigfcGBNXSBroQj2Zk7rd6D69lo5DDgavra7GufsP1SLHKrI57O7jg6CZ41bQSwe7z73XBVp5N128wYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzPk4C+UF1Mve/QtVdh7sAhjW9lxcoxB8B36qEn20ns=;
 b=fpjsDrCeSQ3/5hIpbg9ozMnNjghpvKOJjsZhcpWRrfLQxo0KCfgf6RMKCIoeztPRuauop1jHycM8JInlLhV/jD1mv1PS5ih9504yoHRpdOXJb8AR/SA4ulDOGtEi5UsSuTbA2bjcRWKF+frguqLpzSJ3l9CLoP09hOENFdgTShJ3guWwBTT8slotS3juDKjzDC1fSd3ozl1Q+QT9rxOYa5a/PK3JTNau7D/HU8bvK5xH4c446w+0GMDNvV4wNb/QydrU9yk4Hb0hdj0gZz16dMXAdta/1ZeGGmTUiHaT1esMLGwX5DsRBRupkVgSW3XHUFoND0hB9hDDSz23V85MAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzPk4C+UF1Mve/QtVdh7sAhjW9lxcoxB8B36qEn20ns=;
 b=WI+LnueKL6pkPmBULzL/tJoOps8CHMYpUiotNHQbWdreCEp1M//jylPxdQA3ZQACW0wsCvequg08Da+NxBKJDM3ae8nlyiBiewaXrfrf+qSUCSFMfr59EaDg1SUqiOKN0F+DAXUzv9uGsvm0O2mT3IpHKqxna6DuCwfUzvjgKzh0SxTZNDDMY/T7HdHSTdpocBMD7i8gZ/XcjxBPmKA9szUdQk5KhrPn6pP6prGrQ0eWka/iSDGBH9ulc1aRnq3e++0OAfWaLEma60kab9mFCfhm+Dbe752ve8Mv27faO2xwamUK+Gku66dreMl9mnVD1UQYxw/qs9Qyqm3EWoVttA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from FRWPR04MB11150.eurprd04.prod.outlook.com
 (2603:10a6:d10:173::11) by DU4PR04MB12109.eurprd04.prod.outlook.com
 (2603:10a6:10:643::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 03:04:13 +0000
Received: from FRWPR04MB11150.eurprd04.prod.outlook.com
 ([fe80::3e8d:a3c2:53b1:d586]) by FRWPR04MB11150.eurprd04.prod.outlook.com
 ([fe80::3e8d:a3c2:53b1:d586%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 03:04:13 +0000
From: carlos.song@nxp.com
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	rongqianfeng@vivo.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by type cast
Date: Mon, 17 Nov 2025 11:03:55 +0800
Message-Id: <20251117030355.1359081-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0122.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::19) To FRWPR04MB11150.eurprd04.prod.outlook.com
 (2603:10a6:d10:173::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWPR04MB11150:EE_|DU4PR04MB12109:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a79d88-e587-4cd8-cd25-08de2585fc2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JXOGlTCsGTXanlzxFHkq2JrXoah5Bx8RU96qrAHj1fr/97yhxsZOcfPZPFbd?=
 =?us-ascii?Q?0V5u4SojPUGDxR3mxBxQg9lQidI1hZTWr8LmWZjhnk3h78+FgDzLoo3aouu7?=
 =?us-ascii?Q?hmGaO9bCGDs3ifEvFxsAc84wiMmRBjJfxzMoe5A8nNOzqYG+0PU2N5S9x27i?=
 =?us-ascii?Q?ZwhHJ3Qfu4Y1m9Pt8JfwgGfsOyRere5egZBr3r/YbKBR29oB8FWJkmJse0hq?=
 =?us-ascii?Q?X2sylIJQAyR1GDjh9cFByhsLnI6N1MH+AVJmwRb8LblD710QNyUX2Vy8t5l9?=
 =?us-ascii?Q?ZhP+C++8to8P1moC+jEgM+1YrXGw4WuKaIPNAgbVFA/xbZKNi704AiM6g0hh?=
 =?us-ascii?Q?jyRLg/BgscC7syYTxv3pDLeaFwG6mSEzHpb/aJhPNWbQ6yamkafnQJzOhK4O?=
 =?us-ascii?Q?eP+HavCAxI0HHF6y2WHIg7jhnMMmXb1yiygSFljbtyfSM+E28cc0MBKNkueI?=
 =?us-ascii?Q?qx+kPefrf3A4Yvn8BlY/R+6cPX/bLMmepfFIcVb8Aj/by1dXC1kuZhVww45t?=
 =?us-ascii?Q?nnuUh+X21mTM8IS1R2lmFls/H8Ne4tot3/kRKi4zlWHYX5FzHQy9sAMuj/qH?=
 =?us-ascii?Q?xjVf1eV7fCgJucVt/v5tfXE9qzk8sdCeR8S45MSo4Q0WHvQzEZ/zuWUv+hNs?=
 =?us-ascii?Q?0pv10zKytLjmWgpzJbKkQ5vUsFbKnErovGcutFCN6nT/soFkgY4YJxjItPTJ?=
 =?us-ascii?Q?upBRqiYQi9xKHrGCevvxaNJqib3YkitH0H0kUNGwpld3nvKp8esJquHwFFJi?=
 =?us-ascii?Q?fpHLE0sZnlWL+D70EiIF4VnEHpEuFa0CaclXQOQb6pR1ahYxinDL4DCIltAZ?=
 =?us-ascii?Q?NBRBJV1Z+IIsBBnIWx4B+56TeWDFOQdrWWuiNva4srCJscT+XdP8HIqeo/E+?=
 =?us-ascii?Q?YPCc4vbdvgppzUeWmzVxEJgrTn/H+riUlEy53291p0O2bu7m0b1OHDfl+ld9?=
 =?us-ascii?Q?BIXvjVglo1fvxjgbhMJ7eT8TGZk8Gpy/K7BOEPGRRb58UpDRJu5SkKyuzbRi?=
 =?us-ascii?Q?RzjGHobjU+MxWTa1cD9wV8LjGG51HrjQtpCgPE10f9mq2CN3guvtBZhGslIf?=
 =?us-ascii?Q?xRcth+C/w/ZTgALWMR1KNFwiqiZ434XfMOXuVHfY9hD8vk8oMX0E9Lf0zMz+?=
 =?us-ascii?Q?Qcriz4zDsbu2pLSjPOvzgqCqG1vS0CYAK4yBPLjM5CUyqrZN6q1qRBYqzcq3?=
 =?us-ascii?Q?wGyKgjiYVHNKDcvW4Cuvc+ZVMvxNkx0exUy9QOzWhfxpTajGcZkgbDp0DP96?=
 =?us-ascii?Q?jDpU9sYO39DMmDutE/eVyRxKp7lJIrytF452sQ34LQ2u1v7PHcvqrJ5OrDlm?=
 =?us-ascii?Q?pK8gS9qWz27srAAsGsnwKbZKw0Tv8wkgMjZCq40Oo9dAhoROB+5TX5uNIx2Q?=
 =?us-ascii?Q?zJRGa08VDxu71aqZfxWxrlSWW5RvyHCoAf4sfeDTarQBom24Na3RrUnyEAEz?=
 =?us-ascii?Q?Dz4jL5mT3QihWy4y/zNVvxPa66X4a6HrczDmW5Bwra8jFMGJx1jjpEr9ZA2h?=
 =?us-ascii?Q?WR30Y03Mnc9CX8wHgOTqzgsZs1NYvuu9pySH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWPR04MB11150.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ar6WgBjpAK8WM3Bz2oAbkToGbQQndgKnJ8sQgUQOb+Sam+AOF1B+ScPduG7d?=
 =?us-ascii?Q?JrMKkFZcsn8dKxV56yo+RuTQ60uql8grkPR1Wi32le9xkTl71T1fvtrvPKuG?=
 =?us-ascii?Q?v21YmfthHXdlKVVvmWnNQxT0jRVHzbM5BgWnabSZ5Rl2DDAe1PbycaTeaWti?=
 =?us-ascii?Q?GjMEPj5L0qDg/IjeYmxndwYZxX9DRfJnIY4LsJc9WflNnfAbAyFigeydn/04?=
 =?us-ascii?Q?BZ/vRKfFe2uU4VZkQKjwztYWtkHVDa0W8eOs0HHxMWnm037Paghi+Muovaid?=
 =?us-ascii?Q?1pFKYF2yIszkjVR+bnyjSF7FSYAwJA0x38gbV7l0y8oFdKAuyvEbwJf0HBjq?=
 =?us-ascii?Q?dw14BF788pLo5z18WU8/CY6OuJe9W85ax/rDhSEPDsaOeTBT/5lx4KbjAWMo?=
 =?us-ascii?Q?+PpkEFN43U14IfbbDPh8jMuSkEe1jhRc9Crlnbp6+n6ycsxjttY+jZczUZRw?=
 =?us-ascii?Q?4Q6cAJ7iGceckJ+MKJPWIiXO5wOAZVpEy2PktSX3yrd5hXU1w1ukxbM8EEMX?=
 =?us-ascii?Q?G3bbvHxA2gi6BnwHcyK49Tb2jbWn9NZSpM8poSAKSsLfkgmk4fy4gaZqbz78?=
 =?us-ascii?Q?iUftWUKqNgneUpQf3Q1oA6y391Sd7r+k9msyFwSODQgAB/reX8JO6Q/yXRhm?=
 =?us-ascii?Q?jn5Oshr8TOMsofzWpECtefol9+32EeqDysGNQGSpaI+3akVm5CdUusRA9nNf?=
 =?us-ascii?Q?g5jrPSy3HGC9IRhfQYnIR/4CHDjoCTYxLpu2cBeXvObtH+FGkRn1Z77Zo0wq?=
 =?us-ascii?Q?rHI0JhdnT4tB0IkvOOXpJOIKTdq+l9ZJWYXAvIR8WFYkggryhD1o/Jbx69/o?=
 =?us-ascii?Q?BwgIr5RQzKzugpl0PacAxF2HPJtCJmgqHMFtDBQq8UcTWSIXaZWxBpCOabjN?=
 =?us-ascii?Q?+LFM3w6MnZXtby5unZRRwt4UYa30/ZztzSXl4g3hjysh4GAMHHRxSkeOHOfh?=
 =?us-ascii?Q?W1EVg6FeZS7w0iuvwf5mG0cFMsIFPWA+TTlJGHTsPn3ZTIY4j/+W4oGmQ7Av?=
 =?us-ascii?Q?pHJwlmBpRePFvaV9IKbqNuU0wrhODpXN+1IOib6syJ6FgdMkc4+IsdN3b1yW?=
 =?us-ascii?Q?lSc1kDZgcivr86ciwYjWARZ3HyWVwWqwxIk+oeMo+KmAlBc4c+dwXa7bWRIp?=
 =?us-ascii?Q?Y7BF3pcC+mNm7o3m+3AQrGjAJCLZnGxBzIisVDMKbsd27G8izGuyFuaw+2eB?=
 =?us-ascii?Q?hk7AgAXYy+SRysnz/pw4+99h5RF/nqOykdxwLN8Q7fjOky5DkXIqd4XzBRah?=
 =?us-ascii?Q?u0/8dA1FPd2E7Xe5pjIaOLMIUYwVeBhqvBanH6Km8VUiqzo++Q3tKknnjz30?=
 =?us-ascii?Q?QA67WEp0NZ56KPCWjq6WyVFMbYmH0JVOKCLoDktytD6ZlH09KwOsMI2CnMFg?=
 =?us-ascii?Q?+b+nNsj7E3GF8InkUuvP1q+HD2773YOSD8Mq3TYXrrmnKz1W2aEkw2Fc/mfp?=
 =?us-ascii?Q?+EeqJxZqCGFlw7MFccx7T8jhdMg7oFVzN1oJcRZENS7jpS8R7kaLI+m826Go?=
 =?us-ascii?Q?Sa3GOFQ3LOIByeBW/PKjoR6nAwG00+eRzY9o5JG23c9UkAEM0+hMBNra1H95?=
 =?us-ascii?Q?8usy+EbjpzGSZCSAXJpAjfwjz9E7G9YLEz6V8IeI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a79d88-e587-4cd8-cd25-08de2585fc2a
X-MS-Exchange-CrossTenant-AuthSource: FRWPR04MB11150.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 03:04:13.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdASMmvIUfeeJ5m8wjqvpWQxqp1SBChV1ErOrQHIpvstT26TUfUEZZwDjpgn61fTOi5k4X3HVjnAJ9KeaXX9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12109

From: Carlos Song <carlos.song@nxp.com>

't->len' is an unsigned integer, while 'watermark' and 'txfifosize' are
u8. Using min_t with typeof(watermark) forces both values to be cast to
u8, which truncates len when it exceeds 255. For example, len = 4096
becomes 0 after casting, resulting in an incorrect watermark value.

Use a wider type in min_t to avoid truncation and ensure the correct
minimum value is applied.

Fixes: a750050349ea ("spi: spi-fsl-lpspi: use min_t() to improve code")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 8da66e101386..065456aba2ae 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -486,7 +486,13 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
 	}
 
-	fsl_lpspi->watermark = min_t(typeof(fsl_lpspi->watermark),
+	/*
+	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
+	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
+	 * it caused wrong watermark set. 'unsigned int' is as the designated type
+	 * for min_t() to avoid truncation.
+	 */
+	fsl_lpspi->watermark = min_t(unsigned int,
 				     fsl_lpspi->txfifosize,
 				     t->len);
 
-- 
2.34.1



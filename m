Return-Path: <linux-spi+bounces-10081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD24B82117
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA99C3BA6C5
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4885531062D;
	Wed, 17 Sep 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="oFw8ugB3"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8D30FC1C;
	Wed, 17 Sep 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146357; cv=fail; b=Noa52XbwRvrofp/Knh9vGB3K9ns0xBqnPyJEiFN5IBa1PCM2mttVCmq4nE/hzVzeDnYWUKXeZrBn1cKa9huCSmQ0mv3J+1CvKJ+aCKgqD/+emaB3uC46foDFMGbEnIy2ZLrREWwy1NoSM0dGWsgl4PV7whgftTpIQ08tx2pTA5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146357; c=relaxed/simple;
	bh=8l9JymTCgM+epgUzk4VcWqTdwxznhd6zcMGkq7eDAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJyuLw01ve1tyf2ALTRE7JLyMoX9MwR52cP2otFM6q1HvjNDNMEgPKewGZL8rwFx9hLfcS2WaqK6FsMoT5A9ujp0EUdTFoSksZzq0iQB/qx7Fx4v3BBoHn1gCHno5P+j9KYHpH7Z6as6da5brpl18a3i/UxlVnXThY5XXAVDhPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=oFw8ugB3; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN+VnPiBWCcEhzvHmOZJqC40uo4q549vuA4NPiIsGY9JZgxt7kx7hWRSRHzmey3p93/NnmhEQJbeXrc6/cmWE3QYtbkWtFWphHyIWHjNiYzEkkexRX+tNbOYMcoXy8sb1e/XPH5v2CBi9WvHqE+Ou0pyhcfTLqRyXRp9Q9O5nGRurWydnQTrS6eEgJXDo82CDyV1dy7G9+wLkQ4kbkRcCI4ju1tpjHV3wP4bnujXEcJEh8sjfg393CJwqhRVYYqYqomH7kCJp7TJJLuDwgZ7Grflas/iUOVeGP5EPUA936yPuEkmXkmoNKDAYRLPKoItiZRocTl+lRbTCPdRAs/YRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=jQWXX0pnNMGf9lXg2YD6gTOYlzoMLYI77BjPoNoLZn3/N6GnfLSe6oO5AEibyVe36+M4isapNBnM4w/hGfqIkJjJdrPdssGfm/aPB6eKLK4KXDlQ3qcZX9sVA1ZcqpCa0KPAlmiBSksg4KZcwsryv2iky0cCBfgEMnByH0Vf8cQF5SGiNYXXSW6t9riAR/pfgJbNlDG3y/LMDLshUm7aKYliJHgWDQdjz1IJekQ8b3i2FNl5KZtjlHwB4/AenGwxv1Fq5jaMCNi31M3Ip+FLdYdipkoFKvmNS7F/fVTFRvTVu7Wpx7LC9tNILlZYv1EIzHkeMn+zIlAbz5Nz+zwtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=oFw8ugB3EQib+CGgsVPxjac9QhFnXJ2rjXG60mYro2wUeDiug+YkxPFauciTh9QkEGqikRRYFhJ6Grrll3ZxWdDM2o4kU5w1DGzeHOxlgPgdnABKnRWytPejc77eiiXFFjvNojprmYPLSSksNh4T0ZTQGZ3/WNvqLyfq7U/d6nW9FC/6Z9lgIry+gY5vceSGaFM0YJJPNXXMT+PXlC7yen8E4nUscXZDtnCr92PXKMQDduyR365N3fzfOXMKqiGDBmRAK7RhE8M6WksuHuvmKF9ox8YIiIzzFL5Nv1Uqk00c08b2xFTgXgWEFz8UOUTJcIMQfe/vpknO4bqDiB6mwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:11 +0000
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
Subject: [PATCH RESEND v5 07/13] spi: airoha: unify dirmap read/write code
Date: Thu, 18 Sep 2025 00:58:43 +0300
Message-ID: <20250917215849.19720-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 095d4647-6ba3-4da3-c15d-08ddf6356f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7liu56iat2l3Hm1Y3ke/ple1KS1MHbMHOAtKHff1m13pQUNspYiXrHaFpfVM?=
 =?us-ascii?Q?7Y4GUaHJRMxSdEUL+fzcLeMdY/wXzBrd8L3NgrhgMZJ/kvXxmG/NrmP9aBGa?=
 =?us-ascii?Q?PdS+TObJS16Ztn+WRi8dAFloOeFy7tHy5ruw8LyH7fCygmmWfPW7Q5VvGe8D?=
 =?us-ascii?Q?VZcgNbVROARK4ZFUCpN/jTu0vIGBJHakUA6IkOsRkfJG+xKZLGgTQT264umf?=
 =?us-ascii?Q?B8Ye+NRc3It93PqL4AZWuBxYpxtKN2RsnNg/Mzsta1NM3qCrDE0oLBRN+sRk?=
 =?us-ascii?Q?58d5WoY0VI+s2SSJdpBnKwpcAyies1JOMDI7cc6dajebRQERIO6oCHhojGh+?=
 =?us-ascii?Q?RoywkQvqcd2s1vf9RJRW4oWtW6hmRpNPyPZLH3s6oGkmHgtEPD4ogbrCdEV5?=
 =?us-ascii?Q?TVS7DsleqDisbQiz/FWZFY8ZoHtjOgeI6zsv0+GXtpIU63Cr7e6/Kis3RFhX?=
 =?us-ascii?Q?O1sgFhyzo5D5ZKLEj3fH43VLqpYjKKCcVxxhciOBDE3xOkg49wiY1eBn4LY6?=
 =?us-ascii?Q?PHtdYVlzpjM9/+hQ6hzrbKLRkRGzl3on09XBEM1XPcHtLi2xIGRjvqm+vY7T?=
 =?us-ascii?Q?fY3LpJQGUfLXm5RvqWH/ajaRBfFfBj8pXZT/BGHo/0to8p2g8jxhlY4unlTy?=
 =?us-ascii?Q?2qTSYuc8x19rUIjQamwU1Ci69fP0xF52n6NL3kdAogS0yY+jvY5Bej/nSmQb?=
 =?us-ascii?Q?xE4J5xCpCL91Uppf1bZ9bKLI8I0czXXokmoZAMvQxX4LM1zwfDVANzC/UI1U?=
 =?us-ascii?Q?dg4UDWQ93X970gH52HesFj90JSgQKxZ9bN7ors9NJy4pr5glx1eG6Rbtv+sp?=
 =?us-ascii?Q?1Ph8eFVvNypkz2MKn7ERF38fI5Uj3n/cCUw/cqq0tBR6DTKDZu+nyhtjoFSS?=
 =?us-ascii?Q?oxwUcnvXs6ZdZ8K3yILlw3OIurCIYy3+S3N/dOmFMjfk68ibTsOjH55GFtfq?=
 =?us-ascii?Q?D3O97PAG1Hm8/eZGblRIpb0k8JW578LgeThEQ5/H81eo7AKy9BZsCWoMUlCs?=
 =?us-ascii?Q?rcjSl6wHznOzzMBdwPvfrvcPZxOZXJwmYcyo1irDFmcBsng6MlXzUrGgt1fN?=
 =?us-ascii?Q?A98GpO2gskpgONSHTdN6MRZbKmVLajI2prDbmEgZXvvENQ1LXF57hQv7vt1f?=
 =?us-ascii?Q?qer+seZCZkUQ7cbqdAejC5P0WC846F21PYFlYwsWs4C+BzMdg5gq3PE/WbI9?=
 =?us-ascii?Q?2vr1uaddDd4d/huYp2xpJqB7MmkX3hmo6XdXykgqfMK6TchnkZryb7A2a02m?=
 =?us-ascii?Q?kh5A/0yfbw+vqMAfowrUY1LCzQq3dRCLb11v9O9I5qP+DfO8WtAtTftxm4as?=
 =?us-ascii?Q?8wcJ5/jiK4rKOk1nJVgTx4wzND1Y82ttaVi3Rfr7HxWYb7COC+sWRrX4y8a3?=
 =?us-ascii?Q?7LQVAp/jkOMtTSiXd2o2lH6T3QS7biX9kK4DY/spB6KM6X95GBdT+HdBbi0I?=
 =?us-ascii?Q?f9L55NsBdzO99cWZcGSYkEReLc4kuHBnRv8t8LNl8Ozq8Ot/AjX7zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HDjaYrWAK7pR9aHVmWo0oUbTsSmjcr/JabXucga7cRheQeNxlbACzukKah1Z?=
 =?us-ascii?Q?2ZR5Mo/61os59rEX1BCiccv6BG3+2n3ahwFOfN6423sj24mAOckW84f3c71V?=
 =?us-ascii?Q?qirDL0lA9gh2Sv5E05rkNXJWmqnb+uFtKAFlUdwlgjgUcvQwYSNv0qCXqE9a?=
 =?us-ascii?Q?2voMy7X8yRejhNo/Fhy5ty1wIxH551R0/L/7aZ3koONhP9PNioQ8CW3A0D3i?=
 =?us-ascii?Q?bqVnmFPjiOQmt+QzKGRA5RflQZRFaYYDaYv9CfzA+mTb6Q7hAfGLosKUPPuQ?=
 =?us-ascii?Q?r+jbRZJjOLLGBM40cLrA1LDdZ7YhDG+gT8yEpjuwS4O+/z4En3hjhvS6fF2S?=
 =?us-ascii?Q?u6LNT4AJAxSjQMdJ24DRpRBmP6grQZ7vY/JPw75Ayt5PFRRolmD7qhKQxo6K?=
 =?us-ascii?Q?50r8kg/bDhWgfBYeNTDNFMyQg/Sqzo2a7Myg/xi/SVarEvLfx1XTvA6EhHNt?=
 =?us-ascii?Q?ybxBqn12LItt84awPgqbLUgPiCjWjoI2R8PqjVj9FLhbW+w9jerOozCbVj2g?=
 =?us-ascii?Q?bqvjquTKqqg7cn9lVp7zShax8sLK28uepnE4x+IYdRuGRcI2BiCWgGG/APQe?=
 =?us-ascii?Q?9zpTuF9ejCmIlcZPtP5RqRDnf2ILZGDDwUD55iNHsoUCpaBvC2fENPIWE+y4?=
 =?us-ascii?Q?OjcsRWEi59t3vTzagfm/WU0xdYLa2V8AAYZGKLFgQt8EooAXFhjbsTjfcYA+?=
 =?us-ascii?Q?2UnYqv/66JbTQhTi84ChxLIRRY37p3tTcGEePIpebYcQyo6wq6P5W+aoXbYN?=
 =?us-ascii?Q?djmGRzIWB+vcVqH3nMDXK/ympaM2+n4L9g0J9wVE2BwT1WgwfVxG8qxpu/uF?=
 =?us-ascii?Q?mSndusOOjY/jt4SmT79gT14Gb1BrlkJjwdrtPE47J4lm4i35KIOu0e6JuGp7?=
 =?us-ascii?Q?MIISG3PyEfHlkSz9JwGy7ALNo2BBiataJ+4Ek/JX/O2EeBUMqlpPPl0Ghl0z?=
 =?us-ascii?Q?V2vsy2JyfXe5Ecot1c69+WxChEBrKucGATjpxxWJ9KX8ihI5kiOQL+qQ5gEk?=
 =?us-ascii?Q?+t+gCgKIP463eGtRdozv8zIt/8dEew39xxZOzNtyUPoo+dSVaYbiRRvLet30?=
 =?us-ascii?Q?pgdUgeXpxnBnArjFVuqFfWOJFzevBQierIyq4Hh+00NblUvSVVNj8o1ekz6r?=
 =?us-ascii?Q?ggzmuXKbl0zV+7pFFlxNq/A/8iMI2j1zV6eOjSmWfjpMgI2WTbNPb/9+qn+u?=
 =?us-ascii?Q?v72TEaONpGzSb0RrRQq5PL7pzAcEVkpg6/bHZQ9DlQKascsim8GYAdwciVGY?=
 =?us-ascii?Q?DVj2g935Os9SJtzRBDMWnfiE6rCnLJyZNylCcfwpAF7X+Ym4cLG8ivriczC8?=
 =?us-ascii?Q?zpSVYypBnTYMgyfGWIDawo1uJ2Z/faCL4weUH0NDu/VMLr7milxWPHjRA64o?=
 =?us-ascii?Q?yOUKJpMUBQvshdZlOkiuYT3NfI/DTyU7O417pxdwb21HAeIo8ntpq+mWUHGE?=
 =?us-ascii?Q?1c8+eh8XfmMK3zfjLIx0NjPTNoUrxo5q8VVfUmDNALnHe2nU+sahG1+uy1ti?=
 =?us-ascii?Q?9kCYgOoJQ91MoRoA6Kr0hV9OuJPCdjQ9Sf2bozQdJRkCeAi6HDsnQa4s4Beh?=
 =?us-ascii?Q?KyjDMkQMoFzfwJ7cyd7bL8lKInLBR1S4f0Frp5RkkXGD6B5MrvUUPIOfuT4D?=
 =?us-ascii?Q?RjkAuqQM1lJEMRpXk79dV2U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 095d4647-6ba3-4da3-c15d-08ddf6356f1b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:11.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQu4IBxxckccO8ylqP7yRve4tJyn2QigP87Oo6jOO5ApaC5j1Ej5y1wmwTgphssMLB91JE5jCjpRkKA7nL1+GenaPX/5v/1V2giqWqMU4H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

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



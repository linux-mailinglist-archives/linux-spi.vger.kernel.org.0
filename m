Return-Path: <linux-spi+bounces-9453-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD3B272D6
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8503556815D
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2D6288510;
	Thu, 14 Aug 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="d+kC7qjb"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023077.outbound.protection.outlook.com [52.101.83.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE62877D3;
	Thu, 14 Aug 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213150; cv=fail; b=LEVT0fKCgTBe5LeGXlZNsE1f2d1G+bwxRe3Zj+RKZEpg48yaLFN8C/p1CJD0bIgOyonj4EU6cQ+J/u/LHrgc0qkrr2jzQW3CgIQU2cef1ni6yRgWjU86ey1p32RDUCZninwrR5aLCBKaQqM3bgaxyaeIFKXpMxyAn4jkdiQFYW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213150; c=relaxed/simple;
	bh=W3BLPsAHgVRZb0V0HSjAaHEEtgIWmxNrYWCMpmsFX/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gis7OvI8M8cHtGLV/AVaScSYYCY/gRIkx3RQIbZd7TOed43X1Cel1yF0lKIHvZVMbKAx4Cc6kpSXxasqgBQ9mr/Nyn2St73KXMntYJOs6FNw6xIMic0E4iOzRq2Lbk5iiuYjHKuL8ajRRRDmdAfSxUZS5bLwEox7BfccCcQDOlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=d+kC7qjb; arc=fail smtp.client-ip=52.101.83.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg8MFlwQr7AjpdfaD8BITBGiSyfUFLuDxjb2HI90nIFXB1dVMlFPnDw8PiROMtBtpHEEsUMSFzKMdraAmGsLU9OU/TjChfN2DtNxvVDh2lqGwcPG8AqWGsV9G30ktEnra9Hd0hbpQOd7jdQRgvGfN97g6kiAWKhsIGuo2fJKu80ixa3I5SXsSUesf0aSIWg48TC5ZP1PR0KG410RhCf8C8u4xlFXWVMy2RW5awQZPWGlINA0SwDjNiLsR5IVVKRB/6mpDwYEQ2LeDbUE91ccUU1VBLs5E1N/M8qaBZDtz+6czfvSMuKcLzVrAp0uEM6JzHnOQ1A+gvkEp1klLF105g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIdjPD4DG6jzmeIiCMn8eFSHyQL7FEVD7vf1+tAzdGI=;
 b=CebY1rCU4CsNj6EN9YKjzAVlA61Dqxv0IQuBUPVvyjvYtLyfPRLqlLVw+uXNBQCwaoLzdpXiFcdNQIyJwrXp8wAy7+hB2MxgOEN6Fs3hn13qu9oKtGHLWdLhpALcf/9+JtEoDa1XWP5gLivqJS9l8neE1+vZVQPOwmwRuVxx2t9/fQNcDCX+wi3EDRaOdUXaw3RLryqZp5mxSP/WylKMqIzgVXAqonemrgFURiF/3DVX8WO2qOZVATBXePoAFW4uKEP4ozErLC00So3krs17YGW4gyimwDQMaZvGMRiYbfoyo7rSKoHdTu4vfmmv8GU4fksltf/xq3/aZmPnBJm9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIdjPD4DG6jzmeIiCMn8eFSHyQL7FEVD7vf1+tAzdGI=;
 b=d+kC7qjb39nB5RcSs47XEfmsGsLsAYcF6VmUHg7dQHgYKvuQOcI68QGw0TZpAFusWaRNfv61Cckmrq9AL5K+gwdF3gSAqHXmZz8weheHD+lO/TapqOrUz5cGj0llEuCRoPWg6vTWQKKMy9f6EBAPygTEnEk7BQIlZ37tyLUdszOQFzc1GKV23Ewv2V9TvlIPEQ2M3MWj9x7Co5nrMArd8AbEladtz26cqRpNSpeh0MKkJ0dPijfQ2gcggNFUDig65EBBSvX938kRVGDsUM91AgD586mydm1XbddwRDA0lIVeDFnIkW5thn+jznlQF3PB9E+aXKfMVo3lkEnatD+VOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 02/13] spi: airoha: add support of dual/quad wires spi modes
Date: Fri, 15 Aug 2025 02:11:59 +0300
Message-ID: <20250814231210.4174427-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250814231210.4174427-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 759fb265-7e31-42b6-3598-08dddb880507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1iqsBUcBckG/mCR5QehMelQm9ksKwvXnweGfZg6JlKdrioifLuacQ2dgWAJV?=
 =?us-ascii?Q?6NY86dJaj1HpLgF8oXdmobao0DaN6A4Yf1AVV7d7eS+8rWDqhgyf8nC0GAgh?=
 =?us-ascii?Q?fhUYjj+3UfT9ixWG8k64m6kRQ1sv9l2umm9b5HSBx/kYDjR+kxMfUOlpEp/g?=
 =?us-ascii?Q?aWf7uE+q7oFvBQHGSOUtjKMZ/J22mQfPyEdi7BEsDd9LPyA0sEv5FAX+zAET?=
 =?us-ascii?Q?XRVoCSQfwcujQcDUHiMGp7TxOgUddt7vwL80UYcZ3bKeHpiXkor4ERtyw45T?=
 =?us-ascii?Q?UygCs5UoKpAh8cLrJefQSW9lNxr6g2pMgtDj5Iikzv+m9EPIZRWPAuXNzeet?=
 =?us-ascii?Q?dTUUWMWFdtNrvSt3zwJaqWWxRJCXHaFN2WYYO+ZdSBCKsXUwLe+J9CkE5YWv?=
 =?us-ascii?Q?C6Xah8wM9fkao1G8V2eMcwcTSNNYhHmhEOS0WGTnz5mQnAFarplnJhN9OqB1?=
 =?us-ascii?Q?eU6P6/8XiWK4DVWksnYAE3yEc+sk53Hx1EboMDIGn8Ptd5tD5/jlfvqtq/9M?=
 =?us-ascii?Q?asjeU3Afl4ZtnjwKnhG+P3BkmGbWqZWyG7xbmxy8mNG6q3nbRHmlC9o4KnTq?=
 =?us-ascii?Q?xKcIYjXNNNgCfXFQbXrRgkVZCaKF4wcnp+sXLUOxf4OovYT8JdnA9u3zMUmu?=
 =?us-ascii?Q?6DtcFRDehI+X36XfqvWJ6NOB5+zih1yN1jW3ulHi7AoUkdvR3R6qGD608R6R?=
 =?us-ascii?Q?nlymJufFQ5mi+JfN4AeygdmN7mSb4jn22D45QlqED5z3rsUljztmFGivI8fD?=
 =?us-ascii?Q?kg9FqWRjbhwNWBsw3lTWK2ZfMNqUJDcovEh6MaCTiZHKyfSATuaVB/I2IszQ?=
 =?us-ascii?Q?c7eQ9BL5UO0YlsVDIpOVdlK0HBuvoLcVdnFh8GeVoBc4m8XB5Uck0dd3q9P1?=
 =?us-ascii?Q?Ztls1sx/6IpCTtES7tpCk0WUaGhv0D7tMcTEOjO1dEaISXNoa9uxv7/ZYH9a?=
 =?us-ascii?Q?uEYnMqEkkfpesSSaRKz9Vmds6LEHJCxju8xqYYQa6x8vOrRam5n2OXekPOLW?=
 =?us-ascii?Q?4w51XsDtLNLy+DIb9IfqcV+JOKGyxIq4AeQzc1JH4PJbKJiy5BBRfNTZn4eA?=
 =?us-ascii?Q?u0EZ1MS2RUDySVEyCZEI2eC4QA7CZ30aWCA21bbbKya0sfWNBtF5iUubsBwE?=
 =?us-ascii?Q?Dk5Thxi28SmP1Xta5vg6Xs1CSnJp0w7daG2bUfWMhoZkc+aGkB3fZ9fZSdIr?=
 =?us-ascii?Q?E+3EGtCEvCfkD9LjU/naNcZXCDshLhf8MNRWHZ+0weGGPPU+NYX1P+nJJKXB?=
 =?us-ascii?Q?HbgwY9x6Dwpk5qR2baQnCJLDgNHNgebp4RCO+yuRkpBDRxMs5LD8RZRYyYXq?=
 =?us-ascii?Q?MoDW7qouPfyVF1t8qhgfKnfg7kpxYQB9vPsTL66Agl8oAHp5J1zP+95SFWUd?=
 =?us-ascii?Q?+8YQedIfAzBhr6AKYcMYiDgcfkjvaqqe8VYJGvvcrp/Ido7X7SblucR+71uF?=
 =?us-ascii?Q?kTovgcwYPVYNuhlBiC1RY6FCi2oeMYAHnFJajUe3e0UuV312DVL4fA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?741k5slfXYOsPiICwMMpEdYCDrV5fJlvxF62R6DI0UFvNdU9oHUaSIY40H0G?=
 =?us-ascii?Q?2L3RHeOIJZxTgMueDyWoun6lphed8Y3/255KGPpRnQygOdCYbeu8mKnHzbeV?=
 =?us-ascii?Q?3rvKdqtcJtTq7LOgUlK6D8Zizpwd2NCqz6o4OQUPdEZoyI8umf+EZkj/qhOv?=
 =?us-ascii?Q?SrKwEpER+Cl5/EXL9INdU7VwtC4cN9U1JtIHF8wiS73tYqBAfk892X0dwlKP?=
 =?us-ascii?Q?w+aZCQfBenqkwhf+Y3hMwJzx0uMbdCP53sP8HHspB5vBUrrZcMeWOjNfXmz9?=
 =?us-ascii?Q?sFJCYF74adT7BTSzPDf8QTB1K/o+EqbllA6BIBgiC9mY0B2mXbODjOFJqQT6?=
 =?us-ascii?Q?kTszSpADWcsSjSXQpyo2mGnmmRvA+1GI0iyAOM09ldFju32EQWWEgwhKccsv?=
 =?us-ascii?Q?9442hojtQWwJ5ooEmyP+MWFyCFmkhO2epzX5vL3m8HLexbTTBsAwdDWiC28g?=
 =?us-ascii?Q?ZqQPunCtv4m5Az3Cf7VcwHtuGkgYiRpkMvCWomBkZ2ma7LTkooW+1QgIOrd4?=
 =?us-ascii?Q?Um1Qr88oWFJ4Rp6kI9MOYVsLWw0vm+CW6nZfLpe2MrI/kw0eT1UU+OqYgkyc?=
 =?us-ascii?Q?No80RHmkUbDb42faPYNvHSffeUkwuuL/UrA6HnMRs0jENu6eT/1ZFrqVM4mS?=
 =?us-ascii?Q?HWL4dgImzxXo0CW9ERSrsejzpDXkt4Ji4geWhlMhwPcQ3NTk2FfmD/zEM4W/?=
 =?us-ascii?Q?pKWoOqXDppsujohCBviZ8+s/ThogBB46UHsnKKhpLu0zEH7TIaWtYCt3fk0w?=
 =?us-ascii?Q?dQhXO4DptV/10WhgfWO2nmOJAZbFealTBl+it362hgqVtdKPHqP4Im5NqlJC?=
 =?us-ascii?Q?0Z36PStKNNj8dmX01V0k/j5X/lAhgDArmSQrbGCI6UyRrccEadKLDE2nmKCG?=
 =?us-ascii?Q?Z7aZzYVYNSGWoQMxDS0KQ1T5KHUxvDehyoRDbIA5mdSTbdcv6pXj/sGbYaWB?=
 =?us-ascii?Q?A3+jaop9CI2C/j/VlGkmCKh4PZcXWWan2kFBMcCFE29egmDLjGcaODtnDe9u?=
 =?us-ascii?Q?IOX6gWTR8byU/2tjmgIlGPkENkt2V/AgZmiRQryaGixHcP40a+4ia5IvtcIX?=
 =?us-ascii?Q?/CZD/NS4dJUlrwUtyPiSEJBSJcpjAH06sXWZJZmNQdyH1DtDPm4KIWbpE9b/?=
 =?us-ascii?Q?XjeSohZZwoJhrOmw7k1pWWtuqAaKO65iEa6Tqoz9u5gM7qJbAnoSUH3E0iFO?=
 =?us-ascii?Q?MaFuaiDmz5IRIohLn2mr0jYVrbWGSFer48hyxMhGinVPEwhVI62f/58ME3Ff?=
 =?us-ascii?Q?QqDNJxgNWU/hX2U14idDmxHu1Bz2vYGNk9qMQyUX8zbw2c46aye16118aItX?=
 =?us-ascii?Q?Ap4Cud4QymaM6wN50oykl0Fd8drzNLp93RMQOa31FTUcPFcC3DT3J1yZR3W8?=
 =?us-ascii?Q?N+ENR+5N3TfqH6JjkpTeX7snfCKa0EaWXQ0jbJhaIqc+e8XYWJBQ9YCxl6Hk?=
 =?us-ascii?Q?jrGY0X5X8bcU6NArnPNlr0xIEfyXVPxDySoyOjQl6/6hh4V7sF7DI4eJZuSy?=
 =?us-ascii?Q?tsWokGC7x3M2pOGyPhhVEmkk0KAEXYB3m5HwUKkTzfhzKr81HCbFwIsIrZTv?=
 =?us-ascii?Q?4+4m9nfppeREFxFkrzY9t1bB4iCvguH8huneDl2Gf1uZWR+3TUek76zffzFg?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 759fb265-7e31-42b6-3598-08dddb880507
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:20.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTX+CgN9/6/z22EL7KSIfifj63VlOzyRLNZu5WnHPTqp6bBrYhDb6QSg3Z6aH5T9z4wWR4SF+rQHvgJqrY2cSeqN0bMtJCrtarNa2VADVfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

This patch adds support of dual and quad wires spi modes. It will
speed up flash operations on the hardware with corresponding hardware
support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 111 +++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 09dbbca8bd2b..70855975c2f3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,25 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +432,31 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -596,9 +634,7 @@ static bool airoha_snand_supports_op(struct spi_mem *mem,
 	if (airoha_snand_is_page_ops(op))
 		return true;
 
-	return (!op->addr.nbytes || op->addr.buswidth == 1) &&
-	       (!op->dummy.nbytes || op->dummy.buswidth == 1) &&
-	       (!op->data.nbytes || op->data.buswidth == 1);
+	return true;
 }
 
 static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
@@ -891,12 +927,27 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
-	int i, err;
+	char buf[20], *data;
+	int i, err, op_len, addr_len, dummy_len;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -907,40 +958,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.50.1



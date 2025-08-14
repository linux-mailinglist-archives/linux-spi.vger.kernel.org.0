Return-Path: <linux-spi+bounces-9461-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D43B272E3
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB515684F7
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A682291C2E;
	Thu, 14 Aug 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="rp7H4SBJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D128D8F8;
	Thu, 14 Aug 2025 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213160; cv=fail; b=fj76SwRqF6OsKGk8BS6e7uPME+qT7kdwOWzHB2qx5etk5CMPB1hqHlyd7ow4sOkXQgibiiqIWKi1ekoxjVfmdebnuxAg9O0MK4vw6BqzhgJQuT8UelAcuRnVXGSzkgsGcDb8LDWTzk++n9yjMfhaq6H0YqefGaQ8wqZu82a9+WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213160; c=relaxed/simple;
	bh=nyl0xOn5e93yxpSKfwKUYJeHGmhFJ+9JhjFLUMekYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EhufYsigtMoxmKmyMTIP9zQ1JU6mro9hnwPtBaCZBClX9J+qS5UgUg+ZZHUJbAQh5gyyWuPwv2JeatEcRszrpFH7ocsKERT9nQ4yBma4ZoMb+AhGs2kO6e3Jzq/Rr2B6g3jKbkA6PGyO0HynEKgR3JuTSzuJxf46+4Ok63CC99c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=rp7H4SBJ; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaSc7Ys5HE2YBnIUIUW2f4qmTzcSjj5/FIQjPPERFly9siITwgm8WMywd11iml+A6YBcMApNT5Hs11eaX+Ceet1pyC+P9JQwKyvbY5s4IOuqMG+lJO+cWjBh9zEJplCFEbvOaoIxhJOILR+TuKV1T8jY2QHMrLOV6GictfmeQ5y4xYRGjleUokSmJiO1RxvcNa1rv3Px12rhRey/PUA2I72g/CpylC+SGKWIiWCUEof09bulO/2op9SqqMS91bJcpC0YfKgOwl5o68YASly40im8KZWPdZ7Xn6rbIYf7CbjW/irRdvqxrWm5aD6NSH+u6rV+sBrS20V+Qeko1xokcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSF5+oAvyY84GE65hc7rbbh6mUR6jvIpX6foYEwd/4I=;
 b=yR95pI/hFSdXdUZXIojplXgJ0gTp+wfsXoHA815fE1HpszIb4E1WkdY0D+4Lm5fqzJzwTKIQQUmJl65ibEocwj44FA78ysB7Pi3AEKv5apwMHXJME59hnBh7jAGB0a0L6oM3Zvtt5qq5cwo/xFRkLMTtzXC8rQadKnLJCx/fhKG8Zv2ZqJnZy2Hpkv3KbmySXYQGFxu0JlZEwcx9mz6zxWNZmqK5fyTmcug2HeZcQywwonnFiXYANUHPBz6AnMWek8883zMCdKhGcgfKEnJdqx3ZTWCwTdjZMBbJFaQ1dAHx/zLfs4MPNxC5DhW3IfYrxzPj+E/BKz/l4rzv86TyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSF5+oAvyY84GE65hc7rbbh6mUR6jvIpX6foYEwd/4I=;
 b=rp7H4SBJVa2YkzGme35/3xmYS7wfvMqt9THp9pyXY3RrZvAIJCXtOyqbf06BU7o8yumu0xDcPI64QeyqBIaQV+4wfeNJBCp/28yfdz3rdI5rnTLNFiq/0BqskgTXoIuSMn0G4jBDO/yhPjSNBTqhpbtaLt+852gpnITayFu+aDAwadP+Rbjb66APu7gX/+bXl2wScx7sfBBo+6/Siz/LwlUCXcyJ2TvqyFB8dz6Jxhkkxe2+Njl8eFQbhYcLZRh/zTVnDOe7SHYnmpg/ufTZE31ISYWj9CUKzN4YlLvJr+LysWchMwWy65foHERuV19k2cTvE+r9TxUe1gj3WrJBbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 11/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
Date: Fri, 15 Aug 2025 02:12:08 +0300
Message-ID: <20250814231210.4174427-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 11242d1f-c7ab-4cac-7be3-08dddb880935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?57KCMHBwDVI0M6wOAWU32kF8WFhRXqJsghjFmwazhci09UyDp91lERwfgE2R?=
 =?us-ascii?Q?tlLUepoY4coc17IzgDGulAks2So1+l6DqzOrwVLYise63U8jWH8hec+ydMgV?=
 =?us-ascii?Q?2HFTG0unkyRpTmM0vZFn16XgvLe247tVhs4M7ytysjEeNeEKQBtPNLZ+lq66?=
 =?us-ascii?Q?mBqX9IIv5f48+UQH1EoGf8ScdERo5HNLUDOvJBeXj6E9OEfhUu8M44qzeB3X?=
 =?us-ascii?Q?o7fr8l7MiE23bROo/qcZ9VJBSS2HHyvU58dQvp75Yda7438ma6eOvWJahlk7?=
 =?us-ascii?Q?ohFc95pPPO6/Gzqdp6DeIwkHjGTuZNN6TEtJvfdM1l+qPc0tmT5bdSZbjTY2?=
 =?us-ascii?Q?H46N+cgrxkuE4yLR3GBkbSW0uU7diCn6SB8gekcVvthxgAxWrnEnHIqNBlYd?=
 =?us-ascii?Q?4GgEQ8+cmc5Rln5w0Gm2TNX3IHKkrBlbwqED6ymijzrFkU5FB4lX7193YtSB?=
 =?us-ascii?Q?aRJiiIhQFOFcI6Ldt1GW3PeThxdJX6SvaGxIFn0gdrOosrI21o/Na2DAXflf?=
 =?us-ascii?Q?DUifBZN4H6+VpzcheEl0WDsdM5q0YDjdNHs/WHEYCko10hKvFsK64Cljo19u?=
 =?us-ascii?Q?16ghiqv0GkPKD2baQpjr7xbb6ngK/l8W8hCTNxj6ATlQTNqH3QTpKzdZm7ok?=
 =?us-ascii?Q?Kj2fqueyxAfVP7EkTgkCYu5pmIV48qdMPxGu8ueDlQxyD9RBxmgcYufe7SpI?=
 =?us-ascii?Q?W2LmgB8bFb1zRrEouB/f8gb5ok+R2bs84aAiyyKiFu8i7xZGcm5M+o7XeWkl?=
 =?us-ascii?Q?KRpz9FhwINasl7OmCnPiqFmxdfRH0+ba1rOH+d3FprQ9JHf7PMcchTtiwL81?=
 =?us-ascii?Q?3JNs3WOVj+teWfLU8n8gzqrGZLSoY8fjHca2dum7H453bwg1BaXOm45eQUyP?=
 =?us-ascii?Q?OQO80awCfB6p+H+Hq+vzLPPIeQVEHsXn5FvQEgLYUUlG7QptFtaO3j7XorHN?=
 =?us-ascii?Q?COcm58/62bterLQx6mJ+DxkcoaXWz7Fbu3Gy3iRH4whD/KkDB9zPdruFRCMi?=
 =?us-ascii?Q?FZ5NybM1Vi2P/gsk9oKp05h5Qder17+DL7ikbqAK3ElSvLfoq6HCNL3Z7XAd?=
 =?us-ascii?Q?PN0eY1OSwEfYKqfx5z6kqyRSOJZ3xZqTVkkJ8Nq3xWaJvkz+QuokwiMQNKc1?=
 =?us-ascii?Q?vlgOO6z5aqyN1u59zFGs80/x98cSJUePGq/Kut61l4EJilqbFGFcWKOuQRR4?=
 =?us-ascii?Q?Z69gsZ1aVhioIh2cEC4th+KxmdHjmZg7mmlTnBI/jEzR3succwk04GEPyk7T?=
 =?us-ascii?Q?H/tRt0+nRzfNJeSVpiGNEyn7toUM5uu+aRrZ4N//EtAex4aiQDRYGJnCdETk?=
 =?us-ascii?Q?j7XVSrlrUiMSvzxeHal4PdEidYHROLXW9ZP714qqztRjqom802DR7zlJp3si?=
 =?us-ascii?Q?5K5figa+8MJ4oMLlankPylCA8EMIlP9G8BGEy+ylGQ2++Ye2H7igBHn94KQw?=
 =?us-ascii?Q?qxQ2qrEvO/4Eim/LcfGJWYryJQHvG9QRmVp3jLJ6dKrJYpPVv3yskw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7mbQ8hKpMe9EAUl/Ol9GtDvouVXrY5aJFYccTzmcLItXTIoCokwQJpSWqE9?=
 =?us-ascii?Q?zpCJ4TRG7ArwVsRqjxVXX32xzjfXTyqiwr1UMFqBsg04AWimpFN6fR5f5yR/?=
 =?us-ascii?Q?XBqnoPj1/E5nkwhQcdJYXR4sPPzS+QeXHWEomB7eIZ39X73Ag2nAfOmwALG2?=
 =?us-ascii?Q?gOwKkz/aJOQoRBFzIC8oWyygvJJFq8oeKEpiUknB/AxEp1Dm5GLqIpWzfZNJ?=
 =?us-ascii?Q?1jCm1fgWIk40K8GBjBmODcXmxeJtJEv837r6TCTSbATkd4N3q7eTW7uoC9g/?=
 =?us-ascii?Q?Xyp+wPqzsxlZGsCnm+UJQnFa/183qgUWxd+1wK2b5558GMivYuZO1bpmNtnm?=
 =?us-ascii?Q?GDvfUBza48FpGHDKtiMGXt9lCjW0djx3GWW/9MPSBAzBCBQP8MkHaC0qxfVc?=
 =?us-ascii?Q?HtCwbfttjls3u5u4y3FUuR8QxUgrNKSTnvHyNl9RruyB2HS39env20HBRdcv?=
 =?us-ascii?Q?E1ll0T5Hvf8KaUlmPmKOijrfYn8L0tUF4CsMCB91DyEccYGSj14ejH7+rfmh?=
 =?us-ascii?Q?BWctiAWlZCX0wltQnGOYw3SLjqw89H093OtD4kR54HUV22inewK1imdzEDjt?=
 =?us-ascii?Q?o+97Guhll/dwk2ElHxwXWTJXF5cFwJYGJR7unbRYizUsoL56q2J/5Yo8xus2?=
 =?us-ascii?Q?jNFdKTvh0E6TzS+rjWAmOZYHC4tVuqp9psLoFXkj2PvvDYYeFLtGUNC6gVew?=
 =?us-ascii?Q?zoKEICgzhlGCcKV5cihfaDmAbXJ/g6Bk6DR2s/ukChFUXAViQqtn+p3uyiu8?=
 =?us-ascii?Q?pNxcP+Tt0O7N8C2E3vxQqgRul++409JO1q42nHyS8Sq6mwzL+TncaRnmbQ53?=
 =?us-ascii?Q?5YX7BIdi/qrDEEI8xLV2t7b3SyYeHAJa6/C2RaYV5xFXuWOVkcLKIwtqUsjo?=
 =?us-ascii?Q?Z1IqYHGvij1usgHVL7tkLDQCLFFCWJGvWX088ds3wn4D8RAnbtUA3x+EKc+c?=
 =?us-ascii?Q?oJDfEp/9DQAcQVSmHeJoB5vIT8fsA86y0qfLyM/8032ptb2t5Yez1AlUwzuT?=
 =?us-ascii?Q?Tq/Xu8hnsEmuRrDLcR7GT5Qa6W1QRdFuZkMoxBqh0KdoB4wzDKHIYidSHjwG?=
 =?us-ascii?Q?hzcI771DEIoC/iB0fXqH5G0QEI0GnqN1FsoHWMfksDsXgl6iSl1RYdMnqtng?=
 =?us-ascii?Q?H6gU/KLno0upa2+1za/BJ7A8wL8nxfLIepBuH2tUjhiIPkNdYs1gL8crWdoT?=
 =?us-ascii?Q?ylB1o/MjRNSe8wMRfTkvwoj7T/hgb8QR+/dGQfYMCss4bb42C4u56djIpgL1?=
 =?us-ascii?Q?mP9VKhFcOr4/r6BG640TRuOZW00YHJEFB7+FsobOorDGyeQXUObUFLWNyhJf?=
 =?us-ascii?Q?LOxcjOto1RdTNTvzM4AD9vzT9puhDpPSLJxfWr+8LvscwwDF5X2KX1Idz8WI?=
 =?us-ascii?Q?jLNQhX/RiK1eyX+Su4Ccy1yVLWkl+Mqb22yntQIP/UXl1QF0JfJId2pVNoA2?=
 =?us-ascii?Q?BeKCHDiGyA0zsxysQ2EMDAla6vnvC40zRGikxLT3OYykhuGctO9mlWmthwu8?=
 =?us-ascii?Q?lufk+GYXkV6FjAemkMVp4PA93iIhwO6ffl8egd6AVkMMYWFKGNgzd4OTwhTi?=
 =?us-ascii?Q?MyXMF9ASn3qWAy8owyPstWggsav9BEa8KI3V8AAyHscD6IomMd+Db+BDQ1eG?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11242d1f-c7ab-4cac-7be3-08dddb880935
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:27.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8TWdMhopwXXTrdHFCJ/j99+vws2BWWgGO8sY5tKLq2A6MQk224bgym8w8CuVU7CqQHF3sD7W6Z8Bki+WAsuq9hgiOU3c4IDZ8DTX0K+BL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

This just reduce the number of modification of REG_SPI_NFI_CNFG and
REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 113 +++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index e21d7c8c2e3c..bda85866d1ae 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -662,7 +662,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
 
@@ -706,18 +746,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -813,7 +841,48 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
 
@@ -854,22 +923,6 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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



Return-Path: <linux-spi+bounces-9615-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC39B325A0
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0937BE338
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AF135A53;
	Sat, 23 Aug 2025 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ff65dCFJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023102.outbound.protection.outlook.com [52.101.72.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A32E413;
	Sat, 23 Aug 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908206; cv=fail; b=iRI0vwE65m9/nK8H6yla/2bdPLruXHB0uolGHOKXfq+p534yZdcl5QQs/wcZ2KnOxnCnscTqhXGvEyv45R2LUoksFOjd76fj8qyOSrivToM0YBmL0QITP+6nYLA6QP1UnmWxhaEhq8vV91/WPCsVSzWxuBCmpAoWzybF5kQU3zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908206; c=relaxed/simple;
	bh=vidnD4RPXFOb7eUxVO+DSJUqu7RNnwhyAizyKDUcL2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKwCPduXtPtmfaWIBTbNACSzT74CaQZr9KDVJsOEijTJMXZbU7AXmfkX0pkrnmrzKEgzJaCO7bKq2tjbjH64zK6AJ3sa8xHVx7xGfu3GZrkCkiIoPRKGzGAORJLnkscMDiKwB6BMoSN+Lsu+HUJ4laM168Cyk6WMzlyFzOXgFoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Ff65dCFJ; arc=fail smtp.client-ip=52.101.72.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDhnL3ZxwS/rPNAm7TfPW0AhOFBsdZDozBdOdTLZDy+p8/oJ2QqN2iWUedJcLutKSILgdcgsXq3JZt9HW0qzO95Mo3RX8oGUqWZLvAVP0Kak/CvfzQfP6qxM5xaXsvvv8WwIFL1bWurToo7Q2dKi0/yrYg42/wQH9B2cjvgc5Bz+oGTw1yFGVy1LgCo6jTcE7gHif3dxW1gi2xMpLbwEBj8Jx7E7YYqvhnDHX50Bh/QLYiIzXP+F8juDJ9ED46v2CQ9cfrtPSLp0jtLxdd4C5y9IhaifOW6qj9UHrEJ+GThnnUCSmLEeTg81ncnHeeBH8bAenC2vJ7+lgZXyUegOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hWgVIawDB/Wf+O1FJHbcuLFBIZyVM+OyxcDewNgqxw=;
 b=gn/5ufack2/Id4Qvy035L7tFXwmNPij2Ol9/Ph+dQWbeBexVD41J24hOXUORXcHBZEOM7qV9RLS8L1N9D7vW+sEfCozbXGrf1c6FiFQv6C+whm/p+/4bCc/lE83nUhCyWFR0hLNfjQkVjhp/0v6jbd2l+t34mvQXUdUYvlTqAjReZgHd63k/G6WzwWKyW1+qioOg407ScS4bsYtK8+OAmCFtDiKsQ5M3bX8aF+6lRkOXKhn7cm1Og8heBvym5JmxgZPjZXYudPPD8eooNZzZ5MuJbH5j8ZQ+ukO04M6hIoBCHrmijeACZsODHAvfcQPBeCC/3mu7rnmsN3eDvd5NBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hWgVIawDB/Wf+O1FJHbcuLFBIZyVM+OyxcDewNgqxw=;
 b=Ff65dCFJv03rJVTCiF6VdUVvlUX++PqwRrcThJF6m7Q1xK61AdXECM3eqzOiSr0Mf5pxnzIz18s4dYUbjM7EKvS1koN5RoIdXAArQ+JJzLVBvJdCbW9TQriEriKDwUnbRmJs63Q1fosQhNMU2EUU49MMl+suCxi3qBdgia1xmdLjFh9uvmdI8+SdraqLujkhqAtbbXz1dolOA1HLSYTI+ksmfeqdldKPkmhLuAE5Vdas2J5CHMv/Wt6XuzVCNXW08ZuDKrPhc9KuoaQnaooBjoYhC55CkFfccHZ3jhuHnkOBrV1puq0X8RmEiwI+yLiRMAhohxgQD7TqWmli1L0Saw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5618.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sat, 23 Aug
 2025 00:16:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 03/13] spi: airoha: add support of dual/quad wires spi modes
Date: Sat, 23 Aug 2025 03:16:15 +0300
Message-ID: <20250823001626.3641935-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
 <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f203b3-9f95-4b7d-74ac-08dde1da52f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3PWFAsY1P98XXHm+AxDpJ2Q0wd5WncsbDEhVr5AeYJh26hq1gC12+qShgA5?=
 =?us-ascii?Q?OO1Ck4OLPiso8X0+ax4/6Bn0JHU8Nz6UqnY84b7T2I/FMmcmOyEr8JwYgJpP?=
 =?us-ascii?Q?GNuDNazVKVUC7m6eaYT5rVpD01I+Sv268dqm0zGbaVWRVYPcEwKEuLskoCX5?=
 =?us-ascii?Q?13jmEkuIQZh8tIJyVWi5edBU3L6LGtn4LLtb7zT7vwjQzAMwSuAmBD6VpH3p?=
 =?us-ascii?Q?UZWG3Q6XAUGj/gsNfQeilbf77BmpZmpPNY8B1LupeLx6SO+Ghg+1HcePW/Tg?=
 =?us-ascii?Q?fwJdokKsSnNRWdCwzcKXdDtZZSD4ZwmbyAl0SVxTZf3qQ/FNfqW+QqYBAQ4S?=
 =?us-ascii?Q?XsAvWEYci5SstSBxHXBOKdx6wiBAaG/5HHHQ06uc+90CibI83piVLpDGLuo2?=
 =?us-ascii?Q?6J+b9tF+RowDCRFIMr1mT9Hntzab5POqlqaiRlEyk3Cu0JsrYuqo9ynNQMdS?=
 =?us-ascii?Q?T8m51+ROB2VprWTnbNEmrzKttbfSpJPHhXUgx6q+FqwUKI9D2yZ2XfI7Td3A?=
 =?us-ascii?Q?GFIRzpeWjAaYbhEiHmGkyrFRm+rXi9fu70Xv5a2p1KDW74msPpr6BbNZtTpX?=
 =?us-ascii?Q?BK8KnvRkAlKVRO+DyAkK43eAKB+Lpbnn1gVok1iBx11qhxt5Z4nfTC60lRPo?=
 =?us-ascii?Q?ChCXHtVUhsX4ZD5OYGVznqQe61BY71ZSTDUDQ1feZ7TxlJHCAsVCoSQ1mJ2d?=
 =?us-ascii?Q?F+AhVkDlQIYAjAFzmcVwBDvGJzq6r2GQhCQcYOVl+dTYyUaPOo8IkadabUhl?=
 =?us-ascii?Q?lGpWFOoDxjZHn7ZE/9/l34S1T5khtl6niDcA7IYQ6rrA/wGj8ivNMPmH8xk3?=
 =?us-ascii?Q?6GHmMwaYCOCayPLjsnx09PrNVSS3V70JCEX+hwtl7HRD53XBf0rOE5QQt0Sc?=
 =?us-ascii?Q?rTTtlhJD6zrNzT1JMUgJv1Q3zDzhNcANhgGjYWWrSLmJc/Kc0a5rqfgEkZ8K?=
 =?us-ascii?Q?CurLTJO6p1yC19B1CXbnZNv55iiJugIPaOxUxx68W3a6kOYgr4kE8bph6BAf?=
 =?us-ascii?Q?XWwKZpVMHOgweWQQD+4DzpHMm7zhl+NlX+nzV8Poj2UUFi/dmLic0xqHYKlM?=
 =?us-ascii?Q?ufy91vKiVGsX7yG6c/k28poeVOmPWtf5Jiq8Mt/yYTSdjUc8gUJfPcq9fFDg?=
 =?us-ascii?Q?ecuBzxS6TsQR9nRcCo/mPKrl9FBhZlRismWezu7FDqLN6vyWWA3KkihJRl/W?=
 =?us-ascii?Q?QQsc2pVRIqhfJZ476rKXVlfDP+0KQ1b8r9cUe4qRt9kOotZoZGg3Evixzm7D?=
 =?us-ascii?Q?3taT9azKsx8czDZgDXYMwdmKvK8ooYewRsqj1zMO//iTRtf56oRO0JU5t2hn?=
 =?us-ascii?Q?dnmAgH/t6UbOAV/v9o6N+iS9U+ASFEKM47nnO0JGskLqiBuPEEg7kukBZKse?=
 =?us-ascii?Q?C6uKgTeN4h5dTbxMq98+nyZL/eZSS7IfyHwYCcYgIS7/KGqW+YdqxZMD6U65?=
 =?us-ascii?Q?TaKHgEACrjUjd8f0lGBZqlAUFaMf5WQ04fE6v0hkDWCFKTBj2M1g/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zo7BkHb27MCj6/1K2YbuNhGnhZnl3AMcfgIF+vJ++Igt76dn0I+uXFE2vluB?=
 =?us-ascii?Q?YHzR1YzFJ5o1X7qU61OKjXVvHCiA1ybzggrTK9dv/9fwTEb57jn7cpi2ukWv?=
 =?us-ascii?Q?AWtEOEV2BOQhNeaG3tdb1w0qoGA0V30K53prJaP7RIZvnbdp9WWW9G6OU+SC?=
 =?us-ascii?Q?tQGt2bE3rdtcfzYx5B/wgTXzs/jQkURcght2+Pav/mBspWctB8XfpmSn1i5a?=
 =?us-ascii?Q?opUUeBd//gMBqKZ/7QYRLI1lr69s972IiR3htRvhjdOS9jVDQeENvUVKyqaj?=
 =?us-ascii?Q?HDHZeVbhDI2Ro4pysNLfk0TbydMSWPkPRiOFhxFT6MuMoa+33/l0029QjBOg?=
 =?us-ascii?Q?AFlYF/W9BN70MOnFJfQNeNe/0/5oWX5lFotxEAS6LcehhJVBNImdafcO1hMy?=
 =?us-ascii?Q?kEmcV6zVptlc5KuvP82TGhirpoMXeDTXt5eeUy4YrbgpY4JmQKZD4QEOtWa+?=
 =?us-ascii?Q?Xg1+MsmKERuJ52UgTiqD+VU6UVeM1Mufg3L8dLVk236xHFCEHsBMW8j/IRcC?=
 =?us-ascii?Q?guHYMX10ukKoMxhd09OyXFGIue0Zv8kPVATAW+InsmZoiU/0HfjPp7IBHEHy?=
 =?us-ascii?Q?Qmt1pJ3zrouBIDWogc0HE5JmAo5xCna4RGaHdppn1bCJPvc6e2Kn0g88WQrx?=
 =?us-ascii?Q?LuIZ5qYoCQjdD0q6+I+FXfPLocR6DNxCu/IyBViRF/HErvjebjP8+yJOVSRC?=
 =?us-ascii?Q?Guszc7eLp8GuDKtURx3v+eTq0RzIPIpdd2iwjo6hXdXazNUPS8x6AiBTFZW0?=
 =?us-ascii?Q?LYN4tYg/S5Uz2qVxqqyIFd/1w1z5Tb5XCvKOan2ApEZoeFYRgSwJwbXyjA8l?=
 =?us-ascii?Q?fraD73ZJZoBlCaY7NzEvEaBEFL+MUlq1tSwqIhoV6oQVXXVQcxmME5D3Pf0F?=
 =?us-ascii?Q?DaKP2PMdXbkT5zzUjgEe7M+2rlll+e5zAuLivgepnUEZSWP0aYMs8XnUvYEZ?=
 =?us-ascii?Q?K5TCa8TXvC6RBmYFe2TTvD7CGR5swcFKMGJhsqAODr7tMBNiS28vJnvFNdre?=
 =?us-ascii?Q?m5q1oEw1ORXsbb9B5WBZfceBqumWEsGS163yrpLcoZi3DFEUpl5+7qlw1EkA?=
 =?us-ascii?Q?2ASreEowfYDFymT97cBrGzNEOHG33lvln6LiVb0HeOAZrJ74C5aNJjdEckpi?=
 =?us-ascii?Q?3Rx43I62IMKQ15OER9/J3K4ezOrNvpoftVwmJO1dgfOTK9ibbqux8rSQh6pP?=
 =?us-ascii?Q?gusv7g98OgL55IEMIJ0kZk7Xh5BwC64LkReImkfFWBHk40ogsSjz92XmzA0u?=
 =?us-ascii?Q?OgKUYLP664RJESt0/tFY9vNvLx1GuhHaHFdoiHVIjmI8gO481Y689u9lms/g?=
 =?us-ascii?Q?yc4bYj7u9HYZmcCWuUQ5/KVX7qbfSSpEJSvbfdzM8GAyKFHtCqqL600lA2Sx?=
 =?us-ascii?Q?+SkP6aDEaY1rMRg4jpEawlcPo6QnlfK/BkN/6ncsz13280ctcEMPfCUnqxyp?=
 =?us-ascii?Q?nFtx4/1JkyefL/+P4pwFJu9RsNgU3rCsWxKr7b4l1E41dfiZvJb2iBxpk2ja?=
 =?us-ascii?Q?Q/RXw/C08RtpCZDsu17jYJvoFNoyvTOMb+8lJEKBzq8cjI8bBGn9HFyjFu5u?=
 =?us-ascii?Q?1jFpdAgaIhkwyAyYqdFvHNsRNHtSrhCAgdTHm6tsFS+LLGr8MuYV84DTtkBu?=
 =?us-ascii?Q?AdKTaNBE/JtrEyApeq9dxVg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f203b3-9f95-4b7d-74ac-08dde1da52f8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:36.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddSZHmpcKOAi/gZ2FxbVkr1Xfb+qT6Xd1kwvf/9BldU8sw5k1t6bzlXkT4QTShxDeHXZq0LJp+tWtZzWIBvk7ayYgYIz3zD0EDUgOU5OBmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5618

This patch adds support of dual and quad wires spi modes. It will
speed up flash operations on the hardware with corresponding hardware
support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 109 +++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bcc464ec9c61..d64a687c07de 100644
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
 
@@ -387,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
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
+	case 0:
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
@@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
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
+	case 0:
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
 
@@ -895,12 +935,27 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -911,40 +966,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
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



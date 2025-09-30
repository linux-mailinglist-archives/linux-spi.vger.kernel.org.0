Return-Path: <linux-spi+bounces-10363-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A4BAAFEE
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 04:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC00242149D
	for <lists+linux-spi@lfdr.de>; Tue, 30 Sep 2025 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80D238C29;
	Tue, 30 Sep 2025 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="hsthd39d"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021100.outbound.protection.outlook.com [52.101.65.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8773221277;
	Tue, 30 Sep 2025 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199240; cv=fail; b=bdc0Mzt/WKRpH/nRB/xaH11Ekib8IyNutxkBiTUnvW5dqsIEGG405NZsjAqDb5ymOFAKsA8eK5auXN1tLRUvwLmRNcWJRmwIa/i+ZNfE6HBuTmkLTbu7jz3fLTn84kYdsxb/E5phZ88jr6k3yZAg4eSjEFwXMtoqCJythVD31+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199240; c=relaxed/simple;
	bh=ePjsoeZZzg/griX4kSV0rVTb4AjMBla21bv3wlqzAAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lEbiRrbnkZ5uyNmcq2LiJKQb4Zkg9OHCilyarUg5hhsC+OKtVIRbmtjfOWH0KCWeGs+jCaDLyEo0U+ZAg3IUwzngGeCh4KnbYzPTDLaJoOx371Z4QXFxhg+iGOKo3atsEt/2t0c1K5D272zbKuLxkvKtwR4LwB8C9KxnMSU0JDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=hsthd39d; arc=fail smtp.client-ip=52.101.65.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfwmxonY8PzjP+sHwqT3AiOhS1ciGfb6jJOQ0IZBPrnfxGRcDQLJ7TmBZiDvnHwV6A8TbAOm0+1eMOD/j5Rpryo1a+giME2hV+jXi+iw44mYekqSLDWVWghlTeZU/QjZxiHQJcDFt61549KPMTR8rKPuaRmpHaohkkwpX/kp8x9Xu5P6Nlof/Qm5mSL82rNgZJDyqWZ9LLmGRsB/alR9vzztG5KotQWC0enpWVB9YwRPR+YF8rytCgwtzWXBjHIW7e8AckAn70pd6VRkW9/o7O++KcIQ6AZTac05RWzn+0hUIZINF6GpgTSvsfKqgnMPGwzdVKD8Jcnc8jFV/Li6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URx0qNoovSMJ7D588DDoEUns+ZQALca7bPxiuQFxhT8=;
 b=imgFWh66aBCkDlo0H7jGl54lEX5lmN04vhZmpxv261YucO+x0Eekv/eWtUF50q4RDPVGgOhAawQfqJIBwVkB/ZFEF271OYHgG5XEnCPvleWL12zHKFJrtm/2UHmZWEzvam3KYQ3PqMXStNZ8c6XMNo9JV7HjIfrhsBR21Ab7wtnzw9loXRs/rxTlTgMggepHLKdegtX9NSRvL8gA5ZECQnIGLGyYULB3SSbNpCUjPKOBtfzspLPVyAsUh09bVlFkPTbMFp7cMblJYbmX21HIer5q6qbvXgfN7fWSsA6tnA6CWW3yA6CwPqLqHTHRUgk+XVErP0NxdkYjcGpSPolUNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URx0qNoovSMJ7D588DDoEUns+ZQALca7bPxiuQFxhT8=;
 b=hsthd39dxf0ukwBU7eMImFuRW8zhxx83C+5eo98E2niEPWk4uwxfLNiddnd8w2eBye37vXSGnMHxqVoDYnjW1uTgdIU/e715bI4io0bdiYs9drmt+QIy8WYp0U5ZzT3gHqdatDxh+wANQJYCavRcYuNIIxR2csrH+7B+n/UQ1AGnwJ2R9rRoPDJTWsanWe0gEEQ5wTuXsagohjR2Y4FiefAkkZpQO20qJTd3cZYdHW1n8s74vHYxe/qlMGTI4DZStUUsC01pCoLYISD6IBmzR7ZitY4fgoAxXuiCmek+wNqDwEFDNr8U10QTcGNlpX/jbtaxuYeh2Mi9aqxgGAuRQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB7929.eurprd08.prod.outlook.com (2603:10a6:150:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 02:27:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:27:11 +0000
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
Subject: [PATCH RESEND v5 05/13] spi: airoha: switch back to non-dma mode in the case of error
Date: Tue, 30 Sep 2025 05:26:50 +0300
Message-ID: <20250930022658.1485767-6-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0b3fa98d-b8fd-4095-e62c-08ddffc8dc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIajEpub+3En0xaQ7KyJjXOQyZy5dSCFVXDJkCNm++61G7fzJsgveRZdW06t?=
 =?us-ascii?Q?NEwzIRthfLrJHxSOnbIFVCFpRTnlgDpMlU0eVmEL6OBEFtmD9PEFPYG67TUV?=
 =?us-ascii?Q?rZPHwhfAlwkpnAsy0Knbz89poUUirjN4V3/oriIP2cIWd/TK1VNHMbCEzZqV?=
 =?us-ascii?Q?hfGNe/avmifGEMjkz3wlmuiQFLnjdKadAg6dLE52s4Qos8WxFSzSVWifIwQ2?=
 =?us-ascii?Q?XWpLjJc4+0ry1IdAELW3N0iRHbymcoT170ii1myqgtBPA13IxtGtKbaHmbL+?=
 =?us-ascii?Q?jbEjL9FDcKbY9M3ft7ZtlbLBEyJihepOdT1x7w4mMgLSGRp6BmCY2tFB0NYS?=
 =?us-ascii?Q?VAXx3ZgBgUGBDfwsMqW+p/jl/BLoLXpLiFmUvZYhokcVbAN84VRCP0he3KCu?=
 =?us-ascii?Q?WERpgXfMPkw8GuWWrEHgfFmvNswGmxRZseHd76QLzVJeg1FRxlydryIcqyOL?=
 =?us-ascii?Q?6i63S3sJg4janXN2qcR+m59VY33iDUm37TKvQS/LaOvfy48Hoc9ShwBUQZ1t?=
 =?us-ascii?Q?MxoKs02enJUWCtBg+CI/SwNk7TAtkLaD8ppy1MX3L7ezLErjETRvxvk6Dcfa?=
 =?us-ascii?Q?t7bKhZ3zfL6zb8Tn/dQ70AE25H81jP78lkQpQH+/O/WBwPZDDcDrQq/lQs0J?=
 =?us-ascii?Q?BIowsr8p7BqslzJfWVt2xAFwZZkKcVLGg3CKbl8VAFDXodIok/6ZuTsk5OtZ?=
 =?us-ascii?Q?kswRAr4Tex7DGDoqeIGtM14c/O32y01ca0myn5eKGPED6YgqNd9HYsLGUU4Z?=
 =?us-ascii?Q?BL5GzT6viMv3gZybdH4cNboe6j94YYcq0lyUMKCATLVbfOui+qfKWB7nmDUB?=
 =?us-ascii?Q?dIRyyLonkQRXR+EEjEt6KHX7ZBnYMMQ7GoiH+KI4Q5RbT62+GrTDkWI+/H7r?=
 =?us-ascii?Q?VB4Fej498bOke4MxakAjdCtiisx4mDADrUHaakbCxqngueioy7ER2nJrEms1?=
 =?us-ascii?Q?9Q8XKfu4zMPM3sTGMHxau9bQDqOCHaJ7FyavixRD4f8TqItVFBJ50NXLIED9?=
 =?us-ascii?Q?Nf9vbodbojPTDcSclt0PIWhOWGAp717E0fFAEXRv0huh8Ete15I0Dd6OGNkl?=
 =?us-ascii?Q?tR8Rr3vRNAAdfFrz19e+nhAqhA5dDvbmwr+8n0Tq6Vt+JQgK96FgtWK07F6S?=
 =?us-ascii?Q?BoH6mewx3TbCVcSG2cB6762OATKqky29ydKkYl1n80WAksxNvjlR6j8/kkY+?=
 =?us-ascii?Q?9ZAF566dXNezyTKeQgmuGwqGznX1MLiFywYJ7J9G6UxcayWZbl4mQwFILC4Q?=
 =?us-ascii?Q?BTzrMmqbAGZV+0Mu3H+Q+Nnui+v+/vwnYZa+jmpEJmn7hAaO4X3tjRjcjBHU?=
 =?us-ascii?Q?slQ5yuI3oqeoTOYBuC/HVIpLjDNgwHfJCboWTPzs0Tfb9Lf6XQQqX8grng8P?=
 =?us-ascii?Q?55Xjf6eyOA5vp2D1upxDRUxNeNwaZROC8Ku8RA0BlAC8BQaHKj0wQ9ry7vvo?=
 =?us-ascii?Q?DMuKvz1RRkmDimfvUIWpW9r5yzKJzIqGAMsWym3eUPlvqY3gHb5yt69cyUws?=
 =?us-ascii?Q?ENFIXKTm66H6pCgovLCNTv18BEWGbeNn8dj4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOLiyRE35KMA9dI/vrkDL4xwtL6as5HUegMotsFe4Y9TH3iB2XAxmqonvoib?=
 =?us-ascii?Q?u4U1uB8sj4zEDwYmVbd/Ecar9ewMAFubyOtJM2ne0WjvG0m4nfs2oWosliyb?=
 =?us-ascii?Q?6bfqwN8h0UQ1DNorIhvqlmcPuGhi6EjymXfjGKNAGewljUTNBa3HSPjxlZWY?=
 =?us-ascii?Q?4+5O5S+77E0LrhAhuJWzHyz/U9pjQvzsgew/hplPQJldXv42eA4kc5TasMmL?=
 =?us-ascii?Q?nIvjOuf8jQaM9yl6JGRUXq6Ms+ad90T1kAwJwTC0Pu9Arp5fibvQbsdMrgLs?=
 =?us-ascii?Q?XkX0g32Xyfrn9EkMSGdPWRILfex409HGShk9ov5JRe66VCyVpPW8mbw8jMHa?=
 =?us-ascii?Q?Dw3h8asxHDvW8idoxeY3WbT/a+F5Zk/x/H839SGwOvDc+TxaheRdkfp2Ux1u?=
 =?us-ascii?Q?7iyf1ndc6aRyqoH+lbHDGX/CbcDEWY6syq2FwlInZNdYaGfmhX9gg1HVJaXm?=
 =?us-ascii?Q?kyhKXxl791RmKy+vglq0xmmSnahPo8SPjS0qcjUyQgEfRoZSHfDpjvMWUw4Y?=
 =?us-ascii?Q?dJ7uiYAUf6bp9UK0FGY467lNFaTNDTnVxy3ubBK6jaHZafwt8o35m2Qs3py+?=
 =?us-ascii?Q?HrK8rMaSU/L3qizxuiLRl8RE34d4kbaWaQmYKh9z5KdCpd8hreP9NPdlITpG?=
 =?us-ascii?Q?3cr+DdgvxKRhSCStQ03MY8Q6CwGTFXn6/rGue8+tvDvVEEmhYAcmhn75P4HO?=
 =?us-ascii?Q?HVtgVQPt90fGhr703CB+ptWMj00jJBiH8EBGeBdAdrMqTh8EU88qlwWC6iOQ?=
 =?us-ascii?Q?wkWe7wylch/JtZ/LxrcueU6E/IW4O+hhrIsMWMWg/HtEpoYp8N1EV8Z7fiAv?=
 =?us-ascii?Q?Fk4oHXvxds3rAeQWxg4qNB8tvDf8ymogtW0o1nol0wfRA2Nv/zFwehZJFemS?=
 =?us-ascii?Q?6VrNa1/jpIS3cVT+ynuFm2zcF9KLqSDsoeUr1FWEeTgldb3KJ5UdfGgKidVa?=
 =?us-ascii?Q?OaGZPi+wbTifAe6ZXhiEkvrS0fRRDXfZABdAFl2fKc7d8Zxln71zKsZR6O8N?=
 =?us-ascii?Q?Gkq96VvIAMTq9nciItHg1NabTBBp+is1bNCl2qgxU78pWVc5QYNp5gp78TzM?=
 =?us-ascii?Q?OEj2Olfsfpy/Bc/0FngXEAjaNSTnROrgFVJZIaBZy0CR0ULjfNKbj0/UeBHc?=
 =?us-ascii?Q?qiDWK13946W0mOhB0UqVV87qnEc0DhAAz44KqG0UxwjKQ6W94lO1L1SLy+qn?=
 =?us-ascii?Q?VU5MQYKmz52cRBlLburbMRV60H/w7GK7nEKVgOiyqU94gcNvtL2xI3hTrKOZ?=
 =?us-ascii?Q?IdLeALyzbURemwiiUQQUai5CAueVdVKaY/6cd669qHXB3fXsS6yTABJrdJ6Y?=
 =?us-ascii?Q?HGWg0ZBT4xDA/x9l5gj6FdZPCNQH0gIz/GYD12mR+87Q9cUkRoOpFekX15nZ?=
 =?us-ascii?Q?/OdduIHJyL6LgDa/HIpJDvUW0FJEP5u6PdoIRWEa0eXsjt+JdwvKFthPnHQ0?=
 =?us-ascii?Q?4/1pSjCMOzvxgkCl+S67yo4CQI0mCNLCNdPrVYxlKF2XvbIyqgIlxtjS37yq?=
 =?us-ascii?Q?ibtpCT33sRrBfUtU9YoQuBPA55SJ5gZ4N1bfSJ8aLTG6tXG83n7Ku+cV6yzi?=
 =?us-ascii?Q?iaoEErTmEpMojXq0oGSomake9eaxTP2L763rIirGaU2TwjzspPJEZxUmuR/O?=
 =?us-ascii?Q?UKQLlK9KuLBhGXO/p83KQNg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3fa98d-b8fd-4095-e62c-08ddffc8dc34
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:27:11.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCUl4OUhZKOmCmal0xzvgqHiUqbhXwPnDGxZRQS21/xcqaM5945+ULb1FLXL/sJ2uGLml3OdJtQaQjwbYV+kQ8dRlnd4M43w/rgZQv2ydtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929

Current dirmap code does not switch back to non-dma mode in the case of
error. This is wrong.

This patch fixes dirmap read/write error path.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 2d86dc62dbde..a39c3ab4af5c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -691,13 +691,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -797,6 +797,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -926,6 +928,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
-- 
2.51.0



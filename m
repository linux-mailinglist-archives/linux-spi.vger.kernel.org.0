Return-Path: <linux-spi+bounces-9474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FBB27EFF
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 13:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA80F6216D4
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF32301489;
	Fri, 15 Aug 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="YtnoFcHM"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021137.outbound.protection.outlook.com [52.101.65.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD3301019;
	Fri, 15 Aug 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256600; cv=fail; b=NSVwVKJ3T0Xe8RCiLjKemu83zfwfbGPv8EUdx2Yg1ckY7TJG9/67nr2DpIU0/uOlctDBAhIzVR8X2LAdjukTEpzrqcPVSePPrxTIVG4sNSR0d1XSzLGIe+1oMwWlciL+8O+M9Ms2lyv4JfRWjJmosfkxRs8LufpumkxsKxBkb0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256600; c=relaxed/simple;
	bh=u9+7UbXtg/HicqIqxjOe96V+4mP6gT+Ri52VtsI5dWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCe150Vid4aQEczhpN61Ub61dk12DHshzbdc39pgv7X18USQNKVIqg7G4I4C/eUZjyVoVgjImIfE3I7jX3iTT4XvypbdfhEjvPaZbzEQnqs1QCaYFSqpUKQz5em1dnxfhOWZnmR/JDpb8uutx3RkvXhOZFqooAf6Mn7tFRJmuPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=YtnoFcHM; arc=fail smtp.client-ip=52.101.65.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuhrG7u71P8cUjk7m/lHmBnBNqP1ZPTnFiap9OmdLuOlBfNkRTs9sX5CvU0PnBjm1PoRRjhftyIK/RS3AEWsJYP2kRhJCETiKwHFPuyk26kyPxPBkRPJhqiatinoBY0oCmYQkN+Q6ruCpJoUNSBLYjqFnhlVgFhcNW8JYfSgeMBr+juORaDW1e3HaRFjNCgP89eTZra7sxKD7N/vqznkVKEyOBdWm1tGqkyguCWFEiGlGbs9Qy+DBw0p3OtuIy+B+FEh1YvCq4XHOmHALWay5Nnx/o8tReh8XHWFq/ZMQHIbKqTpDiyesXyCtIF/zN8CmJgh7rJcKq1ybMtKcI2yZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KiIrW1vV1ajvXX3X2HFmfts1RfITbD0K83yjwiR39c=;
 b=dSXTvxRuQvRp+F0Cefe67bXASZyLYBPnY/HBowzjCkOSZGikJLPsKJKAW3J6yN+o0fyPuSdjJLFohLcIP29UmEIZGIX0GSM6YJGhswZfm5PbwP+/WNn54RIDa9NVxf/071gatd4+ojCj3WPt6iwI3SNmKvyo8jiEVEvyf1CdZCtmr7nuxbkaQgeTIgLGYh8nmJI6xrj8yBZzEUVFmnG/VVcVk7MbLzx7WwkLCtXwsl6nu/idxaxQCkiq3cacB8tp6Vv/8Gz9jyYpb26gVk6KyZTRkaS+1kLMEHUeQkhPoPXFl2S7CWjOEe75spYTG++ArEfvTfs/dlILTqO5HIfOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KiIrW1vV1ajvXX3X2HFmfts1RfITbD0K83yjwiR39c=;
 b=YtnoFcHMcFdlbuHOQzvoPSZcq3+lGEjss2mL8VQsX4GHlb5YnYcklCe9ZZjT52piq7cIVppX89a958LhSqfdw+9oVYQFw/5sjysuF0Uiupoc8oTQk5eXulmNmBR+YRbhvxBxHBuQZRAyXUEp1q9p4QRrcKAWWurr5JCsZUT9hDZ5Km4D5mHvtyAO45Uo90RrQnqQjPwuEp2Ils/ID1ZugxJEYKqLD089lNzd+Zamrjz+oIKGXDxdzLyhZzgUmNr/A6XiqCwISCtORtsLXcSLRp2R4n3dD/sGS959hhEwUxFapZwIuWj0qnKg/0/eOAYNSjuGHQFmdgbUoSIcRoRcEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:16:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 15 Aug 2025
 11:16:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 05/13] spi: airoha: switch back to non-dma mode in the case of error
Date: Fri, 15 Aug 2025 14:16:11 +0300
Message-ID: <20250815111619.45001-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250815111619.45001-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d69b758-8028-4e66-3231-08dddbed308c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KRWf1jd8jCIyJ4018ZOt8VkKjTlIgSQYR3L/lcnOLVOoiBaTckbyuQ9Qo+IF?=
 =?us-ascii?Q?DHc0WZ3rWGEIKNIh9MqOa+c52hB+uGjn8zW8dfsO6nn/mKFAa2N8lm9ocpui?=
 =?us-ascii?Q?K3m5y287Y3zM8Bw45d3AMPsFxjS24Gii2RT2QlB1+LSXEu8O8llSV5PwbCAo?=
 =?us-ascii?Q?mrAoTMU/uStYrwcDcm7KdULkyEb7WerGo58VbE0An4L6JnCGpcq1QDA/xnen?=
 =?us-ascii?Q?fAwLOrubjf1Ei3YeEj8Y7E3Cnsyy5l9TdSCSJoyp34oRzqM8vw2uQnMlo8it?=
 =?us-ascii?Q?FQm91oVkXDBdxC2+HsX6EIgksHSh+ZzXKBYw+L0XzPo6xceZ+numuVACqV86?=
 =?us-ascii?Q?std0XTTUl0T1FyYFJMtNmUbP+7R6quAqcU6Dl57Q1NZk8kxEHHSw+/g+hLvw?=
 =?us-ascii?Q?UEXhce3ka2giIHB7twZichiz4hUMODP0CgQbDryq2Hq4vT7NKO3Vt83iNd4A?=
 =?us-ascii?Q?2tJullOxe+3nFkYk/Qcijkwj/Ke1vIqUOhGfwOsQ6AU5Je49KHDq51TKRtZO?=
 =?us-ascii?Q?Zd3H8U5CJ9YQiE7DCyRafwq0G4bDUAIvh+Rm02vrOh070ZYCM5dyxuhsLb3j?=
 =?us-ascii?Q?plbrD3oZdzdXayy7il2NU7Ldoc1p/leF7MROwjIHNkmRCDU1WlEgeH28tvLp?=
 =?us-ascii?Q?iguFTPS9cAPTqTvtNfLwQtQlreFgJwYUs+AADMhltdg/xwu1ZWwWrPYAsvIh?=
 =?us-ascii?Q?Vlie/xu0bGqpnM/7403Cblhzg0FFYoiTABh8ppozI+JjgdVp421l4wF4QXYy?=
 =?us-ascii?Q?5wN8lIoLt7yBkqYqM+dXYfkm6cOzVc3fShpwjgXGbc2cKXYqJE+319eL5rJt?=
 =?us-ascii?Q?r8KvYGxEO80NHDP/jdFXlP7f5RK6hC+91qfvkV9yH2lr4EAVvUcJFYgLhSM+?=
 =?us-ascii?Q?GAZnIGU4Iav37aXANW+mS5d35+R7DR/uLKXO5TBr8k+agifOtOy7dPcSCF7Y?=
 =?us-ascii?Q?/OcLD+2BjOapUowvTtg7zrYqaZ8zef11b/bJZkiGW6wiJEqqptb/ESdnTPVG?=
 =?us-ascii?Q?0SD1x6jVL0GxMbjvLrktl0/+4JVpVqX2SpveOGLl15H+N0by9d2MigHl+vuQ?=
 =?us-ascii?Q?YDHAo8gYHHqyj4qGVg3cezaFEZgb7ttgdE/kEJ0wmtjYxj/yqJkNJmnoUvMN?=
 =?us-ascii?Q?z1eEX4RPJmyo85VI/Q/dXh6NsRrOHFr3AFJntPd1KA02Z3n3ZJFU2vxYrJp+?=
 =?us-ascii?Q?rrrl+NF50atMQbCuNrbvL3TWWkg2s44o0MyBZhTHaSinKYqwhETA45gZdbyl?=
 =?us-ascii?Q?YKWE8jylpcUqNds75g4pMcuaL8gRPQtnON047vps0QFdqTEuAUcicilDuwME?=
 =?us-ascii?Q?CA5wJFzI7gzIoVQm6/5roYBhcKw0pFDmKEzjrO9Hzs0Jsphsm5HarRNaUIqw?=
 =?us-ascii?Q?ngRAh6yKJPoCSc2PeRoR6zsybpL1niENC+WHdKc+XQIsF5ItrMLS2xeunWXu?=
 =?us-ascii?Q?u0xfiMQIE0MiZDFNEOgX3/9A7OkE1JhEDPtqdjMlqRH/z2XHPi4X2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpbR6AhZugDYNcFBjTAqMNrbqhH576WUtcOkPnkLDMEvaD51cp0Ah0IRYuLv?=
 =?us-ascii?Q?jWkEQfvS2zl1zwcGxKipgCdYSzeORdK2OAdfvUORTFSLDafFpvoFNJfGKfzK?=
 =?us-ascii?Q?EtGG6ag90A2SxosVhrOoueZHNdXPooiMLahitkYZhNby4gzqmMmpGwQFhf1X?=
 =?us-ascii?Q?FwLo5GbvQkyD/YcAi/n7P+hR5kyPPp/zCCZQqfHxgJ/fICzYdWJXyQ9uVscQ?=
 =?us-ascii?Q?O1Eh8Pph47iFkyuZjePIKqTKqK7kWeQcXeEBct/FfHvZ66NA0rZ37Dhq2s/Y?=
 =?us-ascii?Q?ltB0MygFV3tcndgw1zUgreHcRZZ9jAJcORO9/1grOMM5VAK5+DDLfD0RNL03?=
 =?us-ascii?Q?lile/0h0wk3j1OhO904hE8Ih/mzfkVWpW2jF3ZXDq0srSaqZ/Bjt8NJVj8Gb?=
 =?us-ascii?Q?7J7HzNY/a125bCQVFLFZjKitokfQEyuDWZ3Lgu9pl+5q9ISLMhFKv1ORYsdb?=
 =?us-ascii?Q?tdKC8AJyCzOjdR2hQWIbi1+VU7pFDDpB4sfGnB34fmQFLzaDLQA8Q4O0d3QR?=
 =?us-ascii?Q?Cx8IYtKeIJY4ZPbMxgJbk6ASNjmn0WkDc6pEvJoa2Ry8RxTMs1qhTtjQsVC6?=
 =?us-ascii?Q?W8+8rEVnxrpjaAG+cPEuBLz4mXEg4KC4YK/MeG+QrXUD7M/WsUrhLAxKGOoq?=
 =?us-ascii?Q?uzeyg4JoOqg2IB2jPpog9r6LTHO5lYRczChSbwwQu8rH5KKMgzTaaHjVDqjN?=
 =?us-ascii?Q?j5t6vMh7dZBuDIFhiGoT0ia3w3eTEfqt2aAqKRmejWY39sSsdMorzX9Dma4O?=
 =?us-ascii?Q?1ewFNr9TWCH58AnnREH+YMxfeuYxfkDKYeUDMuH8X9JbmjHzNYCBaDrSYvad?=
 =?us-ascii?Q?6jfIRapoM8rAeoMYcZvon457VKYhQbQ/rga82YEhaZyWKbnQGjz0n3cnmozw?=
 =?us-ascii?Q?egp2PhY17tDvNT2+RKGAnjs03dNbvnJ0mNAif/a6+vt7NCFD2CLxEQPqKwaa?=
 =?us-ascii?Q?y52s7nlcrx2zvPMNCJS1LZGDb1CzkfRDyDulzrXaibt0+431r5pMUWD9JU3G?=
 =?us-ascii?Q?KF6kqwCYZHLYOnAMxZD8sKPpsoBdnVqDGxb+lYL6IhR+iJ3E1hr7AB0U9BDX?=
 =?us-ascii?Q?8kdT/42D6R2JZUjfNwsouWZMJTQYEc5/l/uVMtPPPGfjfgqF5VRylUhL6rr5?=
 =?us-ascii?Q?akkHfopGD8CNenNyQyYWfGVeFyWPBs5HEjbbQfcx5GbYIwO7/u1bdufBY6fo?=
 =?us-ascii?Q?UE3SE8BgR8yQggX9dNLkQEhYHpJ2JKGXFywlw9TFXbxGKuR5iTHp4cQXSVcr?=
 =?us-ascii?Q?RhYM7Un+zY633Bnfg+DB57DL00uFzKW3mACMpCBFNTE+Atnu+0J3oUFGdMfA?=
 =?us-ascii?Q?3QvHf3Muq34DRj/daBQ9B64WJYGa0cAqI0kFGbaA7IamLyTsGud9KtUXvUmK?=
 =?us-ascii?Q?Y5ftwyCSPxFuNvs/Rjo/2ohB4DheiOif0fFFZww9va+hMDwq8ew51QtUPH76?=
 =?us-ascii?Q?HX95S8AhsC01Fb1grYW55eR48gxmvXRQMd9jx29H7b7hAb6Zml6lyXC/qZMM?=
 =?us-ascii?Q?Deaet5KDXyP5P+fVVWtIencz4h7KmFVcPAIjAM1i+neSwhKDjO9v00K5Ou1h?=
 =?us-ascii?Q?iZqurohmqyPv4nXKKqSoyuxqzFALWdGK8q0xwHlPHUgaHezycnYBX4tp0DY0?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d69b758-8028-4e66-3231-08dddbed308c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:16:32.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0XMkwXg+akpD17z/1CBV/1pjzJ2SLkJuFVLRo78dX0jlnbS6pDKdCtKN1YX/F9GiWU1twRC4pdmrkdbFeoE6pksTXlyT9UOjmoZQJF/7hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268

Current dirmap code does not switch back to non-dma mode in the case of
error. This is wrong.

This patch fixes dirmap read/write error path.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 565fe3b95c2b..dbcd9d437077 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -686,13 +686,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
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
@@ -792,6 +792,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -830,13 +832,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_TO_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -933,6 +935,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
-- 
2.50.1



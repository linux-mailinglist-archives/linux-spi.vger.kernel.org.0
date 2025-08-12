Return-Path: <linux-spi+bounces-9365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7160B21BB3
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 05:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7167A7176
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 03:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF627602D;
	Tue, 12 Aug 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lHQFXpwX"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012030.outbound.protection.outlook.com [52.101.126.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7A267AF1;
	Tue, 12 Aug 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969936; cv=fail; b=SoozPxJGQ3OVkkImpLuKQVvuSJKQbhX0zEI7p6nFMjAVMrJWM3fiq5MRI8FfL5jIdszkz3MQwJvMXHA7eC2v7NxLimAsiI/qP/nxVchcBc4efE3fjb8FiM5tAeZBiCpceN3be0MmnoyDoDvBmy1pkzpOeYU+4fW2+awVRkc9j2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969936; c=relaxed/simple;
	bh=OFeP07JRnW9Qv5msxPzxlgOp+/qm+1a2BqEmuaUspkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lZiX1wbzrn0P7fJSCrxnt9SRImCMAmCzfa+rN0gk2EL6FhDsNDRXVxyt+Pcr2KwLwJheK1bGxHoF2QcWiqEEeSPeHbx2E3qq3mDsYnRnF6S7lwM8OeIABm0RTAVa2Rq9eRYDseg3RPeF0JettLlC0p0LfGSQg8rLC/FCbqsGyk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=lHQFXpwX; arc=fail smtp.client-ip=52.101.126.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DETXL+u8ChDA8e4Wqj492t167BogjIBKyiH/h6aCLms+2pECEmNSRMntAJ7FL8wdhpaE3W9vICUzOJRLrZJ50exMOvj5SZqzUzw8ZpPdEIsvX3+lYT+qz8HmX5Bdb/c0VJ8HDXt+tBNc94IUkT+jbAZIeW7Hw26eZooOxOynKrdqDIw1hK8Nrs0Ny2jdZm4qVLDmNZa3fdOkL7AKpbQkFpEWlJ1H7qZ28PBYdDQw4R/wWjunfn4OV5XwH3PIMyGHnf5nzpen5CH1tyjIVSAP74JjL2nNRtTldT6ZLnKMFVwWv56Y7J0wSGTseYkUQsJ1K+vJsnYRaONQwEkCxr8MdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZbmHs94NAbqz9NzRYvrmlTkZqM0E+wXLaxepO3NRL4=;
 b=Sn2oLeGChV8xAigx2E5qMT+Q47K56z0sfiA2l1/eweQv0YMga57eqIs0iRuJ8bZIE7Fn0RyhAVwGZqTLmceVWIgYcFIgYq/Gw6bc30rkjbBQgo75W3PLswrR7m5NzCtdtLgQcDY4JOe9x2XNG2vh8vUCh8h2RR/BAWGE3qXfNYRL7nOIHxqH5lbrWMKgudsnS620cSvpAEOMxMOW9iDGEWj3yLXqRJXIy+u2r5YhnOD5hO/eWVw6uuL2lxxdaj4pfQjP+E/ASVpjOdQbIncEmplDbVIA9re83+IyI+O/S8sqbdQLd76QRJQhXm7IBntg/s9gvTXuxkOoXrhfZrLviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZbmHs94NAbqz9NzRYvrmlTkZqM0E+wXLaxepO3NRL4=;
 b=lHQFXpwX7DPJUHXgkFQZC+AxUiUfLK3t3ZNa+e/YaamZbR55KCtBf1SIc8Em6ZQ/ze03Cwg3HvpmL4+/iIlMetatPm8zRiXBYuiuyzJ9dDwfHVGFOLO9wGXRAhdacGyhWDNGnLPICrUrmyfAOS6FxGcQ2nMt6OO5EVPVjVTnCAnMfjy2HhkHKWXj+pnPXom2ObhC85FZixoZ7iDRls1EFh9DGtq35OEXdTsAaB8sRsMkyFH1xu991gFSNe2dMsFXAu87kjZDhKjW1E1ldC62AxuLrFGTDjin2QKI12ctjysX7EdSgErJDodpjbNv+JpmBq0BMhYiIF3rUFasRiahWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB6999.apcprd06.prod.outlook.com (2603:1096:101:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 03:38:53 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 03:38:53 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chuanhong Guo <gch981213@gmail.com>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 2/2] spi: mtk-snfi: Remove redundant semicolons
Date: Tue, 12 Aug 2025 11:38:17 +0800
Message-Id: <20250812033817.487565-3-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812033817.487565-1-liaoyuanhong@vivo.com>
References: <20250812033817.487565-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7de97f-5ec8-4fea-560e-08ddd951c224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mjokxQyqtZOm02gLWJsQOvp+BB4VzLG7mjnXcTY7itEcvilnxcks/2Rv/OSU?=
 =?us-ascii?Q?nW7zDttAQWeypzUv98qtfq8z9HhYY1PeCq/0rb9SwtWoFpahyPDnzNxx7q/R?=
 =?us-ascii?Q?nH0ZeDvNbUlBdKjTWeZyEOEEEBK+LfDEQSn1ARhLjrp9FdZeOujSm6uF3JPT?=
 =?us-ascii?Q?Sv+oKLX5/m19CBH8tQcvwCths0LAI+eRc5UWQxnzgDB48wuQgsb84Teex9uJ?=
 =?us-ascii?Q?H0SSTkBsEv7Qu9C709iHqW7O8GuG+B0DevlIjmhVzYPa83BEoevO2R1emR+i?=
 =?us-ascii?Q?+iW+Qdb6L/Eqs6aKN93v9HzGLkMj0GvcoxocRkhgjC1XlVQ5+cl2D1vKHex7?=
 =?us-ascii?Q?2UD0U5TtSer0RtrTgSuaXJG9gsTne9hmkMhTSLic8l/HR8XB2H5pfwdcHXqk?=
 =?us-ascii?Q?8IeA18PsRm5fjrVWNaeScA6ruywWd7mASLFBY5Ybc+FR93l0bXL9cR92kKIp?=
 =?us-ascii?Q?8M+J06OTw2M70+efGjiZ1aWr9mG10kjeu+66FoIjfkdWyYF7xubKnCnmg47l?=
 =?us-ascii?Q?xyItE8iRDBvkhGp3c+NvR3P+/Wn182v3SeDBuoSMt2us4LpQScs9YRge5j7O?=
 =?us-ascii?Q?t0uzHKgMUSWKkVLW8g5nHXs4JX37+7IQOWiulbXh35Pw6QIoVsWzVpULOyXV?=
 =?us-ascii?Q?qtBvpfW8UkBxTOGg9hxS4G3F6y5OUEKSPb3iMNcB5kyZLpnhSSHqKO9+CJ93?=
 =?us-ascii?Q?YI7c8EpfAojVB9eM5feydqu9Tac8lzLSSZdjBi2lhY8LSCK+TirZ9Zs+LBQI?=
 =?us-ascii?Q?IgeFeYyapr2RR4Sv3IIUvyHdV3WCqqY0XjCJlEcbMMOz6Bh12pwD8b1of7YK?=
 =?us-ascii?Q?IjAUdh+KWnmIEubDI0ShqaSVObTL1MuOtPvzdTHvMplObWtu6bg5fslzW7n2?=
 =?us-ascii?Q?FT9bKx7WUK1+6a9qBPXr30RO1yzIPc7l5Vl05JYNgXXTt6kUNGcnGxYftan9?=
 =?us-ascii?Q?4tNr9bMNyqKdCSjkJDiJ2a5aO99Io1Ig0X+D6gp8OIWghucHvZzD05rAQK7G?=
 =?us-ascii?Q?LVtwOmtoYC0kzqA/FY+3eG9RxcY52zZ825DsNuJtPJTeU8s2usbJnR8orve1?=
 =?us-ascii?Q?Dw4YjcJieGOdWoNM5HBlT6/96BGXsIXo931WyoxKM75W1QWcXwXhxABo3Hrk?=
 =?us-ascii?Q?ScIGdoE7+5lqkTTv9aOsdnDai9iybvvNG7dFSwtwPEPTyT9zN5yS/OIImWFG?=
 =?us-ascii?Q?qRkdderKDjkqz3XRK4p0QwQWCDUrpCitnorTgPffd3QJjxZAqPRaB0uMLoRz?=
 =?us-ascii?Q?TsjLQyMNDLopEQkBPqJ65qPslQh/SkQmIqZH7ydlcPZcyY8D59yfapOjFmFS?=
 =?us-ascii?Q?hluGf9tzi9idSysMVqoEU0gHy9YDGIQ2wyVPRv5RLqwZfvLprKpEYnyLiouy?=
 =?us-ascii?Q?mABYpnKfVUI/lNljxQzoejA+WJn6/LNpvmEtueec6KXU/T0sj0MQEAmv+wLu?=
 =?us-ascii?Q?mjo2eJWd4VS/am8wqwl46Cew8B0id32kbAwZc53EyJuiuX+kh2rK0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOVFYZItDdVBJnMQd2PaEWJzSFmMcQtjyViXQovSeMStXTmah9BtL37B/aqK?=
 =?us-ascii?Q?ckU2n6O/cYbWWsURRF8OnFoFzj/8N1/QQFeE92VlVt5ScIbkzOvWnzzOWIAN?=
 =?us-ascii?Q?e6Xr7v0q90J21ysJaTBdD5rBeWO8sNgV+wpM7bG/divrPubnNp64uzLP+Hp7?=
 =?us-ascii?Q?YmqKBo1q1c5EpgcFXXi3DavzgqU9WwbbomPGK8TzxV2yzV5J4mIANxwNWpY/?=
 =?us-ascii?Q?nWL6CQ6GhqlW2+cCBYdhCpVGYxTmzqsHQshgPUKCHyARY9lejktVLkKn7XWJ?=
 =?us-ascii?Q?96KknOfniYCIcCmcRTTfGXoiYcy/WS74jFGts2gsD2sRzK70OTROFIvOBlSG?=
 =?us-ascii?Q?PhLlZoqRBmNPbfPbUgYBN03tYuo84SATaEPCCC4hfUcgDZUzLNm9yxZixvUU?=
 =?us-ascii?Q?RZ54aI5MElL4mIKxCxlv34agaupNAZyuYWbqBtAtNjASyfr9JxxRztro570Z?=
 =?us-ascii?Q?PEm4+niH4puGl/kurejs3zLyUTAjIgL/hnxmgwTq1H3ukl0cnT78SfbV3EaZ?=
 =?us-ascii?Q?Qepun43619wdao09Rf+NIatZWJYMlJ436Y54BDPHS4AbzJ7LKZAcBBLyZWse?=
 =?us-ascii?Q?8GnN3+emKURxgru9AALCwYoEAxMK57j+X35QBQck4pJkPNR7FQnMjLU5i0tO?=
 =?us-ascii?Q?B2DxsaOHJmpEb0hyhIJnzQ8XuPsvF+b0ECjComF3qwdK4U/n1HtOnLC1j8ra?=
 =?us-ascii?Q?vDKOoS7XK2Jihq5GH135MvrE8O2d/GNsK+KwBxEM/f1H5/gvoFddgfy1e0Ur?=
 =?us-ascii?Q?PDZSHCg6CABDcPPEY4iPynNnBzb5OFx0QTuo/o7kLTiC+EFCbeUCSirEiwCJ?=
 =?us-ascii?Q?vzs4ABYKCvNtSi1hXeRQqyQShCLBc0ZDz9x953oP1VUkPoCN+D+lbYXCSsxB?=
 =?us-ascii?Q?4KNDJD4ncVAn+7LRvehTDXc2bIgbkYaLYhDwgSgkg88m9CW7d57CUyn0iJZ0?=
 =?us-ascii?Q?nOgbT5cim4tJy+AuduWPm4paN+EfQ4dDJWNz2JURxCsS5+j9EE3utSfD//Sv?=
 =?us-ascii?Q?gyQFraB9ku0H6VE5aUtRJ3UaWXqejXMunAT1x8quJTOdWXkeHwzlFR4cmEBj?=
 =?us-ascii?Q?KNEGG9/pdEmVV/M3ouBfVUwxOcmK2koxj7/dqxYdVsuh4uwAogNJKNFlVx/9?=
 =?us-ascii?Q?WPhD1RIUjiK8a5K78/50UX/7SHTo54w2y4vJhkpSC+aIqz7Upr0Q2gS5PlpK?=
 =?us-ascii?Q?PMNnJY6fsN0ErTPwITdlZg5ASciI23+KEeWoMKKu1bx5xkIvPIz2zh0A68Sn?=
 =?us-ascii?Q?e5CRxp8D2hvSjrdU/VKVTvP2E/nzQMy4+lOy7nVMSGKA6UpFOC/ohPQJ/89s?=
 =?us-ascii?Q?OKG2hEXyG6vYReZPgfvShbLQL4pZ4wHV59oJvSf/SBgLOHxdZ2MxTlaonfjJ?=
 =?us-ascii?Q?UgZJ2SQFzJE9ZVh3WxFU3rZ4SMkQM4DzJXgb+R7SMwcJwsnYRaCXg2W44QDA?=
 =?us-ascii?Q?BS+HFtc9y3VdOTBA+QNKNwMDrZTtmzCORY7n7j7Kmyx1Crcyk+t2g4tf/K69?=
 =?us-ascii?Q?ii+e4REcMTvA/Y6NiBpQrRP/roCUpECnG5XCxHS6wXKz0LAH8TPMk2gIOp27?=
 =?us-ascii?Q?VRXOofV5YMm1nB5i8W/xCIXwfNh4/QxjcBHVHThi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7de97f-5ec8-4fea-560e-08ddd951c224
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:38:53.1383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGcLs3/wRzwKr96482mOQDAMyGOX2Jxk03NTQ/SO4GWM+MqjfguplFoaRs1ZVjTRbb/IXhJa2a8pjN23W6vU0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6999

Remove unnecessary semicolons.

Fixes: 764f1b7481645 ("spi: add driver for MTK SPI NAND Flash Interface")
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/spi/spi-mtk-snfi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index e82ee6dcf498..ae38c244e258 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1139,7 +1139,6 @@ static int mtk_snand_write_page_cache(struct mtk_snand *snf,
 	// Prepare for custom write interrupt
 	nfi_write32(snf, NFI_INTR_EN, NFI_IRQ_INTR_EN | NFI_IRQ_CUS_PG);
 	reinit_completion(&snf->op_done);
-	;
 
 	// Trigger NFI into custom mode
 	nfi_write16(snf, NFI_CMD, NFI_CMD_DUMMY_WRITE);
-- 
2.34.1



Return-Path: <linux-spi+bounces-9462-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D923DB272EE
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 01:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597C9A27BAB
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEB292B22;
	Thu, 14 Aug 2025 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="R9vpS+vI"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023077.outbound.protection.outlook.com [52.101.83.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0D28F942;
	Thu, 14 Aug 2025 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213160; cv=fail; b=hlajpJP33TpdwUK+RncRbBirftvbat3vlM3J/Y8NFqWeZ5i2H/GAitAaBQvVcXd30lluXHmdrxlhnS9opUugWt1BR98fzqwzPRxahzjwAh+m1jGRI9c90ufGSBv4Ez55lGqinEcgplk7l/7JE039Q6GQczkJToDpLZVnjWJkZN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213160; c=relaxed/simple;
	bh=P0AnjIgBEN+k0yZbzIZYn8bjgncRLgZSBBH58q0ewWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+WudpUQ1HOFMmPK+fXk9a0Ut52rn5IhJ1XXpB5vRYqgpg/pPlMCGIt6DDm9orE0wGeS5yalEEoABvFHs7pE5MfOj8nRF/wVmqWOicgXjdHvTPMgDkJUGJuqiw2OaBs7dN4PkiLbpjNdyuvKm8W5M2UK7hy1vOUksVhC3t9prfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=R9vpS+vI; arc=fail smtp.client-ip=52.101.83.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgwSCoFPDebz3cxAxjPeIgX0F3L0CbsA+Huo7xDxjIwZBYVKw38qgZnntggMW54Mm904hgtb6tjcX5NckyBswQPQFfIaIAa9yHXWleGymko/j8p6VhCLy9cuc1bbflcvj6tgGDJuisMoJh1T5IZBl625WSY34GBsBXOUgL2X9sc7Ns/tSC1eUoVDnrcyrSj8HVQC5rbayMSM+LzyV74473pAACcE9IWjehOkaCSs53i6+4BLxR2aK4Ru4OLAuPyPmWfzl444WQKo/CMbuSAN1VlvVFhlDGSaNdqqi0Cuy4BSqGogh5qBf7Qs7iJ/aEkRyTFUAGds+oOYAnCeIuZkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SgKCteCPt8OVZrOZTua3zEoumRlrMBkjssXvIQmox0=;
 b=QM81Wj8D1dnwF97tYuPt/SL9d6oh9hU5HVySzFUvLp60Afaye4smVxA8N87wAEXfCifPflk3p11O/XZQBzCtSUmTvSptOKPYgoUkKAdSpXJmFF+9G1RwI0liMqBs/13+cpn578fUkM2+pZpQ6yDq26CHZ5mh2QWH4eVAqxB2yrPgZncn1WwPGIJn6iWY3twnRwttJuYkj0F/jnfCwxss9rFFE9TfD4s0c544DTQdX+uR9FlEIia5bzI6jWjvJYNjoscj7D/qJdGcYQaTmqFN4QrPWATu2hhnUtthwsueEO7HHTSRPy/JT43zJYGdYfxYrM1y42moILhqm7n2G2mUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SgKCteCPt8OVZrOZTua3zEoumRlrMBkjssXvIQmox0=;
 b=R9vpS+vIJFdS4tss2e9GY2DkY/fbh/EKBULUCDtIGrcMImBTb89KNp6fa4NqllLuqHnMY+e2rPozPCe1y9MlCA3MdNoPHDvb+r/Yurn1ClWWzwByeiu3fJrLIkZOgjd7HkUMb4tTtkbHptmXG3UuztXmUAx0UyCsfPglS0ElksmBUPhM/pj1wK92obxIFgVEzy01cr4Z9S43BHmiHrlUC8rVPkGHGJlmEKHM218K+He8lDcCuxzq9kZLb5z8zjsU5VTd6dZnvgMUacPFFM7KVLwmnMrPpa3UCTAft3umB4kqKRf0jM22+dz2bo6N9F0HBbLRWo1klnjwxjVqbKNtKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6032.eurprd08.prod.outlook.com (2603:10a6:102:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 23:12:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 23:12:28 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 12/13] spi: airoha: set custom sector size equal to flash page size
Date: Fri, 15 Aug 2025 02:12:09 +0300
Message-ID: <20250814231210.4174427-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 2d4081d5-653b-44f0-bee6-08dddb8809a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C8lsd1t3WuTQj/l0Ch8oTNxxEm8VOqE5/nsxEJ6J7pWiZf0BEBcoHANWc+VX?=
 =?us-ascii?Q?5YRlXxrsofCoHrcePfoMkltWw0pkBrU/Vds2dkhCZEEC1PkHKadm8DPkaNwn?=
 =?us-ascii?Q?aQDOUnQvcqohYi+rCKiiPgZVojlIM9wovUP1vJ6G/sKCs4TNI0X2+3yp3fCi?=
 =?us-ascii?Q?95rXBeo8FhJZoTisA6quHlI2uiHAp5m8BRm1E4AkhL1XeMLiiTrFxbivhVP6?=
 =?us-ascii?Q?jxpewu3n9+tdGAQ/VcHmjtdR+THEeUeZgsprv8pWsiMteW6VxPTRrxBTimYA?=
 =?us-ascii?Q?WT2T+t8Pt1Qwk2Utql5HfDGZD9GZPulPMYpezWn6Uo29L/W/QmbX75d5uRY4?=
 =?us-ascii?Q?ysuyFP9wNxRR3MAJb5YJsTrjJyFJaWebGCMM9D178zOBnQ3YjMg5CCFKZBF4?=
 =?us-ascii?Q?9P+kHaX3mkbzUsJ7qEs4AJHwN3VIUIAKxQoQnNjkoQgVBSE4wHQc7AJN9iVZ?=
 =?us-ascii?Q?PzFUxLDJzq7I8//TO8gEc7qCNKYMoskySRi3UxsoegaM1+ZVMO2t63ngTZtk?=
 =?us-ascii?Q?8uv1FjpGIe67T82bfiqqZ5K5JmdzBpf/VKlXAN8gxetrj1xJIbgS7Y8AlRMv?=
 =?us-ascii?Q?aXCa9rH68zIyQ3HNNe5n6HXFHa9L+Wo7sZxbg3xGsJ/w+rLytrOQ6s6o+sPj?=
 =?us-ascii?Q?WtCrHH/zUk7+WAY9SzJtthMcyrU6m21Me11aum6TBz3RiMJIG8RKJyJ/diGs?=
 =?us-ascii?Q?3u81SDWCm4KpedupNKDvM0Rv9HhlqXlFQflynP/X1p/UwLEK0xids5kup7P7?=
 =?us-ascii?Q?aPdiho0kKudrENCLqSthERATbQoi4nhQSdkwRyMbP7pQTIn9LgYVTI8XWxIw?=
 =?us-ascii?Q?SDeuW2EBClKSS3muvmNn9bzzbuyoxAlLmt7eJIaTVVINF0vkJRbcuRUl8vJG?=
 =?us-ascii?Q?XFagCUajDolNogacPuEndZMr0jOmZxubkxort95qZc/TyNVDz33chZzAm/39?=
 =?us-ascii?Q?fKkPEu0enjIEci24cpTtEOnoTsZXVDO25dp8B2qX6a9j5AvcUqZGGLRUSAiT?=
 =?us-ascii?Q?Sp/10pJpeRee33fKYElcKtnUjj5Jzmc6sWxd0B2ZxRGWlc0ljs4og+wCJLgB?=
 =?us-ascii?Q?pDgRjK+5pTSCPQ1LO5hW9K6hBsUbFscqEeTrpcGoS1dO/zTu3WywivaJ3F13?=
 =?us-ascii?Q?gx50mFF2kC7SWnMyVY/2tJqWByuovPHhJIDYs/7eLq4Dyd3nBNijI0OK1Qlj?=
 =?us-ascii?Q?5be9Fr5Qv7Zq6+ZK/1G2NsbCwvAGtsQ2S08BoeK7WoDnm2p3e4O49xPDplin?=
 =?us-ascii?Q?jh4oRvVBGkpHLHuHYdD5qeog9DrBApVLYPHZV0jwt2WScRIPuvVfxiYztuqc?=
 =?us-ascii?Q?1F8Qb2qOjLRjsUTMJzcuRIEORR1Yjt8lGTWaJ7hAQ5sI6KEqCuKdKK9b9PJt?=
 =?us-ascii?Q?opv0Mo0vLnvOooBG8emVIGvdpgeFz+K/vFEQC3qsIeN+XbaEYfryThsedOLT?=
 =?us-ascii?Q?u0MAaPFIXZUb6YBUkFdM4WqArMe9DbbjRdVm18brhGaBBdHBC01fDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7b4IvI3KxfKSQhzEKQEQIiveDc07ulC7Xe6uO7sgVTNDmafANHhmhONxFD4V?=
 =?us-ascii?Q?7D+BxtMRaoNo2g3kYosDsywFzeBnRxtJqKMFGknGte+8vIh/NXKJ+h+gZhJc?=
 =?us-ascii?Q?tcvK68L0g3ubZkacug/cW+15IkQ7xc4oqHesoy9To7/4/QsJvK1UsizEvyY0?=
 =?us-ascii?Q?oMqaiF9JkUJ+wCWQXaUA3+KumEfmkRXhjw3H1nof2I0lpSBbUrVDwnZXm3Dk?=
 =?us-ascii?Q?JyMo1VshIYjMKvaX4pDnkEuWmt4HbWCIXXeP6MB5Hkse2R6Vn0CtT9mO4bTo?=
 =?us-ascii?Q?8ZWrHYTb0cWdMXhs71Iuaoxkd692UT7RbwYBYq68HoNOqpTD5OhSJqmmiNa0?=
 =?us-ascii?Q?E43dGMafAdmuwnAgnj9LtNXvnWQjmvWpKQ1rf0TsdvAyvUAdKbjiibKYzucn?=
 =?us-ascii?Q?q7KBONkf+6vdDtSDz6lw38Yjw0CmtApggspe+bSUVx1+0XOwd5uDPvr90DC0?=
 =?us-ascii?Q?85ZfGnMn7QWcXkLQcSA0zmRyhFZfXN/hi0m04DpPc32yRQcxC/PmGy07Vjg7?=
 =?us-ascii?Q?+5oK2yYEFunG1DcqCojnUGqiGQWFdD8fVJVxK0+EjaGPN9/wL6rQe2vVM7sR?=
 =?us-ascii?Q?mBnJ5Q6ZsObfT7hgWMAqznDIrWEIcIxBIoZHwNl7hL1jBpfSeCnAawiSDjIu?=
 =?us-ascii?Q?ObBV4eyB5/t46zpHypgJJphKPtdkIo0DVgdq6h1FLRKeMjlE3DYH3iXpTwUZ?=
 =?us-ascii?Q?s8+yHiuDWM4DCrmG537XFp2bTjcxeHCXF7eU4TZ6CnGc84l+OD+Eug4uZOwg?=
 =?us-ascii?Q?WDjQZMuZb8+mTud80yqGGPuXRk0NuMgfCb/76eLZOVfiNnNutFzL66Ogtqmg?=
 =?us-ascii?Q?wZNaYBDUXfYq1NsEiIEWw5tN0JRLxAWUl9YhWEWINpcLF3p9L79JnRlCmkOD?=
 =?us-ascii?Q?RWCrc0Yxkjsf0usdd89poAukN4oeWax/3OYdASD72jG+MhTZw+5P43VsDoYx?=
 =?us-ascii?Q?Nr3nWcC7yQtbcuPw76h95+YX2+ld6uvb5MO5Mg5j/elElWoCzpynSX6NwGKi?=
 =?us-ascii?Q?JoU+DsvQNR661JGUY4Ylp2/BejGPN37LUEcr39vetGcmV53GhbHQFtg2GUDe?=
 =?us-ascii?Q?byPc4Np3uDQXA1ML32/mjoEMK0lRaRxQf3wEH9SZn0iYEc5v2rCwASR2XIbM?=
 =?us-ascii?Q?EVoJTgzZSmrD3UXEmwfOW5S/HgZ4psLb1WZnOqWka+Hjhw19qFe5pKPhVdYS?=
 =?us-ascii?Q?tufClq5Se4IrhYHdbKkoaDhh8azErWT/K377wqHsGPxyHW9EvNKzRPoJL4L7?=
 =?us-ascii?Q?KlGgcLmVYs7CE0hdXe2flu7osiXJBQq3i1J2mGB8i9MW7RbxNbnetRHTbEWA?=
 =?us-ascii?Q?eSvanNGQ6/5O4VPd66E9xo6pkTqOOTHSghhBlj/KlGFGZtBqKDU01Qazlpky?=
 =?us-ascii?Q?AakIeEobf7xZUgU/oKHwMKA4NUsMd+QvU8G/KFbuMYtywJxqpimRICnLTig/?=
 =?us-ascii?Q?Ws9j7vtjeEuzRLjMGLm2wHtGdPxBm12DkQFUIkfay1Nbgf0ZlwyaOlNhRUuP?=
 =?us-ascii?Q?XlSffiRtM7vZpLyBtFthpoOK3oVx3V1+ADqAqdp9IkVZzeUTldU7oyNtDjab?=
 =?us-ascii?Q?16Op9PI+aNXAOASYefWpSYAqvoguabJlnDLy3IyzB582Uf602cfBlbvdo1Jy?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4081d5-653b-44f0-bee6-08dddb8809a8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 23:12:28.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTHg2+Nx80OuUzEVKRrf/wBKn6i3+YRj5ZYIwMQNFZH8HEiIT6imOfEpxkA6UvCd1fWkhN9E/o6cWwrs0XdARUs2xFOo9kjjqhmEnKujUIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6032

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bda85866d1ae..a96c87f01f52 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -629,10 +629,14 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num *
+		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -690,18 +694,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				 FIELD_PREP(SPI_NFI_OPMODE, 6));
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -719,12 +722,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_unmap;
 
 	/* number of bytes to read via dma (whole flash page + oob) */
-	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
-	      as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -813,10 +814,14 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num *
+		(as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size);
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -832,9 +837,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
-	memset(txrx_buf, 0xff,
-	       (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
-	       as_ctrl->nfi_cfg.sec_num);
+	memset(txrx_buf, 0xff, bytes);
 	memcpy(txrx_buf + offs, buf, len);
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -870,18 +873,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -898,12 +900,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_unmap;
 
 	/* number of bytes to write via dma (whole flash page + oob) */
-	val = (as_ctrl->nfi_cfg.sec_size + as_ctrl->nfi_cfg.spare_size) *
-	      as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1



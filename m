Return-Path: <linux-spi+bounces-8650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D52ADF05B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93771BC02FD
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3BC2EFD8E;
	Wed, 18 Jun 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QvkqAwIN"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011035.outbound.protection.outlook.com [52.103.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2692EF9D0;
	Wed, 18 Jun 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258465; cv=fail; b=sZf2vFZHEuSnuHYhfdGctqZTb1gfykbjJZA7GEbZ/S8tcWrB3Gree3Qrj4i++X0Rke8ZPM/zRLnBM+hfdFSQAe+oE60fwgCkiwlAeilTH14HCZcn4jGzCWDl14IV8tik4Mtt/8sSYVwwYIgFffhHC2D0RtCmR40pR0DSNh99oBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258465; c=relaxed/simple;
	bh=NPDAHSSnfWIrKWbPYQcUVprzR55ZHBRSe1FD+eHUrKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QtU99CtCEjskVCmgCBqiwDnyKjbFMHOPYHhLULn7XoUC9jTYdsE/udEOoeN4blsOfsiPFntgSVJWKtJlr9Yeznb+RJgHvt2SMPwurqkS/BP78BKcq7d7Y/PiUrPYumhcmlRldSOeTjWIxM683vrLYbWVyeWK5Alka4Fho3o7G8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QvkqAwIN; arc=fail smtp.client-ip=52.103.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS2kJAHm2fpgwSyitttmngOmndkeSjEqznSZyPIpeAfoJ56xB5/fuPmDpW/N1ptEb/WGkMZU1nTLbEK3nVZfFZF2nhVHXtBELMiwQiTigOoOue6+XSXlln+nGfbR7Y+HwPo/K4NzzAfdyZ5/zPP1umEvzKl2wAI/GkBT8nBb/qxUOqMRFq8Yn/aCC4SFJGFVXSveInWovuXt+fjZ3fUgXY8G7hMqJYphorqKKWqX0nnv6xNoWHTzr0KnWgPVNM6s70mjT9h5ZheMoTXsRCSw+C6FEffycFY7WN9ypKw+aa7lK0pLt0ckCjftTSdnRTjQRIGovu7NNAXBSV+tbw7FdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9YeKpAQbkDgTaPc5TYgZu8U6pV//btZOtyBEWVfJ1g=;
 b=mRJ5DrPSpERxu8UcE0KtRPlbMrw35+ZKjLfqyTRWaVH3pmkBJw5R7QhNejATOPRr/3keizTiuheAPZCVsD3N0ahbNVomU+lU/u6q1f7RYU7iwIuqje/fBmIXy1oAtXhtod7RL7nKY1H+H3ACDmrQiNS5V+nRCjqijW/CusaDDkLPqwG15VUpc4gYVVHQHGaRr4DwXRqYRIGoYn9Zod5XdHvoelFNrSjH3QCOTyAHCwQCY6ARzjyprDpvFThzmpZR03EejMjsT6XemHvo/jvtF5nnQW2PNWeb0ZiUsR61nODa5A+0EIOb/qzQru4enYFms3ZrZjKzVlKivTIKghZ35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9YeKpAQbkDgTaPc5TYgZu8U6pV//btZOtyBEWVfJ1g=;
 b=QvkqAwINRjLZHg68qGy8SN0o/3wvFp66ZeEYxarc2ews8sXa9U+iq3KoPae6ASNdL58kUOGdVvR+9hQrSqC7sunWgPOG2wgWu8KWpggNJJmwyqaB9C7Wb4VVOitEDL3i3qbIQjzfI1uc4XhWFPplNFMZJBv5LUMUy36gQFZ5pKeCxfI3KRmUVntUhkxHlx7TCVuk2L/97JHX3SMQ68AoXyrdkPdZ/4rbM0V8+xXk+p6OdGWhnzNTovC+pdyyEeTEaV/I7ZUduodfknExFudfFlMzPFEVyZhy+DnAaSbdG021MVT16RVUM8En7BNin7c//raIFG7thvqafjTNbjL6uA==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:21 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:21 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 07/16] MIPS: lantiq: falcon: fix misc missing-prototypes warnings
Date: Wed, 18 Jun 2025 22:53:20 +0800
Message-ID:
 <OSBPR01MB1670C89728CD1E043CE94E03BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-8-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 2044c271-213e-4dc2-c5b6-08ddae78024a
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdRs/aq9JggGW5twkGCSnVzUOkEWFrYrtzcmKqqmkEx1BRLCRjEvaUjCKsvCEY/wrl+4UCHX8vKt66BNZswLGoCqS/GOquVfAJJ0ITUXfG+9pJENEjdOufMwFmomD4sUbvdoeJcuyZ5w83EEvXRmdtydQEJYl3Gr1S1xtRYHH8vLx/xvJLs4pMfjlS3i6iHHccOEC2To9Awd2d+6qseOpnA3+tB+DvX387cryIdTr1X5EhMe6NeY6cF6v3lMQfQpM6pu6GQfDwXDU9eKWDWIN0OiqMl9VVjnlgMhuKVLshmHdloLOOQMw7IChRAuUFBBdk8YbnHY+XqYa/0SVvC+hEDApv2bIXyneaFya5IsnaYej5Q2QmZzH/vYgG9EDg1siKTay5im2+K+ssRt76j9/SB+sLxpqd2cQMbUw8JNlIFGjXs6KW1nDGuizMfXqRxKRebmnrjPzZH4WRW4tyuLDK7nQjpRGYTYrD11GruaPCajMw5HJXwcAgtIhlhZKj6wXRbDHSOjyGHXCxzTcCt7gr133aLC9YU9C0OizY0HjMbOqji0xdBq7IBBzRXpNst151De5CezeLHGvFSx01iLle0hr6DC9LqfmOWQRPH6fqL22jhFPphrzBfRlcx6Fr6WMxCYccI0eQj/aZeUGBu4pGYg4xP1hS8NMLmwisoZX1QiUOuTKRHigchOi7fYFQdAf/9z9ygoftD1eXkAEmBteIg1wUYWTiCADDYbYd2Mbk92k=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|21061999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iwb85xVSwRHrMerUxM7tY1/TOpBBBIb3HNFNDq/Mk5VZUBsyGsgRoZXJu19l?=
 =?us-ascii?Q?L9/PWrDb9jQplDmiRzTGF3hoK+n26sd9DjOXqxTk97KLNngAWKKrzycr3jo7?=
 =?us-ascii?Q?n3/N07I4807UUrWiUBrOMDpEF5DAoPW+vtLG664j/HeQirySE4zw9+Fm86An?=
 =?us-ascii?Q?LKUpi1RHo+dV5gpAprQ3HSpt2XYbGpxkfFuGPClTvvdC5nA6QEX6YXWSHu8f?=
 =?us-ascii?Q?8bvzOSpBDFh1xiaQQNc4JuKYJcT/b6rZ2ffttnXXKpLehD8b75qnEWNPjN3h?=
 =?us-ascii?Q?HD2dBHKchfmc3yLq7vc1mlnNbGl6iByhm1jG26bN7JxkjZw/OoL2eHVf1lHD?=
 =?us-ascii?Q?GE9T73tqwsDabjpQ7+6YXbCTRs38oRdDyGLeYMQNcyZrRkD8pPmjZ61nvnxL?=
 =?us-ascii?Q?dxKAjutiSsH0ItuPtQInbDLIuVqKolandMlOoSodM0B8JTdanQzPm6+MLnxE?=
 =?us-ascii?Q?/Kqy0oUU7//FsTkJNuyrESc3Bnr4Tp2cjr3qDpgj9ToPes1LqkBDjmtUPG5S?=
 =?us-ascii?Q?wpH7hVdviPro40kCtoo+bxQU8yaQd6VNWSR9EmHrOw8EGGJKYoAvt2siMtrc?=
 =?us-ascii?Q?r9aDAn1JQ31nPP9SytXsQQs5TpjvLcYIvGBg9WIw1dT491IxRnT8dXbcPzQa?=
 =?us-ascii?Q?vqAp1lGt7Ufjm4CS+C3gmGAmwArYUXbWe43LYgITbCO8AO4p7NZm/YxL7n3J?=
 =?us-ascii?Q?JZ1KrZ1epf1VR5IyvO4N0OA7oR+JLpc+qDCQ5AG7sMmaEuIrc2MQ+Z7CSW80?=
 =?us-ascii?Q?/OYMQC6bGpgxoZvolHEmC2JyaMd3GX5mOMKxWnO0rE9mUvODV13N8bUs+Rdg?=
 =?us-ascii?Q?sLpR8YglSuXNlMGmW0X5gIOuKWsmxK9DjjHhl/MrL7gevuwrNbVordDCWikV?=
 =?us-ascii?Q?+kTEvq0TjNfybkqkVUokGocFX1VddnuQmagk7goEhJUbguW4OAaGdv0Q8DAJ?=
 =?us-ascii?Q?mqzV7/Nw3rSkfioM+Gqu4/HuxOU8cgH7MA7drUnFLOy/qsPnH1OJ/DWZ2ldE?=
 =?us-ascii?Q?ilSrn+bveB0W6W2A9JFwc/ueikcMB5Q6XKPyEkXi9TDZkPB5Tu1IIUDTbiKE?=
 =?us-ascii?Q?mtcvX3jDf6zGBJDkZSBHowGT4f0m93Ae6SXAulUbVaOnCtfx7SmovYEJL7+J?=
 =?us-ascii?Q?ZxnIOYSqyHbiLChJjTL2ZqomD9HW7zWpjonEbVBv23YkL/QDrVToa/b4PYJm?=
 =?us-ascii?Q?gfB8ybxibHRaP4r5WU21OCajFkoIrDWwgqJSI48I9BHBZuYAnq8gCFKDq5E?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7JddkI2Umrb8XcCQFTsmpUufDXyBEGAqkpCZWJXb0ob2FW6CV1k/hkO2FJN4?=
 =?us-ascii?Q?uxOTBP1Ve5rJ6wWnhSYQM0qek8Y4eGlxzyiYd8IoyOKcaxgjllb1F4i0hgxT?=
 =?us-ascii?Q?DDjTOwfDuZMaKUPCFAPUesSQDY7MZLiLIEm29/KhhzX81CeR7eId+aMntZH9?=
 =?us-ascii?Q?YqHuL1UBscop+YnMc6KZGdiwrrUQZa83TDjrVMQcW2c/biwiQ5SCMoGPAkoH?=
 =?us-ascii?Q?u4S2nUwzCWlz19kZ5zm3EsYfG0HTVCipWGb3tf8G3G1xhwxuSnX7lbxs0i2O?=
 =?us-ascii?Q?rDfz7+Jt3c8uff+OQy0qacfaVZuLhIixbdQoF+ZmiEJ3huTM/UUjf7uE0q6r?=
 =?us-ascii?Q?QLUjVS67EQwBaDtN0a5YVa7pt/AHCfu5VTZ0odmatdbILf392y6jELg7rEBE?=
 =?us-ascii?Q?nE3reDte8r6O/KALFjdGvBy5G7cZ+PkPW5eCj+iAmz4GnOUuNSt+LVkdPJiv?=
 =?us-ascii?Q?aPQtMQam99GDoyIQA6MLXLWAvOMHAkxefd2IB8gWExCZoEics8JJlO1knOfx?=
 =?us-ascii?Q?nV7sMD2rSR0A1isqYlwMn6mvGce/vR7XmJLgf0WVzJ7gVYW33pDtOMD6S3Na?=
 =?us-ascii?Q?1Vs3WvJwIu9+efuLoYClpHzZT8G7Ntt5LpqyxCd6xKXGLFlRO+gHMTFzEdqE?=
 =?us-ascii?Q?B5+41zX6UmMmKQOpYeU/tXMKO9jYHU7Xc309s1ROjLWxBN/0qP2UpleoY8H1?=
 =?us-ascii?Q?WMW1oqTJyCyXU6i0/18LaXAkjbgd+8DkZv+tVHrP8i1jWSXVmc0Ty+1NKSwp?=
 =?us-ascii?Q?qTFVhPdub8+/yf2+d3NZqiGo9DpiPbDcZ4g0lpceGazrn5SuPdodStOH15Rq?=
 =?us-ascii?Q?d/kPUX0tRNu99C264zqkIa8MDmlbzoYkrmuZ63/zLinz/ebEzveot1dgJixi?=
 =?us-ascii?Q?CQqxpCFCn3Ll3BL9Ltd0tGCng4t+hnB5DDU95nYz3wkuSVis1yaO7SgbOwUP?=
 =?us-ascii?Q?+W2eVPagWQN4RJPCu4Y2IpSNkO8OfeIk6wgUJyebBUKgLdZhqYQbb5M3lJAx?=
 =?us-ascii?Q?25ZFAZbg1HA4m4SNsGlvp2q+X698rRruRPopFnHCOHrcK9+p8hZ1S7YtFJT6?=
 =?us-ascii?Q?OIfI1BaTOGG/O/gK01vNRqX6bvRVC/tX0pTPGJF7xj3N8eLYzxabCWxou8Da?=
 =?us-ascii?Q?YjDdCVlynzVvQaznetqS9xbx5qjy/F597uoiIlhXenhkpgE6t2Zu+/L6QsYv?=
 =?us-ascii?Q?31h6ksiwlb7QMMRgJxeQXJBFQDH8ae6Xpcc/d72rP/J2UetdUGo69cTYwBM2?=
 =?us-ascii?Q?UghV/lyk3jC/Tvq8M0jv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2044c271-213e-4dc2-c5b6-08ddae78024a
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:21.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following build warnings:

arch/mips/lantiq/falcon/prom.c:39:13: error: no previous prototype for 'ltq_soc_nmi_setup' [-Werror=missing-prototypes]
   39 | void __init ltq_soc_nmi_setup(void)
      |             ^~~~~~~~~~~~~~~~~
arch/mips/lantiq/falcon/prom.c:46:13: error: no previous prototype for 'ltq_soc_ejtag_setup' [-Werror=missing-prototypes]
   46 | void __init ltq_soc_ejtag_setup(void)
      |             ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/falcon/prom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/falcon/prom.c b/arch/mips/lantiq/falcon/prom.c
index 7b98def10..2a38c4267 100644
--- a/arch/mips/lantiq/falcon/prom.c
+++ b/arch/mips/lantiq/falcon/prom.c
@@ -36,14 +36,14 @@
 #define BOOT_NVEC	(BOOT_REG_BASE | 0x04)
 #define BOOT_EVEC	(BOOT_REG_BASE | 0x08)
 
-void __init ltq_soc_nmi_setup(void)
+static void __init ltq_soc_nmi_setup(void)
 {
 	extern void (*nmi_handler)(void);
 
 	ltq_w32((unsigned long)&nmi_handler, (void *)BOOT_NVEC);
 }
 
-void __init ltq_soc_ejtag_setup(void)
+static void __init ltq_soc_ejtag_setup(void)
 {
 	extern void (*ejtag_debug_handler)(void);
 
-- 
2.50.0



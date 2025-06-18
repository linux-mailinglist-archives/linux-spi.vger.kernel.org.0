Return-Path: <linux-spi+bounces-8649-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8509CADF05C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AB33BB72B
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154C2EF9CE;
	Wed, 18 Jun 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AGJSvOUc"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011035.outbound.protection.outlook.com [52.103.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9652EE611;
	Wed, 18 Jun 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258463; cv=fail; b=Z3CNFLacom1sObihWWzG/DxSButjPCDZAnrrCOVUa4IvJLm8T1Y2t+OlOoLnFthtwRyzrT4i84VLMhrL07EX8QypIRsR/MPsa5iV2QXm2p8pRRLrwfoZF/CTbQeWahBPqbTdoslGNKfLKOkoc9CTeTZdMqWU/LdObZ9lkPkABpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258463; c=relaxed/simple;
	bh=hL3h9R15WmCjLR2/bWk9w2QrIBXC4nvgQdKH9p0ReTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6TDBe+V5CZQS+YsOwhfiqi67ELtn1WBLu2FuwOMHAotlndMAeRa/vzJ3TtWRrnfj7DsQt03tiXUQX1kSVoWj8ANOLaglUC9cTghP8MJmF1lw/TVUg+AVF3UpEa3VzzGrRUzIDg8+WI+PIblf9VSc0bPOzcyiK655FvWNdza18A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AGJSvOUc; arc=fail smtp.client-ip=52.103.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qumPMcajUGMeOa8QebW14M+cBu9bubiBiY1dmRGGuMTXkNG3IXhGAcbR3qQ4ZUW5D1K6Al4oGAE39M8BPo5l/vEOdzvUwvwU6jYcArPDP//K7MzvwPXU2qt3HGZ3FKChU5eyJQrtgczN3KOgMSNk4d4dUrCWJjPGBZRPwIn+NxdBhKb+6sgkGjL/0EW8ZTY4M5H9UMkV5TUu/048snw5sEOo2uX4LvyBod65z+TdnK+O06eRaufSujvn12LW9ptcOfU5boAfKwNSUlX4PYD/6/I45sRAp0PP0rDSYFrFCqhu0UxntFUPynWwKjLq6P/WfZC9gLx9pAuOjbd0o/1a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok7tYZPEu/wLDahd6ksgzl6aqer/MyupQeoTpPY/DoA=;
 b=GCxz+TU2BZbyb1hG2WH7I793Kffre9uuvnJ28qx/n0q/GImz25W0JfM/UAIazVD7VAQVhlSRj+9bPVFU03u3GEqn4BagIqH39ZF1ZpYROhiWb+YkfRzS0dR/GUXMTEoxWrACHQobIrJ1+ac5G6VY4NXzcQ/4IVL9FMBHZO8AKNL5NU0acWj5JEcTEATPnIGzkSeskQyBVbf6giU+Xt1FBdMZLX536ye6l25EsMbPHRETV2TPquM4WerYpFD6964uognfPXa5COHb3HSLuTgiaPORCHuFJAz8w9IzniYZns7FmwGTR4v7s07n5wl/8bAtJGZ9lVZRfCrV9sJJmFHaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok7tYZPEu/wLDahd6ksgzl6aqer/MyupQeoTpPY/DoA=;
 b=AGJSvOUcdqfHBNGowiFR9upG0M4jVAbbj3Rj1rLjMIhJYTG7WW2EaUrU+e3ikpVmQf/+Dwmcw1MIYCq7dsslnfmJRgxoJEeYasb/pOdPRSl/mv4bTD4qupMjCeuUNcNgJtw6EAEVzBYsD+zaOasUEBsJl79Jtigm3ftS4LC9hoiJpuNBE/7jrng8f6iHMBguWRbqYFJxo2LcMUc1z1rzDwRWTHp3+yPf66f2okw4DwV6ct8jkeosb01P8G5qOzn6ulgbEBhstqsSKWDpbelY2M7z1TGYOSz1SyxVS0NdNRrulQFzfVAdYlm2RyfkmL5hzeZDwsMLagFbrV+pw7rKQw==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:18 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:18 +0000
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
Subject: [PATCH 06/16] MIPS: pci: lantiq: marks pcibios_init() as static
Date: Wed, 18 Jun 2025 22:53:19 +0800
Message-ID:
 <OSBPR01MB1670AB9CC3071AEC579E6FE9BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-7-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: a62a2395-18e7-400e-5ece-08ddae780077
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdD28TfrOh58RwcwoMjS8byQg3NpIPFwIeRQQRlzgYmMCuUq6qRvk+vwAbQSMwKRox1YH2OkytNqp/MhOgr+AXIwQaHekjv9UFkNbWVwwd5XMOHyoYqoHvFEEWHXcKZOGU6m+PegQHwNL9umkPGg82opeFDVsH+WWUTHwi4teCMIRzZ/d5MJpRbg63KYvOYJO8XrhocWJay1uV6V0h969zWoJ1Cdg7NarbccK4Zi5bZ4A6QCFTLfG/TscxPRNRmfaStmeKk4qi9CdbNiq1YSyTdCEumSAH2m84MaPVCYVkI0YbIW0Echkanhh9eCi7OlNXWl1QNTqMDlBo/h3j2e4EFbChVb8e5JC1Olz9Va/w5yU+hy8CoTsmpLloSMhmS8j5myz9DWm4IcOGG5mg2ePMyIYChGPCOSk4NTc2AFwAESQymOT5WoztigEnn4KpnBoNm0wmG4norjnGr+w28eWg9BnUDnH2nBKfCYGJjuzdQNkU40KGjlX6rUC6Zeh9KYdSrPOcRCOlRLMmuo9fbOF3SA2kX0+jOFQ+ihhq+dEoAQ8DyPfo2xqpyBCm74nomP9V1SRHzMcXRVPETULsmXdTq2des9gZaPgGrnY7VtldoW2ClUB6Qdsv+UmRacxlltpmEa8LlLeGk3vV9Z6TlPea85C7uGYAShhBXke4kF61/NDODQBeqpdS7pIP5Pm9xJxebWmA4MXL9Yt/c2+Lm3XFfSfsIRT2npKslVhKRe7Y9K0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wbs8gEMLjB6g/lnso6KxfyjoqxRDxv5m81WU38Vpu+HTEnVPk7F4kzt0Xiv4?=
 =?us-ascii?Q?ac3OISIboCNUafOWyJn+UDUIR1BjYVsKtEIaw2OIC0Eu2jW6TMR3Zsp9u2s5?=
 =?us-ascii?Q?OYsm0TIO511D+QcLF//6I0v9tPvbZdTXsNH8lIDTjlGt6XnPjdYTLzyyfRwv?=
 =?us-ascii?Q?A+3Uao6WviGHWDDw+yPvTd+EAPOcDf0C1FW3c9iCXLZmbG7frbt7TOqVBRWr?=
 =?us-ascii?Q?SHBKtWZ0QJJIwLmksH9NfYrxjcSMhgHUAZoxJgh+e8h5G+khKQjEg9McUfyu?=
 =?us-ascii?Q?4pahQorg7AoTV67f+sfNbQ86U7rmsElrtjvHtAUeIscJdsTyyOopG5rotaSH?=
 =?us-ascii?Q?aQ9v01jbUIZRTvXxNAEKrWcjUsurstUwd6wHr6XMZd0Xy5Uz/3V8oRyneM+q?=
 =?us-ascii?Q?sBcm+q+yQuuW2oVerZ888ZkA2QG8BqQAZzO4GgAea+U19X/iYYKa0pyLgLvt?=
 =?us-ascii?Q?Nh9h7wk1MU+5yd6v6yRQ1y9/JYoqVOoFAzdgzqMh0c8D83I2stNYNsU4FWqw?=
 =?us-ascii?Q?KvLduwpdXjaJzcPdUlxi78QTequ8qvfWbrFscD9R+kzmP1f8x5BwKJmBakg1?=
 =?us-ascii?Q?qoFDlaO9Cx9/Nzq9a7dDhVPyZmhYMewOTHfoHxDFiZZ2u/0G9sIFM5TlVeVv?=
 =?us-ascii?Q?/SoGzMcgy4z2rZSteSorThUfHPpgA0vf3J3IrKRpCjzeKPIoiNpNuh1SW+v5?=
 =?us-ascii?Q?Mxw4XZYxW/EvE5uofIp1Spn/ruoRTvKZI64S1pSYEsCvzbyF+XQIBkm5ym1G?=
 =?us-ascii?Q?9VywmCj2eFgXw9NkZOmUNa0Bdi/dDg3g1/nOTwyWlEIqGmFQeUY3eEfHfFlG?=
 =?us-ascii?Q?5foLw/SMA/apb9JX+CiANMcd7TAtLCmCTrQEjacbwSk+B/osrU7ftsy20NYA?=
 =?us-ascii?Q?Ws7fGaRmsjXdovEbWkRmvuIS3P/2hAPqG5ALJXUvpjLLrPnovCHnempT7dlt?=
 =?us-ascii?Q?JQwPWJXFRDuJc4gHp+IHpza/ZM622E+JJJtCp3fKz1erdtVXxf/6uaSE/5KZ?=
 =?us-ascii?Q?d9oMC7caDzOjgFGz9LPOr3l6jDBPNElvbPzaMJdGOAowLSxbBKUDJbHan/eL?=
 =?us-ascii?Q?QKQyzpw7C7mAP/91/R/KLTtKB319e553aOYdKAVpsSjo0BWTIF73uNwMa68B?=
 =?us-ascii?Q?yqgnxJGsqcsjOmRPOmPwMKWS1FTNieDtsNUBl6gnoPv1twMQrvMVtnFie9Is?=
 =?us-ascii?Q?0RALtBrGdpNKsWD0SASqz9hK8epCuQx7OdAkIQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ThcKnua6LCccs3il4zscfIiRGycAd5VJGhG1GRcatcWu0uk1J6tcuQQjmmir?=
 =?us-ascii?Q?UOJO0Kmf/Y6vw0hpPw59D9Ub1HwJSzCd6f6CdSJ66aePVT3DFuevtFjFvliM?=
 =?us-ascii?Q?/Xgl9s/MSKbcPd/CnzGDaM4kTQuHNP7we8UX0T96DPwhfFE1xe7emhuoJZXq?=
 =?us-ascii?Q?5iFbBR9k89yw8M2yxVXR3LaktCBYuLfRIcJFYFcc7mgrXyDmBElqrT3hiHcd?=
 =?us-ascii?Q?gtHt/dtj3GDmIcmcrUwGMCm3uM759Koemq2n8+IoxQfJaKfwA0YYM+QVlNQF?=
 =?us-ascii?Q?02cSznLIhD6AMol/M2vf5vEdcCzYVr8jluz9mRTsVY5UBUzxir2Y2CTXC7N/?=
 =?us-ascii?Q?IJlAt88UEkKV2N9fGXu5N5k74lV/885olu3kcw/xMltXBuWNBBEUkBNraIzE?=
 =?us-ascii?Q?u4Db/OMn6bXd/X6MOzQAy2LTivZuuTvb+fNXNMu4kU1g/f8m2N9Mc8xj4i9A?=
 =?us-ascii?Q?quwOxP3xuaBxNGXD2tv2WcmlGEOyZ58eLRmYUlVxEbtGuO+GAUVmt1cMuwbU?=
 =?us-ascii?Q?qaATyN/g4m5H7Nb47Vmekx0MSGbu9xCngaF0BvhVQnYISz6bh6SRoF4vRRJq?=
 =?us-ascii?Q?JS7X495MEN6kgiZtRv7/KLeD/2gl8XkZsT2JsK6yN6ESIntR0BTb3hM/cAb6?=
 =?us-ascii?Q?azdFAPel5k4IRFe3cMjwMN+oIk/5FPAxo2AwmsnoVNFt6Ye3zF1HtzD8JFrV?=
 =?us-ascii?Q?b5wDXUW9Fii/qwKb6si/7Dv7nNJJ1dR+SE0cthbphvRaSnAo+XgBSgpci0At?=
 =?us-ascii?Q?0Nj30tsAoAN6l8N2sOMRpo/3aLbr3XZ/I5gWmiIXGBPyFDVhOyuv6KOvkEdt?=
 =?us-ascii?Q?X0JIAIy5c2I2esr4lmVTQCfRBgHbvfclf6e/KoJEzQc7oPCa9UnklAXWbxhM?=
 =?us-ascii?Q?iImYuleQN/xPUVf49DDMwCCADG5XbmpkBL9jiyxP2RqxYc1F7R815IsGx9fS?=
 =?us-ascii?Q?iyz8XbH8FxkJlubd1uls8we5iB0/SG+AdSl+d7cqCfIBVaOUO7EIvOyJOUUR?=
 =?us-ascii?Q?liyFz5tLhQFEyXVJzRFsUY+1gNXSxmCp2hjapdIPEGXm1zJsl/iWVzNkevrw?=
 =?us-ascii?Q?kQpRYx39PlsQrL8tjM5AvYxjPqNxd6yRbD7AYM9rELNvE71Syk0B2umHW/j3?=
 =?us-ascii?Q?bxaM3/tbTH7g9qpqyubeVaXA4obPzbKOaL6SPW9s1yibY2hpGrOOXm2JWtDp?=
 =?us-ascii?Q?luU8JSLCzpawyMZqV3k6W5rhPL61FBIuTy+uf+O3wcr9WE+OXf2+VVLjVJA3?=
 =?us-ascii?Q?RDfG0+g6Tvc1cB0qeYjg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62a2395-18e7-400e-5ece-08ddae780077
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:18.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes build warning:

arch/mips/pci/pci-lantiq.c:239:12: error: no previous prototype for 'pcibios_init' [-Werror=missing-prototypes]
  239 | int __init pcibios_init(void)
      |            ^~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/pci/pci-lantiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 68a8cefed..0e85839b8 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -234,7 +234,7 @@ static struct platform_driver ltq_pci_driver = {
 	},
 };
 
-int __init pcibios_init(void)
+static int __init pcibios_init(void)
 {
 	int ret = platform_driver_register(&ltq_pci_driver);
 	if (ret)
-- 
2.50.0



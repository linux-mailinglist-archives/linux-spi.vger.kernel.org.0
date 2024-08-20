Return-Path: <linux-spi+bounces-4249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEB958579
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 13:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF02283360
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2918DF87;
	Tue, 20 Aug 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l/dVodeZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22218DF79;
	Tue, 20 Aug 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152382; cv=fail; b=keBNGH1YAJDouMN2xZ4kXUewMFFl6R4XIYNGEP+Mqqa8KW08eIBY8+4vQ1vFpxkPH3kiDl763AEVFbOKWFbX6JjvBD+4cHQYF1+bIxaEKDLdqHbEt7NPcjRCz/cCL6eMX9MBbDahbAVlxEK6X1A85kxVW9vVPu0AApGfmvLlmSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152382; c=relaxed/simple;
	bh=zBJ9ZQyhlaCUzx17D1W64udqD+M6KHzxxOrhwK8YPk4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BpZ+PZsQjIO8WqHTC7YrpjDeKlBxmPdhtHw9yeiHyaolGQvuPBadXwYoVXbc02dMPVOE6MJz/aSCDmoUBeUyJp17OIVTKESFN+ZiGYNF+4s35f38LhTOHd8dDnhci6XRn5KwqIbd1EuD1+VLOUl/husZAn7TR92jSxtzqW/5HGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l/dVodeZ; arc=fail smtp.client-ip=40.107.255.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDXOGxybSHBG/XILFWZd0f+W5kzbbNuIImGHgS1rU5RtypUI/n+Rtch8tzsGVqY2KDTy1ukcQQXrJMpU68+oQ89KK6Ez3KPMtNoj4HZpeZOW7szP/aGoh+/9WaaShp3nqO8Zv1gYPI9vxmfkZ2q5rwe6ipkE0gkvTh7PGYPpBxm9qvNKvXgiDQWt3vLuRH5P1sMf/bzDUD+KBYULJLFMEa3AGD5OrRdqthnCkRIKLfS2cuoGqD+TnxLUMCTIjuUkm1I5EXPBioQLyjkUz3uVj3/FIezHF8yjxhXG/akyKMgi4ADjWlaSzftNW8GoSz2NmdvtCI3f6vhCzIvbUL+L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHqA4Hcv9Gvz4eSmGP85c22fgInDRP3iHFmpIfMoO0A=;
 b=cURZikTxcrkZo6ZlLHKo1vu2wMFEH6mdSSSpySfqKOuRwkrrKChMPGUq0/fBtffB6P9htIAVZnpY/cT6srElvjNSnrFQxbOAdzm0t8YQTgPCIK7F0u4R93erPwajvLNqhT0mykNIL8QQptRa3Yot4AfewGLOJ5SYxJOjbzUBcNEB2SenaXV1zxxHEEcQUg6EUtPkv42/q3E9hN0HtHdY0VCcRTPxpP6fat0mYuOwpJHJ0KncLeLc/nt21adyJI4K0WlCWEe5tFqz1aem44XzOT6/JjIK0spumCmHc0vwMIRrYMWMwMiouLRFOpMajz/H4BJ5tpBCnCByNm7Ua05A3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHqA4Hcv9Gvz4eSmGP85c22fgInDRP3iHFmpIfMoO0A=;
 b=l/dVodeZl5ewWsj6aKbphLYaFEYGbbbMme1TCrwxZ2tUbd+oeDR6B/k/1aWFhkLcl159uppvuwe0VwtOe0/gXizlqPeeA0TEluls8TXkw0Gygo+9Lj4nrCHZGArgOusjeu2lbOmNsNBuZq0+uR5JGSV4wEHTbcUBs+N90TFk11gmU7U1ko06t4GwiDGNKx4FDd2J0DK6UNJlLMFdM5MnmhW7Ge8RUNRc6OOizak1h8toOjpaH61hZakKtGi+G8oldlAtIbDf58fbLjy01KYc4wTHLSpZS0JV+yNwjMl8JJk/N1BFTs/pPXYT4fDfJnYamd895/ZyDeooy9A0JsCTew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by KL1PR06MB6669.apcprd06.prod.outlook.com (2603:1096:820:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 11:12:57 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 11:12:56 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:spi:Insert the missing pci_dev_put()before return
Date: Tue, 20 Aug 2024 07:12:35 -0400
Message-Id: <20240820111236.550379-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::7) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|KL1PR06MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 630d58e6-e177-45d8-6c57-08dcc1090adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|81742002|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y5rsQnPA4xl8X3S7kM+sGtVIhc64CITb0IsQSkE/mTeNaQf1tZgdDeq5YWFq?=
 =?us-ascii?Q?w6q+71G7XOSnr9MwGz+OfmnzNleAqu3Ma+Gb7hjJdL9yzVqJBVvhttpA86nM?=
 =?us-ascii?Q?uhXfwwzeDj2oiMXSLIAmqycpWAdE/Ek8CyGzjEZqTVg076v7PZdx0WYucAt9?=
 =?us-ascii?Q?AOC/SQxhsBteeddgXPCRdo+Fz4KD4Clo7+Pawo3pL3l5J4A7ZB6Tg+bg3wgi?=
 =?us-ascii?Q?P4IPOdu50tsmPXlgu3pszfSrkOu1/HXSBWDrTI0biJ/WH5/1AJhbTjNOJlXO?=
 =?us-ascii?Q?PMUOhuA1VphwoJAdPO5QtHjYa/0GyWpVX6QOZBPU2+yDHk414qzf1fdBp0oO?=
 =?us-ascii?Q?J9MXy9+OV4u8VQaSNpc9tYk0K9cZGkfGAe5tugMIDZVZ/kjA+YXcp4HU2IIB?=
 =?us-ascii?Q?kpL0IVz6b8jPXrBfxBGuoPHJyf48lHp+PqDu8VYP81Q8zT5qd7wa0qoDc48e?=
 =?us-ascii?Q?aVPVSp8CBDRQhMDy2KSiC+V+bY5IUzwrg2h3jsbniTRaZw//WHNKAghwJd89?=
 =?us-ascii?Q?hh6OFcl3qXr0nobCR1GkFU5T51S1kKksgw302jIf14uSVg1ltO23Vp0b/RUj?=
 =?us-ascii?Q?peuE9vyw/L8e1IEW9V8oKx3e8BXMhV22XZXv5C2hxUD65t6fiJYklXoxlS7c?=
 =?us-ascii?Q?BmFJQeBc93WH2MxxK21qzYxQblk3nYRXGiNFMYDVyoR7sYWGirtq+TvQ06z9?=
 =?us-ascii?Q?uzb7VvrhLYkXDOHGC1qRxS3aJxvTSUEEAsASngdUKfNwwVtPxn0qkRPyzCT+?=
 =?us-ascii?Q?GPVwdsEzvyod4VJwBECR929Q1/wGLtHEzeUO0P09cmvBDw2KkUKbzuMXVdxp?=
 =?us-ascii?Q?PGRGyKbDvlOFQ4RkZZ6h2u8A7RDXbgZ7T7yH31XDsV5VTr0zzWNTmf3XGfz+?=
 =?us-ascii?Q?+C/jCUbkS7sNiCq1bmRNkZN9vshFZu1/jLuR0EpFD5R0MeCABtDXw2kvzAic?=
 =?us-ascii?Q?d+z8nq81X+wDsZ2UpvwaGyIwFT73C7s+Gya/whi5WIEveREQuJCTFuy6a1/t?=
 =?us-ascii?Q?F8c9gxrOlPyxlsqMPw/86XNXmGKQ/J4sJN7CN9Frk5ASfkTC9B0RhU1tlyZY?=
 =?us-ascii?Q?AkSUI+jQlEgKMwzvhPQVnkKhciwLXd39plU7H75P5NzOtTtBmYtfIpxvvtuU?=
 =?us-ascii?Q?uwmafP8fwcQEqkSni4mIRtTlP68Q7shd0qvBiflsyilc9BTkxwiizETfBAxv?=
 =?us-ascii?Q?P/r8zgj3AJ5bGOQiM7RaFVAJ3fuL6At5cdS2grKOCpCsWlhNTn+78lI5TovJ?=
 =?us-ascii?Q?uTHkdezaaoY0su0Lwn3zPP1syuDiYBJTghkHh6DvlEsKIcA2EZmNLJIzNCIA?=
 =?us-ascii?Q?9zUz00mbd6vYsLrDFBImS1V6sHOTRCKHZo7GGt7APlqUkMgf0hioaRc5m0Mt?=
 =?us-ascii?Q?VWC9dx71d7fTIG3bXCBJR9lkg4tkFMBYr4kZYOQmtsQotKSewHY/W0iniQuj?=
 =?us-ascii?Q?DrvE2mvOKKFTAY4RzvtA2ATvk1OnXclhYLwSZEhO3oqvdvavH60FYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(81742002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wLWnvwzxWYvb3eKTJXXvoH4ye+9//P/7ZDTdoSH9gN8mzrF/quvEq3XtRW1J?=
 =?us-ascii?Q?tokY89ukAbcxqrCLnaN5aknFrrXEFsDO4rQdi+KiSVFBHiAGtPvjYV2izaAB?=
 =?us-ascii?Q?nJOxvykIxXR8vecbTODNvNSxbTOKPpmurXjpxa2Idw5KdceiGodlAK2WuXuv?=
 =?us-ascii?Q?zoJaDP85QCcG9DgMxR8gRk06frCrgifUOi5B3hB5QgfRDyX9n4SvcWe9evKc?=
 =?us-ascii?Q?u7xLgovkLjAvuhUMP5qrpWs8EzWjXArPzcUeydkkKFvu2p5RfeFAlEwAJuU3?=
 =?us-ascii?Q?upbPPjcmv/mvFl1ZrmrkiJLgX5Q4DzGOxSNw9y16Tbo2VFUyhsNMJ0ykV5Rb?=
 =?us-ascii?Q?xNU7zTrwxaktkjlTD4xZl9jeQ6C0z5NMzexI7v8ml9RPLbHmyxvW6TA71W2U?=
 =?us-ascii?Q?dsHN3dqrV2pi8Cptmp9paIZFSM1QrnQDzSLwyz3cDQokQ3c0IO/ru1yLI8aQ?=
 =?us-ascii?Q?hDOBAZ9mGN1z149etou7+lHhiZv7LaQs6prKBXMFxrOZ7lGVcYb4dI5Pdc39?=
 =?us-ascii?Q?Liix81sEp9oK1j0HUGJv9YYOJ02+jG+jfjqQl4K754ruSiYy2asoPS41VZo4?=
 =?us-ascii?Q?v11zi2FEFpQ+IEVbMG/nrki/GZI5UYCMsDENT1ToGF1HRii92R7QTpGAAjDo?=
 =?us-ascii?Q?FvrdMb0KXT0806YOU6QhELzeZFz/V2AQw0/ZW9YOM4igufQyygHg16krwTN9?=
 =?us-ascii?Q?+Evrp1N7p3nGb6lh+jxFuG3wrPA/ESI4kID2AO1YZJzg1oQTTKIgmyXRZDoW?=
 =?us-ascii?Q?8L1rvV2D75kMmimRNyk9DblmaqCB4U0w0mlOMGGDPdcjSO4XurzrQrIdHS6G?=
 =?us-ascii?Q?x0hRsd8zz5SAqjIUCNWgYlr1vH3D8uagDC6cJMbAQctpnshWcxLpzb6/YXZ0?=
 =?us-ascii?Q?cZU6ueGx77sYKsDfPSo3U9cevmjt0x/KaNWbc5optY9AP4/SZ8PB4/iwsjhs?=
 =?us-ascii?Q?cyxCfELGmf6071ZdDOIStoa/Ppnl5osxxEBMS3ai2bCWe90mZWux59mKaMjZ?=
 =?us-ascii?Q?xaPnLB1Jl10vU5h0MMsiYPnch8dUVRr+DCY04Nq8v79wgXIQonODXLgKPbwT?=
 =?us-ascii?Q?nOC5LXT/l/PUnbNFTEI1ooaNu+Lq166uJhoC2U7eVlVfX6ooAW42JRsgvqTP?=
 =?us-ascii?Q?bM+rszZlbCArysghq2vh0J/IRS0sZysLL5UcwBH3l0OpI7xto+wOECs4UXhY?=
 =?us-ascii?Q?m5enrb5or/bZZQUZFaGOa3fRisXH6QqGQXaETyw4LAXHwx2R0GdXwAkXNLax?=
 =?us-ascii?Q?UnmE1LDJjIdsrqsVZuRQHr9gBGKtktazMnoqo6yIv4msQ8FtEr/tj+HGRZqx?=
 =?us-ascii?Q?nis8fUSsRjh91EHNjgER5l/BYTtXH7tidz75U7ScoOyV383/weY3l1uc9K9G?=
 =?us-ascii?Q?+pPhW9ZKwHftfWOis0bGn7EXtrhgw3wb19A0mzRNyjJiIZAhwQhwyfnBv++2?=
 =?us-ascii?Q?Yr1G08wr+JMhSIEJQCBWJXnX2dFvrAX3YerHEJfO2sAcm387xOHPl9am5raj?=
 =?us-ascii?Q?2pVFyYUqkQjgIsKPNpjkN1vUD8ayhjO6UT9Hd6LCMGxcf4YpfcmvyJd9q85y?=
 =?us-ascii?Q?sJRFwoXSOjZVhdzmm/jBecjQabfDBMk8MIscsPSB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630d58e6-e177-45d8-6c57-08dcc1090adf
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 11:12:56.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtQG/XE/xQNJ4qMpFgfz1BLFp65F4WnnJF2lUxXGfwKmpmUnQjP7kBAU7jGEY8T6ZiC5WY8FjZgkPZdBsZdpvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6669

Increase the reference count by calling pci_get_slot(), and remember to 
decrement the reference count by calling pci_dev_put().

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 72bccb3b5..d49d8fef4 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -145,7 +145,7 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	c->num_chipselect = 1;
 
 	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 50000000);
-	if (ret)
+	if (ret) {
+		pci_dev_put(dma_dev);
 		return ret;
+	}
@@ -223,7 +223,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	}
 
 	ret = pxa2xx_spi_pci_clk_register(dev, ssp, 25000000);
-	if (ret)
+	if (ret) {
+		pci_dev_put(dma_dev);
 		return ret;
+	}
-- 
2.34.1



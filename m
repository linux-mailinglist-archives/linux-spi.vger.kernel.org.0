Return-Path: <linux-spi+bounces-8889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A89AEDA61
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E209165909
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0DF218ADD;
	Mon, 30 Jun 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wEJjBpeN"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C538DD8;
	Mon, 30 Jun 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281245; cv=fail; b=h6xUi/Hp3wbht0AQ2SVlJaCzA5dP2llgcepagMeVycRRknuQhGKxqUmeYuhV8SYkE6MWuB/29DMHtQLl82E9YSUUXAWN2ZC7qNf+xVy8LAdLVm6d7q0FlphU8a5m87QUZASEZshesM78ZcCJYBA4P3mG//hLj5ZqWPdL3DtKLxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281245; c=relaxed/simple;
	bh=ogZtEVrSjvmF/dvzNf4qhrPmDLXz9X7sLBPmRlRE+1g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mizzbMBb6pTz07UOPmJsDKeiwPAlAfUgLzJr8fPn0qQYc2MEJ2kvvLlz3tYLs+i/TGyvIVmSCjA7gG9eiN1KnTZcENBMtsKuInSiDZYoRAWJwVQ+9Te0n7ojrWjwLpVYKgcs3Ot9nCIhUYyTvVt+XjNdSJ9DViFBHfO3SGqgBZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wEJjBpeN; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRteHDJ3FfBpXpCNbOmFz1/FJzSFhKiUQzQ203lDQtfnTS+rjFQRZcL0r7eM+6Rrsxr/GZRq6PrXFToWqbcoEirVxN6oM0+hfhPKb2H7eCgeqvXA0RgCkcIDZ53c7tuWfTGNHVj2G2RLp1HJpVJWoKae9ib8+6s5HBoGUX0hM9/Tq9qUkEbjGQJvcBMvvRZN8yxI/6NKMFm9IbaejnpR8EsOTxCn27GZH0k4uw9Zpvy1GS+CLN2natx+Fq5053z6eez9q4NHoOsZXSQANZl0xv9UC9I4GUIbqIp1mmyDQ/cOYfbE70WNCDhPei1T5/xXxsibrsq1S2AYX/NAO7pO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSBIdXxpVUj9IzADDEoORrARinMD/dptnSl6iywuM/k=;
 b=NHMzbsrMxvi4wqNkI07mYtRy/bTlpbx0y+lUKtCCDzvG9WTEtCcUALoy2/DcL8Vmyy71v9KOdQ28RpIm8uT6WYZRPpjjUKz5dBTtGdWDETfOx3fISTzm//HLKkKOfaxyS11VYkosOwKFIKoOzgAfbcVyxZdc1wAv8B1G4jZLkB3Qrcc7fPT9YyXuW9BHAlo8uhLSo2ZJGMZJuPr5shZX3nx6XFvpVMd4AD7yCo3JOZ2xKLUlK+8SMKTGImLB1P4J29JAh+nbaOcW71DsyxBXk4duLvcKFPUhszpyaF/znVkl2QUwvE//fmI1FejrN/iIMyHuulCqcoOmQX71+XWOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSBIdXxpVUj9IzADDEoORrARinMD/dptnSl6iywuM/k=;
 b=wEJjBpeNwO5OyFjCSlYmA7CryL1u19F1j38VAJsEx8mYCft8/Ywgy5j0lnPnZSg5fzVsGuj7M1TXoz6XOd5plTGonjZWxcqcI8dz3rTE97o4zcQR1AnBkgNmf/gpk8XTXd3txiQB5LStvIkKoDQpDr3tZ8Df9gcwW+F78TGiFM46c83Y8ARl8KxxwNr6AOpHqk2N6iOH0+Aq9h31iGJNEdhsez9RL5AXy6DuXHwwCA85bmQyPYNwf81Nr/A2qGywzCb6HtVWsWJXBud+7eH5XdHAOFEkYNRhUVLuyg5JA7T0Da+eXLiB0F7NoPaONPXvwbm1Pjw0y0l9pZrrn5lprA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by SA1PR03MB7100.namprd03.prod.outlook.com (2603:10b6:806:339::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 11:00:40 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 11:00:40 +0000
From: khairul.anuar.romli@altera.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Santhosh Kumar K <s-k6@ti.com>
Subject: [PATCH v2 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on failure paths
Date: Mon, 30 Jun 2025 19:00:35 +0800
Message-Id: <55fd5496924ef8a9046bd2758d0111be6bc8ff8a.1751280932.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1751280932.git.khairul.anuar.romli@altera.com>
References: <cover.1751280932.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To DM6PR03MB5017.namprd03.prod.outlook.com
 (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|SA1PR03MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: a601f618-1f0e-47e8-b25b-08ddb7c5599e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y496LF3v0QlPeLKPtSw7jiMm5Tc37n+WoTkkTcQmS24/IZAN0cbeg167Ocd0?=
 =?us-ascii?Q?/sCF2QHDEpeXa1ieDbKSwRAJpNgxxX33QxIMiV+thsQfj30fX0uL7kBk0wKI?=
 =?us-ascii?Q?vOH+JwVcPRs0IkWKZgY3q7Q9c3Cm4xWVexTyYqic1qSJsieSOJOGxgmn2CVQ?=
 =?us-ascii?Q?bfwDPMfXao4+3Hvz8cW0tMGZ8Ll4hC1GfEbYxurraoXFGj1bYISryZ2lWeyc?=
 =?us-ascii?Q?aWKrno2MW/mkZl7zd503iNslGppxyygj/qhiXjoLhU0QbEVvof6VEtlex7gK?=
 =?us-ascii?Q?TI0TwAp2qDi8xC8VgEXNbuFdp7pEyxQFT7j4CoDJrfr73/A3Wc7llAF2eVlq?=
 =?us-ascii?Q?fINsbB56umbKDZ7Q0no9v6o0kF0TNmNKAz32yhG8yjP2WGmgDFtdTSNiKFn4?=
 =?us-ascii?Q?FWhAp/DnN8w4BTZyekZJY5SnR1A6MmV439vh+AZDIDgNZOLWqWBcbC5SWKLU?=
 =?us-ascii?Q?svKdTEgZtWByEFGSvoPAYLIIwSwZcZw1rMorQJgoH6Rr65f0l7lorMZTPgFO?=
 =?us-ascii?Q?SCSnmGPm9lL3Kp4bQ/YzBjS172ZMGtW1dXR0rWpxGKBaQR9PE763tOyFph/C?=
 =?us-ascii?Q?mvs+ES+HJ5VOO5dLKmWGy8UxKUusAf+FoBSA+qLPEFuQjHCKmtPX7ZLPPPXc?=
 =?us-ascii?Q?z2VhgUihbgwKPEijSpihYI1q7u7c30B188fVdxgVDD3Krs42xzeqAvasiJ5p?=
 =?us-ascii?Q?bRPwh/q8BEEg7Mriz152qdwEdDAUfRO8G24CbtprL4bYkgkYCxPuDUvmU4x1?=
 =?us-ascii?Q?EUWh8fFfETwcFKYha/I0h6KWhhH8sH46j3NJEce18gHjtRm2jOqm1Oq7Nixn?=
 =?us-ascii?Q?uGw7Sf4jBTbSToyojiaOkhT1HLhGeVHpgYCGYx7rJxA9EkuMbumnz+XhFztg?=
 =?us-ascii?Q?SFpFGoUwuFHwc88FVjvdGwZyg4mQmmElJWIHa1oqJwj2yQ8+JwZnUTDrSNyQ?=
 =?us-ascii?Q?WkN3Dc0RZl3cI4AH34PuL6KVnqRe3wfQCBccXFspKwMjyle79uo+466lJMeM?=
 =?us-ascii?Q?Bu7N79NGeQQoa1iNqsVSzsmOLEpFamJOrOJ/7d1MERh4E27NmgEaC+kUyv4w?=
 =?us-ascii?Q?CnqhCI7+ctrbUlOBVmnsldPA9N9PvdN+CI+aFbo40vVXkAPdMynK0Zj/wM97?=
 =?us-ascii?Q?P4M32hkxD0RdVxV4d/YMX4GViQ+yoYC0hnzxUyOqtpsNvxq173Gd/sCV9s4i?=
 =?us-ascii?Q?0CqVrvFhygEE5LToPw/vKmMx4Ga/tgQ/RGVz5vJRs1fOxM8LiaD+9S8Tk6J8?=
 =?us-ascii?Q?QiJ7ZKdrxDN4iLrskG/VsX0BL70h0kOui6tv84g2SUYX93bSPBUw0k/3J+bs?=
 =?us-ascii?Q?Shxv0fLylbSk9+Zj5wI0IF2R5OWufiLfp2hAC3K/BrYD1mheeQHBp8pA4Lsz?=
 =?us-ascii?Q?TmZaWiJREvXBAxCbQPImUN8O4KMlOTZ81rVQx9CiBkkFglkI7w1FZYESWyrr?=
 =?us-ascii?Q?TAdjQeDoy0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/R3pPj8VLWzcWa0c6qk05/djwTsjZSEbrk3/FJ0JodDtW+2Zchx7/0xYoOdr?=
 =?us-ascii?Q?tkn6loRzGeZd/EaRwh8U4gku9jzhDRJGNTZZcsSL1kqBIMYC8sfSJtlG5GvD?=
 =?us-ascii?Q?xVzfjMx/hHOS3fZDrGmN9yy9eY0fCCq5/ID1l3/yDtSK8ei1nC6lk0DSI5sv?=
 =?us-ascii?Q?JbMuvrAdtbFji4N0Homo794R8SWZot6VwEasqNXF53WFDTznp6JGLi0Sf6R/?=
 =?us-ascii?Q?0UHJRHEFDiZmosD7L6TMoF3dRTpC5rlKmzutLsltQGsnhE+pb+XXENXjluq3?=
 =?us-ascii?Q?s4vyeTvNfFLqb0HrI2IQAaZyPGJ/mANxSr1RuEm3otKJzOrSjMKIrIqGAzS7?=
 =?us-ascii?Q?x2i2k1Ff8q+bXfQf5HpcUMWCVpPnztItJL3MWeaJPwu2IT1tmhtrWe/IFMy1?=
 =?us-ascii?Q?STMiwzpfiQa6tXjhCcmxSBrVr9bVEIFuDwW410AeWgDkBB4sqXKFA3sgu/8I?=
 =?us-ascii?Q?zV5+FuatsUps7jmOCnF09awrua5WiQG1ij+qAhZnMsKxP+VRy8M8b8z+0buN?=
 =?us-ascii?Q?iDgEoRkjeZM9HgWdZR9w9cpj3q4jW1xagBSbMr44Mpn15X/zr5BUOFDjdFa2?=
 =?us-ascii?Q?4+7n8y+DQ9Ge3LUOeEWjEfYBkby50w/jVyw5vjIvG29PfRuOpyO5GG/eisNO?=
 =?us-ascii?Q?vqIBBhKVQDvl0oBegoKs05LZ6MVranFb0yIa0cWSNIQQei0D0S9QbUdZhtiC?=
 =?us-ascii?Q?hiBhhMj+UCtTKhj36gA2UCDeUzi4JiLPpLLePVTNyuHqNCVLIRjTHQ7vWGXR?=
 =?us-ascii?Q?ZfSrDtN1O5pf25C+zPDUkibMCemeFGr48LDjq6fUZ2aU1Ny+Z00sm9JDAuhQ?=
 =?us-ascii?Q?Ynr9uj1Ns+rdDlWCgcrEOrfM9EeZ4hpd4WjND/aORXS50wORRX9VF/Z6uwK2?=
 =?us-ascii?Q?6MT6OMH2CuIixCpDcngAIYlTLyiwiZneAIhQ6YnlCPFMu+nCkuiMJlzg6MJr?=
 =?us-ascii?Q?88txyaNnTC2zRXyygy9DYK82UBJLuWfqR8oWEHyNZ2OJII+vHzW16r3hFg5o?=
 =?us-ascii?Q?pM58X518v9VgsRmScTpgJtMH9/jO4uSLs+dUFdAyDCOtdZujHOp5Auq5oW0G?=
 =?us-ascii?Q?pDKQJFZ3OCxMFOfu032CL8riPYMEabnn8yOhplVrKXnahSrzWBu2UcBuDfHf?=
 =?us-ascii?Q?mfDI6y52HBJcIVY0tN2RPNOhUpim/gkQ8B0FHAxEDoIG5DHo2AaKtI19UEW4?=
 =?us-ascii?Q?sPNsJzqPoN2cB+tV2QjXLYuVIur4PrGHCuEl6/7Fs19QbaWek04e2/RGLq1W?=
 =?us-ascii?Q?nCQm5d7FTqibUtoNFM+ExuNtKt3Uijt2+8QKcD4Ic3mDSzCZDNNWA7UD2ejr?=
 =?us-ascii?Q?kKPuL9hnwCekYJss/ow0LsSOoWz7lygnlefRYRLS9eVU69QmGgQiNdf/a5f6?=
 =?us-ascii?Q?T1PsrjS0Tc53tNJOUGPjPm+WnVV2ezBj9If2d609Sx0aek/HtR2j3D9WJipf?=
 =?us-ascii?Q?BbO/5bgnyfAmtuIynkfNxvymwJe84VxaBwXrBmPU1b8Erm7y0PIB5JYtsQZ0?=
 =?us-ascii?Q?hdL9Ps8Jq3yK9wChACqxruS6WAY0Kh4KYdyToLLrxw6TlRL2csrdyqlt1A+f?=
 =?us-ascii?Q?BRlg0840tSt6zuh4XdVEQqEbnhv97aM48a12hWQwop3KW46oS/6HhYEr2k9z?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a601f618-1f0e-47e8-b25b-08ddb7c5599e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:00:39.9646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+qUTAiuy+J93JEaLgdkt6250luZSziiMiIqZyoncpUquuMPrCq0nSj/557cFTaP7+YflObQ4L1SwOjZMPMMFQfpNhizTDwiWInz7RKW5eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7100

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Remove incorrect checks on cqspi->rx_chan that cause driver breakage
during failure cleanup. Ensure proper resource freeing on the success
path when operating in cqspi->use_direct_mode, preventing leaks and
improving stability.

Fixes: b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
    - Add Fixes tag and stable in cc.
---
 drivers/spi/spi-cadence-quadspi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index aa1932ba17cb..d3c78f59b22c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1960,11 +1960,6 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	if (cqspi->rx_chan) {
-		dma_release_channel(cqspi->rx_chan);
-		goto probe_setup_failed;
-	}
-
 	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_get_noresume(dev);
-- 
2.35.3



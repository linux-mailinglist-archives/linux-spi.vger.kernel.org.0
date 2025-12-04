Return-Path: <linux-spi+bounces-11763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D1CA3EFD
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 15:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C56E300B8ED
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B1296159;
	Thu,  4 Dec 2025 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r1kq2exw"
X-Original-To: linux-spi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7D21B192;
	Thu,  4 Dec 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857143; cv=fail; b=WtKsZ9scZ4RTtvCg9xSbkmkwMrK5EHesskldyNmNvWPLyVsbhCWiMLKY4kQdG/mRhregoTJp8jL1OgSNFyC1eklCywSvJzDF3TsNoJ0ycbf6YUqSoTMmSmNOF8W3oUMe/ac1zpYMpk6PwmoorVzhYgXa94+o4tSRuKf6QIGjfdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857143; c=relaxed/simple;
	bh=mknAFXJUxO4z9V4z0QcgG2D1Iii2x5730tGNj+M6qTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alk/MmL6xySNJuXZMKuqRvpkXP7d0+wzquZy16f6bc8CHjQC35UkSGhG6GnuUw1Jir1nuRjyzpoWp0f7RShcF4K5Sgcb3McSnfR9t6y0tucKQyVTUJpStsTAS+ieIQHtSVw8yL0VXSkLdHbUHxqOSsJCfmIojiTGuryylIV/Qt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r1kq2exw; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQarCbHnVqDwWFECdsGwTYnnJ5My3ivryAZTGbYHPdY3ldP+2EXZeRCfXL+dzzLBBDL3YBB27WYplegy38eXHqc2E7qRnhshcJawWuwUiOk512xGPUgoqfiMA4yx7dGpGx8FoJHpuwGSXsip90p4FVQmS33VN6/3oAMOxi4EEm2J1Hrqkeu9gAVavKo32W8YD1AQzopiQ6tQaZKC9t7PKoYLcfs5VWGcWlehO3Jz5ySQ3ufqKemHbEiGrxowogf4ivj2ty0r0EGnpm5ap4belX3lMpDVYN0FAcKZZPE5aK9BC2+mY2a8Bbhp95tSg+UH1TkhZ+HxtHoJS5yatbFenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPtauYgiyj97EuNUQHDhUk0z2Z5S3nyKISZCIPSfc8c=;
 b=W5LGIfsyk9FgrLGUHfp5fc2jj89Wy6omGgVNAmpjgehDzZ1tdFVQBZdCNtwz3qwckzrOBOBFqezeyuoOzFaljpY7zokToryiQzk0rwLkR6RKZVvtztRc9qi4o+WTonm9DPMCi2ZNbdi3FW4qi8eHV3U4SRJPKjOtebvE9vaAM74pt8Y9ll/Mw2FJbKEP5l//NM13zeRmBm1WZtZiWpr2JnPiRwrRZDhSi8oRtOuafsuY1Op6wAdpBCianQ2mIUC40+SWuI61nsa0Pk3YNAQD7pesLpXbMtGv873zEL8pn3OjVQR2k14gNmHRmcH6qYV8p4EMJ4cEpD/sZhgyq3Ljmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPtauYgiyj97EuNUQHDhUk0z2Z5S3nyKISZCIPSfc8c=;
 b=r1kq2exwCvPkr5DcyJoYNxdEY2nHfVNa6veRvulY3itkR1J6da1ECCtJvz4T9qft+9w4QIMrJxznAHCUPLyq0M2MfkG7vfyEWE3izpNqQ9TQuJ6MsaQXpRYB6C1RYRRLkc7s6jgrM7JzEdfFyDJMA7mzpozWtUHGxQXmsTKkCmA=
Received: from SJ0PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:33f::30)
 by MW4PR10MB6396.namprd10.prod.outlook.com (2603:10b6:303:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 14:05:36 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::db) by SJ0PR05CA0055.outlook.office365.com
 (2603:10b6:a03:33f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 14:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 14:05:36 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 08:05:31 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 08:05:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 08:05:30 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B4E5UpO1654681;
	Thu, 4 Dec 2025 08:05:30 -0600
Date: Thu, 4 Dec 2025 08:05:30 -0600
From: Nishanth Menon <nm@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Francesco Dolcini <francesco@dolcini.it>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, Anurag Dutta <a-dutta@ti.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <20251204140530.xax5didvuc7auzcd@problem>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR10MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: c17a7ad8-37f2-4a38-51c4-08de333e32b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpNmFcBQd+Ax0WFG7PnNCSB3S1jOgHNxFQbHQ8tUM8p7cWgx9OtGvS0k8xOd?=
 =?us-ascii?Q?mDqCWufPiOxhe49yOhUpjmUyH2cGxqtFUg742EaOUnfxaMJL+MZKrq1AQAXP?=
 =?us-ascii?Q?mGjohKMzhvNgmV4+wFEmIA/pWTtszipas4R1b8cErSvRS1mBTBfpK7zmBETa?=
 =?us-ascii?Q?ag9lVcuwQVGA7KCXz3ulhXMYJe5GRGNifXOoOj/VVN64U+eJBO/VowHT+jHZ?=
 =?us-ascii?Q?l5hGWTR9iYxfShf5SLL1kRqyX6w/nTB98mMhzXSBOAF1A6f7ka0sUpQW4iKp?=
 =?us-ascii?Q?HCQdQcLzsq6ThhxpFUXuWGUeFkau4oNwiS/h8yijiXdgAUGxuCMeIwfVZhrU?=
 =?us-ascii?Q?Y+2plow1lOFuBb7bAgSgaGARBjxdlIcnkrTvX8Zx1/DYygfzRKwt9uSBPbeG?=
 =?us-ascii?Q?tfKGw5EO+Grk2/vHQB+S9/VNlzxucefa1ZFcpILnJbBM/BfkgihShj3p2dbZ?=
 =?us-ascii?Q?3QcDINLqdE/BRVDcIBJbP2U+sa+QtP6da1vwV1OP6IeoW/qvSms6v2SPeKhj?=
 =?us-ascii?Q?94FOR1JLEImn3EWzX+LHUeP0wjmogpX/JFTIBvzLK4EuPEoj8Psm75c4es5x?=
 =?us-ascii?Q?XLcTwzrCEykOhCvpUIf+c8XCXQV0/w/Jq6KHhbvMu0F/ca7s1olF1dy9p0mW?=
 =?us-ascii?Q?xRx48GiKDMLKSVJ9net0r8DI6YElkQ9z0VO0fTNU0e86iN243DJqX8Aw52px?=
 =?us-ascii?Q?uEAceMsC1kc3Q52upwVeFtdILAknKlD1uAKuSMo3TM4plq6RAbAJJ38x93nd?=
 =?us-ascii?Q?IgJDS5Nb+YfCJY8ytByi9AOcOjmo66WjYURtq+6rTPcj7/o0gl1fT9lkMElA?=
 =?us-ascii?Q?OwSHiBpV5bUe54AmBKxv8Qccvf7drqFkdZ67nbWv3ZCs9qZXBJFqaGi3TIi/?=
 =?us-ascii?Q?ARtcd2XPkrfXiWW36VPC0wTNlsEDrIUidAys9igxelG3TCzELM2HXI09kv0l?=
 =?us-ascii?Q?ca1vi1mj+pNjsruKB0iPPLp/wMyEWADpqhvviFSHDLzDkMQbLuPBvFanJp+8?=
 =?us-ascii?Q?zW3RSnR0Gahl6aSVpZ7pTTuv+Uk5JNJWMJX+nyog9wNes5afRRLZQnOyCNT6?=
 =?us-ascii?Q?+09x+z7Y5aP701u0pPyDhAF/GZqurQZ2+IRWLroQPPIO7MZzUexoZ4OzRZuI?=
 =?us-ascii?Q?UPOEMG78jbBGxe4xJU1wZOEvykKhKjYwYzRpJ7velgTS+53/TSx67TgiA2H3?=
 =?us-ascii?Q?f65lw3KX4AkjURBre4lePGojbOy7OaYj3L4OhKXYAmJz4gnPb/mnVfMkngiR?=
 =?us-ascii?Q?SF+E/q/d+A3fXzv+qqBMjN2hl0CsnveeTZ8KGPiSUr7MQoDbzLu+rb24Wx64?=
 =?us-ascii?Q?RRKJ3j4DNiSOzGfFXF2sQIRMpAdLEepzHKz3kY42Q4vJrQtX4jaoxsPXhFGT?=
 =?us-ascii?Q?h9h6g9gZSsg/n3ru5RudiBCMPplpzfSEFFxy6X3Q53EA6gFplwP55n6C/2gx?=
 =?us-ascii?Q?0EvujH3yiwXMejTEdGVqgebYVm73wOdvaLjKzW93MI/jlEzxK0JInftnjSTz?=
 =?us-ascii?Q?yFE5x+va47ebJfEvvJ7K9XCqCwHgVk6bQ7ll?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:05:36.3638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17a7ad8-37f2-4a38-51c4-08de333e32b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6396

On 13:28-20251204, Mark Brown wrote:
> On Thu, Dec 04, 2025 at 10:13:35AM +0100, Francesco Dolcini wrote:
> 
> > Unless I did some stupid mistake testing the patch, it does not fix the issue.
> > Here the log with v6.18 + this patch
> 
> Yeah, I'm pretty sure it didn't work.  I've managed to find a system
> which instantiates the IP so hopefully I can modify it to trigger the
> issue and test directly rather than working blind, I've also noticed
> that we're getting
> 
> [   15.430306] cadence-qspi 13010000.spi: Runtime PM usage count underflow!
> 
> even in normal operation (on that system anyway) so the runtime PM
> handling is definitely unhappy.

Hit the same issue on J721E platform [1], the following seems to help in
my local testing [2]. I am no expert.. but do see if this makes sense

The clock is already turned off by the runtime-PM suspend callback, so an
extra clk_disable*_unprepare() is only correct when runtime-PM support is
not in use.

[1] https://dashboard.kernelci.org/log-viewer?itemId=ti%3A4db11a5806594ef99c7c2828&org=ti&type=test&url=http%3A%2F%2Ffiles.kernelci.org%2F%2Fti%2Fmainline%2Fmaster%2Fv6.18-763-g4a26e7032d7d5%2Farm64%2Fdefconfig%2Blab-setup%2Bkselftest%2Fgcc-14%2Fbaseline-nfs-boot.nfs-j721e-idk-gw.txt.gz

[2] https://gist.github.com/nmenon/1ebaa7cf18e7df49ab59aaa7eb798a68

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..3678e971d6d9 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2024,7 +2024,9 @@ static int cqspi_probe(struct platform_device *pdev)
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-	clk_disable_unprepare(cqspi->clk);
+	/* Runtime-PM suspend already disables the core clock. */
+	if (ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))
+		clk_disable_unprepare(cqspi->clk);
 probe_clk_failed:
 	return ret;
 }
@@ -2048,9 +2050,11 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		if (pm_runtime_get_sync(&pdev->dev) >= 0)
-			clk_disable(cqspi->clk);
+	if (ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))
+		clk_disable_unprepare(cqspi->clk);
+	else
+		/* Balance the later pm_runtime_put_sync() */
+		pm_runtime_get_sync(&pdev->dev);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.47.0

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


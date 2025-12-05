Return-Path: <linux-spi+bounces-11789-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A2CA7AB4
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D40F31CC0FF
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAFA330B0B;
	Fri,  5 Dec 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lDNzbBOy"
X-Original-To: linux-spi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ACF3090D5;
	Fri,  5 Dec 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939498; cv=fail; b=IciqmQRrVZjhmGhWURxz+KcNZo5A3Y+r39qGOolj/XMWweDoG+dQhkPogMZs+snt3njsqRYu78XD1509yd6txMfnLxKDxHUol/ISY1NFeB2R0LW8+nxM1IDgZL+/RuBwbsDQ7iA4KT/ry3dxgPYmb1+edwijT+vYrzLN5LNDZoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939498; c=relaxed/simple;
	bh=UTFflOkQj56n2nu/vX8+0uiWr4opDbHk35J/xr6J0bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q+eoEINTGvYpSjaMAuM1S/YQbTLRPA3oNKGvW5k8tBPYQiRoLsmOogoLCDTU/sQgv52O/lksI8SyZwhDSh61S+ggByA3OuFXjQa4iJrGh2628Qb2tXPpmpkkUSIBlKZlBcUSzL1b75lX6SOwY5pq+DRkdOmZPO0rCUgvd3AD6gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lDNzbBOy; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRrVRDWNUnyuihPiRDO57tPBFm8/LWE2YdYI+sQYVXEuDwn60xQWXyjMySR1JigJYEmjoGlhwiE09I23+kzLXWz3xxJBWiI3gz00+te7/32Db+df4aov4vwYPImqPSnVzR9gbpOqiU29hzxs4p3CmJXCaVdvra/Jt56FvvWebE3571S6xAMhz39ClFvImaTMaDvV2+S6tt/3mhk4x3AactHO8X5/sgKE7haRuWByw2DwN+KltTSaE9Igtddu8/ecgB2kVFlLGt5YbKyHhpQufg2VQC7GpyF1xBTSe1sts4M9fzwaPSuf7uVP64FagPTmnLWFLzoWmRv4SxTLhDPkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVA3xHrXH7iCeoCkNGGfKybHGF70YkW3AphxhGsARVo=;
 b=GdZO2U/B9Y69XQ2ujwKsdlL7huBlcLxjTtbs6GQD+APvDQUIaDchLHoc+3TiLtZ6Ec+GUDGz/k63r4CeiZqnLG+Tx6HvIpU5guv3a4T/PWPHHbsMMjEICQRSSu6VWAgtbSx4RJFBGsj68ir5spB4oGWFGP34IP3yfGIteRQX3+KIZFkPeZyHuJVFpeXunR1DH7RX7wmJsPGnfthQQHaQGiRScOSLox3Hc6CnuP0RuJuL5RxZEL3g4+I5kfto4/DtvB8XCx4JT7PKxfcG8gdr+e+QIJ6VJ0FYF7+U4EbVNgs51l7ZofIT4ZoqysK56Rdchsz6Z8U/oSWw1FajihIZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVA3xHrXH7iCeoCkNGGfKybHGF70YkW3AphxhGsARVo=;
 b=lDNzbBOyWRTxfqvMiZTGMm2ky8Nip6RCpLHjHvY+gliVvf/0e27fdWz6ZNvYbz1LEGC+i/Up30jqP1ZMfUaw8lCXWWM54Xd+OWxSNRM8O/FC8riqptd2CS9KbI4cMUMAnbMWpjX5aOyDoSgNo+VVMbyI2w0UNvvVPfGH2tdBVmo=
Received: from CH0PR03CA0259.namprd03.prod.outlook.com (2603:10b6:610:e5::24)
 by DS0PR10MB7479.namprd10.prod.outlook.com (2603:10b6:8:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 12:58:12 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::a1) by CH0PR03CA0259.outlook.office365.com
 (2603:10b6:610:e5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 12:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 12:58:10 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 06:58:09 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 06:58:08 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 06:58:08 -0600
Received: from [172.24.21.18] (ltpw0bk3wf.dhcp.ti.com [172.24.21.18])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B5Cw6c23332193;
	Fri, 5 Dec 2025 06:58:07 -0600
Message-ID: <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
Date: Fri, 5 Dec 2025 18:28:06 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
To: Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Francesco Dolcini <francesco@dolcini.it>, Siddharth Vadapalli
	<s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: c631f938-bbb6-46dc-b014-08de33fdf1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTc2L2xub1dqeGk3ZW45TXJzc3Y5bGFvNVIxMnZ2cERSNHQ1TUNZWGJDNjRC?=
 =?utf-8?B?bWljNGJwMlF3OU12c1k4TTE2dFNkZ0NXd2duMzJEY3p5d1hWd1NVR2E1ZHVx?=
 =?utf-8?B?dlNjeHZjOUQ2LzNJY2ttUy82QXFpZUFMcWIxMjNxWHd2cmwxaTU4RWtmRHJ5?=
 =?utf-8?B?NW9RTjFrYm1IQlJPU01SZDZ4MGIrcXBNcEZ4bmdzTjJzUTIvSUFLR2VFN3BQ?=
 =?utf-8?B?OU5ZamliVW4rWFZMa3ZCMGt4aWVxM0U5REljN2NJb3B1b3ZmY1JEdDdvcDhn?=
 =?utf-8?B?MFRnTENzK1lCU0trbDBWZC9wOTRpd3pZenVSdFpkVjVpWXIwN0ZROVRxckM0?=
 =?utf-8?B?bUtIRHBsaTI0T3hZMG5zVGtSZnVUeU9mTGllQXhXWWxZQkhYNnJNODlCYXlu?=
 =?utf-8?B?V0Frd1A1eGUyaFEwS3RVWkFVaWs2SEtqcjY3NWhhM0RMRmwzMTdiWnhqdHdr?=
 =?utf-8?B?amNPa2hvMHB4SU0xS1huZENzT1RSbHRFV3Q3YTlDWWZRazlDM1NUclBwaHlF?=
 =?utf-8?B?bUpMbkxqQ2RYZ0hPYVkwT04yVmxXNWpYOHEwcjJtMFlUK3BJa0NlRTducHR2?=
 =?utf-8?B?MGMvcTZTZDN6cUxtVXp0bitadU5EK0NPZDRGVk92U3AwbkU0SVNDRXNaODhS?=
 =?utf-8?B?eHphMWl3eTdHNy9MT0lGNHB6NFV4M0VncUgyZHV6c0dXYkY3ajdqcExPS1FU?=
 =?utf-8?B?NUhWUUtuUXdhVkNRQVRPYmVkZndja01qdjZHMmdSN0tqU1RROEFkYXRLMVRs?=
 =?utf-8?B?SW1Ob3VQOUtmTHFLVlFaSFF3QmFtQlZ0NktBM25sZHdtN0o1NFJTQlhlNy81?=
 =?utf-8?B?aGVLdnAwbnBGL0JKYW5xamRyaXVlaU5GWEtCcGlxNGlmQ3MxcHNINTFXazQw?=
 =?utf-8?B?dDJLdDdzZ2U3MW9GdjVzMS9WemVFZGtzY3l0SFVPeDlPMFpab1NPT3grSGt6?=
 =?utf-8?B?YWgzMVFZYzY3N25xUk9nWnZLNW9ueHhFV1RuT0hqT0RwNXdiWEY4bS84L2hk?=
 =?utf-8?B?Ti9WN2dVR25HVVVHVjF3SlIramZDMW90Tm0rdTVFeXVTTkpxb2xZc1dVWTRF?=
 =?utf-8?B?ZkRQOGIzQU5KYmxzSFlqZUJXU3Vic3BMZStjVFVJbmdISzNLUjJ6VDNBS2Q4?=
 =?utf-8?B?RWZIU1gwYURuUHZQSlhBNi92aE5KcmlFeTZpa2xVQzVNeklNTkhETHhlMXNu?=
 =?utf-8?B?Y0U0UHYxOWRkaFJtdGloZ0Y1L0tjKys3OTNIM0U0N205VHNMajZTaE9FOHdq?=
 =?utf-8?B?bmdyQ3ZxM2ZpTjZaMkpZTkxQSGJVdlhPeWlJeFhKNDM1Mmh6VnY5UEZLaElv?=
 =?utf-8?B?N1d3RTYwTXNiMkZsQzFJOU51dnoyU0gxNVUxRDJvRm9rRkpxYnR5cWdpSEhu?=
 =?utf-8?B?V1dManZqcHgwd1ZEY2J6RzBFVFlJWjVKU2YxQnZwRm9tbUNxR045VzBKN2wr?=
 =?utf-8?B?QkRIWEU3N2xzUHk5MW1BNmo2c2liekxLalJ0Sk9XZUZXcjRCTUc1UjhnRDVw?=
 =?utf-8?B?T3FMWVpQYk9TT0hMTlF4YWJmSC9KN0xMK09CV250RGlteTV2c1lCRnNqNEM1?=
 =?utf-8?B?MU1kMDAyVW1mY0c1Mithc0FQODFKRTFLOFBnT01UaHcyd1JkYm9IdlJ6SUlm?=
 =?utf-8?B?MEhKZVBCZWZDZ0Uzc014dmlpUjZOTzFZN3N3czU0eGpMWGorTGtBR3V5T1F4?=
 =?utf-8?B?RWVDcEd1aUszK3lIR09sVGs5a0E3RDBDMzkzMk45VXVYWlRiUXV5YVVvR3Iv?=
 =?utf-8?B?ZTE5SUpJUG10WnhsNm9pakJjNklOR1NDWUU3Nm8xVmVGM0VwWm5aMHVXOTVJ?=
 =?utf-8?B?TCs5ZVNVVlh4SmtLakFGeFJpbHdYZ1FtRmhXTnZmYXFJci9mM0J1cm5PMWxU?=
 =?utf-8?B?MjRkZnZhNGxteGZGR21hZ05tOVhpQzl2dld2Mm5yRjM2RDZjUnd6amNkSDBH?=
 =?utf-8?B?aXVNOTd4am1tWU1vSThCZzRrMTZnbHdkUFNFZWpGb0VnTnBKejFEN2xJQkxB?=
 =?utf-8?B?UkNHb2JkRTY1MkFHSmRzY1JZZ1dqUlRSeEp0MVU4OHpBejBKa1MyM0c1bGFX?=
 =?utf-8?B?WFFKaFVkZVRBbWRobDdBeU5pOEtyS3ljeDJoSzl6YkdzVkx5em1xWnVCWWFr?=
 =?utf-8?Q?8j9A=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:58:10.6494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c631f938-bbb6-46dc-b014-08de33fdf1a7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479

Please ignore the previous mail.

Hi Mark and Nishanth The below seems to work for me on j721e. Let me 
know your thoughts.

Apply over 6987d58a9cbc5bd57c983baa514474a86c945d56.
Also, the error actually comes from :

if (cqspi->use_direct_mode) {
     ret = cqspi_request_mmap_dma(cqspi);
     if (ret == -EPROBE_DEFER)
     goto probe_setup_failed;
}

And not from flash_setup().

diff --git a/drivers/spi/spi-cadence-quadspi.c 
b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..492b44976e52 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2024,7 +2024,7 @@ static int cqspi_probe(struct platform_device *pdev)
  probe_reset_failed:
         if (cqspi->is_jh7110)
                 cqspi_jh7110_disable_clk(pdev, cqspi);
-       clk_disable_unprepare(cqspi->clk);
+       pm_runtime_force_suspend(dev);
  probe_clk_failed:
         return ret;
  }

Regards
Anurag

On 04-12-2025 22:35, Mark Brown wrote:
> On Thu, Dec 04, 2025 at 03:11:26PM +0000, Mark Brown wrote:
>> On Thu, Dec 04, 2025 at 08:05:30AM -0600, Nishanth Menon wrote:
>>> The clock is already turned off by the runtime-PM suspend callback, so an
>>> extra clk_disable*_unprepare() is only correct when runtime-PM support is
>>> not in use.
>> Right, I'm pretty sure that's where the extra disable is coming from.
>> The pm_runtime_set_active() further up the function is looking rather
>> suspect here.
> qspi_setup_flash() is just reading DT data, it's not actually
> interacting with the hardware at all, so I think we can sidestep the
> immediate issue by just moving it to where we parse the DT for the
> controller.  It's not fixing the actual issue with the missing/extra
> clock reference but it does get us back to where we were:
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index af6d050da1c8..bdbeef05cd72 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1845,6 +1845,12 @@ static int cqspi_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> +	ret = cqspi_setup_flash(cqspi);
> +	if (ret) {
> +		dev_err(dev, "failed to setup flash parameters %d\n", ret);
> +		return ret;
> +	}
> +
>   	/* Obtain QSPI clock. */
>   	cqspi->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(cqspi->clk)) {
> @@ -1988,12 +1994,6 @@ static int cqspi_probe(struct platform_device *pdev)
>   		pm_runtime_get_noresume(dev);
>   	}
>   
> -	ret = cqspi_setup_flash(cqspi);
> -	if (ret) {
> -		dev_err(dev, "failed to setup flash parameters %d\n", ret);
> -		goto probe_setup_failed;
> -	}
> -
>   	host->num_chipselect = cqspi->num_chipselect;
>   
>   	if (ddata && (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET))
>
> I'll send this out later assuming nothing blows up in my CI and nobody
> else notices an issue.


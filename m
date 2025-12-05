Return-Path: <linux-spi+bounces-11788-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B38CA7A7A
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 13:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC68E301E149
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0123126D0;
	Fri,  5 Dec 2025 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O6lXOpmZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05542230BEC;
	Fri,  5 Dec 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939315; cv=fail; b=N/bebRv5TvxCtHAxuMmZyM9OCyo+6V9V13w7+Ash+xezfE9tXt7HPE9Rq9l8zx9rnIC8E0WOlYMVHvGc//WpgC1qB/IsZtCVKTaqo9+wdhJjU3ouJiWBbUJegn47SFMoCHPWrfKePgy5845/Ci0qA5bEeYPzrQ3d+cyV30jFrqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939315; c=relaxed/simple;
	bh=/BzWSvjtKEF25p8d/kFNI+f5p3mv8TG81vx7GBlEUD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lplNHr/3dn/TrFhWe8QrPTp/LOVwTwIxtS7cEmBHamLr9sdV8EY7xLTFH5BnJdHsMXoLFGCxS0vjvZrxRjEQoKD8OkYUW1yAWRQsH3ukg+EW9I4mqV/paTXsqgzdDTK8eaTBCKZpGE3Z+AMcTFbJp35rg0zIJtO5MeiJQLTe0KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O6lXOpmZ; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUYxhVkF/RmFW7tWvsPvjRqVIYYNQyPAy2d8oCwckhRcP/MzqSAxdznCHFJMWFWc5w5donQDPfaq0aL7qDIACMBeUQ0Yx80DjlVnThcpIUYK8d9pvFUoDdGRG+1jbUVkAGOEHrDrFAjJ0Is/2rqxG2p12jbfTzYvrmC7jVJrS+a1ifZPx31CFWWl6/S/seA48wW/HVt+ykI3DOlx1dVOvhapE0ICO37m/FdIJSz566AAJoxS1I7b8bzai/uTiVc+/TjjGHYUW81gjUF/P9AGS8ciBCYNEM4kdI9LfWwQrpsRYte9MZNbLK0DZeLFoQvPxouW4I6y72MpgMweblk81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXx39N9NvL3vtnGQGBPcvoY/b7xiNnAxmMEHI2Xm66E=;
 b=s1TvGaix0KNQ5sZvqjAgAiU/NNHIz6jrMxS6ED2m0lihSzvfddYIojhAEygmCZoJrQsujC2mn1H/cx1ML7xXcEbERXORCDhdT6MDi+rqAN10yfT4mPt9bxLbn06dzVO+W9Tp6e/OhSjQcPMVEswUMnbX79RhFb4ckjv2c5fqdeuMZKO9vqeiAaNyw46pRigylG99v0rIK6nnvBTvjK9wyHOR+hkj5Lo6IhO4qcS413sERT/KbnbuUP2YksuS8VlftHZnTOEONMm8M3tgK4U8T2pv+xa312EVhM9h5oSdcnFW1PdkZ84dsxtS8TzOS0PYNB6Fm9B2DJW9B6ZBD1L0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXx39N9NvL3vtnGQGBPcvoY/b7xiNnAxmMEHI2Xm66E=;
 b=O6lXOpmZ9ITeF9ePO1OiXcXjWfq7omwIiT4ALYG1m8MHYo/xpfckvA987nQdO3/joC/aAk53ochWVji0wIYooAbyL3RDOhAO7+4UQHmOIVVdyTFx3FUd5mXGuMas3tmZtVp8WmHCRM6bbO1CGBFg2flPtjhDCIhip4KoRyxQn0w=
Received: from SJ0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:33b::7)
 by CH3PR10MB7562.namprd10.prod.outlook.com (2603:10b6:610:167::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 12:55:00 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::96) by SJ0PR05CA0002.outlook.office365.com
 (2603:10b6:a03:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 12:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 12:54:58 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 06:54:55 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 06:54:55 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 06:54:55 -0600
Received: from [172.24.21.18] (ltpw0bk3wf.dhcp.ti.com [172.24.21.18])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B5Csqhx3319793;
	Fri, 5 Dec 2025 06:54:52 -0600
Message-ID: <95b2ac7b-c9c9-4f05-a1d2-3e70fe388dd9@ti.com>
Date: Fri, 5 Dec 2025 18:24:51 +0530
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
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Gujulan Elango,
 Hari Prasath" <gehariprasath@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
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
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CH3PR10MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad611f9-d9c9-4dde-0164-08de33fd7eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emNrQURNdEVqWTVRM2t0YnlpM2tJZDBFTjExUnQrMnMzVlNwVm9VNEJYenlE?=
 =?utf-8?B?TVYwYWlwdDgyeFN0QUtFK1RiblAvZ05wamZuVE5DZXc0aDEyL1hQYlJzQkhM?=
 =?utf-8?B?b2RRQmtpcXRVeWxUdndLc2pqRjBBNisrZVFPM2lhTzlyWGRVeG1LSjJITHhv?=
 =?utf-8?B?NjZCMTBzR3BiTUo5azEzOTVCanZENloyMW0yM1JYTHdqVEN0czN2Q2JubndX?=
 =?utf-8?B?dzBxNk1CTDZJakVYNmRXZnhOZmNlZWhjL0pEekJnamU5dm13dklPVkZwNnVq?=
 =?utf-8?B?cytpVGtXRTNkWllBQisxcTk0N0JpT2JaRVhOMURIbWczUEpMMkwwcHFwUTJL?=
 =?utf-8?B?UDdrcXpGN3JpMExlNUdCc003YldMcWZKdll1WnIyWXVERVFoTFBUK3NlNDM2?=
 =?utf-8?B?TEpXWEY5UVpQL2FYUFNWWnQzZ290WXpROU41MmdKY0ZNME1hRWFVVDZIT2NX?=
 =?utf-8?B?NTVwdnViaEFQblFYbEFQV29aQVp5RTFvR2NIelJJTm9RbWVTY0FQb3RBSDM5?=
 =?utf-8?B?Q08yamtIU2ZDN2lLMVFKeElsNzJVYmhlVHpXNmNwQ25oejVpWWNxUmlsOGxr?=
 =?utf-8?B?VGxuOENiWGNNdjM0MDNETEdxTVhGZVQyNG8zQ3dYTHZPZmdRSjJnRDJzeHJH?=
 =?utf-8?B?T1QzZ3VLazMyajZvT25Oa05UMmNQWjlDdE5FR3RlNytrcU9VOG4rNUxWTWtv?=
 =?utf-8?B?VUxoSFgzT1Z1UDFrNEpFQW93eEcwSXkwL2xRNnloZll5ZnZTSUZxN2loWkUr?=
 =?utf-8?B?clQ2VlRpYU8xUmZYSUIzVmY2WFFCcFFiWnA1N1F5bE40QTd0Q1N3SmtidkFD?=
 =?utf-8?B?dlhlU0o5SlVsUU5zN2ZzYlJzcmlZZC8vWU9oa0hKU0NuQ3RmSFYwSXMvSStT?=
 =?utf-8?B?cEowWEgzcjYvY0hCZUt1bFZmcXZJdU1aaUZmTEM2alBZWUR5b1B1ZVVJRzlG?=
 =?utf-8?B?dGtWZy8vV2NuWVJjYWNCTHl3cHNsV1IrWnA2QVhnRWc2WTIwQXREUVhZbWI1?=
 =?utf-8?B?TmkwMFdpc0M2QllTMG5rUnFlR2F5L1Y4cWZwTFRGR2x3TkxXcHRiYmxIYnUx?=
 =?utf-8?B?SXd2MHQxQmdBTWswRllqMUxGdHZlcXkyazdPclN4S25KZEdmZEtYc2lndlNt?=
 =?utf-8?B?QkNhbENiSDd5MzBuSi80bTFyUkh5UlE4aHQ2NXBOeWFUdXk2UjhzT0FNSWk4?=
 =?utf-8?B?V1l1V0dvaG55RjBXekZsYXBSc2ttTFA0c1N6eW9zL1J2YkZMbDNOME1WMmJp?=
 =?utf-8?B?c0ZWUEZleFpOL2dYVEwza09aS1FZS0xUangwU0VXY1RnZjN1dnFUQzRhY3h3?=
 =?utf-8?B?ZnZJVXMxMjRoL3MxNjBKSm54M3FQUGRjVmhTVTJnL0xEdDY0dlhBR0F2dXFH?=
 =?utf-8?B?WkpUcVNjckFNY21aOHAramIyUHZ0R3ljcWpkWXNlZjNyV2x4V2ZnMm5HKy9Q?=
 =?utf-8?B?cVljZHpCb2JsazVaWWpXQWZOMlRhMG1Ba0JCSzJlc1BjTmd5aXRUOWxXczNQ?=
 =?utf-8?B?Ylh1T3duN3lkYXp5OFp0TDNRQ2JGaTNRSlZaVDVBMzlOd0JhZHE2ZUczbWZV?=
 =?utf-8?B?Z1BwUi9tZUEzZUNWRVE0SVg0SnFGWG81RThsUVRvV2U3Qy81aVdIaktCRnoz?=
 =?utf-8?B?T3p0ZERWSjJxTG9kVHptQzZscDJzMExNMkl1Q0wyK2NYanBVbis2RWxFOHZX?=
 =?utf-8?B?N1B0SlU1TkowMUdaZFhOYnlQWm12UkttSXVYcW9pYnByYk9iaU4ySTVpNm9Z?=
 =?utf-8?B?bStQZVhoZDRGOGttNjBEcE9jUGlGYnJtSGdSdCtUa1ZZQnk0YVBVMXE1bkU5?=
 =?utf-8?B?dUcxWkRFY0ZnVEFkeEhoM3BtS3JuQ3NvSlpjckdhY3ZXZzV6VFZxVHNoYzg1?=
 =?utf-8?B?aW1yRS90Z2x3RS9PMmMvM2RWTkJHdFczSy96RVZ5Z3dpNHpnUW00UzRxUXZE?=
 =?utf-8?B?T21VTTR4aWRra2RPTGg0eVhCWWR6N1MyekxhbEFKY0JsZVZMZno4Zm5DOGt1?=
 =?utf-8?B?eDF2QjcyRW5kZk9yQWlOelo5N0J3d2w0UE1kZTB0NXRIcVpBMU04Q1pEeDMx?=
 =?utf-8?B?TElhN2oxRE93SEhQK0E3MHJENXhqTm5jdU1ZWnBaT1c3eTJLOXVtcURzV0hL?=
 =?utf-8?Q?1nXA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:54:58.1186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad611f9-d9c9-4dde-0164-08de33fd7eea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7562

Hi Mark and Nishanth The below seems to work for me on j721e. Let me 
know your thoughts. Apply over 6987d58a9cbc5bd57c983baa514474a86c945d56. 
Also, the error actually comes from : if (cqspi->use_direct_mode) { ret 
= cqspi_request_mmap_dma(cqspi); if (ret == -EPROBE_DEFER) goto 
probe_setup_failed; } And not from flash_setup().

diff --git a/drivers/spi/spi-cadence-quadspi.c 
b/drivers/spi/spi-cadence-quadspi.c index af6d050da1c8..492b44976e52 
100644 --- a/drivers/spi/spi-cadence-quadspi.c +++ 
b/drivers/spi/spi-cadence-quadspi.c @@ -2024,7 +2024,7 @@ static int 
cqspi_probe(struct platform_device *pdev) probe_reset_failed: if 
(cqspi->is_jh7110) cqspi_jh7110_disable_clk(pdev, cqspi); - 
clk_disable_unprepare(cqspi->clk); + pm_runtime_force_suspend(dev); 
probe_clk_failed: return ret; }

Regards Anurag

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


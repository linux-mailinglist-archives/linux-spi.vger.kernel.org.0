Return-Path: <linux-spi+bounces-11828-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7631CAF82E
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88173014D9B
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097382FCBE5;
	Tue,  9 Dec 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wBapsR2k"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E22FCC04;
	Tue,  9 Dec 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273974; cv=fail; b=WiLamh3nicuZKrcd01nVb7IMguXeAcG2kAe1383u3M1J0OsyI32M+67Sej57Hnb3tCPLEcq+8kqRxAcdRKKyysHGIVm24rY05SiFerTHMVgOP/S/NJ9qtG6AN64lteOJACPEyCPYI5zfI+aTSMA6M5yz4l1k+BZUH/0pez03/LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273974; c=relaxed/simple;
	bh=Wo9sr0RDeaZsGhTYhuU/NQU/E9M46kHnMfqdW0YShIc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=sLBw2qUNvMkmy93IRJI9/462cox6B1tvEOYBwdj13LDU9w3ZdDu9lOJmwvCCRr9hVrODFS3vbme+8eQHfcyFu4cBYGeqXK4iuDcTXVy7CC+CSMPOCEp50TSMzEWj9JPh2AyILc4NoF+792q0u+iaz4SusJVb/j/uKCTAhErdcGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wBapsR2k; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOP6LLgT+xzq1l5axHJascNdeMcUGk2KfcsjQPMvKFqElSRiJxURHxZK3vmfVbKoqvWGBqsm+yqiENl/f2PGK53GmbjHCs8oFDa3Se31bFXE4a1eZ+Kclx1MTKtAIt1Xr8KuGFDOzKxG43Ph+pofZsNkreqJsX/unnwIMsl5BKrr7JHbAfHZxXFRSsK7wySxso0BwM6ZYEGa3whRk6gLasxPxBV+eDheYhEANwAnZcggFrOcKXQRzntMbNm+menWIDEEqS9oB/q7jfzArRV4qpMdLfiizOmUZ5JZ8V8HHfmiLmbyr/V2RbwGQFHYvnwE0bHh3jlsoiEa3e1+gEc2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sVyPpUIDXMdtEk7VpBKwZH+b3E2bt88FzG75c7MZ10=;
 b=hoURdaCRsdvGdL1ugSFEmUDcjgafflUR3SjJOp+vTd3amtvA8FH3Hy/v96VIR4lUjYEGeyCCxuPCJsinJIGTmHbWPx/VZT6W8OEfL+FhJgWvTUdwl3lQhJkokPg/XtMpl971SQhpNIY/Z3yE17Y2Ub9JSb6moB4VCQfAKKOcEvr/avDSOOawK3J5Ze254Ei1MPaK+bZvBrdgGh3/Xh8dkQw6xZIgupoqUF+jrokotz3oSpcbQMNePrBlO+pymvoNNd2ZEedO6fmPnK3Tc6gSpqwpxF0VAVPEDz17l7nO/JWUku0OSfWaUMrmKAJ5Zw2tfO7uLIvuxBUB0udCccNzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sVyPpUIDXMdtEk7VpBKwZH+b3E2bt88FzG75c7MZ10=;
 b=wBapsR2kXIkGWGU9S/E5Rtwk0TbJgNBqW8U69DsVToOMk7TBs2hbQalLMs5zuMxXtup1HUfyoYpNCtt13JHj4g03U2DC90PCX/pe/DmYq9P0VGBwlVQ56i39PODuVtSgkxTnSN71s7YAVyvSHl/nsGVlJ6tIVRMo5l2/P4/5Nr0=
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 LV3PR10MB7983.namprd10.prod.outlook.com (2603:10b6:408:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 09:52:49 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::40) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 09:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 09:52:48 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 03:52:47 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 03:52:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 03:52:47 -0600
Received: from [172.24.21.18] (ltpw0bk3wf.dhcp.ti.com [172.24.21.18])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B99qiZ51012689;
	Tue, 9 Dec 2025 03:52:44 -0600
Message-ID: <cf8e7003-ebca-4817-8350-f29332d75fab@ti.com>
Date: Tue, 9 Dec 2025 15:22:43 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
From: "Dutta, Anurag" <a-dutta@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Gujulan Elango,
 Hari Prasath" <gehariprasath@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
 <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
 <555e9f6b-b8b6-4cc5-900b-63aaff8b4e6c@sirena.org.uk>
 <20251204140530.xax5didvuc7auzcd@problem>
 <4d6b857e-4bfe-45ef-a428-6e92f218f0c5@sirena.org.uk>
 <2fcf5235-cc94-4202-9164-4889356c5264@sirena.org.uk>
 <cd95320b-6852-476e-bc8a-2e8d1ac77a9e@ti.com>
 <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
 <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
Content-Language: en-US
In-Reply-To: <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|LV3PR10MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4278405a-5297-40a7-8d97-08de3708b63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZExtR1MwRm0zeTBHMngwdjRINU9pM29wR0l6WUNrTHNsYnJsSXJLb3dKTWhI?=
 =?utf-8?B?aklDOTFEN1poeTlkaTQyVnRuZVBQa0RRaU5qeHRBd3hOS2syRGxiTFV1M2tP?=
 =?utf-8?B?ZDRnQ1Nla28zQU9tQzN0WkxDNTBPSmlsaHAra3pSa2JsbU40bkhnNnhwc2NO?=
 =?utf-8?B?c3lGSlREdUdVWGUyK1JzYkRjRjVPR0d0Qkk0MXV3MFlyb1B1eHNxaWlvR0x1?=
 =?utf-8?B?WWtsSDVsMEE5Z1BWdGZUV1BzYVZEa0VzSXowc09mWFNkaTRLVkFqOFBocXc1?=
 =?utf-8?B?Y2FDMzFwWlFBTWUrTVFIZmdIRXlxM2lvVVJKL0VYQnYwTkg1SDlKNFBLbktM?=
 =?utf-8?B?QW14RWZSelkzaUVuOXh5aGRpRjh6OEJ3aHVQaTh3Qk9ZNXhPb2w2QW45QmJZ?=
 =?utf-8?B?bkNENm9DcG5mYjNtcEtBNHU1cHQwY0pWTzFvdy93d05oeUU3TmlNYjBNUk9r?=
 =?utf-8?B?QzdZNmFua2pwVU14emJScjVHeGdEKzk5TVFsZEJnaHRSV3FjYW55STNnakRr?=
 =?utf-8?B?WElUcnk3VGREZUJxVThsTnludDNYc1pxR1Rmb2s4WFYybTk2S1pIUzlPZWNs?=
 =?utf-8?B?anY4RlNyWWlkaU5VVTFrRjQvRFBrZVU3Z3ZnSmNYUGJ3elRGN3dqdDZRYjdG?=
 =?utf-8?B?V0J5VzRDWllnQUF0S0RsZ2pXaVNuVTlQM2RENTB3K2ZsM3A1OGs1ZEtHSXF2?=
 =?utf-8?B?aWk3b3I3cCtLNjA5cXJUNlZ3NUlNV0d5emwwTzRBV2xiU2dhU2x2MmhlNHNr?=
 =?utf-8?B?QWpYbG5nZ3Z0V1hJSDE5U3ZuNTFXbkVnSnVpY0YzbnJXQ0wzZlcyL245bVJt?=
 =?utf-8?B?eUZtSnVkQlY0WlVIU1BnNTNSVVRiNnArQ24zd2U5VUxGOW1sZlQ5VWV5ZWRi?=
 =?utf-8?B?SEhzaVF5MUJTMDhuQmpnd3NpTnRXREpSSWZrajdtcytkRHlPZ0ZFTVBVdDNq?=
 =?utf-8?B?SlQwWDNwbm44c1hPam5YY0lIeStNQjc5Y3p3ZUtxcjdUcjZpZDVmUUdWbmhu?=
 =?utf-8?B?bVBXcy9LK2hRNFhkMDUyS3EzU0R5VlF1Y21CT29UeTN3ZGJIRTdjZnZvMHJt?=
 =?utf-8?B?Sy9IODZJYmhuVnF1NjJZNjdHTzVMV0c3M084M055Y1Q5TWZBOEtFS0hCYUpM?=
 =?utf-8?B?ZGNpSy9QY1ZmVWlYejdzeFRGVi9Zd3QzT0lqNWlXQk5FM3FVZGRrU2x0Ym9l?=
 =?utf-8?B?cGUxVlhWdTdqang1RDZuallBeEVLeTU3M3NEZm4wNlJ3K09LYXRxa0dFL0oz?=
 =?utf-8?B?c3oySktCOUZ6bmlhY0NLRW84RC90UzRMZ2lNQUttT3BvWCtNWGtuQ3FBV1F4?=
 =?utf-8?B?ZkhFU01rd1NNSC96SVVYbXl6Wnl1NjJkcExLWWw2VWVVZ1J5R3BoU3NCc0pJ?=
 =?utf-8?B?MHIrUHl0aHZPbnpJVzZkWFZIdjkxbjh5L3JuRG1rMUlJRDhzYWN4cVZSajRq?=
 =?utf-8?B?MDl0c2h4Ujh3TFJpRzhaMkZMcncyYXlaWlJsaXlTUGJ1dXR5TG5FYUdvZ1N4?=
 =?utf-8?B?djZnTS81Q2x6Yy9tOE9zdjYwMmZjbk9LSVJrY0JrMXJPNmp3SkJMV2RGNVZo?=
 =?utf-8?B?Zi9ubDNkVjdEMVlhaVVqZzlVeVdxSVB1VndIMEFJc2cvQ1AwcWN4eldGdjRN?=
 =?utf-8?B?QkUxbjNkR251bUFGTlVPaTNWZ0dtRkZVVTlub01HYjVERmpRMThzVW9JcUVZ?=
 =?utf-8?B?L1dpTy9ON0hCZlFROTY5dFBiS1daVEpLNkp5R2JJNCsrdS8zYWY4R2xDT213?=
 =?utf-8?B?ZURTZ3NhTHVsNkxDZ0ZIcUxGMGpMVFpncUN3RDRYTDNBMENmQWpSSFF5RnhD?=
 =?utf-8?B?QUFJYzlNRGtQdnd2K0lUUm9OVHRzTTZlSUtsUlJseVZ4Yml2a21VNDF3TFVR?=
 =?utf-8?B?eFRsTU15Z3hHamNQdWxlYjFXOGdFR2g4M3VyVWJveHRaZW5YMDFydzA4R3ZZ?=
 =?utf-8?B?eC9Cc0VWb0kyNmpVWE9SZktvcEgzWHVXOEE0STU3bk1UTERTMlFqWlJwQjU1?=
 =?utf-8?B?SkgzWXJ6djVhYm9RWnJpU2UyQUIvM2dJY2JIZlZoT1ZkNXN0TkRxOVVkMllk?=
 =?utf-8?B?b3dvSS9lSDdoVEJZSThJblViTFR1Z3dZVHlmRGdLTllvdjN6YnhUV2NEaCtF?=
 =?utf-8?Q?6Dxk=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:52:48.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4278405a-5297-40a7-8d97-08de3708b63c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7983


On 09-12-2025 11:13, Dutta, Anurag wrote:
>
> On 05-12-2025 18:55, Mark Brown wrote:
>> On Fri, Dec 05, 2025 at 06:28:06PM +0530, Dutta, Anurag wrote:
>>
>>> Hi Mark and Nishanth The below seems to work for me on j721e. Let me 
>>> know
>>> your thoughts.
>>> Also, the error actually comes from :
>>> if (cqspi->use_direct_mode) {
>>>      ret = cqspi_request_mmap_dma(cqspi);
>>>      if (ret == -EPROBE_DEFER)
>>>      goto probe_setup_failed;
>>> }
>>> And not from flash_setup().
>> Great, thanks for confirming.  We should probably ensure that has some
>> logging...
>>
>>> @@ -2024,7 +2024,7 @@ static int cqspi_probe(struct platform_device 
>>> *pdev)
>>>   probe_reset_failed:
>>>          if (cqspi->is_jh7110)
>>>                  cqspi_jh7110_disable_clk(pdev, cqspi);
>>> -       clk_disable_unprepare(cqspi->clk);
>>> +       pm_runtime_force_suspend(dev);
>>>   probe_clk_failed:
>> The trouble with that is that in the !CONFIG_PM case
>> pm_runtime_force_suspend() is defined as:
>>
>>    static inline int pm_runtime_force_suspend(struct device *dev) { 
>> return 0; }
>>
>> so we'll leak the clock enable.  If we could just require runtime PM
>> this would be an awful lot easier to deal with.
> So, can we maintain an internal state of the clock(enabled/disabled) 
> in the  struct cqspi_st ?
> Before every, clk_disable_unprepare()/clk_prepare_enable(), we check 
> if the clock is actually
> enabled/disabled by checking the state of "atomic_t clock_enabled" 
> within struct cqspi_st.
> And, when we do clk_disable_unprepare()/clk_prepare_enable(), we set 
> the value of clock_enabled
> accordingly.
>
> Is this a good approach, given we take care of race conditions as well ?
>
>
Another solution :

diff --git a/drivers/spi/spi-cadence-quadspi.c 
b/drivers/spi/spi-cadence-quadspi.c
index af6d050da1c8..4d298b945f09 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2024,7 +2024,11 @@ static int cqspi_probe(struct platform_device *pdev)
  probe_reset_failed:
         if (cqspi->is_jh7110)
                 cqspi_jh7110_disable_clk(pdev, cqspi);
-       clk_disable_unprepare(cqspi->clk);
+
+       if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+               if (pm_runtime_get_sync(&pdev->dev) >= 0)
+                       clk_disable_unprepare(cqspi->clk);
+       }
  probe_clk_failed:
         return ret;
  }

pm_runtime_get_sync() will increment the usage count thereby preventing 
from runtime_suspend()
getting invoked, thereby preventing double clock_disable()

This will work for !CONFIG_PM as well because pm_runtime_get_sync() will 
return 1 then.
and the runtime_suspend() is never going to be invoked.

logs :
with CONFIG_PM : 
https://gist.github.com/anuragdutta731/c0080a7592de992e71103e9947639b2a
without CONFIG_PM : 
https://gist.github.com/anuragdutta731/f9a79302b65088d53db2c970b6b8eff0

It work for both cases on j721e. Please share your thoughts.
Regards
Anurag


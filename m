Return-Path: <linux-spi+bounces-11826-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D221ECAEF63
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 06:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81BB83030FF2
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 05:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10030BF59;
	Tue,  9 Dec 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uZvTtGs+"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423CE3081D5;
	Tue,  9 Dec 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765259037; cv=fail; b=BCJ0sG2sStb7XahC6e5mjHe6+KOEsGGgRftD8R3Zp9GN0RKiX5d+oCmbhLSOYeaIAby3Ael2TX5NghQiWJpddeP4ETERMYMsJfocH3fKrKjfiSP2O+tvde4T53HV7LLxV5Urc1rvXU2SyH/bXMq3ryh8hLPNOKqrDT0AS69Ng70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765259037; c=relaxed/simple;
	bh=piplTwgolbajR6YJNUR+c0J4xiLxVzphxhpHPzmR6lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=prllYpBJf5V+1JJzUmX152xTMet996rPo2fHR3MGxF4u0zh1Uz0UgG03JjVcasluBvOUGg+y8MnyBlrFaELDsfqxhzeSAa26REI3BaVpv59l/xX1yjbkZtkOPXrKHBNYVLNBSv/zIGRg/oAFtvrt+8cVgOhrB3FXpZEDPBZ5Dq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uZvTtGs+; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/3z1IOFZopKAcuDzCR+P01Tcfqd5LqeW2QhMS5KbEjzLtfOp5fGLfGQ6N86Q8FPfFPQoMJXc7/hciZcrtJJLHx0pmY7KchVm1hPdwR1UpcFveJOzwCkzy2dE5M3ifPnY4kcQyPbmkWxnYH5qKFnJsq+jZxJWIq2TMqQdZoeNCGm36IEWJZuLICNrAEp2nXYY5brspVcYr6nKIksDWa6j+NPsRhJ3Guu8dfEeRO9R1IDh+qy2dm5hMyAsZ2CoUSFlbgzCHX/J268tnpt+Mx/zKWYBwdznsHpLrkglfNeXVZBb7TSPKwVWXNM9ERVNn7/qtBgbdL1uytxwvd315z0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gykD1gcyE2uhso4HYwovezh8nJBVOL3H87B6JFOF/Sk=;
 b=eeam2rml9KWF9XbBuFRu1i4shtc6uxehLlok8mSJHUErlpCjeh5yErr84MES4TN+Zvw/SKPHUS1rKuy4KNl7yGuBj4amnOUOMSnCAg0ZdTXP6J7OcodEzcr4l81P9tPUvbLhOQbCINF8h8M/tH9UotxZw9+GKiUZse14aOB4r/jG2j+M+a8wcWsI5hUFTxG0OHI1lXUf+uqCo4VjOfKCnZdMUMqjZZi66xSaE/Y0B4NPBQx24A22eAl+lOmHtXrRriMv4ilU5bJv95ye2zvcXjKE7tmriQLGOEAOUBfNoDskYEy/UFnlBMBSYxEom1QrhXU2hfhqPEGtUgqv1i8iJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gykD1gcyE2uhso4HYwovezh8nJBVOL3H87B6JFOF/Sk=;
 b=uZvTtGs+gd8UqETwdI48okNjia8x9mbe74dJUmPes8t3R2BSQRXwu+sgRgavzGk0H0pc0Y9aRBs9WGNSOO0uRKtRKXr8tG9TkRX+Ghhz92T9cIIti0Zc8l3CjbGHgFmPJ3oKyQYmvZZ2xJayIo8ek8FsPjsYj3iW88AQOiRRR4c=
Received: from SN7PR04CA0195.namprd04.prod.outlook.com (2603:10b6:806:126::20)
 by MW4PR10MB6629.namprd10.prod.outlook.com (2603:10b6:303:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:43:50 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::59) by SN7PR04CA0195.outlook.office365.com
 (2603:10b6:806:126::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 05:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 05:43:49 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:43:46 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 23:43:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 23:43:46 -0600
Received: from [172.24.21.18] (ltpw0bk3wf.dhcp.ti.com [172.24.21.18])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B95hhx5654235;
	Mon, 8 Dec 2025 23:43:44 -0600
Message-ID: <5525272e-7220-4352-bb08-ac66631108e0@ti.com>
Date: Tue, 9 Dec 2025 11:13:43 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
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
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <f804d7a7-4ffb-4d2a-bbaf-ca0a076a11ab@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MW4PR10MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ccc02a-63d6-4f26-086c-08de36e5edb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDlUdVNrY0d5RmpUQ3E0TGtYSlB5aml4dEZJNDhySU1lbVk2V2Foa2xpK3By?=
 =?utf-8?B?bVJwUHBRZ2ZNZ0pJNUdrTGNzSjFURGZMTVhSVkZCL0U0dGl4cXdkR0w2M3Vu?=
 =?utf-8?B?Wjg0TEF2WWsyRmd1QURDK083TFRGdjVTa1F6bmVxOXZNa1g3ZE1EdS85cFY0?=
 =?utf-8?B?ODVCcHhNbGt5c1RnbWJYY2FKWVlqQk5aMnQ2M3c5Ny9yUTFKUlpidS8vWldB?=
 =?utf-8?B?Q09KY1MyVityYlRXZ29HSXd4UVNjYzh5YytaNDNNcWhVTFdvZlN5dFFsWXpK?=
 =?utf-8?B?eFB4U1crYUtJZTNYTDdreXcrT0pzQm1YWmRRTVhkTFdqQS9paDBJSUphRnJT?=
 =?utf-8?B?WlhYcVhsNkI5eG1xNS9OZE5obWRtU3RyNDZBYmxqYytncEVzOXBQZkVVeUxw?=
 =?utf-8?B?NjhlYjVMYVpTZU1KTitiOExIa2dQeE4vYm1UWjM2Q2hpaXBZUUdXQlJRN3Js?=
 =?utf-8?B?NEhGSnhsZjJXRnNsYmxteXhuamZna1F0WitQTjZ1WVdzREVoTDBWZ0tKM1Fm?=
 =?utf-8?B?VmJMellNMWJQQWN6VGNtT1RUbk5SY3ErTEVKcEdmM2FVclUzaWpldHJ2Vmp4?=
 =?utf-8?B?MUJzVXk5VTJmYlR3SjQ5RlFmb295Rk1mUy9pL1JtcGt3OGw5dVhaNFJHUWY3?=
 =?utf-8?B?K2tOcjloUk5wQUV5Ny82NTg1QjVOM3NRTU5ldHJsczBLRnpqb0hnNDNSNy9m?=
 =?utf-8?B?OXdwcUZkUVpTYkxnRGRhd1V1Y3FFTlFBTHNSem0xZFQza3JDQlpRdE5VQ1Vi?=
 =?utf-8?B?NHcya3o4OUppby9BU0gxUlFFWVVSbWhuMVc1a1pFZFVuSlJLU3g1M2xCckJr?=
 =?utf-8?B?QmNYQktqcVpkbVNhTVBUZ3pGOWFMc0g3bkk2ZlZnMTliOHNPUHlaZW9HOCsx?=
 =?utf-8?B?d3ZNZkEzU0QrU1AwSWJzbTJ0akdwQUd1YjROVWJ2L3JrSXJ4UnFhM0xaczZR?=
 =?utf-8?B?UUZ3enA4R1lIbWxIQ3ZqcXg1bndYL29aZmFyc0JiR1Ftc29tZlN5cDhtaDdW?=
 =?utf-8?B?UC9sKzN0YlpLKytXQTdjak9INTNMYnZEQlVSUEVzZlJ6REkyMFprZlFORDk3?=
 =?utf-8?B?ZlFFbGQ4amJEcUpPWjFPcWF6WkVEOVp2K0VzdUsyQ1NFUStZQkNmS0V3NEN2?=
 =?utf-8?B?R0tJNXMrSnE1VEdYUWZXWjBZdzIyd1NYR09ZWnRBeGJYUG11TTBCSjl4UVhw?=
 =?utf-8?B?NHBET1BadGEzVm51aTVvREVQTU9mUFplVjZmU0c2Q0JtRndwWkZjSFJsN0NW?=
 =?utf-8?B?cDZCKzhYSHJ2dFZ5bU82eTg5Q3hGZEcybTdCQ0VtN1FTNXBNMWpJa3NIYmtJ?=
 =?utf-8?B?MVhHcDl3NFptVU51eE9BcGgwclNtQzdlQVdyTVBGZm1ITU1LOUU2bDJwKzFX?=
 =?utf-8?B?MG1NQ0lJSlEwQXcwQy8zMFE0Z0srZGJIZ0ZLazRPakdhUDNHVU1LcHpXalJk?=
 =?utf-8?B?REtMMVZFQUFNckd0b1NYbExHNFJUclNwSW1QbHVRVXN6d1dYNzhDditlSURL?=
 =?utf-8?B?NXFLRWxINVNaWjQrS1ZwSkg5MFB5MkppVlh4b2RGMnBCZnBzSHp1d2lIWlFS?=
 =?utf-8?B?K2h1aVdxOUNZZnFUdEI2SVIyRlJaL1RBVmlGd1NYQ3JUY1Q4UVNsZWtBb3Bj?=
 =?utf-8?B?VDBGdmVqdk5tTjNYemt4MllZWm1oMUJYZlZzMlVraGlqaVNrUXZZN2R5cGRW?=
 =?utf-8?B?SEZka0dkVlA3N2tMRG1WQW9uV1ZDRy9nY3YzdE1mT2h2STF4OXhSSVVFeUNs?=
 =?utf-8?B?Tk5UaUc4a3NSbW5sNm95WGVad2dDeG1xWUk1bHlTMldvb0dwQVBVUVVMWmpS?=
 =?utf-8?B?SUsxa1FtQnBvY3h2bGFCbEk0Y0xaNlkrSzhJVFdnaUdrT25kZzE4WEc3RmRU?=
 =?utf-8?B?Wk9Md2xDbVhtMlBuWnhuaE53RlFobEN5WE03SjFXbFRNMWxHTERBY1RZR2JH?=
 =?utf-8?B?RzFiRjdhNC9RcU00V2xyd2pqQ1R5T1k5eG5xVVdCY2pzRjRkT0I2Q0ZMbmd3?=
 =?utf-8?B?MkVJWlRTd2h5eHFZVUt3ZGpHSWtDWFZwdVVmRGlpSy9ENlFYN1dES3dZRVZT?=
 =?utf-8?B?a3U0QVREZTltS3RrTmVVL09RTmZXWkVUVFM3UzlKVzBaSVVoK2FFenVsQng0?=
 =?utf-8?Q?2qc0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:43:49.5620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ccc02a-63d6-4f26-086c-08de36e5edb1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6629


On 05-12-2025 18:55, Mark Brown wrote:
> On Fri, Dec 05, 2025 at 06:28:06PM +0530, Dutta, Anurag wrote:
>
>> Hi Mark and Nishanth The below seems to work for me on j721e. Let me know
>> your thoughts.
>> Also, the error actually comes from :
>> if (cqspi->use_direct_mode) {
>>      ret = cqspi_request_mmap_dma(cqspi);
>>      if (ret == -EPROBE_DEFER)
>>      goto probe_setup_failed;
>> }
>> And not from flash_setup().
> Great, thanks for confirming.  We should probably ensure that has some
> logging...
>
>> @@ -2024,7 +2024,7 @@ static int cqspi_probe(struct platform_device *pdev)
>>   probe_reset_failed:
>>          if (cqspi->is_jh7110)
>>                  cqspi_jh7110_disable_clk(pdev, cqspi);
>> -       clk_disable_unprepare(cqspi->clk);
>> +       pm_runtime_force_suspend(dev);
>>   probe_clk_failed:
> The trouble with that is that in the !CONFIG_PM case
> pm_runtime_force_suspend() is defined as:
>
>    static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
>
> so we'll leak the clock enable.  If we could just require runtime PM
> this would be an awful lot easier to deal with.
So, can we maintain an internal state of the clock(enabled/disabled) in 
the  struct cqspi_st ?
Before every, clk_disable_unprepare()/clk_prepare_enable(), we check if 
the clock is actually
enabled/disabled by checking the state of "atomic_t clock_enabled" 
within struct cqspi_st.
And, when we do clk_disable_unprepare()/clk_prepare_enable(), we set the 
value of clock_enabled
accordingly.

Is this a good approach, given we take care of race conditions as well ?


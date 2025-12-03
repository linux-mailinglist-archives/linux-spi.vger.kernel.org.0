Return-Path: <linux-spi+bounces-11735-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691DEC9E1D6
	for <lists+linux-spi@lfdr.de>; Wed, 03 Dec 2025 09:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BC13A5841
	for <lists+linux-spi@lfdr.de>; Wed,  3 Dec 2025 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BD328727A;
	Wed,  3 Dec 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jT85B3pG"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96212BE7A6;
	Wed,  3 Dec 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764748957; cv=fail; b=fZG5488le0tjIOvAAfPi/maetTSpkq2Tie9nYMIsPI06s0xN6Vqdb9pUpom8BR8XRRqF7O37Y0HYjhnP2TE86BrafvtDKz/JcWjYQ1Ru3+v+b1u0p0vPl4rb/nFmNjUpbZtXWllXMxrrBG9/alMcPwJChi/REyYaUp4lUX2E9dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764748957; c=relaxed/simple;
	bh=U17ra84zBFRsC47dpW3lvd5k3o5Ehq/ORBaYZ2C41Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U5OPEEeB0uocHKY8N9t1foLqMPl704I398tYS8zXJTBhOWOZOlFAPMz4HJ/RUUfmyssqTFO3Q8jMV9OhCkeStLy2A/mkhFH95G/LU3Er1Lu9oxiUeqg2zQp42BTZrzbnFKATp5RX999tALXb6VyzW2tH1BAMSkjL5724kqeRYm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jT85B3pG; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VneX0jf0ao9oBAinKs5cALaV7FHnpB1Mk20t5s5UyDPAtEDkcyjrVU9Fk8wxZWR6tZxnsKMSlSLmArd87hiqxzQdEdxyzeqgjvRenLIW7E6PsHLmwkH+fprqNSnunDP1CnYG529nhME8NTNfTesEs8B97K6w0SePokWsTg7q6QnyR+oz8dMAfOJgV2koODmJsvLWITocSCNapAtyHZpdOLFcGkr0IHcB3zerQzuwZhBImTrnvp/JnsDt50jb+3WO907ohFocPkoFxS4rl/BoZrFLvxoGzyaCPQNG3nQm/K29Csq1Et+HNqcigmfHfe9B/MM2QG26p0ymO22YHcCWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feOAxHfutAQypO6ut2f22CEz7nDMcOW4yrtaH9x7wls=;
 b=cI9z64cvOjRfBcIt8Fwfiy16Tk4wAcXsTHKyNbugQDNK89Cah6fk+SCMDSjPUuHqcQm1LHI2ZqdjRgIyj8yGdavFqFwWwPM+vb/dyqE7bNjZ79kFqXklx1P21S+la3xPm8lK5ZZ4R2mCmvtwCXAyAs8sKpxEynp9E4lOmvG/vx7356895F9xlppWjSNIPlKsX2MhP51JLEg72fBZTlFxJ8c7f2e6nrTAFYpq+dlUgayWxfW+Tmry8Wulu6D/h6QmMKaX7Zntf5TtsuC3PGMrsfwovD4ZZl3M+tzdfETHTRGUt9MIGg+GsQ/QyVOuMxcc1HiutKzh1MRmi+eHEzVTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feOAxHfutAQypO6ut2f22CEz7nDMcOW4yrtaH9x7wls=;
 b=jT85B3pGGSmMUr1kI070xsKEqG4RsRIuWoA810AQDv0e62JUwQTxWM9RiUgulGGMeDxTC771NnIR6V7uJSoI2+tIrVv0i2As8rlP/CAKjnWO7kB/y4tf60jERUj+YG/hRfYl5EgJ7NoadZEHwb6mIKo+RRoIP7Dr9Da28vSwWRU=
Received: from MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7)
 by IA3PR10MB8114.namprd10.prod.outlook.com (2603:10b6:208:513::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 08:02:32 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::76) by MN2PR15CA0038.outlook.office365.com
 (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 08:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 08:02:31 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 02:02:20 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Dec
 2025 02:02:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Dec 2025 02:02:20 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B3829xC3686810;
	Wed, 3 Dec 2025 02:02:16 -0600
Message-ID: <cf87ced7-aa66-4b15-98e5-92cb76737073@ti.com>
Date: Wed, 3 Dec 2025 13:32:16 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
To: Pratyush Yadav <pratyush@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>
CC: <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
	<tudor.ambarus@linaro.org>, <mwalle@kernel.org>, <p-mantena@ti.com>,
	<linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <a-dutta@ti.com>, <u-kumar1@ti.com>,
	<praneeth@ti.com>, <s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <87qzunt4n4.fsf@bootlin.com>
 <ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com> <87ecqcakjo.fsf@bootlin.com>
 <mafs0ms4j4fuz.fsf@kernel.org>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <mafs0ms4j4fuz.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|IA3PR10MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6e3a80-e5d8-45ca-c7ac-08de32424f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHpRa1RPQnA1ZlFHUmpYKzNzV2lyeEE4Tk44TUJLWkk2RjE3Ny9EUmVKbjd1?=
 =?utf-8?B?eVh3OGd3bEtXWmI4SGk5ckFyR3RUSmExbG8zdTVvcUpXRmkrck8ybnJCQmJj?=
 =?utf-8?B?d0RFZ0hRVEpsa252d2FaQXVuMFFoeGdmbVJ0c3NsY2pSelg2ZDdtcTBZTE9N?=
 =?utf-8?B?eks0ekZrNzNsNStOR21GcHRybU5LSXNjUGsxSTdsZC8wR0hzY0orYXhTNHhO?=
 =?utf-8?B?cHdDeGo0QVROOC9VZE9mNGEza2tHU2FpVDc0M20wYThjU3BmVWVxeURDYUJh?=
 =?utf-8?B?UUpXcVRUc0d4S3lxVDMyUjFpN2dLR0VGK3U1U0t0U3I1YlJBNGNldFA0bUdO?=
 =?utf-8?B?N011NFJlck9aU3UzNVhSb3JMTmo4RExYZE1rYkhGNDJlQzhJcFJ4NTU2RGt3?=
 =?utf-8?B?eDNSWWUvL0x1YnpwWXZWQUJSZ3pKalBIdE9tY2tlcUFrZ25IZDlPOTViRm1X?=
 =?utf-8?B?V0NOR2FiK2R5R1ZPZ0RqOTJHTUhvKzJGY0tjczdSekZVaWo0TDJaSEN1cGVB?=
 =?utf-8?B?MVptWFd6aHYydUYyU3AxN1Y1Q0UxZHMzeFRRbktNaVBKdTBzMXA3MnlITzVI?=
 =?utf-8?B?c3c5cHV0aW1CT2k5cWxJaTd4UjBkUmQ3Zjl5M05WaXVuSnRXalQwRHRqa05T?=
 =?utf-8?B?MkM2a05aTk9wQWFjaEsvWjhENEsySm5WdExXQTZnaDNKSzd4RVNqWmx4VXRl?=
 =?utf-8?B?dWZSRk5VTVFIb05tOXYzb1YxV1k1QVd2ZFRpRkpvLzN1MTBCV3hDbVJkV2pM?=
 =?utf-8?B?cktMTVdPZi9BY1JoWEFiRWkwOTF0cE9xVzZUa3lDOVhLRTVqK0VEcUsrY3JM?=
 =?utf-8?B?clZtQzk4bWhtYkNCYWFmRis2NnlvVWFPZDB0YlFzdWZaSTRXMGlhYVZQd1Ev?=
 =?utf-8?B?TVdkYlUyTG1JM1FjUFhFcVVxbVVYNHZVOEpEamMrT2JkbmtxZExaV2Q1cDAz?=
 =?utf-8?B?aEcxdGVTbzQ3WkZSMmtLN2Ywd2NQdWRpTDlSY2wrRzJ6bzYyMGZZNkx6aEl4?=
 =?utf-8?B?bGExUGgxbGtpUlNaU0RuQWhidGJOVEhkaTlrb2ZDSnBPY296VTVXelIvc0w2?=
 =?utf-8?B?MzdIdmxYVXRTNFhkWEY2d2ZmMW9GZVExc3RxcHNjcGU0RmZYVEkwWUJhQTVv?=
 =?utf-8?B?UGwrNk42ckt5d0JHbWYvZkJ4bG1hT3Vja0l4ak8rMkNyc3FpdUkxYUhuWVJU?=
 =?utf-8?B?NDJRb1ovKzdYdVp3TUU5bDdlSkxVbkxCbjBmZFlmd0dDNlp0TUVPSkR0RWhL?=
 =?utf-8?B?Ym1QTjJwd1ZucVViOWVlcEZMTUlRZTZET3lrQWVHTDI3QTh3K0FXSms5SVND?=
 =?utf-8?B?d0lkS0dhc2ptWkoranRkalFJVDBXZVorVDVlai9obnZPV1NZSDdYd0hONEky?=
 =?utf-8?B?Q2FYV3lRcHJaY2Y1MitBalhsdWJiclV6dWYzVy84WUxoakg3cHNxN2daeDU2?=
 =?utf-8?B?YXhaMTFlczJBTkJwVjVIeldrTEo4ellaSXZjd2RlSllnNjd3a21nWEkzK1Ur?=
 =?utf-8?B?b2R6OEVoNTdYMm9RR2NsY1ZzdU9FSHhDZldsVjNJM0dWMXZaaWcweXF3TG1P?=
 =?utf-8?B?TzJ5ejU3LzdWUUd6R1NZUi9lZXRrWVMrMmtRMm5zOFg5TTVyUGY1QXQwcEs5?=
 =?utf-8?B?ank1UXdqOVZEYm00R29qLzhpYWxGSWNaTHJkMDU2Nk9TOHpXNXlGWnMwTW1a?=
 =?utf-8?B?L1RVbGJiSFVFOHlYcElxZ01wcE12NVJpTWpqeGh3MTZXbXZmeDNDVjFETHN2?=
 =?utf-8?B?ei9wZUhMcmduaU5ENm45TFd4aUI4WE50R3dNTVJBSWlSSXpWSk1vdi9Pc0pv?=
 =?utf-8?B?MFFzZDRaN0tTM0FuZVVuYU41YVlTRUZNWFQzWVFWYUR6RURMSUtINnpZN1Iz?=
 =?utf-8?B?K0JHNktSZlB0ejN2Q2h2TlkrUUNWNldvZU9lK2FwZkxGVEp1a0xBZnc5b0sr?=
 =?utf-8?B?RWxOeDNBWHRYeTV2Z013aW40RnluYjNqNGNDemR2WlFwV0ZjTWRCMk5GQmox?=
 =?utf-8?B?N1gwVE44Tkt4RjdaMjJJOGRBRW8wQzBOZjZRZTloYzFsajQxMlNnM1FPVWE1?=
 =?utf-8?B?U2U3SFBoUFBFOXl2d1RkcGNQMHo0cldEdVVJKzJsT3RDbVBpUTBWY0tPWEE1?=
 =?utf-8?Q?qi98=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:02:31.4138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6e3a80-e5d8-45ca-c7ac-08de32424f6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8114

Hello Miquel and Pratyush,

On 18/11/25 19:12, Pratyush Yadav wrote:
> On Wed, Nov 05 2025, Miquel Raynal wrote:
> 
>> Hello Santhosh,
>>
>>>>>      - On tuning failure, retry by re-running spi_mem_needs_tuning() with
>>>>> the second best set of ops (max throughput - 1)
>>>> I would like to challenge this need. Can the same calibration fail if
>>>> attempted multiple times (eg. because of the heat?) If yes, then we need
>>>> a fallback indeed. Otherwise, I'd be in favor of just failing the
>>>> probe. Calibration is an opt-in -> users must allow a higher frequency
>>>> than they use to in order to enable the feature?
>>>
>>> It's possible the same calibration will fail intermittently for
>>> different reasons (temperature changes, as you mentioned). If tuning
>>> fails, the driver should fallback to the non-PHY frequency so the flash
>>> continues operating with slower reads/writes rather than failing the
>>> probe (availability should be prioritized, right?).
>>
>> Agreed, if the tuning may fail we must fallback in this case. However
>> there is another situation that must be handled in this case: once
>> tuning is done and we want to use PHY-optimized paths, we must fallback
>> to more basic/slower reads if for some external reason, they start
>> failing, right?
> 
> How would you even detect that your tuning is out-of-date because of
> temperature changes? You would need some sort of on-flash ECC to detect
> that. I think many of the flashes that support DDR reads at high
> frequencies also have ECC, but AFAIK the SPI NOR core does not support
> it.
> 
> Anyway, I think we should limit the scope of the problem. Let's first
> start with the expectation that the tuning supports the whole operation
> range of the device. This was true at least for the spi-cadence-quadspi
> tuning that I worked on when I was at TI. The tuning parameters had
> enough margin to ensure it worked for the device's whole temperature
> range.
> 
> If there is a tuning algorithm that can't do that, then we can extend
> the core to either do ECC or perhaps let temperature sensors signal the
> need for re-calibration.
> 
> But for now I think it is easiest to just ignore the problem and focus
> on the other ones like how to get the calibration pattern and how to do
> the tuning.
> 
>>
>> The obvious choice in this case would be to let this error handling to
>> the controller driver. Re-using the same operation at a lower speed
>> would be suboptimal, because the fastest operation at a high speed might
>> not be the most efficient at slower speeds due to the number of dummy
>> cycles needed,. But I believe this is negligible based on the fact that
>> we already are in degraded mode at that stage.
>>
>> However, this may conflict with:
>> - read retries
>> - continuous reads (?)
>>
>> So in practice the fallback might be needed on the SPI NAND/NOR side
>> (this can be further discussed).

Just to summarize, fallback logic during probe:
    - If the controller reports a tuning failure, the spi-mem client may
either retry tuning with the next-best (max-1) operation or fallback to
the non-PHY, slower operation and adjust the dummy cycles accordingly to
use the optimal non-PHY variant.

And yes, for now the priority is to have a robust probe-time tuning flow
before addressing any runtime tuning concerns.

>>
>> But once we solve this, comes a similar problem on the write side. How
>> do we know if a write will or did fail because of a temperature change?
>> What may be the heuristics to fallback in this case?
> 
> Santhosh, do you have any numbers on write performance improvements? I
> am curious if it is even worth the effort.

There's no real performance gain for SPI NOR, but SPI NAND shows notable
improvement wrt. page size.

Write performance numbers from AM62A SK with W35N01JW OSPI NAND:

    - without PHY: 6 MB/s
    - with PHY: 9.2 MB/s

Thanks,
Santhosh.

> 
>>
>> Thanks,
>> Miquèl
> 



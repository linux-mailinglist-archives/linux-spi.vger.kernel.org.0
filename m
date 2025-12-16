Return-Path: <linux-spi+bounces-11934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333ECC0DB6
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 05:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E23B302C4E2
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A77340A47;
	Tue, 16 Dec 2025 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="td4d0wln"
X-Original-To: linux-spi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD3340A70;
	Tue, 16 Dec 2025 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858109; cv=fail; b=BA313nWDSWZxIGsX76i+2W/Se6+Uh0XP/o0FoZvbDpuVYfyJg5bnhHoG3j2DvQLUQP5rL6ir3KCkTOAZAz2M9+Ui12UklUY0BDNOUk5UV1lkUDbV9dQQKaP+LE7/vCzLcFdzIUJ9DO2WR8ipxvK0aSxHh4uJDLgds+mTgNblGII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858109; c=relaxed/simple;
	bh=//Ydfb129j0WT6oxQDwvVMlmDu7eZYllRoHtx+pxnss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HRnxsqkWsXpaxh03wd3p46GvYtbjw/FWAOtKGoAPZ/tGqxw0dFBmXfN/ceuziQS+pq0x9qsqddF5BRN6qxxD1tOAI8RhqoHv4uIvgSbfqdlUodwVR8YLZuO3rPX4f5j69q0Vi9IuzkFbw5oxYrwdeRyVhEoEwYBG1cVqwgGmV1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=td4d0wln; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVf/loV6Rl0nuXql6kTn0gNfFcvMspLPwaIp1HQv7mOs376MT4nJXApJhpdRDY4s/pcyLSHtE03KEtc9KfEclOtw91ux1TcEHwMgWhmmQMBQLCun8PU8gvMN7gxHlchIXuI6gKHvFR4DmwAyBkGM86WXPWgkxa9Tk7HY0IJrTdtu9HF1DOLGnt+6Q/mrBN0TTZFYQaFly5y2BJ7c2kwC6ZQ+59I57myJ6Bd7skq9uTLVDpsPfGqDSAByJxd5uZ5dQ27h9m/uib7VXbDf9KHI5o3VivcddUBLmN1PeE8YERILHZRwdmCsWQiOtbzmRhbkqZemnLHNYIreQxlFyYeY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgmt5L/3Yy7q3r5Y591G39EhP48jhP6RAs2fKmp9ZqA=;
 b=SW8YdlWBmyqgWmwmpIJFjcqxb6VFCbqSOYrYgsqWPkFKN9fxsIeooY5J8TPw8Nf4iPFKrDEfHBQvpgm6e7Ii+ielFnWNOV3kQjW6pXYJ4Kopc6oZ1Mx0koKahbo99jE+TiRwF+g4pYm5tHcgZMFtyvr4lPinks8J29afYl4+uJXsQp4ntP+A1usxJMkvIp+VAZqCr+ymcPo0vPdIzXD3e/kdU63fMEqNG7bYJLzpWcAvGBsG/FM8rjcf7XvPispFwXgYZFN0G4I/PCmkPMU310k+sMqG+yZ1E9FN4IErrNm8ejQpxyRo37AX8vJBArwP6bh51FYA5HKBNa8Py0sBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgmt5L/3Yy7q3r5Y591G39EhP48jhP6RAs2fKmp9ZqA=;
 b=td4d0wlnlth7SmJ58iz8MPFGfe2eyDpV4NY6UAEUYxs2lgFsY0JiAfJqN3ktp02PLLPiVyp1ASnvqV3wk2cqpbqXD1bBbu5/dlcQIU5/iRQXEavL5b+2LZMBsUPkwUTRZKhNS+SL/areL36K9WRE81HsITtU92SuVzehzxj6Lsg=
Received: from MN2PR14CA0011.namprd14.prod.outlook.com (2603:10b6:208:23e::16)
 by SA3PR10MB7042.namprd10.prod.outlook.com (2603:10b6:806:317::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 04:08:08 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:208:23e:cafe::62) by MN2PR14CA0011.outlook.office365.com
 (2603:10b6:208:23e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 04:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Tue, 16 Dec 2025 04:08:08 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 22:08:04 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 15 Dec
 2025 22:08:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Dec 2025 22:08:04 -0600
Received: from [172.24.21.18] (ltpw0bk3wf.dhcp.ti.com [172.24.21.18])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BG482ta3500759;
	Mon, 15 Dec 2025 22:08:03 -0600
Message-ID: <82ffe3bc-6789-43b5-a48c-a1f490a70c64@ti.com>
Date: Tue, 16 Dec 2025 09:38:01 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence-quadspi: Parse DT for flashes with the
 rest of the DT parsing
To: Mark Brown <broonie@kernel.org>, Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
 <176580718260.161463.4539075429059025833.b4-ty@kernel.org>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <176580718260.161463.4539075429059025833.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SA3PR10MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 263ffe72-d388-4f2f-e1f2-08de3c58b877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZhbERZaDFTYk55QXcyTGlLVFR3aFh5aFlObG83VHFRYmo3U3ZkbWNXRHNW?=
 =?utf-8?B?Q0liaFpDOXR6MFcvZlg5cGlnak9kUW1ST2ZOK3RYdUNSQTdXTHdVRXZIQzZZ?=
 =?utf-8?B?T1E3cHk4aDM3SXhWdFVxWlZmTHJXSW03YzJlWTBRaTRqQVVrT0lFb3JsYkNF?=
 =?utf-8?B?TWlMeHkxRTA1bHNVTk82U2FsdStQZzEwendMc3liQjRBTjZjc25uQkpGZlFE?=
 =?utf-8?B?Y1JteXZOVVdKOGhVc1ZyV0lFNGNpRXY5Y1l6bjVLaUsxM1BiR2szMlhuQjI4?=
 =?utf-8?B?NlI1U0h6b1plb0ZGUHZIaE5YWm50N1R0M3VrajZzNkMvSVVGRWR4dWNCcnNO?=
 =?utf-8?B?b2d0WDhVWGhmdkp0Q0FYNHpsNlZ5eGMxSndrUWhiSUJRMXNtZ2RWcGozS0I0?=
 =?utf-8?B?dmUvd1hodnRFaTlnWDhrbERuemRqYk5vWFNVMCtOVXNPY0owMW9USVZaN3Rk?=
 =?utf-8?B?ZGQ5YXBUNG96cFYvNm55QkkrVjc2Qmd2QU9MWVQ2S05KM1FqWFlPTk1nVDZQ?=
 =?utf-8?B?MngzK0pMajNqTi9PYWd2UnlFc1d0dC9VMjZoVTQyMkhPR01WWDdtZjkxbUND?=
 =?utf-8?B?cklDWDZUeEtscis2NmJySWM1YTd5L1A1UnI0QW5MbXl2WmtjaEI4dk1sa3hE?=
 =?utf-8?B?QUFVanB5L3p3T1daTVBwYUR3T0lVVmNIaHJxbDZBRUxKMFZLaG9UU2xqaXRQ?=
 =?utf-8?B?NXVsWEFLc290ZEhTYXdFRTRsWjBTVkxvZzc2TEY1YTBZTmFEMXJrZGIzdHND?=
 =?utf-8?B?YWZDMlFFM1haQThHSmNrYVhzdStmUGNIVW9zcDJrK2ovb0dtb0ovcEcwRDhD?=
 =?utf-8?B?cHJrWHhDMGkzRlBWSTF0d09tQTZPeTBaQXZZQVYyUDdid3BLWFlzWHI0RFg2?=
 =?utf-8?B?NHN3UDM3cERlb2xqd3VPeEZFTkR6TEg5N01zMzN6cDg1YXBjdjJPMCsxNGZR?=
 =?utf-8?B?NU9ML25meGpmNldvNCt2OE5Ob09xcitEdGphMU0wQlpYUFZiZ3l5TUZNalhY?=
 =?utf-8?B?WUdDSDRVNVR3c24wMlFsRXdoa2FZSklibEJmMlR1N1VCbEZHZlE3cGMyM3dD?=
 =?utf-8?B?Q3RIUENZSkZSbEQ0SW5qZng5eFpFcVFtcVhvUDJPMDRoN3BNWGNyYTNpRGEr?=
 =?utf-8?B?MzhITWxFSFZKWEVrckdudml4OVZBQkdIVzZCZEJTakR4ZnhhYkhwWDdXNlov?=
 =?utf-8?B?Q0xBZ1pFMXcyMWxNN0ZRZHJVWGlBNm1LQVNTQ011djFLL0ZrYkI2aDlLNWVZ?=
 =?utf-8?B?WFlqakJpdVFNWUxBMzRsMlRsR0lrcGllZHd5K3lGdjl0NFZoUnEwakFEWEY2?=
 =?utf-8?B?NjhhS0JYT2l0QVZqMXMrdWZ0UGhKdHU3ekw1Ry9vWWVrWFdKeGJaNEpsbzA0?=
 =?utf-8?B?R3kxZlFFaG4welR3RWNYWXNDQTFGNHgvQXEyQWpwYlM1SXFqcU1VS2dnOGxY?=
 =?utf-8?B?bFVraDU5aWdMS204QllybUhNOFdUczFrL1lzakJFVTJKRHZ6Y1BNaWxuU2RH?=
 =?utf-8?B?bVJoTFM1RmRQOTNRU3dnU1BPdmF3SE5BVE5TaUdGU1dMeDYxS2RUUUZxK3Y4?=
 =?utf-8?B?a0s1L2M3MnZjeGtma0VLQllwRm8xenJNaXN1RFZ3aDZDRzR1cjZscTdkb1FM?=
 =?utf-8?B?N3U1eWlNeUJoT2R4VEcyZlprcUdrZThnZVVGbk1NanQvRTA0c0lwb0IzYkpq?=
 =?utf-8?B?N0VqdHNBR0Jac3FDVXEwWFhBYXljNEpna0lrdE0yYlphZlhBV3dwcUZuUkwv?=
 =?utf-8?B?MVkzRzlHTitxb0dkZDY2dm9TbGhnRUhWRjhNeWw2OEY0MUxHSlBETmtjQWx5?=
 =?utf-8?B?ZWZXQmxIMWNjVmRjWGFYZDUrVnlQamQ3TGVYNU1RVC9SNFYzNjR5SklWR1V3?=
 =?utf-8?B?MXFjMU1rK1JhbUp1YmFQMmxjUFJTVmNXZ2t3OVVUMzNwR0JmOC8yY01ZVXF3?=
 =?utf-8?B?K1NZb0YyckpZOW1maWNuZi9RYWsybWVoMGs2M0l0UlFTWHBhMVVuTHpMQllT?=
 =?utf-8?B?RlNYOXRaT0RTcEFGaFBKNGJndUtiMEtQMTJucy94L3J3cmx4RWsrY1dTN0x1?=
 =?utf-8?B?ckpmaGVrREVkSU9vSUpjMlNkZUZ4Z2Izc2FQSWhZazZpdWY2ZFFPc2R1aElI?=
 =?utf-8?Q?W02M=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 04:08:08.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 263ffe72-d388-4f2f-e1f2-08de3c58b877
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7042


On 15-12-2025 19:29, Mark Brown wrote:
> On Thu, 04 Dec 2025 19:13:35 +0000, Mark Brown wrote:
>> The recent refactoring of where runtime PM is enabled done in commit
>> f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
>> avoid imbalance") made the fact that when we do a pm_runtime_disable()
>> in the error paths of probe() we can trigger a runtime disable which in
>> turn results in duplicate clock disables.  This is particularly likely
>> to happen when there is missing or broken DT description for the flashes
>> attached to the controller.
>>
>> [...]
> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> Thanks!
>
> [1/1] spi: cadence-quadspi: Parse DT for flashes with the rest of the DT parsing
>        commit: 9f0736a4e136a6eb61e0cf530ddc18ab6d816ba3
Hi Mark
I was under the impression that we are agreeing on this solution :
https://lore.kernel.org/all/20251212072312.2711806-1-a-dutta@ti.com/

Regards
Anurag
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>


Return-Path: <linux-spi+bounces-11852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A95CB2D5E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 12:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EC7301670E
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245902FC006;
	Wed, 10 Dec 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bWvolJYa"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB326ED56;
	Wed, 10 Dec 2025 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366495; cv=fail; b=Uf7YcgY55zvV2tdPrdJhRUkT7AH+ZPT5WIfef6dZejK3y+H3uc0+IYhhxFuH9no7P7rzSjPPhSfiSbgIkZe95r8eVXODBNFQAqY5aOX00oeomsRtDDD3twFEAYEpa/yoyRqF5t/jqryWXkFmHK0V2Ws7UKWbHuYdvFwieRJZnGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366495; c=relaxed/simple;
	bh=EWEsJl6DNoH6sgk6WfqMx6m2yEFAtFtTBWsMzCls6AE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=nxYFCUnYKIiujl7oQ2lgnZr2nkZnJFoLBlO/hVtLcHfY/KunPhzuymhPpcZItieeeJmJvy2jH+DmY7Tqh4urttJw1AFOmFTDpD+F5BqHTEJ3aAWAH8SDUSNu0+0otH9RjSBGFQtS0XPASVGIUjrHuc1+5v11jPTu0mQRxE8lswI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bWvolJYa; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9I72NYpiBy/EhBVTWznrL2mJm+9qMRRoCOOQdp2YMKIcf7OQ5If/1xp9IGHrl3uAmbdr3VaAeyB7cz3f8siQ1mljcC6hoEXgkdfUKnR7Tigvn3oOcfp49crrM4C0Kx12g4j/ZjD7xhLY5ELXwrHXX6l9ORWrqgSyZbFEwN44sfymXmimVTydZ21gVpX5UzC0PzAQ0G47XsxxBjRKX9xI3copg3klMiK1YV92EsCTeOdAevdj4juxsns5DD1JGXbbpj5moxlv8DXxVjWZ0ErXp3gJv9VdXMxP5zu5+MYxtB39HrzH15Dk79JK3jWMWsKXes1xB/5kJ+CLO7T7FebDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs9sLSwiWSs18xTk55M+jlMyGGUSMs+v8PgdJqULo5c=;
 b=fLGxv+eqbPcXXd7u0Z79psRGfN5EqsYsunaHzp1LOZJ0kHALtSX+TZeIYo87b1CVUi89l5q8sfJm9X1nhYtMA0iinLg7FNd5HvEeBI1usO58lwn9ezNMrBUmNPw3BvaR7ktPOCP3UtxERB1XmSlLl25Np02MX4gF/+UYA7M8Qd+vgt6UXVgnTsWCLCW7m2xkSJ2iyw6lias4krS677mHK5cPA+cVaqMXKFJZo7kbSCscjRxY8xTgpuPX/rRc8GGxpAwd+9YTK1NKsfDZFlCEOFs6aoyc4EYuzKGf8eoNlZYNVtA97C6bkyOMbpkZS/LFDU6qIdE/EceYjWqakDdu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs9sLSwiWSs18xTk55M+jlMyGGUSMs+v8PgdJqULo5c=;
 b=bWvolJYaeHBsyEUIq1NKgQJhHKXuwTSBfVDp2cSyVmlkbLuM5n2bhrNOufLVlAKrbHBbBySEYtO/RMj3ZVTwsrDkoM9tifulqlKzGhikgQW08h/MJKSHGgplkkAMztVGfMF6Sp8eRQlDSNi/nSRvdCzh3CvVWmevUEIuEM/Yt1M=
Received: from BN8PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:d4::24)
 by CO1PR10MB4579.namprd10.prod.outlook.com (2603:10b6:303:96::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 11:34:50 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::e3) by BN8PR04CA0050.outlook.office365.com
 (2603:10b6:408:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Wed,
 10 Dec 2025 11:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Wed, 10 Dec 2025 11:34:49 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:34:46 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:34:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 05:34:46 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BABYfpX2857436;
	Wed, 10 Dec 2025 05:34:42 -0600
Message-ID: <042979ae-afe6-49eb-8311-00931940a4fb@ti.com>
Date: Wed, 10 Dec 2025 17:04:41 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Santhosh Kumar K <s-k6@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>, Pratyush Yadav
	<pratyush@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
	"mwalle@kernel.org" <mwalle@kernel.org>, "p-mantena@ti.com"
	<p-mantena@ti.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"a-dutta@ti.com" <a-dutta@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"praneeth@ti.com" <praneeth@ti.com>, "git (AMD-Xilinx)" <git@amd.com>,
	<s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <mafs0ikf74fja.fsf@kernel.org>
 <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
 <BN3PR12MB95702234F0F9840C70E42C61DCA6A@BN3PR12MB9570.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BN3PR12MB95702234F0F9840C70E42C61DCA6A@BN3PR12MB9570.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|CO1PR10MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c4a6de-de0b-44af-3831-08de37e0210d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2VvcisvVm9pc3NENTl2Tm0xNkluS0ZZRXJ6bnJUNU1RMGJvSlI3NlhHZHo5?=
 =?utf-8?B?RFFvekVncXpHS1BmUXlpaTcwMVZaRmsreDJQVGdaWndxRmQ1RlI1bFhPcHZj?=
 =?utf-8?B?WGNvdmJ3Q3d2bThVU2dZeEZtSGNzSjd0Y3BZbDZOd0Z0K1NMWXFFeGF0cWRY?=
 =?utf-8?B?QmNuVE0wMTYrNmlKbUFoSTh5YVFxa3kwc1Mxa3E4RXVFSHpEVEdrd0FhK1hJ?=
 =?utf-8?B?QXc4ZGtkT2tTYTVEbzRhN1R1RFNoQnRDUVV1aHNCZC9MVzV3NElCaW9SRkNu?=
 =?utf-8?B?Q2l3NjhMZyt2WmpsVHg2YWdQYVJzZytreDRpb1g4N2hWV2lGTmdvRThYTCtZ?=
 =?utf-8?B?N0tKZHVobHZtQ0VqOWNaRnVDUGVRdUcwY3JyN0VmOUVwcnR3VjFralFFbjJt?=
 =?utf-8?B?eVNOb0ZyQnJGTC84WkxPYWoxaTNQWncyamR5azJpSE4xVXIxdWpiREF6bHBK?=
 =?utf-8?B?NUxLa2NtSkUyR2tXT2lQNjkvbmJDRnZVWVZjUU1IQjlMRGZ3NXBEa0xuOUpw?=
 =?utf-8?B?V0tVRDBoN1hUVzZyR2VJeTFQMzFYOWYwbk5FMGtwRVFidDJVbTBTWEoySm84?=
 =?utf-8?B?VHlCNXFFNktvTmFXSTFtRm1wMGdJc1VTc3RTZTBXWEFmNWMvYTRsbXg4alFO?=
 =?utf-8?B?cGhJdnN6eVM4STUzUloyd0RUVTkrMXRxeWZnNHJwUDRZeUlGa0h6U3QrZUtF?=
 =?utf-8?B?bWpQRzNQRXZ5U2ZBM0ZsNVZNOVdVNldVSVlWK3B4YlFhWTVYNksyc1JNOWMw?=
 =?utf-8?B?ZllOK1Q5aGM2dXNrc2JCa3VSTVM5Q2hSdGUrK0FEWkd6bm1YWVMyR20xMHRZ?=
 =?utf-8?B?b1NZdWNoeHZrMGJ6WGJPT1R5OU9HVGdPd1dnQTlzbEw0VFBoM2p1Wmc4VVh0?=
 =?utf-8?B?ZDJ3a2ZaaVFOQVNLSjNnb0JRb2Z4WmpCM3N4TGV6U3Z1UTQwV09EcmF1cG0x?=
 =?utf-8?B?OG1FSnB1V1k5SVdMSm4vdXRna21jOFBWWXRVTFFSQ3ZnaklQczlkWElOcXFi?=
 =?utf-8?B?OEVoRmdDVjUySXphaGpvcnZpQzgvY2JyRVBCa1hlK0E3YjN4Yk90L2tJbkpJ?=
 =?utf-8?B?QUV3Zy83UXJBVFJJZXBUS05kTDdCNVh0OXl1aTdYTUlrMExwMjRqMzVhYkdR?=
 =?utf-8?B?SU8vc0VMbnVjVXNkM1RzbjhxeTZyOWg3UzljM0RObld3UjBlQlR5L25hZU1o?=
 =?utf-8?B?azZaNEw0UFR2c1JsalpMNkhQYTR1cnNpQnpPR3ErcUpEbE9zZ1MwaDRFL00r?=
 =?utf-8?B?dXFabnVoSUhRQ1h0WENaZnFlRUc2dy9jcjVLcDdpNmJnSzdRdnc3S2c4bXl0?=
 =?utf-8?B?eXNsMG5ZTDdGZlNDZ2RvK0hsc0N2M0V5L0hwOUJnMkFyYm84UWxnaUZtbEdh?=
 =?utf-8?B?NkcyTzQrSzIrUjVGZ08yb3ZpblNNNzF3QW1DTGwrWDVKQllNZGM3WmlqcUZI?=
 =?utf-8?B?V0lNMlU3UjdieXZUa0NFdXJkTHNjQ2tHb0RXdlpXTVNiTUFXTW0rMEV3bmxO?=
 =?utf-8?B?VXJQbkFFb3NFdlZibTRwU2k1ditTckoxY2tzTjhkSS90RWdJMWtPUzhSMnNn?=
 =?utf-8?B?RW8waCsvditGM0ZFLzNPRG8vVnhUcGZzYVJHMG1YTVg2UmNVMXQvYjBDaTVl?=
 =?utf-8?B?cVEyVUhSNVhnbjAvTkFmNzdrZnRNMGplcy9DcmJCSU05SHVudzdlTWZJZmdy?=
 =?utf-8?B?cElIMW5ja2REWndvYWZXQjVLNzF0VGwyaDQyZ3BDalNBMlVZeHc4T25PWWlL?=
 =?utf-8?B?UnlLTFZXMXhkdVhNWEpwMXUzYzFvblByMnI0V0I4MjBsbFpnUjduOXN1WlY2?=
 =?utf-8?B?V3grNEhwZCszbkRKVTFCdTV5R21hNkQ4K3VqaWtLSCtWYzVHMTdLejVMT2FU?=
 =?utf-8?B?eXJkc3c5NGxHWExhc0xBOFBzRjZoNmY4MVpWVVQ3NktDaVhQSVE0VTJ4MFBT?=
 =?utf-8?B?WGdCVHBrQ0lmU3JCNE1Ibm9aQVhDSjlqbEVjUitPUU1kUTVvL29iTnQ0cThh?=
 =?utf-8?B?ay96eHdNbFVZTHh5S0ZneTd4T1hIdHZxczNuSjFSWFRMMlBGaGtpQmlsRVFy?=
 =?utf-8?B?eEsxWTNKMENGZi84T2lhY0RQeWI0NE85RzlJWU1EVENhWE01a1M0ZEhsRUM5?=
 =?utf-8?Q?lUis=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:34:49.8681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c4a6de-de0b-44af-3831-08de37e0210d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4579

Hello Amit,

On 04/12/25 22:24, Mahapatra, Amit Kumar wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hello Santosh,
> 
>> -----Original Message-----
>> From: Santhosh Kumar K <s-k6@ti.com>
>> Sent: Wednesday, December 3, 2025 1:32 PM
>> To: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>; richard@nod.at; vigneshr@ti.com;
>> broonie@kernel.org; tudor.ambarus@linaro.org; mwalle@kernel.org; p-
>> mantena@ti.com; linux-spi@vger.kernel.org; linux-mtd@lists.infradead.org; linux-
>> kernel@vger.kernel.org; a-dutta@ti.com; u-kumar1@ti.com; praneeth@ti.com; s-
>> k6@ti.com
>> Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
>> controller
>>
>> Hello Pratyush,
>>
>> On 18/11/25 19:19, Pratyush Yadav wrote:
>>> On Sat, Sep 20 2025, Santhosh Kumar K wrote:
>>>
>>> [...]
>>>>> This is actually wrong. Tuning is way more generic than that :) If
>>>>> someone wants to use a chip at a high frequency (50MHz in your case,
>>>>> but whatever, there is a threshold above which additional care must
>>>>> be taken), it must go through the calibration step. It does not
>>>>> matter in which mode you are. Calibration would still be relevant in
>>>>> single SDR mode.
>>>>> This 50MHz bothered Mark because it is too Cadence specific. Maybe
>>>>> this should be a controller parameter? If the spi-mem core (or even
>>>>> the spi core, by extensino) sees that the design allows running at
>>>>> XMHz (due to the SPI peripheral properties or simply the absence of
>>>>> any limitation), and if the controller states that it requires an
>>>>> extra tuning step above YMHz (and X > Y), then it launches the calibration.
>>>>>    From a core perspective, I would like the calibration hook to be
>>>>> as simple as possible, because what "calibration" means is highly
>>>>> controller and chip specific.
>>>>
>>>> I understand the concern here.
>>>>
>>>> Let me point out the options for launching the tuning procedure,
>>>> along with the issues in each approach.
>>>>
>>>> Option 1: Launch tuning as part of spi_mem_exec_op()
>>>>      - After spi_mem_access_start(), introduce a
>>>> spi_mem_needs_tuning() check (a new callback to SPI MEM controller)
>>>> to check whether the current op requires tuning
>>>>      - If yes, we call spi_mem_execute_tuning()
>>>>           - on success, mark tuning complete in a flag within SPI MEM
>>>> Controller private data
>>>>           - on failure, we attempt a fallback by calling
>>>> spi_mem_adjust_op_freq() and drop to a lower supported frequency
>>>>
>>>> Option 2: Launch tuning within spi_controller->exec_op() implementation
>>>>      - Very similar to option 1, except that the
>>>> spi_mem_execute_tuning() is triggered from within the controller's
>>>> exec_op() implementation (no need for spi_mem_needs_tuning())
>>>>
>>>> Drawbacks in option 1 and 2:
>>>>      - Tuning requires multiple reads of a known pattern, but the
>>>> flash may not always be in a state to allow read commands
>>>>      - No fallback on failures, can't make flash-specific adjustments
>>>> in case of a tuning failure
>>>>      - No access to write_op() to write known pattern temporarily to
>>>> an on-die cache. Pattern needs to be always burnt into the flash
>>>>
>>>>      - Plus, in option 2 - we can't call spi_mem_adjust_op_freq()
>>>>
>>>> While the need for tuning is dictated by Controller specific
>>>> characteristics the ops (and state of the chip) required to complete
>>>> tuning is under the control of spi-mem users (spi-nand/spi-nor).
>>>> So, it's impossible to achieve tuning without the help of spi-mem users.
>>>>
>>>> So, Option 3: Launch from SPI MEM clients
>>>>                             (mtd/nand/spi or mtd/spi-nor, etc.,)
>>>>      - Once the spi-mem chip is completely enumerated and best read
>>>> and write ops are chosen call spi_mem_needs_tuning(read_op, write_op)
>>>> as a part of .probe()
>>>>      - If tuning is required, call
>>>> spi_mem_execute_tuning(read_op, write_op)
>>>>           - If only read_op is provided, it implies the tuning pattern
>>>> is pre-flashed to the partition
>>>>      - On tuning failure, retry by re-running spi_mem_needs_tuning()
>>>> with the second best set of ops (max throughput - 1)
>>>>
>>>> With option 3, spi_mem users are limited to calling
>>>> spi_mem_needs_tuning() and spi_mem_execute_tuning(). Rest is hidden
>>>> within the controller drivers. If spi-mem users change read/write
>>>> ops, the above sequence can be re-issued.
>>>>
>>>> The controller can store the read_op and write_op in case of a tuning
>>>> success and periodically re-run tuning, ensuring we always have valid
>>>> tuning parameters.
>>>>
>>>> One concern with option 3 is that we may not be able to make use of
>>>> static data on certain flash as tuning patterns (like reading
>>>> parameter page or SFDP table for tuning instead of controller
>>>> specific attack patterns).
>>>
>>> Why not? How else would tuning work? Do you expect controllers to
>>> first flash the tuning pattern and then tune the reads? That is a hard
>>> no I think, since you don't want to over-write user data and I don't
>>> think we will ever have any area of memory we can reliably over-write
>>> without risking that.
>>>
>>> I think we should start with the requirement to have the pattern
>>> flashed already and figure out how SPI NOR or SPI NAND can discover
>>> that (perhaps via NVMEM?).
>>
>> I agree - having the controller overwrite user data is a hard no!
>>
>> For SPI NAND, a program operation happens in two steps: data is first copied into
>> the internal cache, and only then written to the flash during the program-execute
>> phase. This is why the tuning flow writes the pattern only to the device's internal
>> cache and reads it back it from there. This avoids touching any user data on the
>> flash and is already implemented in v2 (which I'll post shortly).
>>
>> For SPI NOR, we do not have an equivalent "write-to-cache" possible, so we still
>> require a pre-flashed pattern region. At the moment this is provided via a dedicated
>> "phypattern" partition, and its offset is obtained through the of_get_* APIs.
> 
> I was wondering, for SPI-NOR devices, why can’t we use the "phypattern"
> partition to write the pattern and then read it back during tuning? Since the user
> would need to define a specific partition name (i.e., phypattern) to initiate tuning,
> that partition could also be reserved for tuning purposes. Please let me know
> your thoughts on this.

Yes, the 'phypattern' partition is used as the source for the tuning
pattern on SPI-NOR devices, but the pattern itself is pre-flashed. We
avoid having the SPI-NOR core write the data, since the driver should
neither need to know the pattern contents nor modify any persistent
flash region during tuning. Keeping the pattern pre-flashed ensures the
tuning sequence is read-only from the driver's perspective and prevents
any risk of touching user or system data.

Regards,
Santhosh.

> 
> Regards,
> Amit
>>
>> Regarding ways to locate the partition:
>>
>> 1. Using NVMEM:
>>      a. Exposing the phypattern partition as an NVMEM cell and issuing an
>>         NVMEM read during tuning does not work reliably, because NVMEM
>>         ends up calling into the MTD read path and we cannot control which
>>         read_op variant is used for the read.
>>
>>      b. Advertising the partition as an NVMEM cell and using NVMEM only
>>         to fetch the offset is not possible either. NVMEM abstracts the
>>         private data, including partition offsets, so we can't retrieve
>>         the offset as well.
>>
>> 2. Using of_get_* APIs:
>>         Using the standard OF helpers to locate the phypattern partition
>>         and retrieve its offset is both reliable and straighforward, and
>>         is the approach currently implemented in v2.
>>
>>>
>>> I think SFDP is quite nice for this, but IIRC for
>>> spi-candence-quadspi, that was not a viable option due to some
>>> reasons. If you can now make it work with SFDP, then that would be
>>> even better, since we don't have to deal with the pain of pre-flashing.
>>
>> The current tuning flow requires a specific stress pattern to ensure robustness, and
>> the SFDP data aren't good enough for it.
>>
>>>
>>> Overall, I think option 3 is the most promising. Options 1 and 2 will
>>> likely add so much overhead they will end up being slower than non-PHY
>>> reads, since tuning is usually quite expensive.
>>
>> Thanks,
>> Santhosh.
>>
>>>
>>>>
>>>> Please let me know your thoughts on which of these directions makes
>>>> the most sense.
>>>>
>>>> Thanks,
>>>> Santhosh.
>>>>
>>>
>>
> 



Return-Path: <linux-spi+bounces-11853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD284CB2D6A
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCDDC30056CE
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F7631B111;
	Wed, 10 Dec 2025 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KxsUDgj+"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DC31AA8B;
	Wed, 10 Dec 2025 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366585; cv=fail; b=tvefxjOK/MZQWAtiCcbkFLFW6ROhK7hPgwGmQYllCQKGBeRLXxfYdQ3BN/CpZWpZ43doQ74mOip/4vzD/rqRzqtxyyonuGqpspU5emBubzR5+/cGycMLC2wDk3jcGzvy44MCPNFTL1RhqmNK4WvP/DFn/selR5YQTktsqkB16ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366585; c=relaxed/simple;
	bh=/QVz/MIBLOpW2B3szzOjIHaP4P83oCO/Av6kXt9Pi8s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=LAJgQuA9AtQti6p15aczVmOjYK3oTpo9naNUTReCw8JohtaJ4oreBRt7KBXftB1vmNQG380jifrHbHWmiCddIsjd5afK8mWxrIiSg8O530q/eaugtBe1oXg283445xNyuxhHzDt+1119tI8wuKhOBtT23R/7pxySha088cBh7AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KxsUDgj+; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLif0Ee84h5pY3k6gitmFCoWxFpoFAbKfZpdYxxeRV6A0g3QgfHUNkzmpc7z6px3d4BpBtyZy/vLVKRGEQfJlu3L6qdYObtLJQMTozXkwhsaxgVW+uhgmFbqhOF5Xkfk+QvDh5Q3Ld6tx14UU6T7MwrUD9D3ZwqTbDQMVKMROYryneWoSj9vAjXFUs8F7Ui5VjfiRdRwFk/lIQiVJArDXAeMig+2P2ukPIgDMktY7h9U74OQWqymF6wPLuhyoA3DVAmwEg1WHNzQJR7epLmn2Di+2RcnesxjEEFlbWXKNwx9dsqe9H0hEKrKgsS9IDG0HtmglUsM0TqZe1+79eo9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waT8Fzl4U1OEcTJTMsyxTdFLEypPpPB3p1/FOsoX1dw=;
 b=kWNpPsViWa8gPA/BIg0/NWsksEvXdxLZ7Ci3n3An5YKJyDjSFza+d4BeZ6UrRif3AKbIRPSwJY8Srbn2P2TcLCCEsm9+FxAgtBMdZN75uFPm3RVBGqpQ8YNlhn1c1thjWbtwrYaIw8SxzKwNRqL7A7WngJW0vdPu3dnKFCbb+rQYZIEfE8arrpALWtnoUoMS/abJVsiOZNb7FyfC/kVw/sehI+Io6phNWtvVCi00UOXqTlaetf9BvwC72q8ruuf/RBYRYYAuGUHdPrPMhTEyYa/FjjgiavlA3O5hev0EGs/AU1V40eiZ37144zsfftWYV0St8H+JyR4Cjnt0yglYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waT8Fzl4U1OEcTJTMsyxTdFLEypPpPB3p1/FOsoX1dw=;
 b=KxsUDgj+tAI5+SirINk+wCTQpE3gQqvf+hOq6Pb+12mkD6l6DRKuZlGHTEhnJrRuPnLQvVn0M0ldVbtGuSJ12K4Z5SzXBDLBse7qmUfmInJK8q3ItgbvR/QeR7zvzlh1gjuE1jR4UVxcGr+jp23IFpeHQ/kdfgT1xYwQV5JpIMs=
Received: from CH0PR03CA0411.namprd03.prod.outlook.com (2603:10b6:610:11b::27)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 11:36:21 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::4c) by CH0PR03CA0411.outlook.office365.com
 (2603:10b6:610:11b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 11:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 11:36:19 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:36:16 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:36:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 05:36:16 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BABaCCs2893034;
	Wed, 10 Dec 2025 05:36:12 -0600
Message-ID: <66d40c4c-07d0-4474-a288-ae9945a2b269@ti.com>
Date: Wed, 10 Dec 2025 17:06:11 +0530
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
To: Michael Walle <mwalle@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>
CC: Pratyush Yadav <pratyush@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<broonie@kernel.org>, <tudor.ambarus@linaro.org>, <p-mantena@ti.com>,
	<linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <a-dutta@ti.com>, <u-kumar1@ti.com>,
	<praneeth@ti.com>, <s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <mafs0ikf74fja.fsf@kernel.org>
 <fe103265-7a68-41b8-b168-15a5e19abb3f@ti.com>
 <DEOH4AUI33SQ.DGKJ4W258658@kernel.org> <87jyz3ao8b.fsf@bootlin.com>
 <DEON5LMMZLWG.21BQCPB0YE904@kernel.org>
Content-Language: en-US
In-Reply-To: <DEON5LMMZLWG.21BQCPB0YE904@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SA2PR10MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6322bf-b7b9-4eb0-5b8e-08de37e0565b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWNOMFhVWURpczk1M0VySmJOblVYL3lyK1ZvcExUWDNsbno2QW9uRFRGZXhh?=
 =?utf-8?B?Tzd6cThwSmg3aUwwWUNsNEhvQTY1K3hMZ3UwVGdyRHdGWng4K0YwT2JoYWlX?=
 =?utf-8?B?QXhLS05Hb3RNTjE4aXVEbXVxaktaSldLR1V2enB1dmtnMnBadmY4L0laN1RM?=
 =?utf-8?B?WkNuSGYrVHczU1JuVTZRYkFZa3JzNXZGWmdjZFp0aks5YVRvdzBiZVh6dGtu?=
 =?utf-8?B?L1VFa0NaZTh6ckNYaXFDZXluMkZPYkZBSVZVbDhHbEJnL3BjcnNVTkw1QzZT?=
 =?utf-8?B?T2RTa1cvd0ZjV3hlY2NDcmMyOUdxM1V2dHdhVDNLbkpXTktYVXRvQ2p6ZHU5?=
 =?utf-8?B?VG1BWmZSWkpaUzZQRmw1QzZ5MVZvMWhHTFVuSU0vMzF0L3J4UTE4Qk9Md3Bi?=
 =?utf-8?B?RjJILyt1QTNSUVNST05LN0ZJU2J6a1l4bzQ0bzZ1T3BneXdIbEVQQm9UcVdu?=
 =?utf-8?B?eEpVdG9icWdaUGNYNUdwL01Dak50NGJiZ3pwbzErVVVVYkpyQUY2Z1lDL2VU?=
 =?utf-8?B?NzRMOWRnN3E1YzdjRDhsZmhtcVgzYnBjMDdZQ21pZUloeStiSmMyT05ReVFY?=
 =?utf-8?B?a2JyVGhHcFMrNkZITzBzSmJiWXNIZ0hjY2dXMjNCZDVISjdpWmdIYllBT2d6?=
 =?utf-8?B?TFF1REt1Yktxd2pIWVpLWE9JNVorWGhidERlYVdjdWpKY1E3MXBUdFh2WnRF?=
 =?utf-8?B?bDNrQzJ5VGdkVlQyQTZnZ0lQZU1nUjFQaWFXOTZ3ODQySUU5d0kvelFyOFNZ?=
 =?utf-8?B?MVFPNXpEQTVxbTUzbllIRzdYSXM5WkUwcGFIaEtOV1lWMzl1YnBWR2M2NW05?=
 =?utf-8?B?NFR0L2JGenRyTkVIWlZySzdsbUdOZ1JKRWhQdis0cE96dUcvNTFieGVpZmxO?=
 =?utf-8?B?dTZXL0lqcE1sY3l5dXREMVV2anJKVGV1eTlpMzVQWVZBOEVUWGxyZlBBZGFV?=
 =?utf-8?B?ZEhUeVVXN1h4dnE4K0pzb29ZNjcvNWRtMnlndkw2dmtwL3JTZ2ZwSEJ5NmZu?=
 =?utf-8?B?ZXowM2ZMOTlXNGRPM05nTWd2RlpnMWhOcDVjazc1eXQ0UkVyZkI5eVUwRFVm?=
 =?utf-8?B?NVFoNWdlUUszQkRGUUFxcWNhM0J0M2lKK3dncXJjU1M1WDNOeUxWZU1ZUE43?=
 =?utf-8?B?ZlcwRkVJS0ZWT3RiWVc5aXZVcFRMUTFJV3YyTGpVL3FGY1FSb0dHUnY3RExh?=
 =?utf-8?B?eEpxd0F0b1hNaWJLRW81MDBBMzRkdU1HcXhKeXpLeXoxTFQzVXkvOXNueWlE?=
 =?utf-8?B?ckdvNi8vbENsWEw0VlcyalhFN0V1elh4V045Sm1POHIreFpSNDVnNFg4dnB1?=
 =?utf-8?B?NmVWdzZPVG4xNFVVS2d5MHo3WmI4b0M2N0xMUFduVjBBaTZDWFpldmdVMlJa?=
 =?utf-8?B?T0loV3RXdEJIUnkvV0VoekozZG5oZmNrSG5ac2cxK2thQUFWQXVQaGxVcWEr?=
 =?utf-8?B?VnRuMXR3VnlMOEJqNVhuWnZOc3p5OHJhdzdqRWNWbjBnV2poenpkWGFRKzAx?=
 =?utf-8?B?THp4SkV1dlJrZ3lVV2U2bmpJOWNabWdpMXlMNDBVVDhCUThoVXFqa2EvdFlr?=
 =?utf-8?B?T1V6elpGSjJHYjNHY283QWF3N05pczVoZy8xdFlvL21GYzRTcXJiQWpuK1VU?=
 =?utf-8?B?V3AvQU4wdjJrRkxJam9jZkd2T2N2UStMdmoyQ0lnR2RWUVEzNUlONVdYejBl?=
 =?utf-8?B?V1M0a2Nwa2dVMEdnNDNFMDVwb29Kc3YwZjFrakxJZ0JwNUVPMFR5N2hCT0lw?=
 =?utf-8?B?QUFnUkJTa01iOGVRVWhtYnYrMFp3dkh2MHM5Y2dJUWJ5VW85TFV4aXRESXBP?=
 =?utf-8?B?Ty9CVHU5Vzk5L0tOcFRPRGVBNHRINHM3T1h6THpTcjE3UWhOVnRsVDdvNWR1?=
 =?utf-8?B?TXNiREpGL0ZYUjlBR29tNW9hbVdpdnUrVDY5MytrNDI2N2NOWDJpOUZMQUVY?=
 =?utf-8?B?RUpXUi9ONVZYdVZpOUR4SXVkaWN3WjNSU3RuckJWQXZDZFlZN0VSeUFTZnk1?=
 =?utf-8?B?R1dKbWRLczJHa256a0M1WGthdVY0Z05ZalJxalZpRGpCT3ZaQ29lM1U3elhL?=
 =?utf-8?B?cFNtVUdJakc1UU5rdzN2bHVoNHB4dFBsenF3S2FIelZpZUQxUG43a2ZLY292?=
 =?utf-8?Q?UVu4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:36:19.3565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6322bf-b7b9-4eb0-5b8e-08de37e0565b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556



On 03/12/25 19:42, Michael Walle wrote:
> On Wed Dec 3, 2025 at 10:50 AM CET, Miquel Raynal wrote:
>>
>>>>> I think we should start with the requirement to have the pattern flashed
>>>>> already and figure out how SPI NOR or SPI NAND can discover that
>>>>> (perhaps via NVMEM?).
>>>
>>> But we should also keep in mind that certain flashes might return
>>> tuning data during the dummy cycles. I.e. the PHY might probably be
>>> tuned on each read and there is no need for any pre-programmed
>>> pattern.
>>>
>>> I'm not saying it should be implemented, but the current
>>> implementation should be that flexible that it will be easy to add
>>> that later.
>>
>> Conceptually, yes, but in practice, I know no controller capable of
>> using just a few cycles every transfer to calibrate themselves
>> automatically and reaching such an optimized speed state as the cadence
>> controller is capable of ATM.
> 
> Then have a look at the flexspi controller. I.e. look at the LS1028A
> reference manual "18.5.15.1 Data Learning with Flash providing
> preamble bit".  The sequence is a follows:
> 
> <CMD> <ADDR> <MODE> <DUMMY> <LEARN> <READ>
> 
> There's an example with the learning pattern as short as 8 bit, or
> - I guess - 8 clock cycles.

In this case, we can skip calling execute_tuning, since *_exec_op
would be able to perform the necessary tuning, right?

Regards,
Santhosh.

> 
>> Despite the end result being close, I would still consider this other
>> way to optimize the I/Os somewhat orthogonal. If someone has some
>> knowledge to share about the training patterns sent during the dummy
>> cycles, I am all ears though.
> 
> There's also a short chapter about the training. Basically, it will
> just compare the read bits with a predefined value (which is max
> 32 bit long) of 16 different clock phases. Which one is chosen is
> not answered though (ideally it should be the one at the center of
> all matching clock phases).
> 
> Now how good that tuning actually is, I don't know. But the
> procedure sounds sane. I'm also not sure whether this (any?) tuning
> will account for different I/O trace lengths of if it is assumed
> that they have to be trace length matched for multi IO flashes.
> 
> -michael



Return-Path: <linux-spi+bounces-1726-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7955876596
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 14:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9A01C21366
	for <lists+linux-spi@lfdr.de>; Fri,  8 Mar 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930BA3BBC1;
	Fri,  8 Mar 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZwcWZeEc"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866EE38DCD;
	Fri,  8 Mar 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905695; cv=fail; b=fShApbbE1Xxdzmm0Y37O2ClBPdSe/DOPowSxDjj2ciwzkkOyJJFCztybzVphOVygh4Ft+b7+7McM67K6701HUl8zqNP6e3GVu9G3y4hf5pOHQeqUoV3MnIux9YXObhD59satgX76hZsWBoQ4sRf5gL5dL+t3Kfz0w91+b6zPsYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905695; c=relaxed/simple;
	bh=pJpH4XhLqm9OOni86Wba4pndyKGj4tE4DDlsYY5SThQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l67Wngu5J3vH9TgSMQRgxmTfclJit7PCHnEVbmsbmjDzrqpFfRieKY840gfBQcahSlTJP2xNajZi9r9tm8Qkodx0cP3fI1KfP2QVeCp6ABok7jqg074uml4bG0DHJ0PCzs9sZtVVyQEVdWbUaEFMGv0D81KS1kCoez/hrHfRYTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZwcWZeEc; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3wJAp3iU+Mbmdmh6e8eev5lrsAB2kMmSBXaHfqVz00IsdoKH0ICxZ1koQ30X/PsQPX2f/8N+DSbAmp6liUAJf8APg5b4W5Z8wZXro0WaUlqMhVwUN3+ujY2CV0S2b/3MKHT8yX+XnBUbxDn7vIEvsI4P2qIO1Ezub9XsPMPx5QO30O3eubyj4YVy4iJKdGfHzztAU8PcqwkjfXbibsKYeAfOHL2IIvcUGwWWaJylqGhXcSeqBpUm+mBPHvS5ZqCjooB4d94kQa6NGgN31labU7mEUnXW0EfkL/40qsRZXRsxAVcbzfD9Zj2JqkSd26eYv6Rzb117EAZ8x5S0NUd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukcvLM3HYB8B0V0sO/HSJb83u6OTXkGYFDhIOpterq0=;
 b=MRO1v+GVtXxptIN41TwwJjzzo5Bl2wni29q1JqO0bKQxQQDMpskC//VXJ9N+JbE9jhAWaVY7RVLZ+U5xaz6ibP/PUZ11hdIwHGdp5uBwCZ6QH8Ig56CnElTScSCyAw+akpF52u3duz7Qy4jEqWECc1TN5qhlegqYfVX9g737LqxXDFfwJ5CcYvlMyAPoJviD9AI3bVPVGGn1RAYhlAs64OragBi6FUs+KTRpLcRmP9RyUlpAky5O5294yAgKT67Z1ddNvynSWyeGpONXRWDe4Qd2+atKCIDaU1dUPzFL3P896rUouIWYthIuQHfGGVxt91iAwXRiISDR1XbC2p7+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukcvLM3HYB8B0V0sO/HSJb83u6OTXkGYFDhIOpterq0=;
 b=ZwcWZeEcrUwjiMNcpfsyRjMpC2JmXseLRziJ0dDNjVVEeGi4BADgCEjhuEe+nUCg2diTgCM3SaZJuDJ0MMtJB4F3I1/z5tigDTrYFLFw3y/Wp9muv+ANwFZpjomvsUUJJ9raNHNxmch+uHdmaxcSdLgP7wPXZoyeM/v0WkSrUgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 13:48:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 13:48:09 +0000
Message-ID: <1e35a288-0a11-4df6-b7c5-82e5cb6e1d3c@amd.com>
Date: Fri, 8 Mar 2024 14:48:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20240307154510.3795380-1-andriy.shevchenko@linux.intel.com>
 <20240307154510.3795380-4-andriy.shevchenko@linux.intel.com>
 <f7a882c8-5858-4d6b-8a70-0702c3170661@amd.com>
 <ZesTS2LDEYz_bbPK@smile.fi.intel.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZesTS2LDEYz_bbPK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0020.prod.exchangelabs.com (2603:10b6:a02:80::33)
 To SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6d02c7-db87-46b6-89e3-08dc3f76638d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q+LtP6OG0A20EfLAVGk8drCjazTLpsQK6NZLduOGa6twxVsGQ/KQgsfoC/pjosOugUIxqiECyvZc9ECB34enBdy73uc8Rh2DXuks+CaTMXi5QaDB4zrTUYFnojYbvw94krQSv1PMe1snMhIzaB0HHUv7FrTsHmqssOwIATuYKqWjULiKgoHiEywgYEXLqrgV1GoVaMeFo3042aQfkYuWjwlqXd9TWpfvtlSZ8lyQPjnnXSM0Jvy9TBlfR9WQ8mYan5QNGj7X1N4qtRGs3p9s0rnaOt+vvQD6eS7+USIuHJVA+fGqZ1PbbOhmuXoDZdTA/V+ehFrQAo0oeQACiMxDyWKyWnhZbxFu/jBRWCw6QnDNMK4NpfOlCSxjBI8X3LtSNi0VF4LyKCuToEAPQVMnpeEI468OBHyG5ayhetLckJAmedpcIxEInHyj2iN2Tc81EJ5IlB3JgknrZFMy21fasglPzbeFsXbrlSpziUggObooSYDhU0FQT0bYR08Bz5jg/qaeOCaB1sN4sAlkNZOrCETN/ww2BRdbGhFqrz3vdwElQH3hzOl2PxQAhGmXT7nmSVlObIWAni8VNSV+GHjoUyeYoKNVZlu0SbGptO6Ym5jLbvn1OQILm9Yu+wdjJRJWBkU0tYfJyvADs0aFfMcMfB2lsxYAIT0dkp//iLI3CYE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzBSem9OblpmcVUzNDF6ZWFWRHlwbjVlc0RGcHVBWXFvYW9mWVUzZFFnSUZ6?=
 =?utf-8?B?MEtIUWE2RVN1UmMzRWZRQm1wM2MrMFR6QVUvaEt3Z0xOcVFnMWRGMWs4RWJl?=
 =?utf-8?B?VmxQaHV4UkJSR3EzMlF0TGYwdWFvTVVldGpNZ3A5SVgzcG8rMThkVUcveVdQ?=
 =?utf-8?B?RXhiZ3BBdWlBVFI5S3BXcXk3UXlNWktMMTRhRndIQlRWQ0FYTWl6VVdwY0hU?=
 =?utf-8?B?Sll1akd5S0hFUk1udDRvTUwwUVVCZ25sTlc2WDhIZklLaXNYMEptdldWbW9G?=
 =?utf-8?B?RU5RdkVUV0VoVlh0R3ZIUEtEWVFTSzRxRjhTSVpncEk2QStudnJuYmZYMHNq?=
 =?utf-8?B?S25Cdkswbk40Z29hQzhTNmlRRjh2aXdOMDJGY2RTLzFjZnFicFFDTzVUTWJt?=
 =?utf-8?B?TlRrTVpNbDg2ZERSZWdJTzVZa1l2cWlHMCt2Sk1xQ0s5RXE5K29Qc0E4Wk1B?=
 =?utf-8?B?SnU2eHU2YjA5d2w1bUd1S2VCL09DV000SkptUE15RFJjUExqcDdqRjRXby8v?=
 =?utf-8?B?ZWp4L2lLb3BtS3ZwNEhoR205OE1QdnZLSE1oeFhoOUhDVm4rRmZDb282V0I1?=
 =?utf-8?B?L0ZZK3NXeTZwTlVUSVpLT01NWEVZNVhiV0dGTDJKbUNLU00wenlneWVSV1ZP?=
 =?utf-8?B?S2l0MmlRcyswMWFXLy9QMjFLVmR3Y0dacFN5Vy80TWRzMTEvRy9HRWx3VEhs?=
 =?utf-8?B?VC81YUNiRnVpY0txcGc2ZUM5Z21BVlJmWVA4WWd1TnhrUEJsamxVUnh5dlNw?=
 =?utf-8?B?aHRoZ0tUZ0lLMmFQcWxZc1krRWtwc0U3aUtkRDdkZmQrUHRRUWYrVWRDWHlv?=
 =?utf-8?B?MnM5QjlxZG1kblhITXN2VVVVNTluWHVWTlRhQ0d0VklFSFVhYWVQYlFwb3Rt?=
 =?utf-8?B?YllIYzJRLy9CZ0dmVmhHeEJqNHd3bmo1TTJ2TC9Wc3BpbWUydDlTWFlncm1W?=
 =?utf-8?B?SmFsQVdEUWMwalJJelJxOHFxUWJQdEdLZy9KME5RajBralpLV3NHSWh3cUQ1?=
 =?utf-8?B?N2NHT01XWVlGczgydVllc25tbHFzNHdXYkFKeUkvUVlXVnY4eFJsczkySG5j?=
 =?utf-8?B?cDRTdzBaOHpVZ3gxeUVyNUxJTjRDa0VPYVV0MWZtLzBkMFl4cG1TT0FVWVgx?=
 =?utf-8?B?QWVaNDY2REhSMFNJT0xzRHUrbElOK1VsSUR1NXI4elQ1bytjaVJkbTlpSyt4?=
 =?utf-8?B?cWJkVWUrQkJFdEVObHZTL3BZL044UHZ3MDVwYTFlK2xmUE9iSWRYZWd0REpD?=
 =?utf-8?B?Z2Q0bmtUSDJWRG11SEkxdVBRdjk0NjJsR3JLU1g5b0Y4QWlmb3hLZm5qQVVl?=
 =?utf-8?B?dk9Ya0JOOUFSYU9haGlhNVNoODZ4Z0hxVmVDUDNRVXFDN2JHbHBjSzVFQ3ZB?=
 =?utf-8?B?cjVBZ0xORThtUDlvNEV1T3FTMURqbVRtRXlRWGs0US9IbDRKL05mRFloMkJV?=
 =?utf-8?B?WnhyYmE5V0t5bnpKS1FoTVN6ZlZ4cFVJeU9odFhMSDc3by9GelVuMmw4M05I?=
 =?utf-8?B?RmJzNGlGa3gvbElFaFhleXpKSFNUNnNyenlzNk5wSmJJL0c1RU1mTVBidkpN?=
 =?utf-8?B?UmJidXMrLzQ2ODJ4Qk5sTkxvVFdXYVRydjUvSjViRjk2OW84Ty83ZzlPSlFp?=
 =?utf-8?B?NGV4b202dU42REFjdEhSdnhlSWxVcWdBa3Q5VXFXVkhUU05rTUVBeXozRndH?=
 =?utf-8?B?SWtKSWNMMU0vVEdwQjhtQUwrV0FhUHZsa3VIRnJpUWw5bldvTE5STU5zbzNO?=
 =?utf-8?B?b2xsQWNPbUFSaXA2RGtZOE90bWlEOHIwc3M4QnFCeEU4Y2tZRTlWam9YNzBJ?=
 =?utf-8?B?dzRxRGdSWE9ZNG5rYk50bW5Yc1BQRVRCQUhBZXU2WHRvc3o2TlFYQmp4aXp5?=
 =?utf-8?B?dnVnOHdHMzNHNVhpS050M3paU2xROENtbFNNck05ajNaOEhlbTlnWG5Hc2pa?=
 =?utf-8?B?bHlRbnlPOFRSQlVWSUdIY0FZcWRnWWsvdDYrUEtSK3BOcnhFbEhiNks5ZTQz?=
 =?utf-8?B?cXhmSmhVbkFHVVlQK1E2WE9hV21LZldjNk1sR2xQVVdFRjdFN2hkK3g1eU12?=
 =?utf-8?B?TmlmcVRSYktNQ2tIMC92cXZ5VCs1eHlGdE0xUnV5ZVpadncxekJWUEF2Kys3?=
 =?utf-8?Q?wMmfEqhc19tO9v6Z8CuPsCqpc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6d02c7-db87-46b6-89e3-08dc3f76638d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:48:08.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0Izqw9J6rBt9m/M+CdRyuVSelUjUidFgxSLbeOSkMLT8wmLkbR97ha4/KiR2QV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122



On 3/8/24 14:31, Andy Shevchenko wrote:
> On Fri, Mar 08, 2024 at 09:20:23AM +0100, Michal Simek wrote:
>> On 3/7/24 16:43, Andy Shevchenko wrote:
> 
> ...
> 
>>>    struct xspi_platform_data {
>>> -	u16 num_chipselect;
>>> -	u8 bits_per_word;
>>> -	struct spi_board_info *devices;
>>> -	u8 num_devices;
>>>    	bool force_irq;
>>> +	u8 num_chipselect;
>>> +	u8 bits_per_word;
>>> +	u8 num_devices;
>>
>> all above have 32bits. It means on 64bit cpu you have 32bit gap here.
> 
>>> +	struct spi_board_info *devices;
> 
> On all architectures? I mean do all 64-bit architecture ABIs _require_
> the pointer to be aligned at 8-byte boundary? Even if so, the struct
> itself can be aligned on 4-byte boundary.

I am not able to tell if toolchain enforce 8byte alignment by default/by setup 
on all 64bit systems.
I am using pahole to check this which was recommended by Greg in past which 
reports gap in the middle.

thanks,
Michal





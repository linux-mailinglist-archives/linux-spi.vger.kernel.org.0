Return-Path: <linux-spi+bounces-11851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF31CB2D55
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 12:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8E05300E002
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F22FC006;
	Wed, 10 Dec 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ivKZVZZ+"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980263093A5;
	Wed, 10 Dec 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366462; cv=fail; b=A6ZcIdQO/3+DynvnSzoMrPY1dDkyRsPWAYvuFjejSta6KRtqTe9cugmQqVi40jZjyVL8Xivv9LfrBKMjpcK5mCyGZFpmYrUrtFZQAeFqV9vbc+KG3FnOQ606biqN4MIEjAltBOzHs870Wd2qQsAkfq+/jnrsbEQfK+mEJW3cC2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366462; c=relaxed/simple;
	bh=3gU1W2+KtsDYjSjg0y33apItzyHFEoO3zXt2I5VCThU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=gaOtIjdncCLIuCU2k2G0V54ti0tu5fKkGP5JWAecKmEtjFhSdXNOCZ1cKH7z224kEf7Ymgxm3k5MMVNFg/vF5StbdLe3cBk8UtyeFy80pthVE8quJMeA//U4c4JkESGqVbicMJflT9oE/CRNNzx7jzsM+XSbWWEK1WiQVa/hjpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ivKZVZZ+; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgheMV0kXnutDsvaZ/g0BqoOknPM/wKkfkPYFVNpXq7KrR7yz3C7jHL5zgtdE5U4tDQhFMrJs3yCVpTo/eKyVJcCqLncWVIXO0KJJzo+meKzPLxd2bOZz/haWDW3ZChrhuivcUAmYbPrHpke7+oDw3YYIDJC6y794GNfnedU4cdFJCaedfj/Ynq9bBWVHYt5fKWIIyz9fWn0jRqCD/PzLoBbhX750VpAGHoJ/r5CxFmutNCzRjUGM/GZXHNAs587SbhGJ73q+lI/Lrp3q/yq7wKvwhMvQ9KUjZtmOtEDhpkCPUjb/0gGzl6TLqWuD8A3GNLP/Qa+oxYH5Gnra/8VHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaFCKV4ew+aajWRRm4XK1GeiQ0Q9beI2cHQke0qsHGA=;
 b=lX4Iw3uTw/CjKnk5O0cEwdYruM9MJWEs982cuV0lZWtMD2x6M5qhCTNfajcqSUbjHJrA1sgeDDx/u54XsFta3+iSBUTRqAocYHM4z7MPhbwqtYj558PVO1HSHE4ptzn8SdBnsXf/Yrw2UpbgDGxGPCEcYS9KZY/aUtGNPOGwE3xFlvF0qUFb95xb+bpWrx3Hjo395UZA+2/q4FM5NSPbGOavRyh1mcI/962FojV/OF5E113Z0g07AypNjrE6a1KzRFwGU/gZfaekmRLHn0NHqr5/BuqLzFSz25RwNlQvMQhZskPGB0digAr/dPlglbRoozI3tArHUZG9523UYINrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaFCKV4ew+aajWRRm4XK1GeiQ0Q9beI2cHQke0qsHGA=;
 b=ivKZVZZ+0QO8JrfTsJTlPE/c6gMz4hRAKnnRVLEgpopYdfLatZ2REkrTMLWOJb+9n4R7egHerisnwIHusI88lbDeWZHVDaeA3cUwGoOZnL2tMtEHK7VCJ/SjsKC00zVCppQGSUbJbSHdRm9jko9BSmkvM8iNBPgRa/qfIzJLEe4=
Received: from SN7PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:f2::17)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 11:34:17 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::41) by SN7PR04CA0012.outlook.office365.com
 (2603:10b6:806:f2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 11:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 11:34:16 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:34:14 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:34:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 05:34:14 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BABYA1W2889609;
	Wed, 10 Dec 2025 05:34:10 -0600
Message-ID: <ea6f3dd7-0732-4de9-8bf1-e88a45ad6ac2@ti.com>
Date: Wed, 10 Dec 2025 17:04:09 +0530
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
To: Miquel Raynal <miquel.raynal@bootlin.com>, Michael Walle
	<mwalle@kernel.org>
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
Content-Language: en-US
In-Reply-To: <87jyz3ao8b.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f777ec4-a1de-44ce-9002-08de37e00d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW8zdHd5bXpXUExpUHFtdEhTN0JjMHJRUlh6b2pra2Ivd1ZCRGNwWkFDMVor?=
 =?utf-8?B?MUlsRExranZZU1ViaHJxWHBSM2RPRzk2ajFTSG9WTkxlcUVqRHh5elYwcmJG?=
 =?utf-8?B?NXc3RlQ0M0VkeGFydGM1am5lZ3dKVXdmdmZ0dVN1TkV2NVN5NXhHdzBIRlVs?=
 =?utf-8?B?RCtXRHFacDEzc0dIdUMxYU8rRUlxWkZRVXQ4QXlTU1lIdU5tKzlwL2F5S3BI?=
 =?utf-8?B?RTZVdFU1YUcyTnJBaTRuN2dEQWlCNzRtK2NKb0dnN0djYkVyV0FPdS8weE9P?=
 =?utf-8?B?RWpPVXZiZ1BiQW03MUlLSHpkNHRNdjBwK2xwR2pCSHB1a2pNRGpvMHZhdCtJ?=
 =?utf-8?B?OXh2V09WYWtWbW1GZ3Z0TUdQVzZkUW4vNmRqTTZNczdyOVBac2VkRUxQYjc1?=
 =?utf-8?B?M1ZYckhPNzNzWDZJOHNkM1hWWDhRS2xQdUdJNURFb01CczJyNGdyMWxIU05u?=
 =?utf-8?B?S0dkSG5hZGJMS3NmQU4zekowcDA2eUpYWEFad29SV0hEVXNTZE5VWGZhMXF0?=
 =?utf-8?B?djdxeGg3VXB6WUNzZjlxYUtTeEV6dFN6SVpJVVY3cDREREw0ZXBSVG1DOWJ0?=
 =?utf-8?B?T2V3bEdsVXRkckdrZm0vRVpBTG1oWDhLMmdocUprNGdOQ1R0K0s5ZXhOWEsr?=
 =?utf-8?B?RFlJeFBoTWh1YllZeVVEM2pLdXh3TmJHa1AzandDVVQ5WXhEM05VeW40NkFP?=
 =?utf-8?B?VnNnZHoveVdzZGpJaG5EWnE4cE5TQWNQYVhtSFo1d0RPWXZBMVZIczZNcVVz?=
 =?utf-8?B?V2FvWndpSnJsZmVyQUgrdUg1NHBkZ0duR1pRTklDR1hmNlRCQ3BjWUlsV0JC?=
 =?utf-8?B?QzVFdm9wZnVBWUFLT045TEpWelBsLzhEem9DdHVHUVg3UkhZK0N0aVJ6N1pQ?=
 =?utf-8?B?K09nSmMzZ3d0ckpqM01TZjQ1THRTcGhUK3lHTWlMRmEvVlVPbVA5Y1dhdDh4?=
 =?utf-8?B?U0dvSHY0bEEwSlIxSm5pSElKQi9KYWp6ZlF6aExPY2xUSkhaU1N1MkozcW9U?=
 =?utf-8?B?SGd5NWVjOTZnU0ZaT1BPT2RNb2tJZGxna1FyakIyN1lmamY0WEIvdnFHQ2Vl?=
 =?utf-8?B?WFRCWlp3ZjJhb1MwMHhFeFpueVdrdCtzY3BQQXJxQ0Q4M3Bra1BBUDUzNlFk?=
 =?utf-8?B?eGFBSnlzVWllcTFCUXF5MVk1d1N3R2EwU28vazZ1WVg0U1JpTkhtYVhUVjlv?=
 =?utf-8?B?OWV6eWwra1VuNVpTR1BVTitVQXRQeXJ5Vm5rUlhJazZTZ1h2cFVENnlTOVZ3?=
 =?utf-8?B?MGVrNnNLNGN6OUVDOFNsRTJFbTJyam9sY2pVTUUyWnc2U1Z0YXJ4eWovTUNp?=
 =?utf-8?B?dmhRN3J6dFJqblhqVi9UMkEyaFhjWnNIM1dYcXEvQ2ZYVTAvUzdyU3RYeHl5?=
 =?utf-8?B?ZXg2bGYrT0FMckVXcDlRYzBIMHJ4WmNnQiszTlB1a3FWTHR6dFdueDhYeGhl?=
 =?utf-8?B?YjZqTDlnVWJrQnBqMUpqOU1XRmExUUI0RnVsakcwWnRsSUIzRjEwV1czeTl3?=
 =?utf-8?B?a2s2N2NaOFRyWFRnUlR2d2ZGaWJPcGVTazd6RFpXMVl2UzVGRXFIRHZYUUJE?=
 =?utf-8?B?bkRuYVVEbDVRUy9CY2dWSWVyZVFnY0NLck44RnIvK1FhQTNZdTVWOE13aDll?=
 =?utf-8?B?VTBmSTZxVFBEUjJJZVFSVEY3bkVMVllPQ3F1czA5V2dRaUJTUkhObUUyMUdn?=
 =?utf-8?B?N0ZkMUN2bFFPV1FxTWVGa0h2OTIyTlBaS3pCOVFPeVJ2amxvaWhvcnBxLzRJ?=
 =?utf-8?B?QkQraTBXb3cxSk52Sm1SbGIwdWI5NXdvZlhSU1J2cStOSExBOEYvWmNjWkEy?=
 =?utf-8?B?NllpS2FkbDVJNlRYdTRpSFhSMGdLUkRPVFV0WkFPaU1NMG5jNUdkLy93SldP?=
 =?utf-8?B?V1E4UEVQTWY0ay9vNzcrUmVNSWxzUUhDWGljdmh4dmR5MFJEYW9rUWJDdkl2?=
 =?utf-8?B?bnNkczMycmxYYi92NTlwZDk4VVh0aWlzRXkwMTZoT0tlNGF0RXBNckljQzJi?=
 =?utf-8?B?OVVzcW94Rm5uaytXaE5MWXdibGowZzVvS2xtQUpnUjFqZlZIS2ZTZHVLa2x6?=
 =?utf-8?B?bGd4SnBMajdmMWVNOGdmc2FkZlgyOUxNelNGQ2o1NTZWcmFFNzRCZ01BKzhn?=
 =?utf-8?Q?+gxg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:34:16.2961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f777ec4-a1de-44ce-9002-08de37e00d03
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156

Hello Michael and Miquel,

On 03/12/25 15:20, Miquel Raynal wrote:
> 
>>>> I think we should start with the requirement to have the pattern flashed
>>>> already and figure out how SPI NOR or SPI NAND can discover that
>>>> (perhaps via NVMEM?).
>>
>> But we should also keep in mind that certain flashes might return
>> tuning data during the dummy cycles. I.e. the PHY might probably be
>> tuned on each read and there is no need for any pre-programmed
>> pattern.
>>
>> I'm not saying it should be implemented, but the current
>> implementation should be that flexible that it will be easy to add
>> that later.
> 
> Conceptually, yes, but in practice, I know no controller capable of
> using just a few cycles every transfer to calibrate themselves
> automatically and reaching such an optimized speed state as the cadence
> controller is capable of ATM.
> 
> Despite the end result being close, I would still consider this other
> way to optimize the I/Os somewhat orthogonal. If someone has some
> knowledge to share about the training patterns sent during the dummy
> cycles, I am all ears though.
> 
>>> For SPI NOR, we do not have an equivalent "write-to-cache" possible, so
>>> we still require a pre-flashed pattern region. At the moment this is
>>> provided via a dedicated "phypattern" partition, and its offset is
>>> obtained through the of_get_* APIs.
>>>
>>> Regarding ways to locate the partition:
>>>
>>> 1. Using NVMEM:
>>>      a. Exposing the phypattern partition as an NVMEM cell and issuing an
>>>         NVMEM read during tuning does not work reliably, because NVMEM
>>>         ends up calling into the MTD read path and we cannot control which
>>>         read_op variant is used for the read.
>>>
>>>      b. Advertising the partition as an NVMEM cell and using NVMEM only
>>>         to fetch the offset is not possible either. NVMEM abstracts the
>>>         private data, including partition offsets, so we can't retrieve
>>>         the offset as well.
>>
>> You can probably extend the NVMEM API in some way - or switching the
>> read_op on the fly.
>>
>>> 2. Using of_get_* APIs:
>>>         Using the standard OF helpers to locate the phypattern partition
>>>         and retrieve its offset is both reliable and straighforward, and
>>>         is the approach currently implemented in v2.
>>
>> I don't like that hardcoded partition name which is basically
>> becoming an ABI then.
>>
>> At least we'd need some kind of phandle to the partition inside the
>> controller node (and get the ACK from the DT maintainers).
> 
> Yes, agreed, this is controller specific, if we need to use an of_ API
> (which is still not needed for SPI NANDs, only for tuning the read SPI
> NOR path), it should not just be a partition hardcoded name but a
> phandle in the controller node.

Yes, using a phandle is a valid idea to avoid relying on a hard-coded
name. But, it does not work well when multiple chip selects are
involved. The controller is not tied to a single flash device - a single
SPI controller may host both NOR and NAND flashes, for example. In such
case, only the NOR would require this phandle, while the NAND would not,
which makes the phandle approach unsuitable. Another example is a
controller hosting two NOR flashes - both would then need their own
phandle references.

An alternative would be to associate the phandle with the flash device
itself rather than with the controller. Let me know your thoughts on
this approach.

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl



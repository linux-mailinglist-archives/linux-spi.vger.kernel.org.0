Return-Path: <linux-spi+bounces-11850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D8ACB2D4F
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 12:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89AD30051AB
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A12FC006;
	Wed, 10 Dec 2025 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IG/5jXKv"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB8347DD;
	Wed, 10 Dec 2025 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765366430; cv=fail; b=IrYGSPKblj2xjEDY0AgTkBC54tY6TNZeL7GgsewZwcQ0vr2ORSTfYNuxQNPvk+g9HNbRoLhrzExZ+nAGf+D6eWl6KgeO2WtaAdUvak9oDoVm2+k81i6o8bBQdJKCsiU91C03v1QAbdBM7eVDRN6S0d/4wIhUVA1fhBw0ovtxUA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765366430; c=relaxed/simple;
	bh=u1DvCsCryVsF92G+1+VwQ31OabrJdFegaZAeX2G675w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=R0j+aMOXPlJHgCzk4LkRK0SWa2pQA2/hspC1MXA+9M5PA57NF+Ea9nOf3EdpFdGmox2yMGsE+fJOpXlqmH5TpqB+GKuthu+2+DaALKKWWOhu/m1bvkOPaUovzbvEQmH1W/f+5LY/uxzruoVi7WlFMBgEYPxzU1txWlTbEvO8q14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IG/5jXKv; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stuKHpdK3pGTodRy/T1a0zXY4hCDR7rRaIqQBqzKcdSewShxmhXnCUNq+bV9Ify1wZNQzKIq5IJFoVOMoLqa+DvF87SgzYforkZR5U+vXrBGFotUgEohN4l84d+lNY+itYCx170fOO+vWgbW3TbxbU8QSVPAbjX2bCjwx/NuqiF/tRSDqazPEZh1hxsy9os7zj1VduccFx12+HUksOjMvgpkTbVDKM9u2loYsjTzPhaRe9SujusWuCPRn0rqX8DyETZvzwNQlg+bJbCBtnB8brTtX0YQVMKgWso+ubzh41+3EmyLbj8T1cQy/cjO75XJlrEdc8sbPqd586uBXDgOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTr0tfRzJIOv3JIrHEMcxHv4HgtX3KgmuqvyZTUtOCQ=;
 b=eqz4CzaxgyycqCFjtZ4cboZnuqTlx/gBG0D+7cllSlj2C1tJYdqKprFKeRebAbW7PYk+sW9gu+Hbl6v7yeV+2ABmdFqKWGfwBDbke58VyukCZCRr1gNo1E8aijFu0YC8gcIAJhCAZlfYnG1Gh4iZ7Te4nSTozw/Y/AOx03iD93xojQZV2L0Ty3LFZ+Pu+Nyf2yADeqLUQtOZ4agU8S7QnkaGZpnl00vkcgh9J5PZHNgbVJOg+O1nXjedHuQ63n4bAW9tRkQi6/UQTUeJEFawoSBCJwQzIct5lC8n7H2ZlPjI7LEaa6boCAJ4+/0jTgbZb7sQyJf3dBOr0MJSVQOAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTr0tfRzJIOv3JIrHEMcxHv4HgtX3KgmuqvyZTUtOCQ=;
 b=IG/5jXKvagep/ujbMhb12kui6FuukX+kr0PqDN9Ww9yqB+tflr9ALpK5vzMotLS2zq8dltCu8eNEQhiBjY/0y80pOEX023QsijBG899X5jfWMWglRaLvFgooCE4+r0VDcjy7rYKvTW8vgrBIzegjGnlyV6lIih7NPFEh4Ma0wTI=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 11:33:45 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::c2) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 11:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 11:33:43 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:33:33 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 05:33:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 05:33:33 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BABXSuT2856514;
	Wed, 10 Dec 2025 05:33:29 -0600
Message-ID: <0928678d-7f5e-418c-a006-ae56f7534ff5@ti.com>
Date: Wed, 10 Dec 2025 17:03:28 +0530
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
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Pratyush Yadav <pratyush@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<broonie@kernel.org>, <tudor.ambarus@linaro.org>, <mwalle@kernel.org>,
	<p-mantena@ti.com>, <linux-spi@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<a-dutta@ti.com>, <u-kumar1@ti.com>, <praneeth@ti.com>, <s-k6@ti.com>
References: <20250811193219.731851-1-s-k6@ti.com>
 <20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
 <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> <87qzunt4n4.fsf@bootlin.com>
 <ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com> <87ecqcakjo.fsf@bootlin.com>
 <mafs0ms4j4fuz.fsf@kernel.org> <cf87ced7-aa66-4b15-98e5-92cb76737073@ti.com>
 <87v7io9c23.fsf@bootlin.com>
Content-Language: en-US
In-Reply-To: <87v7io9c23.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: e666156c-3312-4398-51b3-08de37dff973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZKOGxSd1VLTDhoeVI3SW1PZFQyVmN1ZjZZc00rWlJ1TnRFMDJuSU90UG1H?=
 =?utf-8?B?YnhBUkh6WEJOVmpzQ0VNd1k5RTdKQ2Z4RDg5U1R6dHI1eDdqYWk4MVl2R1Fm?=
 =?utf-8?B?a1YwMENlaytXV1BWSlFFR1J3ZnJwRGNKRUpUYTZKaUdpcGdiaGVWY2JoVUtp?=
 =?utf-8?B?aWZIR1llSUNSdnprQW1uY3dwUytESmRleWZqbGVQa0VYdGt5T0JLbFpNWkNN?=
 =?utf-8?B?QWJlUmU4a3VzSk9LQk45bXNPeEhnb05pYkcyMXlrMXN1aDBHYUJYQktYWGxt?=
 =?utf-8?B?a1cvaHNJbkMrL3BWdkFqeHNrNXZUTFkwMGtxNXVkS2lvVnExS0dtakpuSE5L?=
 =?utf-8?B?MVJsQUJOOTJ0RU9KMEpGUm9BYjZYK0ZnZUMxczhKWFlzTy9FVlNtcVBKdG5M?=
 =?utf-8?B?Snlieit4R0NheDNCZUI0RW1jekZ2Tk5yNy9SZXI5V21seEN1RGhMbzRLbXdQ?=
 =?utf-8?B?bkx3NHhlWHg4N3hjWEpQby9tZGUxMTJWM0JnaVVOcGEwMGFhNlZjYThySFgx?=
 =?utf-8?B?bmFHWnRwdWQ2b3ZGY1l3aG1aRjlqUW0rTlNUKzRSdktYQmdXTmp4K3lFSmN2?=
 =?utf-8?B?UldtbmI2Vy9xamhmTFV1QVVleWJBL3Y0Q3BldTFiWE82OEtVU2QzYzJoZExU?=
 =?utf-8?B?aVhBbTdiUlRVbVhaVDZrLzJNbkhlWUVCM1VqaEtRWlM3azIwd044V01OM2Ny?=
 =?utf-8?B?Uks0NE1KR1F6YmdVK3huSU9VdzJGZCtrM2FxNC9xSDg3a1l6eStZMHE5ZDhG?=
 =?utf-8?B?ZUdhbTgvYThiSmtiNEV1bU5scUJUSWRnUkt5UXpxVzBaVVpTTCtmVWlxeXhu?=
 =?utf-8?B?enpDWjNiMkNjV3dQdzFZRGEvUy9hNWNVY2dMNzZNUEtWdU1yQlpYRm1oUjVu?=
 =?utf-8?B?ZGJSaStHSkR2dHplQ2xYaHBWcGxodXpTdXluRDV4Qmh5WHhBNS9jTHlrZFRv?=
 =?utf-8?B?QUZERS9QejlmeHlUYW1oVUZTYUtYalFLLzA4M3RjaDFZNWVhbTBlanFuRXhF?=
 =?utf-8?B?bzc2WG1hNkRIZEtacTh6Z3NmRTI3UDhGZllWZFdlUkpuczR4NzAzUktpUjhL?=
 =?utf-8?B?dnNqVGhWRGJVemF3eGdsZy9FL0FlRnMzYWk0aFZlZTZ2aXpNbGpkT0pPS0dN?=
 =?utf-8?B?REpqRlVldDlwRHoxRHcycVRjc1BDU3locU9EVVFMMzFpNWxGYmwvc05iUG1u?=
 =?utf-8?B?RTV2eE8vRkZzeFF2c1lSd09WMThkenhRa3hFVXBxMjVieHZUMHFsNWlNQVl2?=
 =?utf-8?B?Q2w1SGx1dWdhYi9wNWJUVkRGV2RCUUNNdVB5R1FxSHdEcnM3SVUzeGI4cGdh?=
 =?utf-8?B?UUUzV2phb1AzNis3aU5jTDlNYkdPeTBPaDc5dkJ2M3BiMW1va0Z6YW5OdXJj?=
 =?utf-8?B?RkVFNVgvN2dWdERwVXY5WDA4a0lFN21XZCtmQ1h0ek9xNTBONlZpV21CcWNE?=
 =?utf-8?B?MTNxbW1UT3ZMbTJuOUl6MnVuMFJUQS9RTlNyY2dRQWtoaktqeHB4TVhNelZV?=
 =?utf-8?B?KzcyVkx3dzRIQTlKL0dERS9xOUNRUWtEaHpEbmYvaVE4TVZRQ0V2T3pJY29t?=
 =?utf-8?B?TmVOUWZldFgxbVpkRFpzSWJQb09yUWllMWtGUHJObVRBOHBlQytyZWVyTFlR?=
 =?utf-8?B?bXZHVktFblBpSjErbVNuL2l5Z3hJR3FWdkh0Mi8rWEdQNzJqQmNpQmJLNVdY?=
 =?utf-8?B?WjBobnVudlpobnhPSjlJdUxuMGhMSDRIQlgyUDFacTRpTG9sOUUrNzRYUHdh?=
 =?utf-8?B?VjN1dFM3V3hBT0F3TS9lRGF6d2orRzJyUlJqUzBmYS9oNXZ0WEJzZXU5ak1Z?=
 =?utf-8?B?SHY0Z2syYk9oVnpKTXNJY1g3OWVRZFM1OU1oVWF2NnpHbHVPcUl4VlpJVGtl?=
 =?utf-8?B?TGlHWmFnVGVqZzJEZG9JTXJDNEkvalluQlVJNkl4bkZNQW83eXp3dHZ4QStL?=
 =?utf-8?B?WTBmVklkeDJsbmlOT2pHbkgycG9BMm96Y1Vxd1Q0Z2FRMUN4NjEyMWJ6aGls?=
 =?utf-8?B?VS9RNnFMV3ppMzFXVUNqMzRySnJxMUh0RFplWEk3MmZ0UzFTQ0ZPRDZMY1FC?=
 =?utf-8?B?WEZKMDB5VEllZ0d1bW81RDBUYVBSY0hoVnVWUCtZMWowb1JDRDVvNlZWVzA0?=
 =?utf-8?Q?btgY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:33:43.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e666156c-3312-4398-51b3-08de37dff973
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566

Miquel,

On 03/12/25 14:28, Miquel Raynal wrote:
>> Just to summarize, fallback logic during probe:
>>     - If the controller reports a tuning failure, the spi-mem client may
>> either retry tuning with the next-best (max-1) operation
> 
> There is no such "next-best" variant once in ODDR mode unfortunately. We
> will have to return an error indicating that PHY calibration needs to
> happen again and just retry without it.
> 
> As to when/if we shall perform it again, this is a delicate topic. Being
> conservative might imply just disabling the feature and no longer using
> it from a SPI controller perspective until SPI NAND/NOR calls for
> calibration again, but it is unclear to me when this should
> happen. Maybe we could trigger a background job with a low priority for
> that. But don't bother implementing this in the first place. Just make
> it work, make it fit in the current subsystems, just KISS. We can figure
> this out in a second time, especially since failures are not supposed to
> happen very often.

Yes, for now - on a tuning failure we can simply return an error and
fallback to the non-PHY, slower operation.

Also, note that "max-1" can mean different things depending on the
spi-mem client. It may refer to a secondary OSDR read_op if the primary
OSDR variant (e.g. 0xcb) fails, or falling back to OSDR when ODDR fails,
and so on. The exact logic will need further discussion once the basic
tuning support is in place.

> 
>> or fallback to
>> the non-PHY, slower operation and adjust the dummy cycles accordingly to
>> use the optimal non-PHY variant.
> 
> Why adjusting the dummy cycles? I am not aware of a different number of
> cycles with and without PHY mode. It should be identical, no? The
> difference lays in the frequency we use, not the fact that PHY is
> active. And once we've decided a configuration, we can always handle
> slower frequencies, at the cost of a few 100kiB/s maybe. So I would not
> see this as a concern.

Regarding dummy cycles, I meant adjusting them only as a consequence of
changing frequency, since we would drop to a lower frequency when tuning
fails.

For instance, on the W35N01JW OSPI NAND (using Fast Read I/O), the
required dummy cycles vary with the operating frequency:
    - 8 cycles at 86 MHz
    - 12 cycles at 124 MHz
    - 20 cycles at 166 MHz

So for flashes like this, we do need to call .configure_chip() when the
frequency changes.

Again, as I said earlier, we can revisit detailed failure-handling
logic after the basic tuning infrastructure is merged.

> 
>> And yes, for now the priority is to have a robust probe-time tuning flow
>> before addressing any runtime tuning concerns.
> 
> Yes.
> 
>>>> But once we solve this, comes a similar problem on the write side. How
>>>> do we know if a write will or did fail because of a temperature change?
>>>> What may be the heuristics to fallback in this case?
>>> Santhosh, do you have any numbers on write performance improvements? I
>>> am curious if it is even worth the effort.
>>
>> There's no real performance gain for SPI NOR, but SPI NAND shows notable
>> improvement wrt. page size.
>>
>> Write performance numbers from AM62A SK with W35N01JW OSPI NAND:
>>
>>     - without PHY: 6 MB/s
>>     - with PHY: 9.2 MB/s
> 
> Eager to see this in SPI NAND (only) then!

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl



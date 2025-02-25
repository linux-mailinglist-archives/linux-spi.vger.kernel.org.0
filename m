Return-Path: <linux-spi+bounces-6904-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18556A4322A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 01:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F3816D65A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3632571B5;
	Tue, 25 Feb 2025 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U4Ktu4wj"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE72FB2;
	Tue, 25 Feb 2025 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740445114; cv=fail; b=VQqxyYzK2Kju9jGkXz4vJwCCqNAyNLFXjWWCdpWJ0N2aaVn9bqag++nP98S1Q4eyLOJdhIDcb4/eHr4oGkwrMNVbz5+e6O1JFZdMOygvfW54xR3APsNlicJ/QdAxbSG71LgZkNzCBL3SlEBNT+523MQumBVZu+nrB+mfFaMwNaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740445114; c=relaxed/simple;
	bh=ZoKqSBF9tqwHNdMnL13URYEIOuiC68he8yUnuD4V0Ow=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WCKtdUhpk00k5JrzH0DpDw3ERm5f1nk1W2goAnLP03reztohRtQK99dt2T0NpFE4eVhpecW5rRib4YTykhuTirgpZwebabUt8oE2CjVwEv+wzDEBAvTVhdytWwelWfP1hTyjcs2nZ5XHaxXyJpW//y69obh1CVtXcCtA+h+dUtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U4Ktu4wj; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asJfFWepwOV9zZenUwpR55c+Kk6VHX2PX7JI0nMyV1674YXExqbTmti3yHdeBl4K24n4TRCfDG99cLy73YmIN0Z+9iZeq+XpFJ2j/kX4m5h7nondn8C0VTGExjcrKQQQ8VqbXkYBPngd3Ho4gSR7zCs6thsafH8ljjEKQZobEHjsv1IFWgK7iQHurRt/tBFq6AxN2fgmxmf2e1aB72EXQMf9McpNyRlsGIboyxjzJ5nx/GDMVLJRqHA9o2lgCc3AGtSJ8RcP45PKgcyrU4Ee6+KGZv8CDfXlJRNEmmRtCSF/YhFVt4UTG0+ptC/NC1i7ACmstJZwj4XY43vSw8CWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSE9lT9jVxUOiZG2SLlaUb07XkpVIom2L6FPRIMzxpM=;
 b=M1fIgQxn45qVPyCycjWieYpNkm9ODQTNcT0HSqHpgeVeRe9rIeP/D9kIapKKrsA1pA7idF751pWrc8PldVK79pHfURCGPj74cpafZVFvYLPEdfX/IWiB5HX5tOi6So0AR3JQfTmgzvd+sk0ewlPexXNl5wYUcV/M97FXMdEL0I1OpAWZ0E7+FFrN0gPnzSzSN2HRFqH060ztNER/LouK5eg2X7NSkmmFuVxwNvMB2OA6efmILCOseFGDrEKyZLE0rjk+qZVtRL8EyLqx0tERpyhBR8RN/55Mmu2EBQ/RqyINIAvztoijeV0BHUvLRezy6t/DcycJUhp2D2B1/cE4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSE9lT9jVxUOiZG2SLlaUb07XkpVIom2L6FPRIMzxpM=;
 b=U4Ktu4wj85jNHzVgBSQ6mtfmO5OLrQjBN0nALDObJ6QeoKeMBHK844KMT4+Z0dubIHkXuGGI44vqDl67jxITZ3ITpvP49pnzAjCPec2AdL2Fam5FsJSlmw9yRRRMhJnHJ7TwaH7rNW1eqPCsDn1Vgwq+ra23HSgEAWDkvvBYuoCp4sZKMmgoywmWjD/Vyqwf/ygaZxm+CG6+Ndv5h0wb7ySqEcw0uIrMAW6iGPy4ilghXqyY4o5r7YrlJJWghwEqNYuSpPy4lokzez9ZUsbQnvwqgFUxNKcftOmNflZxkMxdC2XDC5sshCivCg5lP2/qZcjMkhvtrkoFhpZMEuGe9Q==
Received: from MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:10a::5)
 by MA1PR01MB4193.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:16::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 00:58:25 +0000
Received: from MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::207c:c76a:271:28b]) by MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::207c:c76a:271:28b%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 00:58:25 +0000
Message-ID:
 <MAZPR01MB9162502ED35D787218257179FEC32@MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 25 Feb 2025 08:58:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: dts: sophgo: add Sophgo SPI NOR controller
 driver
From: Chen Wang <unicorn_wang@outlook.com>
To: Longbin Li <looong.bin@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-4-looong.bin@gmail.com>
 <PN0PR01MB91662EB902D8B337A0526458FEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN0PR01MB91662EB902D8B337A0526458FEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:10a::5)
X-Microsoft-Original-Message-ID:
 <cd6da9f6-74a6-4b9f-8b77-a1b4a2cd3001@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB9162:EE_|MA1PR01MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: 230ab4e1-632d-4fc7-702e-08dd553781bb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|7092599003|461199028|19110799003|5072599009|15080799006|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDBUVEtpbDZHVGsxQmpiZk5FeTJxNndncXJrYTVpNEhnTmk0aWVmdHpkZWtl?=
 =?utf-8?B?MW04Z3Ztd0ZJRllOMzBzZE9yVXZPbmhjZWZSWFExTHFHK3hBV3lEa1k3VDBL?=
 =?utf-8?B?bnlJVDV4Q2Z1NmRTU1ZmMnFONzVNYllac3pPWWQvV3NkaG4zYVQvYW42M29l?=
 =?utf-8?B?WHlBU1YxQndKbmFtS2d3L0NHMG1uVlFTQTdNTzlrTklIb0lQaWFVcEt5ek1V?=
 =?utf-8?B?T2QxNHlBUUI5V05jSk8wOSt5WE5nQzVIbHJkVFpCOERUMVR1a3hIUjRGVmhi?=
 =?utf-8?B?S0VwQ2tMcTgwMzZ3Yy9JN3RIaU5NQzBUZDN6blA3YlhtNTdKeE5acXZjdTlm?=
 =?utf-8?B?SVc4NExTR0xJTzd3T2VSelYrMDA5dFM2R09hWi9LQmwvME92bHBkdUhnQ08w?=
 =?utf-8?B?UVdoRCtDMWZpSTRYdFl6cmRVRUdrSU1UaDVPK0t3TG5qbmpQZGdjUVFycWRW?=
 =?utf-8?B?UkplMmFGR2dXckVvOWdWRi9SdXAyV25HS2FuU05YSXAxNXBBdFk5aVAycG9k?=
 =?utf-8?B?TTFjd0hMeTJ0QmdvZ3lkY0FmejhVK1NiOGFFM0k5TERIRDVGUGZ5TWc5SEdW?=
 =?utf-8?B?NmR4MlhQT0MzMkI1SUxJcmpZNCt0N3lRcGhNcXZQbDZ6anRLOS9tV1lWVkxY?=
 =?utf-8?B?U3g0eU9yUi90NDhDTFNva2JGNEVkcWp4TE5kNmxTT2RuSVdpcjNOMURIaiti?=
 =?utf-8?B?eTJROWJRSlJPNThteE54Q0lFS3kvcFlKa0ZGODBFb0tiK3pIRnM4NXU0VEJ6?=
 =?utf-8?B?UEpvaDJoVjgzMjhKaFRNNmx0cjlOeDFpT2pQOWJQSmMrNXRRVnBIdWhwd2Vk?=
 =?utf-8?B?Y0MyS3FPUjdZQWVBVFJIcTFkYzlabzJHdGNPd3dLQUM4SUJIaXFHQ2pFcXor?=
 =?utf-8?B?MEk5aDh4UjdlbElLWmx3Z0ZjVFFXZUFKNk1yNTJNaW54eFFkNysvWktRZEZ4?=
 =?utf-8?B?MUJBNzFzdjRrQjRFRVI3WElxeE1GcVF3QmJJS2thOTdEK09va0pHd2NnNjM0?=
 =?utf-8?B?STBhT21xc2dYMXRQOUlDRUs4VWk4elBOMGNpc0ZwUWk1NmZ4bytKUjQ5Unkz?=
 =?utf-8?B?VHNnRElVTTRHc1hXZFBPcktiSEFvMUJEWWdWMlhsb3pGYXhhTmVhSW9rUnQ5?=
 =?utf-8?B?THg1SE1ZZ3hHT1dwMGkxVE1yRGdXY3NqUlpVQlM3NjhBOStTM20zM1dKRlFz?=
 =?utf-8?B?TW5PTVpHN2NDcVhJWncyNVUxUk9oeVZWb0crdHVqaFhkSENnL0FZQjFySm1n?=
 =?utf-8?B?enVoVnpuMHN3Z2RXb3FuVXFHbWlDWnhLWWxQaE9HREpMYndXNEN0clE4T3Nn?=
 =?utf-8?B?c05KcXM2T00rOGVkNHdHcGFjcG9YbDhHSjFLUkxDK2hVcVFMa29JOW85bWtY?=
 =?utf-8?B?WmZBRERBSjZzNFpKdHpHbVJUMUdhY2wyVEdZYTlyS1RBTnA2Vjd0M1pKTit3?=
 =?utf-8?B?WGNqT1FaNWpLRlVWS1h6UlpKcXhCelloajFFS1p0aEt2MFl1dEwyOVVTdGYv?=
 =?utf-8?Q?tKwe2A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXJjQUMyZkx2alNqdy9vS1RrVFB3ZUVySGNMNkRjS0xHWCt3YXNPOFhPM3VJ?=
 =?utf-8?B?cytXdEdpL0wvN2FwQ1N2cHA5WHNSaXBWWDlORW0yczhXNHZOZGhsTURSTGxm?=
 =?utf-8?B?MDBRVkNaY0xReDMxb3ljaGFYaUdzV2s1MDgyT1M5bjVYMS93R2lSVGxYcWtF?=
 =?utf-8?B?YVhEcHgzWlk3MmNycXlHaGFMT24zTDVUM0lWYjBKMFlYOVJJcXBQVVhyNVN0?=
 =?utf-8?B?ZWFOVnhLMTZYekNReEpDVkMwU1Q4RDl0WDlwSXBXTGpzYmwrNXEvVHFjd3Bz?=
 =?utf-8?B?Mm1MVnJuZG9yZWtiLzJOeWVvY0xVYURvZ1BJTWl5U1VCN25MNndRdW9sdGJu?=
 =?utf-8?B?OXBSUWJnN1pOMFNnaXhkN3R4WnE4azdwMStINTNqZFlLSDlsSzUvNkZzaktz?=
 =?utf-8?B?d1hNa3Zoa0xLWjMxT1Nma0FqazNCbndZQzI5RWZWMG1FVGhUY3MwOXJiQ0F4?=
 =?utf-8?B?TWdsTmN5Zms1Q1FWN1BiRk1ObytIWk9yU09uajZaK2o1ZEhiWUNDZ3JmRjBy?=
 =?utf-8?B?c0srQVBWa0xpa1hmVUZCWGgyakh3M253ZEpIVUQ1V1g2eGtwdVR3ak53R1JC?=
 =?utf-8?B?Nm9RRnBOMzVtN1Vtd2VwMG1pSnV6NWIyN2J2YlpBSlVjNlpsMGIyOHAxLzha?=
 =?utf-8?B?c296cmhMb2lUZERUL3N6YmRtUkcvL0Jad2x0NzJ2QXlEUnpyelFJYVViSnJz?=
 =?utf-8?B?dlpRRVBBVFJuMEV0UUhQRW81cXlyUGJhYWdNMEt6MjUwRG9wTGtaeFptUEho?=
 =?utf-8?B?VHVDUWw3SDB6WHJFQnJYRVlmeS9rTmN3d2lQZC9lcVhIRm44dFhTVjlxL05j?=
 =?utf-8?B?clFRb1JtYlYzNlBhaTFpMDZ3U1lmSmdCMEJHamsxdm85WUkzdXlPZmp6VXFK?=
 =?utf-8?B?VkV1K3l1Qm1NcTA3MHIvRVJxRHlzcHA4cWk1bmd6Yjk3MDdVV2FDcHpYZUJv?=
 =?utf-8?B?c1RuKzl2Qi9heE1NOVVSYVg1eTB1MEQxRm5hVi9rSlZITVp4dUg4WU9vbmFF?=
 =?utf-8?B?bStKQXNoY2VGSlF1aEFXdWZpRmtGTWI5RFJvNUNYRGRLR3RETnhsdFNKVmJ3?=
 =?utf-8?B?a1lBVUl5ak1NcTJmOUQwdFY2aDVwTzdEcVRyak1MRUhuU0hrODlQenM3ZXZm?=
 =?utf-8?B?TS9KazRsbUlTRno3WTJEbFpSQUVaSzAzeGJuU1BRbDVpRHl5dUYwNGZGc2ZN?=
 =?utf-8?B?Qng2VW1zM2d3U0RaY0hqYjFxMm5kc2gzZ0RzaFZVUEJQUElpc3V3cUpNODFv?=
 =?utf-8?B?UkloRGVacXhZTWo4RFVQeWFTZ1M3dk41NTNxNHdsQ2hSV2k5TkNYVVFST1RP?=
 =?utf-8?B?dVBhY1FIb3BCMkVQQnR3M3ExRnpVOEFjYVRkcFFVbnNhYURRZTd2VG1vM3N2?=
 =?utf-8?B?ckx2d3YrQURiWXFES2dmVk9jRFNoSHBYQnhRY3M0U1ozdjNycUVQYUQ0dWhT?=
 =?utf-8?B?TmlJeStZbzMvcmlpRVVCK25hcDJvZVRubUNYeGllUUJqNTdxOUorZExxeG4v?=
 =?utf-8?B?SW9wQkNjcTIyaWUxejhOWnNxVytucXBYcEFYbU41YzRtTThEZnFNTGNsSVpM?=
 =?utf-8?B?SjIrMFZEbFoxSUlEOFpvMFBhTWlJdWM0MDhsdmU3cHVINDcvN2RFQjVDRXZz?=
 =?utf-8?B?WWxjK0tSdUNEYVRtSitvWUpnOXFRTTVSTVlTbFVMdVJQNDJtb1RLNTVpcGZX?=
 =?utf-8?B?dFBzT2ZpV0l0c2ZqZHZ4NHU1V3RQUllyZC9VVzVFNkk2T1djZy9KU1pST0U3?=
 =?utf-8?Q?OFPvuCk7y5GaFZA7RQMOtW8hLOk/y4+Rae3yJRL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230ab4e1-632d-4fc7-702e-08dd553781bb
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:58:25.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4193

hi, Longbin,

sg2044.dtsi  seems also does not exist on the master yet, please double 
check.

Regards,

Chen

On 2025/2/25 8:23, Chen Wang wrote:
>
> On 2025/2/24 18:12, Longbin Li wrote:
>> Add SPI NOR device node for Sophgo.
>>
>> Signed-off-by: Longbin Li <looong.bin@gmail.com>
>> ---
>>   .../boot/dts/sophgo/sg2044-sophgo-sd3-10.dts  | 18 ++++++++++++++
>>   arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 24 +++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts 
>> b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
>> index c50e61a50013..9c634920f37e 100644
>> --- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
>> +++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
>> @@ -80,6 +80,24 @@ &sd {
>>       status = "okay";
>>   };
>>
>> +&spifmc0 {
>> +    status = "okay";
>> +
>> +    flash@0 {
>> +        compatible = "jedec,spi-nor";
>> +        reg = <0>;
>> +    };
>> +};
>> +
>> +&spifmc1 {
>> +    status = "okay";
>> +
>> +    flash@0 {
>> +        compatible = "jedec,spi-nor";
>> +        reg = <0>;
>> +    };
>> +};
>> +
>>   &uart1 {
>>       status = "okay";
>>   };
>
> What is your baseline? I can't see "sg2044-sophgo-sd3-10.dts " on the 
> latest mainline yet.
>
> BTW,  the name "sg2044-sophgo-sd3-10" seems a bit redundant. Wouldn't 
> "sg2044-sd3-10" be better?
>
> [......]
>
>


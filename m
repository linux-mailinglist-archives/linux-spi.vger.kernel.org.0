Return-Path: <linux-spi+bounces-7310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32493A71481
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 11:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7BC57A3A36
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F41B0F0B;
	Wed, 26 Mar 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLQzLr8v"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9D1ACEC6;
	Wed, 26 Mar 2025 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983940; cv=fail; b=IHxoy0KTsu3BFGmJiqXRH+YMEjbfXYZijLFlhjw+ZehS0A7iGUtjUb7JMh4g4Inznwyg5PgIOC4XmdgFclthKLrTmYmzRrXmLo8IotKfVu5HdD3jJC/iX5VBjCKlv4ScrRiA/EeWz1zh9XTbLgefvxbXtI4bqKUWZDiMpy1DXyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983940; c=relaxed/simple;
	bh=ELAsXX1MNBVxvr0Iec/DVb/CN7U4Lkz21gIR7EkYlH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eITVl5SAJXykDLuAozQQ7lrjbUgHLLXrFLr7Kj1jnKGDDJKwktWc+OJGjx38aIM3gGK4cuSRguEyycLInl21FvLgYcCkuBLXBKlMA+IuUVP8eWN5F9BqGt8VsBge1/iXOWfJ35824RDbFiryl2qJ8vrf41By2BuhMCmMhKWLy40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLQzLr8v; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmoTfDJGZ5ktCFzuWe9zXiSnBgg04CFPirTgu1jweN08HfZN/uRztqHic7XLElATRGDSRt1lOK6c8kHsNPg3qPPF9Ub5F4KGU8PN5YtkMXqXCmN/EtHx7jsmhSL8VAE5ZjfOMDD0EERt3u511RZIqJKNvEVFQc/FLRwwbU5DbJBeHxYTvbCi/gXSkB8G9GmAHWacY4ROXBhNq2WJDvknZotTdEwD8zuUc51mjmPMbNGCcSbIfg+eMLFgbtFr+hah0pYD3783BSULDXafqjQo07xaD+DNxfEZRsPQeblr0WA2ZwgkbAxpdf2Jl1+O4kdoXYToqZEO9R1EI3iTppRm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk/9iR4YfgnEIevL0VgjeiiKyQ0TYLAd6HbDnWLFep4=;
 b=ehYY+eInrty0EbchJr7XSISLDZ99lRs5YT44Vm0hjYYFCzh6iKlU3PsgHPBsodkPIfmvsF46Y2oK+rvhLF+fjDJ48WSUj4TMYwDBSgotwuhmgSIumJq123pHqZ0LttBZmGCexAoXFwKzY4/PAwvWDaHow4cf3aZKQWVHpkZqWc97kTsAKAkvufvvttK06L8Os4BT4Eeoj0fQ4oduaae0A/lHVCHfdem23qf2YKN5pfsIrDDRpaqfLYTe1J9FNpCqZwftDfuWPD+VMni87y0l/ZhPo3UeFpmXAWEhXJPmOQ/tKpaGzOZJ2A6iBgU2qB37kTZYJW7E2sOsmHpIocboQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk/9iR4YfgnEIevL0VgjeiiKyQ0TYLAd6HbDnWLFep4=;
 b=kLQzLr8vHaZpoqMzcJyzY4pWivRhzIeVYyKEEp7VarShtf7072TnidNCtHHGRIbRspSCUjTMgB45KLZB3ciC4dWJV0fwc4Wg9v+3ylyeMO9DsGc4YLXXnuoV2hLs/NEDylSPUFTIV/kWcKcDWIjXk6rqxOp0Cv29D3KgxKLDxA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 10:12:13 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 10:12:13 +0000
Message-ID: <836f2d63-7b9a-4fef-ba52-3d481ea91077@amd.com>
Date: Wed, 26 Mar 2025 15:42:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] spi: espi_amd: Add support for IO/MMIO
 configuration
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <20250313183440.261872-9-Raju.Rangoju@amd.com>
 <b409f5e3-2259-4427-8d4a-1652e7fec135@sirena.org.uk>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <b409f5e3-2259-4427-8d4a-1652e7fec135@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::31) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: da1d2e17-a408-49fa-2b92-08dd6c4ead99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bklkQ3ZQZVdaL2dNcnZYR01KYXVubzh0SlRaeHZHL25VdTh1WFNoTUY2RzlI?=
 =?utf-8?B?bDZBUlI3bmxGc3NQbkliWTJIcVMvd0hUTjBhek43ZHFoQit3OEtsd3pXcFFl?=
 =?utf-8?B?WEtMNDlKbTY1dHlRYkR0QUtiYWl4K2FweDJGNVVWSUJ3ZmtjTHRhanNUMWY0?=
 =?utf-8?B?bWxGUUkyUG1keld1MjJxcVJ2V0pKVmRnRzdST1BqTHUvcmduWG9KR0ptSVNa?=
 =?utf-8?B?VkxqSHlZdndvN0h6ajA0SmNIMm5RQk5sRzA0TEFTTkx1ZGFhclNvQ1FURmxW?=
 =?utf-8?B?bkhMdzllWjU0MTl2ZjZsSDBxam1vUmpsTy9Cd1dQbDkraS9obWlRbzBaL2Z0?=
 =?utf-8?B?S3ZEYXJVajhnMjBnUzJudFI5bjh2UE1sUW9LVi92T3JVK09UZjF5eFNlOVYy?=
 =?utf-8?B?MHhJVmQrOFZZUktVUmIvdjdPMWoybytJbXVmRzRTemU1UWpsajlmZ1B0L3dY?=
 =?utf-8?B?OWFGRlNPQ2xiV3VTQW90MGx1UExBN1N4MUFpUWZsOEFNWnkrbHhtZllmVmR1?=
 =?utf-8?B?c3R2dnl1M0RuUk5TWEtiQnBQYys2ZHo4Z3dDY3RnRVNaTHB6M3FlSll0dlpP?=
 =?utf-8?B?VjNyMG9GN0k4clRtZkxmUFZLWjhSazF1dTdIZU9JelpiMEd5elBnK3ZQbHo3?=
 =?utf-8?B?eFFFRFUxU2ZVZGVubTlRNDZSa3NkaHFRZzZPNGFydHA5ZGlkTVBrK1U3bWI1?=
 =?utf-8?B?Q1c2NTRZMXlTaldXVFN1RnpvQVF6SURncC9uNUcvVVNXdk1jR0FoREZ2Yjla?=
 =?utf-8?B?ckkybGZkZ2FGV3hRd1FWWlptanBZNitabGVLaUNpcHVtNmMrMjBmWHY1RVNX?=
 =?utf-8?B?Mnc2NS92R1dPNEJ1UkVERFVSVS93VC93RzZhSnRNY0IxTDJMQkpBUEpVQTEv?=
 =?utf-8?B?NnZQRnBEUVJqWUdLeXhOOXduKzFmZnAvR1BEYUZZMW5jblpwSDNQKzBpaVpX?=
 =?utf-8?B?V0FCempGUitxMk56TFZTeWZuTTBRbC9QNUZ3TkFCblUrY0NGckE2OTFhSTdF?=
 =?utf-8?B?RGhjUmhMU3FIYm9zaHZLQWtaZURiUW1TZGxrdGFmc0RlMFBnNEV5eVBKRHVO?=
 =?utf-8?B?S3IyTUdFRHZwUjcyUkZaa1Z6bWxjcUdyc2g5UnFSYzhjL1djRktSMGZhWlA0?=
 =?utf-8?B?YTl1TFBPSzhjU0RmeTNwS3RZRjg3UVJYOElpSUU0akZudDVnWHN3cEtvN1E0?=
 =?utf-8?B?NUdhNFRhcmpHWWtnUnJ1YUFINlVjTDRqVnFZanNlSExzcnU3dGNDSW5Xa0Uw?=
 =?utf-8?B?ZmxJY0p6V2VkQzBueUhISUFiT0NFRHZwL3Y5dUtVQkpmR2VBNFcwNy8xS1k4?=
 =?utf-8?B?ZzNUdFZabkIramxSWTQ5NjNBejZWZXhZWksrQXJldVZCNENRUzdocGhUWHhp?=
 =?utf-8?B?YzFWVStMYnlDQUhhei9XZUlOM1NGTVEwMTk3ZFQvN0tBQWRmdlNYTlJYN29R?=
 =?utf-8?B?eDBSNFltajBVNjV3emtvVUdRczQ4MEQ1dHpmS05oU0VxM0lMSlJKVlN5dTNK?=
 =?utf-8?B?eStvVzVjL2sxTlA2dWNCYnY0R0xoUnZESnNGV0NrVlhXZDZ3aGNka2xJajhj?=
 =?utf-8?B?Q0tJU3o1dUliL0dTNHpHdGRNUDN6UVNzT3F5K3IxaXQwMEVBUFZtRGtoeVBP?=
 =?utf-8?B?VGNYeE11S1I5UzhBd1grVTRkWXByODUxWFZVTmM0L0ZHS2o0QlQ1bGNYL0ZV?=
 =?utf-8?B?ZnREWlplSWVzWTQwL0JlRFZmTzJOUklHZ3B0YU8vaERvcHFpYzV5dmo5a0Nv?=
 =?utf-8?B?MlFMZ2hQUjBLcHlrTnFwMXBra0tYQVlzMGlsK25WR1A3NDRRbEF3UUlPNk1D?=
 =?utf-8?B?RFJ3a0g0MUpwWGJmUEZnT0hXYVAwbzFudzV0blAwbE5naTcyUU9KVG1UQVA3?=
 =?utf-8?Q?pCfIZ8KZkLRcD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1krMVFDZCtuSTI4ZVJkMWtrYkNURUF3MUt2dU1Jek1MWTk3akpxRGdvcmR2?=
 =?utf-8?B?Unk1ZlFZOGJrRnZrZ0grYklWYzNvZUJsM09zY1JjdUZTNGVPRkQvdTVYM2lI?=
 =?utf-8?B?a05Vc2h6aitrQXJ6QnVPZ0dPNDZKd3NnMWM1ZVN6SDlFWEN0SHBBdXlqZkxV?=
 =?utf-8?B?ZEYvdTJaemp2eFpncUxvRnRBY0F5SHNhbzNKT3MyL0RDT2JzMTdCenBlWURr?=
 =?utf-8?B?Z3JpQzA1VFRpZDBZVWNORW1VYzBoc3ovd3dGNDNSQ2Rqd01QSFl0aHRSdk41?=
 =?utf-8?B?NUZUWDQwM00xdW9zMG1Bd0M0RjlWVmp6WVhmaHg3WnRBaENRdGh3SEs1SGsx?=
 =?utf-8?B?SnlFVExrNjQ3UDV1RytOOEp1SjU1N3BzYjFxa1pzdTBMMWJRMi9XZVR4M21q?=
 =?utf-8?B?VmdBeHNsSC9EME9ZTG9kNWFXVitlNUNYcHdQdzdMcUczam5PbElJelpZUmRY?=
 =?utf-8?B?eGh6MDJRRjAzQ0NycTIwci9BZGtxU0owbXY4aWRpSGVScGk3cytZOWlvSGdp?=
 =?utf-8?B?eUNCL3BRamtHbjVtZE9CQVlVQ2hKWElFaS9wQURuR1AreTNlRU83RnlvSS9M?=
 =?utf-8?B?OUhHaEd1Tk14YzZrS0QvUTlwMS9md2Z4dWVqRjBWWkNleEJyd0w3ODBZa0pj?=
 =?utf-8?B?TDgydHU5UVZJdHlZZXJzTklURS9sMDhkZ2FYVTVXMWFCZjB0QTZZV3ZEWHU1?=
 =?utf-8?B?SG9EYU5JNnlQQkcxWXBGRWRIN0FiV1MvREd1dEJjZGFTQmg2bEw0U1BvUlJ4?=
 =?utf-8?B?ZjdFTmRyUkZFRnIrczhjQm95STl1ZVNlVXptTEk5d1QrRXZZcUpIRnplUWZw?=
 =?utf-8?B?RW5meWFNQmtJRlpKU0JacWQ3UUI5b0NSS0ZPSVVkNnV5cHNQWTYxLzYwSFl0?=
 =?utf-8?B?WUJWcU0zWDJ3U3dkcUVGTms4dXU3NGwrREVPS0FlamdMUml6TkZlSEEyR3JG?=
 =?utf-8?B?WW4xdzR2aGtKWDcxMWRHajF2U2pyM2lCK2hTNHErZUJNOWkydkhvM05lU29P?=
 =?utf-8?B?bFYxOEMzMVp2M0owSDI5VHBsR3E5bWxvUlU3SlZHamVFbDhaQnpUK21DclNX?=
 =?utf-8?B?NHREYi9LWnROd0crcXBNL21vcGczNzN1ZUZMbzJnRkMyRFg3VG1wOGIzZVlP?=
 =?utf-8?B?bEcyejhhZ2tVS2xiZzBrWEZHK2x5NUpxeTNjWHFHRlhyYkl0TW95MkRTczlm?=
 =?utf-8?B?UnlML1ZZNkFvMFRJdEdXMzFQZUFrN1llTjNYRnhvTi9sRlMvWURVNFVqVURY?=
 =?utf-8?B?cmFBeHVQV1MxdlBuL01wNE53SllRU0JUbGlVTHJUTnVPUnp2cjN2Zm5rWTFB?=
 =?utf-8?B?TXNZRkdPSVZIbGtYbUphd0NheGVyVUxmNk9KQzlmdHRQMTg5bTlwN0lJUllD?=
 =?utf-8?B?b0g0ZG16MlVEV2ZiNWtMTlhhdGZScHVnN2R0c1RMSE5vaUhkdTliRmRHVHB3?=
 =?utf-8?B?MjV2bHBFOGJXcE50R0VwZ0NFSko4ckFidWNxTnRhVUNMRURwWjdxbXFwWktn?=
 =?utf-8?B?VzF5UFI2MUYrQ2Y1WmhCVGkxb2Eya0J5VWpxR2t4bk1OWmh0NUVmU2J5WFFy?=
 =?utf-8?B?ZUx2MmVabjk2NkM2eTJPaXpiRGZyMUl6WWZDYXdLV2RIK05RUTZNc0h1WHN2?=
 =?utf-8?B?OTV2ZDMzT0FHeDdSOVNmd0ZhcHlwZzFablZOb2lFZ0ZlVmVYY1VyMW9XMHhp?=
 =?utf-8?B?QW5IZzI5WFBpN2poNytoL2ZmN3dnRnExTzQ4TXlWMTlwYzdydzN3MzcxMW5I?=
 =?utf-8?B?N0UxcW9IMWxpdFFYUm02UEJpQ29UdWQ5cEc1V0ZDYnYvbjJzVmE5Z0xwbC9o?=
 =?utf-8?B?L2J6c2ZxS0tlSEhHckRFOVp5RlV1NTVPOHNFdVdOeENTT2hxMHpOOFFUZ2pC?=
 =?utf-8?B?SDRFMDJHSVNVd1pSbXYveVZRMzlJYm82UEQ1aThsOXFVbjdlTEJVRXVwclFj?=
 =?utf-8?B?bjN0dm85T1BxRjFPelp4TVNVdFIvUWtodWp1MHRZUENXK2NtL3hhTVNjcHZQ?=
 =?utf-8?B?MDBuaXlHdHN3SXM2SWREQ3BDc2VZTUtQbnhWUkdjK3NXbGVaKzFiSFN3V1Vi?=
 =?utf-8?B?YVQ2d0RKY2Jub21tMEpwcFRyMnI1alFUTHpxOXdEc1lnZ1puWVM1cDJJNmhB?=
 =?utf-8?Q?ZstnVqnJs9u7PFeQrf/MB0D96?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1d2e17-a408-49fa-2b92-08dd6c4ead99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:12:13.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yp+160BHxZ2bWR7xZBR0/U6DHpkTbkgDn2TSE6pMnGUjX2Fq9933hTPY/yLBokDYlIaQo+HQW1QtyLQIYUp07g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665



On 3/17/2025 7:40 PM, Mark Brown wrote:
> On Fri, Mar 14, 2025 at 12:04:38AM +0530, Raju Rangoju wrote:
> 
>> Add support to configure the eSPI slave0 IO/MMIO address before
>> initiating the peripheral channel IO/MMIO read and write operations.
>> This patch introduces new IOCTLs to enable, disable and read IO/MMIO
>> configurations.
> 
> This absolutely does not seem like something that should be exposed to
> userspace, if there is some reason for this to be runtime configured it
> needs to be clearly explained.

Hi Mark,

Thanks for reviewing this. In subsequent series we are planning to drop 
the IOCTLS that are exposed to userspace


Return-Path: <linux-spi+bounces-7308-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE81A71450
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 11:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379803A5CCD
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E2D8C1F;
	Wed, 26 Mar 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNbRk1D3"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B83D6A;
	Wed, 26 Mar 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983266; cv=fail; b=NeOXhcNEkryl0XXHFhaln8HpsY6MFmtaFJINUb6H2xSuHvvAaJsYO857KaFm/7b4nOBKV9adhir9ZuzxiL4LNRFIJCL62QhRXBWcYk9Ul95mGz0MMokebsIJ9rT5BAjo/nDnmdiyvZfjPUBFcVxFNyF+ejCLAX/w521vS6/8QTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983266; c=relaxed/simple;
	bh=Z7Bt0vBY2GksNMboPcx30Bv0Vf/hvJiRMqnJeqz54ZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjR22z0xQ2G+U9x8PZbF2wEfD5nTLR+MIJp93rQddWzu1YaBusfnZUhdSI/4i95B9tcijhKAeiOpwqFJEtT23M8xZTQ89iVuMGryteccoOeLu0cYYaP4CaYXr1w+MkGzG8RXdg46eI/0dkA2B+Mmb/NZzyn5Ca/VQW6JIL7r0/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNbRk1D3; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTFg6fIPVSQldHMePP3iprW+tqoXr/g0YI1LtRyP+E6N9kEKEOBWCEshAx0mmIb0bAQc5yyxB3VAtZGbRrRO353rpdwIoWq7AF3tzqTdDPPoRb48vP/X1Rd4KooPs2YuN62hCyV+dV1NY74kq1kulE9dkn3SbVumyZdl13wg01pM3HjTb75Pwxm7pcmad0VwNwZ1XaEsTi84LvJCyRufXz9kgHVZvsq62E318obQ+I+3QsyWllbr+E2afY2Om5X+ehT9F3m0ukGmbSoI5nLZyyJoDV7Gi8zI3UjOOT+6tq0DW74WkaOOjhlkl6r/vPcL7gURZuRPrUpUc3/ha+JxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xB8bqtYYSIiB4FJJGrPr6iTYrHCwSf2FVo6r4B0HII=;
 b=fEZE2vz7joIjjLsgJk0DHEKEdaknblkQcFrE6JbiyxF9TKmwQUQ+vS9ffMjvLV0MXngYs1dG6RyJyCKOSKcmvFWfo248v8k5n115/4xIXLMaiV+dcFJ87fbNmn2UMZFhfd9115S9BzP0Ki05yhsEOS3klQf6pGaOHpnrpiDF89M0zzgN3FzgtN/VBfJJlbZKAyVTFwHZtr8D6WqUDReWMnVNHj/X0Uk4F+vihNt9P9HWcsYX1T8W5npmrUQhbYPmFF+K1g9Ff0YL9Tk5kJrKroxOS5CZgnyyo73kTN0kXl/bbMABJyS01Jq2rzBrqB54l3rI1eBxz6WfbPSHP3d2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xB8bqtYYSIiB4FJJGrPr6iTYrHCwSf2FVo6r4B0HII=;
 b=iNbRk1D3a1RsHX2Zvr8E19WyBHTkRKvUnnSpkU5nTYT4XhvIWrONkz+P2DMCh2i//kOQQFeJ9jbbb146qfa7RQ0NJfsJf8tTmEBKwxLD+Y0tgM7SuwU0EU4K3scS+UMzbSUUBlIfX4SCQrrFhsckN90bW/jYxRuwBx0vTwAE9gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 10:01:02 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 10:01:02 +0000
Message-ID: <bbbd1a89-873d-4b15-80a4-0690bb1ab314@amd.com>
Date: Wed, 26 Mar 2025 15:30:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] spi: espi_amd: Add AMD eSPI controller driver
 support
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <20250313183440.261872-2-Raju.Rangoju@amd.com>
 <311453e6-c3a0-4976-92aa-e3961485b9ab@sirena.org.uk>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <311453e6-c3a0-4976-92aa-e3961485b9ab@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: d111a561-289c-4ce4-26bc-08dd6c4d1d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0ZDZ2JhK0IxMU0zVGl6UW1DRjFSZEY1ZDQwajJnWGdZK3lEbHdBT2xJT1VT?=
 =?utf-8?B?cG5sTml1d29LeWpnckl6NmNrRVZ3cmNRUUVaL1FwZUYzcWtkWnU3S3BBU3J5?=
 =?utf-8?B?eThpTzhER1pXQlV0d1pkUkxGREtnZzhzbHVkaTV0Tk4yT2NDZ3M1aXpHQ1Ro?=
 =?utf-8?B?SW5wZUpMcSt4NnBMYmd5cmdwZThCYUJWM2V3NStnNDFlVVRzTnBuUSsxbXRM?=
 =?utf-8?B?UzNTVVBJNVliaGF2NXZmcmJtWjBPVUxUVXFXbUFrMTZ4OEZ4N1NTYlpLMkZN?=
 =?utf-8?B?VTUyU25vOWEwRzE0U0tUV21iR3lsK2tYOHEwbXVxdVBTWGpFMEkwckR4K2Rk?=
 =?utf-8?B?SERGVzV0MU5zbUdCc0VrU2w0MFp2anJWQWZ6bEs0cWhTK251Q1A3NG1wSTFO?=
 =?utf-8?B?WXlNMDlsdWh3a3dNU2lNdEdYL1g4N1RtR3dGT1pKQWhEc25WMGg1RUZqZXJ1?=
 =?utf-8?B?bWxHWnpMMUFnSENQRW4zclA0UEJ3SW9adzJ3allURFlFWEd4MkliK0V0Q2Vq?=
 =?utf-8?B?NWJYYk8rOVBramZEd2JRcUVPTTNMNGZnKzJ4SW1EY2Vwd096RFFYRTE4N1lB?=
 =?utf-8?B?WFhZdEdLYUZQTFhZY1BSQVo4Z2N2L1g4aFNHdkpxbnBKRTRwcHNpUmtITXc4?=
 =?utf-8?B?TG1Cc1hKQmZ1ZExKVmE5K1dYL0VaSkdIZmd0ZGdqU1NuUUVrVWRISHI1Rys0?=
 =?utf-8?B?blo2S2FEd3lhWnVPMG5kY0ZjdVhvMXRzME5NZmhJY3gyd0J4V093TWFOdXA1?=
 =?utf-8?B?T09TSmMyNyt4azJPYlJVeUZzcjlvUHI2QnZxbGhRMC95OXVNZFE4RWN5UWtm?=
 =?utf-8?B?alBMZ1pzV1lMalFmRkpjZzBoTEg2T2dBcm1iWG5QT3Z5TUpFQVBzeDNNVWFy?=
 =?utf-8?B?RmhUenJ0QU9lQWNMN3BUNzVrTU9kaEdFYXN6VHVWTzZPU1JPU2JlSTRVYlVy?=
 =?utf-8?B?UzlrcE5iTmttbGhiMHg3aHd6d05EN2dWQXFyS2kyQ05sUUh3WFg2R1JmM21a?=
 =?utf-8?B?NElDQ3FuZmc3UUNGRFdaaWdqcklGNmh6SnVXZjRBa3NienQvc2tYYlRZYXRO?=
 =?utf-8?B?YXZ5K3preEVkZ3c0bnhoRndnQkhXbVZUVUIrR1RtWnY0QUpGdU5ETnZZb1dm?=
 =?utf-8?B?K2VzL0pJS2FzTHo4c2NFcHoxK3krTnZoQVBOMTN0WlU4ZVpHUy9VZVRaMy9Y?=
 =?utf-8?B?cG8xRnQ1TnBBNDgwUW1sTzBSQXpHT1BTYjBZVHVmMDVkVGNmbUZtR2lybUFq?=
 =?utf-8?B?VG1LRHF0dUk3cEF0WEVjZktJSjdJZXA1RjlTOFZDMS94SWNMTTc2ZGpYNlBW?=
 =?utf-8?B?TTRkbG90Z2xVMS9hd1pKWmloNDFqdno5NkxwR2tZeDFXY2VKK05NaWR2Vkxz?=
 =?utf-8?B?RnYzZ2Rtc2gwZ1N5eUxQdDY4aGdCY0p0U1RxVU1jbHI0ckVicmZJeThZektP?=
 =?utf-8?B?WVNNVnUzUldaa0x3ZFNRODVXRzE2bU41MDArNk95anRzL3NtTzgzOGdQRjg2?=
 =?utf-8?B?cGhEMnZGRjdSMWJlS0RGMlFlcEdYaW9Hd01yTWVSbS9JL1FsNzdjZVZacDls?=
 =?utf-8?B?OVBScU1tNHVZeXlZMkZuWU9zT011R1JNQnlQMWlsaXp5Snc3SEE4bDBlODdO?=
 =?utf-8?B?bGJEQnpUd2VobjQxVlVMSFRzNHBkYlVIUGdhcFU5QjRIdjVFUm9jQW0yejE1?=
 =?utf-8?B?YWVDaWJlazRzQ2tlYUxCbGxpMk5nM08wOGtFbW5XWFNyb2lNdUQrcnBFbUIz?=
 =?utf-8?B?SEpOdHhkTXZKNTlORUd1TFB0d3NVTGhBOU9qb3FJTEhiL21RVG5wVWxubGly?=
 =?utf-8?B?YUJwOHRTbjhBcVk2bjF3MlowR2RuTU5pREtkRFA0S2dvVHZhVmlUWFdnMHE0?=
 =?utf-8?Q?d9ARpNT6ML96W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGJIRjB2VTRlUGU4MzJ5ODdOODhGUmJKWlZqMWdycFkvYittVG9JeFFsUGFo?=
 =?utf-8?B?Ky9DZ0VXazh1Vk9XSDBheEh6ZjhNelhaUjZWSGFSSHV5eXRZdi93QkI1TGRr?=
 =?utf-8?B?NnczcnI5bUZvMlhZMXVxTmVwT1ZGSWlnUXNNbVcwV25UVXNqSlY3RG9yYjky?=
 =?utf-8?B?Nm9kMFFmU3dBTElCdVgyVjBIVmNKek1DU1JSamRTdXFkR0VKRDRWcGhqeGE0?=
 =?utf-8?B?cnovZVBrOGN6MVJxTEI2b0xiK25SczNzMHdacmlKeVZpcDkrZ2p6RmVENG5R?=
 =?utf-8?B?VFFwVUI2STh4SFQwaVpyYTJYN1FaYmNQWXBROFQ2V2JWSDAzUW81QkVRZ2Rv?=
 =?utf-8?B?dkVUcjhlSWptWTIySkRJMlg3eG1WWnlONm9CYnpNZkdVUFIwMUpVZzE4TXRr?=
 =?utf-8?B?TUxRcHRFN3BpTUZOT045dktwbVRmQTJMaUcraFFpSGwwSEdud3ZwY0Z3WkJx?=
 =?utf-8?B?ODFJOVFZS2lBWEdWNWo3eXk1M3VnUDJRT2dNOSthYkwwU2ZTN1FMaVpMTEtT?=
 =?utf-8?B?NW40YnRCU1hGVmN5SDhpWFB4TEdIc1pJRXh2WUdMQzBiQzZLTFYybWsyRHdm?=
 =?utf-8?B?aWFnRUtQK3lpcStiVTR4WDNHUXJKRkdaOXkwTkcvQk00VVcrbC9zd1lGb3BH?=
 =?utf-8?B?WTJqUCtkTnV1eVpTeHVRT3RRWllRMkg2RVFOZmo3Qmo3ZVF0eFhuYnpTR0NK?=
 =?utf-8?B?L3c2aGc5b2VYMGtFMFF0cGx2Z2tmZGYyVDU5R0U1ZE5ZdWQ3Skc5MWIyN3ZD?=
 =?utf-8?B?Y1RWdDFIbEJacWRGODNlUmNoVkNpa2k0TGtjR0h3WXoySmZoRmhOcGpNUnVS?=
 =?utf-8?B?eGZ1Z0VBNC9QSGpNQ0pmMTcwT0VnZm02K1hwenc1SFZ6c0dnelJMS3VlM2p0?=
 =?utf-8?B?cjZSZ2IrTC9mU0o1OC9WZFMvaWFYRWRNVW43Y241Z3ZSK3hYL1FhSnBSSHls?=
 =?utf-8?B?YlVrNWJ2ejZIU3k2QnNqYlpoQWxIL3EzMmNLUWZZMTAwdjNVajA4Vkp5TStw?=
 =?utf-8?B?andNbXBRS2lpcGltR0VwS0Jxb0VZMmU3MnUrajVVR0JxQzh2V2tndzBOTFZp?=
 =?utf-8?B?Yll1N3NiWVc1Z2FyeEpERDN0OXl5UUYwd2tOQVNxazRwcU9JWWQvZE83MUFX?=
 =?utf-8?B?dllQcGdmRjZYTEpuUHhIdGxqRTdKY081UVhSSllKMzhqZGd0dUgyU0tOdE9z?=
 =?utf-8?B?WGM3eWZwR1NpSnM2c3BSYUt1YmZpd2RvbHp5K1JkTW5iRDA2cHBRL1IzNjZi?=
 =?utf-8?B?ZmMzRmY1d290d0FTa3JobklrRTlULy9qc2xaTjRLcllXL1JqYmc5TnorTjht?=
 =?utf-8?B?RTVMTU5INzYwN1BEbXVsTVlVRHF2T2tFQTdLbDdlREdZTThvd0tEZTZ5YzBJ?=
 =?utf-8?B?OFdiTGVQWkY1TVBVS1N6dU5GejRvcFNOWUYxVE9kbkU2K0VWbG5GNkRBTVBS?=
 =?utf-8?B?L3VqekFpSVdkSW52VVFsUW5ldi9lYit2SDFOdTFJZlo3UjdVWksrcW9MTXVp?=
 =?utf-8?B?T1JEclQ5aU5RTTlXVU0rN3ovUEpkTXhsakdDZkluY21acTZtbVdrdEphVitQ?=
 =?utf-8?B?SHY1MHZCdTVHdkZuNGpRYmduZWFCUHNIU3k4TUg3WjRUZUFRTENETnZ1MUF4?=
 =?utf-8?B?SlJUNm03SDRKRjhFb3lHNW0rRFppckZLZ3Zkai94M1c0THlRQ3BUTXNCQ25Z?=
 =?utf-8?B?KzVXbE9adS9nQ1RTRUVFbDZmMGR1L0t1djRwUVFUTzdKcWp4QXRWUTE1TXJH?=
 =?utf-8?B?cWdzNEUxN2I2Q2RVRkVMVU9BVmdHSERrNUpJU3ptTzljMUpLNmJCOXVVMzlu?=
 =?utf-8?B?WHJUVGlrZVJUa2dEenFTc1RPRWNkSDBRVnpackZHbWxjQmNIaEFCU0VJZU00?=
 =?utf-8?B?YmRQdlNpL28ycms5TkR2VXIvb0hZTjlFdEkzOHFEUmJ6VXk5N3hUSEdOUEJG?=
 =?utf-8?B?d1hSZkRzWVp5dE8ra2dDNHdmN3huVTIvNVJ4dnlxWkNWVDRxZzJRSzNqbk5o?=
 =?utf-8?B?ZS8vaXNycVQ2MWIxdm9WTnBub2k0R1pwOFhTQXRxVUFFdE40ZjBuZUFyUllE?=
 =?utf-8?B?NGxINGVHVTN4WFVWc1oxZER4V3hFSG5yNlBxL3FEQmdzZVZZdkdXb09aQndx?=
 =?utf-8?Q?AXu2rMrhBgXrg/6NB6SuF2iOv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d111a561-289c-4ce4-26bc-08dd6c4d1d8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:01:02.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cMGP3jfGTb3QjAjdLz/9yqV29X8SWp5g0W4wWhEn5aMiIHOGIP262dEmNIjbW6gkW0+cxgsKpb6bLkWd8yaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426



On 3/17/2025 7:36 PM, Mark Brown wrote:
> On Fri, Mar 14, 2025 at 12:04:31AM +0530, Raju Rangoju wrote:
> 
>> @@ -159,6 +159,8 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
>>   obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
>>   obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
>>   obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
>> +obj-$(CONFIG_SPI_AMD_ESPI)		+= espi-amd.o
>> +espi-amd-objs				:= espi-amd-core.o espi-amd-dev.o
>>   
> 
> Please keep these files sorted.
Sure Mark, we will address this in V2.

> 
>> @@ -0,0 +1,883 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD eSPI controller driver
> 
> Please make the entire comment block a C++ one to make things look more
> consistent.
Will address in V2.

> 
>> + *
>> + * Copyright (c) 2025, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
> 
> Are you sure?
>
Yes, we've used the same copyright text in other AMD drivers/files.

>> +static int amd_espi_check_error_status(struct amd_espi *amd_espi, u32 status)
>> +{
>> +	int ret = CB_SUCCESS;
>> +
>> +	if (!(status & ESPI_DNCMD_INT)) {
>> +		ret =  ESPI_DNCMD_INT;
>> +		dev_err(amd_espi->dev, "eSPI downstream command completion failure\n");
>> +	} else if (status & ESPI_BUS_ERR_INT) {
>> +		ret = ESPI_BUS_ERR_INT;
>> +		dev_err(amd_espi->dev, "%s\n", espi_error_codes[POS_BUS_TIMING]);
> 
> Can we really only have one error flagged at once?  The whole
> espi_error_codes thing also seems like unneeded complexity and fagility,
> this function is the only place they're used and there's nothing
> ensuring that the defines for indexing into the array have anything to
> do with the strings in there.

The purpose of maintaining error codes is to inform the user space 
application about the reason for the command failure. The user space 
application can then use these error codes to determine the cause of the 
command failure.

> 
>> +int amd_espi_set_iomode(struct amd_espi *amd_espi, u32 *slave_config, u32 *ctrlr_config,
>> +			u8 io_mode)
>> +{
>> +	struct espi_master *master = amd_espi->master;
> 
> There's a lot of outdated terminology like this in the driver - while
> sometimes it's unavoidable due to the register map it's better to use
> more modern terms like controller and device when it's just pure
> software things.

Will address in V2.

> 
>> +	ret = amd_espi_get_config(amd_espi, ESPI_SLAVE_PERIPH_CFG, &slave_config);
>> +	if (ret != CB_SUCCESS)
>> +		return ret;
>> +
>> +	/* Check if PC is already enabled */
>> +	if (slave_config & ESPI_SLAVE_CHANNEL_ENABLE)
>> +		return CB_SUCCESS;
> 
> Is there any great reason to use these non-standard CB_ return codes?
Sure, will address in V2.

> 
>> +static int amd_espi_suspend(struct device *dev)
>> +{
>> +	return 0;
>> +}
> 
> Remove empty functions, if they can safely be empty the functions will
> be optional.
>
Will address in V2.

>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -EOPNOTSUPP;
>> +
>> +	amd_espi->io_remap_addr = devm_ioremap_resource(dev, res);
> 
> dev_platform_get_and_ioremap_resource().
Will address in V2.

> 
>> +	amd_espi_control_reg_init(amd_espi);
>> +	ret = amd_espi_init_slave(amd_espi);
>> +	if (ret != CB_SUCCESS)
>> +		goto espidev_free;
>> +
>> +	dev_info(dev, "AMD ESPI device initialization completed\n");
> 
> This is just noise, remove it.

Sure

> 
>> +
>> +	return 0;
>> +
>> +espidev_free:
>> +	amd_espi_device_remove(amd_espi);
>> +	return ret;
> 
> This will return your non-standard error codes to generic code.
Will address in V2

> 
>> +static void amd_espi_remove(struct platform_device *pdev)
>> +{
>> +	struct amd_espi *amd_espi = platform_get_drvdata(pdev);
>> +
>> +	amd_espi_device_remove(amd_espi);
>> +}
> 
> There's no need for this wrapper function, there's exactly one place we
> can call remove from.
> 
We have moved all device-related operations to a common file espi-amd-dev.c.

Therefore, the device remove callback is invoked from the driver remove 
function during un-initialization.

>> +static int amd_espi_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct amd_espi *espi;
>> +	int status = -ENXIO;
>> +
>> +	guard(mutex)(&device_list_lock);
> 
> Whatever this userspace ABI is for it should be added in a separate
> patch, most likely it shouldn't be here at all and standard interfaces
> should be used.  Currently it doesn't seem to actually do anything.

Since we are not registering the driver with spi framework and going 
with char dev file for user interface, all the dependent functions 
required including open, close and ioctls for char dev are placed in 
this file.


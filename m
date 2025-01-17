Return-Path: <linux-spi+bounces-6392-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A46A14A06
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 08:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DC21695C2
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820E1F76A8;
	Fri, 17 Jan 2025 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5p2YpQaw"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970831F6686;
	Fri, 17 Jan 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098134; cv=fail; b=f3uNe4VEBOtoestOZFKmOr3e42kdKxJ7EeKVyCH3EuHs3ZI3NvdDn2cAervNRPkrs0sxjuGHFGTa5mlE86Jc4xXSY2bvEDZDr0I2+1zI8/7E9NN0f3nbR5XEqV5dF5+OFyXxAW34xmNLuP3+caXZ/Ho+FIqKJewem1tMGcpUEmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098134; c=relaxed/simple;
	bh=+M+knvBqswihb7EDb18iVo/5qlViNWP8B+zjM8vUBKY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsFqSPrrIeRqDDLKp08MR99LQ/Z/5tNpzpw3tyHE51YLiKdaAhDFyAct46LfcrGnXa+P7gj3eElueCu0ABElKv4YbkINU6eP8PHG4KgHNXa0+TlHNQAw5yaMmR3wEmiJPLOduRWKlzSlgmnGzpvRG2SDGZHX8Xi6OHcchISROhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5p2YpQaw; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QboAJKVw8y529pQQ9lDVhTH1FtM5nCSxNHZx8SjBAIvS7GPr8P7XVJEzWSpLZVMHaZF85EibXDNb86bgkWF4RrrGlGshlgsp/Typ7Ydk8jhelyLasoGoOlX4RdYWu7Jw+3Yr8OPdsr5x+mUQ9g7f4FLV8dJtUliz16Y/8Exz3gQAOlDV7rzQyVFS5O32ILYzeuJySpVQ06SNLwV9oOH5R10MNO/g+Tas3YtxdlyZtSpaXdOPJWqX5sJYopmY8Kmwp8oOG1aEDJigoInFkHoSJSUf+jLHZmP5VOiw1ipbVvAGB2+GXI+hPhFEWG77JVFH7vbJZjW6SsRvNOHICwah9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDcet1WV7uaGVBG3ET6Gool2GwxGnpwW/nsTC/ywDVM=;
 b=Ps8i0gUB6TgeXWklyJKiE1IziqecKAPzSJ4+EdP8gb1BRsOhA8cGuBO4h7Eu1xMZBDcw+mldmTlRhiPAIvjWfbAfyS8KtiHzHX+P0g0sklwxLyjhgSfiynH0b8UFU7lNoBFpY/qUFqC4q0aLMMggQQLSknjP4C6RkRddfqRJ92PtIL1dbrwbA0FKsgt937pE9rdIiZHTRHSwzg3ErWo4WqOvE3t1pjcoPQSFfJ1plFBdHA8nKh0qa4AhqJqPAp38FbfeEmEr8zubX9lJp0LPB6rYO7GJRgjvCW8gMWGPVJkkUAaaIojfKwUdnKPEDzqNDrKbNNJUsuUihlTGxeIzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDcet1WV7uaGVBG3ET6Gool2GwxGnpwW/nsTC/ywDVM=;
 b=5p2YpQawAje7DN2UM/dWTRmllRa+5DnSoABP1DagKweetNj/2TqoR8V6sPhjl2qYz0pryOfw+/9edItZqi2U0nRft2JGmK6bct3wWEi0bzldX4+bAcf1cKBDIQu9rOuY37UYBGp+kevH6qr2wPCpdIKPQJzKX3DX3mV4LDjjxx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 07:15:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 07:15:30 +0000
Message-ID: <93c9d615-b9c5-40eb-b206-443243dee01f@amd.com>
Date: Fri, 17 Jan 2025 08:15:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] spi: zynqmp-gqspi: Abort operations on timeout
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <20250116225521.2688224-4-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250116225521.2688224-4-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0253.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 66eefb51-b7b9-47a0-38cd-08dd36c6b999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDlqZG12UUdnM3JtVUs5WDVFa2NPTXhLQkdHM2RIY1Y1U2h6YzJneitqd3RT?=
 =?utf-8?B?MFp6MXUvbUxodVNHV3NuWExrRkdUbE01OWFaNGd1ZmhwNWRtUjYycVRaNlRV?=
 =?utf-8?B?cmtIcnh0a0czWGVMV016T2JJTVZGcFZqOWlMbDIxTHNnMWplRkk2Vmt6RTRC?=
 =?utf-8?B?TnBXYVltUzVDZEt6Sm1WQVg5U0RDQitYN3lPSDFLcm1ONGhQVWZZR1RIK1Jx?=
 =?utf-8?B?UG5ZbnViRlBTZDZORXdVbUcwVTlDdTZzblp2R2lsdmI2Yk80eDBZWGxzdmFR?=
 =?utf-8?B?U2srNkFiRUp3czUra1BZVGJYR2dXRmUzUFJ6NGFBTHJTdHEzdHFmTDVranNR?=
 =?utf-8?B?WkNQS0swTXV1bG9hNEhpcm9IdWthcDNCd05UUElMOGtkYnpXUldKbHRRVjQy?=
 =?utf-8?B?NDBTMEhQekFiWDFzVnJDb3dhYWxCU25jRzVrNjJhRUJ1NHhGTEJPaVY5Q3Vm?=
 =?utf-8?B?VC9DMFlYNDlIejJQOEhIYThoZkxVemZnOVZLcGFDeC9xcmlta1NOaTJyTndS?=
 =?utf-8?B?aDQ2emV4K1A3T1hRTnlRN0oza1hUc1hRUjFoZ1pkUDRCUWszRDQrOEFyOUhk?=
 =?utf-8?B?Tk1VWEU5RzRZNE1kb2wxZk15SGthZWpOTGlJVGVVaDdPdGt2dUkrcXFqeFN2?=
 =?utf-8?B?Zm1RNmRjTm1uV0xCdjFQKzd3TmZDSGhVQzU5OHd5eTNBeHhyMFh0TTQxZk00?=
 =?utf-8?B?Uko2SG1LeDQ1VlhIV1o5RWcvNnZNajZkRDg1dSt6K0I3eCtUblZWZFpHU1d3?=
 =?utf-8?B?aTRTRUE0aU5TSVR2UitSa0pjeHRTSTBZbGhBbjZtcXcrL1lMdWpZNGV2bXhZ?=
 =?utf-8?B?YXFGdklSbXh0N1Fvck9yUmJQbmtEbzlHcHVhR1QyODErcEtaT20vMjl5Y3dG?=
 =?utf-8?B?d0g3S0ppdGFNcE9iTFFoOEVydm9BdGZpWTY5T0RoNEJXVUhOYyttck40dVJC?=
 =?utf-8?B?bzF5Zm4vVGlkWlpQNWZ2WStZaHhzcmM0Ujl5aUNGQWM4Sll5Q3UwYkpYMHFw?=
 =?utf-8?B?cStsMXJIZnJxajVkK1VXOW94VVgzTFd6MnpIK1BycjZuQmlxRGpJQUViZXlt?=
 =?utf-8?B?bVhHNzNQd2QrOHMwY1F1dG5Wd1NmUHQxcHc4U3kvYWJTSnVwYi9PTFpiSm9S?=
 =?utf-8?B?YmpDNUVQWDdkaDVFZndScHFRdDFQUkZOSG9XU1pMdlpJdVl6K1hjWkNXejFZ?=
 =?utf-8?B?QllJcjF3OWI1SDNJamIyNjJnMm5UTXdWNlpxYW5USjhOVHYvZTI1Y2NyMWtK?=
 =?utf-8?B?ZkhsOG5icFJoYlVVTmxWTTlRcWhrMWlIOEM3SkhsSzRXOXJnNHdOZzVYQU5l?=
 =?utf-8?B?NVArOFUzS2l3WTZReDQwekFVbi9VckppMWZwa0tXUHBhallVcUpMQndnUytm?=
 =?utf-8?B?VHJLWUNBOWoyM2NhRjQ3RU5aYlovMGt0QWlLSUJmdGg3QkU3YWFQZCthZGVW?=
 =?utf-8?B?QXFzYlV2bVBZQkFISU9Mb2VhOHBNc0tLUXJ3NEZhc25RYzZEUnVWUUo3MFl4?=
 =?utf-8?B?M09FNWZUQXlyKy9MamVYUGgzT2ZDdm1vYmRiRHRGaVRwWnR3c0ZlWWFGSk5C?=
 =?utf-8?B?bWM2VDNGRk1CSWZ3Z3A0OGtuTVhNcmdyRUxKUFBkU0RNeXB1N0lnY1hmc0xX?=
 =?utf-8?B?dUNPeVM0dE51WHJYK0pwWExaV2p0YTgrRE9MaVBUYUp4Y0pWamc3bzNBS3hn?=
 =?utf-8?B?SjREU2xTb0pzbWlGMzR5L25lbGJxa3NwaXR2Yks5OHlJZTZmQjlaZmlZMkJl?=
 =?utf-8?B?aDhpQlVVeWFNTi9OTnNoTUlyUG9CVnZoUkZlVzdZZ1c1N2tHNmtORTRRU1JN?=
 =?utf-8?B?TkNVQ21pMmh3a21LL3VxSDlrbVoybkNRbW5ZdFVhY1ZMRlF3NWIyNFdIRVU0?=
 =?utf-8?Q?lwUm4MQoC/iMc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWViVFJpQW5sdEFmSVpMeXRQdnhhNmFKWktUSGN3U2xXZSt0OEV4YngwMlg1?=
 =?utf-8?B?aXFCdE0wZGZvZUQyTDh3ZkNBQldiekI1VFU1YTdFUXB2TVNzTXhDd2l1dDhQ?=
 =?utf-8?B?Q2hYR0c3RDBCQkFKWGdjVmZnSzh1TVpxSlZxK0JzVW9mWlM4bXZuVC9LSCsx?=
 =?utf-8?B?MkhTQjlZYjhvSC9USHFpR2lzeXdMWFh2eUVQSUZQU2w3akhUV003Tk81Mnl6?=
 =?utf-8?B?SnhGTkJRV0pGVnM5MDVXM0M4WmEwaG5IRURDN2F6N3JUdGtFcVNSWnBrdUZK?=
 =?utf-8?B?Q0JGUHVIa2V5dUd6aXhBV1VSbFBFTDhDQWNRdS9zLzBkc1NiNU9vWG5Ld0pH?=
 =?utf-8?B?a2UveUZBOVZ6aVV0NlVPLzBRdU80SnRZbjgzVVdnZE1NMmptb2pzK0I2OG5t?=
 =?utf-8?B?disycHVyWWV4eHlYS013MW9sRWMvTi90MGRRVm54NHNJOExnZWc5SzRXRzlG?=
 =?utf-8?B?UHdtbFVwOFdETFdYeUNOYUhPaVdISlQ4M1N6alpRNGVhUUlyR3NBYWJleERt?=
 =?utf-8?B?QUNCd1U0OFRLUHdPMHFUOFZnenRxWnJkTjZkSUtJZUhHZ0dKTkludzhnb0or?=
 =?utf-8?B?MVhDZmVSUDVOUm1hNTlyVHc1TDdxR0s1T1BHRFBEMW5JQ0JJYVZpa1dxak5I?=
 =?utf-8?B?dm9qd3JXZUsxblZCRW5Zb2ttQXIvVlN0RWQ5RktJSmlERGZ2WDkzbjZwTjV5?=
 =?utf-8?B?RUt1QWRCYlFMdUN5K2trVW9RVUU0VkpvRnNLVm1QemVSeGlnek1TMkpaNUVT?=
 =?utf-8?B?VE84blNsTzhENlVISmdlSVRHeVhMV0JDT2Frb3NvZlBqdWszWDBHUEs5Z0ZB?=
 =?utf-8?B?N3pucUFDMUFacWpualh5WjNiVzF6K3diZUpPZnY3dU1QdGtCaFl6bURqQngx?=
 =?utf-8?B?VnpnODdTb1RHdlEvSHVpYXdCcEZ3RHZRcXJ1bUdYUVBpUXZ1cmhuaTM4WDFj?=
 =?utf-8?B?K2RXUkhrKy92ajFzNVl3RUNma3dJM1R3WTlNd090Y0JWU1g3dytYN3g3d0xX?=
 =?utf-8?B?TGlycGVtQ1gzcUZiOFlKVG9JTGtZQTlZakdQc0JsN1lYT00zLzlERWx2Zzkv?=
 =?utf-8?B?MGI4U3AvZUZ6bkxNOTZXYjJUMVdoT2xna0hITEFhSFo5Z0VBWkFsc1d0a1N1?=
 =?utf-8?B?TVZjM3FBNFdNZk9aUEM5QkZVd0x4eGtMSGNNWDlUMWU1bHNJRVVCakVQd1dE?=
 =?utf-8?B?cXFIcHFWQ0RqeVJZUDZtZDR3TmxUNUl3VkY2QmNiQStmclUvZko2L2hsV2Z1?=
 =?utf-8?B?RUJEYnY5eHNzOGd6Umx0cnZ3K3FKcGhSZDlscnY0SEpUNGpNTzBwNjgyN1Fv?=
 =?utf-8?B?VU9KTmRyRnQ0RHZJamFCVjR5T2hRTW9KN1hlS09EVGpZaXpYV3JyZXgxVWJO?=
 =?utf-8?B?bEtrVkpuSys3bWZmaWZ2c3NJY3dwYXQvNE4ySTY0ZjVnTlBMdjFRdXR0WWlD?=
 =?utf-8?B?WUwvR01LL2pXYWYyOXhNT05vNFVQMkpzUjNrTDF3N1JBb2NiUG5oTmhWcElr?=
 =?utf-8?B?TjhBdDdsV0luNVRxbmxXR05Ra0JOQytWN252UmZKNGxJMDlISCtnUzJaK2ww?=
 =?utf-8?B?eGh5a2JRcXJtT1Y0eXZIOGVjeE5lZnkrZjhmeFZUZ2REcXZzWExhKzAwYUcv?=
 =?utf-8?B?WGpLWmtBWFFzMHRXWXpIRkRsOTUyaHN0azY5MTZyS3BYL2hJdFNpSVBYd0I0?=
 =?utf-8?B?V1pHSDdIcyt4Y1k2RzgzOXJsWVoyNUxnbHFRb3hCdThqVXJqaVhnSWhhcG5V?=
 =?utf-8?B?SzYvTEZyd280SWppSWhvSXhPUEwyUXU3bHZVbWFSV3ZyczljU1JqT202ZzBz?=
 =?utf-8?B?QlF1M0h6QThFdTdLSWx4em8rQTIrREkzUTZ1MWVKTFpqdFJROGhSWG1JVmFO?=
 =?utf-8?B?Q3M1MjRFT0JkZW01b0M5WDdaSEdEYmxIcHVmVmw0SnlWaEFpWVU2TjRkZHoy?=
 =?utf-8?B?bThDR3F0QUhEU1R0RWxOeFRoaXRqODg4ajB0RTE1UVlXTllrY1JiTFdHRlpk?=
 =?utf-8?B?bXFZY1FuMENVMTJnRzBKMEtpbVltU3poTjhUcFFiOUdzRHptRHUyQXA5aG1w?=
 =?utf-8?B?Z1pLZFoxZGZLcUM5dGJnNm45OUdicTI3Y29JbEVSeHVyYlo5dzh0TkJybEhS?=
 =?utf-8?Q?lD8MtC37Ux6/AhVbbekqF/7qB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66eefb51-b7b9-47a0-38cd-08dd36c6b999
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:15:30.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4i8ydq8Plek0CmCEaYZLF0ZRO30T92rkvRNqEiggbr/vVSarrpga9/Tu3DDJRe6P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296



On 1/16/25 23:55, Sean Anderson wrote:
> When an operation times out, we leave the device (and driver) in an
> inconsistent state. This generally results in all subsequent operations
> timing out. Attempt to address this by resetting/reinitializing the
> device when we have a timeout. This tends to be fairly robust.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/spi/spi-zynqmp-gqspi.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 7d138f45b692..cf47466ec982 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -1057,6 +1057,21 @@ static unsigned long zynqmp_qspi_timeout(struct zynqmp_qspi *xqspi, u8 bits,
>   	return msecs_to_jiffies(timeout + 100);
>   }
>   
> +

unnecessary newline here.

> +static int zynqmp_qspi_wait(struct zynqmp_qspi *xqspi, unsigned long timeout)
> +{
> +	int ret;
> +
> +	ret = wait_for_completion_timeout(&xqspi->data_completion, timeout);
> +	if (ret)
> +		return 0;

newline here please

> +	dev_err(xqspi->dev, "Operation timed out\n");
> +
> +	/* Attempt to recover as best we can */
> +	zynqmp_qspi_init_hw(xqspi);
> +	return -ETIMEDOUT;
> +}
> +
>   /**
>    * zynqmp_qspi_exec_op() - Initiates the QSPI transfer
>    * @mem: The SPI memory
> @@ -1104,11 +1119,9 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
>   				   GQSPI_IER_TXNOT_FULL_MASK);
>   		timeout = zynqmp_qspi_timeout(xqspi, op->cmd.buswidth,
>   					      op->cmd.nbytes);
> -		if (!wait_for_completion_timeout(&xqspi->data_completion,
> -						 timeout)) {
> -			err = -ETIMEDOUT;
> +		err = zynqmp_qspi_wait(xqspi, timeout);
> +		if (err)
>   			goto return_err;
> -		}
>   	}
>   
>   	if (op->addr.nbytes) {
> @@ -1133,11 +1146,9 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
>   				   GQSPI_IER_TXNOT_FULL_MASK);
>   		timeout = zynqmp_qspi_timeout(xqspi, op->addr.buswidth,
>   					      op->addr.nbytes);
> -		if (!wait_for_completion_timeout(&xqspi->data_completion,
> -						 timeout)) {
> -			err = -ETIMEDOUT;
> +		err = zynqmp_qspi_wait(xqspi, timeout);
> +		if (err)
>   			goto return_err;
> -		}
>   	}
>   
>   	if (op->dummy.nbytes) {
> @@ -1204,8 +1215,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
>   		}
>   		timeout = zynqmp_qspi_timeout(xqspi, op->data.buswidth,
>   					      op->data.nbytes);
> -		if (!wait_for_completion_timeout(&xqspi->data_completion, timeout))
> -			err = -ETIMEDOUT;
> +		err = zynqmp_qspi_wait(xqspi, timeout);
>   	}
>   
>   return_err:

M



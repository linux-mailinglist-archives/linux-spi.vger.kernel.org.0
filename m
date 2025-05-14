Return-Path: <linux-spi+bounces-8121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB91AB74F3
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94CD1886E03
	for <lists+linux-spi@lfdr.de>; Wed, 14 May 2025 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932728C86D;
	Wed, 14 May 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mgQUzlWn"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D127FD7F;
	Wed, 14 May 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249322; cv=fail; b=IV17l49QcDPy7DxgXevfdrfS+0goAI7vKcabB5BSOY0OeHxloPfvpxyIffp3jYmFkTuFP1hMP59MHm3UgSEHhOPpLHLz4EZN6NrUm6NpoH50ZC6kqb1L2BUOL7lgRs9lzKHcKHDT/b1VJoPdGLHwqkHbLfoVqO0kc9bJmC0brIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249322; c=relaxed/simple;
	bh=P3pf0kSttUFonH177CWDKJjp/nmvSmqEiBQ1dB+ukng=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fnXS+AYMe2II85VBUWsnzf8YMZnSjukin3muAvnJw7bGS8spGt1i7OXPOmbPM0y/V6SQXHPcY6UFwt4V0CmzA0T7ilz1TwD+vHNdlGFyDPpIEX2S1WzjkFmFpo7AENFJWMJo0cwfvZ19Hc+Dct7G8e39s33fF1IHbPrlKrJaBNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mgQUzlWn; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWYU0OKAoRtLRv5JTOVJAV4TB7HW/c64lfYY7+E4rpVkK8Qn9ryNuUie4Y2bCYuxkTgqhs7J4CQL2Kz1jdFQv1PkZb9WG1ftd+HbVRpXEssybMmBzy2qLZOtgf0VuTLuK8nDdb7I5/NkGUU9XH4hk2b7SWIcglONDfRc/xy2RqxmfrOkLY/darHRXaAd/ce3XRkzhrmWsVQ4fldtpS0aWHSDyb79ToSasGXAko6Ztz8mMrG3+kH4iMiMpKgZf/+y7nhT4VZAs1l4XDnSJD6/vokfqjgalKOh5Tmol9c+Cj4eFoGh1PAQXonEbpvgISN0bv8jawC88XwDKUIJDa/ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjKL/vCzTthGleSaEPOa2YHDkmrqCMw6PbbVgo2qjWA=;
 b=QefWDyuFVHIS1yLbfdjA7JnE62siyBBNTbd3ABE84eDCvqczay5eICHik7fzcY8cgdSQFpBD0ATH+oDIYPVhOcrqB9WIepUMN/UAyAIdfiDyCPSyZgrYleA8/Ed0S0oA1BL8yT1winceAv/kpxDi6gnjk3NfiNkCw2Tg/WaFlkVWGgBB0Kv3Jb1tTjl9azHYgsZ9CRch0LSEI16MtqESFu10NpF8IGZAcgvVZdX6pMZ6Stjvh0fMN8+h/oyOuFP3Uc8jpceWS69Y0RI7Lto1z35u+kgEvn0BC2sdkNdLrrgpdF4DwS6MbtRm2X3n4V+50yAbOsXnU7o2Ga5BBNtuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjKL/vCzTthGleSaEPOa2YHDkmrqCMw6PbbVgo2qjWA=;
 b=mgQUzlWn2uyqplF6IH74swOtben9z0mYHyMUAb6zC82wcWb4ygwcdUlVG2pWYCEQFuMFtsLy1RiUDhwwMLggsRApA+VIe5d9A8rqSUCupFPkft3tZ0r/9cMt02ozwMwgVaQQ3mQ8DE4RVHCCxf4lYTcjQsnPllwDVmk+FYCWyLQ9NwNdw1uAMh+/MtpDfgwTuzIVDF/qd2NfwhZHBWwgVOJapAFn0r0qJb3LhsHxIK9W5wYQihk7tsA2C0c0dl3+DV1Ald3sbKajUs/SQNh8AA7BSOAvjO8LzZBfCGp4LrmKbZFSokeV6aSOb7/d9pvjL61qSluRbAI+eq2j9KV0Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 19:01:54 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 19:01:54 +0000
Message-ID: <9971eb7b-bf39-4b4e-aed0-7ea1fb9d23d3@nvidia.com>
Date: Wed, 14 May 2025 20:01:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] spi: tegra210-quad: Add support for internal DMA
To: Vishwaroop A <va@nvidia.com>, krzk@kernel.org, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, skomatineni@nvidia.com, ldewangan@nvidia.com,
 kyarlagadda@nvidia.com, smangipudi@nvidia.com, bgriffis@nvidia.com,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250513200043.608292-1-va@nvidia.com>
 <20250513200043.608292-2-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250513200043.608292-2-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4ecced-a38f-4f6c-e50c-08dd9319ca95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG9Xd1U0OC9FVFhoS1NnbkNSN1hnODMzZzBOblk0UjAzNnM4cWxHWlBGWDJP?=
 =?utf-8?B?U0JhYWt0TVYwck1BU20zVm9SQmNWTUErR2lkTDBXQkpKQm9XRmdEMTY5QVZK?=
 =?utf-8?B?bE5RcVZjRW43dUZzZE5hTk1BcFg3UER3LzZ5RUhoVW1TV0RQL0xMSzVFSzEy?=
 =?utf-8?B?RnlQWllSaXdxZ081aHV4TEpFMk9vTlRZelY4NjZRTnd6c1RoQk1ubGJKRkNG?=
 =?utf-8?B?Rnd5YzI4a3BtZmMyN3pYOWJWUlhmZE5CMmxIUGpRNDJsekEwdHo1TVM0cGFp?=
 =?utf-8?B?NEVzUjl2dUJXUEYvSU5WRUpVWmcrRURRMmU3QVBKUFJ1YkhXZnRaYTZ2VVRG?=
 =?utf-8?B?K3A4TWpxK09Mb0RqZVRTR2pubmlram0zYW9NL2xNWitQMDFaOXNJU2tlaGpo?=
 =?utf-8?B?aXIxK0VoWHo5MUhpVEhJd0tNU2MwNkU5YVdWR0w1YjBuYU5tOGhNMW9xMkdL?=
 =?utf-8?B?ZEVLQ21XdXlhNUhmUU1wUXJuT3ByUFBmOXZSdDRUTGlPQ2F0b09ZazlHVCty?=
 =?utf-8?B?MjZocnBDSkdldWxXSE0yUm5ZZkVvckYzQTBEUklRTUgyK2VzMGVVMUlUZnJG?=
 =?utf-8?B?YnhNNDEzWS9iOFkrTVdQMVZIRDlDU2Nsa255Q2JWSGhJaXR2NWpJd01CTWtO?=
 =?utf-8?B?SHd3ZXQxUTlSWGtuZ2NCU0w3MHZrSUk5S3I5bzlZOWkyeE83bmpXMENRcFVj?=
 =?utf-8?B?VGJPUi8za1Vlc215bS92RG1zSVpWeHhHSkFvTWRqanpBMFB0TEl0L3ZnMEFm?=
 =?utf-8?B?MEhXSjlSOTltL0cwdTMvTHZUNHBlcUpKSFRMWkR2ZjBGbjZmYVRnZHpjc3c1?=
 =?utf-8?B?ZlRtV0FGUmxvNXMxTm9uRHA2WllxVGlOKy9xL2tabUIxSFdYOTdac2gwMlFO?=
 =?utf-8?B?UW50V1c4RE1hVHFWY3NGNlRIMDZlNTZBUlphc1VMT2I3cTNEeTgySDNBTEpZ?=
 =?utf-8?B?eUhrYjdZUmVtMDFoRllhdi9aMzI4ZHg0aXpkMjV3dG9vMDVLYnlYa1RQOW9T?=
 =?utf-8?B?N1ZuaUs0NFpKZlNrM1FDTDBSZVlmNTlqcFBKam5oK2VGaGo5L2Zza25ZbWw0?=
 =?utf-8?B?MnVSN3FBVUFSTFRWNmp0WlNXd0htakFOQzk0SlpQd3h5cm5zQzdXdElGbmFP?=
 =?utf-8?B?WWU5U0VSdTQ0eDdXeTJZbjlCdFNsVU5IZ0E3Zk04MkR0c0kxeUpQZDMrMkcz?=
 =?utf-8?B?djdBb29mbTlnRkpLekRRTU55ck5oRXl4czVibHY2aFZGeThMdHJwcGJoU3ZG?=
 =?utf-8?B?WmFJL20yOTB2Zlk2T1h2UGtVUHhmRVlQNEF5Njk0UVpYYjFzKzVXRDRqY3JH?=
 =?utf-8?B?ZHUwVkYzdit4Z3JHSTZQcmdCeTVVUHVSK090b29VeXpqcmVMVHUxdHFQa2x3?=
 =?utf-8?B?cHQ5YTF2dTRtV05MSHFKa2krVUV3KzNMTDk0Vjc2VE56RUMzNWN5OHVCWVc3?=
 =?utf-8?B?ZUJqU3QxYWxxckNIelF0YWI5S1B6WmdtZU5PQUdENFAzSDQ0RnlTUUdvOGE5?=
 =?utf-8?B?cDlvRXJoYVVoNWhIRXlLcTQ4MWxCUmpmYXdpZk1NUEVsSVJEZjN5NkR1TTk2?=
 =?utf-8?B?TXV5RzdtMFc4eURjL3JCR2Q4bnFTWDM4a1hmbm4reU1BWDh1VEJkZVhQVFh6?=
 =?utf-8?B?cVYzZ1hYaXIzRFZ1eFZBckd5WjJtaGNqUnhML0I0QmRaN3poU01Hc0VxQTZx?=
 =?utf-8?B?MHBIOGZVUHZrc2NGNllnOE5ucmlVeHR3MUl6cElObUxZekt5Q2V6bmpFVFJq?=
 =?utf-8?B?QnZ1U3VmRU45eXk1QVE0M1pNQmN4UWp6aFV6Q040WDVWYVQ4Mmh2ZXpaQ2xs?=
 =?utf-8?B?OVBhVEsrbnZYR3lFbEdVNFVEUWh6WGhORDlCYTFYNU1pakoxR04yVDdEZk53?=
 =?utf-8?B?TXI3UkphZUtwcGRxS1VXQ015TGM4QmlhaE01N2pqRDlwVVZpYlVic1B1d1NQ?=
 =?utf-8?B?c2x4bEttVmx4ditORHlsZWk1Q3Jub1NvdnlmSkxqajA1bk1PRnU4YVl0MXpZ?=
 =?utf-8?B?NVpWSk45NUNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlJQMnRzUk5ESy9sUXdZQ01hYW5zM2tHOVlqbVhrOElqL2hXaXEzZmtkZnZG?=
 =?utf-8?B?Y2czcThWN1d0QWxYNk4xSTdNanZKVkFyejFzUUdFbXlFSEJ1eHJURUpWakM4?=
 =?utf-8?B?Zms3V0N0TlVwcmorMWxxRXV1Rm9BeVY0cUw2VU0zbC9HUEI4dHI1ZFZZczhs?=
 =?utf-8?B?MVJwczFmMkZNcE02WGIvL1dJcG13ekpQSGx2Zjl5R05WTTV4azVRSnlLRSs4?=
 =?utf-8?B?cm03b3dDaGpoL3hES1J3YmpDaGR0QmxqR213Q0JhR2NUdTJzcXlWR3JlN0JI?=
 =?utf-8?B?TEp4eXJiUUJmZXlFSWs0Szg0ZnUydkhLUXdRMXRFNnFjNnUzWWVKN05VSWly?=
 =?utf-8?B?d0RIVDFOOGxNM3JtcWFiMnZKYkxZSlg1MU1HQ3ZKMjgwL092clY5UWlCN3NI?=
 =?utf-8?B?alZYUlJESzNPekE4YXZqQU1CSWtKL0ZpTjlROCtRN0ZpL0Y2RS9aQ21vcFdO?=
 =?utf-8?B?aDhQZm16ckF6U2svQlBFaDczamhobCtXNlFaK2MwQjN4QzEyNXh1U3d3TVVk?=
 =?utf-8?B?cDhBWGU5ekJERlhUY0EzWHhVbEpYTTdyaFQ1SlJNRE8zbjJxVG1ibGoyQzRU?=
 =?utf-8?B?V0VYaUl6bW1iV3RNV1BKWFZmd2VTOWxpYk9xUmU3YVBzQjQxMXlBdUU4dXVG?=
 =?utf-8?B?VERrZysxVUswRXNJUlpVMDJVK0d1WDVMUUp5c2NQWDZhVGhOYnRKb0VrUllm?=
 =?utf-8?B?VzhDNCs5alAvR2tjdENLUENtbWxxZUQ1MDZvTXo2WXk3cG90dmlaZ0U2VnRD?=
 =?utf-8?B?T3Jvc3FQUjExUHFoVHZrUkJ4eUVId0RLVXpac1dFakdWOXAvaVgrRW9waTZt?=
 =?utf-8?B?djBoUTdQOHAvT0xaNU15NnQrcmhXNlA3NXBkNEVNOEdvS2NBNkg5NHZrUmcz?=
 =?utf-8?B?L1ppVHlFRlhsTzR2amdoSzB0REtycE0zZkN1dERxcUJhUkI5TnFEVXpZV1Ja?=
 =?utf-8?B?U3hvUHk0U25DTjZYVHpVV3Y2V3prdkNGYTNqenJsUHg2QmJadWpVOGs1ZDZk?=
 =?utf-8?B?SVNUc0EvL3E5TWFRa3VwL1FFUTlqSVh6ekJvQjk5MEloOFpXUE00MDB6c0Nh?=
 =?utf-8?B?T05Kakl1bE1YMjRtbG5DUHpUV00yRmVuK0xvNUcrRjVTSEhubnFRNU9WSnJI?=
 =?utf-8?B?NWoyRDdzWkxjTFAzeDZaMmdqNkZYVGp5UlJVVnk2ZWFxWlFZVENzTnFpcUdw?=
 =?utf-8?B?VXpnSW90MG5icUlLWitxNHE4eEhJNWxRWWZrUldDdFNZZzdpMWx4VVJzSmZE?=
 =?utf-8?B?NktvMkhyZVdBa293SklUMmxvbEtuejdieW1yRURjWG1GclIrTHZsRmhMRTdH?=
 =?utf-8?B?ZXJPUGR5WkVxM0g1NkNVY09LckhzODdtdFdoRUltL3dtWDhwNHVFSXV6cXow?=
 =?utf-8?B?clRIWW5NM2FrQlk5dEUvVmhNVU9icmhDckpXY0VpblFyc2UrbzdVUDBaeHdO?=
 =?utf-8?B?cG45aytJNVo3S0NVYjFIeGFxRGRCb1dCTXU0c0tXNG9vZ2tZZGtxMWtPR3U5?=
 =?utf-8?B?bFFQMktxeUxsdXcrSkFmR2dKVGxNSGltWWxITWEvYzBocC83K3B3UTJ2ZUQ5?=
 =?utf-8?B?eHozaEtiTUN4M1o1ZjlxSkFqVTBUSWwrYkFUMXRYcWpvamNSMEx6R3pTUGRk?=
 =?utf-8?B?UDRYbHhtTGN6QWNxb2tLVENuODQvcHRIUGM0VXgxV1JoclBpdFN3V2t4Q2Iz?=
 =?utf-8?B?UVpZWXVkYkYwTHAwVW92djcwZE4zUXlXU1JLcjVTNVhiSVZtdVI1VElsUjYx?=
 =?utf-8?B?Zmxla1pLNkc1NVViR2hmdXg5dXlET01FRGYwZHhWZXI2bkhGZHcxSjRQSHcx?=
 =?utf-8?B?NEp3R0xOcW9RUFNGUjh3MktWK0JyZkdFS1dCWEphZmg2bHVsNmRQV0hWK080?=
 =?utf-8?B?dStKa0VMMXpUMjdrU2dxcXN6TkRHTWM0S1VkcFNVUUIzdjBlS0VFazlUeXZu?=
 =?utf-8?B?Z2dRY1hJZElFZ3NMKzBsVnczWmU0OWRxY3NQdFljVjQ5amdyOFFnUCtCU1Vk?=
 =?utf-8?B?ZjVTTEhJVUJtZVovLytUUG9pTlNnVUl4b3h4bmo1eHozSjRzeldBWmYyU3Qv?=
 =?utf-8?B?UnJZekUyTTdEZWp6UFBtdkRFUGtQMUc4Q2l3a01jdWlkWG81SFh6R3FZM0hB?=
 =?utf-8?B?UWIzOXdHYlNHYzc4cEpRR0J6TEthYjY0U05pbEVrZlRnTldpdzlWbVdpdXVL?=
 =?utf-8?B?QVlDNmN5bFNXRWRYd0w3T3ZTRGFPbzF4UWx3RW1jQTAvb0F2OFpveGkvMFRv?=
 =?utf-8?B?WCtLYUdXTFBZYjczSjRlQlovVk5BPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4ecced-a38f-4f6c-e50c-08dd9319ca95
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:01:54.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4xltbgZcOZ7MEae61W9Il+ApiHl1/FXwLxpj1OefydE1tGcZs/G7ac9zah6xDyTXLhqig2YlU7YlEOSXNQ+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199


On 13/05/2025 21:00, Vishwaroop A wrote:
> Add support for internal DMA in Tegra234 devices. Tegra234 has an
> internal DMA controller, while Tegra241 continues to use an external
> DMA controller (GPCDMA). This patch adds support for both internal
> and external DMA controllers.
> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 225 +++++++++++++++++++-------------
>   1 file changed, 131 insertions(+), 94 deletions(-)
> 
> Changes since v3:
> - No changes from v2
> 
> Changes since v2:
> - Fixed version number to match the actual version
> - Added proper changelog section
> - No functional changes from v2
> 
> Changes since v1:
> - Added support for Tegra241 device which uses external DMA controller (GPCDMA)
> - Renamed variable 'err' to 'num_errors' for better clarity
> - Added DMA mapping functions for buffer management
> - Added support for internal DMA controller on Tegra234
> - Added new DMA registers QSPI_DMA_MEM_ADDRESS and QSPI_DMA_HI_ADDRESS
> - Modified DMA initialization to handle both internal and external DMA controllers
> - Updated DMA transfer logic to support both internal and external DMA paths
> - Added proper error handling for DMA transfers
> - Updated SoC data to reflect DMA controller type (internal vs external)
> 
> Initial Version:
> - Initial implementation of internal DMA support for Tegra234 QSPI
> - Added DMA channel initialization and configuration
> - Implemented DMA mapping functions for buffer management
> - Added support for both transmit and receive paths
> - Renamed variable 'err' to 'num_errors' for better clarity
> - Added support for Tegra241 device with external DMA controller
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index a93e19911ef1..3581757a269b 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -111,6 +111,9 @@
>   #define QSPI_DMA_BLK				0x024
>   #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
>   
> +#define QSPI_DMA_MEM_ADDRESS			0x028
> +#define QSPI_DMA_HI_ADDRESS			0x02c
> +
>   #define QSPI_TX_FIFO				0x108
>   #define QSPI_RX_FIFO				0x188
>   
> @@ -167,9 +170,9 @@ enum tegra_qspi_transfer_type {
>   };
>   
>   struct tegra_qspi_soc_data {
> -	bool has_dma;
>   	bool cmb_xfer_capable;
>   	bool supports_tpm;
> +	bool has_ext_dma;
>   	unsigned int cs_count;
>   };
>   
> @@ -605,13 +608,16 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
>   
>   	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
>   
> -	dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
> -	dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
> +	if (t->tx_buf)
> +		dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
> +	if (t->rx_buf)
> +		dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
>   }
>   
>   static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
>   {
>   	struct dma_slave_config dma_sconfig = { 0 };
> +	dma_addr_t rx_dma_phys, tx_dma_phys;
>   	unsigned int len;
>   	u8 dma_burst;
>   	int ret = 0;
> @@ -634,60 +640,86 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
>   		len = tqspi->curr_dma_words * 4;
>   
>   	/* set attention level based on length of transfer */
> -	val = 0;
> -	if (len & 0xf) {
> -		val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> -		dma_burst = 1;
> -	} else if (((len) >> 4) & 0x1) {
> -		val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> -		dma_burst = 4;
> -	} else {
> -		val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> -		dma_burst = 8;
> +	if (tqspi->soc_data->has_ext_dma) {
> +		val = 0;
> +		if (len & 0xf) {
> +			val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
> +			dma_burst = 1;
> +		} else if (((len) >> 4) & 0x1) {
> +			val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
> +			dma_burst = 4;
> +		} else {
> +			val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
> +			dma_burst = 8;
> +		}
> +
> +		tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>   	}
>   
> -	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
>   	tqspi->dma_control_reg = val;
>   
>   	dma_sconfig.device_fc = true;
> +
>   	if (tqspi->cur_direction & DATA_DIR_TX) {
> -		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
> -		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		dma_sconfig.dst_maxburst = dma_burst;
> -		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> -			return ret;
> -		}
> +		if (tqspi->tx_dma_chan) {
> +			dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
> +			dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.dst_maxburst = dma_burst;
> +			ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
>   
> -		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> -		ret = tegra_qspi_start_tx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
> -			return ret;
> +			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +			ret = tegra_qspi_start_tx_dma(tqspi, t, len);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
> +				return ret;
> +			}
> +		} else {
> +			if (tqspi->is_packed)
> +				tx_dma_phys = t->tx_dma;
> +			else
> +				tx_dma_phys = tqspi->tx_dma_phys;
> +			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> +			tegra_qspi_writel(tqspi, lower_32_bits(tx_dma_phys),
> +					  QSPI_DMA_MEM_ADDRESS);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS);
>   		}
>   	}
>   
>   	if (tqspi->cur_direction & DATA_DIR_RX) {
> -		dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
> -		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		dma_sconfig.src_maxburst = dma_burst;
> -		ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> -			return ret;
> -		}
> -
> -		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> -					   tqspi->dma_buf_size,
> -					   DMA_FROM_DEVICE);
> +		if (tqspi->rx_dma_chan) {
> +			dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
> +			dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.src_maxburst = dma_burst;
> +			ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
>   
> -		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
> -			if (tqspi->cur_direction & DATA_DIR_TX)
> -				dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			return ret;
> +			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
> +						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
> +			ret = tegra_qspi_start_rx_dma(tqspi, t, len);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
> +				if (tqspi->cur_direction & DATA_DIR_TX)
> +					dmaengine_terminate_all(tqspi->tx_dma_chan);
> +				return ret;
> +			}
> +		} else {
> +			if (tqspi->is_packed)
> +				rx_dma_phys = t->rx_dma;
> +			else
> +				rx_dma_phys = tqspi->rx_dma_phys;
> +
> +			tegra_qspi_writel(tqspi, lower_32_bits(rx_dma_phys),
> +					  QSPI_DMA_MEM_ADDRESS);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(rx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS);
>   		}
>   	}
>   
> @@ -726,9 +758,6 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
>   
>   static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
>   {
> -	if (!tqspi->soc_data->has_dma)
> -		return;
> -
>   	if (tqspi->tx_dma_buf) {
>   		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
>   				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
> @@ -759,16 +788,29 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
>   	u32 *dma_buf;
>   	int err;
>   
> -	if (!tqspi->soc_data->has_dma)
> -		return 0;
> +	if (tqspi->soc_data->has_ext_dma) {
> +		dma_chan = dma_request_chan(tqspi->dev, "rx");
> +		if (IS_ERR(dma_chan)) {
> +			err = PTR_ERR(dma_chan);
> +			goto err_out;
> +		}
>   
> -	dma_chan = dma_request_chan(tqspi->dev, "rx");
> -	if (IS_ERR(dma_chan)) {
> -		err = PTR_ERR(dma_chan);
> -		goto err_out;
> -	}
> +		tqspi->rx_dma_chan = dma_chan;
>   
> -	tqspi->rx_dma_chan = dma_chan;
> +		dma_chan = dma_request_chan(tqspi->dev, "tx");
> +		if (IS_ERR(dma_chan)) {
> +			err = PTR_ERR(dma_chan);
> +			goto err_out;
> +		}
> +
> +		tqspi->tx_dma_chan = dma_chan;
> +	} else {
> +		if (!device_iommu_mapped(tqspi->dev)) {
> +			dev_warn(tqspi->dev,
> +				 "IOMMU not enabled in device-tree, falling back to PIO mode\n");
> +			return 0;
> +		}
> +	}
>   
>   	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
>   	if (!dma_buf) {
> @@ -779,14 +821,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
>   	tqspi->rx_dma_buf = dma_buf;
>   	tqspi->rx_dma_phys = dma_phys;
>   
> -	dma_chan = dma_request_chan(tqspi->dev, "tx");
> -	if (IS_ERR(dma_chan)) {
> -		err = PTR_ERR(dma_chan);
> -		goto err_out;
> -	}
> -
> -	tqspi->tx_dma_chan = dma_chan;
> -
>   	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
>   	if (!dma_buf) {
>   		err = -ENOMEM;
> @@ -1128,15 +1162,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   			if (WARN_ON_ONCE(ret == 0)) {
>   				dev_err_ratelimited(tqspi->dev,
>   						    "QSPI Transfer failed with timeout\n");
> -				if (tqspi->is_curr_dma_xfer &&
> -				    (tqspi->cur_direction & DATA_DIR_TX))
> -					dmaengine_terminate_all
> -						(tqspi->tx_dma_chan);
> -
> -				if (tqspi->is_curr_dma_xfer &&
> -				    (tqspi->cur_direction & DATA_DIR_RX))
> -					dmaengine_terminate_all
> -						(tqspi->rx_dma_chan);
> +				if (tqspi->is_curr_dma_xfer) {
> +					if ((tqspi->cur_direction & DATA_DIR_TX) &&
> +					    tqspi->tx_dma_chan)
> +						dmaengine_terminate_all(tqspi->tx_dma_chan);
> +					if ((tqspi->cur_direction & DATA_DIR_RX) &&
> +					    tqspi->rx_dma_chan)
> +						dmaengine_terminate_all(tqspi->rx_dma_chan);
> +				}
>   
>   				/* Abort transfer by resetting pio/dma bit */
>   				if (!tqspi->is_curr_dma_xfer) {
> @@ -1251,10 +1284,12 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   						  QSPI_DMA_TIMEOUT);
>   		if (WARN_ON(ret == 0)) {
>   			dev_err(tqspi->dev, "transfer timeout\n");
> -			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
> -				dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
> -				dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			if (tqspi->is_curr_dma_xfer) {
> +				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
> +					dmaengine_terminate_all(tqspi->tx_dma_chan);
> +				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
> +					dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			}
>   			tegra_qspi_handle_error(tqspi);
>   			ret = -EIO;
>   			goto complete_xfer;
> @@ -1323,7 +1358,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
>   			return false;
>   		xfer = list_next_entry(xfer, transfer_list);
>   	}
> -	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
> +	if (!tqspi->soc_data->has_ext_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
>   		return false;
>   
>   	return true;
> @@ -1384,41 +1419,43 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
>   	unsigned int total_fifo_words;
>   	unsigned long flags;
>   	long wait_status;
> -	int err = 0;
> +	int num_errors = 0;
>   
>   	if (tqspi->cur_direction & DATA_DIR_TX) {
>   		if (tqspi->tx_status) {
> -			dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			err += 1;
> -		} else {
> +			if (tqspi->tx_dma_chan)
> +				dmaengine_terminate_all(tqspi->tx_dma_chan);
> +			num_errors++;
> +		} else if (tqspi->tx_dma_chan) {
>   			wait_status = wait_for_completion_interruptible_timeout(
>   				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
>   			if (wait_status <= 0) {
>   				dmaengine_terminate_all(tqspi->tx_dma_chan);
>   				dev_err(tqspi->dev, "failed TX DMA transfer\n");
> -				err += 1;
> +				num_errors++;
>   			}
>   		}
>   	}
>   
>   	if (tqspi->cur_direction & DATA_DIR_RX) {
>   		if (tqspi->rx_status) {
> -			dmaengine_terminate_all(tqspi->rx_dma_chan);
> -			err += 2;
> -		} else {
> +			if (tqspi->rx_dma_chan)
> +				dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			num_errors++;
> +		} else if (tqspi->rx_dma_chan) {
>   			wait_status = wait_for_completion_interruptible_timeout(
>   				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
>   			if (wait_status <= 0) {
>   				dmaengine_terminate_all(tqspi->rx_dma_chan);
>   				dev_err(tqspi->dev, "failed RX DMA transfer\n");
> -				err += 2;
> +				num_errors++;
>   			}
>   		}
>   	}
>   
>   	spin_lock_irqsave(&tqspi->lock, flags);
>   
> -	if (err) {
> +	if (num_errors) {
>   		tegra_qspi_dma_unmap_xfer(tqspi, t);
>   		tegra_qspi_handle_error(tqspi);
>   		complete(&tqspi->xfer_completion);
> @@ -1444,9 +1481,9 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
>   	/* continue transfer in current message */
>   	total_fifo_words = tegra_qspi_calculate_curr_xfer_param(tqspi, t);
>   	if (total_fifo_words > QSPI_FIFO_DEPTH)
> -		err = tegra_qspi_start_dma_based_transfer(tqspi, t);
> +		num_errors = tegra_qspi_start_dma_based_transfer(tqspi, t);
>   	else
> -		err = tegra_qspi_start_cpu_based_transfer(tqspi, t);
> +		num_errors = tegra_qspi_start_cpu_based_transfer(tqspi, t);
>   
>   exit:
>   	spin_unlock_irqrestore(&tqspi->lock, flags);
> @@ -1474,28 +1511,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
>   }
>   
>   static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
> -	.has_dma = true,
> +	.has_ext_dma = true,
>   	.cmb_xfer_capable = false,
>   	.supports_tpm = false,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
> -	.has_dma = true,
> +	.has_ext_dma = true,
>   	.cmb_xfer_capable = true,
>   	.supports_tpm = false,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
> -	.has_dma = false,
> +	.has_ext_dma = false,
>   	.cmb_xfer_capable = true,
>   	.supports_tpm = true,
>   	.cs_count = 1,
>   };
>   
>   static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
> -	.has_dma = false,
> +	.has_ext_dma = true,
>   	.cmb_xfer_capable = true,
>   	.supports_tpm = true,
>   	.cs_count = 4,


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic



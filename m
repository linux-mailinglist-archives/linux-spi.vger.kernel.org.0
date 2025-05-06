Return-Path: <linux-spi+bounces-7925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9DAAC167
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 12:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF8518809D0
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B908725F795;
	Tue,  6 May 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJMxh+9U"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC58F66;
	Tue,  6 May 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527519; cv=fail; b=s13SQsgeFo5IJPRWyGu3G6A9l+nkSSbMUFr15ezVaahH95FxqgLyVFwop+55OHv1OGN6NzN+Jf3RmMNNexhR+F8mj5LsTIlX37ppysXHBi9Sl/B7fKKnccpCZQNqhveAiVOjRaUerr3+5rESjTNu5MuqE5SvFSCDoruq//NlG4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527519; c=relaxed/simple;
	bh=pNWPJsXEubjk58YzXpPJeM4xY8jDjg0yKApELeSoByg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pqki5JCS65ZibX4jGmaX0DOBMrKNnHcsTHwgImuHzuyvQVEo02uKH/UkdS1qigX+r5wcXafE6XEWc+LSBub6cYHBl5s8SEsoAMVhz5i3/CdBEKuxXvKc1PxxitW31U6NGCCCyJzzhPipaqFF/GQnfLN0DupWG0oueBBcURQb2E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJMxh+9U; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEOIK3kqPAWNPVHcwlmfcy0uTB3iNZw3YOR876yVZFzzw5UevoJwbCmRICglOqrLY8LVEZnXlYj1ipsrUpBtVGu8UiGWSwHBTZ1p1P5twk4JTy7oP/WS5VtpZ5D0rG6VnrmR8eNHR2fX3v3rPF/M2XWe/KQKuNvPvgf7Tcywl0rvdvLKt8YZWeQSb9JdKNivMVebvDi9W0N2KDL9DYLLdxxra9IrYCsrYictC+ht+lwxXfpx80yDECaB1CTIhyDv4Qe3PEozVDpu8cYu1LmOuhldqo0qg5D9x5xQXFIP+goeRNUGmub8gttNOFSfmKltxlOk2q5SLHrTzT61gnSWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzApHTVKEO4cZVdnm/jkBpUp+1kJpvU+D0ENSAH5zCM=;
 b=Bx8hmx1DRDDweoBmjm1i+eoDGm95DDa6fCIID5HzMZ0MK1v+xhG0Uo5WHFKFQyNs1mQQn0bYBAy5+V9641WKXpQirH3cAk4XNw+dP7liT1kofECy6bkkPS9cjtzAsnUBugfb5wXMw5780Xc3Py/C5kJiToOmZ5amyOagjsM96QnIGCnmSbk3bBukJXWFSqyc5xyQsetl9pkvyKV2dhyUk+PijqsY6jWsLA/IKklkUkAW3yw7O/HvK6ktPbPA7KoGhtyxrvnw+3nB1LYHhTcmT8GqfX+rLDi/HzJy+50DFlHHfOTDiTfBi48PQaVv+KmLwI9Q9vdGCJdXBmfQKh59aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzApHTVKEO4cZVdnm/jkBpUp+1kJpvU+D0ENSAH5zCM=;
 b=IJMxh+9UHfn01PlLe/Jxken3bzIO5VQjDMflpgmt+a2aj2oBcgHpUbNSz4YgLyNW4tzvHDci+5VlNg6ueq5qqra+gizsjJkqQXyhvvzXr3tKwlHpYnKuCFZaI3ZoOkDIia3+qujmk9/L5j3kUu0ayQRTllJeyflkbFPLhj8PSyfJKBvWy3dQMUktnLB+0/7ly7unvIXWM4BAeE4UTMQtVs/Mj7HjJfOcGKStgKN7AcWhq5ldw8AZd4JXSwQaz3fb7hr1qI+ICyox6f8tJcwZSHePFaaDhwdrqUwidmChlBeDd2G53EDcb4krWPSS+LsQhryU0Xd2CK+qKMzJr++9lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 10:31:51 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 10:31:51 +0000
Message-ID: <e0e4c82e-afed-4ebc-a942-76e1be86d6a5@nvidia.com>
Date: Tue, 6 May 2025 11:31:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra114: Don't fail set_cs_timing when delays are
 zero
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Mason Zhang <Mason.Zhang@mediatek.com>, linux-spi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com>
 <00b119fb-1cbb-432d-a884-5b33696461e6@nvidia.com>
 <CALHNRZ928KN6ZBDzdGWyabSQw4Hny6F5RdqZ4hBUZosPZtni1A@mail.gmail.com>
 <ea5f8416-64da-4a26-8706-bc7ace502ad1@nvidia.com>
 <CALHNRZ9LUqTBf5_WBKVt1FR+aPrTk-HUR2jmgQMrWH8xjAHx8A@mail.gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <CALHNRZ9LUqTBf5_WBKVt1FR+aPrTk-HUR2jmgQMrWH8xjAHx8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: 21eb2716-b67e-4779-ceae-08dd8c89369c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NUaHZwVzMxelV1cmIvZW03MHhGSGJpN2VlSlFEZXNZbHBvSEtiYkN6T1BU?=
 =?utf-8?B?T25XRzZKTTlEQ0gwSVhnT0lnWHhldVhLZS9mNStTSUdQamJVWlpteXA3N1FL?=
 =?utf-8?B?YzY1NnBpdkVKYkFFNGlOTHRYcTIwUisvalRxL21vQ2huZ0t6czNheGFiYkRa?=
 =?utf-8?B?Ykx6Uk1BWVB3aVc0eG00NVdVRTV3VkhNQ2N3MGhWZ0VLNUg5ejZyVU1FRHZH?=
 =?utf-8?B?WURjQ0NvVGRISWR4YUVieTBGV3lKTDlwRzlmWkRyZ0YxTkMzL014bEtpTkRU?=
 =?utf-8?B?MzljWGtMT2lXaHlUUWxUelVYeCs1OVR6R1ZTRG5ac2d5WmJBRGg4RHd0UWFY?=
 =?utf-8?B?TFMwNnBNb2JNd1RmSEl2NXpycnErazNKWFFoeS91MVBQZVZ1eXFTb3RPVzNE?=
 =?utf-8?B?amREbjRoNTI2a1NSQXNUQ1Z0YkQ2OXpUZkZWcEhDRERPSVkzTFFZMGE3dnZZ?=
 =?utf-8?B?WHA2TmJVV295VTZoR1V1K21kUE9xZkorTlEzYXlNVXJrMmJCQ21RNjRUYnF3?=
 =?utf-8?B?amxHekd4NTlNVFhYTDgrMmxYZTBpQXpURDdETDBRVXBvRHhBQ212amNwbXRZ?=
 =?utf-8?B?ZU5ydGNWM0Q3RW9CNjBqME5zblRrYU0yZGVVMURpcUZIM0x5azJOUVpVdmJ4?=
 =?utf-8?B?UldZb0JwR0pmZUZjN1ZTczRPQWwwc08zTUpjc0UxendJY3FBK09uaGFCckpj?=
 =?utf-8?B?cXlHVTl4bTJUVkVDeVNPZDNWd1pKVDA4VFA1enZzblMxOVMyNWZZT1BvTk9X?=
 =?utf-8?B?VE9BKzRkVFlBV2RNdlA2VmFlNlBuQkRKWno5QTZmZ3BieFB4dzRCMnRKMWkw?=
 =?utf-8?B?dnVLZlZGUkUwLzRtOE10MVM2a1R3eE9WaDluYXRkWnRjdVQzcXFuTFA3RC83?=
 =?utf-8?B?aFJhdDgvazF3K3F1dXRteTdsaTNjWHlwUEZUTXQ1cEJ3RHJpMzI0QS9oK3Jp?=
 =?utf-8?B?eXRSK0paelhqY2hWaTlwbW55MnRNTk1hdWZJNVJWNi9Pc2NTYTlsblhjMm8y?=
 =?utf-8?B?N0VqTm04Rk5QTlkyR2FvMUs2RFRRTFY0d0pTK3lyR0tKNUN3YlFsZzF1ajd0?=
 =?utf-8?B?YlZkTTMzOGtlM3hsQUN3SUgwb3FaY1VSK0daeitjQTZ1TWxONHpMRUlTa3hY?=
 =?utf-8?B?ajY3b3ExeVIvay9rcGlRckoyK1RrbHpXV3QvUkYvblZRTUNHVHNBMG5oNS83?=
 =?utf-8?B?L3cydmMvTlZwTnZhNGdEaHluQXpsRUV6OGdRMUQ5MnQ5Z01Nb25UeTNFcDFH?=
 =?utf-8?B?QlgyalRmQ2lvc0tlSVdJS3RnNWtnOW9WV29PTUVObDg2dkJNTU5BeEZrM1c3?=
 =?utf-8?B?dkhTVW5VNmNsUmdla2ljYTdZc0xWMzd3RllDNDZtVWdLaVFmUlhNSEY2aHdU?=
 =?utf-8?B?WXFub29lOVhUODhiTjF3ZG4xejRudnpPMG9YTENxQ1hDWUszSVlJRnV5dzl6?=
 =?utf-8?B?eEpGSkpLV2FFODdTNERheFV5bTVhQlQvemkrWjJxbDdaRWRreXd1UmpMUCtS?=
 =?utf-8?B?eDhRWXZqQ215K2VKenRIY3dVQVlZYjB2bzc4M0dobXVzV3R1ZnBETjdJZ25q?=
 =?utf-8?B?OHNVL0FoSWh2ZXhkNEFTWG5PY1dhbVQvbmxPY1hPZG85b0EvVFBPUEdqVFZI?=
 =?utf-8?B?SlR4Q0RmYjZYL09vU0I4UmFlaGlVQ0lWWHpVTzM5WFRyYjJPNkIxUVd5RGdG?=
 =?utf-8?B?UWxRZDJEOWZLMVJBNmNFQklxWWJpMzcxL1lVQ0FYMlFrY2dnbDJUNFJ0WkpZ?=
 =?utf-8?B?aWw1eGY4SWMwSFExdWg2UUVCYlpEMEVqMmhSRzVTeXdwR3BEaHBZdDZ3cGlU?=
 =?utf-8?B?SkZETWFSN1RhWTJqbTN2U1hWSWpyeEJ1UGlvVXFyRCt4NUhxbkwzTXZOaEVB?=
 =?utf-8?B?d1hQVXVEc2wrdU56amtZQkxvMk8vMy9NVkVqbmFJaEtWS0FYQlZPTkpKa2x0?=
 =?utf-8?Q?dKr/YtVZR/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjlmOVpOemU5emk1b3QxQ3RTZ040cUtZdGZ1MzVFREkvNG9sNXBjRHoyVEhx?=
 =?utf-8?B?dUszMHBZY0ZjZG1iaXFJY3lMZ0hXZzlMV2ZMN2d3MDhoNzBvSjJWUDlZaU1o?=
 =?utf-8?B?d3RpSlcrenVESjlnZmlIWXYxVytaZ0ZPZXdTZURaRkJ2a1FESEk1YWZiTlds?=
 =?utf-8?B?cU1NTXFhME5UNUtvVG5lMTN6MXdGdXFlODZ4Z1dUQitnSFZOLy9FdTB6ZnNr?=
 =?utf-8?B?S2Y4VDFTem5SbkVENUthaHlGaDM4elpzSmlaZXUrWTIwSC8rTWRsN1gwbXVs?=
 =?utf-8?B?aWQvcmE2MkFRSG1saFl0ek1IeFRReEViWE9YNndFL0c0WkVWZU1OaHBBWUFo?=
 =?utf-8?B?bTZlQU1vRE03RWdvU3ZBQmQvRGNzamRxTEV5ejhrYjBNMERjdHI2dVFsMVBC?=
 =?utf-8?B?WW5Qc1FJRmhjRDVDWnQ5Q24va05DdTgwamFnbm9QMm95Y1JrYllmZ21WZzhv?=
 =?utf-8?B?Mjh3RkhNYkFyRXJCSi9kdmxqNi83U1l5Sm5tMkl5QWZkWXZtNXEraEpMbDFi?=
 =?utf-8?B?L1RKL3Y3WmZqZ01QVW1ONmtPVmVaREN0Q0FZVHhKeXdLYUVoVngyOVljWUVL?=
 =?utf-8?B?UHpydzBEWUFQMmsrWEVHMllvQlhsQVNkcndQK2pKOTBGOTY1V2xoZUZ4VEt2?=
 =?utf-8?B?bGh4cTBFT3hVY1NPUC8zY29ieVl0Q3c3dzNRQWl3S1RIMnFRcGQxWGFHZWdC?=
 =?utf-8?B?WHZrc24za1plN1BEMkFnYm1QRFEwamdtbENxTXlGNVBkbUdCM3FwN1diNTFk?=
 =?utf-8?B?bWpzTnhLQmpqMjY5MHpVSjg2THpNYU9VRGJQQThvUVRBR1h6Q3h4em1SNjVh?=
 =?utf-8?B?S00rM3VnaTc4dTQwTitaU21zVW1GU0YzQkpDM3FNa01tVnQxZWloaWFOaFcr?=
 =?utf-8?B?Ykw3ZjVxdzJNbWdLUHVQWGI1OVdtYXJsRTRIRGt3ek8yeWk0bUdqM0NXaHR1?=
 =?utf-8?B?ZUZoOXdlbkNURmQ0Um5NUHgybURTcEwrZHR1bHBKRzZvbHVMQnZBRFVNcmtB?=
 =?utf-8?B?N1UzejNPclZ5N0hiaGZQbUwyNTBuZy9hczRtTHBmTU84ZlJaSW1YeEtZOFZY?=
 =?utf-8?B?a2JOR1pvRC9pZ3ppVVlJbC9sYi9ZTFBKVXFzTHM2QmlCU1cwcXJNUWUxUXo5?=
 =?utf-8?B?dFNPRjFNWXJiMk5vMWhsbXBMZlJENC9oQUxGLzZ1TXRSRGJiVDd2bFppWk9t?=
 =?utf-8?B?Y0RScU1xNnJleEFmLzJXejFqNngveG5jdkN0VEtHVDRmcXdIQ2xKU2NGaTVB?=
 =?utf-8?B?Z3piOHdGSFZ2SjU4TGt3UTVSaWVGenJGdkQzQks3QnhxUzV4cURMSzlDckIr?=
 =?utf-8?B?RnVNTWtlVmdVdUJKLzk0dGhQWC9HRVNldU1YaUg1aWhUMUFnbkJuZi9Cb0tJ?=
 =?utf-8?B?cjlTU3B4bTFYQXBiQVpXZlR1S3lzekRsSVdLalREYjV1QU1VdDRBMG5NSU9w?=
 =?utf-8?B?dDcvNUlZeVlyNEhVVlU2WGtDT2RSeWpobUhRaElnaEE1K2RSakkyQjZMZExp?=
 =?utf-8?B?TDF4OWNFbXFkT1BhakQwSklJWlEya3NNYjJkYk9CV3dQeVl0TFRwaDB1dVl1?=
 =?utf-8?B?YWpyOEhZelR1a0trUGErbTY5NUE5MjkrSnY5dUV6WTEyVTNpcUZUdCt4aEJR?=
 =?utf-8?B?VVVkekMzSThVRmNESVMwMnd3T3hBR1F3M0NZL1lYODJ3UXdzOHRWVnJZNm4y?=
 =?utf-8?B?bFFvejlNWnZFMU9PNDE1cEczdnFJQ0c1dktsYXFmajhOWVBzTk5KeFZmNGVo?=
 =?utf-8?B?NjV0ODl2b3NSaXVIMHNRVWlLVTRzdFprbjUzM0toWlBNd01vYVkxSGgzZzJw?=
 =?utf-8?B?SFBOM0JKbjZaMm81Z0pBQWFkZWN3bEFESm1acjhKeFdMOGo0V1RKOTdhM1p3?=
 =?utf-8?B?TXZrZHAwdWNZb0dHN2NyVzBlV0NGdFRtam4zeWFuQUpnL0lSTk1oSVVhekZP?=
 =?utf-8?B?LzRVVnQvK0w3b3hVOHVTZFpja3FJZ3k2VWpuWEpES3hoc2h0ZXdCdFVSQlB3?=
 =?utf-8?B?SWoyV1ptcUlEY1p3bURtVVl0R09NNEd5cTEyRFNWZ1NncUQ5c044eDJTV1Fq?=
 =?utf-8?B?cVFpbXJMd2QxTnVmMUlHWjJVUjdCeElhT2dwVjliQmE1MDZlQzdNNHJVL2J3?=
 =?utf-8?B?ODIweXp2cXE1MG5qTHdqQjVWSkFSMEtvNWFJbkNVU2k1RkRGVWwyK2lEK3dp?=
 =?utf-8?Q?Z56Y9wU7JAr0G2NSLWQEORR88OfF0oFRhZNG26v59Apf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21eb2716-b67e-4779-ceae-08dd8c89369c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:31:51.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VOlIoV2TlaU4rg3YmGHYuyJpjijAsOElwiOgHFal7OGAzN+AoPQW5/NjiNjMe13Q0Hz8UJ89ua7ZmJ7U7qsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172


On 06/05/2025 11:12, Aaron Kling wrote:

...

> Alright, I will send in a new revision once I can verify the change.
> Since this was already picked up, is there anything I need to do to
> get the bad patch pulled?

You can either send a revert of the bad patch or just fix up the 
existing patch and reference the bad patch in the 'Fixes:' tag.

Jon

-- 
nvpublic



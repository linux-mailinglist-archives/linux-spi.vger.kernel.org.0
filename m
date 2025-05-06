Return-Path: <linux-spi+bounces-7923-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29FAAC0E1
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 12:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C39517348F
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F53C26B0A0;
	Tue,  6 May 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cE1w5ep6"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976802472A6;
	Tue,  6 May 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526006; cv=fail; b=HPA6JcxqsxxPeYHV4Nssr2wvPXFXZX6nXMmc0qDsDdCR/9yRGF4mO18nhYUOGUzMWRWhhCA6mGyaj7n9jaPMZJxlARZbVB9ZcBy0TPsgCaPbfTUenC8Jn4Tj+2ZDEUslSVbvkDH4C+5lohpNNZPM8qJtCpq3abJjSEX6kd5BwIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526006; c=relaxed/simple;
	bh=P7w3jPXnhZiwpDh31rAtJDOQ010X3EIUV4QokANwNgU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ueIUhW0osf582W98Qpv618Dt+9tzWGCz7KrUfPRrGQ6+Vgfxmrg9rtPYvYWZlAKnk/R9pKQG1TfNBz0QTh1200KGRaqaQggaM+BSekeyeXMpSuwG05dJ3L3VxWD60tyYc7xdHutfa41n1nj/O8NiWu81tyjPEv/uQvBWOKc8r9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cE1w5ep6; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fA5k1WvWSTCtBmaLTFyIbHUwP0KHOGcYzp6PZTjd82gmIG59+RLe+ymQFA13L0OjRo9aWuaonMw0EVn+5L8B03ZaVjctnn2zqEgNwfENj6V+qpmM256scwVeUYe7hvTOPoGTwawY7fOB//Cs2KQmbKRjPenAm9hhER08smBOM2/Nk5v9qS+wEqjD7lKmIOLy+mO3iUOLUahVMDLrVmC/8l5pM8wtZJq1ExU6g8RDgnrAGO3HJ3yjRXISNYgrwsXreTuLLakzlQVvZyHwq2WXvat2oCk5yxTc8QyAQ4HDpFn3Cmmf/gf56josd8ziwhHi3udF5zDrLUhM6SytIzsjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lBmNv72cl8UOXpMXnWCBM1bG+FONmJJEvZOP8ivuXk=;
 b=JLhlBdltJ8QV2eLLyBnGOnGLF2xiZNFn243j0njK8x/dz3E6rBivuAOJzhLWJ7yf67BWnVANo2t9dX+4Me4Wbtmr9JnpEWPIaeeQ5zIqX+gaXzhIONaQme9KPXyQ6oHN3N8wmFNKnrasFNpSJNPN41LFVybNpnuyi9uRX4o0b3ggHdUVPi/Uo5TbUTL/zvs6IyQzpIx8k6HxHBs3BMMYp530hKWBKURTSIljUVzBKoXvR7pLoFn6S/AhHKlQ0SmpjxA8XYVEPEnLgvgxPB/lgy+kn4/3JERSop3laAn2zFLZUrIroS3duWlMDWrFHrsuy43pGY3z7p9f8k5hiSe4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lBmNv72cl8UOXpMXnWCBM1bG+FONmJJEvZOP8ivuXk=;
 b=cE1w5ep6f1Hm8+MO5d/lv1OCkkjjOJzc+ar3tf6muDMZ/Gy2gSd9jSfsKh4BoBdIULjQ2hUzEd479KFhDpc4wlndgmplUtbUVOwtf9hQZo4EFJwGB4NDZpHyBUCTl/LXt620FWkVuDGYMulSbwtKb975GI75zQcSvCenvq6jFj5GitniWWzrmAv8V/lFcJz2uUvyYzl7hWKh0cR48ok4JITpMwhEEbMECv4sIyBGLsGo0r1gQXz0sOXLo/ApxaIyjGoJCveTCo/VAiIQ93bHNrhckC5DlgLsjRzkfBr8t+VmyCLucJFw+tVDftWcmJS59dNZYIidZcBodWYo1VZqLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ0PR12MB8115.namprd12.prod.outlook.com (2603:10b6:a03:4e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 10:06:40 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 10:06:40 +0000
Message-ID: <ea5f8416-64da-4a26-8706-bc7ace502ad1@nvidia.com>
Date: Tue, 6 May 2025 11:06:35 +0100
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
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CALHNRZ928KN6ZBDzdGWyabSQw4Hny6F5RdqZ4hBUZosPZtni1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0208.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ0PR12MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: a283c9ce-f527-4b74-24fa-08dd8c85b1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elE2UzZSdGxJYXNxbmowTEpZOHdBdjEwNVpVL2p1aWI0bnpKRjBaMlhoWWpI?=
 =?utf-8?B?dUVTUkRXRmNmK1dDa1pTS1pobGRsUlJmZ3hiZUV0clRUb0FBTU51YkpUMThO?=
 =?utf-8?B?T0ZVT2cvbThOZkJ3MTRLaVdReTlSN2ZtVjBLaWRTNFJOVisrMEJYR2J6WmlH?=
 =?utf-8?B?cTNzL0RLcjdLM2F4Zkp0TDFwRXVhZFpHNmc2bmJscS93VzA3MHczd2Raamtw?=
 =?utf-8?B?ckZBcVlLNXBZdUtWUWNsa2Ria1IzY2dwQWpSbWR2NWxQYkt1UFJYcGhFeVQ5?=
 =?utf-8?B?djZERG9GMEtoTWoxeXBRc2F2d3JRYk1odHo3bU5jbmJzbWFwdk9idlhxZjVi?=
 =?utf-8?B?WEcrTVRMRHRzZ2hBQlBQT2ZOWXhjaTAybEpqU1VzVHRFMC8zZ2tSV1dJNWRv?=
 =?utf-8?B?dWNlcTM2OVJvTUMwdm1vVVlzaElOTVFxL1NybS8zanRYSjdRZEJEc1ExR2Nh?=
 =?utf-8?B?Wmt2MnNwTjdIZC9nK0tsRzBuTkNSMjhZL1dnWXREekU2Y1VQUlZ4bm51YkQx?=
 =?utf-8?B?Ly9GZU4yRVg1MUMvZk9tTmFVaFkvK3RPREk5VzhtMWpNTndlL1pGcGxHS1hr?=
 =?utf-8?B?L1lYNTVkTHRjUjFCRklIOXV5S2hRV1h1VDFyemQzT1p3dlJLTjAybzNZTnk1?=
 =?utf-8?B?VEs5Ulk0dlJaT1RMaFY3RDlNWmtybWdZeGVvT0F3b1FxUzRPNUVNU3ZoS0NZ?=
 =?utf-8?B?QzFTcVFSM01MVTcvbllKNFpTdGVETy8wM08wdWVIR2FWUEw0S3ZYL2VxTFF5?=
 =?utf-8?B?Rm1IN0xMSGIyYUQ1RVYzejY1bjhyNThadFJjaWZsVzRmejVsalgxam13YzVJ?=
 =?utf-8?B?a2pWRzE4dkpqTmZRdVJ1VStWNDZwbVdHclBtdjdaZjRtQVZEWXNOQnBsVSt3?=
 =?utf-8?B?UlNxeW00dnNpRENhOWJ4dmthZEE4dnh5T005VXNvVERJYTlMMlR1UDd4bUh1?=
 =?utf-8?B?WlZKazY1aXUyeXhiY2tIalhuanM3RkZWV0xpNE1ic2J2TlNrempabmNSZDQz?=
 =?utf-8?B?cktNL2tEL0E0a0xDK1laaGpGT1BkajJjR0VTajhPdnpqM1IwVEgzdWN1ekps?=
 =?utf-8?B?ekZhZWNoN2doNHZhbzRYNFZ5VGNjdVFIY09pRlBmNUJoMTBWYVFWQjlmU0Jw?=
 =?utf-8?B?Q25VMjF2bnMzUldHKzdHVUp3TW01SlNrcGdVcTFRdklxNUhkTGRxREE2WHdi?=
 =?utf-8?B?TGQwRVk4YlI3SGEzV21nalpIek1XNnJZNHgxK3pwMi9lT2RTdEZVbmRvWWVI?=
 =?utf-8?B?YWNtak1ZVnNJZC8xZEVFSkRrTVJhaE4zbTlka0hrRjhLNUVvSHVCZ3YwdDFK?=
 =?utf-8?B?K243Nml1RzVVVkZ4aHFId2tJYytOMzQwTXM1bGNYVlZhMElqYlhURFFyMytF?=
 =?utf-8?B?cTFla1dIZGFSaTJxaWV1RXhVOUdra2xuZjBReGNPRHR3Z1NzRlliU1NWcmdi?=
 =?utf-8?B?TmVaYUFjaCtnQXhibTg0dCtRUU5ZWWFoSkJiVDQxalJ1WENvS3BlY1J1ZzJy?=
 =?utf-8?B?N2pkVFRueng5NjE2TkVQa1pTR0xIZzRZMUFCTWE5Z0NGUHF2MjlaN1F5VmpZ?=
 =?utf-8?B?dmlHZlZIdjBUVWYwRGxKS2xjWFFhOTdFOVVSajJqWHZsUFJ6VXlpTytJM1Fz?=
 =?utf-8?B?aXc1WkpHbGF2OHl6ajVYSEZEVU9oZkpzWEJrbk13UWw4RzNReGloZ0o1eHRp?=
 =?utf-8?B?VkF6UThzeFZLZVFqTWNoN2pYWGd2bzQ1NkYzZVRONGxlWUNjQUc5ZytSN3la?=
 =?utf-8?B?allzVHZnRXJqKzRocTNKUXlCeldnaXc3WktwVjlUayt6NFNyZEdqQURkVEhL?=
 =?utf-8?B?L24xZmtabDVteFJaY0w2OEV4aFpyQmlQNEYwWHJwMjlqcXRiVUhXOVVlSGVZ?=
 =?utf-8?B?d3hmWXhpbmIrUXI1akM2ejZqMDhwNnRZNGR6Z1REQ3VaYWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFFDSUhueVhZOEFyM0ttenltWDJSN3N4ZHV5T0NVcHc3NndMUHdBYjNDSERa?=
 =?utf-8?B?S3RkWHBBeTJYU08zbk05U2ZRM0ZFTkppWlNqV0VmcDF5RDEyVTlaWllVUFFR?=
 =?utf-8?B?Ykl1RGhFVFk5QUtwOGQzK0pURlh3bUh3NVJNT2sxZkhJWktVeGNkUXd1VWxR?=
 =?utf-8?B?d0c3dm1SaDJ0NDFhNmYyeHJxYWxFNEJiL2M3OVJ2R1lyVERsWlNobndZdDRp?=
 =?utf-8?B?UzZrUzZaOFM2V3JxWUkzYW56SUlMdGJYZUtlYytMZ3UvUXR2M0VhMmpidUds?=
 =?utf-8?B?cDVuYkw5dmNHQ0sxUzBiUWRmRk5rWVBsSUV0NndrS3VYM0x6cUgzUXlwWHpR?=
 =?utf-8?B?aHh1R2Q5VU5vTVB0bGFsMWozaGZHbmRzRWpvdTU1UGxJb1p6YWVGbndZSmNP?=
 =?utf-8?B?MnRCMGMyaVdJdUd6WjJGU3ZPbFFRN25ud2ZKbnZhZGcyL01Vc0s5b0tNV0Q2?=
 =?utf-8?B?NTBEUmJTSjZTUlBtcnlieENwcjVCOWtiZVVVYVlVQmlYNDg5Z2YwbUZkMlha?=
 =?utf-8?B?WjJDT05RMzRHbUVXbC8zQVZZYjJZQ2M5SUQreDNJWklpSUJNSzdPUXhGUzBM?=
 =?utf-8?B?SURyVFU4dlpYNHRZSEo3WUdxS1hxa3FncFkzZEdxQ3N5a0FTaUdvQjR6NVpv?=
 =?utf-8?B?UjNBL29NKzB1RURxSllrbGwyamtGa0NSNjVmOGlwWmN6UkRNMklHQzZqck5D?=
 =?utf-8?B?RHFGbHo0NTcydTFsamJYdHRhNDhIbTlyeGVWT2xBSERwUU1qemNNYXlmRlY2?=
 =?utf-8?B?S3l4Y1U4bjYrT1NHY0c4bVVSYmRDNi9sVGdFMFpNbGkvaW5XSEhFWFl5UEhB?=
 =?utf-8?B?SnBFNmFJTlhmeDVTZXNoYmhBQVJkRVd2RXpRdDk3MjRUa3JNVjM4d3lFOUlq?=
 =?utf-8?B?b3pXbjY2T1FTL01TVytDdXhlV0Zlb3p2RnpzeDg5QTl6RFhKYzMyWGU2QndO?=
 =?utf-8?B?bWppT0NHTFRmbDZ2RmJ0WlNMRlJDeGF2eWlxTU5vL0Nudy9TRktUQVozN0g3?=
 =?utf-8?B?NXVJN3BoMHJwbEZ4VWNKelREZ1h3cnR3UXFzQ0tINHlBeVBBOU9nSldvS3B6?=
 =?utf-8?B?cmgxenY4WWhZUGlUK0FvSnN4ZGtNSm43dnQ3cEZiNjF2NUk3U2diYVNtQ2dG?=
 =?utf-8?B?SjBYQy9QWGdVeEFhSFdCbXJoMGVlZ09CRDJvV2hpZDFYc3BVTDRlaVpGNWVY?=
 =?utf-8?B?Ulc4OWVQRjZjcXFnUjJZbVQxeElqTnFPTS9qVjRSRnNrYUUxNHk0Y1cwODZD?=
 =?utf-8?B?QkFiSy9KMDVoZHpUT1B5Z0VpTU5PNW9GcEIvaUZsOEpZS3IzKzlVWko3YmNC?=
 =?utf-8?B?MG1oUTlhbEpoL05vWVdacDNHQ25GNnVrLy9wc2tTQXBQSXlyaSsrbnJ0aFRQ?=
 =?utf-8?B?TzljOHkyRzBtUi9tM1NVMEllUzhIVFVTallwUzdyWEt4aitIWHlKSUhvb0lK?=
 =?utf-8?B?ZytLODFFOVYzY1BFY2FGTkV4c1hOUlYvaE1aWGRtaUdRbkdkU2xlcTY3eEhD?=
 =?utf-8?B?b2lHVnRPVTNKZWxKNUxjb1FxeEdTMnE1ZlJKNmFaSk9lMStQQ3hGdml0QWg1?=
 =?utf-8?B?Z0FCOTV6b0xYUUtuZEFDWG1zTUc3N25ZdlNCODROSStWd0ora3BtYS9MUjRy?=
 =?utf-8?B?VVNTMmlkRkx1OTRLK01Mci8vcTc3MXJ5Vm1KZDF1ZTJYK1FxN1FiT3ZQSHpt?=
 =?utf-8?B?WDNOU25IQzJmMENCUHV0L1dUNjJqMm9LbmxiRkpvdTRYNmNCU09QMDVraUI1?=
 =?utf-8?B?WG5SK2NUWnIwMndsWUNPb1RSNi95bWlFQVIvMnNGOGhwWmhacWdpM1E1cVVt?=
 =?utf-8?B?akNrY1MxakRyT0hReHRTL29vUVdEVm12c2lNRjF2NlFOcVQ4bWc1Q0g5VVpj?=
 =?utf-8?B?Z0Vkcm5xdnpMYjhEcFYvWXVIczRJYjlybDhmSUVTcEZUNVNpQWVVVWJTcUFT?=
 =?utf-8?B?ZlB4ZmVIcWNZRVJtOTBYNHJsbTlMRFp0eERiSk5QUXQ0dHZRdkU0YzhURVgv?=
 =?utf-8?B?ek9iSmhENjlFdHBTZVFqOWZhQ3YzUE84OE9SY0pmNEtnSGMyK0NYNTVQOGg5?=
 =?utf-8?B?cWFYZ3ZJdmlZM1BLZmo2eTFaVzFUOERjY29zOHU5SUQ2SHlJR1RuVXBZb1I0?=
 =?utf-8?B?T1dReXRTVStqQzNYRGNYc3hZUVpUM1JqMjBtWlRVV3NDcE9RQVFCOVh0anN1?=
 =?utf-8?Q?4k80ricdtgoATbl/zFRUp9v5LzZsRggKBvZRcL9wkiIe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a283c9ce-f527-4b74-24fa-08dd8c85b1fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 10:06:40.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRkiRHP6GT7cjD0p4lfgadboHpxa3cB7lRBcjBHiqriyPFYab3EGVxDW1MLWGBUqnVdn/8lPnNecbQd8qplogQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8115


On 06/05/2025 10:50, Aaron Kling wrote:

...

>>> -     if (setup->unit != SPI_DELAY_UNIT_SCK ||
>>> -         hold->unit != SPI_DELAY_UNIT_SCK ||
>>> -         inactive->unit != SPI_DELAY_UNIT_SCK) {
>>> +     if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
>>> +         (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
>>> +         (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
>>
>> The above does not look correct to me. For example, if 'setup->unit' is
>> 0, this means that the unit is 'SPI_DELAY_UNIT_USECS' and does not
>> indicate that the delay is 0.
>>
>> Shouldn't the above be ...
>>
>>    if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
>>        (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
>>        (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {
> 
> This is what the code looked like before 373c36b [0], which dropped
> that check because the pointers can never be NULL. Should this check
> if ->value is not 0 instead?

What the code does now does not match what you describe and does not 
appear to be correct. Yes checking ->value is not 0 would make sense.

Jon

-- 
nvpublic



Return-Path: <linux-spi+bounces-6965-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088C7A47BD4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 12:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DDC1892D2D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE96B22A816;
	Thu, 27 Feb 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pt/tXo5z"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1D1DDD1;
	Thu, 27 Feb 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655048; cv=fail; b=k4fheSHwGjlM/9dMezZRUbB6JgncSRheAgQnefexrmsUnaK3CjQExCqmkJXbwVYUjHZfw5mXK26zR8aaOMOWRLuxiMki/pa9YJ/qeBPx/CqvMajBrDfJmTg5hxfJ5uDpTn0fgEzD7YerWaeZAaxWfe5i15iAi+HzG0HDt7vrnHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655048; c=relaxed/simple;
	bh=S+zCggTYD/82kiDc1exFaNK+0B2S9bnZ1Du3R7zJ2rg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dy0W1PpAXuCvpdluCAHOI5e2hZOsNdGzbakSidUBrBk00iJJ4FjzdjWpacsDZ6HNfZFDTuC5j7YVZKcJRE0EUPi2kT2MfcbfoM4zXjr3/w3HURCWu8lWIA2lrBpIh5VnyhlGK0eTidrtPRIIAK0m0T6yhejxklohruMY/r24gb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pt/tXo5z; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxFyTYcKEv4kI1MXTTqBvHdxBgI1obEA+POGqKvcoxXQb1V3ZhruxaDQs3hCvM00fqtCeMKbeXMMv33x/6TRuShdpLZEl4ayqX02jhvZqGYj8pF9j0LHxxwLUS6LvPVaYYw9moiTPOOIhtYtpBaiFCZNszzY+o4VR8x6zIN3pOED8mHdUBw7FvQShWpqXFxdsIBwJ2M79MvytgDA85hVaWDtj798pKRj6lNDLz2obfqACHg2yGGdLyJ/LCqcUEKUowF8bLAQsEdrjcsthQ+82voHStk6NeNGzUVow+6gVolVXkmfZFCkgyb2wLCAJC0y56uYOCVsZNoTRIMegruG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbOJGrB4m3OZU61UcHPPdFTj8NrOX9EmxsGUpV7nuLQ=;
 b=tTvyAOX2VPSlfTwC/NFwk5HS5Zgd3mIJu4haJacVi5NlxvkwL4j/dkXwKaCnl18QSx3w+6T7pS4DPk1tpv/u+8new6b48T2pXrJBx/S8ZjeWRL+hxL90IekHcpz1fnGlRy90yuO9NvQrkglj4tDtMs02GP3kO4pjAsaoyXls0Eqaq72UYkQ6xjDinEda+/eYskqsFfoo7DxiWKO2cs6djje35hzurg1CMLnJknNdfA90xM60hQppsjGpNQHC/QjdtzpMWvJZIRnvM6+3UuqZ/fhHacoUCoxA3uIlnXzYgObrCoHTXkDVgTK958pAav/VQc6QC4umu6QUcvf92pmTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbOJGrB4m3OZU61UcHPPdFTj8NrOX9EmxsGUpV7nuLQ=;
 b=pt/tXo5zsaODF8f+ZUcPOHweQ3aS9cw1+EhWtViyY0w+AYK/pNbo0qKFKNVpH1pa3nDi2wgTOTsirw/Z5VutfvMdZLBKqrs/W8tJtBPietD87JG2mv43Imx4KDRVjmgEQtf4W5EfCDd2sik9CF6uzKRCuWqQOQL5pMhGehSj279sgox8bpQAukHtvlM1sMkL7mR+vIgMTVL3L+8ZpsQN1kLEOzqL7wVO3U0usYkMhKyxoIfj6tPEPyTi1NzPj1yu5HaFEzamkRw1Mw9fcIj5kAkcwREzsLLjGyUhKpw7fr8P53ye5vE40RQ5Coktwtnu2aOp9Fzx9kkuGDaeaZuPTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 11:17:22 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 11:17:21 +0000
Message-ID: <0a77e5a4-b4c8-4e5c-84f7-b6b56d4c0437@nvidia.com>
Date: Thu, 27 Feb 2025 11:17:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] spi: tegra210-quad: Introduce native DMA support
To: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
 skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org,
 linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
 <20250212144651.2433086-7-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250212144651.2433086-7-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0382.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4913756c-c712-43cb-4d53-08dd57204e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnZjV1RyNm1qME0yZVNvVXNDU0c0cktwNU5sTFhHcy9UYnNZYS80WmJqOHFQ?=
 =?utf-8?B?TTJzS0Y1dDdrTHJESjNFTE10bmUxajZPdnZLZUx6RTJuVjB0RGNHTkl2cDZY?=
 =?utf-8?B?SFl5VGlldHJTeWp3MGdBcVFvT3dMS3JxU3ZqblFtNEJ1VEUrb3c0SER6aE85?=
 =?utf-8?B?dGtiZTN6ZkU5V2xuK24xcUNmakhaRUVoVXdhNVVBYnQ2MXUwRlpTYjJWOE41?=
 =?utf-8?B?cXVCbVlzWWNmaE1XNWVrN3QyOXYrdXBtNExKbEp6NVJPaUk3QndaS3c1dita?=
 =?utf-8?B?K2taZzkzakhncHpSeDBMb2J5Umc3WVNqSWROdmpLSElDVDlmendrVnMzSVVs?=
 =?utf-8?B?aDFzVmU2Q1F2bmNVemVtdDdLSWd3RURFalpEZkttODNwUTRRUjBoM1cvcTZ3?=
 =?utf-8?B?UjhyUm9VT0tmSEdRY3Nsek1UOFpSTDJHcTMvZ2IweHMzVkRqa0RDaFFDWWRE?=
 =?utf-8?B?aWFoSS9qYWwxUEZBUUltYzFGYjlvRExETkdxSHpFNEtqaERPV0ZENU5QYm9P?=
 =?utf-8?B?Qi9oOWo0NzNGRURyNmFvNnR6cS9FckRlMVFnd2lLTnp1K3lLVk5TUnppQ0ky?=
 =?utf-8?B?bVVReWtmbjM2WGwrVHo3c1U1eGZqejFDeGdqMGlHMEtMSHkvYlFJMXhvOXE0?=
 =?utf-8?B?Z1E3VUs0VzhFWnMvNU51dTBBNis3aHNtNFhLY3dnU1UxaGhUSmV3dkIreVZ5?=
 =?utf-8?B?VFYyTWxwS3NkN256Szd1eitzVUl2S2FQdGNVMlN4bXNUd1dRMVV0cHZReEI1?=
 =?utf-8?B?ZHMvQy9WTTJVbFZPQVVzeVZqWVlYeUd6TnBpL0NzTUJreERsVm83cTJQM2hq?=
 =?utf-8?B?RHhIY01pSlRZQytXaGhxS3ZCMHRKL2xheUROQXZpemV4V0NRU1RmTnkyZ2l3?=
 =?utf-8?B?OGNWNDA5a3dTQW9xQlhWVXpNNENXaThrSGhZSVZxQm1JdExPRFZGenU5QklU?=
 =?utf-8?B?a3pGRUdMMkJ6QUxLN1JqTitiVHJIWHlyU0pnaU9CM3F1Sk9DOGtKUmVRQ1Zt?=
 =?utf-8?B?dHpERHVKM1JuVGlkWnZSdXkzYmhOV0VOYkJiQVZVU1BOU3pBWGREbDJXVHNn?=
 =?utf-8?B?a3FSTkhVcVpRT1FvdmtadmR1ZnpXOG1HYi8zbU9jSklpWmxMMkJYUUZTOER2?=
 =?utf-8?B?Mi9jM2REeXBjMmdJS05NT2w3NDU2Y1hpWUh6Um9qQlJFb0V2TDNNUEs1ejJz?=
 =?utf-8?B?dDVYOElTK3NZRFZVaGEyUngwWE1Rdml0c3psak1ERjNOOElhUjg1cXFoY0My?=
 =?utf-8?B?K0huUDFmbkR1Y25sYURib3REeTZxOW5CUWNSQzUwamNpZHZNWHgwL2JoQ2dW?=
 =?utf-8?B?MDhjaGlIS3FVUVNrRFpFSGN0VDJPRXhaaldsS1l0UVg3blpoR3lPdTBUbG5t?=
 =?utf-8?B?amI3TEsxVDdiUU9sZzlmcXRJSG5La0FNMEtnbGNyZFZBcnEwVUYxRVpWSlFu?=
 =?utf-8?B?OHMyckFVT0FBS1RxWW1IQ0wvT1IyamZJODhIOS81WUJDeW9HSjhOUldCOE8z?=
 =?utf-8?B?K1BSci9lTFlhSkpOVFJ2akVMYkNmZnZETmMyUHlrdGI1MDkyUHpUYmVFcHNi?=
 =?utf-8?B?M3A2V2dEQ2c4Nys3aXQrTHNlK1YyN3JMbGF3elVraE43Q3dLeXZxZEI5eVBt?=
 =?utf-8?B?Umw1Z2p6ZEwzeUMxR3lxTjBnMGZITDNDMkNoOEpuN0phb3F4VFdjb3lQOTQ1?=
 =?utf-8?B?YXJxOCtQTzVTZjk1M0t5ZzZZZFh3bDBpL0dQQkM1RTlPZThsazhkME8yNTRm?=
 =?utf-8?B?K29qZzl0VmI5R3ZnWW85Q2syQS9OYVlSM1kzcmovUkN3cnF4dFNXblpxblVp?=
 =?utf-8?B?M3hEWlR6RnliOGF6aUNsWlB4WlgzZSt2WjVaUXh4dHpuSnVQbzhiQWllOXBn?=
 =?utf-8?B?T2FEdVlRZk9zaHRBOW90ZStyKzdVa1U2MVJOTjRDaWdYRmwwZVQ5cFJYTVR0?=
 =?utf-8?Q?5T8jADYCZfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z213RWVnbFk2WVR4Y2lTQmtkd1ZxSVZlWHhCdTI2QS9zbkVwaXhrQXdtVWF2?=
 =?utf-8?B?T0R0KytsSHRlcFArMGUzV1o0WWxpbUxkaTk5elJ1WjVuZXV6TzgvNktvRmZ3?=
 =?utf-8?B?aEZERk81dmpKeEZNMU9tckpSUG5jMW1NVi81UW9DVDhkd0poc1BVcnBJYTU5?=
 =?utf-8?B?Q2twRmt3UkJ1bGE4TWgza3dLN3g4TUpEbkRnQVREZC9qNGV5UHZCa1JROVhB?=
 =?utf-8?B?cTE1TllLNW1PanRzMUFNWEZIVzdReFMyb2l3bFFGWm1VenFKanhyOFhXZVZ4?=
 =?utf-8?B?bVFRZ0Y5VnZBUVRRUWQ1czR0MTRvRzlpdWYyd2s1RDBsMUk5b1pzMERUWXE2?=
 =?utf-8?B?c05XRFRlNVRWSjhKelFhc2FWdEp6WllxN0hHMGdlMDBjU1ljcVpxTmc0bm03?=
 =?utf-8?B?NGxPdytuSEpBN0d2QzJuQUxkdSswb3VLWVcrWldZRW9qU1JsWTcwMHI3c3p5?=
 =?utf-8?B?Ri9UUmZzdmU4QlhjOVdGL2Eya3AydGtjbmpOQ2M2VjErWG1PRUlCenUxMlIz?=
 =?utf-8?B?UkhtTGoxaGxwWlNyNDFLZXh3U3hIUWxMcVZybWhxKzZiNytyRnYyZ2tiVnpi?=
 =?utf-8?B?eGZzU0V2TXZyNDc3c2h1TGtybFAxQjIvdENqWXIxaWYvZW4za2R2RVRqYUll?=
 =?utf-8?B?cDA0RjZMV1kvYlYzVWoybVdzeFduNGUzdXNaVTdhUUZNdTNveUN3SDluSTYy?=
 =?utf-8?B?dUZvWElxL2NVaHZWbzl4MEUvd1FVaVpKWlVHM29IdTBacDdYd1k5eG9lVnJ1?=
 =?utf-8?B?UG5Iakd4bzZKdUdyeXg2cHVRa3o1a2NmOEtHRGVWdGJHNlRtaUtuc1hFN3pU?=
 =?utf-8?B?dmN3dGdaNnpFT09ad0hNMWVWdW5BY1Ntd2paNUp3Q2lFb1BYK3c1eGdQa0Ji?=
 =?utf-8?B?eTdsV0ZKNjVOU3hWN3l1VitMN3VhbWdnSE5hMjNRZnlaMmRPTmVLd3VJd05O?=
 =?utf-8?B?RldQamYwa05yS3p4YVJTbXVCSGxQS0tUUWNKWm56UHY0SVhsaVRDREFOZTE0?=
 =?utf-8?B?MnhNaGdDS1JHdXAyS3FuWmxReTZ6bnlQUi9oT2dJQlFwQzhDZUQxNkN3M1hC?=
 =?utf-8?B?U3dWc3FZeHpsK0x1VS9DdWIvYW5IYXRDOVhRTit6bHBMYnFTM2FCWlJGUEp0?=
 =?utf-8?B?Z2lrT25KWURQc3JaK1hpeWkxZ0xHZlhsODBiNWRuUDRSSmtOVkwwVnRZdUVG?=
 =?utf-8?B?VktBRjU1MnVKUEZpT1ZYME5sRDI2empjcUU0VkkvMUMwamVDZVBOWXdsY0FO?=
 =?utf-8?B?cGNnL2VSSGZWaFpITUQvZFA5NnIzeDVHUmZtUGJ1d2pna24yeUV6T0N1VGRF?=
 =?utf-8?B?aDc5WUFZdzZPb1lxVUlyeWxiRVNjT2VZNSs4OUsrUk52aTdRMlNaQk9qaTJO?=
 =?utf-8?B?eC9UT1hzYXE3RmdONEhmKzlhTHBXcTg1NHFvUW5rTlJSU0wxdnRHQ1dkN3N6?=
 =?utf-8?B?VWUyQUllT2IxNFZZaHNkU1FGVVljb1d1VzV5djNmUlFUODhUWkQxcTZCRzJB?=
 =?utf-8?B?cGFVdUtMZkM4cGl4NUlsQUY4aU1MMWZGODVLaTRwWWVlTFNDTFZMS0hWeklF?=
 =?utf-8?B?ak90SDdFNllOcENkTDhoSDZTOHljS016ZUxVelZqVzRUM01naVBCN2IyTEEx?=
 =?utf-8?B?NUU2S0dqVGdidHJtT1dzeGpOR0dxa3E4WnhyYzlvWTlGekhqRTRzUi9kbFNE?=
 =?utf-8?B?NlpZZktlOHh0UWpoNjl2ZkFyU1FvTE40YVVaZUxQVEpIK2hTek8xbk5relRp?=
 =?utf-8?B?SStJVEJEQmFTNU9hM1JFbGNFd00rY2k1cW0xYzVRSmJPbEw2YmpORmYvdkFK?=
 =?utf-8?B?UXdUUm55bk52VnFSNno3Z1I1ampheWlFcjQ4KzE5L2hiVTlTd044MVB0NmRi?=
 =?utf-8?B?NUlUYVJ4VDBjSFJ3b0tOc0U1Vlk5ODVuYW9rRmU0Y3JJWEtLTVVuZmVXU2dM?=
 =?utf-8?B?UUluUlVRektXNFlhV0pGbG5YMnVLN0VDQXowenk5MTM3dGlPOTM5amhIRzBn?=
 =?utf-8?B?UVJ0NGMzTEpSeWFnMENCL0krZ094S2F4MGVVa1MzejBRNEdCZmhmVXpqUzhu?=
 =?utf-8?B?V2NYNlpZbUdyak0xaU1PQTJremFVVFNYNjI4TWVKbDF1M0VvYTlOWno0QUlv?=
 =?utf-8?B?K1pOSXRKNXUwMlA5QVJvTXRMNE5rT0x2dWJJdmJ2c1NzV3pXdW8xUDQxbms1?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4913756c-c712-43cb-4d53-08dd57204e12
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:17:21.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsCZWAHPct+a53Yu+y1bWZVT/9FyIc986CJBcVrqdyPHdJkRzL/qUUlH8+ONuhqWHHBekS8Bigx0L7wEJtUiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372



On 12/02/2025 14:46, Vishwaroop A wrote:
> Previous generations of Tegra supported DMA operations by an external
> DMA controller, but the QSPI on Tegra234 devices now have an internal
> DMA controller.
> 
> Internal DMA: Uses the QSPI controller's built-in DMA engine, which is
> limited in capabilities and tied directly to the QSPI module.
> 
> External DMA: Utilizes a separate, GPCDMA DMA controller that can
> transfer data between QSPI and any memory location.
> 
> Native DMA Initialization: Introduce routines to initialize and
> configure native DMA channels for both transmit and receive paths.
> Set up DMA mapping functions to manage buffer addresses effectively.
> 
> Enhance Transfer Logic: Implement logic to choose between CPU-based
> and DMA-based transfers based on data size.
> 
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 218 ++++++++++++++++++--------------
>   1 file changed, 126 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 04f41e92c1e2..7463b00b1ffb 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -111,6 +111,9 @@
>   #define QSPI_DMA_BLK				0x024
>   #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
>   
> +#define QSPI_DMA_MEM_ADDRESS_REG		0x028
> +#define QSPI_DMA_HI_ADDRESS_REG			0x02c
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
> @@ -605,17 +608,21 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
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
>   	u32 val;
> +	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
>   
>   	if (tqspi->is_packed) {
>   		ret = tegra_qspi_dma_map_xfer(tqspi, t);
> @@ -634,60 +641,85 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
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
> +	if (has_ext_dma) {
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
> -	if (tqspi->cur_direction & DATA_DIR_TX) {
> -		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
> -		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		dma_sconfig.dst_maxburst = dma_burst;
> -		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> -			return ret;
> -		}
>   
> -		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
> -		ret = tegra_qspi_start_tx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
> -			return ret;
> +	if ((tqspi->cur_direction & DATA_DIR_TX)) {
> +		if (has_ext_dma) {

For consistency with 'handle_dma_based_xfer' I think it is better to 
use 'tqspi->tx_dma_chan' here.

> +			dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
> +			dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.dst_maxburst = dma_burst;
> +			ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
> +
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
> +					  QSPI_DMA_MEM_ADDRESS_REG);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS_REG);
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
> -
> -		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
> -		if (ret < 0) {
> -			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
> -			if (tqspi->cur_direction & DATA_DIR_TX)
> -				dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			return ret;
> +		if (has_ext_dma) {

Same here.

> +			dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
> +			dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +			dma_sconfig.src_maxburst = dma_burst;
> +			ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
> +			if (ret < 0) {
> +				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
> +				return ret;
> +			}
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
> +					  QSPI_DMA_MEM_ADDRESS_REG);
> +			tegra_qspi_writel(tqspi, (upper_32_bits(rx_dma_phys) & 0xff),
> +					  QSPI_DMA_HI_ADDRESS_REG);
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
> @@ -759,16 +788,26 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
> +		tqspi->rx_dma_chan = NULL;
> +		tqspi->tx_dma_chan = NULL;
> +	}
>   
>   	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
>   	if (!dma_buf) {
> @@ -779,14 +818,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
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
> @@ -1056,6 +1087,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   					struct spi_message *msg)
>   {
>   	bool is_first_msg = true;
> +	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
>   	struct spi_transfer *xfer;
>   	struct spi_device *spi = msg->spi;
>   	u8 transfer_phase = 0;
> @@ -1128,15 +1160,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   			if (WARN_ON(ret == 0)) {
>   				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
>   					ret);
> -				if (tqspi->is_curr_dma_xfer &&
> -				    (tqspi->cur_direction & DATA_DIR_TX))
> -					dmaengine_terminate_all
> -						(tqspi->tx_dma_chan);
> -
> -				if (tqspi->is_curr_dma_xfer &&
> -				    (tqspi->cur_direction & DATA_DIR_RX))
> -					dmaengine_terminate_all
> -						(tqspi->rx_dma_chan);
> +				if (tqspi->is_curr_dma_xfer && has_ext_dma) {
> +					if (tqspi->cur_direction & DATA_DIR_TX)
> +						dmaengine_terminate_all(tqspi->tx_dma_chan);
> +					if (tqspi->cur_direction & DATA_DIR_RX)
> +						dmaengine_terminate_all(tqspi->rx_dma_chan);
> +				}
>   
>   				/* Abort transfer by resetting pio/dma bit */
>   				if (!tqspi->is_curr_dma_xfer) {
> @@ -1197,6 +1226,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   	struct spi_device *spi = msg->spi;
>   	struct spi_transfer *transfer;
>   	bool is_first_msg = true;
> +	bool has_ext_dma = tqspi->soc_data->has_ext_dma;
>   	int ret = 0, val = 0;
>   
>   	msg->status = 0;
> @@ -1251,10 +1281,12 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
>   						  QSPI_DMA_TIMEOUT);
>   		if (WARN_ON(ret == 0)) {
>   			dev_err(tqspi->dev, "transfer timeout\n");
> -			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
> -				dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
> -				dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			if (tqspi->is_curr_dma_xfer && has_ext_dma) {

And here.

> +				if (tqspi->cur_direction & DATA_DIR_TX)
> +					dmaengine_terminate_all(tqspi->tx_dma_chan);
> +				if (tqspi->cur_direction & DATA_DIR_RX)
> +					dmaengine_terminate_all(tqspi->rx_dma_chan);
> +			}
>   			tegra_qspi_handle_error(tqspi);
>   			ret = -EIO;
>   			goto complete_xfer;
> @@ -1323,7 +1355,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
>   			return false;
>   		xfer = list_next_entry(xfer, transfer_list);
>   	}
> -	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
> +	if (!tqspi->soc_data->has_ext_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
>   		return false;
>   
>   	return true;
> @@ -1388,30 +1420,32 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
>   
>   	if (tqspi->cur_direction & DATA_DIR_TX) {
>   		if (tqspi->tx_status) {
> -			dmaengine_terminate_all(tqspi->tx_dma_chan);
> -			err += 1;
> -		} else {
> +			if (tqspi->tx_dma_chan)
> +				dmaengine_terminate_all(tqspi->tx_dma_chan);
> +			err++;
> +		} else if (tqspi->tx_dma_chan) {
>   			wait_status = wait_for_completion_interruptible_timeout(
>   				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
>   			if (wait_status <= 0) {
>   				dmaengine_terminate_all(tqspi->tx_dma_chan);
>   				dev_err(tqspi->dev, "failed TX DMA transfer\n");
> -				err += 1;
> +				err++;
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
> +			err++;
> +		} else if (tqspi->rx_dma_chan) {
>   			wait_status = wait_for_completion_interruptible_timeout(
>   				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
>   			if (wait_status <= 0) {
>   				dmaengine_terminate_all(tqspi->rx_dma_chan);
>   				dev_err(tqspi->dev, "failed RX DMA transfer\n");
> -				err += 2;
> +				err++;
>   			}
>   		}
>   	}
> @@ -1474,28 +1508,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
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

-- 
nvpublic



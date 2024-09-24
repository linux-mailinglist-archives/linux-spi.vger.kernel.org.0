Return-Path: <linux-spi+bounces-4950-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3168984893
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230601F21C81
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C191D531;
	Tue, 24 Sep 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JEOtBUxJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858031FDD;
	Tue, 24 Sep 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191525; cv=fail; b=Cww7/Tvojc+M8dGOcTLnGo3kEwhkI1xn9RbJfkbfzt9p+FvuVYPhSbIBx4pdrZby1fwsFI+gVrDAlYP52Er3xxAw9il/dueJZrR1oMHbrSSi7bawbCNXPJ9LbCapnzRbLaIDJQD3dqH0oAQiVzguxI1/zXNFhUGfoKbkIpvEmWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191525; c=relaxed/simple;
	bh=4vtzJLcoB+kbvgkptb9NG9318DPutJj2Y5ygRo+nk8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzOqYKF6J76znwnHFaY/OhuQViuvkMKZ5WxNh7e4bEKl0M5oerMyGGFcZv1VF1lOskp3eAC7H1x1i+JObFdjgE2wD8xHfnhB+YPbdHCrkAaetyJUW9sXfCNcL/ZD+vrTDiSugWwKVLXqktwhGWW0QmurneX1YvrIEqgxO4ffG/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JEOtBUxJ; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH+7JwddyFbBP2HT2S9T/F4IFE7Twijf8M1UJCy2ycKAWcQ4L7RE5LMZtw6PdBqYajqvHeMfnIRe8v7FY7ZGH/57K2KSc/1ndXNwyYWnj50Q8x2btHq7HDV096z2iBqmv6TGB2vYYYIjyRpJQMXn/Kr4XCqmnPghdB9lJ3LwAQhrldYzX3Nv6Xrt/db6dJMG+8V6sdt72h+Kkva7alG8rP5SChlEdtV9jjFRUtOBXm9mYq6ujhoib9nRGYfLSbz9Ychz3MTorwUTnacCunqhJ/pdYNmGPKAzt9xlvdJ+v7A5X/lEVXn8jTVkUPMcJ81U5of3dHIE4uF2Su3doujzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSLns+KOrpgp1OizUlr+maAjpeALbvqe5dmgOM/SakE=;
 b=gUw4awDQgG69Rjv2iegC7yB57hv9SvYYjTo/F4F5OG8tctDTPs7EVCAdQicEm29VcZHyRr3zKRQ0UwkjG8F3phIcp8F5uqiTXuu9PrTLl6dvs/eEkrM+0MJ38FLCJKVSAxd5rPpbxI/SBV/70I5FSTxjiuQOwZJ13rW00eUW/9ldZXkO7rlnRRPSYGUssPzlE3VfxbJj+sV91slonWWJ2uxnZ32f3Xf9Kzt5q5QqIAY01brEEnKynffA152DbHdAeE2atyEiGiiGjhWWTq40e5XHZnCNyjPlr2+buh2t+OnTorM9IR67yIuPOlDYe7Gxgm1SCkE4CshJ3CxNiOeYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSLns+KOrpgp1OizUlr+maAjpeALbvqe5dmgOM/SakE=;
 b=JEOtBUxJwlFczFuPtAWQg/7NvFvkvB+a6g/fDC3xMwoGf26PLt1e/fM65TjEkq9d5HWQ/yV3gn/gNhv8ECtnGtPixlz4DG5xn+MMzqfD38LxplbICgeTpgP3WmI6+vDhiOIMuNlUkBwPh554oFY7+h5WQqDoSqvN5kJUu/bCvww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 15:25:17 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:25:17 +0000
Message-ID: <52f6b06a-ba0d-c736-81d2-cdf5a3802b66@amd.com>
Date: Tue, 24 Sep 2024 20:55:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 7/9] spi: spi_amd: Enhance SPI-MEM support functions
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 sanju.mehta@amd.com, krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
 <20240918105037.406003-8-Raju.Rangoju@amd.com>
 <ZuvmIG5h2hnicIjQ@finisterre.sirena.org.uk>
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <ZuvmIG5h2hnicIjQ@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: f5552fb5-7b91-4a11-75a0-08dcdcad1853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S21BaFJsQnRxcnFrWTBvSjVicXpReGdubytpUVhSL0JoVjM0U3dxMVlUMjBy?=
 =?utf-8?B?bG13MURWVm5TKy95UFZkdXVmUmgvdmRpSmtscGpRRWxuSVY0dWVid0Nzb2sv?=
 =?utf-8?B?WXQweUZub2VXSjdsOHQxNTlwcWlqcGNMSWY5VFhWZHY0SzVWdVV1d0VKR3F1?=
 =?utf-8?B?elcwSFRaRTk3UGRaSHMyQTdGUVk1bVVOeVJQVE1DNXNBNXNqcnZDYnlsYU4x?=
 =?utf-8?B?bWNiUUllWUl0S0x0UVBQTTlZT2xFOU9kRHRBcEZaanlIUVR3ZTIwcWdQb3Rz?=
 =?utf-8?B?THFTeFRUMXI5V1lUTGxWQWNQZjB4WXJYUDcvY0FnZTNub3NTTEtRRW9wc1lF?=
 =?utf-8?B?VDJNbVlhdHlSKzdMNlJwZ3h3K1QxK05rQ2k3cWJuWnlBeXc0cDJ3MXlab2ZZ?=
 =?utf-8?B?blZkYWhDSjBEM052UHZBWWFuK0RNRFlidmNVVXhpdHZobmVTUUNBR3llSk4x?=
 =?utf-8?B?WDdNbjR4VVFlblhPYVZEMjBJYlZKMFY3MlVhNzA0WDdaY2lITTFwaU9hbWRT?=
 =?utf-8?B?ck55Z253b3dlQ2l1KzRCMlBlK0VZUVNha0g5Tk9EN0h3U3dJYmNiSXYySnNk?=
 =?utf-8?B?dmdxWHJ2RytOemsyQUZzajU3U1VNbkRnQUpzeDNsaVd5TEdXdnJIR1ZTbml1?=
 =?utf-8?B?WlhXU0RTOEIxN2hDZTlLTWU3a2o1TXYzMFBNaE15a1h4UisxUzc2K3o1MkdU?=
 =?utf-8?B?Y1lTOXBDcys0MkUzS3QwQWsxVDhMRE5yekNXQitVRkJ4d2hPT2cyTDNLTnkz?=
 =?utf-8?B?Kzl0c3hGMi9pY25ScnFnNW10dWduWUtMQ3NWZmE3alRwRGZKREFiL0dJNm5S?=
 =?utf-8?B?QmtMb1pkUUFSWGVUS1RMbHlVSm82ZXpGOUdLVGZIQzRLbDRXSHI2Q2tTK050?=
 =?utf-8?B?c2VUS1ZlRWRGZk9kZFg4NHJ4RWtBRVpiOFhORmx2OEZ1UG9aNFhmVnVybHdT?=
 =?utf-8?B?N0tnc1VPK0lNMTlYcEFqNldXUmFpN0pkVmdmRzQrSGx6M3hjQ1NYZml2QlV0?=
 =?utf-8?B?R3YrQUE4c0tLSENuUzd5a2M3S2VSQXh2emJ3bWJ3QlMxN0NxSzBlanBJU0lC?=
 =?utf-8?B?Rk5QRG5lTGw0R3IxbHdkRTF1N3h0eXFlZHR3VHFxbkttd040N1RiWkFCOCtV?=
 =?utf-8?B?azVGejQrVTVlbFJNNTM2UXRQQ2dnQlpaMUdwdGNwaUxXeGh4MmRMWGU1Z0ZB?=
 =?utf-8?B?ZUwrNUp5YjhCbXd6M3dPbFN4a3FHVnJROWFNZTVzZlQ4elBHRnBuM0htMXRp?=
 =?utf-8?B?SW9YQTNWSmlQeFBWZUZOaHdEWWdXSEZFRDFieHdBZzR4N0NyWDJLWGpTTVZh?=
 =?utf-8?B?WDVYblREemRSWVhyNTQzTGx5czkrUjZFb2dzUmR4VEkxeWNjWG9tc1hxbWdj?=
 =?utf-8?B?M1BsY3BkcHlZQW9rSnhneGxiT0txcVBtVEljdHF4T1NQa0RmZHpyWlJGckQw?=
 =?utf-8?B?NnQ1NUJXTWlHYVdwb3BzZVk4QSsrRUlMd0dOc0hWVFRRZjh2QjhSWEdGTHRi?=
 =?utf-8?B?Skp3dk9jU1ViYndnUW9veDVsUWZZMEgxT3EvUWlQUThJanRmMDNWeDVVZHpR?=
 =?utf-8?B?WFRDWUhCdVMwRXpKOHpGQ1o2OFEzMjlDa3ZTdVVXOUxoaE50OHJJQWQxdzcz?=
 =?utf-8?B?WDNCQjNkeStxRitRbTd0Yk44a1NFYlNiM3g1bHRCZFlidUR5Sy8zS1cvWkg1?=
 =?utf-8?B?dm9USjBSdUpIeXhRL1RVQ2lndzc0RkFiN216d3hvUllVN043ZGNFMEZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRGU1pvMDJOSnFPL0FUZGFnc0JWblBUTEVoQWVMWEZhcHpLRFhQYlRsQ2hx?=
 =?utf-8?B?VDF4bkxDOFRQRFZLOVloUnRBMWNvWTVxRXhhbXBZYno1YXZ0TlNBTGsxbS9T?=
 =?utf-8?B?R1NSdGpURGVzbjdkNldFSWZCUDNxZU9DUXAwQmROcUh5MUsxYWRVVFdjbUk3?=
 =?utf-8?B?b3cvbERuazNFR25hZWlGOUkvRVg2aVNHc2FmNTFDNzkvUzRhbTNaVkpSaElr?=
 =?utf-8?B?N0xUTndUL2FBb1FHeXlTSnBsSmxHSk9MQmsvS0JuU0g4Rlk3YkFlY1FuSzhF?=
 =?utf-8?B?a2xmSVJjakxnRnJkWFZrUXhVVUptOEpMTkxhMFpUb3NYdTRnNGFFcGROMkpv?=
 =?utf-8?B?cnFjR0FYOHhxMnN2WFh4NlhMa2RzQVNHVzlKczVsaDVrUGlvbGF6dzFORExH?=
 =?utf-8?B?TmpMYmxSTlBSd3JLSUdsNE9pUlY5c3BwaVlVNkFhb0hzRGJtaTgxeGlqcFNk?=
 =?utf-8?B?bC9VVy83MXhoajVMZE12ZWZ3cE56OXBYd2Mwa3E3RHNQM3pxejF1aU9FM3l3?=
 =?utf-8?B?N3FONVhYRHNvN1kxUlBsWmtLRnh0bzNxaDZMeW9KQ2xNc1huaDhuamNxTHBs?=
 =?utf-8?B?WGx0b1RYR1lTOEwvUDFBbFoybjZ5c3NwRGhuSVJkZUxkQlEwTnhYRnlPTnc2?=
 =?utf-8?B?TjFTSkhSWTZqcWl1UCtVVW5wa1ZyZ2xRYW5IRHNpekxUYUpUU2NxTlBSaThu?=
 =?utf-8?B?SjlPRGFxaHB6ZzhETjB3S2NvbkxrbTRyMnRuRkw0N25PVWQraDFsdzZTT3VC?=
 =?utf-8?B?cFJldnp0Y0ZTaFEvZFZDTC9sR3d4UzgwTmtTY3Z0TmczM2ZiVFBYYk54RS9j?=
 =?utf-8?B?aFZUejJkSy9ySDRrbjRDN3Z5d21kTzBEZTBENUhvVWEwSXArbDBIZWQwanJF?=
 =?utf-8?B?WGlwSXB6TEJQdzJBbEZraWFsUmhiWHlRanhkNjJpYVB1UjFmZGFESjNKbWZX?=
 =?utf-8?B?T1JQbVVNUWtWUTBRbUtrSEhvTUNiWnpSMkRhSCtTR0E5U0pLVSt1MVYrSzFj?=
 =?utf-8?B?N3lZRSsrM1FGbElPb1I4VnU1UDBFOG5PV3M1cjJiNk5Dc0RhMUdCek5EZDJW?=
 =?utf-8?B?aFVkeFVmNEJSaUJBUEVCS1d3U2kwc2VKZGJyR0lKWFY0WFE0MEh5ZEkrRHQ5?=
 =?utf-8?B?Ui9kT0hCQWpVZ3ZPeVZXODdxWitTUjl0azdGcURjdGZSbmhqN25nUE91YVd1?=
 =?utf-8?B?NDA3ZjVONkt0V1VKbHNjOStpQXVGMGcvbmVUL0MwZ0pVMzBJYXdJSnlkUW1z?=
 =?utf-8?B?VlM0dEtDZ0JDVExvOHhlZHZhd1FCRkVEZURjWUNBc1VVeVJBVHZHaXJZQWFw?=
 =?utf-8?B?a0p2YjlwQ3dUMHBSUnJuVnNrajhlN0VFTURxL2tjMDdsZ09xamRPRmZTVEFr?=
 =?utf-8?B?Z2s1MWxIUGRCT3JRNVBnMXRlSW82TXBXR1RHS0pLcEpHTmdlaVNpamRWcFIr?=
 =?utf-8?B?NitCRVppOW9GaUlJNnJJQkVSbXA0TlRwazY0N2ZZNE9ITzZ5UUpmd0x1T1dz?=
 =?utf-8?B?TXArL3BmZUFyUTkreHdLRXVReEM2ZXA1ZnUxMUNTSTNSalJuZ1hrZmI4dlhY?=
 =?utf-8?B?ajd6UnRkNFNKUHovS0FtZHNjMXVYRkNmbnhibWpZeEgvSTlxWUFTblFGakls?=
 =?utf-8?B?ejZJanFGYmN6L1RudXNjdjhTU0VkZ29abHpiUml2a1dVTkpqM2VqMW8vQWQ4?=
 =?utf-8?B?TmYvQXNOTHlMMzN6TGYzSHlxbHNkNjcrSk45czNjc1pibFRiZ1hjWmFUZ1A5?=
 =?utf-8?B?TE1iTnVQNDMrb0JyWXhrQzNCTWZlbys2bm9BZVczdDU0NkZadi84U3djWFdn?=
 =?utf-8?B?cTBCekNkRXJGWkhJUFdTNzBnK0F3WGpuMWhVc2xKWjAweGxMcE1jU1dyNDRT?=
 =?utf-8?B?bXhnRDhVY1g0NjVHTXZ5ZDEwdmdCYXpmeVc2amVheDNPaFhDbWFVLy9EZjRZ?=
 =?utf-8?B?UzdDbDk4eUEySENRZ3k4dWJMdEJJdXRybFRscmU0TWRCVDRMbVk4R2hNZU5s?=
 =?utf-8?B?LzI5Y09jZDdtV09JSS9NSW80SjRjcGJmdkc5YVVwMm11blJ5cTJKWHVUTkdh?=
 =?utf-8?B?NXhNR3NNVUNrbm5NVTNOaWR6MURRZFo0d2p4eENxMFJndzBPWWdUeXI3SmJJ?=
 =?utf-8?Q?zObMykGritSORhbnvhX8cnIGH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5552fb5-7b91-4a11-75a0-08dcdcad1853
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:25:17.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTLZ2AG88QwZgr2RmqxPWSyJWTG23Es5X2oqaQQUFzcuGi3WWmydZ1sKlm06J3gLEWKLloQEs1n5KDSUJ8ktlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182



On 9/19/2024 2:21 PM, Mark Brown wrote:
> On Wed, Sep 18, 2024 at 04:20:35PM +0530, Raju Rangoju wrote:
> 
>> AMD SPI0 controller supports quad mode only for read operations and has
>> limited support for quad mode writes. And, the AMD HID2 SPI controller
>> supports DMA read, allowing for up to 4 KB of data to be read in single
>> transaction. Update the SPI-MEM support functions to reflect these hardware
>> capabilities.
> 
>>   	/* bus width is number of IO lines used to transmit */
>> -	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 ||
>> -	    op->data.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)
> 
> So this code you added earlier in the series is clearly buggy...  this
> whole change should've been part of that patch, and the addidion of the
> patch adding the new HID.

Sure, I will take care of this in V2.


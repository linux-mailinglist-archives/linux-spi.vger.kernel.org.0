Return-Path: <linux-spi+bounces-8387-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C96AD1BB7
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 12:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C37A4350
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367DF1FC11F;
	Mon,  9 Jun 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnVdIyEA"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E412517B9;
	Mon,  9 Jun 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749465669; cv=fail; b=b59O3RDxEUxXt3DV0D/pfR2w3XdL20e4gGnxpjkdo68I2JBNbFgRw8f71QDwrDtQ7WF9GX9kIDU/eOveFfrRplUk8ZdKPkJvP1dRjXn2FIU9rs25yoKC8wSUdae+nW5lNezVOPgTcWDDcFI/rZT49f9BpfDYWMKbwma8eY10lvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749465669; c=relaxed/simple;
	bh=E5/PJo3WUEGcvqvsi8kprrgUHl68qVy6C3uNf1DLxyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbQyltMbhBO6M5xc5NkXS9IWrqqrrHKAFjGTrbvnU30ySoBGyOSSZk53BIFF+a3VCaOpqEQlhqA2g0EGbaPGCHIdoOIRO9xBfpaaZ1noNalMUkQfz0lwKLCzxCPxptUiyEvZdqXJSKXNUEnoADlC0Qz1NUXTlTNFiSf50FmGy9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnVdIyEA; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDeVkL5UHw89OdwYp8NS7paicF8K4ESfELLXS1SApZ4Lb1Vm/gZTMH3kgPFCMaTy5kcpMVwEGS33bZMXDyZHO8Lkb1qNXAlmucETT8HyZA80JlO/sbsXtO0U7hZ/BMTeWhSRulWf8aI+JEPyOKIkqVXeLU2N3UNCf9ts0xKyEBea3q4hhdSdQfghwmDOd9/IqExikh0j79zstRgOMvfIAKrN7KzPSdCI//5YbjmSI+8P6UXi1GswTwfe54eC1yTYLwpVojdOwmahIdFIXtOaAvdRlhqWq0hz3LYYUyariJ3rC9eesT1a1wsbhrUV/b10JNsPh9pbvmhEWoVwWA3qDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i2B37tA/e68srQFcUhOMhNnuF6nvG1+gC8LAgIqHsc=;
 b=YpEDkBN/2fnXIhajCVxded6tMJr+kVkBrGv6w1gQabVC4nHDzc1sf2/nXe2I75sqPp2JezQFwyRwn4z4dXWahNbhlhKVEwximK5lhQx/fsEqyCxde56STkYgtKzpxvUn6ae+YmyjXGjytv2I0e6z9n7OrVt+NG4ruo1GP8epszIohtvu6a3M+cCPTMPNtr/Xa8mcRCF0yFD12DOzoRQ0CSRZocBI9dWapw/si9fYSYdbiz4RK2SmGvdCRXDPoj5u6HJFlvQZdTqLhC1KfhGut6FvCK37MFJyW/1+YVy+EkKm20Tx5jqTt4vwd+IUoAJmjhhr64iK54kyl6gY1/KA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i2B37tA/e68srQFcUhOMhNnuF6nvG1+gC8LAgIqHsc=;
 b=gnVdIyEA9/u4IHI+sctRc64X8svdT6RC54QcrwDlxOKA7Xwgycgegnta6F9iX6PNSmuxvfE/mNtEB1aa7tvtNcoda2X2JmeS68GIurv+VO/t7BHxDDpv95pAsRzTpA/tY1i8Ve/Pw7Kf6qdaNys2LcHKMLNHvKWwEeD0wWe4OhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 10:41:02 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 10:41:01 +0000
Message-ID: <76916f5d-bf5b-4e4c-9252-d537dc00a2ed@amd.com>
Date: Mon, 9 Jun 2025 16:10:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>,
 Akshata MukundShetty <akshata.mukundshetty@amd.com>, cve@kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
 <aD1ytV8kiWP9ssuv@stanley.mountain>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <aD1ytV8kiWP9ssuv@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be1c752-2858-49c0-fe6e-08dda7422096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVlzWGdZNmg0bHRIcGcxajg0ZDhOV0dyYU9XRUZNcXZXQVIzNk96VE11MXht?=
 =?utf-8?B?bzlMZWlhZWpNVjR2c2dobGlRd0ZtWDBMbm12RU5OY3dlSENsVU5Nakg1VE9y?=
 =?utf-8?B?VzNPUjBUNDc0UFB2QUpqOWVPR2kxRjd0Vk5Gc0xHS1NjQ1pNQnZSeEFWb09X?=
 =?utf-8?B?YmdDWVhVckdEdE4rRHFkc3EyakVSWlg5dmZwSjhCYnppR0lYUEhkS2VNSjNC?=
 =?utf-8?B?cE9DK25MQ01HWFlOOG9ycmtuQXpaN3hVUUtNa0xSVzlzQnhON0RLUk00T0Vz?=
 =?utf-8?B?MGZzb0J6M3JCN09VZXhCZ3BxN2J6MFYxQXNiNndBcnFPNUtkNW1ZaG94UXpQ?=
 =?utf-8?B?YTVFa0pIKy9XSFg0M25NdXVUcUo1KzM3NStVWmYyek5zN0JnaUNyaTlHTkxT?=
 =?utf-8?B?bWs3N1d2UldjTElPZE5zZXd2QVZBeDJFbzBEQVJER3FtYmM4UHMvd3hlQkJu?=
 =?utf-8?B?RjJ4K09McUttSUlTMURzKy9oRkJoUWlGR0ZUREgxV3lrNXc5Q2JMZitxRXp2?=
 =?utf-8?B?Vmd1N3cwSWYzQ0ZFSk5MUTJMZU5Vb2YxUmNtY3k1VTlMdWFjQ2dYekt2WTB4?=
 =?utf-8?B?L0RpaG45alEwSUwyYS9LVDd1ZFR1R0FRTzdKMGRPMHF5MjBDRW5aYUFjMmkz?=
 =?utf-8?B?NmpUeDV6QVllMXoxQUZUTER3dExWcGh2RjZRQWFrdTVNTlc0V0tkQk1id1kx?=
 =?utf-8?B?RElHQ2NXdDd3U1dpSWxxdVRUem9YUXg3a2FpdkI0MnNvSi8zRVdNaFlQWnE2?=
 =?utf-8?B?emczaHpHZUczVExHL0c3L2ZaRWVGQ0dDVFZiRkVqYmFmUjZtMnZtL0VoREU4?=
 =?utf-8?B?czQ2eldEWDlkNHRXa09pSVRNSStnWFIvNEp6bVdjMStPMEpiSVFEVmgvNGZs?=
 =?utf-8?B?V2VDR0RIcnRkSHF4MEtGQkJ1b1U2dzNJZjlMaTVwOVkxRHpOZDh2eDVWZDJp?=
 =?utf-8?B?bTBram9OSkY0UzNCMW1YZ2ZGTGZ2dUFPNmg4T0lCWkI1L2hEczJjMTNoZENM?=
 =?utf-8?B?S3NVZG5IRVpLRzlRbEV5UmdMTzFITFU3cnN5Ykg5ZWJtTEdFU2FvRkpUam9t?=
 =?utf-8?B?bTBsR3JGVXBXb1RxT3FzN0ZNc2ZvdnJIS2lYbysvcnlGMVR4dS9yV01NTlNS?=
 =?utf-8?B?Y3ZYc1dkNi9Vc0paREVMS0tHcmpjTlR3cGNwYkVLR3MySGtnSFE5VXRoZXJ6?=
 =?utf-8?B?Ny93S2g5YVJraHk2c3hjT2s5UCsrMjNvK3RHWFpHTThlZDhoUm1aVHhiQjll?=
 =?utf-8?B?bWZoQ2hOSWNHa29TOTI3NStXZFJMNStlOFBpblhWR2ZLeVI0clU3ZlBPK0JB?=
 =?utf-8?B?dWNGa1lNckhnUFZlNDNLdFhZZGw4MzNlWVB6cldNOFdXSW9Kb1NlYnpaVHJw?=
 =?utf-8?B?MjBaYS9oMkRQYVNKVWJlV0dYSGQ3eklpanh4am9lMllweFNGU1FnYzhjZlAy?=
 =?utf-8?B?SERUTXd1YmI4TzJKalFFdXVCYzRRQll2cEpROWNaVk5YUmFCcUJ3ck13WVNT?=
 =?utf-8?B?ZUVEM1plMjE2TnNiV3F0TzJLYVAyK2V3OXRaaTdCWDQrd0pncEp4dUQ0UG9T?=
 =?utf-8?B?U1AwemhyaGhzRXJSNWRIaFdqcGxOS1lrTE03Mkd2Q2MzUCtmU29KOWZnT1R1?=
 =?utf-8?B?aFhIU1FvSm9yanRVUkdpL1BDVFprYlY0cjZxc3E1dEpLenBvTGhkK3d1d2Nr?=
 =?utf-8?B?ZUlJcDdFYk1heWJhNVc1ZmlJNkIxeDR4T2pWZmNJTk5iZkMxLzVsalE5bU41?=
 =?utf-8?B?VmxWelpFQlJ1djZBS3RpQXVFcEdESWJPYXdld0lKbGkrclFKS1dqQXk2SzJI?=
 =?utf-8?B?bS9VSG14S20vMGQrRmgxRFFGUFE2OFg0Z2ExcHNQNE5OQlJueStCQ3BWMExX?=
 =?utf-8?B?Nmx3U1M3Ri91QXBuOHBpemJBNHh1RDV4K3V2SWF6c3BHS1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnhQWUdrY2hYb3E5ckdwYlFMMTg2cGhiL20vZVJBYlhiZk8waUJzVG1uVzZh?=
 =?utf-8?B?MU1OVXlOWmlPNElmZTNDWmRwTm5qZUJNb2ZDeitTR0pHU1FmMzYvWjV4eWxk?=
 =?utf-8?B?TDNsb1lCaXlTbHpCc3djUjRzNm9Sd0UzdzEzbzJxMS9aS24xNk1oZ0R0NWJR?=
 =?utf-8?B?VmRLWGpkeXppTDhycFlMRnk5NXp4UnJjeGZBMDJRaU16ZGoveXBDcG84L215?=
 =?utf-8?B?VGRSdzNuWTdOZ3B4WWZVa3AyWEc1UUY3ZERuZjVsaGlhUUF1djE4Z3luTExu?=
 =?utf-8?B?TlVvUmo2SW9OSGZ6bHd2aEhZcXErUU1DN0lrUWpRVzdzM21idElDRVdlRlhS?=
 =?utf-8?B?MnFEbUpPYjFzQVErQUJVZlpDMTM2OHlHUG05MXphMVErcU5hV1RTYTZNWjRt?=
 =?utf-8?B?ZEtSODhFeGtIVWtTRDVINkVXeEVYUjNQZXUzVWZGZWtJOHF0c3V6eXR4cWZL?=
 =?utf-8?B?WGs3VTkrMFkvZWwzK3ZZWVZ5ZERBLzZoODFjR1RKbGovRXlINlNhSC85eks3?=
 =?utf-8?B?cUVOVlBnSnppMU91WEJpSDlwQXVBK0w4UHRUQUVpSjJ5ZXAyVnRHajVVeDVy?=
 =?utf-8?B?QkljelZFWDN6TDBpcnhSUDhiYkhvUDZENW5wSjZyb0hSUnN5WHNJLzdwaUNw?=
 =?utf-8?B?SXhNSHpoQi9DWFA5ZklMa3J0VlowTUkxdFRqemoxcnBHMVh5YjZWMnJXbVlK?=
 =?utf-8?B?S1ZGQ0FpN0VwVEl1RmxUVU9VeUJuM3NUUk84bUJsa2FVKzB3NjZkNzBtcGJ5?=
 =?utf-8?B?aFZTcnVDN1M2UVFvRXZUZGhobzZta2ZCODJyRldFN1E1UjdQWFNtem5ReHVK?=
 =?utf-8?B?LzBJMDN6eXdRQktWVGlyVllCNDVZdjhBV0swRzFIKytBMTdCNmNVUTA4cVJS?=
 =?utf-8?B?ckR3bXMyb0U5cnNiRDZpcjg1cFdhM3BwbVAzVHJTdUdHWXNBSWpweWhEcmRa?=
 =?utf-8?B?LzdrQmZBdENOQkFZeDF4emc3VjNKaW05SDB0a08wRVl4UXRUZ2RHNzdkSzZ3?=
 =?utf-8?B?MVY2UGdpTWUzNWxiQVdVM295OFlBdU4waDVRMmVaS0VUVGdGY0pISE9qYzhL?=
 =?utf-8?B?bUpkd200N09SUmxOWjN3MjNBanVQNWQ5QTdxUTU1RWhjcXkxTXlKMXpHTzdk?=
 =?utf-8?B?TUlOWFRpN0g2WFU5TWtBRGlpWFQzc2JXNzRFTmNDK2NXWnM5N3ZLbUt1MmRj?=
 =?utf-8?B?aEVIc3NFQU5vVnRkYjJiRGZhREljd08xc3ZCcExmNEFUV01ZTWZ3S0ZIWXBl?=
 =?utf-8?B?TlBHOUZNRnR6cGlWQUVLaXZva0kzc01kbDhYQlhSbHI4bGZXWUtoREJCUVZx?=
 =?utf-8?B?SFQvZWNXb2oraXkyRDNRSTJKblM5M052b2NCSG5hTG42UTVTcEJQNlBpNFF5?=
 =?utf-8?B?N2ttVGwrelN3OUtGdlRzQTV5VHo1OXJlSWV5S21Oa0NQMnp5U0ZMWkZ5YmFx?=
 =?utf-8?B?VVZad0FqNzNsSFc4MXEzNEpld2ZmY0lSZjBNQVpaSCt3V3A1Z1ArUFBOZThY?=
 =?utf-8?B?YkpJRlVLVldPK1J6VHlna3R0UGp0NnZyVG5YMFpFdXZ5Ykd2RWhiblhTc0lM?=
 =?utf-8?B?dlRpWlJqK1E5VGwyakF4SEdsV0lNaGNCR20vb0piUGtLOGZRaHlsRHJXWGlx?=
 =?utf-8?B?ZjRMNVFqcFNWZXZSczFkQ3BlOFd6Yjg2K2R1RDRBNmdDRlRwUCtPRFRidk11?=
 =?utf-8?B?OHZBSWJMMHNyUTVWWUdZMHV1ZFh3Y0l1Qks2eDl5enpRaHdOMTBGTkw2ZXlM?=
 =?utf-8?B?M00xK0FzNktLd2wySUJlUmhjQ2FxNXdLYVRLQXN4TW1McHpzOUhocVdZbU14?=
 =?utf-8?B?OFA4QmNnMW9pRzRXeDdQT0x0QzR5NFRnT3Q2S0lHd1JpSHVqSWU3RlFreDFV?=
 =?utf-8?B?N0VWTWlOU1VhMzJJb1A0OHhSRmtwQ2hrVVFrdTkvOVZybGNqRStsK1BsaFlK?=
 =?utf-8?B?MmJ5L0F4Zm5TdmtidHFpa0VrUE5QQnVzek45NnRmaVlvQTJPL2pZRWZJcFVs?=
 =?utf-8?B?M0ZYNTZLd2JFZ2hhV3hQYUxiNFp5UjhLSUVIMGZGTy9yRDdYOWRrcGVHT3RX?=
 =?utf-8?B?dTNrZnFGTFVoNmE5RmxOaHJUSE0vWnFYNzhqQ0hlNTA5Sk9BcHVPOGE4L2ZQ?=
 =?utf-8?Q?IGBMh5hoiWxCiL6lGopK52HbB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be1c752-2858-49c0-fe6e-08dda7422096
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:41:01.8007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKv7gJOprD23HYFfZ1zw+R+ZGZ1lSqfFGG0ELrjjdin/vrmPEKFFHuZk1np2PKL8O5LhaHXGPekhGt8gsJrCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631



On 6/2/2025 3:15 PM, Dan Carpenter wrote:
> On Thu, Apr 24, 2025 at 05:43:33PM +0530, Raju Rangoju wrote:
>>
>> Fixes: 226d6cb3cb79 ("spi: spi-mem: Estimate the time taken by operations")
>> Suggested-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>> Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
>> Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/spi/spi-mem.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index a31a1db07aa4..5db0639d3b01 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -596,7 +596,11 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
>>   	ns_per_cycles = 1000000000 / op->max_freq;
>>   	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
>>   	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
>> -	ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
>> +
>> +	/* Dummy bytes are optional for some SPI flash memory operations */
>> +	if (op->dummy.nbytes)
>> +		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
>> +
> 
> Hi,
> 
> We were reviewing "CVE-2025-37896: spi: spi-mem: Add fix to avoid divide
> error" which was issued for this patch, but this patch is a no-op.
> 
> If op->dummy.nbytes is zero then the original code does:
> 
> 	ncycles += 0;
> 
> We don't divide by op->dummy.nbytes.  Was something else intended?

Hi,

When there are no dummy bytes for an spi-mem operation, both 
op->dummy.nbytes and op->dummy.buswidth are zero.

This can lead to a divide-by-zero error.

> 
> regards,
> dan carpenter
> 
>>   	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
>>   
>>   	return ncycles * ns_per_cycles;
>> -- 
>> 2.34.1
>>



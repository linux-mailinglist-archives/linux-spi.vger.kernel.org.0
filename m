Return-Path: <linux-spi+bounces-7367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F8A76614
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 14:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5059E16B47A
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE51E7640;
	Mon, 31 Mar 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dmYoxALw"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954B1E5B90;
	Mon, 31 Mar 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424471; cv=fail; b=YiHiEPvQQmGoXVC91Vjm1LU7yh7Us8vZaC4U1kAiP0Y1O5pdKp2rAmhrPwi+nyV/l9JedLDD5pQJZECYLEYxIwAaYh0hLW+whOA76ObzgP5q0V967IlWqFUjLwrt7XIY3MfrasfbUoxlDSLCKgoryNdqiPDweBkpP//2SW8zgJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424471; c=relaxed/simple;
	bh=BZT4XUbU+89fag9M4vJcpZ6aDhzlMI/bY40u2e5uJXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UGx/trYH+NKEIG5kYXmRirOzbXprUnMhLvAjJLwcS/9shk5/a1GwJrA+uuF0DoTwlgmb8aXsv8JRy6zNOaaaPze+C9JQ1qIaRgS0jK4AGLqYii/Em8MYOTVw2x6kmKo9y0MTXeQN5HLBlNk+DnPyLMzfYeS/R6V+9E6XvIFwk5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dmYoxALw; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcWEP6dHnM/nBYuyEQd8RHIYqWEzloRX5BuVcv0BW9Vjzo5Vd4qJWyAbJwxRGDYFrrqklMVu51P7MprZ7uCB8ltZRmhIDUN+CWdfzXOCRVDR1k4mFn7LZKzVWQrYELVU4zN3ZKG/eRcvRIOfhMApfh7lYRF0y8TMk+nOIaO3SDKcg+KiVY3r7TJctMsVm/CbgXnkrOoXKk8HA7J7XkQTJmtzTXGQjb8lHfqGNG2vzSKCxXItuUgcbpYgFeOHks9UJbGPzIEbYYwD8cgBrgk8HcCETS0PingxatWTKojqXDz4+I12qlOWmJiIu12RfDyKuduPTpOEJuea0zWvfezWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSkUodIGsu5q0JX7HuCl302DcAHRcaC7OL4bo9BOiyw=;
 b=X9OtHS+Q6p2IlUQ9z5XvZUaPq5/Rlpu8eqmlCB3d257OJCrGTU3xYt5MWgdrgABK1xZDNrZJl1qNp9SDU3uDdXRhYHeqMu+IpqD/j9Y7GdZIw9jUhbasJcr6SciP06l9vQ7345EdhMwcZBjsfYI8kfDgAGcTNfYtEkAXuDxGyORch/RX/nsHxGNUYLLKBX8K2uTCwFAvByX+/BFIpdYf9I9O45a7VnKCWmvWUI01q54RGlFfLxuYFmNi5Dlp4xJjU0TQzhEpQKKGm4Inneyu8GsBAOKs5FTW7LrqWDrbOfxzId5jt0AvNWBfoO0kbphqV+RYXAVYPsj2gzQY+2pqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSkUodIGsu5q0JX7HuCl302DcAHRcaC7OL4bo9BOiyw=;
 b=dmYoxALwvUgdAVWbbWvZoV7uKHKhd8n23WYoDX/YgeTgYNAu0DXn7cu3cHOahp5N25Mp5RMDSqM6pCeAEJJJtuYnUHh3c98QCV/aTKWVeB9sjoEHBG1q5xXZaklzm/+WfNAZNTUrvs+1UCYzK0g/+XUnZjXqII4H8A30LhX3q0dydcrGzU4QOFF7lPsRigznXe5XLlPaXV4qXmhsMoxBFkDCUBEcEMqE2JJtxmSGvTxvfjaNjH54ETn3gJzgM9wuECC/m02uuALJlfTCypnx+tiAZ3MpXCS+EzPnnjGEZEz3mn1cbcPxpeejOobUkWnM4JBa6yhVYGLrl0Zk1HZlXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 31 Mar
 2025 12:34:26 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 12:34:26 +0000
Message-ID: <69aaba89-10c6-408e-b328-c3e31a1aeaf7@nvidia.com>
Date: Mon, 31 Mar 2025 13:34:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
To: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Vishwaroop A <va@nvidia.com>,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
References: <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
 <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
 <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
 <63b87feb-32ee-423c-8d82-61445414c6f7@nvidia.com>
 <9760cd70-cbd6-4865-92b9-b48eb2cdea55@sirena.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <9760cd70-cbd6-4865-92b9-b48eb2cdea55@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ceb00a6-c59f-4e5f-db99-08dd70505f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHZkTW4vSitMcUdRSFloR2F0VytsSUJ5WVJZam9YSlpBMS9TbHhCQnNPc0JK?=
 =?utf-8?B?WFVRS0l2MXhNTVZhL3dBMGlXYkhqNStUVm12L2NFZVRiRHV5ZzhmQ01JR3J4?=
 =?utf-8?B?c1lJYlVTdnVvWHB1MVlXWUpxSkdudzc5S0NzSmlZVlF6WDBORE81VmhTM1hL?=
 =?utf-8?B?WlZ4OVVLOGVWYlpueThFcVBaYURpbTFzbE5XelpKNHIxK0t4MXFsbUNYTldt?=
 =?utf-8?B?bVhNN3J2aGlFTWlEaVQ3Zk5heGtQdExHZkNLSjhTQ1RTZ09DT2pPWkRTZ0VV?=
 =?utf-8?B?SDA5Y1Rsd0Z3Yk81cUhnaUZ2RnJjZ2c4UXQyMVF1cUNiMUJYVWJ6R21iYmg0?=
 =?utf-8?B?VjZTeTVYVTZkcnIyYnJleFJOZmcybEw3bVJNWnlKNGE4Y3VHUkx5S3o1Tkgy?=
 =?utf-8?B?SUNFVGI2a1g5QmJVSkV2bTJnSmpzWlkyaFlkVjE1eUs2T3hVVzBXUkZoVnll?=
 =?utf-8?B?NGM1SGI1VitxRkx4VGhsNzVtbWhBNnJmdmRhdUZyM0ozQzROZUlGakNqeHRN?=
 =?utf-8?B?dDM2c3pPS1FxcHF2WmdDNVg3MHQ2U0t3M2FvQ2MxekplUzFXMThUWnBaeVZj?=
 =?utf-8?B?QW9WTnIrUjBqZ2RvcFlmeVNiUE9rMUxoUGFkaGxXQ2tnMFB4TktCYnJjTkZG?=
 =?utf-8?B?ODRyMmRsdlZWNmc4ZEpKZ04xQmUyZnFsQXNwMWFSd1I0LzJRTDQrbWxIbjdC?=
 =?utf-8?B?aWFKSE1ISjNLc1Awekl1cGpNMzNvWmRNK3N4WVdnSVBFajE1VEJCK2Q0QjRQ?=
 =?utf-8?B?dlNPaHlBYWErd1ZIZGg3cWgyQlNob0h0VTVlNWo1dllMS2NUdUZ5ak52bFFJ?=
 =?utf-8?B?MWpCQzB2aXBibElrVHNOR3N0N3A1WnE1VkhwYXhUbzhtOWY1QXBqSWtoVG1S?=
 =?utf-8?B?aGt0WDNsSjRrVHlpUWpoZWttam9Yd3ZPTnRySUxxOVdEZ2tEeDZxa3ZoOEFq?=
 =?utf-8?B?UEg1QStGZVdFYW8xVmZoMHY1RG0zL2xtdU4zam96K2MxbUVVdmdWWmxzU0gv?=
 =?utf-8?B?S2pId1VkVjM4dUpvK0VBT3BvU3JoSC9pZjZ0cmU4cnl1U1IvU285c01qMEFr?=
 =?utf-8?B?WmZxbUJVNDhya2ZCd2VlRWhiZ1VsZ3VQTXRqa0RWSURVditmaTlLV3kyRzRv?=
 =?utf-8?B?NTB6YWFhVGZtS1NvWjhqZCtjZlhmYnAwNFUwdmtKMjdBTUdEOGFWdkhtcFU2?=
 =?utf-8?B?T2NUQ0RzTzlrOWNNbndXYU9CRWVVK3NBOFNCMUVTaDFKdHBFa0xRS1ZUNW0z?=
 =?utf-8?B?ajRLZjF2TG5qb3RuMjRmMW9hTndFb1lxSW9KajZ4MzhCWVprWDBiRE1EbGdP?=
 =?utf-8?B?R2JOMk1LemVNa3NkcXpCS28zeTczRzQ4eXRBQmlHdzhpRzNPWFRxeFpsRk43?=
 =?utf-8?B?cjRRbUk0alZHRlg1MFM2a3U2b0JtdC8zRk9EUnNpSXpMZTNPcUdsVHJlUzZT?=
 =?utf-8?B?Tm9BdWhkTHBJdTJzZjRhVW1XcnF3V0IvSXc1SEw4NnhqTHRDTkhOZlE0OG9m?=
 =?utf-8?B?c0FVdHZ2ZTIwc2ZWajVDNjZWWUFINFNMeVlndkFBUXJsVkNwNVZiRHduUlg5?=
 =?utf-8?B?eGhsVi91bzh1R0VsWDV2Tyt4RE4ybm01aHZlejI0bEVzamhESWNIOEZ3SEF1?=
 =?utf-8?B?YWpyWXpDdG1ubXJKczN1KzJqTDhrZk1HbnNVdTh4NW9zQklJR1M3dzFmVzBY?=
 =?utf-8?B?RmRnNWg1cGptNVhsTmpZaEhuTjN6dDFkQjlmY3ZTYzAzUDlicnJEZ3oxaXVw?=
 =?utf-8?B?VmlVeWl4VWJDWkJrTmIrTnAvUnVXWVZlWW5JSU5Bd2lMckQ3N01JZjNXV1hs?=
 =?utf-8?B?azk4V1Nqcldwam9VSzJYdy85SDhoVjRlRDNmSFhwb2xxSFRxb0RmZXNBdXhP?=
 =?utf-8?Q?gB4uLQe9NiYUu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHlxRjA2dzZ1SXh0L3pMZWpaRVFSZFVkNERwSndmd0hjMll1ZnFyZlM5M2hv?=
 =?utf-8?B?Sm5YNWJxakRiMjFSZlBEbEZvUDE1WnNJT3JBZUZkakxFbm1rOGdDa0tpOWlC?=
 =?utf-8?B?ZkFFa09sN3g0ZnNRTG9rWEg1czNUVDI2bkJGeHNCTGg5ZHR6SDNCbzAxWmNK?=
 =?utf-8?B?c1hOUDhpQkV1a3NjdDhiaFdGaVRFeDlyNjNTZ0hodzB3cS9NN0hkaXFMdE8z?=
 =?utf-8?B?d2MzNGliaDM0Y216Rlo4aklZUSs1d25OdHQvNnJoU2pRbWoyYVJURXo1WkZw?=
 =?utf-8?B?SVk4RFpINXhKZ1VmQmdFQ3pyTEF5Zko5a1d2K0JBRnFrZmFxQnMwWGpYZnpj?=
 =?utf-8?B?anZWUkdTVmVxT00zWmZYMmJxT0JqQ0dwTDRMQnFncHczMzM2YSs0cklKanc2?=
 =?utf-8?B?OVZMVFVQbUJpbjFLdkFsTzhIRFNpdVhYc3BNSXdIR3FzZkdEYkYvYk8zT1Fy?=
 =?utf-8?B?d2wwMVpXeEhENXFRNHN4MGJ5aTBEZzgxWS9GU0ExTTgwRGNHSjlTbWlMODJ3?=
 =?utf-8?B?QnV5VHZrNWVrUUk5cnpFZzhpVTAxUFUxS01MRFFEZnRHOWFnTndIcG16TlJE?=
 =?utf-8?B?aURSQ0o1WFFsMkFhT2FDNkZDTnRqc0lxU0d6QWxoTi85Smpnd003ODRTc1VM?=
 =?utf-8?B?SEhQMGxYNnZ0YW9yWGhYUm54Mm9RalR3SnhCdTQvb2hmQTREcFVUZVpGWEhj?=
 =?utf-8?B?RHd3ditHR0o3dzF2RFVuL2RHRnJnYThtdWhISWR3ajBqekg2Y3hwb2ZpS3dY?=
 =?utf-8?B?M1R6U1RwYTBscHdMeUNLcmhpdUVicnBTTHJLTVk1MVhoM01UZWRKRUhHMEdm?=
 =?utf-8?B?ZHdWcmFSSTgrQ3o3aFZuK2pEWFEvWjFVMU1WSXF3UXAxaU95L00rUG9GT3l4?=
 =?utf-8?B?U3JQQlkybkRqb1JaRy9hSGdwN2NxK2E5dG15bnlySFR0UnF3M29GWmFSU05M?=
 =?utf-8?B?bmUvc1BaNnJXTWdjODVZcGFndkVGbEpjMlBlWS9XV0paZkZmVTZRRVVkbGVw?=
 =?utf-8?B?eXhTR0JSRGV4Z2FUQjJHYkZLdHhqWWNVMCtveU56bXpkck1SMExIVkZBejFY?=
 =?utf-8?B?V1cyNE1vOXFsL0hEWEswS2d2Y0J2TWZDRzRpSzkwQ1crQjk2RGVQQktmVEtQ?=
 =?utf-8?B?TS9vOUxVZUsybzBxdUw5VFY3VERoUWRSMUJTMmJwV1JMMDRianhaN2tIZUJ0?=
 =?utf-8?B?VldESjhuREZydlkvMTg4YVloWkwxc29NMzVDOXZ4cjg4ZFBMZUQrbGhJN1FS?=
 =?utf-8?B?NE9YQTRvZ0NQU1ZoNUJkSEdiQk5ia3R2RlowOVhSOEhIaStqYjlTOHBxVWpo?=
 =?utf-8?B?TENIOExTc3F2cEs2TytZMmI1ZlVqcmtIcVBPd3FiSlN3YUN6MDdCNmZkZkd0?=
 =?utf-8?B?M2dBcm5abUwzVEtvQVRKM2JDUzEzOXBkOFhJWVNZZldGZXlWV09vZ0kvbE5Y?=
 =?utf-8?B?NWUvVzJrUEhaWGRMdVRMeVN2QzlQbnRtTnVFVUMwMHkybDdjSFNYMUUwSzRQ?=
 =?utf-8?B?MlpOYTJXTlZyUFdpS0Z5bVVzMEJaWHdSK0NxcEVKSnZMOXl0MXEvRVdVdHYv?=
 =?utf-8?B?TncrRVRZcTdTWSsxcjJIVGNjNjVQakpPWExtNzdrVU1xNjBDUkY2UmhISmZu?=
 =?utf-8?B?MkFwWE5kbTI5b3RTdEtiWXkxQ3JwMG5pYjk0ZWFlK3pVOCtTRDF1c25SMmsr?=
 =?utf-8?B?MzRnNDd6UHo1Yi9UU2s5MlQ2SGZ3TWFjTkVGbWljOTArN0VqbEFyWmNuQmg2?=
 =?utf-8?B?SFdVRi9CRTJUK2RuQzU0VjZnc0wwU0lnSHBxTGsxQU5IYjFMT1RzVFp6MytX?=
 =?utf-8?B?YklWRUZJbmJrb1hQSGZiSFd1TmhDbnlvaHpUWW1mcUY1TTIza0VYa1pTaVN3?=
 =?utf-8?B?MFhVeGRKSUFKZTM3MjlXYmIwQ1ROOHRWeERwNHA3dU5laUxmcXh3NEhZUEdu?=
 =?utf-8?B?cjJyaTM3QytBUXVvUjc0YThvb3B0L2ZLdTkrSnZMSW5uWERpNFc0anlJZVVL?=
 =?utf-8?B?dzdTTFdQdkhRR3lwQ3ZvZXFaTks0YjhIVzYzTXpxR2lvWE9BWUU0WEw2TWxI?=
 =?utf-8?B?VjVuMlZoY1g0T0ZraW5IYTBsTWUvU0YvelduWTIyLzVUd0FRZGxGalJ5clJv?=
 =?utf-8?B?OGlaSFlyYWplY0ZmcUpubGFnY0VRNVZGYlFseDd6QUJaemthQkRKK2RJVEQ3?=
 =?utf-8?B?WGVCd3Z5RWprN1BDcDN1bTdaZHBrZVNVM1VDaldUN08xek9EdFFoMDdMeHpq?=
 =?utf-8?B?R1Y5cnRPRDZrUVg3ekhhQ0FiSWhBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceb00a6-c59f-4e5f-db99-08dd70505f9d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 12:34:26.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcEjN8EhTHxpz7+PJZM5FiBsR/XxRTrgzWkwNnvh9LvEekRfQz3X+oE+gzn79PX+349nvSM3/4eTwuhZjRPYUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660


On 27/03/2025 15:33, Mark Brown wrote:
> On Wed, Mar 26, 2025 at 12:16:53PM +0000, Jon Hunter wrote:
>> On 25/03/2025 17:05, Mark Brown wrote:
> 
>>>> The way I imagine it, exporting would involve writing a chip-select to a
>>>> specific SPI controller's "export" sysfs attribute to have a SPI device
>>>> created for that particular chip-select and bind it to spidev.
> 
>>> My general feeling with those is that if you're building for them you're
>>> probably either already modifiying your kernel or easily able to cope
>>> with doing so.
> 
>> That's definitely what we do today, modify the kernel directly to achieve
>> what we need. I am trying to avoid carrying too many out of tree patches for
>> stuff like this and have something in the kernel that works by default. This
>> is even more important for 3rd party Linux distros that will not accept
>> non-upstream code.
> 
> Overlays should work well for that case too!


If you mean device-tree overlays, I don't see how that will work today. 
Unless we are to use one of the existing compatible strings, but that 
feels wrong because we are not using any of those devices and like I 
mentioned, just using 'spidev' alone in device-tree does not work with 
the latest kernels.

Jon

-- 
nvpublic



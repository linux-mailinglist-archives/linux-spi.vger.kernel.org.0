Return-Path: <linux-spi+bounces-11838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1674CCB1E63
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 05:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2F213014A09
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836421254B;
	Wed, 10 Dec 2025 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2rNWhd3"
X-Original-To: linux-spi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B117555;
	Wed, 10 Dec 2025 04:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765340672; cv=fail; b=DyCEKZjJ4etMAF1JWjnLhYlOdlAf10KBUYYRYNDr+mgqMILnmVzF3YAgy4h9qKfFZAWgy8kgXT5raJHudyZfVPXNcfLl4e7X/PzvSNDAnfXCVnlzvfTkYhPZy78LjpFQh24DRJZPnOY8YXptqS/8Tld4EAc8W8b3y3980ZZSsJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765340672; c=relaxed/simple;
	bh=fUwP+1MpMwPYjKKzttGW9NUcAusDa3t1FdK0hIWquH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVzTMbe+DcQFZoN93877MxCMhB/CaHO6dRL/LRQA28H3NJNk/Ue2a1YXbAgaBMr6el5hB2IXBXgSCtn1Ac1nVuQ+91NaDuUe4YY1movExm8LBIaRw20B7Kse56PRZWS8XAz2g9eqrwRm0XzY44oE0rKPM0S9c7IDQD5YKIBH03U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i2rNWhd3; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCJjexwvXV6pVqZyT/AC6kLQbJr95papvyk6JRrj4FytbS+9i9Tai7sG4fhkiSwj+op19UZtlSHplqnfLkr8kpvt/bP0ILUbRpUXcdbul6phmz2f350JiGQyx4eXK8SYwXAfx7hWHOVcWQEAZy8KGrFhtl+uo24WHTkTjcXMUpGQomU4cSPsETihqe0yeU0+Y5GMkRVaFFw5TDKAqixVchEJIMoOd7x+7eNoUdNBxYi6FJkmDz1fwGFw9rNT4b2gboCo0N8kQF/gZP/eEHIA061XZJe53Lnxacz9hI3ROJcsNqXgsnxXq1vfBRtM7afxgEN0KcMp7juLRnGOAl2Tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vncjNtJJCAR4/egauwnF3Pozlj4AHgWV8yXtkqLhTDA=;
 b=At91ltLj6DxyRrDga75oT53Hd58u8QnjAdx/quCeXllOJUJ7dP/Me3yRFsfn/Td89b050nZi7TwblUSeVmTUsiS4QfwUdvG7Ek1mUJCDlUVq0dg4M0mcXihPrjSsSdcJqoQRQQUX5Osa1IYUDBELZS8ZHCQ2xpR5lg6AH4lFsym5nE+elHENt7yqNou4ZZ6fimsnynGu1BTl/sffhvBc6xOYP0J1WvSlQ05EZI+RLb9sBYA4d++UG8qN1r/65zli0rMsvqW+jLdaWAtZiclt0kxukFJw5y4e7Ui+jtkOmrzZhfgzDEGgTbsg7KRkZYgNlMcplAnc9MKKXzifQOVB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vncjNtJJCAR4/egauwnF3Pozlj4AHgWV8yXtkqLhTDA=;
 b=i2rNWhd32xPmMR2HtHk/aPd/ICkHQhsrZWpCyVoRrF5Tf9Lctr7N8ivqVYCcls4Ne5rOh0hqprTuwe0DdutEbAQm74OSFw9HHVGX6q734lzADACmYkfkY3u7Nvf/IbogMhlb307UsU81N+AAVF7S7RG5topllHxzde1yBs0UhtNWkH5mfdnr6Sra1X3G79uTjKG6Si0tm0pcITi/RE+d00++sYPLw85pLKQP4slrgC68YnjOdfbzDwBBbkL/YFNfPFXAPJlhq8faybLCpJtvlae3pY5smaR/S3NgpjeT6SiYVEOGL9wlfDV+t4pK3sR7JKjiNQZtYxEBavX4D287ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 04:24:27 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 04:24:27 +0000
Message-ID: <e2b2288e-e8fb-484e-9675-39a0d14441fa@nvidia.com>
Date: Wed, 10 Dec 2025 04:24:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra210-quad: downgrade the log when fall back to
 PIO
To: Guixin Liu <kanie@linux.alibaba.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
References: <20251127130207.43754-1-kanie@linux.alibaba.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251127130207.43754-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed8e6a9-4513-4307-2625-08de37a4014e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHhHQldpcUhzQXArWDkxRldrUVZ3T0hndG5aR004NDVvL09BOXIreFI4N0tE?=
 =?utf-8?B?cDF6SGVpOHVncGVqTGRBbmFiZVBMUHhMb2xTTWVrcEx6Nis4ZVNYRlpadlJx?=
 =?utf-8?B?VTFyUGVwQ3BwT1RodUFkNWxvNDMrbXhpNXluV0Z2VUg4amY4bmVJSm9vMGJQ?=
 =?utf-8?B?KzR2c3BIclMydHk5OXBmSUFWQzgwREx0Z09ZMkMwRlMwcUVxZUdxeFFmZmpV?=
 =?utf-8?B?NXRsY3ZSbXR0bjRpME1XYXZHeWp4dWZ4UlJoT1NOT1VTbHNGd2FTSytoOEpQ?=
 =?utf-8?B?TUJ3TzFmR3kyM0FzUmlza0Q1d1ZKNjZYbUI4ZWUzY2J4SzJ2b0orb1dWaGtE?=
 =?utf-8?B?SWN3bzc1cEVEeXlVbzRsT1pYV2phU1lmUFFNOThMQ1djQlNmb0g2eUhlT29U?=
 =?utf-8?B?clBnMm1iTkV0ZFV3NHZxWTg2UUdzOTdwa1JRRG53djJ0dVlxTEtMa2Y4cVpu?=
 =?utf-8?B?WkE2Z0ZVUzIzWXZMTHhic1JpUHJBOXZ0aGlhMkVobmRMMklCUkNDajF1VXNH?=
 =?utf-8?B?R29waTZNZ2VKei9GWnZlQUozTVF4R1U2L2JMdDloTlloeFlZYkVqMVczYlBu?=
 =?utf-8?B?dVovVFYrSUhCVnJrSWEvQ2QraE9hUjdNVnRWNmN4QzArZnFxK2x5aUo0b1do?=
 =?utf-8?B?UVdlQ3dKcTVTOFdsbE5uWUszcXphSVIrRHB5SWZla3ZkbTB2dUowU3hRYjUz?=
 =?utf-8?B?QmlzNlRLeE9DUEVWZkVaQWtkR0NFYzY5TnNtSmNkYkZMZ0dZQlhBVFdjLzRI?=
 =?utf-8?B?U1RWNVFSNDVQTVJQNFc5UlRmQjk5WXlWKzYyTzBoNDh6UVlqSTg5MjJ2aDNU?=
 =?utf-8?B?VzJUdm9TbHBvN2Y1QW5mK0hwLzJ6NittL1Qzclp4N2tIM1dISEVYUDJST3g3?=
 =?utf-8?B?YStUQ3k0V0pNNDFNSTlVUG9yWHR2MFNHRDYrYjErOHhvQVJCYkV1M3hnU2tD?=
 =?utf-8?B?NjlESnBwalJCU0RRUVV2VjVNWFo2K05veStVQVVhTTNZbkt4V3BmTlJnaVpL?=
 =?utf-8?B?WnJhUDFGSDJzVndubGtTQzJySEQ1WWJXakRzdFkyS0F3QUtQNTgrdHFlS3N0?=
 =?utf-8?B?Nmx6MTZzeDd3Rk9TVHdxWnFrc2xiazBYQ0k5aFZZaGZ6T25jdnhCRncxR01K?=
 =?utf-8?B?cTQxQ0ovR3JrQ2drcmR3Y1pDNEUvMDd4VldkOTlCQTBWTWZ5UWZHTUc2UlZz?=
 =?utf-8?B?RGZadEx2WkgwV2ZTYkFlVGNabEh1QmxpRG51aU1ad1ZLWFR2T1NnSG5VN1cw?=
 =?utf-8?B?ZE9EZW5DcVRyZnZiOTB2eFkyMHlEd3Y0eFVnQXFXZHR6UEVCRmtvaDF2VDkv?=
 =?utf-8?B?MW55a3VibzVmRnhESFNqUHJCOVgwb1lKWXoxd3JFRDIvVG1JcVRUZWhUZU9G?=
 =?utf-8?B?a1ZvK0xxTW5PZG82ZHVIc2ZIL1kzRDFzYWJqb2cxTnl0SUxIdThtU3o2d0cz?=
 =?utf-8?B?QnpwQjNQU3ZnamNjVngzYVBNbm9pbzFJZk1NMWVHVi9sUkJOS2hsU0FKbE5w?=
 =?utf-8?B?RVFEYnM5ZWxyRU9TdU5PRVV0cEZ3Uk10NDFEV29odWFnRkY2elp4b21TNVpR?=
 =?utf-8?B?L3RkTTNVbWI0U0dPZTFUMjV4ZmM2YjZib21IVU9uWmZDL0pRSE5mTmcwSnov?=
 =?utf-8?B?VFNnQUM4VHNkeUdMUFBjaE9jVTQvekNzSE9oVmhYaDVXbGdscThZaExkaVpu?=
 =?utf-8?B?OUV6Q2VEZnpBY0hla1pCVU5GdHE3b3BoenJ2ODVpczJwLzRHRGJmMHE1eXJm?=
 =?utf-8?B?aVlBYS9xd3BhRmVQSEJFV0hnOVhBWEF0SitqTmJuWU42UXg4TEJROWpyMjd2?=
 =?utf-8?B?VjMxQ09rUFVaYTVjOTEvQXkyV2JMK0hzdjVIUU4zY1kvdXRZVkJ4cmt3bmR3?=
 =?utf-8?B?OUhXb0lYNTl3emRxaE8yOWNPbmZ6K2ZsTElvQmYyTXBIbnNMMzFGNDdrNHRG?=
 =?utf-8?Q?yXNMRKakp+TcE+yg+NOj4cj0smSGHsoF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGpoZWt5MGlMZ1QwMWJEdDZFbVZNdm1mSHErcmhRQ1VTaEE4R0VreGRVNzRo?=
 =?utf-8?B?MjJnTWR6amtmOHZ0M20xY3kwMnp1VzM4UnErMzdBbDlTMXZxTnI3eDZTVHo1?=
 =?utf-8?B?Q1JicVZKVlBiZFpMM3FJaFRTREl0aGlrQWNGR2RsWGQxQXR1NVZXbUpMT0Nw?=
 =?utf-8?B?T0ZWYkFuU0g4dG4zelpOdG5TNHZPWEszeE5wUW9hWUVBK2wyemtFSmV3NXJS?=
 =?utf-8?B?N3ZQNXFxUEdUM2dpUVh4bWtxYlFFQUFwaEMxd0t5TTBJVTVManRLbzJTSlZJ?=
 =?utf-8?B?NnhnR2ZndlBtbU5JWDFqSEZzZjhYU2IrbFd0SzlGWWZRNklwSUV3dEZsS2FW?=
 =?utf-8?B?dW9idnNyWkhJSGRsWUZsQTMxUWQzYmFFVjJCaTBUMjN3NXRKUHQxZ05WR3hl?=
 =?utf-8?B?enhFRUx4MHNVV3lJMExqNTFMZnJxVnBPYlJTbDJDZnRES3ROeDBkMVE3emQ2?=
 =?utf-8?B?R21lUDNoK2dJL2ljZml6OHdnRmtUVlMwa0hlSWVEcEc0WkYrMFl6RnZhNlhn?=
 =?utf-8?B?Nk44WkxYWFRkUmR6U2RyR3hRSnZpOWlNZytHN2dIQVpsdXNTNDlIUE1XU05X?=
 =?utf-8?B?M1liMDI2VFRaODBQV05CQm8xK3JMTXFNMzU2RWNpT2tDdmZ4ME9UbXE0YXdx?=
 =?utf-8?B?aWh6YmoxUXJrZFczU3pPY3lrWktMajhMclZUZjNWaVRVOW1JZEIzM3BEejZn?=
 =?utf-8?B?M3V6WTQ5YXJ6QmM5ZmxPL1AwaXJaeGNJMTY5eGhzUFgybG0wVkt3aU02aHdm?=
 =?utf-8?B?L2pLWUNjci9MVDlWL3FMMmRoYi82ckpHVHplNlJUUmJ5Z3hxd2hXSldCOXl2?=
 =?utf-8?B?dURWN0JzejF6TElBQzd1L1RVR3FXRjdwUiswVk9Td0dXSTEzYi9nZ0lPNjE5?=
 =?utf-8?B?amUyeTY1Q3lmaktNbjFiMkNMZWlxdzJ4N0U0d0tYbngxNXc5czIvWUdSVEZI?=
 =?utf-8?B?UlFUSk03WUFGQXkyREZkZ08yeFRqTUJqbUJIUEY3a2Zua1V3WlFnZDI4eXVL?=
 =?utf-8?B?dGhuUmNqMWdrbEh4cDVBdHFucXFvZHpDb2lrVW9UN1A0M2gvZ0I4S3JJd09v?=
 =?utf-8?B?QlVpSTcyN2lmRnZBM0tVTG42RzQwSXhKZUVZWHdZVlpZdXJ4MWxHeHNYMERt?=
 =?utf-8?B?Nm00QzhsOGw5Szg0M1NsZnpTU1NQVXZUNTN4Rmw4MDQray9pM2dqd01NTXdo?=
 =?utf-8?B?SUU0SWdJTGlYRTFxNklEd29WNnlyN2UzSGxMVnMxWG9TZTNVUzIxS0tvbVAv?=
 =?utf-8?B?L1l2UkFkS0F0UDV1eVNJYTlFaVllcGhPaWk4dEdRTTM5dm03NGZzY3A4ZHRz?=
 =?utf-8?B?OHR2a0EyNmw5T0ZYaHYxMkl5MnZwemhSQU9QNlJUMVcxdDBFWFlUZTZLYktU?=
 =?utf-8?B?eEVCUGxmYmtrWDJnWlFRWVBybUYwTXk0VmF1ZDFQb2tNeUpJSkdDLzd3N3Z2?=
 =?utf-8?B?Sk1mRjVKRWdKM3JWV2pneno0ZGNEM3I5UUJMek51T21lYThnM1h1MkhYK1g4?=
 =?utf-8?B?b2pyYnArT2dpNklNdEZZTnVjNnhHelFQaTR0OFcySkozZ3FxS05vRVVqQ01B?=
 =?utf-8?B?U0VocjBsY2ZoZVp1NWQ1R3lNSUo4RVQzZExJTUJuTUNtSmpwR3RiVWJIclQz?=
 =?utf-8?B?UzBhTmlGRGpMR0pBQ1lkRjI1U1FvSGxKclpNeHU2ZFhBVEZFTnFqQjJNdFh0?=
 =?utf-8?B?Zm1venJhUzBTcVlPWjZjUHRlbi9BRGV1bHhqN3pTR2M5M1NpY09taFdvempV?=
 =?utf-8?B?SHd4QUpkT2xPZWtFaHVCdXRMdmVqaFM0aU9GemdOYVBoSVRmeHRiL213L1Zo?=
 =?utf-8?B?TjREOW5wTHQ0MWdNVkhLREpVWE9meEl6N0ExWks4L2VUaVRHWFVMRWw4NEwr?=
 =?utf-8?B?Z1VUREN1RkZTZjJYZGNiemcrQ3c0RzV1NVlEeGNNTitUSzZRUkVtcXJCYzhN?=
 =?utf-8?B?Z2gxTXl2RUd0eDdpV0p3N2xzeDdZcVpzdGJKcC9oSnVjWXNheWp6dHNDYms5?=
 =?utf-8?B?eXV1RVRoL0VIaXgxSTJ3eHhNQ1IvVUpMQlQ3SWd2NkQ5RUVDaVI1Wis4N3Bh?=
 =?utf-8?B?QkplcndYQ2d1SmNhSlFRU282M3FST1c4dVl2cTU3eFd2NjRnZmdaSE8zYVJY?=
 =?utf-8?Q?4jjRX8lreoEimXJOtZ1Hd7mI0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed8e6a9-4513-4307-2625-08de37a4014e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 04:24:27.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfkeRKPBViJaV2fWmtWxTm0nROkBtptAfD9hpY/p57moTBNDrKWgrLsue2K3wg+OJbBLB37ZYvnF4xsSescSAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532


On 27/11/2025 13:02, Guixin Liu wrote:
> When the machine boots using ACPI, Tegra cannot use DMA and falls back
> to PIO. In this case, logging these messages as "Error" may confuse
> users into thinking it is an actual error; therefore, these two log
> messages should be downgraded to "Info" level.

Which Tegra device are you using?

> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 3be7499db21e..2189904b931d 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -823,8 +823,8 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
>   	tegra_qspi_deinit_dma(tqspi);
>   
>   	if (err != -EPROBE_DEFER) {
> -		dev_err(tqspi->dev, "cannot use DMA: %d\n", err);
> -		dev_err(tqspi->dev, "falling back to PIO\n");
> +		dev_info(tqspi->dev, "cannot use DMA: %d\n", err);
> +		dev_info(tqspi->dev, "falling back to PIO\n");
>   		return 0;
>   	}

This change would potentially hide an actual case where the DMA 
initialisation fails when booting with device-tree.

Jon

-- 
nvpublic



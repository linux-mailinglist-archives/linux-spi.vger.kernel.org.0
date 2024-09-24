Return-Path: <linux-spi+bounces-4949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD498488D
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE2D28633B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E3D1AAE3C;
	Tue, 24 Sep 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BSHAT3rp"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A11E48A;
	Tue, 24 Sep 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191429; cv=fail; b=rmE71nqRwbAbCoxGR7qk8ASteJ/iNgTDk3m2WC7S2KZTdyV3Fwvck5bQKIo9m35akofyyRidtSJND0DXUkwVXmqK0C3DXtR5OMCW6HU6R1gveuSI2hj5L3sszFECseAWhoSA24iMbPOx18pbo2uc5lwLsBbt7KC2/Ayx8WErsQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191429; c=relaxed/simple;
	bh=6vF82zbAXXCN1KK2wV1XZRVj813JSrcwzuwXfaBPDM4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVhvqm/IygtZizWZu7U4s4bYzUkk7wgvljr8lzHAIMYUFFdPN6jzzfnaBI650jQL0nHqoT7TD7+GC8ASzBnZw7VWrxaL3BzQQR4/EBqhxEzrUdXgvTEAkL+A/e+OGJeI6tyRxdP3JxIFkFCFAnaos8dQY+F4EUnIBXnezZh+D3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BSHAT3rp; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJsk/FSx8HGRoO/B1MctBLTNEHphJ9EZ2lG/UFkvR549XN+yHWilIGiHtHMSng5IEkoSnHgd30LdQMQ2OhkoUfu+A4+dvvuxw5v/1osYI+YC+76JPTTqmu2cXjyiittWhLsyjfsEl6l7dEPrqYdkyYmz57Q4SHy6vbcW1aPqm4wlGR6MerxGh4TkPa84wFDfkFg/rnfbPZ9FbuZb7FS1sBly5EOtqHDqJDFY2TlCEq/Fbl/nLGtyiZSLGhKAEI0tQLQ7bIMV2IfU6Oo0M41XP0rNOKqARIHBRoOuIsil3Jmfgh9Et2nX3H242vilNtyHoEu6dIjoicUPnLLljoFVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/WCx81M9oOESGrPQ3Fy+YJicE+HRWijRxIaJp10hTE=;
 b=XhwESLOXSKq9T1VtobILZx8/L7mgt0r7aelmVliO7F7tjbIDRI/TOBOLxwK9dX89iJZkTZx6XGEYIouNTf2OX+yktwgrjIEqMOrPcGKT/k7bVrpzFjd92gdeRBVu4m9rWa9zz5+oiITMNlXrz7oCYmG8Uzorv1W6wfrtddrmbnmrAbvbztETAozJeAZaJl4BPG3+hkfQJG7f8Om/OA1iLRrJhgAlWC0G/TJDOd5a8XtG0VxGAf8TiaTNQ8eLDmBCAlJzKXwYwwswK70WLPzMWFzZbNlGFzS5SEUzOvYMPnZzEDzyVpGhPZ3pN5nckyqRyoog9FDiOQMJHH0r4NWnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/WCx81M9oOESGrPQ3Fy+YJicE+HRWijRxIaJp10hTE=;
 b=BSHAT3rps5ZpjJQb8yOvLLByG23/PcCJ+N1ms9KvbbMEeb8zOY9LYTQdnW4bja6+fCGevpr8Y3ycofTUiqugU3wh+8N0g0IuFuV1Jxbr/fM/3qJQrTdHGnpwYoc5Nr1fmQvj6bP9Bt4quccyA3qQl59xFv2LkszZBJUuA0KF3EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Tue, 24 Sep 2024 15:23:45 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:23:45 +0000
Message-ID: <ff19fa23-7846-654a-b1c2-e95bdd1adf36@amd.com>
Date: Tue, 24 Sep 2024 20:53:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/9] spi: spi_amd: Enable dual and quad I/O modes
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 sanju.mehta@amd.com, krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
 <20240918105037.406003-3-Raju.Rangoju@amd.com>
 <ZuvkOohXSzLZZAw7@finisterre.sirena.org.uk>
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <ZuvkOohXSzLZZAw7@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e56cd7-d66a-417a-1e3c-08dcdcace114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTBoNkUwTTBidUREenJac2ZFQnpJSG1XdUszQUxPczFwTXYrYmhNUTg5UFBW?=
 =?utf-8?B?TCtXNjhxYURqQ0Y1WTBJRm44VmdXZVo3NlRPYnZXN2wvQ3JLZnpIODg1MmJS?=
 =?utf-8?B?R2xxY1ppRWxaUDNKdk8wRkdTOEpTcW12V2Q0NlN1KzBJMXBRR0JUL05XdnVo?=
 =?utf-8?B?SnU2OUFBRUVaQnpiL0hpVFVrQXBwb3Rad2JOMjBYK1dJZ2pzaHUwZ05HR2lX?=
 =?utf-8?B?K3VlQTF3Qlc1dkQ0YUpaN2w5T3haNHA3UzJKRmZnMlFpZVBWVGxQZGUwTlZJ?=
 =?utf-8?B?aDl4OFVaRmJpZ0ZSQnZSbTNZYzNsV0p3bGZqd0xBTE44elVhQzZFQkxmUW5D?=
 =?utf-8?B?SW9PQ2MvL2I4MTZTM2NmK1pOQTh1WklpY2JjaGViZ1dKUG5SWktkd3JSdVF6?=
 =?utf-8?B?Z2VwaWdRRXpMK1pOTm12cXlaMzcwTzJ4STh2a2NNSWFrT0o3bHVSNVptdlZk?=
 =?utf-8?B?dlNyZmZ0NWQ3WXRyejMzTHltRWdnWEU0cWdITno1c2xsT21ReVU4aWVzV0dj?=
 =?utf-8?B?L0ptekJtRDZNZGhRVjEzS3gxNWZLNFhpOFZsL1BXWE5qdFErVm9UQTFrYnJB?=
 =?utf-8?B?T2xvODJKYnJFZEVrUHNPaERzMkdKOVM4cUdCTDI4UjYzSjI5dVFHKzVJWHVR?=
 =?utf-8?B?WVhWMjRkQW9WVW03eUJKaHVxTDg2ekt2THkwSXpFVDdIZGlPVU4xSG5QaTJ5?=
 =?utf-8?B?YUt3S3RMSHRZc05kMVNHTkN1YWw0TGtQY2VMbWxycFNTbDJTRTFXaEVDMGox?=
 =?utf-8?B?ZVZ1eFE5anMyS2hQTWREZkFxNWxVTXJPcGZaeUNsWVgrbDVOMHE3bDFPNFY2?=
 =?utf-8?B?Zk5iNFBTay9WcWpBVnZjMmZBWmZBNm82dG44Rmx5Q3BmczdSTXdVamd4U2w5?=
 =?utf-8?B?aXJCeUczWmFoR1BiUC9nKzEwVEhaTzdTMkwzWDR0cXBiOXJ3K3V2ekcrT2R3?=
 =?utf-8?B?NFhBKzYweUxKMXdtSE1Id0R4bkdtYlpBL0JGVitZTzJXaHNMV1JqRHRkVXRF?=
 =?utf-8?B?bFFJQk5WRHZLKytiRTZuNjBlL2pCT1FnbnNVbldRaWZZOFUrZjdINWhwcS9V?=
 =?utf-8?B?NUtBYjZrVXFLUVdWUVBPckJYdGpueUgzQUV1ZVlKNGxMMUhhVzBLZmlwK0x0?=
 =?utf-8?B?NzZCS251WlkvQmFYc2tCUzZLRDBvSzZHRlJSbUNQcFFTWkRDb1ZEdEo3Q2lH?=
 =?utf-8?B?SE1ZRlQ4Z29oQmNOWDdGakFJa3Buc2IxVElpU3hrNlltK2psdlhndVNkOHp2?=
 =?utf-8?B?YmhTcE9CUEROcjd2SUdBdVZVa1Mrd0UrdDlneHZIWnExTTk0WkhPNlBVSlBw?=
 =?utf-8?B?eTBlc2lFdU5NTXJpOHY5dVB4NTNrYm5RclVPQTd3VjNHL2NpWTZmUzRsb3NC?=
 =?utf-8?B?TXZtMnp2aFNqYStKNGJ0bWUvNVZIaGE1Nlp4Tm1lbC93WGM3YkJlSExIVEkw?=
 =?utf-8?B?eDFYQU1MTlYrWEtaQ0xpZjJialVrMklUbC91cVJyd3R5RlU4RVdxcWtmazlm?=
 =?utf-8?B?REp5UmlEenhXSWd0RU9heHBZdVN1NWxDdTRDRm14alpaSis3U3JmUzdCTEY3?=
 =?utf-8?B?dmthUW02cjNiYXZKa3JqVGl4TlM2NlZ6dm52V2xxRVhQVXZ2Q0JES1hQQWd0?=
 =?utf-8?B?RFhjZjhPYzJzTk01bzI1QUQza2luMjd2d2c4aTE5Z2JYWmJhd2x6RlEwVnZQ?=
 =?utf-8?B?emxtd2ZXbnM3ZFNKYmRUUmZtcVhOakFCTElHWnprcFZsRXF6RzJvT3JnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU4xMnUzRW91SHAxR1lkMDJzdE56WVY4emJweDZ6cDd5UVhYdmR3d2hwR2Iz?=
 =?utf-8?B?dlk0cTRtNWxGS0NoRWY5Rmc0c1lKMlNMMmh3dExaZ3l4NkFUTUhzTE5KMGJq?=
 =?utf-8?B?OFlFRUhVK2ZYYTI0SlM3UGszWXJFOWEyaHpqVlRMUTZlZzlDMVJWc2o2VW1T?=
 =?utf-8?B?SkJXUFlHNlJGUHZXZ0lrNUZhaWZYdzRUWklNbmV2dzBGZWF6OTd5K0IwRFFU?=
 =?utf-8?B?c1AwVGw1ZnhBOFdmMkhZNllCMGZ1eVozZEkwNGhLRjVjNHFjL1J2QU5kY0E3?=
 =?utf-8?B?ejMxNU5PZXExMlk3L1FuZys5SWZuY0Y4Q01FN25VSkpxK1N0OTVCWG13cXFW?=
 =?utf-8?B?UGZZbUtxdEc4ZW4xbENZSW5jaU5QR1h4Q3BoaUcyOVdXSnZoM01mdCtBNk8v?=
 =?utf-8?B?VzhWaEx2WS82MkVNa2tzQ3lKdHhuQXJ3YmM4U3VIbzZCbVZ4cnNxUGtKTndh?=
 =?utf-8?B?R0RPYVo3TGFHS29uZXBBYlVSbVVTenlySkI2VEVIamNjaWhzNmJLRitKTklX?=
 =?utf-8?B?eEx6NUpLMVlQdEttc3Q1Y3ZBK3Qzcis4WHBKY0xhMlZpdDZPMU40NllsYkpG?=
 =?utf-8?B?QnBIR3lXNnd5OHJaU3ZEemhZeDAzdzZnRStBS0xtTGlHNkVidGY3Slg3T0k4?=
 =?utf-8?B?Z2lQSmVNSCtUU0k4Q1lzUTlJalJFblFqUjNKSFNQeTBJTnY2dURHSExqYUM0?=
 =?utf-8?B?WStWUmQ1SVBKRXZmNU84YUJVUlJnQUVqaXU2TktVNjVOZGdqVDhGNVVjcFYw?=
 =?utf-8?B?UjdvQ25SUXhlRHdSRmhYN3RwcUNVY3FQNUx0ZFJFNTNlRG1jZjczcHZRKzc4?=
 =?utf-8?B?VTErajNTS2VFQWtMVFZtQ1RjdFJzZkxaQXNlbXJ2M1h2MDNYQXRTb0FhcnlY?=
 =?utf-8?B?S0NsejgxMzZPRG1iRHBXMlBNTWV5UG5qVW1uOTBhOFl0Z2xoZk9FdW9SRHpU?=
 =?utf-8?B?NCt1OHg3b2g4dDhVRGlKcjR6U1dhZnRtcFJhMFZpdnd3dks1Wk1uWHdxQ1ly?=
 =?utf-8?B?RzRWMzI2RGRZNGg3c250dWJxaVRiOFRMeXhhY3NPL0t3b1l1cUllMVBWMVFt?=
 =?utf-8?B?aTNxUlV2bVMzUmo5KzJRK2hKdFhNQWJnQVRLenRhL2hIdXRiZG8rNU5tUUU0?=
 =?utf-8?B?SnJzcXRoeldaUUJzRFFpdXl0L2VOU2xKT1VxeFliVWdWVXk2b1QxYTk3YS9Y?=
 =?utf-8?B?TndTVW9ENW9abVpwTTdmUkJKREZtQUh0UWNiY0tLZnh6VVpDNXBhZStCWC85?=
 =?utf-8?B?SGtzL3NNenl2UzNZOVUwaVZiWUdUcm9qbWV6bHVSazQ1Zm1yKytWOUZqdXNp?=
 =?utf-8?B?amxXWm9mcmRNdVd5SVdOTjlXNWN4ejVJN1RLWTZFRWJ6VFZDT3RhUXpEQVh3?=
 =?utf-8?B?eElpZ3dRaGl1Vlhhek54WTUwTkRsV0c5MHZIaTQwdDk4MWJHdkQ3dFVqTUlD?=
 =?utf-8?B?eGtMejh0bENZbXVrbFB4azV2NXM3VDRqU3M1eERBdU1lYXJTTWVpVU90K1F4?=
 =?utf-8?B?WWRNTHdnZCtoM0pkbDhuUUtkLytNdFVrOHkvQUVGU1dWYWFGa3JrZ0pHaWZS?=
 =?utf-8?B?N2VUYjV5ZEpmWXE1eU05aldjY3NESVJvNzlYemFXOUdTYk1EeVRkTkpySHZK?=
 =?utf-8?B?RlRoQ0JuUVhjNE02elRqckt0cFdYaG1vZXNrbGZ3eXRhRkJKTXlVam5aR3NQ?=
 =?utf-8?B?SHZ6dW1RMWpXajlvUFJNYU52bi94d2NLRkJWdE1rWXFLK2FJWEI4RytUVjRv?=
 =?utf-8?B?TUpKdVVrQzFqVXl3NDBJellralREU0hDV0s0UFNNTElMUmtBTk1PM1pKb3Iz?=
 =?utf-8?B?ZEhMSitBcmdOM0ZSVUE5cUhLb2lFaE1PRUl5QjBvNG5IU3A1dVArWWpTOEFR?=
 =?utf-8?B?SzMvcEQwWEEwOVhmMVFKL1lvVzlCZWdGLzg3N1BSeVgrQkFUUE5WcFlTVG5a?=
 =?utf-8?B?dVpwOENzWkt5cm93SGQ0R1l4SmV0K0RyUnZQNU5hb2Q4MEZUNXdaa00vSXYv?=
 =?utf-8?B?UEdMbHQyUW4wVmN2K2x2VldkZ3NkVlNNRXZ5QkEydjdEN0ZOU1Q3Mno1LzBp?=
 =?utf-8?B?R3plc0VMOGUvQzF4K2dCaHB4ejZzaXBDSjViSkFBZFAwYWZFMk85eDVDS1h0?=
 =?utf-8?Q?LJS0kdZvYYBAwwVmxq/JkGW/O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e56cd7-d66a-417a-1e3c-08dcdcace114
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:23:44.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkLUpSNAmPiHq+tRjfwS9gO+ZeolgKwsvQKnewaq5skXt0rztCNOFNaX5SC74N4bYPfEMcEGbXJqoKzF3XmvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271



On 9/19/2024 2:13 PM, Mark Brown wrote:
> On Wed, Sep 18, 2024 at 04:20:30PM +0530, Raju Rangoju wrote:
> 
>>   {
>>   	/* bus width is number of IO lines used to transmit */
>> -	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
>> -	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
>> +	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 ||
>> +	    op->data.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)
>>   		return false;
> 
> I'm not seeing anything where we tell the hardware about the width?

The hardware already supports single, dual, and quad I/O modes, and this 
functionality is enabled by default. No explicit software configuration 
is necessary to select the desired I/O mode. The hardware will 
automatically determine the appropriate mode based on the programmed 
opcode. This current patch is only intended to communicate these 
hardware capabilities to upper layers.



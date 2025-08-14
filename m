Return-Path: <linux-spi+bounces-9403-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6645B25BEF
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 08:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8FE7B98DE
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE3244664;
	Thu, 14 Aug 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="RpxYocEr"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022124.outbound.protection.outlook.com [40.107.75.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3A24E4BD;
	Thu, 14 Aug 2025 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153545; cv=fail; b=uQl0SVQTREeyp5CUBN94E2TdVzCT/aVHjPK6/iWzYASsEYntlAaccKEKMrQKxllaXiEuiCVCFtLIpohRb7IgXFPoG9lPbrw3Zr1CoBTG5WV2NklBtDPBdHEhcbXVMYO3kfaXQsA6qFHqE4PMf8oc88WTUZIusokt0IdITt+QBmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153545; c=relaxed/simple;
	bh=rZOzvPjs4AyRxn6ucorElqQ1n53OSuBv6UChsfg3wmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aDoU2ShVEjFyWAdC0pMJ9pzVH9pv7gtzdCBAxuCsn16/69L5/yPBxxJl6OGCPHwLRMLRQXyivVPfJvu3SFKjvOvqW4TsmLzEADverJrLER9Ti3gXsmKGHzDWCFxkkqdVkEOqMmsTIQXrBEEFD60LJe8vq8T8MNeW/C2gFx0/GnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=RpxYocEr; arc=fail smtp.client-ip=40.107.75.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9rx6L6BS/d9iGeOGW7Ucj4oP8x0VNtLlJ68nQYVdn8Z9sE4H4KbfYutl3Ty9P/2YeOlS9MaPwS/D1Lw/7skV8ZzSZKswXK+ktaHHssp95OLl3Ki5NRxOCkdNXmVl23Mm/dI2JsaXnO6tIFOSCqiQQND384qUL80aIttv14V7vwxwlXHYI/4bKdcefpRgqRrdDf+Xw+WJJ5bjlJnTGrOuWttWPm8AWvBOrZysOM+7CzHFtZmllHrwayDLbQiCzgAiXZrextNuMZd7u5lsSBD9TLrzAxZ/X4DNE6QqW7RzRr9VQC47cI5lugNVXd2dTHjRL4sYSYfAQbNKfUITJ6anA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbFuXIPekPrC/EbSQaXQ3BRVLBYDVP/aRtZ6xA/zyYs=;
 b=g0NGGaDcjTxe6uDPXA81Jozyu4LS0GCFV8iB87ty/0d/R/4eK+URazj4tLaXLzqNydMBdewr3u/SIg8uOwgVXpC9L2e1csk1EeD/44od8ftHAvmskQJZpT1XepCNowgZfEndSx0NXLyzLRqDpUiZQgsfG4WLbV7ohbB97aE6+rBLyNeDREQKIBO66RJjRxcWH0I39Bnyb2sZEdpL9Fbkg1G5MjH7C1VQgsxqDidRFD0gR0cNryXr3arB4mfbJZU0DQGEf6NvfWfOgC7vrjXgRvjiZ3/+1+h1VF7JUCQPE2OuzOrtXZlGbgYmedZ73XqjUTADnSI2dWwlnUb9usowbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbFuXIPekPrC/EbSQaXQ3BRVLBYDVP/aRtZ6xA/zyYs=;
 b=RpxYocErMgLSo0A87k7RYqoSbpOV0fysL7tGLYaW+6oRkGNQ4lllM6BzFh7XGjUna6AZO/UvlTAqY5WfS3nOf0boZ9LUT/ZsJ32iLykB8QUEBz9Qh6xPdo+NseInB3PCMyMFHNoK6nv+tQW1H3YzvBo49gbRa0DToJodpMhkL7AZ+BkYmuvT2LCbJQbpeMQnPoYsGgtxXiS4ChTnV92Gmbow7vE4HRiL9Hfqci8CEm9OgYGQytaLfgpGsPMrZtWClzFCX1ZI/t+GgUkCBXMYwddaQTCcxnaV8AftDxJdtPMzsrcYsPN/xmVjhbQ3KMLFGoCD+vos1xDsF0MUtMbmfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by PS1PPF83F4A8B9F.apcprd03.prod.outlook.com (2603:1096:308::2dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 06:38:58 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 06:38:58 +0000
Message-ID: <cf825229-7294-4fc5-b7dd-09dc1198db74@amlogic.com>
Date: Thu, 14 Aug 2025 14:38:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
 <20250808-spifc-v1-1-ff4e30e26a6b@amlogic.com>
 <20250808-adamant-fat-raven-38c8b3@kuoka>
 <7fab19de-8ed1-4fe5-b2a4-a7e9c13d8424@amlogic.com>
 <5cc336bc-f071-41d2-b59a-af0df23af00b@kernel.org>
 <d872a711-7442-4e2e-bc59-0d6f4f656fde@amlogic.com>
 <017a4d15-286d-4e0a-89ff-f658009a6de6@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <017a4d15-286d-4e0a-89ff-f658009a6de6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|PS1PPF83F4A8B9F:EE_
X-MS-Office365-Filtering-Correlation-Id: e86358e8-eec6-462e-fa0c-08dddafd3f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUVTclFMWTlBUko0QXIxUG1ESHdoUVV2VHVwWkMzM09XTEFldkFYOTRqU1Jp?=
 =?utf-8?B?YUU4YjNWNUVmbGJUZVJYK0hkL2lCZW0xV094aVJ1dkd6RktkRHp6VWVPNnZa?=
 =?utf-8?B?NGtYbmxCT0tXdnBGNkUxMDhjWDZndE1yOVdEd01NOHdkbXFlbkM1UGdWM21x?=
 =?utf-8?B?cnljMUVJYVlaSGlGbVNuZm1jZEY2TTU0aVpoUmF6OUZYaWpDM1IrSnZVbytT?=
 =?utf-8?B?dU1hMUtISEU2NG05NStUb0VMUjNjNU90cFUwN1BUaG04eXZSZklCd1V5NHZZ?=
 =?utf-8?B?b2V0MFlTRnN1RDFxL0RmeVZUaG1Oekdld0dZdU9lUjR2UE5KTlRFSGlUVi9k?=
 =?utf-8?B?NlMwdnY4NE1wTUZvSGFxU2pJYVd5S3M3VGxhVkk5QWRrRXhnUEF2Nk82QmJQ?=
 =?utf-8?B?REVRdk1za2IrV0xmSlA5SGhEUm0rTlAvYkUxZ1RMWXd2Uk15QkdMazVVMVpz?=
 =?utf-8?B?TUpHZmVKck41aVg4NUVTa2plemRrTThLdnVnRXdRUFJzOTcvOStiWUU0eTdN?=
 =?utf-8?B?SUxaeFZsd3dUWnBmc21Yb1RlV0ZCbTJOVWtwdzVsWjBnYmJibjFlSmlwRTJh?=
 =?utf-8?B?WXArUzBWR3BMcDJXRDhMMEhuUzhWclVwd0FwdVc3NUxzaTk0bTlzeGZqWGVj?=
 =?utf-8?B?OTNRczNPTDd2VGhXYjAyK0Z1d2VtNDFoMllZMXZQRjliQ1JleUxNVFFDb01r?=
 =?utf-8?B?SGw1emRDQTZXbXJ5TmVWUDFNN3BHTmJVd3QyelRPVVJtNlc1NnJaNUFycHc5?=
 =?utf-8?B?bUViNElIMHphUmRpVnY5UUNIdC85L1dXb3lRR0UvZVgyWVRTbDc2UlN2UXRt?=
 =?utf-8?B?ekE4RVdFcmU4OE1uTHlzSENzUis5RXVaUEZHYnRaakdHZEh6WVJwRjQrVUJ2?=
 =?utf-8?B?dDl3cnJzdUIwcVJybGQ5SHkzLzFuYkZJUGJyMDYxeVlrbFowUlN2cUxCTWpB?=
 =?utf-8?B?TlpCU1F2Mk00dE9nblZKMjljYU9aUlFOUUc0SVZVaGNGeWhLTkVPYTNxTzNT?=
 =?utf-8?B?cmt4RTlYVlppVVdRcWw0cXU4WUdwR29UdlZBcUZnVnA3TmhZYkRnS1hwdlRL?=
 =?utf-8?B?WGx4eXVrODJhQ0hwN1NGWWVsb1RnNktHUHRkaVhaeEhCRWJxZnJEaFNpY2ps?=
 =?utf-8?B?U1RVdVA1L3M5bDNnMDU0WFVTOVNublJBSWh6dE9zUk9YTitTQitwRktXc3Vk?=
 =?utf-8?B?MEV6eGwwTGxYSjVnZTQycERsMTFhdGd2OWtTTHBSY2hpU1IyeWYyMEQrYzFB?=
 =?utf-8?B?UHhqaE9uQmRXRm9OYnZvSDJsVE41OEFXdHVubUUyS0dpdWJhVGRhekhLazIr?=
 =?utf-8?B?ZmE1OEJ1dFhtcHBDMHl2bDRPTGJ5TmJRTjlRZk5pTzNnR1I5YlhIU01xa2ZJ?=
 =?utf-8?B?cm5rWXB4djFxL1h5bDgwSmdsWVUyTnFvOUU3MUg5SWlqZzdMZm41S2thdGw1?=
 =?utf-8?B?UWI3aS9FTjZ1eFRsS3l4ZXFYb3ZKOTNMMGF6S3ZoQmFBMERPQXJJRTQwQnhs?=
 =?utf-8?B?TTFjSG1GZ0doajduSmxsM1NTR0duT1d3UlBoM0Z0ZWpvVkkyM3ltU28zMDRz?=
 =?utf-8?B?TjNITVFTZjhISFgvVWRmWTFrZGduZCs5anI3ckxJTVlqK0wrM2lLaHJsdEx5?=
 =?utf-8?B?a1dSeUVqUlR0VHQrQUUzUlY3Vmw5c2dUYmU0S3NXaWFvN3huMys3Z0l3aHQy?=
 =?utf-8?B?Rk05M3RTVC9kTS9Cd1g4MVMzV1dDenBVbDRyemZyckNGSHplTmNtQnl0SHY5?=
 =?utf-8?B?V0t5c09nNUZxWEtHcGpmUXlCNEw3VmZQQUo0bDZGc2pzS0phZEs0dUNuNy9v?=
 =?utf-8?B?U0VMaXErNW9UUmJ4ckhvMk45R3RSYm1sMTI4YzlMUDlGV0N0Z0tjTXc2ZWlS?=
 =?utf-8?B?ZjFBTFBtSm1la1FtTzQwanVDZmtQZGZnWmIzYWZDRTlWOHo0YlF0VWFyV2hY?=
 =?utf-8?Q?qJZT7wEDHiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGVZaSsxcm9iZ0JzS0xMZjBGdTlOTnBzUzUwTXFiekRmeVdQbHpPSmhTS0Jp?=
 =?utf-8?B?TlllSHhPNVdNSk1Nc3gwWkIxdG93dXN1SU11V2ZwcHYxYzNRR01ROFF4UU1m?=
 =?utf-8?B?VXc3OUV4Uk1Dem4vSWVBb2I1Ly92SjFSemt2YXpIa0x3alRNbENKZzNVVE1G?=
 =?utf-8?B?bkVrOEZPT1ZzWTZFL2Q3R1JVVGUvbXVWYUd2OUx0eVlJMTQwclhBZm9MZkJK?=
 =?utf-8?B?djlUSmV6emxGNWhPNkFsZTcyNi9hSkZ2WHF3dm1oVW4vR24zL1dDcFJmYXBX?=
 =?utf-8?B?RnBNSlFwa3J1V0NPMUVoL3FQdXB3WG9JMEZhRmMxbG95cVZqZ1JTS0toWXRj?=
 =?utf-8?B?YmUzMExKaWpPbGZKUU5KSmp5aVhZRDFqTm9QeHlhMFNhOW53Q0FQWW91NHl6?=
 =?utf-8?B?WWs2Y2pTSnoxVkJha1gxSUtHN3ZjRWZ0TFJ1dDVodkQvMUNVNE1wQnA2WDdI?=
 =?utf-8?B?dHB5MzJxQjVsTlRueWpHU3Z4VG5WMjVJalp1US93aWhNaTlESWliSmdrWk5r?=
 =?utf-8?B?c3pPV2tYSzRpL09wQWRveXdyV2t6Q1NQQ3ZHUG1CWkxTNnliYnN6RjgxRDVz?=
 =?utf-8?B?ZFZHZnNHK3B2RXJpT09HNEUveENIVllMbkwrL2t6RWJSOEdRVVZGbnFQYldu?=
 =?utf-8?B?cFgzdk1lNVNZdjMxVmJqNGhGRzE4N3dROGRpTHY4Sk5rbURoM0FNUktGVUUz?=
 =?utf-8?B?ckVCd3ozS21BdTJ6dVlGZjk4RkhhdXlXbFl2Yk1FZDRpZ2Z3UHArd2Zsb1FL?=
 =?utf-8?B?SVRBK2ZZd0U5OHFvOE5OT3NxalVFQUwzSUY5UnpPMnBCLzIya3dWb3VSbmVt?=
 =?utf-8?B?bVFBdUxPdmVtQUZ4aFBwME15V0xwb3g1RFNBelk0UFNoL3NRSkc4NTAvdHNu?=
 =?utf-8?B?d0svR2RYUTJ5akJxKzdEcGJVY2x3c0FkM1NCZExZL0JGOWVVaXZJOHh6eEJW?=
 =?utf-8?B?WFgrd2R2TEVoZ2NkQkJxNDlpZ2tHUW9aY1dFSGQ4aXo0cEZLY08wOFpWOHgv?=
 =?utf-8?B?MjRpRS96dFlzdVRFSUlKV0xHK3NtOTNuNFF2S3ZuZEloeEhER1A1WDZhYzk1?=
 =?utf-8?B?ZEMvaDIrbGtRbGVwcmV0U2JOR1VrSXRQeFdtb1VTZEZ6amZIYkJOYkxKbDYz?=
 =?utf-8?B?Mi9oS3ZiVTF5R3pFWUFRY21WQlpzdjFJQzdjSTY1SXFOcTY1eittcVJWakxh?=
 =?utf-8?B?aldUVkhLOWk0Y3UyajBBbDBpbndCWjVQQWNyampydTlCQVhhNjRzZWVqNjZM?=
 =?utf-8?B?cXFXWXgzTndoS3YvWkZpQ3lLY3A1azBwWXhvL1ZWR1J6UHZzb3llQW9OcUZG?=
 =?utf-8?B?WWhMY20ySjYvM0RsY3diSTJDZkZvNEg4S2tBUGx4ZC9NcmVZMjQ0ZUlxTjBy?=
 =?utf-8?B?VXMwN3p2MVJUQjY3ZFVIQkI2SjBoZWUxUFB6SVI5MzJQZE9RQzNYT0Vxc1J1?=
 =?utf-8?B?UXE3UmNVeTZmVm1jY01yMjhPS2FDU0tXU2lib0lRc3ZpRFNhV1MvdUlmME9W?=
 =?utf-8?B?S0VUa1Q0M25QSVFvNGpEbTh5MUdTNUltZXFSMWtEVXZmZE9OdWR4Q1R1ZmFs?=
 =?utf-8?B?cW9UVG9EL0RHVXFmUDBzNzhZQWpPKzRMa1p2emVpZGpUbmNLTXRxSldoeHFH?=
 =?utf-8?B?MUVCaENDTXQrWUt3akh2aXVWa0NJOUlCeHdiWmw1ekhxblpCUWNSRUxYVXU2?=
 =?utf-8?B?ZHUrZm96NFUxQXVTUkc2Tld1NStycldacWNZZEtTOWFqVEdIT2VIVTU2a2VH?=
 =?utf-8?B?ZFQ1R3dGUStDTFNENHVsb09GMHdhY25wRWxlaTVSV2k3eXFESkltbzVJSklw?=
 =?utf-8?B?U3FmdHdRMUlhbEx2M0VPejFMbDhuM1hvOEZ0d3V5c2lwNVZFcS8veVRpcnpz?=
 =?utf-8?B?anpOODdQWUpYVmYrY0h6M1dJbWVCWWcxM0wzUUwyQzVMYkF6SWdoRjdLSVFp?=
 =?utf-8?B?YUFuemt3SUVkN0tjdHFHM0dhMmNEVFJZa0ludDJ5dkQ3ZVpHcWk1a0FYdk5X?=
 =?utf-8?B?K1A5WkV5bC9uRldnd2RjMkQya29rOFY5amd5VWpSQ0lwSElXSmRxMHF6b0tZ?=
 =?utf-8?B?bDJEUHhGM1BjZlF5RkhnSHo2UFdxNVBmQnIycHZBbHR3SlFudy9HMkVmWXNz?=
 =?utf-8?B?N1FhR0tYQjQvZHpQRjNZLzErVVJUQWRFSVZWK2paVHpIdk1iMmNhTnJvZkxZ?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86358e8-eec6-462e-fa0c-08dddafd3f8e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 06:38:58.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZuaPZg8XK9dPk0JSkFsfuZ3uBm1s6vGsi8dfLodKML2UOZinq5bpcAlxSv6ycm+jmQObDnpIlJgVfis/Ep+wnE5H+oRYsmNXjwGGGSHDco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF83F4A8B9F

Hi Krzysztof,
    Thanks for your reply.

On 2025/8/14 00:19, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 13/08/2025 11:34, Xianwei Zhao wrote:
>> Hi Krzysztof,
>>      Thanks  for your reply.
>>
>> On 2025/8/13 15:36, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 13/08/2025 08:13, Xianwei Zhao wrote:
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: amlogic,a4-spifc
>>>>>> +
>>>>>> +  reg:
>>>>>> +    items:
>>>>>> +      - description: core registers
>>>>>> +      - description: parent clk control registers
>>>>>
>>>>> Why are you poking to parent node or to clock registers? This looks like
>>>>> mixing up device address spaces.
>>>>>
>>>>
>>>> The SPIFC bus clock multiplexes EMMC modules, so the corresponding
>>>> frequency division register is also in EMMC module. The SPIFC and the
>>>> EMMC modules cannot be used simultaneously.
>>>
>>> Then obviously you cannot put here EMMC or parent registers.
>>>
>>> It looks really like you miss proper hardware representation.
>>>
>>
>> It does seem a bit unusual. However, in our hardware design, EMMC and
>> SFC modules are integrated, and they share common resources such as the
>> clock and I/O pins .They are mutually exclusive.
>>
> 
> How did you express it in DT? This looks similar to serial engines and
> such are not implemented independently.
> 

The hardware design provides this clock for both modules — EMMC and 
SPIFC. A control bit (bit 31: Cfg_NAND, where 0 = Port C only, 1 = NAND) 
is used to determine which module uses the clock.

It's not that NAND is using EMMC’s resources; rather, the configuration 
register controlling this selection is located within the EMMC module, 
which makes the setup appear somewhat unusual.

In the device tree (DT), I'll just refer directly to the clock frequency 
division control register.

If I don't describe it here, then when SPIFC needs to operate, EMMC will 
  be disabled. In that case, I won’t be able to access the corresponding 
clock division setting, which means SPIFC won't be able to function either.

>> Here, I'll modify the register description. Do you think it's feasible
> 
> No, because it changes nothing... Clock provider pokes clock divider
> registers. Not clock consumer.
> 
> Best regards,
> Krzysztof


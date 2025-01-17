Return-Path: <linux-spi+bounces-6391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9258DA14A04
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 08:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02D8169644
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jan 2025 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272AA1F866D;
	Fri, 17 Jan 2025 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BfjIRx78"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7E1F8665;
	Fri, 17 Jan 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098088; cv=fail; b=nU/a8tBXw955wTcZcvdeRmHavOKJFGGeOSq9U5Hdr+Unep3Ite/kfwswuBie2GOA1TqXZXLRwaVFi8rVDDm9woqFZ0UM2NnJbHkWdX2e219DZlrT39qT0EhBe6LkVivcyYudo9m3W9Y37aryNyO9M+8fdVA6sBm/J7CzN+CekUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098088; c=relaxed/simple;
	bh=N5YpbHoAui7Ax3Z9lHB4pqD9MJMYXtJJ1FSW0ExaHdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FiJ5hF7hsa0dK1uNpUww2E27Re+PJ2A5SZCxIuWVBe9xqlMYeRCcBtRW1uowyThSL3/joByxKMlRGFTQ+iMxzrMX7lNztj/dkFQYe02VKWYVKfeJOP56FCqTWGs6TY6twpsnaYnu8qxH2MA2NnNkVn64ty9ALO4ZzT+/yQPQAc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BfjIRx78; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Couq83qKWwxDQGhhaSa6SJ9gC94g41vlx/SY4uAgL1XELjyJnSosYDV2r73XwIxPasuoKH/P1goVmzVkLvLF54/JXq6WkMjMNVvLf87CwgFnLn7YxAbqvQWMd8bKpwmcyJJsFBX8n33lc60IHYerjTFriFrXx7LQPTK32AuWKEZp1WRwsGipa/Fns+kcPaznYIURcSEUqJf5Sf/SAwD+ioJBCfTLKD12q3MLxpte1yYbpGyBqdAlf59T4tvR74CFkmpDR8RWnM/VNc0FfvldHHU0tCoANaKKYci6/Dt5RiVlZ3sLBUFgL6oFDpvifxbjeiM5isnANpqdESxcLmzwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9CpeCjd7QJMD2VboOG43N3WTvGtbew2985klMXvdlY=;
 b=cv+EZ2XFIbad23hyTfnBVSbT3Mc6g0sFILYbxcsJL7l/TtyMh40J+kfYRyUIHxFTKDoMAmN2uyaJy8WnnXah67Y7uDtZxsnQtZiJFVZnTRg9ZI0pfUaSRPMN5d+R/7n9VAGsq8NC2VEKrX63Dp2rsRJvzbZREdvq2n6G5AlbDctoQmISEKTKxaeX69oZuEr9ggvM1jpZVfV8wO+mT8jaqMOiQqoB16SET9IVzuyymGMY9tZ4lB/Kws5628EMLyI1Sj0Lo6NumZBr2f31fdk5Kc+9o6DwfG/rfBnuDmKoeIftIE3k7+MavR7P6mvNQkEugyhnPIv+YeW/r0JlFzGSHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9CpeCjd7QJMD2VboOG43N3WTvGtbew2985klMXvdlY=;
 b=BfjIRx78gpCQBcOJyomJ3PmTS83sYr38HBYVfaau8SYiV+veaS2GJEa9OT2/Vd6XYERS1LsHHXdw5HgTw9ZhoC+1N04CHuxrCDaz8+9MrPmkTus2EsUtU78RHOEeTgMm208ILSeNcwRnTnJ5zRW4m6p3NHDL0BpPElJA3ar0O80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 07:14:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 07:14:44 +0000
Message-ID: <8a0d8789-7a0d-42b7-9aff-e867c14db3c9@amd.com>
Date: Fri, 17 Jan 2025 08:14:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: spi: zynqmp-qspi: Add reset
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <20250116225521.2688224-2-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250116225521.2688224-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0275.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 87030254-c3d8-49c5-b4bf-08dd36c69e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWd0TnZkbHJJQ2g0eFAvbzFJb2Mwd0pmT1BQT0V2QkpIZGRUK2JyR0dML2tz?=
 =?utf-8?B?S3pWaEVGa1ZoMS94bVJsdWhHQndXYUcvRllLM29vaW5NZXlWYkJNT3NZTUh3?=
 =?utf-8?B?aXFtNzNKdXREMU5PSzZLT2dwdFRMTFhmREo4aTFsdE5zTHN1OHhheHVGNlBG?=
 =?utf-8?B?cGxZQ21ZNTRyWjJYV3A4T2s5eWszc2Zzanc1WllyRDdRL3lDZUI5WXhRbS90?=
 =?utf-8?B?UXBkR2liWHpBOVVxakcyS21kc0hrTzVBR21VcjV1SU9rYTFkbHVkTlF0VG1m?=
 =?utf-8?B?aVV0blB3MElKbEJjdVBlRHpQb2RvdGM4ekkzWVR4cysvL2M0TnhwOTZ5Szlj?=
 =?utf-8?B?aFZORm5PbkNpeDR3bWcxQlFDUGVZWmZ0YWhDVVl6TElyQzdwekUxbWN2Slpz?=
 =?utf-8?B?bkM1M3dVZHF1UllHU3dVV20vSUtLQWozK3RNbXljbkZzNGpPdVg1MncrcWF4?=
 =?utf-8?B?RkNRWVBldWk4R2ZXNWRZanBlVHc4MkdXcTV3OEJoVWhPbnBLK2JJaFgwR2dP?=
 =?utf-8?B?UmhYUEFEWktzMUJQU2R3RjdKS2piM3FTb2lyMEQvdkxtcmw2S1FFU2RiYUhY?=
 =?utf-8?B?b05XdkxLVlBVWkFWQTlvbmtqelhESlo3MDhLVHZzbEUwOEtNOC9HK0prOXpO?=
 =?utf-8?B?SlFPUFNFTFhOeXJaaUxUdUFoWS9kTlZiRmpCUUVJQXZ0bUxCNmZpd2tyV3BP?=
 =?utf-8?B?SjBBVENyVzdZdlVITkJqakgrR1h5MHV5eFJYbUszRkR1UXpTck4yWW1ZMmJr?=
 =?utf-8?B?dE40cFVsRm8rcHlmbDFKQ3FBcHp1dE52RUo1a2xPZk9TcmFGM0dMSGhnOE5s?=
 =?utf-8?B?REViZ3pFdkg0cS8vS2gxaGwzRnFSSGM5MlVRSk5xYVhxamM4YVhZTGVoU0RU?=
 =?utf-8?B?MmVGanhpazkvMjhvUTBWMElwQzBuK21PRDgwWmJIemJDa1Zpb0pvUUZMTkJ3?=
 =?utf-8?B?dWFISElYZGZ0NlRFRHZOY1hCQllNVnMwbmxtSlgvcFF0eGVRdXA4eHYvS0FL?=
 =?utf-8?B?K2RzcHQxbHZaR0pRUVFONTZKWkQrSGlvOHVZS2lVS0YzLzhJczI1a2h0eTNh?=
 =?utf-8?B?UWxoUndGMUxVSmtOdkk0RGJKSGJFcDRKVlNJZjlNWjhBTUdjVy9TQ0d6T29C?=
 =?utf-8?B?K0NqaUE5S2pNRGtBUlFjRUoxdkJxNjBOeHczRkpQMG5GczBhQzNGRmxDTFZB?=
 =?utf-8?B?YjYrcU5CVlFMZU45ZmM1OXhEU291V1hXYzlLSzlLQ3dteFZXa2pqRXdOZjBH?=
 =?utf-8?B?aERXRnFBcmgyZGVTQ0VzbTgvTk1yVk5SSUU1UVB0Mkkyc29xd3JUSEx1aGRM?=
 =?utf-8?B?SG9UNnRvQ0V4MWRtWGNseWpoK2JHMnQ4UitabkhPMklsSkkyNUgxazhuV3Zk?=
 =?utf-8?B?STdaR2tta05xbDB1bklyRzlTSWFiTnhnWXk1THgzLzZUcGFocWN5Z0JIaXFj?=
 =?utf-8?B?MjlLQk50OTdMMmtOcGpySS93bFhMVG94bzlUdzJxZU9KczhzOFNLU0hudWJn?=
 =?utf-8?B?aGJ1R3Uvd0JGTmdmdmp2bnhYWUNyUHJlY05TQlJHM20wUTluRUJObFZEVHVu?=
 =?utf-8?B?UDU4M1U0cXh0djFocWd2TVZuQU5VcitLOExhUWpDdlJtSjcvTXVhaDgwZHVm?=
 =?utf-8?B?SEZnaElGekNOYU5hY3ZkSCswRGlIUDhIeXlLMEFJZWNjSzczd1BaY3N2WG5h?=
 =?utf-8?B?RFhaSVducjBGWXZ2OE05NFRSMWZlbUtUVU9jQkdFdFBoeGUyRnROUm1MOU5n?=
 =?utf-8?B?bnFlRzB5WFdROFRZb0RlRUdkN0V6Sm83Z1JyNHdiRWpGQVcrQ0hEYlV5aHdt?=
 =?utf-8?B?ZXczNnVERlZFaC9LUFJ2N01YVnprbktPSEtoc0VJZ0NSNHhUNXRNZEJxZjJr?=
 =?utf-8?Q?NV6rp3l5JY9rQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmRTUm1jNW1WSnMvMHFkM1QvY0wwUVB6em5zT2hHeFNwWjE1VVhSM3lkSUZF?=
 =?utf-8?B?Wnh4aWNJWkxranJxYjNMVjcrYlpWSlhjempRbzlaempUWk9kZEpSTTNmc3E0?=
 =?utf-8?B?OG91VmgxSkhyc3FJTUlTN2pxeFk5Q3hJbERZTTJJa0FwWVh2SVhYUnNTQlEx?=
 =?utf-8?B?WXpoR2xJZUtBU1Mva1NFbFI1MGdHcFhuNWlHQklNbExlZFRCaWZPZVFBeWQ5?=
 =?utf-8?B?eWlweXZrRDAwbXVoMklFZmx3R1F5WkxJWjJ4bStySkhMMlVRci9LcythQVNm?=
 =?utf-8?B?WnFFUVFrRUh1cDVHVjBuQmUwQ2J5NlNvdGNEQkJsQzRkcEZWOW10VUlLbWNx?=
 =?utf-8?B?Y2szcDk0UWp5eEFKMFJiMEZXUTQvS3gzLzhOdG5SZ3k0aGFhWVRPU3NXK1BD?=
 =?utf-8?B?dzQrc1VZTDRxOW1XR3JGVVJlbHE3MGNrOG1pMDNvamdVcktYR3o3NE5Idjhz?=
 =?utf-8?B?RmI3WVhZY01mZEVmZksxMUtmc3RRcm56UHp1UkNLaGY2WXBZbzBsNDhHY3Vh?=
 =?utf-8?B?aGdiU0J3bGNuWE9LdXZLcHdWdVYreUMwSUNaWXJDSGJHK2VZNnprTWUyenpQ?=
 =?utf-8?B?SFFkUDA0Z0c0WTIyWTNGVnRnblVUUjJkRXltZW8vVlZkeVVLNFl2aUdZWnF1?=
 =?utf-8?B?ZTFqMlRjMTRmWXc2c3Z4clNwLzZwZEgvcWdFUVF0Z2NOcHFDaFdVbnRZY3Bi?=
 =?utf-8?B?RVlETXRsbUlqSlFwUzhrV3ZDbGtxd1Z1bkx0c21UcGllRi9JOHZlbjNESzlL?=
 =?utf-8?B?aGdOU3pYYnpVUlZsM1ZKWUpRditjNnVvU2ZSdUNyaU1QYzlJd2ljK0dJWm9M?=
 =?utf-8?B?Sk1lWW0xWTVvYVVsZUEyOEZwMUZnd2lPRCt6RU1yZmJmaURPQkxzSXM0bVFw?=
 =?utf-8?B?Z3VSNFZ0SWZyT2pCNEdDVG5mY3J6ZUVlZkZxdXNreUt2akt5dWhLTU43RDJP?=
 =?utf-8?B?clBMWSs2d2lPNkcxU0pYUWNHZmR0WTR4M01qRm9XSHZwOE16SmtQak15RWR4?=
 =?utf-8?B?dnlNMG1wejViV0YxMCt5ejNONXhlQ2pxb3JrcVl1aGVkRjJjdk9KWjdhTTdr?=
 =?utf-8?B?VHdCZ1RtVW95RUVXbXlzRVdiTXM2UXIveXhlQTFyNWFUNVV4UzM3RzlrL2tu?=
 =?utf-8?B?c1VzTDZvSmxBMm02MncycEUrNlIrSVEvSmE3MThpTjNxOStlUWovT2piaVJO?=
 =?utf-8?B?TG8yYlJjTUk4b0c1OFRxRjl0dm9xbTNlQ0RGZEJteGpRcGo1QjZGSkFTWmNZ?=
 =?utf-8?B?R1ZJZE9aQmxQMXVQakNsdDRZanNnVnhHVmNwdDR3NXRQMDliZ25nOW1NWW8w?=
 =?utf-8?B?RmZDUHJ0UzRjOWJYb0piQTNURVlSQ2RsNHVCdHFYOWh6eTNYQ25ENm9QTUpW?=
 =?utf-8?B?MWRGbjhreWwzRElMQURmdys4bVlOcmF3a1hLWi8vOG9oTWYvRGJWa096TnhD?=
 =?utf-8?B?bG11MFM5S212ZGN5K1NYeE1MMXNxMStObHFLV0ZsT2FrUTN6cFdqWkFJWlNx?=
 =?utf-8?B?Rmx5RkRTMWMvT3AzMVRXcm0wQ1hBa00rVmovN3AzN3ZPVDlvWFVmOVVyZnpQ?=
 =?utf-8?B?RGlnZGx1SnE1VFF1WFA2VW4wYVJlSzROQVhqVnp3K0Q0c2dCMDRrcGV6NEVH?=
 =?utf-8?B?MmtGRkJ2MWR2M2dETUxmbVFDQTJaK3BuZHFINnU1dnA3SnJTL3l2R0d2cFBT?=
 =?utf-8?B?RXVnRlh3ODFacVlHSWxNNWh2emJDNUtaSk9WTXFoM1NNSDRkNlQ2NzBBeEEv?=
 =?utf-8?B?ZnBrUE5ycmdqRDdWVTZlKy9vdzhUbm5yRzNGZFZGbkcwbERKTG5xRTV2S0JL?=
 =?utf-8?B?UGkzV1NwdTRlWkdhN1FXSXpjQkNZaTdZZEZVNS82dHFaVXJjMHl3QVhyS3o5?=
 =?utf-8?B?bkRTQlRhcHl0L2gxbWtxNXJ0blhaSFZjQzIzeUhHVU9lQ1RrQUsvdnowT25H?=
 =?utf-8?B?S2JzaUpjTEQ5cXpzVHFvTGlTMVgrVG1oK0dqU0pIOGlDYzM4bXVOWENYdTlS?=
 =?utf-8?B?dm5Gbk5sZGtEUkk1L2ZXdWJLM3RBSVlIT3BiNkFVVVB5REltMUljcDNzVStF?=
 =?utf-8?B?cHJ2eVg2aUhjT1NrRlc3NmFSUDVZYVlGeVhjSUN6Q1hlWDM0akhuZWYxT0J3?=
 =?utf-8?Q?ZIfwzDfBwGR4JW6gD4a7KH93T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87030254-c3d8-49c5-b4bf-08dd36c69e27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:14:44.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDaGytexu4m00pVArNDd6rO5Wic4Eqd/e40gJ11a6QNipCDdDKNwcJFE2HDcgB+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296



On 1/16/25 23:55, Sean Anderson wrote:
> Add a reset to help recover from cancelled operations.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index 04d4d3b4916d..901e15fcce2d 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> @@ -36,12 +36,16 @@ properties:
>     power-domains:
>       maxItems: 1
>   
> +  resets:
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg
>     - interrupts
>     - clock-names
>     - clocks
> +  - resets

In 2/5 you are calling devm_reset_control_get_optional_exclusive() that's why I 
expect reset is not really required property.

M


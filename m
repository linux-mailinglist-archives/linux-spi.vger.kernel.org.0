Return-Path: <linux-spi+bounces-7015-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7939A4D7A8
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 10:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080163AA369
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 09:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A31FC115;
	Tue,  4 Mar 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="YoQAjh6D"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2092.outbound.protection.outlook.com [40.92.90.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A51F583F;
	Tue,  4 Mar 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079661; cv=fail; b=SDPnlebjeEwo6WFD3VM5U4lZdZvnQMuCqes/WhtAQD5f6poVWLy1UZOvyvTP3xRUqm+J4WirMY1Ly7bHRqy/MfmBnqjaJSdGSNXHGUEo5YwuJexWK9aTJ2J6+cjiWR+j5qJUXBta/NdaAIex/s3aCz+1MalPOlpFeO/gbyevw4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079661; c=relaxed/simple;
	bh=fHjblc3hA+V3eQRk9Q8pyLqaSEu4nsfZjRkhpzwJ2jw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJM4TZ+3HTROJPiGhZ5ZN1CFQ+y+4FJpvtxak231vrIP21YbOTfU49ZQkz4kG83/YL3vtBH2fjOj4TLI7Yy1XoWipFzETjJ8ob8MtAdWIE6LWZY/McDFuFQ87wzC7DsCTqp7xZcjg3QFXYLUtyurpufOvsvEPAXxQJVTwaqfSMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=YoQAjh6D; arc=fail smtp.client-ip=40.92.90.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gulnPnD8x3x1SYULjxj8ptD8uI6ynVoPoqCmKEq+98w2LBmeQf4HXCR2gq7B7vD2jPua5nddLs/vc4+ifFEwWOR9UFcd0rvVfMVw7t2ltKAr3DDm3OtX21SbmwPi6qIuDyJrXF45TK+ElYQC+PVTB0/inGc9ISHxrtX56Daax3J4dpWARCw5ts8WO4wXoBfTJZyh99Zpf+XnUbxB05RSRoRuc9ScBd4B75PFJw/WHjYHUWePaA6gEXLz0JjgG3XQeNjwvoNVwaFFtu/q9qKXJFuzxf9gSypzy0qpYWeXx/pL462+a+JknPSNT8mlHoPiThfTSlzyAFYk2KxK71gOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CON3xMIzZ1I73D8GqeQIcQeOC6esXQUwHkXve8c5Bg=;
 b=LPXXR3xhOUVXVkPZrg4XwYcXpio7f4gAvOTklfTo705E+/aqSiL0iIpHjzuohNqdCSNE7ydJbafltRHKLu/OG/kDWmcAVqPUNMzmiNAl4rdXC+2O4VcZyU7RWYPC+lkzPBHQlg7TTTZBu5v/W3/B5XniX+ll2UoALFbHggfLdc4FWp1d4IH9GLKethv90bqHN34ZKseTYoeWze4zRGrK6asw6nISbWKJLqsCbX5vNxC1zdMYzhf8sZyxMDOJM4B7KssYsMCl+rJAAREqsbYJzd77UCCDXEbsah55DArBhS+IqvGEklZEL3xZ4dOhvH0yImMQnUC/7IY9ALL9szI38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CON3xMIzZ1I73D8GqeQIcQeOC6esXQUwHkXve8c5Bg=;
 b=YoQAjh6DpNQVHMqPe0Rrg75MZLy+xs24159t97AtBqJJ2uOOLyD8SbSfebpqB8LSWv5AmrLaxCklhzVp4QWh7fcfDgrmYfzVEYz5FGUXKA6jL+WZd9mvVpkRB4CpVU1xL9a8BjuoGrhCwDYuQjcz3ZiNhbJPNuVUIsyP3I1pCz9n/Ojsamr/Nqjc+Nx7vFSEWtOqwJC/gd4r1ynO9+SWIBqGefqBd16S8/kSnjdWAOWJdu+PFM3zfNbU2rLMtVixF/PLHAT5+eIGCBvCf9hRaOTkgL+WQamc7yO7yiQ8D0hkcp7iW8+qIjEAFzlpsFPkX+7uXZNwEUcrEFNagoAsqw==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by AS8P189MB2095.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:527::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Tue, 4 Mar
 2025 09:14:16 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%2]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 09:14:15 +0000
Message-ID:
 <AM7P189MB100970D57C974DD7CC5DB156E3C82@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Tue, 4 Mar 2025 10:14:14 +0100
User-Agent: Mozilla Thunderbird
From: Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v2 2/2] spi: sophgo: add SG2044 SPI NOR controller driver
To: Longbin Li <looong.bin@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev
References: <20250304083548.10101-1-looong.bin@gmail.com>
 <20250304083548.10101-3-looong.bin@gmail.com>
Content-Language: en-US
In-Reply-To: <20250304083548.10101-3-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:208:14::43) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <952fad9d-e138-4a0b-8879-3a70239f9233@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|AS8P189MB2095:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a292060-70b4-42d9-b687-08dd5afcef3f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|15080799006|19110799003|8060799006|461199028|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxJTmhUQ0IrdmVCRXBtMG1rYmlObHZsSmgxUGtJcjdHOUVyZEpCNDJWQ2t1?=
 =?utf-8?B?NmFDQ0NLQUoxQkFXNEViQVEvYTkxemNvaGVKaXRqUzFEQTc0Z1hDbk9QZytL?=
 =?utf-8?B?bXFjdS8vN1NYNkhLVzkvdXVlci9qZUE4L0FjRlhCbnM0WU9abmJuVU9TSE9Y?=
 =?utf-8?B?TGtpVW5Lc05KRW9MVURFeEovNEQrUWt1Vm5BeFJGUzRIQm0xNWVGMStLcGVP?=
 =?utf-8?B?Q1ZpSXl6T0piR3FwZXlIVlRIMTZqd1Bmcy9wUm04Yk90RFNzNUY4OEU1aUhE?=
 =?utf-8?B?TlJhNlhGajR5WkZZTWxLL1Z4NzIxV1lsVS9NWHdNSThsR1lGSldIeE1vclJU?=
 =?utf-8?B?Tld6NkdhUHBCMzloYzVtS3BIWEFORy9wWVlscEdWUEd3SmtDdU5KbjJDNlJ2?=
 =?utf-8?B?RjFvc3RVQ0xIOEVoNDYwbER6ZERucVJtM25Hd1AzQ0lUdVFKM3hXeVZRTDB6?=
 =?utf-8?B?eDZyOE9qZ2lWWlpWSXRFVzhqRHZXU0dOclF0eGRNWWc5Q3ZCc2ZaSU5Gb00y?=
 =?utf-8?B?KzM5OCttYis2Q0JxWlBJTDNxMVNIT3VDamZIZHgvMkxYWlpaVi9rYVg0Uitt?=
 =?utf-8?B?M2RYY3pMT0NKVm5ySE9HQ3RyRThLVmFLWDFnVHNjejZPQUQxY2UrT3lBa3lD?=
 =?utf-8?B?WVB2NFpUY2pRd21DTXdCWjcrWVgvYVdEclBMUGhNeXk1R2podXpabmVNMDIy?=
 =?utf-8?B?UUVaanlPMjQzaDNISnhsd0poaHJsRXJqQlpGb2IyT1o3bC9zRnFRVE04WE85?=
 =?utf-8?B?ZnNsbWZwR1BQNHMvN2dWTW1ZazAwZXJjK2F0MXAyRFZTMnhTd1R1V0ttdzJz?=
 =?utf-8?B?VHpyVTQzb3V6WGttcVQyR0xXYjZ5WGNjYjRkbjFBcGdZb1BiKzNvOS94Wmhm?=
 =?utf-8?B?VkJWTmgxb0JZOGtSV3VGakZSR0hVZmpMK2YrbnJXNlVjZUVSeVZBQVNzN1lY?=
 =?utf-8?B?OXpJTDRGNkV3ZzdTNjFPS3FER1EwYzZUVFpaMXNlRzF1cUcyaGdzWmF5cDF5?=
 =?utf-8?B?SGpzZDhWdVRubXRndHI3OGJTUDd5VzAvYnByZEdRVnNrZnFkc0R6WDJXaFZu?=
 =?utf-8?B?MjFBdUtvWmgwS2FsNVN0VE9VNUlLL29ycXpMbFpwVG1sakFSNnhlcHJPUzlj?=
 =?utf-8?B?bGQxSFh3Zmc1SjNxZjM3TExyNDduZ21vNFZNYkpnek5YbC8zdEl3bllKSVdY?=
 =?utf-8?B?eGkzdWN5MHpuUFFlcHIxT3FUZ1BZajFBUm9pTmhRRVYzbGFLWE9SaU5kRGRI?=
 =?utf-8?B?dTZucHpZenFaeDlrUGQ5dm1hdmU5Tnc2d0lKMmJQaEd1L04rRkJuMG1Qcm1h?=
 =?utf-8?B?aXRxcVFQbmpmWjNkaDNwV29ZVmZGK1FtWFcxbnFLUVh3SUFYQlVlcFF4bW4y?=
 =?utf-8?B?VU00M0JOUlVyeHZ1eSt1OG44anltek9jcUVDZ0dKQnZlaERFRzd0djFCdExj?=
 =?utf-8?B?SjlieEl6Y0hiQnJXZVNmaVFyYWozaSthR1ZJZlpjSVlwUmt0TWRzVXR4MkRB?=
 =?utf-8?Q?2R7jv4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE5xVUs5dk4rM2F6TnQxYVZOR0FzRHZMNGRlVzRlWHB4RktTdU5wdHhhMTJR?=
 =?utf-8?B?Y05NYmhKUDUxSmNHbk8yWDQ1eTZjSnNzOTAwekpRc3drQU5xL284TDR0V0Z2?=
 =?utf-8?B?MU1lZk1HVmhxeDl3SzhReDB6azhvK002M2N5MXp2VmJweGV3SGJwMXZwTEU3?=
 =?utf-8?B?TFpMdmVZZVVvcmpmNkxTVGZjR2pFOGcyc0pmN2ZoK1FDdERyaHdpeklYY1Ji?=
 =?utf-8?B?WElqUlBBWERBL2hWRlB0N0dVUkdjbFFvNGdjTXB2OE1Rei9mMXc5REhvZ1NF?=
 =?utf-8?B?dEpPcm1zVXJPc29oQzJOVzhETnFTYWJtU011VGY2b0xwSXNVYmRYUC8wVTVD?=
 =?utf-8?B?ZzV6TVVKbmFNOTB1eEUzYzlRdHk1MkZFZUtEVm8yMGxKSXZUNzBzQ3d0STAv?=
 =?utf-8?B?VmlpYWhXOVQwU3RkSWxidzhYYW0vOTNRYXI0dWZ1V0ZyVXV1YXJVUFNLdy82?=
 =?utf-8?B?MWREeXpBN2gzVGxzTnFaNlVmdFgzZTNNeHpYdFk4SEF6RVlEMCtoYW5VK0hW?=
 =?utf-8?B?cElJWnQveWdVVy9LaFFSa0RDMWRkTVJyYWptSk1XWDBTTFN4Y29mS1o4TEpO?=
 =?utf-8?B?anN1VmdaT0I5Y25jQm5aTEFjbDRtVWlwVFRHdk5tQlJlMkZTM1p6UnhqcktE?=
 =?utf-8?B?aG9CQjkzQm5ZdHQ5M1IzYUdUZ01CaWJlTDY5RmF2bkRhTDMrcGRUUUtaM3NT?=
 =?utf-8?B?dXBGVFc3cnkvc3A0cmxUNG1OWVNrTjNpM1ZhTWtjQkw4QkFkMVhxV1Frd1Bo?=
 =?utf-8?B?Tzd1TXFPdnYwYnAyTC9XNEx1RUt2UzBWOWZTSFhocXJ0UmhIdkFDTnJLZVJ6?=
 =?utf-8?B?Sk5OejA3bGFPempQSkhCLzhJK3pETE9uZEE1WTNXZWZKNE5nRkhoQk5OSmF4?=
 =?utf-8?B?ZFVza0ZFbk9PVTRITnQ2UGRPTEVRRGtTYW9jbUtpa2dPRDZzclZrckRqYS9Z?=
 =?utf-8?B?SFhyd1RFOG1paXVhUnUzQkpYVkFId0ZYcUkvcHRXQXBVd2hHaFY5eVR3aEJL?=
 =?utf-8?B?OXVQd2MxeGRmNXI1NHdxSXF0dmwzdDVQQ01HTVJvRjFJN1orYjQzM0U1a1pm?=
 =?utf-8?B?Smx2alVQQUMvdU1UUFRkUzBVaUVpd1Y0WEx6VGF5SEZYbll5RFNhcHZRMWhL?=
 =?utf-8?B?ek5CeTZYb0JYT3VYaHRGNFB4VGhCRFJDU3VVYW01MU1SdU8xQzBwMUlyRVRh?=
 =?utf-8?B?T3FLMzVINXVVbExTNDRlclFVdktNUC9zb01vRlZGd0ZJb2FkdjMwN1pzWkZI?=
 =?utf-8?B?d0oyREUxN2cvWWtFdHNqek1MSGlIV0VZdk1qUEJub0c1ZXJWRnBJR2N6RG5W?=
 =?utf-8?B?UTA0RmJLR2NCcjZsV1dUMys2a3g4L21pSkpZMWJnYUZVbThqeTRqMmUyWVl6?=
 =?utf-8?B?YkxNT2xqS1VjV2Z2dkJjWS9KWkd0ckhwYmdxSmpMdVBIU3pXRHljdWdKVU1i?=
 =?utf-8?B?WUd3U2xXMFZtSXJiSTBQNUlNc3kvYUdJRHdsSTl4NnZGQ1QxNXNLQko3VXR1?=
 =?utf-8?B?cytRWXNGeHNzMURISURYcU9yYklldGY3OEp4aEpYcTArYm90OEhRTEd0L1Vi?=
 =?utf-8?B?cXoyRXllYnhJRVhYSmZsQXQ1NlNva1JVYmVGTmtMWndJTURKNXU1NTkrTDZX?=
 =?utf-8?B?MlBSUkhpZmFoR1RLejdjN2tUajh5SlgrRHJmaXZocE5qeDhwcVFPdmhERmVi?=
 =?utf-8?B?OVFycG5sV2pwMTJPcitCWkdrODk5RUZEZkcxWXQwNzNQbStjODRqVkU0aDcv?=
 =?utf-8?Q?pjdc02zqYhT7lqXYVS3cU64VyajZapAr6Tl8RiA?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a292060-70b4-42d9-b687-08dd5afcef3f
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 09:14:15.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2095

On 3/4/25 9:35 AM, Longbin Li wrote:
> Add support for SG2044 SPI NOR controller in Sophgo SoC.
>
> Signed-off-by: Longbin Li<looong.bin@gmail.com>
> ---
>   drivers/spi/Kconfig          |   9 +
>   drivers/spi/Makefile         |   1 +
>   drivers/spi/spi-sg2044-nor.c | 500 +++++++++++++++++++++++++++++++++++
>   3 files changed, 510 insertions(+)
>   create mode 100644 drivers/spi/spi-sg2044-nor.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ea8a31032927..281310178734 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1021,6 +1021,15 @@ config SPI_SN_F_OSPI
>   	  for connecting an SPI Flash memory over up to 8-bit wide bus.
>   	  It supports indirect access mode only.
>
> +config SPI_SG2044_NOR
> +	tristate "SG2044 SPI NOR Controller"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  This enables support for the SG2044 SPI NOR controller,
> +	  which supports Dual/Qual read and write operations while

Nit: Dual/Quad not Dual/Qual

> +	  also supporting 3Byte address devices and 4Byte address
> +	  devices.
> +
>   config SPI_SPRD
>   	tristate "Spreadtrum SPI controller"
>   	depends on ARCH_SPRD || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 9db7554c1864..c7a46fd61903 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -134,6 +134,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
>   obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
>   obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
>   obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
> +obj-$(CONFIG_SPI_SG2044_NOR)	+= spi-sg2044-nor.o
>   obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
>   obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
>   obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
> diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
> new file mode 100644
> index 000000000000..454153a63b42
> --- /dev/null
> +++ b/drivers/spi/spi-sg2044-nor.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SG2044 SPI NOR controller driver
> + *
> + * Copyright (c) 2025 Longbin Li<looong.bin@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* Hardware register definitions */
> +#define SPIFMC_CTRL				0x00
> +#define SPIFMC_CTRL_CPHA			BIT(12)
> +#define SPIFMC_CTRL_CPOL			BIT(13)
> +#define SPIFMC_CTRL_HOLD_OL			BIT(14)
> +#define SPIFMC_CTRL_WP_OL			BIT(15)
> +#define SPIFMC_CTRL_LSBF			BIT(20)
> +#define SPIFMC_CTRL_SRST			BIT(21)
> +#define SPIFMC_CTRL_SCK_DIV_SHIFT		0
> +#define SPIFMC_CTRL_FRAME_LEN_SHIFT		16
> +#define SPIFMC_CTRL_SCK_DIV_MASK		0x7FF
> +
> +#define SPIFMC_CE_CTRL				0x04
> +#define SPIFMC_CE_CTRL_CEMANUAL			BIT(0)
> +#define SPIFMC_CE_CTRL_CEMANUAL_EN		BIT(1)
> +
> +#define SPIFMC_DLY_CTRL				0x08
> +#define SPIFMC_CTRL_FM_INTVL_MASK		0x000f
> +#define SPIFMC_CTRL_FM_INTVL			BIT(0)
> +#define SPIFMC_CTRL_CET_MASK			0x0f00
> +#define SPIFMC_CTRL_CET				BIT(8)
> +
> +#define SPIFMC_DMMR				0x0c
> +
> +#define SPIFMC_TRAN_CSR				0x10
> +#define SPIFMC_TRAN_CSR_TRAN_MODE_MASK		GENMASK(1, 0)
> +#define SPIFMC_TRAN_CSR_TRAN_MODE_RX		BIT(0)
> +#define SPIFMC_TRAN_CSR_TRAN_MODE_TX		BIT(1)
> +#define SPIFMC_TRAN_CSR_FAST_MODE		BIT(3)
> +#define SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT		(0x00 << 4)
> +#define SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT		(0x01 << 4)
> +#define SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT		(0x02 << 4)
> +#define SPIFMC_TRAN_CSR_DMA_EN			BIT(6)
> +#define SPIFMC_TRAN_CSR_MISO_LEVEL		BIT(7)
> +#define SPIFMC_TRAN_CSR_ADDR_BYTES_MASK		GENMASK(10, 8)
> +#define SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT	8
> +#define SPIFMC_TRAN_CSR_WITH_CMD		BIT(11)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_MASK	GENMASK(13, 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE	(0x00 << 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_2_BYTE	(0x01 << 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_4_BYTE	(0x02 << 12)
> +#define SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE	(0x03 << 12)
> +#define SPIFMC_TRAN_CSR_GO_BUSY			BIT(15)
> +#define SPIFMC_TRAN_CSR_ADDR4B_SHIFT		20
> +#define SPIFMC_TRAN_CSR_CMD4B_SHIFT		21
> +
> +#define SPIFMC_TRAN_NUM				0x14
> +#define SPIFMC_FIFO_PORT			0x18
> +#define SPIFMC_FIFO_PT				0x20
> +
> +#define SPIFMC_INT_STS				0x28
> +#define SPIFMC_INT_TRAN_DONE			BIT(0)
> +#define SPIFMC_INT_RD_FIFO			BIT(2)
> +#define SPIFMC_INT_WR_FIFO			BIT(3)
> +#define SPIFMC_INT_RX_FRAME			BIT(4)
> +#define SPIFMC_INT_TX_FRAME			BIT(5)
> +
> +#define SPIFMC_INT_EN				0x2c
> +#define SPIFMC_INT_TRAN_DONE_EN			BIT(0)
> +#define SPIFMC_INT_RD_FIFO_EN			BIT(2)
> +#define SPIFMC_INT_WR_FIFO_EN			BIT(3)
> +#define SPIFMC_INT_RX_FRAME_EN			BIT(4)
> +#define SPIFMC_INT_TX_FRAME_EN			BIT(5)
> +
> +#define SPIFMC_OPT				0x030
> +#define SPIFMC_OPT_DISABLE_FIFO_FLUSH		BIT(1)
> +
> +#define SPIFMC_MAX_FIFO_DEPTH			8
> +
> +#define SPIFMC_MAX_READ_SIZE			0x10000
> +
> +struct sg2044_spifmc {
> +	struct spi_controller *ctrl;
> +	void __iomem *io_base;
> +	struct device *dev;
> +	struct mutex lock;
> +	struct clk *clk;
> +};
> +
> +static int sg2044_spifmc_wait_int(struct sg2044_spifmc *spifmc, u8 int_type)
> +{
> +	u32 stat;
> +
> +	return readl_poll_timeout(spifmc->io_base + SPIFMC_INT_STS, stat,
> +				  (stat & int_type), 0, 1000000);
> +}
> +
> +static int sg2044_spifmc_wait_xfer_size(struct sg2044_spifmc *spifmc,
> +					int xfer_size)
> +{
> +	u8 stat;
> +
> +	return readl_poll_timeout(spifmc->io_base + SPIFMC_FIFO_PT, stat,
> +				  ((stat & 0xf) == xfer_size), 1, 1000000);
> +}
> +
> +static u32 sg2044_spifmc_init_reg(struct sg2044_spifmc *spifmc)
> +{
> +	u32 reg;
> +
> +	reg = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
> +	reg &= ~(SPIFMC_TRAN_CSR_TRAN_MODE_MASK |
> +		 SPIFMC_TRAN_CSR_FAST_MODE |
> +		 SPIFMC_TRAN_CSR_BUS_WIDTH_2_BIT |
> +		 SPIFMC_TRAN_CSR_BUS_WIDTH_4_BIT |
> +		 SPIFMC_TRAN_CSR_DMA_EN |
> +		 SPIFMC_TRAN_CSR_ADDR_BYTES_MASK |
> +		 SPIFMC_TRAN_CSR_WITH_CMD |
> +		 SPIFMC_TRAN_CSR_FIFO_TRG_LVL_MASK);
> +
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	return reg;
> +}
> +
> +static ssize_t sg2044_spifmc_read_64k(struct sg2044_spifmc *spifmc,
> +				      const struct spi_mem_op *op, loff_t from,
> +				      size_t len, u_char *buf)
> +{
> +	int xfer_size, offset;
> +	u32 reg;
> +	int ret;
> +	int i;
> +
> +	reg = sg2044_spifmc_init_reg(spifmc);
> +	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +	reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = op->addr.nbytes - 1; i >= 0; i--)
> +		writeb((from >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < op->dummy.nbytes; i++)
> +		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_RD_FIFO);
> +	if (ret < 0)
> +		return ret;
> +
> +	offset = 0;
> +	while (offset < len) {
> +		xfer_size = min_t(size_t, SPIFMC_MAX_FIFO_DEPTH, len - offset);
> +
> +		ret = sg2044_spifmc_wait_xfer_size(spifmc, xfer_size);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (i = 0; i < xfer_size; i++)
> +			buf[i + offset] = readb(spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +		offset += xfer_size;
> +	}
> +
> +	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return len;
> +}
> +
> +static ssize_t sg2044_spifmc_read(struct sg2044_spifmc *spifmc,
> +				  const struct spi_mem_op *op)
> +{
> +	size_t xfer_size;
> +	size_t offset;
> +	loff_t from = op->addr.val;
> +	size_t len = op->data.nbytes;
> +	int ret;
> +	u8 *din = op->data.buf.in;
> +
> +	offset = 0;
> +	while (offset < len) {
> +		xfer_size = min_t(size_t, SPIFMC_MAX_READ_SIZE, len - offset);
> +
> +		ret = sg2044_spifmc_read_64k(spifmc, op, from, xfer_size, din);
> +		if (ret < 0)
> +			return ret;
> +
> +		offset += xfer_size;
> +		din += xfer_size;
> +		from += xfer_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t sg2044_spifmc_write(struct sg2044_spifmc *spifmc,
> +				   const struct spi_mem_op *op)
> +{
> +	size_t xfer_size;
> +	const u8 *dout = op->data.buf.out;
> +	int i, offset;
> +	size_t ret;
> +	u32 reg;
> +
> +	reg = sg2044_spifmc_init_reg(spifmc);
> +	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_8_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +	reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = op->addr.nbytes - 1; i >= 0; i--)
> +		writeb((op->addr.val >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < op->dummy.nbytes; i++)
> +		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	writel(op->data.nbytes, spifmc->io_base + SPIFMC_TRAN_NUM);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sg2044_spifmc_wait_xfer_size(spifmc, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	offset = 0;
> +	while (offset < op->data.nbytes) {
> +		xfer_size = min_t(size_t, SPIFMC_MAX_FIFO_DEPTH, op->data.nbytes - offset);
> +
> +		ret = sg2044_spifmc_wait_xfer_size(spifmc, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (i = 0; i < xfer_size; i++)
> +			writeb(dout[i + offset], spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +		offset += xfer_size;
> +	}
> +
> +	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return 0;
> +}
> +
> +static ssize_t sg2044_spifmc_tran_cmd(struct sg2044_spifmc *spifmc,
> +				      const struct spi_mem_op *op)
> +{
> +	int i, ret;
> +	u32 reg;
> +
> +	reg = sg2044_spifmc_init_reg(spifmc);
> +	reg |= (op->addr.nbytes + op->dummy.nbytes) << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT;
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = op->addr.nbytes - 1; i >= 0; i--)
> +		writeb((op->addr.val >> i * 8) & 0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < op->dummy.nbytes; i++)
> +		writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return 0;
> +}
> +
> +static void sg2044_spifmc_trans(struct sg2044_spifmc *spifmc,
> +				const struct spi_mem_op *op)
> +{
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		sg2044_spifmc_read(spifmc, op);
> +	else if (op->data.dir == SPI_MEM_DATA_OUT)
> +		sg2044_spifmc_write(spifmc, op);
> +	else
> +		sg2044_spifmc_tran_cmd(spifmc, op);
> +}
> +
> +static ssize_t sg2044_spifmc_trans_reg(struct sg2044_spifmc *spifmc,
> +				       const struct spi_mem_op *op)
> +{
> +	const u8 *dout = NULL;
> +	u8 *din = NULL;
> +	size_t len = op->data.nbytes;
> +	int ret, i;
> +	u32 reg;
> +
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		din = op->data.buf.in;
> +	else
> +		dout = op->data.buf.out;
> +
> +	reg = sg2044_spifmc_init_reg(spifmc);
> +	reg |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_1_BYTE;
> +	reg |= SPIFMC_TRAN_CSR_WITH_CMD;
> +
> +	if (din) {
> +		reg |= SPIFMC_TRAN_CSR_BUS_WIDTH_1_BIT;
> +		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> +		reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> +
> +		writel(SPIFMC_OPT_DISABLE_FIFO_FLUSH, spifmc->io_base + SPIFMC_OPT);
> +	} else {
> +		/*
> +		 * If write values to the Status Register,
> +		 * configure TRAN_CSR register as the same as
> +		 * sg2044_spifmc_read_reg.
> +		 */
> +		if (op->cmd.opcode == 0x01) {
> +			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_RX;
> +			reg |= SPIFMC_TRAN_CSR_TRAN_MODE_TX;
> +			writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
> +		}
> +	}
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +	writeb(op->cmd.opcode, spifmc->io_base + SPIFMC_FIFO_PORT);
> +
> +	for (i = 0; i < len; i++) {
> +		if (din)
> +			writeb(0xff, spifmc->io_base + SPIFMC_FIFO_PORT);
> +		else
> +			writeb(dout[i], spifmc->io_base + SPIFMC_FIFO_PORT);
> +	}
> +
> +	writel(0, spifmc->io_base + SPIFMC_INT_STS);
> +	writel(len, spifmc->io_base + SPIFMC_TRAN_NUM);
> +	reg |= SPIFMC_TRAN_CSR_GO_BUSY;
> +	writel(reg, spifmc->io_base + SPIFMC_TRAN_CSR);
> +
> +	ret = sg2044_spifmc_wait_int(spifmc, SPIFMC_INT_TRAN_DONE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (din) {
> +		while (len--)
> +			*din++ = readb(spifmc->io_base + SPIFMC_FIFO_PORT);
> +	}
> +
> +	writel(0, spifmc->io_base + SPIFMC_FIFO_PT);
> +
> +	return 0;
> +}
> +
> +static int sg2044_spifmc_exec_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	struct sg2044_spifmc *spifmc;
> +
> +	spifmc = spi_controller_get_devdata(mem->spi->controller);
> +
> +	mutex_lock(&spifmc->lock);
> +
> +	if (op->addr.nbytes == 0)
> +		sg2044_spifmc_trans_reg(spifmc, op);
> +	else
> +		sg2044_spifmc_trans(spifmc, op);
> +
> +	mutex_unlock(&spifmc->lock);
> +
> +	return 0;
> +}
> +
> +static const struct spi_controller_mem_ops sg2044_spifmc_mem_ops = {
> +	.exec_op = sg2044_spifmc_exec_op,
> +};
> +
> +static void sg2044_spifmc_init(struct sg2044_spifmc *spifmc)
> +{
> +	u32 tran_csr;
> +	u32 reg;
> +
> +	writel(0, spifmc->io_base + SPIFMC_DMMR);
> +
> +	reg = readl(spifmc->io_base + SPIFMC_CTRL);
> +	reg |= SPIFMC_CTRL_SRST;
> +	reg &= ~(SPIFMC_CTRL_SCK_DIV_MASK);
> +	reg |= 1;
> +	writel(reg, spifmc->io_base + SPIFMC_CTRL);
> +
> +	writel(0, spifmc->io_base + SPIFMC_CE_CTRL);
> +
> +	tran_csr = readl(spifmc->io_base + SPIFMC_TRAN_CSR);
> +	tran_csr |= (0 << SPIFMC_TRAN_CSR_ADDR_BYTES_SHIFT);
> +	tran_csr |= SPIFMC_TRAN_CSR_FIFO_TRG_LVL_4_BYTE;
> +	tran_csr |= SPIFMC_TRAN_CSR_WITH_CMD;
> +	writel(tran_csr, spifmc->io_base + SPIFMC_TRAN_CSR);
> +}
> +
> +static int sg2044_spifmc_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctrl;
> +	struct sg2044_spifmc *spifmc;
> +	void __iomem *base;
> +	int ret;
> +
> +	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*spifmc));
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	spifmc = spi_controller_get_devdata(ctrl);
> +	dev_set_drvdata(&pdev->dev, ctrl);
> +
> +	spifmc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(spifmc->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(spifmc->clk),
> +				     "%s: Cannot get and enable AHB clock\n",
> +				     __func__);
> +
> +	spifmc->dev = &pdev->dev;
> +	spifmc->ctrl = ctrl;
> +
> +	spifmc->io_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ctrl->num_chipselect = 1;
> +	ctrl->dev.of_node = pdev->dev.of_node;
> +	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
> +	ctrl->auto_runtime_pm = false;
> +	ctrl->mem_ops = &sg2044_spifmc_mem_ops;
> +	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD;
> +
> +	mutex_init(&spifmc->lock);
> +
> +	sg2044_spifmc_init(spifmc);
> +	sg2044_spifmc_init_reg(spifmc);
> +
> +	ret = devm_spi_register_controller(&pdev->dev, ctrl);
> +	if (ret) {
> +		mutex_destroy(&spifmc->lock);
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sg2044_spifmc_remove(struct platform_device *pdev)
> +{
> +	struct sg2044_spifmc *spifmc = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&spifmc->lock);
> +}
> +
> +static const struct of_device_id sg2044_spifmc_match[] = {
> +	{ .compatible = "sophgo,sg2044-spifmc-nor" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sg2044_spifmc_match);
> +
> +static struct platform_driver sg2044_nor_driver = {
> +	.driver = {
> +		.name = "sg2044,spifmc-nor",
> +		.of_match_table = sg2044_spifmc_match,
> +	},
> +	.probe = sg2044_spifmc_probe,
> +	.remove = sg2044_spifmc_remove,
> +};
> +module_platform_driver(sg2044_nor_driver);
> +
> +MODULE_DESCRIPTION("SG2044 SPI NOR controller driver");
> +MODULE_AUTHOR("Longbin Li<looong.bin@gmail.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.48.1


Kind regards,
Maud



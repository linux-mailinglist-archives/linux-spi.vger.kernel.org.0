Return-Path: <linux-spi+bounces-6900-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950CA431D1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 01:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D282189AC58
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 00:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39292F3E;
	Tue, 25 Feb 2025 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aVC59k+l"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28141C27;
	Tue, 25 Feb 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443029; cv=fail; b=tYvv7ajmqjqTeejGgOWDAjIz33X9xSwerjopmKRzSyuk55fbpMzuR87IjSwy4HKdxIeIEiR10NDxHnskZDYpf1dKGLXQT2WSrmBKBQOLL8617hD9+JM3HF2vwG0gP519dZYzwcOLBPypaCHx+rFT4aeCrIqqAxIWRD3JYrBKyVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443029; c=relaxed/simple;
	bh=ihcphGCrVFSnNyEf9FrKsxCLtibxMxUQBZuS9hxteeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EN1tjCdn492fdYtStxbr/hX0wTrXRHMK76gFKTer2wMQ89SqntT5BWhcWFOlaPl3gN1jmbpZkZyN8nNP+/2jQVOOFlvmoDw9hCtKE/QHw4/wwVnZLy4joAxY2dQDN86yY5p/yfk7Pz2YW90odz87NZwaEmWcL9hT9Hxm3sOQUYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aVC59k+l; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXrtreHhKJNvwfWSr7wYf21ytIYSWY73fE0ANIsCCGw7OMeaxQNW2uaWnhG4DpwjR2jOxlCj9yXCCw95wSYvtp6mJBiFXamR3NdJ+9dJ0jX+3RUgM+F0wBIWobnIMOjYyElaxhchXP/CX9yq6Jq8aHyurkPHnUOJ6M/m42GXcnTKCeYKWBcCNinlnB9K8Hav9VjZa3uxUc8V8fmdB2Tdole/wHEXGj6MK9c7GZ8kfDd93ZAQOOeeYQO6Lvin1IO13p8kZYikYxl5cXbEStCN1yqUkPza9KG3tNldb+xQseTimOsSSSsp/l9KIGvVieqWyfRx2PqtmD0xiHARiMoeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGNmRurzYFn8Il0+W0XXcmqN/Y/zGMLXPFZ8z6fCkU0=;
 b=p5YKpbWzbWIINh3ibMKitpBi5b9UEzwYDcIt5zI64mYTmtMSgVZWdO1++rav/km+rgoDqvbGD5TAsvo/rEOpJ2RxAjD9s21Kf7J2crl7pwD57aqq1YJfYnoCCuIq2cS73VV5s7uMXqEFv4lC2+rPkyWLwwQdqT3w4rFwTMe/n4+O/cCIwHLSquzqjI1VrlmmNTD/Sh/8ayJvrMU7PCaLnW1S4M6AkoyVI47il8dk+x/2ATAqgaF8VmiCIF0/EhY04dt62DZ00ToaLRMlIdUStICMKF2YYMV3JdrhKxhz317/ydM3YYl1dg+3A3szATyD5E5BqjtDkaOAerayLNH8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGNmRurzYFn8Il0+W0XXcmqN/Y/zGMLXPFZ8z6fCkU0=;
 b=aVC59k+lcO2jKnGu51A19ZV6GJZNgeIqROZcE3+qYCHRT4AbyIvsx+XkLxtU5bfx6FIC53tRlXATCQh2wpq3dxRadWbyVwEmnPe9TnNQ0XIWE5KdMIMW1pgbWVRTMLFsmDNXEg28t6y/8stxkPdpv4xrOXhLsPO7jrTtZ/F7NcW+YUj5BDapz/nAbBiHL0Ow/hwuMstEag7dkEQcqFr/44Z7k7Vmvegp5N3rMSwkH75RhQXHu36kCVqAIgYfan/BDLECs7zcCMaT+g4nCRcvG4ArHBAHsAh2Hu2DgEVfilW06wayjOp4NWSouPjx8n2gaPMzNdureETavK7Esp5vog==
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
 by MA0PR01MB5725.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 00:23:40 +0000
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e]) by PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 00:23:40 +0000
Message-ID:
 <PN0PR01MB91662EB902D8B337A0526458FEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 25 Feb 2025 08:23:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: dts: sophgo: add Sophgo SPI NOR controller
 driver
To: Longbin Li <looong.bin@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-4-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250224101213.26003-4-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
X-Microsoft-Original-Message-ID:
 <9bfe0d73-ff52-4333-b9cc-3f6d61923f67@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9166:EE_|MA0PR01MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 01df010d-7ee3-4f48-4a63-08dd5532a7a0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|461199028|5072599009|8060799006|6090799003|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXdNZDMxeURIMGJwKzc1WW5xOEpnVHc2N1BTb21ta3dlN013MUg0NnJUMG1K?=
 =?utf-8?B?QnkyK0Y0SktGMmYzdTNzM1JWMjRIVkFJUFlvRUx6WlFTYmZseWtPNkJTK3E1?=
 =?utf-8?B?UWYwM3J6Smo5WStNSys4b3FCVjNqd2prbGlaUWJYc1kyd3VnajhHS2VGbjVp?=
 =?utf-8?B?SlpUQUZMRW83VC9wKzBYV1FFTjZWSVJSMWNKamJGZk1sSUpERms5Zlk1WmFS?=
 =?utf-8?B?V0Zhd2hMSGlPcytCS2V0ckxvVXMzeExHMndZWnJrRFpMeWhUcFArTFRGc1g3?=
 =?utf-8?B?TUIzKzRIbXZEaFdScld5TWVJUGgrWExLcHkxYnRNNytqNklUanR5enFFTElH?=
 =?utf-8?B?aTN3aVUxS3p5MUxXVlcxUVQzdENubFQ5enR6UmNUOGkyMHBydHB2Wi9uOHNa?=
 =?utf-8?B?T0xVRnBsNjV2NXRmbjdqQlQxNjdDbDJsajBhVklnSFZGUGhpYXAxOXhrZ2U2?=
 =?utf-8?B?NGdxV3ZMbzhQYmhnTitBT28rQUlMTXgyNmdsSEJpeWdYVXgrMVJwQm83eWU4?=
 =?utf-8?B?UExtTjQzS3RQQnNkYklUK05zekVNVzZQeVUremlWbWJtSm4zWmFYaWpnWFJt?=
 =?utf-8?B?L09QZ3ZaM3ZTR2VBSmVvS0Q1MFo3b3h0cVFKYVZTb1B6aG94Mk1ONDFTazZ4?=
 =?utf-8?B?azcwc0VERWtTaFgrdkIyaGJMNm1YeU1VWlllb2kwbUUvSThHNUZvbUZScmRC?=
 =?utf-8?B?MFIxT1FheXhNYWVzRmlONzBKSTY4WDhCV042dkticFJhRlVEcFpqOHViOVRx?=
 =?utf-8?B?VzYvYitPUnNDQlFrVVZqcXFIWWsxY2MrRlhpRmYvajYyVjhkWk82R0RjUXRG?=
 =?utf-8?B?VldQdTQ4ODJneVQwZzI4VENkb2lYZ0lLQVZyTERWSnlWUW5zaU9tME14M0xi?=
 =?utf-8?B?NnNPSEFiaCt1OWhpNjB1eUU5a2o1UlJPZkpIUWhhZWo1VXJVcnpHVVhrbzBa?=
 =?utf-8?B?YlAvN3d0V1NvTGg0ZG9sN1FVcEhxMEZHYkh6WS9ZVlUwaGxwc0ZrN0E4aTB6?=
 =?utf-8?B?eGpVZ1o3ZDhpb21NbnRyaFRIS25HdkNpdEpmQmR2VHZ0N2wzckgvbks5bEpi?=
 =?utf-8?B?aFREeDlqVHVhYldia0JnSkVha25QRDd0TlluNzU4WTFROTF6UklFSjZGR3VN?=
 =?utf-8?B?VzFWM3JSTkxJZjY1c0dVdXkwS0pZRCtCQlBwWlFnUjB5MVUxOU9hS050Y29w?=
 =?utf-8?B?b3NpbEZzLytGUzZIZldhUzIwbjlhL20vdVYwYVJ1TG42dDAzOG52SEU3K1R5?=
 =?utf-8?B?NTB0RVQvKzVpd3I5ME9HWkpGQW15UHh3ODQxRC9OWXRSamNXK3V5UE45akV1?=
 =?utf-8?B?VzE5eG1aMnJRdTZjajM0OWYwMGIrU1NVY1lhelZMNUpEcys4OUE3aUJwNWdn?=
 =?utf-8?B?NGJ4WWxMNGRlc05qMTFUb001L1RwUGRQR3pDWWhxVnAyemN4T20rRGZPSEw4?=
 =?utf-8?B?eHBwS1NRcEdVb1lxbE13YjZ5QTRDeU1DMUNwZkNOQWVhbmtUK0pSdHRvWkFJ?=
 =?utf-8?Q?37bOso=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVyR2F5cytBUzJvMVc4RC9oaHp5cUNIVUNhakw5NHUvM2xxRkI0OVkzMHhE?=
 =?utf-8?B?NFJ2ZVNMRkZDYnhhWnV5cW42WXZtaHRRSHVoZFlFNjArS0JFb1hEdnhsZDVO?=
 =?utf-8?B?NlRMVHFvbWc3SjFRYU5iNjNveEM0ai9UdVZ5SDNMNEJHSUtLUU45TkdnVUZG?=
 =?utf-8?B?VEV0NDdUOEswc0x5WXZqVXEydi9ZVFZqYTVzVHVnMzZLTUJjRFZKeVd1akhL?=
 =?utf-8?B?T0FuOFFhQWEyZnZUOEtBakZYOEoxU1JWUVFabkkrU3hpckR4djFCZythc2c2?=
 =?utf-8?B?TVNzcW1wNTlmaXRxVmNyMmw2N1RaMHVicWdEQVZmY2JDNzQ3VE1XTkRWUXB2?=
 =?utf-8?B?R3FPdDVlN0UxdHpTckZMZzdTMndYN2Rtb1ZzakZncGxVTmVCUEdDRis0YTFJ?=
 =?utf-8?B?QTlyNHgwcmYzd0dHcjRQWkFVdWlydW9ucjhENklSYk12VHh1TXpVWFJwdDE1?=
 =?utf-8?B?ZHQ3dWFtVkhDRFFVaHhLbTJ6amJ1VVJKR0Nna3g3Qjh4WnFCdFhaOFR4Nzcr?=
 =?utf-8?B?S2NoKzE3bzNPNkR5a2hwZElVMnkyVGtzNU14THRPeHNzK3dIN21Hb0ROQklV?=
 =?utf-8?B?UDhzajQ5V1FydjlLbzIvK0RBRTl2c29sUkI0ZEZTTktSQXpPcGVTRXcxaXVr?=
 =?utf-8?B?bjdwdGRnUnFmSmtXaTBwWCtMU1NtemdSd0hPdGhRaTAzVjJ1SXBReGUwMXVF?=
 =?utf-8?B?UnM5eUlDa1V1ekdsTDJEbjB1Y1FXMENESmZORVludFd6d2ZvbWU3cERYb1BC?=
 =?utf-8?B?ODlhcm91OTc0bllVNXZWMmNMRlRFZDQyYXc5NVRzVGhsdjFwdExwaUZCVG9L?=
 =?utf-8?B?d1dhMGt0NjBlS21hZlZmVzNRZC81Rk9pWmVyTlN6cFUyWERqVGt6VGtiQUZY?=
 =?utf-8?B?dnBuNHVJRFJmcTdkSUpBWURVUmZ5bkxxZTR4dlJWdGExQ3lIY0xtekdjT3NV?=
 =?utf-8?B?cE9wWlUvMFVZd0RMR0xkZXpaM1hsVDhRdks4N0RiZVVJeVdEc1JPUWMwdTdD?=
 =?utf-8?B?M094RlFMczBBby80N0dRMEpvdE9ISTJ5Z2ZOcVhhdmluYWdNVVJoOVROejdR?=
 =?utf-8?B?L2ltQmRvelBnNnhsRVRHQUs3YmpDRlFCaE5MWitNZlJOeWVkWUpTSmZudTU0?=
 =?utf-8?B?a1I0aGFmWURVak9KdVN5YUdleEJzWU5UR0t1TjdFd0tPVitMMENYVFUwdU5p?=
 =?utf-8?B?dEFnZmI0QXFMZUkyb1dSTFRVQ2VlcEhrZkdPR3dQdXYxZ2xuT1FOaC9nRnIr?=
 =?utf-8?B?dTFoVkQ4eGlWUHZ0dWpMREFNcm9VdkcxSUQ1RG02cjlPVjdaL2dJYjJxamx0?=
 =?utf-8?B?NTRVUGtRb1Y1bG90ZGJTT0Z4UjJDN296ai9ZcTY5Mm9vTHhGVEI1OWpWMkJm?=
 =?utf-8?B?Z0xJWmo5YmJLY0xmK1NuYWVJamFnOFYyOTlFZld3SUh6Wk0wUUhJNXJoWGFZ?=
 =?utf-8?B?cEw5Vis5cFg0ak1UcnBMMXMvaC9MREJRaVJIeHptUGF4TVZmZzc3K0tBVkJL?=
 =?utf-8?B?bFhTenQ3ayt2SW45WXpZcnFac1IxOWtRU2dWbkp4ZnpBZ0hDcUZpaTdrNTgv?=
 =?utf-8?B?YWZDMFdweW9tKzVjVXVYTlRaRnlOR1pNcG0vdUpwdkNnVm13bVRJcE9RVElo?=
 =?utf-8?B?MVVjK1lpaVFsNjEyUmc4aWdiSDY3SkZobDhER25hNHl2TlZncngrTXMwbmFp?=
 =?utf-8?B?NUhZamQydTlBSHY3Y2VOM3pHSVplenFnSTRiUDE5Q0pzMHpQanpGc29nNndu?=
 =?utf-8?Q?6x8vJ/bETqBS8eAufXcJmMALCdkvGNO/RrqfR9o?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01df010d-7ee3-4f48-4a63-08dd5532a7a0
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:23:40.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5725


On 2025/2/24 18:12, Longbin Li wrote:
> Add SPI NOR device node for Sophgo.
>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>   .../boot/dts/sophgo/sg2044-sophgo-sd3-10.dts  | 18 ++++++++++++++
>   arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 24 +++++++++++++++++++
>   2 files changed, 42 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
> index c50e61a50013..9c634920f37e 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
> @@ -80,6 +80,24 @@ &sd {
>   	status = "okay";
>   };
>
> +&spifmc0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +	};
> +};
> +
> +&spifmc1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +	};
> +};
> +
>   &uart1 {
>   	status = "okay";
>   };

What is your baseline? I can't see "sg2044-sophgo-sd3-10.dts " on the 
latest mainline yet.

BTW,  the name "sg2044-sophgo-sd3-10" seems a bit redundant. Wouldn't 
"sg2044-sd3-10" be better?

[......]



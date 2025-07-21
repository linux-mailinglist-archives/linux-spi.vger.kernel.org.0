Return-Path: <linux-spi+bounces-9141-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B44B0C4A0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E747AAC05
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E22D6615;
	Mon, 21 Jul 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N/J9uFUA"
X-Original-To: linux-spi@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6829E118;
	Mon, 21 Jul 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102737; cv=fail; b=D7zTlIQB+UR8EHuofjvchDcc8ctrB5/pJtw/JKJEY/TzPjhLx/UOzDS1gTzDrFLsns8yZHBzHQBwlX/d/1DSzBA1c5m7IBLGbft6VXSS5Ve/IR1hsjSJQ5z5Siz+GPlfDelzJPGI34JMYWslBUF0m4bF9K8klRDb3Y7xb6xXdJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102737; c=relaxed/simple;
	bh=5V/rWn2REQKYBy1ZQwgqRK4KNNflArJKJHkTLzWgWhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ULNo0CYyBCwL7TT8aFGybjVNhNBlTYS1Vzr2Tfgx91jqAMXVBoSwwbrB2sYb4MKt3PmdCC7SPYJoiakxURH2kzBPkH8jsya/8dyiuo/ivyRoW+FjE5HWHpu/3IZcfjR9DvzqRq5XrbUbGXa+9HMAGle6aiSCTWPxfudHyWIy1ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=N/J9uFUA; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFQQOINbz95hPVqFarU7CqFxpuqNUHzH6WkVBJT89yIY/n9IPpmrEQgKuv7fA1Wh0ASG8XIhDly5F9nDOb9YTVU9JVzW8X1IWjX+cwJuIJIPNMTGcWftFlYZu9Y4uK2qL/gnZFwP3MNVcb5bMTNDEsw/S6g1b7DUDyRJ2QfYirqdJIoLkGsit3a2+WEWuj9+8ue4YoPmy9vClw9q8SKBlKsoe+kVjPGD+49FzvU0oBJtwMJGeqLWv/EyWjTZgPGbyVwuTdsHDwnSwVe6NhMh7+Q04yCgzslXG00IG5cU/+vBmZ9I5lkuQ1LkrI8rW8WFU0OjB0aFE2nS8CwATPePvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnxkC29iNHYiczy9NKA4MpJDwG3KH4qpNmXh4o9t6e4=;
 b=sjYrtmp+2TywAK93jBJo1sTDA+XTF8k3RR80O9zzacs2PIq8o0YhM09U2EQLf2XcVk/MzEHzqvNWxa8d8afcDiEH9Ut7dcIqO/SMNHOyf17Xkd5n2dIwM9SRK1E91SDA+xmAzO2cJx6UAkpGBfvnHb550nLnrHr9ZYXYvUEAp7Ul40wEhJezONuJwgXy5qxQqED8WoJAFMVzEju1ahQSZkLNQwxr0aiGVbRe8cBzKQFlUDfnnPvk/3ZFyM9CXhe0x90R+8RPVbICtuPASD/no4QbzNdlrGf+k6llYHLenj1MJfa+vPfsafh90yE/Xu9RNHbJxgtvfKZNO1a8bUNm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnxkC29iNHYiczy9NKA4MpJDwG3KH4qpNmXh4o9t6e4=;
 b=N/J9uFUA0tiPZqf7zPYMij3d4flIuiGGwtUvPmlYS2LPG50Rn9f72mFjizS6LAw8x8N8Ka+RKcLUKdGASl9JCkvo2t3yGerSQ8UYGcqqFZb1ni9Tg5f4uav/ZXNHJhP6WcshN9kx5zJbbX8za2sNsaXOP1K0qyNH4H0LpPNFkItfU9yQoWOHBsbHSN0uoEy/aeJv3xCeER30mUwxyICOmeNMrEusqrJU7gH1HhX/Vr5woDqQ2+SBgtdpSEw+87Nqmf+3FtY0lEPmhrVvwZmPL9tCCwKjAVhWl3Zk31bY3ZsXfyu1MR6r2yTpfUuPPKDoETRRUHsb+eSbXIr9H0i+gw==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN3PR01MB5517.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:78::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 12:58:46 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 12:58:46 +0000
Message-ID:
 <MAUPR01MB110723FAC07AF511BF42E0102FE5DA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 21 Jul 2025 20:58:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] spi: sophgo: Add SPI NOR controller for SG2042
To: Zixian Zeng <sycamoremoon376@gmail.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Inochi Amaoto <inochiama@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Longbin Li <looong.bin@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 sophgo@lists.linux.dev, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <29df5685-e16c-44d5-a15a-714c6622a51f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN3PR01MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ebd784-87f2-4f66-5bee-08ddc856540c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799012|6090799003|1602099012|40105399003|440099028|3412199025|4302099013|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0JKWTdrVG80ZFg3WkdsZnhWTjlOSkZIcmFMS2RueVhjSFA4YmV1Ri9kdFlr?=
 =?utf-8?B?RkpQeEIwRWhQV1lIWFdGMUo4VHRCV1AvcnRWTURTWDhKSjRRbnBMUWIvVDdw?=
 =?utf-8?B?YXZBQmVwTlViSGxJT0FIVVgzOXFHaTdMQ1ZjY3FnWWVvZEg0WmhxMWJVRW1Z?=
 =?utf-8?B?UE9xTHFYMU1xVGl1Y3c5dWhtcWdaOHROSmRvZlBiUStWTHl4dy9LWWpaMUQy?=
 =?utf-8?B?UTgySjFRM0VPL1J1b3RkdkdWY3BGdDRjRWdCVGlRWUJaZU5iSFVpZkNmKzJ1?=
 =?utf-8?B?R1dqcUNaNjBTM05RM1FiWm1xeU43MVd2S3JGY09OQldQQW82ejlVc0R4Vk5j?=
 =?utf-8?B?RWZiMVNhaDdLZkJ3T3N1U3Z2OEQvTm81VUk5WnJMZUlBOXQ0SThxb296Mnox?=
 =?utf-8?B?UTZBRnpjZU1lQlVoejl3Z2g3SU9yUXFiOURLNXpoblhvVTgwZTY1enBjajVI?=
 =?utf-8?B?OEZZT1pnOU50NmJVUkNTN3NIajJCN2RMeUZUTEJUTW9Kd3J2K1JzNFo3QUs2?=
 =?utf-8?B?bGFzSnZJQU15b3ZSNVU1TTZvZkNuK29XWm9JMnJENjFKZDdOOVIxQUxZL1p2?=
 =?utf-8?B?SHBXWHFENjkwTDB1cjhicGY2VitNbFN6dlplVnNERmIvMEpYQVJ3a0orVmVo?=
 =?utf-8?B?ZU5lTHlNSEYzQVNGV29Nb2ZUTkdMNWtGNVlPR0lJbkcwVHhiZlZRMTI3RmFI?=
 =?utf-8?B?Wlpzd3VTcCtoR2NtYVlQUnprRXVSM24zR2dwcUFEVkdYclRON3NEcHB3WjlY?=
 =?utf-8?B?ZkFxVklIU0t0TXFBaldLVGEzWVhHT2UrUi9Jc3BQMzFxQy96b0VSbklSL09J?=
 =?utf-8?B?K0phekcvYUtTZTlnbS93eWdDdnFFWWZCQWhRMnBwTTlrdU02K1U0b0Z6cDBr?=
 =?utf-8?B?U3U2N0FVMU1pK1BWa0VlVXcvYnVBOUhuUnRyUElKK1I2YWxTVlI3SnNqa29j?=
 =?utf-8?B?akRxSHpneVRGeFVqUlgyenpXNHUxZ1FlcVBSV0hWWHJFQmh2Z1c0ZUhrTHVT?=
 =?utf-8?B?aHI5SEdNSzJJWm1TUWhhUXoyemhEZjkzbTRzTjZQVUhHL1pTdXVhWTdZUUZ0?=
 =?utf-8?B?REJIWkxZZUNKeEtvSVo0aUlWRkZ0UjJFNDJNNUpxMExNWWRQbmpSeVUvU1pK?=
 =?utf-8?B?Y0VWZ2thUFJDM3NRRnV2UDUwWDZrNGtrWDVXTHRsYVdLdGpqZVh5WFk0dEJZ?=
 =?utf-8?B?N2tJc3ZXZVlaak82REdkdTZmaDNieXhpUm5RNWhUQVNLd0RVdFdFdXF5MWtB?=
 =?utf-8?B?WDJSRUw4dktFYXNzT1dCTjZFS0MrUHFjaE4rWG02TDdEMlpCNkRmQ3JUcTZQ?=
 =?utf-8?B?ekNtbTBZQ2FpNTdDMkhpd1NPVHp0S1RkN0ZIeThraE9ka25YTlJkRitRYTdS?=
 =?utf-8?B?SnNQTEUwQWs0OFYrZ0pZRWorOWpLZ0sxdHc0VkJiazViNmdrM20xVmc4dFIv?=
 =?utf-8?B?dkh1MDA3eDBZano5SDdkc0NJZ1pJOVdUVjJ5cGFXbU5Ra1FQMVVTbnNFcytv?=
 =?utf-8?B?aVpRQnF5RDRZbDcvS1dKZ1RRZkdzSWFpd0Q5cGtRejgzakhUS24rN2xJUWtP?=
 =?utf-8?B?aTRvTkFxK3ByZUQ4eVdLL0RaVkwvdERmM29jSE83WmhYTFRpNGRvSVZkblE4?=
 =?utf-8?B?TTNFNk9FZmd5ZWlXbnpKeER6cyt4K0E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGI5QmxiMXVLZDYza214Wklwb21aUUxwY0pmb2tCMjJtS1ZLOWpEN2RMNEls?=
 =?utf-8?B?bWRDWFQ3REFFNEt4OVlnajV5MW5pNVovQjBaWmEyMVJ1UkErUWxqSE5MTlU0?=
 =?utf-8?B?TkwyT0M4MFozbkhicjZSZktqZWdrb1ViZU5kR0g0ZWt4c2hJMW02OWxVSFRF?=
 =?utf-8?B?N2k2b3puZ2hFN0xjK1VIWWlENWRjdTMwU29STVZsbnM5VTFFYVk1N0QrZVpO?=
 =?utf-8?B?Q01lRGZsQXlsTFFJL1dHWW5sZ2lWd1BpQnFoa1UrNTg3bTdMN2p0L1ZrRnJm?=
 =?utf-8?B?eGg2ZUo1MDBZOGhmS0gwbWtzczdGL21oU2RpUmNFWFJDR3Y3cmZDVkRJaU8r?=
 =?utf-8?B?TmhHKzhsUGdsM1Ftcys1WTlRZmd3V3dMK0Rld2psM0ljVURTdGVId1lra3ZT?=
 =?utf-8?B?U0V4UUtUNFhxLzRlQ3I0TzlObnZSY3gxa0N0cU9jVXdyYytuQkNJT0RhS01x?=
 =?utf-8?B?RWhOdlBCd1c5ZmRIUGpiNHlJTUt5NzhBemhkcU5LazM3MG41bzlFa2ZVRU1j?=
 =?utf-8?B?SkpoS2x4dytmUVZQUGRXNEVGN3N3UTd0N0VLblU3MGIvL3Vla0lGc1JoTHhJ?=
 =?utf-8?B?VU52eXhzclJvaEw3NzBYSS9jVjAvRzloeWJPZVdSU05INmR5TFZ2ak9acEVT?=
 =?utf-8?B?VTI1VG9rblRTVUQ0WVY5M2pVc2JiVm1zUXQxbEw2LzBlS2M5QjVCNlBPOXdC?=
 =?utf-8?B?M0xsS29mVFkzMXNXWmtybitSeUkrbE03WTlLYUpLcnZyNDNpZE1jTWhaMWRx?=
 =?utf-8?B?UnBuVnFab3Zod3JIZ3pVY3Q2OFYrQmNXZHhsMlJwSm9NNzR1S0I0S0RUdnZE?=
 =?utf-8?B?MzVOTFZWUDI3Q21jYWg5dkhPY0tBM2NPL2NPYXI3SUZhaTBIY1AzazRreXpL?=
 =?utf-8?B?U3E5MXYrQUFoeEhBUDkxcXRRbWRxNjNPTFZkOHN5NUVFLzdzQ3d4L1RBbjdo?=
 =?utf-8?B?SzAwT1JyaWEvMS9jUk1ldERpazJEc2JvaVAwUVpvcjdvS2FZWG53MnVWUDdR?=
 =?utf-8?B?dTZld1F2SzZXWnNPU1lrZTVDa1VHeWFoSkZVbWpRa2FpSnJUVTB6aFNYMkY3?=
 =?utf-8?B?SGdJbEh2QTVMQWhsaWxrNlNVYitkcUJ4ekJtUlQ1UmZUTXFVWHNrTFVrS2hv?=
 =?utf-8?B?Q3FidnlldFZtOWNJL2gvVWxBN2ErVVRnNDJsdm9PWlpmQlo2Mk9TY0JEd0th?=
 =?utf-8?B?clFVL2xONWo4OTZ3aitTbmFFUUpkZFloM0djZVppVVBIcnBNSGFDRWhZZVls?=
 =?utf-8?B?WVJWOEQ2d1U1Z29PWGJTTWZWOSt6MG9FNWFoK2pQNnhDTUhsSUFxMzRPcDNQ?=
 =?utf-8?B?bjV4L29vLzBTK1NjTlh6YUtRbHV2ZUQ0amhrbWUvbms4VE5ML0hqY3JzUjEz?=
 =?utf-8?B?c2hwY1FoMGNDN1lXcnIrcm1aMEwyYnJrRWJHbXFMTEFYLzZoS2FDcG0vUklh?=
 =?utf-8?B?bnBRZWQ5UURBaVcwUklrMmtITDlTSWZTcjhPRUk2TG5mWWJlUmc3M05TTE9s?=
 =?utf-8?B?TjZTZ28zZkh0bTFVNFBBNXpTc011ZnFCeUExUU02ZS9ZN05pR3NRamJNZ2Rx?=
 =?utf-8?B?YnNIbXdLdVFLVkg3czlQR3F6Y0R0UWVuMmd1VlpRWExENnNtNzNqdkNXU2RH?=
 =?utf-8?B?UUlaR1dLRHBtNFZFY0ZMK1dFRHloR1JPWmFIUFVtQkNCZjBDb2RpeXdzb1gy?=
 =?utf-8?B?ZEJDZDZpS0lIejBmZm9YRW02Rzl2NFI5L0lIY2o2WXlibEJwVHhHM1dxNGdU?=
 =?utf-8?Q?b1wsPPxgeToS1rSowLevy8D7HyAKvlqCoLpVDRf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ebd784-87f2-4f66-5bee-08ddc856540c
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 12:58:46.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5517


On 2025/7/20 16:31, Zixian Zeng wrote:
> Add support SPI NOR flash memory controller for SG2042, using upstreamed
> SG2044 SPI NOR driver.
>
> Tested on SG2042 Pioneer Box, read, write operations.
> Thanks Chen Wang who provided machine and guidance.
>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com> & Tested-by: Chen Wang 
<unicorn_wang@outlook.com>

Note I just have pioneerbox/sg2042 so I can only run with my board in hand.

Hi, Longbin,

As you are auther of this SPI driver, can you please help review and 
test it on sg2044?

Thanks,

Chen.

> ---
> Changes in v4:
> - patch1: Explain why SG2042 is not compatible with SG2044 and add Fixes tag.
> - patch2: Explain the hardware differences between SG2042 and SG2044.
> - patch4: Remove the extra "sophgo,sg2044-spifmc-nor" compatible property.
> - Link to v3: https://lore.kernel.org/r/20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com
>
> Changes in v3:
> - Drop the patch which adds additional flash_info into gigadevice.c
> - patch1: Because of the incompatibility, separate the SG2042 from the previous fallback mechanism to independent one.
> - patch2: Newly add configurable options to spi-sg2044-nor driver.
> - patch3: Fix reading bytes issue that causes the spi_nor_check_sfdp_signature() failure on SG2042.
> - Link to v2: https://lore.kernel.org/r/20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com
>
> Changes in v2:
> - patch1: Accept devicetree nodes whose compatible contains only
>    "sophgo,sg2044-spifmc-nor" to avoid breaking existing devicetrees.
> - patch1: Improve the commit subject message.
> - patch2: Dump the SFDP information to commit message.
> - Link to v1: https://lore.kernel.org/r/20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com
>
> ---
> Zixian Zeng (4):
>        spi: dt-bindings: spi-sg2044-nor: Change SOPHGO SG2042
>        spi: spi-sg2044-nor: Add configurable chip_info
>        spi: spi-sg2044-nor: Add SPI-NOR controller for SG2042
>        riscv: dts: sophgo: Add SPI NOR node for SG2042
>
>   .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |  9 +++----
>   .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++
>   drivers/spi/spi-sg2044-nor.c                       | 29 +++++++++++++++++++---
>   4 files changed, 77 insertions(+), 9 deletions(-)
> ---
> base-commit: 8727665368cd4af112146b650ec0ebac038b5cf5
> change-id: 20250523-sfg-spifmc-7a910290e964
>
> Best regards,


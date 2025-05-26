Return-Path: <linux-spi+bounces-8289-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B84AC37EB
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 04:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA8E3A3637
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 02:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86614F9D6;
	Mon, 26 May 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LqC+tK/7"
X-Original-To: linux-spi@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DFA84D02;
	Mon, 26 May 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748225667; cv=fail; b=Kgj01zod/scQ5skE2eG6tdGT9vqXU5u7tVW9jObOz16/ak8rUXOvUOVGmhN64L0qVBWt/ll+HbazayEtT/VnZFmBs7hM+86auVziYClh7NAt7ku4ox0ay+G1lS/cQaLps0k46YeHGaKmERr7XTU2apnSnSj68/cC3ZWUBwwGSZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748225667; c=relaxed/simple;
	bh=ukOp6PQeW/JemMZ+rLMNRDW6xiqscd08D7bT0LjjvMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTQDnFrO8leEUdckQozcKLa+3J96nWa/GYwXqjzGM8R5WXdotXNyNjWqZnAOLzB59y+MH8WoLERX6aACvg+3aj5AfZCtRg1j4f175wIXNGWvEadMp2oMbD1dPqqoGxtdRPQsFqxoGP2r+y+ZrIe6osLJe5uDwm0bZpZB7cTPnJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LqC+tK/7; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqJnTSOqSXMGO0KJyRDgIodyWVy96JFjBCPOR3TXvokBZtH2s7SjCTN6F47YM82jDH96LBFg6e1lPvkbhaKG8nzpIXi6OAfx9ikGGqtHVDleTu9GSxJ56pLbH1oe2dMKvgKuDG7ddwpq9xXMshn1flSxgJCmj5JUWUbFtHg2YwYmYVLp1cvAUbaZiS2UUi5/6acQWetW99Jhts4TQtRs/aeOk2h9Rq9gxshf1YExBZOk6tj1dI06v+uyqnPL/V62v9I8aIRcEgY3diiuvO0yh0KueY2Zty3At/JvIEVeEkaDsZ8fOhhwU4BQhvs4rZqcY9TCn3HQ5j5DODvKmeySUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7t/3zovFud7KH3p4W1UsPk67W37e2nyxBMjpAKJIIY=;
 b=N4q+Yb4qagzhKY11rHpZNEJrW6UKylr7/4HkDjWXLUxzFv69ezcNHf91qdSUwDvYwbmEQtwhddkGCIP4YZyI7lI14y09Kerrgfo5loT+f9o0MuRPEVAdzVE2wILN77FAq9J1+f7HJTkdNQP5T3f/VMfj6OQSrPdCTkS7m1NCJ2FxHwORtBwyW0b+xY92QjO1DgwapAbDyvKJAbPJkckNK52FBLYoy2QqrR9Yrbw3W7w5n0UVv7Ls8rFR9+wkAVNTxPOPW1cI+9g9fFhjcBOsbu8obs3TrEaEqw3DGWKR/BfSBuqGaHvugWYrxER5TUFYs7QSIh+wX1mDVtHbS9RF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7t/3zovFud7KH3p4W1UsPk67W37e2nyxBMjpAKJIIY=;
 b=LqC+tK/71S9GNTieAxqteYMM5pMump2aa1Xfr0EdQqoq1KWwqFqDrztQR/GVu+q7P7P+8cFETBHIukrTjBw4YTmS/18dGnAddeEdKxuA6qJa8wVUtN9PjMBFRdo1nzojho+F3qtF1UksF3ptG0/lyon6+FkSz2P8pc4UEWL8gYcrXdeKxrY1NH5YIDgZO3Ofq3U+d+1HTqrVOaHT8Lr3z6Mcm35yuEGfoM4dF+ctqp7JzCKIi8ruuJIAN+DBhji14I6N6nIWT++2g5Rr1ADuaJu5LMin8Tz5pL/59nVjAitG1TWEm5R6nCTVleg3ESwqXcgHLx/aEaoij0sikTl/BQ==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by MA0P287MB0068.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:37::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 02:14:15 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 02:14:15 +0000
Message-ID:
 <MA0P287MB226205260B3BE560C6CA4F04FE65A@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 26 May 2025 10:14:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] riscv: dts: sophgo: Add SPI NOR node for SG2042
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
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20250525-sfg-spifmc-v2-0-a3732b6f5ab4@gmail.com>
 <20250525-sfg-spifmc-v2-3-a3732b6f5ab4@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250525-sfg-spifmc-v2-3-a3732b6f5ab4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <28bebf42-5e4f-4ff7-8d44-78b814102f41@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|MA0P287MB0068:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c363e3-187d-40e5-b77f-08dd9bfb0371
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|41001999006|8060799009|19110799006|15080799009|7092599006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3Rqanp1KzdlVHFKRWx2V1ZWcEFQZHVuZzhTYWVWSXZKcnl4OFVaTVBxYnJG?=
 =?utf-8?B?OVlRWkR5cXdEdHRyWnlJRkxWZDFJZXJUWVVQOTRNTExnNlB5SDlIeTYwQW1q?=
 =?utf-8?B?RkdNcVQ2OS9LbkJYcTNyQTFJa3J2U0RlRFBudlhxQU15TmVKU00xb0pSa3FF?=
 =?utf-8?B?cDNOdVN0Ujg2TUxrQ3NSUUtXem1QeHJ1UnhBWEcweGx1bUttdWhLdTI3UlRZ?=
 =?utf-8?B?N3ZpK01NakFpOUtuVVdoVjJYMkVYb0JLcTZ6MEliUjJaeGxYS1BEb3BkbXQ3?=
 =?utf-8?B?bHU4NzlnUEQyYUhWek4rZ2NOVUVwNGt5SEpvSklWVWh6TWtIcEN3bnhRZ3Bu?=
 =?utf-8?B?bHlLb1FZRnF4N21wNW55dC91UVZlTm00Wk10dTlpeU1DakdRMDZyZUNHenJW?=
 =?utf-8?B?L1orSmRzZDFrRXpZUkRUc1dvc082UHprY2d2Nm9QMmFKOTlLcGVpTkpTc0RN?=
 =?utf-8?B?YkpHRWcxWnB4QXlYVzRlT3RtY0VZTjZMeGwrMURKVWh0Sm9OY3RwRmNmTzE0?=
 =?utf-8?B?NUg5T3ZZeHZkYXpMOElqVHRMdDlTVnVZMUtwcGVFWkI0aE1KZ3lqb0lwNUVr?=
 =?utf-8?B?ek9hVXNYOFRHUHpOT0NPVURQbm9nN01uRmZsTHA2RHZhVXUwRnJYQWFUTFR4?=
 =?utf-8?B?dGNYMklEb3h6OEg2QjVNRmxybjRVRmdvK3Z5YWVsQ1BydytxUkNZOTVHUW5a?=
 =?utf-8?B?NGp2UWtQbzVYWnR5eUZUaTZ1cEZRdGY5a2JsR05TcWZQNWR0RUNQMDBINFlq?=
 =?utf-8?B?V3BKRFd0TmFJQWFhOVY4dEgzS3pwMHlXWkM1WjhMM2JBVTJnSDRxTEUwVFN6?=
 =?utf-8?B?elZEd0NnOGx5Tk9MNjg3K2VrR3BXVG84RXdsZnVJcGs3WCs0UHQ2NXlpc05y?=
 =?utf-8?B?clpkQ2NRQ1BPcmRwTHVNWnlaVDV2enlBMnFtUHppVlVEU29FcGIrT3dhNDRt?=
 =?utf-8?B?cDRob1FnVTRZL1ExZU91ZXVwU2Q3YlRGWEt2S09aSWJxYTFBWERZVGQ1aVNs?=
 =?utf-8?B?cG5GTjhRSVFqai9nN0ZwNkRKbDIyWmUrYVErbWkyb2tPcDFsMnAyQnBhM28v?=
 =?utf-8?B?VDc2YVpUbXBvSEgzMVAra2Y1OEh1MEhJZUtBU1hqSkdYdVJ1cHlHK0V3cUoz?=
 =?utf-8?B?bDd1Q0pTblYzazhvSmp0dXZ0Z2xPdHJmNWdkU0k5NFF1YkRPN3VTVDlqZ05L?=
 =?utf-8?B?cWtqTk5KSmJCMHpHOVR5aEIzSFpEMXV6YXV3S3lHSmhXL3ZBeThrVU1DTXMv?=
 =?utf-8?B?cHZPK3p2RGtZaU1yRlhRS05UU2YwQk40b0ZUZmIzN29OKzRDVjk3TjFISG9l?=
 =?utf-8?B?U2NjYUxLbXF1T3ljSGtYK29SRTBaNWJnRmxEWkpKYUljRXdLSFR0dGhZcVhK?=
 =?utf-8?B?Y2Z5SFh5QUNOZmZpbUVCQU5BdjNHcWlFNGg5NU5oZ0NlLzMwRVNIV0pySTNS?=
 =?utf-8?B?N012aFFQT2tZNi9MdlhuSXozRE9Td1YrZWhIRnhYYS9uYmNwUzVUZTZkcGlZ?=
 =?utf-8?B?ak95bDEvZEtNVG0vWmVOeVBGbnRzLzdyNDhKdFNBcm5DUlF3dFF1VWNSejNY?=
 =?utf-8?Q?yhd7Eiiia+9RWaki2al2VOpiM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlF3ZHRudmJTdW9MUmhxbHNxSUx4VVBWdG5uZHBCNGg3SEtGVjdFOW9hMnRp?=
 =?utf-8?B?M21zR3hmbjJpNVgwL0pJaFFUb256RE5uaFZGMnhYa0pEZVhKVjJXWjNSS1hI?=
 =?utf-8?B?YUMwODRoOWxHa3pNamZOSW9KWGg3ZHZTd1JHZGlTYmNvblc0UlF5cGQxQ3Zz?=
 =?utf-8?B?Y0YrWFdFVWVKaEVtSzFKK3VoZUJwTkxiZE5jeU83MDhSc1M1YmRYOW9rbE5D?=
 =?utf-8?B?dzVqZTF3RzdxeUxucjJkUjVORDhnYUF4ZFRIU2h4WC9iZlJmUjNRbnlWdnU3?=
 =?utf-8?B?eDVWUGdPNEVyZ2ZBcGJYVjFZUnpGaldMeDhrVk5oa01wT05ud1IzNS9Sb1dG?=
 =?utf-8?B?ODAwckNjOGVsVjU1VWR3UHRYbitXQTNtWE04bFU5ZFdmOGxwWkIxMlo4VjVs?=
 =?utf-8?B?UTA1RzdyRUpDRG44d1RzWW40ZVhoWElxL0pKVFV2bDlBR2JKRkFUMCtFWG5R?=
 =?utf-8?B?aGNWRXhVMUJ6dUI5MGVCcHBWNWUxeTlHbUQ3QS9tdGxEL3VITmVOTEtOVG1o?=
 =?utf-8?B?cTViMHZRMXlSb1pCWnp6MXgwcmpXZjcyNlBuL1VPbTkxcmhRWkZqTlJRZ2VQ?=
 =?utf-8?B?ekYxS3dFemhsMmdPWTJHSzg1SzFxb2E0RU9KZmdtYmtGQmJUUysyOEVMSk00?=
 =?utf-8?B?Z2JEemE0TFV5SDE1NFBJV2V1TnhiR0wwNC9vRWlndEZFTW1jZ05yRUlrOTZQ?=
 =?utf-8?B?MVlTTCtmYkJ2MDZJL1VtNG1qRGRvK0Z1Rlh0aDNIYkhGRFJXQVoxWnljWnFU?=
 =?utf-8?B?Z2JvR2VPVHR3dW9pd0tHTDZYZnRMbi9yc0M0V2tVbW1lRVJsOHZHc0I2SVFr?=
 =?utf-8?B?NmE2dnVhQTgwaENJZkxRRXFqd29qbkFNVDJSWnNLOVpEaGg3VE5wQXFXK01x?=
 =?utf-8?B?VjJRVkJYQTlUNXJ5dVpybHNRdlh0MGdHemFSSmM1cGJzUkFPYno2WVlFNEt6?=
 =?utf-8?B?RWY0bW9vS1lsOVQ3VVg3NzhYL0hqbnRnWUxaZHVST3NtOHRtZERGYjNKSUI2?=
 =?utf-8?B?RkdtSnlxU1BCb056SWZ2RDRSVmdiSFh5WE4vdy9ZT0tmTTVGaEh2MUQwL3dv?=
 =?utf-8?B?NVFzdHNTMmRZdXVjbnpCTDMwd2JtU2p4NnV4VE04NTUwQko2aGRFVmpYcWhm?=
 =?utf-8?B?SVVFUC81cU4zRE4zNGNoUlJyT0dYV1UxUm1JVUJXYXVrNFFtbVE5R3VSTDBD?=
 =?utf-8?B?VDlML25sS2VyQlBuY1Z2RldrUCtqenNXcDIzU0lqcythMGUvK25TRWxCR015?=
 =?utf-8?B?UnJHV1ZpVko3K0Y1QnUydTJFdWI4enlRY3F0N3cranhUdHlsYWxuVFQxY3Jp?=
 =?utf-8?B?bE9CSmJWMGowOFRyNVNhelVWaGpld2ZXemNpZk1NQkd0R0tJdWtuVzBKeGRJ?=
 =?utf-8?B?bXpXYUROYlIzanE1YmQ3eUNLNm5rVm5LUG9ScUg0clpkc014ZHM2MGYzSUJP?=
 =?utf-8?B?YSthdGVRWWpROUpmMUc2WEJibHJ2K2NuMUs5dFlZdzFIWTcyWXpEQ1VkUjJJ?=
 =?utf-8?B?ZkNwT04wRmdzcVFsenYrWEdoK3pFOEt6biswM05LY083S0VlcXNnd0JyTW9y?=
 =?utf-8?B?ZTNLOXFid0Q2b0lEa0FaUlJKa3VuTVZoaS8yNGEvbHZ5YlhVYkhYaUg4N0hC?=
 =?utf-8?B?cng2KzdiK3ZaWjN0TUpIRlN0ak1GMi9QUnRqL3RWN1dQakNSZVJZS2NwVzFh?=
 =?utf-8?B?ZU9FNXdNb0YwcU50aTZDeFliT1k0SDRBeUpvbHFxdEhlNnB6N01qMW8xUlFv?=
 =?utf-8?Q?9E6Fo3mipprKyNacL2UrcrF7VGoqQRuSjBTOc4h?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c363e3-187d-40e5-b77f-08dd9bfb0371
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 02:14:15.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0068


On 2025/5/25 22:58, Zixian Zeng wrote:
> Add SPI-NOR controller and flash nodes to device tree for SG2042.
>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>   .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 18 ++++++++++++++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index 34645a5f6038389cd00d4940947c6bb71d39ec6f..c59a819e35d3201c484bf98392aec14392a7eb04 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -68,6 +68,24 @@ &sd {
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
>   &uart0 {
>   	status = "okay";
>   };
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index 212a3edc73fd654de59e10fab2094af2fec7f88f..06b433d5949bcc2374ea90223ff2d81434fad2b5 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -83,6 +83,30 @@ soc: soc {
>   		interrupt-parent = <&intc>;
>   		ranges;
>   
> +		spifmc0: spi@7000180000 {
> +			compatible = "sophgo,sg2042-spifmc-nor", "sophgo,sg2044-spifmc-nor";
> +			reg = <0x70 0x00180000 0x0 0x1000000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_AHB_SF>;
> +			interrupt-parent = <&intc>;
"interrupt-parent" is not needed, because it has been defined in soc level.
> +			interrupts = <108 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_SF0>;
> +			status = "disabled";
> +		};
> +
> +		spifmc1: spi@7002180000 {
> +			compatible = "sophgo,sg2042-spifmc-nor", "sophgo,sg2044-spifmc-nor";
> +			reg = <0x70 0x02180000 0x0 0x1000000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&clkgen GATE_CLK_AHB_SF>;
> +			interrupt-parent = <&intc>;
The same question listed upon.
> +			interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&rstgen RST_SF1>;
> +			status = "disabled";
> +		};
> +
>   		i2c0: i2c@7030005000 {
>   			compatible = "snps,designware-i2c";
>   			reg = <0x70 0x30005000 0x0 0x1000>;

Othres LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>


>


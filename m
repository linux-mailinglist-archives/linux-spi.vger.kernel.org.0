Return-Path: <linux-spi+bounces-9541-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A698B2D70B
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A675A55EC
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8392DAFA4;
	Wed, 20 Aug 2025 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="KHRg5cVi"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020092.outbound.protection.outlook.com [52.101.84.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA02DA750;
	Wed, 20 Aug 2025 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679801; cv=fail; b=nJeyNvEmF1iGj2Oej3ZY3stGAEm8RiyGjIrEtZUYGC1YFM3UHOSgBIAyVMdGjYcumkTGlaNA/Qhrdn5YVDFoN0xB4GhzEPocgtTqk51cithHTpCuoOtFUcOkZhV4BCDWsilW/UAKBwrQLqTYosnynFAt3VtybXgkhZYwhYcsaxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679801; c=relaxed/simple;
	bh=L2vK5REkIDjVGERzJ+8VooD7eVde4KnKk926Dhaygu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WmscoxgLq8mP/49zPNp4E+pwDrJodFwqR9UYsVHqe525X7EYeZqlpBQkiFjPsshnA1CIAI/IvSZ9ebcAEsyN256rXmC1am59y98tH4QZi8FampYg//hU4/VXQ1Ctct5pkMR+mUeqTKDJfTJwDdXXBRUcAGH8/+UYxzt83/dkirs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=KHRg5cVi; arc=fail smtp.client-ip=52.101.84.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZKrtCMz9wLf5WPAcQQW36QwgQ69ZABCrTleyJPQTldLvaXa3ZnqzfeUeHPjzDCXxLgbDTRKuJZfSW0UZcdGPawdr4LIWH8c04Y348bvzyG+6U9bMZccFdbQ7s+AtAOdq4TiCBQQ06TaJgxE9C60cnUNeXTpJDq6dpBObdedW+ftcwRknTAl2AGt8h+ZAbYLOnkuOlOIk1fuOgA9fFclBT5u5Us+L2mIZfAdpmLvC8f+qXlAat/ZT3Is27wZmJmjZ8enJcHbzM8lvIFoghT8vXZ7sB+dAoFXRKuQ1LxGN46Mfdg6L2Mbz9rsBd3e+V0udGDuDvol7QqTzcZ8bgKUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VZXm+KH7V0rNXRPDAVC7x0zMt0ag+Vh5/3pAlVKoy4=;
 b=eylHtAKgnqEEdPc2VeDfG0DJWZxG5H9P4O+nzoDhWRwtpvTNyNe6r534saMiwG5ynDmRsSFFwh6/7nFLXANb+LxdazBUNfG+4IN9i9K8RyJ3qA2/koCrP5b1fpd8mxlAQAnaRwggnteClRLDGLbP3DysVK5chySSFQAIYLNtHi0MJOIoqvwBS+v9d/0bKFKxA3vWzkvxeqvbm+r4tZ52cO/tikm+ukc5ZNoG3Wy8ZJUDwHQVMHW/A7qwXoK9JQ6yInsyUoevIm3wV51SnSJJq3yAMeeArdQpmp40bYN0otKp35ih/mW4KqSLmVfaEGuR0cvlmDycvWo4VR+t5cE98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VZXm+KH7V0rNXRPDAVC7x0zMt0ag+Vh5/3pAlVKoy4=;
 b=KHRg5cVi778qmfsaCuIsPf5LXKWrYbB1RSf5eFMEi16QblU8qCcz7WO0XlM5dH0ZMYGaUsDNMMqUUX/nFwnkJGHDp9IKs6Kbuqi8VpdiVEQ6QFZN8SIHJecHoR1xQnMdO0g65JUydFTYekdgwnLOQlTU9Q5tqxLQDNJtPj7hN21Ddl8SgEk5he87K+H4/VTR2nysVq2wxvMg/mX1b4rjrFB/tLP0PBQkLuC0E5tjSppRTWYh4blaHQsnSVt7azSgy0n54xuqKGnzcBmrbQx4DWRB+9MjsTghDrceGAWeDYT5FFsbrzowHgdvzusEh+UCgZRxB4DyWcZdn32jyUfSPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS1PR10MB5746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 08:49:56 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 08:49:56 +0000
Message-ID: <a18185a0-407c-4a1c-b915-fec9b3283b87@kontron.de>
Date: Wed, 20 Aug 2025 10:49:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
 <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
 <78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
 <e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::11) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS1PR10MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 52271acf-3399-4547-3e6d-08dddfc689b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnNUaEdTYWlNYTdiWktOZ0UyOXhuL2JzcEZPbGFaUWxGRmNqc21uMUplOTdP?=
 =?utf-8?B?dTF0STUxTGswSmtERnJmczQ2VWRKaVJHUDFrei9sMlJ0Qnp3RzRzNzJWS2tV?=
 =?utf-8?B?ampzUEZIZWpHV0Jta0IzNnlGbWlITGI3aW1tRU9wS243c1M0elB5VE4rWGtq?=
 =?utf-8?B?eTZEckJZTno2WjNxamVjdmRlMURadUNLSlJvd3B5blR2aVNVcUVpbWVZTlBw?=
 =?utf-8?B?akZiNExNSk96enVET2JjTlcwRlBRYzNPMlRET3lLR2gvNzF5R1hiTDFqOU9J?=
 =?utf-8?B?RWsxOHhhU1ROczB0bysyckg2ZmUySU1LWHFGVExHZGc3dlVZTzU4TWpOUC9a?=
 =?utf-8?B?cHpkZGxTNnlnd0RVcmlTc2FTRWd3L0hOZ2kzT2pteW5MM1VYNUphQktQSjRB?=
 =?utf-8?B?SjBBSDIyV2NuMHR2ZlgxZHNYWklyK2s2T1FFMHZpZ2xrVEZmNkJMcnNHallm?=
 =?utf-8?B?eGg5eGhlcit5ZmQyWTY1cldLNEhJTkQ1QTR2ZmFCSElGRDkxL0t6ejBsSGp1?=
 =?utf-8?B?RDJydklxYmErdnJ1aEhUd3J5a3Z5bFh0MzN6SEVCTG1FRFRsYXl3KzdUK0hw?=
 =?utf-8?B?Zm9jaEVqWENPUUhENHVOdXZEMGU4SnFDTTlUVVo1ZzVSYnZBR29KaHQzY0dz?=
 =?utf-8?B?bngwaWNmTTJVY09Ib1VkNlRMbVpCK2R1NU12STRBNzA0OGlsZDhLL3dBaTh4?=
 =?utf-8?B?V3lRRDRBTys5bHJtUkNmZk5qbDA5Rlo4REl3ekhiTjF1THgvaDZkaXE3Z05Z?=
 =?utf-8?B?cFZJUVRBazhyVU1yUjUxa1V5bHFPNG53NTMvc0RacWFIMEkvcVRUOHVNU1RZ?=
 =?utf-8?B?RS9HNVhFd0NNL3hCYUhub2w5dlRPQW5USkJ3TjFVcExkSFlxKzNZVFFOcUdM?=
 =?utf-8?B?WGFDOEszZDZkMTVCek5iWjYwNXlBWXpOOXRRWmVvNDBNdXZwMXlvOUx5WjR4?=
 =?utf-8?B?L0ptMkh3aVlOK2piU2NCYUlFUFhuUnpxYllIL0doQldnRHVGekgvWTlYWjJw?=
 =?utf-8?B?djdYV3I1djAvKzljbEtETnJTQXMyYlJtR1l6TEhHSEx3SW0xVWRvQ3c3V090?=
 =?utf-8?B?cnZyWnVJcDRUMUZJdUxpQzZ4YmJVaHVyREVmZkFycFV1WVlhYVZwbEJjSm90?=
 =?utf-8?B?RTNIZVRvWGJ4Wit2enZvSzB5cTNrODUvZm10a3lqT3NDYkRGYVNEN1o1bU9T?=
 =?utf-8?B?bnJ4cDJnRkZsWExFVm50MmNocWZBOFNZZUJMSUtkR3ZIWTVhL2lMNUcrVDVK?=
 =?utf-8?B?WWptd213VVl6SW5udUl3b2hKZ3NHcFF6Q2lQTG83dGtOeWpJZyszL2NwaFhU?=
 =?utf-8?B?elY1TGdQR2NNbk9HN0tvU3dVMEJ4NHUwRnRpUlU3bU5EL3kvblc5akNVNXdI?=
 =?utf-8?B?bURnTnZZa3NzaUV1V3dnUEZNaHRMN2Q4WE8yTm1yYlR3UVBPYjJWejlZVzhP?=
 =?utf-8?B?K1BXZ0V1aFRia0ZTZElpU3NiTmtLTHNLbmRWdTJhbzdEQ2J6RWZvdkRjdUYz?=
 =?utf-8?B?bXFQNUxPdHBJRWFJNDYrUXl4dzFIbXVZZDY3alZrdDBMQkhFU3psUzRPM1di?=
 =?utf-8?B?THk3L0hWeVFVUjlLOG1TVHAzT0pKM2hlQk12T3V3TWxlcVVldUdyVU1Eb1Aw?=
 =?utf-8?B?d3MxRHBJVm01TFpNN0RkWDZXaXZFTWY3YXYrYkdMaTNkSVY1REh5eHdZK3do?=
 =?utf-8?B?TkoyUk9rNHYrK01sSVBGQ0lFcW9NMDRreGNHSVVnN0F6eGpPZ1ZIUVAwbnJW?=
 =?utf-8?B?WUVKZzZJWXVxSXRFc1hycVJmNGN1WnBsWG1rUWU3a3hXc0JRWTV3L2ZRYUlB?=
 =?utf-8?B?ZUlObmNYTDZmU0YrRGFRV1Qzc1dKdWFPNG9qR1p0eURCMUhHN1JkUThFaFJt?=
 =?utf-8?B?KzlWbm5qbnBGNlB0dStqSndNekRJK1N4NGxNelduSGsvbXg0T0Z0L0ZLOWRP?=
 =?utf-8?Q?qObN1clY/YI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUtHMWpVck5jTkpXRGppTmt1ajFmR3ZZNCtKTklHOVRBMnNkQnFEQmJnUEgy?=
 =?utf-8?B?NCtwUE5ET3R5bHdyUDNubmFhZ0JNUmY2ak1TNmlvUExrSWtJcVVBTzdpVUhM?=
 =?utf-8?B?SEhES01iNDluVVI2ZkROUi9pbnNnQm1WRE1FUzFRa1ZlSU45V2R5aW15OUgy?=
 =?utf-8?B?QktSZDdqeU42REVheG5sZk9PejhINnNDN045R0Z2N0FlajdOTHU1aHJ3cVpV?=
 =?utf-8?B?SFRmaDAwNDNQRTViSE8zdW1RYm81SHprbURlbE15amNBbUwvTDlZMVJKSy9L?=
 =?utf-8?B?ZS9zVUllb2J3Tk9JeklyUm9GeDVpSVZkUVRLdFVBZVBVOEhYL2hKSENTdUp3?=
 =?utf-8?B?L0JsR1lmZ3VNdXROeEVhK2FiVDJoSjgvd0NwazArRmNVRGZhbTgvQUZvV0c4?=
 =?utf-8?B?dE9ZcEZmQ0NNaXFNSTJoUXRLbmhONjhkeXBWVG8rUjRoOVkrS3RUUUFtWGtj?=
 =?utf-8?B?MUFzYlI2SG15bW0xQWVjNFRlQklBUTNDRGpyaklWRlU4ZURvVjZMRjQwWDNU?=
 =?utf-8?B?QVloOVRDbXl1QzlIL2pwRTBKS0NsRUdHcVVaVGUzZUJFVmduZitTQ3RNR3p3?=
 =?utf-8?B?UEtKaTAwcHc2SjI1Sjd6RENxMjRBZzdFVEVmVU4xSmhMOWFrUytVMGtzN3Rl?=
 =?utf-8?B?aEtPaml6MjNLZkVjRU94Z3FnZUtxSmZPOEptQkRtK0tQcXQ4KzJxS3pJakd0?=
 =?utf-8?B?QzVyYTY1NWd0cjFVMDh2S3NqTy8xcFl1MkFvNXZpSzFNbFRFNWVZNjBhRDRY?=
 =?utf-8?B?akhjYmlvMjVuNE9qYldUWlVaZjA3NDh4ZDJKSDNCZk83Q2pyZzh5Y2lRUXFo?=
 =?utf-8?B?MXVEWUNqS0VaU0JlZitLTXE3d2hrTjZERWNOek9zRGdrWjlBY2ZJRXJkNFVB?=
 =?utf-8?B?UUZrUWJad3djR1NmL2Z4M0xIOERhaEI2NnloOGpZU2VEQ29LMS9qQjM2dUFD?=
 =?utf-8?B?dHoxQVJGVFdrSGhHdkVYNk91eHRiMFRMRlZHYWpJUTc2MG5VNWZ6WEozMGJH?=
 =?utf-8?B?N2VyOWVDbE5kOXV0REZqRi82S2FJSEs4ZXZWNXpOcWtGVUNQMEZPN1BYTDFV?=
 =?utf-8?B?VjZJVE1OeXlPSzdTc05OdlZTc0Rxa3UxeUxoaGpwUmJsUHNWQjZUSHpFMi9x?=
 =?utf-8?B?RkxUd096QkdzaVhwM1gzcXljQmNHVWtNR09FTlFoS1ZZYllEVDdlcDN5K3ls?=
 =?utf-8?B?dDhkOEFPdmY0dlBXNWVVcjJTbG83THFzdHhtMFFiUWpvMmJEUnB5TXVPa0tE?=
 =?utf-8?B?NWFlRWsrcGVIMVpSVGgwZWhNMGIrcW81aVZHUlNZM3EwcXN3ZmZvaHhqYXd0?=
 =?utf-8?B?ekYrNzVua0JacytuRk0vMjdtcDJxSFNYNTErZWpQSWpScE0rMmNQYXFQekx5?=
 =?utf-8?B?YWsrc1hUdGtETUJmV3JyYmVzY3Z4YnZvUm5aZG5weWkrWEd5OFZwM29BVGIv?=
 =?utf-8?B?L1pYMWE5a3Q3TFBIcUpwZXl0cEcwQVhpS2tOVThCVjJveGZxRDAyQ1lCT1BH?=
 =?utf-8?B?ZEI1OWo5RlVjS21CQzFkZG0wQi8xdzEvcllWbkgwdkVZeS94ZmFhMUxyNGhM?=
 =?utf-8?B?cEJRS2Q5OFB6b2E1dzdzOWh3R05WWnJIemtKUCtWVGpxWkVQd2pDejU0ZWdX?=
 =?utf-8?B?cnBBRm4yQStRYVJ1ZTcyVERUNDJHSm5GNy80OFJNL2RLQVRvSVFwNXh6elhl?=
 =?utf-8?B?NElMYXo2cmQ4RFd0aSs3SVlLWlFaMHF6cmpTcW9WVVBSRWM3b0JPUHc1MHBq?=
 =?utf-8?B?ODlhT3ZxVWwvK0hWR0FYZGUvZW9XWlZLdFYzbU92NkpUNm1FNkdVUmR5YWtR?=
 =?utf-8?B?NnE5N01zTmpiVVRPZGpDTVAyT1Exb0xOcVJhNERTS1MyL0dZMjc1TmlBVzVy?=
 =?utf-8?B?bkM2eENBYU4wOWFVUm9YL2pRTUQxeUhoaVB6V05tVlMveVptOWYvbjRCbjUr?=
 =?utf-8?B?cEJkd01oWkhZU2lNRVlWNHBWc005S3I3dE1LQ1gxQzNQanR0UkhSRE5ZdjZB?=
 =?utf-8?B?cnFoQnhsZkd2ZUpqeGpPNlZ2bUI1WUYzTlo1bERKVzBQcEtPQmJYaGlVVjZr?=
 =?utf-8?B?UDFXMFZRdUNZNVVLRUVGbklIckx3cmZtZlJ1NUl0SUwyYTcvZXA2RW4rYkc0?=
 =?utf-8?B?RThNZ0s1Szc3TGxISUo3dUpjcHEvYUUxTzh0OGV6V1ZrSXR5bEh5UzJwVWhN?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 52271acf-3399-4547-3e6d-08dddfc689b6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:49:56.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYvuKGIyG59jkC0ajrkSD2Olqifowwpo2vWWtToytKILx+JeByspDG/Wek7LXE/8OR3wf92e5dcAx3TBFPppJ28vmcVBboI3t6IbuA47Wyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5746

Am 14.08.25 um 17:33 schrieb Mikhail Kshevetskiy:
> 
> On 14.08.2025 18:29, Mark Brown wrote:
>> On Thu, Aug 14, 2025 at 09:54:23AM +0300, Mikhail Kshevetskiy wrote:
>>> This driver can accelerate single page operations only, thus
>>> continuous reading mode should not be used.
>>>
>>> Continuous reading will use sizes up to the size of one erase block.
>>> This size is much larger than the size of single flash page. Use this
>>> difference to identify continuous reading and return an error.
>> This seems like it just applies anyway regardless of the rest of the
>> series?
> 
> Could you provide a link? I do not see this in upstream linux repo.

Mark asked if this could be applied without the other patches of this
series through his SPI tree and I think that is indeed correct. The
other patches are still being reviewed and applied via the MTD tree.


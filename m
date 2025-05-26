Return-Path: <linux-spi+bounces-8288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8CAC37E5
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 04:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF01189257E
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 02:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484D13B7A3;
	Mon, 26 May 2025 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mqU9FqIo"
X-Original-To: linux-spi@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011031.outbound.protection.outlook.com [52.103.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906D1DDD1;
	Mon, 26 May 2025 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748225473; cv=fail; b=BhfmWrCNagQTmL3rRDXo7ZQuRZ3bcvG1aCcE9AiIieoUhygjyYyQ2AQ5aRrnXoF6YWlrnO5m1gX0WHClyNVFLAQCLFDTg0cobIzhFmLzfGXgt8U2RGFn7DT4eGERtMdBOQmfedMFKGVnd0dJ45LUYbcCv2byHwNmCen6mAgmZqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748225473; c=relaxed/simple;
	bh=d7gHhDzygLzkqSiQHXLMo/5bbTB7LxdsFv4g4hfuAtQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hulrfebBY+vuBmudduqgws6JNhIrykzbcW4V00ASHlM15IAW/G5bvcWw6GUjvGJ5aYPhDfEGRQcWthOZyeC3DdGCmpYd6PLquBou5d292JAgwo9VcH7HX04Be88S0tKkqediv4SeG4fny7LclV1LxLEiGvDCxCsT0BsFJH5R4/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mqU9FqIo; arc=fail smtp.client-ip=52.103.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBqOoKpmVkYbuxzsBBA9IZqrqNHvp57V9+Jwkaxkg/vjkRWzanM8c6ykohFEe55qa5d4IxMHdsxQtw6e5BF8rJfvcesbRYS0+Rbg5GdOzNQIefwNYKksZEIoekhFK34bjJt9gc5zLtaZztmWxIk2Nz/3m6EaqiJ0Cgdxr57i1Pxt+3PCpMyBuvDQY5jJG81FUf3yq1K+j/fn3GVB4q7HtOPVg61iA1BEVyb++EQMDCer/H9dT13F8RzCdflAOUMGYv54y717rbw8VxNrDzDIbu6d7Y9xLyujcMgG34207tE14BYVqvBsBcSL1pDDMj4aW4KQg6JWL/k8KndlZYtt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B2rx58/mwRIVLhg2VHc8+0iDwd2EBq5fE424aTq4tU=;
 b=Y3UN/BkLzYcOWvbLTJR8hou3lKuO2GrzuqPAvsDX79neTdPRaqf/4PGu3JaIrsWlSA3xDb8RwVlW4RvJh6OignXlKlo3l7+PF7vT1CBM+kgTPA+nbHDjHZkmjzzydFWKKTnECti6tNzpKMNIbAFrrV8iUpSys2dNv5gRrv7nzLGWRaA3VxMy4PuW4TjgSlvJ5HB1B1e0M0qWgf2RWiEic3mdH9dNtqTVs2o13qLZUrOvU+ktPyrQnQe7F/ANQ0//SLR+hE1Pa9YfH98Q6kKTWqC591ByAYi58MzBHpuea9+nGrdskdelA3OvRsQ4TmXhe2glBgc95o1O8ODmgQR/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B2rx58/mwRIVLhg2VHc8+0iDwd2EBq5fE424aTq4tU=;
 b=mqU9FqIoqivdrAOPyg8Aw5aK7NA3piYNDFBjgK/des0fJwX4qWJvKD8MtWF5Le5jGrvGWKIDoNk16VBl9bTafijDjh8w5RmoZLh8eO6yDkMEksb8MDUH9+LFo9KKYtfPojw5e2OYzSmO7CeNpDr/E9IKd6ssbMpW2sKsQWCFI2qtvYDaaB8WqNUEf2LS0SpljHlVGMRq6KUqbw4XLHM+bW9+omL4Q8VJDvun+K0EJ4qOWGgSZ4tKOtEnCCLyPkAe6rudVXRilPmidxaSCwCggBaysjQt5mtYjSNRKIX98VRfYQ851NVBGla7TdaBh6Xv0Sg3y69a+zALgcUs+SwNMA==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN3P287MB0100.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 02:11:03 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 02:11:02 +0000
Message-ID:
 <MA0P287MB2262566E644CFD5926934146FE65A@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 26 May 2025 10:10:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: spi-sg2044-nor: Add SOPHGO
 SG2042
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
 <20250525-sfg-spifmc-v2-1-a3732b6f5ab4@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250525-sfg-spifmc-v2-1-a3732b6f5ab4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <ce80430e-9948-4298-8328-ec1b235a2db2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN3P287MB0100:EE_
X-MS-Office365-Filtering-Correlation-Id: ab337aef-3c0a-4884-f345-08dd9bfa906f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|8060799009|19110799006|461199028|7092599006|5072599009|6090799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnFIWG5NQ04rWnJBK3BTRmRHdTBFNlRVRkw1SjIzbVMwWGNQUlRZUDgvYVgw?=
 =?utf-8?B?cUZzQ2MvWmJUMjFUMXlPYVk3M0VBclIvZk83TkV4VEFmRXFrR0JiTElSaUxN?=
 =?utf-8?B?VU5GTGY2Qm9Qd1laLzJpV2JuNEhpZUZhakJIa1hYejlzZy9vdk9sODVhZTlN?=
 =?utf-8?B?MjZSempuVXhmTE5McVQzUkRwZURTQnBqZ0U4YldIL0xmeDk0ZS9tcXBpWDAz?=
 =?utf-8?B?eUtaZy80M0kzUkVBb0F5Vk1leDA0ZDJ4aVVWU0J5bU5PYXIwM2hQbXNLMGZB?=
 =?utf-8?B?R1NqcVBoUE1vTUwwYURhaldIUFlIMkVCQmV3RTdwOUVrSVdvQTI1VmxsVWJB?=
 =?utf-8?B?SDNEdVQ2SVVaclVZQjFTeG1PcEFGc2l5VkFVOUNPamZ0eVpjYXhoUE9UTjdY?=
 =?utf-8?B?UU4xaHo1a29TdFJEdXZKUGFROHF4OFZFbFR2NnlJMVJJeEw3TXJjdkRiNWpW?=
 =?utf-8?B?WGdYWnc0RkVDSVNaeisxcWlOZGIxQkJBQ2VCZlJGRWNxLzlBc1NTckROa0hM?=
 =?utf-8?B?azk1bVp3Zmx1cUdwM3FhQTBPWHhYMTlKUklEMmg3aUZIRU5yTnR4M0wxZVV3?=
 =?utf-8?B?aWFxMVc4WDU2ckJuS1k1aysvODV4d3JJQk9yTUNwQ1JJWC95MmhKMlkzWjBk?=
 =?utf-8?B?bWZpU1ZQUHQ3M2ZmZ21Ed0NuQ0VJQm95eDdLVDFPK2lqMlBnOHJxSXJmSUdm?=
 =?utf-8?B?TmdFU05PZ1htNDlnclYxK0QxV2JNMGtJR0ovb2VLemlYcE9PYXkxTUFpZXZ5?=
 =?utf-8?B?aFFrdmUyRXRUMFJOajJEaVRkRUE0TG1YK3pQRGFCK3MzcEZWaW83UGU3eWQ4?=
 =?utf-8?B?QUZDOTZIOS9OZmlUaUc1d09WM21GN01IR2ZoVzAwNFY1cGN0THo2RzY0QVNs?=
 =?utf-8?B?ZVQ3VEFOYUxsUGpOVVhmQzZLeGxrTHgvcmg3Qm1ldmZiTEsycE1FUFA5RVN0?=
 =?utf-8?B?ZDUzbDd1M1BDdE5UVGhWZDhCZGxUZC9STmgvWlUyM0toRzJhN0JWczVXUnpX?=
 =?utf-8?B?cWg5L0Z6d01LcnppbVQremZsb0ZhYkRsZFZQeUNLekxXOWx5ZER5cTl1TG1m?=
 =?utf-8?B?c04rNmhYZVc0QTNkeE5Na1R4K0p3UU1GeEl0LzZzbENseENtWDBQUUl2d2Rt?=
 =?utf-8?B?TVptUUlqa21GbVlKSm1PR3lNWUFVU1oyRjZ5cFhjOGY3aUErV3hCUERleHpW?=
 =?utf-8?B?QmRQcDNOai9UVG9FWElleUk0eTl6TU9hYnRJb0R0MWFqUERLZlMzSjNLZ0Fp?=
 =?utf-8?B?OVIxRmg3NkdpeUFjYnJ5cmw0b09rS0FCZmxmZTlYOWduaFE1MVRNTjd3eENX?=
 =?utf-8?B?ZkZQejZlcWFWSHI0ZzhsdFU4MGY5dk45ZXk5aFJjWElWRVp6VThKOUpXck9a?=
 =?utf-8?B?U3dEUTFtYS9XVmFCN0ZnSVlaUXN0NEVxTmpmU1dVRjBzakpOMkxOYXhWbUlp?=
 =?utf-8?B?YkR2eUtldWVHSjd5Z0Q1N2lZVjVCTXNGUUZYN0dUbkUwZnlTc2tvQW03Vnhq?=
 =?utf-8?B?MzhGdXVuazl5RGp3bG9jNHpSU0NkeFBmL3BTOXk5ZllkMU43S05LUXc2RWhQ?=
 =?utf-8?B?RmErQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRnNmhIMkc1aHV4a3pKUUhxODlwaXRkejlVSFV6WTE0STlmOWVicnI3blFG?=
 =?utf-8?B?Mkloc3U5NkR5dnFPaTk5d2RWZE1MZC9PWEVoY1JUTWZaWkJOZ1Axb29nUGhL?=
 =?utf-8?B?YlprRnppcGFzRDAzeDQyU29xY0lUWEoweWU2Zy83ZjBlYTFDVlRqemtqYURC?=
 =?utf-8?B?Ui8vdHJ4U0h2a08yOWE1d01qeVJNNFBZa3ozYVlSL1hGTkVLSm5IRG4zd2M2?=
 =?utf-8?B?ZndUL2xPOVpNb0J6U1pYS0gzb2hQdUtkN3o4QzJTK0FLMS9FQzE1Z3EyaVJR?=
 =?utf-8?B?cUMzNDhWVElhYUszdU1jUmQ5U2VlSHNWUmZoMDhia0FSaVFqZ0dWb3NKRnll?=
 =?utf-8?B?NWdyVHpwZStMd29QMDhzS01tZElrQnJWdWdFT0d2dlNtdVc3RHVwY205anV5?=
 =?utf-8?B?cUt5Q3NrdzQxRjh5QmFwU2w4UkJjY2VtbzNZUW92ZlFVVk5jdEtCMFNlQ2l3?=
 =?utf-8?B?OHk4d1FzK3Rzc0FnUytTSXl2R0R0TVdhUTl1bEpiaFJEaGlVS3c5VW9uL2lM?=
 =?utf-8?B?azR2ZmloSHUzNzRUOEhXTloxVE9xRUJZT0ZXSng5OFE4RFJPeFBjT1VCY3A0?=
 =?utf-8?B?Zm1TeVVHUEtFUEI5bU5PeXN4UXBTUVhRZ1duZks5c29iT3lDVFhYNjV1S2ph?=
 =?utf-8?B?Zll4dk5kU0RzVytUTll1eVdWUm5uMjdMV2pPdGlNQXpkTmhaQm1uU3FOeTdw?=
 =?utf-8?B?SkEwYU81ZC91SzdNWXgxZXJGampsVUNpQ2ZVVGNDRDd4MktFYnlvRnphU2t1?=
 =?utf-8?B?d0FyUXFlRFdlekNhUWt1TW1kRStob29STVpQSnpPNitETVg1c091ZG96bGpG?=
 =?utf-8?B?N25wTFdWV0djVG5kSEtuMnRkSzFIVVhJQ1N2VkxTTzgxenJnbi9ObGRzVitu?=
 =?utf-8?B?NHc0M0VMWUxsR3hiZ245QjFNRmtmUlA1RUJzanljZkdYMG1lRjNUZEg0SkNt?=
 =?utf-8?B?bmNscjlFRXRFdmNGNkNvcFRjOTJEbVh0bGVIZnRiM0FWL3NmVTJ1OUtuSXU4?=
 =?utf-8?B?NVlpVW1naFpmc3Zrd2NrOS91WXNUNnQrMitmM3Bqdm96NHozQ25rOWlVdktV?=
 =?utf-8?B?OXdjY29zRDFXa0ZPbG1HbGRDVXVSbkVEbHFrcER1WU4rTzVabTdjdi95R1pJ?=
 =?utf-8?B?NXg2S2VXaEpheWh6VDNnTmVLWmt1enB1MXdTWFNHV2F6WW9uajFJU21TcUdq?=
 =?utf-8?B?TCtMaWFlUjZma0EwckZiR1hhS1V0UTFGd1hERVU3L0k0eEd1YmRxOXJpdmFv?=
 =?utf-8?B?RFdyUzY2MU95WlZGejNmc3dqaTBGTlh6MUVqYUVCNWlqYUx0Nlhsczd0ZTJl?=
 =?utf-8?B?bHBMaGtleEVtTmpQRC83VnJsUnIvQXhJUm5KNHY5VC84OEVwR1pDWWFyckw0?=
 =?utf-8?B?ZDhvWE5Xa1B4Rm9zSlJGYnJpS2ZwZmpRUXlZTkpXVXBXQXJNUTVaZlhpV2NX?=
 =?utf-8?B?eEZFWVU3TXl6VmREZXI3OG50aXB0bWVvYTFSTzQ3a3VFbVB0TVZ5ZThXRFM4?=
 =?utf-8?B?aE0rek1xRmdINVdlUnlhdWhlbXlrbFVnMzlwWXFjb1NmM0g0NSttaHVGOXlR?=
 =?utf-8?B?STNsOGZKSmhjd01kWUkvbmc5YlZVSzFsaVMrZXlsYnlSZDV3TmhVVTdXNG9Z?=
 =?utf-8?B?V0h0NXRkU1RjSy9BYk9DYW81SlA2TXNBUzM3VG85a3FyaWZMZkNkVWpkekRX?=
 =?utf-8?B?MUdRekVvTk5tQUdEL3NwaTVQNHI3Yk02d2FFY2lxaVdjOG5NVWlPc0UwZjJq?=
 =?utf-8?Q?rScL6QUkvGkbYEKHvC5ctPuTx0JkSSGVNIWS3ke?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab337aef-3c0a-4884-f345-08dd9bfa906f
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 02:11:02.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0100


On 2025/5/25 22:58, Zixian Zeng wrote:
> Add bindings for the SOPHGO SG2042 SPI-NOR flash controller,
> which is compatible with SOPHGO SG2044.
>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>   Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
> index 948ff7a096433a8c3c64cba13fc1339d18f6c19d..66e54dedab140a167ad84c43f312f93af2bfa06a 100644
> --- a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
> @@ -14,7 +14,12 @@ allOf:
>   
>   properties:
>     compatible:
> -    const: sophgo,sg2044-spifmc-nor
> +    oneOf:
> +      - const: sophgo,sg2044-spifmc-nor
> +      - items:
> +          - enum:
> +              - sophgo,sg2042-spifmc-nor
> +          - const: sophgo,sg2044-spifmc-nor
>   
>     reg:
>       maxItems: 1

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>




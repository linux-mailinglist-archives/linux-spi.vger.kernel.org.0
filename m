Return-Path: <linux-spi+bounces-6902-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C053EA431F1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 01:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABC4173193
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 00:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740651853;
	Tue, 25 Feb 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="n7uIBeZC"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC11804A;
	Tue, 25 Feb 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443969; cv=fail; b=HKGokhA2xszXeKoPpHof61LrBktLOPMIbyQGkQTHmw3ZlRvMEUfWLm6qPkWoTbnXo/kmC4asZa+WCoeojZ855zb9ZjPPL+J+PNn9V9kwFgWSoyR9Rbu8xD2AxxGdK41NrHCJ2hZHBeTpi0+MDPoTrBMvcBu7zLBVOgEdgYd2/ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443969; c=relaxed/simple;
	bh=hB0ua4gXN2h75wlUMKMXI7daNOH2RFOpTXlsXTDyIK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mGx9C2amz/DUHJUINruNBmB148IVFGmbsTsQ0lCK6mpQdFoJtNFWUXATG5AuDpN9ryBXKxo7TnO05LdJnG/hgdBuMpAFktdanJKdsJE/69XeMTZyaAzeQHbWeq3I3NRnLxK1aAgvhx01DuslECQUImvbcWUyRqVxFOSMwnVadVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=n7uIBeZC; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmqL8OVt28oa80+GOEHYWdVlIHvBTemtgn252lrM0WsZqJHcHYX0uD2hWSyM4xVdhp0jp8+IvtWoPwcH27v9VDESqsAZBtGYOc4C5mPbg1ny7H4aAZbubD/2pIfFyOcqeHtxilHpUNC3AalSxUd+hij5UeqS5PRUSYmaqwzlvY9ViKc4H9HqHVo8Lsu8gIYpr6kY9CgOIPYhVS5wMn0xeHpDK/WEWe6xDxKKQ7eLLDo1loEhFeEvpJ295NTpciCXxAKg0ftBsdNoUoka1+0QnoT73/UlLWooSDEnpNnXDbM5xv3oTBNnKSEsw/4uSrMVyOqznTa1AKqMZ3VJZ4TzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSBZOxiyu01BPQa0cYDWUrrF9z4f1aTesgaySQo9bJY=;
 b=qnpTmf9zQq9MaJ0SDkMyqu2XaIvQSx3cw180HIoYdRaVzAEmz4wpcLjqgvscdkp3lO+9o99beiF6DZ8bb4KSYDd/LvnNJ9+ODqRAdkQCcuO4XYnrRthoi44/VBoowtNo5FYBmG+N/tvzPq8/RdxjLMMfLSj0mOyLLt2fDJV3AahXEsTwxRe4BuTdXgaGyqKDrAB9NpOBluNj8KIclJWwbxazfXS4utGotvTn/BqyC6Pmg8VCt4Vck8eGJhdviJE9OkCWmq8c/bfQkY0Dj9Je6MOGEs74zCMQ+0ckPyIozRJJ3OWMJMLt7LP5dMfIZRneXp64OczdklEmpYE3a769YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSBZOxiyu01BPQa0cYDWUrrF9z4f1aTesgaySQo9bJY=;
 b=n7uIBeZCo/xiYqSS4ahG7Jv5j6dhLRFwfPaUSO1zJccxn2RUCDKkRlCkF0OLpELBlrQEDYJ51EALGj/YXahSaVIVVMVB4izKdJLhzA1tO+EhPLn//X43HO/uFCUzn2n7TYE6Hr9cR36D6ia2Z/cyAgkaJIHj3tKojduIICQkm3njrODjzAQT3r5m1iHUM27eTrov9m5Gd172xD39+ODubkb4FU/OEO8tBVfuA1AzP3eJ1nwBQES9fNFfLkGDyNFaZS1k6eRkKZpvlb0dE5ZXAWhgquiH8x+f8N87LO46w87KaOi0DMdtgRI5lilfrIwW4LMTOIqWIphQnMsoDA0nHA==
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
 by MA1PR01MB4370.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 00:39:20 +0000
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e]) by PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 00:39:20 +0000
Message-ID:
 <PN0PR01MB9166B5BA907852452A41288FFEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 25 Feb 2025 08:39:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: sophgo: add Sophgo SPI NOR controller driver
To: Longbin Li <looong.bin@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-3-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250224101213.26003-3-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::18) To PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:165::9)
X-Microsoft-Original-Message-ID:
 <7a40a805-5afe-4f7d-bf74-44e975e256af@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9166:EE_|MA1PR01MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f524b1a-d56f-4670-a741-08dd5534d7a8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799006|19110799003|15080799006|5072599009|7092599003|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymw3RVN3dXE2ZU01UGdLVWpIdDJqZDJSN0ptdjlvMC83eDRjNmpJaHR4cXNs?=
 =?utf-8?B?TnYxSW8wQTcyN0k4akl4VjROdEZYZW9ldkhuNkdOV1BqNnVneEk1TWJ3aC9G?=
 =?utf-8?B?OTNNR2FDY0RteXZ4REg1di9yeHc2UXdBYlpRcU9WN0xUd04yRkoyei9CZFl0?=
 =?utf-8?B?RDBPRzhRTVJtd0piYnlKV3l6Q2ZVQnJQNXUxT1RYOGFoL3NjYThmZ0Q4Rk9z?=
 =?utf-8?B?MG1mNHgrcldkYWFYbVdaY3ZZYlNVcStkM2dXL2ttNHp4WVhRY3NsRnVuR0g3?=
 =?utf-8?B?RnkwcXpMYzQ2Vk93RVVmcy9pRFFva2wzUGhtNzF4anJkamNEbjBzem0wT28w?=
 =?utf-8?B?RWNkTUcwUjlXenRpeE1pQmpCZjQzVjNuM05IMm9DWVp3WDU0VERaZ0tMM01B?=
 =?utf-8?B?Y1hiY3F1TFdhTVMyZk5qZnZZRWc3b0RORlltQWFFMWJ3VjJoeDF4TE9vd3F2?=
 =?utf-8?B?d3lQTWRwbFBKRXpVb044VUxrN014OG5DMUphbk1zSmFqeDcrekVUZ09hamtk?=
 =?utf-8?B?R01Sc21LNGYzWC9qazUyeFRKRm5DTy9EcUluMlorYkZwQUN1d3ZhWFJocTdL?=
 =?utf-8?B?ZVFGWXZRdEUzOWhoTk9WM0dQczFQVlB5a0FRMFRZMFQzOGRuRXpxZExYSzNH?=
 =?utf-8?B?SW9oR2N0UXIyYmRxbm5ZbldWTXRXTTJiZWJ5Zmx2Ky9wOStubWNFalJqY3JD?=
 =?utf-8?B?OGhvazZBcTZtMnY2aFlXQVh0dnAxNG1IMURtd0hGUmkrMWNpdVFpZDNRN2M2?=
 =?utf-8?B?dXp3c0pmL3Q5M0xUcnVXZFFoSlBIQ0RvSmd5Tm0zK1UrUDhxdUhoYml2WjBo?=
 =?utf-8?B?bmNGSUQrT2lxdEZmM2FIeXZOR1ZCSUxFSzJ1TlhZMkpqKzZWd0xFQnhEL21p?=
 =?utf-8?B?S2loaS9KMEU5TlUxVGJKQXpaOURMc1A3d294UlkwTENXcmVkTkdNQ1FxaU9V?=
 =?utf-8?B?MGxjeWgxTGlBbmMvRk5QemRnUEhoWmRwYmxTSkJZdTRsV1pYem54clNBYTdH?=
 =?utf-8?B?VFNZU1ZmdEdUbW4wMWNVMCtzTVlJQjNyZmpKbXkyQkowTXRxMHozL3VMR09L?=
 =?utf-8?B?SjBGTkRDTHRDWW5NeFNLRmU4aURNcWN5WTlJa1FMUVZGMlJMTjhBUjUweFpJ?=
 =?utf-8?B?QWRyNlloZGdvRTZ6RXNFQUxQSXBqMWMxUEFickR1eDhiaWZKWUxRenhoWU03?=
 =?utf-8?B?K25rOFo0R2RlQ3FrZTNrc3l6ekc5bCtWVUlFazRtUnhqYld4VzdINmJ3dy9h?=
 =?utf-8?B?RnpWVlNQaVBnSDlJTWJIMWJiN0I0MVo4YjQ3cXJtTktCdlF6UGNjR21tMHZv?=
 =?utf-8?B?MHRHSEZiTzdwcjFzdmY2dTBLeVFXQWtWSVZZM285U0VnWmh6emcrQ2NEU1RR?=
 =?utf-8?B?SWUrUVdNdWNHYVVreGhHUjRlUHM0U3FkUzN6b2JjdnNEV1kyTzZGN0lwYXlw?=
 =?utf-8?B?RDdCZW1oMGVSTFZ2YzFnL055clRjRWp3WWJ2UFBadXdJUG5zcjhJN3g1bk13?=
 =?utf-8?B?NzNUcVd2bjZkc1pNRjN2S2xnZEhPWDFFUEVNSjJnOTA3dVJoVWxmalNWSCtS?=
 =?utf-8?B?S1RWZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEdrcHN2L09LYXA1amh6Wnl1ZGZrQ3AwN3lBYkFXTUNMMHl4bnFtYzJJc3JY?=
 =?utf-8?B?ZXVWRGZaOVM5TVQzcklMdmw3RWtva3dMRDNiek9SL2RrUnVmT3hDTjRJTVd0?=
 =?utf-8?B?ZWE5TXhjdDlmNVpjRW1NQWMyRnBOTzdiK2I5VDJVY0tTMUZUcis0Z1NyNlU4?=
 =?utf-8?B?bG5nV1pNTnBwZ1c0ZGw1RFZQVEYvQjVKcEhhek42ZU5yNDAxRGxhRk80K1F5?=
 =?utf-8?B?dU45RTJ0aVRxN2FuYXllZlBYd2xYd2x0Vmw1UW5Mb1pUaTlqRmtpWDRMTW5l?=
 =?utf-8?B?VkhLVGhUdWRZL05uL0M5TU5HTlJ0THZiaUZ0eVpmdGNVeTJUNmRTM1NQZFZ6?=
 =?utf-8?B?RzR5UkxiRVh0US9iUTRjZWxYU0hzM21mcG1VQTA0dGJMRW8xR2p0M2xkWEtp?=
 =?utf-8?B?Ny9xTVlSTldSZ1NiUWhzbHBKaDZWejB5dkw4ZFhlRmhoNHFSRDdZTmNLanVG?=
 =?utf-8?B?ekVMcDY4NXg4TnFxOU5HbDM0N3RGZTNLNGFEdW9XMUQ0VmFQOWNsaG5UZWFQ?=
 =?utf-8?B?ejAvSEVJSVorY2RqeDdJTGlTRXVrek54ZWZDSXVIZjNlQWYrYmIxOXlsWHpx?=
 =?utf-8?B?cVY3ZTZnT0Z0dWFrWkVybCtOVjNHZEE0Ymx2VXJscklMeForM05pTVBuUzZv?=
 =?utf-8?B?UjRYbkJNaFFzTkIvRy8reEZPQlhoNlAyN1czQnVqWHRCL28yUFJDSnVuVjlE?=
 =?utf-8?B?VzJFYjBybmtoanJKbVJNOE1oNEg4ZTZaalBhTVB6ZmlPbUdlb0tQWW96MGtq?=
 =?utf-8?B?akJuNmFmREwyUjZQK3cwQUZqRlp6TVEyMTVXK3pMTlZ1aEQvSlVyWVN1THZn?=
 =?utf-8?B?cW1GWDYxUVA4MTdnTk9WaXg2bUJCMWlTbVZxcTg2RTRNSjlINmVQZ1c0MDBM?=
 =?utf-8?B?Wi82a21zck1JLy85RVo3eGY3SnJJSTdtcnM2QVlCUGM1VU5uTExxWnZBcXVz?=
 =?utf-8?B?Y2hrQW5qdmdPR2xkMDBiN1VPK05BTlczT3pxVTFndUliZjdOSG1IdVFPRkFj?=
 =?utf-8?B?Zkp3UklUR3Y5VitTWmZxTitHc3JNeHZqY05lYzJyMVVPT3cvSyt1cDhYeWIv?=
 =?utf-8?B?S1IxSEd6UEJTaVdaTFR0OGdObHZYdVBlaWpXOTR6c010OG9uTWQ0L2xUN3I2?=
 =?utf-8?B?dkdYeDFkb3Q0c05JaXkxYUx5Zk9ZNmUvSW03OU02dmUxd2dmRUNCSGJMTVdE?=
 =?utf-8?B?L01vWFdZenJKd0xNMFpaVWxTOXhidVlRUzFRNjc5eHVnczBhNHRHSVh5Uytv?=
 =?utf-8?B?TFU0Q1ZaQWtQQUtNQXpObjFoTjdTaWJxaUlCa2w4cFFRbTc1UHRxZjJvZG00?=
 =?utf-8?B?M3VGdk5HSGVkKytGOStabEhQS1ltbmVaNUM3TTN5RTNQVWVxSituNHFNbmhi?=
 =?utf-8?B?NGowb2NGRHJDcmlISUJZZFBJM29OaUNINnRDakxia0NtMVR2aDJqUWpEbXEw?=
 =?utf-8?B?ekE1ZjNKWERIaUVEOE9CNzl1cG02SFVrVGRVVG54YnNMd3pzbldVVGZ0eEZD?=
 =?utf-8?B?ZWxpNnJFVHl6c0ZiMjVYZUR6bk82V1hrVmxQbjRNbGltOXk3d3BHdDUvZFF0?=
 =?utf-8?B?Wmd3RUI3YlNXQ254em1tNFFudVlINU1SWjl2LzBGYm5IWEYxMHFHSGd6U2hX?=
 =?utf-8?B?ZHZES3pGNTl2TEd5MS9uU2s3VUF5Q1J4aXhFa2k0WW9ZNUhpbmRLVFJtajlR?=
 =?utf-8?B?T3NZMEpncnFSNEk3eFJ0bW83b1kyeXFlMkVRc1E1eW12bC9oNGxnRUtlN0Ft?=
 =?utf-8?Q?uwLF6H63QqLOMSNhMxGwJvlJFeaWoqYshQDRhtd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f524b1a-d56f-4670-a741-08dd5534d7a8
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:39:20.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4370

As I mention in anther comment, please use "SG2044" instead of "Sophgo"

On 2025/2/24 18:12, Longbin Li wrote:
> Add support for Sophgo SPI NOR controller in Sophgo SoC.
s/Sophgo/SG2044
>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>   drivers/spi/Kconfig          |   9 +
>   drivers/spi/Makefile         |   1 +
>   drivers/spi/spi-sophgo-nor.c | 501 +++++++++++++++++++++++++++++++++++
spi-sophgo-nor.c -> spi-sg2044-nor.c
>   3 files changed, 511 insertions(+)
>   create mode 100644 drivers/spi/spi-sophgo-nor.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ea8a31032927..6b6d7b348485 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1021,6 +1021,15 @@ config SPI_SN_F_OSPI
>   	  for connecting an SPI Flash memory over up to 8-bit wide bus.
>   	  It supports indirect access mode only.
>
> +config SPI_SOPHGO_NOR
SPI_SOPHGO_NOR -> SPI_SG2044_NOR
> +	tristate "Sophgo SPI NOR Controller"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  This enables support for the Sophgo SPI NOR controller,
> +	  which supports Dual/Qual read and write operations while
> +	  also supporting 3Byte address devices and 4Byte address
> +	  devices.
> +
>   config SPI_SPRD
>   	tristate "Spreadtrum SPI controller"
>   	depends on ARCH_SPRD || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 9db7554c1864..9ded1de4b2fd 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -134,6 +134,7 @@ obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
>   obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
>   obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
>   obj-$(CONFIG_SPI_SN_F_OSPI)		+= spi-sn-f-ospi.o
> +obj-$(CONFIG_SPI_SOPHGO_NOR)	+= spi-sophgo-nor.o
>   obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
>   obj-$(CONFIG_SPI_SPRD_ADI)		+= spi-sprd-adi.o
>   obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
> diff --git a/drivers/spi/spi-sophgo-nor.c b/drivers/spi/spi-sophgo-nor.c
> new file mode 100644
> index 000000000000..1139deeac327
> --- /dev/null
> +++ b/drivers/spi/spi-sophgo-nor.c
> @@ -0,0 +1,501 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Sophgo SPI NOR controller driver
> + *
> + * Copyright (c) 2025 Longbin Li <looong.bin@gmail.com>
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
> +struct sophgo_spifmc {
> +	struct spi_controller *ctrl;
> +	void __iomem *io_base;
> +	struct device *dev;
> +	struct mutex lock;
> +	struct clk *clk;
> +};

"sophgo_" -> "sg2044_", for structure and function names, ...

[......]

> +
> +MODULE_DESCRIPTION("Sophgo SPI NOR controller driver");
Sophgo -> SG2044
> +MODULE_AUTHOR("Longbin Li <looong.bin@gmail.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.48.1


Return-Path: <linux-spi+bounces-6899-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D281A431C6
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B816A3A7BBE
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 00:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498BC1C27;
	Tue, 25 Feb 2025 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jF3y+FRn"
X-Original-To: linux-spi@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5E4A29;
	Tue, 25 Feb 2025 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442636; cv=fail; b=VHUaI7HGcVeRn8XG2Weas6C/nW+zvPGMhzvJCeN1FUScS3FANduptHl/QrxY+9l07GAZyrxKvx2BAj8In5sYFsrkKmy8bJVRtignLJZuStvpb9ZE08Go6RvZM/q/d+IksOCqrM4ojjxfhoCwBzr1ZkREVX65JgZSBRxho3DBffs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442636; c=relaxed/simple;
	bh=RAlIVekMLU7NGGskVTBQnnCcz1lPqvFKbyJ9zix4Zp0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTQKPRyjhiZvD5wihNJVY30i/EVfaE3cW0PJBxo3sq8N8bZcJl3Z2r+KqDatELfeXDQZ5a7W6gcqJVy0yJmDcV6fb9P1ZTs7CVsuBdlUlRIYmJdnyFT/gentRh0LyHZfv2lQJGJTSyu4QV3EuA+X/fwEtxkHoShaHOKMsaYDssE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jF3y+FRn; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xgyxmt/rNAq3ECZnuwXZx0FemYS7BRkS+Z+2rJ8IgtcdJL+XpS7h+rO/3OPC8JZFh4AGx7wJc7OujySsftbI1vQg2Q3w+gO9zW4rAwNY6JK2gPEADLhRuBcQin7T5wE7NY1/xmWAGIwXwC2wz8tVfTKubHb78iMf5QB7cyUBCDVV3EtBQ1RLg33rTQHPryOsyCzVZOtQUC/F42Gzl8qLC6DW8y27kpWNJFfFDfrzmtC40FRSBuxyWxDdfFQjEaw0AqWn/CC7ieHtSozyaA42BK5Pif0/XVnCExRb2gykwg2XZtfLSBRtncInfamwv7otL6iHop1SGr69SwWF65FbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+otcXgyUPJExiUarzJcxDXv87oSwmhrSH9spcVsOzwY=;
 b=mqDXY7kLoCyqtSq/N7c3V2wnwMs2sEpKXpFMTCcOiT6gfRVuA/XYlSw8RYuYrQTepUin2Rl8N4Hs1YIee/KF0L9UMS+R+W9NOXPGHaOoZBvx3u21Uy6tOx3FQyZnAdgQtEyR8pQlj7eQNeALg2nMuvwmcD8uedwD129/il2kx0xr1BtSQlae4prwyAdh3RSm5AeSqZM8biPHSxVnxw4znlAUoTNskD0Fl9LPLy/r/KbX1N/5YGd5qS93H7dQinst5oIKqHZG04mZanq+sZytCyTKQOQiV8w7+cXW61E9PmEKgxSODnPOx2kd6ava6yr4j4f3rOgvPULTmfMhIDVK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+otcXgyUPJExiUarzJcxDXv87oSwmhrSH9spcVsOzwY=;
 b=jF3y+FRnhijHsmuznO97yQg8bLfmMzPoFtANwXYMDvAP8I9HVhiEoltRLWCQFRxBKCkThfXpyxOQsS5gGliBF6oo7ohZjLRq8VQeS0Mmo9LVAef9+KIpIG3XjVLaghUMBekCF4nnffZhHFHeQ3AelAKFwtuFLh2UeS1Wqh40QmtUsbIIjntl2UjtDdYT9aFgkoxIvMmMijyiXnL331tObqOMqods69Csxb58W+/wiB2Rv8M8pDiDLKXqZa+C3cusrD01jwxPWB2j+68tzHvJ7jfLADPK0m3JldeowCtzLVvlO6uOQAgyiEJkxz/f0ebf7PiAWQsgdwNS2giZgwOazg==
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
 by MA0PR01MB5725.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 00:17:06 +0000
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e]) by PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 00:17:05 +0000
Message-ID:
 <PN0PR01MB9166E5F6249600B5764B6602FEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 25 Feb 2025 08:17:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] spi: sophgo: add Sophgo SPI NOR controller driver
To: Longbin Li <looong.bin@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250224101213.26003-1-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250224101213.26003-1-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
X-Microsoft-Original-Message-ID:
 <2d506703-f941-4ca9-a5f9-16fd6f3e203c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9166:EE_|MA0PR01MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: acac11a7-4c4b-4da9-e1d8-08dd5531bbe1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|461199028|5072599009|8060799006|6090799003|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnZmL3QxVHNmOG1mZU9aY3RxYnkzNWpreXNzZUtjQVBEY0kzZkhYTDA0bjlo?=
 =?utf-8?B?ejJmMGl6a0laRHQ4Y1duRmFYTmkzMzdJdDI1RGRtZGxOZzkwUFJzVmhHUXhK?=
 =?utf-8?B?dnJmR1pwZmJYWFBBQ3YzWktFdGd0VEJydTRSL2VhSktGQ1VoblpzSmR1SHQw?=
 =?utf-8?B?c3JUSU1aVGd1V1pzR2cyeHliQmMyS2VzTmJ1WmNpVThwVER6S05TWFJ5OFRE?=
 =?utf-8?B?OU1PWWlFczNRQmh2Z2pIclBHMmJBWVFPNWpTYjFMcllYcFh3SkYrSEtmanpR?=
 =?utf-8?B?czhCU25HTnV0TVR1TjJ5VHJWeCt4MEM1Ly90TmRTbW9uVUlKWk9nM0Q1YnJ4?=
 =?utf-8?B?Q0VrbnBZOUdzWitFNGlQMlZGQkVla3FkNy9WcTd5eldnVXV5QmpFQjZub2Y1?=
 =?utf-8?B?aTJ3YzNKeVM1MEpjb3U3ZGdsN3hiekkwVHZsaDRtdmpBc3k0S2hyclRYc3dq?=
 =?utf-8?B?bi9FKzJja2I0UTZlcHl3WWsraU1jeFNabHh0VUlDTjVuYUFmQXV3bkl4WHV2?=
 =?utf-8?B?RjEvVEF5dkQrei9LUWRvbWF4NDNrZ2hGMG85dG4zaEJONEJwYTJmckdPM1hQ?=
 =?utf-8?B?T0ZKOUNWeFBBRXl3Nmg3RWJZUGVCM2JWKzR1S3pGZUtreTFnOW5JWXpUa3hI?=
 =?utf-8?B?eWZpS0w5NGxaalFmNXNMOCt0WFlkd2VUdU91bEZaNmhZZHVuWWdVc3RaaEtp?=
 =?utf-8?B?amw4czhrSzlTTDB1ODFsZXhHc0Ezdmw5amwzandZMWUyMElYa3BCVmNOaXpV?=
 =?utf-8?B?L2lPRVA1U2VLWUwxLzg1N3czQkE5M1RtQ25hRlhWUTBieDhGRk40YkdsYnZi?=
 =?utf-8?B?LzBMTm1JTXJvS3NUMGFLbXo2OVY4UUROQkZ5dDRZeHorZlBDWXZldCtjOXVF?=
 =?utf-8?B?ZVh1Z1VFSWl4Z3ZQKzR3eDlkY1JxVEQxYW1TWnI2RmpRWVpuNDZNT0lGZTN3?=
 =?utf-8?B?OXhFcW8zWWc0emY5ejB3QlpDWTZuR21ZZ08vckUxVk9MVXppWDZJSUs5bFl5?=
 =?utf-8?B?WDVCeFF3aUdhMGt5S1dQRlZTT0h4RzYveEFQMHZtQUhiWHRVbnlrdWw0c2dY?=
 =?utf-8?B?UzRKVm5lRjBrb3dhUlIvRkQveWl0WWkxNkpqeXQyaVJzTUR0L1pjL3pYWWwz?=
 =?utf-8?B?VXJaRFhFcTRZVmkzdHNaeXVuVWUzcVROR1E5bG1iZjg4anlkTnBNMkhDVmhO?=
 =?utf-8?B?SzA2MzN3L0NCVVMwS2pleFFrZ04vY0pvdUgxYzZMNi9URzkvOG1NbmFBdTF0?=
 =?utf-8?B?NXNUbVdRbGgzS3lnMmxsQlV4dUJrT0d3N3NzSDYranBROHJsQnB6MzlEbEQz?=
 =?utf-8?B?NW5haU13cElDcVR1MG9MSXF1SzlkUGpRbit0eWdQN0l5Zmsyamtsd1puV3RE?=
 =?utf-8?B?T3dxUTEvL1MyVXhveXNaWXlpMS93MVFYWFpRemZtbVpsUkNCdUdBVkQybmJk?=
 =?utf-8?B?UWZoTGhpSG4vcEp3SGU0OEZaWjdodWdBZ3RkQ0dOV0NMVXAzdlJ0anhRMEpT?=
 =?utf-8?Q?hxWTxQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWhUV2t0aU1XVE1zQ1BXWWpVYm10VlNuSisvMHI2TWVaanI1VWlYSlg5OGVy?=
 =?utf-8?B?K2Nub3g2dXF2eUJabm5xU3BBSjZCc2c5REJIQnZRcVlxTVFTbEI0OUFHSFg2?=
 =?utf-8?B?ODRhZVRob25PRXVzSS8wODJYbVJPL3ExTEsxMEwxejdtM0RZcWRtVnhVUUxX?=
 =?utf-8?B?VGEzblZFTkx5OWpGSEl5TkY4SDlPVXd0amFaVW95UnVlbUw2SkVxeGx3N3RX?=
 =?utf-8?B?djM2cTZ0b1Bpb0ltVTdwajJBSlhVb3NNR2FxbUF4Wjl1c1N5Q2ZKZDBCR2N3?=
 =?utf-8?B?L2dIaXJmdlp1N1MrRlgrWWtpQ1JXcmRpUGJwdW9XbzBYT29EcVhUczM1MU83?=
 =?utf-8?B?MU42SjRlN01BNW45bHExZDJQTEExdStwWTBEdmJySVF1ZWhueTFEV0Z6TjU5?=
 =?utf-8?B?b3I0U3FYbVZySm0yaktIcjhMMitxOU03YVBsU3FNOElBTU5hWHh6UU00YTlv?=
 =?utf-8?B?MmV3QW5yNWpkUkR3VFJXN3hETzlFRHdBM2pQdldPTzVqMkE4KzRWbUNKc2Q3?=
 =?utf-8?B?dEtkR1NjT3VPT0QxVE5XRnd1RFQvdFA3WTJiaUYxUHZCR2RESktYNFJDeTEr?=
 =?utf-8?B?TDVaUmoxTDRsUWdzSjNIRUhnRzV5cEp6M3VYRFlVNGU0SkhDb09ySmRjNEth?=
 =?utf-8?B?L0wwME4vZ3ZIeHh6aVljZ2pVR0dOUmMzTFh6dTdVRHZsN3E4R0hheTUyeWta?=
 =?utf-8?B?OXhESVRKZkx0dzJIVVdqODVwbWw5c0dYSGdlZWxVYk9XSEFrNC9mVGp5ZEV3?=
 =?utf-8?B?OXUxNDFDS1BmTUFpR0xuUVRtNmdyNGxQSmhrUnYvMFJMNkFnN0ZxYXpOM093?=
 =?utf-8?B?a3QvUkRUVnZtOTZuN2ZSODRBUk91RUlTeUttRWUvTHEvMUNkcUZyNVU0dmpP?=
 =?utf-8?B?bUQraGRSeC80dnpFQmhGeVJKZWdtaWxxdGtFaS9VckdMU3RiWlBZWExFMDBq?=
 =?utf-8?B?ZDFUQ1JMeWcxOVZWOVZ4bzh2Tk9YdXRiTDBrVG5aZzBtSW1LaFJlTm8zcmwx?=
 =?utf-8?B?bDRPTU1iejNFdUx3UHAyRkZxOFhzaWJJS3hBSlR5dVo1MkVoVmZkRmc2Nk1R?=
 =?utf-8?B?MzdlZWZyUTZSUTVQWDZPcTlyTWVxYmlLa1czWTlXd3JDT2E5RDkzRElENU92?=
 =?utf-8?B?V1IyNjl0MlR0ZXk1eHZsWldtR3IzbGdFOWt4NTFjbmhrY1J0eFJUMTZnOWpu?=
 =?utf-8?B?c3lYbWNCMjRkL3Rpd3J2ZEJsbXdER1RDL2ZROW84Nkx4OFZZQ1FDeGxDU01j?=
 =?utf-8?B?REpPZUViakcvbHF5VkNKcUMrVEhyY3FxNTNxRlJpbFB3L1dJMURRTDNabFRX?=
 =?utf-8?B?ZXJhNG9kUHp2Sk84eFpoYnpYdVVVbit1TDl2anQyU0RGZGtPRzNkVE5XaUpl?=
 =?utf-8?B?RkFOMmt3SENkZGliWDAzM1prY0Rtc2x2MlZ1dTR0M2UybUNnZVlwTGQ1clRS?=
 =?utf-8?B?Q2dydjFoOWo2SEdpRDJlbk5UUEtvbGpLc254RUhrTTJyRlp0RVY2NmIwOTB2?=
 =?utf-8?B?Q0Z3dVRzUkNCeUE4YlFESWo3VXB6a1NvcWR0UmV2N0UrN0ZjYTNla2NhVm1G?=
 =?utf-8?B?N0FSM0o2ZEk2d2Q0ck5EaWlIRnFXRGxTUm9zakNVajF2cUlxa01hQVhQMk9a?=
 =?utf-8?B?bHphck5ZbkxZYUpOWGhUZTdOeTk3QXVoZTJicEZqbEVlZDZCQUNvZVRRRFlV?=
 =?utf-8?B?RVlNR2JpQWt3RVZUby9LdmtOc01iYjljUitQL0w4SGF6Z3loL2thZUdFTVM4?=
 =?utf-8?Q?Aiu95e8CTeFM9899CyA0p1pv4bttF2+5Mm6acAP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acac11a7-4c4b-4da9-e1d8-08dd5531bbe1
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:17:05.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5725

hi, Longbin,

I think this patch is only for SG2044, right? However, the file name you 
used and the description in the patch all use "sophgo" directly, which 
makes it seem that it applies to all sophgo products. I suggest you 
correct this, otherwise there will be conflicts when other sophgo 
products such as SG2042 submit patches to SPIFMC.

Regards,

Chen

On 2025/2/24 18:11, Longbin Li wrote:
> Add SPI NOR driver for Sophgo, including read, write operations.
> This driver is only suitable for NOR flash.
>
> Longbin Li (3):
>    dt-bindings: spi: add Sophgo SPI NOR controller driver
>    spi: sophgo: add Sophgo SPI NOR controller driver
>    riscv: dts: sophgo: add Sophgo SPI NOR controller driver
>
>   .../bindings/spi/spi-sophgo-nor.yaml          |  52 ++
>   .../boot/dts/sophgo/sg2044-sophgo-sd3-10.dts  |  18 +
>   arch/riscv/boot/dts/sophgo/sg2044.dtsi        |  24 +
>   drivers/spi/Kconfig                           |   9 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-sophgo-nor.c                  | 501 ++++++++++++++++++
>   6 files changed, 605 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-sophgo-nor.yaml
>   create mode 100644 drivers/spi/spi-sophgo-nor.c
>
> --
> 2.48.1


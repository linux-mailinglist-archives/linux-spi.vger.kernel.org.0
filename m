Return-Path: <linux-spi+bounces-7016-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3EFA4D9F5
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 11:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760ED3ACC64
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CA1FF617;
	Tue,  4 Mar 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f7bmE2iU"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853FF1FF1DE;
	Tue,  4 Mar 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083307; cv=fail; b=inF6zi4B83WwLfozZ0ceyiFo5TyCMvl6lxPa17YLZKOxP1SSXRUW1UEL6//fAs6/gnY1iJXvNZEMRPPj9y1xbc1IK9wp3BAKynyLZqxAiJMz+2DLI4DprcXTHQXrND7KR8k/PK784y1WE+IMc0MaDn/waHfSW8SDScDF2H0PseM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083307; c=relaxed/simple;
	bh=4UwumKpHoOQxrlnhOqcqs4wJugohBCEg1gIuDniiI3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UC355HDygLoHo2NsIF5Au3YBQPnlT70ICYIndP4RcTXWRY/bcMxCA0tydqj+O7oAFN0lMFy90McrnQgnJR6Njw2AkWlYHB02l2F8bQRAp4Oo56u4DlHOnPd7FAi9T6Shp7ySOUu5kQfMHULqn9PXW/7jcNv+mX4ZM2tKXz26KnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f7bmE2iU; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRXtUUHBsjPyIYCR8wRELv298ouZesZayiHm4bQUUQ7rCYsfHQTk+wMiy2WnOMw0acYda1SlJWP4C0xmOCJ8vnxBth6nYB4Psy1GppaHAm87zIcvviiSlR/AdTnzo9RtdsKOjM+FvDx+KwpN2HKe4ud7uxQmO+XOTrRUBfILK339bTtnL0KUSo6Nyep/1gfkuOVFMbUGpa7VDz00EHg9VWAitgYiAvVxMorAuHJRWohGZJt5WxmZr3AVUy1gJe3mSM34dZNkWlmIMIU7z56VxdnCiKT6dxEtMUfpKwTisCATTrfmEbXdcSFGF0tgNKv8MOfVXjHXjcugZTL1X9qb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw3vWEXcn3AUAJvM3zLxipJhdEL+J2tClBVlcxBuvqs=;
 b=QcptT5B7S55mgaaDbFUeQh3whNSfx7uO8o8Nkq9SikjH6CNT08LCAcY7odbB02CVYny0JDyiXR8nER/Y8yI48Pq5d2LWyjk4tCMJzv380Prj52iy6HjePYuLHaIpYG/1//CA6OGQMCsJn60eG37G32hI27IdDPJu8ZAuK2RgG5hT11DxhY+asaOLtpBQRzuie1oSbo/N5chkUJiF2V6WNEWNhsTfcJ93Yq9sfe1nSADXudOfhSf28ePkRtvqvsJ9qKqL/2QMoUH/K/G6n9PtqR+Eq5a+EleE5iFU92uy6qtdV2l2SLLnVLvZLKHlQyP5I12LHacx6b2CKzWZK6CHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aw3vWEXcn3AUAJvM3zLxipJhdEL+J2tClBVlcxBuvqs=;
 b=f7bmE2iUccboTQd1lRva4Bd/J34kcwtTy2VqQHMJCPhjT8yqsoKtmp9iNELZ4/prNXxPVA8NlxII73leuYRJb/nsPJ4hMyt4dWs6ZcOpP2kfI2RU5xFaphI0kGWqxvO0Iek1BWD+MNCPqJUF4Aw07p25xka/kuF7eA5ImWrO0/WLy4zCppe0dM0d77L5gCYSQaA+djXEenC6rX0cWHRs3fyuiJxewuwx/1nofsZGoqI5LVtVd1S7Fuhp8rVxmoYJsQQwTaQi6fq+uikFTGKHkZS+4Fx1jl0ETa2U1L1mtLfZEaHA3LSYswdvQUUQcAaGLV/c6Hd1onlesN9spTEW4g==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by PN0PR01MB9691.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 10:14:58 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 10:14:58 +0000
Message-ID:
 <PN0PR01MB10393099D28CF3DF75A0F414CFEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 4 Mar 2025 18:14:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] spi: sophgo: add Sophgo SPI NOR controller driver
To: Longbin Li <looong.bin@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev
References: <20250304083548.10101-1-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250304083548.10101-1-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::20) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <4da53f1c-4e13-49e2-9837-f284cf14a0ff@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|PN0PR01MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efd917f-9511-403f-5162-08dd5b056ad9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|6090799003|15080799006|8060799006|7092599003|5072599009|3412199025|4302099013|10035399004|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emc1bVBGcnU0UkNmSFJxSzl5cTN3VUZMeUFsdm1heWtOYkxIS0o2N2dmdDU0?=
 =?utf-8?B?TDZ1UHR4dG9YUlZ5SnBWdlNTa3lPUTh3QjJpNHVyeFJ1RU5jZkIvakRqT255?=
 =?utf-8?B?bTNaQ0RpaXVsRDVsd1ZTU0Nhb2NoeHEyOFhUVmtzNmQrNkpTMzZQRUxXTTh3?=
 =?utf-8?B?WU54WTlSYXlsamF6cWxmR3kwb2RaOThObVIwRDBnQjhpaHg3dmEweks4NGN2?=
 =?utf-8?B?NUt5SUgzNmgyTnZadzI0RlM0NWpIbGJUTU9LSnNKZ0dNdmlKcER3QVB3cUFo?=
 =?utf-8?B?SjZvMjM0cnVBTjUxanowZDNYZ1RHcURVKzg5VzlrYk9PMVBlaWNLVXgzRWZl?=
 =?utf-8?B?UkxZbEZLUTM3YUJ1dk9hQmdHbGtpMDV2TkJra0tKOFF3MGc0eXhpVXRtTGoy?=
 =?utf-8?B?cTBZUUpKUlBoN1I4MkFsaE5XWEdiVzlMODF0aUxtazJaSERnZHIzVnhXVDhI?=
 =?utf-8?B?RWQzSUdTVk1JeFU4ZURqSUZNNDlCd2FYODFYNFIrREkrbEpxZXB6N2NpYXdO?=
 =?utf-8?B?Y2llZFpFUjFWK1lXU2F5Q25iTlNIWUJWMXdTVmpISGRudHJsdWkvN0VxMnFS?=
 =?utf-8?B?ZGhaSFEzalMrTXl4K3lhY0VrdWE5dlNzVExFVUVhR1hSc09CR2RDNkRlSlRG?=
 =?utf-8?B?Qk5nWEdIYXBEcSs4MlBKeWxIaFY1VVY4eVUxdVlwNVlLcnZMZlZMbVRsSXh1?=
 =?utf-8?B?VVVhTXd2VWM2R1ZaelBaTFRrYkhpQTFVcVN2Q3lORVY0N2tTMWFLQ3l6a0tx?=
 =?utf-8?B?Yk4veVBFTzRpenZQUDJmd1dkRjFBNGI1R1NldjY5TTc4YUNGOWw2T2RIS0l2?=
 =?utf-8?B?QnY4OGQrYktNbUw2bTAzNFBWMGhadEdkMHpEallqNzlTYlNaUjQzVHhjd0Uw?=
 =?utf-8?B?SXpldGN1VWs0WkNWQkFXbnEwdjhHajlxWHhacmo4cHBPT2oxU1ZOVmZNbXhi?=
 =?utf-8?B?QlFhOVpFcFc3YlZjT0o2YlR4RUdvRG9kcERIQWNkSHlUT0pUcTltQ1RuZmhw?=
 =?utf-8?B?N2gwL25iR255MWRJd0c5dDhJalBqVUNKR25hZFVYS3hlSm1NVUZnbXZPbmg0?=
 =?utf-8?B?SzU4NERzaktxVUt0WEVLdjNkZU95MUQrR29zQzR1UkVnMVlYQVFhb1NHN3Vw?=
 =?utf-8?B?akdoTTdiN0J0QXVwVHZEMmpEcEFqYXFnaDl4dlM0a0RxQWdVdFRweXVmK0U0?=
 =?utf-8?B?S3dLY1FqVUZlRGlpYVFKQ2N1V3FZc3dkenFIdUhQeHJ5TURwV3VXSXhPaXE0?=
 =?utf-8?B?dm41VGVJWlVMS2pQTWUydGQwQlp4THg0ZmlFMVVDeDM1WHdDaEtvd0RxbjZw?=
 =?utf-8?B?OVM3NktHdStleUxHdDByc0QyNWVSd3ZNRlJzZllMc1BLc0pHWXRmR2E5MmZX?=
 =?utf-8?B?UTJQNXFydmJYQXAvVTg2L3FCOGZPaDBKVUVVdFVQZ1N1aWtYRzErSWFPZDFX?=
 =?utf-8?B?OFV3cDlzWng2bWJSS2VKVHExcklpRWloeUxHT24wQk5paU51bUlQTWhFZjI1?=
 =?utf-8?B?M3R0NFVTQ2k4NDk1ZjJKYzN4bTE2blBydjEvVjBnOUY3aTRnMkh3SUhCa0tN?=
 =?utf-8?B?U28xYmFuRnpVVzN1QnZ0QmVqUllOc2Z2dit0Qm04RExqRThsYTFtRTQ4b1JE?=
 =?utf-8?B?THhwNitZeWI1djhoejJpbkxYTUMwTEdlZW03Z2wySDQ2bUc4a2F3MEFkc3Bs?=
 =?utf-8?B?QzJYNzhDQitMa2M1U3BWaStVL1NqdFg0enhna3BQQ3JWYXlnbkZjL3R3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFpzWHRsR1gxY3JkZ2lZbStiaW5wanBUeUFDZkNCMnVjYTlYeWJxc2RpRG9Q?=
 =?utf-8?B?dXI4eGVJV2tHbWcrMnJDQURrOEFYcGNrSnBLMjVYc1R6UTloa0xjeEluRWt2?=
 =?utf-8?B?OWtsZnFqRjVoRlFGMm5LSndlb0ZRT3dlaHRHV2ZsK2NoSWo0Z01NSjlWNWwv?=
 =?utf-8?B?WWhPN2hRdDV6ZHhCNUdlUGxxbnJxT2JQZ3QyQ0FIWkxZanI0RlUwV28wclJL?=
 =?utf-8?B?RnBrOG9pSXM1ejJwaWJvYS9UYTBFV3QrQ204b0lxUHpZYVkzckxpTm9qRWJq?=
 =?utf-8?B?QXdYT0dSSEpRRkxnTDBNb3h3OUpEaFozZHhlRkRVTlJ1aG4xOEl5blpuelJ6?=
 =?utf-8?B?bWhPN0ZOYlVvd2RSNmtsWVRzQndPenpNb1ZYZldQS25rL2IzL1R6T1Ezci9Y?=
 =?utf-8?B?Y0Zoa1g4TnNiVkZtWnNabDdIQ2JMSE1EM3IwdlM5cERJeElvZitkU2V6WmFk?=
 =?utf-8?B?eFFTd0w5YjNnSGF5M2VEWXh5bzR2b0NnaDdLV0h5YzRka25ZdHpmTkhKbEY0?=
 =?utf-8?B?bWZUU1BKZGJBQmZZbjRDRk1PQ0VSdDdVVWE1OHhBbUxVc25ycEUwSFFMQW4x?=
 =?utf-8?B?ckJWbWgvd3NUVERJVy9WdzRUSkNuU3Q0TVhqeG5MODNIUjF2bjU4RGdrWHdC?=
 =?utf-8?B?NG9NVzJKdStMREw5MmRMbHFlSUwya1MxUUEwTzNTVHJNbU5IYlJRUnBDSE03?=
 =?utf-8?B?WmlycGdnR2l3ZC8zZ1oyUm5NbnBYSXFSR3d6S0R2ellJdFV1dTBudDRxV3lv?=
 =?utf-8?B?OEFTWVEvTGVvYStRVEc2N1h1VnJoUHV3OVBPSlBZOG0rQkljT1UvTXk1b2V6?=
 =?utf-8?B?ekwrMlJXcHdNUGVwVU56dEJUSGFOKzUwUkhvN0tFalVxMVFFUzYzZ0l0dkNy?=
 =?utf-8?B?NzNLckk4UDF0SHkvQnNZTFpmdU5HQWloSy83bWZGelZwdXBqL3paTmhiSFIw?=
 =?utf-8?B?MGV3ZGJGSG1ZckhIODMySkdSNWNySzJoNWNEdGtWWk9lS2sxTkhtcmlBTitU?=
 =?utf-8?B?K2dOazlsN0xBa2trRXVMQTkxMlg4K1cxbHpycGRROHkyd0ZQUEVmWGlNdStR?=
 =?utf-8?B?Z1BQdzNWKzQzWVFXNmI2SjRnYVhxTFFhbUVmdmU3Nms0cnFkUk96V1hkcG5V?=
 =?utf-8?B?cjlESnF3OEkwUWg2RmRlak5IRWV0dmRneU9Rdm5UZUx4dDUvNlA3SXF0VkFS?=
 =?utf-8?B?YnhKdk01dG5rZEJheG5zRkwwVjA1T0JuMSsvbWN2VERxOGVxaGh2V0VkY3Rn?=
 =?utf-8?B?bmxyUEZwaVZUMVlQRkY2WGc0clNmOVFYQXVrQnh4L2IrcmRuQUZZcGM5VzZj?=
 =?utf-8?B?UnoxdmVxeFZyMnNrL2VqSzh6cnRGQm8rN1B6UVEzblpkbEVhU2F6Z2VydGIx?=
 =?utf-8?B?MjFBcDhwdnR0YWljQzRJZzRmV1JTUk8ydjlTWm80WnF2WWtDaE5DYWtsL3d4?=
 =?utf-8?B?NG56a3N6bmptSlJKR3dYSkM5TjlITXpjSGhwZG1DQnR0OTdiWWxickJuSk5k?=
 =?utf-8?B?N0RrdkVFY1BjMGdvRXBxRWpwTmcrRDFPM2szUGtYZURsWE1uZnAreEJISmZF?=
 =?utf-8?B?eENhMkNzMW8za21BMmdObGlMMmRxN1RIUUJHN0ZCT2RXVWxvZ2JRTEdTU3ho?=
 =?utf-8?B?NFU0RFNuZEg4WURuQ2ZVc21sbXFTblVWdVd1VnBhOVEyemZSVENvd2pPZEFL?=
 =?utf-8?B?YkpnWVBueFl0ckpQa2ZJNzBIRUJSUEN1ZUhnUEE4djRRTGNJN1NQZlB2OWZQ?=
 =?utf-8?Q?saYnZ7D6pH0WOAVmOfzjQAaBCUn3KIOoLk4rLtY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efd917f-9511-403f-5162-08dd5b056ad9
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 10:14:58.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9691


On 2025/3/4 16:35, Longbin Li wrote:
> Add SPI NOR driver for Sophgo, including read, write operations.
> This driver is only suitable for NOR flash.
If there is a next patchset, please also replace "Sopgho" with "SG2044" 
in the cover letter, including the email title.
> ---
>
> Changes in v2:
>
>    Fixed following issues as per comments from Yixun Lan, Chen Wang, Inochi Amaoto, thanks.

I feel like you left out Rob, and you also left out his signature in the 
first patch ;)

>
>    - Replaced "sophgo" to "sg2044" to avoid conflicts with other drivers.
>    - Improve driver code:
>      - Improve coding style.
>      - Removed the [PATCH 3/3] in previous submission that based on the baseline not submitted.
>      - Added error handler to destroy mutex if probe fail.
>
> Changes in v1:
>    You can simply review or test the patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/20250224101213.26003-1-looong.bin@gmail.com/ [1]
> ---
>
> Longbin Li (2):
>    dt-bindings: spi: add SG2044 SPI NOR controller driver
>    spi: sophgo: add SG2044 SPI NOR controller driver
>
>   .../bindings/spi/spi-sg2044-nor.yaml          |  52 ++
>   drivers/spi/Kconfig                           |   9 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-sg2044-nor.c                  | 500 ++++++++++++++++++
>   4 files changed, 562 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
>   create mode 100644 drivers/spi/spi-sg2044-nor.c
>
> --
> 2.48.1


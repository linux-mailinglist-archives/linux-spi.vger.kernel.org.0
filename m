Return-Path: <linux-spi+bounces-4154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292794C209
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD962821F2
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1AF18CC0C;
	Thu,  8 Aug 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="iAmNBB92"
X-Original-To: linux-spi@vger.kernel.org
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136EF18E02D
	for <linux-spi@vger.kernel.org>; Thu,  8 Aug 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132444; cv=none; b=mLAo0M+tnvCDsq7LdO1SXCChwFObm37vI3JzQL5w9dLulRA1RQpratG/b7q5DnYf8Y6m9EgncBjda3QocWKeQ34vEIpG8kndAEdcPOog698g5PIlaPgmtUhMQcvLYLZ5sRg0ynF9Yogk+vDm7gC9F/1JshKwXjhMgmfr4SXo7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132444; c=relaxed/simple;
	bh=yrez5Jn9TkgNLr+MSp7JM/iqz72RX/+SNmnTugHUQ2w=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=N9mPb2ThQYE7tF9H30YwqfouznJf97pfIYdxPG/UXlYkI6u6f2Nz1T6uA/3Lru2Awa6Aa5Buu2sE4Ft2bhKbjT/VResTVEj3uSWkcffnxQCL3N83pwj0uGx9yMV7bxInMJpdWwvEYzok+FHbq/whVaJoqDsVrfjpwbd0/pCdy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=iAmNBB92; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723132440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAsU/Q6PICalD5a+ibimkhqrflVdpOCuRlhVoc17I9Y=;
	b=iAmNBB92ZYQn10qEp2769sT6PK0j+EpFBkd3ptqBU0sl4tcjeEUvuwtE7aQNQEjFVBE8X3
	MD3O2W0Ot0wAW52AgRMgzmxqDahPP1TNaNNsDJcJyuLUgqCUaIQNC4icerssTdLwoI3qmY
	LWHPquiqVE+eJ84+DwYz4thKOchi4wM=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2040.outbound.protection.outlook.com [104.47.85.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-187-ESJF4yYMPh-U1gugQje0KQ-1; Thu, 08 Aug 2024 16:52:28 +0100
X-MC-Unique: ESJF4yYMPh-U1gugQje0KQ-1
Received: from CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bd::12)
 by LO0P123MB7861.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:429::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 15:52:26 +0000
Received: from CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c521:bbd7:6726:1147]) by CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c521:bbd7:6726:1147%4]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 15:52:26 +0000
Message-ID: <19c5442b-984e-4758-ad50-34392c0ae79f@camlingroup.com>
Date: Thu, 8 Aug 2024 17:52:23 +0200
User-Agent: Mozilla Thunderbird
From: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: Re: [PATCH v2] spi: imx: fix use-after-free during driver removal
To: Frank Li <Frank.li@nxp.com>
Cc: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, lech.perczak@camlingroup.com,
 krzysztof.drobinski@camlingroup.com, pawel.lenkow@camlingroup.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <d5aeab83-347c-48c5-9482-b01ef73baf97@camlingroup.com>
 <ZrTRW7Y/vUN0wGx+@lizhi-Precision-Tower-5810>
In-Reply-To: <ZrTRW7Y/vUN0wGx+@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BE1P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::19) To CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:bd::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB4178:EE_|LO0P123MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd76fd7-bbe8-4b6c-56b1-08dcb7c21978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGZPcnVyU0Q2NUpZYXl2YnF2M2VsQ0d2ZVNjbnpxY3oxQkdSbDc3S3l3elh2?=
 =?utf-8?B?bDdkd1dCd0RnaTRoMmxHTXRBbExCdysvaTQwVWdtRmY0ZU51Ti9Xczlyem5X?=
 =?utf-8?B?cTFWSUZ1UE5STGlvaHFmSFlwWHBKMUo2d1JFZjRPN1p0eVhVUmw5NmYra1k0?=
 =?utf-8?B?dkQ1N1AyTjlQb3BrNUtLSXg3YUdaWkRoeExNNVR2c3BqRU1wT3pzMmx4VDVX?=
 =?utf-8?B?T2liWGs4RUorUENqK2JKWWxEWWtKMkZ0dituWjdtVlNvbDR6Y2J0R2VVSmFX?=
 =?utf-8?B?NXhFTTZXUzQrRjFUSC9ERlNLc21jQmVwOEVDY0EwMG1IQkFqSTNpRkU3QjNt?=
 =?utf-8?B?NnJzRy9DMG9qSklQL1RGdm1WQnVkcmRaU1JsTkd5KzlzWVFIRHkxYTlIZEcz?=
 =?utf-8?B?cFhFeCttUVlwaitOTEk4Y3JONzNhNHkycHFlOW00cStzSjdlU1B2eVFSQWZC?=
 =?utf-8?B?ekkrY1Fia042dzZPU01uV3phTG5TaHdWQkhwTUdHdDJaaXk4UE54SDdGY3hJ?=
 =?utf-8?B?aG4wZ0hqQmVpOVFTNkVJVUhJRzRSMGRROHkwVTNCWFdZcWRyNmtmRXVIUWx1?=
 =?utf-8?B?V3c2NGhSVHVwVkl5bHF4RzFQRGIweHdBN3VSdHJvVG1sRExQOTdQOEY2eUs1?=
 =?utf-8?B?cXl1WjhSV3YwVFVVYVdKempaVjVWWHZwZXYvWTc2M2ZwcjF5RTh2VlRYVCtX?=
 =?utf-8?B?YXY2Q1lzRUxKUDB4VVZmMnR0TlQ1SjFVaGxVYS9DSUtEUEY2YUJYRklROFo4?=
 =?utf-8?B?UXQxVlZYZHZ3Y3hqVWtBRVVudXZhblhqMnU3ZGJCdmlwenlaRXRTOHdoSVRD?=
 =?utf-8?B?eis0RDhxVlU5c0pkMC9lamFrMVRNUEJia09GVHAyK1ZNUE5YbVJhdUpZSG9P?=
 =?utf-8?B?Q3hIZHhPd05SaTFYYkZqenB0elF2cW12Y1c5R3J1OUVCRzltTmo3UFBaYk9I?=
 =?utf-8?B?b3RXa1N5V2VmdXg3MWhZYnp3RFJlc2RaTFB2enFDbG1RbHYwOGdEMERYdUx4?=
 =?utf-8?B?QkNaM2gzejdTTGFtcCtXQ1YrNFJnUmhweXkzOHo0QzJXWWZQUWJ5UGFiYmZw?=
 =?utf-8?B?RjJXSmtQcTNJa1F0b2JqTVBySHd3NlZlT0ZoODZXWXFoR2RFSXJGMHQrNmU4?=
 =?utf-8?B?ZmJUaHpzMEJYM0ZoVGU0T3YwV2NFaXZnVmZCOHpma3VVV2ZXTjVKb3Y4bFpI?=
 =?utf-8?B?czhNTzFnWHJOd2t5emJSZG41cE96R2pxZm94OWUvK2ZCMEVRbmlFTTIzQ1NI?=
 =?utf-8?B?SXdMRjBkMlhUVUhQZXNtTVJwR3QrQXdoanhpcGxJODNzNTQrZE8xL052YzJY?=
 =?utf-8?B?Ung5QW83UUM0R1Nod0NxQmJPMHJiQnBraE53WEpqLzhBV3dTZ3pOVGNjaVpy?=
 =?utf-8?B?R2hCQVdtSGg5QVd3NmxtcHNhamFoL0s1NjBqNkw1RldDMWl1TGFZeXVkRG41?=
 =?utf-8?B?b1NNay9GclZNN3ordUlYNHhyNlF3RzRJNkhLVFZVc1JmM2xjN3kxUWNOeXJh?=
 =?utf-8?B?Y0VvMW5qZEpGNE8zcFRHUm5XaGxXSisvNGlWN1M4eVhiNC9RcWVFbXBXSm4z?=
 =?utf-8?B?K2VnUHg5c0t1cUpvS0pETmgxNENqR0dwZ0luZXRHOCtKZWJzQWdVbHV6WUZE?=
 =?utf-8?B?WnRQYng0SXpzZlRxR1F2UXFsWUVLZ2NwNjlnRFo1Tk5iV28wZDBWRmxKWHl0?=
 =?utf-8?B?dUZ0L051MGhYTklNYjdVcFU3cm0xSy9najFEWlg2VC82SFBmRDJHNWN3UWxM?=
 =?utf-8?B?SVJtOFhxZnZjcS9HUFZjWEQySDFxVEJUVVdGZW1nWERFNEljY20ycEZBQkQr?=
 =?utf-8?B?b1JXTUFnZW1salY2dkVjdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG41aGh2MXBKdVZLZzVBTS9NQy9hWEdWclVKRUprL0p1TDJpdzVFMGptbnIw?=
 =?utf-8?B?aFlkd1dNdzZwY1NvWFBWeGw3Zm9XMnY1VnN1V0IwTi9mZTYzR2xjOGloU2Rw?=
 =?utf-8?B?ZExhQnU2UVl5aGozTlZ0dllCZmVHSEN2UVZQLzhkVzM1UzhGZHFnaGp0REw4?=
 =?utf-8?B?Qnc0UjlJZGRlelZHblg5NW52bUplTFB5MnVjWnBsT3RFLzJIT0Rac0U1OTMz?=
 =?utf-8?B?QlRxNG1KZnl1TDJuZnhsVkFoQWJpMjhzSzlTRG10V0haMGFMVGJpdE5xZlNQ?=
 =?utf-8?B?dHFRbjBSSUNKNEswblJqd0xhTWZGc1g0UmFSK3dKRC8yYncyMFpuMGkxbWJj?=
 =?utf-8?B?ZkEweGZSNU4yT3J6VkxZdDVkbFA4MHBDVkQvaEY2KzNXdlA3bUlFbUR3bjdi?=
 =?utf-8?B?YTBuSFNnWldmU3A4WHB5WXFPOVM1aklxclFuMnBBWEF6WGkway9jeng4Wkh4?=
 =?utf-8?B?OTg1Vk9GL2JKcE96LzFGZ1hDb3M3eVlMRzhDeitxRXdRT3FyY2JCZURVN3Ny?=
 =?utf-8?B?dmpER29BdmM2NHZ6Z0FVL01aejZ0MGVsUHFqUjl3SjUrL3paVmlqejhrTit3?=
 =?utf-8?B?Sjlud3J4NjNYN25HS0h2ZUtXVmVSaHRoMDFPanY4L1ZSbXpCMU5pVTJqNkxn?=
 =?utf-8?B?Mm9ESitlWGErUFNKbWtHN1JCV04yNVFGZGM2T3p6K0lKajd3bDZVa2ptUTNm?=
 =?utf-8?B?ZXc3ZjBvdlJidTd2anB6VC9pQkpDRDFyTUp0TGNvQzFSbm56MU8xNldzN1hW?=
 =?utf-8?B?MFppc0JoSEFRWERnTHEzUWczWXlMZk1lZzV6RGl1bFlDTHM5L1RuUC9OQm0w?=
 =?utf-8?B?NmsrY3IxalZnWnFmS3dQSXFnczdUd3RSbkgra0FIWG85aGdoYlh2YWVIY1c1?=
 =?utf-8?B?cjUrQzBSOWNXK1p3dWF5WVlqUksreUcycy9zcW1scHYzS0I2RmtmdzQ4NUlW?=
 =?utf-8?B?NmxYZGR5Y3Q2QU9lSVNibDBucVd6djdCRUdWVVg1NHpJelU5SVV0Qkd5U0VB?=
 =?utf-8?B?bmpXQjRYaU5NZmMrWVM5MGRubGV0M0k3TVhqY292enJ4aTBNY3RJcnRqOVpz?=
 =?utf-8?B?QTM3ajFIUVlWS2JaaDJOaGQvU2EyZDVBYmx1NFJpekx6ZkE3WGxiQUdtUjhy?=
 =?utf-8?B?K0I2RE1STmFOL1NSUzZwV2xZQ2VGdU1rT1BDWGlkaUFLbVNpeDZOQ2QySmxC?=
 =?utf-8?B?c1hyU0tqV1FyU2xOVW1sYmNlamlDeHJnb015anJrVHNlaVRZdFJwU2NTK2dO?=
 =?utf-8?B?TnN0Q1ZacXVDRlRJRDVGc0hBYStFSUNvbWZBYTFUUXJsNTZXTVlyczNJbjR0?=
 =?utf-8?B?Nm5Yb0pKdTlKak1GbThiTWNLNkRRWUJ3ZzgzbG5TWnZ3Qml4THBTZDE5c3Bi?=
 =?utf-8?B?aUlrUG5qbmNraEpoZnVINmFsNWhEeWRBTGZHWkhMYm11VHYwVnVHNFk1WHhl?=
 =?utf-8?B?enpHUnp4ZUMveVZpOTdPZGh1TkFVVjQwSWxtWTBocjNjbUJMR2Y1NVlpd05q?=
 =?utf-8?B?VFdYd3VJWUQ1MDZQT1NSbFRBUEhPd2N3L21NalNiVlBEb3pVWmVZcC9jWUp5?=
 =?utf-8?B?TmQxbFZDcm5EOVdMOGgvVW8wTmtKYjJDUWJlTmRMZnUrTk1TNnRKeTJCV1Ri?=
 =?utf-8?B?ZlcyM0JuQUo5S2p2OU00VmhSSGFHWjlNaUdvVEVCNThSMFE3VE1RZWZIUDUv?=
 =?utf-8?B?anZJY0Z5bXlFVzJXL0dnQ2VBMG9qVXRXUXVDYTZSOTkrdnIzYzNRUUU2cjMy?=
 =?utf-8?B?NGtNVjZnZGVEeFlONXVZWVJ0RVpYWEZwRk0xRVJYKy9rYTJYbnZlYi84OEFu?=
 =?utf-8?B?RGh3U2x4dTlxeUpiQ1hkNFFpVk5abENtMWplZS9rY1QzenVqY3BjRWJ1SG9S?=
 =?utf-8?B?WGljcjZIME1pY2ZBN0F5L1N4ZDdBS2swSHgzYldPRnkwR0xtc1gvamhLU0Rt?=
 =?utf-8?B?OEhpb0sxU1FvL0g5bTJJN29pWnM1N3hudEE4T2FQcnpiRlN5emI4OThQbk5T?=
 =?utf-8?B?aGVTcDUvZW5lSUlpNFZGRS90TEZPUFBvYUxWdWNaTmlKL0dqRmZ4NHBMRmRR?=
 =?utf-8?B?SUNQclVhUjNodFA3cW1vbFZCY1FBcFBRZWhXbUU4aTBTa3JBU2phRUNvbFRM?=
 =?utf-8?B?VENscXZReTAvWGVYWGRYY0I0UndGL1hURmxqemhFeG45MHVxNWpMcEhjMXZx?=
 =?utf-8?Q?+DV3n8JL6IlujvsD4GHu27Q=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd76fd7-bbe8-4b6c-56b1-08dcb7c21978
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:52:26.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/kQ/OSpToi4xiFxZKAWGadcmgbccz5mAbf/qEfvRisGkopji2ZwO3hgb2hO1hFz0u9C1qsLnunCc0tXgiLzeZXj3WDWfvos3qbpGzEoV28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7861
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

With the CONFIG_SLUB_DEBUG_ON enabled the unhandled fault error appears
when unbinding the driver.

The spi controller driver memory is freed inside the spi_imx_remove prior
to executing PM callbacks thus leading to use-after-free.

Fix it by switching to the devm version of spi_register_controller.

Unhandled fault: alignment exception (0x001) at 0x6b6b6c53
[6b6b6c53] *pgd=3D00000000
Internal error: : 1 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 2 PID: 1241 Comm: rebind.sh Not tainted 6.10.0-dnm3pv2-dnm3pv2-ga03695=
deba11 #1
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
PC is at __pm_runtime_resume+0x58/0x6c
LR is at spi_imx_remove+0x1c/0xa8
pc : [<80632438>]    lr : [<806ebefc>]    psr: 20010013
sp : f1d81e88  ip : 83c0e204  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 82dd9454
r7 : 82dda054  r6 : 810f82f0  r5 : 00000004  r4 : 6b6b6b6b
r3 : 6b6b6c53  r2 : 85321240  r1 : 00000004  r0 : 6b6b6b6b
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 1687c04a  DAC: 00000051

Register r12 information: slab kmalloc-64 start 83c0e180 data offset 64 poi=
nter offset 68 size 64 allocated at kobject_set_name_vargs+0x2c/0xa0
    kmalloc_node_track_caller_noprof+0x14c/0x37c
    kvasprintf+0x5c/0xcc
    kobject_set_name_vargs+0x2c/0xa0
    dev_set_name+0x2c/0x58
    spi_register_controller+0xcc/0xc48
    spi_imx_probe+0x41c/0x694
    platform_probe+0x5c/0xb0
    really_probe+0xe0/0x3cc
    __driver_probe_device+0x9c/0x1e0
    driver_probe_device+0x30/0xc0
    __driver_attach+0x11c/0x1cc
    bus_for_each_dev+0x7c/0xcc
    bus_add_driver+0xe0/0x220
    driver_register+0x7c/0x114
    do_one_initcall+0x58/0x240
    kernel_init_freeable+0x198/0x1f4
 Free path:
    kobject_put+0xd0/0x29c
    spi_imx_remove+0x10/0xa8
    platform_remove+0x20/0x5c
    device_release_driver_internal+0x184/0x1f0
    unbind_store+0x54/0x90
    kernfs_fop_write_iter+0xfc/0x1e8
    vfs_write+0x25c/0x450
    ksys_write+0x70/0xf0
    ret_fast_syscall+0x0/0x54

Call trace:
 __pm_runtime_resume from spi_imx_remove+0x1c/0xa8
 spi_imx_remove from platform_remove+0x20/0x5c
 platform_remove from device_release_driver_internal+0x184/0x1f0
 device_release_driver_internal from unbind_store+0x54/0x90
 unbind_store from kernfs_fop_write_iter+0xfc/0x1e8
 kernfs_fop_write_iter from vfs_write+0x25c/0x450
 vfs_write from ksys_write+0x70/0xf0
 ksys_write from ret_fast_syscall+0x0/0x54

Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang by=
 pointer to struct spi_controller")
Signed-off-by: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
---
Changes in v2:
            Shorter Kernel oops message
---
 drivers/spi/spi-imx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4a56a5b16e12..14834c4e839a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1854,7 +1854,7 @@ static int spi_imx_probe(struct platform_device *pdev=
)
 =09spi_imx->devtype_data->intctrl(spi_imx, 0);
=20
 =09controller->dev.of_node =3D pdev->dev.of_node;
-=09ret =3D spi_register_controller(controller);
+=09ret =3D devm_spi_register_controller(&pdev->dev, controller);
 =09if (ret) {
 =09=09dev_err_probe(&pdev->dev, ret, "register controller failed\n");
 =09=09goto out_register_controller;
@@ -1900,8 +1900,6 @@ static void spi_imx_remove(struct platform_device *pd=
ev)
 =09struct spi_imx_data *spi_imx =3D spi_controller_get_devdata(controller)=
;
 =09int ret;
=20
-=09spi_unregister_controller(controller);
-
 =09ret =3D pm_runtime_get_sync(spi_imx->dev);
 =09if (ret >=3D 0)
 =09=09writel(0, spi_imx->base + MXC_CSPICTRL);
--=20
2.34.1



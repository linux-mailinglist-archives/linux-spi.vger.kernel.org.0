Return-Path: <linux-spi+bounces-4152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768294BDAC
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 14:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8286C1F20FEF
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0018B481;
	Thu,  8 Aug 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="MTqkb3hn"
X-Original-To: linux-spi@vger.kernel.org
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53F018C356
	for <linux-spi@vger.kernel.org>; Thu,  8 Aug 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120809; cv=none; b=u3zxarpAgzriHNtfUge+yasEBNPpE6U9uaN8hLg9UzhjqhXTQYJxOjqTEdpvFcGxDRI0FCxJCGSpxGnc+BSkIDd5gy79CK1ekTGKkpP5YlzJmLGfi83oPkcTUz5iFFMZWbHVTenQ1iqRyubplA/mkrbYz+/oDz+PYk+RjFmGA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120809; c=relaxed/simple;
	bh=z+aoer9GhKQlNeWNCe46u5XpSAcHE+j2Fp0pZ4c2EK0=;
	h=Message-ID:Date:To:Cc:From:Subject:MIME-Version:Content-Type; b=iJTv9/2gcZX435TZBnIVdurzIqD9oD5gxh6ZXJLHzxO2xZ0AptIrEywwthnn1t/CKCXfLxpZyV1EdHqGD4v4Aw/GKv7ktlgmhAvGfwGLDIx+LpMTEhFsqJnCfYjVlngdrP22cukGXFQiFM8XRA4C7YqHr0LWuRoeQ5ceZjTOTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=MTqkb3hn; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723120805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RgS8DoPacLqwgOGadvdTGlFwHlIX+uPzHOjbgLjY8kc=;
	b=MTqkb3hnTwe1tVIyttcFChbT9HfiopRra4ilIUOgTgtYqK5cDanajkHiK9oxxtz8jbpzVJ
	6xiJuoLa4rghsXIIJMbfB/Z31di0OJX/jLWG5ttE2vDFldUEG99t0x7Kp0L3NAN/t2H9Y9
	u6iApH9ACTcN3PdnaK7pg147V8s+sAg=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2104.outbound.protection.outlook.com [104.47.85.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-192-XuEx34W9MB2SBFFYlL0i1A-1; Thu, 08 Aug 2024 13:38:50 +0100
X-MC-Unique: XuEx34W9MB2SBFFYlL0i1A-1
Received: from CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:bd::12)
 by CWLP123MB4100.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 12:38:48 +0000
Received: from CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c521:bbd7:6726:1147]) by CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c521:bbd7:6726:1147%4]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 12:38:48 +0000
Message-ID: <d5aeab83-347c-48c5-9482-b01ef73baf97@camlingroup.com>
Date: Thu, 8 Aug 2024 14:38:45 +0200
User-Agent: Mozilla Thunderbird
To: broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Cc: lech.perczak@camlingroup.com, krzysztof.drobinski@camlingroup.com,
 pawel.lenkow@camlingroup.com, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
Subject: [PATCH] spi: imx: fix use-after-free during driver removal
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:bd::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB4178:EE_|CWLP123MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 512ac4c1-42eb-4e72-230c-08dcb7a70cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjlQMGpmdkRwZEtCMHJYaWo1dnhyR01pMzNCTktSMHluckRsQ3QySSsxVTc5?=
 =?utf-8?B?Ykt5a0JQODZpb1hUM2xwMlNyejdHVzdyRnBvUXNLMFRYUzdwSzBNU1BmMVIy?=
 =?utf-8?B?a0RjaUVjNXNVODdYdFduS0RYWW1vSGdjUVhGVk5OOWY0ZkNoS2ErRlBaWWpJ?=
 =?utf-8?B?dTlIcmxISy9wZlNjcklyY1dRaTh0UnJtVHFxam9PSmpuSlZGSGdKa0IvSlZp?=
 =?utf-8?B?eWVTT3kxNDBQaGRObncrWkxkdWpIdThQQzJuV05JdktVblBBRkErVm5Oa0Zx?=
 =?utf-8?B?YXErZncya0dYdzdaa1MvbEtBYUR2Ujdycm1KTE5LeXRxRGlPQ29mSTFVUmp5?=
 =?utf-8?B?UVREQmJjWWh4K0NoRG9HYlJzck1yNWg5VHJwOFl1Myt2LzFEcS9HU2hIZ2FJ?=
 =?utf-8?B?aFNvclJnNnFtWlBtVEZMTVNoV2labnR3amRBV05QSFNsbXpIRkZNMk1rL1FK?=
 =?utf-8?B?YnJldzI3c1p6ckhXRU5QellZb21Cd29TcUFGU1V1d0tEcGZGRUhzMEZLRGVx?=
 =?utf-8?B?VUF6R3g5ejN3dEJvbDAyc09hQW92MDZVYlNUNHZOS1dnSTRnUDNjQzEwaFg1?=
 =?utf-8?B?S25DdC9GYjd1ZWJwdVJRbjUvWGg1RFJxcFZldGdoQW9jMFJFektVK2d4cGdK?=
 =?utf-8?B?WnVORjI1OHNoRWdMUitsaSsrZ3dxaVFubHNOMVl5Z0RkT1FGRndHZzVqUWlP?=
 =?utf-8?B?a0trRHRlbzJTOVBLQ0Z3M09UU0p5eEpvS2dqRVBaZWZRbGptbkQ0a0ZkUnAy?=
 =?utf-8?B?eHd1UjI1cjZiOFMwQ2FDRHpkeVlxYjk1TmdjdUd1SmQ3WXRzT2QrL2JPdjc3?=
 =?utf-8?B?SXBZY0Rzd2t4bDVzS3JSWUVDUFhSZ0U3ZUt5RWxIQ1M4OGt3KzU4TmEyOWxa?=
 =?utf-8?B?S3l2MTRCWCtWaTE4ZWt6c1R1R2x4K2htZk11RmRZWTRnZXJlN3VmMnJGd1o5?=
 =?utf-8?B?dExrWDdOMVYrdFFXNDRTY25aS3VQdVdqaHBEeXVVZUdtbUpTb2Z0a0VzWlZZ?=
 =?utf-8?B?dUZpV1lXRW1sdUJjdFh2U1g1UGNnbDVPYk95NXBBM25wcUIvRW9mYnFydTVE?=
 =?utf-8?B?cGhXMUo5OEpZTXRRSVU1bThZcmk3YTlvNkFCWnZpWXRzSDNJWDV5L01za2Uw?=
 =?utf-8?B?YnF2VzU2UHBROUNGbEE3T2JkTGhsREtRZWhHUkwyb3dlMHlxRFhSUmVuMCtY?=
 =?utf-8?B?MmUwOVJFVEhtaDRjMHQ5NFgxeVdiL003dEk0SFVCTkxHMG4zMkRsV29RNFN6?=
 =?utf-8?B?RWlkelk4cUoyd004cDFvRE5hSDh5SnJrK1JSZjhlbkhTTDJtek13VzlZa3Z5?=
 =?utf-8?B?V1EwM0xHblU0RXQ4SU5Send6dGJ5YUFEUUwzRDQvdjA5Rk96Yml6Q2E5aEls?=
 =?utf-8?B?SllmdDR4SkpRVmRXcG5PL1A5WlhiczlNMnZkQ0VLelhlb1czUHBwdEowTExz?=
 =?utf-8?B?MDg0Ymp1TnhoYVRPOSswNTdBREhjSDRwOEx5QnliVytSUU9SQ1pGRURFYXhX?=
 =?utf-8?B?WEpCRTFLa2YzZmpvWksyTmJjbitOa1ZCK1BldGRuN0lUQXpxYXNrMHNGSUZQ?=
 =?utf-8?B?cm9WcXg3c1pzM0o4SkplNTUrakU4SW0yaXdjNXV4eCtWSmlQOFNwNHg5R1FE?=
 =?utf-8?B?TnptTkk5REN6ZzFoN1I0M040RmdVcmdoUEJ3ZS9uYUkzL3Q1SmJvNm5xQ1NX?=
 =?utf-8?B?ZWp4bU9wQ0NUM2JQMjJ3MHVENGI1YWlMSyt5YjAzSlVqS0pDenEwWEI2U2lO?=
 =?utf-8?B?TXN3bTF0ZExaUmIxL1dpbi9hVk5sWElaVkNFb2V4TVNrL2NkRzRxWXEzRE5x?=
 =?utf-8?B?cTFVeC9Tamp0b244ZXFMUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJNWTBHRklnSnFwZm1rMkdtSkZlV3NuTVgxNWxKSTJpekwzNWRzbjhLV0dx?=
 =?utf-8?B?dFFOeDFMVEZKUVR3VDZPMDFtNlBhNlRINmJoL0Q3cjBVNVNCajBZWEc3MGVN?=
 =?utf-8?B?YjB5Q0VjTmhsbGJYSXc0WStrUGt2dytGaDVQUUtuN3ZNei9jQmo3THllK3pF?=
 =?utf-8?B?MjY4TEthZmkrZEtrbjFrb1BQb1ZtQkt5Wk1ISU9VSFlRQ214NExlQ0dXMzNp?=
 =?utf-8?B?eFdmbFNROUpjUmdneW1hZ3FFaE42Q1NFejdOdjZ1MndNNmpOOXlrWXY5cFVW?=
 =?utf-8?B?UXhTNXhMQWloNTRUL2ZJaDFNbnowUVNVOU5LRjJxQ1R1cjluc3YycjlLbVNs?=
 =?utf-8?B?cEVtZFhENGZsT2VEcnljeTUzS1lmTjl2Q1hNVnJUTXRwNGZTYnBlMG9PeGJ3?=
 =?utf-8?B?RWg0NjJnV0dYWGdtM1I5b1V5YlZQaThhM2FRNXUzMFk4R1hBOG12M1ZQdHly?=
 =?utf-8?B?cUh4REwrR25NS253V1NxN3ZqN0lvUDZyd3Q2Y3RORlJNd2o4NUlvUUV0T3R3?=
 =?utf-8?B?YVloeHBRY1hkVHdrSVpzM1RoMC9uMGZtL0IvQWJNQ0lEaFoydXN2YVJabVN1?=
 =?utf-8?B?SlpxeWlUSEY4Qm9EbUFUY1RtbjZiUktJYXZ0ZHJ2YjVrYTBsUGloanpqMlN1?=
 =?utf-8?B?QWNYTDN1S2FhVnREUG0zM0Y2c3cxaElzQ1FkQUE2WDZ5dTIzN2RVK0o5LytI?=
 =?utf-8?B?aDRab2pMcXVnRE5JRmttUFlUUnJEaUsxRW9BWEtLdDdDT2RUVkdVWGxrUUYr?=
 =?utf-8?B?S29Cckg5QitHUkpneW9PMytnNmcyc1ZRUXYyMVdiK2hyMjNlTEE2VHphTlV0?=
 =?utf-8?B?S2lKU2hhSUZOb3hRdXcxaXlxTmVhR3NQTDZkNkplUDNpUkRiY3JqVjJLYVhi?=
 =?utf-8?B?STBXQ1hZUmN4RlJzVk1mY3IrYldTcXcyaEs0UmxJeWxzQ0xIVGFOaTFXSFVw?=
 =?utf-8?B?VDloT1VEOEJpMENmVlBRckRoeG5mUmRKam9ISWtieHRkZUljMGgxenUxNk5l?=
 =?utf-8?B?WXpqZzZUTzlMM25leElrNk1FSWxoMFBRUE9HUGRRUlZhbjRFREhKUkkxVDBQ?=
 =?utf-8?B?ZW56WUs0Y3JibU52akQ3eHAwTDhadUJqZGZsQTB6a05sVi9hTitIaHNjUElY?=
 =?utf-8?B?SktGdWxXYTNvNGJjYWRZN1phVko3NTR1Y3hualJKUUlGZ0lHZXRPV2tyd0JG?=
 =?utf-8?B?ZnNGUXB3QXdaREVSLy8yT1VNUENoTXZOTmppMW1VeUhjUVRyalhrM091bkF5?=
 =?utf-8?B?aW82VjJ2c1ZiOGtwM0VSbmU5ODIwTTM1SDJxZkFwSWRrK1o1b2wxcjdaY0xy?=
 =?utf-8?B?dERmRmR3ZjhZTWE3ZExnbHBHUU5pQlVXWnViRVdMSDc2OXJSSlVVblp3cjVl?=
 =?utf-8?B?WmoxMjNJbEFPcFJONElMQTg4NG9WYVBBdkRaWDIxMm9hOUVya2pkM05aMng3?=
 =?utf-8?B?ZHhtVjlGd3ByeXM2azZjN0J2b2V1NDV5czg1aTlueVJoOTlISllnVnl4TDhN?=
 =?utf-8?B?YmE3a0ZrT1RvWmJoZnp1K3hQVlVLdXQ4U3RxZWxGN21DbnlWWEkxU0l3WVk0?=
 =?utf-8?B?dUtkMkNTQkRETExKeDZUZ0pyNVE1dmF1cm80cGUvVXR6bE8wQjZkaGxjUGZ6?=
 =?utf-8?B?SmtJQUpEVlRLVnJ6eDRKK3ZXNnZKd1BROWxNbEZyT0RMR3hpMjVUczc1alF4?=
 =?utf-8?B?eWVhaUhwcHZLcSthWHUwck0wck5QN2FsNEpUV0RBMGhQckVXbWVrajYzUE9j?=
 =?utf-8?B?SGxVaHdvR0JuMmIwOUZPcVFubjRWYlI2dlpvaGphR3RDb3lKZWh5WHhVWEJz?=
 =?utf-8?B?NjFQaVZXbnpBa1lSNWZFeGRwM0RweXU4alh5YlJTR1JBUzFEQ3NzdUhRS0lz?=
 =?utf-8?B?dWdzdVNYTmE1em9hZ0NkR3VHNlNKVkFxWWdBTytiMEhtQVZ3Y3V0Vjc3QjBQ?=
 =?utf-8?B?VFR4Qkpmc1hvN0F0WHV6YTMyZDNRTzRrNmtIUkNwcytqb1c3Z0RpVTV1QjBJ?=
 =?utf-8?B?ZzdaQU1sdVVaWVNuYThCaDRNYUhML0lYOXhnTkVjZnR3aWxuSFBtYi9zdktG?=
 =?utf-8?B?dWJ5c0lKMGU4Y2dKZXRLZnBEYzgrU1pEN0hjbk1mWlNlUWVRZitYYjcyekJk?=
 =?utf-8?B?ZTB1WnFPU2FYT1A5SVZyaWtERU0rWE9oU3pQeGZMOXBPSDZBaUJGZSs5UU9q?=
 =?utf-8?Q?/F9RHqY9FahN8Bnq2ZXyFLc=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512ac4c1-42eb-4e72-230c-08dcb7a70cc3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB4178.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 12:38:48.2678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDGiNbLbf/HFLuN2dQ30EZQfp1jobIvgop1xKORWmQWaA41HSgMtx5jRDM8zr1e+Iik1s1uQytFKm20QOCqRxZ/dkvZdiAlpudkJhds0CWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4100
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

Alignment trap: not handling instruction e1932f9f at [<80632434>]
8<--- cut here ---
Unhandled fault: alignment exception (0x001) at 0x6b6b6c53
[6b6b6c53] *pgd=3D00000000
Internal error: : 1 [#1] PREEMPT SMP ARM
Modules linked in: cdc_mbim cdc_wdm cdc_ncm cdc_ether usbnet cdc_acm usb_se=
rial_simple usbserial usb_f_rndis u_ether wl18xx wlcore mac80211 libarc4 cf=
g80211 wlcore_sdio phy_generic ci_hdrc_imx ci_hdrc ulpi usbmisc_imx roles p=
wm_imx27 pwm_beeper evbug libcomposite udc_core configfs nfnetlink
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
Register r0 information: non-paged memory
Register r1 information: non-paged memory
Register r2 information: slab task_struct start 85321200 data offset 64 poi=
nter offset 0 size 2176 allocated at copy_process+0x1d8/0x1b2c
    kmem_cache_alloc_node_noprof+0x10c/0x334
    copy_process+0x1d8/0x1b2c
    kernel_clone+0xa4/0x340
    sys_clone+0x70/0x94
    ret_fast_syscall+0x0/0x54
 Free path:
    rcu_core+0x2b4/0x7e0
    handle_softirqs+0xf4/0x25c
    irq_exit+0x68/0x8c
    call_with_stack+0x18/0x20
    __irq_svc+0x98/0xc8
    cpuidle_enter_state+0x168/0x37c
    cpuidle_enter+0x40/0x50
    do_idle+0x108/0x200
    cpu_startup_entry+0x28/0x2c
    secondary_start_kernel+0x12c/0x14c
    0x10101340
Register r3 information: non-paged memory
Register r4 information: non-paged memory
Register r5 information: non-paged memory
Register r6 information: non-slab/vmalloc memory
Register r7 information: slab kmalloc-512 start 82dd9e00 data offset 512 po=
inter offset 84 size 512 allocated at platform_device_alloc+0x20/0xb8
    __kmalloc_noprof+0x148/0x380
    platform_device_alloc+0x20/0xb8
    of_device_alloc+0x34/0x178
    of_platform_device_create_pdata+0x60/0x11c
    of_platform_bus_create+0x1cc/0x35c
    of_platform_bus_create+0x230/0x35c
    of_platform_bus_create+0x230/0x35c
    of_platform_bus_create+0x230/0x35c
    of_platform_populate+0x80/0x110
    imx6q_init_machine+0x98/0x21c
    customize_machine+0x20/0x30
    do_one_initcall+0x58/0x240
    kernel_init_freeable+0x198/0x1f4
    kernel_init+0x1c/0x12c
    ret_from_fork+0x14/0x28
Register r8 information: slab kmalloc-512 start 82dd9200 data offset 512 po=
inter offset 84 size 512 allocated at platform_device_alloc+0x20/0xb8
    __kmalloc_noprof+0x148/0x380
    platform_device_alloc+0x20/0xb8
    of_device_alloc+0x34/0x178
    of_platform_device_create_pdata+0x60/0x11c
    of_platform_bus_create+0x1cc/0x35c
    of_platform_bus_create+0x230/0x35c
    of_platform_bus_create+0x230/0x35c
    of_platform_populate+0x80/0x110
    imx6q_init_machine+0x98/0x21c
    customize_machine+0x20/0x30
    do_one_initcall+0x58/0x240
    kernel_init_freeable+0x198/0x1f4
    kernel_init+0x1c/0x12c
    ret_from_fork+0x14/0x28
Register r9 information: NULL pointer
Register r10 information: NULL pointer
Register r11 information: NULL pointer
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
Process rebind.sh (pid: 1241, stack limit =3D 0xf1d80000)
Stack: (0xf1d81e88 to 0xf1d82000)
1e80:                   83c54f40 82dd9410 810f82f0 806ebefc 82dda010 806269=
8c
1ea0: 82dda010 80625014 810f3b60 82dda010 0000000c 810f82f0 f1d81f28 806228=
c4
1ec0: 85cad640 0000000c 85e56080 85e56090 f1d81f28 802dafe0 00000000 000000=
00
1ee0: 85108e00 802daee4 f1d81f80 0086ae30 85321240 80b14188 00000000 80257d=
8c
1f00: 8687c020 00000000 00000000 00000000 00010000 0000000c 0086ae30 000000=
00
1f20: 00000001 00000000 85108e00 00000000 00000000 00000000 00000000 000000=
00
1f40: 00000000 00000000 00000000 00000000 f1d81f50 16506a32 0000000c 85108e=
00
1f60: 85108e00 00000000 00000000 801002c4 85321240 00000004 00000000 802580=
e4
1f80: 00000000 00000000 0086b000 16506a32 0000002d 0000000c 0086ae30 76ef6b=
a8
1fa0: 00000004 80100060 0000000c 0086ae30 00000001 0086ae30 0000000c 000000=
01
1fc0: 0000000c 0086ae30 76ef6ba8 00000004 00000000 005a6dd0 00000000 000000=
00
1fe0: 00000004 7eef2468 76e982fb 76e155a6 40010030 00000001 00000000 000000=
00
Call trace:
 __pm_runtime_resume from spi_imx_remove+0x1c/0xa8
 spi_imx_remove from platform_remove+0x20/0x5c
 platform_remove from device_release_driver_internal+0x184/0x1f0
 device_release_driver_internal from unbind_store+0x54/0x90
 unbind_store from kernfs_fop_write_iter+0xfc/0x1e8
 kernfs_fop_write_iter from vfs_write+0x25c/0x450
 vfs_write from ksys_write+0x70/0xf0
 ksys_write from ret_fast_syscall+0x0/0x54
Exception stack(0xf1d81fa8 to 0xf1d81ff0)
1fa0:                   0000000c 0086ae30 00000001 0086ae30 0000000c 000000=
01
1fc0: 0000000c 0086ae30 76ef6ba8 00000004 00000000 005a6dd0 00000000 000000=
00
1fe0: 00000004 7eef2468 76e982fb 76e155a6
Code: e8bd8070 e28030e8 f593f000 e1932f9f (e2822001)
---[ end trace 0000000000000000 ]---

Fixes: 307c897db762 ("spi: spi-imx: replace struct spi_imx_data::bitbang by=
 pointer to struct spi_controller")
Signed-off-by: Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
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



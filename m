Return-Path: <linux-spi+bounces-11316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DCC6F08F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 14:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDF1E50550B
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FCB3612E2;
	Wed, 19 Nov 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mdiZeuPC";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="t+BpKJKR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2B359F8B;
	Wed, 19 Nov 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558846; cv=fail; b=m/kNSiX5ZyUccjkXOcayV+xG+odudQpiGVMLotCedfZFAmSCEkfj8qHZTeks/uAVgdZXTJILcywPBrUVZQDbIR/x73bUcw8YqHMl2vKKYfxSxo5qO7vK+SbEINWNB2n5X+T9zqo8q7fIIHUrq7R+p3MBIvgneikEfxCj4Wg4GMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558846; c=relaxed/simple;
	bh=PZgPdIfwYALa7yHMXJP0oRdgPVKMhe3iBjpAM7HCSDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNelzoCwW/qNgSfXqTIqV/lSFhBJUW5ztepFhqZQtvimp+2TbM70g7Z2jD2fVbtM939/vMeWbx+XWnuaSRzrdcVQLaOD00y3vR0n3RbR1yqxxSBnNPERRDRRH64jHUWHsxMFUTkyF8/S6kc7UbSFzv3U/88LOQ+lnrrq1dxeS0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mdiZeuPC; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=t+BpKJKR; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ60kem2358492;
	Wed, 19 Nov 2025 07:27:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=2+RBVkm7n1+AT/taVNx3H6ZTjNiEKjXUMouaxXKZ+fM=; b=
	mdiZeuPCzE7D9FeUAQ2qd9TVVzPOSggN+F94v3BSzVnnA2CxBfufc6DJLbRiyg2s
	XzNIsq6hVp8LPJ6LZaVD/ciCPA0j8b0NjeXh3aTUHFDnLyF3Ep+ICyUIl/ZDmK0q
	KGYhETDXc2po8IUimymoji6VvLHdQBXYvnNxcs6WkJc1LE5fEMWOknOJ8PpiLZyf
	zDX5sKjNFJXFncE7VDb2q0Tl3ZeQBZIJQ2uZViUPqmNsClzJ/zhoC/ezOIT46Te9
	HNUMdzPui8lPM1ZUFdl644zqdHj2aVrlfGbjx80ns9sCUltOBjdTWkLu3eoltspZ
	YB5uvIMXro7HDOA21yRhWw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020141.outbound.protection.outlook.com [52.101.85.141])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1cxnb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 07:27:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN7JK3A9xzmRAgEwNdbQKm25UQltZSwyMeFEDDTFmA/J/NmS2bcAc9Zt0lwknnk2e2sp4VqWwRFIB1SWFTFRsIUKCp6V5h8Q1S0JBbTJ1tIHWkE2KFms/Bu10OLc3NLS8g+hzUrN34S6/vh8Bidn0/LI6MCzr7Y3TWvruXrtGJ/pYbCfHl7YlnrYs6ScsHMKHknEUHxnk0Yh8poOlp3zrga2Fm3OST4nYeuoFpKWQyV01LS6bYbfUgKsz2LoyuU3egUifrEQIG/tDbpssrXp//i1wp/wAWFgHB5tu7lbAw51a896dqoatRAJw+Mqyb3tq/i9GeSmLZGu0p04XiexAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+RBVkm7n1+AT/taVNx3H6ZTjNiEKjXUMouaxXKZ+fM=;
 b=buQLcs4mLrhGUrJwdlCpR2m4htbo6VlXS043CAj5QIpET5gUi6P2nvS03vtXtse0TB/mApeJWZ82eCBeVC6D1xeFk79xv5nPwuN06lIXgZLO9uE3Q9i/b9Ja7LHanpgzrvQ7F38f1Q8eb1mgW2X/Mo2moRy25r+AEwm9qIgXwnBO0Tlc7IaxJxjyKZhefiuecVj3b+AeG3u2wx61dFJwaZXcJI4fcrGhI/s2tYLmaIemfK2gELfHG/Gxp960927yfuFX96jMenf2UparzVlELm9VkFnZ7PNP6+cm0XIPUxNDpxEEQwrllIDqdraMVtsEpu2s/ykquMHWiP553xiP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+RBVkm7n1+AT/taVNx3H6ZTjNiEKjXUMouaxXKZ+fM=;
 b=t+BpKJKR1V2TdYjiBqA64R+bbaK9xMfADFq40FJtqPVRYO1ktTiIVEap6CUbGGK1BMF4T5FFz6K4MnO7JjAf/XKqrjCbeqv9GRvus+CTotFjE85IDnIjOSyyNgjlIxd8eKXHN8zni64MbEgWRsIB1wAheYOXRz0iOdqwSzowBmo=
Received: from CY5PR15CA0077.namprd15.prod.outlook.com (2603:10b6:930:18::33)
 by DM4PR19MB8303.namprd19.prod.outlook.com (2603:10b6:8:b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:26:56 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::22) by CY5PR15CA0077.outlook.office365.com
 (2603:10b6:930:18::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 13:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 13:26:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 49637406547;
	Wed, 19 Nov 2025 13:26:54 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 5B7F3820247;
	Wed, 19 Nov 2025 13:26:54 +0000 (UTC)
Date: Wed, 19 Nov 2025 13:26:53 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software
 nodes
Message-ID: <aR3FnUNO4DyCdiLD@opensource.cirrus.com>
References: <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
 <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com>
 <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com>
 <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
 <aR2o2R30TbVOcqZe@opensource.cirrus.com>
 <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
 <aR29uKW7yLxws9jA@opensource.cirrus.com>
 <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM4PR19MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 137bf8ac-9f5a-4585-a90b-08de276f4f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0NaSDdBdVZ3VkV1UDVSajVIV2c3N25MZjUrcFNqK1FnY25nSENwcTQ2MW5O?=
 =?utf-8?B?YUZrMVJHSEtoL1BwVUpHdFp0dS8zTjVZQ2lnSVVESzN6aDlQS0g3cmJpbmt3?=
 =?utf-8?B?UUJYYXFySEZYNGt4czV1bk9ZM0ZTYXhWUjZKSlY5NGVuWE4rQU8wRDBEOUFl?=
 =?utf-8?B?RTF0MEt3R3ZIbWFFWW15TmllZjN5VkNHZnMwcDlKVVd6RlpacnJBVGpYMXEr?=
 =?utf-8?B?QklFUlE0bmVucU1lS09CM0RmZ1JuZERyMUNqNVhpR3FpR0x3YjM0Nkc4Q1Js?=
 =?utf-8?B?aUZaQkNiR1lKK0xPVThEU0dRQzhzc3czRTJ6K0crVUF6eFRGRnFMZ3Yya01C?=
 =?utf-8?B?cm93MGVrU05pNWovMWk2THh0UHRlR3RqYmZWN1VsTHg5SjVIRU9hK2VzbFAw?=
 =?utf-8?B?U3ZoSE1UelZrdERNdTZzWlIrUi9lYjhzKzFWL1d1RnAzQ0x3WW5hR3QzUWE4?=
 =?utf-8?B?RVhiQ2dqNWJPRG5OTzllNTdYK1hNUFhxc1lZOExnTzg1NWRkUXVqNFhCQ2hL?=
 =?utf-8?B?UmdBR241RitQWE52ZHhST3hKTlI4SEhoaFpZN2JORXZXOWFLNzhJODJpYVUz?=
 =?utf-8?B?WjhKd3BIazBYbDFPNDlSVEVGcTVmSFhFNnFEM1lJbGtHeEUrNk8rQmpwQmx1?=
 =?utf-8?B?NkpYOGxuZzN5SlY0bDVERzh2KzVHTFlBY3hLb1lDWDMrRWpMQzBGS2J4cEI5?=
 =?utf-8?B?ai9ZQW5XOENpd3pxZXhXRjZYZngzNXp4WngrYzFPY3lZUnU0b1dyMDVVSmdj?=
 =?utf-8?B?cVRpZllLWWgrVWZVNjZzektad09yaTM1QVdCcE1wYW1GR1BhcXBob1lsV3VJ?=
 =?utf-8?B?YU43aFZpKzZXVXY1Q1dHaldPcVFGalJkR0pGYkhzWmo2OHRMaHNzSEhmWnY1?=
 =?utf-8?B?bXp5WXRQbWh6Mit5RzN4clR3M2l2dUV2MUkvYWdTbG5wWXNic2dadk1PWUNO?=
 =?utf-8?B?aTdwRlBKeUozY3VmdzF0aWsvbjZDbnc1WU9vNFFZWmcyay9idmdjSnJWR0Q5?=
 =?utf-8?B?UXF4TnVuK1JNTURjekZjY2hsdUNnSTBPT3VVNi9OZmdFMzB5aGN0aTlZU0pk?=
 =?utf-8?B?ZTNoeG9LcDZHZ2xaZVd0V1VGMDN0MGhoZ3hOSUZwUVdQUEU0dW5tUGU5NnJV?=
 =?utf-8?B?TEpKcndCT2hrUWVwUUdXTkRpL2dOb1ZmMGo1ZDIwN1RHMGZjaytCMlBGNG1k?=
 =?utf-8?B?Tm5Rc3VodnppZzNuZWg5SWRobCtLR0ZJWFFFOUROUFcrYXY5R3ErdlBZSGR3?=
 =?utf-8?B?WjRNdUV4cytZNlA0a05sSFNyeVpxZFlkUDFiTXVLR1pMUTcxRmxlUWU0TFIw?=
 =?utf-8?B?NFc0a3pQa3hLcWZ1RjZIblloTnp6djc5R2tKQWc5Sk9oWlRGTDdjMFJJN3R0?=
 =?utf-8?B?THZOMGsyVjNQYkhyNzZLME92b3pNSkRxV1dtcVBSd0NYV3IyZjUzaVdmUXBT?=
 =?utf-8?B?MFdyK05QUks5N2xVRGN4ZndGMEdsQzBUSStXdVp3U29vdWU4SzcrbmU1bWoy?=
 =?utf-8?B?RnF0R1FTNmtKaXF3cmpZaUppZzlSeDJBU3ZlcHJ2OHR4aENCcUgxUFhhd0hZ?=
 =?utf-8?B?NXFKdGF6ZFlBdUdXNUZ4T1JUeUxxcHRpREoyTkhrNWZ4eWsrazdobEhycms4?=
 =?utf-8?B?b3p4bWh5ZngvMDJJRDZSeXJqK2F3UVh1RWUxeDQxak55UmNUWjROV2VlT2Zm?=
 =?utf-8?B?RzJrelh2L24vSzhEL3F2aDJGc3hCVmt6MkJYaVhvUk5KblBYMTFrWkxrY0Ns?=
 =?utf-8?B?K3kreDBJVjd0L1hrclltbThsRFNFOVpuN0puanF4UWtFVVVhN2ZTYkpjbTZM?=
 =?utf-8?B?SVZtaXFCbXBGeUlMdnZFZmkvRk8wSVRWSTZRQ1Z4OU04S2hsUEJMTlNSa0li?=
 =?utf-8?B?Sm5oU2dtay95UlJSamhlSld0SEFlbVFZakhOTmdEV1VUWEFLaXV3RUcyUlN6?=
 =?utf-8?B?Zjd4QmI2aW1vSGx3K1BtQ2ZWT1drRUo3OURNL1ppSXVyRGs4NnhydXByWUpD?=
 =?utf-8?B?WjRkUk1aRUEwWU5vWm9jSVpXZThXN00vcVpzb3RYR0Y5dmMrTmUxL2JvYzdm?=
 =?utf-8?B?cktJR1MzYjRHbjlxNGludldEY3dCWGM0L3RUQy9GSHdJemljSEhud1RPVUtv?=
 =?utf-8?Q?oHYo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:26:55.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137bf8ac-9f5a-4585-a90b-08de276f4f61
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB8303
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691dc5a4 cx=c_pps
 a=g/OBtAqTw1pRpVLcEUWRsQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=WOD_k__izK6bRcXKzuUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FSJsV7n3ZunUi-SAj9T107HSvnuMqrU_
X-Proofpoint-ORIG-GUID: FSJsV7n3ZunUi-SAj9T107HSvnuMqrU_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEwNyBTYWx0ZWRfX4Fk0z2RNiRRA
 m8QqxFfCJEaV0v+11VQ7ul5r+QiwsDFb4IgugISS9/YlAazBNwEFyJ7EFLdrT7eEYWfwl8rwzCS
 2BEmiwQAv9EdNtjCgR+s/OAEiFLHF3J0bhjrtGR0WqJpeH6ZuHi7dTjF/AwC0HoY3sw2CEt+gTx
 B5HMsPaWF3GDNTY7NtV6s5VuqLFGsR+qqBwFpoIRgy7Gu6cQzYqcKB+JRBH/3JG8WTKBuGSQqgA
 MOOIRr41JrGf5jaZAmwon4nrM6GDn/7fI8Ta9BPOttSJWTUvkxkd7EwHekkYUt3xjKYxUI/Vnlq
 2A+viUrzc5Abw8kwV3pCgOz+Vax1QRaCYM9e/nTQTl0sbPEYgIU4rKTklzeyO4ux3lBAnhE3OPc
 3kc/8ame/jaIRS2XN+AcO7EXz/mFog==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 02:07:55PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 1:53 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Wed, Nov 19, 2025 at 03:58:08AM -0800, Bartosz Golaszewski wrote:
> > > On Wed, 19 Nov 2025 12:24:09 +0100, Charles Keepax
> > > <ckeepax@opensource.cirrus.com> said:
> > > > On Wed, Nov 19, 2025 at 12:06:57PM +0100, Bartosz Golaszewski wrote:
> > > >> On Wed, Nov 19, 2025 at 11:58 AM Andy Shevchenko
> > Can we tackle this the other way around? Since there is only a
> > single fwnode for the device, can we find a way to get away with
> > a single software node for the device too?
> 
> I still don't understand what the software node that's already
> assigned to the SPI device is though? device_add_software_node()
> should work just fine if the only other firmware node the device has
> is the ACPI device node.

Its the software node we assigned to the first MFD cell, that one
succeeds but attaches itself to the ACPI node as a secondary.
When we get to the second cell we try to attach a new node but we
get the one from the first cell since they share an ACPI node.

I think as Andy pointed out though the first 4 patches in your
chain do loosely want we want. Previously, we used the name to
point to the actual pinctrl driver, your patches should let us
do that properly through the fwnode. So we can drop the pinctrl
swnode and just have the cs-gpios bit point at the actual fwnode
instead. I am trying to hack together a strawman but its failing
in a lightly odd way. Hopefully I can get that sorted fairly
soon and post, or I guess I could post a version earlier if you
wanted a look in the knowledge it still doesn't work?

Thanks,
Charles


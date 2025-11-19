Return-Path: <linux-spi+bounces-11331-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA60CC6FE35
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 201EE2F4EC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A500369209;
	Wed, 19 Nov 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Hy1sXxN1";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="EzdXckej"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF8534106F;
	Wed, 19 Nov 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567541; cv=fail; b=UxgWmyG24MkwkXIYRyDtnqFaMgHoKd2FBRGhpGK4vS5XTTWklHckAUCS2c5+A+NcAAcfoAwoQDDN9LhbymgPiUCgw6TtZ0VQIeEcCAlfc7K9x6aEeeAP5LfeI5bk4i9kuF4r5pCHHNMskWp2XNosmHngStlNWlXs4eY1oXdJYyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567541; c=relaxed/simple;
	bh=vzLvG7XluJaHzx/VR94Ub5uTKKUrAYNxZpFjoL9QZmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnANw7aIrHonabETCvxitIInKUU0gAfDt1FwcCIkiyXcOaHDGFMBX1p3l1ICnQS0ADH4p/T62vSSdKu/OvPrji0E48mv9W/JmTs8EUqf72ySezk4CvgDsJvt9QIA1VaAh6bPRMtWIFY5Uo2yQN+ueWdYmOdbZ/JBJLT/jL9laDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Hy1sXxN1; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=EzdXckej; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ0QBoI1832304;
	Wed, 19 Nov 2025 09:52:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Ea+idX4IwazHnhHDT2RtVyopYrChvxc99Fq0vbVdF4A=; b=
	Hy1sXxN1HTSK1Rt7qC0/dznymYNBAp/2ICykyvCBcQ7+XGtvdQ/FNdEnoTVJrCxZ
	GT6xdl4Cjifrxp1W/9sZLHdWFFsl0eCEOZzcG8QExedvZTUT+tKw1DC9guabfyIW
	iZEmJnO8/JWx+1GYZlSWWCcoUGqo5XcyS+yUReeDkNMBx1THSTIEEAppgu2qCfkY
	IJges1hIvKeel4f77QExXoyF3fgH3bb5JRgBmcuvdprz4bcQZXeg+hi6V352yfYu
	wkyZsiJ6A+hfRZK22nt+487SlJWDXmyo1jNpuQTDXbMrotG4CHVdk7awvaC8pyFy
	Srq6w2QGmo9T+abOBs903Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020074.outbound.protection.outlook.com [52.101.46.74])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1d61v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 09:52:08 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2xtIB11zoUrLDEiGw5+cyd3QlbOeyu6dyPFMtE4sQ+n2E+ExHOi1SwLhQGuE2NEYumpvqHlMRv9CEsnkxTyuFARCIvUSyfqbmpB/xkjuiz4t9ykvxd+5ZrDdwLM2+sxggu2OcOnRndnu70EuQ66VwJXJ+x+Q0o1X62F0Ug/0JOUkUSqIetRPBJ0B3QU5Huc88IzVrBfOpaBI/XilXKoIvgp7oMR6Q96ccysEyQBixCoSQ2biGwLt5RBUnZdk3gUJaG21CumBa0bBbypnsuPGJ2OUuNwEnheLooGKqVhABL7QT9RsQGAiBRHf2RjNRvfqETDyTVlsvthjLkjIBOO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ea+idX4IwazHnhHDT2RtVyopYrChvxc99Fq0vbVdF4A=;
 b=sI/q5EPv6kSvOWPBYTXIMw+qHl8avrXZdpa3tmZlS1W6r/lcuYnkxGMQYue6jWDCPzChcbnpq9DmEzdJbCYxJ9AuT+1HXuEvJPDCCSnZfxYz0PvezB5DK0I1Rm7VeTOiMMIvGb9wNOWExORgWkpNfzZqFT0FQpu8NYbZEkvPVUnPaE+3z4DpZFwoxH0x2Sm/6+LRSGghNd7jJPeWV6Mxa65PUc6oOIMWsovsiR9xV5RHGlr6KkyofJoqtnf56hDAlZlcUIUD/Zfr1L5xZBQwd+Mdg2pkaoi51066PvXzDjaLB+FCRgyMM/qzSy75iIm5xfZXC0xGw58FgHZO+q5uiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea+idX4IwazHnhHDT2RtVyopYrChvxc99Fq0vbVdF4A=;
 b=EzdXckej2ZTcwoarVRJR6t6510yknUDMiqEUjzo0sQZzXq33BEChfJ2aC39NStmbUEjV35hIYg+rtOp3MqBP5O6TdqgnNnbEYp64k2K7QMG/otuEckPeEZvGcATNA2GfgdNl1S0PUMkc75KSSIkimNPpBWNXwoZmyfIdpO/hUKw=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by LV9PR19MB9085.namprd19.prod.outlook.com (2603:10b6:408:2f4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 15:52:06 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::6e) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 15:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 15:52:04 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id C2AD4406547;
	Wed, 19 Nov 2025 15:52:02 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A5311820247;
	Wed, 19 Nov 2025 15:52:02 +0000 (UTC)
Date: Wed, 19 Nov 2025 15:52:01 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Andy Shevchenko <andy@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-spi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFT/RFC 2/2] mfd: cs42l43: use GPIO machine lookup for
 cs-gpios
Message-ID: <aR3noZXxma9vOXEI@opensource.cirrus.com>
References: <20251119-cs42l43-gpio-lookup-v1-0-029b1d9e1843@linaro.org>
 <20251119-cs42l43-gpio-lookup-v1-2-029b1d9e1843@linaro.org>
 <CAMRc=Md4jHrHxHUOM=eFuWRSaEO9jFEoHGTjEEJLj9w6E53gOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md4jHrHxHUOM=eFuWRSaEO9jFEoHGTjEEJLj9w6E53gOA@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|LV9PR19MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dda8688-611f-45d7-8b11-08de2783964b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGNzenBETXZ2OGk2NXFEVDBsd3pac3pZV1BRK3VrNHp1TStOSjRoV1JVcjNO?=
 =?utf-8?B?MXZOdFlqOUZqQXFRZnQxSWpKblkxaklTYzNmY2JNeWlkQkNCSnNJeUNlWVhN?=
 =?utf-8?B?SkdsNzZjb3RuZzNyRnQ5Uko0QTJSU1RsZVRhci9HVFRYNDlMSEhvbTdVVHl2?=
 =?utf-8?B?VGEwWTdodzBRWjAwa1hIU1VhckxmZTBXYitFTXl6YjVrdVBBcmlmTUZSUDZs?=
 =?utf-8?B?amxYbXdNd1QyUXJwMTFlak5WZzZpaWQ2VlBWTDM4RTFNYVRpL2RiY0RTdnhQ?=
 =?utf-8?B?Z0tpbUN5L1RFTFh0OThjdjBCSEFMRlBORmtXMHRUSUg1ZUdWVUkxSHZhWUlS?=
 =?utf-8?B?d2YxOTh4cjVwenZTQ0VRWG1vS1Ard1l3VHIyYnNvb2I0c3lqbW1qV3FYdW1S?=
 =?utf-8?B?TVZ6TXREaS9Td2RDbUU5cnM0UlBpdDdHd0psT1lPd0dIU2hzRG0yUlM5d1Qr?=
 =?utf-8?B?YzBVZXVObDN2TnhtSWVUYjM4LzgyZ0U0M1ZRTlpMaWNubTA0Mkh1TGsweXJH?=
 =?utf-8?B?eEcyRDAxSks5Z2txcTN0N2ZHZjBUc29pSlRXcTQ3YkJ0UEo2V2xQVmNYWUxy?=
 =?utf-8?B?REdjVFI1blhZYXZ3dlBuSGk0YUhuRXhrbXd2N29nQkJCaDNpWTFHdWhxSEdn?=
 =?utf-8?B?bWpGdDhxSlBBaGlhT0VDT0hWNU5yRkF1QVNGbDRNK3dRd0p3d3VWNVRXV3dQ?=
 =?utf-8?B?MXArSHdPUnNETzBWTzEwUmxROWl3bUJGMjEzUnhDQ04xRHUwTEFJa1FudlZO?=
 =?utf-8?B?bUtsMzYwRFVOMVRaQUFMSThBWXZuVlU5VHd6cXBNajRoQ1ZnZ2xNbEM0amE5?=
 =?utf-8?B?MFY2eFY3MzNSTFJzZ2pRN3BHeFc1MENqbGwrcXdCL2NRZGEvMjVwRGttTjhw?=
 =?utf-8?B?Rnl1dzBRR1VxYXc4OGhJeEhlQkN2c3Jzd2VnRjdXUXRiU2x1eStZd1R3MVVX?=
 =?utf-8?B?bXFsQndIVDNNbGpTZTlMNEx6Zzh6ais5UDFER1d3aEQwS0xrL3I2ZTVNbWpQ?=
 =?utf-8?B?ZldFem5wcTlyODUyZ1g0VVJJU0MxZHZMZWwzNk9JZWpyTzBZcmVUcE1sbFFJ?=
 =?utf-8?B?QThIWFhKTEdhZGVJcjNlMzdoRzUxMUQrTVgyaXFERUtSQ05aZm5ZaG1oZGZq?=
 =?utf-8?B?a3N6WGF4WkdzZUNrSm1EejVJVWpVc2t4UW1rNHQ2c2djckRWcU1wR1hwdmww?=
 =?utf-8?B?blFzWWU0WG1YNzlueVlEMFZ6TlNpUW05NWFvTDBRdTdMc2lPbWdZVldMWk5x?=
 =?utf-8?B?Z0FNTmhiZlVqUlJoellqNjRITW83ZDU1aHl5R2hDNHNCeUNOSG9OQXh5YzNB?=
 =?utf-8?B?NWpjbXB5V2ozYmNpU0xxclRQd0U1ejBpZWt4UksrTW1peVErelluMUw3Wk9v?=
 =?utf-8?B?ZkVhSlk2d1FFU00rTU85RXNPNE5xOTJ3ai83MjFKTC9GTmtRSDFmSGxNVlZ3?=
 =?utf-8?B?RkxHeldQVFBxcWFJWS8wZDNvejN6dW8yTUdFdUF3UmZERHdDUko1VDZnTnNY?=
 =?utf-8?B?VlBNRmxmS2V6T1l0ci8zTjk0OEtEbTJONDFKRXdJOTdzeUVVdDJCNThicHk1?=
 =?utf-8?B?VUJyd2R3NmtvTVpKNys4RzhxNXdMMXI4YThWcVhpR3RLVWNTRExOVGF4Qm52?=
 =?utf-8?B?WHJRTDZUclg3cUdvQ3dXdnpRNEN4VHUwTVhTakpJWWNSVlhvTytySjM1aExl?=
 =?utf-8?B?aXF4blVKcnNDeUhQRGhzT2hlWEh1NjJXY0lmbUtMN3g4b3dGNGtkZ2cyMG0x?=
 =?utf-8?B?aGs4VHJtQkovZDdxZVNOSEU3cldadkZEMnd4MmUyUDYvSmxWb09BQTF3U0Ey?=
 =?utf-8?B?ektzeDBlYVErTHlVeU1wb01VemhpcmF4cVpkRmpobXAxQkZVRUFiZmhHc1lB?=
 =?utf-8?B?SlZUVkRKNVV5RG9Jc1V6Vm0rU2gyRWZIUHIyK1V1THlPd2FIdVk1dWR4OWgw?=
 =?utf-8?B?MXRndXJNdHhkZFZ6VlM3ZENZdVozVWp4bWhCRExoNHZRRkt2Ry9Dbmd0R2s5?=
 =?utf-8?B?VHB6czB5SG9IQmZXZjcwVVEvT0gzd2xRYXhlSlNNSmpESGZMWHB1by9KRzN6?=
 =?utf-8?B?ZW5tR0hwRVFJZGFrYVNiKytLUXdud0lYSHdtRDM5M1BYM3U3UWF2UlFoMjVI?=
 =?utf-8?Q?+6qM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:52:04.5588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dda8688-611f-45d7-8b11-08de2783964b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR19MB9085
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691de7a8 cx=c_pps
 a=WjvyLEvnPukujdTL3r9oMw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=KKAkSRfTAAAA:8
 a=2WepCDA5Qn4-z1COq8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LLiZiJfmflKlGpTdxPEdjRCGBaNOdJtE
X-Proofpoint-ORIG-GUID: LLiZiJfmflKlGpTdxPEdjRCGBaNOdJtE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyNSBTYWx0ZWRfX24kscGuKT5Ws
 SLhUouh4DtTGnJZY1fGXWVG63byPFRLrwhh5ZJLiUf0QO0hgibexBq+FRKBgHX0c1OYxXyLTV9+
 zFRdPLEHeTDwq7pWTeMcv6VRh3FKWpHuD6HulzhEdcOew6NjTc7p9Er/gvMWBff3RfOtQFVmWN8
 ckHUK0dJwP3WwnsiBQ9Ep+RMhBptbB+WrpqnXLazQoIRzNg652ruxwUvTYzsp2T2Y/oSK7dvBMq
 7YMD+d6hX3J4vtrnv58jKAQX3maO43DsGOqlJu90fm8D9g7NLNFk9jQ/6RLX4O6o0KalIIXVBzV
 Qp1phFaO7x6gz08UlNbh3wm3+Kdm+ECZ+Glgq4VrvYRC4HuM8D/5z998U+U82RF3dgFSWYE/jzf
 uZC/GOUfMS0fOJB/3Gg+P1iOs5CrMQ==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 04:35:07PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 4:21 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Currently the SPI driver sets up a software node referencing the GPIO
> > controller exposing the chip-select GPIO but this node never gets
> > attached to the actual GPIO provider. The lookup uses the weird way GPIO
> > core performs the software node lookup by the swnode's name. We want to
> > switch to a true firmware node lookup in GPIO core but without the true
> > link, this driver will break.
> >
> > We can't use software nodes as only one software node per device is
> > allowed and the ACPI node the MFD device uses has a secondary node
> > already attached.
> >
> > Let's switch to GPIO machine lookup instead.
> >
> > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> > Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Closes: https://lore.kernel.org/all/aRyf7qDdHKABppP8@opensource.cirrus.com/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >
> > +static struct gpiod_lookup_table cs42l43_gpio_lookup = {
> > +       .dev_id = "cs42l43-spi",
> > +       .table = {
> > +               GPIO_LOOKUP("cs42l43-pinctrl", 0, "cs", GPIO_ACTIVE_LOW),
> > +               GPIO_LOOKUP(INIT_ERR_PTR(-ENOENT), 0, "cs", 0),
> 
> I sent the wrong version, sorry. This should have been:
> 
> GPIO_LOOKUP_IDX("cs42l43-pinctrl", 0, "cs", 0, GPIO_ACTIVE_LOW),
> GPIO_LOOKUP_IDX(INIT_ERR_PTR(-ENOENT), 0, "cs", 1, 0),
> 
> Charles: Can you fix it up yourself before testing?

Yeah can do, but I am still very nervous about how this approach
interacts with device tree and ACPI systems doing things
normally. Is this also ignored if the firmware specifies the
properties correctly? I feel like if we go this route I am going
to have to bring up a few extra things to test on as its quite a
big change.

Apologies for the delay on my suggestion but something weird is
happening deep in the swnode stuff and its taking me ages to peel
back all the layers of in abstraction there. It seems something
copies all the properties and somehow the fwnode I want doesn't
make it through that process. But the basic idea is like:

props = devm_kmemdup(priv->dev, cs42l43_cs_props,
		     sizeof(cs42l43_cs_props), GFP_KERNEL);
if (!props)
	return -ENOMEM;

args = devm_kmemdup(priv->dev, cs42l43_cs_refs,
		    sizeof(cs42l43_cs_refs), GFP_KERNEL);
if (!args)
	return -ENOMEM;

args[0].fwnode = fwnode;
props->pointer = props;

ie. As your patches add support for using the geniune firmware
node just do so.

Thanks,
Charles


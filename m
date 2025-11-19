Return-Path: <linux-spi+bounces-11351-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B6C7045E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 779483A7E88
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BD361DB2;
	Wed, 19 Nov 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OLWk+RS/";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="hmt8DzUc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023A27A442;
	Wed, 19 Nov 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570662; cv=fail; b=Fdbj1IKypjRoqPliUouXaLV9NPcmANP7jBloTMLeATCIreQspxVZQPLZ6tls52ghRMWWMe33IaifjpP5CiivsXMEr8Gd9DhAbnsD132KanTO8bw25JIvEg3PHBaeaZiAYB5R/o7/z0+VZ9q5s5avdugBSgYgTGLY3/F4cuomT8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570662; c=relaxed/simple;
	bh=j0KVW2NQ26DENYGoF1g9ZLfHqGENm0F5+Al2cgzBQ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPph1f8f2qNE3hPBIxyaBm9DSuiTI74vFJsQNJdK0opJr4muw5oPINNetbbmZf73lwRzLAroy9LSzD3fH4c02s2SBx1ZRB1K/D5xr1eOH+VPIZoRX2sZK19Te+kOsQK0I24U4OH8pc+cpsnWv3NCqI4XxlXxz7pK/e0i6Sz6faQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=OLWk+RS/; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=hmt8DzUc; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ60ksD2358492;
	Wed, 19 Nov 2025 10:43:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=slTkA9jh4n46KBJPKGDJUoJcdKUBTz5GjhF7kd76284=; b=
	OLWk+RS/pV2su+cD/Iq2fw5miJ/lIz4A83SN3bOJveX3Nk6pPJD7u+ZvVU1i3IM6
	jwp1JuJT5JOFX98O/TOd+dJWUA1cZdWwRj1CaFDRpmDhvz38njfPNfL+FhwZcArf
	oX4i0oi+Hio1vAPG6SMMn+m4Tr0v9Y3dG8hDffyEfUmx7x6w0a21+Xtf7fj//0zE
	Cyhxt4/b/sz+Zx7ZKDJ/mgkzh/ICOZ64QHGFdJgc0fs2LEgu7xRCSH6jMGEOxdMq
	YKHTbZ/4nhZz7J6s4QpZYW/JNtV7fE1Rog8XbkmMqNwowP5BubEqFirorBUW0kGi
	TiwUPg9wFkvZjSBeox873w==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023091.outbound.protection.outlook.com [40.107.201.91])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1d8wm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 10:43:57 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfliDn7cSBn3EM86Jfa4oICAbS7luQCW+2lLkoEJHFAfvfAqb5Owkfpc1bl4gL1A4eqfR3n6lAsag61XctJ4dDm0c1ux1RY3cpTOX2ETZhpC6AwiL1KvgGVr3oRpKDh6fsSSFkn0OQVruTXFY1RVFcTk4YRMKrhNKuA/KZn4IUWIFM052Lbmwq7Rdiu0AvsYttek0IooZxGzoCgAaqiMuqxPIq33EIiC7YLJMUXh/df9NY4KTH+uxtI/35BgtQPwhi7CBfltLSsZQXeZicYz9JzwD4BHr8YveOEcxV87XC7H4f2RoAf7dO2PvuwvkBksYJcaHB8E4OfNfJO5x4p8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slTkA9jh4n46KBJPKGDJUoJcdKUBTz5GjhF7kd76284=;
 b=gtm2VO5O5ljDv+qTwMr02udVP+EP0IzbhCjuuq+k+jQF5N+EMdMfxe4+mVhzS79kThREcoALGcfmAHc/lI5c3Wzn7fMguqcj0q5PO1729Emev/SRTTSuO9k7sUX8ivVBTa2xU5Qj2IVM7AW/HLsRly4hn6pvf7WpmbeOYrz2RxB8ah2TyjXjSVNvFLDwXtqF8J/bGrMucmC9htDoPLtwY07PF8aYkikFGUDWzAj9o0P+td9TGWaiRZRFebN+RKk08W57t7hjp1BZkzcuJP91kvrBaxl9YkkV8RuoA7R9xJylA17RKo+2/gyl5NYLdslarvizJNv+/8hRZoPJ+Gk78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slTkA9jh4n46KBJPKGDJUoJcdKUBTz5GjhF7kd76284=;
 b=hmt8DzUc6xPNApKNt+4bnDphlIlJOdxf0HGFu9Q5kEu4Mwkm5M7AJ+EFO0nA5VXuR67FMzJsBsrGreTdSNm2bWs2xau4OMNgCFXe7rk+fG1f6OWqfcc/SNQX4UHUQVVDACdwCLJOBVTX3jowesr7IutcC+MQbtXBtHiVbwygYvM=
Received: from SJ0PR13CA0170.namprd13.prod.outlook.com (2603:10b6:a03:2c7::25)
 by LV2PR19MB5766.namprd19.prod.outlook.com (2603:10b6:408:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:43:51 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::17) by SJ0PR13CA0170.outlook.office365.com
 (2603:10b6:a03:2c7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 16:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 16:43:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A05CE406547;
	Wed, 19 Nov 2025 16:43:48 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7DD53820257;
	Wed, 19 Nov 2025 16:43:48 +0000 (UTC)
Date: Wed, 19 Nov 2025 16:43:47 +0000
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
Message-ID: <aR3zw1zqDldZCu7M@opensource.cirrus.com>
References: <20251119-cs42l43-gpio-lookup-v1-0-029b1d9e1843@linaro.org>
 <20251119-cs42l43-gpio-lookup-v1-2-029b1d9e1843@linaro.org>
 <CAMRc=Md4jHrHxHUOM=eFuWRSaEO9jFEoHGTjEEJLj9w6E53gOA@mail.gmail.com>
 <aR3noZXxma9vOXEI@opensource.cirrus.com>
 <CAMRc=MdYJ0+yXziHB5ok40yUJMyYPKPt0K5COXDm3tM6dWqAJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdYJ0+yXziHB5ok40yUJMyYPKPt0K5COXDm3tM6dWqAJQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|LV2PR19MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 6287243d-f4cb-4db2-5ff1-08de278ad186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|61400799027|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFJiS0FCbDdtVy9ScGI0LzZBTG9hZ3N2ZzJqWTgwSFVKa0tYT2dXSEYwc2Yx?=
 =?utf-8?B?d3RKeDhpMXZtcWZ2dzVIY0dlQTBBSFZCalo4eDF3SUNEOU0yTjNvTHhtWEQw?=
 =?utf-8?B?MDQ5djNHWjdpd0pFUDVBdzB4ZHJRYVBMR2w2aDM1bm9ZN1ZBcDZHMzNUODNG?=
 =?utf-8?B?SHhFaTFqMEZmQ0ZDbG9yVFlWaHpVUWZIdzh4ZzhxN1BOc2l3Qkg2eVZFNmw1?=
 =?utf-8?B?QWQ1emtHY095ZjMwNDNsbU5GTGcvc1ZEbXNVZW1LL2tkK0hFdytkckJ4d3gy?=
 =?utf-8?B?NnJMRjN5aFJBSzVvSjlCY0xxellXZ0lOc2EzSUYrVVo5R1BLbU5ORVFpMFNr?=
 =?utf-8?B?R3pQZHFLOWlSQ25Gck5jVlZEcmFRTGZJZmVIZEYxaWd6NUx6QkI1Wlh4VFVC?=
 =?utf-8?B?bTh3OEE5YWQvMThMZmNYWXEvU00xcjZJeVB1LzRDcVhlY3JHMExjZWVoT09S?=
 =?utf-8?B?OVBLNGFkb2J2Kzl4dVJYR1laVDVvOElNOFMrWFp4S3pBaUtjT1FsQ1QzSjdX?=
 =?utf-8?B?YXlLMExhQ21WYTlkL2FYY3dKeko0SGV3ZDIxZUdzMEt6YkdiQ2RmUWswUjlm?=
 =?utf-8?B?YUhvNXNVb1MyZHg5NGZ6UXhUbk1DMkVRRmZ6YytSbzloRFlxR2ZtWnBVK291?=
 =?utf-8?B?VlBkM3I4MGtWbkptSFhJcGp1WlhmODVyYkZHZnptdEI4RHhpZk9nV0FQS1Bn?=
 =?utf-8?B?MXRPRXRFR3gvOUFOdWhyMExzL0gxSVFVZFM2SGNsOS96YXVrYm1YWko3YXZv?=
 =?utf-8?B?QWNHTk15Q0ZpaWltdjVTTlp2WnF2UW1EejJ5Zm5NUlhxRUM5N2NOcjJnK3Ro?=
 =?utf-8?B?QjI2UGh1MW96TjRCMzREMzl1NXJvMjExWHlWQnd4OWx2VG1vdUV5K3M2RHF6?=
 =?utf-8?B?ZkZBR2VRb3R4RmE2bFNDZUI1UXVJNStVNGFaU210R1FaOXlBQ2VyQXpEZ1lo?=
 =?utf-8?B?dHArajlxbG54VEdEVHRhOVUvN3JFSGI4SHZ6WjBybjd1N1VFUUl6Z0FaaStF?=
 =?utf-8?B?UDRHWFE4WThNY1o5T2k1ZEhDNmNOaTJmWE9jWUluZGVLbXhIM0xWcngwckxj?=
 =?utf-8?B?NWpwMmxvM0xVMUZYeTZ1cTU2b2F2VDdIcTgvZzJWbnRrS3lQODhlUU8yQklx?=
 =?utf-8?B?bGx4R0h5b2xTOE1GQm1TUmVwZ3dTS1UvYko0dzJIQThBS09DRnFmUkNjQk1i?=
 =?utf-8?B?WHdjL0VqYzRKUng1d01DZG5qTndqQ1RreEdpdEZ2SzJjM3hvNTByMjFrK09I?=
 =?utf-8?B?ZThhS21JQVhYRHZnaFk3bytIVllDZ1ZKK0JCNTFMOUY1WllIQnpkSVVCOWxC?=
 =?utf-8?B?RkpGbnlhSTFBUXg0M2xQVHZQZS8yUHlxVEpERkVTUFNsQ3kremlDQVlSRS9C?=
 =?utf-8?B?YldSOVkycWxKTWp6a2VaYWVLcUtYMFVGK1FDMCtuUUZ2SHozak9FYTlIdWNs?=
 =?utf-8?B?ZkpBTzk1dWp6cUZtTGxaRHY2UGZiMDZJKzAyc0dSZGxpNmJMRERCNjY3aTFN?=
 =?utf-8?B?WDNPQmgyR3Rnd0QxRlBOY1cyaXl2UVllRk53UWlFOFV3MG92VnA4L2t5b1Nu?=
 =?utf-8?B?VUhYZXcwYlE2N0FvMWZFbVpMVkV3TUdQU252ejF5YW55Yy9wRzZpcFkrQS9t?=
 =?utf-8?B?LzRuT2dZdGdUT25CZURGbkgwMWpzalg3OXpmK0NSQ0JRMnpURk9ud0J2NU9R?=
 =?utf-8?B?QlpGR1FLSDUvTkZCQTZTZHY5aFFvSUZmWDREcUlpWGF5V3NDeWdIeFd0VG5P?=
 =?utf-8?B?NksvZ3BqSW1MYWF0Q2xWM29BTkI1VGN0OXFybmNkUXRwTnhQcERybjBPeC8x?=
 =?utf-8?B?bGtRSUIxVE51djVDSXZkb3B3cnRHWVBIRDZITEd6N1BaVXJhc3BScXlZYTEv?=
 =?utf-8?B?elcrV2E2ZmxnM0pLTGZsWStIcytHbGtVaGFSZ3NaVFArMWhoZnZITVJKYjBX?=
 =?utf-8?B?eW1mbDRBNW51Z0tJZExiZWJnUGZWY2NQZ2NKakFTODNxSHhRc1BRZkJTQWp1?=
 =?utf-8?B?czFVdXRiRDAvUXNBMFlCZEI1eTN3RnJmTVc2TTFxVXJWcGJUaDRMdTNMbGNM?=
 =?utf-8?B?Zzc3WmUxWTFTM0JFWEZFZmp4VDV4YnFzWlZQZ0RWSnpSY3JueVBDVDl6Z1RX?=
 =?utf-8?Q?GCbo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(61400799027)(36860700013)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:43:50.4000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6287243d-f4cb-4db2-5ff1-08de278ad186
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5766
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691df3cd cx=c_pps
 a=yYYKAKAKl8D9GxIYT1WzoA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=plTyxhm5LpqnIAvPtcYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KdJ6OULfHp_Ca-jXSWKygEOcFp36M-Fn
X-Proofpoint-ORIG-GUID: KdJ6OULfHp_Ca-jXSWKygEOcFp36M-Fn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEzMiBTYWx0ZWRfX0o8Zd0YpfAc7
 V8ptZdUELT2anj/ahAcpp+/cDVqTknBPZ5ecSmc9G1vPEOELUV1KQSu0VUSFcb/MLYKRrmPJKND
 8bkcPnTAT7Q7qFN6FF1enJVq6J8LuLMKfSHCOeJLRiM3o6+s2qc9q2kmRDOmzNiyPbjRgVXFwSq
 L2bC95Ozb71gcBvA6rCE1a/eYT6K4xcquPc5owoDpG49Q6DQtya6/PJ6MY/W18M6+rBqaag0gRX
 HP3xbEw2vcIKQ5qFWbwdoLl57xkoZo3t9ix9PBCMm59mZTFdy8JnGQybxoDyDDMZ5X3BcrTmWUs
 FLrKIOJad2qKkQ2FQRhSmFyalDBijW/vgGCobSTs0mUqvMPnJcixleeBAOW2UXjiBYA/UrqAroa
 /QeGt0O1o6AEJb7SYln5eh/uSz98AA==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 05:28:54PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 4:52 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Wed, Nov 19, 2025 at 04:35:07PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 19, 2025 at 4:21 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > props = devm_kmemdup(priv->dev, cs42l43_cs_props,
> >                      sizeof(cs42l43_cs_props), GFP_KERNEL);
> > if (!props)
> >         return -ENOMEM;
> >
> > args = devm_kmemdup(priv->dev, cs42l43_cs_refs,
> >                     sizeof(cs42l43_cs_refs), GFP_KERNEL);
> > if (!args)
> >         return -ENOMEM;
> >
> > args[0].fwnode = fwnode;
> > props->pointer = props;
> >
> > ie. As your patches add support for using the geniune firmware
> > node just do so.
> >
> 
> But do you have the firmware node at the time of doing the above? The
> software node must first be registered with the swnode subsystem to
> become an actual firmware node. Only then can you reference it by its
> firmware node address.

The firmware node here isn't referring to a software node it is
referring to the actual ACPI node. As in we are now correctly
specifying the GPIO using the ACPI node rather than depending on
the name based lookup to find the driver. The problem was before
your patches we couldn't do that as it wasn't possible.

I have sent a patch for you guys to have a look at and see what
you think. I am slightly inclined to favour that approach since
it changes a lot less about the system and once we are no longer
relying on name based look up I think everything the driver is
doing is all above board and legit.

Thanks,
Charels


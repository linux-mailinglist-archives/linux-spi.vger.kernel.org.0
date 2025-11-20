Return-Path: <linux-spi+bounces-11385-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D0C7363C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 11:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB34E8DAA
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1063019CD;
	Thu, 20 Nov 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UolA3ac1";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="FP9eCMKl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFF2264A9;
	Thu, 20 Nov 2025 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633233; cv=fail; b=C5UFFSl3q7+b/lWUiqqPcpsdd5TdZFwPsh/v8pD77b0SMMnyTNFcCfvD8AHNN+9aMStrnHakO4myvB4bhUProh4ak0l2V1Mt3dF970lr39KozxeDeQI2ivnROJRFXBVLS6glYfjwRKAKmewXSeYSEXngM0GiPI+wRJKKm2Ne1Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633233; c=relaxed/simple;
	bh=kDvSTPtfqnlekpHHWTRTYvR5sOL2XztVC64vmXmSGQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCrvrRdu5l49tpFy8D9WCyCVPFKiXs0idM7eLha8d9SnmbT0PUR3Vsxfzma0n49QmCorvfqbAVlPeOc7LvY+J6KfUVMTOlAUouf1oE3NSdwaWRCw5y1jOdzQ0wIa4RWTGYUw3DrpyMzXNKr92hTEcQth74M0EeHiiwXpUWvAlgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UolA3ac1; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=FP9eCMKl; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK5KmPA311678;
	Thu, 20 Nov 2025 04:06:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=MhOChC2/yMYV4dDCa4NXEM2qQIYp2xkrRVyAH1TSpUg=; b=
	UolA3ac1hmeez3x6KmSHHqQrsd6okXJuI1ZO35eBejCnc5U8cxXlrzcpcmV8hHxG
	ijSmJ00sCRu4FU0PP7OjNEOTYH8NGXMNS+Eb+tstpPGx6mKItOBIN+NI9HNiE3+1
	Xj+PqZpP8lTuiJ5A34WUGmjN1cUZJH9GSQ/odIfConNBEMuZ55fR11fXJ/ZDJuNG
	zTwlkQbFXbXPhilBOuQskPMsF1sd7xQngzxL6Fz56//+EWwddhGB+tV9nNUawUta
	kqfTEvl2tP7L57mPg+3rJ8uMkbTGi0zbg8RUBS8fTTxV3ehEkwBfGRppD+MxkoS1
	FqWC/UkZ51JmN5kgKnGgKQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023079.outbound.protection.outlook.com [40.107.201.79])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ah1bma5kg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 04:06:51 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkfiDfI/h79O87Stbb4BiQHJsiSmocSScBOHuJqLRY9gj8iUffmByB2DeJsGbNT945fPywyzTE2A1DWRGOTbgeQhONC2+il9k0fGo4Mzj5b2ujqnPQcSVtAkWcmGPb49JUziiMePwwwkZBCmtlh0sWKM33BE/ARgR7EYCV5p+0qiqXeuKT+DQT+eV4cNuC6vpshkm+OexX3gYDvpdsr8rz1UalkFLaNi2D5k1t5neIFk2h5fxZXr4a2RaquDuyp15zceI4cjVICSSDPNuHP7PbpGaSNa7/DCz0JcVfiIHsgcOqJ3CuQQhVuM/Qw3nSUZ+wZ8D5Y9QerX1AmGH/vn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhOChC2/yMYV4dDCa4NXEM2qQIYp2xkrRVyAH1TSpUg=;
 b=fsdOxQPmVXWL5MMwWtr1M8HhrHbIy5rpXr99cqKB2DuB9h1egleq79VfXkxpEMBJcfn/Qz4NFxEs0gBiPVS+g/lY8BlKmfPzo/HI0Fu0k0Uy29FFr3JPtuqLvr4xV4mN4/S32l+96DD53sMun8Sd4QLOgjQeA5dw/stPu5IUtD7PvZalBKkpovzF0YqsTVQ6bTPMBX7WZEFkN4M0gMjmPQizu3L3hZgmEVNZmdNolOXVCvWeBQVLGhbA5LfPryawwHEdH4VJwlQeHhXGz6nhK4ZzSvjXG/sUr+yT3kU/GFPmpFxt/SmRc/rzCQcLGhnilcPVh1pJ/yo5WlfcrBFZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhOChC2/yMYV4dDCa4NXEM2qQIYp2xkrRVyAH1TSpUg=;
 b=FP9eCMKlDyaKyGPM+7ecjWkNnJokxOyALIp08rq2O1DqgKIybn0oL2qlOeLfcjmDQm+frXUu2AiiWxZMAkFbHo9YPVWVgka3h1NQnRUHys3mp1dw+F8iwBsp4sW+HO9Kw2+mnx4Cw1MzDAu6w+x0U2P3UJBM03/H/sVLwuK3nyU=
Received: from SA0PR11CA0081.namprd11.prod.outlook.com (2603:10b6:806:d2::26)
 by PH0PR19MB4906.namprd19.prod.outlook.com (2603:10b6:510:a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 10:06:46 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::3e) by SA0PR11CA0081.outlook.office365.com
 (2603:10b6:806:d2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 10:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Thu, 20 Nov 2025 10:06:45 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 24B2A406547;
	Thu, 20 Nov 2025 10:06:44 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0D97F820247;
	Thu, 20 Nov 2025 10:06:44 +0000 (UTC)
Date: Thu, 20 Nov 2025 10:06:42 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: broonie@kernel.org, linus.walleij@linaro.org, andy@kernel.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, bartosz.golaszewski@linaro.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
Message-ID: <aR7oMlVpUL9prRLs@opensource.cirrus.com>
References: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MdcL0f9aE5emAsFLmwZoN5_-qM4JCSzP6D3J8D1PrsaEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdcL0f9aE5emAsFLmwZoN5_-qM4JCSzP6D3J8D1PrsaEg@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|PH0PR19MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: d41e4310-c836-40af-2701-08de281c830d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjUxcTlkZEV1cTdISmxROVcySktROTl2V3MybW5EdmVhUTJCdnFCb2NhR2Ez?=
 =?utf-8?B?Nld5dDRRSVhvQ0lZV09hRWh5WjhFTXNOS1AyOXdwb0lEYmJ2TkV2Q2FHR3g4?=
 =?utf-8?B?c3NvOHRoTHpYZk45MHNJRmYxOXh2a0JreHdhTFZndFhqSXdORVhLZ2hUMFB2?=
 =?utf-8?B?b0Q3NVlsUkJMd3RYdmtPMjAyK09lRzJBMGcrVWIwNnNOQWsyU0ZtbGxPMlBj?=
 =?utf-8?B?c2RnZld3dzQ2QjlBcS9CSFl6MTFvRUhYNUNNOW5LU3ZVcnlncVFYTkpEdUZJ?=
 =?utf-8?B?MDRhSlpIai9FU3cyZGxnTytFV3ltZnZnVVNoTmRBZlF2ZHFTMkNKZlluSmRZ?=
 =?utf-8?B?cHBqMk5MREhPd0ZDZGRoRVFVMWVKUmZEUzBHN1dpeW9LNlh3bmNZajBybkVN?=
 =?utf-8?B?RitaMXlzS05uNjcvajhyczIyaGJXaWNUQXNPenpFY2pUMjR6cFRqTEpHVTMz?=
 =?utf-8?B?Q0orRitVcU9lbndGWER6TkxnbTdpM1MzbndSeWVtQWJuSHNEWnJoWExLb0Mv?=
 =?utf-8?B?Z0ZTdkk0SW13NU8xcHJma1JpdjVOcXg0d2NQM0NzNnJTMHljYUNyN2dzenBG?=
 =?utf-8?B?ZzdhT3Rnc1VwMlZ1NXJMUktZcVVYNnBOREZpbXQxUEdCb2xtZkNVOGFiTHlm?=
 =?utf-8?B?Y0J6UWdhbmpjQ2YxSEM1NHhCcDlTakxtZ09kVmZUTm5CVEEzamNCN1Ywc2k3?=
 =?utf-8?B?RXdwQ3hGTEhLalhGVjhWR2N5UjJUVGFBMU5HQ3dlN1VxR3FpTFllY0ZUTFlB?=
 =?utf-8?B?T2RxaVdyVUVrMFMvQ05EODhiMHY0OHhzTzZRRjY0M2FWVitIek9BdG1ib3B5?=
 =?utf-8?B?RFAxNFFCYjdhVHMveDIvQjZ4eGdJY095QVl2ak1hSnI3WE5ELzlZMjhTbmhp?=
 =?utf-8?B?cWIvUldWODI1Z3ZxM2tyZFRCbTZWd2doMEFOUGxUZWc4QVcrNFdIL2dzbXdX?=
 =?utf-8?B?U2dlYkdpMDNHQnc3WVdVSjZhYzVHdWRiemx4RkxEOFVGa3d5aGNuMXc1ZG8y?=
 =?utf-8?B?SncwRnZLN0M0NmI3Q3RmSG10a1dPcnBOY3UwendvU0tPWG5TQ05PZjREc3Qr?=
 =?utf-8?B?WDhIK2tNaWhNeWhCaHgrNUE1am5HRHdJSGEzeHlwZ2lxUTE0S2NZemtUczFD?=
 =?utf-8?B?MldUQlduSS9jV21JR3JIS21sMW1icHhRaTZnbHBpMWhPeTdKZmJldE5GaEVh?=
 =?utf-8?B?QXhKUWh4cUhhY3hlMU85QnJWbFY5NUxtT3BydHd3UkkyTXZXVkR1dkhvQlYr?=
 =?utf-8?B?U2hndTVlOXkrSmJ0ZENXUDFOZ3FnL1BuNEVTNUh5VmxkcUpOUVNielo5eStt?=
 =?utf-8?B?SlVUSFhZanQ1OXNaZW0vWWZ3cGRVYUtVVnZVdHdPU01LaUQwT3VyL2Q0NDBJ?=
 =?utf-8?B?V2g5ZVpCc1d6M1lLWVFPVlY0eGZDR0wwdHZsdDc4dnowY09tSUEvR0xYaXVz?=
 =?utf-8?B?dzdoblhBZFBlUzBYdStXMUlERVY5NWhTdFZpbHFFekU4NS9sK2gyZmJ4L0p1?=
 =?utf-8?B?c1NMVFVBOWIxK29DMnpFVlFyc0E5eDU5bExEZWxHalJSVlFia1ZQTllPMWNY?=
 =?utf-8?B?Mk5DbnQ1aDU5bHltWmRFMjZqZ3NqUm91UlJWZlU2WThna2VFR3VxbUFoa0JE?=
 =?utf-8?B?d2grTG02dmpIblNOajQ1VnNja1lVNGsxd25TcFhRTFNDMDVHa3ZEQlBGalRV?=
 =?utf-8?B?eHY1RzBUWDEyOXRDNUtGbmZucXB6Umoya0lIL2ZpYlpUZ1p6Ui9YU0VuTC9G?=
 =?utf-8?B?d1RHRVhnTEVwZlpvTkFXMVQzTzZReEh5WUxYL2FZSUREdDNhMTA0REtHVmJL?=
 =?utf-8?B?alM1VmtpSUhzRUpTSnNsdHYyeDh5R1VOZTZDeHpOUWQ5Z3o5RVJ2NUVpb20r?=
 =?utf-8?B?d2lDdXRmb2xXQkhxTlQ4TUZ2dDVLb3lNYWpIVkczY0pLSnR6dnRaWVlRVjdN?=
 =?utf-8?B?NUNvRVB6cXBXTmpUYTJ6djF4dUJZZHNkMS8zbTZDaktQT3I5ZmN3QXJGb3Qy?=
 =?utf-8?B?T2JCMUp6a0xPWlJVd2x5M2RmSlVXM3g3R2ZvQ0JVZkVxWjZQYjNyd21kTWNu?=
 =?utf-8?B?MnZxSTNnQWwrR1pIdEhSVFlBWWNxMnE1R1oxOHp5Ykg2M211ekR6ZElDWDk0?=
 =?utf-8?Q?6Cis=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:06:45.3107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41e4310-c836-40af-2701-08de281c830d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4906
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA2MCBTYWx0ZWRfX2uHu7M9lQl5k
 SM0eiwvqHVGazqHQ2vC0ikdJ/AhAInx0BIbLO/sjvC+FenGJWcKkvvfvAOscEVvY8xANaakEyxC
 ndif1tEmYxXI6s3YQab97oBGJwJKlnXw65d+E6QZBD8ZtHla9VdR7zYp/yj/I3jQ9EkWKOb1V+u
 CjfJpuudIzbgMwZ5S+GaHm6pqjKXahr255u/OQCSPw5h4vWoLBarqeIDphGtIEgcL+ja79xe0IY
 /hmT8V61udRuJK231559+GIxOHA4j6yOVqGWSHypYoQK4qcbN8rkRvJZqGTFQ3AQ/d46+UN0Xxi
 kCe4KTM8TlWP1sKy2lFere2DgXM/gt/r0vjTWnePSZCTLScx8/lPJ6cO5oJ7bSlKIPe9wh8D/k5
 fPZC3HExgT1R/YmdiztYtmt+Lq7ETg==
X-Authority-Analysis: v=2.4 cv=XcmEDY55 c=1 sm=1 tr=0 ts=691ee83b cx=c_pps
 a=QpQIPgq430LJFJp+cclIig==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=e0TgBREAnGws873Y1xsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JPWsj5sggIDzTfiBBff1rI4_8XurzflD
X-Proofpoint-ORIG-GUID: JPWsj5sggIDzTfiBBff1rI4_8XurzflD
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 20, 2025 at 10:29:41AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 5:40 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > +               props = devm_kmemdup(priv->dev, cs42l43_cs_props, sizeof(cs42l43_cs_props),
> > +                                    GFP_KERNEL);
> > +               if (!props)
> > +                       return -ENOMEM;
> 
> You don't need to allocate it for more than the duration of this
> function, device_create_managed_software_node() makes a deep copy of
> the properties. They can be on the stack.

Good point, thanks will fixup for v2. Should be able to send that
later today.

> This is looking good, if you post a v2 and it's reviewed, I can resend
> my series with this included and maybe it'll still make v6.19.

Cool yeah I am fine with you pulling this into your series once I
have sent the v2.

Thanks,
Charles


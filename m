Return-Path: <linux-spi+bounces-11307-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F0C6E368
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 9A11D2DAFB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627734A3CB;
	Wed, 19 Nov 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EEZOH0M8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="t3RqbL4E"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05882F0C7D;
	Wed, 19 Nov 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551482; cv=fail; b=TvQXoJFDa3nN9rLodnoXL9rDW++q2ZVxz5bMNRex2LHWL5IGwPvJ0klWK9C1NkK4jROsRzmcBC+FmhG3kAKCQVjccJAdBuQFoBjLpa8QLK0bMfgI2IAYkKfsxUzs/Mre3hIiRdCxg1V6XaaqHWK1nYrkIVDe2mjY0OSS9ILsz14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551482; c=relaxed/simple;
	bh=R41dNQ+N15A0bhucgGKGZrcGGGeXYwjrF50K+ECsiLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfWEzAPIpaTumYAy+haMtcUf6rXKGq1trT4RKNbrzwoYfkecVXbquYnSCO6C9OFIGyM62Xa1/6YQCO/RRkh21HOCKbDb7fjS6ET9+WvrU996he+yBweKBGYPtDYYkJIWm0YIhW92jj/q6kQnQfOCsc8hU9WqVJWT5CkJ3AZbdTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EEZOH0M8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=t3RqbL4E; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ0QBYu1832304;
	Wed, 19 Nov 2025 05:24:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=+MnvlTiQEHM8vgppFu2dcQPHob/x+XrkMcUBTuzU13g=; b=
	EEZOH0M8PwbSgkYV9yw19X529ELNCMLf2GijKCrlfZLSCBWayfC0QAVfMpDzD9Om
	i5UMSk2LZQC2BBF5/Gtayfvn/Iu70SDwtpXywjAJd87O2Lp/xFKPNsal11BZ18rW
	Da9HkmGEqWEoHBLeITmgedo/ygder73NAqWacevRFl7r9RJcQZoReS57k3R9LUrW
	txcxNwqAYff9anVRdP5zCr3/ofjL7XBBn9I6vPBPMp4OMZ9eXExDs7oefsnj/alz
	WQs9esDFBukrH/mE9ngPP+Ht9GAgQycKLrCmEY/iA4DT42y9I5THhA5NgaImtQQ1
	o5JKSxLNj2N8hCVzPodGnw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023077.outbound.protection.outlook.com [40.93.196.77])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aeqt1ctvm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 05:24:19 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3YbPflWynJItykqPkc43y0Y/mCAkzNSfifmefcJS7zQ1mkkYX+NBJFEmE1LsVGOu7YTo8E45gx5IuZ4M7kYHM4vYkxIFjSAZTLiCopymGo420VDRq7PQMtb+hSsy54Iypo4RhTh81BKTr6C9VkURJ1E4spV76NE3fKVmrnNiUXJ2sF0+6vmV01umU3Cm3kn0L93pkHG8SB9IVsdvl6ERABz04KupvRYjGOGHAB4W6dY/mr4sKqbqNzA8P63rG4B2tmtQv0flkSJQ0iZU6rbdn4oL2PjYZhCdMD8bfX1H1vtSxhfLbNqvNL8WicelJz25N/3fLMPcqA3VgE/XinlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MnvlTiQEHM8vgppFu2dcQPHob/x+XrkMcUBTuzU13g=;
 b=Ud9xtCwgHfWiH/RKVjK5uv6tmuAhXonmdHg+mbUChh4qxF2lsqifEEs368aE809YYcdoD8TYO9eYzT5tuoBBMhEOaN1upIit3Zj9mLN6GAkgMPjQ0HN5LT3lX5PmU5z0eRQQkHB8j03blSvpOVcsOB7n/DBI3HK+lGcJH00lbVDNi9nngET+zbcvz3qHo5ZFAevNJZdpdXcTPRqvqjEJycHJ/x5LGrIwE7bkcb5/4DsOcnZOd6BZz0erpC3o8e5JRcCbctxnZHFq7eE3cNCnQWbVrACTUJGwMs233ahZYf0bG1wMFNNPtXUWbCqpKrCiTU8wqEwu/2WJcZ5sS1Ndkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MnvlTiQEHM8vgppFu2dcQPHob/x+XrkMcUBTuzU13g=;
 b=t3RqbL4EySbyLF8g/q0kfLy4Hf+VhxacX+W34CROMBOHs/21fgCCV9CxYHYLGHw2lAnQkixE/eyWUabL4dH0V1s7kjjPs6xRcE7g2EMZ+CDzfgslD0azDcJDy7HXdi4S7yOE/Z6U3S+RuXVVL06qY067Vwo2MCEj2HUo/JhMq88=
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by CO6PR19MB5354.namprd19.prod.outlook.com (2603:10b6:303:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:24:13 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::79) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.9
 via Frontend Transport; Wed, 19 Nov 2025 11:24:12 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 151CE406547;
	Wed, 19 Nov 2025 11:24:11 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E442282025A;
	Wed, 19 Nov 2025 11:24:10 +0000 (UTC)
Date: Wed, 19 Nov 2025 11:24:09 +0000
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
Message-ID: <aR2o2R30TbVOcqZe@opensource.cirrus.com>
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com>
 <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com>
 <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com>
 <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com>
 <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CO6PR19MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: da953ccb-271d-416d-6a91-08de275e2abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXBBcXQxYU16azlKcm1lYVpaeFNrVlFEMmt6ZXdMZG02dGg0Tm42aEpzZVdD?=
 =?utf-8?B?ajJGN0FHTkdTdVJpVG9MZ3JMMXFqS2dyVG1xMEFoUEhONHNDWUU1QS9SRDZk?=
 =?utf-8?B?SmpTd3JkdlA2QzRna2xiOE9FYnovY2lBVlVDdUs4WXptSjdFK09Na2l2cEdh?=
 =?utf-8?B?WjFjNDUwYy9pU1p0Q21ObGY5ZjNLUUZIaXppQXhhZk9aM00vKzkvSW0rT0J1?=
 =?utf-8?B?N05jNU9NZG9FZnk0UnZwTWVQckVnQkx3NVFxYWViS2pPQW9tS2hEc1JEUzkz?=
 =?utf-8?B?RVE3bW5TQTJ5alRMS0hleXBydS81WTh6aWNUS1MxcGtsVVJVSlFBQ21PVmRl?=
 =?utf-8?B?a0lqTG5FZXpBMTJSOGk3a2hQS2JENGsxK0htVlI2RklqWVZZd0UyWk95SXdS?=
 =?utf-8?B?M240cUcwcWZnVzJ0czllbWpKbnhtY2xhdFlOWXFGU1l5SlVCVzZCUzZoS2VM?=
 =?utf-8?B?YTN0UHhGNG1sUkhhcHZITlFSM1FKdmZRaXdPMGdIVEJLdEJVUkRHNDBoOTg0?=
 =?utf-8?B?ZFppeVRxQUcwS004TlRBeFJaN09DZUo5Yk50aCtNV09UbVJNS2FhT1JUMDFQ?=
 =?utf-8?B?NWN2b2hoMFV5ODBOeUxiZjh6ZU14Z1NzUzNDZ2F1UGFheGkzMUVoTE5YN3Fk?=
 =?utf-8?B?cDZhVk9MYlB6RFVUTDl4T2NIQUZvbExRd2ovZU9YcElrc1V3VndtcFNxK1hI?=
 =?utf-8?B?ZWd3R2NEajJHVThJbWd6UTdobjgrRFRqV0Y2VW9meEs1K0ttYlJIK3lsYjY1?=
 =?utf-8?B?dzJYYU10eWFSQ0NzV0gveU9mc1dBbFVVY3RjU3F5blZaN1QxQTNENDFVZHVN?=
 =?utf-8?B?aGJ0TEtrRHlFWGtXZXZUSWRaQ1d5bkdZYVVMWEE2WlVEWWg4U21mRE5RcmhH?=
 =?utf-8?B?YUlkY1Iwdm5rQjg3Z2JrME1FdGE1Ti9QQlltcStOUkdSQkNxK2M5T3hyOTB6?=
 =?utf-8?B?NllROVJxWFZHWFFTL1I0UTdVR0ovekhvYTU3a01UQ0ZIWEdRdW4xdXRkbk5W?=
 =?utf-8?B?Mk9rOVd5TkJQbkZ0SkRsOGh3ZkhKTmRTcy8rK0YvZk1qMEc4MTByZGRQTkVs?=
 =?utf-8?B?R1JXYlF5RmZWd3lRYlpQUkhCVU8rVmNWTWFPQ0NqYkszWHR3OWJHTkJrZU1P?=
 =?utf-8?B?bHF4U3BYRmt5R1pya2lmVWVMaE9BVFFaZ2IyTk5mTG4rYnZxUFJpWjlVNDZr?=
 =?utf-8?B?NGxzMWk0Wm93ZkhBQmJWMVZOVERHa1Q0MDhqeTlIcnN5Wnd4RnQ0czBaODFv?=
 =?utf-8?B?MFR0aGx1cXc3ZFlOL2tQSkhNNTN1UnBJMDJhZEFoVHJ4ejVtSERFTHhsK2to?=
 =?utf-8?B?YzU4T0JXSGVUME5wTHFGTXpMb0Y0cldacDNRVE9HeTVQRVlLQWwvV3Y4ZCts?=
 =?utf-8?B?eU1uWHRkUHhvTjRWUTR2dFpJekJlQmZPZTJBVmVBME04UUlhK3pFczNqQzFP?=
 =?utf-8?B?MkJVdVpkZ1pKTk1oaTQ4SmUrUHFNWWQrSElZZGVHS04vMzUzUTlXWlNuNm44?=
 =?utf-8?B?ZVhoSFcwZzVWWmg3RThBQjJqV3FiSlBVQnErNExTR0dOVXNGdDc1Uk5Ic1lJ?=
 =?utf-8?B?cW1rWVYybGNDWFRwVUhBM1VKS2EvTU9SNDNuOE1SYlJUZUNscElNaGdlRnpM?=
 =?utf-8?B?TzFITmszZDkzUHhQOXVTVEdRZXM1bEhOM1JaMFdIM3NhNDY5V2ZRR3Y2bEVj?=
 =?utf-8?B?bWNIVWFSdjJQbVlUcytkWjhDa290RHBUR1JTa1VweEloNnZML3BpMFZrL2dr?=
 =?utf-8?B?WjhtTU9BT2tnYVI0NjBFMHR2ek40dE4vUWkxcW10VUlneTV1WmxMekoydG9D?=
 =?utf-8?B?S3RhSitXME1qSXNJNlQyc2hWUnpXTG5idTU2eWFSRWQ4TXY5WnNUSUZuVm5h?=
 =?utf-8?B?TWNkTmhVeXZSTmpwdit2aEFkK2dxNjFsdUdKd1RBM05iTXhJM3I1MDV2VFlE?=
 =?utf-8?B?TEFjSVorN2t0MDBXSnBBamZtam00T0ZOaVVWaXR6eGlxL3ViMWlJdGpVdmxO?=
 =?utf-8?B?dDhsWW5YQW0zaGpwRlNCRmR6eml1TzhkRmt5OXFWQ2VRVzRKcHkwVFRMcUkz?=
 =?utf-8?B?bytzRVNBWWMzM1NrdjlXZGxVMEFnTkRTRkFiTmtQOXRUb3I0QUFTUlMwYlhK?=
 =?utf-8?Q?Lx+M=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:24:12.7500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da953ccb-271d-416d-6a91-08de275e2abe
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB5354
X-Authority-Analysis: v=2.4 cv=OOEqHCaB c=1 sm=1 tr=0 ts=691da8e3 cx=c_pps
 a=I1rsLqJrwb5vkj+WUQplAA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8
 a=WXag14hrOiLcnYhab-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cPjcdErZtivEaXsRvuzkmv7JKMrTq9TN
X-Proofpoint-ORIG-GUID: cPjcdErZtivEaXsRvuzkmv7JKMrTq9TN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA5MCBTYWx0ZWRfXyJz/zsxYoLKX
 ITT20O+/xau95+jvxHlCkwJkp01GDQQRviwYV9gd7jF2FL4igEz6G57dVBOCgRFq7ZbQwe5tZTx
 uDpfrziWeaOCPKYkRsq1orOFIUh1zFE5PtddPAf+ZJcLyGCzul2K5qVPvxKE7MXRq0/ntaJN0vO
 JDPGp97W49c/m1aKzQzP4fSUpzkcMQDM5yFi8/H5QX/Vs66VRH2HSRcdX/Jh+fdcCYKrq/D5Dic
 uLSVg/3FgEXSaXzO6etSMfAq4FDJR+8gyGeRuvUlHuPUOV2aZCq1lMxnztdDdnkmKIy1fZ6DTVg
 zfYbeofWwkxr3oLBsn0hYEE9v/UCxmNpNFhZbYom7H1cnmjq0u/uvK3JuMN9BtXr2MQrmaxhQ2a
 whOC4EqbLoKlIj5S7PcUcwvo6aaG3g==
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 19, 2025 at 12:06:57PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 19, 2025 at 11:58 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Nov 19, 2025 at 11:50:09AM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 19, 2025 at 11:47 AM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > > On Wed, Nov 19, 2025 at 11:38:35AM +0100, Bartosz Golaszewski wrote:
> >
> > ...
> >
> > > > Cool, thanks for all your help here. Might take me a couple hours
> > > > but I will get to the bottom of the EBUSY thing, and report back.
> > >
> > > Sure. Could you just post the stack trace down to where the EBUSY is
> > > returned in drivers/base/swnode.c? I'd like to analyze the logic
> > > myself too if that's not too much work for you.
> >
> >
> > FWIW, there is also an interesting debug technique. Put in your driver where
> > you get this error code something like this (after all #include directives):
> >
> > #undef EBUSY
> > #define EBUSY __LINE__
> >
> > And then you get some error code which is line number in some C file. You can
> > narrow down grepping of the EBUSY in the suspected files and get the one.
> >
> >         git grep -n -w EBUSY -- ...files of interest...
> >
> > Hope this saves some minutes for you.
> >
> 
> Charles confirmed he gets it from device_add_software_node(). I want
> to know how we're getting there and how we could end up already having
> a software node.

Ok I think I see what is happening now, the swnode is created on
the first cell (the pinctrl). Then it moves onto the second cell,
but mfd_acpi_add_device() copies the firmware node into both
devices, the device_set_node() call at the bottom. So it inherits
the swnode node through that primary fwnode.

I am guessing this code has perhaps been more heavily tested on
device tree where it is more common to have nodes for each cell,
whereas ACPI is far more likely to have a single firmware node for
the whole device.

Stack dump as requested:

[    8.130022] Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
[    8.130023] Hardware name: AAEON UPX-TGL01/UPX-TGL01, BIOS UXTGBM16 03/31/2022
[    8.130025] Workqueue: events_long cs42l43_boot_work [cs42l43]
[    8.130032] Call Trace:
[    8.130034]  <TASK>
[    8.130037]  dump_stack_lvl+0x5d/0x80
[    8.130048]  device_add_software_node+0x5c/0xb2
[    8.130054]  mfd_add_device+0x248/0x447 [mfd_core]
[    8.130061]  ? _printk+0x6b/0x90
[    8.130069]  devm_mfd_add_devices.cold+0x3b/0x70a [mfd_core]
[    8.130077]  cs42l43_boot_work.cold+0x1d3/0x7f7 [cs42l43]
[    8.130084]  process_one_work+0x237/0x5c0
[    8.130096]  worker_thread+0x1e1/0x3d0
[    8.130103]  ? __pfx_worker_thread+0x10/0x10
[    8.130107]  kthread+0x10d/0x250
[    8.130112]  ? __pfx_kthread+0x10/0x10
[    8.130117]  ret_from_fork+0x182/0x1d0
[    8.130120]  ? __pfx_kthread+0x10/0x10
[    8.130123]  ret_from_fork_asm+0x1a/0x30
[    8.130134]  </TASK>

Thanks,
Charles


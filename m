Return-Path: <linux-spi+bounces-7805-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B1AA54AE
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 21:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56D37B01CE
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC1319A;
	Wed, 30 Apr 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EInOMRP0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aB7mYlde"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD63D76;
	Wed, 30 Apr 2025 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746041452; cv=fail; b=NEpM27/EWo9MCoTpgE/KW8cpsnRdDUvMgJmRHKsVxwyWSAZbphSElHzDdiiGByOJumGj7hb6UweG4AoNQRz3wsuZf703EyCmlHDrep3IGg9nJjRAlq5r2ofPud10nrMz9WuVHptACWrpwLs+lVffKkFeRorOBSJ6Kxk71c8VNHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746041452; c=relaxed/simple;
	bh=/I75pgRSN7VHpP2rX3tLG3n+8XubxCYqxIq39WFxD4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iRb5oOlREotdrluAw7N7M108IXGHfuu8bKjJpvwn3CzQpt0VXhLDCe7yZYooEeNG1XXxFu9KnOe9TF7KKtNFzcvC0g8owY8Hauqyg1b/UuW/tj9T810WT99Br5QljVryhlGooM5Z1oUBwXJF0RHKbwVPF7EWkkxE9AM44fTTu4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EInOMRP0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aB7mYlde; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHttl8008798;
	Wed, 30 Apr 2025 19:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z+iF3vXQxC+Cu41/0TyeX9USft6A//9va7fdZlkepoE=; b=
	EInOMRP0/oha4HCzlqow5h3Y9zRg+X0hap8WcxUb8v9XcNs7SK2vzjokECVzkwAJ
	I+4S8xp3ipJsS1f+Ia9Sux7yraHBXj1TXuSdW3np3MfWsbdQp1uGWiqJTgiu2g3C
	i7ZNpgWKCd8BiifdqAmR1awC4om6gd3Hbw5uGRWsFV5x0MoMAFpy9zqF0B7I9PtE
	Mav3dJPiYH5AnObqRGH5v1WFuM27ETq0B/u2Lyy8mEb7rmxjmtHaJKRX274tZgGW
	XflSoYkVba1+tcBcj3FUwZ9+qEzWJU1GSWDr9ordmb5FWZVMsRAbnUHnQC8tQV9c
	qhsZmHj+Gi/Hmx1SVjsxrQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ut9y2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:30:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UIv1R5013788;
	Wed, 30 Apr 2025 19:30:40 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010000.outbound.protection.outlook.com [40.93.6.0])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbs0kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoHuKD/Huj2GMojO8LveEGhuIsJB3sJZYO4eDUljcxrqJCCzbAlKRzZJomtYVgblVwDJBpcqm14I7sDIZdgf8WZaa9qWg+1ufWFZWlmwkyXShiJRVcond7tuedZsjrPMXuLV1t1ryqKBltSkHfgPLe40kefOK0wlut2GkdkQa1axDyng8S0GDbb/EP3rvVxeUuxk1lYL0dOMwL5vpT42qUNk1HopFVdE98LPNXd733fw/Hf/eyawApI6nZM+nTpGX3AB8A8RC/GVvMBXFNwP8Tgtto/N16QSiuJb5F29BuQ8cTCCinZn+y9FKxS+ndUYTq9/p/E+/c1AVUs6nXBu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+iF3vXQxC+Cu41/0TyeX9USft6A//9va7fdZlkepoE=;
 b=C2mM0Vq6mHYBFz22dlpxjs+yeLFGBgFcy7VQVyTnP7aAZrSBN8S6HeHxQBHJglgxJv7AB/D37MvjcC9TKH4rVho3kVCGzgWi5FqBJp5ADJsh/htb4UjTWtZgHIxlsyaMIKrYVCc/tngWkhZ8JYX0NyoqOqxcGRS8jtlWmtYvSZqV4JCTLztYWv+VIg9zlA1nOrD/pXgi7q87AS/TmQRJ4rsOkSn5ZkfuYW1ydOtdMxmFjlT0MgCXH6F+uGDqocfTfj3LrVYjMSzf89xq5ljbS2lK6zc2Zi83IPeThD1QFvfv8kUD9P4U20czHlyVYssPo5pGvalsmYkjzhpb+djZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+iF3vXQxC+Cu41/0TyeX9USft6A//9va7fdZlkepoE=;
 b=aB7mYldeFACmDs2y38kU2ebTStue5cUnA/E8ZepXdVZ9UwK8k9UG7NrCpX4f4C5MVnY2Hlr5s2ojKoGfi6RD7grPXFDwF3SmzK8VaFA0Lft1Z+HK44mPVBOaZXo/z8eRc1zz/yrANnMJNNsyX3tzC/PypLU5p/CWNzf8+cjgHxs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CY8PR10MB7217.namprd10.prod.outlook.com (2603:10b6:930:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 19:30:37 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:30:37 +0000
Message-ID: <17183bc3-0f15-4789-89b8-b4bfbdac5872@oracle.com>
Date: Thu, 1 May 2025 01:00:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
 <20250428-flexspipatch-v3-2-61d5e8f591bc@nxp.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250428-flexspipatch-v3-2-61d5e8f591bc@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0069.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CY8PR10MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 466d2c3a-fb46-4869-c4a2-08dd881d7bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUN5U2tmU1ZveWFveFNTc0ozOThZaE9WQ2svcHVUQjdOb25Zejd2b2Nsbnhr?=
 =?utf-8?B?NU5walRRYnU3S2xjSzN4R2tGaHVtUGU1RkVNVUExM2U5b0pucFBaOTNwaFZR?=
 =?utf-8?B?cGFueWRSU01JZDJJblRIMDVpRHY2N1hzRklSV0htSFBXV1FMNmhTa2ZoYXhR?=
 =?utf-8?B?T3VkWXpqWkRyN3gzcnBVcUc4MFYxZE0yVXZVN25HVk1xNzBJQ05yalNQRW5F?=
 =?utf-8?B?TVEzdnh1SGNwUVZudDYwb1VVTEErNmh4L2NsUmRCdkFlN3dQM3JLR2NOY1NW?=
 =?utf-8?B?aVUyYTlWVEo4elFKaXB3ckppQ3ZIRlY4QzRxUWtmOVBtb0RZeld0UjBrQmlB?=
 =?utf-8?B?MkZBY2hqU3hTQlh0bXd3cXRQYldOOW94MWpneGg5NHc5R0ZLS3d0QU1kWkxz?=
 =?utf-8?B?TnpEV1ZhSzFiT1pkcU0wd2RuL1lxdWJ3ZGIvSXhaTzc1bmJURFZpY2NjRGYv?=
 =?utf-8?B?YWVVL1pSdDVFZlg3anlFUnoyTllCUGhQd1pIa3BFZEV1N2ZiNGdLRVo4Yi9C?=
 =?utf-8?B?ditpTUpPd0FQeVcwMVNYbC9DM3RCT3V5aTVyZmNtVTZmNEhQQ0RHVXN1L2t0?=
 =?utf-8?B?cGZSTGUyUW9nNm1GYmF6RkRUU0djS3c0UGpzNjRnR3Q2UUl2dWd0SUFmcjlL?=
 =?utf-8?B?cWFzSE8zL3pkVmhzdlFWZ29KUWdoeEtnYms4VEF4dUNzdUNVV0I4VWp1Szhu?=
 =?utf-8?B?RFVFZFFhWGtxdHUzbE44eUFJd2loZ1JWUnpxaGV3SEQvdndKd1FBK0dKRFEw?=
 =?utf-8?B?WUw2K2NMcGcyL2cvYmhJL1ExREcyZE9xTFBqcWJ1Ui9ha0JGUk44U2I2MDNN?=
 =?utf-8?B?RXNHMW5qZ1JjUFFkejl5MEVNa2J3dU14cTVoaWd4d1dZR3k0TDZ5dUIwNU1V?=
 =?utf-8?B?L3d0SUhucVEzOVBIVzZ3NlhrZGdhMVBFZ1RBcWd5OC81TDNzU3RHSG9pQzhB?=
 =?utf-8?B?TlRaYmZqcExDZnNtMkNLOFpkV3lyTGxUNithU09mZmpYd1EyYXFuR3ZzMlQv?=
 =?utf-8?B?SGxJd1gzQ3VBS2s1OWF5Mk5pTm9oRVkveDZVcjlETm9NN0Fxc3Vld21mdThN?=
 =?utf-8?B?Mjl4cVowTUVKc1pnNkhjamN6a2J0a3NoR3ZaQm1GUDkyZTR2dnNOVlpBaVV2?=
 =?utf-8?B?VU1sbnd2bXlKMThaU2h4VEZaY0k0dTB6cSt3Y2FTbU9Ka2lwMTNUdkJQdmZo?=
 =?utf-8?B?cDU0ZWR2MUZ3dnZtK0pTMVNLNUxRU1VtVHJhQk9QWEd6NEE1UkRuWHYra1dq?=
 =?utf-8?B?YmxHZU1Pc0EzcXVNUS9HWlRuWERzUEUxVFYxeGxHU3JPc0ZhdTR4TzIvQmtV?=
 =?utf-8?B?Ry80UC9vRk9ySFp5N01DNzFxeGhhRG0zSXpvUTd1UC9HN3ZlNlowdUNIMnoz?=
 =?utf-8?B?QkV2RHRmV3NwR2p4RVIxUDl0WXVoVzFCeERHSTNUNnN3VXZhMGdybUR2a2xJ?=
 =?utf-8?B?LzcyMW9MdVd0clBKdlpDZytwaUE4MjNMeDB0MG9KakFOTjZDeGIxM2M3bHY4?=
 =?utf-8?B?SEtTdkJONHVLTE9IVzVGb24yaGVLYmFGTVUrbnppMDZKOEl0ZWR6Ukc3V1Ax?=
 =?utf-8?B?OGRPcktIVThucXdjL0R0TkZqNGNiT2NnZVo2ZFRnNWtBRTlFS1kvTHFQUXRX?=
 =?utf-8?B?WUZUL2JIOWI5bWw4NHI5bkdyaURXa0YrbnVCYlNtVXFlVEZMNFduc1VYYjUz?=
 =?utf-8?B?WEViV1Z5L2F5WngveUcxQlBmZCs1TmNKRWNUVGIxenBtakVwMFZLZFBuSTRa?=
 =?utf-8?B?TWEvL3M5dmdKYXhDTnkwS1FtbGF5Z0lRSXluRWY5VDBNMWFiVlAyeVRlV1Mx?=
 =?utf-8?B?bmc5cEt1cTJ6d0RsOUdsTVZXeStaeXpnUGNMY3NMWVJGbDFHTisraHhsTmw3?=
 =?utf-8?B?dmN6QkZyNGNzdVZmWFVTdGh2eTd6TzlUbkdTV29hWlJmanFkRnViVEgvUkJs?=
 =?utf-8?Q?ySxjkCSFHnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1haTmpqSTh2MFRkbU9ERCtFMnFpVkJDd21lNC95RFVIcnhOc1JvSHd6TWEw?=
 =?utf-8?B?NklXTHQ5eW5IMWxycC8xZ2N3TU9KbmdyVndCLytBMjdEQUgreWdkU0tsSisw?=
 =?utf-8?B?dy81d2RQTmZUb1Y1dFdPVFR1dEFNbkpvNU9OSUFGclNHUlU3VS94YjV4RjhJ?=
 =?utf-8?B?a0FHMmZ0RHJhdktBYkhzOHdHWFdUYW0xYy9mS0xseWhyeTY2a292TUpqYmwx?=
 =?utf-8?B?QytwUnI3QUtZMXAyVFF3dE9pdFlrSDVhZXlOdjVjV1RHbGlKVmM0dkI4bVJH?=
 =?utf-8?B?NW00RnFXckNQRm1UY2xJYU9PclRVbzNKV21wdUtEbS9DT3V4OWIvalBJQ1hF?=
 =?utf-8?B?NWJvSnlFVnhjWHJtY04rMUhnaWtvejR3elo3THZHdjFFVks5YjFFNlJnb3BI?=
 =?utf-8?B?Wmp3Ty9HQjRhVDZaSWpUbkxLaCtOWDhHaU1zamU0VFlsSHYwK3hBVktCb2pQ?=
 =?utf-8?B?WUlGTE9QSnp6dGhyUmR3VXQ4VSsyelBwOEgraEJJR0UwOFFSSlVITlNMbXFH?=
 =?utf-8?B?NDBKcjhRZnBwMlROUFZDMG5XYmZTSkw4QUZ5OFVlczJYQzJEdXNvVU1HMUVM?=
 =?utf-8?B?amNLTWpvRXNHaG9jdHdldmZReTEvNmxwYUprcWk1WXJnT2xLbVg2Y2FKNzVC?=
 =?utf-8?B?U3RmbDcwb3dLdXdzTUYraGprNG5XeExqd2poRlB2UG8yU0ZiZGNxckpZbXN0?=
 =?utf-8?B?TVJ6ZWhrUitmWmFDaXVFUzJtM0VZU0d5SFNhN0N6dnRmUkFkeXJldlR5WVpj?=
 =?utf-8?B?ZjJ0NUI2Qm94UDhMdXNsK2NSVHlOZmlHeXpwN0VQeEFuUmhoMEx2dHA1NWpk?=
 =?utf-8?B?ZDNSekNqNWt2RmN4QmgxZnc1ZXR1Z05FWXpCL2x3RVdyTGsvaGJEcTRqTVVJ?=
 =?utf-8?B?WGNMR0YvNElVS2EyZnhISEdGTjFYb1RKZzA0aGRmd1NrMmVEdm80ejczdW9P?=
 =?utf-8?B?TE5hUmZYRzEyenI1UGsyR2xLRFRIaVhpQ2R0VTNWckpzVUszNlFpZVhSMktj?=
 =?utf-8?B?cCt0K2xJMUxBamIxWHFtdGJWL2ZYancxU3NKNkRUekdPaVN0aXo0cStGcU16?=
 =?utf-8?B?ZGxaZFBCQ3c0QWtUVU5qb0JmVk9hYUozcTBWYTFSRCtQbTIzMTZJWUVYbWhN?=
 =?utf-8?B?RWRaV3RSMklqZWI4WVJZbnlXUmJGMnMzZEJBL2MvU3BlUVpjcnl3QlFGL0JC?=
 =?utf-8?B?VlZ0NUdNNTVZMnpVMGErOVlrQkxuQXJDQldveXVUaFYwaXhaejdJQlRCM3Vw?=
 =?utf-8?B?ZWRkVmk1bjlCcnRhMWpLd1hiRGlYRVk1SnA4TDRONFhMelhLNWJJQnR6bkh2?=
 =?utf-8?B?LzFXYTdsWmZaQ0xiM21DUTNyK0dYV3lYaFZJOTBqdEU1SzMvcnhCd1ZQRGIw?=
 =?utf-8?B?Y2RRUk9RK2Y4cDQzVEhIMVNpa294L3dxendjVXdMRjNLanRvaTVVK1kxdktp?=
 =?utf-8?B?U2tBV2w4Rys4QW9OU1h2WDJQejQzaVZxSCtDWEdkUFFCSzhGOTJOYS81eHhW?=
 =?utf-8?B?L1g5VFJDSlR1Wlc0Z0V4SEpZR3ZrMUVPRTlmOFJKd3pFU2VlRHNxSXJvM2Fa?=
 =?utf-8?B?eXJ4MEZoRGs1MXBhVjg0dUFYQmtRWnV5Wm5Db0JxTUVOem4yWE1JcGV0RUpn?=
 =?utf-8?B?M2N5ZVJPcnBuN2VLS1loOGRkS1lyRVNpTlVUZzQvYTlxSVBBSVM3RVFZUENF?=
 =?utf-8?B?Y2V5T3MxdTkyaWhOREpnT0lHOUtSQzB3THVvTnNHZHU5c3NtYzFRb1JFTUdx?=
 =?utf-8?B?d2NtZitoKzBDNXpUZTYwQytNcHA0N3RpeTJwVVhUbWpPd0tBeGpyRWxWT3FD?=
 =?utf-8?B?RkMwMjN3M3hFYTZkMlc1NWhYVWdCSDZXMDlYbTRpSmw1WTBrODNRaVNpSFN6?=
 =?utf-8?B?c0ZEcHV5NUNBcXhDNHgrSHJ1eFNCVmtWajFNeG1wQzNzRWdXc2JJZjFZV3k1?=
 =?utf-8?B?VnNXMzhvK0JIMlNGMGl1c0RqOGx2YnBnczluVWlUd1BqcG9UVjRvbnBGck9H?=
 =?utf-8?B?N292OFhBcUxSYnZUYkdNL0laaDMzRFlzUDI0Y3NYV3gzOTJjZnZqNVZUSXNz?=
 =?utf-8?B?MDRLeG16T0tReEpiNGVJRXB1em1ibitvVUdPcEx0aEJ1bElKZVZFRkQxSkZp?=
 =?utf-8?Q?UuKiAAMScnQXcgTqgh+6IrXuW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iqB3q/ZVHJu2Zpx0c7TjLk1UDtSV2UWrKlR0H9BPChqRfEhWNqqYxKP4DTA9Vv3xy3cy3QxpxfKzM//kZM7Nyw+OQYBH5o3HqcKcbNr2L6kWaqQgm2+SU7E/Nde3RzwPZHAcLPZDEkt1MCJ75MsMIchGiOz0rfD7T84OA/WS1o5+Ezupyht0o3cOzQHOltkk0TrppzzoT/h2xsKB5QAPhaV8QRpbZYAbFAjymv2p1uuD67O4itT5xndpBqMeTiJ8yq3R4KqsQt1E1o0TpHk1TP9SnGtEoUGfCxUBfhv1jZgK+VZp5AzzBeGI52q40ZMMRnRUKM/N/SoZ9msz5x5/qqPmCGVI+a2EBqSEoniSxRnCyObWlm/Tk4MW1uWSKJaJ8qzZkaVRted+vqmovf+DT1lI4dcbS8ogvyWRvCU3b4k+Yokya/FvrqkYCr486MxR+pJJmCcfBqdAo7dIfCXCNqxDCHYf3rAvLYg8g60qxtiQ4dAMV/cXFJ0U/hds+HH1phJvBOLsxjMZdL6csqPtXM6ydFuXJznvxKNWKCxB+m9oGIdi+QZGe6JDWVhGyhCpNphUZO6q2GzR+BaJz4ps1uLIN648vWnud8m6xAMsDWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466d2c3a-fb46-4869-c4a2-08dd881d7bb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:30:37.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chxWrfpqvqx2oeMVl/a0STvKI0XpkMVfWUGARxm5/rFo+uS5SoNKBS5lMNhbNNU+nwlQEENzqPT3fdL0heMxXrEAcvthFAGjdrm7KZOTKz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300143
X-Proofpoint-GUID: -VVjaaq6_jGbbQ8J8CxH_9AW-6H6l7L-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0MyBTYWx0ZWRfX8EZZhTBVdnJ3 BpuJUt43tM3XgAudxiM6IX15l8QuchdZgSfv/sHCKfMpYB6QA7nLzIqdCQZDquIypgJql2vb2dy e1MY4fuaPQ3Q5yfOmyE36hLFaxbuOaiUxwAGuTueUbsEheJ2jBDP5LDXnmLuWT6yHpTVkQpLKu9
 lNGaXgcs6ils+y53hB4Zno2GTE76T3GbmHENlbSLfJ9es0Xxlt1q71UOMQsFSTnNYCci7XXGXZk /zq180DCN1jHPJirHcjSwFDp+SzUeR0GrZbHlwGvDA8Swbc5Q7azcA44/n0GZWd9ghf12p9JIGg ExY5LuC63Z/yVh+sS9JeYK+I5mRv9JNK5sbPjQVvWujTpUqM+H8jSveCIbOyPq1A+dVZk5rc4zX
 TECTjwN3ogGEUE3I8YQ2AX9bAXVQvASszsbp7zCQHBkjk/7pVrqkj0Kojfy1Ftbwt4T7lkzC
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=68127a61 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=wcHvg5fK96uDVXhtC5MA:9 a=QEXdDO2ut3YA:10 a=6PhqOlfQFvMA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: -VVjaaq6_jGbbQ8J8CxH_9AW-6H6l7L-



On 28-04-2025 15:36, Haibo Chen wrote:
> @@ -1249,29 +1272,70 @@ static void nxp_fspi_remove(struct platform_device *pdev)
>   {
>   	struct nxp_fspi *f = platform_get_drvdata(pdev);
>   
> +	/* enable clock first since there is reigster access */

typo reigster -> register

> +	pm_runtime_get_sync(f->dev);
> +
>   	/* disable the hardware */
>   	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);

Thanks,
Alok



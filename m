Return-Path: <linux-spi+bounces-7596-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C83A89718
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5942A160670
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730119C553;
	Tue, 15 Apr 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V1X7Pl44";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HrjJPifU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678371DE4CE;
	Tue, 15 Apr 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707037; cv=fail; b=b9rsQv+jm+sbFHPUQ5YylhhCKtT03TqwsjnH+MBk52F3lTWfJ2pDECACm1T84ivqLNJn1nValUUKVN+K3HeryQV8ssu1z/nYU3NvJ7jsmXVaPk1dPV+hkiJqFvPN84leDjmB862YfqiAfJ7qabcBwhp+Bm9Zil2rFhiOn1VC6CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707037; c=relaxed/simple;
	bh=8iTfNKxcAZxQSe2FMUQxDCyo+m2LC1WFCmNKHUoxEWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfI6vHxoTE8R0cBtFZuh66YYTeHHki5SbgihUF+PdprCBDXJEeonoN/h8QHYrr7mQ6QI03FLODTPCOKl06xcj3AZxRsILBXESMYcWCzkoIIe8+kzoNXqhbfif5enlsL2xjcq6X54f2yNpoxUgUe4rR0RVhpNRkPSStRsTI2pKfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V1X7Pl44; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HrjJPifU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6fotK032430;
	Tue, 15 Apr 2025 08:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HSjePUF+lUvEFtAf2AhfGZib87mKkmS2A4PQh8BqJSI=; b=
	V1X7Pl44SeTNP8bzSKrqjTHtrPOGMjxA0sM/mOEY+TPwI2iYXjsWkTzl8mR4MPxJ
	yy8w1YJXIOB9Ao3XQfuxLI5bs0uaTWvRIVMYX/6EhT6iVPzaUXUiUXp1JQ5aoi/P
	dU60uX8yAzPTztnqZx8xgeAGo9ia5bzBThJ9+1ylzz//L02tIMIp6qe7wXk0rE3/
	p+rguEi1D0IrcQTH0Hm9ohuZ7ctA7MvoH3DdCJwx8NxukbLxkkAKstlVwH7lV28L
	Q2YVKpZoDCsVrzKFrg+Kvf0YM6H80bQ7AY1yM0W4emQAEubr+AeggecKL/6gxeAh
	snPcSZcXb5pcVVcORjTIgQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617ju99d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 08:50:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53F7AT2h008553;
	Tue, 15 Apr 2025 08:50:15 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d2pq1mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 08:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raJKUvIXcBCSanV7SXqVOZFOTFrA89+VuTIwOEE0FTsUasGLbes/kBot5+t8DN9OvoTXMq19p+978n2oCnmt4YbN9ZCmvrbGfNky44LWGfsD22eAsDeyw+JYynB1+Ff6ryXs8P7fOJX3440XbZ42V62w3oCz4UE486wVrVjEqZises7yPUhlLj8I5XAYOKGdyRBSU8WQaGinSrf8OZsz/3rt5LSJASHostXQu5zZrd+E1snUrfg5UAM/0ywEtF4/BLAsNGWH3VVYTqyVf/+rLOJqYqWu6gkzum1WICBGXxPv5sfHXbcc+0UZHbkSzh+yNRYK38t+UpA8yRhXmmsDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSjePUF+lUvEFtAf2AhfGZib87mKkmS2A4PQh8BqJSI=;
 b=jSQ/jNtWFmZRTLVdd8vTYX6pQGBdomXSXuba6bZMSUwR9ClnytOsn1iDshGXu3KBZRCk3HQH0Yq9OexJL9QMetO5s2FSA4D78A6KulgTWtPOHfjxP5buX4yX9R2xyq9kbau2nO43Q8vKFQCeHo18tlR6rVh+CQ9UYBaP8iJP5WpHPzY+k/TagolymglAaDBQc9hWWxWzfn7G2zNizF1FF3jpkrPcmaYZMs7awybWjiR5dbJeS3u7Xe/EOJn6CWq5kSQqsS6jmMTwznqYob5GuC2w7rAKdA6TxFWFBIyAJc92W4HXDWqGUg70PFyv1pHRz+ao34nQ8bheBc5C1WDFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSjePUF+lUvEFtAf2AhfGZib87mKkmS2A4PQh8BqJSI=;
 b=HrjJPifUtc0q96afPTIFwRvYsuwNecjDMP9WCXO2oZ6OS3HUNQ1jPAxLrcbw4l5U7RaZ8eiNSbISl+Z52XfCJ5E1ida7BHs6txHtWMEe1Pth23jLhb726Qsk9mE2Ybp1CU/pIp4a+Xvxutvbvmy7a4kPe3RncOw3DF7yt18Px1o=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Tue, 15 Apr
 2025 08:50:12 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 08:50:12 +0000
Message-ID: <aedc9fed-ba6c-4e22-9641-53ff0df8cb06@oracle.com>
Date: Tue, 15 Apr 2025 14:20:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] ASoC: renesas: add MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
 <87plhe1a3f.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <87plhe1a3f.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 232bc625-525d-466c-f727-08dd7bfa8863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkF1V3M5Ty9DWHRHTEFMZVZVU3hoc1FqK3AvRkc5dHBpVGcxZGQvUkMwanQ1?=
 =?utf-8?B?cFh3K1pkMUxmemZyNUVZazZUTlRyNklkTWVJOVp1cml1UDZ6WjNUVXRhZURK?=
 =?utf-8?B?bHZOd3dyam5OU1pScE5MU3VGSGt6d2wwenFqRWtBZjBQU1dhcTlPUUtaSVlU?=
 =?utf-8?B?ZEhlZ2llbEtrUER4MnRSRzdNbG9oaUMzMHFrdk9qd2l4WEtIOHE0bzR0Y0FR?=
 =?utf-8?B?QUxyZXlnMWZQOHk3V1piS3JUZTBESDIvWTRldEFNWUNmS0l0TmFIZVBVUVZE?=
 =?utf-8?B?dm5kMnNOeGFXUzJEZVM0b2dGMTVzeVhneHhOQWc3S1ZJUVY3ckllaDZCNEp3?=
 =?utf-8?B?amtyUTlrOGNYZWFaVU1ya3JiTzlJcWs0RGxjcEwyblc3TWdxYmJ6UTI4Y0Ji?=
 =?utf-8?B?ZE9kQkF1R25PQjZxTjZmd1pnc0lIMVRua3R2b3ZCSHV0UU11WFJZS3IwT0RN?=
 =?utf-8?B?SjF0dzJFMlpMVWpzSzA0dTV0Rjg1MVJqdy9mWDMzV01lMGVrNnlzdm5hVGxH?=
 =?utf-8?B?bTB5YS9KVXZ3SVFjRmNQaUhRTXZDVUpmQ1IxUG9aVVFCdDQxZEZjZnpiMFpo?=
 =?utf-8?B?QmJhWEVGb0VXc3ZjdjNmMW5NWTBuVDd4ZzhsWWEzOEp1bmU4dmFOMUpHbjhk?=
 =?utf-8?B?VXo5ZURNbURTTGNPb2VLNHJZd0RiZnJaYm5DVXZnYkVqWG1qaWhVdnM3RXVk?=
 =?utf-8?B?VE1aeXVuTSs3RUxieUd4aUlObW5tM3pSWW40eXUyRFBJcVZKbGoyOW1oTnpV?=
 =?utf-8?B?ZTBzU0pvWHpqYkgrS09iZC9YSko3WHUxdmFKVm5SV3E2ZG9oNVlkMzFSNisz?=
 =?utf-8?B?ZE1XM25EVDlaL2dUMmpUcXcwZDVrMldQN2tpbTFmMjVBb1FaaEJDajJaa2Ns?=
 =?utf-8?B?NEs5MGkzR1BhZGVvZExGcmFPZmViL1Rrb2kxbTA5UnYrTTh4a2ZWNFZRcEoy?=
 =?utf-8?B?WHR1MDdHUHkrcWNLUE5vNFVtMlZBZ1RxZEdaTXdKTElDYVJsUXh3c3UvRkYy?=
 =?utf-8?B?cTdtQ3VGQTJ4ZTR6VFZOOVhsaE96eDFhemR4VU91Rnk5WExuQWxSS3dYamJx?=
 =?utf-8?B?cjdsVFd4ZnI5SjFqYk9OZTdSdUZWM3NBcmIvQm9FcDhqMUxLOE5LY0Y3bDR5?=
 =?utf-8?B?TDZLQ2VZbzhET1B4VVU5aWVmeWVvMXIwY2RLdktONS9OMTlkT3hWUjVJTE4z?=
 =?utf-8?B?UThaSUJmZEtLbHN0R1RESE1ldUkxM0NiYS9ubVF3WU9BMkkwNFh3aXBoM3BY?=
 =?utf-8?B?VklvNTJMS2ZPRVd0QlJHZjUvVVNyc2xxbmhiNmxGYmErRk1YQm15eDIyWHBO?=
 =?utf-8?B?TVFGMDdUT2dPdE5US1ZERC95NDBiVWw4bFRJd2dHblFFWGE3NEhaaC9VNlhD?=
 =?utf-8?B?a3NwVVhNOEpFdUI2RkNXMEYrMWM3NS9UM09ZUExKNTdYcGV5RHRtU3I2N2Fk?=
 =?utf-8?B?Q1RXcngzQlBHYmdzVS9PSERRMCtncThhUXp4dlBKeXBydUxOZkdwTk4wUXNL?=
 =?utf-8?B?N1FaQlBrNCtGODV4WlVGSVB1dWRiVWdpVWFOS0lYMWRyeEpueWJkb2hsMm5R?=
 =?utf-8?B?WEtBazNiUGMwSlhDenJDNmtwOUlVODNwUUFyU0VFakhiNlZ4c1JqT1pRd0Jy?=
 =?utf-8?B?cXFxNlMreUJ3OE5zNklzSS9RU0o5eUw0Z3RodFNRUmQ5ZUxGOTFUTXZKYVNl?=
 =?utf-8?B?M01oKzVJY3p3MWRqUmVnWFhZdVVINVpmRFd6NXZkSGJtWWFPZnNMY29GMWhn?=
 =?utf-8?B?aUUxeWRJbGFRVG1yRjczak05ZHRoaHpmU3F4bjQ2U2lZdzRqaTV4a2Z0WGFq?=
 =?utf-8?B?SG9aVG4xa2ZUTjI4YXA5RVBpQTZkZjZ0REtDWkdGWW1jSUo4MERVcldvSElx?=
 =?utf-8?B?TkhRNnVwbmprRHl1dWVDaU5tanZyNkJwZE9KenRvZTZXVjZQR0Y0Rko5WHl5?=
 =?utf-8?B?NWdxTkVOZE5aM3VmdURqMmZ3aVIxaTBocHI2UGJlVmg4Y1YzdnIraE10S3BM?=
 =?utf-8?B?aGVwcWV0NnRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVQvNmRoWUJ4WUE4MUdLek5Zak1WbmtJbm13VXpzTGtnNXQ4bGxqOWQ2Sm9L?=
 =?utf-8?B?RFV0N09IZ1pwRWF5OHI4TFh5dGRhZ0pMcmhsUkRqMkZhOFF1aDdnK0RCNmZD?=
 =?utf-8?B?RnpncGtxWWhaQnNLL3BqSHQxck4wQkMzMHBINDhrZk1lZnQ2Tm9GYkd2cmdH?=
 =?utf-8?B?cEdleTRJdjhjRmtIMDFIY3A1cjhtYSttUnNWR2lOTUVQKzVNUmt1SlNCSXVW?=
 =?utf-8?B?Q2Nvd0hCWm5rc21QSkxVV1dPSjVTejBTRmxtSGhwOW1pVm9veTZ2ejY0SlpG?=
 =?utf-8?B?WWIrUndJSm02aklUT0FxU0drYkV0WjBScVZSUStlQkhyKzBXR3dCUnA1TTJu?=
 =?utf-8?B?U2d6aWhtMG95S0d2ZkcrSVhXTUJZbnBZQlg1RmozK0lHcXpXWHplQS9TZWhY?=
 =?utf-8?B?a21vY2ZtSEFzdVNOMFlUU3hmZXllc2NzcHN0V21nTVFzOFFyY3lHTzNIaFJt?=
 =?utf-8?B?dlJrZUswcU9rWU5hbW1GYUkrWWN3QkJFa2dxbWhOV1Q0cW9hTk1NOStmdXhk?=
 =?utf-8?B?Y0pKbzFHdGd3ckV3TWYwODdIZjNTUUpaRlU5THJSZW9vRGUwSFNOalVESk0r?=
 =?utf-8?B?eEx3ZTJFdk4zMktzamxvclc3OCtJZ2NPNVVIWWFXTG9tUjNXL04vMmtOMG4z?=
 =?utf-8?B?OW16eUhWc0VGWGN5OW1hRXEzT1BkMzFXUGppZEJWZ2lGZmdZanZUWktqRTdV?=
 =?utf-8?B?bVdvTWQxK2VSYUFYdHk2U3VydW90ck5xTDFKcHRaeGc4VlJ0M0dhbXhSY2FG?=
 =?utf-8?B?a3hGSGMxQytCdjhxNENUdDZqT3BZbmV4NFE4ODJxRzBYNlgyb2xub3RNKzdo?=
 =?utf-8?B?a0dzc2xGN0tPbm9YbFp0Z1hRaXdEd3VsWUdTMkpyQTY0ODBUQlZaN3NnbjVC?=
 =?utf-8?B?V2ZySGdKZTBLRG9xRWV5VzI3OUtDMmFxaTNvdW5JRy9Nc0kzQkwxMEtBWnlW?=
 =?utf-8?B?M2sxWjkwMGs4aHVwVFErb3hzWXl6dW8vakxIMk1OTjIwWHNwSjBDWVIvM2Vh?=
 =?utf-8?B?ZUhiUEFkRzRxSkI4ZmxqcUJ6WnE4aGhmRWI0Qlc0dUQ2VkVZVXRPZmJpYTRJ?=
 =?utf-8?B?MXZ1TGZkMFh4OUQ2bk1WdEl6VmNEeFJYcjNGTGhQb3hLcHBMYUtMMnhUNDNP?=
 =?utf-8?B?Z0czK0FzZVhnc1Q1NmlhYVN1Ykw4YnZ1NFhuaTBXSnNXN0RNY1BQZTZPcmFm?=
 =?utf-8?B?YU0xTXF3YUV1b1JMaExlS1RPT2J3Nm5IOFJsRzhaU1ZpbEl6WWR4bEdHRXBU?=
 =?utf-8?B?R29xLy94NU1HUzB1aE51bkdKRkxYb25aQkIxWUhQSjNOVXBuZG5ENHI1R0ow?=
 =?utf-8?B?WElFclpSTGRxWHJGSFFBQWl4WFRpdXM1dUdBUHY4RHFvZm1JRE1nQy96dy84?=
 =?utf-8?B?SnNoMjkwNzZ5R09hYjVKYU1XY29uOHNyTkxzSlZ0alNTd0E1UDlwUnZSbklv?=
 =?utf-8?B?anBTbHVGb0NPN0VhWk9TaGxBNFQzN3ZGa29HUGMwTENxd0FLMEh2UTI5ZlFJ?=
 =?utf-8?B?SGhPT1MvcjFDOC83LzJlQ0JhS2RUc2ZRZlhTaDVJNlgyb1psVk9rcHhzQlRR?=
 =?utf-8?B?R0VsZ3N4T0xEL2tITGRaUGZUcEFQMURjRTJDUmNYdyt5bzBJUkFsVUFKcDRt?=
 =?utf-8?B?S1A3YXZHS0dNQ2ladVhuS3I5Y1Znc21MUjNYM1NXVVovaUZ3NVN3dWlDNUhU?=
 =?utf-8?B?SDF2emZycEZlU1JObFBNbmNjVks3M1F0a3U5WWU4dERDU1RTKzN2aU43ZmEz?=
 =?utf-8?B?OHJPRGpXdHl6akZ2U0VQOW5BMTdsbHRBSWJGakw3Y2lEME8yeWthdmgxaFhx?=
 =?utf-8?B?SURWWFJTdk92THdPS0hyaytyYmY0U2JxaXN3SUdsOE92SG9ia0R0TUJsOWVW?=
 =?utf-8?B?NTg2ZGNSdTB5bGp6dzZ4OHUxTlNpbnRXUUYxZ2hQRytYYmxma0tYR2NlSlMz?=
 =?utf-8?B?RHJCS2pMSXpKdzJ2MWtFekNmYk5yZHFiUi84YnE1YXh3ck5lcWU4MUIzRHRC?=
 =?utf-8?B?VWJueGdRUUxSVjBmczhmb3ZMeXpXaVg1SHNUM0IrVFluTWZFdHN5UEIyelF1?=
 =?utf-8?B?cWExTjhzVUYzMXFFdHE1MHFxNG5oYUM1MjgwOWlHaFhLU05mcFBmU0NPWjNC?=
 =?utf-8?Q?afXsunJqqE21GMqRYXzIIOp3Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9XHtz3b0nuOBgtUjL1L1wW3aTZNR9ySOqGSKfPeTn+jY14bFY5bXY4yvU5Of5pfXzPbKgVC+aS+ZK6SgkZ3zBBj0BFh5ZtSJsAk49Zi2qz4jb/C+fZ7kLbWuN9nexqxfT9Y8tAx1Ck4aQRKsys2z0/AtNWNoxfrnkooaz+qNLDEQ0076nEKEUCTo5T7asjlOSUVO9/Npnn1FlptowhT3zb5l3ZFrF445ymZSHPrAaGfYaJMkv8otqXhyfdPLKbPr7Scml9NS48On5eD6C3CiootkEE+vdMb/9FhuUeHoVfdCpszStYBt+DmB3Nc100KOhRZcGADybkyonzASKyTV8uYniLvui4pummSGNQOjq4DwTRVII/oN92e9f8JFjaKv8qzf9aFynErjWaoRoKG/hg/XfGpypE6QE0NQY2lLQ7pfxFSOimQsRIbkCz4phCIt/rVYLCfhPMS80vkAf+Bkyai/p/XPtYLXB9MGGWMI2z5/hpOOjVYRsdLceSlyDLGvN1SqopvZJtA8zs4SADzKokcRf1keXhm4yw/xxUh2HNER2FRzCnzlpugV6hv/OtOaFN5mDSXLxQHs5sG0fHfokn4+dW/wKEae9xaVZLtAGw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232bc625-525d-466c-f727-08dd7bfa8863
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:50:12.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZO9ooeGSpf9ZzKU2vXMuk5goJWniF8zsOGDXt/Ffsi0SpnAV53113wXCxzpVMptlsSSqwA+++HxXXJEw5TLb1TqdiXTp0UMOXxyems83n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=854
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150060
X-Proofpoint-GUID: WoQU3CO6J0_72FRl7covpokqycTSAx-X
X-Proofpoint-ORIG-GUID: WoQU3CO6J0_72FRl7covpokqycTSAx-X


Hi Morimoto-san,

Thanks for your patch!
Sorry, I did not ask you earlier.


On 15-04-2025 07:04, Kuninori Morimoto wrote:
> +	/* Check MSIOF as Sound mode or SPI mode */
> +	struct device_node *port __free(device_node) = of_graph_get_next_port(dev->of_node, NULL);
> +	if (!port)
> +		return -ENODEV;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return -ENODEV;

nit: -EINVAL will be more relevant here

> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENODEV;

nit: not sure why -ENOMEM not return

> +
> +	priv->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	ret = devm_request_irq(dev, irq, msiof_interrupt, 0, dev_name(dev), priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->dev	= dev;
> +	priv->phy_addr	= res->start;
> +
> +	spin_lock_init(&priv->lock);
> +	platform_set_drvdata(pdev, priv);


Thanks,
Alok


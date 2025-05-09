Return-Path: <linux-spi+bounces-8034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E60AB13AC
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 14:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09B717C7DE
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC83290D8B;
	Fri,  9 May 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZTnx/Mb"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8A290D87;
	Fri,  9 May 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794624; cv=fail; b=O6NxezOxcRteDZBJjrt8R6hAoTf9zNNlBA0N7YvXgn6CLrMGYp8GNuJr/ned6+bXO8YYWS0dxzkJK6BrbnB7Ord+lFOmgBFalBFGE8KCqOLqw3Lh0uzSPncdnVIMb11QzzBTJ9QeABkpFZB/JbNd0CrBZp4cLPJwtTNivfy0cnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794624; c=relaxed/simple;
	bh=4Nz4ugngrZs9UmP33koVkCg1wwpfYPgkb3xUL6jMwNM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hcAgFctYHGdc/kb3bpP00KRLKJztKjE0jBH3gvXe+PTNnq2Q1mNWbNSifClbuDETIuA+G8GvkYXi29DlJpD571jciV09gWf319vOeE/sqCVs+bduI2snCpJ3Y2BrqZ6YzF2QDrE1apz89zNNq766qRCMpNTwXcZBQSUQb6Jm23Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZTnx/Mb; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJIiGaAyo15jzO2+5VEsQGqPplh/XEI7BSmXemzznBJ9Df5ohiSNgTFQod1VPN/JV+mCw2TiA5xZ3KXABaY/Re2tGR6l7KtPOMeXDzjNntlUEwDrX7VOP6rZDBOWCJkcsj6Qv47BcMA6E91DjYyLWoCQj+HoaZmVfnQN8oXGx78K6cSbbbwfW/mz1to5M1foOxp9/lXDi+FDz8KxyRg4cylT2ZK1p6WAuTCRZNXNJznC69bTsAsJNpg6U5azHcyCs08R7p8udxJJ4Wk1kWhOlG1daqUncTxNji/lEge+gdDTxiQAW3v819I2PN+3tiIGHLxclZhxeWuMdSl84cAPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9c4W9fb1qK09KdhjnTettoEiPDtdt65ycp2Mkb8fhg=;
 b=fuLTrtkWcA5N0dND8HW8IRsg/U70dhDLJHB7bs+lPhHx+owzd6gfWoG7Q1s+7EX5QOyEBahGoUmYp96mxOgRRn8qgNQQQnlx8BFXoUSBmL1vjJO/bt5SeH67+CYavFKFOCAiE8sXTffimeXtTo6B4+GdE0Lp77u3If/1XZ/U2C+FWCLTkKMGTjpYwmVNH63NwRVpThEP3RGLFc5XgcXY87MezA4y7lhKQy35fQ2YJnJVAVBeL1xFuMkNIluNzMLx60Qz/nO6S9jE3g3kWu8wuxkN892RfrcxNd9ApucsmixJa2Of8V6ieyP87xSW+aFZu6K/SFyuaC4mIdyVCq3LrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9c4W9fb1qK09KdhjnTettoEiPDtdt65ycp2Mkb8fhg=;
 b=oZTnx/MbH7TSi0+xNV/6oSGPhVc+hyLnRLUJdoNd6fE/f215czro7b1xcxM2FiUePeuGlzFl3mvJIs6qyAM3oAWDwXQuWvOthfm0vI58/mIDBpSPli7yt8QX53b83E2GkD+11FHSTOPRGzaPntvwrII39yClK2kJN4Frk6xD40Xj/mNRGcB3bYm160GRsn3nJ8Er0nneWEeahzzJeK4A2cnU4doKfldn9IYpPBOsMH9cUetmeHZeEjGEBJfwjA7s8UEn5nyPFiioL2jPguqLRkPVJm3TwDlyd180oGOaZuCO1Y/a8vdH5QO58lBlXLIx9MccjMdAV30a9qOFaBqdrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 12:43:39 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 12:43:39 +0000
Message-ID: <91dcedfa-3792-47df-bf00-86c147969100@nvidia.com>
Date: Fri, 9 May 2025 13:43:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: spi: tegra: Document IOMMU property for
 Tegra234 QSPI
To: Vishwaroop A <va@nvidia.com>, krzk@kernel.org, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, skomatineni@nvidia.com, ldewangan@nvidia.com,
 kyarlagadda@nvidia.com, smangipudi@nvidia.com, bgriffis@nvidia.com,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250509123521.3471650-1-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250509123521.3471650-1-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0577.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::21) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 76015e6e-1431-4b7f-3f86-08dd8ef71f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzZLYmFBK2VKK0R5MlhNd3NSOGJmSGpmUmNFNmRtcVBmU3QzOWQrMG1BTGJ3?=
 =?utf-8?B?RnBaREJzdTQreHQ3WXpLLytHWTVsa1RmUVRJdTVVTWYwVDJkdE5JZDlhaXNt?=
 =?utf-8?B?Z21RUkJ3dmw3a3ErZTFSV3B1MDZJMGlEYThMR3pGSGhFUkFzYTRlcHVRL2VZ?=
 =?utf-8?B?QlV2TTQrbldLa251R1ZQWkFBbThubUg2MlE3RmdWV1ljclBYeVBSODB5SnlI?=
 =?utf-8?B?N0FoV2t5U0h6QlBiU0JCMkpXaWxLdTk0VGxFZzI1R3Y3YXVjMlVTa1lyT0Rh?=
 =?utf-8?B?UlBpTXVVU05Tb1dvc0FlTDU3NktqOTFtdTZZWWdpWUcyQlNmWndMMXhxdUR4?=
 =?utf-8?B?V1lxSGVqMjkzSlRuVVlmTjF3WFVpS3hYb05rZlhlQXJkaDlKeTJmbHIxZ0FC?=
 =?utf-8?B?RVVWTkg1UFdReUZCQitRRjRKd3JSYjFlaXZpZndkL1NhS3BFUDhlVGFaKzVM?=
 =?utf-8?B?L1JsdmpZS3Bwa1NPWlZvWktmNWFYN21VSFRONlZoYnFPVkIwU2pPUDNmMEFJ?=
 =?utf-8?B?ZjNlVUxoUmhtNG0rc1pQTG9YWElZZ2o1L1JKM0xQR2Z5VS9rSWkvTWZ6VXlO?=
 =?utf-8?B?d0lQRWZLdTJ5dStFbU1TenBtUW52VzZNd0VJTzg0OXlNM0czbDRObkxJbXdP?=
 =?utf-8?B?UVdUdllPVGlDRklFSXNhWVByaGZyM3dJWmpOREVZeUpEL0hBaHRJNGYrVGJL?=
 =?utf-8?B?eDdjYVNFeDVTYXlEdXhsYWRBMkFodjlWd2ZlaTk5SDJRcHFqczRZZktBbFJz?=
 =?utf-8?B?cVNFU29uQms1OWRYOGVJeHhXYWZyYUp1WnhVMXVxcDBhNEJDa2J3cVgzd25x?=
 =?utf-8?B?U25qRE5seG1YTUtONDZCZTRMNFY1THVqOEV1ZkFWaUJYcG9yZ25MMFp1MVZO?=
 =?utf-8?B?cnpQbkErTVRyc1F2bHZBdFVIcEZ6L2FiNjFZc092dzBCZ29HYTNvdk4yUFRV?=
 =?utf-8?B?QU1Bck5zcWlvcHJvRjA4WGk3YjJQTVg4Um5XRnBiUHVmc2JqZ1BFMVhvMmpx?=
 =?utf-8?B?azlZWGNoVnBQT2drcEQwVWVpNUNzMjNxcHdWak9DQWk3ZlAxdlIzaDd5UCsx?=
 =?utf-8?B?SVBUdWk2bFhXaklLVE9ydG5sK29wR0k3VUxZdnlRcnFLYzY4UHpKaEducDg0?=
 =?utf-8?B?d0F5Z282VnoyamVvZnhadUZpU05RWFRYWlo5MlFuU3ZxN0Vyejhsc01saDYx?=
 =?utf-8?B?ekpkdEUxSHVZMjhYMURwOUt5cjB2NTN3L05CbEUrM0FXU2xkcXA4UWJKY2tE?=
 =?utf-8?B?RWdsVHpEWjM5ZGh4cWc5V2pIbEoyWmpOSFNmZjdaTG1oM1RlTjZsMXN5eG1N?=
 =?utf-8?B?M2dXaHQzOUxpVGk1OTQ0K1RpQlpFL2N0aVJHWmMwRlUwMUNKR095WHR4TGdm?=
 =?utf-8?B?QkwxVzlUb0x2dWVkOVdlK2djT3o1QmZUamNmK3BYTGtvZFhPK1BHOVpJOWN1?=
 =?utf-8?B?QlhyRWdLaWg5WG5GL1U5MWtjZEJHMmI2Y0sxQWVGNTNMSktPUDJ3U1cxS2lS?=
 =?utf-8?B?eUxuRUcvdmlOUE9aYlgvWnJRTURaSS8vQ0kyazdTOVA1WG5RWFdSa0xJZ3or?=
 =?utf-8?B?UHNXaXFBYnJUNVQ5R2N6RGloVnlvUXdNdGp2Q0VadElNdlZiTXBMYml5U01r?=
 =?utf-8?B?cHN2WW1PbjRFS3FmTXBRcGpXSS9TU1pYYUtOeDlrZEdIUkgxeHQ0UUdzbDZh?=
 =?utf-8?B?QmVPaTB6VDhEQ0E1MENQeTdLaHBRUHQyNk0wWnVDU0w2TTNNOXR2Y0JBUHVP?=
 =?utf-8?B?d0xpMVdTTlM4Mitid0cxZ3JTeDZYSlp0SzNMVVl3RVpEbVNqZXg0NDNrd1Za?=
 =?utf-8?B?NlRJdDlkQU0zcFprV3pOS3ZYWHRScTdjczE1S3FyU1VtZ1hDQTlPaUo0VlVP?=
 =?utf-8?B?elloUFdoU1pwWkViVktZL2wxck8xQmIwbW9oazhTRlcwbnRySXBSODM0SXo3?=
 =?utf-8?B?d0ZEV2ljUU5KamdpSHRNd2E1M3BPQzc5TUNINkNlMS9adGdheXZ2blVrZGxw?=
 =?utf-8?B?WTRhdWRTRFNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjNpaUwwbjlqVkZvN0NFR2RXVGlqZlBtWXUwS3dYU1REUDYxd1hjU3JUeXVL?=
 =?utf-8?B?Nkd0d05DM2FIYVVsSnZMODZGTi9EMEt1dStUeHhjYzM2eDIwWFphYURSZnF1?=
 =?utf-8?B?OXBtNzNTTnRpdmRxNUltMVpKRjBsTUtVNDJPNGNZZmFOaHlDT05FcktYTzRT?=
 =?utf-8?B?OGR3NkxTNU9VZFhQSUs3VWZTcHc2TFZlS3R0WXNva1grM09FM2JET0tQSXA5?=
 =?utf-8?B?Q0pIUEhpamJzZis4aVltd3BTSnhPczZXWHlKcnFjZlRWVlRTSUxpcHRLUkFO?=
 =?utf-8?B?bzBJY01WQXBUMS94eWVVOUpmZXRzRHFtMFdQcG1wZzkyRWpkL2dlY2tieXBv?=
 =?utf-8?B?dEF0SFBHRXROWlJlaFVLMThGdUNuejNOaGkxQncyYjNFelRQZ21PY1NVRFJu?=
 =?utf-8?B?VEVQd3haUUxXNldJNzlSRGo3anoyd3NRSUIxNFFOYTNraWZCTWFaNkVCRnhq?=
 =?utf-8?B?UEZxdERLK3lKNXVrM0Z5WG9TV1kva0hQVzRmVTZmSVR3eXk5UVhMYTUzZUxm?=
 =?utf-8?B?clV0N3U4UTRJWlJjU0ZrWS9LQzhJdlVIb0tva29aaE5ETlI3clRmdThYaHZJ?=
 =?utf-8?B?T01GMzN0VU55OEhYcU1ERTNUbkY5MkZwQUs2QmhLOFJoTDRSRlZLRHAzUzdY?=
 =?utf-8?B?Yzk5dFYzeFhOOTd5Z3JpMkhDWmNobnhZQ2Z3WCtFbWc4b2hMRElUd1lQaGx3?=
 =?utf-8?B?M3ZMM1dXYjB6cVBHcENYNzMycFU5eTZ4U3JxQlh2V2RmOEFuc2RNMGdrNTRa?=
 =?utf-8?B?TUVvU1NZZDduMldzU2N1SEVGcEFhZ2w0YVY4YmtIOUFwYmxLdTk1VDFnOXN0?=
 =?utf-8?B?WG1tOXhZaHZLdFYwazVra2VUVUppUFRCYXNHL1NGL2QyQTRhRUpzdjFjc0Vp?=
 =?utf-8?B?RnhlZWYrZDRvNXJmaWdtZ3k1VGRaT1BhZ1F6U2FPSlVvWHhjcVVwL0laVzhO?=
 =?utf-8?B?YTREZHJZVnRRNlp3d05adVhnMnU2RGlBRHhXOFhKTm5NQWxHWmE5eElZUmdF?=
 =?utf-8?B?bHpsRzZwVk1vZUFjczFhSks2S3NDUjVvbU9tbGxWUnAvTGxvNjltUDFJNkZT?=
 =?utf-8?B?L0M4cVNjYTc2TjROSFlYNVM2QnFnVWpFSFJ2eUd3VmphL2w0UmdpYjI1cnNh?=
 =?utf-8?B?aDg2ZDhHT3hzYnFySGJtZ3V0bEI0M2E4L3VPd0RUaGhUdER2U2RFVEhjTld6?=
 =?utf-8?B?TUd2ZFZ6WW01RGpxbHo0ZGJEODlPOGNSQ0l3RU1aWWpWUmgyalh2aHVRQ0hn?=
 =?utf-8?B?cXBuL0lQNzQvNG5aLzhmVVBFNy9qY2Q5RzBYaUlPK1ZyWTI0a3h6ck4rdGVN?=
 =?utf-8?B?QW5hTVVsTXh0ZWlPbmRub1BycCtjdFU2Y1FscGRwU0Fhc1ZZRDhZTzV1VHZS?=
 =?utf-8?B?c3IrendzTXZVWHhKUlNkU1RZSHMvcHBJWkZjNTJ6SVptTTdvOUNDZXl6NWtH?=
 =?utf-8?B?Ykt0anZEZW81cDVJUTd0YWV0b0lMZmNHQ1FUWENIUjVHTXcxVGZSckhwVGs3?=
 =?utf-8?B?N2dBdmp1dkFZb3pNTGtQWGRNRm92Q2lzUWJiMUtrdmlxUHBKcWlDL2R4ajdU?=
 =?utf-8?B?TVprUERZMjNFc0lyR253alVBc2ttZDdVbk0razZZaHYxUVg4T0kycmViM2Y4?=
 =?utf-8?B?U3RBeWVVWnhXcWNRWXJSNWE3dHlFUWJSWUsxOUZpbjZMN2NjY1RKdFhDTzlR?=
 =?utf-8?B?OWZsd1M2QkpoRktEQlVoMHVwWjdaT3NRVVZKZjFuNFN2NjhPS1pJZ0xYSEVr?=
 =?utf-8?B?Y1drS0FkdytUek9zTytkWCtTdXBKSEFkZWo4Q0dNRndsN2MrbjdqWXAyelVF?=
 =?utf-8?B?OEx1MzNYbExiMWdlTnVuTEQ1R0hKd29oSTNtTGpqR2p3ZTZFK2o1cDhtVVFt?=
 =?utf-8?B?RGlwcmFvT0hqcTdVMDgySmhDSzRuRjFYbnE2V2pPVW14Q0lGdGZEdWZsY015?=
 =?utf-8?B?WUF0RmY0c1hBYXFsajlramdQdU1RYjZaem02ZEJSWkFiWDYwNWdJQ0pvLzdu?=
 =?utf-8?B?eHhsR1hkWDBWaXgvR3Q1VkpKUndRQTExbXo2Y0MrdjBuU2FDMmtBanZYZTN3?=
 =?utf-8?B?Tzg3RmRIMDg2dkwzNDhERUFJSjl4RTlqOXBqaUdIWHNxOTlzTnA1QjJyTEti?=
 =?utf-8?B?dm14U3RVYlcwS2JicUNRR2FmcisvaWM0T0YydHFjeFVySW1ST0E0TWpYYUp1?=
 =?utf-8?Q?sABvZ8twW5f+GtG/G2IF85z46ksMjZ18FG5DnNRKkrPF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76015e6e-1431-4b7f-3f86-08dd8ef71f37
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:43:39.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ecRfhy9K0wuynrjB+dN0nslQRhskefg8MLvwMMqMa+tHrQ5Z8kuexQYJ2KtL5Ia71r7YPoMc7GZU80H3jtHZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

Hi all,

On 09/05/2025 13:35, Vishwaroop A wrote:
> Add the 'iommus' property to the Tegra QSPI device tree binding.
> The property is needed for Tegra234 when using the internal DMA
> controller, and is not supported on other Tegra chips, as DMA is
> handled by an external controller.
> 
> Signed-off-by: Vishwaroop A<va@nvidia.com>
> ---
>   .../bindings/spi/nvidia,tegra210-quad.yaml    | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)


Please ignore this revision. This is not versioned correctly, it is 
missing info on what changed since the last version. We will correct this.

Jon

-- 
nvpublic



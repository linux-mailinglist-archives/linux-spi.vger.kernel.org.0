Return-Path: <linux-spi+bounces-5849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62F9DAC5C
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 18:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF11BB21092
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930FA201015;
	Wed, 27 Nov 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cEDpA99o"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4B225D6;
	Wed, 27 Nov 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728253; cv=fail; b=Mh6zJQWAv9/PSmSQk2UciofUoLBEI8HGXpPoq2/LyUSm9lnS0JCkXSrAFwVtMWw3q9davGxxBEsTnECc/jAETj1zYCjNedVhMs+rS1qbt/99TndvdOp2xsDywGkS/TOaEV1C4OjkPpzd583g9uT11TTFSzE5RiPZlYmsDoF4+S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728253; c=relaxed/simple;
	bh=CSLW75mMCpmbKmLlP81Pe337cIKkwGP4RhZuvGxPtK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+ELbqRMqsLov5mUhFAZhzFRkdLNMSRedmag4uxBqJDqE2a7QPoi5FdlUT8VX/t44mR4dgLkaGgBeKilUeBLelPX9spOiF8OfHHy3fVWamje9hFOSbEvwFFWwhCay8Mfqt/Rtz2G0NFPBDhNu0V7hf6xbKL9irN/TN7vnD8PAgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cEDpA99o; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paQijsReYx/aRSw3Phbr7KnsMsMc0n7lAYlrquBLRWOqNtgucX6EmvdgjkecKOauwVO2WIJ6RgAGINSFkVZmRTVlAYNwOOYIR0EIT/pJxkZwoUW+U2mYduM4S3/O7Cgl1CGwYE74SqEPhpsNC7vTvSyRKcwmLi8MafNrlH6PgOobiYHCJWTpaETc7jCyVhV4IVzZQItsZ3uAV71PrNMvnM8p+MZAcYS7iGn0mIfMJbA8vPBBUrSWILfMpcP4GQC8lKa3ZpKkdgyJsx6dTA88Dbhu24AH4Qw3Dhv+OLDmflvB6s4l2fJQaWKe1QFNE1yCXDVzFa1r/ev+w4rF0S6M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX30cPofzekRuWph66Ng8o5RtKOQZ1wchJsFV04Wktg=;
 b=ZjRn0F3wIdc0XvmbYJtuN7GXuS1MhP7055YpKQwMTpNLh4ZVm38hh7LmPXbraqjMbCeP8l58NWYrUZJVC4BGHEZ5aoP8KeTgVFX6vgQkxl18UcgNLddso85jv+pg8Q7qAmdM6xvr/fAfNWK/+b3TsLHhWrLAhi1B+Unz5zqGxNkugMfXRnpi9j4OvtDgFKr/C2krWtsd8S3D26CEsKObmS70zqUGi34gWZPaOucbW/hzaBiovUzMN6QRVcl7LMvvsu2Ai0t5P9sRsObWJZjBLFTNPntV+X9pXMV4whBFwUb1Z9n446xhLsASyzFVGXX3JQD0sEhGqx+a4o4knTqONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX30cPofzekRuWph66Ng8o5RtKOQZ1wchJsFV04Wktg=;
 b=cEDpA99o6KFSPl0inZerz8SkNpBxn3DnTg9t5iXm1ouPeNj8Dcjv3bcbdCJo7qUGWfa7xuHZzf3bW83f58FYRG1G/FCvWthFdLEMqGBUJnZ2e2YIOzJUS9dsu6MUH31+tRtZMpp1H9gXGTfVWGDcbOTkNWC1kQ4wG9Tul6DRAZ0Y+/AUp2KkV/VdLfIP+FXRK1SiJWfT4cJvcdAHYsvFgsVUdeidt9Ty/fH6dOT+o4YkgT/LscY8fIEGjysjx9tfcEiQf62rgKLT5ZOmeLck8vEJvgF2AoBJrY5nNlYnyX93KOTChcwrrNcGPRGYCdsBRU1bmvmaGC+hxAfw5mSaRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 17:24:08 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 17:24:08 +0000
Message-ID: <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
Date: Wed, 27 Nov 2024 17:24:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
To: Mark Brown <broonie@kernel.org>
Cc: Vishwaroop A <va@nvidia.com>, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::18) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a9751a-5a3a-478c-7f41-08dd0f084d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkRoWmtqbDA2d1dPQlAvS1VTaGZCZnhwNnpVZ2xYVlVRZ0NYL1FaTVUvbE5U?=
 =?utf-8?B?YlJUejBvWERVR0VsUTRmVWpGd3lMd1c4REJpZWlTVDFab29LQmxRM2h4eEFt?=
 =?utf-8?B?WVg4cmtvMUViak4yZzVvSjVsTC9MK1V3enZDZ21yV0JPdm9oTElkeEpteEEr?=
 =?utf-8?B?SS9kd0xNUnJyeWFETU9OR1lLbEVyeU5JcVFhY0JIcDY2MUVIS0dnckVCRUJE?=
 =?utf-8?B?ZXJyOHQ4dEhLMXE3Q3ZISkJwSzFLQXJBc0hYc0VlUXNRNlhXZ0IvdGl4WHBX?=
 =?utf-8?B?aHIvYlZnVFhrRW9TMThZUmpiNTFsU2xVOU9RdHo2OU1HZmlWR21MUmZ0TVl4?=
 =?utf-8?B?UE5xOFJXdGVWWEYwb2JVS2dybndHZHJkeTJ6bWw0cHN4QXJBeDBCdFJKSWpV?=
 =?utf-8?B?OEdSOUJRZjRqZnAwOXZmb21ZOC8wbE41SFlxRmtTVXRaSU9oN2RQdVZMb2ln?=
 =?utf-8?B?NjNZM29iTlAzdnVzbzNzYnpiWWRtaEY0cVk2VE1CT0JnS2ZBRlpMOU54Y1Nx?=
 =?utf-8?B?SU82eW4ya1RSSlpoemM4cHJLZVBsUGJ2NmE0aGg5QlNTWTBjN2JjcTRrSXJX?=
 =?utf-8?B?Z050Z0RQY0xMakhXNGFLSkQ1dlpDRmgyZW9uejF4cThBZGFBSGZHNUFzY2NO?=
 =?utf-8?B?ZXhFN3FUTDJYNmdSaW9GWmNhSzRhWEVtZ3JHUDZMci9Qc3VDekhzMHczQU5v?=
 =?utf-8?B?RmdHRHBpdjhNQzVTSGtuUHdoOVB2UmZITWZGY090dnRGZE9XWHpJVjhvWjFF?=
 =?utf-8?B?ZHU4Z0I4am5TRVZNNHZNY3YxSjVubGE4bFlCR1JlOTlMTG5BMWJKeFRENTI4?=
 =?utf-8?B?U2ZpWjE4OG5CNnJreTdQbE1uUVJkUkltc2QwNVVBZVBESWVnS0xsWmVDL2p2?=
 =?utf-8?B?aUlyRENWaUdOK0tJWXB0UW84Mm56dWVyU3BHbGY1ankzQ0RmOXM0T1FvRjN0?=
 =?utf-8?B?YUJ5cHhsY2xVdHR1WlUwL29sTlduNkxzVG0wcHU5V0tUZENMcWJjNXVKdlRK?=
 =?utf-8?B?RGd4bmtPQjUwblVaUmZmT1VWcVFQUDNSOHlHbGhjOVdlZUFYSHFQZ1p3c1VJ?=
 =?utf-8?B?QW5BUDJEVW5iOVRsd0EyY3NiSEhNbHVLMVhnT0JFMDFlWDZvUWdOUXBuT0RD?=
 =?utf-8?B?c05vOHU3Vk5PNEJrM211UXYwc0VpVnZoU0U5MG43RksxL1doWFpiNGRIRFFI?=
 =?utf-8?B?by9RcjhacDRKYUlYVko1bVB1RGJNUmFjRlFzZFNNZ0RyZGJRQkVsenNXbHVZ?=
 =?utf-8?B?RThPTGIrZSsrV3VVbkpNdS9kZ3VhajlBR3JnMzZHWTJ0VzExaWhLc0x5U20v?=
 =?utf-8?B?OEdGRUJTbkpaYlg4K0d6ait4NHgzdGVEMDBMME05d1NjcDM2aWRBYWtrakNj?=
 =?utf-8?B?VDFEOFRkK1lYRm12NGo1QlZVeVRKV1Q2SFdjOGFIOHFlVmhhZVVGUnJrNUNr?=
 =?utf-8?B?ZFZlSlowNHBVWlRyanV2MHB4L0laU2VLRlU2T0tQWUNhNXFFMnprMW90L1VN?=
 =?utf-8?B?UVQ2dndjdFVRVkp4ZkM5UWxjcjR0UFJoa1plb2NyZ01KY1NCaGRoVWJkbSth?=
 =?utf-8?B?MWtodlRIYVZJQzBRRklvZGdQVk1BcFlpd2hDRG1FMW16R0J6d1hSVytTbnBx?=
 =?utf-8?B?elg5WE5hMHRwKzJKQnBvblJ2aUpQQ0t6UHY1NEJSVWlXVDVUS3F4NHRpZEU1?=
 =?utf-8?B?Y1dsQno3QUJyUmtiVk1SbXV6NWNDby9WUnZpYkdpdWpqLzNzdmdGSTdGZnV1?=
 =?utf-8?B?QUlxMTQyb0xNZzRyeGdaYmVRbEkvNEFjUURNdkRDZ2NraFVERGhXelB1MVYr?=
 =?utf-8?B?OXpjR3ZRR1hhdFJoMXB2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anhVaklaY2tmellKWlNaNlExU2RGL0ZuTi9qVFJQdndtS3VGOEN2UzhoRUhY?=
 =?utf-8?B?Ymdmb1lKcjlyTlZsUlpBekhDMExBRHR3d3hhLzFUd21Jd3hiMnkzMUVYK2g1?=
 =?utf-8?B?V3dqYjhTSDVKZ2Erd2dURVh4ZmRXRFc5VjZ3ZVVwL3Rsb2pRcG13a24zL2F3?=
 =?utf-8?B?QStES2NWMVhzNVFaWmlialNaS1JLbTBFMUJKbEx5ckhrUWRNalZUOWZEOHV3?=
 =?utf-8?B?SzlYZGZzdm93eXhwblQrUG5vK1p5WmpnaEdXVzc3MFNuVXFyZWM0UXVSK2Vs?=
 =?utf-8?B?dW8vZ0NEZ21wZ3YvczZNMGVJYTZjK253Yko2RUxpY2Rub2pWM0E1VGZvbzQ2?=
 =?utf-8?B?cFlSWkxNenQ3NElMcnFCUytjWGlFQ0s5cVFhakhLT1hGMVhvejJIbEpGTG1V?=
 =?utf-8?B?dW1DTklMYTR2ZXlBN2wrL0lWWnM4RFM2b3BTZUpSNXc3WFl3V1dEbURXV2hH?=
 =?utf-8?B?NUsrWS9EZEFuK2tqUWQwVDl2S3dvQm9neksxU0M1R0RIOEc1MTRTdE9oRjFp?=
 =?utf-8?B?eHJZRldyOUNTb0luNkR4SWE5TG1VcU5hbjNYU1pSL2JsNzUwUnlOc1RwOWgy?=
 =?utf-8?B?MkZjZkR6SDh0SGVIcWl0clM1ejN0UEp6SnFLenowQWxoOTNqWEhqOUR2TkNv?=
 =?utf-8?B?MFBhMnVPNVNQQUZXUytzMEdONHF2cnFKcGVJRk5BMkc5ck8xUEZkL2JtZHMy?=
 =?utf-8?B?bTZxcjlabXFWalZ4QkVEOCtRM1ptY2tzemY0YzBaWFE2WW4wSkJkYkxiTW5F?=
 =?utf-8?B?N29uZGVyVlc4UGRFOG9rTUpPc0NhTWI0Y1NaWnJ5aTU5Wk1iNGpGa2NyYmNj?=
 =?utf-8?B?K0lJb0w4SlM2RGREVnVqYWVUMDhKVnlremhoU0k2bXRTZUI3Y2dsZ04ybERt?=
 =?utf-8?B?dEsvM3JPU3dWV3M3WDIwT3RvTEFoNWhZVTkwTTdIend4SHhnaDJnbERVeEZF?=
 =?utf-8?B?K29FVjBCd3Q1S2l5cUlIQW1zczdydm5Md1l4cHlFdlFXTUIyWEUwanB6V2g4?=
 =?utf-8?B?QzhsWEVmQTVhRGczWVJobkJhSUU0ditwQzVtSVI5cEthY3JtMkhqZVowWnAy?=
 =?utf-8?B?NFliNDZOdERsNlFUbWU5Ty9uL2xMcUhFTFN5dXNvZFZpZXc2dUoxY0EyZG93?=
 =?utf-8?B?cllwaE9CY2xrVGpnb3F1dGl0UUVmSFdreHV4eXdoYTh1WWRGVWluNW1Ed3FB?=
 =?utf-8?B?RGh4RlYvNkE3bFJ6QjR5cGhvNnpmUWlBNDQvejVjOWVPdUVKSTlaTU5SZEpG?=
 =?utf-8?B?SkNZOXFmaStYTFZHR2lnVXowVlpING9mdVhIb2hWTUo0ZUxYZHBYNjlWd2lO?=
 =?utf-8?B?d002MWd4eXBhY1JUNXdIMXZ1cXJHMnZsNEhGU2pNcE9LeXNlejNlaDJQQlZI?=
 =?utf-8?B?a1ZHL3JxcXE2NTJPMHI4QUkyZjNia0VMTkozUng4eTNXQnVuWTdUR2ZVQSto?=
 =?utf-8?B?VVJkeTZabUh2ZWc2MGdKZG1UN1N1NC9FdzFLVThWZ2dNV01NQjBGcnl6ME9u?=
 =?utf-8?B?K0RrckcxaEZpRjdGV0dQaW12QlRTZE5IcC8raHU0ZnV1Y0trdGR5UFJGMHRn?=
 =?utf-8?B?M0hrYlg1Q1RYTTZReVQwamI1bitNU2NaajJBQTRJUFVzb0FqUzJteVdqSzVm?=
 =?utf-8?B?RGhJbFlEYVJrVnB1Q1VFYXBLZitrYnRpVzdKbmdxL25mK0xHN0xaREljQ2RJ?=
 =?utf-8?B?Qjczb0oxNHRGc09KQlQwNENmVEZNM1VuSXYySHFyRktZTVpremJPemxWVjFW?=
 =?utf-8?B?S1JTS3A5Ky9YSENuQWJxRXpjRXViVnZxK0oxbGRyY1lDeFVHQzRHcmd6YmJM?=
 =?utf-8?B?ekp1Vzd1SGdvVWhXengwS1lSSGRCd1JmbENFa3k0TXpoOHd2a29FaFZGK0Jn?=
 =?utf-8?B?VGlnMDlLWlhJQSs3dUMvT3l1Uk9RQ0RHb3Vidzg2bDg0bHFrMWozR3p3VVdn?=
 =?utf-8?B?MTRDZDRpNWE3UWVFY1dFK011QkJRckZLZjBiSS9tRk80bHBqN0tZcE1YUlg3?=
 =?utf-8?B?TW9PdWVKejQwZnBLMFVHRmc5S0szVktFTkpyMmxYYlN4WGliRkZRaUFjVUti?=
 =?utf-8?B?K2p3N0tIMHVGVDRLeW8yUHllU1dXQ1JHYUc1OSt4NTVOQzgxMDJ5eWxIejZR?=
 =?utf-8?Q?O6ciZh/9tRlRH4Oq9+oyMq2gE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a9751a-5a3a-478c-7f41-08dd0f084d0f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 17:24:08.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiQ0dyRsvt7cM95lfQH0h19o6/jfzDzASpYF9P5k+gxsRQFvgUvnqReucjOXuucJuo2acwTWkJyROQQ8/j2oMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787


On 27/11/2024 16:09, Mark Brown wrote:
> On Wed, Nov 27, 2024 at 03:54:52PM +0000, Jon Hunter wrote:
> 
>> On the Tegra Jetson boards we have a 40-pin expansion header similar to what
>> is found on boards like Raspberry Pi and allows users to connect various
>> cards to. By having a pseudo device we can interact with different SPI
>> devices.
> 
>> Yes by default nothing is connected and so there is nothing to talk to.
>> However, this does enable us to do SPI loopback testing for example.
> 
>> So I am wondering if it would be acceptable to having some generic dummy
>> device-tree compatible string for this? I guess it does not need to be Tegra
>> specific.
> 
> I understand what he's trying to accomplish, it's the same thing as
> what everyone who wants to put a raw spidev compatible in their DT is
> trying to do.  The way to do this would be something like a DT overlay
> that describes whatever is actually connected, or just customise the DT
> locally.

We could certainly use an overlay, but how do we handle the kernel side? 
My understanding is that per patch 3/3 we need to reference a compatible 
string the kernel is aware of. I guess we could use an existing one, but 
feels like a massive hack. It would be nice if there is something 
generic we can use for this like 'linux,spidev'.

I see that ACPI has something and it does print a warning that this 
should not be used in production systems.

Jon

-- 
nvpublic



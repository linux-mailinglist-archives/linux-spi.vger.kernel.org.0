Return-Path: <linux-spi+bounces-7742-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2076A9AD64
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE01891038
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6F2253B7;
	Thu, 24 Apr 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E9KlommB"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81A23816A;
	Thu, 24 Apr 2025 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497672; cv=fail; b=YSxrSLATFF0+dVnhGCS+yvIsoxEZ17Ad6teRwF1vpfOoSLzxmVl9JREq9VXp9tdt+mVV+wwUqT8SsmNWPKTjxk3NY25Qtyd58ujU9/CBfba0OuzbBWEaRepcLeDYO57JeJTGwcnmIaG3wI2EWjZ+xpv17qI6fvkbkZ890QH54OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497672; c=relaxed/simple;
	bh=NwdOXEipAP7+YTAH2QF2b5PPiocjMBReK1xPDEvQCkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNs6kKVLY6TO5RBWXQGNopcHAkvRtNf3NX0jzO1qhna5sPCzmUejKGRWmXdPi3UsKvnZgW3MtzEhoKQiJh0ssO4hy+OuBMVPaZN5F8HaofysvLUyXY+3QzlE3+2q+VgbpfToDyWGRyCYYdBns8gv+v1Ut3QwhgBzEQXQILyPx8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E9KlommB; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2IgPR3Ss+N8lhmsFTD2x4lUg++nBFQjsPZjY4Xai4bZIAqm5lsC7Sg31QpKCsRaXmbwaL0eY+pVRXi/HHclmi4BxZhRh8jy8tmvdy3bAY4siuxwf8dWSSwvU3gvbaisByqz5RxgoFvW3MQcq+7MELzQgTIDl1yY/BxcqU96LLEqRIQ5Dg3OoUwzBHu4xSUjYDaUz0zbvo8NO8Dn1tgHODjyvgrQcLua+EeMq2xATRNrGMIKyLYFvcb4G4PhVeNMzQUwwhUYEbcpHdaH5r1TXaofm2/GXfOMqn8CCdKLXqhyL+5hQwyUuafSWgf5NdIq0osRUUZtTi7G8QgyA4K02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ+yw/mZqELCXVHbiIj9CaZhRXxMbNRY3hmDWqlT6pQ=;
 b=NkTpH4zsKTcpJv/d5mHR2kRMDV4SjlgcwUchm/BCIiKZXBFrMlzzdDnYtl3xW0A6qk0tS4ZgQgMwBbs0iKfQ2OjbmjH1r4zjY0mHZOwqQ2t32P1/u2rsL9q9clJNrWJlCFksB3/i5Qb4n7tyZC9XrEtAmhDXPJVmMAr+A3DTCMSbWKagf/0kgwWHSvl/yM7iGK7pS4a4YsMmx3ZT7B38hYS9DlAzd7ou3oKA/3aJ17RnLnalrz5G6lQhuRI7PHgrBBEuS/a/N7nkeIL7q/ucDwEzh+o+xaJtCzkryvD7s2z9C9QYF8N9ME5hzSDiu6+kj2fL+A6Gw8rO1/ks/+pCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ+yw/mZqELCXVHbiIj9CaZhRXxMbNRY3hmDWqlT6pQ=;
 b=E9KlommB+4RjgkIJ1eaJTFBJynI54duIkL6vD43OABpQjQhmmQda8P0CxlfBhqg7G4303/Sc1Yw6CCDTbx7L4QPC4UytbyagY4ofrI0bnx/rm6XrgFqRYN3yF5ed0zMJ3FykcOCecBd9s3ezv0jolmZkKHGRSGBiDF+6GecyQec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 12:27:46 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 12:27:46 +0000
Message-ID: <7166d32d-1172-4f43-8539-199791a1f82b@amd.com>
Date: Thu, 24 Apr 2025 17:57:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 miquel.raynal@bootlin.com, Krishnamoorthi M <krishnamoorthi.m@amd.com>,
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
 <8e9af5cf-0098-4b76-a945-f8a96b75e163@sirena.org.uk>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <8e9af5cf-0098-4b76-a945-f8a96b75e163@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb0dd40-bff4-4191-8fa0-08dd832b6aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SklZckhnSW1iU28vdjIrMUd6ckNPeGdtTDNvVFhYZXZyVGpnS2lROUxnWTlz?=
 =?utf-8?B?U3JsREpGK3Rsbjh1RUVrKzdnTDBENnlXMkVCbzFoZldDMmNuRTE4alJLRlBa?=
 =?utf-8?B?eDJvLzV6ZnlCd1Z4am5IZzkwNzJDTHpGRnFIVU1ZUFMrckFXWThEY3E3aUx4?=
 =?utf-8?B?WllzL0NHKzM0dDd2V2YwLzVtdG4vZXlWUVp1TnRJTFVSLzJ2NzNYbmhkVSty?=
 =?utf-8?B?MndpOGI3TlBTNVpYRW1ZajFOK2xzaFAyNFBRTjFRYXhVVEliVmppeVpDdU5u?=
 =?utf-8?B?YjR0K20rQkFGU1JVNFY0L0YvWHVXZk5tMzE5MEI3ZVYzVnMwaTNSSXZnSkFP?=
 =?utf-8?B?ZS9UUDJQS3lLZDIrVGVLMSticWJmS1gyM09BdUFsWU5tWW1KeXNVL0g0c2hN?=
 =?utf-8?B?VmZIdGZOMEo2cVUrNmxRa2FwdTYyRmViZ3hoZnNzdlFHQVJleHRxbnN2cUZu?=
 =?utf-8?B?bTIvdHd1UnpXVTBCRGhYYzJqYWRMVlFROUJHL2dnWEN0MU5CcjgzdSs2LzlM?=
 =?utf-8?B?YlpUT2x5M1o2Z0lsa1BkVXdhbEpFM0RkMzI5R0U3ZDI3K1VBR05yYkJEelAw?=
 =?utf-8?B?Y0F4UFZZTmp5U1hpMEZyYnhnbWhWZ2txZGhmVXBtcm1QTTRiTm45bzR3VkI5?=
 =?utf-8?B?TFkyTWRzMW5ZS1ZJYlV2SXBnZ0labDJtUnJlR3l2Z3RMemU0N3Njai9LYWVM?=
 =?utf-8?B?UDhyVE5qejFPcjZKMVpYK2NyMU1LQ3o3TDFiUCtvQkV6UTNQUGhZWVRNTnR2?=
 =?utf-8?B?NmQrQnhHK3dySVRoL0k2YVByak1ObjZHT0F3SVdGTlpIeThXV3k4Z1AzVXpR?=
 =?utf-8?B?MklGa1J0Z0tqaUlYSnAwRUhTZEFLVkk1djl3UnkvSUdmV3cvOHRUTUw5UHgx?=
 =?utf-8?B?Nm1SeVRkZVJwMEJoc08zZzk2clhyT0JzRXlTSWFkRU9Wd2huZlI0QUp0K3N5?=
 =?utf-8?B?WEpQaGlkMGJBamNTR2J5VHdjZ2crd0p1L2UrN3dpMTZLS2lYQkxERWFGZUVr?=
 =?utf-8?B?WmY1QWFVQWNxNWFoUmFKWWNqUnk0NkZkWVFNakRGelJ1R0FjeHhtck5FSTNv?=
 =?utf-8?B?YmdIK1dGTWhBekdVOWZDcDluK0hGMXplOGdDTU1qa3VCWFR2c3B2dEFaVVV1?=
 =?utf-8?B?WG53anZBZnNtclhzRGRaQmJPM0hJNWVtZTN4azR4a3JXK3FzUVNXNlhGbVVT?=
 =?utf-8?B?MVJyVGhrMU8xRno5aldqYjlFc3k0OUlsRkRLTzhxbnhxaG5QN2I4OVVuT3Ux?=
 =?utf-8?B?WlpKc2VRMlNmSG5KeDNKNWJ4Ty9icGkxNjFFcmJQYnU4bmN6Si9VTi96emRi?=
 =?utf-8?B?NTNtYjY4dUc1N2VTRy9Ud012RVdOOU9OWEpvQzltelhXbllSendGREFzQ29W?=
 =?utf-8?B?aGFZOVZYQlZPemJvbFZXa0hUWnJJU1czNC8yL3JrTU1yUGVTTmkxMW1nZWND?=
 =?utf-8?B?amorN0FtVmd1eFBJeFpOWXZPdkZQODJ0SzZROFg0WXQ4S1pYL1Y0YlFJUElS?=
 =?utf-8?B?c083dWNMVUM3Q01ZTkpqcm1iNklKa0laSDg4NWlLS3ZETUNxeG84b2labkha?=
 =?utf-8?B?c0RoY04ycTdzUWxoTmg1NFVyeFF2UFBCdWFOd05MMExYcythRG5mN291L21U?=
 =?utf-8?B?Q2Fod3lCV2llUk1Vd3d1dTFJZTNrYTg4OUdlWDNwQVpKMDh0dUFDRmgwREVQ?=
 =?utf-8?B?Y2ZmSW1jcVdGZHd5MG5HZ1R5ZlB0QVlYbG1mbldGRlZ3K2tIVXhlTG1UOE5m?=
 =?utf-8?B?UEhud3VBb2dwbFlrU2kzbVY5Szl5OFFQT0pxYjlvazdPeGlFbkhhekRTLytx?=
 =?utf-8?B?Q3E4ZythdGtWL1Jud1luNElSUm9PVzYrWUUrVmtnOEVlc1FFMEtLN1pGK1lz?=
 =?utf-8?B?R3NmU2crVTFJVzVhOTFnQlFGUU1OSVFGWEF2MWUrZU5hTkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGRLKy8yWjFGbmpOZUtEZTZ1dE9teEc0YU1UZldZbW5hSGlJWUhxVjczTEgv?=
 =?utf-8?B?d2Y3Vm1nWFljN2NVQUxIUmJUWWdTM3AxUGNPNk0zcFZQSWk3TmZxVks4S1hy?=
 =?utf-8?B?N3ZMUWtiNUpka0FkKzVmL05qTmJJM2VTSWRYYy9QYnBRVFF5NXJvOWVZdDJi?=
 =?utf-8?B?SEV1ZTZuTFZ6dFB6TDRPNTB6eVdqZzlrMWxFMGhnOTU1L01SZGFwc1c4ekhp?=
 =?utf-8?B?TWV3NU9PNGt4eE1IanRTcTRHdURhUVNRZEEzTFhObzNESDQ2d1crd3hQL3Fl?=
 =?utf-8?B?YnNYU2ZOZDcxZXpnRVR6YnhJdEh4Umk3L05MdDl3ZXhycG1MQittd0kzQUxo?=
 =?utf-8?B?dEJHelpESlhMTDVWbDZTYndJTGx2ZytIeVJRdVR1a0dJYmg5SjRnTzJpaVhB?=
 =?utf-8?B?ZVZCSWZUTTNscHhycnF6MlZBTDhvVmUxeXVzbjFLU016YTB3QkNuYnhFMjRo?=
 =?utf-8?B?eDlQalpUdnZzZERaTHJLL21CcWIzUy9oU000bXVQSXVNU295VUF1OWhxcWpV?=
 =?utf-8?B?N2drWG90V1QzWVJNNGFBOGNMUVdNcHZmOFVIRFNkR3daOU85N1EydC9kbmxL?=
 =?utf-8?B?K05MWW9YZjZGY1pqeEtoM1JoVTV3WVBkMTJOWmlJMFVUN1UzeDRrUkxJWjdq?=
 =?utf-8?B?WXdxNWFtZ1l1TzJXWmUvbWtBaWpib29lN2t4NGxBRHk2MW5HSi9lKzFmbmlJ?=
 =?utf-8?B?MloxRWVQWERzaEpTSW5ta3d6YjB3ajlTeFdMUzZwVUk3VTRXM1Rlc3RybUpI?=
 =?utf-8?B?TEZJZDQwcDFWV1o3NGVKSFhtZU53ekNUM2YxSDFPOWRJbUxEVzlLYlBGeEJJ?=
 =?utf-8?B?QkVtSHdqOGM1UUhrdHp0NGkzaThQVXRsTEZVdkJLeFNYMTg3MjdPb1hkUkNO?=
 =?utf-8?B?VGZQYTVVUSs5VDFJVmtTYXY0THJiZ1pkWjVuUVpxRDhHZ0lyYzkyeXRZcWF5?=
 =?utf-8?B?ZmN0b0hnelZRcUJMU1dxNktwelhjbm02ZUxYRzhBWThYS2hYdTl2dTZyditY?=
 =?utf-8?B?OUdEVkxkN1pZYmZiRGJoWmdkMUZzMmw2NlJrUVc2TEJ5ZnBBZUxhc2hlOUdJ?=
 =?utf-8?B?NnZ6d2p2QXFTcTU4ZmFnRGdRRDU4bFZGUTlCcUEyK1RGdnNpS1A4c3FwbG55?=
 =?utf-8?B?Zm5JVmF1a0pMckJ6ZG1tTHExYTUydFEzT2VFcnVXRTFRQzcweVUxUUdrMmh4?=
 =?utf-8?B?L0krbU5jZTY5Mk56bkVUYjFBQXF4eE9VSDRoeCsrUzhGaXUzN0VNTzJjSnl5?=
 =?utf-8?B?Z1g2YyswZDUzbURyVjZtb2piZ2hRRTlxMHl6bEQ4ZWh2YlZ2bXpKUGFYSTZs?=
 =?utf-8?B?T1pXTTF4V1R2MXhucWVFZ09MbzM2c3JQQ29DYzlPL3FqaDk0VExkeGhsb0k0?=
 =?utf-8?B?NHY0SW4wWkJRY3NWMmdwY2s3bnN6clJ6c3RPazhCbVFVY0FOUDBqY292QTFJ?=
 =?utf-8?B?VlFKeFFMd2RhWCtZT0kxa1NHVURBKy9tRWhqZ0pwa2wxM2FsUkJPVFNveldE?=
 =?utf-8?B?bllaWmhLUlZ4OThROCtRaEd4d255MjdPb3h4d3hyYmdqQktiZkQ3bEcvNC96?=
 =?utf-8?B?bHcwK2NMZS9yWVZqZ0RWb0ZJYy9jUkM3KytuTTdoZDdQSWMwdDJBZGZ0OGh5?=
 =?utf-8?B?Y1lFVkFRZzEzRFlWOTcxNWZ6V1lKa0UrVUFlZHZRTTk5S2FMazUyRVo3bDhl?=
 =?utf-8?B?RzMySy9aMm8zbllFdVQyY2xzZ0IwbkRQNDkzdVppSWlJZGN3YjdjZzdKTjR4?=
 =?utf-8?B?Z3d2MDV5RTVBT1g1ZmJVRElSZngrZExtdmhuQnpyMHArVWxyVnA3SXViTzcr?=
 =?utf-8?B?V0hJUW5oZCtVN2hOMkdLNC81VmVmUkhvRDM0eFdhUWVKTW0raVdtS0VSaWdr?=
 =?utf-8?B?cmhvUmQ2VmN5dmlKbXFISDBCM0VCaFo3VjQ5dmM2WFJzSGNxTXBySU1GYkp4?=
 =?utf-8?B?c25qVDYrVWpleTJaU0xVcHRrZ2dDeW5qT0NRT3VYaEdTak0rcHQzZFZWbmky?=
 =?utf-8?B?K0lCRWNYV0ttLytGMVR4cEJsUFdGbHJ6Sk52YmdwY3UrL0hCLzZMVXhQOGVm?=
 =?utf-8?B?WXR2dnpzTjBRVGYrRHhEWllNbEJvNkwyQVZiMldMMDVBVUo2VVp6Y0FMMTF1?=
 =?utf-8?Q?lxLV3ZVl9/9e9HtPK8wQalGv4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb0dd40-bff4-4191-8fa0-08dd832b6aac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:27:46.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lGEXz1X0z9Lq2SNU8/bFG1jZY3oDb6Z5I0YMnwtNkA1WVVZytJfUO2dXFozCbCXKYqtK4t9mTwHBVvZYDeagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761



On 4/24/2025 5:45 PM, Mark Brown wrote:
> On Thu, Apr 24, 2025 at 05:43:33PM +0530, Raju Rangoju wrote:
> 
>>
>> Following divide error is fixed by this change:
>>
>>   Oops: divide error: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 15 UID: 0 PID: 1872 Comm: modprobe Not tainted 6.14.0-rc7-zero-day-+ #7
>>   Hardware name: AMD FOX/Lilac-RMB, BIOS RFE1007A_SPI2_11112024. 10/17/2024
>>   RIP: 0010:spi_mem_calc_op_duration+0x56/0xb0
>>   Code: 47 08 0f b6 7f 09 c1 e0 03 99 f7 ff 0f b6 51 0a 83 e2 01 8d 7a 01 99 f7 ff 0f b6 79 19 48 98 48 01 c6 0f b6 41 18 c1 e0 03 99 <f7> ff 0f b6 51 1a 83 e2 01 8d 7a 01 99 f7 ff 0f b6 79 20 31 d2 48
>>   RSP: 0018:ffffb6638416b3d0 EFLAGS: 00010256
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull out
> the relevant sections.

Sure Mark. I'll respin V2 keeping just the relevant part of call trace 
and discarding rest of it.


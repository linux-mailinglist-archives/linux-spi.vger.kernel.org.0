Return-Path: <linux-spi+bounces-7762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CFA9D0B8
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1654C16BA
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE6188596;
	Fri, 25 Apr 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jt5fTbqf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xg3Mnw6k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A09221767A;
	Fri, 25 Apr 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606791; cv=fail; b=ujTf4DLrDc2/ILCLZyv83ydONMurdHemTDA2D2m7Oc8S/pE8w49pj5r41nSJq+KOGCGmSBnM4dGGpZuk0/XLYWKIyTKR8xr8ArJonEs3vEIU33EsryKT6FH2QxC4/69PcNXFHXaUdLhYLx6iKvcDoNonIzf0fK27MSr9ZcfUIMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606791; c=relaxed/simple;
	bh=yX5UumpIcIbkyMUMlUl9bBmBbq8MkOwFiSBtCu8iMTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gHAm75BDnM2TORR/jHsBs2ykB2+5xfUzWe2Rx0/xh+C/oYEC9ZprNkj7tW5dq5BgDwMo0DPqZ6T6SBWJjKY4kEre2xrlVSooalHdNnDu2IAYjR6rEvYyZeoARV+bFxLH/Tr2FcCQ4F8VI1kamNGLJQsE6fbLdsUao/RaA4GrBCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jt5fTbqf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xg3Mnw6k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PHjGZZ003411;
	Fri, 25 Apr 2025 18:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/76VcFleXkjMS9pDmRoxHUX9s56D21jX/JQ+CHptrf4=; b=
	Jt5fTbqfi9dBW6Iu9trp6x5deIMeYleI8U8Z64lWhSpLnQtimB0Jyj8NifYT3BCd
	fBwcy20/HUyWSdgsao8zNJRb+sAJXAsEEqWS087vawhMO05juRpwPLozfGNyxrPP
	+uN4fCeMIKmjoDQyy75le4G/vdHK8DFXQ+GCXr8jNgD10jBAwqj8S2D6cvNV86rS
	ZAJkdWdTRth3sUfJfcjgPOvfTzwsqQtMmM0xSZ7/rtzY6adAyAOhSW6rJF8oAiO4
	TxgtI/6cNBNXQVPrmEfyQP47iI0202tQ8dBhn9E9S152qpYRnBS+iimoO+qpU03W
	Lu0GX+SpsrmisynNq0JbXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468et1r9xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 18:46:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PI18Cn031751;
	Fri, 25 Apr 2025 18:46:20 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gft3yhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 18:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/AuzFU6Y13YLngDvCPcZ+qaBUbR+SrQWBfiyhCquPQqUri+Ycq6NZtbTBHmzyWItHs7gfcOj52ZspD0fbpHBBwmUJQHNKmYuYxbKL4ZbPZscuzOx6KL4z2YlEfEaFZ3hyC7faA0IHBv45tWhMvoeCm6Ts27ZfsZedRV272ui1rWRWPIZZKyPEog4rhPhzeyaJ5fjKT4XZ69idbyJPg5m4LWfMMNciHnodXukoSdnDdZzcySPwxuIrz4G9Ake5eiEHtUxsSEBRQRxByA6ARMvf+7djqe9n9oQQ72SSLbGW1FcCukVEnxWiumTUQZNsdO+8sopIAndEwZReYbbf7VdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/76VcFleXkjMS9pDmRoxHUX9s56D21jX/JQ+CHptrf4=;
 b=nHamqHLJhRtIFmKu9xW5TmjIGTQCzjKG1qbS2RyKq5roog382w3PRcrIIlxzGAo4xeSjqPrllFUcKIL/yS2fbhL1zbzea8ZzfjWSvzQWg39y1Fi3db/FkvuTpmiVnX+986xg4Q/3hVFieIVtKp/ZbLFGZHqzxOBLvK7LfoLbVEaiSTSkw2DRIOWAVTwOVXN+Vf9iJ2D7+E4EBz4HPlifgvTC0ymDLsBYPJjE2BOlnCqXTYKlhQZLYOjOIaeF3hxIrPYMwUYp4irHn3hygsZVBf1B4E7HzZAxyaD0VsWwhGJThZWnt9xe1MNdBArZo/5PLHgHGExHHLkVQKH8tQBx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/76VcFleXkjMS9pDmRoxHUX9s56D21jX/JQ+CHptrf4=;
 b=Xg3Mnw6kmpy0mqAVMXZo6OqXsb8GMHTaifxlIgwWTJOWU9G1SU3cr0P+KstXQ2+6DvOyrmSpwEWIRIU43+sjYegzhEbjH1IzxI0an7WTEBqhovlOTvjsbymmWq3ZbrlnfcDSvD2sA7pCoC4NkNg4amR/GfvYs1U0odKW8bBZoHg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN7PR10MB7103.namprd10.prod.outlook.com (2603:10b6:806:32b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 18:46:16 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.033; Fri, 25 Apr 2025
 18:46:16 +0000
Message-ID: <ed290edc-c310-4259-9b44-ad43c425cc28@oracle.com>
Date: Sat, 26 Apr 2025 00:16:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] spi: nxp-fspi: use devm instead of remove for
 driver detach
To: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20250424-flexspipatch-v2-0-e9eb643e2286@nxp.com>
 <20250424-flexspipatch-v2-5-e9eb643e2286@nxp.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250424-flexspipatch-v2-5-e9eb643e2286@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN7PR10MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe356cb-636b-4f6c-ced1-08dd8429756e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnIwUTMxc3k5VkNQaGV1VXNIWWNacjdkcFNNdzRtMHFSYm5vMGVDN0Y2UFo0?=
 =?utf-8?B?QWFYSmhmeFN2Z3dzd3dKdHAyQzk2V3VpSEd5N1hPY2xFSFdtWndpdUVsZ1JB?=
 =?utf-8?B?THpsWFR6WnRaVkZTYUlPV1M2WCtQZTdhVm5Jb3UxUUhIZkdFYW82K3gvOGdi?=
 =?utf-8?B?aWZXUFJVODFIRVlDWk00c3BId3pvem9Ya3JWOHJSOFR6Wnl4OWtDcGtDNElW?=
 =?utf-8?B?THV1OG5VSzBVRmFKRlovQTNCeTRwdDVBMFhCNDA0M0FQVWczODBmNElqaU55?=
 =?utf-8?B?bzVSRVpGamRJSHlMNkhieS9tNmhRbjl5cE5NYmNNQUZ3ZEVlSXBpY0Nuamps?=
 =?utf-8?B?ZmZZK0VpZTAzcnNtOUdrTmJTVWY0cUl4RlVuTDhsQlU5bXNyVktwWWN1V1ls?=
 =?utf-8?B?YmlOdnFJVWcrNkpnMmtSQ2J3N2VDTmh2OWt1b21oblNCV3dHeWxMb1BPVjZF?=
 =?utf-8?B?L3hQZWRUQ0NVM040VXluMWtrMlI2WTdXSy9LcnhPVXJTR3VLeU9JNW03T2to?=
 =?utf-8?B?SmZYc1Jta1hBa0xld3lPYldNd2Rtc1VZWjh5QkpIRTVjVEpkWEJ1a1Y3cUpJ?=
 =?utf-8?B?bVNwVE1BbGhKRVQzUTFETFJibmMrcU9wUElhWWcvcDRnem9iWUlhak1Oc3lo?=
 =?utf-8?B?OW1oSnFYWEVUMGlkMThPUVg3NktZT0FVN1RpS1RxNDB0cEkzLzltVWtic2dV?=
 =?utf-8?B?N25qdlY0b2d3TE5McytUYXU1NGEwV0VhZmZaaWMxWWZFcFB3ODl6SEpUMTJs?=
 =?utf-8?B?ZjJWdElUUzNUdHJ2bE1wUjNkVjJ0cVgwcmhpRDRJNnZoY3ZGSUppQ2d1d3l3?=
 =?utf-8?B?MXR3N2U1WnoyTjRRQ3lxS1ZTNVA0a1QwcmFNNXFNT1YydDJEMDN3UWk1Q1Vr?=
 =?utf-8?B?MzlEVlhlRkhHYWFyV3psZTM1M2VpbGdud2p4ck4ydTNaTG1scHBvMzlUSXNK?=
 =?utf-8?B?RjF5R1lnNGNDNlJDMXlwcWtzTFQ5eGNFYzVXZnZ5aFA5OURIWnRoaUtabnow?=
 =?utf-8?B?VTZLM0VDZnBXc1VYZWZlRDNTTm8xK0lNT1lJTklnVk9XVUNPU08zZytsNnNy?=
 =?utf-8?B?ampLa0ZlWG5UYmNsSUdGTUl2YUs1Wmw0Y1ByWUdQOStKWDUvWGV1ZUdQS0JD?=
 =?utf-8?B?YjQvTUFjek5UUUVpUEh5eXhBdFJpVnRBeURjM0l3elhveU82ekRqbEgvTEJV?=
 =?utf-8?B?RUo5ZnlvVlJ2WFRmbVZicnkrMzE5cW13bFI0ZEtEWldwWkR4Ynk3c0VRcE9u?=
 =?utf-8?B?UWd0YmIvZDgxMnNkV3EzdmJZMGU0dmhPbWV4eXZRRUY3N0pibzE2czRkbkFw?=
 =?utf-8?B?MW4vRjRWam9saDVuWnd5QUJvWVlMaWNiWTRhNGtSekUvb2NRNCtRdy94SGd2?=
 =?utf-8?B?S283c1RIRHdTY2VVUG1INUlyRmRZWmZzbFhHT3pPejNRY2VKL3p5UlFHVXh1?=
 =?utf-8?B?Zy9kNDVVMVcxclRjaXRTNTVEcHI0dlFoeDgvam91dXVuWDdwWG80ajN4cU04?=
 =?utf-8?B?Wmg0MFYxL0gxTlBZUnM1ZjErUEVRTDVDOGQvb2FjQ2gvVFMwTTFsUm12Mll5?=
 =?utf-8?B?KytUVUtmaUhtc1U5c1ZuTkRsTkZiVnpvNnE3czJoK056SzJKSlJJbXNzVGhu?=
 =?utf-8?B?ODhDZUF0OTdrblpQeWpOamhkT1VLRmxmQ2pqZGprZW83V0NBVTNEWVg1ZHZJ?=
 =?utf-8?B?YWlRZDB1UG5XejZtUnY3Z0J4NVc2OCtST2tsSlJUMFVLM05oRlhwYzRuZkJV?=
 =?utf-8?B?OVg2NDZCVXZHazlER2lTVExYQzFuWUNHMHdqbG9IRzhpUHZBSzI0dlF3Z0VX?=
 =?utf-8?B?MEllSU9ZSEVnQXFobUZuU1h4T2xmbHczajZRT0lxMkpjMkhBK3c4bWQ4cDdj?=
 =?utf-8?B?UUNyTG5uZlp0NWVoWWlEODlUNU1meHhWeWhySzZvejFWem10OUgwZ3V4ZTRH?=
 =?utf-8?Q?cUOPw74ona0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXdReXdNYUUxNU1paUZ3c3VvNFgzMFlHQjhCS1lJV1p1cDdDaGZjeTVzQ3h0?=
 =?utf-8?B?blM2Mk1aMk44NFJtUlZEcGtxOWl4RjE1cmtiN0xlTDN0SjFsNEVxaXVrN1g0?=
 =?utf-8?B?NUtLY2VRTjJhRTJMNExHM0NQLytKOUQ2OHhYZk54eldtbEFVQklWNzFDUkpq?=
 =?utf-8?B?VWkrck50S1N3TXpENVRjUzMwbHZEMnJKSEp5ZHA3QTVIS3M0YUkwNzR5emVk?=
 =?utf-8?B?OHd4Wkd1bHhNMnppNk9GNHJ6NnpXbFIxNHg2RFZjNzRNSUJmTEdCcWFKeXFz?=
 =?utf-8?B?VW9WRWdwcVVnUk51R3BNYUFTREE4V25TdzBodjdJaUh5TElHRmRvaWJXZ3dI?=
 =?utf-8?B?SEVMU0o3MGFIYS9vV3pKckk0aXNTYS93SFh0b21Id3ZaRzNWeWtDZ1VZT3BI?=
 =?utf-8?B?YUQ3bjFyQkFrMVpObHUweElTY3ZRQW5IYUZWS2FUNVJPL2RoaEhZTkwzc0Ja?=
 =?utf-8?B?b3E3ZWhyS01yN3dtSUZjRkJDU2xNQnVkd2s5eFQ4ZnBBZnZ2VFRMQ1hLOGRR?=
 =?utf-8?B?b1pwOFNoRzBuTE9kK2RkajZSSTFaMGFCbHdtUFB1SHloZDNtMGQyZm1aZ2Rl?=
 =?utf-8?B?YU5iMlZGQzVkZ21GcWs0ZlY5WFkyWDhRejZpcWNYUlp3QjdtRGlPcTJYeVYw?=
 =?utf-8?B?ZHpxMFE4YVNhYXBBQjlGSlI0bGl2VzN0c2poeWp2N1FUbWVmaGZzRHJVZ1N3?=
 =?utf-8?B?a3R0YjMvMndtZXZMNEFwOXdZNnN6YUhreUNjcStMdlZWNUdKT0dVU1Z5VnJC?=
 =?utf-8?B?bnlNZG1mc3JRZ1hINGVtVlMwZ2lWSkphTUNvdzdLTVdDY2c5VjlHWWJFdnU3?=
 =?utf-8?B?TmlqTXVDbmg2WGgzeTl4cEdFNU54WCtSRG90aDdCWUxvTjhVV2poU3hZSVVE?=
 =?utf-8?B?UlJ0UjBtckdNUnVzQmErZSsycDlGOExBekh6dHloZ2JDZVZvRzYwaHo4cFZx?=
 =?utf-8?B?TVo1eEpwRlJTZ1d6ZksvbmF3SFZUY3lJdWVGUEpoOU01WGs5bHRFUVRxWCtD?=
 =?utf-8?B?VTUrWnY5azZieGx4KzRKUnRqRDJ6aS9laWs3bDJDeXpMcHQxMzRCRUJYd1V4?=
 =?utf-8?B?WXh6dUJ3YmIvTnoyMDRjdUF0TUFIQ3JuOENSVzdJZzFlRGg4OEM1ck8yNjB1?=
 =?utf-8?B?aEtxU2RWVFZaQ2tpcEVxRUFzbU5Ga2tBZFlyMmdBR2JBMFVSVFBLYVo1SUZs?=
 =?utf-8?B?dm5vZEZRVFZudDdRRy9NRjZRekh1ckhKN1p5ODM3UU16clQvRTM1SzcyNDVs?=
 =?utf-8?B?YlEvWG5xWXE3NWQ5MDRxZytRWkNCdjJ2elhEdUZhamdnTmlkdU5qcGhhVFht?=
 =?utf-8?B?bUUxZXpiU0J4TENudFErNmNONlZQTHIyamJlNlN3VjlQMTh0Qk5NUG84dEVU?=
 =?utf-8?B?WTQxRzRuUlRzTTJqakpxTjVKa3BYYjFYVU1YTVRLejRqa0xlS3ZyY0p0dTdK?=
 =?utf-8?B?TWpzci9qbXcxUmdvekY5Y2Iyb3JyNmRpd1oyaDc1QkVMR2QwWVRDSjJwdEN6?=
 =?utf-8?B?UmdJRWhpa2d0UWxrVlA2blpERUxSWjduNWsxVmFEeEZtbmxjbC9rSnBWM29Y?=
 =?utf-8?B?bFp1NDVKcStEdFQvbkRkc242OEROM2lYK0l5bXFFb09jNVUwWUZob2lONzNH?=
 =?utf-8?B?d1gwOXd0MkxoVVNLdnN0MHVMd21FTlBXMzlpQXNyelV1NXhNdWcvaFZ0T0Ez?=
 =?utf-8?B?MUY3OFVvb1hmdDNUN0ppSXR4Tnh0M21hcTUwb3FDOC9wd2J4b1RTdjYybHRN?=
 =?utf-8?B?WU1vcjg5cktlRlFRUGN5SndEUHNIT0JCZXNEUVJIR0sxaXdSSHkyamFKT3Zm?=
 =?utf-8?B?MmhIejhOWnZFbm9hcDQvTVVpYWV1ZmdXRXZDeTRpQmtRTlVsdmlNNTJEUGlG?=
 =?utf-8?B?VFJDTXNURk94STNVb1BkRndQQ3V4TEl0cmZMT1h4ckdsR21GeTh1N1hLN0p4?=
 =?utf-8?B?OVBiZXhPdUpMUkg3eXAxUFhVWmZ1ZE81d2hLOWU0cmxEZk1Fa0MrcGpralZ6?=
 =?utf-8?B?RklNMDJQeWJONFVRZlB1OENZUnhGb3BEanR4OEFRazh5cklvdGcrQlBSWVVB?=
 =?utf-8?B?WWdrbzd5d3d0U0JuWFk0cS9naFZCT1BtNVEvSUtkZmZHZzdvQ3VuTHVFbFRx?=
 =?utf-8?B?SWJEMTdUek9wbEM2UXFtQlhyQ0R0d3hscGFsTmNQUThSdkRURmk1dmZVSGtJ?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/K+C41DxTGlewif6lUjAY6xb3mdWAszgNkb5EvzzITbxCM9p0h4H5RWK5JiUSXSQZFJ9IVScdsJaTImf9LD1/cmJtCj6kvVhEG7Fx7UipUK2NILW4ysQvvhsyXsuvERRp0OgFevJV7CYkzwpWTEtJGC7AR5q3YGblJNHSnLmYPLOzXcobECJuPVhY9GYAK5mTm9nYAZU4qy0K0LxzoLBc+kZDCJ9hdAqXHyHSy6zJ9UENfz/5AoPZV4fOy8HR6CNq13inmtBsZWRsBpGD+W5XeyMp4wGqg5bpgtliUQPdUYyUtuR0KFQh1X5VCPvPnsOg9bJxp6piUr4leICHKfd8QNH+DHHMAq7i0urD7+FA0dsy/lzmKgzS/3FQQ4EhZFAMM+KYDyV334aVJBqcNTGvOINb4KvrqT0F/09w3Jc5TBXle0muGUPVce+3PzGPYPDvBt8hsinsczcB0jBB8hZ0yDSc9Zk5WFcLjyWKQEFEEryi2sq3RYr2wwyFXmXs9yDeYYwGSGNsi7vCUK9vwJcbtmk4A0QFh/F+kowIRM46q6Znef6BXD+5jtTXanmn7vobDoXjv+ohhvq2zRlvtihJ87yGTJsx++30R+7tdyGsCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe356cb-636b-4f6c-ced1-08dd8429756e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:46:15.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRkeeO/DAITKpiovxu8Yqp84U2zLXDpZ9HlDFvqLxKA1kNRJOLrQtkZpLLvCrON1iTGRMI9zyhc1KRBUvQyX5YPDzhki3GFszzTPI9mRgQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250133
X-Proofpoint-ORIG-GUID: wSN01tB5wbZPE0HYbuXdyZCNBMIJinBM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzMyBTYWx0ZWRfX5UBW7sPCnjqd VsjAuxuwlgnTqamQN1vAINMojy0oJZ8gCqK2ZuEEGsdJSc6DPG1Ax8pGxB103nFq7YkLowFbMAv PxUkuZfyBHQ/HcxBwf5cNox0Ay0UUtkQVIHLRlS56vTrcMYdVx0H/ufsczp7DAHFXI5ujaPWM7E
 U+v1UVvi5Kqtjb/4HXxIEBqObun6M1lzHfe6Fs3030bMcNUVlcnNKTh1UtB4eMxZ8TBK1IgcUiI 4lh0nGQa044d5Dwxn/IRD0LNdd6C08CYvGL8GFrUwWd0dVWX21ZyL5oEMI7l23WygHRJ9Zr2bgC 4XCgT7aqf4SDzVSwd71OXYdG//yPCJCR4GjMYFmsdQ1PM5qgDWYvr+WpGmHXl/2yFfRlrMm2tmR pi+jo79w
X-Proofpoint-GUID: wSN01tB5wbZPE0HYbuXdyZCNBMIJinBM



On 24-04-2025 13:03, Haibo Chen wrote:
> +	/* enable clock first since there is reigster access */

typo reigster

> +	pm_runtime_get_sync(f->dev);
> +
> +	/* disable the hardware */
> +	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);


Thanks,
Alok


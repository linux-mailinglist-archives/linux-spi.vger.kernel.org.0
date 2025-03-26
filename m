Return-Path: <linux-spi+bounces-7307-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D330A71438
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCCF3B3B0F
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703E19E992;
	Wed, 26 Mar 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zN4mOx5q"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737372A1B2;
	Wed, 26 Mar 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982939; cv=fail; b=U4qKTmqsnFYtxMzlVmijFY/PBm0ivlXMcgSU5miR0EfnoTjuHpXtKXdj2hLtSBqCc7YOSrsiUnHCmx/Xr4H2xXqvubzkZfySCciCJgmQ3DaiA5UM3uzPsMJ7qgy9lii1q1o0oTdIn/taS22asFxR6WvYJow+fKFHssuBDL68Qso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982939; c=relaxed/simple;
	bh=JXIM2mXvDFHHz41AIeQzdONWVCBvVxOulh9u37XANy4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=owV0ui55H9I0mB67kRBTrLBVSZTyRDDwHkfI5M3XbqoQhEWy77jKaBlSFfgorFgH4hpOZCjNtoGC8YjEeDR2cbtiNZG6wELa+qGW77btocL3eVHzfw/pKJegLTzyH+b6sJEtv03xdIqqjrPcagde6vH5Rp2M36VLidZdIFi1trY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zN4mOx5q; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEh/f1mOHcnlOMtrXKLwk4IR4CnsQ1onBdDmeLu7AXziDoygcC+rDrAVRMq89wjONFptOyKrsBEC/ROgfDN4IceyPC3UCZEqy9nj8i5rQ1SJGv9QtRfv8emPINxuFTehISKSWBLeQAJdNCXBdVYNAkwNjrapEiwdqt3d0awJqcd77xS30DfIbSpaIo4nrutzWFmMgqmfg0JgLDm9BYMxQWS6qbdz8bwqPjNjcrQc9NAoQDEwbBas1oMVVVE5s9dI6nJZnrxKE76z2TuVDxVuZgo1CpIp0X/eVUkcDaRyYiIKNhGgEyXXLofSo83iRg1STCUe7VXtHRdwg6Fi7smhrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewTzIN8L9UpSflR7wzXvkKVJn8YqeABObDuKH3ObVBA=;
 b=gHgWL3fN2zpPeGOyvjVu8Y0RlhN2eCR3DdrqBXI4/4R3QrrjiiYLO8oI2srocRuPhfUyH4+vmPNtCUSI8hMWk79H+xAMYau/zhReynArWqPyaErcMU1wDWqSZUqW6HEI4hDVwAIGpTHP4dgMfOnnhS5RPqB++jB6k/fim53DHv6Zvqv6asO9oXATnikJGv6L8RNIPVObNpf/7lOUTjmNqBFxEWJpzBkMxc0IxtEcLrgHq4IU+K3g5i1eaDt5MyIik238XFwPdk7g+xcvV8YEGZSayWiyKBiUc3q5DOltWPUSENfBPzHiPTUimOZAUGS/EXktPiB75h60svGSPZobcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewTzIN8L9UpSflR7wzXvkKVJn8YqeABObDuKH3ObVBA=;
 b=zN4mOx5qKwQy2eH+nRiNBObVa5jRbX9d2n2yQvO0Q/V2yucAR6KRNjZLdXyRPA7lcyPhdTMg6EXn5O/eCxAYkp/TFY2RqOJ6D2zJnNE+jCAqtlBOTdps1lYbNJb98JUPnFJ/LVTw5nC7Kgrb+BcL7EIwVoKjZ75vPO5ZZ+VtYQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 09:55:34 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 09:55:34 +0000
Message-ID: <55ad37f1-0fbe-4a83-a998-80f2fd94a883@amd.com>
Date: Wed, 26 Mar 2025 15:25:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] spi: Add driver to support AMD eSPI controller
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <e41947bb-7a2d-4b64-b680-d38dd9935a00@sirena.org.uk>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <e41947bb-7a2d-4b64-b680-d38dd9935a00@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::17) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 568a41aa-9956-47f0-54a0-08dd6c4c5a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clNXNmRvT1AvbUNCTGEyeldPYTI5K3lIRzVDNUNsaGhaWTdWYjh2UGRuNDli?=
 =?utf-8?B?aXg0K2hSTFg3ZVh1UVViSE5YR2hWdlRZdGpYbzlEdzh4VEJkbjllOHB4VU11?=
 =?utf-8?B?M2ZGdERYTHVTV0xPZUpYOWZsRlpTMXc1ZVNON2lkelcya1MrSm54WWpjZW9X?=
 =?utf-8?B?NlU2SC9SZDlNQmh3MzJSVTdQajNzYk1nMkVaSjFiK3VOTG4zOUlQNzBXeXI5?=
 =?utf-8?B?TnlZREdtOTR4Z0YzMnhjS3NjN2dZbmtLWDZLUkQ1Skl2WmlzbzNvTGJTZHRR?=
 =?utf-8?B?SkRJM3AxOWpubVQzQ253ZzFZZGU0bUtHWVA4bEZVeGJuaGVNS0ZRcTJXVGdG?=
 =?utf-8?B?cDRrWnN4Mjl5K0YrUVRuMmNBdTBNc3dsaFUwQVluN3l0TEYzMVRzK1BBaTlK?=
 =?utf-8?B?bEdvaUZ6bFBCNnE3L3pkMGZOeHlsNW96NDdQY0F0d1BsNW1pd3RYMXM3MDN2?=
 =?utf-8?B?VHVZTjBjYlpUVGRjUnBOYi9oZjhSYkJHWVZZa0VSZHltOUVuOVk2c1IrSVc2?=
 =?utf-8?B?bmM0QnJ5QjY5VjA5QnkwcUJsWkRDcFRBMTkweElxeWUxVWE2Z0hUaUprY0Nz?=
 =?utf-8?B?K3JCYTVUU1A3VmxCcW0zRlBpclN6TXRsbnhTZmRROVR6YXVtZUdhenF5RTdh?=
 =?utf-8?B?Z1BTeXNFNW4vaEUrbldYT3lJZVI2RU1adGNzS2lUOHpCa0VyVHFreUtQb2xr?=
 =?utf-8?B?M3pzR05uWjA5UnVxd0RncWF0c1FtY2pUcDlkdHorTGNDZVJHRHhNUFcyY2N4?=
 =?utf-8?B?UTBJcUNsSllzNFRQTFpIR3ZjbGZSejQ5OVJrbm1QY3JYOWpieFJ5ZDZjdUNk?=
 =?utf-8?B?WEV5T3ZUbGZ0VmExc0VXWjVZdzNJeks1ekVUZ1U2QjhCRmdiSTVvNElCWUE1?=
 =?utf-8?B?eUVNWEVZQWplRy8wTUNBYW1WZ3dyWGZ0NjBRa2FhWWJCTENuYnRNc2tKUEJC?=
 =?utf-8?B?eTJSbEdKbWs5N3lPVndvQ1pZNEpDMWQzTk5mVHhxaU1vOXJHYTNzakVaWjNl?=
 =?utf-8?B?NjJUVkZhcjNaSXdGR3piK3I0dlJWVVdhcnhqRjBFWGtCTngzSXNFa3dKdGJk?=
 =?utf-8?B?ZkYza1BmYUtuWXl0dTg5M2FSRkVERTdsVjlNb21FQzAxd0VXSmRPZjZKcEhs?=
 =?utf-8?B?NkNQNmFhZThwbTVVdU9MbnRwb0VEM2NrUHVxbnc3aVVDbFVOa0xZcDBVTXFq?=
 =?utf-8?B?QlRTeWliSStRYVNIUUZiN0JVVXJUOTM1NTFDcThMY0NQU1FwSTNjclhYQUpY?=
 =?utf-8?B?NzRMYWJMdUE0NFMwaDY1TDNKVk5ITWN2aFhFcHJ0MjdQR1pyV0FBbUd0ZG13?=
 =?utf-8?B?ZUxBdFBzTk9KZzVmREtOb1FGMHVtZ0MyS1NTU09ZYU8yV0pMQ0xlZ0hZQ2w3?=
 =?utf-8?B?UUJpNXh6bjBqWGpLL09KdFpOT1lEanhuMFkwL2pBSzBOZXJZWHI0WjZEOTlY?=
 =?utf-8?B?MkVCeFRHbzdjVzFxdjdBZVR5K1FpVU1ObzFMTnh1UHBMclZlWDY2ZjVld0hX?=
 =?utf-8?B?SXZHRzVBbWdSTjhnTnJiSGFyVkVLRXdTZ1JaSnllMUl1RnVIZ1ZkTVN5cGVa?=
 =?utf-8?B?d2lDSFlBdkFrMXdVU2cyWHNsNGZuQmxxWkdPcTFBWkhqb1N0akNSVEpUM0Qz?=
 =?utf-8?B?RFE2QzVSYVhhWWdBMWljR3duc05vc0FFbngzYjdORkgzdHRhSWJSRm1HZ3RR?=
 =?utf-8?B?UXAyZ3drTERjYlpicERVZXlPZHFVSVI4TnhuRDZwNW5SMm5PY05lUG93aVJv?=
 =?utf-8?B?VzByR3ROWVgyWE4xK3ZENjE0ZitIOUNjWk5uUS9HcjdQcDg2MWxTM0tDcmxn?=
 =?utf-8?B?SVpodEdnYXhmSnhXR1I1cU82MXFHVU1uekoxSkhaczRkTGJJUVc1dUZjWi9I?=
 =?utf-8?Q?H1E3NCKn71vex?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkVBQ3RTRjU5ZFhlZmFTdzNxMGd0WWpYUXI3c05tNmsvdW5FYlZ0VDNGNjEz?=
 =?utf-8?B?NjM0NjB5YWpjR3czNWZESjg1RjlrSU9wNkxqc2ZOZmNWMnJEZTFTOE1lQ20r?=
 =?utf-8?B?YW1jNFUyR0dlcE9uSzc1cWVPS2w5aGJyc2hIRHBNRWd3bjZTQmc1NFBPRk1J?=
 =?utf-8?B?eHVDcTJvL3JWOUhoTWNFY3FtR1k5ZE9taGsxWnhRZjFSZ2l0R2V5RU9QK2k5?=
 =?utf-8?B?QksyZUdKemtkbWpNQlczd2lPQ2tHTEplRFV3QkZ4NS9zWitSNjY5MEs0ZFI1?=
 =?utf-8?B?eUNtUklFNExubmVVeGJRaWVwckYxUWJKM2VCeHNvY1BwRHVSOUdJT3EzckQ5?=
 =?utf-8?B?TzBwaDJ2SXgydnJGUEswM2hDMlN3OW13OTZwcXA1VGhpSU9pQUJXbnZMZjFR?=
 =?utf-8?B?cTI2YXMvVDdpOEt4NHA5TnVxZUNpdTJxMStKaTlvV0VlR1lLSk5BL3R5NVEr?=
 =?utf-8?B?c1lVdHhodnE2S2hnZUU1SllWODRvQVZGWHVzcGNqbFFnaVI2VlkyMVIrK1h2?=
 =?utf-8?B?UmNWODhJOEI5dDJnRDNFUEg0Mm0zQWgxS1F6MWNhN09mdm4vMnhPamhpb0RM?=
 =?utf-8?B?b0RIbXJ2dFE2OEJlSVROVkxRTG9NOGV0cGV6WFhwTlV5QUhFK28zTUorTWdn?=
 =?utf-8?B?R042ZEtDTFJaQUlobndseXVRNHlrTmhlRmxWOE8vSXFPSnpJeXRtbm5YMm45?=
 =?utf-8?B?TzNCVUxhUTRSeTRUdU0xYnp3Y0xYOTlXN0RPeGo5SVl6R3JzbU1pRFd6TjlZ?=
 =?utf-8?B?aDBMdHVaS0ExemQ3K2NFMk9JeUVwRk9DdUNKM3N6M29EUWZoVGI1U0dGUzI2?=
 =?utf-8?B?MFRGTFREYkJOUm85TnRGbEZRMlJHTHdmb2NlQm5MNVpYN090UGZFMTNGVjRX?=
 =?utf-8?B?K0h6RGxINWlmNzRJVS9LSnpsZFNiVjBHd2x6VUc5aWZnUGRyelhLb3RmMlQ2?=
 =?utf-8?B?MEtuNm8vL0taVlRZZFhRbzd6bkY1eVBUM2s2eS8zbG96aHkrYXFraWhHb0JL?=
 =?utf-8?B?eThibmpWczBqaktJdzVKVnZhRXpGSllKN2JXV09pZ0Q1QUtzdzJmMyt0OUFn?=
 =?utf-8?B?VEE1dDV4RzdKUVdSVXRnMDRzZDk2cjhvTE9OUVhNUGpMT0Faci92RDN4a1Mv?=
 =?utf-8?B?NGRaTXIvQnNCWnY3L05xYUVQbXVmQXM0N0hOWmlLTlVNUEpGNmVpbVdENGdR?=
 =?utf-8?B?emxTRkRFUVdQK0JPQ2tySG1kZlBZUEY3bkxUazlJWGpkdVA0Z2UxbTU0MVda?=
 =?utf-8?B?czRPTkFvMkxBZnhVRDdZTjl2eThwbHpCaUFNbUtWMENNSWhKVnU3MlNjS2FL?=
 =?utf-8?B?bFh6M1I3VStzalRPRkQwZEU3Q1UyR2RCc1lySHJhdm1iQWNNVEtEWWVESGlS?=
 =?utf-8?B?SUY1MnB3QXBJUG1yejBPN1JTSllhdVBYb3pGWWw3akVvM2kvVzNITkIyTm1M?=
 =?utf-8?B?cFdlbE1xOWlScXNyTng1Q1hZQWhhVUpGS0xtYkRwaEZPNndkWnZWUnVVT2RE?=
 =?utf-8?B?UE5FdzNQVFFCeVJmTXZDZC96MkR0YnAzTWdYT0xSV1ZmT0xzUEh3eEpWSkJQ?=
 =?utf-8?B?N255SVpkby9SRHRLOUFwaXVPU3AvK2xacFR2Z3VzckkvNkd4NXpCenRhTGx6?=
 =?utf-8?B?SG9aT3dNSndXajFHTmZ2dzVQTmhYVzMwdHFYYk8zTml2WkI1R3o5QWJsMjJ3?=
 =?utf-8?B?SDNpbnNhT3dHN0hXU2VEREd1NHFMMDBKZWlFR0xtejJ0dzhxY1NOZlg1K2c1?=
 =?utf-8?B?dUF5Ymt2WTU4akxPeXBjOU9Uakw2Z2poS09FT2xrTHNjWHlZM0ZQeUN6TW1E?=
 =?utf-8?B?cmx5bHRDQXRlRDJucmdTVHlXV0ZJYTdXTDBPYjJXRFZDZW9FOE9FaVd1Q2tK?=
 =?utf-8?B?eXZib212cjg2ZzlUZmxpUmtkMldJM3pER01FS2JreGZkcWRreS9nWW52MnJq?=
 =?utf-8?B?eFdXZ1V1SFVGdnVpSWtKZ0phWkJpMjMvTGlvNEpFbElvZlBLbU1VcEsvQm1S?=
 =?utf-8?B?bmNBcTRqRzNma2JSazQ4eFc4b0pFQVdiZ3A2V2VSdHpRb0N3ZFgrREdYV3hW?=
 =?utf-8?B?a3ZBZHJ3SzJ1bjdlNUpxWTEvYWNwM0hMbnRHVTRWZENZaXkxNS9ISnVGcEV0?=
 =?utf-8?Q?2aRx2OFgJkW0W34XPl9Mdfl2N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568a41aa-9956-47f0-54a0-08dd6c4c5a53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:55:34.8687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PltCwNQFEC8EUBbqaynDfYkifD8vQjMxaHprp7GrkkERXsFu9LzD9otS2uwtC1huq7+EtT+kTLMFcoovO1/Nog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426



On 3/17/2025 7:44 PM, Mark Brown wrote:

Hi Mark,

Thanks for reviewing the patch and apologies for delayed response.

> On Fri, Mar 14, 2025 at 12:04:30AM +0530, Raju Rangoju wrote:
>> The eSPI protocol serves as a communication interface between the main
>> processor and peripheral devices in computer systems. It offers several
>> advantages over the traditional LPC bus, including higher data transfer
>> rates, increased scalability and improved system management capabilities.
>> The eSPI protocol supports multiple channels, each serving a specific
>> purpose in the communication process.
> 
> I see nothing in this series that registers a SPI controller with the
> SPI core.  You need to use the standard frameworks the kernel offers to
> provide standard functionality.

The AMD SPI controller hardware has only the chip select line enabled, 
which is connected to the EC slave in AMD EMB platforms. Currently, 
there is no support from the slave device to register as an SPI slave 
device with the SPI framework and provide SPI communication.

For this reason, the AMD eSPI driver is designed to handle device 
initialization itself and provide a character device file as an 
interface with user space for dynamic interaction and configurations.


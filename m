Return-Path: <linux-spi+bounces-9118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E639B08335
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jul 2025 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617337AF3C3
	for <lists+linux-spi@lfdr.de>; Thu, 17 Jul 2025 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404FA1DF248;
	Thu, 17 Jul 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="IFFSRuBP"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023094.outbound.protection.outlook.com [52.101.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414002E3701;
	Thu, 17 Jul 2025 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721627; cv=fail; b=uimYVXvXU161FXkTdu0b211u6YBjzKH8XKqHaY3LBWeEm7YfxjoFhTSwlIRbbdd8uocNNnWEi0DfX+6GMn5uYxtT0+DFjZbqgYhKSs78lVDYwMvxLs4h3oJiq2dK50aqh5+SUhGmWc+c+PRU5cj7hXx2bsOB82/CeM2V3wS/Meo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721627; c=relaxed/simple;
	bh=FsMWoLCABkt72iM+reJ/j+4l2Jt2M2yWcmKWwBCyGXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3VY3y/5GzwvuV9YbtjUebGmFPtjuCMOBPAfFhIM5zJiGkrxg/k5dZC2bOGe+Z3kG4RYAXNTi4bi80eIKVhVgnTjZS/3NYTicrUGzxwkJwWthi9V9T/Q6tfxXbUb9Rewn1A+gp3pKYCdK5KnfLI4Qt4l6TF4kL+RmsH8z05yQUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=IFFSRuBP; arc=fail smtp.client-ip=52.101.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLl9sl6mjF55/zMQnFXazsoZpMyI8td6C7VdqiwweeDxeBAtWWtUkvKMjvQNg4ZMbDYgbTaxEE79Mi1S7xoQu2N/Nn/NxZspeMTYP4TbmLpBqdu0O4NO1BeZC5pK8G8PAWhIk3H8C5qs2xRnUiDA4YeeBjjpKh4gFc6rIzogb9l7lsaG/jnZQD4rjDkVZizTkzHO4FK41NPId0x2g7bOvUdyJZqxBSivbQuJ3d2XgA5cjFgY8I9kb76tSMgw9WNNZJHHYNQKc0PjJh5KdBF5RE/jMCyt03VvAQJaYLMBg/RINDpJabjj1EBZYnI/lG4hcxdC1/8qYUJCeuaiKa5yGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6srlpyOysfxSxp//CePCeOexlHkcn/jCRPFIF8Lut4=;
 b=PDkAg2HSl6uWbgnkyg0rpVVO0GyBLhi71mLFfzXikUhL85sqLvQYFhh05iO/x3ZPY2OqNn1tEbhwVuuF5iQU9ZAJ8YEZNoQFhrU4yLeyXbMnfn97qn5WXyN5kSaOkkW4LC6TClO+Hp9HhW/rszU0z8Vk+adQfwY7B3WNYZq6tOVuLZSQ/SI3FIMhP2lSj23HDisLK7QS+qrKeLJageKAmE7ji8oq8yX0n4WEpFcSb2NMRvT1Y9r6glf4qOUhG78Bh2gqCHB/NJsCPUYDOeiR2NfoL+56DRnjJlSvdpBF8ppfyx1OY6n/ryDEzJtirACkwmbH5uUVuV0LbGdBWhMgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6srlpyOysfxSxp//CePCeOexlHkcn/jCRPFIF8Lut4=;
 b=IFFSRuBPZUgvttaAfNGxpSKFchquvK4BNawr4gsGMJHda4RKJc4+NzvoJwwZ9PvbYKsH3dmzxihnF+mryAyjoDENhOjZ61Jh6vTJBVx54yKhAG1oEFQtm4RUjg2vU7/uoQFU//4l3Tt6HeKgqSs0Oqc+aOPtIAD9DDmDLuekJx4Ahv0emwgXuaKsJKa8s1zLHIPbCHlKZCTRCDx1E36vOEzkP1SvasIYrYhRo6N3UgKEfHI1UhAuGvlgnlrsnsm9DnSTctAg6rsd2laM5MoSMAXlYP/1cywZuTxHwgXstwCigr5QLJ0fBLhjeC/iAPQ+8tk08P1cgSFaO723e11bJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB6850.apcprd03.prod.outlook.com (2603:1096:101:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 03:07:01 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8901.024; Thu, 17 Jul 2025
 03:07:01 +0000
Message-ID: <851350ce-b1fa-4bf9-ac81-b926215acf65@amlogic.com>
Date: Thu, 17 Jul 2025 11:06:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
Content-Language: en-US
To: Da Xue <da@lessconfused.com>
Cc: Mark Brown <broonie@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
 <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
 <3ac88119-9980-42df-9e1c-c0ec30bbaadd@sirena.org.uk>
 <55ecc836-7fed-44d5-aa4b-94bc17894ef0@amlogic.com>
 <aG0hU5nbjLjTWS6p@finisterre.sirena.org.uk>
 <03b7abe4-95d5-44f4-96ec-989c736e58b0@amlogic.com>
 <b42995ed-d1d5-4624-88ab-4ba1b6f54ebe@amlogic.com>
 <CACdvmAizF9OcdBi=Qw38NH+YHT=4edQzJGuQNvxm+m5xqZE0nQ@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CACdvmAizF9OcdBi=Qw38NH+YHT=4edQzJGuQNvxm+m5xqZE0nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0d3032-783a-4d07-0893-08ddc4deffb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blJKSGhTZ2t1aU1DcHFsN1dvc3lYS09PNTlwZURxelZ1WDBYc1BDMitXMXIx?=
 =?utf-8?B?bkdRRWxCdHU3Z1VpRlVPMkUzQlllNVZJRnF6ZDAyakJROXVTUnl2d0szYmRT?=
 =?utf-8?B?MWVDN2h5SzRnYlM4amlzQzR5U3dKTVRNc3hROTF1bUt0WlZnRzE3NUtMNzVN?=
 =?utf-8?B?eDVqc3RQb2xQOUlmVW5nTzQ2STF6dUFYRy8yVWZJZTg3NDB5eTFSMElxQlpx?=
 =?utf-8?B?aUY3enZPNDA3TS9PdUo4SWRGWE5BT3ZRUjc5ZG1ROTVSUTRGLytMR3NEbFpo?=
 =?utf-8?B?WVdKNUFqZEI1MkJhUmxhM1dCN3NQZFdvREJXWlFSaVgrVG9wNzJlVFdYUFFh?=
 =?utf-8?B?T0xZWmwvc1hQYytsa3FQSXJDWG1JTlFNdDB4cDN6WUptS3F6MHZtZVR6OEVt?=
 =?utf-8?B?N2ZmcEFFUEo0NEVyNmVORW93YUFGdDZaWjhkbXl5V2FsMjB0d2Z0ZkdRYUVN?=
 =?utf-8?B?UExyeUVHT3BITjFnTUx4QWNxTXF3ajVidm1YdjRVa1VjMVRITXhlc1h5bHlE?=
 =?utf-8?B?Wm5UKy9vTkNkT0dScHU2dHczMXpPdDJ2KzlEaHA1L3F1ZHhLL3B3c2hPRXl0?=
 =?utf-8?B?bW5QUTJVZmhscFMwaWR6bnk1UDk2ODd3OEFGa015KzVobmtPZUZiSTFra1ZW?=
 =?utf-8?B?NGYrcDRROHJRd090bUlXcmZQSFQ2VFVicHVZNEZtRmRlUmx6akxCdlY2Z3Fm?=
 =?utf-8?B?d0JQRUdJN3RVQmNIY0s1Y2RFWjhZb2ZYdzk5M3BCZHR6b0ExQ0diOHJpMUcx?=
 =?utf-8?B?K0VBY2RTM09uRGxUTDhlOU9mTkJTbnE4UmNidkw4Slg5OXgxMys1T2dGN21M?=
 =?utf-8?B?VEJ4cHNRQVZLblMrbWFaYkdHSFhRNGd4TzNkSE9WVFlLOFgyRGFmQ2NURTEx?=
 =?utf-8?B?QmRUM0FCVEdXU05KNTlnVXV5dEtMQUxzdWRYTytpajBDbEtDSVFPZkpySXVQ?=
 =?utf-8?B?NjJXWVlBVWZKNGFUZXFZemlJbHFraDlmWXE1UTE0OFVJa2hBdnNMWEpoQXho?=
 =?utf-8?B?TWd2cjI5ZFpXaC92cUhGVkxFVFBLY1FUdytTRU1DUDNXUDFGRDlCNHVwNTBJ?=
 =?utf-8?B?NGlEVkw3V3NKZWVvTFVSL1JoeWc1ZmI0RHBrSzd3ZDRpYk9zYU1jdVdEa0l2?=
 =?utf-8?B?QnJTWGIyMnZjVVNXL3YvUzkxR0Z6Qm1MZE1mWGErWE03WG53MGxQTWgwMTh4?=
 =?utf-8?B?YVBsR3V4L21keWVraC9vV2tVcklFbmJpa3AyU09YcVhibGZIVXZUM0FsU3J0?=
 =?utf-8?B?d1RTODJFOTQ4R1NhaVBjc0hicXdlS2JYUjE4Uk9pb1YzclZzNXJ2SklTaVFU?=
 =?utf-8?B?NkI5OGowcmdjMlRoWE9RNkh5bkJJVFhHMEVaaHhxOStsZHFHVVdmRzFhVjRp?=
 =?utf-8?B?dVhwUytPeks3emZoYmxySWdCMGFiRXE3MDVuY1hPeXF2VVRyZDdBTXByck9D?=
 =?utf-8?B?K3RDZElTVUVBZDJnbTk1R1dFL29idU8yaTNuQ21VeWRrSExBWXU2eHNvL01U?=
 =?utf-8?B?R2JvM1lCcGRNQXFIRXlLZ3VDajRuWk0rMk9qams2TmJpTGNxMkRQbTRoRG5Z?=
 =?utf-8?B?RnhLcFJMUnZIZTk4V2k5c0JmK1V5dUh4WENLVUVlN0xCalU2RUlzTWdiSm90?=
 =?utf-8?B?Z0liY2N3elk3SkNkckJHR1M2UUlueTZMOHJ3Wk9iV2hiSVh4TU1vbTZkNHJK?=
 =?utf-8?B?NFV5WjZpbDRNWldrdVZuWUliQVRuZlJTWmRSaGRlaDVSOEttdGdaOWtienJC?=
 =?utf-8?B?OU5iTlNabERONkEyUTd2UVkwK21NUjhrekxJZThGclFhK3YwNnpZUjQ4MlND?=
 =?utf-8?B?UVVLQUkxWk44dDVwWG5tSzMyUUpDZ21QNzRjcCtkUkNmbk9MaXpCb1lNQkdi?=
 =?utf-8?B?N01pS0J0Nys0ck8vTzJ1UGVDaGt3QVAxRVB5d2FvaHhJRHYwdFhVTHN6S0t5?=
 =?utf-8?Q?KMuPqmDikKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUlDN082d3NQMC9keG9RYisxS1BhVE1oWHQ4VnVPZERGTkFqV0JUOThGV0Vt?=
 =?utf-8?B?SHFTcGZheGRUcEhhMk9UTVNzL2UwM3dVRzhiOVVpZDhrZ1RqWXVEcElDTGhx?=
 =?utf-8?B?V1pROWJNdjliNFZKc2Y3R29rV3BYVFRVTW9BaXA2cGlTRm1aNFhlSTRpdUZH?=
 =?utf-8?B?USsvKy9xcXNJMHNhTktVMERXQ3ROKytaSEZlTVNVMlZ6b21HRnFUNUs3UEh5?=
 =?utf-8?B?NEdhK2U3SlN1b1krMTZTcXB1YXNxK1MvUXB4bldReVNiM080c2ZpQTRXUms2?=
 =?utf-8?B?WnNaU1BFTkt4VVIrQ3B6MXJYU1VDUW9na08weUV6aE9TS1MyOGxvQ0ZmQTFO?=
 =?utf-8?B?WmdrRTFmd3d0akZxeDBPR1JHd2hUdlJZOXZjYkZKL2hpR0RYQzlTVnNFc2xB?=
 =?utf-8?B?L1lDSnExYlZMRThJMkJpNHBxcDlDckFldE02OFF6NWlpaWhmblRXT2xXei9W?=
 =?utf-8?B?S0N4OSttS0tSTXZBYVVNNkcyVU5ZdGZXaTd6RVlwaUVYSk82aTBBMjF1WTBV?=
 =?utf-8?B?QU5pdHJxYnhhakVFbHdJVnZkaTY1VyszQTJFblFyQlYreDlYZyt5cVFEVVcv?=
 =?utf-8?B?SDFPZGdhVGxSSHFSUUNvU3NITmZqVDNMeWsrSUN3d1hZK2pZZzRRVjNCenh2?=
 =?utf-8?B?eWNISWFIcUxmY05ybDI0cnR6U1EyeUlZcTFWQkFZeWphcjd5OThjeTFUdnVa?=
 =?utf-8?B?OUNsRGNSeUcrVzhyMzR6OUVlb2JubStvT2lITUNub1Y5aDcwRlErOXVXMDNE?=
 =?utf-8?B?QzZ5TllEaGRrc2k4SWVhd3VNRitnVkM2VWlvRDhlUmh5ekdnRTIxS1Bxc1Jl?=
 =?utf-8?B?d0ZBTUJXcnI3NUZWc2w1QmYvMU9HdmtRbFZPUytnNDR1Um9hTlA1Wm1oczBz?=
 =?utf-8?B?ZlRUUEc0cGFreFNobitFc0pnbkRCODdjTUZvNXhFUmt5Y3crQjlCZ0dzUFB3?=
 =?utf-8?B?dVhOZEZRd2ZPK0w0bENFcWl1QXpuZVFlMU1BZjRlZFBheWhJa2JnTE01clpV?=
 =?utf-8?B?VFoyYlJMZWxUZmxjVXRWeEVnZFpsY21tTkZRWG5YV25rMEZWbTB5ZjhsQUc1?=
 =?utf-8?B?MThncEhRUEIrNzdlbTBVSVU5VFpESHlzOEowVlJjMjNwZWc4U21VVW9mTTZx?=
 =?utf-8?B?ZDM3NVdaTm9pTHJEQzIrT1c5WjhCNXdSOUpzQ2p1SVhmTDRiU0xKZVhYMHht?=
 =?utf-8?B?aHQ1bVNUbkJ5SnQ3NTdvRUdrL2tXWm9pNXg2WkpVWldmS2hvejJrUXpteUp5?=
 =?utf-8?B?ZVlSUkV5ZEtSaW1EaS9DSFFRUExzQTJtN2JDeUMxb0w4eG1vRDA3T2x1Tllz?=
 =?utf-8?B?SmFXQ210ZzAwSVF6ZkJ0MVlETVdPZHczREM4RzR5Y0JvUkF0cGU3SlF5Tkxw?=
 =?utf-8?B?UWZDTWNvU21zbDI3ZGpGQ1FqZHArK2dmcmo1SGpGNHV5SmVnOUtLbURlUkdU?=
 =?utf-8?B?cFBjRXY1VytlUklJaW9YYVNBSWRvNTIwWHBjWGNVdi9MYmlwUWQwU3d4L0RE?=
 =?utf-8?B?a3p2OHBXbE4wSWE1aVk5UnJTTTdpRm1MNWg2UTRJcy96dngwZE9XbURVSmxq?=
 =?utf-8?B?T1VpS29XMWo1K01IRGk3SEdyM3VLNzg4U0RDZlN2cjlHZTV4ZlNqK3h6dTZl?=
 =?utf-8?B?NS96ZjR6VWZWR2hObm9aK25DREdjeWdFVlM0N1QrZUs2QUlhNitFc2RQYW1v?=
 =?utf-8?B?c2s4amVaY1NzaHB1MkZjY2pYN3pVS0VSZys1QU9UT3ZZMFhxbk5MZEVRNXFZ?=
 =?utf-8?B?b3B0UmpLeUIwYXl3SGhTVDhQbWphTFNtZ2QyeVFPZHM5THlWdlBjVXNSUVIv?=
 =?utf-8?B?bWdBNFVVVHVXTHZkUEtPSG82UXN5ME1XSjlURDFQU2FQYnpXeWxMV3g5bG1Z?=
 =?utf-8?B?K3pkTnZZeXdCN1RMN2hVcjUxbWxXT1JIUTNxeGxlVEJ0cTZJZ0dTWWRNRTB5?=
 =?utf-8?B?Q3plb1V4Y0tJZnZ4TFNBNDVMWmgyNkdXYjE1MmR3SVNFS2JmZGZDUm5zNS9J?=
 =?utf-8?B?WlY0UGJMcW53dWNEWkRaTmc1U0ZjRjhkbmp4V1JUMXl1Nnhrem9iL3p5bnFn?=
 =?utf-8?B?MGZydTEvaHdwRWZrWnZvK253eTV5OENwMGloOEM1bjVnTUNraDFiQXkxZFpj?=
 =?utf-8?B?OUVpVmlkRHZaWU1nMFhCclplcWxjZDVXQjF3d0FxeFh6eXREMVF2a3NUNzIv?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0d3032-783a-4d07-0893-08ddc4deffb2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 03:07:01.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr1XA5JK9TwpBpgnytuWBZtMSFpraselCRKAgi4gO2gijDpUYg5wT2xoMGCNgPn6L9ytG+Akvhs3qBgjSGqis7wvD6W+asse9m3y2AGxjj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6850



On 2025/7/17 00:25, Da Xue wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed, Jul 16, 2025 at 5:30 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>>
>> Hi Mark,
>>
>> On 2025/7/9 15:02, Xianwei Zhao wrote:
>>> Hi Mark,
>>>      Thanks for your advice.
>>>
>>> On 2025/7/8 21:50, Mark Brown wrote:
>>>> Subject:
>>>> Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
>>>> From:
>>>> Mark Brown <broonie@kernel.org>
>>>> Date:
>>>> 2025/7/8 21:50
>>>>
>>>> To:
>>>> Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>> CC:
>>>> Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
>>>> Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
>>>> <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org,
>>>> linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
>>>> linux-kernel@vger.kernel.org
>>>>
>>>>
>>>>
>>>> On Tue, Jul 08, 2025 at 06:34:02PM +0800, Xianwei Zhao wrote:
>>>>> On 2025/7/7 21:05, Mark Brown wrote:
>>>>>> Is it worth having a copybreak such that smaller transfers are done
>>>>>> using PIO?  With a lot of controllers that increases performance due to
>>>>>> the extra overhead of setting up DMA, talking to the DMA and interrupt
>>>>>> controllers can be as expensive as directly accessing the FIFOs.
>>>>> If the data volume of a single transfer (xfer) is small, PIO mode
>>>>> does offer
>>>>> some advantages. However, since PIO requires the CPU to wait in a
>>>>> busy loop
>>>>> for the transfer to complete, it continuously occupies CPU resources.
>>>>> As a
>>>>> result, its advantages are not particularly significant.
>>>> The CPU overhead tends to be higher (you can avoid some of it with a
>>>> dead reckoning sleep), but the latency vastly improved which for many
>>>> applications is a worthwhile advantage.  It tends to be things like
>>>> accesses to one or two registers on a device with registers where this
>>>> wins, 16 bytes or lower would be a common number off the top of my head.
>>>>
>>>>> If PIO is to be implemented, it can only handle one transfer at a
>>>>> time (via
>>>>> transfer_one), and not entire messages (which consist of multiple
>>>>> transfers). In contrast, when processing messages, the SPI controller
>>>>> can
>>>>> handle the entire sequence in one go, which also provides certain
>>>>> benefits.
>>>> It's probably worth adding something to the framework to be able to take
>>>> a decision at the message level, for writes this tends to all fall out
>>>> naturally since the write will tend to be a single transfer anyway.
>>>
>>> I will try to add new API message_can_dma for framework, and implement
>>> PIO for message.
>>>
>>
>> I tried to implement PIO mode in the driver, but it turned out to be too
>> slow. Due to the lack of an internal FIFO, data could only be
>> transmitted one word at a time, and each transmission required
>> reconfiguring the corresponding registers. As a result, the efficiency
>> was quite low.
> 
> One of the use cases is for SPI-based displays and it transfers one
> word via PIO and then a lot of words via DMA. I see PIO as beneficial
> for this common use case for SPI.
> The efficiency does not need to be high for this one word but reducing
> the latency for DMA setup is a significant gain.
> 

For the new SPISG driver, regardless of the mode(PIO, DMA(MEM or sg), 
the configuration registers are the same; the only difference value  in 
the mode selection. see reg cfg_start.

>>
>> The only simplifications provided by PIO mode were in two areas:
>>
>> 1. The allocation and release of the transfer descriptor
>> 2. The DMA mapping and unmapping process
>>
>> Therefore, I suggest not implementing PIO mode in this driver. I will
>> document clearly in the code that PIO mode is not supported and explain
>> the reasons behind this decision.
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic


Return-Path: <linux-spi+bounces-2772-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E78BF7FB
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C264B20D76
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339542E62B;
	Wed,  8 May 2024 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qofIE7br"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACC4500B;
	Wed,  8 May 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155499; cv=fail; b=T5mq47qcGff5qxgsQu+URA6vA8VGZyA+J3CyNiOLY0WtMiyf3cwVdIFmp2bo9jRVm5xbrecNwTt5io9gaxFqUaLQqOUh1vXd3TwmDvT2Vjdvioc+oqLP1kgIHGtEsm2NQwqYZqLFfCNtfSDaVjaiMPFt8i7N6EOSoXruDfMkZbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155499; c=relaxed/simple;
	bh=3RTdHXaVfpT3waTXvd68MCym1ghp4qE/8gRbalj6JX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XIsRbiuHHeSgxiG4b4Se2rlBRo4GUQChfnEGbrovjSBpWaoawRuRg5VfQpMlVm+RPsUCKy6R8JgOFzTVqlWKES2tjRkTjMDjo7BXXHbpCZ5zdsUuveb5zwZYdCdiC+NAmj5gv616op7PsXxL86358QG6xIAonGKa1D86FgTKXJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qofIE7br; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4484nVVJ002050;
	Wed, 8 May 2024 01:04:52 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xysfmjf5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 01:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGIFYIK6WQ7GADh0hWCmuW47Q4Pk9ZPxyEL95BHZKkL9nl7zEb383Odv8YvkiISefuLnEXB9lkfOpU38dPolMqPxFVURiX6KR+57zcIWT+aNfwn9cuf3ZaeHLCI17y6PJawbTbcl/ooQtQ6Kht8eVPnJgOKKxbXcyAxgiIBzyrgfIk6SNeNMW5+uv8hH5/34klFXUQfCMCypMDzCxixcVamkcgWTrFQ8UA78d3k8MBaKZZLprGF7rdbToyTULwXASi1zQ4si66ze4cHEwt7VwznbxN+HSPrYiNA9HGIlu6sI+CkKC37t1zidUgVFgeI6ufgZ+q1KeQOnA+yLUF+fGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RTdHXaVfpT3waTXvd68MCym1ghp4qE/8gRbalj6JX0=;
 b=DdRglP5A+/1CNDsNufYvjUcaQzo9RycN/6DdR0GMPTECQQ/zQMSD9LGzO5tNLe1l82iH3cRxmEzr2mUR7AtuA9AoOs0YqS3Efz2W5ftZ4RwBBMZDJs2ZV3MnQIfLDLA+mL9ttUhpHTZb8l9mmtiWp7SH68iyQb4phXbwJBAVvcwYErc3N5j/dXwCPEe0BNpghmf+SJHI53FmKDJhuxNfTzHViCG7wvlYNVY13Cm+pngTZw+CIijmQu5dHPpvUbgrSh/sZXaS7YSUGHAhvKV5Omj/1jH2vii3fVnYRXDCTf95pJsmrCSmTZdduw/h1d9MjwNdZxc+fz8LiKbMYKsyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RTdHXaVfpT3waTXvd68MCym1ghp4qE/8gRbalj6JX0=;
 b=qofIE7bre8r5WzbC3192CVFetEo8YekJ1aTRBuuvfCQb1L+6+Fa0M9H8XpqiGU6zGlhGy4J8WRrGyv9ViYlu2ZQ87Zvm1Xoq1RS7hMcIAeLgq+vy8rMG04wLq6nYiqljTH7lneLW3YurCl9EjpBUpw3PSwhSr8g30lIJmqXo8WI=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 CH3PR18MB5700.namprd18.prod.outlook.com (2603:10b6:610:1b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 08:04:49 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:04:49 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>,
        Piyush
 Malgujar <pmalgujar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Index: AQHakS3IEG1hJ0bMHU6EYeq4uC1r/rFuT7AAgBEONvCAASjLAIAMkjUw
Date: Wed, 8 May 2024 08:04:49 +0000
Message-ID: 
 <CO6PR18MB40988BB723DB7576F5C25155B0E52@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-5-wsadowski@marvell.com>
 <16a4a58c-cae6-4b62-859b-3661c052468a@linaro.org>
 <CO6PR18MB40989F97F92C9A37C6BA896DB01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
 <2dc18bdd-0c82-47a2-b87d-b69028f3b251@linaro.org>
In-Reply-To: <2dc18bdd-0c82-47a2-b87d-b69028f3b251@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|CH3PR18MB5700:EE_
x-ms-office365-filtering-correlation-id: d142f877-f15e-4935-53c8-08dc6f3588ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aVBmRHZGVDRZbXBDbHdvbTE1Q1FJMjE0ZC9GaThoc0tseTFPNy9wcU1PNUQ0?=
 =?utf-8?B?MWoxbU1hc1o2UGZqSzBhSnB4ZTJPVWZpYmFHSm5wWGM5dlRLeTJHYXhNZTlr?=
 =?utf-8?B?V0xEbTVlQ1ZUdFRNaG1FY2Vhc0pGMkx0UE96em5XSlFHTnJNTEh1Y0VPL2J2?=
 =?utf-8?B?WE8zMU9ZeTI1MGJKWVRlSjlKOFZRREgwbWhEYkc5bnY0dFRlM09QNUg3dVhH?=
 =?utf-8?B?UGdRUXF6QjRyWGtmVTV5UW8xb29SNVdGcUpyRVA1K2JHcGZRLzBRN3RFbDZR?=
 =?utf-8?B?MWlGRFlFR1ZZd3FTaXpIQW5ycHhabDBMdUFLbS9EOWc3UksvY3plWFZiWlBM?=
 =?utf-8?B?VkI3U0hHbXdjNkNWSllScXBKbThBNlp0NUx2Zldidm9lQW94STVUNlZlaFor?=
 =?utf-8?B?dnU2Rk9Rd1Q2TjlXTUNPU1A1eHhIV2JhVjZIVDZZUDFadlFtTC9lUmV3RmtY?=
 =?utf-8?B?bmZpckdDWDMvNXkwWUlUNDcwRVVqN21yUlA0ZWhOU0txNFJXUW9YNEhoMm5U?=
 =?utf-8?B?NGk4SjJOaEJ2WEZHQm5IbFhKM1F1VkJjWjNST29oSkhzRm9scGxxUmlsMURG?=
 =?utf-8?B?RGpRMkRzK2l1cEhiTEVMNnIxb2lCaUhQblNNNGoxa2VWdTNqSlNoL01haDlk?=
 =?utf-8?B?aWYxSEtFTGFzcUEyRDVzN2hSQ2lDVjVhYzNIQTJMTVdCc0xSQ2JuUFhvSUpW?=
 =?utf-8?B?N0NyQ2tKVkNDN0lhQllZaEhjbi9hSnNOajFhcXY4N0FETytYOThXYnhTZmll?=
 =?utf-8?B?N3pvdy9kSlJDNTNwWnVUZ2twS2RMclBWT21rbWd0VjJMWnJSRFljMUIzQ0RH?=
 =?utf-8?B?WnVVUFFyb1ZaQUZyNVhaU2lUU1QrZWNMZjFCa0owL21IUWFCNGl4cXlUaSsz?=
 =?utf-8?B?d24vQm0yWFpQcEhVNEpLRUpLcjNJKytXQVdRSE93T3kvWXNrM0lvMmpYY3lo?=
 =?utf-8?B?ZElNWU9NYUt1Y0xFdCsxbTFRMTN3aVZWWHZXTXhsd0REUkNqNDNTSnFZT3U0?=
 =?utf-8?B?N1F2dk9rTS9JMzlGaW1zcVdvZVo0SkhVVzFNWUJHYWtEVFYvR2FybHVGUG1x?=
 =?utf-8?B?M05pL29DMTg4VEJiRGJ0bE81S2FKWnZTa0xVSEVQZ3IySXZEcjZnY3BNSUVX?=
 =?utf-8?B?MTIvSlJqN0hPK00rcWVVazhSU0VrbEtXanJCbHRJcHJpSUZOT1UyNmZ4eG1B?=
 =?utf-8?B?cmFWZ0pEcnVJWjVFYkRIeWZuemFNMDZzWEF1bG5ydFB4MzlocFNoUjd5eFFS?=
 =?utf-8?B?Wk1JN1U4VWhrdnRNKzluVTdpOTAxbkxONXpJN0Z1NjBmS0h6QnZFakg4U3RZ?=
 =?utf-8?B?OHVrUW92VHArZ3ZZM1pDQlRGMUloY1pCSzk1bzJqKzcrd0dIRjk1NDZPbUFt?=
 =?utf-8?B?MlJhRGpoSUxjazFGUWJxWkp3UHRGbHVGMTJpWGcxaG4rcU9KbUdRSFMvNnFI?=
 =?utf-8?B?Mkx4T0lUODE3MVZUUk0yTUw4T1ZIaFZVVllpMmpTTVNCY0IyV2VqeXp5b1Az?=
 =?utf-8?B?ZkF0Y2g4ZzJIYmJvY1RJZjhPOW5INFpmeVVIZ2xPbmVxd1ZyQ1ZESzhZcThH?=
 =?utf-8?B?SE4ydDcwTThrelQ1WG5RQjdqOU1sMGIvRjl6Z0FYaWQxdjFDVDVaejg2TFBz?=
 =?utf-8?B?cmptZzdWTm1OV3F0b21SZkU3VmMyWlg4Wk95cVhLa3FQNllEdVFCUXlydzda?=
 =?utf-8?B?WU5nYkRGYmNGcEpoR1VrUVhOWlhyQk8wY0xWa2c0Nlh2VWNUN2hSS2RNK2gr?=
 =?utf-8?B?c1RxbEFxcm9WL3dQQXU0RzNucTZvTEVwRm9JRk1tNzJjYnkzVExsTXZVMkZG?=
 =?utf-8?B?cWt0MlhGNSs5QXFPbHZjUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZWVNdzB3SExBZHhRUi9TcEk4RFhhY3VLN1IraGNIeEo4ZkxHSkU0dzhxUXpx?=
 =?utf-8?B?NmdIcnNyeWZOblVyb2ovcU5WUzVUVjg3UDRKMnZBTDZndElPL2Q4OG1SNlY1?=
 =?utf-8?B?U0JOUnNTdWt5MEcwYWpwNUNRYWhaMllRWGYveWNZWkg3M0VpNHA1QUErQkpX?=
 =?utf-8?B?bmpJdmNZTk8rdDZ6ck4wYXRFOVljOUJYYk03dVVYZU9Va095bkIrMmpYb2N6?=
 =?utf-8?B?M0x4QU94ZGhXSzJpQ1JjbXRKbWxKWnlXN1JXcXcwMEZrUU91VXZ6K2FUcEFI?=
 =?utf-8?B?K29wWm0xUk80VXBvR1F5ZU55NXNHdVFIY3k0Q1JZT0lkdEdaVVRRcjY0SGd3?=
 =?utf-8?B?M1o2QXFsbTlwakUxc2lPNmoyekRBczlqUm4rWW1vWEFVbC9PMTFOZTQyMFRr?=
 =?utf-8?B?OWtsS0g5MjhjeDZ1bmRlZHprR0U4L1IrenVXQlF4aDdWc29NK1hvY1hMbWtk?=
 =?utf-8?B?QnlHS1htQ1pPSVZzQXlJdkFtODZPTGRMTEVsK3ZtZ1VCMUV3UTcwOUdQVVFV?=
 =?utf-8?B?UmJPa2l0UG9HdE9yMVpRdWxZOVRmQ0h4RFBlL2ExWjhPS3BKTkRVeXNtaDV6?=
 =?utf-8?B?cFBkSXhBdFBKOGFlK1ppZlVYdXVUMENWVkI2WjlNN25uQTZ1MHZHbkZVUUhD?=
 =?utf-8?B?cEthbE82NEs5bTgyZTI3OUF6YmNSaFBuWktjN042VFRXeGdNcGllWXYrR2ps?=
 =?utf-8?B?MU5PVUZmOWdpVnBmMUlFTHZtcVZMdkhJSDg1NEtXNlY2VFE5QTRnYjBjeTEy?=
 =?utf-8?B?aURyNVBGTk81aGdkN1FmOFdZV0JQRXlwbFJ3a01TaWU3WE5QbFJHSnI2c05h?=
 =?utf-8?B?eUY3ZTYwK2tsWk1HbUZjUDg2aFBvTUd1YlE0cjFpNnBQY3d4cXdqMmZyUUhi?=
 =?utf-8?B?OTlHaXN3NDJGOHloWGJMaGlhUEhiMyt1ZmJZUVFrK0lMSVpFUmhlT1lDNEl5?=
 =?utf-8?B?OWUvNnpFYnVjWHpCSFNlL1VrdzZrVERKMmpmeGVhdVo5K0FMTUVqWU5sb2hX?=
 =?utf-8?B?bWU3SmlCdU5tdmtFZkYxd0RhS3dNb01MSWxuODJwMXFFdU13OWJsV2FLVmxu?=
 =?utf-8?B?cjFwbnJJd29yYVFFU1NRU2xGWnBlRGZrTFpzZ3RJcmMvcHN1dUdkNUxQU0Nq?=
 =?utf-8?B?VFFrTVNOYThwRnd6NTFWem9mTFJqZUhFN3lHNEh4Q0xSYjE0UERwOWM1OXNP?=
 =?utf-8?B?TFRPc2hSTjZ2a093ek02Z0xYd2xEQlcwNExLcU1CdHZ5dmFvL2x5MDhRY3hQ?=
 =?utf-8?B?MWQ4SmRGa25scm02U3h6L0F2bkQramJVNHBVMlI1UFpka0xEWXpDakE1M1Nw?=
 =?utf-8?B?ZHM4SzhUZ0NXMkU3cys4Qi8yR1R0Q1A1a0p0TC92OFBsTjVsbFNNVWhFQjhu?=
 =?utf-8?B?TDQxL0ZlSlk4dnhsMENWRWhsU2lCMEFSUVN6VUMwb2FPOGlZTlpuaU5BczdB?=
 =?utf-8?B?aDI0VzhZY3VhcERiUktOaXpVNG90Qklhcnp3eCtuaVNpbDFFajdRa1BnNnho?=
 =?utf-8?B?T1RaYkRiaFFHODNDT0w3WmtNdkVIYkpiRS9LSWxJandieXl0cVZlUm9Jc2pm?=
 =?utf-8?B?NEdqVlB3bFY1dC9kSFlyL1RMbTVDWjBETEVHM2RFM2hhMHVpQnd0WlVvS3ln?=
 =?utf-8?B?WW5XUlBwdjZCMzlXTDVwTXFlNEVxbEUrYStFOFBiUXhEVFBEeG9PVUFPb0gv?=
 =?utf-8?B?T01sdDdCQWh0aUZlY1JvNFI1OW5qZG10L01YSTVzRHF2bVBWUUQ1NEdDNVkx?=
 =?utf-8?B?bWhYODJTNC80dkVsVTY2dG9RWldIc2hnQWdJMzVOTXEvZXYzQ1kxN2JoWDlD?=
 =?utf-8?B?WUZ5T3h5dGhhYjNveDNRM1l2UUptL1lDMzhqNHJTS1Z2WHlZL1N6YnhCNkhN?=
 =?utf-8?B?TlRYRlZZREpLNVgxcFVmZVE5V08wY29HNzJKYnVzcFFLSjRReXJObVV5OGhX?=
 =?utf-8?B?VmlNa0hLN0V6SzhrVEZaYjlxUTBPQWloMHhvcEhkYXh3eXBNRGwrbmRPdFgy?=
 =?utf-8?B?aVU3TGNYakJBTkVkODZueENDSnVPQjRZaks5SVNTQXBEaG1PR09KbUVrTmpS?=
 =?utf-8?B?alJrT2F0N0Y2dGJ6YmJMVGFBZVIwNjgyQmxTRmY5eTY3aGFTZmFyeE5nejE3?=
 =?utf-8?Q?JED9d+JX9LeapgMxCLJR/GqmK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d142f877-f15e-4935-53c8-08dc6f3588ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 08:04:49.6380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlcWbX2SWMK+cp6tm8yhG3Qenpnvr+P/+fbaRbZ/BribPM4BOJGIO/VTPOZQrhFQL62U5l/Q/cPLJW13BQXTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5700
X-Proofpoint-GUID: kkeH0b5oWKgrOwGSbBoz3thgaFM3Mom_
X-Proofpoint-ORIG-GUID: kkeH0b5oWKgrOwGSbBoz3thgaFM3Mom_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_04,2024-05-08_01,2023-05-22_02

ID4gT24gMjkvMDQvMjAyNCAxNjozMCwgV2l0b2xkIFNhZG93c2tpIHdyb3RlOg0KPiA+Pj4NCj4g
Pj4+ICsjaWZkZWYgQ09ORklHX0FDUEkNCj4gPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlf
ZGV2aWNlX2lkIGNkbnNfeHNwaV9hY3BpX21hdGNoW10gPSB7DQo+ID4+PiArCXsNCj4gPj4+ICsJ
CS5pZCA9ICJjZG5zLHhzcGktbm9yIiwNCj4gPj4+ICsJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxf
dWxvbmdfdCkgJmNkbnNfZHJpdmVyX2RhdGEsDQo+ID4+PiArCX0sDQo+ID4+PiArCXsNCj4gPj4+
ICsJCS5pZCA9ICJtcnZsLHhzcGktbm9yIiwNCj4gPj4+ICsJCS5kcml2ZXJfZGF0YSA9IChrZXJu
ZWxfdWxvbmdfdCkgJm1ydmxfZHJpdmVyX2RhdGEsDQo+ID4+DQo+ID4+IFVFRkkgcHJvdmlkZXMg
Y29tcGF0aWJsZXMgZm9yIEFDUEk/IEkgdGhpbmsgdGhhdCdzIGZpcnN0IHN1Y2ggZm9ybWF0DQo+
ID4+IGluIHRoZSBrZXJuZWwuDQo+ID4NCj4gPiBZZXMsIHRoYXQgY29kZSBpcyBub3QgZG9pbmcg
d2hhdCB3YXMgZXhwZWN0ZWQuDQo+ID4gQ3VycmVudCB1c2FnZSBzY2VuYXJpbyBpbiBBQ1BJIG1v
ZGUgaXM6DQo+ID4geFNQSSBibG9jayB3aXRoIEhJRCBQUlAwMDAxLCBhbmQgYWRkaXRpb25hbCBj
b21wYXRpYmxlIHBhY2thZ2Ugc2V0IHRvDQo+ID4gY29ycmVjdCBjb21wYXRpYmxlIHN0cmluZyBX
aXRoIHRoYXQgYXBwcm9hY2ggb25seSBpc3N1ZShpbiBBQ1BJIG1vZGUpDQo+ID4gaXMgd2l0aCBt
YXRjaGluZyBkZXZpY2Ugd2l0aCBkYXRhIGZpZWxkIGZyb20gb2ZfZGV2aWNlX2lkLiBJdCBsb29r
cw0KPiA+IGxpa2UgdGhlcmUgYXJlIGZ1bmN0aW9ucyB0byBtYXRjaCB0aGF0IHdoZW4gRFRCIGlz
IHVzZWQsIGJ1dCBpbiBBQ1BJDQo+ID4gbW9kZSBpdCBmYWlscy4NCj4gPiBJIGJlbGlldmUgc29s
dXRpb24gaXMgdG8gdHJhdmVyc2UgZGV2LT5kcml2ZXItPm9mX21hdGNoX3RhYmxlIG1hbnVhbGx5
DQo+ID4gVG8gbWF0Y2ggZGV2aWNlIG5hbWUgd2l0aCBjb3JyZWN0IGNvbXBhdGlibGUgZGF0YSBz
dHJ1Y3R1cmUuDQo+ID4gVGhhdCB3aWxsIGJlIGluY2x1ZGVkIGluIG5leHQgcGF0Y2hzZXQuDQo+
IA0KPiBQUlAwMDAxIHNob3VsZCBiZSBoYW5kbGVkIGJ5IHJlZ3VsYXIgb2ZfZGV2aWNlX2lkIHRh
YmxlLCBvZiBjb3Vyc2UNCj4gYXNzdW1pbmcgeW91ciBrZXJuZWwgaGFzIGJ1aWxkLWluIENPTkZJ
R19PRi4NCg0KQW5kIGl0IGlzIGNvcnJlY3RseSBtYXRjaGVkIGJ5IGlkLCBidXQgZnVuY3Rpb25z
IHRvIHJldHJpZXZlIGRhdGEgZmFpbHMuDQpJJ20gcmVmZXJyaW5nIHRvIG9mX2RldmljZV9nZXRf
bWF0Y2hfZGF0YSAtIHRoZXJlIGlzIG5vIG9mIG5vZGUgaW4NCkFDUEkgY2FzZS4NCg0KSSBoYXZl
IGNvbWUgdXAgd2l0aCBzb2x1dGlvbiwgYXMgSSB3YXNuJ3QgYWJsZSB0byBmaW5kIHNpbWlsYXIg
ZnVuY3Rpb24gdGhhdA0Kd2lsbCB3b3JrIHdpdGggQUNQSSBhbmQgZHRiIG9uIHRoZSBzYW1lIHRp
bWU6DQpzdGF0aWMgY29uc3Qgdm9pZCAqIGNkbnNfeHNwaV9nZXRfZGF0YShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQp7DQoJY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2hlcyA9IGRldi0+ZHJp
dmVyLT5vZl9tYXRjaF90YWJsZTsNCg0KCWZvciAoOyBtYXRjaGVzLT5uYW1lWzBdIHx8IG1hdGNo
ZXMtPnR5cGVbMF0gfHwgbWF0Y2hlcy0+Y29tcGF0aWJsZVswXTsgDQogICAgICAgICAgICAgbWF0
Y2hlcysrKSB7DQoJCWlmIChkZXZpY2VfaXNfY29tcGF0aWJsZShkZXYsIG1hdGNoZXMtPmNvbXBh
dGlibGUpKQ0KCQkJcmV0dXJuIG1hdGNoZXMtPmRhdGE7DQoJfQ0KDQoJcmV0dXJuIE5VTEw7DQp9
DQoNCklzIHRoZXJlIGEgYmV0dGVyIHdheSB0byBoYW5kbGUgdGhhdD8NCg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KDQoNCg==


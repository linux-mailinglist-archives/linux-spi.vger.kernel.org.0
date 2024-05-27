Return-Path: <linux-spi+bounces-3094-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3D8CFB27
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DF01C208B2
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C894503C;
	Mon, 27 May 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="SpLWYWbq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E952030B;
	Mon, 27 May 2024 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798054; cv=fail; b=LgeNyKN8F2JWu/zXeS/KsIxl9c0lncu+g2V8b8IQUFNlp3uDwA6e+1LjEDfWmsVF+B3uURK6hwtX4C4yqzGPcPz7ap4FhNoQk1EPS1X+28Gda2brGDTN0NylwNnbmVGxpOtVweV27rE3k7/FJoCQXMOBaH9X3q0sVbzKQb7dxSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798054; c=relaxed/simple;
	bh=ylPO3Q7DE3/JPNlFtNHh+ZAfjEaOHLW/R3vCSZ6YpYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HZe9Z8BYfxAkzuJm3Ky+tPqrwk3Ztu3UmCG3GJGcTn1OMHNvIaTCI4byo8+0VSdrwJLy9rAwrYjEUk5xasVRCQjG4BqxaJUFvt2QvE7P4srT9g7oZsCI8rOuyGQZvpV7v2QzsNgazxM/iU6TfP3qhzeon5Y3g96JIu/W/rdq9Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=SpLWYWbq; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QLvMVV010580;
	Mon, 27 May 2024 01:20:47 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ybfgf4j2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 01:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrdbEBSWxAB4oCyU9Y7DhFiC53f2/JAP423QHnUWSf4ROcfxr6/EE1QMdSvXoEkA7q32x7uJXMYMI0TTtXA5XTgwsLDcxHEmnwda9OoVFbSifabETe/qfQJilHgbHvoy+YhX3HV7yWI2wajJ4KyLP04w9FeemPZ8lbntAGy8mUG5pxjyht9C93r1pApzMelFIVqnFBdznwKUi9wwY4vIb3kONVvpgDMtn0eEML2LoaThfeqC3Im+HyxbzCLJXD9EiN5aPzWFN1HRauo+66l7J6fqP3l4c5jvkd/3vZ6vb/YWEy5BNahijlwIxu6uvWKHNqCJc4pz8+tUgDvqrCjstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylPO3Q7DE3/JPNlFtNHh+ZAfjEaOHLW/R3vCSZ6YpYs=;
 b=QyUU4q+yywjKigZKScDbTMA9KuwfhujZKXogZXPUONOcoaxqluUfzxXqZRofIP6i1EB7PH3/PG9d/86gJayY8agVMT7XvrM+jP7d2Qt+G7xGc8nAHWBm51nP6UZ3ec5wBAHWpxkwLHwasWRGMXA3nuJrj+YUvrbsFgkGfluwli8HkYyG3aTTGBNHTYd+Q/xokq8PH4PjCrBE5/aKPTje3yVH0Rc8LDq3cgXCPzxnZ9rmDj3fJCryCdF55sCFvMzWZuWeFKNd+02RcZkB/RS8mmMjIvzeRKGSk8Xcy7rctSuEGkgg2yDRaSToYJNFAzabpQX+leol4gu6YoUWnzhaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylPO3Q7DE3/JPNlFtNHh+ZAfjEaOHLW/R3vCSZ6YpYs=;
 b=SpLWYWbqMTzGsYf8KhsnlHpPkds9dumETEoTjK1P+6wY4pxYTMNSwZEfpwF+cBZZqVvqsyVf8bP7KFQEiRnNMN3eK+iLX9u9Aq4LG+nr7WdWjtJKprWCbMbuZt62TP7Te2SwIhxrgqtVOdB4zT+74lI66iL651Vvshz8XU8bOac=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 CH4PR18MB6269.namprd18.prod.outlook.com (2603:10b6:610:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 08:20:42 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:20:42 +0000
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
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 5/5] spi: cadence: Add MRVL overlay xfer
 operation support
Thread-Topic: [EXTERNAL] Re: [PATCH v4 5/5] spi: cadence: Add MRVL overlay
 xfer operation support
Thread-Index: AQHaoa0bWjYaI1hH+U+vFkSobXQyDbGhkUgAgAlInfA=
Date: Mon, 27 May 2024 08:20:42 +0000
Message-ID: 
 <CO6PR18MB40983506FC89AA1449C407F5B0F02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-6-wsadowski@marvell.com>
 <c3421a07-3373-4dc7-aa5d-0ce0d627b330@linaro.org>
In-Reply-To: <c3421a07-3373-4dc7-aa5d-0ce0d627b330@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|CH4PR18MB6269:EE_
x-ms-office365-filtering-correlation-id: 4a8c2b1e-e3af-48f4-0041-08dc7e25e686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WHNyOElLa0xGZEQyR3h1LzRTNmxVaUdxRmovMTQ2MG1lR2d5RUx1WlRJV1BY?=
 =?utf-8?B?N0JEalU3L1lyMGhJdzc4TjdPMXFObkdoN1dNbjBxck5hajFEYitRTUMxVCta?=
 =?utf-8?B?SktrbWxRM2M3RlpMOHBOTGs0b2F1WU5QckI1TEdLeEtzVjZTcWdDazJVR0hx?=
 =?utf-8?B?ME9rOGxpYmYwcmFEcUN6UFRTdHNPaEJsMDRSMy9KZ25LS1NPMmtxTmRickdF?=
 =?utf-8?B?SW83RTRaeURYd3dTcGl6Zks3N0UrSi9yV01leU94RVRobVU0dEVXbjI3d1FS?=
 =?utf-8?B?V1dxNlgwUy9HT0JBVk14UkREbk4ycElyR1F2K1JSMjdoUVZRSVJUU1ZDa0RY?=
 =?utf-8?B?UWpzSXoxT1dIM3NKQWxON2JBTzhURTl2WjVPL3JBTlBTZ3lpL2xlZ3R2dWMz?=
 =?utf-8?B?SjVKMXRzZFdSZmR0SlVManduVFhreWQvekdpVWpxOFFQRFJlUDhVUCtmV0tP?=
 =?utf-8?B?QjZZVVBpN0lhdnI2Nmd4bWpaLzJWQ0FoZzR0TDltTEoxYXByd2JSMFdJSjJ3?=
 =?utf-8?B?NHhOb040SUN5VzVOY25ocnJJY0dkYUpZL3FBSHZyalhkK2VkenF2RlpRZ0Fw?=
 =?utf-8?B?OXZFVjRRaDN2TzZ0S2h2M2poYlRvTlBoVGxBcmtJckVnZ2JvRGVPZTd6NHQ5?=
 =?utf-8?B?UmtlM1hSaExUSzZJWEhNQjZBSG01Q0VRelExaDZDT1F3bHpMZVMxOTg0bzAw?=
 =?utf-8?B?clNUbFpsTTM0U2tLVnMxRmJpQW1zNi8wNVFneExZNnNXdllHYzU3V2ZVRlNR?=
 =?utf-8?B?a3BOV0s5dmpSOFQxRDF4NFk2YXJiUDdhbFdLU0Z4M3I0bVVvV0RHeUhqY3dr?=
 =?utf-8?B?OXhyMmNhME1zVXNCV1V3Z0ZOekNPMU1tTVJ0NnV3TmErZjNENXNEeDM5aEVH?=
 =?utf-8?B?Z0R0L3oxRHBvdk5YRHpRSDFPMFVlZ25zWWdrTlNyOUw5N3NKdFpVZHFYRGFP?=
 =?utf-8?B?SGtrTnl4TkZkNWQyb0czT1hFZUZybkRTRlVZOVpkNHlOdnh2MjhmVXhydnd5?=
 =?utf-8?B?emRZcUJNNXZaQzdCREU4dkVvNnBLcTdRSjU4bXJBNUczem5HQTlDMzJKREhQ?=
 =?utf-8?B?UVN0YWVlZWJSNEpDNDhoUU8zTE1BZkpaemsrTkZiVU4zUXZqQ0ZpNitwNVQr?=
 =?utf-8?B?UFh3SjVwSGIrNzd5dVhUQ2RHalZvRitxakxyeUNYVmd4VUZLYW1ZcnYwTnU2?=
 =?utf-8?B?RmVKQlZNNk93bVR5d085aDF3N2lKajBobVRRRzZoYXovMkhCeFRzWHdlMFNN?=
 =?utf-8?B?bVRjQXVJN0lBOWJCKzhoMk5sUDU5WHdQWmFZSWZoRTNVSUZrbkNEb081aFUr?=
 =?utf-8?B?c3hIaWVIUjF1T3R4MEQxZkZKenZBbjd4Wm11Q1RrUHdwelgvZDMxNUtKVXNr?=
 =?utf-8?B?MkpUdHBBOWVmcFVOT2tnMXpVMFk0UHRFZDV3US8va3BwZ0tWY2NOWVRCODVw?=
 =?utf-8?B?RGFuVld6QjFraHNUNElORnFyQys2WUdQRm9TNVRDSzdrRUNPa3VDWFY1cW9q?=
 =?utf-8?B?WjRKbHJvNGhJd1Q1NHlmQ0M2Z2xQbUE2R3Y1ZzFJWkhXVzUwWTZGOUg3aXFL?=
 =?utf-8?B?OHJqRzRhUE9KRytGOHBFQzF5Y3daYlZLU1plL2xiM3VWRFNUcWd0SHQyNE9K?=
 =?utf-8?B?TGZGQU4xSmxKYXFSYzNiYVltazhsV3pmSDdVWG5COVlzK1VQVzltdTVTQ3pP?=
 =?utf-8?B?ZmpKYm5PSmppVklQR3hKcEdTUmludzJpM0tVbTdaWnBWUHMrby9ZZFlTQzNz?=
 =?utf-8?B?eW12UE1Jd1UxMDVvU0lWQ1N6dDlibHlKY2dPZUhMN0RnNzJmTEhod3hXZ001?=
 =?utf-8?B?dlptTmowdHdQYldYQWQ4QT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NWF3Si9yNkM2amcvWDdCVjhiOHFiaHBlRGg3c0dJem9Ya29qdTlWWHdDOTJ2?=
 =?utf-8?B?Ym1IMTk5MHkzTkZhZm82MUR0Z0sxeGpXT3dwT0Q1cjRLakFlOTB3L0Vackho?=
 =?utf-8?B?bW5CV0RiNzVoOCtCaFdFTjNkOUwzekx5RGtjRW9RTVNHMHEraERLOS93ZXhY?=
 =?utf-8?B?c3JyOFlPbjNldlBWUXN3ekRhOStkeUc0UTAwcnJuazRUZjdmSlU0NFJCMmJs?=
 =?utf-8?B?eGhLaVpmc3Ivd2NXSHlGNXV3eWZWWE96SXBjWldhdWl0alo3U21ncXp0dnd1?=
 =?utf-8?B?WERXa0tOaThPZmUwRDU2czl0NDBwalE1S2dvdDk0NDVPQ2VBUkZKY1d4UTdl?=
 =?utf-8?B?S293c1lWeTdjVUxycHIzazhXdzhDYnA3VUdoclhMMzRlNFlHdjN6dFZGTkF6?=
 =?utf-8?B?WUNBSG9aUDVXVjlTbzkwQzBDcW1xaWNoT3hReHcvYlI2eTk3eTkwRDN2akNY?=
 =?utf-8?B?ZXlhWlVYMTlvbzhMYllJeGpRMHFyL1RMcUthNG9UUis2UlpNaEhOaVNTRHg3?=
 =?utf-8?B?Y2s1RDRCU05UMjIrYnJtU3k2R0lld2J6Rk5IVndlTHc2VEk3bHNpbkhHSXYw?=
 =?utf-8?B?MlRCTGJQdEhVVGNDZXJBY0lEdFMvTmxRWnJYeTU2ZHdweXFNZ0Q4ZEw1Tm1t?=
 =?utf-8?B?a1Jjb0wwSkdmMnd5WTcyNmRRS1dTakdWR0kvWmh2TkhUZjhDYUlIVVdqcHd4?=
 =?utf-8?B?VXBSNFZjUlFpalFFV2ZWTjZxS3ZmSEU0N3ZIdFJjRHM1Y0JzNzBka005Z0V5?=
 =?utf-8?B?UFBOZExBWW43anhCN1lQUFJCa3N6TSt6SWNxTzZSa1c3R2dIN1l6T25Qb0xJ?=
 =?utf-8?B?d3NuYUtwWXcxaFNUcE92Q2YveUpqaWt2eGRsZ1dydTNvWHBTYk1Zb3ZUM1hI?=
 =?utf-8?B?UWxOVTE3b3JiYUo1cnhzTFZFZDFpOVBKZFdvMjh4NlJKejkwMTJWQWIweVZO?=
 =?utf-8?B?cWNVQ29BbFpGY3J0NDdEOXUrZlV5ckVJT2U5a05hSUVFNnBlRkQveVBycWNJ?=
 =?utf-8?B?dExuSUgwS0YxNStMZklQWEJJNXZhSmVLVmlpZTBYaWxyNFQwN1lqRFBzNzBj?=
 =?utf-8?B?c2FvSmpHQ3YwM2JpdksvUk9QWGV0aHNDUFNjaTR0emovSWNqQXpmRTZtRS9Q?=
 =?utf-8?B?K3RpekUySXFNKzNyMkZZR3JtYVJ2NjFhZ2hpYU03Y2tRdUxrQ240TmlnTWxF?=
 =?utf-8?B?eWlxNWtQQmNTRjVBTXMvK1hTOC81enp5UGZOcVA5TzVMSmFCcWFCOFpRc0ZE?=
 =?utf-8?B?TTNOUjNVMXNHbTVSK3lnY2Y3c3ZzVHRWTE9oQVNoOW1XbnRGZ0hYcG9rcDhl?=
 =?utf-8?B?cEI0bjQvMWsvaXBVcy9TVHhFNnZ2L1pwL1BPUjkyTkpVNXUrUVlSMkVqcXdz?=
 =?utf-8?B?QTNoRFk4by9lZWlOdzNucVVvNmI5bXdFSWJ6U1N2eGdHRHJlS1lFVkludnBT?=
 =?utf-8?B?YTdudi9iQjhnRmdnd0xhdUJpSHpBbWg2ZVRxY2Fvbll2b2RnRldFeU1DaGpY?=
 =?utf-8?B?T0NiL1ZjdGJEUWYzMVh3K1FPS21uVFYva05ZQU9mVVQyYnhMd0JsS003akp2?=
 =?utf-8?B?bncrSFYwekswaUtvN3M2N2xCeGNQZHNoTUxJUkNFSUV0NVhMR1ZIWHJkUlI5?=
 =?utf-8?B?eWREQ1FiTC9tMG42WXZ0ZEdUb1BKTWZ2cWZTLzZOb3FYL1ZRbGdnNXJHQVRa?=
 =?utf-8?B?UTVYYmNSQmtkTFlFTTlhenVrUms3L2V0RmorRFo5RkZ4ZUkrb01QS2oyd2Vh?=
 =?utf-8?B?K2pDWGxqMWlEc0FNeU1CVEIzTkFmNm5kcE9jRUZ4bFh3OUNrYTZKNHU0WmdM?=
 =?utf-8?B?UXNSQ1JHc2Rpa0o4cjlJL3RHdHBiaFdka3RzaW1MeDd0NVFvTlNnR1lkcklm?=
 =?utf-8?B?RWFOclBqcndJa3p4aDhmaDJyeVpDUHVRZWhFa2NiYnZwNXdTRmlabGdISklX?=
 =?utf-8?B?V3IzUWpPS2dBajVzYVcrRFFCTnlnRDlFOWJPMVBadm5mY1BPSERUOCtzOTZ6?=
 =?utf-8?B?YWhFMDU0ZTY2S2JLdWNVNm5CYkFUMllFV21ReUROTm84djV3MG8yRXlYeHpH?=
 =?utf-8?B?WDZ0bnlEc25ZOUtxNW1idW9XWTJya1JuT0srY2xPOEVRdUVWL1VYWHJnYW52?=
 =?utf-8?Q?X8N+oUOd61QPKrPQbB4X289t5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8c2b1e-e3af-48f4-0041-08dc7e25e686
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 08:20:42.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwSMWsr1Wrtj+Uek2IqLvq305UXrG30KQI5KMoXzJud4sftIOBnrHB25/6wlhleSSkhtrBM5ssmy4Q81WjPybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6269
X-Proofpoint-ORIG-GUID: 1Po2dIYDiMPveAbO36Qw0QRD0tPUn-pW
X-Proofpoint-GUID: 1Po2dIYDiMPveAbO36Qw0QRD0tPUn-pW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+IE9uIDA5LzA1LzIwMjQgMDM6MDUsIFdpdG9sZCBTYWRvd3NraSB3
cm90ZToNCj4gPiBNUlZMIFhmZXIgb3ZlcmxheSBleHRlbmQgeFNQSSBjYXBhYmlsaXRpZXMsIHRv
IHN1cHBvcnQgbm9uLW1lbW9yeSBTUEkNCj4gPiBvcGVyYXRpb25zLiBNYXJ2ZWxsIG92ZXJsYXkg
Y29tYmluZWQgd2l0aCBnZW5lcmljIGNvbW1hbmQgYWxsb3dzIHRvDQo+ID4gY3JlYXRlIGZ1bGwt
ZHVwbGV4IFNQSSB0cmFuc2FjdGlvbnMuIEl0IGFsc28gYWxsb3dzIHRvIGNyZWF0ZQ0KPiA+IHRy
YW5zYWN0aW9uIHdpdGggdW5kZXRlcm1pbmVkIHRyYW5zYWN0aW9uIGxlbmd0aCAtIHdpdGggY3Nf
aG9sZA0KPiA+IHBhcmFtZXRlciwgYW5kIGFiaWxpdHkgdG8gZXh0ZW5kIENTIHNpZ25hbCBhc3Nl
cnRpb24sIGV2ZW4gaWYgeFNQSQ0KPiA+IGJsb2NrIHJlcXVlc3RzIENTIHNpZ25hbCBkZS1hc3Nl
cnRpb24uDQo+ID4NCj4gDQo+IA0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBjZG5zX3hzcGlfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gQEAgLTkwNSw2ICsxMTQwLDE2IEBAIHN0YXRpYyBpbnQg
Y2Ruc194c3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gIAkJ
cmV0dXJuIFBUUl9FUlIoY2Ruc194c3BpLT5hdXhiYXNlKTsNCj4gPiAgCX0NCj4gPg0KPiA+ICsJ
aWYgKGNkbnNfeHNwaS0+bXJ2bF9od19vdmVybGF5KSB7DQo+ID4gKwkJcmVzID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAzKTsNCj4gPiArCQljZG5zX3hzcGkt
PnhmZXJiYXNlID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgcmVzKTsNCj4gDQo+IFVzZSBw
cm9wZXIgd3JhcHBlci9oZWxwZXIgZm9yIHRoZXNlIHR3by4gVGhpcyBsb29rcyBsaWtlIHlvdSBh
cmUgd29ya2luZw0KPiBvbiBvbGQsIGRvd25zdHJlYW0ga2VybmVsLg0KDQpPaywgY2hhbmdlZCB0
byBkZXZtX2Rldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpDQoNCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQoNClJlZ2FyZHMNCldpdGVrDQoNCg==


Return-Path: <linux-spi+bounces-7227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9947EA68E59
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 14:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10853B2CF6
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85CD154BE0;
	Wed, 19 Mar 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ij86CEAW"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28022066;
	Wed, 19 Mar 2025 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392723; cv=fail; b=KEF3uImy3j6CbnT4DApqHfhXCQCUgONUDZu7U+lpBLJoxfbA2Tlkp1Tzi8VfQgcQbDY69c7xFGLFn3GxobluwRtMIhwfmoF5X/0vcsDHSyz99zxxBLA0tGxfUWtH9eacehp+NECglvejUrYQzhGO6NMzHyv2Du8xU4H+vNUdEDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392723; c=relaxed/simple;
	bh=Ag/vT/ugmyW/ftCfLKuLKBsX0Gp5ezIdFTx1cqqzpDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j4c8w1dXAT0fJA0YvLT9QMv1g1izC8EaJ5k09ZUHroUpy1yk5CGYFyeTb+YE1fsroq/uhSM39Avoj1VPCdgsvvQUGOjQhLfPi495JCb9KEtGbIJ2g5uCvUPg4B27JmvokFMSGRkeMftn7iG2wErgw4tn96evoNB7oCD1sXTQXho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ij86CEAW; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuF66aUc2KinewyZizkFrwUN8KzyNUyL0b6ZtI9Phi/3kFkSDxpiHyZj26XGwHTIiiituFmCdiekqm3+6ICs6jw5ySJ/qGZZg7s1VcOvzNV6lUGapjy9y8WLrNtZGdUzIvUqO57cxMrymOivgWX6AiMuzxPRdWKM1mRic84Ql9t9fcN3JlAMbLBDHdc+s+x90PBwQMDiclCCzXTd85NbFJZLX0BQ94KS2zUTJWZPEq8wJkm9ZAe856uah5qAxS+o2JKwQg3awds2K/xCAnr9LZeXD26PjzF9rCphELLN+Rq7zBbvNMPt5q66M/fPcqhvqBrIlgkxkxB7rdvS59rAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag/vT/ugmyW/ftCfLKuLKBsX0Gp5ezIdFTx1cqqzpDE=;
 b=bRvw2vID4FmN4pY3TM3Zipyptmf3k6lJQV0eAR18ry68XyleF1mdl1LZRgPNVawImrZT+4MWftX8Of6L0PiMZy4BhsmKDZlP7GoV1vaL+j7SLT6S2vuzAtzJi5sydK0trYYmTbYg2ojU56MZM/rNYs79ni+/J4PKd+uApcW26/djQl4IJkgQOyfwGfxUXziRwXqI2HppKN1r4qpcKpj+uits/KRK/R56P38RyCt+rtaslKv6Vr/VbfAo1uVc8sk+2jLr8U3ntXEQhDU78eJ51hBLRCXNveJ5MFv7AhWUFNGZcPA4JIoDS65MPHffEmBvufOhSjV4Q9B7VZzh43BorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag/vT/ugmyW/ftCfLKuLKBsX0Gp5ezIdFTx1cqqzpDE=;
 b=ij86CEAWfo0Mz8fyKIZK0VCep+iN+YA6169K8Cf2LghG337LoZaYM+stB1Eh7cgfYJjPpzvcL/+wHkActLwE6I4vsDt2KM8XfVYrXgeXz5caNH2hOuqDmf3cQXhqfIQMqsOlZlaGJS/drgO9cRC2bNJusUeTJomFyaDHA4umL0nfBoH2hq6pnv7SfSlplyPK4e3Lewhrz0I8xW+oRqPEQSbZVMPkWtjxXuCZpr14eFoT+Qxtm0h4GHEGLsoZT9wMH1sDdvFRN8rKlNidPy7SHPBixIAAh1+l87lqGzXIdx7aDxuOFCYbpzFVEKkJYl2RBM5un0446fgUIYG4iamrXw==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 13:58:38 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 13:58:38 +0000
From: <Rengarajan.S@microchip.com>
To: <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 for-next] spi: mchp-pci1xxxx: Updated memcpy
 implementation for x64 and bcm2711 processors
Thread-Topic: [PATCH v1 for-next] spi: mchp-pci1xxxx: Updated memcpy
 implementation for x64 and bcm2711 processors
Thread-Index: AQHbhrtteoSxb1JVs0emLo02YU9F/bNWg/cAgCQbxAA=
Date: Wed, 19 Mar 2025 13:58:38 +0000
Message-ID: <a322bf90b6b02f6dd96023e34d32eb78b1c23ca9.camel@microchip.com>
References: <20250224125153.13728-1-rengarajan.s@microchip.com>
	 <188ffb7d-47e2-45fd-80b1-b31ca58f0c0b@sirena.org.uk>
In-Reply-To: <188ffb7d-47e2-45fd-80b1-b31ca58f0c0b@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|CH3PR11MB8154:EE_
x-ms-office365-filtering-correlation-id: 010d1866-f419-418b-a471-08dd66ee261c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1Y0VmRabkhJZFJOYlQ1Y084Nzd1Y0JQL2o0RG1Mc0FuSFFNSGtoQVN5dldI?=
 =?utf-8?B?YzRMaW9taVJqWmNCT29QMDJUb3RpK0RsRTQ5c01VKzI4cmNxalMvWTY1V2lq?=
 =?utf-8?B?SFRHTVphUHlwdUIzZmo1UDZhYm9kN0hJV1BwNXdnS08zd0U1UkI5c3lSR3pw?=
 =?utf-8?B?UVJJeWxIZU5FVDBzd1V0aHpuRi9McG93TUw1amxhZlhVV0tZbStuUFJJY2Fm?=
 =?utf-8?B?cWE5VjRVUHFQUlQ2VzBNNVFvK1Z3NTVYVnFQbCtRSEYrU3p4b1EzQ1BHdHZs?=
 =?utf-8?B?VGxqMHE3N2EyWkp2ekh6bGtFSVVtRWNsVEZ0MjJZU01kKyszakNMK2hNUlAv?=
 =?utf-8?B?TnNOTDZIMmJFS1lic3lsZHM3aFFtSG5GVytQNysyaXBKeHh3dkFaZnVKWTFN?=
 =?utf-8?B?MlJxWk9QZmdmV2lnRXBmSlA5Rnl2Y0dBUHNVaXc2YXVYRnJYWGRKWmY4ZUdl?=
 =?utf-8?B?Z0ZHczRDNWpySkZHZ0RrMVkrTjdXa3VqYndUZmQ1QWkrYjNSc0F1RDZ1N0ll?=
 =?utf-8?B?NEs4Rlo0SHZwWHBTN0VTamJzTzBXMDA0L1plL3BOSkZyRVIrckFydlk3ZzV0?=
 =?utf-8?B?bjk5UUhYeTZJU1c3K0FiQmUyTld5T3pZTkVUT01BOUNoYUlHaWc2VEMyZ2lj?=
 =?utf-8?B?eThSVkphUkVWSE53UFBRcmE2WVRWV1VMYjJqVWdPOGRPTVFqbmJMd0YrUHd1?=
 =?utf-8?B?SXh6SlVOaUVnTTBicExEZFpLQlExYi9oUkNvaUVIRTF6K0l0ZW42d3d0K2lR?=
 =?utf-8?B?QkhDN0U1VUkxUERrOUgwcjQ1V1VCWEZReGpuUjNvSGg5R3FLaElOYjcyb3A3?=
 =?utf-8?B?bWtFWS9WMDh6c1FrRHpBc1Z0VlcwQ3JyRVYzVGo1OFRmd3VzbVhCSEM3ZzIz?=
 =?utf-8?B?MUc0cmRnYmNoSW1KK2ZzaEg5NGQyZEtOYzRVV3pHVUZmZXNMb3F0Z21ORTZs?=
 =?utf-8?B?ZFNsWkpGQVQ5bmYzdEpsSVpXaUJMWlRTUVovUElIN21sT1oxbW9QU0FaKzho?=
 =?utf-8?B?bDlFaEdYUlZiY2swOG9zUVRPbnJOdkpsTlFBWC9FMHRqSFdwQWFHbjExdWFK?=
 =?utf-8?B?N3pFVkxwaTFKQ1JxemkrUzJTb3JKSmt3ajQwVG5BZzF1aEhHanlaK09ZMWRH?=
 =?utf-8?B?YmxPa29jMThsSGozamhaeDBMRnZlSUpUUllsNjRWOGd6NTBveWFHSmoramhS?=
 =?utf-8?B?K092WGtCRFcyQWhKTWVVbTVLUTJ5aThmUmVRc1dUZkUzbHlUZFJOekE3eFpq?=
 =?utf-8?B?MzhIZE1PNmlMekdqY05YaWhkeGxkMHpBblpuVmJXQXpSVmVYb1RLSHozQzR4?=
 =?utf-8?B?TFZzbDZTSnZlaTdWTnlEWitNcHQxQyt1Q0JnY0JRTHVKSDkwc2YzOXRxU2da?=
 =?utf-8?B?ZHh2M2hlQXFsZittTnUxeEdPN1creGtlcXJCeHNuWGdmbkRzZ05rSzAzNmps?=
 =?utf-8?B?K01Ic2Z4OTB4QVFOZEtiTmZDOFpSejdEaW5sNldGOVgyenF2RGQrSW96L2t4?=
 =?utf-8?B?bHM3WW92aVVxZ2g1cDhlTG80S2cxdWVrdTE2YkRYMGRwZDZDYjNWcXNmL3ZB?=
 =?utf-8?B?TFdsWHNERVplaXRPVWNOdlpTUEtvRGl2dm5WNmEzKzBWOVY2QlFsVkNTS2tU?=
 =?utf-8?B?NUtZakxXdlRrWnFxNVpVL0hPZUlNK1IvV3hjYW5tdnFHZENUbmZyQkFwa0ky?=
 =?utf-8?B?UEtHbVBVNm5iL2pXS2VuODZlSW9yc2dWTjEwTSttMXl6RXpuVEhEWFM0dXVR?=
 =?utf-8?B?dzMreTZqY3NRU01PNkJDeHRBYmxia01ySkNQMUhkOWR5RWVINmJlcExOS2JS?=
 =?utf-8?B?dnJuQTliMzdTcDRSYzMzcGVyNEx4ZTA3WDdqWW1zbmpyeloxbGhJMGxyQVVP?=
 =?utf-8?B?bThrM3lzV0hoMEtFcnBpOUNtcTVoOS9YWVRPdmM1Nk41UlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXZ6SjFWdXBEdUJlZlNGT1BqTyt1T3lhbGx6a3ZIRUV1Qnh2aFU4NDVpNXZH?=
 =?utf-8?B?Tm1tOS9wSGxyV3hOUW13emJqcUJ6QlEydGlZQUVMRE5nZ25FSW53TEhsdU5q?=
 =?utf-8?B?emgwNGZPK0FNWEJlUER4UzdzTXpmNllQM1BjWWZyMjJjNnZtYWJqeXhqNVlO?=
 =?utf-8?B?NzNyZWdnRE1NRk5HT2tEUWU4QUYrcWY1UzdjMHZEOG1sWkNJeE85d3Bpbk1i?=
 =?utf-8?B?cEZoMTArUStGa3Q1dTA5S1E5Zis2UnZoN1UwbEpKSU9oTndpVHZsWDJ3SjBW?=
 =?utf-8?B?clRVRjFoMnFITTVOMk5mWWpTbHpxWGZ2RzBac28vZ3ExM2pqNEdSazRUZysv?=
 =?utf-8?B?YWNETno2ZVZrMEtOa3dZb3FGL2h0MUFaNVo3U0FQS2Vwd2F2OGh1dlhZUzhm?=
 =?utf-8?B?VFc5OERReGdEOEVaTHEyWE9BRFFhaFVaL1liYkRnLysrWkNtZmJjUXJCYTZx?=
 =?utf-8?B?OC9yNGRnUHpocjFxNm04SUVCMkN3ekl0ODBGZGNpOWJuVUdPcE9hZVRCSnRQ?=
 =?utf-8?B?L2FDdHNlZkJLMytXY1lDdks1RG0xWGg4a1dvcUNDbmVTMEFHVEVyOWNoV3pw?=
 =?utf-8?B?dzNSYkV4YUtKaVJhOWJRZTZtcWZIYldoOTV3M0liNmJzcGNnSnNkRUZKWXV4?=
 =?utf-8?B?bktBMnZ1RmM0QURiMU4vTUJ5Qm1iT0ZSMXV3RThjK3FoZUQyMHNHK29DYXFv?=
 =?utf-8?B?K1pVS0xkWlBGbWFQL3NGYm56L21jdVpVNWpwSWZQbkxsU09LVFo4bXBKYnpD?=
 =?utf-8?B?SjBSOW5TMnlEU0JVM3FZRnNRbTR1a0xjZDh5aFovcDQ0bEZ0eElKVm9xUksy?=
 =?utf-8?B?MlN3ZDNnQXNMTTN4ZEh3amJpZ21mUnZMT09zaTljbEk5MHd0OS9va0p6dUll?=
 =?utf-8?B?M2VmMFFOWmZBZnF6L29DbVlUSkI5anAxcVpabTRlenRJWFJCbDBWWTA1NU8v?=
 =?utf-8?B?N0tpWnRGa2NhcEJva1BjclRFbnZnYmNHUmNXNE43b0NqSmhxU0pSbVlVRyt2?=
 =?utf-8?B?akk2VFg0RFVkY2lTQWJxQnBmNjdkajBlWW04dDhqbUNrTUFjdzdQcGVLNlNw?=
 =?utf-8?B?TUdIRzdhQUNZMVVYeWUwSFV4MmlidUg0bTVGSEE2eFZ3cDFiN1N5bHJGb0Ni?=
 =?utf-8?B?ejEvZmVianZRaEd1dFZnOWI1WVhoRTE3L3ZQK3R6YzlEY1JmM1JWT05tcjBx?=
 =?utf-8?B?K0RNU3F3Tk8yTlhxK1dRcFQ4SXZwdmQybHhnT0tHN01rNWFYOGFqckdDcG56?=
 =?utf-8?B?YVYrVDJhYXBqcklLcGFWamQwTCtYVk1SRXhCQ0x1aHIxcVk5d0huNXVqWHEr?=
 =?utf-8?B?VW9vTThNcllXRVVxaVNMSWRZZEZtdGQvMlU0TWY3aVQwVHJ5cDQxdnZqVisw?=
 =?utf-8?B?NXYyQytJakxTUld4UkZZRGNIOUFYLzZOdlNZeGFnNUdGZEh5SDA0blZVMDJS?=
 =?utf-8?B?WWx2WnVwYUJVVnBiY0N0VllpQ29lV2xzWEQzd0hvUEFKNU9yT1haZ2x6REQ0?=
 =?utf-8?B?ZDlNQTlTSTFLVzlKblIxeWZNU3RyZGphb0xpVmJFRzNhVWFqRStRVE9LTG91?=
 =?utf-8?B?d2NUb1lkd3Z4a0o2emEwNGxvME9VSDcxWGluZlBacXFXZ0ZhNE4rU01pSTJE?=
 =?utf-8?B?NnpwU21pRXJpZURIbldrcGdUZ04zRm1FSlM0MHhCT0IvYnBHZW5aQ1FhSEh4?=
 =?utf-8?B?WHlFbmNWY2ljb2VpRHlxUmZycDR1Yk9FUks2VUYrTHFGVHR4azk1N3hyNjA2?=
 =?utf-8?B?eHJiN216OElHZC96NEF0eWZ4b1YyMEJLaFhXNllNRk9aelcvQXRsUnBwRmpv?=
 =?utf-8?B?UEZTanl5cFNJM0FrOUhCOFh1UDRZeURxUmQ1YnpJSnk4WHRBMWpyVjA2cGxE?=
 =?utf-8?B?T0hWTlV6d1FMWHduaFFkZHR3YnIzanpSaWlUMVU1eC81b0ZzdUdHbTdkNEdU?=
 =?utf-8?B?U2JHVjd6QnI4M2hRME5mZ1pmYWZLanI1c2ZaQ1ZUaEp2OXA5MHlDc1pyck55?=
 =?utf-8?B?YndnSm9mVUJwcHhvS2ZFbEhoNWtxaVBraWg3bUVQTzZmdmhUcFF6Sk0yU2RX?=
 =?utf-8?B?S2FOTXlxbEZPMkpUTzBWREd5eTB5NllJd2srcW52OGVkT0hlTk8ydnhteEQ0?=
 =?utf-8?B?TktqaTgwTVpDRnBxYTJGOEFNbERJSFpqUXVPQm44WVl5Sy9JUEpTZUFiMTVQ?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3605413D39ED8A4E8C6A0788BCD09118@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 010d1866-f419-418b-a471-08dd66ee261c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 13:58:38.3996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tG3YY28ZboP1Nb4wsEEX3K6HY1NaD9tZWPQ05S/3aKDNdl98adkFLGe6mEYnXefPW/isWkedmZ6DCIDo4uXQ48F+MhsjPSWJN6a3Nr1Wyqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154

SGkgTWFyaywNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoIGFuZCBhcG9sb2dpZXMg
Zm9yIGRlbGF5ZWQgcmVzcG9uc2UuDQoNCk9uIE1vbiwgMjAyNS0wMi0yNCBhdCAxNDozMCArMDAw
MCwgTWFyayBCcm93biB3cm90ZToNCj4gW1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1l
c3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20NCj4gYnJvb25pZUBrZXJuZWwub3JnLiBM
ZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgDQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCg0KSSB3ZW50IHRocm91Z2ggc2V2ZXJhbCBwYXRjaGVzIHJlbGF0ZWQgdG8g
c2ltaWxhciBpc3N1ZXMsIGFuZCBtb3N0c3VnZ2VzdCBoYW5kbGluZyBpdCBvbiBhIFNvQyBiYXNp
cy4gVGhlIHJlYXNvbmluZyBpcyB0aGF0IGEgc3lzdGVtDQptYXkgaGF2ZSBhbiBhZmZlY3RlZCBQ
Q0llIHJvb3QgY29tcGxleCB3aGlsZSBzdGlsbCBoYXZpbmcgb3RoZXINCmRldmljZXMgaW4gdGhl
IFNvQyB0aGF0IGNhbiwgb3IgZXZlbiByZXF1aXJlLCA2NC1iaXQgYWNjZXNzZXMuDQoNClRoZSBm
b2xsb3dpbmcgYXJlIHNvbWUgb2YgdGhlIHBhdGNoZXMgdGhhdCBJIGhhZCBsb29rZWQgaW50bzoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTAyMjYxNDAzMDUuMjYzNTYtMi1uc2Fl
bnpqdWxpZW5uZUBzdXNlLmRlL1QvI3UNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
YXJtLWtlcm5lbC9jMTg4Njk4Y2EwZGUzZWQ2YzU2YTBjZjc4ODBlMTU3OGFhNzUzMDc3LmNhbWVs
QHN1c2UuZGUvVC8jdQ0KDQpDYW4geW91IHBsZWFzZSBzdWdnZXN0IGFueSBhbHRlcm5hdGUgbWV0
aG9kcyB0aGF0IHdlIGNvdWxkIHVzZSB0bw0KaGFuZGxlIHRoaXMgaW4gYSBtb3JlIGdlbmVyaWMg
bWFubmVyIGluc3RlYWQgb2YgbWFraW5nIGl0IFNvYy1zcGVjaWZpYy4NCg0KVGhhbmtzLA0KUmVu
Z2FyYWphbiBTDQoNCg0KDQo=


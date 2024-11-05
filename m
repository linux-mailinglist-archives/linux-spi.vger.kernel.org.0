Return-Path: <linux-spi+bounces-5619-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1F9BC742
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6ED2818B2
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D552AF0B;
	Tue,  5 Nov 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o9fwE7Zs"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C6282F1;
	Tue,  5 Nov 2024 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730792856; cv=fail; b=QyYtvLBbaxSkS2+V2Rko613J9Yj4sW2jUNATQgg/KQztGBkRPh2yOb3d73AiP0XOTJpGlfgW0pyzKA/U/htbmbUOmQxKSOM+H6jOWOlgcGOQu/wx6C2fUTqjGhdvfnyZfnp9b82IXDa2Kfl7rPJxsX9ZtzJOI38DwQ627yrim1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730792856; c=relaxed/simple;
	bh=DtVKjyrtRle17gmD7btuaeMnJhydYKJToarDAqaghTA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XXgDaLKBKpQFmcEPvpiaWAGtM4Rt2cNrb4BWlIlZeC8YxnZTfUxYjTpyuqXFVEoTi3CeH4yNcvyKrs2smZJJlDF6VKpTvegraW6J4ETPp8VlIjkJePBv7gLC0w5ZWzeiapaEPZx1KVWHwcD05cFqEDXmzh7QTJCwe1mRIH8xQQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o9fwE7Zs; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPmm/YCbkMFYlD3W9JGcWvM21Fbcxz7Yr//7ndcisEwlG5QADAhzZosF7WEw0Ozsz2RThxsxjdB19bb3P+jyNLwflEeGg+8FtVbQ9HoOdcQcE04k6aLfw+4tGTSBXkZsC/aZdkAGogNNKStkdgtvnHWN4MIIDBXKljBNoXSwsMh+UgOK1EYmRb3RfxahdoZDrBBUOjavTiJWGVwBNV56xQ4iK2VRzEF8uNr5n9zR3m6Rct5ox3TIpzVHlzVXjKtj3rUIgDuRD+WAI060jaMBJu1CQ0ohjdoTZIkIvcpDg66/QpspfNLNrdo/8yCcsDjt35QsN75PTPV1TEJUecwURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtVKjyrtRle17gmD7btuaeMnJhydYKJToarDAqaghTA=;
 b=B5PLnecQedUriVLeETPb3kx4038Szp30bYF9RTMSi8Yiio12ScdCF348VBZWeZ3gwW8j/3PAW8oKb+dJ3xdbf33jH+SZbAMrvijR8ASLyRSrbpq5ob/CLkn6sW6J8KUaCo93ie3pQ2uLtYO5Q6MQhJh8pDbl9KQyFYGbwPq3eHnjjfkyMfWzkzpr5MTmCEzR33L9T+URxudtv2jUG669TfDeij+W/4iXvnDMakSJWj9O0b3DUCGPs7edJz1HL0TOYNsTuA/+mWYsaD+RtNFPqW2WaynE6I8MaZ/NZJ496lwaqiJ+lX3OH5y57s8tcwdgoQ7rjGe5ji6RlERqX1gM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtVKjyrtRle17gmD7btuaeMnJhydYKJToarDAqaghTA=;
 b=o9fwE7ZsmtcBYrvGswUjP2cb/nyWt/7i5W9g+LhmznOlbPSRJbRUi0/Y4ORSRXvI6JEsjUTW2MYs6SflpkN/7l3hTh4ojG5V9oREDCvSW4Bxzg32Yenudxfzpy+pQ/I4NwR3rcCtObSECNwGs/ABqQyA9TEaIdD+2G2FMBMaWbw99+63RjYsij1rbu95aLVDdy9vROLWWN3x6dhAnVFxHlwCap4oS2iRlWF7zMlDqMcFG6dZ1DPP9f5HqKdDh/WE8usZsNuIF6e4q5jN81g6hqstIqAbcTdz9HcIUU4DizRMA9dc/cv5dsMooHiw4BpC3h/q091aDIZNcxJMLB/6uQ==
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:47:31 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:47:31 +0000
From: <Hari.PrasathGE@microchip.com>
To: <csokas.bence@prolan.hu>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <Varshini.Rajendran@microchip.com>,
	<alexandre.belloni@bootlin.com>, <broonie@kernel.org>,
	<claudiu.beznea@tuxon.dev>, <Nicolas.Ferre@microchip.com>,
	<Patrice.Vilchez@microchip.com>, <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to support
 newer SoC families
Thread-Topic: [PATCH v2] spi: atmel-quadspi: Create `atmel_qspi_ops` to
 support newer SoC families
Thread-Index: AQHbKqhdax2sqWU1rUOdBFrhcn4D4LKfIwuAgAAYtgCAB96LAIAAAl4AgAE78wA=
Date: Tue, 5 Nov 2024 07:47:31 +0000
Message-ID: <78f38031-1723-4474-9bea-1c23918a75f6@microchip.com>
References: <20241030084445.2438750-1-csokas.bence@prolan.hu>
 <7cc95e52-7509-44eb-8e30-d518283e7d87@linaro.org>
 <2b310b54-c215-40fa-b6d4-81faf75a8c9e@prolan.hu>
 <20241104-vanilla-operating-de19b033f0a8@thorsis.com>
 <ad585127-9e3c-414a-84c2-c4ea3e6d3c7d@prolan.hu>
In-Reply-To: <ad585127-9e3c-414a-84c2-c4ea3e6d3c7d@prolan.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4185:EE_|PH8PR11MB6731:EE_
x-ms-office365-filtering-correlation-id: a7807f17-971e-406b-50d0-08dcfd6e1a63
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2ovMnVvemFZajQxOWZNSUVSUHJGaU1jeUpKZzI3MWFPeVM5YzJUaXVSNVRJ?=
 =?utf-8?B?QStQckhZMitIa1gwclE5K3NwbUhwK3FQSlJiSFJhV2srMUgxTWh0TlAzRzZE?=
 =?utf-8?B?ZDZBM29jZytCb1hnMktwT2JoeVBzNUIvYk5XNUErRGZxSFF5dkVJK2wvT2pL?=
 =?utf-8?B?TjR5VFYvQVNpMWIrQW9vbm1zb1dtbnFlSUhpSDFwNnhjekpJUW1EanJwazNC?=
 =?utf-8?B?T1FaZGNjRi9ZTGMra3lHZ1h6NUZ6b2tvb1lXOUx4NGV5YTdxRkZOM3dqWjJP?=
 =?utf-8?B?ZUluNXQyeTg1MUFOTExRU0w2OFA5UDhkaWhsU3dvZGpQenFIc28wYmlzNWV6?=
 =?utf-8?B?VVBDZlZSZ1lpSjlzNm5xUkFNVExRNzU0czN6RUpzTGZTeUplT0Y0RUZDaFBp?=
 =?utf-8?B?QWNaZ1hyTTJTL245aUFhNklNd215b1gwdm4rZC9zVVlhSmFvbUN1b280VjQy?=
 =?utf-8?B?WDBsei9Fa0pLZThDckM4eERrWjJVd0V3M0JYa1R5dkVNYllRREJNTGNxM0dG?=
 =?utf-8?B?Uzh1Rjk4UG9nWnZMVVcwTFZXeFgzUTRTdW1ZeTRmZWpJQk83eDNUMWhiQ2F2?=
 =?utf-8?B?cExaS3pFZXcwVzZEbFU4YUFRK0FudHJaRTJlMjVuNWJBYUh5MTVLSG5tak9S?=
 =?utf-8?B?L0h4UU9PZlRzeis3c0ZGWUdab1IyV2lCNnhwR2xqd1VydGo4b1BWd29QSEVz?=
 =?utf-8?B?ZTJJTmtnNFhmSHVNa0xzanN0a3VLTW0rcUgzaGJSdDZLbjBsM2dOUGEwYVhZ?=
 =?utf-8?B?SldwcVZLRHZvZzJLWGNLTTRzdkIwZ3NpT2ZpMVV6V01LbllWaTJkOGg3WUZu?=
 =?utf-8?B?WTJxMzBVdEhoT1VwbFN5VFJZRWl2Nko2YSthYy9qT1lGcGZYWmp1WllDVE1I?=
 =?utf-8?B?aHh3T0tHVVRQOGh0QmhPRmdZakpXRW1CZ2NPTjV6aEFBYjRDY1Z4RDc3NjIw?=
 =?utf-8?B?N0R6ZmoyelFrdmhOcjFGVWtyako5UGdyblNTMm1zQTJiM0ZsbGdOSU5zWHdL?=
 =?utf-8?B?TFoxSGY0a01abFROMXRWV0w2SDFqTkV3YmZyM1BOZys1czJ1TVorekdQb1lw?=
 =?utf-8?B?bFArUGNXay9wOVhwUU1Ub0FqT2ZqeHB6Mk5MQktzaHozYm1vRS9lL2N6eGdY?=
 =?utf-8?B?clZIZCtIWWNBRGxyNjBhR0VUdFBsKzU2S0dqOXVPZ3QxdTlwLytPQ0t4WFoz?=
 =?utf-8?B?OHRQOEFIV2lUNU5VM3RHS01IVCtoV2hYUkdFVDdZV3ExUWV2a3RGTlNzRFhG?=
 =?utf-8?B?SHJzK3RNSjFUUFZaMmhueFJWYVZ5OEFBMW1XYmt5QVpaWEswOG40S2E3d0Zv?=
 =?utf-8?B?T2FBZHJLb0RVMXRscnEwTmNQZW02VGxpQ1R6RjgzQm1xRVgySDBUeHJpWGU0?=
 =?utf-8?B?QXdYL1NzOVBUV2tUeW1oZVJ1R2FXWUhKQzRVREpWbVBEdUJJaW52akxLUzVw?=
 =?utf-8?B?amx4ZzhhYzNnSlBiVzV0SzVjbG5OcjNTWDJxVmRCaWVOSDlNK3ZBRTU0bE8w?=
 =?utf-8?B?WGJ1VFRTMEg2WFNGRTA5NmRhK2FlNDJWWHovdGFmSEwrSXVQQVpSRnVjaVVY?=
 =?utf-8?B?ZkREY0Q4c0JMRkc2UjFSdk4xLzRVd2RVRU5kcTRRd09rb1ZvMDBrbHE0SUlH?=
 =?utf-8?B?dUpzOU5UZFlwOVg5OUtUK0tQVUNUa0NDVU9GV3JBT3pnY3JucjhWdnBFU1JY?=
 =?utf-8?B?b3dDT1drdTFWY2xPK1N0RUtJSEJMQWtBQ2hvdEVKd25LSVhBT3VhY3BNQWRj?=
 =?utf-8?B?OWI3RVY0bGNTeGdZOHZ3SUd5Ujl6L0t4NXhRZm1aWGJoU2c4ZU9BSFE2REFZ?=
 =?utf-8?B?YW4zMnBhU3ZSSFZEUnI1dk9qK2R2THExSm16KzRUTllienVUK1VwZFZtR25L?=
 =?utf-8?Q?UJ+9SyZ/gFnwQ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkloc1ZIdXpERmVtdWVEVm43TDRFMGEvL0grSG82Zmlxd0JrNTlFa3JiV045?=
 =?utf-8?B?VFc5YkRNRW15S05IYnBKZDZjb2dQNGhpRml2UkRrVFAwbVRIZ3FPL2hBNmZr?=
 =?utf-8?B?ZTZlakFkUjljVTJqaTQvdFppeUpCbUUxaUNBNmxXQWUvZVN5aEFlS3hwOU9l?=
 =?utf-8?B?ZC9VWkZhN1QrSURQQWloOFNza1JkVGttMmJnZzhLdkFLZVJMWXJkbk5vVlpr?=
 =?utf-8?B?OHEyZ3J2V3BlYWp4TFZSZlNPQjBsYStWMHVjam1GMjFuVEt3d2NtM2c1OWpr?=
 =?utf-8?B?NkR1MkFqeDA3SlpHV1VDdnhkZ3dqK1ZPOGdOQ2RGQ0NUZldWREw3UVh6ZlI4?=
 =?utf-8?B?dnJ5Y0xmbFpSblJrSm5IaStYZ1djbExDOGIzYXU2UjN2dlF6a0o3c3VVZTFL?=
 =?utf-8?B?dnRtVmU2SFVSUGpWajl5T1EyWXRsb3JPOCswWEw0aGdFQ3NmNkF3YU1ZQWh3?=
 =?utf-8?B?TUFiQUdpR2wzbENOSStPb1pJaTI0N1pxNFJlblVQNDduY01TWHNBbGZ1TFpM?=
 =?utf-8?B?ejJXeXQxS0dLVnZWK1UzL2tRb3VtZE1CQmpDSS9COU5FM292V1JPdERvK0V6?=
 =?utf-8?B?RWtkaFNnQ2hXam5NYkRGeDVoL1lYOFZlU0ZibXp5ZjJWOFRjK3BzclpEL1M5?=
 =?utf-8?B?RnZqdW9xSGwxMGxrTm5tRW90c2JtNDFyY0FwVU1SaDc2a0FISmRUVVJxVFNs?=
 =?utf-8?B?c2hLVGhuZWJTbEJNVFhZdzRBMUR3anU2UmtBMnpUY1hNZXc5Zkc2MnhpTFdW?=
 =?utf-8?B?UFArRHNHaGprWWEwcnQ1V1RzS1YzRmcrMHV3cFo5Q1Y5bmhZcWVUTU5FbWxL?=
 =?utf-8?B?TEpZRWIvNnBHVUZEa1d3bElZMWluenFsWU1sazNRdHJxalJCUkppUlByb1FG?=
 =?utf-8?B?UDVjYjZoNWkxbFptUi8zQm5ETWFZVjNyQjRlWFVCZGJabzduWENrRUs0bG8z?=
 =?utf-8?B?d2RKajc2N1pQYnVPcTIrYkNNMHFzbE54YmxGSXV4Vmp6SFZ5NmdhVEdEalFt?=
 =?utf-8?B?T0dBTUFNbXh1WUdmU1E4VVNGMkt1YnN4TTdIaE8weWw0WWkwQkdYMnJqOW4v?=
 =?utf-8?B?RHkxdUxjQ3RyZkt4aU5jSythQVEwQm5DUC9KbUZ1WDR5WG5jdTdsV3ZMdXAx?=
 =?utf-8?B?WnExekZXNS9hVUlqMjZNWW53eDlpeFBoVmswLzhJWXk3aVg1Ri9ZUTV5Q01N?=
 =?utf-8?B?Vzc0SmQ3ajgxTGFTT29TZHpvWmxQaU9PV3VGeGVjbjhiNnVuSC9FTDlqcWVD?=
 =?utf-8?B?TUF0NGdpeDFiZG5Bck9wazFCUlc3YjBaQ1RCQi9ZTGcySXZrU2NZOG9qN0Qy?=
 =?utf-8?B?eVY3WEtIdXNRTVRjWVZldkg5VGQvQ1Y5blFiU2NKaUo4d2NPSWxIWUhGbDN2?=
 =?utf-8?B?SEhycll6R3lGQnZCNTMzTmFpaG9xMWo1TmladlRYc3lINm84MGFqQzZqWnRk?=
 =?utf-8?B?c1ZHTW5OUk5wMVVPeWkyOGxaSE5wZmFMdHB5Zkc2QS9pOFZ0dlFoVlN0bjEz?=
 =?utf-8?B?Nk15RkNaK0JUb3R0blN3aERVQytYakxsK1hvZE1FcCtqK2FqeTl2Rkw3alNv?=
 =?utf-8?B?TUpFckwvMTZidHYvZ212cjlVNk1sUkZsMmNLcC9URmo5M1Q0bFFYZ2gxWWRy?=
 =?utf-8?B?Tmd6bmJnVTBDMnNBUURYYVBvZFJSWEljRXpjV09IanpWQUxFcmUyZ1F4L3BR?=
 =?utf-8?B?U0VIWWNoYkJMRmxGbWVCV0VwUGdWWFE3OHp4M0d3TjhCMkJxSEJFMUNianhp?=
 =?utf-8?B?ZDZoYXkzQ0ozYjJCR3JERzZ6aHFxUmdkYUxxRmdlazl2Q0laOC9PNzFraC90?=
 =?utf-8?B?SzEwa2RCNDdkOXdlRk1lVHhmV3kwbURHRzhUR0tNb0U3cHZUaWlDcXFhRkRX?=
 =?utf-8?B?VW5pSlhxSnRCUzUzaDZLWGdFK1NwMWQwYnVFSkpCT2tpKzhIWGJuZEp6ZHZi?=
 =?utf-8?B?SEw0MklrQUtIYThXNGZOZjdTQkhtZkxBbWlFY0E4RUVxTmgzYnE5ZWJIQkdB?=
 =?utf-8?B?MER2VWNHYnB3cHZJTW03aFVEWEN4ZEl1VWVxemdaQlJOQm5lQ1llZ0p6cmY1?=
 =?utf-8?B?eEZkOFFBWFFMSCswWkZtQWc1MDZnSXArTkZuNnc5NkRXUzVyMm1qUkpiTmlH?=
 =?utf-8?B?Skcrek9lZ2wyMmpCU1E2M0NRNnFGUkc2TnI0SGpvNVNlVDYyK0p4Tm9PV3Br?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E80701661F9A9947B97AE2EDF0F62CB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7807f17-971e-406b-50d0-08dcfd6e1a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 07:47:31.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMcS/CXZZHYzFhhnFaRGnnJCli6Ski8Xj/M+ww55jqR9zzvpVz6F9xED7RkrC9Sf283xWVNeprKILlhjVHSbRfRNwJ7XfCDq1dV6UuxXOIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731

SGVsbG8gQmVuY2UsDQoNCk9uIDExLzQvMjQgNjoyNiBQTSwgQ3PDs2vDoXMgQmVuY2Ugd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgDQo+IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpIQ0KPiAN
Cj4gT24gMjAyNC4gMTEuIDA0LiAxMzo0OCwgQWxleGFuZGVyIERhaGwgd3JvdGU6DQo+PiBIaSwN
Cj4+DQo+PiBBbSBXZWQsIE9jdCAzMCwgMjAyNCBhdCAwMTozNzo1MlBNICswMTAwIHNjaHJpZWIg
Q3PDs2vDoXMgQmVuY2U6DQo+Pj4gSGksDQo+Pj4NCj4+PiBPbiAyMDI0LiAxMC4gMzAuIDEyOjA5
LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4+PiBJIHRoaW5rIGl0J3MgZmluZSB0byBzcGxpdCBz
YW1hN2c1IGFkZGl0aW9uIGluIHNtYWxsZXIgc3RlcHMuIEJ1dCANCj4+Pj4gcGxlYXNlDQo+Pj4+
IGFkZCB0aGUgc2FtYTdnNSBzdXBwb3J0IGluIHRoZSBzYW1lIHBhdGNoIHNldCwgb3RoZXJ3aXNl
IHRoaXMgcGF0Y2gNCj4+Pj4gZG9lc24ndCBtYWtlIHNlbnNlIG9uIGl0cyBvd24uDQo+Pj4NCj4+
PiBXZWxsLCBhY3R1YWxseSwgd2UncmUgdXNpbmcgU0FNQTVEMi4gTXkgZ29hbCB3YXMganVzdCB0
byBzb21ld2hhdCANCj4+PiBoYXJtb25pemUNCj4+PiB1cHN0cmVhbSB3aXRoIHRoZSB2ZW5kb3Ig
a2VybmVsIHNvIHRoYXQgd2UgbWF5IGNvbnRyaWJ1dGUgb3RoZXIgDQo+Pj4gcGF0Y2hlcyB0aGF0
DQo+Pj4gd2UgaGF2ZSBtYWRlIG9uIHRvcCBvZiB0aGUgbGF0dGVyLCBvciBpbiB0aGUgZnV0dXJl
LCB0YWtlIHBhdGNoZXMgZnJvbQ0KPj4+IHVwc3RyZWFtIGFuZCBhcHBseSBpdCB0byBvdXIgdmVu
ZG9yIGtlcm5lbC1iYXNlZCB0cmVlLiBUaGlzIHBhdGNoIHdhcyANCj4+PiBvbmx5DQo+Pj4gbWVh
bnQgdG8gbGF5IHRoZSBncm91bmR3b3JrcyBmb3IgZnV0dXJlIFNBTUE3RzUgc3VwcG9ydC4gSSBj
YW4gb2YgY291cnNlDQo+Pj4gc2VuZCB0aGUgIm90aGVyIGhhbGYiIG9mIHRoZSBvcmlnaW5hbCBw
YXRjaCBpZiBuZWVkZWQsIGJ1dCBJIHdvdWxkbid0IA0KPj4+IHdhbnQNCj4+PiBpdCB0byBob2xk
IHVwIHRoaXMgcmVmYWN0b3IuDQo+Pg0KPj4gSXQgd291bGQgYWN0dWFsbHkgYmUgYmV0dGVyIGlm
IHZlbmRvciB3b3VsZCBicmluZyB0aGVpciBzdHVmZg0KPj4gdXBzdHJlYW0sIHNvIHRoZXJlJ3Mg
bm8gbmVlZCBmb3IgYSB2ZW5kb3Iga2VybmVsLsKgIERpZCB5b3UgdGFsayB0bw0KPj4gTWljcm9j
aGlwIGFib3V0IHRoZWlyIHVwc3RyZWFtaW5nIGVmZm9ydHM/wqAgV2hhdCB3YXMgdGhlIGFuc3dl
cj8NCj4+DQo+PiBHcmVldHMNCj4+IEFsZXgNCj4gDQo+IEFncmVlZC4gVGhvdWdoIGluIHRoaXMg
Y2FzZSwgdGhlIG9yaWdpbmFsIHBhdGNoICp3YXMqIHN1Ym1pdHRlZCBieQ0KPiBNaWNyb2NoaXAg
KGJ5IFR1ZG9yLCBvcmlnaW5hbGx5KSBmb3IgdXBzdHJlYW0gaW5jbHVzaW9uLCBidXQgaXQgd2Fz
IG5vdA0KPiBtZXJnZWQuIEhlbmNlIHRoaXMgZm9yd2FyZC1wb3J0Lg0KPiBMaW5rOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1zcGkvMjAyMTEyMTQxMzM0MDQuMTIxNzM5LTEtdHVk
b3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tLw0KDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaC4gV2Ug
YXJlIHBsYW5uaW5nIHRvIHJldml2ZSB0aGlzIHdvcmsgYXQgdGhlIA0KZWFybGllc3QuIFdoaWxl
IEkgZG9uJ3QgaGF2ZSBzcGVjaWZpYyB0aW1lbGluZSBmb3IgdGhpcywgd2UgYXQgTWljcm9jaGlw
IA0KYXJlIGZ1bGx5IGF3YXJlIG9mIHRoaXMgZ2FwIGFuZCBkb2luZyBldmVyeXRoaW5nIHdlIGNv
dWxkIHRvIGtlZXAgdGhlIA0KZGVsdGEgYmV0d2VlbiB0aGUgdXBzdHJlYW0ga2VybmVsIGFuZCB2
ZW5kb3Iga2VybmVsIGFzIG1pbmltYWwgYXMgcG9zc2libGUuDQoNCldlIHdpbGwgZGlzY3VzcyBp
bnRlcm5hbGx5IGFuZCBwcm92aWRlIHlvdSB0aGUgZmVlZGJhY2suIFRoYW5rcyBhZ2FpbiANCmZv
ciB5b3VyIGVmZm9ydHMuDQoNClJlZ2FyZHMsDQpIYXJpDQoNCj4gDQo+IEJlbmNlDQo+IA0KPiAN
Cg==


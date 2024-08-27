Return-Path: <linux-spi+bounces-4330-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39496014A
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 08:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E6BB20B62
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EE28689;
	Tue, 27 Aug 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pxiAlIrb"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC008C13;
	Tue, 27 Aug 2024 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724738533; cv=fail; b=FxcDZW/qcPOk00o2i2dzLG1egcPRkD/mx28UAZ8jUV1mcyu2zcqClzrGiyOvfk5ag0Em6CuvctQzKLKSOThgzdFTTsogKRreTrtR/gyq3I0FQL6dga+ofCviSxYNLn6Iq0UtGtDLI4swfSW4tZxtIAp/qb0wBHqCMaeEAv2aC0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724738533; c=relaxed/simple;
	bh=ESfIq6mfT/4MM01M4v6RlMXZuItzFTnowdTLAGI/n+U=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmOxjV2PHEwzmeoN1WGtz3/x9hLYS3dMZocaE+4wmehA0kHKOjTE0SL5sAyEU+zGNvLwY2swhoFTXqWK1eUIONoB3sCxQENfof/Xqgf5iajkQEH+BETbL3g6MRoEi+LgUfKYfGjoOcxsPjZgGTbNDFYXMkdDMKyM4Ft2ZxGW0/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pxiAlIrb; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACxEg8nO29d9c2ZvFWmHjl1GsO6meEzakuVCm/V0DiK5AdcAi5+Au3f9CnvUoqpymoLrOaNj2trdw2Li3R7ZRWLOgF+2aphclIR9uTIaBn7zPJ6IWuqRdFTJcRpUjp3JpwEM6Wgpg4XtGAdPRmCSWlt7YVipeFT8aEAYQilnPua77D+9Pu4O4K9smBH0GVuSH/5/VPeaiQc7lyDEOS+jU2vfcuHKljIWTeFMeaXo/OEY0S3dGFEd/y6HND5ugJP1zIR1bBhPAZUTPpjga87NGUtcB6UHmXN9MOYr57A148u6QFdUWjrrF4qArClYc9Nhaz6TM460ARkdud6rq5sfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESfIq6mfT/4MM01M4v6RlMXZuItzFTnowdTLAGI/n+U=;
 b=lhn8NkCQKypVv+UMnIKOKbQ2QkK4X3mlvG1QHB2riqnkmC7mLHyuW0j3wcuqjuh5fC68AcupHkP/DiUENhvV9UC5roJqXeC6duAzQS2XJNSOM4sJOCpIRfQdHc+Ihmxo5sVftMAyoi4vB2OCxlBQ98QOtet793RDqp7vDTOT4pu5rTsqtzya/5zVX7YHQlRMSAhQ2erJjisDMQUEPrqkYque/vWxk439dFg6gD/1Ss1hAW1Y2lL7xZqYxaU6esXinIWeYFF5UBcCGFsmbTSq7c6uAJRHB/UB2zmjF5PzkhcYUH8im5UOnwwXl47Xk+SN2aiPWGRyxNvzToJt87ecfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESfIq6mfT/4MM01M4v6RlMXZuItzFTnowdTLAGI/n+U=;
 b=pxiAlIrboBusQam0tHsqVNbazfBhNXXclTWR3Os+AzurwXBTztLW3NXXqZoq/eyeOw4z7dTbMFX36Fpe+0ZAJWW++bbZitIP0ZKrhsO6Stwo5imZHdOjHOJdygMAP2//oGKrwxW2sJi9MIBoKeeftsLYyA/tEK+2WCYShNKTas9wYRmC3vBS65eP2JS8ugYj6kMaXW3bCJNlttnY9gPO7Tv0hujNgZ2JSNiM/uuyktxtunXv5MJDoKUBS3ZArVFBTxyYp3PCq2+h7BTBBny2kmMh33Uj3gDLUjo0IQSu/n/3E6LluvaIOHCHUUzwpevgZ999U27gajxX/BOrVVhqTQ==
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:01:47 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:01:46 +0000
From: <Hari.PrasathGE@microchip.com>
To: <ruanjinjie@huawei.com>, <broonie@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/2] spi: atmel-quadspi: Fix uninitialized res
Thread-Topic: [PATCH -next 1/2] spi: atmel-quadspi: Fix uninitialized res
Thread-Index: AQHa97cYSoMoXj2l7kuppwpnF+OyFbI6ncKA
Date: Tue, 27 Aug 2024 06:01:46 +0000
Message-ID: <ad454e33-9ea0-4b94-a97f-38fd868af247@microchip.com>
References: <20240826125913.3434305-1-ruanjinjie@huawei.com>
 <20240826125913.3434305-2-ruanjinjie@huawei.com>
In-Reply-To: <20240826125913.3434305-2-ruanjinjie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4185:EE_|SJ0PR11MB6621:EE_
x-ms-office365-filtering-correlation-id: 2b585a34-0b07-4b03-5fa1-08dcc65dbb95
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFNKUUVjSFlPOFI0bkZabUl3TDlzSDJiRTV5Q0VMMnFraHpkR0YvcFRVRjF6?=
 =?utf-8?B?YzhyVHZ1R3AvMkY4VVQxWmZrdTZibUZpWlhqdFFIdHRsWnJKT2d2bEZUNjNZ?=
 =?utf-8?B?M1RnY1BNVjRBSUxKbWtNcDBHOWcxWXJBQUo4NE1PbkpRdVFaQVJucEVldXJ6?=
 =?utf-8?B?RGxmVWlvOWhSNkhiRmttYlUvbkx5c3FRdmxITFJDYzZ0RUEwZ3ZueG9XQ2Rv?=
 =?utf-8?B?SjRmYUgyaE85K29rQ2RCOEFEbjhoWlpZVjVhRTgxekFkSlBMWjBoMWlhVjdJ?=
 =?utf-8?B?UFo4Tm8yeWNLR2lrc0hsUFJkQS82UnpPelovZk5tbzUxMkcwaStrY2tZT0V1?=
 =?utf-8?B?SGNiTWxKNWh1a1hYUUF6MEp2RkpKTGwrM21vaXd5ZjI5MnBzNGR2RXE4Zk1U?=
 =?utf-8?B?b1VUQUpaaVB3bTl3MEs4Ui9lVEFjblFvMHUxcGhyckExRzErWXVlUEs3WlVX?=
 =?utf-8?B?TUNjTERLVFBuYjllaFA2VFJmU1oyVUhrcUQxVFRLdkd6RG16TmVNVFM4UGJI?=
 =?utf-8?B?cURPRnNVY1ptODZaVkdqenJiTmsyOFh0V3hMUFR4WXhNbTZ2YS9GZnh3REM1?=
 =?utf-8?B?UlBpUlVUMksyVkE3S3RMUW5hcFliR0wwSkt3ZDNtUzdFalNiUHQzOXVyVW5H?=
 =?utf-8?B?a1VaVnVkY1NTbVNhQkV0MmJBUXR5cno5QkhYR0ZUNzZuWmpKNCtSd0xpalFV?=
 =?utf-8?B?emVCRDdWMkVnc1hQZ1Q1K1ZBa0YwNDU4enRxUmxTdzU4Q0w1eFZ0cWpQa281?=
 =?utf-8?B?clBHbVo1VFRnSlZvSW9DNlIrWmcwVC8ra3FrZjJvdE1LVm5IbEg4UTVBNmJ1?=
 =?utf-8?B?ZTNMYTNZQXdHMURxOUt2N05LUGFIODZoT09FV0phMFV4MDR4eUQrNWlCMWJV?=
 =?utf-8?B?RjZJcVlKMFBGeDhJVXV3Z0xGQWdzdWh5WFp1VnNRU20yd2hXcm10WEF2Vitt?=
 =?utf-8?B?ZS91Z2RlMWFIdmR4RnRXZkRiQVpYbWY0eHBQVURqeUJtcFQzLzBNN0h4THla?=
 =?utf-8?B?MlEwV3FYVUYyWEpFM2FHbWNHdEpWVVdBelBHdXFoK1lTb1hMZk9wb3pLN0dH?=
 =?utf-8?B?OUh4S1FJa0dVRW9lRjhvK3B0QXJXRWkxNXNDL0xEMElPZ1FDRTBFdGVBTnZ3?=
 =?utf-8?B?c0NFZVZhVkdQNjZ6eW8zemVjMEhYaTYrQWgrVFI5V3FxSm5QbU1yYk91MnNM?=
 =?utf-8?B?eEl2VnlQL2xCcXdvUWNxZW1Hd0JyRnNnWWpPYm5HbWR0YlFuM1VaS0laV0JE?=
 =?utf-8?B?NjdqT2V5Q2RXQmJQYnVBUi83ZGhBMUV1L0tuR3VVb1A5Y25CalF6bUlndVFk?=
 =?utf-8?B?UER0MWl2S3lsbURlZXNQb3JDc1NJNzdOUUd2Zm1jQjVYcFJiaXRnZ01Qb3dp?=
 =?utf-8?B?SVBnN2lzR1M1QkYrNHVOYWFxSldpNWk4aHN2OFJVaFNiZFRiRFdHdDBRb2F5?=
 =?utf-8?B?M3VaY09GOVRnRUFnckh5UDExQnZPSVhUOTdyYzBGcDQ4Y2loMmwyUldGR1hH?=
 =?utf-8?B?L3I5djE0b1lBTis4bU9UOEdRcUNHSG1TWmRnc3dqZGx4WkZ1ZitvRXFYYUxO?=
 =?utf-8?B?VkFtd0F5N0FEU3JIaUhJeSt2QXhQaHdlOUVaa2VBOFRrbjE1VTN4MHdRRXlE?=
 =?utf-8?B?ZTBLYldkSWpBdUszZU9xOVlad291VjZUOUpUQzdPYm1FczlHcFdJeElabkVw?=
 =?utf-8?B?ZXRNUGN1bDRYTk84RFBqZVdKSm0wVTNOSGk1K09ESytta3RLWnBSSlZrY1hm?=
 =?utf-8?B?dWEzY3BwRDhjYitjYmphSzBvRVlOQkVBNHVybW5LQ1NobHVCTyszLzNHYlJa?=
 =?utf-8?B?Zjl3bFhIblpMeTR4azVLZ01HaDBpN0pFell0UlZkeVM5T1prckU0YWRrTWo4?=
 =?utf-8?B?eXVkbDRjb0hRdDhWSjRzY2o3T2U4QXI5ZnZmUmh3QkV0VXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZExzUlgrU0JPTnhrcldsWkt1R20yanZUalEzQm1wMWoxM241Z215d2tMNjgx?=
 =?utf-8?B?SHZiMFQ0NzdGWDRqTklWRWwwWWZwWGJEU1hUVzc2eE9tV1NUVkR3MXg5WTRB?=
 =?utf-8?B?aTJyOUJZYmJxcEVkN2JIb21JTFlTS2F6V0VBRmdBaVZEM0kySjRpWWZqTmpL?=
 =?utf-8?B?Yks1ZzBnbjcxTXErNCs0RFpEemJCcnZMZ1oyaXlWYmZkUHdXUWEwdGdOZTR0?=
 =?utf-8?B?SXV4U0hHRGtCNEl0ZnVpVHVIb3ozdXhQbk9SVGVETWt1VFJXMHdaZFUvQXRs?=
 =?utf-8?B?Z3I2aVEvTWZQME1hdEozd0VnNzZPcGVWT3Z2c3BwWnNNTmV0N3hwUU5wSGhp?=
 =?utf-8?B?V3IwSnRYaVprSkxaWUFGZWJYMXZFb1dwZHBzR0wwTXNJRStNRCtUamc3Vzhj?=
 =?utf-8?B?NU1COHQ4bHRibmtxZE5GT2U3ZjJCNGg3Tkw5K1kwdU5qd3VUOG1PN0pBOU1o?=
 =?utf-8?B?VlF6REczcUVYYUcybG1Pbi9UNzBRNi91MnlYait6b29XblY2VFB4Q1d3OVYr?=
 =?utf-8?B?UzdXQlpNU255RFRCSTIxYy9xdTZPTkNMWlhlendRS005UVB0MS9tVnZGaGIr?=
 =?utf-8?B?OEIvUjJENTlZNkNSRlM3SFpERkJSZnp3akxNN0hwN3oxWnVqd0tYYVVEWUlU?=
 =?utf-8?B?aVd1UjJQYUVrY2FLaXEzTjg1clFtbzVKbGtUdTZnaENsWVBWTUdOcmZVS3Vj?=
 =?utf-8?B?WC9xckdFSXhBZisxUEpFcjRia3JJWEI5L3g1Nm5mZm45clVKdHFjRklROGxF?=
 =?utf-8?B?YlpmWEFuZXAxRk5tWU5GWm40dHVTMC9LZmo4WmhaRWNtU08vK0k5eEdGZjVz?=
 =?utf-8?B?M0FZRG9WSjR4Tnp6d1Z3M21FYjhhWjl6ZTBqdU0zS01Nakg4Qlg0NUEvZDBW?=
 =?utf-8?B?STlEY1QrM0lqZTRQYVJZTTNpZGlVc2tzUVBNbVU3UkdBdEJTNTVMUG1ReEFw?=
 =?utf-8?B?Z1FLTXpNdDBjVUxqU2dVU2JDRTlIRUMrT0V4VExYbkIwMmxVWm1mMHBSQnVO?=
 =?utf-8?B?Ym9nbm9scDl1WGNRVFlaellsa2ZJU05USHRIOTkvdHlIQll1dWdra1Yxblhu?=
 =?utf-8?B?Wi9tcTJ4Ri95SEZXUDNoZGw1MGRoR2xlVVE5OUJ1MUxwbEhvbythRlZ5WnpJ?=
 =?utf-8?B?WWUwVkxMVWRqa09DVnFmUE9rQ3A3WGFqeVM4bk12aVdZRm1TdWNtRGJnTlQ2?=
 =?utf-8?B?MkFMaFFaTVppZVNYYWxaVitxTnROY0Z1QjRJeCt4STBHSEN3L1djSjdwTU9R?=
 =?utf-8?B?NEJkUk8vMFNpd2kxRDRzREtwQXJuNHJWTXNJa1c4S2pscXBzRHRRckY5dmR4?=
 =?utf-8?B?d3hyQUQ0Wm9hWUlaMlovNHFYK2pPWWdUc013Nm5TcEtUSkM1S2x1UytRN2Rt?=
 =?utf-8?B?UlJXMXJTamdvbzRRQzBULy9KN1IyRW81VXd4UUVLRlZJaGlWQWpEazl3SmpT?=
 =?utf-8?B?YXlkODEwWUFSRmdqTzkxY0g3bFp5L1RUdU4xaHBGR1J6WHJiVjBtM2Fvb3VN?=
 =?utf-8?B?ZXltOVlVU3Rpc0NYNlUvWmZIbEE0UEFNZ2Nid1ZCTE0vcHB5RVNKZzFIUGdF?=
 =?utf-8?B?M1djaWl2ODJtR09IMEJlWU5LS3BJdFJFVmdvb3M4QUxjcTlXZDcyTmNVdFhZ?=
 =?utf-8?B?L0tyNlhvRnNPcGlpSlpEbG1iQXppVnhWb2ozVlZHQXgrTzFsSEZsSE5SNU1K?=
 =?utf-8?B?VjRHOU1PQ0EzSnptMmQxWnF1MHA5dWJiTkZ3VXB0QnRmR1h0VnlhRldhajZB?=
 =?utf-8?B?VUcrVGVLQmFxanhJaGNoTkptTU9BUVRyaVVabGxON0dxSU9CTFpBMVp6SGds?=
 =?utf-8?B?WjhLV3ZLN1B1MWNxNXFKOGo0bGtBNTVtN2h0dkcyRkRJYklwNFRHa1RGMUt3?=
 =?utf-8?B?MDZQenMyNWlzVXpOZUhRNXBnU2RDbEdqWnVKT1ZvNlc1eVY2eW5EK1lUM0pS?=
 =?utf-8?B?U3RaYzI5Tk1LckhISzJxejlTcFJHb0dHTGdOR1YxbytqbFNJQkM5VzVWS0ho?=
 =?utf-8?B?Yks2T256OFJiTWJPejBQUFhzK05NeFA1MmdOUHhnUjJYZWRsSWdNcGZnV0pO?=
 =?utf-8?B?Q3ZjRnRRdU9Db1BQNTFoR1M0dkc1a3ZFYXJmVnU3bUNVb0tFQ0dub28xVjNo?=
 =?utf-8?B?bWFxVEtRQjRKTGZ3dmRESERYSkJtL0NURjU4dGJ4UEFuZ1pzNWcyV29nbFdZ?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89BA35B02A3A024B96C0C20FFF9B0463@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b585a34-0b07-4b03-5fa1-08dcc65dbb95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:01:46.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgNW+Ja3NCxgckcOJg91e1taqsfUMMEJS86uJwIjuIrmEHuf9tQTpIwCjtZjaZMnKz/O6p0b2IRQhl2ABdfO2UaUuJzaSeGJA5JXluuYmeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621

SGVsbG8sDQoNCk9uIDgvMjYvMjQgNjoyOSBQTSwgSmluamllIFJ1YW4gd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIHNlY29uZCBwbGF0Zm9ybV9n
ZXRfcmVzb3VyY2VfYnluYW1lKCkgY2FuIG5vdCBiZSByZXBsYWNlZCB3aXRoDQo+IGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSwgYmVjYXVzZSB0aGUgaW50ZXJtZWRpYXRl
ICJyZXMiDQo+IGlzIHVzZWQgdG8gYXNzaWduIGZvciAiYXEtPm1tYXBfc2l6ZSIuDQo+IA0KDQpZ
ZXMgaW5kZWVkLg0KDQpJIHNlZSB0aGF0IHRoZSBhYm92ZSBjb21taXQgaXMgbWVyZ2VkIGluIHRo
ZSBTUEkgZ2l0IHRyZWUuIFdpdGggdGhhdCwNCg0KQWNrZWQtYnk6IEhhcmkgUHJhc2F0aCBHdWp1
bGFuIEVsYW5nbyA8aGFyaS5wcmFzYXRoZ2VAbWljcm9jaGlwLmNvbT4NCg0KUmVnYXJkcywNCkhh
cmkNCg0KPiBGaXhlczogM2NjZWExZGVkZWYzICgic3BpOiBhdG1lbC1xdWFkc3BpOiBTaW1waWZ5
IHJlc291cmNlIGxvb2t1cCIpDQo+IFNpZ25lZC1vZmYtYnk6IEppbmppZSBSdWFuIDxydWFuamlu
amllQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyB8
IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYyBiL2RyaXZl
cnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPiBpbmRleCAyYjVjNzIxNzY3MTEuLjU2ZGQ4ZGNiODZj
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+ICsrKyBiL2Ry
aXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KPiBAQCAtNjA4LDcgKzYwOCw4IEBAIHN0YXRpYyBp
bnQgYXRtZWxfcXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAg
ICAgICB9DQo+IA0KPiAgICAgICAgICAvKiBNYXAgdGhlIEFIQiBtZW1vcnkgKi8NCj4gLSAgICAg
ICBhcS0+bWVtID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAi
cXNwaV9tbWFwIik7DQo+ICsgICAgICAgcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFt
ZShwZGV2LCBJT1JFU09VUkNFX01FTSwgInFzcGlfbW1hcCIpOw0KPiArICAgICAgIGFxLT5tZW0g
PSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCj4gICAgICAgICAgaWYg
KElTX0VSUihhcS0+bWVtKSkgew0KPiAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRl
diwgIm1pc3NpbmcgQUhCIG1lbW9yeVxuIik7DQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIFBU
Ul9FUlIoYXEtPm1lbSk7DQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQo=


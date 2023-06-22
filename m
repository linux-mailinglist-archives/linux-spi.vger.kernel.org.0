Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A473A616
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jun 2023 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjFVQ3L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jun 2023 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVQ3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Jun 2023 12:29:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C09E1BFE
        for <linux-spi@vger.kernel.org>; Thu, 22 Jun 2023 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687451349; x=1718987349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GRm1a9MaIZKZJD2PZa2dV+rdTjSJoCRrZ4avhCvMgWo=;
  b=yVON20ZRYbKVraW2gfWkmSn9uftLxvviugUJN5YDPC6Q0cNWJYGa0CQz
   laYpRZOl4Trle0OLKc5vjCNhN885yT/81E2oGhFNfKLNDJj4L2AYwJXcv
   4O9KS6WHklhSoGBnTOKyFyFQMf8b91JOpcSba5b08FAO9I5mL1onCk1iQ
   A8FXLtd+oMvCBX2M9QpzqNvBJBNq4DYf9kep8j43QUPMYuAPqFj2F6pOm
   M/xYpJRQrxlevBURRWsmLjhz4UxW7xeoDmbuAMZUpT1uq03c3HXHhgi4s
   7yN3BYjh9IIJvMszx+QiDz63bkBddqWqIq6JVfPsNgDGMsrllx1j5GCtw
   g==;
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="219980090"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2023 09:29:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 09:29:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 22 Jun 2023 09:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQR0K/zOI0MhuhUvLztfODNkNKCZrJUE32BNdmfoitZYQaV9RgsP6B3JU11ZCBygICpaUEkkHT4Gj6K5Wf+cFhebX4nexpcMNteIubh69VZ7Te+Y774bM//nIY9u6XT2nnxZ8bqYhHGgbDabPWgDWEoB/J38QEnb4CztCeF8n9I23aqZOTZ6yWZxeD3+ZV/Yt+C0XQgE8vkTFFPoYrhtSyr+QfZCUnocwNipJnyR35DyyZO8N8bx04tpHNizGk04uwdc/RKY6O0z2e7pEixoavgfjZFOowlZBzxnPgvmNRXf/WeauvGFkzd0c6N037lfxsWD6vp2IYaU4ZGzsfOBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRm1a9MaIZKZJD2PZa2dV+rdTjSJoCRrZ4avhCvMgWo=;
 b=lS/U8XzvAa21BcFL+JV7j9eN94zUjqu+R/0sdCb0oUF1lOD8DqzadDE8nLD5J4/LM+25ZEySF+bfXPM88KZF+17jjYeWNClbg3VqfDIROaCYbnLQ9MCfOYfgWC9C6Djnj9UBk/8Rxw/hcuEFIazIxdlRbCd4NYCGBc4QGc7UJQiJVYopnKlWEZsEQG6IqevKUt/uSCNQrBf/0ALJz/BxNpzs0JdZXjc9sTLSsqhNL3v02X8dkDNXT9K8+oibK3Z76Q68KDCDwGAtcofDl/nc1GaGzm7I/y1ynr8OTWX2oVFopOFXyYAAFkGOoG35euiYEMTdvrCJQCCPgKNq0NUMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRm1a9MaIZKZJD2PZa2dV+rdTjSJoCRrZ4avhCvMgWo=;
 b=rQenKotK4DIexsUfIBUfN8DKNKWSvGfACXpCO7vDFYdWXwBPxuDgfXBJkMWbom6g8NcLfjz6Fe6pY8e02Z2xSm7NRHfKYQuAnvpEUrbfuovPqnCXDuqYwZO/8J7cbbDfv7Xiyomvr6aSSyD9vyoKvpOO0okpFNxKCc4IVKJl380=
Received: from BN7PR11MB2657.namprd11.prod.outlook.com (2603:10b6:406:b1::19)
 by MW4PR11MB7104.namprd11.prod.outlook.com (2603:10b6:303:22b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:29:05 +0000
Received: from BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::7b00:791c:2eb:8602]) by BN7PR11MB2657.namprd11.prod.outlook.com
 ([fe80::7b00:791c:2eb:8602%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 16:29:05 +0000
From:   <Ryan.Wanner@microchip.com>
To:     <miquel.raynal@bootlin.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <samuel@sholland.org>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
        <tudor.ambarus@linaro.org>, <thomas.petazzoni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] spi: atmel: Prevent false timeouts on long
 transfers
Thread-Topic: [PATCH v3 2/3] spi: atmel: Prevent false timeouts on long
 transfers
Thread-Index: AQHZpOkDTGOYb2E+h0q7UcGO8Uz6Pa+XA5OA
Date:   Thu, 22 Jun 2023 16:29:05 +0000
Message-ID: <035e89d4-03da-e8b3-bbd3-2301548f142d@microchip.com>
References: <20230622090634.3411468-1-miquel.raynal@bootlin.com>
 <20230622090634.3411468-3-miquel.raynal@bootlin.com>
In-Reply-To: <20230622090634.3411468-3-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2657:EE_|MW4PR11MB7104:EE_
x-ms-office365-filtering-correlation-id: 0c22c841-c0ee-4eca-a9e6-08db733dcc15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qv2ywWDFqlhLxeA0x2zM1jMOekhPIxlWla5HqQn2p4gXk5sEsKOM2rITFKUDovJ9iSetFrStd7alZbpoHQYxfVfOqAqlgF4+BBbokQDHGFCCCEas8ze+rcURig1iuIV/E9EYXrf0yrkdAAyD2KvLg22DjZsh0pHkfHxlRLycse/rOU6IQ+KveNJ7OV9ZT5WYG645Wwhqb/bfNik9MUJGpv6xPMqKQcz313k1dbRkPkIfj2E8Lp0PZYa0spGX4h+uoEE7TEr8bctTT49pQS4RyOOwZ6zH6NGpQ4u5stjUUeC30vhJiG65qsNDBMu8tRU1SM1qtjmAFfyKKDH0nF5b8JF6+yXCew3UeAyDJkVkCxXsP7iAI+JIqXyKzgDraxAWCpYAlhWVJqKI3Y2kthUtt/f/LOKHwu/qftCUlKHh0t5TCRxPcoVvqOhBNFAfu/VQAJpbacQN34K/MDZENtHoeCFIKkoF2htYorf02rWC80lq2/+4E7yxIvZ2U91ZFXAicBtT5G6pZILufcLBKfpzFbtw+s7M64j8B91ObCmywA9/wjfj+ME7mEB6zfFPAvceK8Y1ch0GB2DjYtBJWFbXcvplss0vgJ15giOMnPvUiC3yECY/pyGn1Ivi6UZyEdY4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(6486002)(110136005)(71200400001)(66946007)(66446008)(76116006)(66556008)(66476007)(478600001)(91956017)(64756008)(2616005)(26005)(186003)(6512007)(53546011)(6506007)(966005)(4326008)(8936002)(66899021)(41300700001)(8676002)(316002)(5660300002)(2906002)(38070700005)(38100700002)(122000001)(36756003)(31686004)(86362001)(31696002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlNZMGQwYnlEdW5jSEhtSU9CcDJBOWRSY2trNVpoQ2c5S1p6REtmcDhzV2h2?=
 =?utf-8?B?SzNZeTluRXROODZIb0RycjN2Y3h0Sy9nS3JQSkM1QUZ4YU9UUjhkeFE2VGx2?=
 =?utf-8?B?bzBsMS9JdzhPdHRrWU9ySFZQVkZFRHkzL2xsTXY0RHVGYlVtVUsxQmZCMXpO?=
 =?utf-8?B?RmxVZ0pDV2lTVmxVL0hZSGF1bmRaTzJFcE5wclpkcStDZHJIeURob3R1MDFP?=
 =?utf-8?B?ZTdMYlhKK3prcE5UdFZqQXlxZEgwT1pJQkNycUtKeU5uMzNoY3duY1lTb0x5?=
 =?utf-8?B?TjdBN0Z3SXJWQzR2bFBJeVJTOTRuYnVhV1VqY3lMeCsyamR4ZG00Ny9CTFdU?=
 =?utf-8?B?SitiOENQVDdxWVB5UHpnVHJpK2c2L3dRSFhQc0prS0ZaNnVoMDg1aFFsMXRL?=
 =?utf-8?B?R0doaVZ2K3JCVDlYRGN6UXhIUUFPaTcxaFVSOFM1QzVCc2d6cGZtaVVJQ1dL?=
 =?utf-8?B?Z1dGYW1PQ3NyNFRoN2FsdmN4bUVxMW5uamI1RzFqa09CUjNwVk93QVIrcFVT?=
 =?utf-8?B?N05nT0ZqdTA1bDlEb01IQStnMkpvcXR5YW9yVDZBbGx0c3RLY29ndFBXSThW?=
 =?utf-8?B?RTF6QU0weGNLblE5VE1oZGJWQU5GeENvNnpGNUg0clFzTlhkcUkxY0MwdmN5?=
 =?utf-8?B?Y2lwalFRakFPNUhvRTdRK0lwWVdBT2NESm43TE5kNkxJekhWSVdnQXd5cXFq?=
 =?utf-8?B?NGVPOEkrcFQzaGowYkxiVnBqRVdvTHlaL01GOVFySUJWK3UwdXdKTTJFNDht?=
 =?utf-8?B?SCtJYjh5aWlhQzVCRVltUjZFSVk1MlhUYmc3OVdMb0RNMUFMTGxJN1FXV1Rq?=
 =?utf-8?B?UUxkR0trbHdvQmIvN29keHE0dElTWHFVM2ZUd093K2dWeFJtU3JnZ3FUbUpu?=
 =?utf-8?B?NTdoS20zdWdTZjd5RW04M3hjcjlSM3VuUUdjdWJKeG9nZ25sRGhJdTFub004?=
 =?utf-8?B?Q2VxY0xaQ2FIdG5YcDE2bWdLV1I5c3ZXM3dGa25hZmlWbmd0bnBBTVZCNXRL?=
 =?utf-8?B?ZDV3SWJ4QzlNenN1aEE2T1RPVHBha2IxVEk5TFgrZzQ0TVpybjdiVW1Ibm9K?=
 =?utf-8?B?bXFaMWcrQU1uaTdBZjR3TXJpbDBpdDJEZkZLb1BXRzhMSXN6QkFYVGRlZWhq?=
 =?utf-8?B?SUxNeGt1cHM5UXMzRkxYMGRBU0JORzZiNkpIQS9MOUlJS00vZ1ZGenFVdjZK?=
 =?utf-8?B?SElYNGJUSlZISFNEMTNmaEgrdmZxUGZWbGg2YWkrMDBMZHJqOVdBdjhVc1pv?=
 =?utf-8?B?c1VxQllCbld1akR4Mjh2bUhuOXpYYndzQ3hWNnFwYWVzOTMwQWd4bW96UEls?=
 =?utf-8?B?eGVQWkREZzBZV09Uc2hYT0FwQ2xSRzI4QXd0bmxNVTRyZGhmdGZFWnpoajBW?=
 =?utf-8?B?RzM2cEhkUUNOMlNnK3FRcFdvcWYxN2l6Z1dYWjcxS2U3YlpTUlRHa21NaUJm?=
 =?utf-8?B?eUJYUzZ2bmNaMGVUa0E3UE9HUUZOQTJ4aTdzN2xMa3FTRUVTbFJUZjlkWXk5?=
 =?utf-8?B?b3ZZY1c1RWR6V2NLUW9BTHpGVm8reDE2UGxOa1FFeFpmUWVPQ3RVRDJFemRU?=
 =?utf-8?B?b09MM3BzcmRSbGcybHhYaWhRSnlyUkE2RVdsWGlsTDhUTXNYOUpvMmlFcGx0?=
 =?utf-8?B?N2pZWUlHR3NvUGNyWTZGUEJ2b2Nld2E5ZXFQTytoWjJkM3kyWGxZTGY2Yy9x?=
 =?utf-8?B?Uit6ZXdWdU0yRmN4b0RBcE5NZ2dIUjlFZ0xXSjdaTnNJb1NQSmtTUHdOaVYz?=
 =?utf-8?B?UXVYWFZGUDFyTGtZMUVoblhvWXNFZlhDR1A1cEozeC9HS2VweExWRkRYOTJX?=
 =?utf-8?B?THU5OGgvbjJoOTdjUXhwNDdJaTJZOStSY1NqYWwzTEJyYzNmSTFGTlNUU0l3?=
 =?utf-8?B?SWc5am5RNHBTeHFQcVRSTHdUNXIyL1k4OGhzZ2JKWUs0ZmY1V1pUOG5SdThs?=
 =?utf-8?B?dDhnd21PR2YxQ0pZcFdsOW1Kb2szenpmUEt6VFB0M2QxeVJQYUFza3NvSlBs?=
 =?utf-8?B?VlRwdG91WHFLMUpqNTdaTDFSbXBLR0FtZjg2cWIrQVdoQTl3TDdkUzlPb3pW?=
 =?utf-8?B?cnZsWDZoYml2dVhGWTdtNHM4SE11MW50MSs3SmpwWFpUVlcwWTB0TWlXSWFK?=
 =?utf-8?Q?I2//YaHcO+cLuhm8DLBvOarVs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB7756967911D2449DE9EDAC773B1AA3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c22c841-c0ee-4eca-a9e6-08db733dcc15
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 16:29:05.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAvuisCRHrYH6383cxKOyS+Q1C4ecQo/ZG5XISPk3Qwm5rlfMnKsZ0XEjw1MNXXxZJ7iPtf+lo5RkqmBRZQ8rP/8btjCpXeVpHmoapWx5Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7104
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMi8yMyAwMjowNiwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBIHNsb3cgU1BJIGJ1cyBjbG9ja3MgYXQgfjIwTUh6
LCB3aGljaCBtZWFucyBpdCB3b3VsZCB0cmFuc2ZlciBhYm91dA0KPiAyNTAwIGJ5dGVzIHBlciBz
ZWNvbmQgd2l0aCBhIHNpbmdsZSBkYXRhIGxpbmUuIEJpZyB0cmFuc2ZlcnMsIGxpa2Ugd2hlbg0K
PiBkZWFsaW5nIHdpdGggZmxhc2hlcyBjYW4gZWFzaWx5IHJlYWNoIGEgZmV3IE1pQi4gVGhlIGN1
cnJlbnQgRE1BIHRpbWVvdXQNCj4gaXMgc2V0IHRvIDEgc2Vjb25kLCB3aGljaCBtZWFucyBhbnkg
d29ya2luZyB0cmFuc2ZlciBvZiBhYm91dCA0TWlCIHdpbGwNCj4gYWx3YXlzIGJlIGNhbmNlbGxl
ZC4NCj4gDQo+IFdpdGggdGhlIGFib3ZlIGRlcml2YXRpb25zLCBvbiBhIHNsb3cgYnVzLCB3ZSBj
YW4gYXNzdW1lIGV2ZXJ5IGJ5dGUgd2lsbA0KPiB0YWtlIGF0IG1vc3QgMC40bXMuIFNhaWQgb3Ro
ZXJ3aXNlLCB3ZSBjb3VsZCBhZGQgNG1zIHRvIHRoZSAxLXNlY29uZA0KPiB0aW1lb3V0IGRlbGF5
IGV2ZXJ5IDEwa2lCLiBPbiBhIDRNaUIgdHJhbnNmZXIsIGl0IHdvdWxkIGJyaW5nIHRoZQ0KPiB0
aW1lb3V0IGRlbGF5IHVwIHRvIDIuNnMgd2hpY2ggc3RpbGwgc2VlbXMgcmF0aGVyIGFjY2VwdGFi
bGUgZm9yIGENCj4gdGltZW91dC4NCj4gDQo+IFRoZSBjb25zZXF1ZW5jZSBvZiB0aGlzIGlzIHRo
YXQgbG9uZyB0cmFuc2ZlcnMgbWlnaHQgYmUgYWxsb3dlZCwgd2hpY2gNCj4gaGVuY2UgcmVxdWly
ZXMgdGhlIG5lZWQgdG8gaW50ZXJydXB0IHRoZSB0cmFuc2ZlciBpZiB3YW50ZWQgYnkgdGhlDQo+
IHVzZXIuIFdlIGNhbiBoZW5jZSBzd2l0Y2ggdG8gdGhlIF9pbnRlcnJ1cHRpYmxlIHZhcmlhbnQg
b2YNCj4gd2FpdF9mb3JfY29tcGxldGlvbi4gVGhpcyBsZWFkcyB0byBhIGxpdHRsZSBiaXQgbW9y
ZSBoYW5kbGluZyB0byBhbHNvDQo+IGhhbmRsZSB0aGUgaW50ZXJydXB0ZWQgY2FzZSBidXQgbG9v
a3MgcmVhbGx5IGFjY2VwdGFibGUgb3ZlcmFsbC4NCj4gDQo+IFdoaWxlIGF0IGl0LCB3ZSBkcm9w
IHRoZSB1c2VsZXNzLCBub2lzeSBhbmQgcmVkdW5kYW50IFdBUk5fT04oKSBjYWxsLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4N
CkFja2VkLWJ5OiBSeWFuIFdhbm5lciA8cnlhbi53YW5uZXJAbWljcm9jaGlwLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL3NwaS9zcGktYXRtZWwuYyB8IDE4ICsrKysrKysrKysrLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMgYi9kcml2ZXJzL3NwaS9zcGktYXRt
ZWwuYw0KPiBpbmRleCA5NDM1NDhhYWI4YWYuLmQ4N2JlMjg5MDU5NyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMN
Cj4gQEAgLTIzMyw3ICsyMzMsOCBAQA0KPiAgICovDQo+ICAjZGVmaW5lIERNQV9NSU5fQllURVMg
IDE2DQo+IA0KPiAtI2RlZmluZSBTUElfRE1BX1RJTUVPVVQgICAgICAgICAgICAgICAgKG1zZWNz
X3RvX2ppZmZpZXMoMTAwMCkpDQo+ICsjZGVmaW5lIFNQSV9ETUFfTUlOX1RJTUVPVVQgICAgKG1z
ZWNzX3RvX2ppZmZpZXMoMTAwMCkpDQo+ICsjZGVmaW5lIFNQSV9ETUFfVElNRU9VVF9QRVJfMTBL
ICAgICAgICAobXNlY3NfdG9famlmZmllcyg0KSkNCj4gDQo+ICAjZGVmaW5lIEFVVE9TVVNQRU5E
X1RJTUVPVVQgICAgMjAwMA0KPiANCj4gQEAgLTEyNzksNyArMTI4MCw4IEBAIHN0YXRpYyBpbnQg
YXRtZWxfc3BpX29uZV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmhvc3QsDQo+ICAg
ICAgICAgc3RydWN0IGF0bWVsX3NwaV9kZXZpY2UgKmFzZDsNCj4gICAgICAgICBpbnQgICAgICAg
ICAgICAgICAgICAgICB0aW1lb3V0Ow0KPiAgICAgICAgIGludCAgICAgICAgICAgICAgICAgICAg
IHJldDsNCj4gLSAgICAgICB1bnNpZ25lZCBsb25nICAgICAgICAgICBkbWFfdGltZW91dDsNCj4g
KyAgICAgICB1bnNpZ25lZCBpbnQgICAgICAgICAgICBkbWFfdGltZW91dDsNCj4gKyAgICAgICBs
b25nICAgICAgICAgICAgICAgICAgICByZXRfdGltZW91dDsNCj4gDQo+ICAgICAgICAgYXMgPSBz
cGlfY29udHJvbGxlcl9nZXRfZGV2ZGF0YShob3N0KTsNCj4gDQo+IEBAIC0xMzMzLDExICsxMzM1
LDEzIEBAIHN0YXRpYyBpbnQgYXRtZWxfc3BpX29uZV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2NvbnRy
b2xsZXIgKmhvc3QsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGF0bWVsX3NwaV91bmxvY2so
YXMpOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiANCj4gLSAgICAgICAgICAgICAgIGRtYV90aW1l
b3V0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZhcy0+eGZlcl9jb21wbGV0aW9uLA0K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgU1BJX0RNQV9USU1FT1VUKTsNCj4gLSAgICAgICAgICAgICAgIGlmIChXQVJOX09OKGRtYV90
aW1lb3V0ID09IDApKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnNwaS0+
ZGV2LCAic3BpIHRyYW5zZmVyIHRpbWVvdXRcbiIpOw0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICBhcy0+ZG9uZV9zdGF0dXMgPSAtRUlPOw0KPiArICAgICAgICAgICAgICAgZG1hX3RpbWVvdXQg
PSBtc2Vjc190b19qaWZmaWVzKHNwaV9jb250cm9sbGVyX3hmZXJfdGltZW91dChob3N0LCB4ZmVy
KSk7DQo+ICsgICAgICAgICAgICAgICByZXRfdGltZW91dCA9IHdhaXRfZm9yX2NvbXBsZXRpb25f
aW50ZXJydXB0aWJsZV90aW1lb3V0KCZhcy0+eGZlcl9jb21wbGV0aW9uLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkbWFfdGltZW91dCk7DQo+ICsgICAgICAgICAgICAgICBpZiAocmV0X3RpbWVvdXQgPD0g
MCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZzcGktPmRldiwgInNwaSB0
cmFuc2ZlciAlc1xuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhcmV0X3Rp
bWVvdXQgPyAidGltZW91dCIgOiAiY2FuY2VsZWQiKTsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgYXMtPmRvbmVfc3RhdHVzID0gcmV0X3RpbWVvdXQgPCAwID8gcmV0X3RpbWVvdXQgOiAtRUlP
Ow0KPiAgICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgIGlmIChhcy0+ZG9u
ZV9zdGF0dXMpDQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg0K

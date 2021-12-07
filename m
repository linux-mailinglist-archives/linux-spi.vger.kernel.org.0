Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFA46B471
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 08:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhLGHvj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 02:51:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:47584 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhLGHv2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 02:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638863278; x=1670399278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Myc391iKp99OLEE2VIgDCk5ngH9jEsGrgwC3zihb7jY=;
  b=DWgMrUls24w7q6tI6VOl8NKbG2V6iAxaGplN2FAjXqSQLz8UoMUnm4Io
   ifQCfVeS1ELeaBFpsiYlatuoqeGzM3yhLolxTCnTUG1PLzdu/UMu+HioY
   at9CWG3SyJnFHN9PNbdbviFTuPoMc2lfQPMMQRSJIW7AF7TtUDZoEFV1l
   ulrQAoD4fWqPEkvmgJhLhy509LsINkcR+hBcANccWXZ1rerIlJRd7Qp7r
   8jfWXPxDxBpTRfiFBUa7bQBoZJVjIDkkTqV1amzk2IhVpwf1CiOd0KXzU
   Pf16/M6fOGYcoemfNZcz8Am3dLQaE7W1zWX4Q+3Pks5DZ9ZCXXcPhdsdi
   Q==;
IronPort-SDR: n55mbTDiPuxTqSqhq5IwAMioI2PNkoU3q7/OQTv31+JTt8uiL7xjoAi8tX2I4Cq4ZdWxmvhFEa
 aqW7qTHWqaltdvWjpwtCKM6TKFcBoiKxHisatLpNSTvBPQXGuG3Z3nciwH6p/96765KYcicXO1
 XZp5tu29eTlVJoDXEmXA0OvnyBWhczSo5UpcEqgxAr4EBGW2EQeQ9VV6w/KBZwnTFNUQA6Puc3
 SfkzQFpFlFVCv2wC1iE4seoi4j0Rgs933O7pKmQGgh95ENu7ELS+9TJQK4ADCwAvJYYYJViQSp
 t2V5wgXM34Bdy+I65MeKLd4L
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="141530697"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 00:47:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 00:47:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Tue, 7 Dec 2021 00:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/L1hmnGbtTjoIwV9vmNOW5OsyZycMSqr2aF55TWazRxtwxHfmfWLt78r/mAeSeb7Onqwc2oos5YBgyjO7Lo6dzDiJts4MnIJ5e8hdI2I3rfF4rx19Fcp+CeV1bhARj6Exp7QMZrxohoMjCy6VuVm8QSeicyE+565uJriyGRigFPRj3Ef71CCcAhXazQeYKpYqEIiTOhw8a53U88pqQQJATNU5uCIinm/YNkH2NVJlZu0/AmjbOEJkAaXNuzFBN2MN+7gl1ERPEfiOiRiiPZbWB0WgPuXT043sfQESift3k3mVdElLs4Sq+c1urBtn3H74fOTHZJNIbcJA4PAniDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Myc391iKp99OLEE2VIgDCk5ngH9jEsGrgwC3zihb7jY=;
 b=T+Ku401pvAuAP+eaPnJaVftUJI+LkBHsF6sdphdgLfhRXQttdyf16X+auuGoXn1lyODjo7S582zO0RWM/qc0JBqvHYoHrnCS4aHfxX6oTJEJb0u4CKYatTAuxXz+t1BXwY1KQl6EjCutpyMv5CaYaLM2mTptPuhPH30NFk81y5FeitggqU4qk6cON6oQeHsAiTc9ECPjdrOizrkjVGjsRm+nbAqrfvqLCQIgkiQnnGxLBeEws/W8PLXymDASQhMuaYI90f0Uzhb9LjlGl46YS1pZmcPl43PwvUcUdX64WtFrZFr3DeKSxP6SFCvmgCeoO/iRTESVs1TYoC3zFO4n6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Myc391iKp99OLEE2VIgDCk5ngH9jEsGrgwC3zihb7jY=;
 b=psgnxJwkjAdlmhHTujlatWkGnX+jYFVZI6Qjy8EUGW99fYPpJwu658TMVsXVaELJCotEjJyhitYHTExfe5QCYkiF6cn3YDZNxF3pVo/iYj7Ijz+xAmweuIR0xIRqEUc3e7ovGRkC68G426fXUej7Ki1OALNEHDSeEGF54vs9kYs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 07:47:51 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:47:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
        <monstr@monstr.eu>
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Topic: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel
 memories modes
Thread-Index: AQHX6z0TCMDia/NjPUS/CLh9E6BmLqwmpcIAgAABPIA=
Date:   Tue, 7 Dec 2021 07:47:51 +0000
Message-ID: <e99a977b-87dd-9e9a-62ea-ef544dfc80e4@microchip.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
 <20211206095921.33302-3-miquel.raynal@bootlin.com>
 <20211207071406.c2ajc3shqybevvjj@ti.com>
 <0d97a420-685e-5120-3c09-d433382c02aa@microchip.com>
 <11cb8408-1c5b-de83-dec0-5ec67305e772@microchip.com>
In-Reply-To: <11cb8408-1c5b-de83-dec0-5ec67305e772@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 040bb5a1-6f29-423d-01c7-08d9b955df0e
x-ms-traffictypediagnostic: SA2PR11MB5161:EE_
x-microsoft-antispam-prvs: <SA2PR11MB5161E8D3893021DF97230EB2F06E9@SA2PR11MB5161.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PDMSaaK4TzHE1BWlUmqRJ5bThxKdjYLTcncUTQlbYbPDB3qOui9GJNWNFm4q9ZPdUcc+4a+a9Rh1HpEIWAMD2UFQrfoduzecJABZF3Xjf61k4HLR9NbBWEwR/9vwhZ3bEDHgS23p/N7yFImWmIZpdAj5KBNKspHneJ2XqKo58xloRprZfpGJZXfZqAhz6pKeig1eTVgzIX1+/CrtpAVJyrBm3XCh9msoQlaj+hoNx5QKqAl4dpOB3kJHBpgdbTvfnU9xE6ft6p82ywW51U+QTzuS6L+L5AxSCYvmgRmxpll4V3v9PiOet2yAY3rK3h8Y2q82Bu2NdqAJTaHyY2odKpcw4B0qlWLKNXtsweeOS2T4F+cwJL7Vb2tAYyKte48tzay4EeaFKr1BGsPgBOu1SyeF//K9HK5vex8I3tOIICSGKK1D5NjkCP7cSulIksAiCWfq/aKwckQIWBab5TqBdNMBQxvKI472lzMwbqR5u356K5w3wrVh0xqiK7xiapBMG8aPz6P5UdduSbkAYHEICoke9iugP85GawhYXxWxvAdtkGATB7glKxta5JhPJBAC9nEYfisZXQdK+BpmCIXNSxcUldq0/FcZyUg+KTa2tvZwGMQMtt6UbkAYzL1GDqY8HxFbAQMPXVyewJvqCyyOzo831FuE9GC1yHwqOZ9kSuUhIuTAJJKVeYSjjYdu/VVHYoURzz3sftVhvxYMe0BusU8mVoPb4RkJKtD49G6AelYOBR3+BuaCpBNQA4yqgEuBRXN87sjD6SpdGnjrHPH+UV4HIaAICMnNkQ3GqgXkPzWZNGHQrbrplzWPQZeoko2OYaYIs+3RCvVGAfnA124mBhDqDfb5bXPx2QyBB2K/ERc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(66946007)(110136005)(966005)(91956017)(71200400001)(54906003)(7416002)(5660300002)(31696002)(86362001)(6486002)(64756008)(38100700002)(66446008)(508600001)(186003)(66476007)(76116006)(316002)(83380400001)(26005)(66556008)(4326008)(2616005)(36756003)(2906002)(53546011)(6512007)(6506007)(38070700005)(122000001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHJPZ1N5N2d3ekFucDhDT3dEd1ViQzdaemllTTMvemVXZWNzREhmeUJoNmNO?=
 =?utf-8?B?Wk44MEF0OWhhUE1XUWhhWSt0SGt5d09ta0tBSW1SdDhuNWJET21iNnJvb3ZJ?=
 =?utf-8?B?NjdBOVpSSkMrREt2R29rVTBVMlJnWEZ3SjBQZm8rV0xXYWR1dXhSN25ZVG5m?=
 =?utf-8?B?bUZFUzlzTXVSZXh0SzJiMXJaRWlXUUlPR1RtcU92S3B5WnIxR2I2anJMeVlC?=
 =?utf-8?B?K3dwYTU1VUdyWEh1NnUzK0hJaG5BSjV0MklXVlkyaHdKeGhKTSt3a0lNRmEr?=
 =?utf-8?B?T0lPYzNDRG91ajMxSERBTkRTRUMxZlY5SGduYWdEbUZUb1hBcWt0U3QyenRw?=
 =?utf-8?B?bThzK3BTVzVvSHlyZ0l6V3ZJNUI1VFdoSmFvYmprMkFEaUUrb0hlZ0dQSDZh?=
 =?utf-8?B?V0dVTXFZRnU5RUZLZ1FWbXNacHdDUW5DY0ZBcVpGd25MTTcrUlVzTGNVOGFh?=
 =?utf-8?B?V2pJdXdtQ0xTTnBtK0tHdHRmcmUrSzNnbXY5cnM3b0hKbHluZGJ3d21EWVZE?=
 =?utf-8?B?SCtEL1pTQUNsdWlNanMraHowSHZaOWdDTHFuV0JyWFhYUFN0V0xFSTJKSGhR?=
 =?utf-8?B?V2tnYk5vR1RhVEg1WGk3bGhkajRoa3pJRVNpcFMzdFFlREJ6SGZKdVpoMFNp?=
 =?utf-8?B?dHAraDJJdHM0R2JsUWdhN0Y0SFUxWjFiWTRleVFGZXFpeStRZG9WbUovZ1U5?=
 =?utf-8?B?SnVWNDVkUjRmTmdEQlhKL3djZE56amtVdmJvZmN0ZDc3S1Y1aVZPMm80N3Jx?=
 =?utf-8?B?SHAzdXRhVmUwZSs4dnVCNHN4S3lmS0VwVHcxSUJEeU1lQTZva3ZYN3ZxeVY2?=
 =?utf-8?B?NUFFUnlXaERLK1hOTmQzWTlqbWlpUGpTZFhyRGFUd25Xc0NxQlNyRHFhUVNY?=
 =?utf-8?B?NG1YcjJyVDhycmpEMWdNRXEvK0hCbTBmYTZ3MmtjdUlnazFMWnIvSFJETnYw?=
 =?utf-8?B?bWNUMXpHemQxcHNwU250N3ZXc0I1SVFNRzA4Tk0xN25aVkFMMDBwSGlISWtl?=
 =?utf-8?B?TjdsaStzM3pRMkxuSjJ3eU5BcEIwTldianFBd2pRQ0hSd2ZSR2xQdWNtR04z?=
 =?utf-8?B?ZkEvYW5iSzNOVGdzdHZFNXVxeG9KWHBCcVBzbUhsMUNROWRIdlRGOXZlNmJi?=
 =?utf-8?B?a2NTQzFac1lJTHN2TGZVYXVOK1dMRk5MUFg3SThkUGVrcG9renhBdFZPcU5o?=
 =?utf-8?B?VUppZG84U3VNT0VVQk0wUzNmZDNGT2EwVkkyTlh3Wmx0d0loOTVPUVphUGw4?=
 =?utf-8?B?RmExbzVmRmVpM095Y005WUtzMlZqNEFRdDFnZXBBTE5nZ3hzVmQxbVQ0S2pU?=
 =?utf-8?B?QWxSRXVzWU9hN3A4S1BqWERXRUlHdFFuSzV4bEpaelM1ZFBCNEd0VWlZWGpa?=
 =?utf-8?B?bWpVZExJb2Mzem8rc2ZHMGIxVzdvODBzck1ydWhqWStnSHg1UjFkV1c3eXNZ?=
 =?utf-8?B?T25jd3ljYXBqbmNOTllBYUUvK2R5c0JaR0RnYjRPZExMcFpxRDBlZ3J6ZUs5?=
 =?utf-8?B?RjJnWVBoQUxmQVdjek41RUUybjAzcnNVU2g4QmRQalN1UVB6bzdHMTI3RUZP?=
 =?utf-8?B?dTE2RHlpeTQ2MUdLMzdRY1NobFZpNjJsQlNMWFcwSzU5M1hUOUQrVEFLRVIy?=
 =?utf-8?B?V3RsTm1YUVZtVEtXSTh4SHJTbWkyK0VyUzlGaTJKdTk0MnBWUzg5TEVzMk9L?=
 =?utf-8?B?TFhZRTJBcXFqOTZXSjVMVG1iVlNGakRwZnAzMkVNVUx2a2M1bTd2WHlSMXpM?=
 =?utf-8?B?MUxITzU3TlhtMXEveDlaaW5BL1NpK0pOZ0x0aS91Skw5cERNVG9mc3pyaFBN?=
 =?utf-8?B?YXg0QXhxUUxvaGNnY1NqRTJkUDgwWG5IL1JGUXlVc1FTdDBxTVlFNTdBRDVl?=
 =?utf-8?B?V0I0bDI5bU1mVGJCTFhMOUZyRDJpenNNRFBRQ3IxN1lMbVBReThaNFhRK0xC?=
 =?utf-8?B?Z3BGMEc2clJhZ0hEUnZQd3o2eWZ6ckkrbkFYalRuOHQxNFI2OGxwaWIwMkxs?=
 =?utf-8?B?QWsrZmllNytUZkhNNEpCeDJLU3JteEFjYjhYeEVRekdjbnMyVkgyalpYY0l4?=
 =?utf-8?B?WjREVUdvUG82Q0x0SEpHazl6WS9ZUGZTSjBoRUZVR1F6OW5BNWhnOGFucTJR?=
 =?utf-8?B?TFcvU2ZXR1FrUlNVRk53NnErSXJsZ242aGkrWUNzdU1DNzFGVWM2Y29PS1dI?=
 =?utf-8?B?VmY1R0liYUp6L3JqZUFGeGoyWENYQUxUR21wS3hLU3BSdXJCS3pkeHU3bHhT?=
 =?utf-8?B?ejNKOXVzd0FPMVFqbmdWY3lHb0VnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7117E0141C369A4AB0B829B16B5F9B9E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040bb5a1-6f29-423d-01c7-08d9b955df0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 07:47:51.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHUOm3Bep4m6WvMTIDSuJ7+SGncRriBhWMF8nV7dq+o4Yz8QqQ0qz/p1SqCS8xwXCF/2Qy2L/QDZAYIG1B0nlF7cBCJKlU4U6bUkR+7M1SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gMTIvNy8yMSA5OjQzIEFNLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPiBPbiAxMi83LzIxIDk6
MzUgQU0sIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBPbiAxMi83LzIxIDk6MTQgQU0sIFByYXR5
dXNoIFlhZGF2IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
Pj4+DQo+Pj4gT24gMDYvMTIvMjEgMTA6NTlBTSwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4+Pj4g
RGVzY3JpYmUgdHdvIG5ldyBtZW1vcmllcyBtb2RlczoNCj4+Pj4gLSBBIHN0YWNrZWQgbW9kZSB3
aGVuIHRoZSBidXMgaXMgY29tbW9uIGJ1dCB0aGUgYWRkcmVzcyBzcGFjZSBleHRlbmRlZA0KPj4+
PiAgIHdpdGggYW4gYWRkaXRpbmFscyB3aXJlcy4NCj4+Pj4gLSBBIHBhcmFsbGVsIG1vZGUgd2l0
aCBwYXJhbGxlbCBidXNzZXMgYWNjZXNzaW5nIHBhcmFsbGVsIGZsYXNoZXMgd2hlcmUNCj4+Pj4g
ICB0aGUgZGF0YSBpcyBzcHJlYWQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBS
YXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgLi4uL2Jp
bmRpbmdzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sICAgIHwgMjEgKysrKysrKysrKysr
KysrKysrKw0KPj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3Bp
LXBlcmlwaGVyYWwtcHJvcHMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPj4+PiBpbmRleCA1ZGQyMDkyMDZlODgu
LjEzYWE2YTIzNzRjOSAxMDA2NDQNCj4+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sDQo+Pj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFt
bA0KPj4+PiBAQCAtODIsNiArODIsMjcgQEAgcHJvcGVydGllczoNCj4+Pj4gICAgICBkZXNjcmlw
dGlvbjoNCj4+Pj4gICAgICAgIERlbGF5LCBpbiBtaWNyb3NlY29uZHMsIGFmdGVyIGEgd3JpdGUg
dHJhbnNmZXIuDQo+Pj4+DQo+Pj4+ICsgIHN0YWNrZWQtbWVtb3JpZXM6DQo+Pj4+ICsgICAgdHlw
ZTogYm9vbGVhbg0KPj4+DQo+Pj4gSSBkb24ndCB0aGluayBhIGJvb2xlYW4gaXMgZW5vdWdoIHRv
IGNvbXBsZXRlbHkgZGVzY3JpYmUgdGhlIG1lbW9yeS4NCj4+PiBTdXJlLCB5b3Ugc2F5IHRoZSBt
ZW1vcmllcyBhcmUgc3RhY2tlZCwgYnV0IHdoZXJlIGRvIHlvdSBzcGVjaWZ5IHdoZW4gdG8NCj4+
PiBzd2l0Y2ggdGhlIENTPyBUaGV5IGNvdWxkIGJlIHR3byA1MTIgTWlCIG1lbW9yaWVzLCB0d28g
MSBHaUIgbWVtb3JpZXMsDQo+Pj4gb3Igb25lIDUxMiBNaUIgYW5kIG9uZSAyNTYgTWlCLg0KPj4N
Cj4+IElmIHRoZSBtdWx0aS1kaWUgZmxhc2ggY29udGFpbnMgaWRlbnRpY2FsIGRpZXMgdGhlbiB0
aGUgZGllIGJvdW5kYXJ5IGNhbiBiZQ0KPj4gZGV0ZXJtaW5lZCB3aXRoIGZsYXNoX3NpemUgLyBu
dW1iZXJfb2ZfY3MuIEFyZSB0aGVyZSBhbnkgbXVsdGkgZGllIGZsYXNoZXMNCj4gDQo+IGJ1dCB0
aGUgcHJvYmxlbSBpcyB0aGVyZSwgeWVzLCB0aGVyZSBpcyBzdGlsbCB0aGUgY2FzZSB3aGVyZSB0
aGVyZSBhcmUgc3RhY2tlZA0KPiBkZXZpY2VzIHdpdGggYSBzaW5nbGUgY3MuIFdlJ2xsIG5lZWQg
dG8gZGVzY3JpYmUgdGhlIHNpemUgb2YgdGhlIGRpZSBpbiBzb21lDQo+IHdheS4NCj4gDQoNCkV2
ZW4gYmV0dGVyLCB3aW5ib25kIHN0YWNrcyBhIE5PUiBhbmQgYSBOQU5EOg0KaHR0cHM6Ly93d3cu
d2luYm9uZC5jb20vaHEvcHJvZHVjdC9jb2RlLXN0b3JhZ2UtZmxhc2gtbWVtb3J5L3NwaXN0YWNr
LWZsYXNoLz9fX2xvY2FsZT1lbg0K

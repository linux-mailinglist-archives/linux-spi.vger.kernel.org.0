Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0976F46B383
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 08:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhLGHTz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 02:19:55 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16623 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhLGHTs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 02:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638861377; x=1670397377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6kopKcV0NnVOHfxCmwuzjDlEIx+SGeuK7XR6mECGhzU=;
  b=paGFGXCdkEsRWO4Q7wCDXeI4K0O0CtxDFSR7J3KfEG2OKA8VgyTOxSl8
   Gj+R85nUK+Sr73Illiv4hQzWdkv2Otlvx5aGdhBlryI7k4MY0aT9oDxg3
   SxShjLcDC0CTnyUxifP6s/9qXnXorinAyMMQVaABM4SDLKn28pMu3L3Qk
   oZCAKA6+LT2uUHdkyHaDFlUdmhOtrdJWs60si7QPLus0ZKAbGGV5kNu7W
   jYuGHaNXV2XpwdBgDI831Uh3mv3W4JKQSveTpkN6ZMWnnDv9nbDN6xwm0
   ZO1xpMGPrzMDEOpkI7BUkBTUVyVuZkvDRslYhyjdDebzXA0Ms3I0AgHc4
   Q==;
IronPort-SDR: n0OXVIg9zNj+1uAfAGd5TUe2hMHzQaDSlVUKD2um//q2oZ8DUMR5zaLytWhuWO5FjEkIGal7jq
 EW4yOMj3Je75wZlucEmbPSaSGqC10xxDjd34VUKzGKiB/Cgc9LHvxRxs+2iDcijMa4MEaJao5D
 6s71QpJDQOQyAs6cfJkaaUSeuEb+EXi7WFzdBGtWLllburwSlcpto+D88V6Xr/qVDIUUFftcsu
 xPUA5BHvsQ2x6DikGK1yMPx/967NXy2QKrChbUZ1Ak2yBiagJDps43ib7jAb2pbDPvvDne1QDI
 E3Ut/XPeCZ7iykPdkszqNnRD
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="78726252"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2021 00:16:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 00:16:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Tue, 7 Dec 2021 00:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKD/4sGFssZqYBhnoB6DsHIlEFZu5HAnHFPZ0ZzNW11Oe9pA7KQUfQrt98C/i6ApK4i/I4eUC6kCjv/KrlYaE/GrKzL+PBPBX34kD9W738+fYYbkZwvfho8m7YZ2Idw1uvE+XTilWiKy3DK4YZhaaYPJkMju9gStvPRLQm0Ewrzea08yKfIl88058G1F53b/tGNy0gPq+XQjj8MEosjHgzvGPD+TqcMmxdiV/j2udmIhICqkRcRZvvvT1wsIjb0GduVkMEqoOwiXy++1jvzYso1ViF5tGhX/fQ2WOvZDbDddv50YCr6JSWBsbTOg1zFaNolli7diFfqUOFF/IhZRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kopKcV0NnVOHfxCmwuzjDlEIx+SGeuK7XR6mECGhzU=;
 b=PUuvpvBBMt4NKYqZTUCE0wNtJ+0IrNek8kh+rDpnME8OEHtvXtuA7FuZJid0PxV8UworAJH8kjs2g99tWcAqxjIEc73x1BAdVAJeZNFSBI9r54wrLiSjKPQL/BO5rc5jwRja70S1TIdjQjZxUnj7X84sP6OE8Td+BNdu8yeRcUk6cQP/3pAK0YV0zLgrDFPjYOy0ZMDdwod5zwgUEfv8vA1NqiBkXjp3taGaIknz8yirfbqyx7PmLJvCdPSlKXtj4KiF6SzFSr4v8HIGAA9KQlepATNeX5licJzCkRmKWyq4RxejcD1sxpwIK0jmuyxoitkIMI1EHFTa4evJqfp1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kopKcV0NnVOHfxCmwuzjDlEIx+SGeuK7XR6mECGhzU=;
 b=azzQ6EedwiNXScMEbsJfx5yqepecEieAvXhjf5DCl0UJmDeYplIwAdvMPzEq4J64BIxD7zQbPCHlGeCAOLJZZBNcG6F9JM5JpOuUhEHymjlIkoCS/bQsdYi1NPTUsVGt4/sR3yBtgZ++4efh/lZAUFc2H82fgbkRKJbKl3TQli8=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2879.namprd11.prod.outlook.com (2603:10b6:805:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 07:16:11 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%6]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:16:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <p.yadav@ti.com>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <thomas.petazzoni@bootlin.com>, <monstr@monstr.eu>,
        <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: spi-nor: Allow two CS per device
Thread-Topic: [PATCH v3 1/3] dt-bindings: mtd: spi-nor: Allow two CS per
 device
Thread-Index: AQHX6zpPa2neF99SbUKO4wTGp8yJTQ==
Date:   Tue, 7 Dec 2021 07:16:11 +0000
Message-ID: <e5d05d00-8823-f9a2-156e-ac0c268d705c@microchip.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
 <20211206095921.33302-2-miquel.raynal@bootlin.com>
In-Reply-To: <20211206095921.33302-2-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b2ef06e-9d79-450b-2427-08d9b951729c
x-ms-traffictypediagnostic: SN6PR11MB2879:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2879FB4066D0E462CE4D6DC5F06E9@SN6PR11MB2879.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIDWtzsmx3gL+eUIR+epH5nUz6mygx7x9ulJhNXiHPnJY4EZ6Z4Jjd6RzrzEzOmsRh0Ly60mIJyDdgRdzWTbaoT+B2Xk07197qs702w6nN7lD+vKgerdhjumOETiLRss4OMsPIQ2OmH+FB3YpKWhFdDB4I+zgWHSqv4b1n/mgszNkKfAgZrU4gZkRCgLLrJBnbQIer174vrRt4SDnIRsAhte3/b41U4VzJq2ZB28rqM/TZBZSVZ9xpulWdEI2vBgsgldyJZ+5OVZA4QQORd7KwUXj51lStO8KMjKA5QoYKxHmhAN/j51ED05IlC9cNlkRriXAGXBKMesgh1K1SjV1DNuKCc98/M74/gkUtMvCf85/uPBNyIpcUKWM03GzPCRtPV6mcaEutNujZHX1nmhEpE0rsKh8GcAImBnTirnR+bf3Voqd2JrXP+VLPv043SPL/SxmbP6yxL+oPXUqfX38Uag8DA7u3rVVxl+FCnm7VBZ3vR097xUDKYAIxRRY56jLgKM6lBN7e40nvh05JngHBWCiRVwItDX9+3R0LeaKluVLI2DYLNDgNvxPbZR4xaRRg5e4CupY19306+zFN3Ep1KBgro5KBhmOJtEL0a6i2nsPHJ3T6lp26kCcZW/yefF0ThbjTlVZMx5MSZuPEEfU+vXxmuXUPeoNB3BiJqPu2/Lbb2OJ/fjayxx8n/hh2HNgJeIIDwfhf41qw/mZZJvScdb0jgkWBbphiT4pdxgPkSRCj30aVjeUJApCe/6EcNeBl/3XkvA9ocykxFwMhQZWj16o5WCul3cTZz/ZUVQ0npwgk9QycPpw6Sovj7xS4hQRAqimJtEn8BVcCc1iz3np9ro6Htdu73TkHHalMKw+o7OVNMz4WfAbu5sGIiTeZEr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(966005)(110136005)(38100700002)(2906002)(6486002)(7416002)(6506007)(53546011)(66556008)(921005)(66446008)(64756008)(66476007)(71200400001)(31696002)(26005)(86362001)(2616005)(186003)(122000001)(4326008)(8676002)(6512007)(316002)(5660300002)(31686004)(76116006)(66946007)(8936002)(36756003)(508600001)(91956017)(83380400001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG5yblZyTVFmYlByU3pXdXVkUk5LeVVwM2xhMzArRHVPZE1CZUdWekdVMHIy?=
 =?utf-8?B?L3NYeGxCQW42SkZGRk9ib3NXU0xjc25nY0NOMnQxRld5QklQU1lBOFZ2STZx?=
 =?utf-8?B?eGQvTnJNL3JkazFrR0k5Y3dKYTUyeDFqdlBtQzUwMGhmeEc1UW8zS1lDcmFZ?=
 =?utf-8?B?TE1SNjM4ekR3eVhJbDFPMVhYZjFYRUg3c2ZvY0dSVXZTc3EwSHhPWnNWYUND?=
 =?utf-8?B?blVzMlRybVd3cStuUDZrWWdMM3M0NG4vMHFGVTJDU0VBdXRrQ2NIUnlqS0w2?=
 =?utf-8?B?UEpxalNlZURoZHljSFlTcmpiMHR0ZHI0RkZjRWdqVC8rcTczYzFrbnNaUU90?=
 =?utf-8?B?NEZHNGxEdHJUcmNWN3o0d3ZOaW01anlqcXJqeVVmRUw3R0M1RHhIT0llU2ZB?=
 =?utf-8?B?UldoWXNwakNoR3hUVzBmbWNhZnFhaUZNWm9OQTdCbmNuSzgrMnAwSmdZQ1Jz?=
 =?utf-8?B?dzlzaEtIODV2eEJjaTFxd2h5akFlcExPSzRFR1BJczBtR1JOTzJtVWY0cG5H?=
 =?utf-8?B?WGFhYkpiQTBTQjBWNExWQzV2NTQ1M21QWkVpY3dTSkpmcmRyNGZUT1dsZXpS?=
 =?utf-8?B?cTJnUHJKUThWNjNJbG1PMUNUTnlobmJESm1CQXozRlJIYmdwaGtOMXNDTHBJ?=
 =?utf-8?B?cUR6blQyaE5SUzAyN2IxcE1DTTgxeU1rNGxOMVo2ZmlINk9HSEFvTDVKU1ox?=
 =?utf-8?B?SjBsUEcrbmRUNTFtckhqZHhKK0xMUnoyQW5hMVFKMlduVFc4ODVZS245b2Zi?=
 =?utf-8?B?cXB6aTRtWmNmVUZQYjFuV1Y3dU5vWVkwMzJicHM3OGN0Zm5zMi9VZzBtV3BB?=
 =?utf-8?B?VXBzQmRGclJhYUY5VUp3RVJTQXBNbHlvZlg1WXJheWhTL0Z0SVd6NnZLVHVL?=
 =?utf-8?B?Z3hDSDJWUTB3NzZTOWJBb0wvM0RVQjJtaEJDWUQ0OXg4MlN0K1pqUXFjclN4?=
 =?utf-8?B?M1Y0RldORGRNMXlGQldBRzlKcXpMWXdEakR2RVlnVTI5YkNSbGpTVkxkem14?=
 =?utf-8?B?MnV0QUtOKys0Ukc5aTFDWHg2alh6MXpsQWNVZUR3UnhVeXZrNDd5dWFaTkJ0?=
 =?utf-8?B?MFJJL29hc1oxWTB1OWJ5dy9pRStUL0ZjVnY5Y0dXd3UvenI0cmpBZE9zeUhl?=
 =?utf-8?B?N1I5QXBKV0xrUkRINk5LUEtYK1Qya0lPN1loMjZIYnNNUVcvbkRRb25MN0Vm?=
 =?utf-8?B?Vmw2MXJ3UzdnSU50SU5yTGxqK0lQS0Nud2xXM0ZOOFNtNXNVVnk0WUZFS3hJ?=
 =?utf-8?B?aHh3K2Nwc1MzM1JXL0NSTmlnc2pqZ1I3V3d5UDNrcGhqZmhLUGJBRyttN1dv?=
 =?utf-8?B?WFJDTEtPODJhaU1LSmh1TnBuSEpXVU1nMjk5SlhQTHFNQTZQMUZVU1VMNzBt?=
 =?utf-8?B?dUhJTU1FaW9BYitGRGtnaHE0SSs1c0dJMlB6eGN2Z3B0VzdrcVRoNmV6YUdo?=
 =?utf-8?B?RzhZVFJpdzhTQ09qRXZON2FSTDY4QzZ5c1JxTnJxSVowejRjVnBuWW5VWDEy?=
 =?utf-8?B?dXFQb0VnVjcvYXpiTStDQk94bHpYeUdLWEEzRmx1WWF3cmlIa3YyMWhYcUUx?=
 =?utf-8?B?S29kbDBOdjNuVzV5WjBGb3ltWElNQTFTNjdlNlBvdng1dlllVG5zeURJd0Nw?=
 =?utf-8?B?aXRDeWgrMkFSRGJKWWk4QTZSMThKTURtdlNRQUxRTXRvbkFhOUxnYngyelFE?=
 =?utf-8?B?cStldlJDL0w0NzRiNWZCRDEwcE9hUlhkbSsyeWVRQU9pWWdBVExENGVvc0Mr?=
 =?utf-8?B?L0k3V0REai92d1FrUmFvRlVzTEl5TERhOUxSRFBvWGRnYTVIeXlCb3ZYY0JG?=
 =?utf-8?B?a3V2a2JmY0RtcDB1QWg3MkpSWGpxcjBMK01sU1NGdjhsYW1kTmVzbWx0ajRn?=
 =?utf-8?B?V0ZNL2xTMlZkTzdRZTBzV2Nxd3oxNmtDaTlWWG9Wb0tNZUNCczRuczM4V0Nh?=
 =?utf-8?B?MDVPL0NIUnA0bzN5VHNDdG42Mm9kZnpyV1FpWHAzRnpCdXZHaVkxN0ltMUZ5?=
 =?utf-8?B?NW51RDR2N3gwRlRtL00xc3lEZ2ZqUkMxYzNUU2NBbEJuSnJ3bVFwbHppa0dH?=
 =?utf-8?B?dHNqNFdnOXdvMFFzZjYrcVYvY2ZxY1ZHczQyZ243VWhVU01uMjJ1NzZFSzZO?=
 =?utf-8?B?NU44Q0YyL1MzVTd3QVhVTUNqVStVTEtCUTJWOExUQWhIZjhjc0JvSzk4Nzc5?=
 =?utf-8?B?ZGFPTjU4L3owQXRSWGdCaWIra21jUWtBejYyWkd3UldlRUZpcUtuUVdqODJ6?=
 =?utf-8?B?UmdHNVFOU3ROYnB0Y240NENyRGpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45C74DFFCF03A04796BC195DBF93504F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2ef06e-9d79-450b-2427-08d9b951729c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 07:16:11.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JCmDY2DfGvVo+3QGdT5vUVSkeH4/WgVAwBYV7ewZBjwoyEkvga9Igdfeofip3QxYX22Qq6GRFs6KsB1VVWys5HkoebkEbNaD29PJUGiD7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2879
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGksIE1pcXVlbCwNCg0KT24gMTIvNi8yMSAxMTo1OSBBTSwgTWlxdWVsIFJheW5hbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgWGlsaW54IFFT
UEkgY29udHJvbGxlciBoYXMgdHdvIGFkdmFuY2VkIG1vZGVzIHdoaWNoIGFsbG93IHRoZQ0KPiBj
b250cm9sbGVyIHRvIGJlaGF2ZSBkaWZmZXJlbnRseSBhbmQgY29uc2lkZXIgdHdvIGZsYXNoZXMg
YXMgb25lIHNpbmdsZQ0KPiBzdG9yYWdlLg0KPiANCj4gT25lIG9mIHRoZXNlIHR3byBtb2RlcyBp
cyBxdWl0ZSBjb21wbGV4IHRvIHN1cHBvcnQgZnJvbSBhIGJpbmRpbmcgcG9pbnQNCj4gb2Ygdmll
dyBhbmQgaXMgdGhlIGR1YWwgcGFyYWxsZWwgbWVtb3JpZXMuIEluIHRoaXMgbW9kZSwgZWFjaCBi
eXRlIG9mDQo+IGRhdGEgaXMgc3RvcmVkIGluIGJvdGggZGV2aWNlczogdGhlIGV2ZW4gYml0cyBp
biBvbmUsIHRoZSBvZGQgYml0cyBpbg0KPiB0aGUgb3RoZXIuIFRoZSBzcGxpdCBpcyBhdXRvbWF0
aWNhbGx5IGhhbmRsZWQgYnkgdGhlIFFTUEkgY29udHJvbGxlciBhbmQNCj4gaXMgdHJhbnNwYXJl
bnQgZm9yIHRoZSB1c2VyLg0KPiANCj4gVGhlIG90aGVyIG1vZGUgaXMgc2ltcGxlciB0byBzdXBw
b3J0LCBpdCBpcyBjYWxsZWQgZHVhbCBzdGFja2VkDQo+IG1lbW9yaWVzLiBUaGUgY29udHJvbGxl
ciBzaGFyZXMgdGhlIHNhbWUgU1BJIGJ1cyBidXQgZWFjaCBvZiB0aGUgZGV2aWNlcw0KPiBjb250
YWluIGhhbGYgb2YgdGhlIGRhdGEuIE9uY2UgaW4gdGhpcyBtb2RlLCB0aGUgY29udHJvbGxlciBk
b2VzIG5vdA0KPiBmb2xsb3cgQ1MgcmVxdWVzdHMgYnV0IGluc3RlYWQgaW50ZXJuYWxseSB3aXJl
cyB0aGUgdHdvIENTIGxldmVscyB3aXRoDQo+IHRoZSB2YWx1ZSBvZiB0aGUgbW9zdCBzaWduaWZp
Y2FudCBhZGRyZXNzIGJpdC4NCg0KVGhlIHN0YWNrZWQgbW9kZSB0aGF0IHlvdSBkZXNjcmliZSBz
ZWVtcyBwYXJ0aWN1bGFyIHRvIGEgc3BlY2lmaWMNCnZlbmRvci4gVGhlcmUgYXJlIG11bHRpIGRp
ZSBOT1IgZmxhc2hlcyB3aGljaCBkbyBub3QgcmVxdWlyZSBhbnkNCmNvbnRyb2xsZXIgaW50ZXJ2
ZW50aW9uLCB0aGUgbG9naWMgaXMgaGVsZCBhdCB0aGUgZmxhc2ggbGV2ZWw6DQpodHRwczovL21l
ZGlhLXd3dy5taWNyb24uY29tLy0vbWVkaWEvY2xpZW50L2dsb2JhbC9kb2N1bWVudHMvcHJvZHVj
dHMvdGVjaG5pY2FsLW5vdGUvbm9yLWZsYXNoL3RuMjUwNV9uMjVxX210MjVxX3N0YWNrZWRfZGV2
aWNlcy5wZGY/cmV2PTdhMjNjYzk1MjM4ZTQ2ZjdiMjJlMmE5ZjZiYzczNmI3DQoNCkNhbiB5b3Ug
cG9pbnQgdXMgdG8gd2hpY2gga2luZCBvZiBtZW1vcmllcyB5b3UncmUgd2lsbGluZyB0byBhZGQN
CnN1cHBvcnQgZm9yPyBTb21lIGRhdGFzaGVldHMgd2lsbCBiZSBiZXN0Lg0KDQpDaGVlcnMsDQp0
YQ0KDQo+IA0KPiBTdXBwb3J0aW5nIHRoZXNlIHR3byBtb2RlcyB3aWxsIGludm9sdmUgY29yZSBj
aGFuZ2VzIHdoaWNoIGluY2x1ZGUgdGhlDQo+IHBvc3NpYmlsaXR5IG9mIHByb3ZpZGluZyB0d28g
Q1MgZm9yIGEgc2luZ2xlIFNQSSBkZXZpY2UNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBS
YXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IEFja2VkLWJ5OiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tdGQvamVkZWMsc3BpLW5vci55YW1sIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvamVkZWMsc3BpLW5vci55YW1sDQo+
IGluZGV4IDM5NDIxZjcyMzNlNC4uNGFiZmI0Y2ZjMTU3IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFtbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL2plZGVjLHNwaS1ub3IueWFt
bA0KPiBAQCAtNDcsNyArNDcsOCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgaWRlbnRpZmllZCBi
eSB0aGUgSkVERUMgUkVBRCBJRCBvcGNvZGUgKDB4OUYpLg0KPiANCj4gICAgcmVnOg0KPiAtICAg
IG1heEl0ZW1zOiAxDQo+ICsgICAgbWluSXRlbXM6IDENCj4gKyAgICBtYXhJdGVtczogMg0KPiAN
Cj4gICAgc3BpLW1heC1mcmVxdWVuY3k6IHRydWUNCj4gICAgc3BpLXJ4LWJ1cy13aWR0aDogdHJ1
ZQ0KPiAtLQ0KPiAyLjI3LjANCj4gDQoNCg==

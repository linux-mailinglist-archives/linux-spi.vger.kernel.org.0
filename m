Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9711040FD8F
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhIQQJv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 12:09:51 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43652 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhIQQJu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 12:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631894908; x=1663430908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Pviffy0v+8Zdz8hhzE3zUttWk8o9hmi/lDOILLLiMv4=;
  b=DSvFAFSOlJjh4c90HltMwasPq2zsX8TvtD2wPJ4piwOqHTF6vJ2jUX4n
   ZC2eATn15CwDhzpyvZUosAUS8vCRpKwaYTwjexSOsC2hM8wMT2QeGSkKM
   AL9GauPLYuy8nc0R2v2/ZU7mD3i+lbo0IitsSHOyqO6WhN/4Zr2PIwkk/
   MEYc/+nsoQoV1TrS/VKZC2cI5ghbF1IZvhtDxagXWkDbs6vhVBCwF6p6L
   TVJon2PMNkopgyUR31+SDU4TZxfV/2jFtekI+ExuHJKVNTzSAnqMWy8YX
   W814Uis7/F6ilt7A7xufF2NrkmdkUBNzk/UXeTCxSw7PusdKb1dfn/ciK
   w==;
IronPort-SDR: F+IkidARf0RRfF7qc73/nrpU+DKQ9vuJkA9qVtcaZy0FFIC4mG3kkaIFvG3GXc+E/UgvrOCwPf
 LCWQSaSk3+M9Az+aqp3oruoKgZID7UjJ5hYdJIjXzbEmRQ54V92XZaigrYuq6Ql0o9oG752sKy
 MWnxsaSgWumes+3dscHbII1ri6YktLGR+IOlMnWFsHMuWHIKP6v5cMUGdAB9RE8MpWDOY0TGM7
 Fwp1UGgba1oGnNN4ApcPysPmegaYeqJ4t9bt1RzWjGCN1u4ja81FFQzlsbU+/DJTBl7GmJIBaC
 jThi5f0ixyYBwh7uObsC8LZ6
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="136381336"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 09:08:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 09:08:24 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Fri, 17 Sep 2021 09:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Maxk4HeD0HNRAAuoz7Inl33JvkpMEMKIwE+7TotK165JJyrlJ7ascWBx2uZW31eJyrne19Hqcwxu3Quu5JvNFezmtwuYnWyDCoMQ2xOp9PgyTz7XffAOk22r+LR4GwNkj6dF5kfnEFgcbH4LljYXWbs8yxHMU+63/cp0oINuFVEOWQi1lxal9F1vmRi/whHP599vz5XQ+p3Lc0u1bsWnwqJ4rbZVFbJ8uyNNiuCVnAp192q1GM10+UCcRxlKs3HmtNzhE34jglqJoc2n205jfenfgEM1mEcIoAPo55W5bwMiJfQBc3TN2M1RBKRoCs2wfIwZFfe8oGEOvVxLVPtUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Pviffy0v+8Zdz8hhzE3zUttWk8o9hmi/lDOILLLiMv4=;
 b=T2daaD5UZiSTnH8Y+JkWAB9iYRv8Mc9wCfS1fih7usHXOL70Fq58A8/tUnWBaaSaltOeJaoG2GTX+RoTesg4fQZUzfrlI+hyyr9TmU2/RHGk4ui9XRqCbT7mmcbW+hlRqSzwHc7a8C5wu1WGwbzeEd0KNPEsUWYaURa+z8OIC2lkowfJj+7ihRadsUR3THMvHuZzGJQJ/vZvlMupqr9GQ10cuUrucJgzRZ4t9aQ3/Or91fx04YrNVuZINHpIl+J5s51weVk9JkJHghMQS6lPvYPjqE9LO3H1q3AG23ySBgFFjCNDpQWiT7tym8NiPGJhCp8CjO0cZu2o0JwkuvW9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pviffy0v+8Zdz8hhzE3zUttWk8o9hmi/lDOILLLiMv4=;
 b=VkN8eJPx4jGzTQ5rTvgN2iLhVychPTX0raqdt6QqAtds67auTRAcyZr5VKrjlD8ja+HFrm2CEf5KDaZXefxXMHcwTRB4ei1KOsitGPkJc5C8VS6cuKFCX+oKhdxHp6eJzRnO8n/teksouFi+GjLdu+4hRMvdZkidygZWJsFweMc=
Received: from BY5PR11MB4007.namprd11.prod.outlook.com (2603:10b6:a03:189::28)
 by BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 16:08:21 +0000
Received: from BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::2116:bc0c:4699:a641]) by BY5PR11MB4007.namprd11.prod.outlook.com
 ([fe80::2116:bc0c:4699:a641%5]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 16:08:21 +0000
From:   <Dan.Sneddon@microchip.com>
To:     <VilleB@bytesnap.co.uk>, <Tudor.Ambarus@microchip.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Dan.Sneddon@microchip.com>
Subject: Re: [PATCH v2] spi: atmel: Fix PDC transfer setup bug
Thread-Topic: [PATCH v2] spi: atmel: Fix PDC transfer setup bug
Thread-Index: Aderl75ZSZUU23/3QUKqzWSAzGD4lQARn0kA
Date:   Fri, 17 Sep 2021 16:08:20 +0000
Message-ID: <6f409e55-33c6-2b2c-17b5-48bed0eb2ff6@microchip.com>
References: <a86bf8dcf3154f6bbf7e1ae21c073ea1@bytesnap.co.uk>
In-Reply-To: <a86bf8dcf3154f6bbf7e1ae21c073ea1@bytesnap.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: bytesnap.co.uk; dkim=none (message not signed)
 header.d=none;bytesnap.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de860645-082c-4c98-defa-08d979f55e9d
x-ms-traffictypediagnostic: BY5PR11MB3976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB397622B7468ADE9835699652E1DD9@BY5PR11MB3976.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FhmWIW/mYubczMU5XRVY2RJ4xX6zwt4niYjNVONWxOJh4m8JvgLgoV/13jYmTryAY5r+4M3gYrLBFkksaoURfOeq9GS4cdxuumZozykEQhj9DgYryUUaNwTq9avLOdFRIhno7M2NWTBeWxVVlCV1Q713sTOvGwLLz1UUVQRZzXqpb35pJ+UjU0b57u4JHUEvmBZIsd+sglwSwFH3xr/A7qv6YUtZw18B2+9g0KEaU7V6UoZuTsp/ZEWIaUbG5aeutqUJ0XF7smi/5rcPSYeFMC5jFcWD3E7WMGOX2oWgrRBH3vmUXrDK4ynUjkFVE/R2YcGeQK9aFZA4rdCntC46hheSnsqKrRhXEcU4rg47c2DqprkWnqxukhrVr7elixkWEAIoWFuKB6FgxS0iZd83XmgutZ60leeNg6CrCRJc55n5fsPuI6vVkqjqVzFHcDvRfzQDqp797x5G5BFFqW8PlGl4TuF0BpQp9RHWAa6Gj2aZ0cZ72jyF4DY8vpOc2+XoVGNr37YTDVPIdntcukFMfiNLJ53zAVzItUZhJmHfQo9+QPpzK2BveWuIn68f9NnL0wixgsg0Zqm0h/6JTT6KM59BxZVIdN8Eaq8y4shLf3vmJ7jJ6UUH1RwIaGLK41Xlwcvu5A6P51ZV5N6UHpQOVtQIpJQ2JnvbfQeajyHL29P/VsjGfom+PWQ1JQyesQ5dX7K2lGRqiP9g6z0ywzv7UYBCcUIg2UGsHzyMM1Azl1NeC9RuXTw6MvP1fS5AdhLrc29Fm56P0c+xmH1gVUbiN8AnRnJqjrFhAVisxDyV9131cY/Dh5fqOSP4nLWpSqcc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(31696002)(53546011)(316002)(54906003)(6506007)(31686004)(2616005)(110136005)(66946007)(66476007)(66556008)(76116006)(64756008)(66446008)(26005)(4326008)(186003)(36756003)(122000001)(8936002)(38070700005)(38100700002)(8676002)(107886003)(6636002)(6512007)(83380400001)(6486002)(71200400001)(86362001)(2906002)(508600001)(966005)(45980500001)(43740500002)(10090945008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDRmY2l6eGNGbjFJZmpGcnk0ajE2YkFRN2FjckI1VWpwcUc2MzNXOENPSkRv?=
 =?utf-8?B?dmV6bjg2S2g3dVF6SmI2ZGRmTHkybURvb0tHVUMzUVhKNmhZaXRMK2xRSFZt?=
 =?utf-8?B?aGM2cGVJcjF1TGpoYUp3cmE3eElxczlWbHd1aXp1MlZFWkMxaVUvSzdkc0Nj?=
 =?utf-8?B?NnFLK3Q5TDZJT1ByZ29VdnJPUDR4Z1R2MVQvQ0dseVFPQnM0V3gxSlBGNGE1?=
 =?utf-8?B?c1J4NjVxRWRtWFdiV1NIYURlS253WTY2ZlJZc1ErSHliWmhiWnNzUXR2YVd5?=
 =?utf-8?B?MzRnZjdmV2g3OUNFRVhOeThiUCtjODFYNDhYUHNJcFVBeFl3dGQ5eFdKTFBv?=
 =?utf-8?B?eWgrOVd0b0ZHcjNJOFp6Q3ZxTWgyNnEzdTFiYlhNTzQ4a1FDRFFPQXB4OFJy?=
 =?utf-8?B?cUlaRGpBVDBMSnp2c2lCMGFUc2dJck5GeHJ6d2RSMW5yQ3crUUhGMjByMHA5?=
 =?utf-8?B?NWpxM3A3aUxmOTEzakVoSS9pbEYvZ3VJWmszbGI0Q3lEVVl6azg4WExaZHYy?=
 =?utf-8?B?V3pLV01sYzluaUlRVkdKakJKYm9rN0t3bnVkZFJ6aHB0YjlRd0hER2tsVjFo?=
 =?utf-8?B?TDJCY1V4MVRPbmVTZkcrUVVYRFNlZjd0UzBpdEV2eHEzanZMMkRoSXRNaVZn?=
 =?utf-8?B?b2lEak0xemE3UzJybERPaTBDSFNtMzRuSElsWDZRcC9CMTBGL0xCTkc3K0s4?=
 =?utf-8?B?MU56RStLZTZCRDRJQmdWMVdUWEJ5Wm83bHZZb3FxcmFoS3d6NWhMN0U0d2Z6?=
 =?utf-8?B?dnNmUTZhR2VDSmVuTU9rZVRLSkdTS012QnhmUFQ3S3RjZisyaXp2dXAvdGY0?=
 =?utf-8?B?eGdGZWNVMVdEdXJpY1NJYzJZNDhKWjZnVlFSclp1VFYrTWlub0dPRWdGV1ZG?=
 =?utf-8?B?a1lvRy9jd0h5c01TU1Z2SnZJRGRMd3hjMGlyZ1BKWEp0OGY5OFN5L0hmTG5s?=
 =?utf-8?B?aURIVGNZTGNKZmFYMHdpZzdoVjJVYSthUUtpcWE4SWg4WUFhTEc4cjY4UTdF?=
 =?utf-8?B?MnZNQlNQb0cwdTU5ck5DS1l3QU9ZcnlrK0NHVVZtQ0poMUx0NFNVRDArajBU?=
 =?utf-8?B?K1NXZzlSb3FNMmF3MkZQVVFMWXhUaVFlQTlMU2tnT0E3TmJPMmpnN2pWT2lE?=
 =?utf-8?B?SkRLaTd0RVdSNjhSNDRWSGhRb2FlNDlPYVd2RytUM2p1eDdRMGEvOVVqNjdt?=
 =?utf-8?B?Qi80T01FcWljVXRmOGE2dkU3RzZmdHk1djh5NFJWZDF5Z0xnRWF1dEs2V1Mw?=
 =?utf-8?B?UDlON3djQXJveVlBM3ViQmxaUnBYMXNPQmZHNVcxY0Z2ZWw2aTY3dVdrQ1k0?=
 =?utf-8?B?MWo3eTJhdGRGa2Uwa28yak9ZY0I3Q0VkTWVyWTVrMVF6cEJWcGlyV3lPazkx?=
 =?utf-8?B?Mm13bWRPMUdabnVIUi9JOHZGME1UWnNKZGkzd1R4Qzl2NWx3ZGtqRlBtQkhW?=
 =?utf-8?B?VE1sN0R4TjZmVmUrTThxRmVkbGFsaUNyNk5CM0JkSVNhS0FhYnpEd1lTSWY0?=
 =?utf-8?B?bFIxaS9rK0ZDUGl3VHdCNFFUVmFsZU1Fbk5EdjZYY3RzUG8xK0ltaTh2NDFx?=
 =?utf-8?B?cS9LU1c3eWpkUmJQcUZFaE9jMVFzMTNhRFVudjZJckVoejFhQ1VIcFNmTUhM?=
 =?utf-8?B?YXNVR3A0Mm5VMXFkSWtkT2lteUJPbnJPL2tMNW1IaTlPeGQ0b21xbithcTBS?=
 =?utf-8?B?TXZNdkFDUk40aFBkdXAyQUZQMGUra3Iyb3E1VThIQ3ZYbnd0cmJocnNxNURF?=
 =?utf-8?Q?RZTYhsz4tY8EMN1sWyCYk2c/RvgRuI0P261+zR+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9387DC723C72384CB00E82A14D5F135F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de860645-082c-4c98-defa-08d979f55e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 16:08:20.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2j4Z2Qwy3di9waoGyWPItGGokA4otfpY1BEJsBNihgtvPp/5grnfOuGKUwUVwzdtYzVmsqR/YHFqZhttuqopWTMA6r5C0xF6NjMsVjs8Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3976
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gOS8xNy8yMSAxMjo0NiBBTSwgVmlsbGUgQmFpbGxpZSB3cm90ZToNCj4gW1NvbWUgcGVvcGxl
IHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gdmls
bGViQGJ5dGVzbmFwLmNvLnVrLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cDov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24uXQ0KPiANCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiAgRnJvbSA3Zjc5NmMyMDA0NDA3Zjg0OGY5
ZWQ5N2Y0MDZlMjRiOWVhZGQ3NGJlIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KPiBGcm9tOiBW
aWxsZSBCYWlsbGllIDx2aWxsZWJAYnl0ZXNuYXAuY28udWs+DQo+IERhdGU6IFRodSwgMTYgU2Vw
IDIwMjEgMTQ6MTY6NDYgKzAwMDANCj4gU3ViamVjdDogW1BBVENIIHYyXSBzcGk6IGF0bWVsOiBG
aXggUERDIHRyYW5zZmVyIHNldHVwIGJ1Zw0KPiANCj4gQ29tbWl0IDVmYTVlNmRlYzc2MiAoInNw
aTogYXRtZWw6IFN3aXRjaCB0byB0cmFuc2Zlcl9vbmUgdHJhbnNmZXINCj4gbWV0aG9kIikgcmVm
YWN0b3JlZCB0aGUgY29kZSBhbmQgY2hhbmdlZCBhIGNvbmRpdGlvbmFsIGNhdXNpbmcNCj4gYXRt
ZWxfc3BpX2RtYV9tYXBfeGZlciB0byBuZXZlciBiZSBjYWxsZWQgaW4gUERDIG1vZGUuIFRoaXMg
Y2F1c2VzIHRoZQ0KPiBkcml2ZXIgdG8gc2lsZW50bHkgZmFpbC4NCj4gDQo+IFRoaXMgcGF0Y2gg
Y2hhbmdlcyB0aGUgY29uZGl0aW9uYWwgdG8gbWF0Y2ggdGhlIGJlaGF2aW91ciBvZiB0aGUNCj4g
cHJldmlvdXMgY29tbWl0IGJlZm9yZSB0aGUgcmVmYWN0b3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBWaWxsZSBCYWlsbGllIDx2aWxsZWJAYnl0ZXNuYXAuY28udWs+DQpSZXZpZXdlZC1ieTogRGFu
IFNuZWRkb24gPGRhbi5zbmVkZG9uQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
c3BpL3NwaS1hdG1lbC5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGkt
YXRtZWwuYyBiL2RyaXZlcnMvc3BpL3NwaS1hdG1lbC5jDQo+IGluZGV4IDc4OGRjZGYyNWYwMC4u
Zjg3MmNmMTk2YzJmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktYXRtZWwuYw0KPiAr
KysgYi9kcml2ZXJzL3NwaS9zcGktYXRtZWwuYw0KPiBAQCAtMTMwMSw3ICsxMzAxLDcgQEAgc3Rh
dGljIGludCBhdG1lbF9zcGlfb25lX3RyYW5zZmVyKHN0cnVjdCBzcGlfbWFzdGVyICptYXN0ZXIs
DQo+ICAgICAgICAgICAqIERNQSBtYXAgZWFybHksIGZvciBwZXJmb3JtYW5jZSAoZW1wdGllcyBk
Y2FjaGUgQVNBUCkgYW5kDQo+ICAgICAgICAgICAqIGJldHRlciBmYXVsdCByZXBvcnRpbmcuDQo+
ICAgICAgICAgICAqLw0KPiAtICAgICAgIGlmICgoIW1hc3Rlci0+Y3VyX21zZ19tYXBwZWQpDQo+
ICsgICAgICAgaWYgKCghbWFzdGVyLT5jdXJfbXNnLT5pc19kbWFfbWFwcGVkKQ0KPiAgICAgICAg
ICAgICAgICAgICYmIGFzLT51c2VfcGRjKSB7DQo+ICAgICAgICAgICAgICAgICAgaWYgKGF0bWVs
X3NwaV9kbWFfbWFwX3hmZXIoYXMsIHhmZXIpIDwgMCkNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPiBAQCAtMTM4MSw3ICsxMzgxLDcgQEAgc3RhdGljIGludCBh
dG1lbF9zcGlfb25lX3RyYW5zZmVyKHN0cnVjdCBzcGlfbWFzdGVyICptYXN0ZXIsDQo+ICAgICAg
ICAgICAgICAgICAgfQ0KPiAgICAgICAgICB9DQo+IA0KPiAtICAgICAgIGlmICghbWFzdGVyLT5j
dXJfbXNnX21hcHBlZA0KPiArICAgICAgIGlmICghbWFzdGVyLT5jdXJfbXNnLT5pc19kbWFfbWFw
cGVkDQo+ICAgICAgICAgICAgICAgICAgJiYgYXMtPnVzZV9wZGMpDQo+ICAgICAgICAgICAgICAg
ICAgYXRtZWxfc3BpX2RtYV91bm1hcF94ZmVyKG1hc3RlciwgeGZlcik7DQo+IA0KPiAtLQ0KPiAy
LjE3LjENCj4gDQoNCg==

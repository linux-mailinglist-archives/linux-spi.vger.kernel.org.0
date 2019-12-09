Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33238116FF8
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 16:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfLIPLD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 10:11:03 -0500
Received: from mail-eopbgr1410098.outbound.protection.outlook.com ([40.107.141.98]:28384
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfLIPLC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 10:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+WNm7jvuKPIajdlE3J1Ul58VkQn+qvfnoqwiIa93PgYoSD8gPvdFWk8IKj6elQDYNoGv/QQt3qJwUhUOAx+vxjOskbyLh0kyib2fnZY1GclawmjB6gndGq3Km0MhnlEnX47nE+HvzoF7wqK3QyqzrltSkYUXr+8c720us7GTcukeaTAZZeQ9PRNJvaDfSLJ03bM4L2ApdeNb3o5RA8MR+yaABNmhii0FI8TwT6f+MsWj679wE8zKo6bjFAEyJXP5HWrYWf8a2+zrjbEBD8d0rlvC1GSKpWECaTXAiItCvcOQJn4iY4gZN5vf58RvdjNnecYxyOpG6+lVbQjYW72MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCfKer80bFB2ShNPoXK6qhQ31tSumEB4iaTL8N74qkk=;
 b=JAleDxj0JxZqasMvJJIxzPxiPKdSjDdXMP0YBfvHVwDClfYfcNreJMw9Ft1KzPVT4U62m3O++yP2e/uRJHCFdSy4S0wDsXmFoZ5wo2IUD7iwEkBu8vz+nzDDx05eWn6I20m32ufP+oTHcmpIcB4GEUU+BWgGjMJ4yNV2eKSZpuGGC0QbpLkT7kP1GCrG/lQ2Ew5bDTKvu1Vjg94P0hUggJgczkIbVeE1BDF1asXyFcLCXtGWIsV6sREvD21qSZBGXk+sCSY/wMQ7wfWKoNY2pb7jgqzPmgZN4inOG5FA8/pGISsCaxnKOcNUS0qqAYaYhR2eS4nguZG4xGHqtOoQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCfKer80bFB2ShNPoXK6qhQ31tSumEB4iaTL8N74qkk=;
 b=Y2bizJgx5B332Bj5fiT9oHEizfJ0VvM6RZ03TapUwjlT9SsxCM7AbCZbfWG7CI4hfEsmH7L+Hu9TYQMtpnIphFUa4ZQKrmQIrC4aPiFps8dmbdyem/KWevXvyPB2vS3tMoDXbGmvl1DP0hM+9CwDONklS2feZz26D2qu1tLoF+Q=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1834.jpnprd01.prod.outlook.com (52.133.164.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Mon, 9 Dec 2019 15:10:58 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 15:10:57 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Topic: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Thread-Index: AQHVrDsFo/XrCnZmIE+HK5Vec6rH7qevIW6AgAK0x/A=
Date:   Mon, 9 Dec 2019 15:10:57 +0000
Message-ID: <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
In-Reply-To: <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMThjNWI2ZWUtMWE5Ni0xMWVhLWFhNTQtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDE4YzViNmVmLTFhOTYtMTFlYS1hYTU0LTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNDU5MCIgdD0iMTMyMjAzNzc4NTYxODY2MDI5IiBoPSJFRFRoTlgvdklmd2RLWGhSdERtUTB3T1FoQkk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d31188b-1728-4271-5829-08d77cb9fe91
x-ms-traffictypediagnostic: TY1PR01MB1834:
x-microsoft-antispam-prvs: <TY1PR01MB183422360F98BBC789CB11728A580@TY1PR01MB1834.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(396003)(39830400003)(199004)(189003)(8936002)(478600001)(9686003)(8676002)(33656002)(71200400001)(81166006)(71190400001)(81156014)(305945005)(7696005)(55016002)(5660300002)(66946007)(316002)(6506007)(26005)(64756008)(66476007)(66556008)(76116006)(186003)(2906002)(52536014)(66446008)(86362001)(4326008)(110136005)(7416002)(54906003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1834;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6WzdHGp4BGCbOZE8y8uFQGT5Tf0InJ44CH5+vpdS24zN5wiQr+8epmA6x5lOUL9PgTCw7KnP5wOMOzW9VsJxqsXTB/RgQib4FMkxw9ZLF/DwCVfViAyQJyI9h4BBhgg6NOIup/5R2hWoe5C3rBt6T2GpvgI3YwbcNAvFVs7INRHcEU9RIVtrf2YodzO/l6TTFbIejfg7ajSilYYI9xi8xvXfyj1sRFFpQOA9NI9FTqyvrDLUaKSnEYmTpyA3hSLsie4cbr7v40ATf6sI7FBPQPLTXU5Sm8f9RxMFLNhJ7cFDp/nkE9z5i5ktvGFfzWPJA0bxx5rdsu/nf3KHX8RCVUc37UDF4B8bJ+Kiyujh8HbWi7+4Ky87xeo9Zrs4xGS/ZNC9+3mDX+ygYiuyL7aOhjyDCrXoWdEycHx0LTTblNDI25QXvC7YKFGh78LNmnl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d31188b-1728-4271-5829-08d77cb9fe91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 15:10:57.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rd51AVDslu7Dt4TAnJsI7oCGnwpF6+Hb/ulYPLoUdgaxCD/se3kqZPTX4ht7VL8oFSfeZF9R+O3Ou1h3SZ1hsuIrdjk9iw7BAQIinb9Xdq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1834
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGVsbG8gU2VyZ2VpLA0KDQpPbiBTYXQsIERlYyA3LCAyMDE5LCBTZXJnZWkgU2h0eWx5b3Ygd3Jv
dGU6DQo+ID4gVGhlIFJlbmVzYXMgU1BJIEJ1cyBTcGFjZSBDb250cm9sbGVyIChTUElCU0MpIEhX
IHdhcyBzcGVjaWZpY2FsbHkNCj4gPiBkZXNpZ25lZCBmb3IgYWNjZXNzaW5nIFNlcmlhbCBmbGFz
aCBkZXZpY2VzIChRU1BJLA0KPiANCj4gICAgVGhlIGluaXRpYWwgZGVzaWduIGRpZCBvbmx5IHN1
cHBvcnQgU1BJLCBoZW5jZSB0aGUgU1BJIGluIHRoZSBuYW1lLg0KDQpUaGUgbW9yZSBpbXBvcnRh
bnQgcGFydCBpcyB0aGUgIkJ1cyBTcGFjZSBDb250cm9sbGVyIi4gTWVhbmluZyB0aGUgbWFpbiAN
CnB1cnBvc2Ugb2YgdGhpcyBoYXJkd2FyZSB3YXMgdG8gYWxsb3cgdGhlIENQVSB0byBhY2Nlc3Mg
c2VyaWFsIGZsYXNoIA0KZGlyZWN0bHkgKGFzIGluLCBYSVApLg0KDQoiU1BJLUJTQyIgd2FzIHRo
ZSBpbnRlcm5hbCBuYW1lIGZvciB0aGUgSFcgYnV0IGRvZXMgbm90IGFwcGVhciBpbiBhbnkgb2YN
CnRoZSBoYXJkd2FyZSBtYW51YWwuIFRoZSBoYXJkd2FyZSBtYW51YWxzIChldmVuIHRoZSBNQ1Vz
KSBvbmx5IHNheSAiU1BJDQpNdWx0aSBJL08gQnVzIENvbnRyb2xsZXIiLg0KRXZlbiB0aGUgUi1j
YXIgZ2VuMyBtYW51YWwgc2F5cyAnU1BJJzogICJTUEkgTXVsdGkgSS9PIEJ1cyBDb250cm9sbGVy
IA0KKFJQQykiLg0KDQpJIGhhdmUgbm8gaWRlYSB3aHkgdGhlIFItQ2FyIHBlb3BsZSBmZWx0IHRo
ZXkgbmVlZGVkIHRvIHB1dCAiUlBDIiBpbiB0aGUNCmhhcmR3YXJlIG1hbnVhbCBhcyB0aGUgdGl0
bGUgb2YgdGhlIGNoYXB0ZXIuIChBbHRob3VnaCwgIk11bHRpIEkvTyIgaXMgDQpqdXN0IGFzIGJh
ZCBhcyBhIG5hbWUpDQogDQpJIGRpZCBtYWtlIHRoZSByZXF1ZXN0IHRvIHRoZSBSWi9HIHRlYW0g
dG8gbm90IHB1dCAiUlBDIiBpbiB0aGUgdGl0bGUgb2YNCnRoZSBjaGFwdGVyIGluIGFueSBmdXR1
cmUgUlovRyBoYXJkd2FyZSBtYW51YWxzLg0KDQpTaW5jZSBRU1BJLCBIeXBlckZsYXNoIGFuZCBP
Y3RhRmxhc2ggYXJlIGFsbCAnc2VyaWFsJyBGbGFzaCANCnRlY2hub2xvZ2llcywgSSB3b3VsZCBi
ZSBmaW5kIHdpdGggYSBkcml2ZXIgbmFtZSBvZiAiU0JTQyIgKCJTZXJpYWwgQnVzIFNwYWNlIA0K
Q29udHJvbGxlciIpIHdoaWNoIGF0IGxlYXN0IGxvb2tzIGNsb3NlciB0byB3aGF0IGlzIGluIGFs
bCB0aGUgaGFyZHdhcmUgDQptYW51YWxzLg0KDQoNCj4gICAgU1BJQlNDIGlzIGFsc28gbWlzbGVh
ZGluZy4uLiBSUEMtSUYgc2VlbXMgbWlzbGVhZGluZyB0b28gYXMgaXQncyBvbmx5DQo+IHNwZWxs
ZWQgb3V0IGluIHRoZSBSLUNhciBnZW4zIGFuZCBSWi9BMkggbWFudWFscy4NCg0KSW4gdGhlIFJa
L0EyIG1hbnVhbCwgIlJQQyIgaXMgb25seSB1c2VkIHRvIGxhYmVsIHRoZSAzIG5ldyBleHRlcm5h
bCBwaW5zDQp0aGF0IHdlcmUgYWRkZWQgZm9yIEh5cGVyRmxhc2guDQogIFJQQ19SRVNFVCMgLCBS
UENfV1AjICwgUlBDX0lOVCMNCkJ1dCBvZiBjb3Vyc2UgdGhleSB3ZXJlIGp1c3QgY29waWVkIGZy
b20gdGhlIFItQ2FyIG1hbnVhbC4NCg0KQnV0LCBtYXliZSB0aGF0J3MgZW5vdWdoIGFib3V0IHRo
ZSBuYW1lIGZvciBub3cuDQoNCg0KPiA+IFRoaXMgZHJpdmVyIGhhcyBiZWVuIHRlc3RlZCBvbiBh
biBSWi9BMUggUlNLIGFuZCBSWi9BMk0gRVZCLg0KPiANCj4gICAgSW4gdGhlIFNQSSBtb2RlIG9u
bHksIEkgYXNzdW1lPw0KDQpZZXMuIEF0IHRoZSBtb21lbnQsIHRoZXJlIGFyZSBvbmx5IHJlcXVl
c3RzIGZyb20gdXNlcnMgZm9yIFFTUEkgZmxhc2ggYWNjZXNzDQooUlovQSBhbmQgUlovRyB1c2Vy
cykuDQoNClRoZSBSWi9BMk0gRVZCIHdhcyBsYWlkIG91dCB0byBzdXBwb3J0IGFsbCB0aGUgZGlm
ZmVyZW50IGNvbWJpbmF0aW9ucyBvZg0Kc2VyaWFsIGZsYXNoZXMgKGJ5IHBvcHVsYXRpbmcgZGlm
ZmVyZW50IGNoaXBzKS4gVGhhdCBpcyB3aHkgdGhlcmUgaXMgDQphbHJlYWR5IFNlZ2dlciBKLWxp
bmsgc3VwcG9ydCBmb3IgUVNQSSwgSHlwZXIgYW5kIE9jdGEgZm9yIHRoZSBSWi9BMi4NCg0KSSB3
aWxsIGFkbWl0LCB0byBkZXZlbG9wZWQgdGhpcyBkcml2ZXIgZm9yIHRoZSAiU1BJLUJTQyIgSFcs
IEkgaGF2ZSBiZWVuDQp1c2luZyBhbiBYSVAga2VybmVsIChYSVAgZnJvbSBhbm90aGVyIEh5cGVy
Rmxhc2ggLyBIeXBlclJBTSBjb21ibyBjaGlwIA0Kb24gdGhlIGJvYXJkKSBiZWNhdXNlIEkgZGlk
bid0IGZlZWwgbGlrZSBtb3ZpbmcgYWxsIHRoZSBzd2l0Y2hlcyB0byB1c2UgDQpTRFJBTSBhbmQg
YSB1SW1hZ2Uga2VybmVsLg0KVGhlIFJaL0EyTSBoYXMgYSBIeXBlckZsYXNoIGNvbnRyb2xsZXIg
KGZvciBSL1cpLCBhIE9jdGFCdXMgY29udHJvbGxlciANCihmb3IgUi9XKSBhbmQgdGhlIFNQSSBC
U0MgKFJlYWQtb25seSkuDQoNCg0KPiAgICBXaGF0IEkgaGF2ZSBub3cgaXMgdGhlIGNvcmUgZHJp
dmVyIChvciByYXRoZXIgYSBsaWJyYXJ5KSBwbGFjZWQgdW5kZXINCj4gZHJpdmVycy9tZW1vcnkv
IGFuZCB0aGUgU1BJIGFuZCBIeXBlckZsYXNoIGZyb250IGVuZHMgaW4gZHJpdmVycy9zcGkvIGFu
ZA0KPiBkcml2ZXJzL210ZC9oeXBlcmJ1cy8gcmVzcGVjdGZ1bGx5Lg0KPiBJJ20gYWxtb3N0IHJl
YWR5IHRvIHBvc3QgdGhlIGNvcmUgZHJpdmVyL2JpbmRpbmdzLCB0aGUgU1BJIGRyaXZlciBzdGls
bCBuZWVkcw0KPiBzb21lIE1hcmsgQnJvd24ncyBjb21tZW50cyBhZGRyZXNzZWQsIGFuZCB0aGUg
SHlwZXJGbGFzaCBkcml2ZXIgaXMgYWxzbyByZWFkeQ0KPiBidXQgbmVlZHMgdGhlIGV4aXN0aW5n
IEh5cGVyQnVzIGluZnJhc3RydWN0dXJlIHByb3Blcmx5IGZpeGVkIHVwIChoYXZpbmcgYQ0KPiBk
cmFmdCBwYXRjaCBub3cpLi4uDQoNCkJ1dCBhcmUgdGhlc2UgZm9yIHRoZSBIeXBlckJ1cyBjb250
cm9sbGVyPyBPciB0aGUgU1BJLUJTQyBjb250cm9sbGVyPw0KVGhleSBhcmUgMiBkaWZmZXJlbnQg
Y29udHJvbGxlcnMsIHNvIHlvdSB3b3VsZCB0aGluayB0aGV5IHdvdWxkIGhhdmUgMiBkaWZmZXJl
bnQgZHJpdmVycy4NCg0KDQo+ID4gVGhlIHRlc3RpbmcgbW9zdGx5IGNvbnNpc3RlZCBvZiBmb3Jt
YXR0aW5nIGFuIGFyZWEgYXMgSkZGUzIgYW5kIGRvaW5nDQo+ID4gY29weWluZyBvZiBmaWxlcyBh
bmQgc3VjaC4NCj4gDQo+ICAgIERpZCB0aGUgc2FtZSAob3IgYXQgbGVhc3QgdHJpZWQgdG8gOi0p
IGFuZCBJIG11c3QgYWRtaXQgdGhhdCB3cml0aW5nDQo+IGRvZXNuJ3Qgd29yayB3aXRoIGFueSBv
ZiB0aGUgZnJvbnQgZW5kcy4uLiBJIHN0aWxsIG5lZWQgdG8gZ2V0IHRoaXMgZml4ZWQuDQoNCg0K
VGhhdCdzIHRoZSBwYXJ0IEknbSBjb25mdXNlZCBhYm91dC4gSSBzYXcgdGhlIGxhc3QgcGF0Y2gg
c2VyaWVzIHRoYXQgDQptYWRlIGl0IHVwIHRvIHYxNyBidXQgc3RpbGwgZGlkbid0IGdldCBpbi4g
QWx0aG91Z2gsIGl0IGRpZCBsb29rIHZlcnkgDQpjb21wbGljYXRlZC4NCllvdSBjYW4gc2VlIGZy
b20gbXkgU1BJLUJTQyBkcml2ZXIsIGl0J3MgYmFzaWNhbGx5IDIgZnVuY3Rpb246IGEgU1BJIA0K
d3JpdGUgYW5kIFNQSSByZWFkLiBUaGUgdXBwZXIgbGF5ZXIgc2VuZHMgeW91IGRvd24gZGF0YSB0
byB3cml0ZSwgYW5kIHlvdSANCmp1c3Qgd3JpdGUgaXQuIEluIHRoZW9yeSwgaWYgYSBIeXBlckZs
YXNoIE1URCBsYXllciB3YXMgc2VuZGluZyBkb3duIA0KZGF0YSwgdGhlIGNvbW1hbmRzIGJ5dGVz
IHdvdWxkIGJlIGRpZmZlcmVudCwgYnV0IHRoZSBwcm9jZWR1cmUgd291bGQgYmUgdGhlIA0Kc2Ft
ZS4NCg0KDQo+ID4gV2hpbGUgdGhlIEhXIGNoYW5nZWQgYSBsaXR0bGUgYmV0d2VlbiB0aGUgUlov
QTEgYW5kIFJaL0EyIGdlbmVyYXRpb25zLA0KPiA+IHRoZSBJUCBibG9jayBpbiB0aGUgUlovQTJN
IHdhcyB0YWtlbiBmcm9tIHRoZSBSLUNhciBIMyBkZXNpZ24sIHNvIGluDQo+ID4gdGhlb3J5IHRo
aXMgZHJpdmVyIHNob3VsZCB3b3JrIGZvciBSLUNhciBHZW4zIGFzIHdlbGwuDQo+IA0KPiAgICBJ
IGRvbid0IHRoaW5rIGl0J3MgYSBnb29kIGlkZWEgdG8gdXNlIHRoZSBTUEkgZGVkaWNhdGVkIGRy
aXZlciBvbiBSLUNhcg0KPiBnZW4zLCBJIHdvdWxkIHJhdGhlciBzZWUgdGhlIFJaL0ExIHVzaW5n
IHRoZSBSUEMtSUYgZHJpdmVyL2xpYnJhcnkgdG8gcmVkdWNlDQo+IHRoZSBjb2RlIGR1cGxpY2F0
aW9uLi4uDQoNCkkgYWdyZWUgb24gbm90IGhhdmluZyBjb21wZXRpbmcgZHJpdmVycy4gRXNwZWNp
YWxseSBzaW5jZSBmdXR1cmUgUlovQSANCmFuZCBSWi9HIGRldmljZXMgd2lsbCBtb3N0IGxpa2Vs
eSBjb250aW51ZSB0byBpbmNsdWRlIHRoaXMgSFcuDQoNCkhvd2V2ZXIsIHRoZSBkcml2ZXIgSSBw
b3N0ZWQgaXMgcHJldHR5IHNpbXBsZSBhbmQgd29ya3MuIERvZXMgdGhlIA0KSHlwZXJGbGFzaCBN
VEQgbGlicmFyeSB0aGF0IHlvdSBhcmUgcHJvcG9zaW5nIGhhdmUgYSB2ZXJ5IGRpZmZlcmVudCBB
UEkgdGhhbiANCmp1c3QgJ3NlbmQgYnl0ZXMnIGFuZCAncmVjZWl2ZSBieXRlcyc/DQoNCg0KQ2hy
aXMNCg==

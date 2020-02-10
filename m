Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5F81583D0
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 20:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgBJTe6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 14:34:58 -0500
Received: from mail-eopbgr1400107.outbound.protection.outlook.com ([40.107.140.107]:9668
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbgBJTe6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 Feb 2020 14:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/HeTQ8lEq5cmNX/GIxNi47py2HJ5KVPE6EiCg8g5768bUmzuCKeVaNZKrSm/WAY8Dd47UY4ottu3xvRCVoUdmDlD13OKqGdG3OeQXfAI2TjDCZZZqNwwUROLcx6LJuFiexGeu4CyBGe0xdJ5IuL0qh6J7Jo1mwOgAhdjd9YZ5rvAOax5OKbzNJTA4FlPKT92suGRc5Hc/xr6ThHqgwwypztBO2bvmdV+BEejDuQSLlX5Jv1JK3tkrhab3gX7/jqzHBf58Rkj6I40pz1AYSJfUDAartnUwJq0s20I1Qr9tpVei05K9f6FeBWs3hhn7Rc3Uo8j6R/qO5dUrgJ4DD7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvlJ3OgVRUht1T/Hzu6+UhuNVxufloKIVFYuhn0I4Qg=;
 b=eAhrQSHpCjHxxn87ifQ15+vwO4iuV8UXV8d64jWvpxDFtSSpYw4aYXVTZbjBgs1SgFPAlpzhxsGW/RvU2OWPP/07n2Hd6FXb1IrzWwgn3Ad8BAaAaEarbDmwjF49YwSQzhdlODT8IqgFBLtNbsIvKNIKP8Jo2rVHr6sWLNvAb2DyDbOTKDqBEVg0f+0HmOQub6Lvs7ykp8q1kPA8bt2NNL+1m1IXQ2/EYxgVLIY+s06vlOdQXTEV3p6Y2Flv+ejDEG38n35aFWkY/EbAC3AKIAsPQvlVBAOUyKeN0y7BegzUxs8nWtB2dIqIR9v7jQmIujBKO2jdyfnJ6Kx9UGK3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvlJ3OgVRUht1T/Hzu6+UhuNVxufloKIVFYuhn0I4Qg=;
 b=gF6p2j0Ewu8qethn8pcYo/l+ueMgIkm/Vl+i+1xqIEdgAQLcnVpLdEER+w83c2/5lJfyJI/BItpyLAo0l5veYvtRzopIknfnFK/vmFmOgNik82Yj8XIdqnNN0wpfx8H0ION/3IUKrJF3N7nSymwizriA98JPseYTeEDfREy4P3k=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1738.jpnprd01.prod.outlook.com (52.133.162.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 19:34:56 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8870:97e4:a63c:67ea]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8870:97e4:a63c:67ea%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 19:34:56 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2] spi: add Renesas RPC-IF driver
Thread-Topic: [PATCH v2] spi: add Renesas RPC-IF driver
Thread-Index: AQHVy+TviPn/l/o2I0KvRtYPATdXYagU2jRQgAAY2AA=
Date:   Mon, 10 Feb 2020 19:34:55 +0000
Message-ID: <TY1PR01MB1562DB6771C35293B59836828A190@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
 <TYXPR01MB1568E8BCB6B80A77C91D98998A190@TYXPR01MB1568.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB1568E8BCB6B80A77C91D98998A190@TYXPR01MB1568.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNmEzYTlmYmMtNGMzYy0xMWVhLWFhNWItOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDZhM2E5ZmJkLTRjM2MtMTFlYS1hYTViLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMjkwMiIgdD0iMTMyMjU4MzY4OTYzNzMzMzQ0IiBoPSIxVTJ2ZzNDWnpVK0xXNXhPajJLaEdyb1V0S009IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bd007a2-a901-429e-0cc3-08d7ae604ef4
x-ms-traffictypediagnostic: TY1PR01MB1738:
x-microsoft-antispam-prvs: <TY1PR01MB1738D580CF6D655D64EC7BE38A190@TY1PR01MB1738.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:274;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(316002)(110136005)(55016002)(9686003)(5660300002)(186003)(7696005)(4326008)(52536014)(33656002)(6506007)(66446008)(81156014)(8676002)(8936002)(81166006)(66556008)(64756008)(76116006)(66946007)(86362001)(26005)(66476007)(71200400001)(2906002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1738;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qu6I+xz46ME/hpUG1+0r9KztQRHtKVp0jzNd4G8hxaeOvNrFYMHrzCX3gucvsIjwPjrbnrVkVn0MzhaCNRONqj9/PfgXoZ/AuMWPRCbGBJSENCBB1Kx2nGti0BPU9H3GOthUvuqr9r3YoRi5qejR2sz8BJJAL49k/8PBirwptvEUGHIhfGb+fAUade5CxYK+PUPXNDvbKuGZWNprxSk6qLs0QhkXgsU5c0eMzAV7olRPnjsD7tSMGYLPY2nbxqRGA40LDrEzp1JlOxfCFbdX4NV+Kp/QVfBWJvqwPtt3XxDM72DHCBGpHVXRDE6BgSeJmaelmJhqqcGE9M6cs+kDTvm1LKl1geK9+0Zbo3HEhCXlmfnqjNa0rkDBdcdH7ZfauQRwal0vOCWuqVq2qY2YiV96C6OFehPQTuia2qkSSkVN+YHoqNw4tkllqbCxEIKe
x-ms-exchange-antispam-messagedata: 7kDWXhTxb/ujeMXvH+C1gA5RgvF5sojSVOq6vlRwGsVy6Qcdbnylp6uCXumy/tnkBLemtt/Cxnd6V+IPdiONP9bxJgHn/d0VeZaa1Ocazl0+cvceGdLdwIyR9E5JXOJ0OJYjOjVIMhQM5XT28YcPOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd007a2-a901-429e-0cc3-08d7ae604ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 19:34:55.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYmE/8dGNwsJLvFMSDVLwHafBvx+EKEbwkLyYOeaf/vHF+KOTukkglhLKCdB/STmn0GqGq1dqsBpNbaoq7fC/CE5i2C5YBabvXRFwgvR8JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1738
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGVsbG8gU2VyZ2VpLA0KDQpPbiBGZWIgMTAsIDIwMjAsIENocmlzIEJyYW5kdCB3cm90ZToNCj4g
U2lkZSBub3RlLCBlcmFzZSBzZWVtcyBPSy4uLmJ1dCB3cml0aW5nIGRhdGEgc2VlbXMgdG8gZ2V0
IG1lc3NlZCB1cC4NCj4gQXMgeW91IGNhbiBzZWUgYmVsb3csIGl0J3MgYWRkaW5nIDIgYnl0ZXMg
b2YgMDAgaW50byB0aGUgd3JpdGUgc3RyZWFtLg0KPiANCj4gJCBmbGFzaF9lcmFzZWFsbCAvZGV2
L210ZDMNCj4gRXJhc2luZyAyNTYgS2lieXRlIEAgMTAwMDAwMCAtIDEwMCUgY29tcGxldGUuDQo+
ICQgaGV4ZHVtcCAtQyAtbjEwMCAvZGV2L210ZDMNCj4gMDAwMDAwMDAgIGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZg0KPiB8Li4uLi4uLi4uLi4uLi4uLnwN
Cj4gKg0KPiAwMDAwMDA2MA0KPiAkIGhleGR1bXAgLUMgLW4xMDAgL2Rldi9tdGQzDQo+IDAwMDAw
MDAwICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYNCj4g
fC4uLi4uLi4uLi4uLi4uLi58DQo+ICoNCj4gMDAwMDAwNjANCj4gJCBlY2hvICJoZWxsbyIgPiAv
ZGV2L210ZDMNCj4gJCBoZXhkdW1wIC1DIC1uMTAwIC9kZXYvbXRkMw0KPiAwMDAwMDAwMCAgNjgg
NjUgNmMgNmMgMDAgMDAgNmYgMGEgIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmDQo+IHxoZWxsLi5v
Li4uLi4uLi4ufA0KPiAwMDAwMDAxMCAgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgIGZmIGZmIGZm
IGZmIGZmIGZmIGZmIGZmDQo+IHwuLi4uLi4uLi4uLi4uLi4ufA0KPiAqDQo+IDAwMDAwMDYwDQoN
Cg0KSSB0aGluayBoZXJlIGlzIHRoZSBpc3N1ZSBvZiB0aGUgZXh0cmEgMDBzIGluIHRoZSB3cml0
ZSBieXRlIHN0cmVhbS4NCg0KRm9yIHlvdXIgY29kZSwgeW91IGhhdmUgdGhpcyBpbiBmdW5jdGlv
biBycGNpZl9pb194ZmVyKCk6DQoNCgkJCW1lbWNweShkYXRhLCBycGMtPmJ1ZmZlciArIHBvcywg
bmJ5dGVzKTsNCgkJCWlmIChuYnl0ZXMgPiA0KSB7DQoJCQkJcmVnbWFwX3dyaXRlKHJwYy0+cmVn
bWFwLCBSUENJRl9TTVdEUjEsDQoJCQkJCSAgICAgZGF0YVswXSk7DQoJCQkJcmVnbWFwX3dyaXRl
KHJwYy0+cmVnbWFwLCBSUENJRl9TTVdEUjAsDQoJCQkJCSAgICAgZGF0YVsxXSk7DQoJCQl9IGVs
c2UgaWYgKG5ieXRlcyA+IDIpIHsNCgkJCQlyZWdtYXBfd3JpdGUocnBjLT5yZWdtYXAsIFJQQ0lG
X1NNV0RSMCwNCgkJCQkJICAgICBkYXRhWzBdKTsNCgkJCX0gZWxzZQl7DQoJCQkJcmVnbWFwX3dy
aXRlKHJwYy0+cmVnbWFwLCBSUENJRl9TTVdEUjAsDQoJCQkJCSAgICAgZGF0YVswXSA8PCAxNik7
DQoJCQl9DQoNCg0KQnV0LCB5b3UgY2Fubm90IGRvIGEgMzItYml0IHJlZ2lzdGVyIHdyaXRlIHdo
ZW4geW91IGhhdmUgbGVzcyB0aGFuIDMyLWJpdHMgb2YgZGF0YS4NCg0KSWYgeW91IG9ubHkgaGF2
ZSAyIGJ5dGVzIG9mIGRhdGEgbGVmdCB0byB3cml0ZSwgeW91IGhhdmUgdG8gZG8gYSAxNi1iaXQg
d3JpdGUgdG8gdGhlIFNNV0RSMCByZWdpc3Rlci4NCklmIHlvdSBvbmx5IGhhdmUgMSBieXRlIG9m
IGRhdGEgbGVmdCB0byB3cml0ZSwgeW91IGhhdmUgdG8gZG8gYSA4LWJpdCB3cml0ZSB0byB0aGUg
U01XRFIwIHJlZ2lzdGVyLg0KDQpJZiB5b3Ugb25seSBoYXZlIDMgYnl0ZXMgb2YgZGF0YSBsZWZ0
IHRvIHdyaXRlLCB5b3UgZmlyc3Qgc2VuZCAyIGJ5dGVzLCB0aGVuIHNlbmQgdGhlIGxhc3QgYnl0
ZS4NCg0KWW91ciByZWdtYXAgaXMgb25seSBzZXQgdXAgdG8gZG8gMzItYml0IHdyaXRlcywgc28g
eW91J2xsIGhhdmUgdG8gdXNlIHNvbWV0aGluZyBsaWtlIGlvd3JpdGUxNiBhbmQgaW93cml0ZTgu
DQpUaGlzIGlzIHdoeSBJIGRpZCBub3QgdXNlIHJlZ21hcCBpbiBteSBTUEktQlNDIGRyaXZlci4N
Cg0KRm9yIGV4YW1wbGUsIGhlcmUgaXMgdGhlIGNvZGUgZnJvbSBteSBTUEktQlNDIGRyaXZlcjoN
Cg0KCXdoaWxlIChsZW4gPiAwKSB7DQoJCWlmIChsZW4gPj0gNCkgew0KCQkJdW5pdCA9IDQ7DQoJ
CQlzbWVuciA9IFNNRU5SX1NQSURFKFNQSURFXzMyQklUUyk7DQoJCX0gZWxzZSB7DQoJCQl1bml0
ID0gbGVuOw0KCQkJaWYgKHVuaXQgPT0gMykNCgkJCQl1bml0ID0gMjsNCg0KCQkJaWYgKHVuaXQg
Pj0gMikNCgkJCQlzbWVuciA9IFNNRU5SX1NQSURFKFNQSURFXzE2QklUUyk7DQoJCQllbHNlDQoJ
CQkJc21lbnIgPSBTTUVOUl9TUElERShTUElERV84QklUUyk7DQoJCX0NCg0KCQkvKiBzZXQgNGJ5
dGVzIGRhdGEsIGJpdCBzdHJlYW0gKi8NCgkJc213ZHIwID0gKmRhdGErKzsNCgkJaWYgKHVuaXQg
Pj0gMikNCgkJCXNtd2RyMCB8PSAodTMyKSgqZGF0YSsrIDw8IDgpOw0KCQlpZiAodW5pdCA+PSAz
KQ0KCQkJc213ZHIwIHw9ICh1MzIpKCpkYXRhKysgPDwgMTYpOw0KCQlpZiAodW5pdCA+PSA0KQ0K
CQkJc213ZHIwIHw9ICh1MzIpKCpkYXRhKysgPDwgMjQpOw0KDQoJCS8qIG1hc2sgdW53cml0ZSBh
cmVhICovDQoJCWlmICh1bml0ID09IDMpDQoJCQlzbXdkcjAgfD0gMHhGRjAwMDAwMDsNCgkJZWxz
ZSBpZiAodW5pdCA9PSAyKQ0KCQkJc213ZHIwIHw9IDB4RkZGRjAwMDA7DQoJCWVsc2UgaWYgKHVu
aXQgPT0gMSkNCgkJCXNtd2RyMCB8PSAweEZGRkZGRjAwOw0KDQoJCS8qIHdyaXRlIHNlbmQgZGF0
YS4gKi8NCgkJaWYgKHVuaXQgPT0gMikNCgkJCXNwaWJzY193cml0ZTE2KHNic2MsIFNNV0RSMCwg
KHUxNilzbXdkcjApOw0KCQllbHNlIGlmICh1bml0ID09IDEpDQoJCQlzcGlic2Nfd3JpdGU4KHNi
c2MsIFNNV0RSMCwgKHU4KXNtd2RyMCk7DQoJCWVsc2UNCgkJCXNwaWJzY193cml0ZShzYnNjLCBT
TVdEUjAsIHNtd2RyMCk7DQoNCg0KQ2hyaXMNCg0KDQoNCg==

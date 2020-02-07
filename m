Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB53156154
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2020 23:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGWgr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 17:36:47 -0500
Received: from mail-eopbgr1400127.outbound.protection.outlook.com ([40.107.140.127]:54144
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727031AbgBGWgr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 Feb 2020 17:36:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBlSrZDc/G88KvsLNlJw9z7OYIlmHIXw8r17zn2IWHOqF9HZ0AOUqu7DhAvGPdqF4U7214TScmcwDJSL7TsmLQ0sZLMObjlp2piVl19KvwsVfFtxrWkbLAbdaOFLIoA/hkXDAdMk9L0Qdh7RVppn7rNEuTHcUyQW96pG6P6E7omohs8nTc9SyCvF3QB6XS3JYST5PtUb3/0a5jUfJtqz1fzTPw4rmuxU6r1ygQprSdY2CdYFixDiVf6OSE6zZYtHR8pGdyu+OonWT6sQSxf5Vu3C3Zi/hiZiwtwJXuzy37R77zSzyFCpFVipSUoZMYgXM9q4PFB6HnihI4hVLbthfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GnDXechib9ke13HZIpyH4LJ8HcIN1J2o7jgtTSQVIE=;
 b=iMAchrHsk4DzHaIHVJwLdv+l59Bgizx0WqbTCygOx6XTyQjbq1InmjsG3HMRDfXPz+yNSA1O0H9y1MqFT0MhxcjVJOMiJDTVvBGPQMGQ4HW5vPyPYyMoIUDzmQNqhgDGbPeAPw7PlmyFxrCp/NNQF6ExXxwAnNbM541cK0/Mqll7HbDxKC/x7Zn1noCYUgT0kxrZ2Tiv1QyZaHDnyuxYItmr6VayqChXiRPBerB0n48yTGFUSP8lDx5JlWJyIzwi1PExU6AFp4BcaMnrCcNiV1tz6H1Hz5uetvGQbSEppoRw4OFIz2fHc7rL4aCPD54uQXi/ebJmry0PP2z2hz81gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GnDXechib9ke13HZIpyH4LJ8HcIN1J2o7jgtTSQVIE=;
 b=JLAC3xTkdDz8Cz31lH0m+DrugXstOuYkG3bNrEVTvaoi3NUtdebZM5Ksqz7WDUGiM0tz9ANfRb+v2Olvf5fgucwRTEMtePF5tovRqrMm5JKk7DMtAeE3k5KwZ6yOTHDBro7JYoV5S8pK+Z920afpQbgiHprszfRUoBcqTC+uTPc=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1482.jpnprd01.prod.outlook.com (52.133.163.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 22:36:42 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8870:97e4:a63c:67ea]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8870:97e4:a63c:67ea%7]) with mapi id 15.20.2707.020; Fri, 7 Feb 2020
 22:36:42 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mason Yang <masonccyang@mxic.com.tw>
Subject: RE: [PATCH v2] spi: add Renesas RPC-IF driver
Thread-Topic: [PATCH v2] spi: add Renesas RPC-IF driver
Thread-Index: AQHVy+TviPn/l/o2I0KvRtYPATdXYagQb3lw
Date:   Fri, 7 Feb 2020 22:36:42 +0000
Message-ID: <TY1PR01MB1562509AEBD0B4460D3FEC798A1C0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
In-Reply-To: <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNGU4YjMzNGYtNDlmYS0xMWVhLWFhNWItOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDRlOGIzMzUwLTQ5ZmEtMTFlYS1hYTViLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTMxMCIgdD0iMTMyMjU1ODg2MDA4MTA3MjMwIiBoPSJQK0N5TjVITzk2bkgvRklCa2RaTDJ6VVc5Zlk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b4cfc37-275f-47a4-1f13-08d7ac1e343c
x-ms-traffictypediagnostic: TY1PR01MB1482:
x-microsoft-antispam-prvs: <TY1PR01MB1482FA1BC59D7C33A9F753268A1C0@TY1PR01MB1482.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(39830400003)(396003)(346002)(189003)(199004)(55016002)(9686003)(478600001)(5660300002)(66446008)(66946007)(81166006)(52536014)(64756008)(6506007)(66556008)(76116006)(33656002)(81156014)(8676002)(66476007)(8936002)(186003)(4326008)(71200400001)(86362001)(110136005)(26005)(316002)(2906002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1482;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d90KVP53aZqY52XspJXm/sjeB72ezhQ1oav/EYkF1NG8HdMZn3lGY9bumqAhsIsBM8V893WxQsWb+5RhI32EOG6fMrz72/1BjLYws9w939P40zA6vRdDiTZjNGLwx1R+CBeA+JuoYcGEBuaa0+J4TVZXbt7d116rxgdIVkK6xRnPcvairRt8603oItOAwzKFRp3AjOWvqYy2QHM3GnKUbT52ey3+wvHksQ9EnBAFpPXC0C/rg2obBQgZbLCpfuzpmnpKUkeOQmGvU4L48gpiXnXT59P+9MzXAE6D+1SczalTlpaN9AJH/st3jxu1boJIL4Ghjzkz7otkZFZeTUmERH6jYiVvWQaFwmWZEa2n27cE+MqnWO0EkGm8Oe39AZMgFZA3Ij5X5pSXRPPyHiaLUnsgX08gCFYkm7Z5xETGIBghInOiZd6LUGMRAOybrwdv
x-ms-exchange-antispam-messagedata: a78k8B0nLcpX+GB20pRtvtDSjnE/o1xpzLh3/y806I5H/HiKd0Q4GqdxzKUkntgr4o9iNIQecHByEjvBQwB3KF4i2LKS/FhSZ+Mr1snlAWHheyKoILEOytxBHSsJGnhKPDjbeoVDtlGwPqH0ZUPzLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4cfc37-275f-47a4-1f13-08d7ac1e343c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 22:36:42.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wntCnswTsAjn1Icy28IHyvB3CWslBx32w13TMtE7HdSa73cUEBU2uofKyepBhhGmpdmtmFZeSlgd39ypHhvrEy0PE7SGHwXA4dkWODAzP2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1482
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gV2VkLCBKYW4gMTUsIDIwMjAsIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToNCj4gQWRkIHRoZSBT
UEkgZHJpdmVyIGZvciB0aGUgUmVuZXNhcyBSUEMtSUYuICBJdCdzIHRoZSAiZnJvbnQgZW5kIiBk
cml2ZXINCj4gdXNpbmcgdGhlICJiYWNrIGVuZCIgQVBJcyBpbiB0aGUgbWFpbiBkcml2ZXIgdG8g
dGFsayB0byB0aGUgcmVhbCBoYXJkd2FyZS4NCj4gV2Ugb25seSBpbXBsZW1lbnQgdGhlICdzcGkt
bWVtJyBpbnRlcmZhY2UgLS0gdGhlcmUncyBubyBuZWVkIHRvIGltcGxlbWVidA0KPiB0aGUgdXN1
YWwgU1BJIGRyaXZlciBtZXRob2RzLi4uDQoNCkkgdHJpZWQgdGhlc2UgcGF0Y2hlcyBvbiBhbiBS
Wi9BMUggUlNLIGJvYXJkLg0KDQpBdCBmaXJzdCwgdGhpbmdzIHdlcmUgbG9va2luZyBnb29kLiBJ
dCB3b3VsZCBwcm9iZSB0aGUgU1BJIGZsYXNoIGNvcnJlY3RseQ0KYW5kIEkgY291bGQgcmVhZCBv
dXQgZGF0YS4NCg0KQnV0LCB3aGVuIEkgd2VudCB0byB0cnkgYW5kIGRvIGFuIGVyYXNlLCBpdCBh
bGwgd2VudCBiYWQuDQpMb29raW5nIGF0IHRoZSBhY3R1YWwgU1BJIGxpbmVzLCB0aGUgY29tbWFu
ZHMgY29taW5nIG91dCBkb24ndCBsb29rIGxpa2Ugd2hhdA0KSSB3b3VsZCBleHBlY3QgZnJvbSBh
biBNVEQgZGV2aWNlLg0KDQpGb3IgZXhhbXBsZSwgSSBkbyBhIA0KICAkIGZsYXNoX2VyYXNlYWxs
IC9kZXYvbXRkMw0KYW5kIGFsbCB0aGF0IGNvbWVzIG91dCBhcmUgUmVhZCBTdGF0dXMgY29tbWFu
ZHMgKDB4MDUpLg0KQWxsIHRoZSB3cml0ZSBlbmFibGVzIGFuZCBlcmFzZSBjb21tYW5kcyBhcmUg
bWlzc2luZy4NCg0KU28sIGl0IGxvb2tzIGxpa2UgYW55IGNvbW1hbmQgdGhhdCBpcyBhIHdyaXRl
LW9ubHkgbmV2ZXIgYWN0dWFsbHkgc2VuZHMNCmFueXRoaW5nLg0KDQpJIGRpZCB0cnkgYW5kIGRv
IGEgcGFnZSBwcm9ncmFtIGNvbW1hbmQ6DQogICQgZWNobyBoZWxsbyA+ICAvZGV2L210ZDMNCkl0
IHNlbnQgdGhlIHBhZ2UgcHJvZ3JhbSBjb21tYW5kICgweDEyKSwgYnV0IGluIHRoaXMgY2FzZSwg
aXQgc3RpbGwgZGlkbid0IHdvcmsNCmJlY2F1c2UgYSB3cml0ZSBlbmFibGUgY29tbWFuZCB3YXMg
bm90IHNlbnQgZmlyc3QuDQpJIGFzc3VtZSB0aGUgTVREIGxheWVyIGlzIHJlcXVlc3RpbmcgdGhl
IGNvcnJlY3Qgc2VxdWVuY2Ugb2YgY29tbWFuZHMsIGJ1dA0KU29tZWhvdyB0aGlzIG5ldyBkcml2
ZXIgaXMgZHJvcHBpbmcgb2YgdGhlbS4NCg0KQ2hyaXMNCg0KDQo=

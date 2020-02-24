Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81A916AD5E
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBXR2t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 12:28:49 -0500
Received: from mail-eopbgr1410133.outbound.protection.outlook.com ([40.107.141.133]:2673
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727644AbgBXR2t (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Feb 2020 12:28:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY7DxX0iJqZ+tsukUf3WyrbGnQ+tnBt3FLk2UY4KCQsR5GitR8DJOub+HCsUIJpJWSoL1MS2j8xMUXaw3vMPUUPxjR/2N91gfNiqHZTPoiPaDvEnzdubj464AW9ESU1clOT8JBlY4kEh0n2ZHkeNBU5q1D3St8g7PGkNuor5TEbp/r4QDYaIo+zWVYpq2SXItoLl+pF5cL4mLURMrv6Rnmot0h0JMP6sgTt9p/yv0oIbz+b/uMWC9OppjquApK/AC1UR/L3unKi0GM2VNODf8zcypDi0vAZOGQkQa69hFNc5nO1V8Z5QD5DUlpFEvr8Poi5K+yG1g1ybtjAjljUFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFlFCTTda4chxHpUkvyeAlQH+voauOQTNgW+C8lL0VM=;
 b=oIkqj8JbTG+OmjEzlnH/vPl/b2BVxu7DTuC0VwcT6frRVOSZKe4sAEz1kJ+Sk6V7aZJHnR7hjDPSGzTLw3clyVO/TpMoauG0ibuJmGNSK3oVOn7mEQM7i5yEt9zZuwAT1rUYopG2PLQUXpdKDhd6GMnC5lBzReVNLvwVUBq0HKr5bfIwXfzOpqO8NYWgorZ9pw9URuyvUTrhrWI/nQ/7iMJWMsIZlccMwtxcp1p19WqM5j+MObC021psn/6oK/Ycbn91jfi0ExOwj4s7xnmvEwPjX6w6sP7u/xHHjUIzWxNeHMKZye6f5r+ieuNsampA0VD+vyzFI5E/jRGJMwFzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFlFCTTda4chxHpUkvyeAlQH+voauOQTNgW+C8lL0VM=;
 b=ULPqMWuXSNFx7ipohxo8gC6lHmD6elyYxskUk71n42Wkd1rUL9i8HVOoHdgHRh6EErI58ja+fnR9Gz5/MA6S37zEXK1t0CwHAfu0WA28Snkpk7zkTYwi4qkrvkL1DnQW8+sZ813YBmw/ngI49I9twXWn/ubaT5yEhbd3ubBcxXw=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1PR01MB1612.jpnprd01.prod.outlook.com (52.133.160.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 17:28:44 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8870:97e4:a63c:67ea]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8870:97e4:a63c:67ea%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:28:44 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
Thread-Topic: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
Thread-Index: AQHVr5Gax3utlknyaU2JKDcLrJZnRqgUmJAAgBOJewCAAipPgIAAwo8w
Date:   Mon, 24 Feb 2020 17:28:44 +0000
Message-ID: <TY1PR01MB15620153764A0D4035080B638AEC0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
 <5760bcdb-e44b-6f18-7262-9526684e5780@de.bosch.com>
 <5603f393-554d-e2a8-c2d8-6bafc20f4169@cogentembedded.com>
 <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
In-Reply-To: <cba1e2ec-4896-23ef-ef7b-0f80d4310127@de.bosch.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTllNjBiYmUtNTcyYi0xMWVhLWFhNWQtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDE5ZTYwYmJmLTU3MmItMTFlYS1hYTVkLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iNjQ1IiB0PSIxMzIyNzAzODkyMjg3MjYyNDkiIGg9ImQ1TTk1L3RaVFVoS216a2lqbGFkRkxEUDZIYz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [24.206.39.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d978d6b-821c-4919-e4a4-08d7b94effbb
x-ms-traffictypediagnostic: TY1PR01MB1612:|TY1PR01MB1612:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-microsoft-antispam-prvs: <TY1PR01MB16128BA4CAFDA845C48F84A38AEC0@TY1PR01MB1612.jpnprd01.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(33656002)(4326008)(71200400001)(8936002)(478600001)(81166006)(2906002)(26005)(52536014)(81156014)(8676002)(4744005)(6506007)(9686003)(55016002)(316002)(64756008)(7696005)(186003)(66946007)(5660300002)(76116006)(86362001)(110136005)(66476007)(66556008)(66446008)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1612;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yq3Bv3KLR/vQuXiUOJCDl46Vg8h35RZg0iAwqslVmlPoFMdDbWLnMAIjiSEL5MwyNXjIA7BZyvo34EOBeMYg2cmGfTBHREhxwymrP67l7GO7xdTLN6xWAo/vuHZNTKbp4IgYfrWnUOtNMnjItyXyo/QZO9DXi85lWFHKxvCi3vXfFj9HnA/7EHSbq4BqEi0VAnt8CUD1ENvZux7Gh/AZfZO/v7JzzOIsvqtEkaxe4zITvlSCfzqUbdhyO2ZCIw7GqGXmoN5k6bk6WjbLHBrxNzaVhy/j6FZWq1/al5acPT6tw8tcXGrXH7E7apfy+9UV2HhvMqXgvnAytf3UcIvKJkPIwslp4qd91KeqrjP4xKSZgZQO2FKO7gGHWEgkx1IrfScQKOlnOJds0UnakxK2IhVGTn8rkMlivSz6Ut0iInv0qpqgH8+LMbapn/w0+/Rp
x-ms-exchange-antispam-messagedata: G0MEB7gEM9YB2PuO3JuBfeJtNIDCgDjg1WbVKKDib0Kuo7Nuwf9dT3OttQ6OKiiKVED1v2O2A8GUHn+55AURDE3oBnpAV9/AboL98kVmfIt3A7cObO6GktCjbqiKT3YJivElWZHMrozZC1AQgDfkHQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d978d6b-821c-4919-e4a4-08d7b94effbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 17:28:44.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1/B7uR99zlAfGMHgZaisWmB/5u6jbiiUi+nZTKpDUKtsjpf3RExw/H82rLClptOAhv/6Oyv9lh4AsTJJFuaMN36vRYqDrhHnlv0txD1ZrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1612
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCBGZWIgMjQsIDIwMjAgMSwgQmVobWUgRGlyayAoQ00vRVNPMikgd3JvdGU6DQo+ID4g
ICAgIEJUVywgeW91ciBwYXRjaCBoYWQgd2hpdGVzcGFjZSBydWluZWQsIEkgaGFkIHRvIGFwcGx5
IGl0IGJ5IGhhbmQsIHlvdSdkDQo+IGJldHRlcg0KPiA+IGF0dGFjaCB0aGUgcGF0Y2hlcywgbm90
IHBhc3RlLiA6LS8NCj4gDQo+IA0KPiBPay4gVGhlcmUgYXJlIG90aGVyIG1haWxpbmcgbGlzdHMg
Y29tcGxhaW5pbmcgYWJvdXQgYXR0YWNobWVudHMgOykNCj4gDQo+IEV2ZW4gYmV0dGVyLCBtYXli
ZSB3ZSBzaG91bGQgcHV0IHdoYXQgd2UgaGF2ZSBzbyBmYXIgcHVibGljbHkgYW55d2hlcmUsDQo+
IGUuZy4gZ2l0aHViLg0KDQpUaGF0IHdvdWxkIGJlIGdvb2QgZm9yIG1lIGFzIHdlbGwgc2luY2Ug
SSdtIGFsc28gdHJ5aW5nIHRvIG1ha2Ugc3VyZSB0aGUNClNQSSBtb2RlIHdvcmtzIHdpdGggdGhl
IFJaL0EgZGV2aWNlcywgYW5kIEkndmUgYWxyZWFkeSBwb2ludGVkIG91dCBzb21lDQpjaGFuZ2Vz
IHRoYXQgYXJlIG5lZWRlZCBpbiB0aGUgY29kZSBmb3IgdGhhdC4NCg0KQ2hyaXMNCg==

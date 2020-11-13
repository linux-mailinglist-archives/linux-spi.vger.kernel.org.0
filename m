Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0582B1825
	for <lists+linux-spi@lfdr.de>; Fri, 13 Nov 2020 10:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKMJW7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Nov 2020 04:22:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49362 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMJW6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Nov 2020 04:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605259378; x=1636795378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vhGPTPVvs/GLZ1bKVr+gHsQslM5YUkDznIdkuBcpxtc=;
  b=qiJEkCUm78llsh8RQRJgrRibGWLZRmwayElQpoOhjeqEEr346j2eUs7/
   J43hz9A2HfNSKmL28d1jG7aWslkvr9k2hz+TbIBcjiIqxyGeLxC0m01ml
   WHGZSYSROYsHbC5LeY1b0JT/TpRHpnV6Z0nlCdl6Qhv3BXQIUzAyeoi6/
   UNtRrB7XFxI/S+gt/yYLznpMf67r7MLJOHlwdCmuvvY7wtoNcFW945WlS
   YY2QQ1ercpz4XOgslY8oYk6ho1GJkvhKbt7vEYkZCvbopBfmdz11pC8Rc
   N8zYxCgJojumVjH3P8IoliO16FtmPt2BDz0RHEPhTjfMdzaFVkHCOBnh5
   Q==;
IronPort-SDR: ElwMMwfYKt4favxwrpLC/WejHDJrF8Np7EtjX4RZAmg5AtoHtgvCH4NtfeN1o7WUHlzp6DvPdS
 0+/8SfNn9nSRkuTcUK0tq91QOrvqa/PrIp3r/PZNNMaUh4uCfnZyaKNEVId3k+DmyEhKD45enX
 /2afucd5N3jZajveC0OPrmwPpe3RqVLzZTtHaMTJr5fmenxcI0FBvrjCKzbOY/Z1IyNX7mw9qb
 EmP96LznoH/bJTjZRSg2FyA2vlwOYmD2bMscqBN+3QrnNts7iPpyabm9ZgtyEZ6BFTuol0FWm6
 PMw=
X-IronPort-AV: E=Sophos;i="5.77,475,1596470400"; 
   d="scan'208";a="153755605"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2020 17:22:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+EMzhyt/NHwJatoy7AGoUNqC5aNoQMFLOtaIeYovuAZ0f/ADB4eiLRWYZBYNvvpnqTVz8nNz7ojyWTii1d7fPrpnmEd7JcNoagHDaTlgAkzOqbMxmLitkjHMX8RTG3glN5UelQ0WycQYPAsdiovc8SUwyD23PYCTSOxEUdwVc/mj8KTqsFfyGYtsoTngWXjtMAsAIRaYMs0cmIV7VmiEO5PH+JvgaVyhFYIoc89LqYzqZ2I1JMNHjbzHU4HgEUvdJntUiyCJIBrxysWPoYKMxzXKqq0ijxzj4ASVhhp8BtXH1eicRbMu7oHdfbgH7OpdhfBzX34t897XmB5GClKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhGPTPVvs/GLZ1bKVr+gHsQslM5YUkDznIdkuBcpxtc=;
 b=d7MV5Jeep/0xiKrWWaCFZS+WdYEpUuguYUdf/KpOpkTNZ/HoWsDVzhOKdBxIjs/z+1CuaB2k7Vi7rmJf4yTFCNdLrq1Xp/XEmCx2iLKm+iXgNKa5xg5Q5BNIvAhvyqDZZCyuLvUqjKK8ujIxkCFMKytEmbjmWoASeJFUMBXrt36Rmh4qCc5BMMdGQcnLcU8R1EBipdj0EtIUSYC7NeRkOyhvtoa8DnxBjUr6hqiTDsGansJQd/584vJKbG+s8NH31TrZ5mrYlZyXAJCmCPpSYQNDQkWkuyZpR5tcKV7dydcy8N3uNSenbH5zWcEQkiRj2/nJh8eAs0/MVtqsiYCraQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhGPTPVvs/GLZ1bKVr+gHsQslM5YUkDznIdkuBcpxtc=;
 b=GgpkyfWcOErWTXW6hSO2YC+YegpQyidTEUAisw+9MAnNJmI72I7/zO59cWQqwBcVRbVAO9gTcrIkuFf51qXJgeC6k9U4+05eDa4bh6JnqCqsnS/rNNeXfwkxpnvgeGvwsJGSZY97Q2AQFTAfOVHvA2rGllNO+P8fH0JPqq9i0jk=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6595.namprd04.prod.outlook.com (2603:10b6:208:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 09:22:54 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Fri, 13 Nov 2020
 09:22:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "seanga2@gmail.com" <seanga2@gmail.com>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Thread-Topic: [PATCH 04/32] spi: dw: Introduce polling device tree property
Thread-Index: AQHWtN4Jq5yxP9fdykKNjBOI754ZyqnAO9uAgAWXiAA=
Date:   Fri, 13 Nov 2020 09:22:54 +0000
Message-ID: <58943f7988706497040cac6f6108336286e9d15f.camel@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
         <20201107081420.60325-5-damien.lemoal@wdc.com>
         <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
In-Reply-To: <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91bc297d-efe6-487b-ca16-08d887b5b3a8
x-ms-traffictypediagnostic: BL0PR04MB6595:
x-microsoft-antispam-prvs: <BL0PR04MB659592F556B743CA086894E9E7E60@BL0PR04MB6595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JpO55x7+SlY9NIpI10WB13VmycVDTQEUJHX8fqivHJ0nmvus8pZOMLDtMAOB3rLZkPiQurAAolfA/gDZDFEy5qa9qDUO1HyBy11HlHucVBWJIWK0wetmidtPsgf0t/Ri+0s02hGufs3UIHl9lLy66iLx2i7HZ9RQ00IFRLlyucTkugo+hsa8IwvUAajjr2ZFFWIrxX7J/FlWTEdWf/BDsXvfI/FwQP2ZnUYOszFptaTaPj1O1X28/1560f+1Lj2eIpbKvvK/uZpquWHcwzV6u+CUy79d5pP3MgGF9GTlVGCHz4wyaw/iy1dgVLx9rtHs3LqnghxmcrGLvsGSgm8yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(36756003)(6512007)(2906002)(478600001)(66946007)(6506007)(4326008)(86362001)(316002)(83380400001)(6486002)(5660300002)(8676002)(66556008)(66476007)(54906003)(64756008)(76116006)(6916009)(8936002)(91956017)(2616005)(71200400001)(66446008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BXzjWKrmB1KLdMYqnRTBD8HXCg5WLgAoiU+uvkcBsY4o+NTNB1sGDbXtUwYcVp5SEQKMGu5dMOTfSzB9r8VUxefiHfrA6a2N/zoVzNTwv9zwyfqP2Znpcs/RT4P8B1X3ZIXjJxw8DIabvWtffNmA4jYZZflpInRe6T+mcvM6P2z6W5K8f+HHr5imAgJO1coM9adGbVSyb3mkeSTWCdHsBNptifgU95jTou1dbXjboOuy154IDeF9Rj1GXODkdd8hgVwhoju+ZR/w0Vqidjrf6vBbtbOK1TCrAs32eXxK8KVjJ5YL2f9mXe8yirCQqxfez7wXCxsnBvQnYR0t4urfL97cI1XyIVANlOrQfTY59Vlp8aY9JVxfE6Nz6YKzb2aMNDy3xC7OJr8c4yyCXd55w/wJwJ/2fcN2o+4PQ4hCr5nmV15g2iEeWUg+/jo8/qfYF42gVjR5Eh+KPAxqwnkH5qFU9r3S++ppESO5YugGMXifR/1lMx9pfx8dsfzSrseUUOtns43/JKTOC6R9/93qGpdQKtuLDhYkmS8/ER2rjpueRslSyy3xpStVIyD2tUKWYqU9qXWEzo0gLoIjDxLDJNHd7Q5cEzmmKfBNi1NtRlG5FMmnOPoAF/Viz2deuye3lqKip5olMAs5nUnnI9ITUcWji2hals4RYn7sJYd23ZUl+qLih2uvq42icOkMd1LSoWmWEBnYM/9AcXfftAPgRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B23609E5220A70499C517C8ACFF72FE5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bc297d-efe6-487b-ca16-08d887b5b3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 09:22:54.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9bcGwCY6kIij6wcZ15uLQuhrJ37x1wINqwOJB1fJ5koXxl9ehs39oCMMceEkNtK2UvCiTMf8yuS9ith7ahcHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6595
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTA5IGF0IDIyOjU5ICswMzAwLCBTZXJnZSBTZW1pbiB3cm90ZToNCj4g
T24gU2F0LCBOb3YgMDcsIDIwMjAgYXQgMDU6MTM6NTJQTSArMDkwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6DQo+ID4gV2l0aCBib2FyZHMgdGhhdCBoYXZlIHNsb3cgaW50ZXJydXB0cyBjb250ZXh0
IHN3aXRjaCwgYW5kIGEgZmFzdCBkZXZpY2UNCj4gPiBjb25uZWN0ZWQgdG8gYSBzcGkgbWFzdGVy
LCBlLmcuIGFuIFNEIGNhcmQgdGhyb3VnaCBtbWMtc3BpLA0KPiANCj4gPiB1c2luZw0KPiA+IGR3
X3NwaV9wb2xsX3RyYW5zZmVyKCkgaW50ZWFkIG9mIHRoZSByZWd1bGFyIGludGVycnVwdCBiYXNl
ZA0KPiA+IGR3X3NwaV90cmFuc2Zlcl9oYW5kbGVyKCkgZnVuY3Rpb24gaXMgbW9yZSBlZmZpY2ll
bnQgYW5kDQo+IA0KPiBJIGNhbiBiZWxpZXZlIGluIHRoYXQuIEJ1dCB0aGUgbmV4dCBwYXJ0IHNl
ZW1zIHF1ZXN0aW9uYWJsZToNCj4gDQo+ID4gY2FuIGF2b2lkIGEgbG90DQo+ID4gb2YgUlggRklG
TyBvdmVyZmxvdyBlcnJvcnMgd2hpbGUga2VlcGluZyB0aGUgZGV2aWNlIFNQSSBmcmVxdWVuY3kN
Cj4gPiByZWFzb25uYWJseSBoaWdoIChmb3Igc3BlZWQpLg0KPiANCj4gTm8gbWF0dGVyIHdoZXRo
ZXIgaXQncyBhbiBJUlEtYmFzZWQgb3IgcG9sbC1iYXNlZCB0cmFuc2ZlciwgYXMgbG9uZyBhcyBh
DQo+IGNsaWVudCBTUEktZGV2aWNlIGlzIGNvbm5lY3RlZCB3aXRoIGEgR1BJTy1iYXNlZCBjaGlw
LXNlbGVjdCAob3IgdGhlDQo+IERXIEFQQiBTU0ktY29udHJvbGxlciBmZWF0dXJlIG9mIHRoZSBh
dXRvbWF0aWMgY2hpcC1zZWxlY3QgdG9nZ2xpbmcgaXMNCj4gZml4ZWQpLCB0aGUgUnggRklGTyBz
aG91bGQgbmV2ZXIgb3ZlcnJ1bi4gSXQncyBlbnN1cmVkIGJ5IHRoZSB0cmFuc2Zlcg0KPiBhbGdv
cml0aG0gZGVzaWduIGJ5IGNhbGN1bGF0aW5nIHRoZSByeHR4X2dhcCBpbiB0aGUgZHdfd3JpdGVy
KCkNCj4gbWV0aG9kLiBJZiB0aGUgZXJyb3Igc3RpbGwgaGFwcGVucyB0aGVuIHRoZXJlIG11c3Qg
YmUgc29tZSBidWcgaW4NCj4gdGhlIGNvZGUuDQo+IA0KPiBJdCdzIGFsc28gc3RyYW5nZSB0byBo
ZWFyIHRoYXQgdGhlIHBvbGxpbmctYmFzZWQgdHJhbnNmZXIgaGVscHMNCj4gdG8gYXZvaWQgdGhl
IFJ4IEZJRk8gb3ZlcmZsb3cgZXJyb3JzLCB3aGlsZSB0aGUgSVJRLWJhc2VkIHRyYW5zZmVyDQo+
IGNhdXNlcyB0aGVtLiBCb3RoIG9mIHRob3NlIG1ldGhvZHMgYXJlIGJhc2VkIG9uIHRoZSBzYW1l
IGR3X3dyaXRlcigpDQo+IGFuZCBkd19yZWFkZXIoKSBtZXRob2RzLiBTbyBiYXNpY2FsbHkgdGhl
eSBib3RoIHNob3VsZCBlaXRoZXIgd29yaw0KPiB3ZWxsIG9yIGNhdXNlIHRoZSBlcnJvcnMgYXQg
c2FtZSB0aW1lLg0KPiANCj4gU28gdG8gc3BlYWsgY291bGQgeW91IG1vcmUgdGhyb3VnaCBkZWJ1
ZyB5b3VyIGNhc2U/DQoNCkkgZGlkLiBBbmQgSSBoYXZlIG11Y2ggYmV0dGVyIHJlc3VsdHMgbm93
LiBMZXQgbWUgZXhwbGFpbjoNCjEpIFRoZSBkZXZpY2UgdHJlZSB3YXMgc2V0dGluZyB1cCB0aGUg
U1BJIGNvbnRyb2xsZXIgdXNpbmcgdGhlIGNvbnRyb2xsZXINCmludGVybmFsIGNoaXAgc2VsZWN0
LCBub3QgYSBHUElPLWJhc2VkIGNoaXAgc2VsZWN0LiBVbnRpbCBub3csIEkgY291bGQgbmV2ZXIN
CmdldCB0aGUgR1BJTy1iYXNlZCBjaGlwIHNlbGVjdCB0byB3b3JrLiBJIGZpbmFsbHkgZm91bmQg
b3V0IHdoeTogSSBzaW1wbHkNCm5lZWRlZCB0byBhZGQgdGhlICJzcGktY3MtaGlnaCIgcHJvcGVy
dHkgdG8gdGhlIG1tYy1zbG90IG5vZGUuIFdpdGggdGhhdCwgdGhlDQpDUyBncGlvIGlzIGNvcnJl
Y3RseSBkcml2ZW4gYWN0aXZlLWhpZ2ggaW5zdGVhZCBvZiB0aGUgZGVmYXVsdCBhY3RpdmUtbG93
IGFuZA0KdGhlIFNEIGNhcmQgd29ya3MuDQoyKSBXaXRoIHRoaXMgY2hhbmdlIHVzaW5nIHRoZSBH
UElPLWJhc2VkIENTLCB0aGUgcGF0Y2ggInNwaTogZHc6IEZpeCBkcml2aW5nDQpNT1NJIGxvdyB3
aGlsZSByZWNlaXZpbmciIGJlY2FtZSBjb21wbGV0ZWx5IHVubmVjZXNzYXJ5LiBUaGUgU0QgY2Fy
ZCB3b3Jrcw0Kd2l0aG91dCBpdC4NCg0KTm93IGZvciB0ZXN0aW5nLCBJIGFsc28gcmVtb3ZlZCB0
aGlzIHBvbGxpbmcgY2hhbmdlLiBSZXN1bHRzIGFyZSB0aGVzZToNCjEpIFdpdGggdGhlIHNhbWUg
U1BJIGZyZXF1ZW5jeSBhcyBiZWZvcmUgKDRNSHopLCBJIGNhbiBydW4gdGhlIFNEIGNhcmQgYXQg
YWJvdXQNCjMwMCBLQi9zIChyZWFkKSBidXQgSSBhbSBzdGlsbCBzZWVpbmcgc29tZSBSWCBGSUZP
IG92ZXJmbG93IGVycm9ycy4gTm90IGEgbG90LA0KYnV0IGVub3VnaCB0byBiZSBhbm5veWluZywg
ZXNwZWNpYWxseSBvbiBib290IGFzIHRoZSBwYXJ0aXRpb24gc2NhbiBzb21ldGltZXMNCmZhaWxz
IGJlY2F1c2Ugb2YgdGhlc2UgZXJyb3JzLiBJbiBtb3N0IGNhc2VzLCB0aGUgYmxvY2sgbGF5ZXIg
cmV0cnkgb2YgZmFpbGVkDQpyZWFkL3dyaXRlcyBjb3ZlciBhbmQgbm8gYmFkIGVycm9ycyBoYXBw
ZW4sIGJ1dCB0aGUgUlggRklGTyBvdmVyZmxvdyBlcnJvcg0KbWVzc2FnZXMgc3RpbGwgcG9wIHVw
Lg0KMikgTG9va2luZyBpbnRvIHRoZSBjb2RlIGZ1cnRoZXIsIEkgcmVhbGl6ZWQgdGhhdCBSWEZM
VFIgaXMgc2V0IHRvIGhhbGYgdGhlDQpmaWZvIHNpemUgbWludXMgMS4gVGhhdCBzb3VuZCByZWFz
b25hYmxlLCBidXQgYXMgdGhhdCBkZWxheXMgaW50ZXJydXB0DQpnZW5lcmF0aW9uIHVudGlsIHRo
ZSBSWCBmaWZvIGlzIGFsbW9zdCBmdWxsLCBJIGRlY2lkZWQgdG8gdHJ5IGEgdmFsdWUgb2YgMCB0
bw0KZ2V0IHRoZSBpbnRlcnJ1cHQgYXMgc29vbiBhcyBkYXRhIGlzIGF2YWlsYWJsZSByYXRoZXIg
dGhhbiB3YWl0aW5nIGZvciBhIGNodW5rLg0KV2l0aCB0aGF0LCBhbGwgUlggRklGTyBvdmVyZmxv
dyBlcnJvcnMgZ28gYXdheSwgYW5kIEkgY291bGQgZXZlbiBkb3VibGUgdGhlIFNQSQ0KZnJlcXVl
bmN5IHRvIDhNSHosIGdldHRpbmcgYSBzb2xpZCA2NTBLQi9zIGZyb20gdGhlIFNEIGNhcmQgd2l0
aG91dCBhbnkgZXJyb3INCmF0IGFsbC4NCg0KTXkgdGFrZToNCiogVGhpcyBjb250cm9sbGVyIGlu
dGVybmFsIENTIHNlZW1zIHRvIGJlIHRvdGFsbHkgYnJva2VuLg0KKiBUaGlzIFNvQyBoYXMgcmVh
bGx5IHNsb3cgaW50ZXJydXB0cywgc28gZ2VuZXJhdGluZyB0aGVzZSBlYXJsaWVyIHJhdGhlciB0
aGFuDQpsYXRlciBnaXZlcyB0aW1lIHRvIHRoZSBJUlEgaGFuZGxlciB0byBraWNrIGluIGJlZm9y
ZSB0aGUgRklGTyBvdmVyZmxvd3MuDQoNCkluIHRoZSBWMiBzZXJpZXMgZm9yIFNQSSBEVywgSSBh
ZGRlZCBhIERXX1NQSV9DQVBfUlhGTFRSX0NMRUFSIGNhcGFiaWxpdHkgZmxhZw0KdG8gc2V0IFJY
RkxUUiB0byAwLCBhbHdheXMuIFRoYXQgd29ya3Mgd2VsbCwgYnV0IHRoaXMgaXMgbWF5IGJlIHN0
aWxsIHNpbWlsYXINCnRvIHRoZSAicG9sbGluZyIgaGFjayBpbiB0aGUgc2Vuc2UgdGhhdCBpdCBp
cyB0dW5pbmcgZm9yIHRoaXMgU29DIHJhdGhlciB0aGFuIGENCnByb3BlcnR5IG9mIHRoZSBjb250
cm9sbGVyLiBCdXQgSSBkbyBub3Qgc2VlIGFueSBvdGhlciBzaW1wbGUgd2F5IG9mIHJlbW92aW5n
DQp0aGVzZSBhbm5veWluZyBSWCBGSUZPIG92ZXJmbG93IGVycm9ycy4NCg0KPiBPbiB0aGUgb3Ro
ZXIgaGFuZCB0aGUgZXJyb3JzIChidXQgbm90IHRoZSBSeCBGSUZPIG92ZXJmbG93KSBtaWdodCBi
ZQ0KPiBjYXVzZWQgYnkgdGhlIERXIEFQQiBTU0kgbmFzdHkgZmVhdHVyZSBvZiB0aGUgbmF0aXZl
IGNoaXAtc2VsZWN0DQo+IGF1dG9tYXRpYyBhc3NlcnRpb24vZGUtYXNzZXJ0aW9uLiBTbyBpZiB5
b3VyIE1NQy1zcGkgcG9ydCBpcyBoYW5kbGVkDQo+IGJ5IHRoZSBuYXRpdmUgRFcgQVBCIFNTSSBD
UyBsYW5lLCB0aGVuIGl0IHdvbid0IHdvcmsgd2VsbCBmb3Igc3VyZS4NCj4gTm8gbWF0dGVyIHdo
ZXRoZXIgeW91IHVzZSB0aGUgcG9sbC0gb3IgSVJRLWJhc2VkIHRyYW5zZmVycy4NCg0KSW5kZWVk
LiBUaGUgR1BJTy1iYXNlZCBDUyBkb2VzIGJlaGF2ZSBtdWNoIG1vcmUgbmljZWx5LCBhbmQgaXQg
ZG9lcyBub3QgcmVxdWlyZQ0KdGhhdCAiZHJpdmUgTU9TSSBsaW5lIGhpZ2giIGhhY2suIEJ1dCBm
b3IgcmVhc29ucyB0aGF0IEkgc3RpbGwgZG8gbm90IGNsZWFybHkNCnVuZGVyc3RhbmQsIG9jY2Fz
aW9uYWwgUlggRklGTyBvdmVyZmxvdyBlcnJvcnMgc3RpbGwgc2hvdyB1cC4NCg0KDQpUaGFua3Mg
Zm9yIGFsbCB0aGUgdXNlZnVsIGNvbW1lbnRzICENCg0KLS0gDQpEYW1pZW4gTGUgTW9hbA0KV2Vz
dGVybiBEaWdpdGFsDQo=

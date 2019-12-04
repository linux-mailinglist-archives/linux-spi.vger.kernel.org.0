Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6C51121C2
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 04:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDDJw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 22:09:52 -0500
Received: from mail-eopbgr1400111.outbound.protection.outlook.com ([40.107.140.111]:53312
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726804AbfLDDJw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 3 Dec 2019 22:09:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4lFI+Gcb8+5Sp58DJ7he2I3abKriG2iN7/bg6VtYFtbqvPWUDLTfunvlNBZOzpXb+VUjqWJVArp0qpAa8qKm46LRatx/xul6GzWtaU4YieDWCzAO++1oixPo5PWUAaAfIKVGAS7LNynRVB7P+rycVDz8PN8j+Er+ELYlmFKm+G8j4jXBSlllKRtJ75hNqjykZMdFi35To8/xtPdU9FvRls4Eo4omANglxAXPpcn2ZMYHhzcs5i68c/JGh3Vf9K68RwLsSg3REXztsjw8G8wDSsprs3cVwe3T5wL5GPTae3oLBuh9sZkWtWnk0MDfaxUeFU+gnvtzIKUn4+WiM2fGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMS2jmU5TDoOWCSuh9uh8kLjmLh1N13nBafFywpdjNE=;
 b=VEQ3GsyfIS4v835xIDdeu121OJbDQAKZLzSKWEmYKLFbCmiP8RZwB1fWca5KK1CGBs2BHyOB49i7k0oTsIJ5Dwa44wLAldK6XgW5bRKk9UIhLaUBwMj45P2RkBFuEPh5D7OOZIgFbiMzbIopAWVABHR3Pv9aIjPZXM3CBNSY70YLBJRAJWfijI878L4iXteXfw6gah+L25If9Ay2lpFtjn78C81FFs/vCVWBKnF4HPCsk+KBQQpFQ/XytwYmF8o8Zn7eI/7eNAvcMwDRqo1aSiO3judXbFDKr8mWNEcIHkAcaCMm1bAKZIEzWirQ1hpnTWZU6ORpw7wG14k5arDDdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMS2jmU5TDoOWCSuh9uh8kLjmLh1N13nBafFywpdjNE=;
 b=SNv6W3x8Y0XeWLXCreCE/Qu7Y5F9MvyXFN6LrseGq/Ku0qp/PcRI6sZNUzPRqzMFkYNScU4TZYOoLM67OfJkpKPrAacMYLdyrpNBB8CNk3lJ8CQN3c1eikrzewrdWabUSDAOVVRGqqrwGvPdT0et5pEeXU5zpjzlqKr9KZzt+6M=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.163.12) by
 TY1SPR01MB1.jpnprd01.prod.outlook.com (52.133.164.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 4 Dec 2019 03:09:49 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::74db:232e:f59e:83f2%3]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 03:09:49 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: RE: [PATCH 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Topic: [PATCH 3/6] clk: renesas: r7s9210: Add SPIBSC clock
Thread-Index: AQHVqYw+LjFTYBzcx0ONO00s2jlMoaeowc4AgAACl6CAABw1AIAAaP+A
Date:   Wed, 4 Dec 2019 03:09:48 +0000
Message-ID: <TY1PR01MB1562AB46693003DB54D57C0C8A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-4-chris.brandt@renesas.com>
 <CAMuHMdUxCdJXyY15f6sr+QFNpg9FLsa5pL3171bm_meJcBNR2g@mail.gmail.com>
 <TY1PR01MB1562D198A463C18B1D810DF48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdXKn3GN5toqH=s4=KuEhEO_10Qi9EAyC_VT4-E4XOWdHA@mail.gmail.com>
In-Reply-To: <CAMuHMdXKn3GN5toqH=s4=KuEhEO_10Qi9EAyC_VT4-E4XOWdHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2JyYW5kdDAxXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODY2MTg5ODgtMTY0My0xMWVhLWFhNTEtOTRlNmY3Njc5M2FlXGFtZS10ZXN0XDg2NjE4OTg5LTE2NDMtMTFlYS1hYTUxLTk0ZTZmNzY3OTNhZWJvZHkudHh0IiBzej0iMTAxMiIgdD0iMTMyMTk5MDI1ODcxOTM5NDQzIiBoPSIxZnZIQUJTWFpzV1UzSWxzTU1VZ3BvMHJHb3M9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 252fa417-33a9-4a03-db82-08d778676c4c
x-ms-traffictypediagnostic: TY1SPR01MB1:
x-microsoft-antispam-prvs: <TY1SPR01MB181F2E7DF0A1DD91D36A88A5D0@TY1SPR01MB1.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(189003)(99286004)(86362001)(11346002)(66946007)(256004)(14444005)(229853002)(76116006)(64756008)(66556008)(66446008)(54906003)(478600001)(7696005)(316002)(186003)(52536014)(446003)(66476007)(76176011)(6436002)(25786009)(6246003)(4744005)(81156014)(26005)(8936002)(102836004)(6116002)(3846002)(2906002)(8676002)(74316002)(7736002)(305945005)(81166006)(55016002)(9686003)(5660300002)(6916009)(14454004)(6506007)(71190400001)(33656002)(71200400001)(4326008)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1SPR01MB1;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3QHK8dsjRoPpPOCEI+e4EtXCIUxuW+D6DHBi2/GDsN5WMUmePb+25OBn3wt77v/uvrHWV960eoIo5cPCrj+GdiG/0aPUTvXBagxd91A5aMNXz+mukKNAPnt5HgAGgVYrvUXVMpuWZsePc+1qLFo75T3aAz4nytLlIGkH+ENRiRahzhXxIFOVucqbncIR11ikJdmoQ9YcccYdbbQflTI52AzN0p8sU3sVzZU+0idH+CGCjzS3JO2b1k7jG3UAN831qIeNqicXjPpzt0Yga9yxUIUDaRvAUvRRladB1JDusDycip6+zezPHOkpdCwggJ0hRvZ5nXq3Qc0n6ai3xFch3sKxud6mSREfIU5cwJyi8deY9I2MfgJUPwThmuW17flba1fCkiWkbn5LEmxrgAEOkJzm0RRUQW0n/GKkbvNSyKsOoR4jQuLjeRxwpMfT+3CE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252fa417-33a9-4a03-db82-08d778676c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 03:09:48.8946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Bhaxz8LeAzEixOglZe4czfG8QkynWrYkgevRyrMcJFd29lDisrv959vHgQdfcMcNjEKmqJOU8+9+dcdfJ3s+BNnJvmjqoMDgm9CCtq0t3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1SPR01MB1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gPiBXZWxsLi4udGVjaG5pY2FsbHkuLi55b3UgZG9uJ3QgbmVlZCB0aGUg
Im10ZC1yb20iIHBhcnRpdGlvbiB3aGVuIHVzaW5nDQo+ID4gdGhlIEFYRlMgZmlsZSBzeXN0ZW0u
IEJ1dCwgd2UgY2FuIG1ha2UgYSBydWxlIHRoYXQgeW91IGhhdmUgdG8gdXNlIGl0DQo+IHJlZ2Fy
ZGxlc3MuDQo+IA0KPiBKdXN0IHdvbmRlcmluZywgaG93IGRvZXMgQVhGUyBhY2Nlc3MgdGhlIEZM
QVNIIHdpdGhvdXQgaXQgYmVpbmcgbWFwcGVkIHVzaW5nDQo+ICJtdGQtcm9tIj8NCg0KaW9yZWFt
cCBpbiB0aGUgZHJpdmVyICh0aGUgcGh5c2ljYWwgYWRkcmVzcyBnZXRzIHBhc3NlZCBhcyBhbiBh
cmd1bWVudCkuDQpCdXQsIGFzIHRoZSBEQVggcGVvcGxlIGZvdW5kIG91dCwgaW9yZW1hcCBpbiBh
IGZpbGUgc3lzdGVtIGRyaXZlcnMgaXMgYSANCmJpZyBuby1ubyB3aGVuIHlvdSBhcmUgdHJ5aW5n
IHRvIGdldCBhIG5ldyBmaWxlIHN5c3RlbSBpbnRvIG1haW5saW5lLg0KTmljb2xhcyAoUGl0cmUp
IGFsc28gcmFuIGludG8gdGhpcyB3aGVuIGhlIHdhcyBhZGRpbmcgWElQIHN1cHBvcnQgdG8gDQpj
cmFtZnMgbGFzdCB5ZWFyLi4uLmhlbmNlIG10ZC1yb20gaXMgbWFuZGF0b3J5IGZvciB0aGF0Lg0K
DQpJIHdvdWxkIGxpa2UgdXMgdG8gYmUgYWJsZSB0byBmbGFnIGEgY2xvY2sgYXMgY3JpdGljYWwg
d2l0aG91dCBhIA0Kc3BlY2lmaWMgdXNlIGNhc2UgdG8gbG9vayBmb3IgKGllLCBsb29raW5nIGZv
ciBtdGQtcm9tKS4NCg0KRm9yIFJaL0ExLCB3ZSdyZSBhbGwgc2V0IGJlY2F1c2Ugd2UgY2FuIGRv
IGl0IGluIHRoZSBib2FyZCdzIC5kc3QuIEVhc3khDQoNCkkganVzdCB3aXNoIGl0IHdhcyB0aGF0
IGVhc3kgZm9yIFJaL0EyICh1c2luZyB0aGUgbmV3ZXIgcmVuZXNhcy1jcGctbXNzcg0KZHJpdmVy
KS4NCg0KDQpDaHJpcw0K

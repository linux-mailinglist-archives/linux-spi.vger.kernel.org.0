Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3959EE2
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2019 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfF1Pag (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jun 2019 11:30:36 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62730 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1Pag (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jun 2019 11:30:36 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="36285096"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2019 08:30:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Jun 2019 08:30:33 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 28 Jun 2019 08:30:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=PG2M+vp0rs1DvLBPpN0cSMz+K+qmyAgVdkC2n04U+CHk7BcuQ4Wk1aVqweNqAdaClhHvQ37bFx4ApKW4c9fd4quNjah2nuSGTlxzxoRA0u1BGfIiVRah1iIdGUtQgUoAnHRD/u6mTRG+WgVY4gw5sU26rmxH/Nm81MIEGqxcif0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/45dqXfh1vQABaTObJenkRoAnxkBWxTCOIA67xQx3ns=;
 b=BgargPMG+yAbLRHAQk6q7ro8xcd0HYU0ep1zwyqJRQ5dhKuB5zB0B4HQNBKiHBQQH+TQi8SpWVVmQp820GNDF2D5mY6NoOnVqF5kJMzryUysJeypXG8FEzdnKT6sNqWoIPlY6KYzg/dR7zss3C0IHjwQ6DZ+dt+56kWk/Z72B4c=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/45dqXfh1vQABaTObJenkRoAnxkBWxTCOIA67xQx3ns=;
 b=TMZcMvL1ZOsjdFGI6/a5E+4vWzt5m2bcInYamtonFUvuF8OBWy0mpzqU5C8kdRkHeoUjUYaAlr+i0eJJItlGHG9wDSuEuHqI1F6Xa1WKBgNfwEIc/JRMB1uPOkkIcDV5tP4haBpbmbdjX3XzgbxX0fQWyFUx1+Cea/lsnfHW4zA=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1729.namprd11.prod.outlook.com (10.175.98.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 15:30:32 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::ed4c:cf24:e5c0:43ab]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::ed4c:cf24:e5c0:43ab%2]) with mapi id 15.20.2032.019; Fri, 28 Jun 2019
 15:30:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <mdeneen@gmail.com>
CC:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/2] spi: atmel-quadspi: void return type for
 atmel_qspi_init()
Thread-Topic: [PATCH 1/2] spi: atmel-quadspi: void return type for
 atmel_qspi_init()
Thread-Index: AQHVLcZsK/H2PQ5w102qkDFDfm9aoQ==
Date:   Fri, 28 Jun 2019 15:30:32 +0000
Message-ID: <20190628153009.7571-2-tudor.ambarus@microchip.com>
References: <20190628153009.7571-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190628153009.7571-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0601CA0042.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::52) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73f3b9ee-0574-451f-12ca-08d6fbdd8ee3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1729;
x-ms-traffictypediagnostic: BN6PR11MB1729:
x-microsoft-antispam-prvs: <BN6PR11MB1729EBDA967D9B311221A995F0FC0@BN6PR11MB1729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39860400002)(396003)(376002)(199004)(189003)(256004)(86362001)(14454004)(81156014)(6486002)(6512007)(25786009)(8936002)(6436002)(5660300002)(66066001)(107886003)(4326008)(478600001)(14444005)(54906003)(1076003)(71200400001)(305945005)(7736002)(81166006)(72206003)(71190400001)(6506007)(2616005)(11346002)(386003)(486006)(316002)(76176011)(8676002)(110136005)(2501003)(476003)(6116002)(26005)(186003)(2906002)(446003)(53936002)(68736007)(36756003)(66556008)(73956011)(66446008)(66476007)(64756008)(66946007)(3846002)(50226002)(99286004)(52116002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1729;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i+lYBVDDe3dDVDBcFVNGdGDJhRq3uj/hT3TuXWXohS3BmPN1Mk2FKFZkGHLvruEhBMjdFvTlg/qb4T2PdG6GM2I4/pTrhb7BrDnwmTb8Cs9D3enZ+un+9D9R4yvaFuiSvRhwO55KXhZ9AaA3e2jBQywDCLWn1CV0aTC7Zad2dbVNgzNk91qyY83Xa+gXBH1463lVHvL1VG3y+J+D5iDW+SBQ/T1SZePITN+pm0lWu/coaL9WFOeoUWTk/sZC4Ad6wPoEkoKUwMtbPhJG+9xna0oLBlM/pVRJj28FD8DhTq4wcUBFfqlvaGm/sbJGcMfvw4X91X0mlSBs39V1yEBPh+T6jtTZFMJ4RJTDboktONfBv5Qse5mLt39fSb9EpJ1tsBSJFzuBMDRt8c5WOVJ7di4pWPIJmJKAqfnpTEqM1HI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f3b9ee-0574-451f-12ca-08d6fbdd8ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 15:30:32.5716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1729
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpjb21t
aXQgMmQzMGFjNWVkNjMzICgibXRkOiBzcGktbm9yOiBhdG1lbC1xdWFkc3BpOiBVc2Ugc3BpLW1l
bSBpbnRlcmZhY2UgZm9yIGF0bWVsLXF1YWRzcGkgZHJpdmVyIikNCnJlbW92ZWQgdGhlIGVycm9y
IHBhdGggZnJvbSBhdG1lbF9xc3BpX2luaXQoKSwgYnV0IG5vdCBjaGFuZ2VkIHRoZQ0KZnVuY3Rp
b24ncyByZXR1cm4gdHlwZS4gU2V0IHZvaWQgcmV0dXJuIHR5cGUgZm9yIGF0bWVsX3FzcGlfaW5p
dCgpLg0KDQpTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3Jv
Y2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgfCAxMSArKysrLS0t
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgYi9kcml2ZXJzL3NwaS9h
dG1lbC1xdWFkc3BpLmMNCmluZGV4IDlmMjRkNWYwYjQzMS4uMzJlYjc0NDdjMzFhIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQorKysgYi9kcml2ZXJzL3NwaS9hdG1l
bC1xdWFkc3BpLmMNCkBAIC00MDUsNyArNDA1LDcgQEAgc3RhdGljIGludCBhdG1lbF9xc3BpX3Nl
dHVwKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQogCXJldHVybiAwOw0KIH0NCiANCi1zdGF0aWMg
aW50IGF0bWVsX3FzcGlfaW5pdChzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEpDQorc3RhdGljIHZvaWQg
YXRtZWxfcXNwaV9pbml0KHN0cnVjdCBhdG1lbF9xc3BpICphcSkNCiB7DQogCS8qIFJlc2V0IHRo
ZSBRU1BJIGNvbnRyb2xsZXIgKi8NCiAJd3JpdGVsX3JlbGF4ZWQoUVNQSV9DUl9TV1JTVCwgYXEt
PnJlZ3MgKyBRU1BJX0NSKTsNCkBAIC00MTYsOCArNDE2LDYgQEAgc3RhdGljIGludCBhdG1lbF9x
c3BpX2luaXQoc3RydWN0IGF0bWVsX3FzcGkgKmFxKQ0KIA0KIAkvKiBFbmFibGUgdGhlIFFTUEkg
Y29udHJvbGxlciAqLw0KIAl3cml0ZWxfcmVsYXhlZChRU1BJX0NSX1FTUElFTiwgYXEtPnJlZ3Mg
KyBRU1BJX0NSKTsNCi0NCi0JcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBpcnFyZXR1cm5fdCBh
dG1lbF9xc3BpX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQpAQCAtNTM2LDkgKzUz
NCw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KIAlpZiAoZXJyKQ0KIAkJZ290byBkaXNhYmxlX3FzcGljazsNCiANCi0JZXJyID0g
YXRtZWxfcXNwaV9pbml0KGFxKTsNCi0JaWYgKGVycikNCi0JCWdvdG8gZGlzYWJsZV9xc3BpY2s7
DQorCWF0bWVsX3FzcGlfaW5pdChhcSk7DQogDQogCWVyciA9IHNwaV9yZWdpc3Rlcl9jb250cm9s
bGVyKGN0cmwpOw0KIAlpZiAoZXJyKQ0KQEAgLTU4Nyw3ICs1ODMsOCBAQCBzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIGF0bWVsX3FzcGlfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJY2xr
X3ByZXBhcmVfZW5hYmxlKGFxLT5wY2xrKTsNCiAJY2xrX3ByZXBhcmVfZW5hYmxlKGFxLT5xc3Bp
Y2spOw0KIA0KLQlyZXR1cm4gYXRtZWxfcXNwaV9pbml0KGFxKTsNCisJYXRtZWxfcXNwaV9pbml0
KGFxKTsNCisJcmV0dXJuIDA7DQogfQ0KIA0KIHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhhdG1l
bF9xc3BpX3BtX29wcywgYXRtZWxfcXNwaV9zdXNwZW5kLA0KLS0gDQoyLjkuNQ0KDQo=

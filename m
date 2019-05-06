Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3B14DE6
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2019 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEFO4a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 10:56:30 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:15765 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfEFO4a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 10:56:30 -0400
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
X-IronPort-AV: E=Sophos;i="5.60,438,1549954800"; 
   d="scan'208";a="29265660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 May 2019 07:56:28 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 6 May 2019 07:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgL7A2/gQwOPkAdBNZtGTIvXAtszUuckM0WBOYMb9D0=;
 b=2TpzhU0D4z5cl/9jHMxudEQAOheVh6LENxZXUGZuZiS+w5ciPgOYd67EcwbwoaSGxrX74xXBagCifYrUPOBEJ/mNmK9kXCKqWJApsQ2mequf063lXhmShbgafiqqB2+AsI1PCrv6K20BfldBKCUaKA38mDG7yzm9m0iaSuulN18=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB4049.namprd11.prod.outlook.com (10.255.130.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 14:56:22 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::35b3:7af:7216:8808]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::35b3:7af:7216:8808%10]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 14:56:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH] spi: atmel-quadspi: void return type for atmel_qspi_init()
Thread-Topic: [PATCH] spi: atmel-quadspi: void return type for
 atmel_qspi_init()
Thread-Index: AQHVBBveYXVMmUTDqUy6OCq0Aik9PQ==
Date:   Mon, 6 May 2019 14:56:22 +0000
Message-ID: <20190506145606.5060-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0010.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::23) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fbee562-3924-4a36-828e-08d6d23300ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR11MB4049;
x-ms-traffictypediagnostic: BN6PR11MB4049:
x-microsoft-antispam-prvs: <BN6PR11MB40490F614FA653512F73C92FF0300@BN6PR11MB4049.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(68736007)(52116002)(5640700003)(6506007)(386003)(102836004)(66066001)(99286004)(186003)(26005)(2501003)(14444005)(53936002)(107886003)(5660300002)(256004)(2906002)(8676002)(1730700003)(81156014)(81166006)(36756003)(8936002)(14454004)(7736002)(305945005)(25786009)(6512007)(2351001)(50226002)(72206003)(478600001)(66446008)(64756008)(73956011)(66946007)(66476007)(66556008)(1076003)(6436002)(6486002)(6916009)(4326008)(6116002)(71190400001)(71200400001)(54906003)(486006)(316002)(3846002)(476003)(86362001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4049;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U+6t+hrsJuz/S/s2rg5KcBjgMrTvAnkvi81gEyEnTN1m4FmEPqO7y3arLkmmOvwSMNr7FAwP5nuHmpxGT1exeHeMVJTfZ+JK0lOkaWWzF6P5CGhFszMMWonjPunkpzxP7VVqv8bjafzJ13GA7gAFW8ldfxLlCKW2rYZsmP34PpSAbFpFZyjTrXv03/3zScB+3NsASmkpaMlNqOvOhQDQqcWK3NBhzmDbBwWt8FWjo1o5mVRNiqHdJpChmbMMIFdKo29dQwuSL9Y/ECUoOghAb7Wq7iTjIKHo5Wg8qL/5bY7Mb2ONQIr1r7Ee9yoPioiBWJ3ciAq9wuSB/Esgu3xPf2gXRvApwumBcKHOvLsYYAFhMTEo9HI1gQ+V1tF+WBSaeRr/VIOlr+plqWeeKsz/aOlt7Kfp99WZOd8FPkaTqdI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbee562-3924-4a36-828e-08d6d23300ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 14:56:22.5794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4049
X-OriginatorOrg: microchip.com
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
Y2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9hdG1lbC1xdWFkc3BpLmMgfCAxMiArKysrLS0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jIGIvZHJpdmVycy9zcGkv
YXRtZWwtcXVhZHNwaS5jDQppbmRleCA5ZjI0ZDVmMGI0MzEuLjYwYWE1YjM4MmU1OCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvc3BpL2F0bWVsLXF1YWRzcGkuYw0KKysrIGIvZHJpdmVycy9zcGkvYXRt
ZWwtcXVhZHNwaS5jDQpAQCAtNDA1LDcgKzQwNSw3IEBAIHN0YXRpYyBpbnQgYXRtZWxfcXNwaV9z
ZXR1cChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGlj
IGludCBhdG1lbF9xc3BpX2luaXQoc3RydWN0IGF0bWVsX3FzcGkgKmFxKQ0KK3N0YXRpYyB2b2lk
IGF0bWVsX3FzcGlfaW5pdChzdHJ1Y3QgYXRtZWxfcXNwaSAqYXEpDQogew0KIAkvKiBSZXNldCB0
aGUgUVNQSSBjb250cm9sbGVyICovDQogCXdyaXRlbF9yZWxheGVkKFFTUElfQ1JfU1dSU1QsIGFx
LT5yZWdzICsgUVNQSV9DUik7DQpAQCAtNDE2LDggKzQxNiw2IEBAIHN0YXRpYyBpbnQgYXRtZWxf
cXNwaV9pbml0KHN0cnVjdCBhdG1lbF9xc3BpICphcSkNCiANCiAJLyogRW5hYmxlIHRoZSBRU1BJ
IGNvbnRyb2xsZXIgKi8NCiAJd3JpdGVsX3JlbGF4ZWQoUVNQSV9DUl9RU1BJRU4sIGFxLT5yZWdz
ICsgUVNQSV9DUik7DQotDQotCXJldHVybiAwOw0KIH0NCiANCiBzdGF0aWMgaXJxcmV0dXJuX3Qg
YXRtZWxfcXNwaV9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KQEAgLTUzNiw5ICs1
MzQsNyBAQCBzdGF0aWMgaW50IGF0bWVsX3FzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCiAJaWYgKGVycikNCiAJCWdvdG8gZGlzYWJsZV9xc3BpY2s7DQogDQotCWVyciA9
IGF0bWVsX3FzcGlfaW5pdChhcSk7DQotCWlmIChlcnIpDQotCQlnb3RvIGRpc2FibGVfcXNwaWNr
Ow0KKwlhdG1lbF9xc3BpX2luaXQoYXEpOw0KIA0KIAllcnIgPSBzcGlfcmVnaXN0ZXJfY29udHJv
bGxlcihjdHJsKTsNCiAJaWYgKGVycikNCkBAIC01ODYsOCArNTgyLDggQEAgc3RhdGljIGludCBf
X21heWJlX3VudXNlZCBhdG1lbF9xc3BpX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogDQog
CWNsa19wcmVwYXJlX2VuYWJsZShhcS0+cGNsayk7DQogCWNsa19wcmVwYXJlX2VuYWJsZShhcS0+
cXNwaWNrKTsNCi0NCi0JcmV0dXJuIGF0bWVsX3FzcGlfaW5pdChhcSk7DQorCWF0bWVsX3FzcGlf
aW5pdChhcSk7DQorCXJldHVybiAwOw0KIH0NCiANCiBzdGF0aWMgU0lNUExFX0RFVl9QTV9PUFMo
YXRtZWxfcXNwaV9wbV9vcHMsIGF0bWVsX3FzcGlfc3VzcGVuZCwNCi0tIA0KMi45LjUNCg0K

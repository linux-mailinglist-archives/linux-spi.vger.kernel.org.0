Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2109613A808
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 12:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgANLKk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 06:10:40 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:39749 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLKk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 06:10:40 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: UvjBIf+DfnY1S0cSL5Svga2gj+VGC9x7Laqp3CxJ9VwS1DURoZFpO9xQYTrxUamMg/bcLPYIss
 rr1t/A+OoqcGsxTpSoC3H1wqE1gOg/VKO7d4Ekqx8gK/KmdpWulV5YQDMvD0wMCgUJlhuOlMLn
 KatDO6UFfP0uNQfQQdOnrCwh4nZ8EELndVUDDW5/BhXOytEkt+EiuqF2FBQ1UIqYEQjiWirn6h
 4xm/eZXgHcT3gXBzD50r4VrJJWK1ircc0cMeNXDxrAtSbgET1LAy2Jku+LNhsY9zl48rgs1AlR
 5NM=
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="60725974"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2020 04:10:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 04:10:16 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jan 2020 04:10:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0cj49H7p/Lt9pxpiNDJsXD7D3v0fQDh7REiz3GGtZ+v3NJytLGfdLOWBzVAlP2wpLoZaa8C182ZSfk9siRehC6Cpic24UZLaHBMhMUUQuzMmSkj23tRXwmKKGjfAnwmeIUcUNff3DlZ6O7OVtNeHv+6kDHgJ1GUTC9CpxqcPY6+e/ISlB0ZBII+NLJ1cxBWqbQW2LWFvsLg+gX/E/57fUzxdh026v2cpGJQ/Z2yNE5Vz0ctIRhhoZCfiopJ1XH0uCFInvhRKWVDkqt8KEsWdB/k87z4wgtp5ZbtbIljx5RGlQXUm1sEMH+lZk00iLNzNW5qzIuYkb/Cx9Ul8RUFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLzNbfQihk1dznnXQaesD9TJLtjYVE/FWtHivYp0/RQ=;
 b=LjwXofR/r/gB9PI/B8RLLk/2sVFNKKedQj1+kA9SG+FrieD5CjSLtl4EfAHMcmr8Iaidut5mpcKOmNWE5McaZE3AIHA4C1jPh9GaRdMIOBGGHG6Mp1TpB/6h8fpnpF6RS/41mb6eevO0aVnh0Zz5wWz2Pmm1VRkAKzADiAPXaT1YPjm35+CEYTPNafaPn7TsoclPsMVxxZkJ2cHlU7IxTKD/pXKJKI59xfp01MQDBfFnbzewGbkVGja1m9xPZo5rlCbR7KwDdSlHx+lQ+u2Czrsj6661cMqL5HHEmWwBAKm7R5tDqcFtl/2btlpHY8d2z4Ethc8zmI+i5Q6lf26DOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLzNbfQihk1dznnXQaesD9TJLtjYVE/FWtHivYp0/RQ=;
 b=kyZr80i1CNDX0pFqAqgDgVpgdwyutfYkDC+HCbasuzlxk3OuvAiurJgyGiPZoUC4u7rr0gAVzbHgYU6kVuYU9XnbNmpeDvTTvyXsOsXDEwrrXu6QBoqertHpfmmu075HPqsUfpczCgpvPwVi84qkT9VpU1bo8LjG8EipkA8+E40=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3403.namprd11.prod.outlook.com (20.176.119.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 11:10:15 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::106f:424f:ac54:1dbb%7]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 11:10:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <a.zummo@towertech.it>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] dt-bindings: atmel-usart: remove wildcard
Thread-Topic: [PATCH v3 4/7] dt-bindings: atmel-usart: remove wildcard
Thread-Index: AQHVyssxad36L/lyDU2/n1XqgFNXSA==
Date:   Tue, 14 Jan 2020 11:10:14 +0000
Message-ID: <f3c4d460-cff6-2e14-428a-a732a6bffe38@microchip.com>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-5-git-send-email-claudiu.beznea@microchip.com>
 <20200114104237.GM3137@piout.net>
In-Reply-To: <20200114104237.GM3137@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7707f527-dfd7-426f-7c15-08d798e254f7
x-ms-traffictypediagnostic: DM6PR11MB3403:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3403FAAF17B4E3B080A813A787340@DM6PR11MB3403.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(199004)(189003)(8936002)(316002)(54906003)(6486002)(76116006)(6506007)(71200400001)(53546011)(966005)(81156014)(6512007)(6916009)(2616005)(81166006)(66946007)(66476007)(31686004)(66446008)(7416002)(8676002)(86362001)(478600001)(4326008)(64756008)(5660300002)(36756003)(186003)(91956017)(66556008)(2906002)(26005)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3403;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRtof8i5WtSixCYcvsPiZ/KhzRAWZ4iiao4TB/9vA62fPfmSViKZVB5sKj1OmfzJq3shgrDg9cXxo6/0q7TM2wL9iL/q6i+Wc1dcogj3+Gbhq+6vvVO9MObBha6qHv8W6hTebOeiXLqfqXgre27HCtBblxGK2KNY2HSKVTS6/Kx0wTCjJo9q5NNhIVP4wQ2HwOh4Lr1jZpQG+tCQbkXCYy3odG19VA6t3T90i/AtjKS+9Nr05P0qE/0hJTkxFLLcxB6rMj1zzdskFSa732DVcywjyhmlJomBXjHz5SoTdtiOgnSJNEEi/UIXMePsLXCNOU75iE3xwRC2paEXIpi4kGYr3ec9ltbZHxeW5Tm5iV/WBH0RCHx8H9gedwb3QH2YOsXyDc7rOMPUW6l7xP6T/tMIR5FCBcaVgTk0ut5XPAZYRVxRKg23Z5yUHdOMU7GPDTk4Db706iCNb6eLg8PGBCtuNlP7n40K+akD+DtoVdk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3E5FBED8BFF834FA0DF10EA00CB34FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7707f527-dfd7-426f-7c15-08d798e254f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 11:10:14.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2aB7LzulXLO/srePqPWhP5Jkw3Ykow5Ij4ZKBq/rNoOJHva47az2ONcTXHnCYlbZLcc79PO39ndwJvxZS7ZphBqFD16pFZwUC95FCuNrOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3403
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

DQoNCk9uIDE0LjAxLjIwMjAgMTI6NDIsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDE0LzAxLzIwMjAgMTI6MjM6
MTQrMDIwMCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+PiBSZW1vdmUgY2hpcCB3aGlsZGNhcmQg
YW5kIGludHJvZHVjZSB0aGUgbGlzdCBvZiBjb21wYXRpYmxlcyBpbnN0ZWFkLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KPj4gLS0tDQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1l
bC11c2FydC50eHQgfCA3ICsrKy0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLXVzYXJ0LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0DQo+PiBpbmRleCA2OTlmZDNjOWFj
ZTguLjc3OGU4MzEwNjA2YSAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLXVzYXJ0LnR4dA0KPj4gQEAgLTEsMTAgKzEsOSBA
QA0KPj4gICogQXRtZWwgVW5pdmVyc2FsIFN5bmNocm9ub3VzIEFzeW5jaHJvbm91cyBSZWNlaXZl
ci9UcmFuc21pdHRlciAoVVNBUlQpDQo+Pg0KPj4gIFJlcXVpcmVkIHByb3BlcnRpZXMgZm9yIFVT
QVJUOg0KPj4gLS0gY29tcGF0aWJsZTogU2hvdWxkIGJlICJhdG1lbCw8Y2hpcD4tdXNhcnQiIG9y
ICJhdG1lbCw8Y2hpcD4tZGJndSINCj4+IC0gIFRoZSBjb21wYXRpYmxlIDxjaGlwPiBpbmRpY2F0
ZWQgd2lsbCBiZSB0aGUgZmlyc3QgU29DIHRvIHN1cHBvcnQgYW4NCj4+IC0gIGFkZGl0aW9uYWwg
bW9kZSBvciBhbiBVU0FSVCBuZXcgZmVhdHVyZS4NCj4+IC0gIEZvciB0aGUgZGJndSBVQVJULCB1
c2UgImF0bWVsLDxjaGlwPi1kYmd1IiwgImF0bWVsLDxjaGlwPi11c2FydCINCj4+ICstIGNvbXBh
dGlibGU6IFNob3VsZCBiZSBvbmUgb2YgdGhlIGZvbGxvd2luZzoNCj4+ICsgICAgIC0gImF0bWVs
LGF0OTFybTkyMDAtZGJndSIsICJhdG1lbCxhdDkxcm05MjAwLXVzYXJ0Ig0KPj4gKyAgICAgLSAi
YXRtZWwsYXQ5MXNhbTkyNjAtZGJndSIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCINCj4gDQo+
IEFsbCB0aGUgdWFydHMgYXJlIG5vdCBkYmd1cywgc28gdGhpcyBuZWVkIHRvIGJlOg0KPiANCj4g
IC0gImF0bWVsLGF0OTFybTkyMDAtdXNhcnQiDQo+ICAtICJhdG1lbCxhdDkxc2FtOTI2MC11c2Fy
dCINCj4gIC0gImF0bWVsLGF0OTFybTkyMDAtZGJndSIsICJhdG1lbCxhdDkxcm05MjAwLXVzYXJ0
Ig0KPiAgLSAiYXRtZWwsYXQ5MXNhbTkyNjAtZGJndSIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2Fy
dCINCg0KT2shDQoNCj4gDQo+IEFsc28sIHlvdSBuZWVkIHRvIHVwZGF0ZSBkcml2ZXJzL3NvYy9h
dG1lbC9zb2MuYw0KDQpPSy4gRGlkIHlvdSByZWZlciB0byBDSURSLCBFWElEIHJlZ2lzdGVycz8g
VGhleSBhcmUgYXQgdGhlIHNhbWUgb2Zmc2V0cyBhcw0KZm9yIHRoZSBvbGQgcHJvZHVjdHMuIFNv
IHdlIGNhbiByZWx5IG9uIG9sZCBjb21wYXRpYmxlIGZvciB0aGVtLiBJcyB0aGlzIE9LPw0KDQpU
aGFuayB5b3UsDQpDbGF1ZGl1IEJlem5lYQ0KDQo+IA0KPj4gIC0gcmVnOiBTaG91bGQgY29udGFp
biByZWdpc3RlcnMgbG9jYXRpb24gYW5kIGxlbmd0aA0KPj4gIC0gaW50ZXJydXB0czogU2hvdWxk
IGNvbnRhaW4gaW50ZXJydXB0DQo+PiAgLSBjbG9jay1uYW1lczogdHVwbGUgbGlzdGluZyBpbnB1
dCBjbG9jayBuYW1lcy4NCj4+IC0tDQo+PiAyLjcuNA0KPj4NCj4gDQo+IC0tDQo+IEFsZXhhbmRy
ZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJp
bmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KPiA=

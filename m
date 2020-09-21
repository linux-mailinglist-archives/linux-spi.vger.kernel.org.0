Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71214271AB0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIUGLG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 02:11:06 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:47491 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgIUGLG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Sep 2020 02:11:06 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 02:11:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600668665; x=1632204665;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=vPEH6gdeQcU9kCy3mU/n/5I3V9TR5H2I13T9qiChYGg=;
  b=piCxtuQGd91pS3UmoJTHGxJpElDNltz5UPr3kpu/Za7q+7cw9R9zMeRK
   D8Kf5ZzPHJfVeQfo++lo5o9WkkkSXEirf2/oD4mPd9ARcHZ+onkcSghUt
   VLmHEEjO+QefnlOaoBFlV2Lqft3WZYgndLBM3bJSGDHBrwcW7Xs2AsSgb
   KhgztECkZmNEkuevyqRpURE29HKNgfQfLIYRBOA7T+ZCCBVcFxIbdxqfK
   UjCWjINchWT7aH3kG7rIwmonC0TNQGc6oHUgubFyR10b2AcVV2ypJC5dG
   H8ab9pDxrNf/X9nk88oMcW3dS87HBF1a19MuXbOdAdj2w3cLNRk3RFPvy
   Q==;
IronPort-SDR: luwJExvwOtLByKQ1uWsG+OYC6WwGsi4AyBWIs45SQno28MONgW33iYYleF0uFl+dDnlybkNqeg
 06cVJTxIbBe2ejBIN01K00Y8eIPq4q70epwbNJDj6HHipUqauZCYJ5lrIWwe3Gfqe2qGsPbqbG
 ETVKzvZZ36TMQ9r7aLEhXY3mosxxN/36OjTq0inaO0Ney/XeY1X05xxtMsjhcoe2oSzFERcEVv
 99DQXJ56gcsmuI5ER4xfoEz/Amgd0th5CbzSgBZRQxpkwaHBQ0bO3Oy7vb/uDKswz2Layy4QTE
 TMU=
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="87544907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 23:03:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 20 Sep 2020 23:03:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sun, 20 Sep 2020 23:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT0x4nJZ6eZmSGFO00Lw1SeotCrhfwNRFK8S1rXl7gFrP/y6AbfQbjL/BLK1KxuT6nToSOpjt9GEYteE0gvd8/t0V8L+TYRwKYDL2mtIK9RQseJnc3Z82QJPp/5oHB0JmlN+h3QhxkLkRzEeTzg71Ws9qBfZzeZoFWcmHDIqz7mg7Waqawl8LFP9kUVL5/j3M1TU7RTLLnW1si/dhrNTq8hmUymO4zRmV3I8lQWk/kitpKUD8InUwKQIIUoRFOr2ebrk3AjHAxq8tfLURNBdb8DKaJvBPl66A5jDityDDXE1eQdslw0gqbgJ3lFOEKA/DtqzFdzlROGnVgyAdJsIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPEH6gdeQcU9kCy3mU/n/5I3V9TR5H2I13T9qiChYGg=;
 b=WJ7eG3cv0YcgrLEFAj/E3aWFUpWpwqOjuIbEiDYDzghDFn1uAy9Wt13xrkWo1eRVmwCtEtwKRrTk2sGXPYPfuZlMKFf5wxUDiYxGnCO9Yl9brT54x1drf1UkdaX2Y7aeUWcrvayw5tVZy2yG2tbQtzQsgtEjYrnJ9XwnfZ8zf4AvAlRgGxcCmumbz+nTFwMbFxG5T9YZct58IKoAJS0UpIsGTe6TWdiCYsCGkgq39jC7YIXVBnb6O4Q8+VxZCGQkY7ZQFktpU+exsdEgqMc7sJI2iD9M8Rf4tv6DF7xLG3mHhUZkGPAOxYvrsKGb2Le8CabR13feEG0SYUfEAQRKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPEH6gdeQcU9kCy3mU/n/5I3V9TR5H2I13T9qiChYGg=;
 b=MeZihs+CKq0rhgVhkFeNb56gOYKnGSmV2fGz9iJ+U3mUmEEvMuAsoetyIVvka+MRDzF1kQL8s3rSCBKTHJrnwxQxodPC2MGOH0h3QlsyWeuq6wmoQFqlEXvz7nrB3BHVg4pNn8RO52ypLdUd/nOC23IUpuhNdEf8R3xKVjPInSE=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB3404.namprd11.prod.outlook.com (2603:10b6:5:59::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 06:03:56 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3391.024; Mon, 21 Sep
 2020 06:03:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Thomas.Kopp@microchip.com>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: atmel: Exposing effective spi speed
Thread-Topic: [PATCH] spi: atmel: Exposing effective spi speed
Thread-Index: AQHWj9zNkov9L5Se/kelVpfvsappFalymj+A
Date:   Mon, 21 Sep 2020 06:03:56 +0000
Message-ID: <a0e687e1-0da1-d049-9c22-75c46fe197a3@microchip.com>
References: <20200918103737.400-1-thomas.kopp@microchip.com>
 <fe705481-ef9e-4dfb-fa86-b138a8cbf4c9@microchip.com>
In-Reply-To: <fe705481-ef9e-4dfb-fa86-b138a8cbf4c9@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.77.80.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 913b9165-aa86-4613-d407-08d85df42023
x-ms-traffictypediagnostic: DM6PR11MB3404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3404DE675C9EC05CABA61559F03A0@DM6PR11MB3404.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tq/szoAAq11j5L/Sn9jA3730DtT8pAcQ5NsvRGtyhsbdSJTWLgrKLWkhwM0N9k06XhkyreCto0ZBtr6ahaGxSYP4Icp8tLoStJ7WllQMpD95upYdtVCK9AV1vjGLvDh8dEGPq/x7lcel9EVs5Tqc6Kd8p0x5ymehRGneNnCAfOcw4aIw+GWXY0i730+uCFaTkavLA7lDro0om6fc1DwmOcTHtpsdA9xW9WxSdmuSOv+u0Fd4TLh3TS9tLc//R+tObkg4/JeRqo7jU/npmo0F/uXszyzPA1h+j4iaXyGRS3kHEFX6X3zmb1wKcMR6F/pcf3JBds8Tf35yUKe1rZ/HoblOMe7lQUYdlHTKm/0I3wQxHNepmGDcAC72rSVgwjJA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(366004)(396003)(64756008)(6506007)(66946007)(110136005)(66446008)(66476007)(26005)(66556008)(71200400001)(31686004)(53546011)(478600001)(6486002)(2616005)(36756003)(4744005)(186003)(86362001)(31696002)(316002)(76116006)(2906002)(91956017)(5660300002)(6512007)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ahfqy/3OEK0vFhDaaWwHsUmnoHDVG4Ght3jcz0Gl1232TRhzlFkYrwPMrkvXTStL2Ps1pyUeYwY1stTbSxFYSoVMItEMrF6WRYZK8vaTwC4+Vwv8trsvyGy5ORjp/m2Ek2TTEwsEiRJBdt5NFlcDXAnPToqtV2Vvs9bJphiOCbFOa4vOw6TBX5S6HcO+51FpBpCYOMtypjnUDcO63CEMq2O4nQUzNwKDSxD/TtAjSABYF0KdrdIOZAr/so31dxgPBrrVAfTr1j4F131XYEbnVpuQkBcQHnlCrDr7xd7ff9qgYQUFnaTbrrR5lAcznWShb7S7Sjdc8rn9V4mV54ZrVCsPD5pbUnfT7BJYNPkOIOcuI4VqBAOyKticAdqZClKWmqEmCP0ZSQX9dZWqEuVFrIibT8QHT9jeUMxPirKU58UFTJoTSZmU3IDkppUwgGc/dKpi6Qa0lUWfL513najDtnvaPBk8fQ2k9SrGU+DScQNvCOplE/8Z2Yg5/9z5//qRGJS6OPWUjGURtxgWw0Q8M4kyVQOT8ZDg7S28FWziNrU/f/XEaY+/AyVkOPtC1mJamXcgq78yLqY4o1NemPKigdWLpf9XCzwnFD/ijQtIIDd4A2h+EI0tGzAqU0f08XCVpA2W0NxoqeTIvKWgDkmV6w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CF333CF10343E46A06F1E9B6FB3373F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913b9165-aa86-4613-d407-08d85df42023
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 06:03:56.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8ECL0OrR3tRPSqP50mohInYJd1LZXU/aKuQlQHJQYSKlTA7GAtK2JoYiaWfsSxqOS5b2JZZrzxwyX0Cp2DcvLGqUr7MSw9PUZp9zgOtTyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3404
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gOS8yMS8yMCA5OjAyIEFNLCBUdWRvciBBbWJhcnVzIC0gTTE4MDY0IHdyb3RlOg0KPiBIaSwg
VGhvbWFzLA0KPiANCj4gT24gOS8xOC8yMCAxOjM3IFBNLCBUaG9tYXMgS29wcCB3cm90ZToNCj4+
IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGUgcmVwb3J0aW5nIG9mIHRoZSBlZmZlY3RpdmVseSB1
c2VkIHNwZWVkX2h6IGZvciB0aGUNCj4+IHRyYW5zZmVyIGJ5IHNldHRpbmcgeGZlci0+ZWZmZWN0
aXZlX3NwZWVkX2h6Lg0KPj4NCj4+IFNlZSB0aGUgZm9sbG93aW5nIHBhdGNoLCB3aGljaCBhZGRz
IHRoaXMgZmVhdHVyZSB0byB0aGUgU1BJIGNvcmUgZm9yIG1vcmUNCj4+IGluZm9ybWF0aW9uOg0K
Pj4NCj4+ICAgICA1ZDdlMmI1ZWQ1ODUgc3BpOiBjb3JlOiBhbGxvdyByZXBvcnRpbmcgdGhlIGVm
ZmVjdGl2bHkgdXNlZCBzcGVlZF9oeiBmb3IgYSB0cmFuc2Zlcg0KPiANCj4gcy9lZmZlY3Rpdmx5
L2VmZmVjdGl2ZWx5DQoNCm9vcHMsIHBsZWFzZSBpZ25vcmUgdGhpcywgZG9uJ3QgY2hhbmdlIHRo
ZSBjb21taXQgc3ViamVjdC4NCg==

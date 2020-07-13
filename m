Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017821CDE5
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 05:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGMDzI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Jul 2020 23:55:08 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:30064 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGMDzI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Jul 2020 23:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594612507; x=1626148507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I4SZ+z3h4qfcj/wEJIngM+7FiLiHmEESaJejUQbWufw=;
  b=W58pYWdabzocu0OzXgV9VJw3ecZqDFJE6zitHYCsHucTx6FT5BFTnVic
   hXWd0Z5VGrGq36S4aSRIXwgFY6x2+wIO6tq5ddu+jt4E/3pDj9bsfdXie
   vnaFp1Y4+9RpVLy5C8OX7kqepGTiOzSGOEY2Iely4oFNCy/bYjr+38PbV
   bIfQTl+FY77cEfFZgx4IYlDKA/Sv0NowG5ATZvJF58MswAut45CpnllKB
   /WqhMho90IjNPjsyj7fW9cj1+fzfw3PBtPRTXAjVUhZ8YFQA333tcEXzK
   jQC1ZIP8ULQ2hKXN0wKneR3m6xjiV8PgSZLJJgaOLwRiUUm5+6Y0gho6n
   Q==;
IronPort-SDR: IloN3Vm9h8mMoxs/nuwKmWWLvFi/ulYJYmKddaE5DUtQ3O2xHiX7EwBIH2bnN2LUsl9P06u19Y
 /z6NK5+WxXAJMyt3O92gYZTnQ0X3Dyw3ZYory2XZl2Tuu7Cg0GB4/0/N1wyFs80kqglOElFuB1
 QwMXGwN0GXeN2NXStunSi54sYw/nVGZOdllayJ1fuLo4zyxyNU8oVq4pueFG05/InSXSjznbNC
 o5XegNfB11/KTKea7er1LtYu/vKBypf47fzTxBbqLZhwuJOyo5A8UvnBWkBLqIV7F2lw7zqgl1
 GyQ=
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="18914602"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2020 20:55:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 12 Jul 2020 20:54:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sun, 12 Jul 2020 20:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8zLBwIupCyRWmzqx8Nttrw8aWgQ5YnQV91O4cNn6GqLRSZ1wN+0kLEbAka+PhzxJW27kzr5vy06MRfR19BxIeHmLt530Wf0+VztJzbGRoejl5h9HGM5JFroNO5W0WAZJuOcsGEBSMricYEnORXRzK3oGTq6jOZ1VIMIpcwPpUTda71v6cmankHJnz6Lfg+1gKynDbCLmyMRLIZWhw6W9SUcOx0C74Ke2J2TqcA0vsg6T3lMQA+Q8oEZoJz22+viO8ZB83AtcMM4VuYJKwj3y8kQd4y0TbDjNHEnjAppejTXAu19k1udWpZLs0uuez+0DOzHRJXbh67BUdMvaGKo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4SZ+z3h4qfcj/wEJIngM+7FiLiHmEESaJejUQbWufw=;
 b=WZbAJmzLqyoOcF3gLSt77x3t5DpG1jd9TGabvO0Olefk2i4V9baMyVhuBkJ88+Hx/57AsIrdZKcMvh8d1Hu6Gzlz8D5hgjrGtPfKyYIf+rQi8gOenZzIUHju9uIMjYXRgulga6hOwoq7HHsifWefLbr8Lh7dSaJCkTZWhhvDjHF+3d/qXzwHbtinTO8CQZHy5M5UGt8lWJ6ew8ThJYuEgFz3Ss2okGDwPG/OedHb64lW/Mi9jDuwAKtzEAENBeajLtzthfankuQ2vUuW8o5dtQrk4cu45skW8pXNZtldKJpmsLZ7r58tjt7E4ceBENtmIDhMKSCwNILSizQNrleADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4SZ+z3h4qfcj/wEJIngM+7FiLiHmEESaJejUQbWufw=;
 b=Fk4SYno5XKUhN2pJAxrK2S5hApxqShRbvv68QfOpvEsIp5Aupb5Wo5AfsbdmzssZDnx2chAANei/MQkRL0pTBP80viYjJ+pLA5LkfDUd/RQCU0O2O8fNyntYD8OcStDSMnHFNmu/ssJYzEGPEFdmhtus7CRNxCF0ChISAIFqWEM=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB2968.namprd11.prod.outlook.com (2603:10b6:a03:90::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 03:55:02 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 03:55:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <matthias.bgg@gmail.com>,
        <michal.simek@xilinx.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v10 01/17] spi: spi-mem: allow specifying whether an op is
 DTR or not
Thread-Topic: [PATCH v10 01/17] spi: spi-mem: allow specifying whether an op
 is DTR or not
Thread-Index: AQHWWMliL5FGGK8980aliLC/F11sVA==
Date:   Mon, 13 Jul 2020 03:55:02 +0000
Message-ID: <2702a5cb-b7a0-ce00-f943-08f359c35396@microchip.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
 <20200623183030.26591-2-p.yadav@ti.com>
In-Reply-To: <20200623183030.26591-2-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.120.242.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 046ac775-211f-48d5-bce9-08d826e08558
x-ms-traffictypediagnostic: BYAPR11MB2968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2968739D2626D37F9ADD8223F0600@BYAPR11MB2968.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nC3z0EEbT3CN+7U98q/SBPLt7Yx2LC5xIG3Xe8XeXodD4c2C1DInZIG9LWdWlS/lPVlwQMbFfx+Z1ErtwIBTGOvkc4CzJQWTYhvEP26MuzptcydYeUYLMSex6K0Iqz7teXtPEEUyFQX1Wik7QgVDrTL85MmJ2+WQpHQ+dhmT88mHogFy5tuw9PBvSZkXvZFrfh2Xodw0cRg/OFmb85KNa7uGNeZJnDnnGhOoKA+Dl/uIatYAJNSARe6oG0vsPkRF8Q3qV/BbutrcIxYMXAyI3DX+rW1El8hLJK2O7ISJgqfZY0+utaYx12CrMnXkK2WDFL0dmSFp7Akg5IQ95N9ZH0RSE4dJ/APtOUbd1e5a52pnWS1628TcU48S5iYnoAJ2Z6MywNufU0xstrzOA4M1Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(136003)(366004)(396003)(8676002)(2616005)(54906003)(316002)(6486002)(36756003)(6512007)(31686004)(478600001)(8936002)(26005)(186003)(6506007)(7416002)(31696002)(5660300002)(110136005)(53546011)(71200400001)(91956017)(2906002)(4326008)(86362001)(66446008)(66946007)(76116006)(64756008)(66556008)(66476007)(4744005)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: slg8wc9JaFhj9GAH/SCkPUOYo7ut6GAKrPnrUwEt+DOJe1F9CpqzQjQbebMNPGIeulnlXTDOWaY5E7drFtIyuWdgX03eMj9hMW8J6aO3uNFcp88XOwGbeYr7MrkCkbTlkyoz7F9Htp/lMRqIAYQ7p/pmqpdfF7JDAVMTnXxhHpXRhNUctsQ2HA0hYBZbV5FNQhTMxycH3ww/WtSNBQ8Y/VbPaj1JQIcWFSuI/P1nbQ8YvBQyi6af80yeEXt9lBaK9fPPuKS8n0sb+tsH5BqENetrKnoiouGH2fKw8e1Ajdm+GPLmeo3ilc2bbNb5kvfMGe7c/mGq+xyGsvGYXv+59AeM2wIS/EipqsJUsS9pYW74n2VZqiS3jgCMye/0I/VNwspVc1t8LHABC4RK3R1iga9saHqMO8dZ+0Yp29PLpUtTQ3c1UO3Fy8bQayGmVDFhFrjZLLH6CZKFRaHKUtdsT5tuL8wwFaE4sULwyNMxgTxmoup2Wh6DOwusJf2asEsZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A062EF7E3CBBE4386549E856BAE6DC3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046ac775-211f-48d5-bce9-08d826e08558
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 03:55:02.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkYXWlysxB7LoV8Y0N6uJUA0JTVvVVpq6j69zB2SEEB7VgMTOYr81JMnpTnuMKd6VIeDaMpILGnR1yKcNoDmb479jguof3E7NqaAnYaIe18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2968
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

T24gNi8yMy8yMCA5OjMwIFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3BpL3NwaS1tZW0uYyBiL2RyaXZlcnMvc3BpL3NwaS1tZW0uYw0KPiBpbmRleCA5
YTg2Y2MyN2ZjYzAuLjkzZTI1NTI4N2FiOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3Bp
LW1lbS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1tZW0uYw0KPiBAQCAtMTU2LDYgKzE1Niw5
IEBAIGJvb2wgc3BpX21lbV9kZWZhdWx0X3N1cHBvcnRzX29wKHN0cnVjdCBzcGlfbWVtICptZW0s
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3AtPmRhdGEuZGlyID09IFNQ
SV9NRU1fREFUQV9PVVQpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiANCj4g
KyAgICAgICBpZiAob3AtPmNtZC5kdHIgfHwgb3AtPmFkZHIuZHRyIHx8IG9wLT5kdW1teS5kdHIg
fHwgb3AtPmRhdGEuZHRyKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KDQoNCkkg
d291bGQgcHV0IHRoaXMgY2hlY2sgdGhlIGZpcnN0IHRoaW5nIGluIHRoZSBmdW5jdGlvbiB0byBl
eGl0IHNvb25lcg0KYW5kIGF2b2lkIHRoZSByZXN0IG9mIHRoZSBjaGVja3MsIHRoYXQgd291bGQg
YmVjb21lIHN1cGVyZmx1b3VzLg0KDQpBbnl3YXkgdGhpcyBpcyBqdXN0IGEgbml0Lg0K

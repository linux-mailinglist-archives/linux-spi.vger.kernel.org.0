Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D31CCA96
	for <lists+linux-spi@lfdr.de>; Sun, 10 May 2020 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEJLWV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 10 May 2020 07:22:21 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57463 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgEJLWV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 10 May 2020 07:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589109739; x=1620645739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+nX9BCk3l7rzpHkoedDjsJKecoiTpzzZtC8hqcZJgAU=;
  b=14d/4/I3uzxmouMrOpmZ+DOxEJBklxlEp7FzS+jzFCQ5hqqEax8Tj/ls
   8LbCAgXcaxaxa1Me50FoVeyQiVLfV5HjaLmuElC7F2jsJoyD+Gg1zzhKW
   rCIMBly8lcXsKPyUxOONYmg9M1mXSbA9PPjwbQSn9U6uRs65ppgJUe5Sp
   jcsBicR7ZOKN53OLXq73FkwecGDrbf2L9AvnmvAcKaSIdAjt67tDZSEE2
   Ov8rLS0w6ErusndqGGBI4UkjvxWvG3H921y4akeKBv+V3lMmZS/gr4b+R
   spALIlxQttD0dsSB96mLFUMbSvETt1pHqXJyViaRUR6wUoeKHUBAQdlnG
   A==;
IronPort-SDR: nBcJ5nL2re+B0wQJzXUohF4zO34QEyzzYxRZalMS0yvDzcv+Rh573CifEV4K1QX6n1cS6HWz8K
 3Nvy35l7at3wy5Alzu0u/MtJWVK/B2arcatyGdY8DcP6i4lDXxn3l7CyCRDjCjHex3WAey/FqE
 uf8Eg0+mM5Pokyj7lSwOXIdZvzM0aR79XzGX+VAGniiY0l5EqpIzk4oQWr5A8Ui24nVJ1HF7ob
 l7hbnS+diyLk3qRfOHAwfW3BMZnZSB/hSBDJiRqZAlBQbG2SNWHKOXiHSlmLj31AyIuhv2gilx
 xXk=
X-IronPort-AV: E=Sophos;i="5.73,375,1583218800"; 
   d="scan'208";a="76113689"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2020 04:22:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 10 May 2020 04:22:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 10 May 2020 04:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esz9Xqnv42Ge2WtVP6sx9F0TYBvyDy8LsnDlIOG3XySrU2WTnWtiBhKijCT7JDWj1TUwYImTot7ZGSEK4zAvDFWzcqLBJxDLH46dIK+Z/nrM074ysKmigWGSHEW93rnAlelSy4LmB6MGz6Ae20JwJA6kD5oJ9JYoD5MWGwzXPFffrQKjsKN6iUjCgYRt9vfcGrX3b3OyFL0SNDlfxPMbOBKO9kNvmtDUkB0SHy1pQUZO08LGnm7puKCfUr01CsyrpB5+VEuViRCJ9BzaHMpT220+bOG9m/emWPcdopo7yICQvMCWmHPAp0PR945J93+liaEf38MU/Zj4xuhYPSt3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nX9BCk3l7rzpHkoedDjsJKecoiTpzzZtC8hqcZJgAU=;
 b=BfqnkuG2Xr1qYs3MSHnM1A15mOXNYsK2ELBl1sZ+XulO5lRo0dvxVfypyfT7MqU1jTQc5FNgdl76LQXQ2dC/KQxyaozFkD7FTbg3iLoGemeGtKcOlJnGnpfnpwGlFcS/ppQXHDBl4VDPQrDrEnfFzlBJoTrB3ru3Cu1vRLY+JZ+s+k/cGyOr7Y7kT8JT804R6odbZ4oxjV1PxMt8mgssAXOqm2OflO6J2V7VnqHtxsKd5staqYlxZ2Ba/pBQCaRVwGknOn2Jit+r2BfMQ9X2OAD2y7YFM+v6rVXlz6G5abRpPX9dxYCFREniCKy89IOIA9Y56BrEUt/ZsBZmUt/36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nX9BCk3l7rzpHkoedDjsJKecoiTpzzZtC8hqcZJgAU=;
 b=CDu+sZtiBDCXszaeZIBGPPZy8p5XXERQhABMZA95uv11M+zLCzISitFaoF13zqVoC50Lo4KOx+uXt+h6MAJZb+IwC1WcBteGwWN1xugbdvuhwi0E02ecnWDMp67l9pl0joaHk1ZLR3gDXdzN++Ti5FTI2UrkEE5R4GSCHRC0sNY=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB3927.namprd11.prod.outlook.com (2603:10b6:a03:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Sun, 10 May
 2020 11:22:18 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2958.035; Sun, 10 May 2020
 11:22:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>
Subject: Re: [PATCH v4 12/16] mtd: spi-nor: perform a Soft Reset on shutdown
Thread-Topic: [PATCH v4 12/16] mtd: spi-nor: perform a Soft Reset on shutdown
Thread-Index: AQHWJr1Dp5hR4yIpUkyKNPb9KcyGvw==
Date:   Sun, 10 May 2020 11:22:17 +0000
Message-ID: <6809202.hICg0JTlGu@192.168.0.120>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-13-p.yadav@ti.com>
In-Reply-To: <20200424184410.8578-13-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 675be7d6-573c-476c-0954-08d7f4d46618
x-ms-traffictypediagnostic: BY5PR11MB3927:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB3927538F2EC76C31051B65CDF0A00@BY5PR11MB3927.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 039975700A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h5Wjmfm/Ud792C4tFKz17F44VRMFl70CfEVw+tEhf01A3iRkP8UDbYo43hV0EUpijVtW3I1VAFrRtcCXWPNhrin+v4uLHcckWJN1h5qQQJ8iLNNj+oH6ggZFqkO14AUrKhd0fIFrIIm5CxGmw1JZg4TUlwLLYMdi3/tnw+e8jy0J68DS4ihPZBaOkrnDPD6j9EV4uB9MTALrSMOo8xRcrpPCUj+cXASl6w4BJL3hXOPA598vv8Areoj/epFGilXdrlczWhq+Lf9jTds/IpGyBg0XnboLCuSfPhg5V9eXBCpwRKDCkhXWEBXBfz5GhTh6jsx0bnZYLrlNw9KcQFfpE++6mrvZZdkAmpPuf5kHpWp2u5pqh39SQYsyxKbUITt1a3vTFyrOoKQRgqHWStAA8mPpyTv8OlSXVBpsnHwU/PtQfqN6CB7Q1gEVvEY0yDOcNTfDoKGVEeW+FqZqVKixcslF3RhMu0t+DuPLem4xsX+4k4g22Clnc+m30UAiblN5vi/mJ9NP6HhM8UiToqpS9PKbvDYyCf9KTzlbiwNqg8YMbDwDZNS6u+XcgeGxtGlF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(346002)(39850400004)(396003)(33430700001)(186003)(54906003)(71200400001)(26005)(7416002)(53546011)(6506007)(316002)(8936002)(478600001)(4744005)(33440700001)(64756008)(66556008)(66476007)(66946007)(66446008)(14286002)(6916009)(76116006)(6512007)(9686003)(86362001)(5660300002)(8676002)(4326008)(2906002)(6486002)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: idWlK7bsu5OceGzLLblyPBF4dEYERRP5wUPIqhzm6bqY77cFUJh3SewRSC8SQbUb2akwU7GGDnSmQquO8xxaSb8cANAWApXXNno1tNOrkSruxq0WtRyOKI3zpm1nnK2D7ro9lLYgQnA2zsKtALDK38OVbl99UBXRDQc5QO56buyeOHXxuT+zhKgA+e8iP0bKqCtZ4yTL8WRzgyKphd9ILs+FRUqqcbrXh8aVkjjiBtLk7CFyQG8DilmoUQ8OFEdp+q82KhTEyi8xoB/lZ4IwYrwa3x9aRPtIu4G8EiyLFE5MGNepOrkdqneI6lnWipHME710XS7hD5gqqbR6ydlxP+cOJdZ/eRSc+wm3gn3ywGfgMZcbBq9TNhLU0qNwaLzlfMssBymQBYYWLhqnra6a2P7PE7epBloN/ldI5xCfi5DzuatDe33cGJf6zyyrZNHfJEK6uYT5jBRwCYeaibDrNzTOXqQD6frf2u2NPaSxTIQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <82DEBC12AFB74F43864300A63CFA5DF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 675be7d6-573c-476c-0954-08d7f4d46618
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2020 11:22:17.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivDDrzwfanN5Rl34cg86/tytYv06e7UW1/VpzU46pzRZfEHHGcpASrL8xn8QOoNWdTMcIvCkm8hGraQ25J4PzpcZxUUSCalTh/eyhc39CJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3927
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Pratyush,

On Friday, April 24, 2020 9:44:06 PM EEST Pratyush Yadav wrote:
> A Software Reset sequence will return the flash to Power-on-Reset (POR)
> state. It consists of two commands: Soft Reset Enable and Soft Reset.
>=20
> Perform a Soft Reset on shutdown on flashes that support it so that the
> flash can be reset to its initial state and any configurations made by
> spi-nor (given that they're only done in volatile registers) will be
> reset. This will hand back the flash in pristine state for any further
> operations on it.

Please don't introduce SPI_NOR_SOFT_RESET yet. We should instead determine =
the=20
software reset sequence by inspecting BFPT[16], bits 13:8.

Cheers,
ta


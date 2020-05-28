Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8551E69B0
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391390AbgE1SqT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 14:46:19 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:32099 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405901AbgE1SqR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 14:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590691577; x=1622227577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+C+43in+nstY/Hzl1lKr37mT2d8V9YiDaG6vh/XSggk=;
  b=Wi2cdPUMl58MfDEFDUL0AqFKTdMxsViARXp8/REVNWR38fEa5CIaa+dG
   W1RJPnht7ASzEg1IzxIQtk9nmQ6DRPB8RpicdOd/BsFPM8DNzvbMm5ROR
   PlPSrd2xYRA7+uQ4it/sgCmlSXBDToLoqkXHA0wdSvUO4+MEqFy7OaQXA
   E+ACJzpn+ebDPlC1GA8UA70bjXUz9AFinnKtTiuuT31td8GPYOPlvKnPF
   COxC+eNzmEmO7MHE7Iwc2fh5fPmH+wx9OiUPeYbTvWMf1rY+vjGh/Wa6L
   x9/1zN/aLih+iHvEo+ajvdQkfs5mcz1Ui9Jr+iAYrRFRzWU48EzwTYdUE
   Q==;
IronPort-SDR: 4lrbINtVatUjMIrxR49tGU8OYIMM0+dbqZUpwka1NbftX0I2rd/k4ZrwMll/5Z3c7SaOk/9nfL
 K0GdobyFH6XM77XyY3KGRG/M+8dsMhR4t7HSXzykstrApno8CucGaCrV0CZ2Yy0BJlKObYx8Te
 c6e6kilRCbzOtoLlo/JM3ueekcS47Pk6cEqR15gGMN6dc+JErRhyicmvCuzCwQhBXXeQbC7Otd
 ZpCtx1JTtDhu/uZNht6A/fJ5e1EvYm/MqZjyMD1jw08gGSZDNm0TfsLH6dgkiNZxsIgyGQaOZw
 rm0=
X-IronPort-AV: E=Sophos;i="5.73,445,1583218800"; 
   d="scan'208";a="76673755"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 May 2020 11:46:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 May 2020 11:46:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 28 May 2020 11:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC1RLZNlm3TOnFcDpu6CrJZ0kg5YYDHeZlc6AZqWsKe21atbsc8HhP7a1dhAhkW3vbnXftUshTV4f52FJpKeQxQYBwO2RDvG78ZGMc+sH78MByDJ/ubLGkqQ8srbbRuzaVgdcP5SFjhPhDtG+fhNbRvrpIruV7ROkkWkJB8G1C0Ee1GALrgEkQFWjWHkJ9e0TDXTMZZhCkgDEuSlt9s4RJEuWjYX17beHIfuxpBvc7+g2eTrP7glBuH0K/q3uMUY80ocLgXEEUQoS58nU7UzqBonOEifEmDPzUKOcEGdv4mo3u71XTOmNvIqoCi6iS05mSL2DmNR7/IwxcTspRxr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTgZ7US08+MZhteKfq6gN8h5MqiKIQiQ8GtxMP5G5pw=;
 b=Wg7DE2b3Y1fLDlbvmCs75RLqiat+JmveN4uOzG1EM1iKyoFRoOTSru5qYvhJHR+8MVvJHb46RRs2j6zZsQltJFvUOYLYXS0kecXr+Hm7fYNsrZeF/k5+ULvlVuFiw9LwpWydE07VLXgSJfE4i6uGx+OaRPLFcOyflIn5LpCo4bLrIM8j5HtN4VTlZsZ6VDnCBXCK3cWJsF2fRPq5GQoaf23yk4hihtZclCg2dxR+MaSvxy7YPLQgFGyAfFCfeN/oRpZea8qFZ+pChK4OQ+04f3jSBcMdlYvGGXotebnkQd4XCVZMS28cGzLNqWEoTPvuJ6iZLqaRG0Ljj7Mt/+j8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTgZ7US08+MZhteKfq6gN8h5MqiKIQiQ8GtxMP5G5pw=;
 b=qdVbeUULQEhvD/EUR0a8gmJXtOMr6lY7b7fCXy59g79yzkhVs0wWnBRHsGUjQhBDRik7/gitIIve5XEx2Y27sxy5GmIIW/F8+ELVAFMrkVCY1hzqaSZUR5CuGu4eKThTr6kE6GZk+SXHQLthCxChMf9bL79zUSBHZh4claGaR/g=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB3973.namprd11.prod.outlook.com (2603:10b6:a03:185::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 18:46:14 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 18:46:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>
CC:     <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 4/6] mtd: spi-nor: cadence-quadspi: Fix error path on
 failure to acquire reset lines
Thread-Topic: [PATCH v2 4/6] mtd: spi-nor: cadence-quadspi: Fix error path on
 failure to acquire reset lines
Thread-Index: AQHWM0FVAkV2DAVl1U2To3n9pTAOnKi92gKA
Date:   Thu, 28 May 2020 18:46:14 +0000
Message-ID: <10731710.Xgm1DyDOGa@192.168.0.120>
References: <20200526093604.11846-1-vigneshr@ti.com>
 <20200526093604.11846-5-vigneshr@ti.com>
In-Reply-To: <20200526093604.11846-5-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 388d2d31-ce31-49ba-1d2a-08d80337666e
x-ms-traffictypediagnostic: BY5PR11MB3973:
x-microsoft-antispam-prvs: <BY5PR11MB3973EBB8A6CE6DDF427E9261F08E0@BY5PR11MB3973.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PfESslQTVlqeDE8iCNcONCgdm8mdj6RtMf+OJKqv3GqPAMcPWMKpyTB71gZkin0FyljaOFSjEM1DzFHNToUnUuSUozJErSQgbAHd2lsNz63771pYE6+Vlkb0mG/VASdEW65lRfV6k0AnDackG99Viv+wlAigL/1JOqNT0czcuqxCAByV5hlRmkBd0l2L7i0PWjv0Mqwhsx3QB3xJhB13jNPe9j6Kqs/5xt8hdCSpXj/b04mTsF4KgY01WqIsuZF/Q7zTcH+ImVQV604LLVSMd08XZghMQgB2DWWIE8xQLpXWXTI2Blgcl7ImdfrwklPs/n2WjOdf6VO92W4gQqMHSV6XuCMMe6hLpEWHle/jNUqtMeoFXMwUWPqjDV8yY6NY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(4326008)(66556008)(91956017)(54906003)(76116006)(64756008)(66446008)(6506007)(8936002)(316002)(6512007)(9686003)(6916009)(8676002)(83380400001)(66946007)(7416002)(186003)(66476007)(14286002)(478600001)(26005)(5660300002)(2906002)(6486002)(86362001)(71200400001)(53546011)(4744005)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wPAB7BXHUutYvwnE1G3m1ak9ws4leRIlknsIu2uVW5mtShGO1qyDD+WDsYCx8SjoaB12q8vLJboREJFp8114jCSzwGBiqrW1QlEWvVxv0gv2hCzNJqD0KGYnr5s9Quhk2EYPgqh3S2invr8LsbuQWM4UEiQwoWSbZDfF2670dLh80Vs+HXQGiRh2dmMCZ3tG2jDUwlGpP/Cof48P3if4Kp0rk/1rQwZU06w5I0Hk6GHq4jukWRCQxQPNJ895JuBf4cQFlOHgcLVNx7DaAdNIHW+mV9VTO4ZtUjn+2spXqX81W2/48cF4UYKuzX8suiuyb0gjsaETskF8s8hQc3SkHCwL4rjU1SpmE2vHpa8eq7v/VtnxgUGnFVw6/cXAWH5I+haRFNclyBYOIkkWk5Ah71nwwUueV3CuAWpItQI0nDoZQpkwSwQKp2tBqjxrbWYVD7d7iHdYiQciBvGp7pu2nBAXkYC5SxP5M6jH2ajH/hg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0129F021C9F9074583D562AE24687F18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 388d2d31-ce31-49ba-1d2a-08d80337666e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 18:46:14.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUyD4Fx1JtKNQbxWlKmIhl2tuU0Ip2jXIK8EHIX9vBiuz69Gjbw8JTnB0Ij4xQKgqXGEcR+p8np5sRn5Oyc56p/YPmA77UEKOfKvFcov11Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3973
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tuesday, May 26, 2020 12:36:02 PM EEST Vignesh Raghavendra wrote:
> Make sure to undo the prior changes done by the driver when exiting due
> to failure to acquire reset lines.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/controllers/cadence-quadspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>


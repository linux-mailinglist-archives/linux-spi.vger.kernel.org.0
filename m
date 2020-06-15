Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162601F99F4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgFOOTC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 10:19:02 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:11548
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729733AbgFOOTA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 10:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW6Bu1CIPhPYhfH2iXy1jTWw+SbZP3vx8HkOuJwLr+56jJbHYGOk33zFIZ322LPl9chEmv++J2Q12BLcYgcNxkYdgIoSoFOS8/4QiP3ZxCryeAxhDvFkRycbzWm8nW5qQ+7Hqm1Zbn/HgfmQ+tb92IIimh4er/z1dR4rUKD7nOXbrvv91JEzb3ZrFv02p72tsalVuehjPpMDCftN2ljWCmHJMNclVStADG20DfcmwIp+WosiqfIEX7u8mfcrD/Uh8lAjhTZ4wyUi+UYtx4D57cAsol2J39Pi619RRJQwAZVVE3F172iiGnKAO1ELSnLNUsavgA0xrfzQsU3bqf353g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vefX8XkRnqcJbGrVQlZtX2fCZULbA2dLJI8hKiaWivM=;
 b=Pdi5O8mCKYLPgSOBwvxf5k+9WusKWW5euaGiYwnxQvpAaCtatTG8+O9uOGsLFHp0GTjy7oUQlFc24zliY/1aXC0o9mwtH0amqcFXF1Dm0EHJ3qUxZK/+689nIWTnr/O2aWulU+Vx06UIqcAXhODyGeTJcA6/UkZ00Ri8DZPq4/fY47FL1eeBY2kcvuXT1RyEJE1/HzS0t0dixWqQW6HM4RZC3432z/2JoGePKad6KmRxpNeDmJrTMaPPnxVogF1pMwXYBQhmp4TQCZf6V63mzBaLOVoG15pXS/0YuqDT+FK7FObOqBZ7ZplIe58sy4H5Tu/SSy1c6J064MAHF5D2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vefX8XkRnqcJbGrVQlZtX2fCZULbA2dLJI8hKiaWivM=;
 b=jHPyBQTa0We4sNiTapiHcxad3NwmHanbHUCeGsx8fGUR71XizxbzpnHboda9q6Ig5FpJs4eIS72GIiQNcSOMCQbZ7xEdA5dhYqhOdrXc4VEKM3Cdml+FnNRDLvOAd2FbKrgMKJ8JqbSdC5a5cqDjMWX0w3TKy4E8yPAYHRLJD44=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6415.eurprd04.prod.outlook.com (2603:10a6:803:11b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 14:18:54 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 14:18:54 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Thread-Topic: [PATCH v1 RFC 1/2] spi: introduce fallback to pio
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUCAAJUwgIAACjoQgAA5dICAAOmA8IADsXmAgAANH1CAAASJgIAACZlA
Date:   Mon, 15 Jun 2020 14:18:54 +0000
Message-ID: <VE1PR04MB6638793C00742D5BA72F8AC2899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615123553.GP4447@sirena.org.uk>
 <VE1PR04MB6638C65257F41072C3D61583899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615133905.GV4447@sirena.org.uk>
In-Reply-To: <20200615133905.GV4447@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.235.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78c1ec6c-a227-4087-3571-08d8113708f7
x-ms-traffictypediagnostic: VE1PR04MB6415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6415ACC0634C21B7794E4E3F899C0@VE1PR04MB6415.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvTow8U+q7wxBWkMifneUgsotU9ai3gzHeTDsflteZC343sFITeQdbYOa2XWOoHmBLyWghbaSlg1ZfFImikO+9EYkvxz6Wh3e2hJFzsxwe1GAHSh1l4Rf3xPRjj0DTXbq+duH6RvGZaG6mBaHDLURJIGj8aL1dWioSyiiXYKp9Sy9srj30oY5wORjEeFFRlv9Z0B8BbP/2Lhiz2Dkjj78PlaO5IAia6EeW6FzoQgCYTK9OmoCGoLuH/kZjhtagBDxXh38vbfOO4wpRLZJQez8vndOWXdiPblw3vuipvPQgwPSrQUI555KLr9NRH+6+/i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(54906003)(83380400001)(71200400001)(8936002)(5660300002)(52536014)(186003)(8676002)(26005)(4744005)(316002)(7696005)(478600001)(53546011)(76116006)(66476007)(66556008)(6916009)(64756008)(66446008)(33656002)(6506007)(66946007)(2906002)(86362001)(7416002)(9686003)(4326008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fnNB4/W0OTi84Rc+Ogok1m+DxaGA+tFek+k2ISGUhcUjBSprkFO2CJ2o/LR0KE9HUwltqGPNJst7OJjHIq83/AJg4UI4rgOPchk4UL7Izorn+wm6pC6KEGwbOpDGBvrvD7zE4naeU/lkr2CnYYORATo0WACaTcF96LPAb5hbDoWXegAjVV0nzsJPoN+SXtN7jTmVGzNivl+utqOuobRdjhFCydDbpRDz36mqaXCr8UKLepNokF47VWKc1CnczwrUZYJo/UrILZFBMp1VJajqQkZrKsGV+ZYPnveju7rVzpkRijJBZ13TXg+cR/AVW6VeYqYaEQ2O+85zsw8FXfVVlFccwnDU6qJLQTYTabSS0yIAqmBDTBcodmItRF32a/aIphsNVQDYXTOxZBCZ51kxs7y7Y4iFCK+XfpVqu2RPo+6XP5DONBBwF32PKLgs4ivWsexs6RuvkphwbBtAo1x6qB74chiImS+Xf5WVqncKdOw1PT+iHhAiHs7eALwyCd+I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c1ec6c-a227-4087-3571-08d8113708f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 14:18:54.3138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAzgrywaEFfmYboIEKPk3AJosen31bKXzQtNY3lKjuGd9bZ3EBDNWuJhyv90SyhxLKE9l1c47ALPK0OqBmK67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6415
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/15 21:39 Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 15, 2020 at 01:35:01PM +0000, Robin Gong wrote:
> > Then how about choosing specific error code for such dma not ready
> > case where nothing went out on the bus neither?
>=20
> Yes, that's what I suggested.
Seems not easy to find a suitable error value, how about EBADR which
sounds like no any available dma_async_tx_descriptor got by calling dmaengi=
ne_prep_slave_sg?=20
#define EBADR           53      /* Invalid request descriptor */

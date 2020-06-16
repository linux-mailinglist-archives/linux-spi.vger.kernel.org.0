Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5441FA691
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFPDGA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 23:06:00 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:29830
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgFPDF7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Jun 2020 23:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKEHvOY72dWUJYiFyYo+Vp5HyuijfTlMHe1T9lRYYdXbNrlnKL8FqfayizoHHjJEqeTPtEBBkxZcAwG6/ZdVZ9bXquoK2IvX6oXYbLXzeR2Fxh2wOHA/iX6F7/QMWUKKt8A8beZ5skfHQIQeKRa8jw4BtuE+XcSSjV6rDbREV8Yd1sUoA6s10sx1CohypnlTZCvZUgIhxiRfKLzOs3mmZBL15KXnjh+B9qSsunkxUUcqViQflW0ga2OGJBWZBpaRakvy54GEdY+rmAC7+8d1z9jRqb/tnybPC49uFDVK3tnlwTRrjrr3tutYIbo5/MCT5oUCe/kd6vHQZh1IJPl24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ8GOj68YeLjqFXpDjCGCY5SU5XB0D7N1n7cI1P0qwg=;
 b=UILEHIGCOZOyX6ykWa305i/dxQrb9FVMqBQUV/IIdu+XxJVXJE+SiwETw+WryJlmxnrkFCS3DmzHj1GYIFogDKN+oNtNyUc+k08GN7OApri/pUZXx6TSGjR8wnBbMt529iBAISYv6oPU23txYtTvvEyuUQNgEP60X/3gW0H6lTIaSv6E6QM5CutUHP3hjd0dxGP7HTlU3/smuEjh/5AWqpRyPdJiQwZU4A4og5o9us7vlzdFbPMXOX6HrAlXc+Iiu3MLzoMhV059bS6RGcSrhkJkUdgnRNdfaL55wJe5JZ6csWPjK+q1u8spulvBryk73uuDmr3U2/XbTc6vvDZONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ8GOj68YeLjqFXpDjCGCY5SU5XB0D7N1n7cI1P0qwg=;
 b=M7tduMR1VKq8qXvID1e7kcu+0RLPL3bPOTsczXk5rtUOpIcT1GsZ8jSdSgDnI+i+r8f+zUchAQbKnD1cfRwGguaD1Ne5hUAn6R2o9M2FCqnrEM53buFsrY09E0ftaZofJQ+v2c3UPwUgR62+163VW9/7OmoSWbCYcb9DQ1lAjKY=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6463.eurprd04.prod.outlook.com (2603:10a6:803:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 03:05:55 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3088.028; Tue, 16 Jun 2020
 03:05:54 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
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
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUCAAJUwgIAACjoQgAA5dICAAOmA8IADWRSAgAAMGbCAADi4gIABAUUw
Date:   Tue, 16 Jun 2020 03:05:54 +0000
Message-ID: <VE1PR04MB663857BA8997E3870B3ACB5F899D0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
 <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612141611.GI5396@sirena.org.uk>
 <VE1PR04MB6638B43E3AC83286946DABCD899F0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615071931.GK1393454@vkoul-mobl>
 <VE1PR04MB6638959679C644C76B4D3D3A899C0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200615112549.GL1393454@vkoul-mobl>
In-Reply-To: <20200615112549.GL1393454@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 428dbafe-1d5e-4e00-c117-08d811a22f53
x-ms-traffictypediagnostic: VE1PR04MB6463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6463AE3F1A1C2670EFB3F688899D0@VE1PR04MB6463.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5vLk+B0Uy5rDnU68S/+ARLhu8K5bCIPltDV46MxRezKesjSNzIpPIz3ZebXlOb1H2Jql0eD154ejsLBloPfSmMOxZaVz0WR5RVll4RuUUiJ5y3mvm/qKKf8fZoCzaHpOm7y/gt9gTO/WzVFqCdW9zK+2qPx8W+Cs+CKVhKpCCDii2mgGrOSXdclIyem2UH9OT5GTOU/OZr0lHxb+kgHuAY6OiM4KsKTR/QkpoZzXGT4ia8YyZJcu6bU8KUOP0RV5fh2oPAUO3sKi2TJA5aqbtpRN0aFaYlIAGHQJCnc81v59eai9WuNKj1yUaHQIRT/N7vmxRu0ujSsxvnVPqglTXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(6916009)(66476007)(76116006)(7416002)(53546011)(6506007)(186003)(66946007)(71200400001)(52536014)(64756008)(66446008)(86362001)(5660300002)(66556008)(2906002)(55016002)(478600001)(8676002)(4326008)(33656002)(83380400001)(26005)(316002)(54906003)(9686003)(7696005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: md3PkGuYC77YXGpCOW06kbE2oKQc7U97201QZgDh2BeMdUztQ38tfNCHX+TxIF5xzXgrEBBlYyWp9SvpOm2b/wwK913AOnnPynOMIT11+krz6S8Yugrjqvsu9nOAdHHcJNCWRjF42kQSQloJ/ZSI0xpnRqAQyzasj7TlBA7NI25fBsncjXGpydRy4d/lyo3QSYZ8OxjW3Ywkk6KUKFbBI/P+wGqb/PX0P+GXvbOnljmf1lwHpG9PDZO0VvCn16ybZksgJlS8ClNBefFS5V1xWfAGy+nvhuVJq1chd5jxJgqIkHsSRB1VSSmtQn4qpHvmVfD9l40gj4IXice/JwSCbuOqiy42pYzhPvpQWuT6DtEeYZX4lBAT7skUClXT06jojdSOrXpHk5RA+I33tmR6ZlN8KZRhujDIvnAD1zcJqXxsiqNjCJlHzGQSliD+baHJ/nqDWuz61+e1jcDpifuHzwal5InnZtewwxU4ETnkrl4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428dbafe-1d5e-4e00-c117-08d811a22f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 03:05:54.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2IoUYRksox7uztWhmBnOGXljpuCrGQh0rNBDhx1m3lLI5XGxEJPdrEGy9hoDsudeKTFzcv5lu0zemwLl41jOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6463
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/15 Vinod Koul <vkoul@kernel.org> wrote:
> Hi Robin,
>=20
> On 15-06-20, 08:59, Robin Gong wrote:
> > Hi Vinod,
> > 	Is there any way to let the device driver to know dma controller is
> > ready (in sdma case is sdma firmware loaded or not)before prep_call?
> > Hence, spi core could map dma buffer or not. Prep_call is too late for
> > spi core since the buffers have been already mapped.
>=20
> Can you use .device_alloc_chan_resources for that? This is where all the
> resource allocation for a channel should happen...
But many client driver request dma channel(device_alloc_chan_resources)
in driver probe phase instead of later transfer startup phase.

> > 	From my view, seems dmaengine_slave_config is the only one...Further,
> > sdma need direction in dmaengine_slave_config phase, because currently
> > what's the tx/rx script used on sdma channel is decided not only
> > peripheral_type but also direction. For example, spi tx dma is running
> > ram script to workaround ecspi ERR009165 while rx dma is running rom
> > script, so only spi tx dma channel depends on sdma firmware loaded(now
> > that could be detect by ' load_address < 0' in sdma_load_context() and =
prep_
> call finally).
> >    I knew direction is deprecated in dmaengine_slave_config, but
> > that's really very useful for sdma to check if firmware loaded and spi
> > core could get it earlier before prep_call(fallback to PIO if dma is no=
t ready).
>=20
> I think that is wrong expectation, dmaengine_slave_config should pass the
> slave_config to driver and nothing else. The relevant action should be ta=
ken in
> respective prep_ calls here, so that should be fixed as well
Got it, thanks for your clarification.



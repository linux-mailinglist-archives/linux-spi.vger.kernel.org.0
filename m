Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ABD2C2097
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 09:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgKXI5c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 03:57:32 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:34693
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730896AbgKXI5c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Nov 2020 03:57:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0EhzPZn88oMm095XugfknbU8UanHJJ5d+YsrF0IcoHL2cSEKvUgirpXesivGVNNwNKyxPkeAX4vkak+hRMqcf9Iz2OGByZY4TqS5mfnDB9OTUn98GEoIC8MlmLmOxpik3b78U3lIsvI/5ijd3MW7RY2Z44EVgCAbSdE0u1uWvKIyEMOXchrXugs3q16f4B2PONocpHljEJY/Y8TAoi1qtyWdN3hn8VoBbDNKftWh02Pouc5S98Vxs7MBMl9/kdHxuqNccXz91A7o06zhIJPd7MjKuRmfJa/ULpPu9EEan/o010rViIutydFWkDXvuOJha0MoEKAv9HvT/0ZPtIHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvkoR5P0aqxuUfw+6JXXE7dCbxFeljIyoLytXnrA3+w=;
 b=dti9DAbUV6kD+VOzZ/fCqR8fe8vHMCmqbimwRepWC2F3Bp9PYlJNtMU6Cbl4qB2Q9J62kVCZkoLcI5jkNcpMyaPriGplXDCs9kHFynnQKIuvaTI7JdA2LhoGtuyAaMsyWEpLlF40wSm9SoZWAyGWHLWpZJ4qojShFIFCDsmRjRsDHrNYFYMXIKUT3KE83CGwo0I4I2RJqQaa8HO7ejxS7XGYQTdIXeKhS9FCPb/Q/EUq1pqucFMSaz6CizN5Kgm3UGZOoknDGNGQiyZh+NofG4nqoQNJzA6nOxbuP0QIG7yKWQjwOX03E8NxzFFC4KjL2CXd0KtOa7Ig0RemcpSaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvkoR5P0aqxuUfw+6JXXE7dCbxFeljIyoLytXnrA3+w=;
 b=lob6BuXMzYiy5Y/Pey4kIEqETv7/gVJy7Q9lS/TkG6ZWacLZFAKeM20q6Cf27EZVQJN8L91ONQIDzwFXeH6o8GAXVp/F2Yr5BWl5YExfAGy1fv/PaCVdc5nvWMz6isrG4FTm4tIaRvUEQXQFxJIiTHL36tJALsGScTwdu9+PufU=
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 08:57:28 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::a533:3a5b:d525:d784]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::a533:3a5b:d525:d784%6]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 08:57:28 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] [PATCH] spi: imx: enable runtime pm support
Thread-Topic: [EXT] [PATCH] spi: imx: enable runtime pm support
Thread-Index: AQHWY9/iuScipEkFI0KzKaHjGfcnQqnGdAMAgBFCRvA=
Date:   Tue, 24 Nov 2020 08:57:28 +0000
Message-ID: <AM6PR04MB562348A699215824A00E29ECF3FB0@AM6PR04MB5623.eurprd04.prod.outlook.com>
References: <20200727063354.17031-1-xiaoning.wang@nxp.com>
 <20201113091800.27469-1-nikita.shubin@maquefel.me>
In-Reply-To: <20201113091800.27469-1-nikita.shubin@maquefel.me>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: maquefel.me; dkim=none (message not signed)
 header.d=none;maquefel.me; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1aaa479-edc9-4ff3-2415-08d89056f89f
x-ms-traffictypediagnostic: AM7PR04MB7077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB707748E030491D3549697C91F3FB0@AM7PR04MB7077.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfsi7kGs0XCItxwPFhDWRzQPGlR6Z5c5X744iKO2sO517PoUI9QNzoCNu+YHC2Ns4rpvsDtoINMT1TdoPLxIAeOwIwH+F4Dm3L4JD6VLUs7+WEY4IqDBC7qhUX2K5zD2yir4D1c2K7OQqtVmaQsHCF5Q0EnmmQ4iDRCxWvpeb7JAOvohsjTShFyl01jQ1txDiiCfnhJREsXP2DvMiO6y/VlVPYvYE7UUTjCGp0tk+HKFegVlS+zx6ePNNYbU3L4vcLutLRV1KPqXKd/1XaFRORSeCpXlA/kjPORTSXUvPFfDhuVRFeVyt7Y6hypo4PGK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(6916009)(33656002)(8936002)(54906003)(8676002)(9686003)(2906002)(86362001)(53546011)(55016002)(6506007)(7696005)(76116006)(26005)(186003)(64756008)(66946007)(66446008)(66556008)(316002)(71200400001)(4326008)(66476007)(83380400001)(478600001)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0aepXoeZeNea85E0CkUh0/0/A60UcCvdc43BAmbtWVuJWGwMGl8UPWgIGTsZKRAjbD/kmFW/lgeB/HSVuTh73nNfcAEm5Wl6oVmLPR6H7zw0f3avG8erCcWY27Bwf5uuVoWnAq9iKppJ88EMFl19h5Q3CIjCZ9H1pEb5T8O3piZr7Ch0QUtg0Wseb96q++OodKfPF94AmFg3MY9Mj0X5v0Q3pljC9bHFZulz+Zzf8S7E1e1JGzoAXD+xjo3/33CUS5UeFGun/sJfzarvzW6IOsGMtAfno4ruQpiKvuTn1/zuLOHd41KjRSac463FfWww+iluKGSZkBRAQNwfN0FOmSSt4jVBn414FyIbvXpExN7R8gMfKNmJvzOmpgfXpvjjt5noIXy3WtbwzA/NeuymlrvKIJhXyf4h1Ghey8Za9YEDAQnKhxKxd3N8nSieRIjbLixKqPS7MuCIRPkiJh2nlw0pOob0cAAqNNwZcCVislBRWnaooM8I7QSYu5BCqHK594BCJuAUhLcvTU/M/r720IorvRlkICdz+1CSLl2RiddPh9Tt/c/bXhhyCpEl4VtNzcwPg7CUbMDiBbjBlI/wKcqcLe91i60rdvD/5TL6fJtnvyja+dfLyIJtS13em5i0arACbvx+LUFPMEi2Z3Go0ll4FueFDCud8Cm6F/iVr1F4LRCGZtK3HME5Wti+MByN9MG9OHt2N7ruO9csSApv/iCGkQnDQUOF5+8aLkNeyXw3/p2WUposufKrAFldZ4e64g/uQOia4qnVGn978FrtKhRpsW0+7dqUZa7a1LaRppzmR89nCTV71Js08i1b+hIAm9ADUuvoeWx44NldJP+Pqyqm5pLO9F0L1UxKQGJRbhtntzuFcDMB6VAkLM2P0IzhCDrqBMXdO2ZKP/1uux2aXQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aaa479-edc9-4ff3-2415-08d89056f89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 08:57:28.4652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9uAPahWLyn0Ah6DgxX8i+OGAz6scIoGenw0TwBWjOZ5urMhPdU9/pcEZE0rllMi7TgpEakTcpM16rmSeaWufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Nikita,

Sorry for this issue caused by my patch.
Yes, it because I did not add the !CONFIG_PM support when add the runtime p=
m patch. This may cause the clks cannot be enabled when do not enable CONFI=
G_PM.
Sascha has fix this issue with the patch:
43b6bf406cd0 spi: imx: fix runtime pm support for !CONFIG_PM

You may try the latest upstream driver again.

I also fix a warning dump issue with CONFIG_PM enabled. It is under reviewe=
d. So that, this driver can work well in both cases.

Thanks!

Best Regards,
Clark Wang

> -----Original Message-----
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> Sent: Friday, November 13, 2020 17:18
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: broonie@kernel.org; festevam@gmail.com; kernel@pengutronix.de;
> linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> s.hauer@pengutronix.de; shawnguo@kernel.org; Nikita Shubin
> <nikita.shubin@maquefel.me>
> Subject: [EXT] [PATCH] spi: imx: enable runtime pm support
>=20
> Caution: EXT Email
>=20
> Hello Clark,
>=20
> This patch breaks spi-imx on imx7d.
> Toradex Colibri imx7d spi reports with:
>=20
>     [    4.258468] inv-mpu6000-spi spi2.0: I/O Error in PIO
>     [    4.264269] inv-mpu6000-spi spi2.0: SPI transfer failed: -110
>     [    4.264305] spi_master spi2: failed to transfer one message from q=
ueue
>=20
> We are using spi-imx with dma.
>=20
> Reverting your patch fixes this issue.
>=20
> The baseline commit 951cbbc386ff01b50da4f46387e994e81d9ab431 (tag:
> v5.9.8, stable/linux-5.9.y)
>=20
> Could you please give some comments on this issue ?

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB9298B7B
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2019 08:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfHVGjZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Aug 2019 02:39:25 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:31618
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbfHVGjZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Aug 2019 02:39:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZHZXN7wNDKVBl20zgDbWu0TkomDGp3jLqSo2lsdkGCsvXxYK++v5qxc2i6KDIdznaLgwRTHKnjI0QZ9ELh/y2YUHU7dqe2zFqZyOUlRCUmwQZxUggZGVHTNMXAbSRhUigZN80px+8WAOmaT5ylf1YELcQkw8G9+HkH6zF+g+nPW/7zc5F2wss8g4YwkIc73pW3Ys1wlOsO82FeK59GhgkzRw2dlifBaCPn00HoXcaDz14FNjlWWEEMk5P0tjUyDrIv8CXC6/746o2xyeouB2XvkBswqFLuCH3+SOQp/mcR9Hy+dvz+u3aNWgs4W5huEnWxA21QuKYxmKBX9q5576A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klP0gSnboWNgzTsy8adPzA1KXIvHYUknEklHxqf/n0g=;
 b=XInXlSnBaDJ32bjpw2aTaEmAnGtEl9ILt7d59RkWiHLf4TGh2oGgQkJc/3t8fRWuQs3TUi5wH9hs7b4RqQzxo5xdpeOX/beT1TshdJqZSEkMXpRfqURQV87Q/1+KTh3x2YLF6yaPDZajZAL3QWr0b4hS1ji4XYxyhkYk4T+XKbfAzED1DGd4WdnzZI/N+yM0JNvkYIhyglCL5OW00TViw7DKant6ZDFozyL65YE1g34ysVK3MH2KGML8nRVodj6vp62c2z8ijOVV6KX7keaff5Q6XD8ZvGmWqt2eAStlfOfNsBnobs2z6w65HHElqMj7mFSCXgyLF+cgm1xd3N+QPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klP0gSnboWNgzTsy8adPzA1KXIvHYUknEklHxqf/n0g=;
 b=E6moTtMQ1taFrVmiUjZt6CKURbPElAx0PKUZbfpv2fRyDzYc8RckSUfcKMRDBIjgFloEa/qXLjGlhCPUaLifVs/8/cv05ThapZre+P+sVJDge6kVnqPUg5+wUWf6WLmQFE9csJgJv+WnJNhoP/bqtcje4Hwx72D7gexPA0e0+EQ=
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com (10.171.182.24) by
 VI1PR04MB4734.eurprd04.prod.outlook.com (20.177.48.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 06:39:19 +0000
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::9c4f:262d:db31:e339]) by VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::9c4f:262d:db31:e339%4]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 06:39:19 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Thread-Topic: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Thread-Index: AQHVUcEk+xwdBczP/06jXTHXcyeTPqcFfYEAgAAn5gCAARs34A==
Date:   Thu, 22 Aug 2019 06:39:18 +0000
Message-ID: <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [92.120.0.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86a516fb-b997-4366-a6cb-08d726cb75aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4734;
x-ms-traffictypediagnostic: VI1PR04MB4734:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB473447A3A81EAFD9A12FB0ED95A50@VI1PR04MB4734.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39850400004)(13464003)(189003)(199004)(66946007)(55016002)(6246003)(52536014)(45080400002)(86362001)(8936002)(2501003)(81156014)(81166006)(8676002)(66556008)(76116006)(66446008)(66476007)(186003)(64756008)(53936002)(5660300002)(25786009)(14444005)(4326008)(256004)(2906002)(110136005)(966005)(102836004)(53546011)(3846002)(11346002)(44832011)(476003)(486006)(99286004)(74316002)(14454004)(6116002)(305945005)(54906003)(71190400001)(7736002)(7696005)(76176011)(6506007)(446003)(6436002)(71200400001)(316002)(9686003)(33656002)(229853002)(66066001)(478600001)(6306002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4734;H:VI1PR04MB4015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +77fFv9GBKXuZ7w0PCJvuUdnULc3snKGhKrMWXPZAdbCOieNPNzkPndxrkKd5UoMpu/3Jtg9hnRgbhIw/v3n88CeP2YQ9Q74OSMHRP4sf4GrisQ7oJiCK9RnNrKSu1KS1SkzKFzmbKHXwcYREELjFRf5X2Bm4mynphBGBWXwWPMK6T7JZd3HSqv8FTPIh625lhAZEaiBTPZRcRu4ph6902pF6CT9SyoSy2WKs/dEoBJrNHAXDEu8IPIyFj/S11M1I7ZzzVaVReGCjkESt9AV9VFCq20NJyakiQfXKNCzYP2TW8reTyXrD4+bjR4/N8lTOHTiF4BppnqrxuuFnUeAATRlK70EZo+/Ot43hOMxZVeGV/qoDkCaOGORNGTCUkQEAJNCfKhVbVe1OHs7eLaFGmbfmUBjXpLsCghpE4jVCF4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a516fb-b997-4366-a6cb-08d726cb75aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 06:39:18.9399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cm/qmxwScHXjwTjcD+1fJjxePENsHlIga1/TZO4QSmVTf+Q7zYVCZq9hkjyxymldn+M0vHRXuf7u6w4aCoTZ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4734
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: devicetree-owner@vger.kernel.org <devicetree-
> owner@vger.kernel.org> On Behalf Of Ashish Kumar
> Sent: Wednesday, August 21, 2019 7:49 PM
> To: Mark Brown <broonie@kernel.org>; shawnguo@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linux-next@vger.kernel.org; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add=
 ls2080a
> compatibility string to bindings
>=20
> Caution: EXT Email
>=20
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Wednesday, August 21, 2019 4:37 PM
> > To: Ashish Kumar <ashish.kumar@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com;
> > linux-next@vger.kernel.org; Kuldeep Singh <kuldeep.singh@nxp.com>
> > Subject: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
> > ls2080a compatibility string to bindings
> >
> > On Tue, Aug 13, 2019 at 03:53:09PM +0530, Ashish Kumar wrote:
> >
> > > There are 2 version of QSPI-IP, according to which controller
> > > registers sets can be big endian or little endian.There are some
> > > other minor changes like RX fifo depth etc.
> > >
> > > The big endian version uses driver compatible "fsl,ls1021a-qspi" and
> > > little endian version uses driver compatible "fsl,ls2080a-qspi"
> >
> > I'm not seeing the corresponding code changes anywhere?  I'd at least
> > expect to see the compatibles added, and it sounds like some actual
> > code updates are needed.
> Hi Mark,
>=20
> Snippet from driver spi-fsl-qspi.c
> static const struct of_device_id fsl_qspi_dt_ids[] =3D {
>         { .compatible =3D "fsl,vf610-qspi", .data =3D &vybrid_data, },
>         { .compatible =3D "fsl,imx6sx-qspi", .data =3D &imx6sx_data, },
>         { .compatible =3D "fsl,imx7d-qspi", .data =3D &imx7d_data, },
>         { .compatible =3D "fsl,imx6ul-qspi", .data =3D &imx6ul_data, },
>         { .compatible =3D "fsl,ls1021a-qspi", .data =3D &ls1021a_data, },
>         { .compatible =3D "fsl,ls2080a-qspi", .data =3D &ls2080a_data, },
>         { /* sentinel */ }
> };
> I had previously sent dts patch based out of Shawn's tree with dependency
> on these dt binding patch. To which Shawn had replied to get dependency
> patch accepted first before sending this dts change.
> Reference conversion can be viewed here [1],[2].
>=20
> This compatible can be seen here: file arch/arm64/boot/dts/freescale/fsl-
> ls208xa.dtsi
>=20
> Snippet from previous dts patch based on Shawn tree, I will send next
> version on this patch after dt-bindings are updated
> arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-) diff --git
> a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index d7e78dcd153d..8e5ba513b24f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -606,7 +606,7 @@
>=20
>                 qspi: spi@20c0000 {
>                         status =3D "disabled";
> -                       compatible =3D "fsl,ls2080a-qspi", "fsl,ls1021a-q=
spi";
> +                       compatible =3D "fsl,ls2080a-qspi";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x20c0000 0x0 0x10000>,
> >
> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.
Hi Mark,

After looking at some patch in Documentation/devicetree/bindings/spi/
I think I should update subject line to
dt-bindings: spi: Add ls2080-qspi compatible string for FSL QSPI driver
or=20
doc: qspi: Add ls2080-qspi compatible to DT bindings for FSL QSPI driver

Please suggest, if you think these are good or still need change.
Regards
Ashish=20

> Could you please guide more, or point to documentation to follow sub-
> system style.
> dt-bindings: spi: spi-fsl-qspi: Add ls2080a-qspi compatibility string to =
bindings
> Is this a better now? if yes, I will send next version
>=20
> [1]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .spinics.net%2Flists%2Farm-
> kernel%2Fmsg727403.html&amp;data=3D02%7C01%7Cashish.kumar%40nxp.co
> m%7C5922d2067b004c8f8f2c08d72642800c%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C637019939369034444&amp;sdata=3DHsumTqK0SiaBjzmbK
> 9r5dfpNtWHiZ%2FcB9e%2Bwy7SW160%3D&amp;reserved=3D0
> [2]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fpatch%2F10192103%2F&amp;data=3D02%7C01%7Cashish.k
> umar%40nxp.com%7C5922d2067b004c8f8f2c08d72642800c%7C686ea1d3bc2b
> 4c6fa92cd99c5c301635%7C0%7C0%7C637019939369034444&amp;sdata=3D2xRb
> YdJHTibb1BM0iNSJ00P69s2RKj9SLNFNUsneT8I%3D&amp;reserved=3D0
>=20
> Regards
> Ashish

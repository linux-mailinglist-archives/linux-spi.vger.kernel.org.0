Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4768097C5D
	for <lists+linux-spi@lfdr.de>; Wed, 21 Aug 2019 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfHUOSs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Aug 2019 10:18:48 -0400
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:52590
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729230AbfHUOSs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Aug 2019 10:18:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2DbPQ2VbJvMx1kdbyXYqoKT/3ls0+ovrXWs13Zch5uwAbKkhNCcyyoItEXh6hai8EWfx405eUe+JNBMauE8cqovsihaHDbOzYCBw9Esu8I44gg4pqwefw1i93TVFe4zgu5EOcBV2o89hAQpC1TUUn63gT3NTsynuqdsmSN64MiBjtKYLbhdoYekZ9NfcTdtG/Lpv66t2fdng832RkuHMb6hwnv7Vanuc53I+reMWmNe8dYZj6Ck+ohpeBqiYtUwmhTafgpzk/97W/DBa5Wg/aPsWGEgqjuArCILx9CvE3pckD8IPUnjDfXV3wXnsH6uUrb3JEhJJ/USUxL0PWqxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQgb4h3tli12W7C65ehs3kmbP1Va0bFBWrSpOX328WM=;
 b=NTtChAPVx4lOGnoGKoWap8Djr3rXXduA8rZACD7A6g/Y1F7+gTQWPDWOyIMEpRWHyBS9I1JLq6xJfoZgOdxs9xbqkDXT/yFZFmzXosfoKEIhKCHg0S92GRB6mVaURt3o9Nf9qm7xsbvMv/xybPpqta0PJ6vxeJh+avvfhumKEqWAz9qQbHOhwIqJukhXXSUCoZpbvSkfo6/Bp77j8p9/IOJ3+pR+It2AAWIYkSdbJGx9aaulw3lJMyNlFWqCp21Y2kvcnvyZvYrfohzA5bREhf37kxGV7ibjsc3+sTXs3io+Ee745R4I6Aj6SfHZvgaIkJ0sfE9gmZ6wmb+v/WT/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQgb4h3tli12W7C65ehs3kmbP1Va0bFBWrSpOX328WM=;
 b=R1o1vhthUGizInDfFXH1sj7Xk72za6urLR1paRadLfyaUdZc1XW6RbuTQfa+o86euVJiXP0kdixpy14sJmHnA56u7D/aefnl70732Dl081RN1E1swNAC8Asqn5ZMTZOumy+3QmN1MzWZOQqm5uK4igCR2qR2otpRC/8/hFprSfA=
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com (10.171.182.24) by
 VI1PR04MB4573.eurprd04.prod.outlook.com (20.177.55.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 14:18:43 +0000
Received: from VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::9c4f:262d:db31:e339]) by VI1PR04MB4015.eurprd04.prod.outlook.com
 ([fe80::9c4f:262d:db31:e339%4]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 14:18:43 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Mark Brown <broonie@kernel.org>,
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
Thread-Index: AQHVUcEk+xwdBczP/06jXTHXcyeTPqcFfYEAgAAn5gA=
Date:   Wed, 21 Aug 2019 14:18:43 +0000
Message-ID: <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
In-Reply-To: <20190821110640.GC5128@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ashish.kumar@nxp.com; 
x-originating-ip: [92.120.0.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5daf5742-fd08-4402-2ac7-08d726427918
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4573;
x-ms-traffictypediagnostic: VI1PR04MB4573:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB45736CD9561CE592EC01E71495AA0@VI1PR04MB4573.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(13464003)(102836004)(5660300002)(53546011)(966005)(478600001)(186003)(52536014)(6506007)(99286004)(66946007)(66556008)(64756008)(66446008)(110136005)(66476007)(71200400001)(71190400001)(54906003)(14454004)(316002)(76116006)(26005)(9686003)(66066001)(86362001)(6306002)(486006)(74316002)(476003)(81156014)(11346002)(2906002)(33656002)(81166006)(8676002)(8936002)(6436002)(55016002)(256004)(229853002)(25786009)(4326008)(44832011)(76176011)(7696005)(2501003)(6246003)(6116002)(53936002)(3846002)(14444005)(7736002)(305945005)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4573;H:VI1PR04MB4015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vo+uH4MwhPVqwghaxsPeXBuU7pIHeE2Nnd+sAwal6HDYfnE9jBqcs+diOj3thiHH39Qmifu7keK2ujv6EcH31dwtdKmDPpKFFDp6yiRe9MoGOu/vowHx1AFfWHehNBQDJF+nuJe/fV2Eo+fWv0WO2yEMGqrLD+6puaCMFKZUjiXWDVl8dmMFJQGKAPgtR+Fw76GBIMOogpPWvFZ9WYIv/KwCe02MYeTD3nyBxHkC7PNX+6HIasZFp237LHT0YtP+KNEi9jhkWaT5s8CED3ukpx1PIiUbRwOAigqy1mq1R5EzjMwWYUo6J8FJF6EzF/DnxBu27HqCDr34bFOBEyjXka9qpYEQbiMBb6/lGffgFiWEgWNnPd3wmDByXdoVRC/ZeK6XRIgY9LeP2s2QXCAywYc7d9YTH1F3LVVzJvCdlKg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daf5742-fd08-4402-2ac7-08d726427918
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 14:18:43.6509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7urDO9tzip+F4nqpNQaMeKw/b3lHamSStmE67kuNW+bnJiWIM55CukAmikEzzVWBUkR1EuWgrxzxTr26LFroKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4573
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, August 21, 2019 4:37 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linux-next@vger.kernel.org; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add ls2=
080a
> compatibility string to bindings
>=20
> On Tue, Aug 13, 2019 at 03:53:09PM +0530, Ashish Kumar wrote:
>=20
> > There are 2 version of QSPI-IP, according to which controller
> > registers sets can be big endian or little endian.There are some other
> > minor changes like RX fifo depth etc.
> >
> > The big endian version uses driver compatible "fsl,ls1021a-qspi" and
> > little endian version uses driver compatible "fsl,ls2080a-qspi"
>=20
> I'm not seeing the corresponding code changes anywhere?  I'd at least
> expect to see the compatibles added, and it sounds like some actual code
> updates are needed.
Hi Mark,

Snippet from driver spi-fsl-qspi.c
static const struct of_device_id fsl_qspi_dt_ids[] =3D {
        { .compatible =3D "fsl,vf610-qspi", .data =3D &vybrid_data, },
        { .compatible =3D "fsl,imx6sx-qspi", .data =3D &imx6sx_data, },
        { .compatible =3D "fsl,imx7d-qspi", .data =3D &imx7d_data, },
        { .compatible =3D "fsl,imx6ul-qspi", .data =3D &imx6ul_data, },
        { .compatible =3D "fsl,ls1021a-qspi", .data =3D &ls1021a_data, },
        { .compatible =3D "fsl,ls2080a-qspi", .data =3D &ls2080a_data, },
        { /* sentinel */ }
};
I had previously sent dts patch based out of Shawn's tree with dependency o=
n these dt binding patch. To which Shawn had replied to get dependency patc=
h accepted first before sending this dts change.
Reference conversion can be viewed here [1],[2].

This compatible can be seen here: file arch/arm64/boot/dts/freescale/fsl-ls=
208xa.dtsi

Snippet from previous dts patch based on Shawn tree, I will send next versi=
on on this patch after dt-bindings are updated
arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls208xa.dtsi
index d7e78dcd153d..8e5ba513b24f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -606,7 +606,7 @@
=20
 		qspi: spi@20c0000 {
 			status =3D "disabled";
-			compatible =3D "fsl,ls2080a-qspi", "fsl,ls1021a-qspi";
+			compatible =3D "fsl,ls2080a-qspi";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			reg =3D <0x0 0x20c0000 0x0 0x10000>,
>=20
> Please use subject lines matching the style for the subsystem.  This make=
s it
> easier for people to identify relevant patches.
Could you please guide more, or point to documentation to follow sub-system=
 style.
dt-bindings: spi: spi-fsl-qspi: Add ls2080a-qspi compatibility string to bi=
ndings=20
Is this a better now? if yes, I will send next version

[1]: https://www.spinics.net/lists/arm-kernel/msg727403.html
[2]: https://patchwork.kernel.org/patch/10192103/

Regards
Ashish

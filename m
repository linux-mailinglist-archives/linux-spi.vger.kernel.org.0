Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3CD266452
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 18:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgIKQeE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 12:34:04 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:25055
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbgIKPPO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Sep 2020 11:15:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzvSpnjuzkit21Op4J7GUXzC0V6AgcsSBt9o2tcoBTQB784ptHcZ7jN6i6/x590XZAhsqAGFMCkpvUiPUgW69/IlFSv5PI2ebWQAY2Of/0DIFwipP3zRrjvhKyhPHV38TVL+yMHfXxksGOtNQjo9461TEoAGpt2wVrLiUISFeXr2GxVa8EnNUB4yqaW2/1+nj2aSxmgY7AXS2WD+/aijb7l7RRnleOIAkJjFpHDNV4T7NA1akNkbV5QU8U4XKuL4+mkE+95HBZwuju+riqV2bRzRne2aqXbufDabNHwFvxrcwmWLpt8EPKkeTyVEzTmIUi0A4fEYCN+fhzVnlvYi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxlP+vhfLdTM44b6FyYulk9IfH/AbIVK9u2cOLRrYwU=;
 b=ZFYBCM8sOzwknBLY1vTBX1VOgWE6F1dGPhjAgVxrgHfXSbAcQ9TZ3xEvaQGdf2nr9lVyiAWzFwFBbdVgRMYMfOHIxHOfTUjLxhwI+GEiVhDVAvdv3zfb2bJAOMP6gBnwxfwkzSe84MErANVKSafVgvD1SxwsfpKQFxH4JwU56Ewt421LtBQwyrZc2Avkp2Dd8NxbsywUtEw4NTOAH4H7ySbT3Ead/9lVVfAKmczF4oIelFpRO8c/BVE+3KEaNp9dH6A5SsIOtbLc/ID/AW3VPQ6q5gK4ekD516cIcpfqmBn6qAvj86hh2fDdYSkXeBdl/j9KOq4Q+Pbr1EQx01Dh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxlP+vhfLdTM44b6FyYulk9IfH/AbIVK9u2cOLRrYwU=;
 b=VrtcCiIUSTkgrmyvrlul1gGUnOlcD0A2hQ/AvrEVQFPgvjFJijMkvolLsXarQboji8sl7Z5eXwwOJ9o+qQqSDtgvCIBQemF+rEZrS5kmvscSY3wUQpaYrCB7zN23Thje5RzFZlkfjQupX8VoOVkOo63RRE6vv3wT+hc6zimS6vA=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR0401MB2475.eurprd04.prod.outlook.com (2603:10a6:3:82::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Fri, 11 Sep 2020 13:32:59 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::d899:49cb:a131:dd62%5]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 13:32:59 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
Subject: RE: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Thread-Topic: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Thread-Index: AQHWiBWF1RqTTjTNrkyBYYIswnJLQqljXbCAgAAB7ACAAA6KoA==
Date:   Fri, 11 Sep 2020 13:32:58 +0000
Message-ID: <HE1PR04MB31961146633F7FE9EFE441A795240@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
 <HE1PR04MB31962FC006C6EB964AC2DAE895240@HE1PR04MB3196.eurprd04.prod.outlook.com>
 <20200911123428.GF4895@sirena.org.uk>
In-Reply-To: <20200911123428.GF4895@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [182.69.197.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e525e06e-5d16-400e-7421-08d856573306
x-ms-traffictypediagnostic: HE1PR0401MB2475:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0401MB2475A03D7C48802C52CAEDD795240@HE1PR0401MB2475.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hG1B2kqn1X6tflJIE4SRaTGxUyWrzfYTTRF/ZKv+GSMgw+/JQFMDk7CV1XNvPlEWZgrXg2c7GLf7P5nBL4craP7Pc6dkWyCMC2iX31kaHE1B6F4saDXy9BhfJyOblhP/DP0oiYkE+lDPspQct8fCJ5XG5pZUpbq3OkjpYWymfUIAmI4UF5VyG2Mt4gDVftkB6TfP02dccoCLWOQELQ5QuUSDrVUuN1hzN4Km/jxSKJTCG3/vJDT7qbfZ/pHtmQPK8qm8rSOTA4Bxp+2aUY2AmnIIG/0MK/IMqlX99DGfHdbf9oWntEKBRB5oUMP4qOA0zZHeGULtUhHwn5TuIEk/dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(44832011)(6916009)(86362001)(478600001)(4326008)(2906002)(8676002)(8936002)(54906003)(316002)(7696005)(55016002)(6506007)(53546011)(66946007)(52536014)(186003)(9686003)(33656002)(64756008)(66476007)(83380400001)(66556008)(66446008)(26005)(71200400001)(5660300002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3qnNeBx+AwyP4KvN3umW0tZ6/q1vhM3rVqBxJxUexwJLnANion1Jpr0GEvRGWUJ2ZpFf9XFvu699WnR35k+CXCkvcCWkQDusvUdQqVOyqhgCAzZRSx8Nkq01vX1Mq1YBTyHLpl4lfIPJE9GKh75aCWAUOFkVPow0PtmE0cjUqj4b5bTaGCrR7WcnHUoG+B5zXrJ8LFnM08mBJs1Bn98L5BIZ0xLyGUwpANQ/zcsAUxWoE2Fx1UpYMX/kRvGespqychveRb1Qjy66X0Nf8/okhrTKgMDXeoA8S7/YR5V3nMEudMURXFz8Jmlk5cjxMROsYNTSUbOFQJmPG8szbacNNqvqdEnmgES1uvZHer0zewQm7XgK4G0G9+sVo//MgL2tQaJ/zJMHKMwKdABIXbC4Z7HpNujeCHjr+XgBE7OkXhqmpSKFkkf1Gn0LqLETgykNX3qFuG4ttunSK3o4zTuoU5IDVnV9emhNPy1t6PBxf0IqASATMEBYuiyv5pzsFOic5Z5qtp/CR5xs/XoVeEAbR9rsuGmOo6J/sRLIL1BT0bAQm4Hf754A7mcs9TCvt7ki/F+UxfzSgparbHJmiS5BZpgnWYDNQ58vZ+bfSFMesUZy/Ge7vbuYOMW8jxwRNAXlveP/WB+tvOpB8ouuwYfpgg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3196.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e525e06e-5d16-400e-7421-08d856573306
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 13:32:58.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFX+C26lwp2hXgO7J7PjMMpUY4YyhtBj3v05VK6xC+7EZirKIveyRAEjZ/KTSi9+ASZrI93yuWxReVV84129FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2475
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, September 11, 2020 6:04 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> <arokia.samy@nxp.com>; Ard Biesheuvel <Ard.Biesheuvel@arm.com>;
> Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>; Paul Yang
> <Paul.Yang@arm.com>
> Subject: Re: [EXT] [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
>=20
> On Fri, Sep 11, 2020 at 12:28:47PM +0000, Ashish Kumar wrote:
> > > Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
>=20
> > Please capture version change summary.
> >
> > Regards
> > Ashish
>=20
> It's there:
It did not mentioned about removing SWRST, which was present in v1.
v2:Notes Looked very similar to v1.

Regards
Ashish=20
>=20
> > >
> > > Notes:
> > >     1. Add ACPI match table, NXP members are added to confirm HID for
> FSPI
> > >     2. Change the DT specific APIs to device property APIs
> > >            so that same API can be used in DT and ACPi mode.
> > >     3. Omit clock configuration part - in ACPI world, the firmware
> > >            is responsible for clock maintenance.
> > >     4. This patch is tested on LX2160A platform

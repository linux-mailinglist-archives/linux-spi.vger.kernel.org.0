Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031263F299F
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhHTJz0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 05:55:26 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:16151
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237040AbhHTJzZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Aug 2021 05:55:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml3wpOtNXTPVgREYHjSUaFQzSAIiUwM16dVCoWCM7rat4qrestcX0yofYioeAj41aPfhDtT/Snq8l2c+qdKwd/zam8Hmno3w38SAW8upCNst80MIfISOFo9O+mX+ZuehJGmdEmRroy4fD//pcM/F7otVoE7tzb47GXAT36BHE5qhQpCLvWIc2RD/Lj4MeHK80MvhrQ+xLARDaId6iLVAtHCe4WNqg9EX861ibuH6r5wuzSscwsVIb3kGG0gN8LhQHaW3IVJ9zCNsg1z18VKEdyTA4Va281zddzU/tMN50yN70n62L3pdyb6sAhkigbewLBMmUHPGY+Y/wWjhjAyqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP/4i3ylnaKXU9a2YdP72CiK11bb+j/4VQOZOtMxqyg=;
 b=nn/MDoI49sYiVWuyn7/fnSYDCsU6U6vCdBqnsOBeSB1y4sJyShRNH34p1RhsbW/Of+qLXQWuGpazt+WWU/pI7ZkJ5rnxircA+uQT9xF+M//wWTOQjOlv5ebdYruvQhnylvjEBxeQAR4sFBORUbLPyTRFeRNIXFaqckayqJEoxNBCQbQLUCWle734/hJb7le96DQafjOaswneIU4W6PWuQMQV5kVSriQvLVyRrvnvqVNfAy+wfqZtL4FvEdEQxvnQR3Fqx1KUbHLWiyjZWn+u+PYlqUL+Q9MMXFPKR2EI2StQhlnJ1bId0qXD5R4UlzDfZWjfIFJbxzG/87ODo/49Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP/4i3ylnaKXU9a2YdP72CiK11bb+j/4VQOZOtMxqyg=;
 b=sPWdB22nlW/YD3JOeY3Cpy6trsM3wvKMNU+aMi64zQzUA+1cW8clTYBBiqF73QC7Y62/1beqoUKyjt/lWqLA4Ou5LA0MkbE7nWKoK6ZKW5T+Nz0wI/ctjJQBBE60DZwLZ0Sfu6dA9GC6HlKD2PjpP4mNGg5w47ONruhzqMZTCkg=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB6270.eurprd04.prod.outlook.com (2603:10a6:803:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:54:46 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 09:54:46 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] [PATCH 2/4] spi: spi-nxp-fspi: change the default lut index
Thread-Topic: [EXT] [PATCH 2/4] spi: spi-nxp-fspi: change the default lut
 index
Thread-Index: AQHXlZpARqCQnNNC70qQWtLvOdbESKt8FR8AgAASGlA=
Date:   Fri, 20 Aug 2021 09:54:46 +0000
Message-ID: <VI1PR04MB5294A70AE91E2AD3D76BC26690C19@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
 <1629445443-10300-2-git-send-email-haibo.chen@nxp.com>
 <AM9PR04MB847228498D541C54AD81E69EE0C19@AM9PR04MB8472.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB847228498D541C54AD81E69EE0C19@AM9PR04MB8472.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11e76e8b-c07f-45ce-7cfd-08d963c08ad2
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB62707F64409378047529512C90C19@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6MAJx2MLgwGrByOrNImLLOGBFLX2rrgWYRIj95gRhGLaD/UaUhIkArh4KSEAmd1t7SGEfm3ZqVxwT2qpUWz4/EL/eji3Qc0EgkIWz8uNcUoeo8A2dwggSLP7iVgOvWkbKGDeFHkyinE8zDAaJHqIy8vmPfPVORoPL8idAt8Yt7g4u+nCYPig1B7WP+z823ncXCyxrS9w4IDt2dt3K4irwRTUbccGC7K4YtonMdewjp3eJtRjPtfWfiFRjrz0RsjfGC0k1wv/dEJk6eFq2VL+f1bcWg26x3jOmdo1gR0vCy5qQuSllaQpSi/d9TCGrPfxYUa0Q2nd3LcWz8+5G2P7ehdkiG5LOuTsmAAwUrnjEgRxU2ZxLr6UQS75/0e7mXhgdTQhqL/VO4Y9KboN4I9gjosVo71gU8cMFjCwLBnEM4golbeAESYTd2VMprVKOTbjKdDKiSOngGaBVH5BzxrIyBL1rRhmq7NUFGsq6lrbOwLyhJHSxEHyKBU/3oE2qLFauraJzGXVMTP0tb5r5g+2m86Cj8yEO8HUtuwK1Pn3Bd+0+1ydfZUSWIjWZ1r4VjcGSRWiFEK6DL7UMsmajwVLnZrN85rXCAOC2Pl62lWwdoXTtevBGus8AMe6os8qbu3SjAZLheV/E2/QfoeWwAmychuzpfjOSU3oq/Yipdo11dVQTVfZYHyORyBCP1QHMQijGd/whKsURqQlAn+qLKHiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(38070700005)(186003)(8936002)(7696005)(83380400001)(9686003)(4326008)(99936003)(26005)(71200400001)(33656002)(5660300002)(122000001)(66446008)(66476007)(54906003)(478600001)(66946007)(64756008)(66616009)(316002)(55016002)(76116006)(2906002)(86362001)(52536014)(8676002)(38100700002)(53546011)(110136005)(6506007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bTN5OGkydFM2MEhQcnQzRnpQWVQxOXRTaFFSamdGK3dUOW5LVjNVa1l0ak5S?=
 =?gb2312?B?R2laY3VXa2lGMWVqVHE2dkNmaXFIRlk0QVhsVEFMbHZGeFZZazNld0pUNG1p?=
 =?gb2312?B?VXZPUFRkNWFPaEk1bzl0TW0wVTBBODd4YVo2RzRuZWpxL3BIdUxrRTFWN3FK?=
 =?gb2312?B?UHRtTmhEUUZ5RnJkTVFGdFdkM3FSRG43Mk9GZHZZNVEybUpCRHBnRGZ6VVlj?=
 =?gb2312?B?bHllMERsQVptN1FiSW55TlhRNFNoNGozNnZTNkM1dm05Z2JlT1l2c0lLSnRp?=
 =?gb2312?B?WFZWMTR6bkxIUXIzUkxWQmVPL3RPRFNzRVg2TnhHK0RwdmJQSUZ0dTl6dFV4?=
 =?gb2312?B?VDdERU5DOGl4aUFOZkl4cTFnZzE5cVFGSm8yWmdXZ3NjNGJDMmI5M1J6Rmoy?=
 =?gb2312?B?MXo1MGxPbjFUUEZad01lMng3ZWNXelozaWtnVks0ZGdrdW04RnV1MDJsOUtB?=
 =?gb2312?B?NjRLaXd0MnFJSTM5SEF6SFpJWVBJRnlROU4wcDQ5SEVHM3Rwekc5NlJqNENC?=
 =?gb2312?B?V3A5OUpRWGpmOFR4cThBOEdRcUhINlRJL3RPU2xjaGZUcTZrME1SZUQvdjU1?=
 =?gb2312?B?UzNVL2NGdnJ0MEk4cUVGSm90eEdsZFF6aXAyR21jSW14eEdnUER0YXUrbUM1?=
 =?gb2312?B?bXJSRkQ0dXZpNDNwOWNONS9yRk4xLzF0UjEzdDM3end0WjY1SVVCdUVxUllv?=
 =?gb2312?B?ejhRNS9OcEsyZWs5L2RpZkxmSVF6cE8ya3ZkSWlKamdwcVZ0L0ZncjRyZmd1?=
 =?gb2312?B?b2NQS0dNL3dKL1hEbHo0NVM2TzlmazZTaXJOVG4wZXRzYkUyYmNUdllGQXhG?=
 =?gb2312?B?SzdlZkw0TDFUY2NvRXVyWlJwU2N6MVZua0hpb3RpdHpibEtYZHdxZWp2U0Jo?=
 =?gb2312?B?emU5cWVCM01tRTF6VnBaTXU4S0xkK3ExdVBNVnJMd0ZYdjlyYkdkdllGaEpo?=
 =?gb2312?B?VytoNGRxN01WSnJ1TnZMVzZpaGkzb0ZJSmFQd3JodXpHN09uQWo4cG5HVVpZ?=
 =?gb2312?B?Z2EwalE5NHBUd3JIT0YvcWNyQkExNzNiekpWK0lra0NSMHZqVDlnSytuaXVS?=
 =?gb2312?B?bFFNU2g2Y0VSMmtEU05ibHlobWY4bkRvNFRHVE5HbktiSnVxaHhQc2gxWlNZ?=
 =?gb2312?B?a1VTQmowK3p0bi9LQXM5YkZOQTI4aC9lTy9sK1JHQUczdW40WEhxQmlPdmRJ?=
 =?gb2312?B?ajhrdzlSL085VVVpNUZ1cFZxalVDY2gzRFFZME5XQTVNTzZjK2tpZHMrclVJ?=
 =?gb2312?B?UVFoTEhQR3hUUjYrRjd0OVg1OXdOWGNhYkp0OEpVRDg4Z0ptbnZCK0V0VFFj?=
 =?gb2312?B?aGp0TlRTSzhGUUh1UDhTWTFkZ3k5aSs0ZFJ4Q3NJQWtoS29SeWthcHRVSXk0?=
 =?gb2312?B?Y2xmbVY5R1N5MnQwb1pSdkhReTExdms2UmYzV1I4NjV0SzR4VXUwOCtrcVcy?=
 =?gb2312?B?ZHZ1SnNlRWgvaW92dmE5Q1NabmMxSk1OQ3dXalZCeGd4L0IwMmxQY1MvcXds?=
 =?gb2312?B?bERkUDV5ZmN5R24zSnVGcGVuWHZVTW9uZElPR2p2T2FzczMrZzNjanBlTkVq?=
 =?gb2312?B?ZGhwTWxIeDF6MlFwMG5MQzZSTUl3b1ZwY1NiYXZVU3UxVk9WRWVkendDMmRh?=
 =?gb2312?B?M2YvcVFxbXRnNk5aS2RKNURidzE2QWhmNGo4cUFCUytyREhYTHV5OUhWVk13?=
 =?gb2312?B?djFKMXNveUpSMlg0djEyRE9XZXdCNkhYSFdvUWNRTmRJS1JRUU1xZFpiRU9x?=
 =?gb2312?Q?giqv+yjoE67kTfaMHoUzhMjW3uC8wBvGCPPOD5U?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_0297_01D795EC.733CE4B0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e76e8b-c07f-45ce-7cfd-08d963c08ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 09:54:46.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxSh/x7bvcDThrNOlGZj3mRyGgY2g7dPr5AqAYCPiTUmaNK+DGRhMSMnnl1PekBFiDb8VnaTTMSLJBMtuBEqiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

------=_NextPart_000_0297_01D795EC.733CE4B0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Kuldeep Singh
> Sent: 2021=C4=EA8=D4=C220=C8=D5 16:49
> To: Bough Chen <haibo.chen@nxp.com>; Ashish Kumar
> <ashish.kumar@nxp.com>; yogeshgaur.83@gmail.com; broonie@kernel.org
> Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Bough
Chen
> <haibo.chen@nxp.com>
> Subject: RE: [EXT] [PATCH 2/4] spi: spi-nxp-fspi: change the default =
lut
index
>=20
> Hi Haibo,
>=20
> > -----Original Message-----
> > From: haibo.chen@nxp.com <haibo.chen@nxp.com>
> > Sent: Friday, August 20, 2021 1:14 PM
> > To: Ashish Kumar <ashish.kumar@nxp.com>; yogeshgaur.83@gmail.com;
> > broonie@kernel.org
> > Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; =
Bough
> > Chen <haibo.chen@nxp.com>
> > Subject: [EXT] [PATCH 2/4] spi: spi-nxp-fspi: change the default lut
> > index
> >
> > Caution: EXT Email
> >
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > The fspi dynamic lut use the last lut for all IPS operations, the
> > imx8ulp only supports 15 luts, so change the last lut index from
> > 31 to 15.
> >
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  drivers/spi/spi-nxp-fspi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > index 1eecf20f1dab..a764eb475aed 100644
> > --- a/drivers/spi/spi-nxp-fspi.c
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -63,9 +63,9 @@
> >  /*
> >   * The driver only uses one single LUT entry, that is updated on
> >   * each call of exec_op(). Index 0 is preset at boot with a basic
> > - * read operation, so let's use the last entry (31).
> > + * read operation, so let's use the last entry (15).
>=20
> One nitpick:
> Last LUT entry is still 31 for all platforms except imx8ulp which has =
15.
> QSPI driver uses last lut entry 15 whereas 15 will be middle entry for
flexspi(in
> general).
>=20
> The word 'last' in current comment does not seem appropriate for all
cases.
> Maybe you can update comment for ex:
> "Index 0 is present at boot with a basic read operation and last lut =
entry
is 31.
> Some platforms like imx8ulp supports 16 lut entries and therefore, use =
lut
index
> entry 15."
>=20
> Other than that,
> Reviewed-by: Kuldeep Singh <kuldeep.singh@nxp.com>

Hi Kuldeep,

Thanks for your suggestion. I will do that.

Best Regards
Haibo Chen
>=20
> Regards
> Kuldeep

------=_NextPart_000_0297_01D795EC.733CE4B0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
U2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNv
bT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0
aW9uUG9pbnSGL2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Js
hi9odHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsG
AQUFBwEBBIIBAjCB/zCBuwYIKwYBBQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2Ul
MjBDQSUyMDUsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENO
PUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29i
amVjdENsYXNzPWNlcnRpZmljYXRpb25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY2VydHMvTlhQLUVudGVycHJpc2UtQ0E1LmNydDBBBgNVHREEOjA4oCIGCisG
AQQBgjcUAgOgFAwSaGFpYm8uY2hlbkBueHAuY29tgRJoYWliby5jaGVuQG54cC5jb20wDQYJKoZI
hvcNAQELBQADggEBAAbO3KB4UPjzcz8dqs00dc1WxVm1GGcg29yJnKejuwv95IGs8TmqHcXZ3zot
7J4cDniEn2Pdvjfw3tVoykkz7vT/JkS5QfOgUeQX7GAKMe2AT17e9VskzipZ+37vsDPfW1XPVRn4
WMgJUHLRad79yO/ojeTPavpUFtAY3wlI4B8dT7du7ibI4Zokemv0PvTpanmUY+V+EjibmoXDTbXm
VJEG965sDuYYeh40QeE5siWSSoDA0yHxRb0TvMBbbkR406oUSSIEZyR4a6iGRgsXral8LULemoOx
N6HCSMmhyGdWXJOMFhbLkPEZQkOXpUCdzwJnG8X3hPnlRNp1qEeIXoQwggfrMIIG06ADAgECAhMt
AAC+6uSCGwwZxWD/AAAAAL7qMA0GCSqGSIb3DQEBCwUAMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJw
cmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRo
b3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmS
JomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwHhcNMTkxMDMx
MDEyNzM1WhcNMjExMDMwMDEyNzM1WjCBmjETMBEGCgmSJomT8ixkARkWA2NvbTETMBEGCgmSJomT
8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEMMAoGA1UECxMDTlhQMQswCQYDVQQLEwJD
TjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UECxMKRGV2ZWxvcGVyczERMA8GA1UEAxMI
bnhhMTI5MzcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDE9+2XERF+z26pPnpECTBk
Qd8RJomqRzsIUDwr4pXlYguj7693YrAllPcn16SP/HlCQLOV73S/EQlQ22fHiv8Op3odseIduNQt
qSaD65NFnj1wOvsidBPwP6GeSk4ZE4lWZYVAE/UT8bT6dDNgM3NDoCEPRSNnJwsp4qGlyFYpl1wa
JuNyF/crQt8c0HZ7IZmcpMSdywmmWhYQOjDg+GzDdHfFSK1EmFf15IgYh/S0iKjwZXcohqRSFh4/
Y9O+PqQ8tRuuIh/nZMK9E8tT/WIFd2kWe2dR1TbcyTpXEPrCNZiYj5LV6dPVJuQsCWwy6evTzLkU
rqcPsCky/loDLZ7NAgMBAAGjggQKMIIEBjA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiFgsB+
gY70VYbthTiC65lLmpJWP4Xmim6EteF+AgFkAgE6MBMGA1UdJQQMMAoGCCsGAQUFBwMEMA4GA1Ud
DwEB/wQEAwIFIDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUHAwQwgZQG
CSqGSIb3DQEJDwSBhjCBgzALBglghkgBZQMEASowCwYJYIZIAWUDBAEtMAsGCWCGSAFlAwQBFjAL
BglghkgBZQMEARkwCwYJYIZIAWUDBAECMAsGCWCGSAFlAwQBBTAKBggqhkiG9w0DBzAHBgUrDgMC
BzAOBggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgIAMB0GA1UdDgQWBBTlL+2gnauehNbF4Mck
cbLTqj/vJTAfBgNVHSMEGDAWgBRYlWDuTnTvZSKqve0ZqSt6jhedBzCCAUYGA1UdHwSCAT0wggE5
MIIBNaCCATGgggEthoHIbGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENOPW5s
YW1zcGtpMDAwNSxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMs
Q049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRp
b25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGL2h0dHA6Ly9ud3cu
cGtpLm54cC5jb20vY3JsL05YUEVudGVycHJpc2VDQTUuY3Jshi9odHRwOi8vd3d3LnBraS5ueHAu
Y29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybDCCARAGCCsGAQUFBwEBBIIBAjCB/zCBuwYIKwYB
BQUHMAKGga5sZGFwOi8vL0NOPU5YUCUyMEVudGVycHJpc2UlMjBDQSUyMDUsQ049QUlBLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmljYXRp
b25BdXRob3JpdHkwPwYIKwYBBQUHMAKGM2h0dHA6Ly9ud3cucGtpLm54cC5jb20vY2VydHMvTlhQ
LUVudGVycHJpc2UtQ0E1LmNydDBBBgNVHREEOjA4oCIGCisGAQQBgjcUAgOgFAwSaGFpYm8uY2hl
bkBueHAuY29tgRJoYWliby5jaGVuQG54cC5jb20wDQYJKoZIhvcNAQELBQADggEBAHNaESyBZSXf
2VjPBOZH2PR/VsyRkmOCEkPU1uxvKTFAYPwmzTsnlPgU4OK9G3DLFpZhrUFfoz2G5Z9lHxrOftqX
lCk7OQpEtEom0dbQN/ZCAmsMIfweppoH+zVGjO45OVI1W+qlQcNhdSV5sylHjD5Gg1GF/DOL4koc
vFlMhaX/MQ7vNrRO6KI7vTl5mcObxpfWVdPT3D8RgKml2n8xTLi7jiIII8rgWexZYlx3ukUBWRJb
ZgDGZ+bOPl0EK26M1ELLUTT/uAxPifKlj1Ls37bW+h3GhgsiW+lZVN7qZWar54TIpAogfVOIaip3
BeirywBeJLBrgkFfD8yA9JvyFNQxggTDMIIEvwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNTELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhMtAAC+69VX
9gixtDt/AAAAAL7rMA0GCWCGSAFlAwQCAQUAoIICxTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMTA4MjAwOTU0NDBaMC8GCSqGSIb3DQEJBDEiBCBH7eE7zUM+3b/W
ATo9DzEg81YsuqNv/SLdSGrpbLRrdzCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAECMA4GCCqGSIb3DQMCAgIAgDANBggq
hkiG9w0DAgIBQDALBglghkgBZQMEAgEwCwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjAHBgUrDgMC
GjCB3wYJKwYBBAGCNxAEMYHRMIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQsw
CQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UE
CAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254
cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAL7q5IIbDBnFYP8AAAAAvuow
geEGCyqGSIb3DQEJEAILMYHRoIHOMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQsw
CQYDVQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UE
CAwNTm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254
cDETMBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwCEy0AAL7q5IIbDBnFYP8AAAAAvuow
DQYJKoZIhvcNAQEBBQAEggEAuGEdyYM7JpotQoGGY8uE8ztUJwtPTKcGiACPDp5EReYidLHr67gW
+9MZj1PFfDNYMmYD4LP+iWyGjliKayKvrJUQ7pVeMwW62y69x+J8/ldMVtM+T+n0B/z5F8egTatx
ZlHwdusOXlo54hjMn5UvCf+jkooCFuEVmc0Gi+Vh7NLfLOJS2JFmzYV4kX4XcXOkf5+fk5lS05yV
rcheNgzgg3cT62diUcb4d8o456vjlXQGt19KfjaZZI14neZ5B713cjHdotTRV5BSa8k/Yom/pwb4
V5258LJrI4LSSjZwraQsTVyPBA2VteAoL1JnvpLIGaFT+CaNMiJS7KmszZOFSwAAAAAAAA==

------=_NextPart_000_0297_01D795EC.733CE4B0--

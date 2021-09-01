Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7543FD4DD
	for <lists+linux-spi@lfdr.de>; Wed,  1 Sep 2021 10:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbhIAIGQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Sep 2021 04:06:16 -0400
Received: from mail-eopbgr60070.outbound.protection.outlook.com ([40.107.6.70]:53624
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232072AbhIAIGH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Sep 2021 04:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgxK0yX7ax/lZxd+0yaZSgEVaCyVSAi9gaA3KOXoV6inRdfY0suPPMiG2kPJNonQvbz9NZjGLZE1yXUP/9aC0r/zHvlELsuYJT7zD2p707+prKcmwTuHTsusvHFzOAm11CokZHLK91iZVc16GmfEoLI00roORcAYwRtXbFGl/rnJ+YSQvmdcSvBP8Z9ZUqCInO2AMMGczZPn9qBRUgM6X5tPYE0ChMIWIcAfKYECTjRgsysW9kzZCBzO03fWupGTLV8AEb1hvkJxyEki/pyuHccCXbN+D92KkCoHArW5HnNx4QKHAf//sWgHVREQKnon1r2RYhQwYzQjUUHSq7XKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BJBNmzFH89Lev864qDdrnwW0rciNxoGuK611ZXRFCYw=;
 b=O/0McVvLwhCUrWgrUHgk8jQE/Jxzs/W8wNP8f4OMltE7Rh3zCofmHVsNS+DOiGfvVdC/rc8VvcOjleUOaDRIKSR4GYcopavTj2yymoBCE6B7NKpdK2FJLqaVt6OpLrWJuRDrmRqRb1th5XAzxJWv/4TQZOnhBZvaH/m9rtano41meUJHnN4l15FX4cmJlOREpHMWIxYuYHTfg6+2HPjWurB3IPVBEScS2mZLwYVQz4I+CyFdUSwf+93FsY0vmTCz3P/swi7ZHLE8baD6ccgny8Rv6q9FJfPu7nPfBMO0jW7JzKMl3p2H3g1LoYAWx5PbEOdQVlD0yOeDKmK1G1sD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJBNmzFH89Lev864qDdrnwW0rciNxoGuK611ZXRFCYw=;
 b=EdLk1KSQTJIrozRpon39vtDdyC5HQuxyjc7F5OOd3krUEs+tL86fn8gGmD5CBT5a3BhjKCd7mEs3lDmIYTLpwEYBwYVQU/gfvZLvaymhF1yczLSUGXUK6kM/kc1sepAiAAuzbkhidLD7gKW9cZpmUjKLUSI+/DfUG8o+zlYBJsc=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR0401MB2685.eurprd04.prod.outlook.com (2603:10a6:800:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 08:05:08 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 08:05:07 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
Thread-Topic: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
Thread-Index: AQHXlZpBEVnfgeM+jEiqKZu1ZD60MquNfmiAgAFf25A=
Date:   Wed, 1 Sep 2021 08:05:07 +0000
Message-ID: <VI1PR04MB5294469919613247746FFEC790CD9@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
 <1629445443-10300-3-git-send-email-haibo.chen@nxp.com>
 <AM9PR04MB8472116E9D7745875A06F436E0CC9@AM9PR04MB8472.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8472116E9D7745875A06F436E0CC9@AM9PR04MB8472.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99d7f5aa-d975-40b6-2f45-08d96d1f36bb
x-ms-traffictypediagnostic: VI1PR0401MB2685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2685207EF1E20B840F7DA9B790CD9@VI1PR0401MB2685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8kNqJBKj43VR6Z95IIs0efRQT4cG8/hQc6MpQBbBCQoppWqMvQDwZ+nmwvgcF595vtKTjudKOwfsINrCX5NAyhWn1B9BgoKhSVHvhBiix4NtgUAAOVuou/o47/xJfC6nj7qEPy32Vbi3WhrM3P3LfLqjzYignbM58VCJK8H/rozvi2upVFSVOs5WJHFJf38y5LTQeOcrx3c4hVxOB0ZmSlan9q+KCaAqChS7WpUBPOl2zWQifkoE+eW63uLY/FewVYW0JpN8PU7Rul8RT4frdi94u7tnKE26W6bLbqpA5fCwQdoPycBO/xZp3tug3qBHUPdmafhEZJ3XYevFHw+IEjnQvyr00yuy5KqihRkVHhzGSlb+oYeb7fQQ0DK3BvsbxxuzL3tEOeFcK5beRGrew0Mu/B41b5CtyoBTqzhUND1XrnET5roF3bD+hyd+5nbtSZxyxZgoRk/eLwG1whxjNX+HGpthj3P4kiJly6tOewMStG//TDPGPJgfLP4PInUVse/eHXphFEbAcHxTvrp4+Ivmm1yn057rFXkamKXWNCy3TOsPknX620++FyFHj+I54vojXGpKBGumqr4R/kBxFq6ojsitZE53qXwVv04tCh7ONo0HevBMYBThdy3MKMLdBkAZLhh8nQlUZal+SGst/T8st5eCTAjEPB/jbXumNCa269FfEabnaruzO4oom1tOZxzv4HF5mDsdWqjktr37w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(4326008)(5660300002)(99936003)(71200400001)(478600001)(2906002)(6636002)(8676002)(122000001)(6862004)(54906003)(38100700002)(86362001)(38070700005)(52536014)(9686003)(55016002)(66946007)(66616009)(66446008)(64756008)(83380400001)(66556008)(66476007)(33656002)(8936002)(76116006)(316002)(26005)(186003)(53546011)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cFlMa1EyZC9DWDNJUG9TRHNrRHRPZGR3aWd2K1Bzbm9hN09jMHd1SlpGSWl4?=
 =?gb2312?B?ZHc3WFlhUEVWZHUvY09mKzg3QkRPMHY3a0tQdmdSdjlVK2Z5OWdoL2RUenA4?=
 =?gb2312?B?b0loVFhiRWhqNDBBMG1kamFBak5EK0xkUHZEZFhQNVpmNW5OMkNCNjI2S3lE?=
 =?gb2312?B?RUk4cDdLckZudVZPSFZSMUZveXdvQVA3MWhyMk10dURVSUo1ZUg4NnBEZzlw?=
 =?gb2312?B?aUk2ZVRMejVhVy9KeTQxa2NTT0hIQzdWMHNZa2tYb0ZhRkIzejlBWXpJcWZC?=
 =?gb2312?B?NlREc0pKTCtxRzJCUjljZDMrNVVKd1NvQXZXdDhkS3czT1NWSCtoV3crbnEz?=
 =?gb2312?B?V3VKTHZWRVdTRytHMC9ZOERJVXZjK3lJWUFFVXFTOXVKQmxUNXdUenBObWNT?=
 =?gb2312?B?UnQ0VzU0TnBYRDV6VUl0Skg5ZFljbmJiQ0t3dHpRL2JUVkQ1N1BzQ2tIbU5C?=
 =?gb2312?B?WEdlRlhEREtkRTBMSUgwWWI5TitDUlM4K0dkRGtWcjYxa0RIWFhDZ1l0TWF6?=
 =?gb2312?B?d0hwZVQvYnpnRitzWnAxQS9VOWxlWlJDRWd1VUhlUmV4YTM4OTdkZC8xKzJs?=
 =?gb2312?B?VmtlcEVPakR2WVE5QldwQ3BqYWIwbTQ5UDNLby9WS3ZhZmZHZUcwd01KSE5C?=
 =?gb2312?B?NGxVWnI0bnhiYkYvQ3h0Z2FJeTNRR0pPWFNDOVNSYllxOGZHbjJVc2crUjZM?=
 =?gb2312?B?UEp1ODVlQUVaNDQxL3NZYnBOa25WZkJSZ2NJNlpCZlllRUxSUmtEWUdQNGlq?=
 =?gb2312?B?dlU4bll1L21iTzVXOWdLU1YwZ29YKzhBNXNTY2lzK0JDYlRkK2hSS0poR0VD?=
 =?gb2312?B?ZXN4MUU5SEMvT2lDMDJSb3ZSbnFGMkRHTVQxUWFOT1NSUEZwRy9oVlIzNmxw?=
 =?gb2312?B?YzZOSDZCL3A4VHptVGVuTUhseFBudUQ0OGs2TnRraUZOek0yY2hCbEhHOVV3?=
 =?gb2312?B?S3NpRVI3K1M1U2FWeWE3ei9VcGRTSkVCaTRQWmdSRHRNTW5oSFp6aUZJYmFv?=
 =?gb2312?B?UVpWWGJST281K2NDQWUyYkgzdkRodUdvQ3hLQXV2THA3WWF1L0V6V3Y5eGJV?=
 =?gb2312?B?SmNwbFA2ZkpIUm8zYVN1aTB1eExKNm94QkZ4aUcwaGRuMEVxWnpkWWI0SFdW?=
 =?gb2312?B?eG4yZEZNaHZHczdPdSt6VDhONWJhdkp3QnZtMlVYWTgrSTZqTU51SUFkNEpw?=
 =?gb2312?B?bm4vUjdiWjJKK0NxQVF6VnlZNFk1dzlDT1dua1hQeU5yN0pGM2pxaDFyS2JX?=
 =?gb2312?B?Z3dOa2s0YmJDdUw3b1NrQzEwQllhMkp3bmJRTDE1K1RvMVlPVXU3MTdxejAw?=
 =?gb2312?B?WjhuaTRIdW9YZHBvTzRPS1JtamdpcThzb3FWeFFxUVd4d21yQnl6dWh2UFB4?=
 =?gb2312?B?Z3NUV1BkWUc1U0gzT1ZMQVdFSUM4eFV1a3ZYWjdVTTNCVEVWc20rMlV6SWlq?=
 =?gb2312?B?cDFxR0NMMmMvbFF2Szd3WWZrSm5hVUYyVDRGbndBZ3U4QktRUEhaeWlkYTEx?=
 =?gb2312?B?aGg4ZTlTeVNpWGxTMUNsaEtjZDl2Mm5qay9mZVdkaEZDbGNuaWxJcDJNNlhI?=
 =?gb2312?B?NXA2OHkzbGJxMFFROWVhK2J6d0YzOTcvZDRwVjk3QlBXbzRtb3dTNmVQbVcz?=
 =?gb2312?B?dUMxeWdlTFBRdzdSRFdnQkNob0dFWlp5WXRQVUlRYXVsNmNjOFpHdW1tNThl?=
 =?gb2312?B?MGRaZWJhUTgzTm42VytNK1dveWZSRmJqNFRvNXFyV21obzlYMnhna2hvbGdO?=
 =?gb2312?Q?1G7VifEyrmlB+f093HqnhDdhyEK/8sjs1JslgyZ?=
Content-Type: multipart/signed;
        protocol="application/x-pkcs7-signature";
        micalg=2.16.840.1.101.3.4.2.1;
        boundary="----=_NextPart_000_04CA_01D79F4B.2084D9E0"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d7f5aa-d975-40b6-2f45-08d96d1f36bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 08:05:07.7974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pg95EGVUXOT64FyAhaFs+lisHHNjSgT+kslkUwMFBgo40MrAM4zfzWIZB0CHGb6qQ3hZJHvAJ6qz0K43iusjAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2685
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

------=_NextPart_000_04CA_01D79F4B.2084D9E0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Kuldeep Singh
> Sent: 2021=C4=EA8=D4=C231=C8=D5 18:42
> To: Bough Chen <haibo.chen@nxp.com>
> Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Bough
Chen
> <haibo.chen@nxp.com>; Rajesh Bhagat <rajesh.bhagat@nxp.com>;
> broonie@kernel.org
> Subject: RE: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
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
> > Subject: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
> >
> > Caution: EXT Email
> >
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > For LUT, add DDR command support.
> > Also use new API spi_mem_dtr_supports_op() to check the DTR mode.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>=20
> Thanks for submitting patch to support octal DTR.
>=20
> > ---
> >  drivers/spi/spi-nxp-fspi.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > index
> > a764eb475aed..f7acad2cbe64 100644
> > --- a/drivers/spi/spi-nxp-fspi.c
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -486,6 +486,9 @@ static bool nxp_fspi_supports_op(struct spi_mem
> > *mem,
> >             op->data.nbytes > f->devtype_data->txfifo)
> >                 return false;
> >
> > +       if (op->cmd.dtr && op->addr.dtr && op->dummy.dtr &&
> op->data.dtr)
> > +               return spi_mem_dtr_supports_op(mem, op);
> > +
> [snip]
>=20
> Now that spi-nor framework and flexspi driver supports octal DTR, if
> device-tree specifies RX and TX bus-width as <8,8> , then above change
will
> always make sure to select DTR mode and SDR will never get selected.
> Please note, Layerscape LX2160A and LX2162A are two platforms which =
have
> micron mt35xu512aba (support octal dtr) and are causing probe failure =
with
> these patches as required dependencies for enabling DTR are not met.
>=20
> Since framework selects maximum supported capability, I think there =
should
be
> a mechanism to choose SDR or DTR mode in driver itself.
> This will also help for a platform to fallback from DTR to SDR in case =
DTR
> doesn't work.
> We can enable this feature as a quirk or by reading a property from
device-tree.
> Please let me know your views.

Thanks for your comments!
The flexspi controller in Layerscape support 8bit DTR, but for flexspi, =
if
support 8bit DTR, need to use mode3, which means we must connect the DQS =
pad
on board.=20
Seems LX216x board do not connect DQS line.
We should take this into consideration, this is board limitation, better =
to
involve a property in device-tree.
I will send a V2 patch soon.

Best Regards
Haibo Chen

>=20
> Regards
> Kuldeep

------=_NextPart_000_04CA_01D79F4B.2084D9E0
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
MBwGCSqGSIb3DQEJBTEPFw0yMTA5MDEwODA1MDRaMC8GCSqGSIb3DQEJBDEiBCCce2LUh2LCOzts
tK48kRLiDt6oU3hzXA8fpGUpVyvudzCBkwYJKoZIhvcNAQkPMYGFMIGCMAsGCWCGSAFlAwQBKjAL
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
DQYJKoZIhvcNAQEBBQAEggEAYt3EiZaphXpaChHRC+J7bT3B5LY5cS+p/jmJUJZJS8bFKu1S3aJP
jX1tDhC1VAmYK+h6t69g2fx+OYzt63Ys+Wa+Ju2axyrn6N7oeYE4umss/PmJMqbDTjVecmOc3dvg
ys8jzVnUQJG5JnNuG94Tv7PjVhs1C1YzCFm2bJSBH/+i70ixC3y7TzGVnCan6BqEGBeJJJmdbBwY
bH+q+5N5ZfTzbiAPAj5xHHAZa3g+iMx+28Gqli+VtXZ6tTq/4FlIKUFVcjQr2jyLnjykFj6SVDgu
/VjvOQ05hSEZvOpUIMpH6F8+6WNFSyr0b/EMM1Nuora69jCV4seFY9SNZWtlMwAAAAAAAA==

------=_NextPart_000_04CA_01D79F4B.2084D9E0--

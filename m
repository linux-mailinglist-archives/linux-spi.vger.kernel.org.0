Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F963FD547
	for <lists+linux-spi@lfdr.de>; Wed,  1 Sep 2021 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbhIAIWY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Sep 2021 04:22:24 -0400
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:3811
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242926AbhIAIWX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 1 Sep 2021 04:22:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAZuXZvmXwspzJ2EPkz2jVAaR05ZM/Qxg278cDBsHTDKQH3tX4KZ99IyOXNpNsX9+jKgQEwIMxDsMqeiduPVNJ+7GmeH3JxZEE8r6C3tbNa18741xbnSHfgEGoc0y3von9kw8LV6riwPqohq4DxmosJxp+JHm0a8/Jmu2HOCMVj1BDnVaHdBxo9TrKVkaGkho6QWpJ4nXZncE804ABN28CiN1yEuUvDKF4nI3Nq583ZOxn7Ja4AFs4j4gMeEAPx7zBMoHtKgaVBeocc3T+xXzTRtWdpc/4+VOFUwRD76NpSVP4HP1Bjv+sRZLU6pkrH7ZmZhHcMWYApg6ykqP7H+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tv26fdJWUfU5z1FVk3orIXlXECS8IjO/eSZggbUCLo=;
 b=P5dl7KjpqEBwkbbUisaOh9s+K4kAjnrPqeUwXzTfPApA2DCoDEngOaaTQ2Di6nb7ZTmaVgNcUs/8n0H51wSoOEajAU9md3qomhvQSQXFO2raSvkdF63ym3tqnr9tNmMa3edSLAz0Jm0Co1OQclQmSMKTGESxeA2HsJH5+dnUL6QrN05gsB0MhXxUC5pB9tIepjqwWNC7/im/qhm7LlIJSDS/elAH2TXVdT4zAuvjnCHLc8NsPybzRGcycbuNB//LZHWwyDEfjEquurzgiJuJM8+0cmALZQBVLOfrYTSjwCrnlOaMFv7Aea1rfgz1SPlYIlFZZAIXILrZb9E/hfKJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tv26fdJWUfU5z1FVk3orIXlXECS8IjO/eSZggbUCLo=;
 b=DS1ayvmQCOhNJg1fqMObjcWsSKHSG6yM/pwpNupRdMTRT+Bvxe0nUvEuMAnBjR7Rllckjj2PGjQIHLCtBbo2dMipATF7huTmTqMthKQjRleiESnB/60dOcYLUhqaD/8z0CsPqINhMUs5ur2BilzT3nTof7GwTkje5Y0Vg7knI6M=
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 08:21:25 +0000
Received: from AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::50c7:73bf:8c6f:8bb8]) by AS8PR04MB8466.eurprd04.prod.outlook.com
 ([fe80::50c7:73bf:8c6f:8bb8%5]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 08:21:25 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Bough Chen <haibo.chen@nxp.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
Thread-Topic: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
Thread-Index: AQHXlZpDvUNnARzeoUKYud+amD3ve6uNbjuAgAF2t4CAAAHZoA==
Date:   Wed, 1 Sep 2021 08:21:25 +0000
Message-ID: <AS8PR04MB8466C1AD1DEED61D65D5F5ABE0CD9@AS8PR04MB8466.eurprd04.prod.outlook.com>
References: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
 <1629445443-10300-3-git-send-email-haibo.chen@nxp.com>
 <AM9PR04MB8472116E9D7745875A06F436E0CC9@AM9PR04MB8472.eurprd04.prod.outlook.com>
 <VI1PR04MB5294469919613247746FFEC790CD9@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5294469919613247746FFEC790CD9@VI1PR04MB5294.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8df57bd9-759a-45c2-ebe1-08d96d217d48
x-ms-traffictypediagnostic: AS8PR04MB8546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB854681CDFDB612656D6FF63FE0CD9@AS8PR04MB8546.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SARHoxhyrdIK7eY0fapSYUGm3LH9k9sZSLmtaCGu48cGFg7tcpqsUGp0ED/Ae9DUPDltRr5JDwZoPlBky22QkApgr/4pIFVTj1IHyDByjoW1TKdOZQ9bt9cZqyk7vTB2/NM9VANpKhgDUIQvcFYF/awmbIpwRN0Ap00REKlP7P0lb0wJOV0O1QKKkHV5q8mgJLgMRMY1VtEm860AqhHHJp14b8ceCL4mwr/F8vVup8GJQxui7XmKHOGuQpIeItkhAm6rrOoS7/JlA6GTn80pcmmJMQOS+/dyDJRGowS1v5/G8T5YkTGUtGlUTTBPWWoB23jwTL2oZ9w0j0bwM1knmHJsgvzHjcJyOl54jOHY6jAJ5VoLENWCFJ083No9SpeCVmO09KGK4F/VnhjtHGNtXVY/S9leldMAScAJD5UkjjgEd06CE4H3cyaUh5BI1JB+20vxTCFUQzkGpUR7SsNBXhA3X7yJi6WrPM60KFSTZl8yi+JuKNzOQABlBraPuxeS8jsQOunGq4eeDa4YLDWaHhnObyix0mQJwqNEHswcvGWaDbRNtCtIXTRZEx2HSlDoOHwxI8BR4XKYY9FQEiMut1YLjZ96l5kX8ksMdYuWVpAvxvblIhk4eo99o1UAf7LbxMF75iVrJGSDcdPT6DFtbvpUbjcEd4VMsHLFtuznFsZnKpaRIzmZs+EtPQEOlO6jffoPFiweB9susYKzAodsxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(478600001)(55016002)(86362001)(2906002)(66946007)(38100700002)(122000001)(66476007)(71200400001)(76116006)(66556008)(6636002)(4326008)(7696005)(44832011)(53546011)(83380400001)(6862004)(64756008)(33656002)(54906003)(66446008)(8936002)(38070700005)(8676002)(26005)(316002)(186003)(5660300002)(6506007)(9686003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VzN2NkVMNGhMTitNUXl1UlE0bDhmRS9sR3J5c1VkSkNPTVBsRTBuK04y?=
 =?iso-2022-jp?B?dXY1ZTBpcXFvUitPWlY2aldSQUNsSVE0cVBnc1VqOGM5eThYUmZYNGp4?=
 =?iso-2022-jp?B?RTFjR0tZc1RLQzNSMmFJVkI4WCtiVWt4YmJkRDJjQ3o1b2JxcnpzZzU4?=
 =?iso-2022-jp?B?Wnd5WnFweDZVU05ET3RyK3BBQm9iZTNGeDJzOHhJUWpTMGg1MDJkS1hn?=
 =?iso-2022-jp?B?Z2lFQlNxYTdKV3QyLzNQVWplVTVhWTAyZkIrYk10N0ovcVQ5YzlRM0Uv?=
 =?iso-2022-jp?B?TFJ4aUlEdy9LZU5XSXVkREl1N0NnTzF2bGNtdmtnczhtZ0wzNm1hYXp2?=
 =?iso-2022-jp?B?a2NKaCthUTFmbjN2ek1ORUg0TWZIY0xnK2FlWHJTTW9xWTRCWDVERHhT?=
 =?iso-2022-jp?B?MkJpWEg1Z1QwZjZGSmJtRTIyNGxpMVI2RVczR2wxd08wWUhZZllBck1q?=
 =?iso-2022-jp?B?VTdBeGozckh6TDBsdTcyOXFzMkc4QWFnbmhhZzVEVXdHSVJjUi9NcjBR?=
 =?iso-2022-jp?B?Um1VYmp0MDBCSUs0c0hOZ1NYMWhHNDFiVXBuK3FxM2MvR2xITmdDT3hu?=
 =?iso-2022-jp?B?eFh5R0FLclhlY1ZwWktDSzB5K0R5bElKM1VRYXp4b2dXUllhNEdxSzVh?=
 =?iso-2022-jp?B?bE1uNVFzUFQwMkhXRUF6c3VjRHJlRG4vNklyTDcrbXF0TVRCOVRNLzlM?=
 =?iso-2022-jp?B?Rm9rMXhLRkRxTExNaHB2d1hldStQMHlnTTRselFsZlB1aWo2N3FkVjlp?=
 =?iso-2022-jp?B?cTNYZlljV1pkSmZ4bWNaazZ0c2w1eE1jRzNXazR2b3dOb2Q0RTBFdEVj?=
 =?iso-2022-jp?B?VFdVYWswZEZTOXV5VndrcVBucjNLcldTT05pVFJscDNIMlRCRlU1Vko5?=
 =?iso-2022-jp?B?S3ByMGU5RDMrV05DWHpCRERXMHJ0YTZsMUIxMWpKZmMwb1ZTSFBjZGJr?=
 =?iso-2022-jp?B?U1FXYStIeE5DaVowWE55V0hmeUhCTmxycXpPZ3J4c1gvWmRjREZCUGNl?=
 =?iso-2022-jp?B?MUN1bm9sczdiYVhXeFNjODVmMzI3WFgxTlB4eEhuM1hBdStsVEVoRUZ2?=
 =?iso-2022-jp?B?K0RCNVhhVm52QS8rS1dwTUV6YlZmemtIS0tiRjlIY3hrMUVwTnV5VnRJ?=
 =?iso-2022-jp?B?ZmhheWxjeStkb2VVSkdoVWkyVTBlYjZhQ1k1K1AwMXhXRW1mWEJ4SndU?=
 =?iso-2022-jp?B?U2x5eWo4Sld6N0FWQU1rZnJSRHE4aTUvM2t2TnNrUmZCSUhKK0ptaFRG?=
 =?iso-2022-jp?B?SUZRdS9DSGp0bEVIVmtFMGFjTXF6V2tXMi9QZE05NENCNWF6aEFzR0ta?=
 =?iso-2022-jp?B?RTZCa3l3R0tnVEVRNG96SjhXRkR3Q3hpdFdqeEFSaTNQTkZ6TGtwTm5U?=
 =?iso-2022-jp?B?T0ZEV01Velo4REhQSEM5Zk5JTFdmS1JML09BNFBUcXRXNlE2WDJDVjU1?=
 =?iso-2022-jp?B?V3RWZDRRa3cvcjhVRU02dGE1WWFJZG93a3puQWpKcDR2amNtRTFsN3g3?=
 =?iso-2022-jp?B?SitCMHFuVWpiNW5hU2o0UzgxeDRFTU9JUWwvTktsMlpFSzgvT09rZlZy?=
 =?iso-2022-jp?B?VDdubGt3V2N6MHJScHJ1VnA2MHJGMTdJSzQwR21TckdoVU5pVUxWalJ2?=
 =?iso-2022-jp?B?aG41bVpTZGMrZVdFR0dIWmpFRm1OY2JxTks3RUlINUp6YTBkWEZlZnAw?=
 =?iso-2022-jp?B?RTliaHdHYVNQRjhVaWhmZ1h4OStlYWlPWm9iaHp3dnBVSGhxRFowdmRM?=
 =?iso-2022-jp?B?WmVsQzM2S2YranNUcDJtUHlwUHcwQ0JBcmNlZVpZT0M2K1Z4WVlyMWU2?=
 =?iso-2022-jp?B?TzFiMmdVNU9Rb2tpazZQQ2tMS1BLeE1iQkw1WGo2bkYvSU9UQTdmcXZu?=
 =?iso-2022-jp?B?dVRzMXo5Z3FNV3Z5U3JYTlNOWk1Ja3NxMDB2S3FMb01DVWdrU2pLK081?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df57bd9-759a-45c2-ebe1-08d96d217d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 08:21:25.2268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8WZsBi2NpavyvPNeQLvPl/KwFkmogSLT16/JaQaI9LToLzKCOZigltKa1Re7vNx22m9LPrgiiiWOqaIP5Z5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> -----Original Message-----
> From: Bough Chen <haibo.chen@nxp.com>
> Sent: Wednesday, September 1, 2021 1:35 PM
> To: Kuldeep Singh <kuldeep.singh@nxp.com>
> Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Rajesh
> Bhagat <rajesh.bhagat@nxp.com>; broonie@kernel.org
> Subject: RE: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
>=20
> > -----Original Message-----
> > From: Kuldeep Singh
> > Sent: 2021=1B$BG/=1B(B8=1B$B7n=1B(B31=1B$BF|=1B(B 18:42
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Bough
> Chen
> > <haibo.chen@nxp.com>; Rajesh Bhagat <rajesh.bhagat@nxp.com>;
> > broonie@kernel.org
> > Subject: RE: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
> >
> > Hi Haibo,
> >
> > > -----Original Message-----
> > > From: haibo.chen@nxp.com <haibo.chen@nxp.com>
> > > Sent: Friday, August 20, 2021 1:14 PM
> > > To: Ashish Kumar <ashish.kumar@nxp.com>; yogeshgaur.83@gmail.com;
> > > broonie@kernel.org
> > > Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Boug=
h
> > > Chen <haibo.chen@nxp.com>
> > > Subject: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
> > >
> > > Caution: EXT Email
> > >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > For LUT, add DDR command support.
> > > Also use new API spi_mem_dtr_supports_op() to check the DTR mode.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >
> > Thanks for submitting patch to support octal DTR.
> >
> > > ---
> > >  drivers/spi/spi-nxp-fspi.c | 25 ++++++++++++++++++++-----
> > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > > index
> > > a764eb475aed..f7acad2cbe64 100644
> > > --- a/drivers/spi/spi-nxp-fspi.c
> > > +++ b/drivers/spi/spi-nxp-fspi.c
> > > @@ -486,6 +486,9 @@ static bool nxp_fspi_supports_op(struct spi_mem
> > > *mem,
> > >             op->data.nbytes > f->devtype_data->txfifo)
> > >                 return false;
> > >
> > > +       if (op->cmd.dtr && op->addr.dtr && op->dummy.dtr &&
> > op->data.dtr)
> > > +               return spi_mem_dtr_supports_op(mem, op);
> > > +
> > [snip]
> >
> > Now that spi-nor framework and flexspi driver supports octal DTR, if
> > device-tree specifies RX and TX bus-width as <8,8> , then above change
> will
> > always make sure to select DTR mode and SDR will never get selected.
> > Please note, Layerscape LX2160A and LX2162A are two platforms which hav=
e
> > micron mt35xu512aba (support octal dtr) and are causing probe failure w=
ith
> > these patches as required dependencies for enabling DTR are not met.
> >
> > Since framework selects maximum supported capability, I think there sho=
uld
> be
> > a mechanism to choose SDR or DTR mode in driver itself.
> > This will also help for a platform to fallback from DTR to SDR in case =
DTR
> > doesn't work.
> > We can enable this feature as a quirk or by reading a property from
> device-tree.
> > Please let me know your views.
>=20
> Thanks for your comments!
> The flexspi controller in Layerscape support 8bit DTR, but for flexspi, i=
f
> support 8bit DTR, need to use mode3, which means we must connect the DQS
> pad
> on board.
> Seems LX216x board do not connect DQS line.
> We should take this into consideration, this is board limitation, better =
to
> involve a property in device-tree.
> I will send a V2 patch soon.

Thanks for your understanding.
I will make sure to confirm NXP layerscape devices for next version of seri=
es.

Regards
Kuldeep

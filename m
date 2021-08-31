Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A93FC634
	for <lists+linux-spi@lfdr.de>; Tue, 31 Aug 2021 13:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbhHaKmu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 31 Aug 2021 06:42:50 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:54862
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241017AbhHaKms (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 31 Aug 2021 06:42:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHFpwTQ0E+VqW/LpuBcTyUAV6H7xuQGSKI5xmVLKh71krO9SAVV8a08RwnUaB8Os65YCu+BpqGH08deOrAm/GSMPQkYFSlLgtbgIhtCGSvITiBrqfpNAGQaZz0/JUqyvb2l83Z1Q+MHTF1x+tsPWW5M91FSU8uIA8t7hZH/LSsEJb8mOgHEf+nn0TJZ71sbHWycI24ho8vT03vKhi7bnH0XOsxRe1vJcaNOlcpn/A7NV9LmO1MOzP2n0Zjai7Qkc7HPpCtOVeOY0eceGfMlV/DR3ImvkTzeDrT7qs1hKzST21x6O7z6AlKSt2qfP/mRi9QuvFMKytMeLFOzGpeqPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byU1t/SjxdtKXnx/JYceOCB/2HjBXaJgZHbFnQN6saI=;
 b=Dm/SDwni9laNgS5ghcZy5WjC4IP8I3ajkHwkMV+NaUItOabctCZ7w6VCr8kvYNY2tW5u4ZPQVJumFDvV6LSkxWOf/7aFQ92Yh2rn2IFv8zZisCr/IgxeGqBfnISVZAZ8iGFYRLpC3GnB4RrFD0+Snmj9Ar/dEEqdP7OHmV7jliX+906mRS43JVCmnY2NVHqC7OFD8fLfhLXpoIjRgSgk+GqszO/FWEBVAWp9Jdecz0/vrYuevZdFS3wMRZf5NCoGbDcayERRcHgO2kHMYHsJ41SiE6Ewqg9GTiH6XF8rW7y5HTc5D+Tcm6QS08y+OxSgbgl+98LsFU12tWQzVG8p7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byU1t/SjxdtKXnx/JYceOCB/2HjBXaJgZHbFnQN6saI=;
 b=qAQ2hNfGDpCU08CxHp81Dc0FhsCi/KMJuTeTvlFNg9W5DEzrZzruZBvNm7VBCdVw91zzgryKvbCq91QmFnNrLrkYXe3qu+6yPhaI68g0AYy4mK78XxUYPCscPU8iQInhB1ea2Zg/gjMSNB3TI4cMP+jihZl9RnVfffQzYsatn6E=
Received: from AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15)
 by AM9PR04MB8488.eurprd04.prod.outlook.com (2603:10a6:20b:41b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Tue, 31 Aug
 2021 10:41:51 +0000
Received: from AM9PR04MB8472.eurprd04.prod.outlook.com
 ([fe80::294f:4fbb:5d9f:9a78]) by AM9PR04MB8472.eurprd04.prod.outlook.com
 ([fe80::294f:4fbb:5d9f:9a78%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 10:41:51 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Bough Chen <haibo.chen@nxp.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
Thread-Topic: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
Thread-Index: AQHXlZpDvUNnARzeoUKYud+amD3ve6uNbjuA
Date:   Tue, 31 Aug 2021 10:41:51 +0000
Message-ID: <AM9PR04MB8472116E9D7745875A06F436E0CC9@AM9PR04MB8472.eurprd04.prod.outlook.com>
References: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
 <1629445443-10300-3-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1629445443-10300-3-git-send-email-haibo.chen@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8076279-2b82-41bf-19a6-08d96c6bf120
x-ms-traffictypediagnostic: AM9PR04MB8488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR04MB8488F10BCC2C4386322E6F12E0CC9@AM9PR04MB8488.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klxIavJrSdXr/I4JWA95rNgT1XxT2QjTBdEcksJ+pQFrgDPcmoOp6YeO2iAZYSJCgBp2v96MKIFDRZIe8JX3tK8BL76ldSiz/haCD3UiszAN+CKlcHt+OxByEAv0z3EbaI97+QIMN7sqritOhkr3mklAqIU8UwdqB8iAoTwtAfKieJ4WbcolRBF0lfMXiCh7UDDIByGqXLICB21Im2uFk3vFufdqQvpDYPRK9v4fKpQCHnECeFGB8drQuI1HckMyvBTpLCUFxVB3eTI6NH1pU2kkKdvgPs46nV2vrRunBsn9W1UjegDPDTY5Guqgnp06CloyPifHLZK1V2wY20WMFLS2r+prKKha1n2DDoA1Z66vcheQbnJMU6i3guQjUAPQcgruvIdeYyx91HH70wriaiDhHin4qKQ1RUtIbGD0vp4u7go0NNTyXs50+D6xtDUYed8jfF86k5PdejQf2zsG1fHKfy8vicgKKtnkZk3sgpaPvdwFufoXnyE0nm+0dZTpNAwPSwEtZMPJSJtFZFSw6cswdhMXhIx4oNJpxrmvXuffBzJEvEUAMTw3mtcRhOwhCZmzEhwTeN99If0UUlAauKk6hRguF5jkvuaNVCi6ONhvs8MIdqoEm4qfLzLE6NFtEoxUkoWnYnDv0+zEQXXW55s1X6T3863D7Tf1YhzRKTJY0Z6TOQnTYRSfzJgjaw1qzxTk0I0ik0j9vIKqqLABZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(55016002)(66446008)(66476007)(66556008)(38070700005)(33656002)(54906003)(66946007)(64756008)(8936002)(8676002)(316002)(6506007)(52536014)(9686003)(44832011)(76116006)(7696005)(6862004)(186003)(122000001)(6636002)(2906002)(71200400001)(5660300002)(478600001)(26005)(38100700002)(53546011)(83380400001)(4326008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PO0soKojIrcA61Qhl1vYS7wmbxDkTa5gQH2UBx6CkGfwO7dUsbLXt3Egw9TL?=
 =?us-ascii?Q?eZm6MQapxQOjPUIocLmmhrz3FKa6+hxPUDnfCl7d7iIvUdToMO+N1Q4MLmRr?=
 =?us-ascii?Q?2STC0BRdpNocxPX7gcOXXRGBczv2x4jjat+Z3ohC3mTZU0/XfQqrWDOxbaXK?=
 =?us-ascii?Q?R7H621RzLNLMyVBTKzkGRGqxFw+pTUbKGU7MV+Pf67T5lhZxcBfh+eH4bjj4?=
 =?us-ascii?Q?UPXt5wDm3zsAGo4CuYqjS+H71osZRIaKG/W/ScLXCLaekun0ZZQWPMlFm2UR?=
 =?us-ascii?Q?g8XZSnTPXAU5BfiiI8uA8cfNDC8QwTZ8pMOHXo2YwpvzkdMqkyk0T+LY+dUO?=
 =?us-ascii?Q?boGM/CnAojaQNvlaEI0wgmfZtqkCI0Sdhdjwasnd4heyLfQnIrtzzqSwVLMf?=
 =?us-ascii?Q?yQ7tCa9or99AELobmneT0GTSeTucn04aIhWxXrKMlDNqXX44SenyZTVOLThW?=
 =?us-ascii?Q?qje7m5yswGRuE3IwkG5IQiz/JZcZ4O+AeEVUKCl1pcq0Fu0x3u00gMshCDJY?=
 =?us-ascii?Q?RG4/U5SM5qMgTAF+DR0FE9/6s4/mnLUV+gN2SwcpiDoFCUojSsA9altgsn5D?=
 =?us-ascii?Q?ywyjA3AyMC8xFzzh4QFOvZrMw7Nc9A11J3+eYJQRh0pW7KJwml93YCJRgkPu?=
 =?us-ascii?Q?xoWujFNjegBOcYNcAc0oUGCmuq9uNV6sTy9Dbr4HfyPO6CNStgWV7MI+uD7t?=
 =?us-ascii?Q?l/vTSWU7qEOC9UeYnMxtxOq9C4pX4WkD9y433X6qPFG0E5e1VOP8K9fmwMI0?=
 =?us-ascii?Q?A6bqrMxXSDACbBl/QnwoPvdwO/8TFEIphrCLyNOvoScbACxzx8VbZcDnfkkV?=
 =?us-ascii?Q?HZUt90jMuxDAhCGPHro1GOhZW6TRYu2tZ5tBiCg25+eLRJXaRZQ/asggC8yG?=
 =?us-ascii?Q?KMloXNNcCZ4yj+Ijoi6GVAKbSGZ2YNft1AoPq8K1oQxMds2nCsoAumEtM8mx?=
 =?us-ascii?Q?AiVR6LZyHZFj2dFKPYLTpS4ePye+2Ky+VCaDF36L5laefZ6VdOUwf2rGsHGE?=
 =?us-ascii?Q?4yoYg6yc5e0QuJudaZ2d2I/doqylhqOx6Jlmh+LMg99Nt+EsDvMlR2yBi918?=
 =?us-ascii?Q?0N/jUU6s19Ip6fgtQnju6s+DPQfkgvTBNOeS0EqmbPy5u9ahqCb5cOzWi0/L?=
 =?us-ascii?Q?SnpyGvp4KMyPhIoRGvqB2/kiY2v8KZUF+Y16y8/IaQWa5C+MjOZ9Xm+J2DjT?=
 =?us-ascii?Q?scxFqll44g+wBOMRDnWwTf+wXYWInlRf4O+zHIDF3IptzscMV+kjv+ZqdAwc?=
 =?us-ascii?Q?LmJEH3/iZx763FjxT2CLU2jUCoDxje44xRoJ2cFCtTuqehopI/aqJ/VSuSxH?=
 =?us-ascii?Q?7f75uU9X4hEOrBsLaZ43ybdh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8076279-2b82-41bf-19a6-08d96c6bf120
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 10:41:51.0895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzVex3F6oGErWxG6cTUVfQQfbwJmlvNhTBnPUcaWPrM4yWcpFiPnSiktMqeh5+BEZjZUbAXNUwZ8ZvZf7wQ74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8488
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Haibo,

> -----Original Message-----
> From: haibo.chen@nxp.com <haibo.chen@nxp.com>
> Sent: Friday, August 20, 2021 1:14 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>; yogeshgaur.83@gmail.com;
> broonie@kernel.org
> Cc: linux-spi@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Bough Ch=
en
> <haibo.chen@nxp.com>
> Subject: [EXT] [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
>=20
> Caution: EXT Email
>=20
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> For LUT, add DDR command support.
> Also use new API spi_mem_dtr_supports_op() to check the DTR mode.
>=20
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Thanks for submitting patch to support octal DTR.

> ---
>  drivers/spi/spi-nxp-fspi.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c inde=
x
> a764eb475aed..f7acad2cbe64 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -486,6 +486,9 @@ static bool nxp_fspi_supports_op(struct spi_mem
> *mem,
>             op->data.nbytes > f->devtype_data->txfifo)
>                 return false;
>=20
> +       if (op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr)
> +               return spi_mem_dtr_supports_op(mem, op);
> +
[snip]

Now that spi-nor framework and flexspi driver supports octal DTR, if device=
-tree specifies RX and TX bus-width as <8,8> ,
then above change will always make sure to select DTR mode and SDR will nev=
er get selected.
Please note, Layerscape LX2160A and LX2162A are two platforms which have mi=
cron mt35xu512aba (support octal dtr)=20
and are causing probe failure with these patches as required dependencies f=
or enabling DTR are not met.

Since framework selects maximum supported capability, I think there should =
be a mechanism to choose SDR or DTR mode in driver itself.
This will also help for a platform to fallback from DTR to SDR in case DTR =
doesn't work.
We can enable this feature as a quirk or by reading a property from device-=
tree.
Please let me know your views.

Regards
Kuldeep

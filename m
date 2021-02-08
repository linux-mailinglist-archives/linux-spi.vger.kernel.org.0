Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9591C313A83
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhBHRKb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 12:10:31 -0500
Received: from mail-eopbgr150117.outbound.protection.outlook.com ([40.107.15.117]:59776
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232995AbhBHRJQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Feb 2021 12:09:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2NeLxI4OE/P1NaDpjmIXfGtaHnVVZ5Yl2xDNmOR5C4DvGmV0uUNFuSzK0ykwcsSNV+oavsC/nggXv92IXu+j42mBU6ZKIQRNjk558R6LhFRVMPthOy/fBG8LADUFWFnXkKNMzO9M97frQal+7IWKPfc1h391JM8+eo+ltUzuyFQRPGY8MwC+OKGbPzddw94xijU+BmHitN/dslOZs9eSyz1GliTzTw0DU1hj7gjo+eI/O/hSFzkb5l5IHmcnzPVFP6k9xnv/A1OdVaN55tgvABCdztS1fc9hf7b7nXMZ8jjWfsL23cSJFA1OwWOwlB9BGP+AgW8vS1j31QhwWRT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMQdRahYZA9V8HEwf2jyLuIkGnrJPcauHayaV9ai7xs=;
 b=FRmIwtMKTlBj7jZ4MT9pK1fMpITRPiQqRROimYHVbzS2Gnag15SGodL5DFs/g/ccTbzOTv779vcKhUB6laiyDuk897jvYM3L0YA6d9kkCuIALAz//jp3+zpfJbAUZ9+WUG1Y8KcwxNZscxjx+PWc5IXWaOoL0DCbgLcWpS/bLrx34Y7PN8583/BLkBtGMeg5J07rgX47M4DS//G19LMTK76zOb5zk+7cNI0tLQIxZA2pQ6U9jK46PfZmKgNobuCUxE3lHrcLSRsizp7J6gWxTAGWgmLic/vW1iwlrQcpR9h5FYwE9QcKzHQ0zH+0kIsSHCuymWt6DwvZ+Wnv2Ie/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachi-powergrids.com; dmarc=pass action=none
 header.from=hitachi-powergrids.com; dkim=pass
 header.d=hitachi-powergrids.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachi-powergrids.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMQdRahYZA9V8HEwf2jyLuIkGnrJPcauHayaV9ai7xs=;
 b=CymyZN/uKMOc0Bn3H1D3A/Af4XLIvGAv7+ZI9ZLHOD61HDcctkwadYHMo2/HyGpqQUYjEASu50qNc4LWjOX10tEpYhxj2fiHxTG5ajzOo/Imv+GfAuWYjFtlfIhNmSkf+BOGfTdjG6YLeJQKBmtXsceqYrxZ0RQIgMFfoQ4KJXQ=
Received: from VI1PR06MB4029.eurprd06.prod.outlook.com (2603:10a6:802:5d::10)
 by VI1PR06MB4030.eurprd06.prod.outlook.com (2603:10a6:802:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 17:08:28 +0000
Received: from VI1PR06MB4029.eurprd06.prod.outlook.com
 ([fe80::5122:a590:b5fb:658e]) by VI1PR06MB4029.eurprd06.prod.outlook.com
 ([fe80::5122:a590:b5fb:658e%4]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 17:08:28 +0000
From:   Aleksandar Gerasimovski 
        <aleksandar.gerasimovski@hitachi-powergrids.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH] spi: tools: fix input string formatting
Thread-Topic: [PATCH] spi: tools: fix input string formatting
Thread-Index: Adb7lWXMIZfEJF6fRI2btRVdFMCGkgARWziAACbAHOAAYyY7gAAOpWsA
Date:   Mon, 8 Feb 2021 17:08:28 +0000
Message-ID: <VI1PR06MB4029F761DD1F4CBA39DF1969D28F9@VI1PR06MB4029.eurprd06.prod.outlook.com>
References: <VI1PR06MB402928E3B0E4C887104BCE22D2B29@VI1PR06MB4029.eurprd06.prod.outlook.com>
 <20210205162031.GG4720@sirena.org.uk>
 <VI1PR06MB4029DDA88C93EFBA0F69D838D2B19@VI1PR06MB4029.eurprd06.prod.outlook.com>
 <20210208100901.GA8645@sirena.org.uk>
In-Reply-To: <20210208100901.GA8645@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=hitachi-powergrids.com;
x-originating-ip: [80.75.192.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75f75824-4b46-410e-442a-08d8cc54278b
x-ms-traffictypediagnostic: VI1PR06MB4030:
x-microsoft-antispam-prvs: <VI1PR06MB403030A25B6FF5BCD2A733D8D28F9@VI1PR06MB4030.eurprd06.prod.outlook.com>
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0kWUoPOWFewBt0b13Ojr859R+N5t1IECeqEieg0++sWNWCb5h3PdoY4qpXKg07iaYa7ivuvRtcg3myqVnYkq1DBt4y7lwdAQl5Tna8smuWbEEjWiXaFHxpR1iSchQSXUYqzEJ5HgD3UwRK85qxK7w6UbKiezIkHyaANScxfd4h14DxCvH3nFRpU2pcbJ4Bj8eN8s+x4MpHfWq7J8h9XuZo1AdID7tpYRS4lIoMLNPSTOTJwrHsxp319hhyPKmHZbEtPEgDM3QJJcSCn2xLvbUrpC1bNAqMQMk3QBJNbnXd+sCyxJJuNNyJE755z7YcXwbG7Z2OMTCYVzIwOkJ3gV7hA0OQ0tcT+79Y3eLulMVrE0kizWKviAnsy7XyIPaRN2Ip2MlanUNAZ9OoJiKwE5Edhy7h5onkgNO/PAZofZsr94alhEPP+vuX0dzArHt9rtlpNpqDuC/7hVaqUzqlO457GGIFE1TmDIIgLjuNZURn/YTf6+fqn8v6/wbaF8hsPKmjup76wTaJfPccANlH31Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB4029.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(6506007)(478600001)(8676002)(53546011)(44832011)(8936002)(7696005)(9686003)(6916009)(316002)(86362001)(26005)(186003)(71200400001)(66476007)(55016002)(83380400001)(2906002)(4326008)(66556008)(76116006)(64756008)(66446008)(66946007)(33656002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U8sfy+59zwgiGytI/5IvAqy857dJJ2r0MGzoHix/nmIbHyq3274mP+EW6kOf?=
 =?us-ascii?Q?ntE1C7/1GlHEPfm1BFy2pZz054h4e/d8M2pRDShDPfSnl+dd9qDoKaYeCNac?=
 =?us-ascii?Q?29+MDnkexBj3tNmzsOm7OqM6WGNKY0dNA4VRVkRVALfL8DZ7EGoHt1IfB59y?=
 =?us-ascii?Q?4lw7RsZzhsBjANhEQRVqfKIGGTLV0AfOC34Nq76xRg5/8NFFUH090QOCZGX/?=
 =?us-ascii?Q?t9WIBfuLfJesaWkQL9xJOy9tRkdXM7hbIqNu83vrUSS2B7WDaYK24AFb+uPr?=
 =?us-ascii?Q?h189MO5Baq0ZQ2LR842sXOfMktxD1Ip7hGVbILGHhTA1yQx8vcLT3hDo6TAm?=
 =?us-ascii?Q?Z6bU4bomPHHlGM0jBcxIzNrI0krWfa3fNwKNNRqhpMixBl6w5Zy1dNpnt0Nr?=
 =?us-ascii?Q?hPV+vdHl1fRBj3EbwcCdBWyuU9nedI3cfRXXLhT++agCEF/6U6YcwBfidae4?=
 =?us-ascii?Q?1NPPs2NyrqcVsErp1THBtFfTPk6AsryI0/GrHfCI40djBmkBGf4c5W7KKJv9?=
 =?us-ascii?Q?SO6b0z1q0Bth9nyYnR+UqSiTdIr9QHcnjr6b+6iTqtFwV0UfInqeQH/pL7rl?=
 =?us-ascii?Q?xbDkbJB5WhZ1gYpZ1O9jPe/fwGzoPxDwFJqfa5/ay5sUGZSsPYjUgZ6w626S?=
 =?us-ascii?Q?m1y+uSBrY+YtGda0n0HWJe2Dy8tccP4kwlVTQN8MpC3pfjzpzZkoabyBcdrn?=
 =?us-ascii?Q?OJtkX2wjI3gBrey6wKRyuXmE/uKUO03USbrIwUcJWhywbaRJG9KLKT9xgozz?=
 =?us-ascii?Q?JwPoRrnIu1M/XX8V0Y3kK/2yfR+LZmokaGmhrYOS7L+VvSrtALJBHyNZ3oZq?=
 =?us-ascii?Q?qXICuk7T781fLSqw9idChNHNb1gD/fkciHLsu/VvlnQzv3Tl+LOvfcQmnicC?=
 =?us-ascii?Q?WaGPdSuEnmZTpA9ngUf9mWg77nU5N2LKpNOKg5m+LQn7rzMBD0Q1UFbYIUHH?=
 =?us-ascii?Q?CraTL7BXqTSIMYo1ShXCsN2STWNdB8Wrn1gTYnCj8c9Jnw433Zf3NfA/QFtx?=
 =?us-ascii?Q?6kxfghUpHvrokklRcz3P0Xpy0+gu1s0Vg4pMKGUhvEt195oqUQXuKNuudyo5?=
 =?us-ascii?Q?9PkVY0G/p+DIzLbyho76wMaXGxws/iUaMwXe6Z1lqryHEzuXRJzmdTYao6sc?=
 =?us-ascii?Q?nKhaa0zY8KKpqUEKzvAesvVi6IqsOMG9E4BnY0yVyzoorQdYMG+kDRUnOZEX?=
 =?us-ascii?Q?gYOktpd+NN1J2bl5blKJ15ulHh9NAWGOzcdoZMA71SCWGcv1Z8KXOSz9Su54?=
 =?us-ascii?Q?xB8v9HjtOxRCQLT0xS8gLaweUvK063Cy6ThspnE/AoCs8beB/M5oh0pOlRx/?=
 =?us-ascii?Q?XDb7x7dB3oWSjN0QrFDh9ceq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachi-powergrids.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB4029.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f75824-4b46-410e-442a-08d8cc54278b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 17:08:28.5372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GPzGdTKZuFWUFeeMgkcNR0w6gk/dFkv+KxZDqaH4/JtY9vpyrHm1IbZ8Fzy+Lph9ICLgv0+Y4I2giisoVhdifHvqM2e0PPORKPIDSWaa9Fu1UiT3vC9u0exec+JKaKON+cGvpcjerq0dboksoXPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4030
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Ok, thanks for clarification.
You can forget this patch!=20

-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Montag, 8. Februar 2021 11:09
To: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachi-powergrids.com=
>
Cc: linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: tools: fix input string formatting

On Sat, Feb 06, 2021 at 10:57:04AM +0000, Aleksandar Gerasimovski wrote:

> AG: to be sure we understand each other, you expect quotes to be sent to =
spi as well? That's expected by design behavior?
> Is there any possibility to avoid sending them then?

If you don't want quotes to be sent then don't send them - my expectation w=
ould be that if you're driving this from the shell then the shell would not=
 be passing unescaped quotes through to the program.  For
example:

	$ echo "Hello, world!"
	Hello, world!

Here echo only saw the unqouted string so that's what it displays.  If you'=
re not using a shell and starting this from another program then I'd assume=
 there's some way to generate unquoted arguments in whatever you're using.

>=20
> This appears to be requiring that anything passed into unescape() be a nu=
mber which isn't something we'd obviously want?  I'd expect the function to=
 unescape things, not to do other random validation which may or may not be=
 appropriate in context.
> AG: so by design is expected that everything is accepted here, e.g \"1234=
qwert\\xde\\xad\"? If yes than I understood this tool wrongly.

Yes, that's my expecation - it's just processing escape sequences and passi=
ng everything else through.

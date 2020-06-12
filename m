Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336261F78F0
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFLNsr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 09:48:47 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:44355
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbgFLNsr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Jun 2020 09:48:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O95KL2qFHLiDnU3O5slPzXLX1Q6O4vDMxl5NGGSCtfglOaMdKEbISkrhOg69pEX3b+rCAOyExCF2g0YLQF5XUTQ11dRNirnb7F3axMi/0apddMFZDugLVGlViwp/nEmv2T+EggpRzibOLVt5THGKg4j4mXSOHYZMppiENqyn2WZ9WTJ3VKhVaUfCOu2i9hcHJVE3LFq4TyVRYnGc/8zIKak71Garn/8JRLB7C+wvtCTnyYqF2ItsGP2oQIpZBGY6TKVhdBnsGMFJGNY2hYE+HHuxdx30o+KMPIfERKtpyG/eHV6i2VPpyPGjbwHBx66uVjiGeEylfLYe7gz2QEwKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2YIDp6GHGax1Y/wq0Zn16DkgNqU/L1oMbvftaQswBY=;
 b=hmPpqgbON8lz9/Xwq+eSvocTXVYdeSSds9e+KMzpXn7Q2ZW2ZJmjsyYg08cJuKVFvhj3X3i2czXVXDdrberj5wtMd2d/AnUUcP99WMOd6dhEwPwHN3SJ5cw/qijJqpHbGbOTQuvfTiYcEnvFs+2I9YUXV8V1SmDDNZgzW4u8NblXwTYk+mx2xSjfKSmp9YrD8rlzb83RzCW5XLo8n3wkBm6d0D4JfHTniWLpDPFlNIzXxXZVjvjYdi9qOCx/Dz0wR8QGRaDiV/nUVEComnV4RXNXJO6dC0l4vvlPga24w579EUzQwZWblsuwipR8eRy+1jmDuQwfMMUf2xpRyTYxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2YIDp6GHGax1Y/wq0Zn16DkgNqU/L1oMbvftaQswBY=;
 b=WYCybxa1b9+dGUgOQWOEsJmhubB3KCGG0zvoarRluGYBYJnRJQD9+zaEEhfAJgQOTe4/RVfoyTYB4+P93YdmJZNZfQeVaebn2fNq2I6vInEW0d547Ho9zLdHZaE4z9p75qyo7xtDFiSmYyq/nCzXi1ts5pTDt3OePFUi4paZMCA=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6512.eurprd04.prod.outlook.com (2603:10a6:803:120::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Fri, 12 Jun
 2020 13:48:42 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 13:48:42 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Thread-Index: AQHWP6z7CX2etPvPnk+oddH8JEW5FKjTbHIAgADDYUCAAJUwgIAACjoQ
Date:   Fri, 12 Jun 2020 13:48:41 +0000
Message-ID: <VE1PR04MB66384013797FE6B01943F2A889810@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1591880310-1813-1-git-send-email-yibin.gong@nxp.com>
 <1591880310-1813-2-git-send-email-yibin.gong@nxp.com>
 <20200611134042.GG4671@sirena.org.uk>
 <VE1PR04MB66383245FAD2AE33CFEA76F789810@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200612101357.GA5396@sirena.org.uk>
In-Reply-To: <20200612101357.GA5396@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: vkoul@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4acdc9ae-97ab-4a33-187d-08d80ed7518c
x-ms-traffictypediagnostic: VE1PR04MB6512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB651204A259840B9682AC373F89810@VE1PR04MB6512.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVKPDfKBfsY0dJg3z/urxBuxyAvdsVRcggqFczgcBbOOEKV4C79Vvtp8zeRdj4wa7DV5nEo5LVx5cT9raZyWgW5mk3pPJbWKiGUjGtHTCb3G99ApJkO3y4EQOdrSPcdek47op7kI2NU4X+zhUB1CEfbCdKlwhBgxYwaPdAP3jCG3yZGLlBYtwN6k19kJn6a+VAxQRJf8mPLgyhQNZRK6gT0aHmC96Hech6BdpMv0j/9kIAaKHePgjaDDel5TJ0wgmVSlMcU0xiTE+lKoPREjghBc1+YTMLLKw2uPTD4ZVRu1HeVqh4hRD51VO3eMQ3KVmH/rKxiZsHXN2JNZuWyAjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(6506007)(7696005)(26005)(9686003)(52536014)(5660300002)(55016002)(2906002)(71200400001)(8676002)(7416002)(53546011)(45080400002)(186003)(8936002)(316002)(54906003)(110136005)(86362001)(33656002)(83380400001)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: e38FYVhVjbA9Gb5yhs2i0D4c/1JiQX5J08GwC1Q4Lc4JrBTNSRPQyls4ZG3StrAyp1Iwpzn3Qw7VuDKHH6cLVCFnpFUI7X7Fbi5cSepMeB+k2ZT9omObw0grxAdvwgWq6FOMX8IjUqBky9Zt5Wta8/9gAnMuTbidDXGQZGQ1zhu3jeHzpsQvqTszeLgRPdmqO4fvSEbcLyFBUobLpCgwoZ+eitdYLpzMot3os/Gwbylpqzwr6UbZsJbj09u6td3sgjTi9yxXIAirzJApxVTx1DOxanL79Y9JOOK0impNurFvXVOF+NX6Iy13Ch/jH05Jlqcx1nBkjy4OfIlq4OAYtCiYCv4+T2pLfEAx+/537B0xV3+Mz1V1qKwU37btEhh2hzBimI8eJaQWIE62i9oM3iQVC8vP8e5XI4ZndHg0MxsMyC6a8f77b5Q1m7ZMYpd5lvMmgNyED6dCo9HDJnKU70mat3sskstFhffSwPYloH4LAbwL1Ahuvr0wHfkQqbMT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acdc9ae-97ab-4a33-187d-08d80ed7518c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 13:48:41.9259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eri9epfNICapusUFyS4dw+S2KaQHhFVxPrEQ4SpeKWCC3kRWByOvOyWm3oqSvCYQ3oL9lOHNqCUwNvx220Uvtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6512
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020/06/12 18:14 Mark Brown <broonie@kernel.org> wrote:=20
> On Fri, Jun 12, 2020 at 02:18:32AM +0000, Robin Gong wrote:
> > On 2020/06/11 21: 41 Mark Brown <broonie@kernel.org> wrote:
>=20
> Please look at the formatting of your e-mails - they're really hard to re=
ad.  The
> line length is over 80 columns and there's no breaks between paragraphs.
Sorry for that, seems my outlook format issue, hope it's ok now this time :=
)

>=20
> > > If we were going to do this I don't see why we'd have a flag for
> > > this rather than just doing it unconditionally but...
>=20
> > What do you mean flag here, 'master->flags' or SPI_MASTER_FALLBACK?
> 'master->flags'
> > could let client fallback to PIO finally and spi core clear this flag
> > once this transfer done, so that DMA could be tried again in the next t=
ransfer.
> Client could enable this feature by choosing SPI_MASTER_FALLBACK freely
> without any impact on others.
>=20
> SPI_MASTER_FALLBACK.  If this works why would any driver not enable the
> flag?
Just make sure little impact if it's not good enough and potential issue ma=
y
come out after it's merged into mainline. TBH, I'm not sure if it has taken
care all in spi core. Besides, I don't know if other spi client need this f=
eature.

>=20
> > > ...I don't think this can work sensibly - this is going to try PIO
> > > if there's *any* error.  We might have had some sort of issue during
> > > the transfer for example so have some noise on the bus.  Like I said
> > > on a prior version of this I really
>=20
> > Any error happen in DMA could fallback to PIO , seems a nice to have,
> because it could
> > give chance to run in PIO which is more reliable. But if there is also =
error in
> PIO, thus may loop here, it's better adding limit try times here?
>=20
> An error doesn't mean nothing happened on the bus, an error could for
> example also be something like a FIFO overrun which corrupts data.
Do you mean fallback to PIO may cause FIFO overrun since some latency
involved so that this patch seems not useful as expected?

>=20
> > > think that we need to be figuring out if the DMA controller can
> > > support the transaction before we even map the buffer for it, having
> > > the controller just randomly fail underneath the consumer just does n=
ot
> sound robust.
>=20
> > But dmaengine_prep_slave_sg still may return failure even if anything
> > about DMA is ok before spi transfer start, such as dma description
> > malloc failure. This patch seems could make spi a bit robust...
>=20
> It *could* but only in extreme situations, and again this isn't just hand=
ling
> errors from failure to prepare the hardware but also anything that happen=
s
> after it.
Okay, understood your point. You prefer to some interface provided by dma
engine before dmaengine_prep_slave_sg so that can_dma() can know if
this dma channel is ready indeed. But unfortunately, seems there is no one.=
...

dmaengine_slave_config is the best one I think probably do that, but the
'direction' is deprecated and Vinod may remove it in the future. That's
important for sdma since sdma need to know the load_address of script which
is running on this channel by checking 'direction', then, could know if
the script is ready or not(ram script not ready if sdma firmware not loaded=
, but
rom script should be ready always). But now, as it's 'deprecated', until
dmaengine_prep_* phase sdma could know what's the load_address of script
running on this dma channel and if it's ready or not(firmware loaded or not=
).
commit 107d06441b70 ("dmaengine: imx-sdma: remove dma_slave_config directio=
n usage and leave sdma_event_enable() ")

Hi @Vinod Koul, sorry for pulling you, Could we keep 'direction' in dma_sla=
ve_config?
This's useful for checking if the script used on channel is ready or not in
dmaengine_slave_config phase so that can easily for spi or other drivers de=
cide to
start dma rather than the last dmaengine_prep_* phase where dma buffers hav=
e
been already map in spi core. =20
=20

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2359B171CFE
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbgB0OQy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 09:16:54 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33409 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389591AbgB0OQx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 09:16:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EBE6E2212F;
        Thu, 27 Feb 2020 09:16:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 27 Feb 2020 09:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=dDo2mPnc4MVPpOSIZ2b31LEePnf
        tr129OiRuGtuO86o=; b=qzjyy7JhkK5+QTjj/6NdO3WWEHsrGskBARpt0N91oTN
        Ld+TolnNyj7ZQFeMZKmbOb0wlmq9v8Kl777GWBWlKJpzmwhub8d2X0kkSIjqsE8+
        KinIrzFMT5+WfTyZQXSc7vU7EufZ0D5iaEszhBbfTRsrJQJtzAfIS52a3Y55hFzJ
        euP49i9LbYXCjsGUkvrVuqD7l36sym0NtfhNod5iRuLQO072mS9i6PdyxwDIv7XN
        cr/kZkmiwa0FGt0pJnZNYw3MP+M9u5HlzY3AlSdnZ/Qs9ssbac1N3BZek71EYEZr
        fpmezbB48FJfEp2EiYzgvrqNxW6CDcK41eSvd7p1Zgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dDo2mP
        nc4MVPpOSIZ2b31LEePnftr129OiRuGtuO86o=; b=mucMiCY2ig2kS7eKuh5m46
        SG9NlKDggt9sPp6jG1WZf3mF9BlKaT9EODy0hptaSTPfhwNzVLa0rwbS5KNdsnXL
        TQ6vygPJ5reZLqA3GrtOiTGxqpq0shlt2WssiId+0514dGFVYGQ6seJZfLzYIJag
        sOPI2GCt9OZKo+AahyxKwtVNpDutH6nfZ4YNmfK75g7YVv7/IPK7r7romkDt48sA
        g5jVzauXPpTsUmdT8dKzRdDJCVbwdn+bz1q7CJUxfx0Sc7W7YSPgPBbBeuI2Ag3Z
        in+UeW6j7OWrgt8j7el/jm7WH461o7sjqRh4/cGtWDiEHCDfj8ZN+lCmWayw3RvQ
        ==
X-ME-Sender: <xms:U89XXshUjvDZ76Ze3U4hE1Zxz7fXbfWYnAr6dNo_A5l5FS0VsdFYaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:U89XXjzLy7tvrbbRPviyT3q-BM7RHliOXzH-XMElwu8Yg_sui1Ryvw>
    <xmx:U89XXmQpAOLUtCmOp_DnRY4ZlZtKTSHcjQeADTAf_KYyIWCvlCdjFA>
    <xmx:U89XXhwNNUF9r_ZZ7WtOAsyiNah0ktiex6pZxPIQLEg4KieUvPUa7w>
    <xmx:U89XXhoKDW6mJyXiYWPAxyIvdj-zwpsQ1kYN9S39SUcuWA5iw5d-TQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2823A3060F09;
        Thu, 27 Feb 2020 09:16:51 -0500 (EST)
Date:   Thu, 27 Feb 2020 15:16:49 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: spi-controller: Fix #address-cells for
 slave mode
Message-ID: <20200227141649.ji6js7vhlrltpn6z@gilmour.lan>
References: <20200227130323.15327-1-geert+renesas@glider.be>
 <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
 <CAMuHMdUVW_51dqMK=ziz_JVT3LuXX7vOF3-Ei-aHiiBuSepGpg@mail.gmail.com>
 <20200227135109.l2oal55nwhm5un2c@gilmour.lan>
 <CAMuHMdWYF9RrLdkuK_PxfVqocUMHVKPpjnyc4FR+N69A_htdyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ikzzwflzmxk3qkj"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWYF9RrLdkuK_PxfVqocUMHVKPpjnyc4FR+N69A_htdyQ@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4ikzzwflzmxk3qkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 03:05:56PM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
>
> On Thu, Feb 27, 2020 at 2:51 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > On Thu, Feb 27, 2020 at 02:19:08PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 27, 2020 at 2:09 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> > > > > Currently, the DT bindings for an SPI controller specify that
> > > > > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > > > > controller in master mode only.  When running in SPI slave mode,
> > > > > "#address-cells" should be zero.
> > > > >
> > > > > Fix this making the value of "#address-cells" dependent on the presence
> > > > > of "spi-slave".
> > > > >
> > > > > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > > > > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > > > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > >
> > > > > @@ -52,6 +53,18 @@ properties:
> > > > >      description:
> > > > >        The SPI controller acts as a slave, instead of a master.
> > > > >
> > > > > +if:
> > > > > +  required:
> > > > > +    [ spi-slave ]
> > > >
> > > > Nit: Usually, that notation is when you would do it on the same line,
> > > > if you want to go to a new line, it would make more sense to use -
> > >
> > > Sorry, being a poor yaml-by-example programmer, I don't understand what
> > > you mean.  Which part do you refer to by "that notation"?
> >
> > I meant that usually the [] notation is used over a single line.
> >
> > If you want to have a list over multiple lines, usually you would have
> >
> > required:
> >   - spi-slave
>
> IC. So I can also write:
>
>     if:
>       required: [ spi-slave ]
>     else:
>       ...
>
> which is even shorter ;-)
>
> Both seem to work fine.

The rest of the file uses the multi-line syntax, so I wouldn't do it
for consistency, but yeah, they are equivalent.

Maxime

--4ikzzwflzmxk3qkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlfPUQAKCRDj7w1vZxhR
xY1qAP9+J6ACEBSld2cNlgZ1np5JgE8toqkBz6bP/lxYW++O/gD+PkQQrYz3Ck0E
pEtc4jLlxTZ04DThtUQDRRkGaY5KMgA=
=hUDK
-----END PGP SIGNATURE-----

--4ikzzwflzmxk3qkj--

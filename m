Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9077B172046
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 15:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgB0Olk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 09:41:40 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35199 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731346AbgB0NvM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 08:51:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E488A2151C;
        Thu, 27 Feb 2020 08:51:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Feb 2020 08:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=rL8rHIlj6lYtdHoMyUTKiQK1fsi
        rI3FJ7XLB2RzfOfg=; b=Y0HlIriETGREYCWbtbx+x1ny0rV7S9mwZsEXLTYgFVR
        DMnJ5qEGsXPku+TO4zN3jXnlQQwlH2VDVgK37KykoEk8OFfr1aP0MHPHkKfdbJx0
        13XZSXCHDpt3g7DbueqmFrycl9YzEb6KEg+hEVWLb8pB7IvIq5CLxIGzzRpCUNHY
        CFeK8Wlya5kRwJsQMBc1uWHKVuYzIVviMMlPsj4N7vw8Le657T2SswSFPGcMasLr
        0EWVYVL7gf58djI4VnZpDCXJJiiog4BXlLsrAZVmnLKG3tbMw86cUNEj8t1xZgqu
        Dmeii8yva6k/FR8rMg6VxICNJjDOCVEAI83vT99ubJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rL8rHI
        lj6lYtdHoMyUTKiQK1fsirI3FJ7XLB2RzfOfg=; b=4GjoEiDvxJLKHUmxewbgdu
        +tWEZlXIrhrkI8/6VlDYm/BJsNQJClhF/mzBgDIjfiaCNVhJU5u1UHKTiBXFG29N
        0LS9dAxWfs832VtY/Vj93tWH7NDoOvnsAAE1SNIB1vk7dZ5EBEe8DYmGxcx7mt0z
        JB0q7HQUsdM61Uk34wJ68w5baqa/jYLRqm5q6xKrErZrQcb0w0Eq09raLHv6piPq
        H0B3CkjxB0UCOrgvjSQ4R/zjAVvvtzXcobp7az3bwg+QFPj7tef4LKZvDxwt+qTG
        xmzM/RU776O9ImVZ4nn9XSowaqcR1SKO+83VIk24Qz41Y/aeBucACTenLQO5C83A
        ==
X-ME-Sender: <xms:T8lXXu7n46_bKu6hKPfae_p-AeLw5MYi787npJ1Tjsb26n9kDgX_KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:T8lXXs1JXuekKaGJawcJ2ILVVO9LyA67CA5B8_Rb2lAElszJ2LOhcA>
    <xmx:T8lXXhvK74mld0NPu5rLUU19hZ4cyebrz19KU5_A_TUG6udwK2qlzQ>
    <xmx:T8lXXq4FM_cnLW_eDruin4UqkmcALc3FQRGlUqsoZ3zRdE5LaX7vqQ>
    <xmx:T8lXXrb8rWKD5_U6eJ7MxnObjhEWQ_XWLNV070QGGyru43ebyqK_Yg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E6263280059;
        Thu, 27 Feb 2020 08:51:11 -0500 (EST)
Date:   Thu, 27 Feb 2020 14:51:09 +0100
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
Message-ID: <20200227135109.l2oal55nwhm5un2c@gilmour.lan>
References: <20200227130323.15327-1-geert+renesas@glider.be>
 <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
 <CAMuHMdUVW_51dqMK=ziz_JVT3LuXX7vOF3-Ei-aHiiBuSepGpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6z2joa2jqig3ppp"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVW_51dqMK=ziz_JVT3LuXX7vOF3-Ei-aHiiBuSepGpg@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--z6z2joa2jqig3ppp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 02:19:08PM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
>
> On Thu, Feb 27, 2020 at 2:09 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> > > Currently, the DT bindings for an SPI controller specify that
> > > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > > controller in master mode only.  When running in SPI slave mode,
> > > "#address-cells" should be zero.
> > >
> > > Fix this making the value of "#address-cells" dependent on the presence
> > > of "spi-slave".
> > >
> > > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
>
> > > @@ -52,6 +53,18 @@ properties:
> > >      description:
> > >        The SPI controller acts as a slave, instead of a master.
> > >
> > > +if:
> > > +  required:
> > > +    [ spi-slave ]
> >
> > Nit: Usually, that notation is when you would do it on the same line,
> > if you want to go to a new line, it would make more sense to use -
>
> Sorry, being a poor yaml-by-example programmer, I don't understand what
> you mean.  Which part do you refer to by "that notation"?

I meant that usually the [] notation is used over a single line.

If you want to have a list over multiple lines, usually you would have

required:
  - spi-slave

Maxime

--z6z2joa2jqig3ppp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlfJTQAKCRDj7w1vZxhR
xSoKAQCMi6BKOxFBB0uhTTAvap1MsvS6SQ4ndibeVqk1uZYQrAD/So9dwDrZrPz1
Tqt3wtZE3K5zNiD+3QvSqGsynf+04AM=
=64J/
-----END PGP SIGNATURE-----

--z6z2joa2jqig3ppp--

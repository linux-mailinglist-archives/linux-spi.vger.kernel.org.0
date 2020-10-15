Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166BB28F2B5
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgJOMxn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 08:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgJOMxn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 08:53:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13AC322251;
        Thu, 15 Oct 2020 12:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602766422;
        bh=GDVHgmMpfMPcT+9pmRkS7VbHuJ1m07eLYVcPINmJ95w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mmrSKLUjuN4RzHQGmhLeJ+1Ky6GCFw2PwXv9CNB87qCVqVN8B3nKB/4VHgepINurT
         DuW7Xa/rHKGC2YPwetSLrrDlhDt+RRk0GMxNYZ7d6ATGkdNfmAUEalm3QWNS50XQOK
         tqwH05KCnXGgR8VoY0pODWTFIUmjK7YE5BZNrr/g=
Date:   Thu, 15 Oct 2020 13:53:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201015125335.GB4390@sirena.org.uk>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de>
 <20201014194035.ukduovokggu37uba@skbuf>
 <20201014202505.GF4580@sirena.org.uk>
 <20201015053829.GA2461@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20201015053829.GA2461@wunner.de>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2020 at 07:38:29AM +0200, Lukas Wunner wrote:
> On Wed, Oct 14, 2020 at 09:25:05PM +0100, Mark Brown wrote:

> > Right, the proposed patch is yet another way to fix the issue - it all
> > comes back to the fact that you shouldn't be using the driver data after
> > unregistering if it was allocated as part of allocating the controller.
> > This framework feature is unfortunately quite error prone.

> How about holding a ref on the controller as long as the SPI driver
> is bound to the controller's parent device?  See below for a patch,
> compile-tested only for lack of an SPI-equipped machine.

> Makes sense or dumb idea?

> If this approach is deemed to be a case of "midlayer fallacy",
> we could alternatively do this in a library function which drivers
> opt-in to.  Or, given that the majority of drivers seems to be affected,
> make it the default and allow drivers to opt-out.

...

> +	spi_controller_get(ctlr);
> +	ret = devm_add_action(dev, __spi_controller_put, ctlr);
> +	if (ret) {
> +		kfree(ctlr);

This feels a bit icky - we're masking a standard use after free bug that
affects devm in general, not just this instance, and so while it will
work it doesn't feel great.  If we did do this it'd need more comments
and should probably be conditional on using the feature.  TBH I'm just
thinking it's better to just remove the feature, it's clearly error
prone and pretty redundant with devm.  I'm not sure any memory savings
it's delivering are worth the sharp edges.

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+IRk4ACgkQJNaLcl1U
h9D8QQf/TpXeQ79oDF5WHvAUgXm2y2SdAHjJgXmtuWpLLFnFmDTpWfOK13TbPVfF
wGKi0mOMC0TShj9mkt4Aw0HPuBd5x0rWc842Up4Q+lJSZhIvcS5Ocgg+7NhiiwuX
du/YBUoiVfzN6L3PMRBvREBEtuMgkPHzjOBicBF9KysBHw2UtzMrP7Kq8Gqlqg8R
TwzAW9KqH9662Cfv5BtXYWfW8drN6VJLBopyxKew7h7JF7AXm/qQI9WsXB+FREnm
MkKzVskCrclETO6RtBYpBVmttrWEWr8efrKB+JT/TiexGF/yW66zRZAKlFRGCq6p
BkN5CEc3XmzVnGOOEoasjUeKBP1J+g==
=vYfE
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

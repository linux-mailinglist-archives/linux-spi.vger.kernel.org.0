Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C34331084
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 15:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCHOM2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 09:12:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231307AbhCHOMM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Mar 2021 09:12:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C6E650F2;
        Mon,  8 Mar 2021 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615212732;
        bh=TpYHSv5nK8/7K9g1DZ6mZmGpQI/dDZxeoiKf7FDZj7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1Trenm8s5+P7MTFrWH3/PL8Ph7ExbOVf3gDt+TPUTnRzOVI1S008+zqRfwmUuu9L
         zKKVz67Bjgmuf+6vyZr9K/7hIjO2ZtcCeB6vMAtS/g2zzPa5S7mRjaLNpMb+XTUA2X
         UYCpckQ4JJG7vnCoOAJbHqqYq4GBu0MzzKf5Nym/+T7w7k8EzLRhpLANDETtHbD3kZ
         qvp5i8eVegFI+ybyq19MCPIjij0lOXDVsKZT36xeO45Ws8N90SIo+ztYlAbbE3ZQhG
         nKkBffD41siP/MlC7FZoRr13Y/kGIrOh0K7M34uSVBP0AFWUZv0Lleb/Angctd3dsV
         /YKN+oQvIHfjw==
Date:   Mon, 8 Mar 2021 14:11:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210308141101.GC4656@sirena.org.uk>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk>
 <20210307144313.GA15472@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20210307144313.GA15472@wunner.de>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 07, 2021 at 03:43:13PM +0100, Lukas Wunner wrote:
> On Mon, Mar 01, 2021 at 01:54:05PM +0000, Mark Brown wrote:
> > On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:

> > > +	ret = devm_request_irq(dev, hs->irq, hisi_spi_irq, IRQF_SHARED,
> > > +				dev_name(dev), master);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to get IRQ=%d, ret=%d\n", hs->irq, ret);
> > > +		return ret;
> > > +	}

> > This will free the IRQ *after* the controller is unregistered, it's
> > better to manually free the interrupt

> Transfers may still be ongoing until spi_unregister_controller() returns.
> (It's called from devres_release_all() in this case.)  Since the IRQ is
> presumably necessary to handle those transfers, freeing the IRQ after
> unregistering is actually correct.  So the code looks fine in principle.

Well, it should just time out which is annoying.

> However, because the IRQ is requested with IRQF_SHARED, the handler may
> be invoked at any time, even after the controller has been unregistered.
> It is therefore necessary to quiesce the SPI controller's interrupt on
> unregistering and it is also necessary to check in the IRQ handler whether
> an interrupt is actually pending (and bail out if not).

It's also important and even more of a concern that even if there is a
valid interrupt the handler doesn't try to use structures that might
have been deallocated before the handler uses it as this controller
does, that will segfault which is more serious.

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBGMHUACgkQJNaLcl1U
h9BKWgf8DT5qM2k5+JsYrmuVeoJbBijnMoT4P90g3dkSSHrfP6+VQdlSTvmLGrRH
rtIcIfzuuTKYhJGFapWgE71ZPoIW+G12ZKe0ao0hV6Tbvv92ClaYWV7CEYO0i0o6
PTbpfjmpuEHh1Ld3gXeGbia0Jz/feLq9WCzuGUcRmkj7Nr48grJe1uwoLrAcJ22V
KVpOTY6hs0cL14wHFtUOdYaC+0nybDc+chRwLxRBja+xoqQhj8V+1MZFoBU91OOH
NmpOPzbaWJmEz4EBNODbxJbO0WaOpew6r313yaPJeEZLpsAqmkRTAxlnsrpqdxwO
CSEry5OhUluavwdcMjGHR6U/ZH9tdQ==
=iimQ
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--

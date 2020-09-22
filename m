Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB62740B8
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIVLXf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 07:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgIVLXe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 07:23:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EB1238A1;
        Tue, 22 Sep 2020 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600773814;
        bh=ARItKB/jx518shbzz7yox5coMjXxlB1rVsnaXlMr7v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMhrdBbVQD9pfqoT8E0/g0b8Ie0PQ6UErTZ4VKjX+V0vw5KHYq0b4VWDhVM3PkOmg
         Ijp8zHaF13kMflpxhAyNBDLg4Me8IW4I0I0By4YpnOnLbVg4poI/Lgn+UkPzgOn53Z
         oc413K3WWnGobtJabG3x5YAFVTXtiJTbrG0QQaCM=
Date:   Tue, 22 Sep 2020 12:22:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org
Subject: Re: users of spi_unregister_controller() broken?
Message-ID: <20200922112241.GO4792@sirena.org.uk>
References: <20200921110805.GI21278@pengutronix.de>
 <20200921120029.GA4792@sirena.org.uk>
 <20200922100715.yxu55etwq64pry4n@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bJ3jXuwtxrXxD2iT"
Content-Disposition: inline
In-Reply-To: <20200922100715.yxu55etwq64pry4n@skbuf>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bJ3jXuwtxrXxD2iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 01:07:15PM +0300, Vladimir Oltean wrote:

> Does it help if you call spi_controller_get(dspi->ctlr) at the beginning
> of dspi_remove, and spi_controller_put(dspi->ctlr) at the end of it?

That'd be another way to do it but TBH it feels pretty contorted.  Just
allocating separate driver data seems a lot less trouble, or taking
copies of fields that are needed to clean up before freeing the
controller.

--bJ3jXuwtxrXxD2iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9p3oAACgkQJNaLcl1U
h9A34Qf+NNBywQt0uXJFW62Rg9tcD44OqnMhZnta4cVouQMuK96v6EIZ3bqlyOcq
YmpzVMrHG4HAHvdRMgji2xA4OgFYHdvA32vQbNvtZjuttJ0z4IxSlkmTB6fV8Cyz
86/DXZh7Gq7m3A3E26/H+RzhF68ZhV+yHLBRtvUqsK4SQgUkeNp+ETHV4g5T4rUz
Vwh1WqBYGhDxxIQT9dA13Kq8xRSSGN91Pk35/lgmwtQYNYpHM42+7RSHNMn3H2H5
W5nQXJZeq2xSShLM2tarNJN2urxvIvZyTVYEdZaYzYH4UXnP3UE/yyFtINJNJP5v
LvjdlklQ1WF/T5xeQA0n0OwkrbN0WQ==
=UkzY
-----END PGP SIGNATURE-----

--bJ3jXuwtxrXxD2iT--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97107216C84
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGMIR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 08:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgGGMIR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 7 Jul 2020 08:08:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96812206F6;
        Tue,  7 Jul 2020 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594123697;
        bh=XhUGgZi7navlJCLWgGMz/XjSfHJuz5CPo+3UciovSag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuNUIn+K3SQH8i5HdQyx7cycZjoqqhU024jJ/sk+4O5w57LuC87QdpYVxbfE2E6qA
         QZHpaYOJlQ7MWzFGdgJqcyux18cFE9A7epBU2c1k+TWMy6+td1ggprYH+uVgQFGqIy
         m/SrSAQSfh/kn4NJ3tww8dRfXG+in3mqDlvWGn4c=
Date:   Tue, 7 Jul 2020 13:08:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        mkshah@codeaurora.org, swboyd@chromium.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
Message-ID: <20200707120812.GA22129@sirena.org.uk>
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
X-Cookie: Will stain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2020 at 05:45:07PM -0700, Douglas Anderson wrote:
> Every SPI transfer could have a different clock rate.  The
> spi-geni-qcom controller code to deal with this was never very well
> optimized and has always had a lot of code plus some calls into the

This doesn't apply against current code, please check and resend.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8EZasACgkQJNaLcl1U
h9B7xwf/cKBIWXIVZ7cgKhUTJ72jK/0YZXW8VirUPNemWNCqngPLthyNfEf+33CC
IHqGoYhy1Ya6ZSVa1q9U04w7LNrbOB/VlafagzTETNWKL9nDl9vTtVZ4RohypJ6H
LAgu83k42Bj6IWqb03bNq6tk+Rm6YNfcOKr1dCNI6eqy7xwCUhdVTIFVx8U+4ueK
EQc36sJNVdn21yrhDDr5Xbv+Xrf/IqXKWNbd44B5ibuAsvqM0hyUhtBDmGm3L5xf
qyBkgN0dtRq7GsCIt4osSyFbM+lejB1wqbDdj41xTw2wm6TpX1/7WRXEZTR8Tuqp
REkgStRcA7qB8zipvOXgAoO6jes6ug==
=8FuU
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

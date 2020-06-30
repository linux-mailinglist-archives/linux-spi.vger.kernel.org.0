Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5589320F36F
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jun 2020 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbgF3LLk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Jun 2020 07:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgF3LLk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 30 Jun 2020 07:11:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D3720663;
        Tue, 30 Jun 2020 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593515500;
        bh=zmldPMDKQh2PN35Sf8qleUdJiiaUFT01iAnkn7OifRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8vo2LQZHqQeWnQbXqHnEa0398EhX0YldJVQRmTq+P7VTbUb9g6PJOSA4jDPjmqGm
         avmK7zlPBQfE6iqQlOqjOeYIE0sZKWpnANPpajyivzwMJ+y8CsnoXwBS0RvY7zyUCw
         Bg9ddKyTUZlWp84nAH/PFIVyX2YPenARjfx19C2g=
Date:   Tue, 30 Jun 2020 12:11:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daisuke Yamane <yamane07ynct@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: a3700: fix hang caused by
 a3700_spi_transfer_one_fifo()
Message-ID: <20200630111137.GI5272@sirena.org.uk>
References: <20200629174421.25784-1-yamane07ynct@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <20200629174421.25784-1-yamane07ynct@gmail.com>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2020 at 02:44:21AM +0900, Daisuke Yamane wrote:
> transfer_one() must call spi_finalize_current_transfer() before
> returning to inform current transfer has finished. Otherwise spi driver
> doesn't issue next transfer, and hang.

To be clear it can also return a positive value and then finalize later,
there's no need to finalize before returning (otherwise finalizing would
be a bit redundant) and if the driver doesn't return a positive value
there should be no need to finalize at all.

> However a3700_spi_transfer_one_fifo() doesn't call it if waiting for
> "wfifo empty" or "xfer ready" has timed out.
> Thus, this patch corrects error handling of them.

The core shouldn't be waiting at all if the driver returned an error, we
only wait if the return value was positive.  Looking at the code it's
not clear to me how we manage to end up waiting - it looks like the
driver passes back the error correctly and the core looks like it does
the right thing.  Have you seen hangs in operation?

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77HekACgkQJNaLcl1U
h9C9GAf7BOBbQ8W6d1EZQomRhHlyv6OdI7j5yinGfEYnzGfYBeYZi7/648GrllxA
xosv4KzNVIP5c/Tpy+OHu3wGML47/HJ/yItVfti9LKfmu6AlyFVBtrUBKeCoNiGP
n+SwkgByb2sR7gMI4SaAraTKcMRw4MpLBuaStyPk65AMldb3zcX/vta74iVJGfIM
A3uOOJr2mRASOwG1eQElSY/p2Z/wmqHk0JjKbs5+7OM+kum9ptLlncc3y6uc+f5V
bQX68vwEO7ao4Q8JrCEy8bVu06Ahyv1Rr/ZR6Xxpux5x/84A+O2ygZIfz3GN+/SN
2VkGNB6PgfiflrpI6ONvvnfpJ73WNg==
=xwt9
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--

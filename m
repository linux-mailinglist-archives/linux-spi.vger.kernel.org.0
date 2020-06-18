Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB121FF65F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jun 2020 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgFRPPr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 11:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRPPn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 11:15:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8E6206F7;
        Thu, 18 Jun 2020 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592493343;
        bh=OtEMXKIbYfiMajFJJ9GfH0wz9lo2cLUIGUNmkke2Bgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NffDdFvZnHR5CP/UhgpzK8VlGPWmPWdOYfrsJLPDmxJEzxn06fo1OupBF04msNFAT
         Oo1S0Rey0WnSdOzbNnJb8YpbhXUdm81PtBwdPsgZ/WWD1loeJkJmMjyRqq9Iz7SGs7
         2AXBQM7FDxP9tw/8d1TlRoDXsSX5Yt3AMjuY2Sq0=
Date:   Thu, 18 Jun 2020 16:15:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     swboyd@chromium.org, Alok Chauhan <alokc@codeaurora.org>,
        skakit@codeaurora.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 1/5] spi: spi-geni-qcom: No need for irqsave variant
 of spinlock calls
Message-ID: <20200618151540.GL5789@sirena.org.uk>
References: <20200618150626.237027-1-dianders@chromium.org>
 <20200618080459.v4.1.Ic50cccdf27d42420a63485082f8b5bf86ed1a2b6@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z9sQuz+HmDh2hVO4"
Content-Disposition: inline
In-Reply-To: <20200618080459.v4.1.Ic50cccdf27d42420a63485082f8b5bf86ed1a2b6@changeid>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--z9sQuz+HmDh2hVO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 08:06:22AM -0700, Douglas Anderson wrote:
> The driver locks its locks in two places.
>=20
> In the first usage of the lock the function doing the locking already
> has a sleeping call and thus we know we can't be called from interrupt
> context.  That means we can use the "spin_lock_irq" variant of the
> function.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--z9sQuz+HmDh2hVO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rhRwACgkQJNaLcl1U
h9APzgf/VJoyNmJCoE/DF9WSzCtICt9DfHIZDE3SmkAD1NVeab83t23C8ryMJGnZ
0bBf5ZxYJkc0COQSCu3WtBUTTzttHCvrg9XbdogG9EaDhJy+D4do1LwgSKegyR5o
Wl/UW8hDGrZ8dTRwpe5JatiEhXvCqQwfpyK3j0I7v8J9BG8aix+stZogRryb/fVa
Dek1aYxAE9IFtKe9KREaih9FiqNiSLNU+XrI7gV3FZRvpH7LafJ7Zok4JSIf71KU
IedwPcxmqkLacJ+MkXDZ5uEaRqfXjAVOfq8tfTduJ/+BWNV43puEjVWCttFI69F1
rfTESrTGfoDqUQEvRy9IvxFo7hZyFQ==
=7ipB
-----END PGP SIGNATURE-----

--z9sQuz+HmDh2hVO4--

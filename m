Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A841D9C0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350096AbhI3M1r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 08:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349808AbhI3M1q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 08:27:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3C416136A;
        Thu, 30 Sep 2021 12:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633004764;
        bh=XMzKJ6yQ8GbX+H2Mwz1aDa/jAtUE4SY9wpVtxJIyZlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3Eo3qkzu0Ybzjop5jdJIvAJCw2rR6kSVz8ydyU8+d6/AEFcKt82yCpmZhMWNMR18
         txTbK4AznXgsFdNvNU0XcKXpkzaPCV501bHudxqlqlHxnUOc7CBRj2dzhgheCvT+fl
         pTt101pLo8mKIts0d4zrPrk8olXVr9L6P4Z03+innWuMTSJYV4e1BJYP1ta75ED0zA
         ICYLj7QThUpt2UrNmRtkLk3p8ZAJajM2AXKObOUV2mAzAI9E3gTWvf9HB1sfd73V/n
         jdyp9LEQjJ7vsZL+ypBhXs1rvyp9Aw5lZ2QwHs6cQi0KAOScLV/dY/Tvkcax6rRBM1
         rWw0XSyQRzYeg==
Date:   Thu, 30 Sep 2021 13:25:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     kernel@collabora.com, linux-spi@vger.kernel.org,
        enric.balletbo@collabora.com, dafna3@gmail.com,
        Mason Zhang <Mason.Zhang@mediatek.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] Revert "spi: modify set_cs_timing parameter"
Message-ID: <20210930122513.GX4199@sirena.org.uk>
References: <20210930120700.2564-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Content-Disposition: inline
In-Reply-To: <20210930120700.2564-1-dafna.hirschfeld@collabora.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 30, 2021 at 02:07:00PM +0200, Dafna Hirschfeld wrote:
> This reverts commit 04e6bb0d6bb127bac929fb35edd2dd01613c9520.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> This revert the commit 'spi: modify set_cs_timing parameter'
> and its following commit
> 'spi: mediatek: fix build warnning in set cs timing'.

Which is not what the commit message nor the paste of the full hash
claimed :/

> Those commits cause regression on mt8173 elm device. The EC either is not
> able to register or it sends numerous amount of errors:

> cros-ec-i2c-tunnel 1100a000.spi:ec@0:i2c-tunnel0: Error transferring EC i2c message -71
> cros-ec-spi spi0.0: EC failed to respond in time.

Do we have any analysis as to why?  Do these devices use timing
parameters in some way for example, or do the values written out to the
device change in some way?

You've provided no analysis here so it's hard to tell if this is just
some random change that happens to change code generation slighly or if
there's some actual reason why this might fix something.  I'll note that
as far as I can see there are no users of this API upstream so I'm
guessing that you've got some out of tree consumer driver which uses the
API, it's possible that there was some error in updating that driver to
the new interface which is causing the issue.

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFVrKkACgkQJNaLcl1U
h9BQ+wf+L0v6eP7/ZC1yGM364eVeDsmC7RZB1iQ+4emAZbeaTiv7ISlnwpWSYO9z
80HsRI6OyRoEZK23fudRrN0dV/GhiBunllTihW9w2oh/TB2mKP8Ilq7pF9ziL1Uk
Wa0mXzMwdZ6KA4dX24Szlnogkwoep61uPNcjvglsxfQMdr5o210AEHt3QqVZz3gU
dRi/chCDiy0GhmqlC7Ajcvb2Xx7aBoFYTZZR4ZGZj+htIo+bbwuoFCEqOGtoqxSf
d/OCbLOzvu+/zvXNnoFKMinCTPcpRYx6WZW8nDM5SeJLTsQ9wpaMTHxMeRFVnY7W
gLT1N00BcSOUIEGzUOwpMGbGMFFpJA==
=RhSa
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--

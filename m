Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589ED34D3B2
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhC2PW2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 11:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231311AbhC2PWI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Mar 2021 11:22:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09F4761932;
        Mon, 29 Mar 2021 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617031328;
        bh=U1QKt8LwW8EbeWyQ4N/1qjJ6Qregzez8iT9mxYfr/QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OlF+ZdbZjZYrRfjmb1tgweLF8vhHW+dsq+pNdLPtJviPcZTcQAINoGpCiyEltW+b4
         n6HKLeB66KDoaYamphkgDPxfDTY40rrxIShOdK+sxNLhax0Dd/0lIzRj7bYWzQiIrp
         5FOTp5JDpsFaXVwm7fuw72q64ys/Sc4rT4r4naarbMOMkR3kFGuP9aHOcEMNPx+59m
         eJSOhWsgK2cVEchSYZCDZGSvDoEatagOiqZqZeeMIoCV8Y2t0ha1ZyTUfDyj3fGs02
         a2vOvxH+lKUjabWN3gAkL96OiYvAuiunw+68ufwfIYiVCli8ejYICtRslQivlvIJ/6
         fy9M82tRhJ2Xg==
Date:   Mon, 29 Mar 2021 16:21:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: davinci: Use of_device_get_match_data() helper
Message-ID: <20210329152157.GB5166@sirena.org.uk>
References: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <1617008316-60426-1-git-send-email-tiantao6@hisilicon.com>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 04:58:36PM +0800, Tian Tao wrote:

> +	spi_data = (struct davinci_spi_of_data *)
> +			of_device_get_match_data(&pdev->dev);
> +	if (!spi_data)

If we need to cast away from void * that's most likely pointing at a
bug.

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBh8JUACgkQJNaLcl1U
h9B+iAf/YidDGdnSkhUJCRbGuMGEoivPRXDJ44kkq9avcMqswv5O14W/ZaEPpaqU
T7dC0MCL1qwm4YE1ar2EzEUX6DG2/iVKlF2zczAZEZrYT8fRpC7HjqkcaL0l/ABl
sStS7xYWNqTMR1nT0tkcyQNWyetQJDMXu3+yegWhhBvaIwYpKa7nHQo9+POAbbeU
IDfb1jrMuVIQJX56k2FjDRXq9l1jH7h12cbYyBONpTxlxewiIwgXHDRAw93ZFC8w
qGRxHZuqPMDSt6PByKZaVcAQ/kV385NJI9IPCh56Aw6RWrAK8yUdtHvLKwqJ+z7P
jWaTLqzFlyPQ7seo3BYBgjG3bUmOJQ==
=MifY
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--

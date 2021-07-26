Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5A43D511F
	for <lists+linux-spi@lfdr.de>; Mon, 26 Jul 2021 03:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhGZBFs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 25 Jul 2021 21:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhGZBFs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 25 Jul 2021 21:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3FFC606A5;
        Mon, 26 Jul 2021 01:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627263976;
        bh=a+SMCLQBpjXHMSlRlAC01wFsW07UnLLea7FcOBYtqLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzODPsO+w30uqXtu/f64UODsgJtrMWXRWHENSuqG/b+kk1ykc6HoZDrg1E/9+Z4lX
         UfNrzRgGLTBQjQy+x1FZFYpztKO6Y1nigKlS0DDhVvy+idlvnP+bLi2T/+5OJ2Rpdm
         i268yTD+OhsjnhpL3/Dyg4gvBJOiBdIQRx+3MIl/ON83MgMlDRyUY6YfHDRBo9a9pp
         ZD/MKlDQTzTG+1DZS0aBeMl+FRebBLBhIr3DzngzKnj4EGjktJe5ERVCj3Mvf3iOuP
         Te28JGnXL1KxSED2E+HZ+tYg2AhLcyNRJTo+MoYUur/QYwkpYnb0Fs0lMSgnKU93QF
         9CXQD+iBtesLQ==
Date:   Mon, 26 Jul 2021 02:46:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay
 calculation
Message-ID: <20210726014606.GB4670@sirena.org.uk>
References: <20210718211143.143557-1-marex@denx.de>
 <20210719082015.ud43iwg5rfdomlqi@pengutronix.de>
 <17bf62a4-af57-1706-f20a-35f9d6cbf9d0@denx.de>
 <20210719211221.GA35544@sirena.org.uk>
 <37b0f7eb-39fd-9e15-20e3-becfcfd4b5f4@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <37b0f7eb-39fd-9e15-20e3-becfcfd4b5f4@denx.de>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 21, 2021 at 10:18:35PM +0200, Marek Vasut wrote:

> So, should I send a V2 here with any changes or is this one OK as-is ?

It wasn't clear that Uwe was OK with the current version, I don't mind.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD+E90ACgkQJNaLcl1U
h9DBNQf/WiTPeXzTsOPWCqFXAGYLEBBfyMAINnMB3xkFL7Hs6D3xq7BtTA45gYOw
l/qvQNrtE9sdoo9y5yQRyjkLnIpxL9j/r8RdL5E8mWnlFROQZ2ZmNYfcefWl1uVj
QBmrAi2xxqsnIO6ghBgyUSe4TUB8d84MLASxigU9DLHtgkTiolXmXyeTzKvOHJWz
omzdm0/4wTVGcmPa7KM8m7bQGBQB2wsa8jQ6dnRqQHH/7BWrwxpLnKkuFyyxUJfI
EYtLwX0j1QS58pXZaNXq9gX5Qk02wo9dnlR9Y0klECDXHWYKjnvZTBOEnebTU3tF
YRm2Y+wjmkJcQ9CLcRqy3OvytUALXw==
=Zhxj
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

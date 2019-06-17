Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13948132
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 13:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfFQLqj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 07:46:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52018 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQLqj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 07:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P56W8WG1LJmb7fOwTSDtgro2Mcc7zg15Qd9jbIlj9TI=; b=U1yKUUWh5F+z7SKpbGtrd5kfm
        3II2f3MKgfjahvIugZeLe/83jBpGPXfcP6dejCML+lI/TufK02kB3dFGAa7eWqUGnYSnrPdvoV4bE
        vr29HS3N0zWYaYmNBu+Sb9gE2dcYzUK7LG1br0NICp6fLELB7EE7J9/7KZsSjVMi+nv2k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcq5n-0001W4-7q; Mon, 17 Jun 2019 11:46:31 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id AF8AE440046; Mon, 17 Jun 2019 12:46:30 +0100 (BST)
Date:   Mon, 17 Jun 2019 12:46:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-spi@vger.kernel.org,
        Jaswinder Singh <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] spi: Kconfig: spi-synquacer: Added ARM and ARM64
 dependence
Message-ID: <20190617114630.GO5316@sirena.org.uk>
References: <20190617060957.16171-1-masahisa.kojima@linaro.org>
 <20190617101741.GK5316@sirena.org.uk>
 <CAKv+Gu-DYzRRG82t27nFZKeLOPzCYphY=AQCQy78=m591rXs_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6kWzDLe2BYLyVXGp"
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-DYzRRG82t27nFZKeLOPzCYphY=AQCQy78=m591rXs_A@mail.gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6kWzDLe2BYLyVXGp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 12:21:47PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Jun 2019 at 12:17, Mark Brown <broonie@kernel.org> wrote:

> > Are you sure it's those functions (which only appear to be defined on
> > arc according to a quick grep) and are you sure that there's no other
> > Kconfig symbol specifically for those being defined which can be used
> > rather than depending on specific architectures?

> I'm not sure I see the point of this. Building this driver for alpha
> and parisc has no use in practice, and does not provide any additional
> build coverage given that the driver can be enabled on any ARMA/ARM64
> build.

It's helpful for compile test coverage, which in turn is useful for
people doing subsystem or kernel wide changes.  A dependency on ARM64 ||
COMPILE_TEST would make sense but wouldn't stop things getting built on
the older archtiectures so you'd still want some dependency for that.

> > > This patch also specifies the default compile type as module.

> > This should be a separate patch and we don't generally change the
> > default unless there's a reason to do so.'

> That was my suggestion - just 'default m' is generally not accepted,
> but 'default m' for a driver if you enabled the ARCH_xxxx in question
> is reasonable, no?

No, there's no special treatment for arch specific drivers here.

--6kWzDLe2BYLyVXGp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HfZUACgkQJNaLcl1U
h9CIxQf7BV7k5l9LfH7EzLo36SMJIWo1dPwSoLcBO5m3ZxpMQ7zguQDThcDve5AL
bQz4FWZkWtTHSiWypvlcDelaKW3j33HuEZyPWj3MbWSMYCzGYkw0+WFlHaT9VXX2
30S8xqAeYIKR48izSuoypowW+c9puqyRsHPA1P+nIj+BfM8IYeZNesRnqfHLmTQY
uvmETlPtjzCr61BgEmExghQdZojCIIa/EUyzMttbz0sVs94G3K42g9DonJiJ9khL
uCV62pyxdrri5OExtE6XxVYhjimHXDmoWN0zMFAEEhNvC/hhw20JTMkqET8MagfI
611dL+qp3XOm301IsCPNR/yBH1iFVQ==
=INCS
-----END PGP SIGNATURE-----

--6kWzDLe2BYLyVXGp--

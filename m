Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A983752FE
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhEFL0A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 07:26:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhEFLZ7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 6 May 2021 07:25:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1439613B5;
        Thu,  6 May 2021 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620300301;
        bh=WNbzA80MuzdJoAITZX3G6o/nza/4npWj18RxnNZuuoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiYD9XPg+1lMybmIqx9xhPE24UUNf6saZLA95yMeYeV5FOrYN2IbxE2iAq5csnFGF
         TwrRQoMIQIm/OMkLMsoi/Z6Acuq1hG4XrFnhnwglnd6HaYy3sRGvpPdmYYkJ32aOEC
         XDkd0n6t1vlNAGIqiInWedp3N3oQPVw67VKJT6/8aDQSKrt/iznj3u5jOtKaaCONxA
         1fCKlhV3hspkAWcOClbSrsV8t3rDXm7BNTi6odf5RnZ9OiAlTCM7dZJx3EYjXnvVvi
         shkJW2hUNPjDGZGifa/bD3ajcO3zphWJPDLPHk+z6MNvnCRrlENE/g8uO78cjK9GSL
         GlRLVX4jN6UKA==
Date:   Thu, 6 May 2021 12:24:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>,
        "tangzihao1@hisilicon.com" <tangzihao1@hisilicon.com>
Subject: Re: [PATCH 0/2] spi: Correct CS GPIOs polarity when using GPIO
 descriptors
Message-ID: <20210506112424.GA4642@sirena.org.uk>
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
 <CAHp75Vfr8t9UVqVn6hLSN6Mi3=iNAn612eE-qKq9HfrwNhpg3Q@mail.gmail.com>
 <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com>
 <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com>
 <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
 <CACRpkdYR99SRgDJEK6e-eT86hBOxz-Ym5pf8Zn+0k4u+i=nfOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <CACRpkdYR99SRgDJEK6e-eT86hBOxz-Ym5pf8Zn+0k4u+i=nfOA@mail.gmail.com>
X-Cookie: If it ain't baroque, don't phiques it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 06, 2021 at 01:06:23PM +0200, Linus Walleij wrote:

> Interesting that the PXA2xx XScale lives in Merrifield,
> I didn't know. Reminds med of how the Samsung
> hardware is alive and well in the recent Apple M1 laptops.

There's a lot of PXA IP blocks in modern Intel SoCs - half the audio
hardware is PXA derived (though mostly connected via DSP rather than
directly to the CPU).

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCT0egACgkQJNaLcl1U
h9AiZAgAgj/RNVgh0jtIBmUlaRmSGXJCjZ87JoMphf1i0gDlQz/OuLlsGWufFoh1
OCXvB2PN3SuF4Vn8UJH1bAxCo6wPV1qVSdjr2ei2IcnKyMmUtGwa1Xedvr08FO9i
NgSZdLvYONTuXcqG2qWbra30+QwJm1k1sqgfZYRa3JySfohjn3LBflZAnzVQrfvN
IVOB/QJmIBS13qpcFSin8DZE60ZYjrvk6vTrMZNwVOXTfmD7cMLxoNGbWfRmEitL
srCRiJZXA8+wA1+T1U9ZiJ2ndKQN/qEQUCSaf5yO7GPGXT5vMdhIMMVgXUax84iq
T4VW7WX5y16upXDl3zhyixgq7T6cZA==
=2wOc
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

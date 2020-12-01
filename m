Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68D92CA5CE
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgLAOgu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 09:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbgLAOgu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Dec 2020 09:36:50 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB25120758;
        Tue,  1 Dec 2020 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606833369;
        bh=16u1ox3tsf5pplg/GM2lJdtCUI6+E5r4G860TvQ0vWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5ua54a7s62SYM0aytx21BouCVthWiwQjD91Sye5xhgmcHxD6B+UpitioEl2/BfL6
         +iBhTvjySU/ejQU5V693tZlVV1M3g8Z25m8zDvh9PjmldAwxjKiRnO338ogjw/RuhD
         Q4BVGwBGaDOiYpa8fPgo6dQdTiPhPPPFW8hN7fxU=
Date:   Tue, 1 Dec 2020 14:35:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3] spi: fsl-dspi: fix NULL pointer dereference
Message-ID: <20201201143540.GE5239@sirena.org.uk>
References: <20200928085500.28254-1-michael@walle.cc>
 <160683107674.35139.13937083243515034859.b4-ty@kernel.org>
 <c1dd024150ed624a6b42562573851f84@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <c1dd024150ed624a6b42562573851f84@walle.cc>
X-Cookie: Who was that masked man?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 01, 2020 at 03:04:27PM +0100, Michael Walle wrote:

> Is that correct? Some time ago you've already applied that to your spi tree:
> https://lore.kernel.org/linux-spi/160132174502.55568.11234605078950751454.b4-ty@kernel.org/

No, it's a bug in b4.

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/GVLsACgkQJNaLcl1U
h9CP/wf/YySiGAKeGMGddCVsdyZABZAqMZ/lUgzqPP4bXtq2B4qRRgOu3QCGJqaW
tMKd9o0FM58irsM7vZnY8HzfF6sjEG4RaD8ImAlsOQpYxIHT9IeBpE9ewONEr3K8
5LgJYausWJNj7y4dwpWOqkogoB0v24bbOp5Zhgt5uhphxIS91bP3lrLS4a8xhVAE
BW90LxQC7fzmS4RWc2/we+2PLNZu2v1u3ILVAtqdWlayFL+kFWfcrYkQMlRksBLj
jlRoCJP6fUE+G59jJIyBod3OiuUksAoog39UHvhTuoAoLLLYHKHZNojv3yCYUtjv
+LR6gy8tZwIKIUWH2q/Dj5MCdmEksg==
=hpxu
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BC365C10
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhDTPXC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 11:23:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhDTPXB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 11:23:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D4DD61264;
        Tue, 20 Apr 2021 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618932150;
        bh=H+pWNNFTTaoI9wEkXUKPItSym2+vODlCLxHqeCemyvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLpiVPObowSJYMGkMe6EhMr/KmOrIvvAJb+2WxEjgBK/DORSDoJrahc9ix3jmeRmG
         84+e4Y+poGmteK7DO3V24MaStIVvB51YUKRva5rZtvs4iyVoP7AILuKgvnP8PAXuzo
         qDE4Bc+sTUYUtfOw2WsB4q83WWpidMsnB1skXULXyvjMHitVpMzmhhYcNcM+eHZXOO
         QY29L2OBVXuVAZWAIQiEh/LNwcCq+SKjj6altPIvlI6lKn6MHnEsiqj3A64yBRx1r0
         +s0VL+cunMaqVGXZMhRzZh2u0d+ksYwraPGnjcKOcrpIccxl/jXS8x5UOmqtF9QUw1
         N2cajqNyROg4Q==
Date:   Tue, 20 Apr 2021 16:22:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Avoid potential UB when counting unused
 native CSs
Message-ID: <20210420152203.GD6073@sirena.org.uk>
References: <20210420141004.59936-1-andriy.shevchenko@linux.intel.com>
 <20210420141004.59936-2-andriy.shevchenko@linux.intel.com>
 <20210420145616.GC6073@sirena.org.uk>
 <YH7uGhEmnk2sBzVv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <YH7uGhEmnk2sBzVv@smile.fi.intel.com>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 06:07:06PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 03:56:16PM +0100, Mark Brown wrote:
> > On Tue, Apr 20, 2021 at 05:10:04PM +0300, Andy Shevchenko wrote:
> > > ffz(), that has been used to count unused native CSs, might produce UB

> > Bit of an IA there...

> UB -- undefined behaviour.
> I'll decode it. Should I decode CS as well?

CS is fine.

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB+8ZoACgkQJNaLcl1U
h9B1Swf+JtnCmtkQqdQwMJgYZbUE1No6gDgEs3/g1OOvoaKgJVzXml4Z32ic5WdI
VCokMQisQh0zNeOTCI8W2b2vJ1IZ/DrB0ymGLXCZhSNzksRBCqJiAhH4QQHyF+cz
tMdu7JSFwCCzQ8FZV1HmAcp+aEdUdaxKhJBOpYIb0ar7om9xExPYp2ZsU/jmxaYB
e8b/BAiOrbWJ/IDSDy9TJCYKsSDU24z+LqLA1TW+uBbUX1E5UuCnUtPhQshRu0V+
v8PyAUJE/e98SgvM7G0PTM2VrmcHQ92vUzpOrhVQfZ9lScEI73ZCNvxt29LfuB3p
hTX1DbHm4Z9RJ2kpMQbbhnQcCq0mEg==
=L9go
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E925B365EBF
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhDTRoS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 13:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhDTRoS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Apr 2021 13:44:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D42DE613C4;
        Tue, 20 Apr 2021 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618940626;
        bh=O943Qoeocu5JxZwJqLj0exQx5HAHanOJdgZVbNSOI4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPD4ZqxXqz60p6+1W0k1wNRg0ps5RLOc+bbWuygtkoWSh9G4WmXnkhr4WfF1j1TGq
         k7rfy83BeUVVWdRnRRbtSkv/GMeHP3gHeuTmmK9FLvc3ZdOelSlVr8zC6sXB4TfXQF
         CdQLjCk0TIeI3+R7JrETJ4YTRAFIzTgM/EmgxKHxZZyXbxGx43ET1xfJEdEWxlDwWK
         ATovgzUX+xJIzjhbNxTMpQgASX+6QJhrZplso/eWwedWUK8o0eCrXhgaTd5my5x8L0
         s6fCWXLovI+h/fl68oPzX9enRHUD+WhmB/vRUQS5wBt1pYQNOyLYb7nntYgAXsTm8l
         /6BRxJ3r5ZGjA==
Date:   Tue, 20 Apr 2021 18:43:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     David Bauer <mail@david-bauer.net>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] spi: sync up initial chipselect state
Message-ID: <20210420174319.GH6073@sirena.org.uk>
References: <20210416195956.121811-1-mail@david-bauer.net>
 <CAHp75VfStm5OeQc-n_djG7vQcvQGbBYSejtTP=e+9VDpAnDE4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <CAHp75VfStm5OeQc-n_djG7vQcvQGbBYSejtTP=e+9VDpAnDE4g@mail.gmail.com>
X-Cookie: Falling rock.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 20, 2021 at 08:31:25PM +0300, Andy Shevchenko wrote:

> Mark, I guess you need to amend your scripts to check that.

I don't check anything, the scripts that were going around were just
adding lots of noise over meaningless things and causing lots of noise.

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB/ErYACgkQJNaLcl1U
h9CaOwf8COJ7DtCuJipBVJmFh1SZQmlzLvAcwdB8LrYR3cjJ5fqvEKUwGjOo8wpo
K2rgyAgq2VwghezknKzMbymDHVWXxmJQFMQkbiVO9yHr9s7tfe3cXQce67hef/A8
iLtjfZ8PXDCIYX4mRr7loIojyIRvlo08iHVwopqRzFRaJn+Htfb38fC4k6VOcgyR
rns4IYKaiQpuGFSUjhSJg5zCOEdsrkjM209+3YBZb7FXG4zv7JDth33m8aNVxoum
0xQ6mt9lc5Peo4zjM8lorveCRVZa7EBkG/nH8nSXEGDJFJhpLcL9zWCS86KVCPXH
j9mmQJ2qik7qcGF36COFTALUbhxRuA==
=4GnZ
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--

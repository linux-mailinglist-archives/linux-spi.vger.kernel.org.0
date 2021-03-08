Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B502331614
	for <lists+linux-spi@lfdr.de>; Mon,  8 Mar 2021 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCHS37 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Mar 2021 13:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhCHS33 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Mar 2021 13:29:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 440A06518A;
        Mon,  8 Mar 2021 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615228168;
        bh=O/BFA+DuPUyYl6u5+s2APWPgJubeAQL/7zarX5rprDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdNFfWvjShvwDr4RKry2N1MUilw2KZjt9iX9wKBN5YTAVq4SIQRabpFAlU4/7CgIq
         TN6opj4SfTGtZ8LVuakM/vgIPY8bBH7xfNTCYFnVjyNbYEZuRTU0ximNn7f7NcrEgg
         M/BGr3aciJQU56Ph15/vwM9wpwbOSfKPeBlMB6XxSOMPm8u+Jij97IlpI10tfqnTmE
         VJViliPbIuEsYD8kKLBqwq6uyBZR/uiGQiCLmYVyIvN3QZNVbkNsvjlHzJvMQLC5ad
         p8EZUWp5mVPdBgMsftafqqUvtO5Rq8wiALu1phXg829K2WLleoX5VwXKdsQKLiWmKY
         bzpBLOwzBCApA==
Date:   Mon, 8 Mar 2021 18:28:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
Message-ID: <20210308182809.GG4656@sirena.org.uk>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk>
 <20210307144313.GA15472@wunner.de>
 <20210308141101.GC4656@sirena.org.uk>
 <20210308181839.GA6444@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <20210308181839.GA6444@wunner.de>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 08, 2021 at 07:18:39PM +0100, Lukas Wunner wrote:
> On Mon, Mar 08, 2021 at 02:11:01PM +0000, Mark Brown wrote:

> > It's also important and even more of a concern that even if there is a
> > valid interrupt the handler doesn't try to use structures that might
> > have been deallocated before the handler uses it as this controller
> > does, that will segfault which is more serious.

> At least struct spi_controller and struct hisi_spi are allocated with
> devm_*() before the call to devm_request_irq(), hence those two
> are always accessible from the IRQ handler AFAICS.

For stuff like this I'd rather the code were obviously correct rather
than having to think about it, dereferencing the struct is the most
obvious thing but there's also the possibility that we cause something
else to happen which explodes on us, or that someone later modifies the
code in a way that introduces an issue.  It does look safe right now but
the whole implicitly managed asynchronous code thing always makes me
nervous.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBGbLgACgkQJNaLcl1U
h9Ax3Qf9Fzk9bxPKHHoF+6eWyoA6ePfXAjJcf/zaHIfUJ95DKClu2Ojvy8ybTALY
lS0cJwK+7N9P35I85gcIztJh696z61jgc2TUFNxgCX0FeRvy4YEqFkxblKct5MkU
IoRP3yoUGmlBAyoR7BUSNmqhaGn6xmzzCj09efb2wzLUXz8euj32GvQowqYcU3LD
wBbYZ0XZwD1OJgpjXEJju7iiQDN8sLPcASzBDGCFsq5McIeQOFPfIJSWvHk/akCN
f0JzN+JDme12yuAllv0+rwkOpSZMc5Wb7nhEj6RTKhrxjM2OWWklo7lyEYRjTd/O
7QfL7DT+vjqlMUr1OpYp1IPGYo7tYw==
=VBMd
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

Return-Path: <linux-spi+bounces-2962-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F08CA32C
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 22:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B11C20B9C
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC09138497;
	Mon, 20 May 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brtTWFrU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F026AC1;
	Mon, 20 May 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236098; cv=none; b=eRU0YwuYUJVtf6sXjhdXqX9Xa3kYWhFncI0W/o8vkpubhqBvJ5kWk1EUIDvwIkfDirMTtwDU/OaYirsWBDZvCQnng+IpVnXoKlmfeZibabaiwhNu3PW9Gbvz3ZEKhOv8tba1ikhyOcQB2+ItfPKk9kySHrZ6paOpmwFzdOIDBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236098; c=relaxed/simple;
	bh=my2zBe9siaqWenWrJcggMSsm/lRUaFuxdi5KyxllStk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUj5+AIJQMwl49FeG1yBz4hXOdB1M4WdwsCGOd90LK8dJVvPu5D3Dr/a5NMP2lthHehoy+BYcSQxN36KqDA3U1mzgCBiVMkmczLUk13S/BBYVeHJ4psQbRqiXGSB+IiYDCtZbJ1U7cAJ4d/kT8UxyHI5hqjKzAmBpwwvbAUNbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brtTWFrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2092AC2BD10;
	Mon, 20 May 2024 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716236098;
	bh=my2zBe9siaqWenWrJcggMSsm/lRUaFuxdi5KyxllStk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=brtTWFrUUt9l+QaRTZWIAdW39ak8mRTrVxhac4xcmk2SSzpR3sAoDoThWHghBM6Sx
	 /qPN1D+MOod3dPot6+w5l8fzFMkXgX4W6geubSlicBwA6BtUOqJud64OTBnXDZ+pcs
	 DQllBYuHOjYceAYghEFKNgqacGOyuJw45579M01TlcMkJHeFPK/dkMjPcUnGIGfjYt
	 pqm9WVNLZtqV/xlOoQRqgRCNjk73ocBhue3cd4ORZ+vNmgaStaJ/5ksj0Yk7kCgJt+
	 w8r172BF0NRht9KG3Wu6JcP3d3Q9IKwLiOwGgAtdKHNcwq9ptniMljbgqxrJ53KU1n
	 OACeC02JkyNDg==
Date: Mon, 20 May 2024 21:14:54 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
Message-ID: <e8837fe0-e93c-4133-aac1-f8f0a010f6de@sirena.org.uk>
References: <20240519211346.30323-1-egyszeregy@freemail.hu>
 <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
 <9ae65e3c-f1fa-4ca9-8d74-12d92c51c5c6@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z/wtkHmo87K8Bbnv"
Content-Disposition: inline
In-Reply-To: <9ae65e3c-f1fa-4ca9-8d74-12d92c51c5c6@freemail.hu>
X-Cookie: We are what we are.


--Z/wtkHmo87K8Bbnv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 07:20:12PM +0200, Sz=C5=91ke Benjamin wrote:

> So, in Yocto project build system point of view the best, if any Machine
> specific settings is stored in the device tree files of the target machine
> in driver levels/config, because it will be deterministic in 100% sure and
> it will be nicely separated from the SW meta layers which may not contains
> any machine specific hacking with udev and so on.

Given that with Yocto you're building a full system image it's not
super obvious to me that it is particularly harder to ship udev rules in
the image as opposed to modifying the DT.  It's a little more annoying
but not drastically so and it's not creating a burden on the ABI for
something that's mainly used within a vertically integrated software
stack.

> DT binding would need to be documented later in a separated patch as a
> guideline mentioned it in Linux repo.

No, that needs to happen along with the code change.

--Z/wtkHmo87K8Bbnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZLrz0ACgkQJNaLcl1U
h9BHTwf/UTLXwbIdyQEa9GF/dnrRiD5Wrml+9Z4OBg1vRJi+oB5qmpm0Tt19LBGV
hNJBOlglICeX7Go64BQHAoZL09W0uVQ+5DOUuVMPQrtlyW3cswOizDdgEm7mXb5X
yDnkvFxPXVH/ySywp2Oy8/3VqoklFGMbIYGgmLQXz7WEmQKnGakCX7KecHWXiWQS
Dhyaigm4RuTIHbw6sPyRRxCrs57bSVyBoCpJmB/+6Iqsz4UsG3GVwAOL/3nECsAg
ijUZELgVNGI9I4T+ZvgPWmNRigzXdzD/ET0OZDQBkfrO5+L9Qhao34LyzOJYey+5
USIgVJjrjbqKKz8Cjsjz5TtHHzUrUw==
=SQbQ
-----END PGP SIGNATURE-----

--Z/wtkHmo87K8Bbnv--


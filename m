Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3083C7022
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhGMMK0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 08:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235936AbhGMMK0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Jul 2021 08:10:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8038610C7;
        Tue, 13 Jul 2021 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626178056;
        bh=veIKrgu4aKMMb8Pa4igOFFjco3WGvRXm9loSYXLs+Lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2Re8vWU1x1K/uW6MuMZnM8fGH+4B6y0hotREznO2jb8/W+nK1rCVDkVuHoXJBJeq
         3oAqxB8Rx9TKkPMjHAy5dQ2AuLan2c4D3Z8qmd0xvQ0caK+XdS+6ftPNxszQg70ebv
         k9QCnDGMwM2vWwqvIVVXy1ug98AhmiJRZFwMZdOBZsjKt/XYgTXtQ+bbXjP8yUdKTr
         OBiuHL5TxLorQw/+x5oXbo0t8uhOLf/WMkThLUho3lWCiPBUs9dohkTvTOwx2Fx2eA
         L1KSg6XnsxmDO6szZYrZgcFFtyL4yMQABdizxsCy+LNK12IOEWxNlfRM9UB2KWlqNG
         FmCYCq8WZOvVg==
Date:   Tue, 13 Jul 2021 13:07:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, robh+dt@kernel.org, heiko@sntech.de,
        jbx6244@gmail.com, hjc@rock-chips.com, yifeng.zhao@rock-chips.com,
        sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v12 01/10] dt-bindings: rockchip-sfc: Bindings for
 Rockchip serial flash controller
Message-ID: <20210713120700.GA4098@sirena.org.uk>
References: <20210713094456.23288-1-jon.lin@rock-chips.com>
 <20210713094456.23288-2-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20210713094456.23288-2-jon.lin@rock-chips.com>
X-Cookie: Keep away from fire or flame.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 13, 2021 at 05:44:47PM +0800, Jon Lin wrote:

> +properties:
> +  compatible:
> +    const: rockchip,sfc

Rob has repeatedly queried how generic this compatible is - can you
please respond to this?

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDtgeQACgkQJNaLcl1U
h9Aj+Qf9HQEP3TDGE1oQIqNLlImhDQnaT3hnM3Iy5CN5AFSzz3RoFWud4t5AfnMI
qKTI9Fs2uk6PR+G/6eC1l0tqcK3K1tCguZG+q6QX7hfqknaA5OTiSGKA+SkflOV+
FLkrz0jfnx3PsZDPIFo8mom9zKoBu/J9Tx170c2LFu9UV4wAta5ciZYjvi2Qk4Bp
F4LZ6PMrJEIJia4OeAdJDjezUlaCNQUOMrKdhYLNaxezLSPAqKZ1GFE7SL5/r9mM
xuD7k3FykkG+XyeAPgClbLM6201FvsM2Jg+lP5mjHYkFudHZ6C6BRC6SMuyxuXNn
hRrqvW5E2j49VH3K459GsKOmZb5yFw==
=eWOC
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

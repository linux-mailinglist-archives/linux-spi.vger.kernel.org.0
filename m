Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71491F63FE
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 10:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFKIuL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 04:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgFKIuI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 04:50:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5CE20656;
        Thu, 11 Jun 2020 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591865408;
        bh=VKzLJW4U7pHPqhl4ThnXEzswPS1Ofcy1J2jS7Gaiglg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3YzXxCm23G9kUwkGqyiTj1l9M2SniIiN7gj4O8ZEpO3URiUGoFBadDVk7F77FcED
         BZhei7SJOUSHbvHKUGROkcAZA3vPfCZCOzmPj8KwnnowF24kTbX9YIqBpWKbVtql7Q
         WZpMZ3SoAxhHPHTlCDGiCTUSQAQVwrn++PkGOh5I=
Date:   Thu, 11 Jun 2020 09:50:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add r8a7742
 support
Message-ID: <20200611085004.GC4671@sirena.org.uk>
References: <1591736054-568-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1591736054-568-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200610110810.GD5005@sirena.org.uk>
 <CAMuHMdWCHeSB9mjpdSX_-qxwo33kMb1_1R93CjBtVBPFPKkEOg@mail.gmail.com>
 <20200610164928.GJ5005@sirena.org.uk>
 <CAMuHMdUNo0tMxWsnXi4q8NwubPWHqTvzGOA-0hOr7oo2cRvvUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUNo0tMxWsnXi4q8NwubPWHqTvzGOA-0hOr7oo2cRvvUg@mail.gmail.com>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 09:18:19PM +0200, Geert Uytterhoeven wrote:
> On Wed, Jun 10, 2020 at 6:49 PM Mark Brown <broonie@kernel.org> wrote:

> > I'm much more comfortable explicitly listing the new compatible so that
> > even if someone makes a DT that doesn't bother listing the fallbacks
> > things will work.

> Adding all of them would cause even more churn when adding support for
> a new SoC... There are already more than 700 "renesas," compatible
> values documented that are not directly matched by drivers.

I'm not sure it's a particular concern, especially since you'll be
sending this stuff in the same series as a bindings update and an extra
patch in a series makes very little difference.

> Nowadays we have "make dtbs_check", so if a DTS doesn't conform to the
> binding, it will be flagged.

For things that are upstream.

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7h8DwACgkQJNaLcl1U
h9AbHwf+Oh0ZTAsfPJi03Ayhsz+OMqw4Uebch9FIKNb8mGnpo5yZuUA/oMtGTghT
1fT2jkgx+0iNVdRsPz6M1OEuF/ls+JyYrcLOmQyu5Jmb/xhrr62ANmMWQV6oZsD6
9ANB0yKJUixSwYgu6OWeFgmdYmzT4K29839XsSK/rs4Y3ZcRfrF2F5skGbbHzVCE
jtqvXG8+GhJHNXpEtyqOd6+sq19g6wJ/Fh13vas59bKQYKaJnn9pS0mjzEughzJ+
2OQTvE2gAaw4zXf/dKGag1Om1NH6NhS6k8MIxoP/kNa+yyuw2AMSsMt8NC7EsDyy
yXvvE+bPbnlTWD+L8Quyr0M51PRvZA==
=au0+
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--

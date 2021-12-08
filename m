Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A931E46D4E8
	for <lists+linux-spi@lfdr.de>; Wed,  8 Dec 2021 14:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhLHOAD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Dec 2021 09:00:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53132 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhLHOAD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Dec 2021 09:00:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 786E3B820EE
        for <linux-spi@vger.kernel.org>; Wed,  8 Dec 2021 13:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D429C341CB;
        Wed,  8 Dec 2021 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638971789;
        bh=xcuNWjZrxzWU0jAdigU5vyr7o59YkYN3tahp7TIgtl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIyFNpfLxMx/nUqBmSuJhFPEeLyAOFJIZdHh68xdRuzJSXzSqK2wFkO01GS4ptX/O
         QENU7XZUXi4Hg3u7rKJCKvm3CNB3JpH0nWuFYtwXArVC7j0oDFuzqfxCfEDuY2NTXU
         IUp/whQ/i0WNK4dwKlfQuNxkksvOCG0zfr/a7dYYsIihX2M3M6w7aqlU94METOJ/et
         8QJPRtBV/QD/nnEaJ048VU5rnJvHDxKc933QoqYzdBpo3sp8W7M+oIqmYo/OHQsQU4
         2KA2fqwGGBN8xmoY+yzMKtaEk0NehbVDM4B0oE0OaDGigou5kJTRLRMK1ywNbHjwOo
         8SxuHq3XxMFEQ==
Date:   Wed, 8 Dec 2021 13:56:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: (EXT) Re: [PATCH 1/1] spi: lpspi: Add support for 'num-cs'
 property
Message-ID: <YbC5iUMGcITd6LiT@sirena.org.uk>
References: <20211207104114.2720764-1-alexander.stein@ew.tq-group.com>
 <Ya9aV9yAEt9aWUQz@sirena.org.uk>
 <701d2fc1336de30789444e43efe98473fdeb554b.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxt/r1x/XnLrRp43"
Content-Disposition: inline
In-Reply-To: <701d2fc1336de30789444e43efe98473fdeb554b.camel@ew.tq-group.com>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Dxt/r1x/XnLrRp43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 07:59:00AM +0100, Alexander Stein wrote:
> Am Dienstag, dem 07.12.2021 um 12:57 +0000 schrieb Mark Brown:

> > Do we need to use the num_cs property or can we just set num_chipselect
> > to whatever the maximum value that can be set is?  I've never been 100%
> > clear on why num-cs is in the binding.

> I see two things which needs to be considered when setting
> num_chipselect:

> 1.
> The hardware limitation in the uC. The i.MX8XQP RM says:
> >  The entire CS field is not fully supported in every LPSPI module
> > instance. Refer to the chip-specific information for LPSPI.

> This indicates there are some i.MX, not necessarily i.MX8 only, which
> have more than 2 hardware chip selects. This might be set depending on
> the compatible.

Yes, this sounds like it should be figured out from the compatible and
not need a separate property - that's usually better in general if
there's quirks in the IP configuration in different SoCs.

> 2.
> The hardware limitation on the SOM and/or mainboard. E.g. even if the
> uC supports 2 chip selects, only one may be available on the board
> connector. This is something which can only be set in the DT.
> This case is what this patch is about: Providing 2 hardware chip
> selects, as the default (if unset) is just one.

Given that we won't try to enable a chip select unless there's something
connected to it this shouldn't be an issue - with a lot of designs you
can't avoid doing that anyway since the chip selects are all in a single
register.  If the pin isn't connected (or the signal not pinmuxed out)
that doesn't seem like a problem?

--Dxt/r1x/XnLrRp43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGwuYgACgkQJNaLcl1U
h9CVkQf8DgVkoJx1QLcOqdiySsxbpIyGaIxGEshJh5ltRDB3Wbq0125FM4KwxBB4
OffYMc3FWM6MgStwyBfclAQKKP16d6pc2xeqMuijMfxQJwGixgSSv24bw7wcLbsp
OScMjGCZmMZ16OQOD3i5xwjLVq96CedXIls4yEzP7fYcH48z3p0gqxxj5whIKsOR
AXxquQy77Ytz4L5B2r0+Me859eWUDHgSpgnkPzebT9bQS4JMY8078OdjQnAj18Pn
X3BT9yTuAj/LPj4GhIhAQfcWVGxqcpmwHIYwFdTRtdwDxzRofMowF/7Ay71pHhJG
Pi6fgb+bHPRyeQ3GsqmHZdFRbCeWgw==
=6dp1
-----END PGP SIGNATURE-----

--Dxt/r1x/XnLrRp43--

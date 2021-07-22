Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79F3D2534
	for <lists+linux-spi@lfdr.de>; Thu, 22 Jul 2021 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhGVN0S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Jul 2021 09:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232201AbhGVN0S (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Jul 2021 09:26:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9637D61244;
        Thu, 22 Jul 2021 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626962813;
        bh=3hM40cKz7KB3yjzfPuUDFQB9gCDFYNtm77W61sxGU2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBZa5vdfi6nywog+T27MttP3U016IrT6QfRm8mjad4wF1rr1nMVIwlsVKkgFkJoGl
         hwmZxbeyz9T5/kHDgbPjJ8pasvYFK0K/fT+96vxi87MqlGJD35SrmCKHt5DqpsNUMz
         0UQ1wSCoSZfZ3GaEgXMUjQinrtivqRzNaXQYQoqnZqcO92e9zpMS7hCnfoczPJFzMn
         JXU7qSLnjgxNiNdQq1MMSUD1/UKcK1kxujuizyXwWU32cYwKzMNfYVlvwBhRZ1o44o
         pIOq4HEiLqclI4qhMnCu9Le993o9LWnBa/XmluhN2Nsp677ZzL+pveLBre/7WQU9zE
         DLne98dzrtQQA==
Date:   Thu, 22 Jul 2021 15:06:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: update modalias_show after
 of_device_uevent_modalias support
Message-ID: <20210722140646.GD5258@sirena.org.uk>
References: <20210525091003.18228-1-m.felsch@pengutronix.de>
 <mvmwnpi4fya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <mvmwnpi4fya.fsf@suse.de>
X-Cookie: Who's scruffy-looking?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 22, 2021 at 03:48:45PM +0200, Andreas Schwab wrote:
> Commit 3ce6c9e2617e ("spi: add of_device_uevent_modalias support") is
> incomplete, as it didn't update the modalias_show function to generate the
> of: modalias string if available.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD5e3UACgkQJNaLcl1U
h9A/fAf+Pj/MH+ZJBW4jEMf4xl/kU08ThILyzqQ4DX4BYJXMP3ejvmgZx04ys8Qr
ToW5MvnITVJAanx5JgcBTNnNd9D/Et9CF7/upYRTzvGvDZrdMaOFWyk7HbkeSLbx
2NCX+IypviPlJDFVMD5D+Zm+o4GnbKyH2B91CVkdM1N/C+DFtjqNRR+55KOVLTBV
u6huHMp14ViUGJcsxjGFjmDMhHE7QGFYaBW6tIDwth5cJtCs99uc+BA41KGnseNN
VF9ypN6byQ4AGWUOr2gzTXFVBIWehGuCWx6XPkHoSOjkHjhfGTVcCvGLYa8q17x3
AtMlJrC8PkMnWXZl1e7i18mE0N/EHg==
=mLLO
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8D23EE2C
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 15:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgHGN1u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 09:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGN1r (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 Aug 2020 09:27:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 771D12086A;
        Fri,  7 Aug 2020 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596806867;
        bh=cauRTF3cdR/PFgrsmHkzjr279ml8ZN/267S96A1D070=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBXsGfYbdXLESB4THwag+WPAVnL5mwYabZopJFRadh5IwTbV4OJ5YuQUZpprZ3CC6
         bp5X4FM9FzAK5ruMBje7aHEMQRi4UGr1Zwrdl/k+wEInPd2Z6/7BUoIJLBqrLxbuZb
         S3wmrfHiLijtUeSy2UjsqgR4FyGcBNUjf5tSXAVA=
Date:   Fri, 7 Aug 2020 14:27:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 2/5] spi: stm32: fix fifo threshold level in case of
 short transfer
Message-ID: <20200807132722.GJ5435@sirena.org.uk>
References: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
 <1596806485-3810-3-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Content-Disposition: inline
In-Reply-To: <1596806485-3810-3-git-send-email-alain.volmat@st.com>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2020 at 03:21:22PM +0200, Alain Volmat wrote:

> +	/* data_packet should not exceed transfer length */
> +	packet = (half_fifo > xfer_len) ? xfer_len : half_fifo;

Please write normal conditional statements to improve legibility.

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tVrkACgkQJNaLcl1U
h9AKZQf/a+Ru7h5ixAXVScXCOGiC+r341yYUTHK9LElaCpXw4iTXlGHMRiJkJOsr
adMT9NNEs2Ka5PQ7wiKIw558VLZ5WbCQ2paWcKN4vElYOhulMCRn3X7Lcs6VYzW1
scWxT07YTt15Tvxi7uBpRedIgOYUO/1sey+1skdwaqQbQYykoV/XUvRYehzyeZ7G
tFJMFskTaBJ8T2I910IItEFasKttZUrLa1X3xtn97WiM2wnX+YCu+BDPwsKv5x0V
63H0dHkTGwEnNiByRU4O3rL8Bx0XnopWzYJlfSY+ayH0QYmh5raD0Fgn/86cW4e4
BVP46YZ6w0ZmTKL/prjveFSWY6zLyQ==
=v0uW
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--

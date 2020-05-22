Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9E1DE594
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgEVLgi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 07:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgEVLgh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 22 May 2020 07:36:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CF8206C3;
        Fri, 22 May 2020 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590147397;
        bh=z/6OXOepRElS/C2Gkk6RRZeDF9+60BoN0+lQKMHv4sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SViwwqlJ87aevdHn4RYwBdrJnJkpk2rgiCE7e168UaD8MlGXvEupOGhOH7ejYfrbJ
         N3kZOSYajFR+FWCWBWyZDHjCeSTW6pHxtLB0BJj1sTzEGGQE0HGaQz/KalAcMtdjVw
         a7j7/Lewv8pBtYtgHXcvbty7bFHiOt4Q0y6gEdzA=
Date:   Fri, 22 May 2020 12:36:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/8] spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX'
 support for stm32f4
Message-ID: <20200522113634.GE5801@sirena.org.uk>
References: <1589800165-3271-1-git-send-email-dillon.minfei@gmail.com>
 <1589800165-3271-4-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <1589800165-3271-4-git-send-email-dillon.minfei@gmail.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 07:09:20PM +0800, dillon.minfei@gmail.com wrote:

> 2, use stm32 spi's "In full-duplex (BIDIMODE=0 and RXONLY=0)", as tx_buf is
> null, we must add dummy data sent out before read data.
> so, add stm32f4_spi_tx_dummy() to handle this situation.

There are flags SPI_CONTROLLER_MUST_TX and SPI_CONTROLLER_MUST_RX flags
that the driver can set if it needs to, no need to open code this in the
driver.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7HuUEACgkQJNaLcl1U
h9DV4Qf/SihsJbdjpA046b8/NxOUN0XzKoBRryG9nf4DC4x3Fpb0tscXdk2/FeTd
JceAquzFzEEQ49acoXxDA2UQXUMtmlEiGfbWhNHS0Jwo9JVU3XPHLG5d+nX+sudU
L+O+LPQB61KcC2OQniMIjgApMjvyj2ePQY0lfjl1jnAb3PLHvlpaUt5Mjp8P0iVB
N2skbxjLqD/nDEDYXV+S0Jp689oOuNDJ/zeNk3ds99vhHEc55yvZxvZB8OcWNuop
AJ94iVaqJX+b7qak3V7Ts6Hb6GgkNvr/78bWpjGK5eB+a00Ia0l8yP9svyYdczOK
GS605iD0geP72ehzZUhOjifzaJ7rgg==
=XMsa
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--

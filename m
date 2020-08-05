Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A3623D20C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 22:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgHEUIY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 16:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgHEQce (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA1622CF7;
        Wed,  5 Aug 2020 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596625426;
        bh=EiATByOyKVVEDEiKPvEDXfJXjBlvSpmgzgFeI6rtaeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1U99Db/ClRkQ6KDU37nlwCde0OcY8IsBhaUDb/7P4LktqYY+Z0aXwlIHJjaLLEg0i
         HP6UmQ81xNImqJlw9hvBneS5eOrYgM8OpOB2BwT4o1Bk6ZArKj0cqnNrzzsAZPZsn9
         CMXDKJsrOkcPyiFsNo1isIOAWdLVMRyDgwbTlfLg=
Date:   Wed, 5 Aug 2020 12:03:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     amelie.delaunay@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH 16/18] spi: stm32: always perform registers configuration
 prior to transfer
Message-ID: <20200805110323.GJ5556@sirena.org.uk>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
 <1596610933-32599-17-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline
In-Reply-To: <1596610933-32599-17-git-send-email-alain.volmat@st.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2020 at 09:02:11AM +0200, Alain Volmat wrote:
> SPI registers content may have been lost upon suspend/resume sequence.
> So, always compute and apply the necessary configuration in
> stm32_spi_transfer_one_setup routine.

This also.

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8qkfoACgkQJNaLcl1U
h9BirAf9F8v+4ZpcM5/rsegzbIEMnqmQNj2m1sFs+bLGVfyscsekXzaSTqzqJkC7
nev7KJtz7moksvzFim3TlHdPOTGmX9YOGii/DSqoYftYYbqHLfZhYkEXE5xZQfkm
NymiZpnrHMSWOUaV8EGcpL2971rJHz+7LoOwwiJAPLofZu6fJLHXDw7ZMCZ27RIk
6GKEVtsn+Vhh0oh5RzSVeKwmEBtaj0Qng8SA0xRC2+1dGhmPFYAbznHVWrFyJYs1
WtIKtCh/v8wZ732BrS4qiyd/l5UdyesjRBugNMwx7ZNlqLwYHiFQhh8VxX1ot+hI
72nCUjTwhxvzVa40nFYNpPYf/9ZbAw==
=1GlO
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292F31E84B8
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2RWg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2RWT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:22:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAB320810;
        Fri, 29 May 2020 17:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590772935;
        bh=nhFmd1nKFRWbwVMxppSyFwFxYzfZC01icTteWmxNe9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1FPpmye2xCTWYQx8DnPqeL7NY0aT2PHCw0ICZ1JF/rsgALuBbUT4tPE4l1JtK9km
         88Jnsv3hLfnKSbz8viW+YyII3FdCgyv1z8DkYes4IVpspZzz7KBXeeQXHkToc4YRUl
         DToKY7od8szlWNyYK0iJdBhXnmvREYp8N2y/TO90=
Date:   Fri, 29 May 2020 18:22:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] spi: dw: Make DMA request line assignments
 explicit for Intel Medfield
Message-ID: <20200529172212.GA17643@sirena.org.uk>
References: <20200528102311.79948-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20200528102311.79948-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Ginger snap.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 01:23:10PM +0300, Andy Shevchenko wrote:
> The 2afccbd283ae ("spi: dw: Discard static DW DMA slave structures")
> did a clean up of global variables, which is fine, but messed up with
> the carefully provided information in the custom DMA slave structures.
> There reader can find an assignment of the DMA request lines in use.

This doesn't apply against current code, please rebase and resend.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RRMMACgkQJNaLcl1U
h9BIaQf7BngWDEhJNivsV2u8clOUjLWsNMVU2r80vgVzQ3Mu6OTsTO8lHM65+mT4
9AEEoGM2jGnSQNYfpwwQU/Ggsayfo7IhP1IvUGR9mb06SUCIgwegphUFjme2Y6ON
f7ryEtXkIeDhTD1VWszzDRVSGvX0+UwQvkqkj54JbadC2pR8qaxRFW+q5SHYy4m6
0xLXgKezGKiPKYvkpyyKW61nQcd9cDt8CFePXqrGKjyXMJnJfYaky8oiu9JYvTGC
IWBqplAHSNtYVwFZu/aEITa9arQy47lczKEtDcoZ+p4luuc04N96CyBuc1k9QPOX
SnRredGuyl5NbsfGJ82nPcfply9MQA==
=vAP6
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

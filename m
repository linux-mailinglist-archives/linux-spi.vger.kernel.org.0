Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01CF1E7DC7
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgE2NCq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 09:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgE2NCp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 09:02:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBBC02077D;
        Fri, 29 May 2020 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590757365;
        bh=ARNaKA1yb6DwZcc1AOHUze81r84J7znpXdtHEL2hu1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUQdH/bBmjvDlHFUmOvB6Sid7DD19xBcYEJP1s+aUiC6byvu1z4ZQ1HY+J+0iSnPY
         YDH8gXxysP1y8ocbXMv23OxD/W7ebndxojTaKmK5+JtrgLkVfuUC/YOCpv6cSq4dvY
         +hj/+PfJVGx22pNPNa6bEPgAuYgnw0O3DDn/5SIU=
Date:   Fri, 29 May 2020 14:02:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-spi@vger.kernel.org,
        Sergey.Semin@baikalelectronics.ru, fancer.lancer@gmail.com,
        andriy.shevchenko@linux.intel.com, lars.povlsen@microchip.com
Subject: Re: [PATCHv3 2/2] spi: dw: add optional reset property
Message-ID: <20200529130242.GA52828@sirena.org.uk>
References: <20200527204110.25676-1-dinguyen@kernel.org>
 <20200527204110.25676-2-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20200527204110.25676-2-dinguyen@kernel.org>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 03:41:10PM -0500, Dinh Nguyen wrote:
> Add optional reset property.

This doesn't apply against current code, please check and resend.

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RB/EACgkQJNaLcl1U
h9CRYwf2Nalr3n2GMXgyhS8OMZTZaoN0+7yQk4fX/asqaFYHtVinVvj2mVqReiwo
wBJ5PUtxGDLAj8XLvgbg33H1VAKOolO2/lxUvB5tSsy8OOThLB4auqXgqgUz5OTk
x6OWGsYxX947lvjJ5VLw56qSqLxcjkR4hHLQXS4ycwYPgMe43oLgAFveoBg7fy6+
Dt02YIeXgkfl1DOHlMii22qRoQy4FzeDEhDt0o1YYGGveSmRf6ee5SnbR9dYWpmL
ARZdxf8b+xiigdDBVCJJf5427eFk/qrYQiAAqn5lDHccmHGE53sJwu/c530foiLw
4o/vA82KVuVqhtfWv9ZXnnyq2UQg
=tV+V
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

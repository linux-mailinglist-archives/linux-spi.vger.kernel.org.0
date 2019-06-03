Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B26C3345C
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2019 17:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfFCP5R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 11:57:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43024 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbfFCP5R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 11:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uW11fmtTizoTBap/KWWBpd8+WwwZRjxzcNh47i5MKJ0=; b=GwRVPwb48KYjiWI8Eggc/cJAs
        e29gYbvkJPGDrkL1wT2b3D8v9Bgh5+qznwRk9eXh/up6W1nAQT1bjmm4bvAdyabojGqh5S3sT8MIp
        PWcBlaD3Z22ilxo1DR5d9T8VO/xdlePrLT+wtOJWIVOGgzmns1AK2M5s9boDu9CsbGEus=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXpKl-0002I0-1E; Mon, 03 Jun 2019 15:57:15 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 55589440046; Mon,  3 Jun 2019 16:57:14 +0100 (BST)
Date:   Mon, 3 Jun 2019 16:57:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vivek Pernamitta <pervivek@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Fix for reverting spi max speed value only
 on failure
Message-ID: <20190603155714.GY2456@sirena.org.uk>
References: <20190602141959.5616-1-pervivek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RMorpr61ug7CvG36"
Content-Disposition: inline
In-Reply-To: <20190602141959.5616-1-pervivek@gmail.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--RMorpr61ug7CvG36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 02, 2019 at 07:49:59PM +0530, Vivek Pernamitta wrote:
> When user space application request for change in spi clock
> using ioctl, current value is taken back-up and new value is
> assigned to spi->max_speed_hz, then spi_setup() function is
> called with new value. If spi_setup() function fails, it needs
> reverting to old spi_max_speed value only in failure condition.

The current behaviour is intentional, we're not modifying max_speed_hz
so we can continue to enforce the kernel limit no matter what userspace
asked for - actually looking at the code we should probably have an
explicit error check in there to reject attempts to raise it here, not
sure why we're not doing that already.

--RMorpr61ug7CvG36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1Q1kACgkQJNaLcl1U
h9DePwf6A8FaQOvSKwYtjWsoDYPI0DOiaT5U4Sj9v/nmeJeXAjLkg5foaE+aL5MZ
ZGyj4GXTt8jJnQpUDZqJv3FgAHTY5DfpU/cZRumMrSwxy4DwR+pvtH6vSkw0yMlo
Fzb5ZXyLnvEjIqhmYKfjHL2Mj5x1s1OTB//rDuIBDA0NT76HCbX9UUrFWr4BNjh2
5e44KLud+9+g6i4q7r+yz9D/vfzl5dS113R8NvXR90qCv00ulTFfmY4gLWWnegWD
9OykYgC18Z0i0iR3aZhJDCm/lvcbHscmzOYYOOec0r0pSVWwBWXQtOixe64OtbEO
F0Z9w/W75Rcsvbz52HI/ceMOnAgTfw==
=Zr+r
-----END PGP SIGNATURE-----

--RMorpr61ug7CvG36--

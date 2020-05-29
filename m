Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA381E85A1
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE2RsI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 13:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2RsI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 13:48:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4F42067B;
        Fri, 29 May 2020 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590774487;
        bh=CU5XueM8Uren8tTTQCGNaREQdasKk9IK8u1gailMNuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yUOrG3IQUBxZeEU18buHBc1e/yA0krknShpUNLJO5bKUFHyrx8iPsyv/K6qfFHLs0
         gOHg6SjZFKD8kCRcH48S3sWAIMFNs+kJUDc1PIx7CpM1jWKlMhTs7kVXPTl6eBi39A
         3ghzEceZBLYEdbmGjtQ4TPc5MQAOWlHsVxDvSNoc=
Date:   Fri, 29 May 2020 18:48:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: Enable shared interrupt support
Message-ID: <20200529174804.GT4610@sirena.org.uk>
References: <20200528185805.28991-1-nsaenzjulienne@suse.de>
 <20200529174358.som3snunfxch6phi@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4AfY4lbNVy6SI0IG"
Content-Disposition: inline
In-Reply-To: <20200529174358.som3snunfxch6phi@wunner.de>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--4AfY4lbNVy6SI0IG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 07:43:58PM +0200, Lukas Wunner wrote:

> This definitely looks wrong.  The check whether the interrupt is enabled
> should be moved *before* the conditional calls to bcm2835_rd_fifo_blind()
> and bcm2835_wr_fifo_blind(), i.e. to the top of the function.

Hrm, right - I'll drop the patch.

--4AfY4lbNVy6SI0IG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RStQACgkQJNaLcl1U
h9DEcwf/UwyI2LMBvPyY58CcQXrZF5LFTL5YDrcWyvT7nhTkEmJjEepRcXdJFavZ
3F8+5aFweraNFenwqNcTnmpspdIzp45E+ZeaEayzqINHQcPj/QAmCTVwFK/vULr4
XxNwzuiOQz3vIPjaqiJGjIE1jBSltoykiKqMY9B0cHyYPXvqEfrobAZHLWnLYdr5
XIhKIEX2Txj0WvGGbZOUK4wiG8/bj+y1jIVHiOqljCIgcjb06ws739t7UhrWM1HB
ZhATvhbiirr0wNcA8oG0mXmgK+vMVTvWenbXxlhReTkbMWG6x8uzCv3rg7aCE02a
4/IdOSFJQ3i6acyBkGgJO5mcHXYXxg==
=gcEl
-----END PGP SIGNATURE-----

--4AfY4lbNVy6SI0IG--

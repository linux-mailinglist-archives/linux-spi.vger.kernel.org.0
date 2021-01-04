Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5112E9F92
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbhADVcj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 16:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbhADVcj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 16:32:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4023F216C4;
        Mon,  4 Jan 2021 21:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609795918;
        bh=jGhGboXJLgp83o7a+zf9VPQq6PttDfIBMW/Cujx0Z6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTWb+fz3CvA3RbZMI/d0XAbWS/8yPs4ixn9QK87DyhrDLdyCzm7G4vh/+Dkj5iSLI
         8TNu5t7idY3cwhL1VXgeCxR6QUyuTX2wH+XX35OTfCjD5h572amb3DWKNpuY70kLZW
         F2zvjboFVnFDwPCLL4Yk5ys1cI6AkvRocuS593OU2/60Kl+HK6XOHYBOZF/TPW59Tc
         V8oomtwNcNb2N1sPEBoK3/QXvBlhJCsr8Mx8WsXOzuwefQLd1tJdqsCwLeeFwl74Qf
         0WDxm52xYT/gVm4A5SlezTyexEn1aj+/G/Kso3kiKTgf/eAUPxuORdXg/LmWITp7lP
         tHNWXPKRUkc8w==
Date:   Mon, 4 Jan 2021 21:31:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI
 controller
Message-ID: <20210104213131.GL5645@sirena.org.uk>
References: <20210101132432.2785663-1-bert@biot.com>
 <20210101132432.2785663-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Content-Disposition: inline
In-Reply-To: <20210101132432.2785663-2-bert@biot.com>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 01, 2021 at 02:24:31PM +0100, Bert Vermeulen wrote:

> +  compatible:
> +    const: realtek,rtl-spi

This is still just using rtl-spi as the compatible string, please
address the feedback on the previous version.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/ziTMACgkQJNaLcl1U
h9Dmkwf+IgiS05nspQXIaJkG86ncWujAt1joFokPRvyZ7r5TIfivPc2fJ0+dUOpr
VvbD9EICjfq6QrJw+ufDhjEs/mcujM4N2QcEs9Dm6tZj4rS7OHQbbAmLv70zHt43
OFTR9aZrtum1oT07q5g7MEoqDgUshxfiDL18x0y4AA227NvCMlAOgBXsqG9gl3Wr
p0qlAY5bMnT3cRbyVMzwcdyNWOXm5/Vnwj7e7Sd+zEaEYOz8EHqi6ZRPP5jjqVUw
XLkFNEG41F/nxhaml/GFWffwDFWBhZVq9l9E9TyuLBZQPuOCSTfoOLj8EgSsmdRB
1qs4FUcE9zMIyYSE30J5vJ99bxS72A==
=4CUf
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--

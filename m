Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79AE3F62F1
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhHXQn5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 12:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232772AbhHXQn5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 12:43:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BBA661183;
        Tue, 24 Aug 2021 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629823392;
        bh=dN3jYyeMJJyDGgXOEDZddGSxpcAb8uTr7jWFGSzh+K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PN2AHTMJjNZYdm3xFgHHra6uvSIMtfe+AsUnazE9c+twfbbeRb7WvaiaxxatlgA++
         CeoG3OP5D4EjsR5RBE8gjl4VYIHkOD+ljAIyjaaUNBG07Obemew/BdPFSpcDpIPubE
         Dd+tLh+Hex6O1zAOGV8P6jSSI2aKCa9SnXpXR1eO1bkH3DRcXqTFDdRC2rCNfYpst/
         9DKibuMo4N1HEAqowON1MozBi/evYUfP+dwdw4bh/4KOuaTCwYahJLsSo1rPJtiGDI
         suM3VyA5MzzDDReEF5dQ2v60YO4KEvtw/rBnCVCfvQyn6LYYJwt6m6UdEqS5dykTsp
         Db4zUggJ7PS6g==
Date:   Tue, 24 Aug 2021 17:42:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 1/9] regmap: spi: Set regmap max raw r/w from
 max_transfer_size
Message-ID: <20210824164245.GH4393@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20210824104041.708945-2-tanureal@opensource.cirrus.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 11:40:33AM +0100, Lucas Tanure wrote:

> +	if (master->max_transfer_size) {
> +		bus = kmemdup(&regmap_spi, sizeof(*bus), GFP_KERNEL);

We shouldn't be peering into the controller structure, use
spi_max_transfer_size() instead.

> +		bus->max_raw_read = bus->max_raw_write = master->max_transfer_size(spi);

Just write two assignment statements, it's more legible all round.

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElIYUACgkQJNaLcl1U
h9B9Mwf/btR6UQz5FMn57mqv/96PQ0c6VH1Q00EtEmqXGHB1lvvL6tmNznGXAUHB
fgzaL4n0vnl6ATBtT4jSmvBsNuXtu0wQ3gLIi0iuEvCaZ4+pCmLGJ53hodhk7Qle
HofZQWJf3xZeEKE5ouqhMp6/S4DGEQ8aT9ROkPxu229daRR4K1vPb5tO25xCvs1g
Lqq8jGwA9LKdwsKo/DZYbSvLLPMek7SpkAs6KHy6AQ9+2EIr5GELXl9BUPYaLIdc
g7kafwsCj4ItU/ozIb1cwUeF8/YnEetEEBoOZC5HTMxFKvY4M343ceXZ7qlnniYU
AYgeJOfxvFkzeXQH52hRCegoE4XgvA==
=EXzT
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--

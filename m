Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7515D3F683D
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 19:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbhHXRlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 13:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242703AbhHXRjo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 13:39:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACDFB61206;
        Tue, 24 Aug 2021 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629825613;
        bh=5qscRr5yIE9QanSoRZ/Vokx51/sueNqu6EM5rBg3EpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fh47MPpE5gLEN7qRdzBH8DfGeRe0lPMN67NE812lAhNjDbXyaEwGsA1bd2YfKEjQn
         7WuhabsQpY+sre+EWiXu5IlZu5G6iM1mdC9gh7woo5H/6/mpeW0kcM/TiR0DPVnjCh
         iLXF7smKz+sFlJZSgTRbFq+F80XkkEuc8mEfE2qwDwsBeBnvRWhdD8xHmeFFgwVEpB
         7gzYfRSyv0i3v9tJBOxH972JII5pdpoMWj/iboDYds9/ZV7lrdSWHbi9pSQG0XG8j7
         7ytE/4JTQTLT0+ks0vtZz+rBY8IkvWL38VSTd/ybmQ4tSTdeLpcASTpp7n6ySH/mkx
         gCLBJCU4B9FMw==
Date:   Tue, 24 Aug 2021 18:19:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 9/9] spi: amd: Add support for latest platform
Message-ID: <20210824171946.GL4393@sirena.org.uk>
References: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
 <20210824104041.708945-10-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7l042bGvurpep9Wg"
Content-Disposition: inline
In-Reply-To: <20210824104041.708945-10-tanureal@opensource.cirrus.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7l042bGvurpep9Wg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 24, 2021 at 11:40:41AM +0100, Lucas Tanure wrote:
> Add support for AMDI0062 controllers
>=20
> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>

Did Nehal write this commit?  If so it there should be a From: saying so
- git commit --amend --author will fix things up if you're using git.

--7l042bGvurpep9Wg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElKjEACgkQJNaLcl1U
h9CbFwf+PXHcYyQp9Pl9JRzAAk65W3qFxAGqAPETWQzSuplpAYVZWgLX9pLi9qPl
VxU5Hsegp7brOPcdy5AwiKKa0eTE3gt+DjuDjNsuppIySEYjxmRX0MPG8NP5ZA5x
NwqOKSKhDPdCCd5niZRccJAqs8EDGut4z8vMuhwulullzOEidFhyDianVaz3r/y/
ZjXS2PQVqsTGyMBK60od1+WiS7z43P/EkZgIn5UwCu5GZOFYh9VhukSS/l+HKj+z
akzZn7ac6B8JqY7stDer3C3rNsbVjZVlzUqp1VeNu3iGbTBjALIENBkwEFjqrTd4
IZqKUlhhH9hBijPwUddlLteY9aP4Lw==
=mrLn
-----END PGP SIGNATURE-----

--7l042bGvurpep9Wg--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BCB23ECF0
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 13:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgHGLwT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 07:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgHGLwT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 7 Aug 2020 07:52:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 918CE22CAE;
        Fri,  7 Aug 2020 11:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596801139;
        bh=pwisC2wbHQcZOjr5Rjsy70WlgSQlFSR0TBxnfhoFCoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELEFJTouaNLfrzJHJ3dEpDJm+t2nVWmrI+9ITs2MKjY4uM9/fmNTLhNNAvm+YfR3J
         8eYH25QkUos8UC7MQRKk2cKcwpnEwZ5lA2hYvsS4qrMTun1YKRsuapj7TqzvXisYtk
         of+mxMZABqKm8apefwrftOfcvs+kttZkT6yWLEQk=
Date:   Fri, 7 Aug 2020 12:51:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 31/41] ARM: s3c24xx: spi: avoid hardcoding fiq number
 in driver
Message-ID: <20200807115154.GH5435@sirena.org.uk>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-31-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-31-krzk@kernel.org>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 08:20:48PM +0200, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The IRQ_EINT0 constant is a platform detail that is
> defined in mach/irqs.h and not visible to drivers once
> that header is made private.

Acked-by: Mark Brown <broonie@kernel.org>

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tQFoACgkQJNaLcl1U
h9CL0Qf+KoFRy+7m1iP3125g6K1zPdZzkGlUaTmdONS970orQsP/df4NIb5Isv8t
nesKVvGZQS3hiYE/RR0OtcJKZhqliUGTW/WE6AoA9Se8MDoRyTFDzVZ16d1xvEYz
9WS9JewtrOPVHyOv9yojuE/9xsPG/9x04Uu8ltxqo2ok6HlVTzbUxuabY8FbAutE
/b+IYMvhXyD7cxFaIqtVlN+++AKtHFry/wQX3adCV3hNy4cVZDWsIOBiIoD2WoTu
VvKV4Wkn6UOSa+kt4wqFrzPCkiOV7qx6WgwjW3HgoY07pzVESxwniHjF8k81KbZk
2KeUBIKXP4gtiXUX+xxMtUOf6HDhHQ==
=f9i5
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--

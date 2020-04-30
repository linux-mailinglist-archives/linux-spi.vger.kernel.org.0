Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311A41BF6D8
	for <lists+linux-spi@lfdr.de>; Thu, 30 Apr 2020 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgD3Lcr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Apr 2020 07:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgD3Lcr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Apr 2020 07:32:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E142078D;
        Thu, 30 Apr 2020 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588246367;
        bh=SDuEwg1WKq7t/jFi9WmoqkIH4AEdT7LiqRcbwtABNhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHoq0B4CB7eyjb2jiTgJnCY9oVfanKYOBA3gjv82qjmhbVF2crI1GVc/QSnh8JGVV
         EkBqhhzJaHb+r2cH9SlLAtUztz5198G99Z6h8fAlV0XkBuv+NMB77dS4OvoxzxcKsq
         zT+cJhW16h2UiDHWliFbvmGmePS3oVu2sV8uu7nY=
Date:   Thu, 30 Apr 2020 12:32:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 02/16] spi: atmel-quadspi: reject DTR ops
Message-ID: <20200430113243.GB4633@sirena.org.uk>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <20200424184410.8578-3-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20200424184410.8578-3-p.yadav@ti.com>
X-Cookie: Sign here without admitting guilt.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 25, 2020 at 12:13:56AM +0530, Pratyush Yadav wrote:

> Double Transfer Rate (DTR) ops are added in spi-mem. But this controller
> doesn't support DTR transactions. Since we don't use the default
> supports_op(), which rejects all DTR ops, do that explicitly in our
> supports_op().

It's not ideal that we'd need to explicitly add checks in individual
controller drivers - are we sure that all the others do?

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6qt1oACgkQJNaLcl1U
h9Bp+wf5AYkjviwzmOmBfB0UQdeRmw/d0JfRnbiV641yDAx2gAOy9RDvBnVgDjJA
sGUWQ4wtEfqrzMA1Df0x+7qjV5wYyCtvZA7qqLf8W5kkpdxHzCP+3GoaGsiN6fhB
8azuDCV4H8AYMZUVdphUpnOiJkYc7ohuG3KiNQzZNcecjlWs9C0ule78cyip05cQ
XG0vw6eVBgLzCNRjhGcSOhOihQwEVEJzoGIqZpd6TcHeKVPXjd8SixdvO4gqQPHl
okzxg38VCs8A/+dL2O5p56FLdVTLhR/D4H3Q8x513JxmeGGMGi8/qERPyreoZGdE
0H4rs5IidYuhB4dnzsMuY8NrpLegmg==
=dsNE
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

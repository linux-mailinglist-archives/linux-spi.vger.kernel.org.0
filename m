Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07E120408
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2019 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLPLfA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Dec 2019 06:35:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbfLPLe6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Dec 2019 06:34:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CED7ACC9;
        Mon, 16 Dec 2019 11:34:56 +0000 (UTC)
Message-ID: <c52eac760b84b5518453df501fcbefe332109b7c.camel@suse.de>
Subject: Re: [PATCH 2/9] spi: bcm2835: Release the DMA channel if probe
 fails after dma_init
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, baohua@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     vkoul@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Date:   Mon, 16 Dec 2019 12:34:54 +0100
In-Reply-To: <20191212135550.4634-3-peter.ujfalusi@ti.com>
References: <20191212135550.4634-1-peter.ujfalusi@ti.com>
         <20191212135550.4634-3-peter.ujfalusi@ti.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sXE7sJg+XY/TFzJstkte"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-sXE7sJg+XY/TFzJstkte
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-12 at 15:55 +0200, Peter Ujfalusi wrote:
> The DMA channel was not released if either devm_request_irq() or
> devm_spi_register_controller() failed.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Thanks!

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-sXE7sJg+XY/TFzJstkte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl33a94ACgkQlfZmHno8
x/6CCAf7B+B8hZxRZRMeLVd8ul40vOlcF9rYKCysCJeIolLp9Y2o4IzUDv0K1mel
0z35UloEsK0lerWCQzf9nH6RbxBqfEE5NbQ/N2ewB9/+Ko1YXB/JkhbMx8ApqqoR
DFhBiIS9MjrKzpffIY1Wa8f2TRngNKJAGbUVYX2lpW2zhRpqDSaa61WWra+KzbNK
vBfmnO3NwN69bN7vqN//ES4MonAbxXm7HGwyI8okIzlwc+rZWympTUBgpwXfGGeC
R1OHlJZiexWOW1LID7wjOPAeYbbGEatKio3MBTOAU+Ccx1JTDzjlKx0AtwIqyKTd
Oc2YpUm1LThjhmtRyLB1OXGc+8edpw==
=JoZp
-----END PGP SIGNATURE-----

--=-sXE7sJg+XY/TFzJstkte--


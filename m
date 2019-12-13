Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C8A11DEEC
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 08:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfLMHyh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 02:54:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:48828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfLMHyh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 13 Dec 2019 02:54:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A01A0AC4D;
        Fri, 13 Dec 2019 07:54:35 +0000 (UTC)
Message-ID: <0949d65cf38c6c21f7b1565765dfc34def0b825a.camel@suse.de>
Subject: Re: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>, linux-spi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>
Date:   Fri, 13 Dec 2019 08:54:33 +0100
In-Reply-To: <20191212231213.29061-1-jquinlan@broadcom.com>
References: <20191212231213.29061-1-jquinlan@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5DTumPm2OHpOqZWUQ8Si"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-5DTumPm2OHpOqZWUQ8Si
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-12 at 18:12 -0500, Jim Quinlan wrote:
> Otherwise one may get multiple error messages for normal
> operation of a clock provider.
>=20
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-5DTumPm2OHpOqZWUQ8Si
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3zQ7kACgkQlfZmHno8
x/4fZgf9HkEjWQ+/PYekVxrIAJOea8gNqwD85mc8QG9VlGdic6z/NE8T30Ss9f5O
SEco4JkgPJKnLX4iJmoKNSo451iXLDCe330twWilQDs5HWu06OKuSmb9X96gJQHb
jJGB2unP+owneVegqK/xAv07qBzgsZiINyyjv9jtdv5Ox7P7ttY54vVww1reUPkt
rsX+Di6zUZGFpTO6vODp4P9XhB52Lc9TE0/NaDuPuF3+4SUlqBLKYGcHpKv90RVm
jT6nf9gPvyd09xeYzWg9G1ulMlGayFDzlKSDKj71cRVKKtpL35WBk1SzxGVMz4Um
KXBFtci2hzFOribpHa1c2tSM6aQOJw==
=7+Aj
-----END PGP SIGNATURE-----

--=-5DTumPm2OHpOqZWUQ8Si--


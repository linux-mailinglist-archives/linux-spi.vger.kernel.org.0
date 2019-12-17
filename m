Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5761227B8
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 10:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLQJaw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Dec 2019 04:30:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:44738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfLQJaw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 17 Dec 2019 04:30:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A6574ABC7;
        Tue, 17 Dec 2019 09:30:50 +0000 (UTC)
Message-ID: <f425ed1a4bf60210ddf9d85261086f29b5869666.camel@suse.de>
Subject: Re: [PATCH v2 1/1] spi: bcm2835: no dev_err() on clk_get()
 -EPROBE_DEFER
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Dec 2019 10:30:49 +0100
In-Reply-To: <20191216230802.45715-2-jquinlan@broadcom.com>
References: <20191216230802.45715-1-jquinlan@broadcom.com>
         <20191216230802.45715-2-jquinlan@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xKJQiabZRc/0guJVF0pi"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-xKJQiabZRc/0guJVF0pi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-16 at 18:08 -0500, Jim Quinlan wrote:
> Use dev_dbg() on -EPROBE_DEFER and dev_err() on all
> other errors.
>=20
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-xKJQiabZRc/0guJVF0pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl34oEkACgkQlfZmHno8
x/59PggAkwDKDFGnQVLG2P1CPv7wWeI2uWFf+BYGxCC6ihHCZneIrm0GnC2lu/L+
Cd/pHWawQ7RaCTsD5xaToQcxpmI7SWkxMpGJ5JzgKZ2OviPtyt/GsqCwTImUdr1R
4Dz3tdm9Ytb1GYSFUK4wYuIVdN5Tzhkxi4SwS2bS7uLHrJt3yROchm/gIPl/QdMI
ChRgun7gNpqaHG5ETgBTJWcS2Plhg6jCkXr3mx4/0q9BbL3lMBcOYG7qU+9X70d+
/phe8pXzgr1v9Zm1oFYu5aL6gPtHFszrYRsuvLEpu4RRyOCsQVaNj5ZyvJDMYbtv
mqRPO8n9wikXES4zBAc5A+XzBztQqw==
=HbAS
-----END PGP SIGNATURE-----

--=-xKJQiabZRc/0guJVF0pi--


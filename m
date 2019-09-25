Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1DBBE5EF
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2019 21:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfIYT5v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Sep 2019 15:57:51 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40855 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbfIYT5v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Sep 2019 15:57:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46dpkh5lbNz1rVv9;
        Wed, 25 Sep 2019 21:57:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46dpkh57sXz1qqkC;
        Wed, 25 Sep 2019 21:57:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id cr9k4nVtNq2p; Wed, 25 Sep 2019 21:57:47 +0200 (CEST)
X-Auth-Info: Yu5piwI6ei8JIHvmH/iv2EXB26CPdpNzMAt4N9ZIxqk=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 25 Sep 2019 21:57:47 +0200 (CEST)
Date:   Wed, 25 Sep 2019 21:57:39 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add call to spi_slave_abort() function when
 spidev driver is released
Message-ID: <20190925215739.6692ee89@jawa>
In-Reply-To: <20190925164517.GI2036@sirena.org.uk>
References: <20190924110547.14770-1-lukma@denx.de>
        <20190925091143.15468-1-lukma@denx.de>
        <20190925091143.15468-2-lukma@denx.de>
        <20190925164517.GI2036@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CKOQSV_mYnHZAmlMvZlX5hf"; protocol="application/pgp-signature"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/CKOQSV_mYnHZAmlMvZlX5hf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Wed, Sep 25, 2019 at 11:11:42AM +0200, Lukasz Majewski wrote:
> > This change is necessary for spidev devices (e.g. /dev/spidev3.0)
> > working in the slave mode (like NXP's dspi driver for Vybrid SoC). =20
>=20
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
>=20
> That said I'll handle this this one time.

Thanks for help (and patience).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/CKOQSV_mYnHZAmlMvZlX5hf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2LxrMACgkQAR8vZIA0
zr38owf+NfpYq4idAYaz+acP1zbwiI6XJ+N6XPIdsxu6mT8UYz0fEfStkeuiCr+J
YTYcu5Krtr7nWv12Dgh+kDTCDqp3Pn9I+mRwOxEz2O6Rr9GqcE17LX8sFeBWToRW
3MT0phpVUKPwO3jqke9uoSItQ66we4UjGArhgiq5c14GYWSJl0TTwRyDwpkXKB0X
TlkAE/8H5Hld5ioXglA056fnYcXXz7sPYXUMmw8cm0jGwjzLTAjWs/WzI8S89TQF
Y3S+QVnskhA+r+XoMFZo6wpelqZQD3RULU6K/4ryoUYyiN8Buo1XGrVZBOJvUpIY
db8l3hi11iraVVU2bFilUdc59nofBw==
=M3+b
-----END PGP SIGNATURE-----

--Sig_/CKOQSV_mYnHZAmlMvZlX5hf--

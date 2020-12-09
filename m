Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2242D4199
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 13:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgLIMAl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 07:00:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730997AbgLIMAf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Dec 2020 07:00:35 -0500
Date:   Wed, 9 Dec 2020 11:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607515194;
        bh=OtQ+HPmkmQDc74CDuz84WYDixTdrS25dyzPgEat+594=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzkIkOkkMX5xeFh8ZiTHIqKMWydjloGqT4FSIkD9U7y0eQPyp3emU+jkizeM/3k/z
         ykf9EwI1SQpoa9rJwa0h5foDlTvNKfGqEdLZpQOeRmbkDwahe6m7wkbho0/ZmTfyQC
         xhabwOQu+KqZE2MdQmo8hxlBJcE6lxRJRGlcV64Pb/qtxWerJVImYaT8EEKZR23f5p
         Vkq6DM3O80NreKUL45Ie/2ovtlvImGypvFIR5AwBeUkV8LNvlWPojFR9CVnnS8wqrE
         VsIuvVG19MtZS4U8dZlMVniN+y+TweGy4nq7ODEB8pCi0BolnRedm907xoRuluDZvO
         Zlqn2eFUTtr5w==
From:   Mark Brown <broonie@kernel.org>
To:     zhangqing <zhangqing@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
Subject: Re: [PATCH v2 1/4] spi: LS7A: Add Loongson LS7A SPI controller
 driver support
Message-ID: <20201209115947.GA4790@sirena.org.uk>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <20201208135644.GC6686@sirena.org.uk>
 <c916c525-7308-12a7-824b-7068fcead4cc@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <c916c525-7308-12a7-824b-7068fcead4cc@loongson.cn>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 03:24:15PM +0800, zhangqing wrote:

> > > +static int  ls7a_spi_transfer_one_message(struct spi_master *master,
> > > +                                         struct spi_message *m)

> > I don't understand why the driver is implementing transfer_one_message()
> > - it looks like this is just open coding the standard loop that the
> > framework provides and should just be using transfer_one().

> static int  ls7a_spi_transfer_one(struct spi_master *master,
>                       struct spi_device *spi,
>                                   struct spi_transfer *t)
> {
>     struct ls7a_spi *ls7a_spi;
>     int param, status;
>=20
>     ls7a_spi =3D spi_master_get_devdata(master);
>=20
>     spin_lock(&ls7a_spi->lock);
>     param =3D ls7a_spi_read_reg(ls7a_spi, PARA);
>     ls7a_spi_write_reg(ls7a_spi, PARA, param&~1);
>     spin_unlock(&ls7a_spi->lock);

I don't know what this does but is it better split out into a
prepare_message()?  It was only done once per message in your previous
implementation.  Or possibly runtime PM would be even better if that's
what it's doing.

> > ...releases the PCI regions in the remove() function before the SPI
> > controller is freed so the controller could still be active.
>=20
>      static void ls7a_spi_pci_remove(struct pci_dev *pdev)
> {
>         struct spi_master *master =3D pci_get_drvdata(pdev);
>=20
>      + spi_unregister_master(master);
>         pci_release_regions(pdev);
> }

You also need to change to using plain spi_register_master() but yes.
Otherwise everything looked good.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/QvDMACgkQJNaLcl1U
h9CCngf/Rl+jkJ0K2K1xYhjOMzRmzzc33799zyHp4rmIu0ueGJAlFY/K9vtZS5c8
DafdgOHKUbQpctdpytUVL3kLDFPzI0d2vEYq/PrU98XPVDUrb32j86/07Yk6gHJW
oahrE1oxXJsGwnFZb1e+OL2w/ambM7WOrBKmA4KCIzyk0jWmp+8X1ej1he/1GTzu
plO3NH9PuDcRG3qIY2fZdUS/Yh5jsuziZjomINZ84n9qZP/4jHjuVBHyVfST7wGE
VU2L2WDFrF/GQxuWhL7oP8xvSAkpIB040rBUeMbi/FLcoQVJTWQnRusK0DbHj2Kk
j7LqNtPQ51k/HEmBitErYhNpLyp3xA==
=gGOK
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

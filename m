Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4AA1EF357
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFEIrE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 04:47:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:42012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgFEIrE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Jun 2020 04:47:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 796BAACD0;
        Fri,  5 Jun 2020 08:47:05 +0000 (UTC)
Message-ID: <f728f55fe6266718b5041b6f3b1864a673991129.camel@suse.de>
Subject: Re: [PATCH v2] spi: bcm2835: Enable shared interrupt support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>, lukas@wunner.de,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Martin Sperl <kernel@martin.sperl.org>
Date:   Fri, 05 Jun 2020 10:46:57 +0200
In-Reply-To: <20200604212819.715-1-f.fainelli@gmail.com>
References: <20200604212819.715-1-f.fainelli@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mEv3c87MBb44GSiC5RXV"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-mEv3c87MBb44GSiC5RXV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,
Thanks for taking over this!

On Thu, 2020-06-04 at 14:28 -0700, Florian Fainelli wrote:
> The 4 SPI controller instances added in BCM2711 and BCM7211 SoCs (SPI3,
> SPI4, SPI5 and SPI6) share the same interrupt line with SPI0.

I think this isn't 100% correct. SPI0 has its own interrupt, but SPI[3-6] s=
hare
the same interrupt.

> For the BCM2835 case which is deemed performance critical, we would like
> to continue using an interrupt handler which does not have the extra
> comparison on BCM2835_SPI_CS_INTR.
>=20
> To support that requirement the common interrupt handling code between
> the shared and non-shared interrupt paths is split into a
> bcm2835_spi_interrupt_common() and both bcm2835_spi_interrupt() as well
> as bcm2835_spi_shared_interrupt() make use of it.
>=20
> During probe, we determine if there is at least another instance of this
> SPI controller, and if there is, then we install a shared interrupt
> handler.

As there was pushback to use a different compatible string for an otherwise
identical IP, I think it's a good compromise.

>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>=20
> - identify other available SPI nodes to determine if we need to set-up
>   interrupt sharing. This needs to happen for the very first instance
>   since we cannot know for the first instance whether interrupt sharing
>   is needed or not.
>=20
>  drivers/spi/spi-bcm2835.c | 61 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 237bd306c268..0288b5b3de1e 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -361,11 +361,10 @@ static void bcm2835_spi_reset_hw(struct spi_control=
ler
> *ctlr)
>  	bcm2835_wr(bs, BCM2835_SPI_DLEN, 0);
>  }
> =20
> -static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
> +static inline irqreturn_t bcm2835_spi_interrupt_common(struct spi_contro=
ller
> *ctlr,
> +						       u32 cs)

Keep in mind the new 100 character limit.

>  {
> -	struct spi_controller *ctlr =3D dev_id;
>  	struct bcm2835_spi *bs =3D spi_controller_get_devdata(ctlr);
> -	u32 cs =3D bcm2835_rd(bs, BCM2835_SPI_CS);
> =20
>  	/*
>  	 * An interrupt is signaled either if DONE is set (TX FIFO empty)
> @@ -394,6 +393,27 @@ static irqreturn_t bcm2835_spi_interrupt(int irq, vo=
id
> *dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t bcm2835_spi_interrupt(int irq, void *dev_id)
> +{
> +	struct spi_controller *ctlr =3D dev_id;
> +	struct bcm2835_spi *bs =3D spi_controller_get_devdata(ctlr);
> +	u32 cs =3D bcm2835_rd(bs, BCM2835_SPI_CS);
> +
> +	return bcm2835_spi_interrupt_common(ctlr, cs);
> +}
> +
> +static irqreturn_t bcm2835_spi_shared_interrupt(int irq, void *dev_id)
> +{
> +	struct spi_controller *ctlr =3D dev_id;
> +	struct bcm2835_spi *bs =3D spi_controller_get_devdata(ctlr);
> +	u32 cs =3D bcm2835_rd(bs, BCM2835_SPI_CS);
> +
> +	if (!(cs & BCM2835_SPI_CS_INTR))
> +		return IRQ_NONE;
> +
> +	return bcm2835_spi_interrupt_common(ctlr, cs);
> +}
> +
>  static int bcm2835_spi_transfer_one_irq(struct spi_controller *ctlr,
>  					struct spi_device *spi,
>  					struct spi_transfer *tfr,
> @@ -1287,12 +1307,37 @@ static int bcm2835_spi_setup(struct spi_device *s=
pi)
>  	return 0;
>  }
> =20
> +static const struct of_device_id bcm2835_spi_match[] =3D {
> +	{ .compatible =3D "brcm,bcm2835-spi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, bcm2835_spi_match);
> +
>  static int bcm2835_spi_probe(struct platform_device *pdev)
>  {
> +	irq_handler_t bcm2835_spi_isr_func =3D bcm2835_spi_interrupt;
>  	struct spi_controller *ctlr;
> +	unsigned long flags =3D 0;
> +	struct device_node *dn;
>  	struct bcm2835_spi *bs;
>  	int err;
> =20
> +	/* On BCM2711 there can be multiple SPI controllers enabled sharing the
> +	 * same interrupt line, but we also want to minimize the overhead if
> +	 * there is no need to support interrupt sharing. If we find at least
> +	 * another available instane (not counting the one we are probed from),

"instance"

> +	 * then we assume that interrupt sharing is necessary.
> +	 */
> +	for_each_compatible_node(dn, NULL, bcm2835_spi_match[0].compatible) {
> +		err =3D of_device_is_available(dn) && dn !=3D pdev->dev.of_node;

nit: maybe err is not the ideal variable name here.

> +		of_node_put(dn);
> +		if (err) {
> +			flags =3D IRQF_SHARED;
> +			bcm2835_spi_isr_func =3D bcm2835_spi_shared_interrupt;
> +			break;
> +		}
> +	}
> +
>  	ctlr =3D spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
>  						  dma_get_cache_alignment()));
>  	if (!ctlr)
> @@ -1344,8 +1389,8 @@ static int bcm2835_spi_probe(struct platform_device
> *pdev)
>  	bcm2835_wr(bs, BCM2835_SPI_CS,
>  		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
> =20
> -	err =3D devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
> -			       dev_name(&pdev->dev), ctlr);
> +	err =3D devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_isr_func,
> +			       flags, dev_name(&pdev->dev), ctlr);
>  	if (err) {
>  		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
>  		goto out_dma_release;
> @@ -1400,12 +1445,6 @@ static void bcm2835_spi_shutdown(struct platform_d=
evice
> *pdev)
>  		dev_err(&pdev->dev, "failed to shutdown\n");
>  }
> =20
> -static const struct of_device_id bcm2835_spi_match[] =3D {
> -	{ .compatible =3D "brcm,bcm2835-spi", },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, bcm2835_spi_match);
> -
>  static struct platform_driver bcm2835_spi_driver =3D {
>  	.driver		=3D {
>  		.name		=3D DRV_NAME,


--=-mEv3c87MBb44GSiC5RXV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aBoIACgkQlfZmHno8
x/76iQf/YhcuGS7sdr9nlK7KZasWwzVQMm4sUpwC4aTP2ok0f8XY2omANTcOMXPi
boV38p9L8EZnRCGxPJH5gcd+P+mzq7E36L0CmhXh0llna9Y0PCDNRiAun7xax26+
AdZ5CP5pxseRYL/hvDKGiErbDAaygtPFdxvo9u034SYQyQTnP5J8YxjTX0V0TTVz
NWPslb+n33JCLVrkFhoIsxr2sgW/dFJTaZ3V1/Bzj5Lktz4dw16ro4tCX86I4ltO
NlvwGVykL6qjn+j0dOvnx6JvHoI5ScPqzkCDXDwQJekTzitTIdiaD2e70AZZ1B+q
S0WCbZgciVz5xKBJn1sx5kPtsVZwng==
=mzr5
-----END PGP SIGNATURE-----

--=-mEv3c87MBb44GSiC5RXV--


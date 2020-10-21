Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6C2950F3
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503028AbgJUQjb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Oct 2020 12:39:31 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:45543 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2444312AbgJUQjb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Oct 2020 12:39:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E7FC1E22;
        Wed, 21 Oct 2020 12:39:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 21 Oct 2020 12:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=uOd/menMgG7CqlQhLT/5eeW1Y+R
        wDDwjyjNIgHo/ZfE=; b=KbDLEH9UMLSn40a0reKdhkx4PvWAMmKG702it+k4Gsm
        NgcGQV0izqcSh/VIRl8YvL+rXaXKnfXyIkdj8eN/VHrctD42nX7goUyyLfBxRl7X
        OFvpdf7Llg0kR+S0j5UfVparymqJImt3gMMD35CDcIqzcNo4LkE/cWQC1lQq89Ry
        A0qXFqh8mANZxFWj9X6iNUTxwWydT+zfltkGMcJLmkogwipAVoMjNaMqs7Lj0/WY
        HmLDdG2kMQUavAPolTnoEDCe16fvLphQMgzddW8x5Qum5S/0h2YkbarrrAGq4wcb
        0HTqKCBbWBar5VjR73ZTIM09azUw2FTla8h9+5cmJKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uOd/me
        nMgG7CqlQhLT/5eeW1Y+RwDDwjyjNIgHo/ZfE=; b=IWgAFdg0pfG/Je2DkTJBFu
        xGFVuxq70GW66ZW3NdtkFCkYs1p4kf4olN5lXj0gNk8S2quYUDvkoPNtMaE2eCvo
        Qj8aIIIOWWeYgwHH7FiGhBDiTMfmKrok40+/9/XlN6E2c19yakG38x6+YrVMd6BK
        xmHE+Ia6JujNKDjHg4ioiM4Rxw43fi2E4yKKx4VgG+nFixzyy+7lC2pMSdfQarqN
        HO3AjZrrZJqdTuA9gcfg0+oQatKXcS9/qTe82Y9oGDhvXeAn3IczisutlHDrUs9y
        TTe40/oe4tCzTQm13QJfQBVvCGi/3rUpEPZZIGJPR+sAv/llhw7y9QVGdeMGREFA
        ==
X-ME-Sender: <xms:QGSQXxNVMUEGXygGB8VvVmOtLgeAAWwc8dB8bz1kZdCB-HqdFPY7yg>
    <xme:QGSQXz9n6kNWmdBnKHkn43NupNvAO2p8KggMvbBDHma6zJc5iGjpU0hcRKFVJo4mK
    VpYdby9UbOnj1bO_V4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QGSQXwToBEvkz00hNB47Byj1PAcIv0H1JIYp-mb36nCKqYBmXl6wjg>
    <xmx:QGSQX9vNHfpeVOH8OWdx5fmyDuxc28knnE8sK0YCNIY7Bj-Y72SoOQ>
    <xmx:QGSQX5csyzGCrbHygo2z7ld3xj3hHJbTp-8Oxxqk-ibIB9LzPpa8AA>
    <xmx:QWSQX95-7cfLywNrCJGRBjGWeTe75QZYd4EKz3m-yJX2H2oVCEKFDA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 392813280065;
        Wed, 21 Oct 2020 12:39:28 -0400 (EDT)
Date:   Wed, 21 Oct 2020 18:39:26 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexander Kochetkov <al.kochet@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-sun6i: implement DMA-based transfer mode
Message-ID: <20201021163926.mjmup6zlx453brg2@gilmour.lan>
References: <20201015154740.20825-1-al.kochet@gmail.com>
 <20201019082129.myxpxla5xwoqwldo@gilmour.lan>
 <4B0B0459-DFCF-4307-8CAE-A2B579B0AF5E@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ehka34q2jomdseze"
Content-Disposition: inline
In-Reply-To: <4B0B0459-DFCF-4307-8CAE-A2B579B0AF5E@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ehka34q2jomdseze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 19, 2020 at 04:17:18PM +0300, Alexander Kochetkov wrote:
> >> +static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
> >> +				 struct spi_transfer *tfr)
> >> +{
> >> +	struct dma_async_tx_descriptor *rxdesc, *txdesc;
> >> +	struct spi_master *master =3D sspi->master;
> >> +
> >> +	rxdesc =3D NULL;
> >> +	if (tfr->rx_buf) {
> >> +		struct dma_slave_config rxconf =3D {
> >> +			.direction =3D DMA_DEV_TO_MEM,
> >> +			.src_addr =3D sspi->dma_addr_rx,
> >> +			.src_addr_width =3D 1,
> >> +			.src_maxburst =3D 1,
> >> +		};
> >=20
> > That doesn't really look optimal, the controller seems to be able to
> > read / write 32 bits at a time from its FIFO and we probably can
> > increase the burst length too?
>=20
>=20
> I had doubts if it would work. I didn=E2=80=99t know will DMA work for
> transfers with lengths not aligned to 32 bits. For example, if we init
> DMA with src_addr_width =3D 1 and .src_maxburst =3D 8 will DMA work for
> transfer with length 11?

Bursts are usually defined by how many transfers the controller is
allowed to do at once, so it shouldn't cause any harm if the length
isn't aligned, it will just do less than the maximum number allowed.

Whether or not the hardware agrees to that definition is something else
though, but from experience it should

> I expect that DMA fill FIFO with 16 bytes and
> SPI transfer only 11 bytes and 5 bytes will leave in TX fifo. I did
> the test and there is no additional data left in the fifo buffer. Also
> at reception the is no memory overwrites.
>=20
> I made test with src_addr_width =3D 4, src_maxburst =3D 1 and transfer
> length 3. Looks like in that case DMA doesn=E2=80=99t issue 4 bytes trans=
fer.
>=20
> For test with src_addr_width =3D 4, src_maxburst =3D 8 I had to adjust
> RF_RDY_TRIG_LEVEL_BITS and TF_ERQ_TRIG_LEVEL_BITS of FIFO_CTL_REG to
> half of FIFO (32 bytes). With the config DMA will transfer burst of
> half of FIFO length during transfer and remaining bytes at the end of
> transfer.

Yeah, that might need some tuning. With the width, I guess we should pay
attention to the order the bytes are sent in, but it can be done later.

> >>=20
> >> @@ -343,7 +436,8 @@ static irqreturn_t sun6i_spi_handler(int irq, void=
 *dev_id)
> >> 	/* Transfer complete */
> >> 	if (status & SUN6I_INT_CTL_TC) {
> >> 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
> >> -		sun6i_spi_drain_fifo(sspi);
> >> +		if (!sspi->use_dma)
> >> +			sun6i_spi_drain_fifo(sspi);
> >=20
> > Is it causing any issue? The FIFO will be drained only if there's
> > something remaining in the FIFO, which shouldn't happen with DMA?
> >=20
>=20
> No. It=E2=80=99s for make code patch explicit.
> Remove the change?

Yes, that also simplifies the driver since we don't have to rely on the
boolean in the main structure anymore

Maxime

--ehka34q2jomdseze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5BkPgAKCRDj7w1vZxhR
xcvzAQCTjn4Sk9vsA5WgKOIbFeV4pVd8yjgm+DYwTGVqHANt7gEApcXjt4GR66NI
er1nTKiTM2HDSQiO1nRg+fdP32fuBQE=
=3XQu
-----END PGP SIGNATURE-----

--ehka34q2jomdseze--

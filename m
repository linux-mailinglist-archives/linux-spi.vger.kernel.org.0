Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1494921575F
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgGFMgZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 08:36:25 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60369 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728885AbgGFMgZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 08:36:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F4545C019F;
        Mon,  6 Jul 2020 08:36:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 08:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=w
        TtYWDcph3Ojts4gXYtwqNFAyjySvYFK34ppHH/b6PE=; b=lxZsMtXD8shWZeY4i
        FDKOiZelsRsE26N9yN1RcEZad3DdNP5kEzR1dDli5erzgxesdxyGwkBU3xYsP6FG
        TN28LUrkZ6RYTRo5CZQjg8oTeCjs7lIKh2+6hl+XKcYJEzES6hLzWdfx2TgI9QNG
        aLLBoZM4adWtMIxF5hrRk+hUKXn582no1ohZlwcsPHN1guBwc1V7fWjilRjVpODG
        Jvkq9VY/s80bZZ4VgXpSoITNbdv0U9d4NHD85fOzoCyOhHBHLcm1oj8ZSG9deyad
        BK8kVgCuclB9SVWks7ziznQh+POVLJpScZhtwrOvBmk796RxrNrzIEgrcUMV63hY
        jQ32g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=wTtYWDcph3Ojts4gXYtwqNFAyjySvYFK34ppHH/b6
        PE=; b=mn3pq8KGCjIX2jjPWTassDochMm+wH4exZlKHhaf0Zqk+z570NNCPp09m
        O8tVMkXF90SqW/qeOz+TgG0H+vTpbxoL80Df+uOuww/Xpf0u1UKqxx8DvGb0lEqM
        ceB5oItpJsyyVmWDsHIdiGKPEmKoOwI+x5b6CaUGeO1PQ968nnfr3x4VZtD6KeXs
        7WVKteYBXvMD+qHRKI4U9fdjjq8fl0lOBuRd75QM+Ijz9yd2LXEhs8q2FYpf5lkg
        HoBMv9ZJsolmBMwY2vJ/nrmL/MBZmy7b6SG36wDeiPgKFSpyQJe4BvdFdtmJD84E
        +69SkHp/s+EKoyM7mHVWEviumOYUw==
X-ME-Sender: <xms:xxoDX1xQV7D7DSyNPsc_kYYVbxzvSeMfKACbzeAZnigI1X7UMdT8cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:xxoDX1T7JaxUCY-MLVR0rHyIRGqa2bfy5C5kNrxOQoezW8ORFUvPaQ>
    <xmx:xxoDX_XSyeyJJrwWBIN_qmuIDt7ZzVotq3Ns0v0g4g9v9vYQNdUgRQ>
    <xmx:xxoDX3hcNlqS9TAYVaiD3Yd0Ib_8sSRFMO8PbF8YzTl-leeYZeUySQ>
    <xmx:yBoDX6P-6KVP3ZYCMwNBDiBafCgBK3nZm7rqVYg6AXRZCwi9718wpg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26D2C328005E;
        Mon,  6 Jul 2020 08:36:23 -0400 (EDT)
Date:   Mon, 6 Jul 2020 14:36:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 5/9] spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce
 sun6i_spi_get_rx_fifo_count() and make use of it
Message-ID: <20200706123621.lm4htzmwg4zn6xzv@gilmour.lan>
References: <20200706071801.558394-1-mkl@pengutronix.de>
 <20200706071801.558394-6-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200706071801.558394-6-mkl@pengutronix.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 06, 2020 at 09:17:57AM +0200, Marc Kleine-Budde wrote:
> This patch introduces the function sun6i_spi_get_rx_fifo_count(), similar=
 to
> the existing sun6i_spi_get_tx_fifo_count(), to make the sun6i_spi_drain_f=
ifo()
> function a bit easier to read.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/spi/spi-sun6i.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 882492774986..f70d14229483 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -106,6 +106,15 @@ static inline void sun6i_spi_write(struct sun6i_spi =
*sspi, u32 reg, u32 value)
>  	writel(value, sspi->base_addr + reg);
>  }
> =20
> +static inline u32 sun6i_spi_get_rx_fifo_count(struct sun6i_spi *sspi)
> +{
> +	u32 reg =3D sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
> +
> +	reg >>=3D SUN6I_FIFO_STA_RF_CNT_BITS;
> +
> +	return reg & SUN6I_FIFO_STA_RF_CNT_MASK;
> +}
> +

I guess we could just use FIELD_GET here?

Looks good otherwise, thanks!
Maxime

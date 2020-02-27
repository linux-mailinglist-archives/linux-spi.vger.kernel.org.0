Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D219171841
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 14:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgB0NJm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 08:09:42 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36885 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729037AbgB0NJl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 08:09:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B03B2211E;
        Thu, 27 Feb 2020 08:09:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Feb 2020 08:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yor+QyML4LmVIrHIJGIRG278cW0
        iwanmWkHn1+jFaJc=; b=UQ0xZSfTyaF5IFYRSYWgJZiOKdPHXXpHTt9eFkSurjH
        Rzndv8elFIpz0vhItY624jyqnvHCWDQFfk1afdyQGQIi8lmQkwVTXe4WA638OJLL
        uwVFrViWjDaULRLixgjFgNxGTxzDAZ6kcQY9uoVU1WGwVKGNjzgjO1rwadeG/Vdc
        ACIwhule6PQGZWnF4UWaVSuYVCZAqM08CXN8hYLOk3aAeQ8FMJahuGSkPt4Ni/Um
        ZvxczxaUdMI/dQ2Jx34eGkY401HKJ2OiVsZNtGjq8/FUA/xPzmpeJxtX+Mnkpu0G
        nhs5P92v8Dfr/0VF9iYesEiqmcZw03WAz4UaiHUleAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yor+Qy
        ML4LmVIrHIJGIRG278cW0iwanmWkHn1+jFaJc=; b=zRrN+sr1LRS7vNy14SSAfQ
        31dHBTtB4xsiLRutJ5exW20wINEL9pnUSRuOef2Lnxa1VdGnXU5jHodDcvOkuO27
        g+1HiEwUXQbty88oI7zyrUOQNunHurbJW3n+fXab6U++MHZL6mGOG3rrJV1z53Nd
        qqT3+M6AsflLACzmS3EZaVVaw2Tz3mjUDR2ohU32HWbNoZ/E92Is7i5WvgmhQbPA
        9RTWVYI7TfXJ44D9v3vMUM7kmG33dRYvMN6NuXNcWuZerM3IoMhYdAhp2sa/HAOl
        6fMQolHBU8xjtPo6QD26+RsX5tLdLy2EW8gatxQJ3rC8TY/NJuchX5ZdXzZEO+9w
        ==
X-ME-Sender: <xms:k79XXphnTWgW5SJHM0KaGeHP5r--zaofFYSMWQSHjghbIyhlyw2Ovw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:k79XXsRjD06zmUqSCx8iOn5MgXHRaM6-DDxyuizs2CpawPZEVp3uKA>
    <xmx:k79XXmMTb-S-IWGQ6V1UOSFxDGDPfqwc2ixnD7HyogS0O18Gk9SF8A>
    <xmx:k79XXhF-2NJci0gdjbLmnPL_1hv-xD3qUHdzPXapFsLYci99c6Pz7g>
    <xmx:lL9XXlFPFyqkz-DeyMXNBqrpzn33wY8Ob4FvOSR2rmUxZjjBLKtCgQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 542CD3280064;
        Thu, 27 Feb 2020 08:09:39 -0500 (EST)
Date:   Thu, 27 Feb 2020 14:09:37 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Linux-renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: spi-controller: Fix #address-cells for
 slave mode
Message-ID: <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
References: <20200227130323.15327-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3mww5ct3acllifh"
Content-Disposition: inline
In-Reply-To: <20200227130323.15327-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--f3mww5ct3acllifh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> Currently, the DT bindings for an SPI controller specify that
> "#address-cells" must be fixed to one.  However, that applies to an SPI
> controller in master mode only.  When running in SPI slave mode,
> "#address-cells" should be zero.
>
> Fix this making the value of "#address-cells" dependent on the presence
> of "spi-slave".
>
> Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is this the right way to specify this?  I couldn't find an example, so
> this needed some trial-and-error.
>
> As of dtc commit 403cc79f06a135ae ("checks: Update SPI bus check for
> 'spi-slave'") and Linux commit c2e7075ca8303631 ("scripts/dtc: Update to
> upstream version v1.4.7-57-gf267e674d145"), dtc knows about SPI slave.
>
> However, when using "#address-cells = <0>" with W=1:
>
>     Warning (avoid_unnecessary_addr_size): /soc/spi@e6e10000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> Just removing #address-cells (using /delete-property/ in the board DTS)
> to fix this warning causes:
>
>     Warning (spi_bus_bridge): /soc/spi@e6e10000: incorrect #address-cells for SPI bus
>
> as spi_bus_bridge() uses node_addr_cells(), which defaults to 2 (due to
> dtc's ppc64 heritage? But node_size_cells() defaults to 1, not 2?).
>
> How should this be fixed?
> Should "#address-cells = <0>" be left out or not?
> Should node_{addr,size}_cells() in dtc default to zero?
>
> Thanks!
> ---
>  .../devicetree/bindings/spi/spi-controller.yaml   | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 1e0ca6ccf64bbd0a..ba2646258b94980e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -20,7 +20,8 @@ properties:
>      pattern: "^spi(@.*|-[0-9a-f])*$"
>
>    "#address-cells":
> -    const: 1
> +    minimum: 0
> +    maximum: 1

Nit: This would be better described as an enum: [0, 1]

>    "#size-cells":
>      const: 0
> @@ -52,6 +53,18 @@ properties:
>      description:
>        The SPI controller acts as a slave, instead of a master.
>
> +if:
> +  required:
> +    [ spi-slave ]

Nit: Usually, that notation is when you would do it on the same line,
if you want to go to a new line, it would make more sense to use -

Maxime

--f3mww5ct3acllifh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXle/kQAKCRDj7w1vZxhR
xa6LAQDPD0Wfg60jxmxXfYCq+tNY5iv4eAFrR9urmk8cbC+RHQEApi8ZLG+vDjzq
xNsvRO1hEXfievcydp8EPO25yCjeGQA=
=2Dh4
-----END PGP SIGNATURE-----

--f3mww5ct3acllifh--

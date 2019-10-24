Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B88E3006
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408031AbfJXLND (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 07:13:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405717AbfJXLND (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 07:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kxBq9eU5c+pynz4hCMtujUwkOF15d6QuZ5BX1XsZdfc=; b=PB1Zs1NjpAPp1u4Uw9oxpfc+Q
        vvZOTeMbkchUlC34r6Wa2/Q/Nov/zAlEKPV30ubvgiKmEMp8fwxNi5OjV1MFsZaBAaoNZZmupRVsJ
        qmoLMCwmELB3UhabdPU4NZY8m6lCQkqW6AutFu2y8XUOMoWYUbc81Kw9s7CbwEoCyruDg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNb37-0003NI-3z; Thu, 24 Oct 2019 11:13:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 47323274293C; Thu, 24 Oct 2019 12:13:00 +0100 (BST)
Date:   Thu, 24 Oct 2019 12:13:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191024111300.GD5207@sirena.co.uk>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20191024110757.25820-4-alvaro.gamez@hazent.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 01:07:57PM +0200, Alvaro Gamez Machado wrote:
> By leaving this value unset, a default value of 8 was being set later on.
>=20
> If it happens that the SPI master driver doesn't support this value of 8,
> there will be an initial inconsistency between the SPI master and the dev=
ice
> itself. This isn't a problem for most devices because kernel drivers

This will break things, client devices are working on the basis that the
default transfer width is 8 bits.  As I've repeatedly said if we have
different parts of the system with different ideas about the word size
we're going to end up with data corruption.  Please take this feedback
on board.

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xhzsACgkQJNaLcl1U
h9BNewf/SgKCEZWVH1yrKLieF/GMxsUxwqzetiY3EiQutLFXjok2pyjmP03nMA7s
0a554YBya1i29mV7kV9HI9dGOJztW0tj4pZaZB3eJQw3DQTPixdBt4sfLLBE2wdW
RjAy4kAb9A/5iro7cIpVUqa0eYc5yH5y6hs8gXQv3aI8OU8WDB3r6spYSAvbl0Ey
s4ea8XRLT6fk48ul+LESLJdOWShvM/q0SIyUg7IOBk/219pPlcBWnXrA1ttsWrB5
SYoTdtfcCocwvInv3vECNOPe9786EBAsdyQXA7ucvrdRqdifHA2UCGXaHwj/iwC1
7mq2rqHGU7ok+mtgLy/ZhpOzjGPPHg==
=uBZS
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

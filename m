Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8686CE3A3C
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 19:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503899AbfJXRkh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 13:40:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfJXRkh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 13:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=38D6aIWXdpZobEE28Qe0pvULa8PgIjrmUVlYVr/Dtzo=; b=UrwC+/oXjoR9QUbfvRsF7a4pX
        LfjSZFwkmu2MObkuAZHsxv8PkjFtmBacGXrvSyCqaTZ70Qhj27VgQacMQg2u9RtmsVAPCx4L5wDoB
        dK+rNLl2zl0v1qrq3r2xL0r1Eig61JeWco/XrWDcIk4mAYpf0t8WlVJS+aMoBg+d22UeE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNh6A-0003qE-EO; Thu, 24 Oct 2019 17:40:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6BD46274293C; Thu, 24 Oct 2019 18:40:33 +0100 (BST)
Date:   Thu, 24 Oct 2019 18:40:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191024174033.GG46373@sirena.co.uk>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
 <20191024131129.GE46373@sirena.co.uk>
 <20191024131856.GA32609@salem.gmr.ssr.upm.es>
 <20191024134116.GF46373@sirena.co.uk>
 <20191024140731.GA2950@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <20191024140731.GA2950@salem.gmr.ssr.upm.es>
X-Cookie: Filmed before a live audience.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 04:07:32PM +0200, Alvaro Gamez Machado wrote:

> I guess there could be some workarounds to help in that situation. But I see
> that as an hypothetical occurrence whereas I have with me a physical board
> that needs 32 bits in both master and slave that I want to access using
> spidev and cannot. Lots of I's in that sentence, I know :)

If you want to access this using spidev then add support for changing
the word size to spidev and use that as I think Geert already suggested.

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2x4hAACgkQJNaLcl1U
h9BOTQf/Y7I13e4P1YBoPchD6sUtdfHEdI1LvdVkRsWIXam2Vock1GHBwIl8bF4F
ydXeyJLBc40t4HvXLhFKIGG/09jwhtmlQhRaHJVAHlms6XjOFB1gNAXcA2m6HKxJ
5nxRGXhtoNIjDIIkSVCzmamNTQhG4qXreZU174YAsdLFKAvJji+izwZpXd3GLBs9
1lJy/3fjaAsHOwWVNrHwO2s4VmzA1pjzMq6CpbU0swPiud3/w7QdoCvNFnBglPMN
e7Rd3B4FBRYkky8v/4W6OtnfOrtJu4mOeh6qprLVUYZ6wv97fzb6w3M7RKVQ5IJU
6g03ZyB6h65BMkOgSJYoA22h3Iwi8A==
=RPG/
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--

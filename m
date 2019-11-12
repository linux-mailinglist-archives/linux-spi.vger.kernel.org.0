Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6321F8F31
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 13:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfKLMDL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 07:03:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLMDL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 07:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zS7SJkCQ2rdagNsuqJLgPUeeYlkcUDxC+YCP79gVVcs=; b=Vm6tHbcRwmv0hiGTfkXpgbLW2
        uX+VpT9VP7e91k9JhGcOSvlfk/wVbJZ6XBa1L4t3JYyWL+Kftf82r0gMOIVxxUMbei9/FpcOpKaPM
        bpiascTWFPsi0jEkuVHNzHC/i4K7RF8DRn1PCe28Ty+L9Tz+Q0vVlCEXadSktGy/KYABY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUUt2-0007nq-39; Tue, 12 Nov 2019 12:03:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 18A45274299F; Tue, 12 Nov 2019 12:03:07 +0000 (GMT)
Date:   Tue, 12 Nov 2019 12:03:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Message-ID: <20191112120307.GB5195@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20191112055412.192675-2-dmitry.torokhov@gmail.com>
X-Cookie: As famous as the unknown soldier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:

> +      interrupts:
> +        items:
> +          - description: main interrupt (attention) line.
> +          - description: dedicated wakeup interrupt.
> +        minItems: 1 # The wakeup interrupt is optional.
> +        description:
> +          Specifies interrupt lines a device is connected to. Typically a
> +          device is wired to a single interrupt line that is used as
> +          "attention" signal and also to wake up system when device is
> +          set up as wakeup source. However on some systems a dedicated
> +          wakeup line might be used.

> +      interrupt-names:
> +        items:
> +          - const: irq
> +          - const: wakeup
> +        minItems: 1

How will this interact with a SPI device that defines interrupts at the
device level, possibly more than one of them?  Especially if the device
has its own idea what the interrupts should be called.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3Kn3oACgkQJNaLcl1U
h9BxwQf9ECv4xZZXn5i2YxaBGMMCIQQ7dBHBaf+RX9PyyxRVwrhqaJb0Bn/Q2jfX
SUx5ocQAvXxWnQfWzcG/i6CsMSbwO5sRJhofRLcU2picVhHROMiYrjNcuXJD77SE
/te7BqRLAXWPCjR3Hi1KGnDLFa347byoeW2WV3txN7SWSKssa43NooJ2E/ahyeKY
nRiz2uivJ6utzuXNjwK6PdQtX+KboYNp3AgwbTBL0kDhLtwNPLoPUb76im4lYqvt
UVj3XRXlLxL1sVpy7Z6IUKezWxiCOUMl3winPd7gxZNgvyCz6dKnIFqtDc//cikO
GWsgGR1j7SZ92kVg0pEvgUNrr8X/iA==
=kE98
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

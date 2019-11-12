Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9982BF997F
	for <lists+linux-spi@lfdr.de>; Tue, 12 Nov 2019 20:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKLTPv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Nov 2019 14:15:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42854 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLTPv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Nov 2019 14:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X+Ml7G/CJ8hCucj1xuBcAsRonG+1DjY0KmhJXnb3RmU=; b=f7JrrVlyQx67xyqEEk23zdniu
        Za7K6+OZZD4BF8kjx18VBXPYS1UPb6Cw1p15meSpfbeXrEVOpeqqgdr4XtmESFTCIAsNSCRArj7vN
        yB4DqnHJV45OgAr/DxirdrMvY0TDvlsewUFBXny4sf4dQ8xr30ucswp2vsOHy4jR83/lw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iUbdk-0000BZ-N9; Tue, 12 Nov 2019 19:15:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E6219274299F; Tue, 12 Nov 2019 19:15:47 +0000 (GMT)
Date:   Tue, 12 Nov 2019 19:15:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Message-ID: <20191112191547.GK5195@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Content-Disposition: inline
In-Reply-To: <20191112190328.GA199853@dtor-ws>
X-Cookie: As famous as the unknown soldier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2019 at 11:03:28AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> > On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:

> > > +      interrupts:
> > > +        items:
> > > +          - description: main interrupt (attention) line.
> > > +          - description: dedicated wakeup interrupt.
> > > +        minItems: 1 # The wakeup interrupt is optional.

> > > +      interrupt-names:
> > > +        items:
> > > +          - const: irq
> > > +          - const: wakeup
> > > +        minItems: 1

> > How will this interact with a SPI device that defines interrupts at the
> > device level, possibly more than one of them?  Especially if the device
> > has its own idea what the interrupts should be called.

> My understanding that individual drivers should be able to override
> whatever the default behavior core has configured, and the device can
> establish their own mapping. We have this in I2C and I believe this
> works well.

> Is the concern about the device tree scheme or SPI core handling?

Both really.

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3LBOMACgkQJNaLcl1U
h9CnHwf9Htk5j6XICHic0T7w226CHXw6GyCY2GGe/lT9tLxvwZ3EzGstAu+8+G48
OG6Pn1Q23bQOevOGt8/oQ+f00yv+RXIipY4bgKIByUBUYSgP5ZWN7VzRVoa/ve4B
HoDoae5kWda/AEC5TRzKadcKcXbO3X/pM+QijqtzDOWLRavWvJ77pjPPZy+4Rzfq
Cii5vzHLiI9Xtn1COJfBPQPZHAPgwy13gN68XkQKt81F6NcuDI/i6ZbdvwWIOqPu
d2AW56WXVQ6o7aPCOP0yWqjILrGXVaJkwB5aM1Br4ukvKJQPiR4JxP4bPETrV4Aj
sBDrQVqj+Kx7vGo2uXDA6cVVy9ELXA==
=pW4A
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--

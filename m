Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392519769A
	for <lists+linux-spi@lfdr.de>; Wed, 21 Aug 2019 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHUKBo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Aug 2019 06:01:44 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:35535 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfHUKBo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Aug 2019 06:01:44 -0400
Received: by mail-ed1-f97.google.com with SMTP id t50so2284115edd.2
        for <linux-spi@vger.kernel.org>; Wed, 21 Aug 2019 03:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vt3hl32Wz0DMATAFnUait/ZG+Wsfgs0SkPaRZ56S6g4=;
        b=kv+xQxXs1fLOGV2iJRNm4rK4EP9ZAIayOSSUymF2bgInqYSObRc6FtfuIzCiPYI1A0
         DQb+r2ljWCXG6qAOBOyJay40JMMdkdMISqZuEmwbdtSEZe9m484UZQSiaC0DRo/KQBH3
         uiFCuQ6UQ4JCmlSrlb3XAJFI6ItWocS+fQVtqvJNoZTErvWFgbTS1kwPr5LnQbCPjLaX
         phyMpI+uJLK4a+tNBBIuVCoyqFVVUI8pA+2nZIbfAKmMiIPs+n/X6ky5F5nET+kdSWmc
         Kl3edrfBtjWVsYudOET9JHVeoDbsuCJUX+jpbuR5L6UhW4LzNoF3WobeQ77ErPKJdoht
         f5RQ==
X-Gm-Message-State: APjAAAWjHfdUq8sYsvG/v2Z1QvUKw5k8czJ2UZbjtdZxGXeOxRrX/dvP
        W3H6JK/+hgl8MDnN9oVSVBzMWeb/DXvNmr0/bVfu+BN4ymbQo48w4cUzJgMK1uZ3/w==
X-Google-Smtp-Source: APXvYqxSEEtnvxgKKD/LtfEzqdrrKVVf9fFmsZa2zcaS3Oxn/H3e/n8YEs1CShxG1wqmuOIRknaoeY+DH/VS
X-Received: by 2002:a17:906:30d8:: with SMTP id b24mr27162486ejb.33.1566381701966;
        Wed, 21 Aug 2019 03:01:41 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id v26sm198026edl.18.2019.08.21.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 03:01:41 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0NQz-0006e8-6t; Wed, 21 Aug 2019 10:01:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id ED5472742B66; Wed, 21 Aug 2019 11:01:39 +0100 (BST)
Date:   Wed, 21 Aug 2019 11:01:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH spi for-5.4 13/14] spi: spi-fsl-dspi: Reduce indentation
 level in dspi_interrupt
Message-ID: <20190821100139.GA5128@sirena.co.uk>
References: <20190818180115.31114-1-olteanv@gmail.com>
 <20190818180115.31114-14-olteanv@gmail.com>
 <20190820130257.GD4738@sirena.co.uk>
 <CA+h21hqCyJ4WQgP31gcMq21k6wG8YQmbg0BZKwh_2YKvWKY5RA@mail.gmail.com>
 <CA+h21hoYv=a5qm4ewB7ey2K2N5Uv5Wm9G2fELX_0ukJZcdXbQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <CA+h21hoYv=a5qm4ewB7ey2K2N5Uv5Wm9G2fELX_0ukJZcdXbQQ@mail.gmail.com>
X-Cookie: Sic transit gloria Monday!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 01:49:15AM +0300, Vladimir Oltean wrote:

> But shouldn't it be returning IRQ_NONE in that case? Right now it's
> returning IRQ_HANDLED.

Yes, that's a bug that should be fixed.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dFoEACgkQJNaLcl1U
h9DnSgf+Nk0c3hb2RRP7T4GqsASOUak5DN5tOUElAG+ZaBNiN+VQFh8mqE+w/NL+
Cd+KjYLc+yj+BkihN7I6fpf+hxzAlRzSWThH4NwfljM8CtYlzK2NyL8fwuCvvTaB
6Ah04qoXGhuXJDo7I3Kn2tZfbUovGJ3eFr3behpvWrxVPljSayzRj8jkTJYQPBcn
s0Vs0K9FdnZM1rE6sGqvrGXekuVl9SJlAGfd0ER86nNDAA7zNsdjLB3ESCoa8qgS
L4Bq1OCvlF8LeBbTi5A4LszbN+uaePmGhPKdQfo9ImLpLbMBRX+fc7zfO1ImdLth
3aqmSSbpUi+hr3ANCwfxJocYYEXrRg==
=/kcW
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

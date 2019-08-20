Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3895F4B
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 14:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHTM7Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 08:59:25 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:44371 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTM7Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Aug 2019 08:59:25 -0400
Received: by mail-ed1-f100.google.com with SMTP id a21so6208091edt.11
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 05:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UnziKJs80vCjHVt3Hfv/aD4JEcua8AtfebgcUYZuNKU=;
        b=XU76BisQbfoS5qoJezzzUBfiF7HL2nkJTJBfB7pFFe7IxMc0Syt+xZ5KDB4/lF+Q7f
         ruB6FhiQrr3FBRzwsR0gfz+aTdic2rne8WT6l6WtbN7khqq2yznrX79HWgdPXZF+3rIv
         ID/fu4spYTZHFFY1RPPmksyL3ytE9D2fjXsH1WwXmCsDbklodjGTB6kXYmoKCllrBqGf
         QEGlJhv5fsffrddL3kc5WeTUJRf2nyTPmilcJfAUDZYLvaIkSUBtBx0gVa7dDYVvY1cQ
         HD2Tp5mHQ4hDIFlkF2mEL6oirWafpPSJlep/w39fl4BCbCKDkNMDYeOU+UKas2fID7xr
         5X1w==
X-Gm-Message-State: APjAAAUh/5vso5CHqlwKX/aLzj27sWW5A/f4YNybAkFh8iaAdAVH7Skg
        LSKiVnXB82fwfVn5Xf7SVgpdygOeEVN2bmn/KLRiL7Xd+NsbS2Ib/Vst8IYWi8mg9w==
X-Google-Smtp-Source: APXvYqwF/mNEg5xdbhsmLCp5B6GhVNl+ct8gQ+V61t/NLTwULly43PlV86Aw7So0bP0W9owfW9qnM9MVNcMn
X-Received: by 2002:aa7:db0a:: with SMTP id t10mr28512674eds.17.1566305963649;
        Tue, 20 Aug 2019 05:59:23 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id c15sm204660edy.9.2019.08.20.05.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:59:23 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i03jP-0002FU-3h; Tue, 20 Aug 2019 12:59:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 70D632742ABD; Tue, 20 Aug 2019 13:59:22 +0100 (BST)
Date:   Tue, 20 Aug 2019 13:59:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH spi for-5.4 14/14] spi: spi-fsl-dspi: Remove impossible
 to reach error check
Message-ID: <20190820125922.GC4738@sirena.co.uk>
References: <20190818180115.31114-1-olteanv@gmail.com>
 <20190818180115.31114-15-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <20190818180115.31114-15-olteanv@gmail.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 18, 2019 at 09:01:15PM +0300, Vladimir Oltean wrote:

> dspi->devtype_data is under the total control of the driver. Therefore,
> a bad value is a driver bug and checking it at runtime (and during an
> ISR, at that!) is pointless.

> -	trans_mode = dspi->devtype_data->trans_mode;
> -	switch (trans_mode) {
> -	case DSPI_EOQ_MODE:
> +	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
>  		dspi_eoq_read(dspi);
> -		break;
> -	case DSPI_TCFQ_MODE:

The other reason for doing a switch statement is that it makes it easier
to add new condidions if more modes are added for some reason, the error
check is a nice side effect for robustness since it'll detect memory
corruption or other bugs but it's not the only reason to use this idiom.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1b7qkACgkQJNaLcl1U
h9BEowf/a/tm1wVUpYZ+BYnk3uZzhKAoLDIYycEiVkUWOQgKMpg32Rz6uvzgmZAz
qCo/zC/cciSMj1ELkVxn6FcoThDbiPKFCDR3nwLaBZ0g4RxwBBQSZ6TO1fC7wA7Z
mslZ7kl/4qdRfQxLydBhamxfzcb8SqUfE0Zh0U/T8weMMv8XJsyHqYo6YlaMo1Dz
C4gMrHs2sF5mgjfkP+7YjaynDTIVfDV+7QLkImDZl0JzHnzLS++2amFfUq9HrHPO
5/h1kT29LcydeK5zAzqKw0UqHeP/vHi37seiHT3mqqAb4H3kWPUsdzRZ8jJoogyn
gxbrZldj3ooptA0QbFFnNkAnjhJHSg==
=1bR0
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

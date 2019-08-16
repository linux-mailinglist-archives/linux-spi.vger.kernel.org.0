Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D6E90136
	for <lists+linux-spi@lfdr.de>; Fri, 16 Aug 2019 14:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfHPMSk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Aug 2019 08:18:40 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:33562 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfHPMSk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Aug 2019 08:18:40 -0400
Received: by mail-ed1-f97.google.com with SMTP id s15so4982679edx.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Aug 2019 05:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQi6Hr8QVAwL/OcjjXHQ7e3FDQKZyWG4jpVl4xyx0WM=;
        b=gnzboT8BJn6YcNZHlZOo8vXZFm1LAtXzeOhktgGHffKPeQyUSFdA+KHQKxuWhDTp6U
         zwTUnLt167d4Jp6mLN3KSyJCI+MfFmMaRBsYgM1gAHBhzdSOCSwTYq5v1fPOKOJZ1fcs
         0QoUau1AJspwojuDGJqbJryXZmv2QNgKkiVN9xJbuZVanC12IDM3souVSUldvquSOOuV
         Uykdh3478VY4pBqU255btjFMhpMSe410BU3PdU1NmNCP7hoeQNwOYfPOns/+0FGaxMB5
         sODpDbjeejtt0rgycX/6wJBD2jlA+gFhQSSqq3rvG9UEugqOfHheo38HimT2cs7QsfBy
         B2bw==
X-Gm-Message-State: APjAAAUlhUOvayUc/wTgAz3oJ8h/0MxwhVelMdjHrJgTbeBTkPvCCnOE
        FsqggdASp+T2Ga2iIvLrePT2expPKGcTLSqC1+cs4Oa3mMRrSQ/n6TubEr7SX/q+AQ==
X-Google-Smtp-Source: APXvYqzBU4078lVt/vD9xKkrFgGaipVSPwwRnC3vbNrF7n5F9O6bdjccgv8jAuYQqjXdq7AuXIWEiPOMeCxK
X-Received: by 2002:a17:906:8481:: with SMTP id m1mr8875891ejx.43.1565957918833;
        Fri, 16 Aug 2019 05:18:38 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id me22sm33418ejb.69.2019.08.16.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 05:18:38 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hybBm-0003OX-E8; Fri, 16 Aug 2019 12:18:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A5A5B27430D6; Fri, 16 Aug 2019 13:18:37 +0100 (BST)
Date:   Fri, 16 Aug 2019 13:18:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next 03/11] spi: Add a PTP system timestamp to
 the transfer structure
Message-ID: <20190816121837.GD4039@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-4-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <20190816004449.10100-4-olteanv@gmail.com>
X-Cookie: My life is a patio of fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 03:44:41AM +0300, Vladimir Oltean wrote:

> @@ -842,6 +843,9 @@ struct spi_transfer {
> =20
>  	u32		effective_speed_hz;
> =20
> +	struct ptp_system_timestamp *ptp_sts;
> +	unsigned int	ptp_sts_word_offset;
> +

You've not documented these fields at all so it's not clear what the
intended usage is.

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1WnxwACgkQJNaLcl1U
h9D8nwf8DrLh/nyypE5Z9eyCgD6tjtuKC/OLPBwFr+Ok3tAYfcVFUJ32DJ8ZsCMh
U3HfHE/KSUK/VgOCv3d6iuNk/2fozEYiFgggeyqoDagiyssXjNSFQwaBI1jNh/8A
9gG+00aG06VCwcYtFPeXNZGyv1ifPFZOuyuwZjIyM9Wfl4B4CbX3o+cxGBhpHQvE
F1Nn4b4/rttBYAmxt5whDtU6ZgGnilVy9i3naqH5bO1ZPR8Mi3i8lOtntBetVVHG
obyEBNVcgWAfxcuHoGZnQXRVJjYicjNa3odkE971eZnqFJlBlQdOWZc5sOpdVFrs
/3NmdZUt9i/YniIdFEhbJ2YM954ivg==
=C5En
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--

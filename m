Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9090146
	for <lists+linux-spi@lfdr.de>; Fri, 16 Aug 2019 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfHPMVG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Aug 2019 08:21:06 -0400
Received: from mail-ed1-f100.google.com ([209.85.208.100]:33875 "EHLO
        mail-ed1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfHPMVF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Aug 2019 08:21:05 -0400
Received: by mail-ed1-f100.google.com with SMTP id s49so4984367edb.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Aug 2019 05:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKhOd3WCCS81mToTkVuzJS8ppaBmXDvx6Wnxxnym8UA=;
        b=Xvj7+CN4e+UTPkZO7n6HOfpotYWiZDqTybK+GGbJVRmoR6+yzR15eeU4HiO1uOaBuU
         ZABSaXq5z12xY6V456O7m/oJr8LSJwoaigMadboHEVV3gS+BndZu1WKTVyvwbftwRNkF
         5BYX6Hs38Xo4NwxJsErP2Fczrlzr3FPbA+1XKNH8jWLDMMBu0h85Y9EELDAcJ9IySyuw
         26maRNLxEDQrUX61KNrOEa1q5AYUebr+jusIMfjYOIjt56O8jmve0sHxAGTAd+RdD5EP
         +gyRntmi3nZ/TnsDljxDNSJYHCuJoDGhusVqJXzPRf7/PqMDYg7sc+8WM+/duR1A4q/O
         Ohhw==
X-Gm-Message-State: APjAAAXd8PkFUYKp6WgU9krQ7DUAVpEjTUjr53JKyTlwOmyjwueor7a/
        WGlPhkecHPyFJX59SKzhu0ym0s+uXva/bnEyT8PhcEpL1L2K9Of8SKTbb+hWhzW6Vg==
X-Google-Smtp-Source: APXvYqyFDPVRuRVwUVQN1kIePjFpx4dlJQLiWIWPHH9631C2TJn6okaPRQ51znHz4j/5JNjE11Aw/HA9rtFA
X-Received: by 2002:a17:906:1303:: with SMTP id w3mr9048193ejb.143.1565958064263;
        Fri, 16 Aug 2019 05:21:04 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id o23sm21973eja.23.2019.08.16.05.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 05:21:04 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hybE7-0003R1-Un; Fri, 16 Aug 2019 12:21:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2D12127430D6; Fri, 16 Aug 2019 13:21:03 +0100 (BST)
Date:   Fri, 16 Aug 2019 13:21:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next 04/11] spi: spi-fsl-dspi: Cosmetic cleanup
Message-ID: <20190816122103.GE4039@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-5-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <20190816004449.10100-5-olteanv@gmail.com>
X-Cookie: My life is a patio of fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 03:44:42AM +0300, Vladimir Oltean wrote:
> This patch addresses some cosmetic issues:
> - Alignment
> - Typos
> - (Non-)use of BIT() and GENMASK() macros
> - Unused definitions
> - Unused includes
> - Abuse of ternary operator in detriment of readability
> - Reduce indentation level

This is difficult to review since there's a bunch of largely unrelated
changes all munged into one patch.  It'd be better to split this up so
each change makes one kind of fix, and better to do this separately to
the rest of the series.  In particular having alignment changes along
with other changes hurts reviewability as it's less immediately clear
what's a like for liken substitution.

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Wn64ACgkQJNaLcl1U
h9D5Bwf+OKuQMiT2y6NsdVvC4VV6RHVuXDYQxs3lIWdb2gLw+ikQZum3e77gvc+Z
If4Yc1d+XAwqFbrD81a522yH0cyGfWIed/Hlmc6CwkKMZC1j+0ngO2PSIKeBdZzA
cuVlqNjke4qPs6lsNcBN9tig3A7Qer4de9hkCCtctdPGBalJSBprV+ow85cjyXbp
4wvnTojb1EzWCMplDPvoTeAGgZHZjsfp5lpf+eTI+isYBjRFeyokFvsosUZiMdZI
Wi+o/Swe1nL/6jM8+EVmJpUzTUDtT191cSM4KaHEifU9zXdrSk1ss09wlruRAETy
ACNvbL2isq76eFbeLwIwtDqf/mfaaA==
=2xml
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--

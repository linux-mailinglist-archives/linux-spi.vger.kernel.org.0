Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4551992087
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2019 11:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHSJjZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Aug 2019 05:39:25 -0400
Received: from mail-wm1-f100.google.com ([209.85.128.100]:35857 "EHLO
        mail-wm1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSJjZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Aug 2019 05:39:25 -0400
Received: by mail-wm1-f100.google.com with SMTP id g67so1001108wme.1
        for <linux-spi@vger.kernel.org>; Mon, 19 Aug 2019 02:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WeRCYbnC49nzDGcOwMW5+OBfIv91cqI3gHen+TmnuTQ=;
        b=Z/7qsXgkcheArcHLQvnCVCo/QeQG/fuP/uWgD1hYRLuleeAVsYi+E5X3xFbtab5eEn
         rS9NKhv4lU8YgrY3/y6FsFXJRPPKR434NXva+I+7Oz8vvJPd/af+gIUq7RdEJ2ssfOWc
         PM/eowxGttBFOC3WzG4m0189RIzVRIyoJUfo8QVgPInyUsX+kX6TuvscRGYnx2PS1tfh
         4VR/NsWYtqduIeU9fYaGoBrSMQpPTg6AXL+bicqtVTMA3hUYCI1ydEuTal8xk52pOjk6
         D9fuTpmauFDGf2sa78AwnNMZHbDE1EHS7oZIBcz3Hjknv+yzk9ncMwhrAMxg7XfiESGR
         MXjw==
X-Gm-Message-State: APjAAAUC25htaKtMio5b17p7SqfAO51sqK27Dsa6hsSZcAcJHfX7snIK
        Tes9YWkHj7L1LS5y8DckDpGbAVKscQoa9O4sNGNPiUUaW6tl5wz7IZ2uv5UgMEhweQ==
X-Google-Smtp-Source: APXvYqwVHW0WBA4o/5WxcX9fnGl4jJVmllRuxsDa6L9c0H5Lg6ThxnTOG9MBSDEjjpDvhuz08ffEccNFNVtk
X-Received: by 2002:a7b:cb0f:: with SMTP id u15mr18287291wmj.173.1566207563316;
        Mon, 19 Aug 2019 02:39:23 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id x5sm278158wrr.58.2019.08.19.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 02:39:23 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hze8I-0004U2-T2; Mon, 19 Aug 2019 09:39:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D2FFE274314C; Mon, 19 Aug 2019 10:39:21 +0100 (BST)
Date:   Mon, 19 Aug 2019 10:39:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH spi for-5.4 00/14] NXP DSPI driver cleanup
Message-ID: <20190819093921.GA5563@sirena.co.uk>
References: <20190818180115.31114-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
X-Cookie: QOTD:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2019 at 09:01:01PM +0300, Vladimir Oltean wrote:
> This patchset was broken out of the "Deterministic SPI latency on NXP
> LS1021A-TSN board" series. It contains a few driver cleanups (mostly
> cosmetic).

Please don't include all the extra tags you've got in your subject
lines.  In my inbox this series looks like:

    790 N T 08/18 Vladimir Oltean ( 16K) =E2=94=9C=E2=94=80>[PATCH spi for-=
5.4 01/14] spi: spi-f

so I can't tell what it's actually about just from looking at it.  Just
[PATCH 01/14] would be enough, putting a target version in or versioning
the patch series can be OK but you usually don't use a target version
for -next and adding spi in there is redundant given that it's also in
the changelog.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1abkYACgkQJNaLcl1U
h9AKkQf+PqyjEad47Y6WM6ie9TyhOFMh5XRXCy0pIhM/tCGPMY4wE+i/MgCbFevU
3LXJMIkqxQHcQsQBeKYOiy84Zbtot+odSUWuLXzblrlvyEChcMFX4/RUgjnGh+yD
SewqnDkZtb0nw8+i7Q9PSE/2w44FtdYHQRzgd9gavchPHgYMTjp8g5GVclFgFN3x
/MFELlDgHza8L1BzcgaOElsDDiIxg4ZbbBDCrxHYA52RN4eL8MkTbhrxQNsG279F
8XIePDM+57MtbShRgpXB67+xIX0b2x6OPc1Dstu+1vQGtrNDhQOWutoROk5YRHRL
VR+gsGk9pFcwv7V+oKX67JRfzMSI9g==
=OpVZ
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823CD34C49D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhC2HKQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 03:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhC2HKA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 03:10:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AABC061574;
        Mon, 29 Mar 2021 00:09:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so13023628eds.7;
        Mon, 29 Mar 2021 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8EPqcs4lhEPj51fKobc7SeG/GdrCBROeNix2wAvAO8s=;
        b=NJeNSszf9STJ/uTyzLNxz2oALfLVFwMa8vlQR9mVSDfZz7aiNKVW4rZKu8mCDoUcb8
         bK6hKcSxwlSuyL66vpl9/8vNXkrE7aHsAVvQ0sw+yYcXG2O3SJSve+MLl1jASD5trR6p
         +lAtQ0LC8L+6E8s7ZBEpI7hrY6segCMZWvWCKJC7u8S+fQ84GG5HDV+0GStbisxOv0B9
         Fioa2ubwZ70YUpYikDtMLInpU+wZHdnt2a+8YY6V1FvSayn16sqpTcP37/BuA8h99C+V
         o0HopJQtMCFrXEF04AUAk/8h8xG8ynn8aDQ0Ey2urQ7tDMhicx/LMVSp5KNQUxLZ6um2
         hUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8EPqcs4lhEPj51fKobc7SeG/GdrCBROeNix2wAvAO8s=;
        b=WQw59R8wq1D7pcSJY9qr0NN6jxM5eCLp2Sfzpb9ayNP4naszQYUxS+3JPgNR1D7kWn
         p/+AHr7PNFAzZF39FChTgUPSMaCD+I7xRyaYjPtDB+zPo1McNYi/4o777AS04yQEYl7k
         q5P8W4wQ4i4P7WyLSSABBLlZtkdaK4reGYsfVJUMZmNMEH/uXBEYdE2q6X9xs3csMzgl
         j9TM3UBzpDLMTaZYLgs1q1oTAxUuoYX1lopOdzEuzeRQlfnMrGnjxlZ/+IE+StRWrE8L
         LVDNq8a8nVecDcQWHwz489eI8nTc9lPtBElYSf7Khge7mwVqdZ1mgpWhkk0g7AQdUxA9
         TOkA==
X-Gm-Message-State: AOAM5323sMGozIyyahKgXwPqDeV8cNLeXrN87EBgbEwwlw5NJ60UoTil
        6+XwTmyGbwuZb2BFWbntni5rQKlkUPA=
X-Google-Smtp-Source: ABdhPJwB7mXbSet2+Q59IdP9PhlFHXAXslHRcTy8lBrIWJXZaPTE/B4OTmnHvl29cCarPWFBRcp/Eg==
X-Received: by 2002:aa7:dd97:: with SMTP id g23mr26854096edv.154.1617001798142;
        Mon, 29 Mar 2021 00:09:58 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b4sm7628441eja.47.2021.03.29.00.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 00:09:56 -0700 (PDT)
Date:   Mon, 29 Mar 2021 09:10:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: nvidia,tegra210-quad: Use documented
 compatible "jedec,spi-nor" in example
Message-ID: <YGF9XcEkQGU/HWfv@orome.fritz.box>
References: <20210327203357.552794-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AklUVe8lhldcq41s"
Content-Disposition: inline
In-Reply-To: <20210327203357.552794-1-robh@kernel.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AklUVe8lhldcq41s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 27, 2021 at 03:33:57PM -0500, Rob Herring wrote:
> The 'spi-nor' compatible used in the example is not documented. Use the
> documented 'jedec,spi-nor' compatible instead.
>=20
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--AklUVe8lhldcq41s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBhfV0ACgkQ3SOs138+
s6EHAw/9GNeVaHkoLSfjhUjshuu9RoNledRj5+lp6/VZiBDq4GAoADW2NsK2mbEO
ljrU5OwaV+Vw+yMn2XzHSVZr1YQF/xhlDYrNaawKXQJu2eDqJ10k/wMuDzA6LpgZ
pczvVi2T6p01Lk9KGvoyT29w/3coDDJSPOBUfKVYbZbJqCSkym8P8SWpOUAP0rIv
pH448ArFh3oM2y8T2R4f/6nVLrKkmb3qDfPKqeSDudzUvjfJ7g2cmCLUD/5C51br
fReiqRY0Wfn0fo7gw6IRIZvPnSbdujZ6PdIxSBfDm9bJIvp6LeKO6blepFra5JdQ
1nSLFB447kSeQSmwVIkoNwjjAIhhmLnFvD2OV+xNP4xyDfGlhmT3/iUNZN+pZ7sS
AOYnpDuSGeHH6XI+n6wTdENPaVV6z15RykEf7/p2YUl5F7zRdL63fQlZpiC2zl/K
KvgNF3j+TpDSk95obOum6hShBIfj2uJqYyNZH2q4NJMLnCQHLQOPVlcFKVGu+5jR
QCRef13F4Y3u+lhuyqarBw4pOdcHFHH4v3ONJiRw557aJtxgM7CynA65sq6e8aaC
orQ83KbCHIyx0ApsSXi9Q2n1lIfVQEVk8gj5AqLyjV2/u83bvyxMWLBw/A8T0PM8
z+pDKUN+Xb2qJia6dXt7JPUlxr4/hXMGkEgayzfZIKdnOXJicGw=
=bW8s
-----END PGP SIGNATURE-----

--AklUVe8lhldcq41s--

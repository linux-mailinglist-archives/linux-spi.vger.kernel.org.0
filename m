Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34EA610F91
	for <lists+linux-spi@lfdr.de>; Fri, 28 Oct 2022 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJ1LW1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Oct 2022 07:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJ1LWZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 07:22:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63526754AE;
        Fri, 28 Oct 2022 04:22:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n12so12131354eja.11;
        Fri, 28 Oct 2022 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIxrQ8E1bPnZiGDXaml/48HhptzuynLApLQoeNm+bQM=;
        b=H2GyWOXWu3amGHhnRB2vDHYVTLeiiIFTuhWlxGA7WXZk8cfDmSMuCwUqNkjr5eJU26
         vwTb6szkVh9cGKikWUWtM01l2C/qV0Kg9Ko4aBb8uesfuRE+mpCGbBgy1ySZH+J6Y+UT
         rao3qgQHSOgEACEScRgbyMOauNXSI2Im6zFbiJrdmJo3ifDae0RCNwt//urKBRm2OTdC
         E4Pk03aUXcYGUQm4LVc80lidNUz1rP+PVSZptAcVEYqrpij0NVix7/pFheg8MnGypn5/
         kGND89NyDH58PsrtY875vRkFpdExIjPhhUrBiUnaLMHLr5svy/KsexVn/vHh6O9nWEbQ
         uNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIxrQ8E1bPnZiGDXaml/48HhptzuynLApLQoeNm+bQM=;
        b=g0VneyVQJRTAmtoVV/CFkpX/xfV3jj5Gs0oeplmOPm5rAv8dS+cShwVkPkm6XuGO3x
         iZDPepDhGgM3Lkw7nWy9LBXOuVKdFzvhF8XTVZX8/uE/mTet3QyGsVMyN+P7vapn1v+j
         MG6v1Smuu9JMg7Fj/mf3/u/HoDaE4SmiacYjH9GLwCZN+xQ9Akekk/rabetTyPYVGepE
         WvOiy0khF+AI6HP+V+lZhOH2jHGt8tKWmTsDbcULRoGbBf89BeX8QbOKh8oI0T09LrAu
         cNOe4exGh9GHvvaeCCNZeJJ0XgxQJdz8OQIqWS15zRlBVl0lPAAt7WKyX+7bHAEKYWBh
         IFxw==
X-Gm-Message-State: ACrzQf1yjnv3QuSw7Qe4AZESLRsB4Q4y9KJls22lz2ldTpiWwAp0ROpp
        NhRApSdgQhMLDNoTiRzB6sQ=
X-Google-Smtp-Source: AMsMyM4ZSWkTrwIdU1Rz7nrRxtfOuDRhhgvAjqtYYT/dpNd0vOqIQldvd0mpDDgDgPXMqvM0xho6VA==
X-Received: by 2002:a17:906:730d:b0:78e:9ca5:3269 with SMTP id di13-20020a170906730d00b0078e9ca53269mr46199016ejc.366.1666956142946;
        Fri, 28 Oct 2022 04:22:22 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id kw21-20020a170907771500b00730b3bdd8d7sm2090215ejc.179.2022.10.28.04.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 04:22:21 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:22:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: Re: [PATCH] spi: tegra210-quad: Don't initialise DMA if not supported
Message-ID: <Y1u7bDYd78vb5FyT@orome>
References: <20221026155633.141792-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QJ8+L68pP1weG6Mc"
Content-Disposition: inline
In-Reply-To: <20221026155633.141792-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--QJ8+L68pP1weG6Mc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 26, 2022 at 04:56:33PM +0100, Jon Hunter wrote:
> The following error messages are observed on boot for Tegra234 ...
>=20
>  ERR KERN tegra-qspi 3270000.spi: cannot use DMA: -19
>  ERR KERN tegra-qspi 3270000.spi: falling back to PIO
>=20
> Tegra234 does not support DMA for the QSPI and so initialising the DMA
> is expected to fail. The above error messages are misleading for devices
> that don't support DMA and so fix this by skipping the DMA
> initialisation for devices that don't support DMA.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--QJ8+L68pP1weG6Mc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNbu2sACgkQ3SOs138+
s6HAEQ/+OpJdVLzcg9lWWFnEhhL89eZhR4X/A7XMdtaNLWiLUV+i7lJYE6GjYHGL
H8Y4o7eH29brDZhWfbmlnMgUHPZJyA5/UdFNdFxZyKEtFpRCRn48vBDpr+otIyYm
Ta2v2un5s+kocInYQ8Kd95Kjl06GtKdzGRhQ+HL9juN6KenoI3NAJqBAFusq5Jy7
QR89K5sO2z1kF2Hx0uYNHPvU4OXNyOhuF4Z7VZtHeFgd6cwAKBd/+EmbuDwWSfik
KLZaUaaNzybAWU4Yn7DkDfZHSN996TLOUITxcgEqyfZN13AUi6vuJLWgcQRvXykW
088aJS6VvHSAAfH7HFRoXoD+4xzsjUeQF4ZSwIZGeYkHi+t498OErObnodpQ4hDN
N6AFWVZaWVrmyL2jLPdcdcXxgeXRNT8H3fqaygvZ6m1QIrdw6WFiSpSNhRTM6JnK
Y42QltbSYanRY+6i/NmHu4BbeaFnIDVmposFJfdTyxairHEVQWsEL2paz3SpPQo2
9M38xG8DET51xSDO9s1qZr2PzkgQzoUG18FKq+owVoBDn2pa4RntZgwFEKPfq3pe
ZDrl8PR9z3Q+RMIlPBNDSGgzn89U4dtL/UypEfT2/1X8XZbS1nfDhPiM0W022DGh
a69DfU+7IIVlc1adoXp56d7tZJajjpD5KneCh6vbmmOwWFFIOjM=
=WDMR
-----END PGP SIGNATURE-----

--QJ8+L68pP1weG6Mc--

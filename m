Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA18280672
	for <lists+linux-spi@lfdr.de>; Thu,  1 Oct 2020 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgJASXT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 14:23:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46404 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJASXT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 14:23:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201001182316euoutp022bc6b9a5a1716608d79e76f8c1d581e9~58W3h5cgx2396323963euoutp02_;
        Thu,  1 Oct 2020 18:23:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201001182316euoutp022bc6b9a5a1716608d79e76f8c1d581e9~58W3h5cgx2396323963euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601576596;
        bh=agbhxuw6V2iMsWEiSEmua9UjtBeA6JAhN4Tp6t+MChA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BapdlcwSf4MrGCwKvc7rKT3M/zqz0JcViAjIBMyjz23L2RU2QBj3Qx0EAItPCOdFY
         cruqAmqV012yhulZRjX/FvKA055dDEd8tpatnYHJcDTIIQe+dZZ0RdAEdAQc324Mkr
         bWNv5TctwfHfAX46+TuOztYm/fPjPMdUg5Npk31g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201001182315eucas1p117e8d9636e4aa4aa1079ac673b99e9b6~58W2fGrPn0087100871eucas1p17;
        Thu,  1 Oct 2020 18:23:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8C.2C.06456.39E167F5; Thu,  1
        Oct 2020 19:23:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5~58W2LxfTb0069600696eucas1p1u;
        Thu,  1 Oct 2020 18:23:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201001182315eusmtrp1b9731213820d3d3e4aec686dce0a7132~58W2LIgh83121531215eusmtrp1b;
        Thu,  1 Oct 2020 18:23:15 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-6f-5f761e93c8ad
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 60.C0.06017.39E167F5; Thu,  1
        Oct 2020 19:23:15 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201001182315eusmtip12a38f823341e15551773e9700cf608e9~58W2BYzVc2513525135eusmtip1B;
        Thu,  1 Oct 2020 18:23:15 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Mark Brown <broonie@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 RESEND 0/9] Some fixes for spi-s3c64xx
Date:   Thu, 01 Oct 2020 20:23:00 +0200
In-Reply-To: <20201001161340.GM6715@sirena.org.uk> (Mark Brown's message of
        "Thu, 1 Oct 2020 17:13:40 +0100")
Message-ID: <dleftjft6xg60r.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRTM193uLsWSpWB4QSWmgSgYQKPBVcGoEFn++RNNOApsgEhb7AqK
        R4CoXEE5igoNoGIDpVqOihQRIVQjUY4aDN7EAyLIEZBD0BiUsjXx37x58+ab2SyFyd6JPalk
        1UlOo1KkyAkJ3vr0p81f65Ues/1GiQ9ze3lMxDSXN4qZq59HCaZoZBJjbLYmkjGPvBIzL9sr
        Cabc1ilisr+/JRnTk2GSMbb/Rgec2df6OYx9oBsmWbMxn2Dv6TPZKy1GxM6bvY4QxyTBCVxK
        cjqnCdwfK0mqHusXpeY5n+7ptuFZqM+pAFEU0LtgWRdVgCSUjDYg+FM0jQnDAgL9UhkpDPOr
        w7UhvAA5rV1cyDUgYVGH4El9peNkDMHFql6x3ZegA8BkirQfuNMnYG78IW7XYHS2CKqN9WL7
        wo0OAfN8m8iOcdoHrg3nk3bsRKvhQufcmkZK74YPesMav57eAy3jH0mBd4VnFaNriTBaCRW2
        KSSkWyTh0ahCwGHQpZ8QCdgNJnpaSAFvhF5tIS70zwRtaZA9G9CFCForlx0t98GHgV+EgA/C
        VNUMJuhd4M20q/CsC5S2XnfQUsjLkQlqb2go6nC4eMLlCYMjGQvGHyWOT3UJweJ9M1GMNuv+
        a6P7r41u1RajfaGxPVCgt0HtrUlMwCHQ0DCD30RiI/Lg0nhlIsfvUHGnAniFkk9TJQbEq5Vm
        tPqX9a70zLWhxcE4K6IpJF8nTbKmxcjEinQ+Q2lF3qtOX5ruvECeuEqt4uTu0kP9vdEyaYIi
        4wynUcdo0lI43oo2ULjcQ7qz5luUjE5UnOSOc1wqp/m3FVFOnlkoSLM0rtpikY9495UPJbxf
        6YhxDo200BG+5cYRw+Nay9Gpc4O7EnYvRX+1xOPjqZsYajm47NNVl+6BeVIbfrHSNBvl7//8
        aZfX6UU/bVVKRJ+lo+auX3OshCXO5uTmhm/fWx/HJ+szRkPPrxy21n0sJiSz4rCtbnH+NfyV
        BTZKjvNJih1+mIZX/AU/u8FybQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7qT5criDZqO8Vss/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYe+Quu8WqXX8YHbg9ri/5
        xOyxc9Zddo9NqzrZPDYvqffo27KK0ePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jHnPzzIVdHBXHD94nqWB8QxnFyMnh4SAiURz+wrG
        LkYuDiGBpYwSD7deYO9i5ABKSEmsnJsOUSMs8edaFxtEzVNGiTtt9xlBatgE9CTWro0AqRER
        KJT49GI3C0gNs8AfRokjG5azgySEBWwlNn3ewQRiCwkYSvx+u5wVxGYRUJWYdrcTrIZTIF+i
        ed8nsDivgLnEnSUrwOKiApYSW17cZ4eIC0qcnPmEBcRmFsiW+Lr6OfMERoFZSFKzkKRmAZ3H
        LKApsX6XPkRYW2LZwtfMELatxLp171kWMLKuYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzE
        bcd+btnB2PUu+BCjAAejEg+vwIHSeCHWxLLiytxDjCpAYx5tWH2BUYolLz8vVUmE1+ns6Tgh
        3pTEyqrUovz4otKc1OJDjKZAf05klhJNzgcmj7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLp
        iSWp2ampBalFMH1MHJxSDYxHfq379J1ZcSbPNY5JzFuTy2OajpR5y5hadXCub/Ze2n191uy9
        oqfXpVkpM5/0bpfxONC32U2bY99P10tz1vuUHqvM5n78MrI8UjBLbKJ/+sHzbSt0pm10WnBl
        XhDna0/LRaJLj8duabt0Z9bTwIXptz1Lbv93zlqQGMO+StCFOcrXU64+PFOJpTgj0VCLuag4
        EQDx0yHK5gIAAA==
X-CMS-MailID: 20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5
X-Msg-Generator: CA
X-RootMTR: 20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5
References: <20201001161340.GM6715@sirena.org.uk>
        <CGME20201001182315eucas1p1b1fc9d5d0ea91db6e56e92d5cf2583e5@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-10-01 czw 17:13>, when Mark Brown wrote:
> On Thu, Oct 01, 2020 at 05:21:39PM +0200, =C5=81ukasz Stelmach wrote:
>> This is a series of fixes created during porting a device driver (these
>> patches will be released soon too) for an SPI device to the current kern=
el.
>
> There appeared to be a number of outstanding review comments (misleading
> commit message on patch 7, some concerns about the non-CMU case), please
> address those.

We discussed with Tomasz Figa and Krzysztof Koz=C5=82owski off the list that
this is practically unused. Tomasz, Krzysztof, would you be so kind to
share the details?

Kind regards,
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl92HoUACgkQsK4enJil
gBC1Hwf+LNI+RLc3LRnqAtWaZioQJLaVvjc9hCUrh/JeDj+oTZdQqWU35u7vUynF
bfjiDVSYjtTYlijnkzMN2uGDJ4gO0pnIsADyb90VNYWb4dIVjS7pZenxdFeZMlmb
JfkU3xdGmdYasYEWzMHP1uz0RRnX5KpivsM5D08/o30SMjvwXz1fzJdmLZqlm8jc
HmoSDEOPZPx6oI7rFq8wHrKHXpFsp0PWzmQR8LGSAQdZHJt2BXbhxIkHupwmlMBo
ovwUhX0vFtr7BD0vt1GdarrB7JEL7yV9gbQvkMPiNlANxVLz+LDxQbFIu9wLx6DB
MdAVhpKjFQ4NjluhP81P6ccdiOBDmQ==
=yDPM
-----END PGP SIGNATURE-----
--=-=-=--

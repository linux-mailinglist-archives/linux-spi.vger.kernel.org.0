Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A33249EB4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHSMvy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 08:51:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40490 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgHSMvw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 08:51:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819125150euoutp0235d109206cbe80258b8dfc771ba94274~srGN1KRgN2513825138euoutp02Y;
        Wed, 19 Aug 2020 12:51:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819125150euoutp0235d109206cbe80258b8dfc771ba94274~srGN1KRgN2513825138euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597841511;
        bh=gzhlptWpxVbsUHuvhCGM3F9nelOeibRw24yuW4FNoY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxcKRey47qqk6gnLKRU4WlBzCzCFYBOWV7JRgLc7g5gIoa16UXvJGrUlnvLjM6nLJ
         eEbYyQ8dv0ttbTvbZGAef6kSIltGAfybg9xxtLyNBxwNDGxvHAEvJMGHgWRq4657ya
         drViUhagX1kGAll9mPp4k2EzbONrx+/HfWveaNmA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819125150eucas1p2f61c758e3e1afe709f09efcc31546da5~srGNi5XFx3079830798eucas1p24;
        Wed, 19 Aug 2020 12:51:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.4E.06456.6602D3F5; Wed, 19
        Aug 2020 13:51:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819125150eucas1p1965fab59b6e75cf54cac262161c5695b~srGNJ7lm_3265032650eucas1p1S;
        Wed, 19 Aug 2020 12:51:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819125150eusmtrp29139167e8ff9315f0d5da482e0c90473~srGNJPv-X0843508435eusmtrp2U;
        Wed, 19 Aug 2020 12:51:50 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-01-5f3d2066c128
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.C2.06314.6602D3F5; Wed, 19
        Aug 2020 13:51:50 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819125150eusmtip19e0c6d8be57ba852ebcef12b65f74a25~srGM-FaxI0503105031eusmtip1Z;
        Wed, 19 Aug 2020 12:51:50 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Date:   Wed, 19 Aug 2020 14:51:27 +0200
In-Reply-To: <20200819123834.GB18122@kozik-lap> (Krzysztof Kozlowski's
        message of "Wed, 19 Aug 2020 14:38:34 +0200")
Message-ID: <dleftjtuwy23zk.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRj3vffe995u3vb2ih75MW5hMpcWeRUNs7kmm7FhDTl6dejucm+l
        8odDKidSzfq5UqGcdc65Ja1hzbQ0HRpJ0ii7dMwqTeVnb99s/vs8n+fz/TzP59mXJrhnpD99
        2JAomAzaeBWllNc9HmtbfmjBupgVlc8D+KpRt4y/XXiL5C+/76P4nF4PwbtcdgXv6H1F8u0N
        pRRf6Lov408Ndir42kfdivVKTcfVIULjsJ6jNHeuntRcdFqRZtgxfxsZrVwbK8QfThZMQRH7
        lbpOczeRMM6mFLc9JM2o3tuCvGhgV0Jz/WmFBSlpjq1BcD7rMoGLbwjKmm0IF8MI8sbHSAui
        J5/kmhdjvhqB52ULhQs3gsaKekoSUawaamt3SyN82aXQ8es7KWkItloG17pOIakxg40FT0O2
        TMJydhFct1QREvZik8Ha34UkH4ZdDZkPfCV6JrsGnP09CgkzrA+0FPXJJUyweihyfZ5cFNh3
        Cmgvt5I42yaoKclEGM+AgWanAuO58OdeuQyHOQn5eaH4bTaCutJROdaEw9u2cQrjDfD94SDC
        em94/cUHz/WGvLoCAtMMZGVwWB0AtpzGKRd/uDBQM7WBBkZyH09d+jSCdw86iUtoQfF/cYr/
        i1M8YUtMnO5WQxCml8H1Cg+B8Tqw2b7KryDSivyEJFEfJ4jBBuG4WtTqxSRDnPqgUe9AE3+r
        9XfzUD0aeXGgCbE0Uk1nUtrCYzhSmyym6ptQwITTB/vNZ8hfbjAaBJUvs/Fp6z6OidWmpgkm
        Y4wpKV4Qm9AcWq7yY0IqP+3l2DhtonBUEBIE07+ujPbyNyNb6bQbWzV3exq550yjXTHHKCvo
        cgb9cKvCLFGcNWGgd1q+J5ByM5E7s6neXTvckS/8gjdH2o0dZ81P7nBjjj+z3hxYeCRdF37m
        mKpIJaa6Ai/oolsSZutORO31HZmfkx6m/jlYtj2j5JB5vU8TrXY2fFxi/xm6J21VRMiW1NZ5
        Krmo0wYHEiZR+xc/oTXBYwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7ppCrbxBu2fuC0W/3jOZLFxxnpW
        i6kPn7BZ9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWjR9vslusPXKX3YHL4/qST8wem1Z1
        snlsXlLv0bdlFaPH501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk3G+4yF/wSqJh17gBrA+MOvi5GDg4JAROJiQ1qXYxcHEICSxklbpz8
        yw4Rl5JYOTe9i5ETyBSW+HOtiw2i5imjxIKTTSwgNWwCehJr10aA1IgIaEpc//udFcRmFpjP
        JPH7lweILSyQJHHpwCUWEFsIqPz178dsIDaLgKrEsq7FzCA2p0CZxIruf2AjeQXMJdr3i4CE
        RQUsJba8uM8OYvMKCEqcnPmEBWJ8tsTX1c+ZJzAKzEKSmoUkNQtoEjPQRet36UOEtSWWLXzN
        DGHbSqxb955lASPrKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMB423bs5+YdjJc2Bh9iFOBg
        VOLhrThnHS/EmlhWXJl7iFEFaMyjDasvMEqx5OXnpSqJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8
        iNEU6M2JzFKiyfnAFJFXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNT
        qoHRaMPz6EWyUxuq3BybWefsTlz6JuzKrLf259o2qyyxuLPx5epbXXpz61e0dLRqss0p4has
        +RNzaklqx7b9lt/avS6tObkq+at14NIfm7Qcg7OqtfM2q1QlNy16t0lcZ/uFJv7S2miXtTsE
        ql6Gql87vHK2U0HEmqKUro+84XYTW5Vzoj27doQosRRnJBpqMRcVJwIA1QaaCdkCAAA=
X-CMS-MailID: 20200819125150eucas1p1965fab59b6e75cf54cac262161c5695b
X-Msg-Generator: CA
X-RootMTR: 20200819125150eucas1p1965fab59b6e75cf54cac262161c5695b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819125150eucas1p1965fab59b6e75cf54cac262161c5695b
References: <20200819123834.GB18122@kozik-lap>
        <CGME20200819125150eucas1p1965fab59b6e75cf54cac262161c5695b@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 14:38>, when Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 02:32:01PM +0200, =C5=81ukasz Stelmach wrote:
>> Fix issues with DMA transfers bigger than 512 on Exynos3250.
>
> Fix, but how? With proper explanation this should go to CC-stable.

Honestly, I don't know and I couldn't find out why. It makes stuff
work. There has been a commit like this before

    0f5a751ace25 spi/s3c64xx: Enable GPIO /CS prior to starting hardware

Apparently, it was lost in

    0732a9d2a155 spi/s3c64xx: Use core message handling

>>=20
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index cf67ea60dc0e..fb5e2ba4b6b9 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -678,11 +678,11 @@ static int s3c64xx_spi_transfer_one(struct spi_mas=
ter *master,
>>  		sdd->state &=3D ~RXBUSY;
>>  		sdd->state &=3D ~TXBUSY;
>>=20=20
>> -		s3c64xx_enable_datapath(sdd, xfer, use_dma);
>> -
>>  		/* Start the signals */
>>  		s3c64xx_spi_set_cs(spi, true);
>>=20=20
>> +		s3c64xx_enable_datapath(sdd, xfer, use_dma);
>> +
>>  		spin_unlock_irqrestore(&sdd->lock, flags);
>>=20=20
>>  		if (use_dma)
>> --=20
>> 2.26.2
>>=20

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl89IE8ACgkQsK4enJil
gBAUlggApUTqPdsn1ouHqpWeD9cWT+uRv8GGM8gtU0ek4a0ppZG4xlm/Pvjv6QvY
5kqUEcGKmj+1UwxYIxlJv3yySNnu+IvoxCQEMACxzd9UjK8+ZDDhyeT3ocXQpA2S
jKg6VNacPq/jG/2TOZsMX/rkJR3LBJrUkA7zZULMavgTET62WOfWn962b4H/BOk/
2SmbNFMsAg6XpyvNQm6+D7MRK37pyIb116WZWAE8SAMqJQwVYo7FxlEcobVYn4dA
IqMZzJZyNlhhIs1PjX/Sfal4aagLIgfMrbWqHV6LPY5U+bWWa3yDJ1zoM2MjE2tn
8ykl1sbm0+wW2sJqQButwhS/CSZghA==
=TpUg
-----END PGP SIGNATURE-----
--=-=-=--

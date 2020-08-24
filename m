Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A724FEA2
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgHXNR0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 09:17:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47186 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXNRV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 09:17:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200824131717euoutp01c0e823076f7354b33bc42e0918d2d93f~uNq2p0st_0844408444euoutp01b;
        Mon, 24 Aug 2020 13:17:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200824131717euoutp01c0e823076f7354b33bc42e0918d2d93f~uNq2p0st_0844408444euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598275037;
        bh=OT0rqyQlWmdMQHNzRDIfGcRAB/16hVBFM4XsdepxvKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACZj1Mvv4Svwq0OPmzI6UcJ09Yg0d5sTog3cxDDQk3GbIB0AUzExGdVGD4TFpkE+X
         2/oervLIkhSfCucsVU0wTC7cRsiOrQ9y7y+evjNd/8HQ5pbbrCMhP7LOQRClnXM9wX
         bDRJjHphdEm/yStQ5d7LHWQxKg5+aqpu0fJ/UYIY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200824131716eucas1p2440fe398c3fa497c05d22b5a92e56ab0~uNq2WXiRW2849428494eucas1p2S;
        Mon, 24 Aug 2020 13:17:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6C.E5.05997.CDDB34F5; Mon, 24
        Aug 2020 14:17:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200824131716eucas1p16a3fde52aa765e7cd6584d4733762047~uNq2Cckhe0260302603eucas1p1x;
        Mon, 24 Aug 2020 13:17:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200824131716eusmtrp1377337d38a0ecdd03f7106296b03990b~uNq2BugMn1770017700eusmtrp1Z;
        Mon, 24 Aug 2020 13:17:16 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-12-5f43bddce15a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5A.DB.06314.CDDB34F5; Mon, 24
        Aug 2020 14:17:16 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200824131716eusmtip17784587fb037d3a2cfa5d332992f3853~uNq13hKY-1595415954eusmtip1S;
        Mon, 24 Aug 2020 13:17:16 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Date:   Mon, 24 Aug 2020 15:17:03 +0200
In-Reply-To: <20200822124325.GF20423@kozik-lap> (Krzysztof Kozlowski's
        message of "Sat, 22 Aug 2020 14:43:25 +0200")
Message-ID: <dleftj5z98xjxs.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN60ynBa0+CoZrESINmriBgOAQVERcJv5o4g8YtRaYFCItpAO4
        /IAkgiKLQlBATWQRSZV9CRKRpCESQKgoixCQaCGIqCxFKQbRtoMJf+ede+6599w8MSEdFsrE
        0Zp4VqtRxsgpe7Lx9VLPnpGWEMVe/cf9dIl5UkDX5FcJ6bxP4xSdbZwmaIOhWkTXGgeE9Pvm
        hxSdb3gloK/PDYnoirZREW26sUIdXsc8SO4lmcHSeYKp1d2imLrSJCarXocYU63baeqs/YFI
        NiY6kdV6HbpoH2VaLEdxDU5XMlqekskoxyEdicWA98FonW86shNLcTmCzqqYdGRvwQsI7vX/
        FfAPE4KyoWWRVWVtGNP3i/jCUwSliw2rqkkEaW1PSKsthT2hoiLU2uCEd8Dgn0WhVUPgTgHU
        91bZnBxxGHStDJBWTOJt0GAusvF2OBEW7nbYeAneD91v8m14Ew6A+i9jIp53gI6CcRtPYDUU
        GL4h6wDAcyJY7jAJ+FWPQnJKD8ljR/jaXr8aYQt05WaQfP4kyM3x53szEDQ+NK/qA2Gk5zfF
        42DoLpoV8voN8OG7Az93A+Q03id4WgI3U6W82gMqs1+uusgg82s54jEDs8u/CP5WKQgeGbOE
        d9DWwjVxCtfEKbTYEpbbVTV78fQuKCuaJnh8ECorZ8jHSKhDzmwCp1axnI+GvezJKdVcgkbl
        GRGrrkWWX9a10r7QhJqXw/UIi5F8vcSsD1JIhcpE7qpajzwsTp+rn71FMlITq2HlTpIj3V0X
        pJJI5dVrrDZWoU2IYTk9chGTcmeJb/HUeSlWKePZSywbx2r/VwViO1kycs5yV+dF4MeuXimO
        lRsNmVTNzMSJzIbdJc+SdAk49EyT852Rn8aTfX+57Amj149q5lSAP/Zobd38PMk7KC74QtgL
        1U73d6r8cMb1mJuiyW8uMNWnN6vMLzxXYf655FC6vX1by/Hvfm0DGWqX6eG0c+ztkOIUY998
        1PNp3dCUjJSTXJTSeyeh5ZT/ABTl4S5tAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7p39jrHG9y+rWix+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyaPx4k91i7ZG77BafW/+xOXB7zG64
        yOJxfcknZo9NqzrZPDYvqffo27KK0ePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jM/fVzAWbBWp6Nm7nKWBcZJgFyMnh4SAicT9Q1fZ
        uxi5OIQEljJKXPh7l62LkQMoISWxcm46RI2wxJ9rXWwQNU8ZJXYe2MUIUsMmoCexdm0ESI2I
        gKbE9b/fWUFqmAUOMUmsaJnPApIQFgiXuLP0GTOILQRUf2lXPzuIzSKgKrH1x0J2kDmcAmUS
        xze5g4R5Bcwlzp6ZAdYqKmApseXFfXaIuKDEyZlPwOLMAtkSX1c/Z57AKDALSWoWktQsoKnM
        QCet36UPEdaWWLbwNTOEbSuxbt17lgWMrKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC43Db
        sZ+bdzBe2hh8iFGAg1GJh/fHIft4IdbEsuLK3EOMKkBjHm1YfYFRiiUvPy9VSYTX6ezpOCHe
        lMTKqtSi/Pii0pzU4kOMpkBvTmSWEk3OB6aOvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJ
        JanZqakFqUUwfUwcnFINjL51PbEna4vU1p/ZX7o3Ryfv4pSns13sX4pYajPOel7E3BbZ7qNm
        cunTCh2NxYoHfsy78TPKWOSFYb/fAakY5h0NaiYngzr9rFdHOIt/r1F4eP8iv0/1BEGXqyyP
        uRzuyL5vjxSKiVhQ8mPKJ36bzmy5fRP4ekX3xU+NeyYV86fT12+Z4e39SizFGYmGWsxFxYkA
        ESmkX+UCAAA=
X-CMS-MailID: 20200824131716eucas1p16a3fde52aa765e7cd6584d4733762047
X-Msg-Generator: CA
X-RootMTR: 20200824131716eucas1p16a3fde52aa765e7cd6584d4733762047
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200824131716eucas1p16a3fde52aa765e7cd6584d4733762047
References: <20200822124325.GF20423@kozik-lap>
        <CGME20200824131716eucas1p16a3fde52aa765e7cd6584d4733762047@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-22 sob 14:43>, when Krzysztof Kozlowski wrote:
> On Fri, Aug 21, 2020 at 06:13:59PM +0200, =C5=81ukasz Stelmach wrote:
>> cur_speed is used to calculate transfer timeout and needs to be
>> set to the actual value of (half) the clock speed for precise
>> calculations.
>
> If you need this only for timeout calculation just divide it in
> s3c64xx_wait_for_dma().

I divide it here to keep the relationship between the value the variable
holds and the one that is inside clk_* (See? It's multiplied 3 lines
above). If you look around every single clk_get_rate() call in the file is
divided by two.

> Otherwise why only if (cmu) case is updated?

You are righ I will update that too.

However, I wonder if it is even possible that the value read from
S3C64XX_SPI_CLK_CFG would be different than the one written to it?

> You are also affecting here not only timeout but
> s3c64xx_enable_datapath() which is not mentioned in commit log. In other
> words, this looks wrong.

Indeed, there is a reference too. I've corrected the message.

>>=20
>> Cc: Tomasz Figa <tfiga@chromium.org>
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 02de734b8ab1..89c162efe355 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_dri=
ver_data *sdd)
>>  		ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
>>  		if (ret)
>>  			return ret;
>> +		sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
>>  	} else {
>>  		/* Configure Clock */
>>  		val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
>> --=20
>> 2.26.2
>>=20
>
>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl9Dvc8ACgkQsK4enJil
gBA0rQgAnJlpI7A1yxNurb3bruQTwOt7iW6zXvP/OP+6/YaJoV6EciSx6JbgDwWa
TSSmQAzzaZooyRZMGoZ0CU4mkxdgsJVuZKdVjmj5Omh/b0ElpC2IzmHoDk1mDH7I
rbYgiJnhmlI6Qz2zNZ6kig5eUxuDq/tuZ2L3tpg6tvinzFZSvFsklA3vBAkAJqJm
HK+VHbfcqqeoUXLQQqELF1A25ft8cD57BjOBtfL7ozjWc+SvQXSsjSQv64O8MPAK
WMIoxt5TcIBXdR/r8Is0bvmp4Q+Yq7Q61T4nQZeqdw6RfYTlvUhhTm1IZO4aHAb/
730YBXVP5vTjw79wVoyFF0h/mw5qcg==
=L5s0
-----END PGP SIGNATURE-----
--=-=-=--

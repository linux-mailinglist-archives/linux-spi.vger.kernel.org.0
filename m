Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892ED249EEF
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgHSNCq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:02:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44275 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgHSNBZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:01:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200819130122euoutp01c0858c294fbe375c0d008180eb97176f~srOife_fs2337823378euoutp01C;
        Wed, 19 Aug 2020 13:01:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200819130122euoutp01c0858c294fbe375c0d008180eb97176f~srOife_fs2337823378euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597842082;
        bh=lFAG+MIVGUUxCL3WA4B50UGWkVptro5X2ZU5lLKAoCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGWA+t4rFWdd6yGf0CCy+yGzIAh6PsbOoGIDPQth2wCwHdEH+VOjwi/XjZ7xg6xmY
         7qvKbN/8SHvoJs4FOZFF2M2hznKZAYszCUR3FXrLMGOPu8Oj8rtsEPXgRp+2ctCIKz
         OgTzXUOz8c3+TJyNJCGPX98RXLJZTGr9eU5PGbwg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200819130122eucas1p15ff03b3656cfe877233f738f1342c676~srOiMh6ZA2312323123eucas1p1b;
        Wed, 19 Aug 2020 13:01:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.E8.06318.2A22D3F5; Wed, 19
        Aug 2020 14:01:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200819130122eucas1p27e9e84c4399d01409858de6d01e11b52~srOhv9o1r0994509945eucas1p2A;
        Wed, 19 Aug 2020 13:01:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819130122eusmtrp27f23490459d0d9c97571346772a6c240~srOhvPV7Q1433514335eusmtrp2X;
        Wed, 19 Aug 2020 13:01:22 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-91-5f3d22a2d5d8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.E7.06017.2A22D3F5; Wed, 19
        Aug 2020 14:01:22 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819130121eusmtip280ab054eb17be4a07487f331b4109e9a~srOhld3Ii2109321093eusmtip2B;
        Wed, 19 Aug 2020 13:01:21 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/8] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Date:   Wed, 19 Aug 2020 15:01:21 +0200
In-Reply-To: <20200819123914.GC18122@kozik-lap> (Krzysztof Kozlowski's
        message of "Wed, 19 Aug 2020 14:39:14 +0200")
Message-ID: <dleftjpn7m23j2.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7qLlGzjDU6elrNY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddgcuj+tLPjF7bFrV
        yeaxeUm9R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGU8nLCfuWCaQMX1ra2sDYxPebsYOTkk
        BEwkFhzvZOpi5OIQEljBKHHt9wp2COcLo8TDts9Qmc+MElPufWKEaVl/fzU7iC0ksJxR4tLd
        JIii54wSx04fZOli5OBgE9CTWLs2AqRGREBT4vrf76wgNcwCy5kklt5uBBskLBApcXv5BBYQ
        m0VAVWLG0z2sIDanQJnErbmXwebwCphLrFkKtktUwFJiy4v7YDavgKDEyZlPwFqZBXIlZp5/
        wwgyX0LgHrvExvtnWCAOdZE4Nvk3E4QtLPHq+BZ2CFtG4v/O+Uwg8yUE6iUmTzKD6O1hlNg2
        5wdUr7XEnXO/2CBsR4kld/qZIer5JG68FYTYyycxadt0qDCvREebEES1isS6/j1QU6Qkel+t
        YIQo8ZB4cFEOElJNjBIrjs5jnMCoMAvJN7OQfDMLqIUZGHLrd+lDhLUlli18zQxh20qsW/ee
        ZQEj6ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzApHX63/GvOxj3/Uk6xCjAwajEwxsA
        TGZCrIllxZW5hxhVgCY92rD6AqMUS15+XqqSCK/T2dNxQrwpiZVVqUX58UWlOanFhxilOViU
        xHmNF72MFRJITyxJzU5NLUgtgskycXBKNTDmC6ybF/WOy+630qMPqe8Etx+/MIl13q3aGY33
        dl17xnwnMZHFdcqXA212PJ0rlj0Wq+ieKXaO4fqCpu3rn/NzC1z+cuTTxMIj77bXqttph9X6
        djXrWBxXTnvimXgvNFDc66XpZtekwp8Cuf2RO03O/mJZu8DI2lxJqYRlS9CTeWlG7nWWweeV
        WIozEg21mIuKEwEdOVjMYgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7qLlGzjDbYuY7FY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddgcuj+tLPjF7bFrV
        yeaxeUm9R9+WVYwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GU8nLCfuWCaQMX1ra2sDYxPebsYOTkkBEwk1t9fzd7FyMUhJLCUUeL7
        zf2sXYwcQAkpiZVz0yFqhCX+XOtig6h5yijx59g0JpAaNgE9ibVrI0BqRAQ0Ja7//c4KYjML
        zGeS+P3LA8QWFgiX+H14FQuILQRUPv3QdmYQm0VAVWLG0z1g9ZwCZRJvFu9nBBnJK2AusWYp
        O0hYVMBSYsuL+2A2r4CgxMmZT1ggxmdLfF39nHkCo8AsJKlZSFKzgCYxA120fpc+RFhbYtnC
        18wQtq3EunXvWRYwsq5iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjLhtx35u2cHY9S74EKMA
        B6MSD28AMBKFWBPLiitzDzGqAI15tGH1BUYplrz8vFQlEV6ns6fjhHhTEiurUovy44tKc1KL
        DzGaAr05kVlKNDkfmCTySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFw
        SjUwrp9j2xRoF7uOoZ2vaL3dRF8v16zFng8/P3G1UDlfktk3o5bT7VTPv7rZ3x9ttjulfZb/
        R5uUbcKLgosL4jWDgu/k/bhsksbmeGiGTcJE16eGWr2fV7aoXNvamMXe5/tFzN4sr9RsYuuD
        fR8PSd88vtRJuUUx+foG+x+X+0MfHhD8JubZ5nlEiaU4I9FQi7moOBEAwF0khtoCAAA=
X-CMS-MailID: 20200819130122eucas1p27e9e84c4399d01409858de6d01e11b52
X-Msg-Generator: CA
X-RootMTR: 20200819130122eucas1p27e9e84c4399d01409858de6d01e11b52
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819130122eucas1p27e9e84c4399d01409858de6d01e11b52
References: <20200819123914.GC18122@kozik-lap>
        <CGME20200819130122eucas1p27e9e84c4399d01409858de6d01e11b52@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 14:39>, when Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 02:32:02PM +0200, =C5=81ukasz Stelmach wrote:
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>
> Add a quirk - why?

Because stuff does not work without it and works with it and it is
turned on for other SoCs which have simmilar SPI HW.

> There is here no commit msg, no explanation.

As I wrote in the cover letter, this and previous commits make things
work on Exynos3250 (ARTIK5 precisely). I can't explain why. I read
everything I could about this HW and there were no details about
automatic CS handling other than how to turn it on and off.

>> ---
>>  drivers/spi/spi-s3c64xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index fb5e2ba4b6b9..8fe44451d303 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -1372,6 +1372,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_=
port_config =3D {
>>  	.tx_st_done	=3D 25,
>>  	.high_speed	=3D true,
>>  	.clk_from_cmu	=3D true,
>> +	.quirks		=3D  S3C64XX_SPI_QUIRK_CS_AUTO,
>>  };
>>=20=20
>>  static struct s3c64xx_spi_port_config exynos7_spi_port_config =3D {
>> --=20
>> 2.26.2
>>=20
>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl89IqEACgkQsK4enJil
gBCBgggAmzKJKZjdcN7psbd+tfozf4RjlgvWg2EeHyNvQREmFtsdVidvErwvxxAI
WSIyLq1cJhTyCTRobYsy/4kg3N/NCODTDDC/iNMUS60jwsbxuPL6qnmXkmNc1Ta/
R/BYT2QxwlYQW5p+qMjnBVHYpVvXqy/SYTqyGnGyykMc9R6l0TXIMCH2yaNMCCLY
bKuz8oomOfEXnVXsK9dx8f70k2L/My2k1eHMK21HM/zkXeEQCijMVlpiaa1NWrBT
HkMgoGlgIZF+zE73k1/D+8H6kJUqfck70kcs7dhpWJie+a5qyQeORBgpe8sC/gLH
Ub1gRspukoIDB2QpiJv88dtGMKeOTg==
=FjbC
-----END PGP SIGNATURE-----
--=-=-=--

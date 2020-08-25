Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272A5251C8C
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHYPqQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 11:46:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44602 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHYPqP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Aug 2020 11:46:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200825154612euoutp02a1324257945c84dd0891fe4906e9bfe6~ujWKlbA1c2475624756euoutp02S;
        Tue, 25 Aug 2020 15:46:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200825154612euoutp02a1324257945c84dd0891fe4906e9bfe6~ujWKlbA1c2475624756euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598370372;
        bh=FtOSd+33zO9H2gbhYyEI6+LIXU6Ebz09N+WK8v5l3Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmnB80HCRpTIJN61GzGyqARX44nnSNahAAHw35wpk/zfjUEnSsVXgEKOrDsC/pAj6
         symrWfoqT2uLNBmBmOayRHvbeydTwjTB0FvjzcSqpr3zsZH7eW52evQ4fUpIKxoRMU
         4tAaqw3yZ4Ag+Ct8RREOmcU+ioAKJgYFow3Cvng8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200825154612eucas1p162a61a2c552e7fc9559c24eb882da3bb~ujWKJU5A90093800938eucas1p10;
        Tue, 25 Aug 2020 15:46:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BC.49.06456.442354F5; Tue, 25
        Aug 2020 16:46:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200825154611eucas1p284be8779ab484e675af071afef28376b~ujWJwJyL42186421864eucas1p2h;
        Tue, 25 Aug 2020 15:46:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200825154611eusmtrp106fcb37d935e266647dfb1dbf967a749~ujWJvb_bw1643516435eusmtrp1f;
        Tue, 25 Aug 2020 15:46:11 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-0c-5f453244bba5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.5B.06314.342354F5; Tue, 25
        Aug 2020 16:46:11 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200825154611eusmtip1a6d020326370241cf5c2de6f0d73a9c0~ujWJjmsc12952829528eusmtip1z;
        Tue, 25 Aug 2020 15:46:11 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list\@263.net\:IOMMU DRIVERS \<iommu\@lists.linux-foundation.org\>\,
        Joerg Roedel \<joro\@8bytes.org\>\," 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
Date:   Tue, 25 Aug 2020 17:45:57 +0200
In-Reply-To: <CAAFQd5C7Ysb2wnUhUcFZObuSSn4oW=e-oObO5Abat8rJRvqPqw@mail.gmail.com>
        (Tomasz Figa's message of "Tue, 25 Aug 2020 17:11:09 +0200")
Message-ID: <dleftj5z96wwy2.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSyUcRzvd89zzz2uzn6O5hvN6kYTQ8ryqKtFbNfaWktrpcKVZxh37B70
        sha9Tpcw5v2SZJHymmR6mcnrbrrSkpaXCVGphsrRRs5zNv99vp+X78tvP5qQ9gnt6Eh1HKtR
        K6NllJisb5s1uPlvDQjZ0lohZO4ZxwRMTW6VkMkaGqGYtOHvBGMwVIuY2uEeIfOuUUcxuYaX
        AubS5EcRU9HSL2Kmr81Te1YrCpLekooPJVOEorb8BqV4XJKoSK0rR4rpWoeDVJBYHsZGRyaw
        Go/doeKIlL++sVe8z77KaaKSkNZFiyxowF5weaGA0iIxLcVlCDoWLgn44jeCR6M3RXwxjaC9
        ZQwtR65+7DULpQhmmifNxRiC921VpBbRNIXdoaLiqClggx3hX2fu0gwCF5PwdKBcaBKs8THQ
        z/eQJkxiJ8geuiw0mSxwOoKJmTHKJEiwN0xn6JbwWuwDdeODIp63gs68kaUwgVWQZ5hApjDg
        SRFUTySL+F394UlhiYDH1vCtvc7Mrwd9ZsrSpoATITNjO59NQVCvM5K8Zyf0vZ6jeOwLxgGt
        gPdbQu8PK36uJWTU5xA8LYHk61Le7QiVac/NXezg1rcy88sp4IGug+AfqwSBrq6LSEcb8lec
        k7/inPzFtgTeDFWNHjztCvfvfid4vAsqK3+RRUhYjmzZeE4VznKeavaMO6dUcfHqcPfTMapa
        tPjP9PPtUw3oT/epZoRpJFsjKaICQqRCZQJ3TtWMHBc7fa5++AbZkeoYNSuzkfh16YOlkjDl
        ufOsJiZEEx/Ncs3IniZltpJtxV9PSnG4Mo6NYtlYVrOsCmgLuyQkP1Qz6L3O3vdPNDXXLx9v
        48gio4NzlkaQErRxX7HVG31q+PtU3apHVaWjk7uyfHYEt4SKsXPBs4v7dzxslbslykMCsy+g
        gonIbq+oUb8ycDUcb2w6YRSUfrINSm10en5V8sX3695NZT1pFqWjs5rAvsO3jwwQXS9+KiMO
        NNwp1MtILkLp6UJoOOV/yjYu2m8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7rORq7xBq9+qlgs/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYe+Quu8Xn1n9sDtwesxsu
        snhcX/KJ2WPTqk42j81L6j36tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jE
        Us/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo+ebY0GzecXh6QfYGhi7tLoYOTkkBEwkWm7eYO9i
        5OIQEljKKHH25WPmLkYOoISUxMq56RA1whJ/rnWxQdQ8ZZRYcuoiE0gNm4CexNq1ESA1IgIq
        Er9PzmADsZkFJrNIPFtiCGILC4RL3Fn6jBnEFhIIkJjw6AaYzSKgKjHtYRMryExOgQmMEm++
        Pwdr5hUwl/g8aQ6YLSpgKbHlxX12iLigxMmZT1ggFmRLfF39nHkCo8AsJKlZSFKzgM5jFtCU
        WL9LHyKsLbFs4WtmCNtWYt269ywLGFlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbhtmM/
        N+9gvLQx+BCjAAejEg/vAjbXeCHWxLLiytxDjCpAYx5tWH2BUYolLz8vVUmE1+ns6Tgh3pTE
        yqrUovz4otKc1OJDjKZAj05klhJNzgemjrySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp
        2ampBalFMH1MHJxSDYwTfnTKPV/Y1f9N2G7dp++hfy33Kbpsm83n2v6O2Sh6UrDW9notxU07
        gzQ3sBw4VHlqV+CvaTfK43sv3mRvUNp5RO9pSblMXm64UHdJ4hOrnv45e349eqO/6fzJUEvf
        /Bz1WW2n5m96bqjwddGHxwsvfDjn+mGnnhp/7dXrOxRs/R1vnQ1TcL2vxFKckWioxVxUnAgA
        OkS2P+UCAAA=
X-CMS-MailID: 20200825154611eucas1p284be8779ab484e675af071afef28376b
X-Msg-Generator: CA
X-RootMTR: 20200825154611eucas1p284be8779ab484e675af071afef28376b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200825154611eucas1p284be8779ab484e675af071afef28376b
References: <CAAFQd5C7Ysb2wnUhUcFZObuSSn4oW=e-oObO5Abat8rJRvqPqw@mail.gmail.com>
        <CGME20200825154611eucas1p284be8779ab484e675af071afef28376b@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-25 wto 17:11>, when Tomasz Figa wrote:
> On Tue, Aug 25, 2020 at 11:02 AM Lukasz Stelmach <l.stelmach@samsung.com>=
 wrote:
>>
>> It was <2020-08-24 pon 15:21>, when Tomasz Figa wrote:
>> > On Mon, Aug 24, 2020 at 3:17 PM Lukasz Stelmach <l.stelmach@samsung.co=
m> wrote:
>> >>
>> >> It was <2020-08-22 sob 14:43>, when Krzysztof Kozlowski wrote:
>> >> > On Fri, Aug 21, 2020 at 06:13:59PM +0200, =C5=81ukasz Stelmach wrot=
e:
>> >> >> cur_speed is used to calculate transfer timeout and needs to be
>> >> >> set to the actual value of (half) the clock speed for precise
>> >> >> calculations.
>> >> >
>> >> > If you need this only for timeout calculation just divide it in
>> >> > s3c64xx_wait_for_dma().
>> >>
>> >> I divide it here to keep the relationship between the value the varia=
ble
>> >> holds and the one that is inside clk_* (See? It's multiplied 3 lines
>> >> above). If you look around every single clk_get_rate() call in the fi=
le is
>> >> divided by two.
>> >>
>> >> > Otherwise why only if (cmu) case is updated?
>> >>
>> >> You are righ I will update that too.
>> >>
>> >> However, I wonder if it is even possible that the value read from
>> >> S3C64XX_SPI_CLK_CFG would be different than the one written to it?
>> >>
>> >
>> > It is not possible for the register itself, but please see my other
>> > reply, where I explained the integer rounding error which can happen
>> > when calculating the value to write to the register.
>>
>> I don't have any board to test it and Marek says there is only one that
>> doesn't use cmu *and* has an SPI device attached.
>>
>> Here is what I think should work for the !cmu case.
>>
>> --8<---------------cut here---------------start------------->8---
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 18b89e53ceda..5ebb1caade4d 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -655,13 +655,18 @@ static int s3c64xx_spi_config(struct
>> s3c64xx_spi_driver_data *sdd)
>>                         return ret;
>>                 sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
>>         } else {
>> +               int src_clk_rate =3D clk_get_rate(sdd->src_clk);
>
> The return value of clk_get_rate() is unsigned long.
>
>> +               int clk_val =3D (src_clk_rate / sdd->cur_speed / 2 - 1);
>
> Perhaps u32, since this is a value to be written to a 32-bit register.
> Also if you could add a comment explaining that a negative overflow is
> impossible:
>
> /* s3c64xx_spi_setup() ensures that sdd->cur_speed <=3D src_clk_rate / 2.=
 */

OK.

> But actually, unless my lack of sleep is badly affecting my brain
> processes, the original computation was completely wrong. Let's
> consider the scenario below:
>
> src_clk_rate =3D 8000000
> sdd->cur_speed =3D 2500000
>
> clk_val =3D 8000000 / 2500000 / 2 - 1 =3D 3 / 2 - 1 =3D 1 - 1 =3D 0
> [...]
> sdd->cur_speed =3D 8000000 / (2 * (0 + 1)) =3D 8000000 / (2 * 1) =3D 8000=
000
> / 2 =3D 4000000
>
> So a request for 2.5 MHz ends up with 4 MHz, which could actually be
> above the client device or link spec.
>
> I believe the right thing to do would be DIV_ROUND_UP(src_clk_rate /
> 2, sdd->cur_speed) - 1. It's safe to divide src_clk_rate directly,
> because those are normally high rates divisible by two without much
> precision loss.

This makes sense.

>> +
>>                 /* Configure Clock */
>>                 val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
>>                 val &=3D ~S3C64XX_SPI_PSR_MASK;
>> -               val |=3D ((clk_get_rate(sdd->src_clk) / sdd->cur_speed /=
 2 - 1)
>> -                               & S3C64XX_SPI_PSR_MASK);
>> +               val |=3D (clk_val & S3C64XX_SPI_PSR_MASK);
>>                 writel(val, regs + S3C64XX_SPI_CLK_CFG);
>>
>> +               /* Keep the actual value */
>> +               sdd->cur_speed =3D src_clk_rate / (2 * (clk_val + 1));
>
> Also need to consider S3C64XX_SPI_PSR_MASK here, because clk_val could
> actually be > S3C64XX_SPI_PSR_MASK.

Good point, but this

    clk_val =3D clk_val < 127 ? clk_val : 127;

seems more appropriate since masking may give very bogus value. Eg.

    src_clk_rate =3D 80000000 // 80 MHz
    cur_speed =3D 300000 // 300 kHz

    clk_val =3D 80000000/300000/2-1        =3D> 132
    clk_val &=3D S3C64XX_SPI_PSR_MASK      =3D> 4
    cur_speed =3D 80000000 / (2 * (4 + 1)) =3D> 8000000 // 8 MHz


>> +
>>                 /* Enable Clock */
>>                 val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
>>                 val |=3D S3C64XX_SPI_ENCLK_ENABLE;
>> --8<---------------cut here---------------end--------------->8---
>>
>>
>> >> > You are also affecting here not only timeout but
>> >> > s3c64xx_enable_datapath() which is not mentioned in commit log. In =
other
>> >> > words, this looks wrong.
>> >>
>> >> Indeed, there is a reference too. I've corrected the message.
>> >>
>> >
>> > Thanks!
>> >
>> > Best regards,
>> > Tomasz
>> >
>> >> >>
>> >> >> Cc: Tomasz Figa <tfiga@chromium.org>
>> >> >> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> >> >> ---
>> >> >>  drivers/spi/spi-s3c64xx.c | 1 +
>> >> >>  1 file changed, 1 insertion(+)
>> >> >>
>> >> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> >> >> index 02de734b8ab1..89c162efe355 100644
>> >> >> --- a/drivers/spi/spi-s3c64xx.c
>> >> >> +++ b/drivers/spi/spi-s3c64xx.c
>> >> >> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_s=
pi_driver_data *sdd)
>> >> >>              ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2=
);
>> >> >>              if (ret)
>> >> >>                      return ret;
>> >> >> +            sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
>> >> >>      } else {
>> >> >>              /* Configure Clock */
>> >> >>              val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
>> >> >> --
>> >> >> 2.26.2
>> >> >>
>> >> >
>> >> >
>> >>
>> >> --
>> >> =C5=81ukasz Stelmach
>> >> Samsung R&D Institute Poland
>> >> Samsung Electronics
>> >
>> >
>>
>> --
>> =C5=81ukasz Stelmach
>> Samsung R&D Institute Poland
>> Samsung Electronics
>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl9FMjYACgkQsK4enJil
gBBNNQf/ckOf5i5waSDTupH7mWGPQ5C4nH/KjRRr7UprzlQ00ktUqbleMte392r7
ndugky+h63kYtJYUHTKxOgoq2ZQOaeqc7+kyqgPc7Ln+rNaknlPesYiQeNlNNiEV
B6iH74vZn2yEMSujXvCSwl7rapKJPoT2sv7It/zhKGe43V72FrVw61CYImAJnpIs
A2nIINsfGjUntWQ6kczTB4Cv93pv54sPj4CAJXbI4MMYbqf7laiveqhvSjGbzSOO
zrcdBTmjSj3vsjbV56MUWdRNYmaWrk9TUBzoMhgGIUPWkc67FrJNi0NWq/+Givbn
BElTd0mc5NMp0PM79Yt2MFbB+Ga1Cw==
=O1Qp
-----END PGP SIGNATURE-----
--=-=-=--

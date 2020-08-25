Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46E62514EA
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHYJCQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 05:02:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48536 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgHYJCP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Aug 2020 05:02:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200825090212euoutp01700f5b9288498d259a8209f47c7530c0~ud1bdEimP0084600846euoutp019;
        Tue, 25 Aug 2020 09:02:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200825090212euoutp01700f5b9288498d259a8209f47c7530c0~ud1bdEimP0084600846euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598346132;
        bh=nELQW/qZXEXb5q6ziQQU/InqD+gC34e4yfOiwAkGpIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVotJBVHQa2SJXC/GPLHmnFaMBDWg7oG7CrZ4LaOIUdUauuIyfLnnLS2kXYeB9Cqd
         JbAp1s77YTwUNVGeao7Wc4uuX0Z1nRM9SrPsFKK6Y7U3tq1OueBszDUwbEZOdF2uja
         ilC6uZP0oteoK+0bnUVW0lx1aR+VjLdJi/8S6CWM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200825090212eucas1p150bcd747d4e709a207e26dd7a86bf9ce~ud1bEUhYL1252612526eucas1p12;
        Tue, 25 Aug 2020 09:02:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 53.31.05997.493D44F5; Tue, 25
        Aug 2020 10:02:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200825090211eucas1p1b63191fa778a775e33169ba2c1d3b74b~ud1amVFGr1917419174eucas1p1H;
        Tue, 25 Aug 2020 09:02:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200825090211eusmtrp19b47e5e8064a4b295d1c4478b18a4c6f~ud1allHsk1202112021eusmtrp1D;
        Tue, 25 Aug 2020 09:02:11 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-96-5f44d3945aba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.11.06017.393D44F5; Tue, 25
        Aug 2020 10:02:11 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200825090211eusmtip2d0eced059a8edbe0bafdf0e313467860~ud1aZ3n4s1247012470eusmtip27;
        Tue, 25 Aug 2020 09:02:11 +0000 (GMT)
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
Date:   Tue, 25 Aug 2020 11:01:53 +0200
In-Reply-To: <CAAFQd5ADym6YapCoJ8+fJbPjSestcD_2R8L5T8jAfO4c=GFQkA@mail.gmail.com>
        (Tomasz Figa's message of "Mon, 24 Aug 2020 15:21:34 +0200")
Message-ID: <dleftjk0xnw132.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUhUURjuzF3mqo2dRsuf0UInhTLSsrAbLVj5MA8+SERUUDbaRSVnjLm5
        VA8uoGjoKC40TZZZg8WUWja4FUpmboNONmAqaYsDpVbiUm455PUa9Pad/1v+7xwOQ8iHKAUT
        r73C6bTqBCXtSta1L9h2ldjDo3bPD7qxD+a/SthnhhqKLf3soNmC0QmCtdmeStna0X6KtTeV
        0azB1ixhM6YGpWxV27CUncly0mFuqtvpfaTqvWmaUNWac2nVc1OaSm8xI9VM7dZI+qzroYtc
        Qnwypws+csE1bkC/jC4vBqR294xQ6ah8yw3kwgDeB5X5Q9QN5MrI8SMEHQ4DJRByPIugf5QR
        iRkEw3deU/8cJcvVpEg8RPCt+6NUPHxFkOl8saJiGBoHQVXVacHgif1hqctACxoC3yehfsS8
        muSBz4DV2U8KmMQBMGQvWRW54EIE9VO/JQIhw/sh+8/0qmETPgCWb8I2Yb4Rum45Vs0E1sAt
        23ck1vslhbF33iIOh7lcx1ptDxjvsEhF7APW4jxSKAo4DYqLQoW9gPMQ1JXNk6LmIHzoXaRF
        fBSsTwyUqHeHgR8bxbXuUFR3kxDHMsjJlotqf6gueLmWooD88UdrzVSQa8yUiK9rQmBaDC1E
        vsb/LmP87zLGlVQC74CapmBxvBMqKyYIER+G6upJ8h6izMiLS+I1sRwfouVSgni1hk/SxgbF
        JGpq0covszo7ZhtQ05/oVoQZpFwvS28+HiWn1Mn8VU0r8l9J+vL08VukILWJWk7pKTvWYz0v
        l11UX73G6RKjdEkJHN+KvBlS6SXbe3/snBzHqq9wlzjuMqf7x0oYF0U64j/Zz/XpFY07DvpN
        xZx84LclfC7LP+Dn5s7FMW00YWyYoBZOvSlXDdRvregNMxaWb9f3LfCTge3qUjbyhGdJ6qv+
        iKWQwM+ejS1JNx/7WiL0e7XGznXbTvN965xtUr3jyWTBjLXmhdmRsWHUSxrY4aPXXG9JNe0Z
        ilsoi8y5m6Ik+Tj1nkBCx6v/Am7+G6JtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7qTL7vEGyz+q22x+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyaPx4k91i7ZG77BafW/+xOXB7zG64
        yOJxfcknZo9NqzrZPDYvqffo27KK0ePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jBt9fxkLfqlWnDp7j7WBcb5sFyMnh4SAicSUv+tY
        uhi5OIQEljJKNF66wNrFyAGUkJJYOTcdokZY4s+1LjaImqeMEt/ffAOrYRPQk1i7NgKkRkRA
        ReL3yRlsIDazwGQWiWdLDEFsYYFwiTtLnzGD2EICARLfzl1kBbFZBFQlbl2eAjaTU2ACo8T2
        j9+YQBK8AuYSbX8+gRWJClhKbHlxnx0iLihxcuYTFogF2RJfVz9nnsAoMAtJahaS1Cyg85gF
        NCXW79KHCGtLLFv4mhnCtpVYt+49ywJG1lWMIqmlxbnpucVGesWJucWleel6yfm5mxiBkbjt
        2M8tOxi73gUfYhTgYFTi4W3Y5xwvxJpYVlyZe4hRBWjMow2rLzBKseTl56UqifA6nT0dJ8Sb
        klhZlVqUH19UmpNafIjRFOjRicxSosn5wOSRVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qBccaDleLvfyoURE57nl/SwP+5/dBZGT7XO7/evTb95BfLslOorurC
        9qn6d088mLjk0rNtc/OXWj3Knl971nzt3ntZRQelzz1SVV/pGu9b0nN5USGT+uVLz6wEGRhz
        D/ZvsmC/fXan06yDrZGaErZltlqT/13gmeKq9yvo8YXpHSuDdUszvVVa1yixFGckGmoxFxUn
        AgCFIZFV5gIAAA==
X-CMS-MailID: 20200825090211eucas1p1b63191fa778a775e33169ba2c1d3b74b
X-Msg-Generator: CA
X-RootMTR: 20200825090211eucas1p1b63191fa778a775e33169ba2c1d3b74b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200825090211eucas1p1b63191fa778a775e33169ba2c1d3b74b
References: <CAAFQd5ADym6YapCoJ8+fJbPjSestcD_2R8L5T8jAfO4c=GFQkA@mail.gmail.com>
        <CGME20200825090211eucas1p1b63191fa778a775e33169ba2c1d3b74b@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-24 pon 15:21>, when Tomasz Figa wrote:
> On Mon, Aug 24, 2020 at 3:17 PM Lukasz Stelmach <l.stelmach@samsung.com> =
wrote:
>>
>> It was <2020-08-22 sob 14:43>, when Krzysztof Kozlowski wrote:
>> > On Fri, Aug 21, 2020 at 06:13:59PM +0200, =C5=81ukasz Stelmach wrote:
>> >> cur_speed is used to calculate transfer timeout and needs to be
>> >> set to the actual value of (half) the clock speed for precise
>> >> calculations.
>> >
>> > If you need this only for timeout calculation just divide it in
>> > s3c64xx_wait_for_dma().
>>
>> I divide it here to keep the relationship between the value the variable
>> holds and the one that is inside clk_* (See? It's multiplied 3 lines
>> above). If you look around every single clk_get_rate() call in the file =
is
>> divided by two.
>>
>> > Otherwise why only if (cmu) case is updated?
>>
>> You are righ I will update that too.
>>
>> However, I wonder if it is even possible that the value read from
>> S3C64XX_SPI_CLK_CFG would be different than the one written to it?
>>
>
> It is not possible for the register itself, but please see my other
> reply, where I explained the integer rounding error which can happen
> when calculating the value to write to the register.

I don't have any board to test it and Marek says there is only one that
doesn't use cmu *and* has an SPI device attached.

Here is what I think should work for the !cmu case.

=2D-8<---------------cut here---------------start------------->8---
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 18b89e53ceda..5ebb1caade4d 100644
=2D-- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -655,13 +655,18 @@ static int s3c64xx_spi_config(struct
s3c64xx_spi_driver_data *sdd)
                        return ret;
                sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
        } else {
+               int src_clk_rate =3D clk_get_rate(sdd->src_clk);
+               int clk_val =3D (src_clk_rate / sdd->cur_speed / 2 - 1);
+
                /* Configure Clock */
                val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
                val &=3D ~S3C64XX_SPI_PSR_MASK;
=2D               val |=3D ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / =
2 - 1)
=2D                               & S3C64XX_SPI_PSR_MASK);
+               val |=3D (clk_val & S3C64XX_SPI_PSR_MASK);
                writel(val, regs + S3C64XX_SPI_CLK_CFG);

+               /* Keep the actual value */
+               sdd->cur_speed =3D src_clk_rate / (2 * (clk_val + 1));
+
                /* Enable Clock */
                val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
                val |=3D S3C64XX_SPI_ENCLK_ENABLE;
=2D-8<---------------cut here---------------end--------------->8---


>> > You are also affecting here not only timeout but
>> > s3c64xx_enable_datapath() which is not mentioned in commit log. In oth=
er
>> > words, this looks wrong.
>>
>> Indeed, there is a reference too. I've corrected the message.
>>
>
> Thanks!
>
> Best regards,
> Tomasz
>
>> >>
>> >> Cc: Tomasz Figa <tfiga@chromium.org>
>> >> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> >> ---
>> >>  drivers/spi/spi-s3c64xx.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> >> index 02de734b8ab1..89c162efe355 100644
>> >> --- a/drivers/spi/spi-s3c64xx.c
>> >> +++ b/drivers/spi/spi-s3c64xx.c
>> >> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_=
driver_data *sdd)
>> >>              ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
>> >>              if (ret)
>> >>                      return ret;
>> >> +            sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
>> >>      } else {
>> >>              /* Configure Clock */
>> >>              val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
>> >> --
>> >> 2.26.2
>> >>
>> >
>> >
>>
>> --
>> =C5=81ukasz Stelmach
>> Samsung R&D Institute Poland
>> Samsung Electronics
>
>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl9E04EACgkQsK4enJil
gBDGmwf9GF7LoqlLOeEGgYseadIIz0SaVDnQx04lZNBEvKy5teghZc/iWOoe4B6E
xknfXtPzzgJdukcCUjs6RVtNqkLI1O2t8eAHhnT6fYP4fi1vJDmyUwjdum2mVlhx
z54qiFeXWFBqimcEKwfxBqcdLnCq5HVgwndthlBLkk3841KrOxrzOk0DF9HyL9Yc
DpiGijpDOo1IcqwMdizgnl04pEvuZ+dGoLWF8xYWW5vmhPrGu1O1dHRzhrPv7nCv
TIk2+eQ+yzC1FKShL644NRwY+C10QECDx0h/VTbuDu94UKGzR4a5MDFD8oXN4s8p
sh5/Irl1LVF4WEf+xAx3Tps7E5PSeQ==
=5KAi
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471C024A038
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgHSNkC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:40:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33723 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgHSNj7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:39:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819133957euoutp02c4db272be98c3e46bf19a6c49ff125a6~srwOY63NE2769327693euoutp02G;
        Wed, 19 Aug 2020 13:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819133957euoutp02c4db272be98c3e46bf19a6c49ff125a6~srwOY63NE2769327693euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597844397;
        bh=iIcTFaAdH5T4Y8qwSWvOXJbTBOWw25ScDXfJBdoMYqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Frc+qrSUisj399CD7uY1wZYCtt9VCjPcRrnpuUBB7lFi8aqJM7jYU89Cyug/KQCL1
         v/ZjyrPjF5APZgr33R3YJHAxujInx6mUFBH4d0VPQi9jErMJfAyghtn9BsI3O/ooNs
         cqM7/c6dM3MbcP98AMPUmeGf+wqSVvUj9kL/kSoU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200819133957eucas1p14647d055caeef55d2670aca5aedf558a~srwOGZ2am2661626616eucas1p1R;
        Wed, 19 Aug 2020 13:39:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.66.06456.DAB2D3F5; Wed, 19
        Aug 2020 14:39:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200819133957eucas1p293192baeabb9788ac9148068c1627a57~srwNwCL-d3012430124eucas1p2z;
        Wed, 19 Aug 2020 13:39:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819133957eusmtrp2303b4fb4ea45a2e8997edc066b5d2d49~srwNvTWnJ0526905269eusmtrp2h;
        Wed, 19 Aug 2020 13:39:57 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-c9-5f3d2bad9bff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.AA.06314.DAB2D3F5; Wed, 19
        Aug 2020 14:39:57 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819133956eusmtip270353a676e9ad14b01447d5daf6d269c~srwNlKNcY1052810528eusmtip2_;
        Wed, 19 Aug 2020 13:39:56 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 7/8] spi: spi-s3c64xx: Increase transfer timeout
Date:   Wed, 19 Aug 2020 15:39:56 +0200
In-Reply-To: <20200819124940.GG18122@kozik-lap> (Krzysztof Kozlowski's
        message of "Wed, 19 Aug 2020 14:49:40 +0200")
Message-ID: <dleftjblj621qr.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOduZo8jqVPWilLCVM1MTKE2mYGgyJ8kOEBaVLD2q5qTu6
        0j54iS5e0tDMS0Jp3jLmLR0pUiFeKJszK69peQHzUpFLtCht8yj07ff+n/9z5RUSEgPfThit
        SmDUKkWMTCAidd2/DG5aV9/Qfb1DUvrR6iyPbiyq59MFkzMCOnd6gaANhgaKbpoe5NPv2koF
        dJHhOY9O+zFC0drOccpPJB+qWCLkTbUZAvnTihR5TnMtkhubdgXzz4p8IpiYaA2j9jgSJorK
        0K1Rcbn4ynLjMJWKxsWZyEIIeD/oG4yUmSW4BkHe8MFMJDLxTwTfXlYT3MOIwLhSgbYyat7f
        Q1xGNYLSCSlnmkXwuWDKFBAKBdgdtNoQs8cGu8DQ3xW+2UPgah5UjqVtJFvjQFidXyLMTGJn
        aL+es8EWWAMt2h6emcXYG/QDYxu6LT4EzV8+UZxuBa+KZ0gzE1gJxYbFzeFGKdDfDOc4EMoX
        qwmOrWG+p5nieAestz7gmecEnAL5eRsbA85GoCtdJTnPYfjY91vA8VHoGlwjOL8lDH+14tpa
        Qp6ucFMWw60bEs7tBHW57ZtV7OD2fM3mZHKYWxohuVOlIxguv4buIMeS/7Yp+W+bElNZwnS6
        +jYPTnaFqrIFgmNfqKv7Tj5E/FokZRJZZSTDeqqYy+6sQskmqiLdw2OVTcj0tXrXepaeoeWB
        Cx0IC5FsuzhY5hsq4Ss0bJKyAzmZKk01POlHdqQqVsXIbMT++t7zEnGEIimZUceGqhNjGLYD
        2QtJmVTsVT53ToIjFQnMJYaJY9RbUZ7Qwi4V+X2YcrTtdHmdH+2lbUtw8SkqX2/2ZwoLnLP1
        4S1BmgB13IE9206N/pEeTzrt7VryJvrkXcqW3TnYWj8dlbR70n7Qo1LxQhvW4tCXVSbXHEOR
        J7zG+89M6ia8xtI1b/FM30xX1mhZ6ojI2H1/KqDqcYdbd1B8CP/iwHrr1XhHh2QZyUYpPPcS
        albxD/esshNiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7prtW3jDZ6vYbZY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddgcuj+tLPjF7bFrV
        yeaxeUm9R9+WVYwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GV0bvvHXtAvUPF14w32Bsa7vF2MnBwSAiYSK65MY+xi5OIQEljKKHGp
        7zFzFyMHUEJKYuXcdIgaYYk/17rYIGqeMkpcfvaLBaSGTUBPYu3aCJAaEQFNiet/v7OC2MwC
        85kkfv/yALGFBVwkfrz6BDZSCKh88wkLkDCLgKrEntY+ZhCbU6BM4s8JkPGcHLwC5hJnL90G
        i4sKWEpseXGfHSIuKHFy5hMWiPHZEl9XP2eewCgwC0lqFpLULKBtzEAXrd+lDxHWlli28DUz
        hG0rsW7de5YFjKyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNu27Gfm3cwXtoYfIhRgINR
        iYc3QMk2Xog1say4MvcQowrQmEcbVl9glGLJy89LVRLhdTp7Ok6INyWxsiq1KD++qDQntfgQ
        oynQnxOZpUST84FJIq8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dU
        A6NqjvUc3nSttSs3+R89Nn/pIo5DF39yrg2Qms57f73JNn2ldQdsT9+zfj5v8w8htdQf6ewJ
        ck5GyUxtvkf61PIKHJvVJO85+XZxxYueFqg/GCKrp91qt65pa15GR2mNy/zSc+nfpndJlOVb
        FIcXW3JElMX/239Bad6G5XOlvpd37XH+2v+kVImlOCPRUIu5qDgRAIkJNMDaAgAA
X-CMS-MailID: 20200819133957eucas1p293192baeabb9788ac9148068c1627a57
X-Msg-Generator: CA
X-RootMTR: 20200819133957eucas1p293192baeabb9788ac9148068c1627a57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819133957eucas1p293192baeabb9788ac9148068c1627a57
References: <20200819124940.GG18122@kozik-lap>
        <CGME20200819133957eucas1p293192baeabb9788ac9148068c1627a57@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 14:49>, when Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 02:32:07PM +0200, =C5=81ukasz Stelmach wrote:
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>
> Why? Everything works fine and suddenly minimum timeout is 100 ms?

Actually I am not 100% sure the max() call is required, maybe +30 is
enough. Definitely some minimum value is required because for small
tranfers (100s of bytes) ms is 0 after the first assignment.

>> ---
>>  drivers/spi/spi-s3c64xx.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 27d77600a820..27db1e0f6f32 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -464,7 +464,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_d=
river_data *sdd,
>>=20=20
>>  	/* millisecs to xfer 'len' bytes @ 'cur_speed' */
>>  	ms =3D xfer->len * 8 * 1000 / sdd->cur_speed;
>> -	ms +=3D 10; /* some tolerance */
>> +	ms =3D (ms * 10) + 30;    /* some tolerance */
>> +	ms =3D max(ms, 100);      /* minimum timeout */
>>=20=20
>>  	val =3D msecs_to_jiffies(ms) + 10;
>>  	val =3D wait_for_completion_timeout(&sdd->xfer_completion, val);
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

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl89K6wACgkQsK4enJil
gBAGyAf8DV/xvxnpKI9QcLDIG7j5YcNjd6eJRT9NfVCSEj36wbS1vI62YA8RMCWr
9lVuQTXgZXhVsbv3JnYny82tw8mdxwd/QwMrK6n4RmXOCcowe5xNAOyd9B5jqiSZ
/bsY53uMtgMKMAlHjTg5FPEgJwb+rTU+zUFNp3CygSRUFaCMF6mWI/WNeTxFwc2e
hEhkhSNJr3nzJxr5YdRrOPFhTA234L5U9bu5cGv5wGxdvT7Ha8j/KcFMXoOXTKEp
0HGYWrKNGmww+iPGnPIWdbLnNMV5V34z7THEQaQ/Blchv3jUwEIDsoytPMY2U4H6
UJs/IX/FmYzeZCdwO/nSKBPYNYspPA==
=i4e8
-----END PGP SIGNATURE-----
--=-=-=--

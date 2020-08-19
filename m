Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3559224A016
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHSNd4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 09:33:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59211 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgHSNdh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 09:33:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819133334euoutp020352fc292c3a0a4b7842c4ce98e59e21~srqpyMS4g2309023090euoutp02f;
        Wed, 19 Aug 2020 13:33:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819133334euoutp020352fc292c3a0a4b7842c4ce98e59e21~srqpyMS4g2309023090euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597844014;
        bh=zMUXHTYnB1hgtZY2XvkgLJVtoSLdRUf02CsOMq63azA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4TujdAtKT1hJBUUldquFdcXVAuB1/TPrjijPQS1inPxRSYdTLabRE2xEFoHCj26h
         XRtNcfVzNCP2SWrIxNWYGfD2nY3QCjKu8u0DzLonFODKTI3TMV1EG5NbBEikAwX+n+
         j8VBsnDHMzo8pXNfnyTc71CwzoFYBAC0mUQHJoAs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200819133334eucas1p2bec685af8a447f39e5d4dce3ebd8a7a7~srqpafQAP0913009130eucas1p2k;
        Wed, 19 Aug 2020 13:33:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.4E.06318.E2A2D3F5; Wed, 19
        Aug 2020 14:33:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200819133334eucas1p2080182850c7ba84829e3304a1172afff~srqpD9EQX2464024640eucas1p24;
        Wed, 19 Aug 2020 13:33:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200819133334eusmtrp139a84cc966efd7a9c8916ba67936c34c~srqpDR8M42440924409eusmtrp1n;
        Wed, 19 Aug 2020 13:33:34 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-1e-5f3d2a2ead1b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.A9.06314.D2A2D3F5; Wed, 19
        Aug 2020 14:33:34 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819133333eusmtip17fe7df747953e9d82e146ca09dafa358~srqo3fPiz0082100821eusmtip1d;
        Wed, 19 Aug 2020 13:33:33 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 8/8] spi: spi-s3c64xx: Turn on interrupts upon resume
Date:   Wed, 19 Aug 2020 15:33:33 +0200
In-Reply-To: <20200819125301.GI18122@kozik-lap> (Krzysztof Kozlowski's
        message of "Wed, 19 Aug 2020 14:53:01 +0200")
Message-ID: <dleftjft8i221e.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7p6WrbxBnOmy1gs/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYe+QuuwOXx/Uln5g9Nq3q
        ZPPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDImvz3PVHCSt6JvUgtrA+Mb7i5GTg4J
        AROJX2eWMnUxcnEICaxglPizazMLSEJI4AujxKrGIIjEZ0aJey9escN0zL04kREisZxRou/j
        MWYI5zmjxO+974GqODjYBPQk1q6NAGkQEdCUuP73OytIDbPAciaJpbcbGUESwgKeEi0z1rKC
        2CwCqhL7n5wBszkFyiS2ft4FZvMKmEu0zl0FdpKogKXElhf32SHighInZz4BizML5ErMPP8G
        7CIJgVvsEttaV0Gd6iJx7scvRghbWOLV8S1QcRmJ05N7WEAOlRCol5g8yQyit4dRYtucHywQ
        NdYSd879YoOwHSV+X53HDFHPJ3HjrSDEXj6JSdumQ4V5JTrahCCqVSTW9e+BmiIl0ftqBdQF
        HhJXj2xgh4RVEzCs5i5mm8CoMAvJO7OQvDMLaCwzMOzW79KHCGtLLFv4mhnCtpVYt+49ywJG
        1lWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBiev0v+NfdzDu+5N0iFGAg1GJhzdAyTZe
        iDWxrLgy9xCjCtCkRxtWX2CUYsnLz0tVEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv
        8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbG66/jfnVp/lh3emt5oajRebcT/Zn+i9jTzzNq+e+6
        GCG/RqroeMB57kCfJS2mkSf+GTB/+3h1tmn27fX1YdY/ZnbVyq8Jmayov+ABUwKb8ZMnofNX
        mVusljLUPVh9WDNcve7hXrntM9b+frb9p7e1p1rzXuPZkcksd+zKr/jkKd1OOyfCG/VKiaU4
        I9FQi7moOBEANZ0ISGQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7p6WrbxBjMWMFks/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYe+QuuwOXx/Uln5g9Nq3q
        ZPPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DImvz3PVHCSt6JvUgtrA+Mb7i5GTg4JAROJuRcnMnYxcnEICSxllHj1
        /AV7FyMHUEJKYuXcdIgaYYk/17rYQGwhgaeMEm0fPEBK2AT0JNaujQAJiwhoSlz/+50VxGYW
        mM8k8fuXB4gtLOAp0TJjLStEq57E7wu3mUBsFgFVif1PzrCCjOEUKJP4tcYEJMwrYC7ROncV
        C4gtKmApseXFfXaIuKDEyZlPWCDGZ0t8Xf2ceQKjwCwkqVlIUrOApjIDXbR+lz5EWFti2cLX
        zBC2rcS6de9ZFjCyrmIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMt23Hfm7ewXhpY/AhRgEO
        RiUe3gAl23gh1sSy4srcQ4wqQGMebVh9gVGKJS8/L1VJhNfp7Ok4Id6UxMqq1KL8+KLSnNTi
        Q4ymQG9OZJYSTc4Hpoi8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TByc
        Ug2MKhJGpk5S50R7VFZLnTx8fbuE9NlYw/yUtvbPIXfLWNv2JvFtPeZXPFMuOfEpH/PpSX7L
        F2lMDjvu1TD/h9FPKSvXbXk+m3ne1h7KDejpSg1VFp7WcDlRIcUpXbHa+5RB0ZdUxUfXA1r2
        hU55dalGUYehr2TWtuDeD6mt8Xyu3r1F1kIpLUosxRmJhlrMRcWJAK9wU9nZAgAA
X-CMS-MailID: 20200819133334eucas1p2080182850c7ba84829e3304a1172afff
X-Msg-Generator: CA
X-RootMTR: 20200819133334eucas1p2080182850c7ba84829e3304a1172afff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819133334eucas1p2080182850c7ba84829e3304a1172afff
References: <20200819125301.GI18122@kozik-lap>
        <CGME20200819133334eucas1p2080182850c7ba84829e3304a1172afff@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 14:53>, when Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 02:32:08PM +0200, =C5=81ukasz Stelmach wrote:
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 27db1e0f6f32..5dcad43fb847 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -1356,6 +1356,10 @@ static int s3c64xx_spi_runtime_resume(struct devi=
ce *dev)
>>=20=20
>>  	s3c64xx_spi_hwinit(sdd);
>>=20=20
>> +	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
>> +	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
>> +	       sdd->regs + S3C64XX_SPI_INT_EN);
>> +
>
> Makes sense but you should explain in the commit msg what happens
> without this (or why they are not enabled).

Done, thanks.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl89Ki0ACgkQsK4enJil
gBBkUQgAqFQPlbvtADVT26WER/P36D2GP9WOAK7ktgcjfzcGS36/m+SConShb6V/
5HcENMhHWwTMXzFHYmMiUVtv0+nuzsDKKNbeTsb5qI5CX3fGa8DFueJA7WpBXBrl
IGR7wkYTYY+KhPmea67VhHaW8a2+e3RhJ6g+VZ59ucpl/Cz7mQ5Yebxsys2fXnVY
5tTMFJ2tCzWn9hryxDY3elEIPyWB+1ST/GVRRyjDgbuzhkK3K9zl12wIiE/kXIqN
voCk9xJz53nKW4rXZ6IYvF9Rz9X2XDCexBlJuX3681ClAxFpmLyUqENA0dxDps2z
QchFYMvRLXdlNdO3WJ+w9LeEL8lHtw==
=Lvij
-----END PGP SIGNATURE-----
--=-=-=--

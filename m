Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF72324A360
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgHSPmB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 11:42:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49410 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgHSPl4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 11:41:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819154154euoutp0294efa226cfd2210a26fdfbccbf4e7ece~stasyZfQn0907909079euoutp02s;
        Wed, 19 Aug 2020 15:41:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819154154euoutp0294efa226cfd2210a26fdfbccbf4e7ece~stasyZfQn0907909079euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597851714;
        bh=+3LTfythzNTv++mjfXoCgwrGfVc6yX0vN7TRVy0kjW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbWUK4bgOKd97tgrd9V9i/28gdlGaM8bVY/r+DVHY12od9qa6Cai4n1S/GZvK7VPQ
         n1yhHR03GIGll+FkDtg3K4CrlhFI778D56/H7GXjOV1LkxDMsgpdl8KgQuwZIi0Rj6
         Ddggi9glpQfZZbY3Y4vNkNJG1AEpkd9uMEHrfCI8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200819154154eucas1p1679e4f547521082a4db6edac85ef44b9~staslB-P22451924519eucas1p1b;
        Wed, 19 Aug 2020 15:41:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5F.C7.06456.2484D3F5; Wed, 19
        Aug 2020 16:41:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200819154154eucas1p1e88747d2495e6d1074991419504066df~stasQxu7k2451924519eucas1p1a;
        Wed, 19 Aug 2020 15:41:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819154154eusmtrp298d238db742f81a255aef93733d503b4~stasQGFZf1443314433eusmtrp2T;
        Wed, 19 Aug 2020 15:41:54 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-cb-5f3d48427548
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.CA.06314.2484D3F5; Wed, 19
        Aug 2020 16:41:54 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819154153eusmtip2cbca2ea14f85b22be552a8fc35027915~stasFxwIh2349023490eusmtip28;
        Wed, 19 Aug 2020 15:41:53 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 6/8] spi: spi-s3c64xx: Check return values
Date:   Wed, 19 Aug 2020 17:41:43 +0200
In-Reply-To: <20200819124833.GF18122@kozik-lap> (Krzysztof Kozlowski's
        message of "Wed, 19 Aug 2020 14:48:33 +0200")
Message-ID: <dleftjwo1uzlqg.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1zdahoWZsUW4qEtOABkRwQRyCJUL8mB8S1B+DClSZFIQW0wIK
        H0L9cCEiLgEFCVR2kbUQpA2QWIwECVQ07oBhURBEw6IsKkqZmvB37rnnnnfuzaNxaR8pp+O0
        SbxOq0pQUGKi+emibWcop4za9b53E1uyMIaxDXfrSDZnaJRis0cmcdZmqxexppHXJPvSUkCx
        d23tGGuYfidia54MiA6KuTelMzhnqrpKcY2l6dz1pirEzZrcw8kI8YEYPiEuhdf5BUeLY4fM
        37Cz85vOtxtHsQzULstETjQw/tDXZhFlIjEtZSoRVE/XY0Ixh6Bn6hkuFLMI6loqRP9Heoo6
        HCMVCBqzugihGEMwbe4mMxFNU4wv1NQcsw+4MF7w5s88adfgTAUGZR8MyN6QMcGQWze/6kow
        ntBa37zKOzEp0PqqlLJjCbMfatoMhB1vZAKhafyjSOA3QFfe6CqPMxrIs31FQrpBEfx8rBTw
        IZgtzSAELIOJzibHBm7w11yE2XMCkw63bwXYswFzDUFzwYJDHwT9vUuUgEOgO9tMCfr18HZq
        g/DserjVfAcXaAlcuSQV1B5Qm93qcJFD1kSlIxkH5R0PKOFUFxGU9A+iG2hr/ppt8tdsk79i
        i6+crs7iJ9A7oPz+JC5gJdTWfieMiKxCrnyyXqPm9bu1/DlfvUqjT9aqfU8nakxo5XN1L3fO
        tKAfL05ZEUMjhbMkXKGMkpKqFH2qxoo8VpyG6x8+R3JCm6jlFS6S0J7uSKkkRpWaxusSo3TJ
        CbzeijbThMJVsrf4y0kpo1Yl8fE8f5bX/e9itJM8Ax1xbigp21IRQ1WKvH4XWmKNyOgjqz3e
        cFidqzGHcJ+rl/zH3Rf3GfDRJfnlZakpPWjSNBzwKWgpIMwodxsL75zZhu5Nqs5Y+9eVe5wo
        vOm5Lo3m4neZLcVzaOACS+T8Ko9u32PevnDUJ7BLhpHeOBc2EPFqvBAeyR5GyoYUhD5Wtdsb
        1+lV/wDvBYpaZAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7pOHrbxBvuuslgs/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYe+QuuwOXx/Uln5g9Nq3q
        ZPPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DIe7nzHVPBdrGLfgidMDYz7hLsYOTkkBEwkzs4/zN7FyMUhJLCUUWLH
        hFVADgdQQkpi5dx0iBphiT/Xutggap4ySrw7vZMJpIZNQE9i7doIkBoRAU2J63+/s4LYzALz
        mSR+//IAsYUF7CSmrf/ODmILAZXvn3yTEcRmEVCV2LNhG5jNKVAmsWXTeTYQm1fAXGLt3kYW
        EFtUwFJiy4v77BBxQYmTM5+wQMzPlvi6+jnzBEaBWUhSs5CkZgFdxwx00vpd+hBhbYllC18z
        Q9i2EuvWvWdZwMi6ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDmth37uXkH46WNwYcYBTgY
        lXh4A5Rs44VYE8uKK3MPMaoAjXm0YfUFRimWvPy8VCURXqezp+OEeFMSK6tSi/Lji0pzUosP
        MZoC/TmRWUo0OR+YJvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBK
        NTBG37NdX/K57coszzTm3I/WYp1LE+V/zvvMce/dOu7ff5oPr3VoW6HjOeMsRwnLrt/BZ3i4
        Yrc2zU0TSft3aFr9Lt6Lfkpc5ka3FV4eCdnRlRL6/EWYi+3uyuh8V7OHL1fHTJTm2p+qvvLD
        qQdPrt1tnDPL9JA+59VPARN+R60pFtulcLV2d4KDEktxRqKhFnNRcSIAvw7a1tsCAAA=
X-CMS-MailID: 20200819154154eucas1p1e88747d2495e6d1074991419504066df
X-Msg-Generator: CA
X-RootMTR: 20200819154154eucas1p1e88747d2495e6d1074991419504066df
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819154154eucas1p1e88747d2495e6d1074991419504066df
References: <20200819124833.GF18122@kozik-lap>
        <CGME20200819154154eucas1p1e88747d2495e6d1074991419504066df@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 14:48>, when Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 02:32:06PM +0200, =C5=81ukasz Stelmach wrote:
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>
> Oh, come on, stop fixing the same local issue without fixing bigger
> picture... or at least documenting why bigger picture does not have to be
> fixed and simple 'return' is enough.
>
> That's the third, same fix for the same problem.
>
> https://lore.kernel.org/lkml/20190314064202.14864-1-kjlu@umn.edu/
> https://lore.kernel.org/lkml/20170207204520.h2eo3yn5kge56lk7@kozik-lap/

No wonder. There is a possible NULL dereference below. Now at least we
know something about conditions that led to this.

Should I drop the entire patch, or just the dmaengine_prep_slave_sg() part?


>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 505789f91fdf..27d77600a820 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -273,6 +273,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data =
*dma,
>>  	struct s3c64xx_spi_driver_data *sdd;
>>  	struct dma_slave_config config;
>>  	struct dma_async_tx_descriptor *desc;
>> +	int ret;
>>=20=20
>>  	memset(&config, 0, sizeof(config));
>>=20=20
>> @@ -296,11 +297,22 @@ static void prepare_dma(struct s3c64xx_spi_dma_dat=
a *dma,
>>=20=20
>>  	desc =3D dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>  				       dma->direction, DMA_PREP_INTERRUPT);
>> +	if (!desc) {
>> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
>> +			dma->direction =3D=3D DMA_DEV_TO_MEM ? "rx" : "tx");
>> +		return;
>> +	}
>>=20=20
>>  	desc->callback =3D s3c64xx_spi_dmacb;
>>  	desc->callback_param =3D dma;
>>=20=20
>>  	dma->cookie =3D dmaengine_submit(desc);
>> +	ret =3D dma_submit_error(dma->cookie);
>> +	if (ret) {
>> +		dev_err(&sdd->pdev->dev, "dmaengine_submit() failed %d", ret);
>> +		return;
>> +	}
>> +
>>  	dma_async_issue_pending(dma->ch);
>>  }
>>=20=20
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

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl89SDcACgkQsK4enJil
gBCFvwf/U3GIG9r6kah4oC6fVqlh4pJlpN0oC31o99MFi3IlOa+5yKeISF4KFRyZ
UzK3BaiG6F9iFmnB8quCe70J93nF2HrMyDXe8NPwg9Ed9KUDDGYAmCf3J/2ITnQA
coOPsjv7MI9Dj4iH62j/+nNanvZiwHIdEXOo2ygTumwVdQlbusetp0mOAboCUB1N
Fc0HF7cr5yHq8hC0nSbdnqjl3rTCWAP8F8zFGYZbzYrF1gnwKR6wr+IplUdSKWk4
RXmGYN9YMTswsRlEub63Sc9IKkfrv0TWy56+Hl/fhCGDq85gvAQohsqAnQbTnSlz
JaB/XzshJlULJ3Ltn7YayRTW68Gw+w==
=dxGg
-----END PGP SIGNATURE-----
--=-=-=--

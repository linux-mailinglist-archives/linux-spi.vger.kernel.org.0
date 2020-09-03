Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACBE25BDA3
	for <lists+linux-spi@lfdr.de>; Thu,  3 Sep 2020 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgICIqA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Sep 2020 04:46:00 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35257 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgICIp7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Sep 2020 04:45:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200903084556euoutp0232b08fb299a8bc86bde9cb569044d9fa~xOaymYDr30387003870euoutp02i;
        Thu,  3 Sep 2020 08:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200903084556euoutp0232b08fb299a8bc86bde9cb569044d9fa~xOaymYDr30387003870euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599122756;
        bh=yq1RRtsL5Qlu1UxYV7nPs1+fpVjy+DD5OU1/D90hnVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Htal2BoqGRYQTYtecsPZUdHzIAAapF2XCWGhcLPsWKbJwAM++rASE+6JIAiyBLjDC
         oWoaqJZmP+STS7UyHDjL3l64Z+AcZSrPdWsuUhmoEiAx5EjZykUrbL0giedSEvsCTZ
         5T14dRbteMNYO8qfbVjSeiq37qxH4kk93koprZhg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200903084556eucas1p2d3465d89ad793acba20a7240c19835a6~xOayS3qxj0483904839eucas1p27;
        Thu,  3 Sep 2020 08:45:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.96.06456.34DA05F5; Thu,  3
        Sep 2020 09:45:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200903084555eucas1p2f40375edb325107b68966fd52198b220~xOax9taqn0889108891eucas1p25;
        Thu,  3 Sep 2020 08:45:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200903084555eusmtrp1b878b8e0f028c6ba3f8ad1e394654107~xOax8_5wA1506315063eusmtrp1z;
        Thu,  3 Sep 2020 08:45:55 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-01-5f50ad43a5f5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.8E.06017.34DA05F5; Thu,  3
        Sep 2020 09:45:55 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200903084555eusmtip218307a027bef21b448dd0b4532fbe0f4~xOaxu116n2347923479eusmtip2o;
        Thu,  3 Sep 2020 08:45:55 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 6/9] spi: spi-s3c64xx: Check return values
Date:   Thu, 03 Sep 2020 10:45:35 +0200
In-Reply-To: <fa403451-5f61-8edf-c696-2d020ec5b920@kernel.org> (Sylwester
        Nawrocki's message of "Wed, 2 Sep 2020 10:14:01 +0200")
Message-ID: <dleftjmu27s0y8.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3e57n7p7S5deRvjuW3OoPrEtKnkYmsV3zh4Y/zJCrnsV0V91T
        lJcVJUo5lahz5uWutLhezmkV+qMlWnRGKyyMIhXlitGxmx5Ptv77/L6fl+/LfjQp6xXJ6QPa
        NFanVScpxO5UY8eUPXCTJSZ2pWszY/o1RDAN5XUipuz9oJjRD4ySjN1eL2GsA70i5kWLUcyU
        21sJ5oTjlYSxtL+RMKc/DpMb5qr6zBOkylqTL1bdMWepztlqkGrS6hsj2uW+LoFNOnCI1QWt
        3+e+f/x2rjglX55x5XUzmY16vQuQGw04FHJMTnEBcqdluBrB1FA3wRMy/B1Bx5SXQEwiGGtt
        l/x3dPYUEQJxE8HZ0mxKeAwhcI50kAWIpsVYCRbLTt6wAAeC48EpkteQuJuAqzk9JE/Mx5Fg
        /P6b4jGFA+DB6Kd/QW44B8HTb2bEE1K8Bvp6TCIee+NwsH1+JxHqXtBZMfjPTGINVNi/IN4M
        2CGBi3VOQph1ExTUDyABz4eRR7aZHRZDV2khxU8KOAtKS8IEbyGCRuMvStCshf5u/jI8joRn
        +iok6D3h5Vcvoa8nlDReIoWyFM7kyQS1P9Tq78+kyKFopHpmAhXkui4g4VjFCCrGXcR55GeY
        tY5h1jqG6VgSL4O6liChvAKqro+SAo6A2tpx6hoS1SAfNp3TJLJcsJY9rOTUGi5dm6iMT9ZY
        0fQP63I9mmhCP57HtSFMI4WH9PHdrbEykfoQl6lpQ/7TSR/qbz1DckqbrGUVC6Qbn3btlUkT
        1JlHWF1yrC49ieXa0CKaUvhIQ24M75HhRHUae5BlU1jdf5ag3eTZKO6Y8ffRqKDlHxqOthbr
        U8OGwgpPOIadnDLqj/+TUNc8UWp0mT7VZPlpWpcRblirN58snGSbbhVdDll65V7lw/bO42eW
        2GoM4eKmSWtxsLXC9/1YRutxY0y/R9nlbQsr/fpKzITXlo/b+1a/TctzVIYGZDkjdjTv3X0k
        OnnOsvhVLQqK268OXk7qOPVfjxIh82kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7rOawPiDTZMU7ZY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddov2py+ZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl/F+TQtbQadUxdxbO5kbGK+JdjFyckgImEicvNLL1MXIxSEk
        sJRRovXLHSCHAyghJbFybjpEjbDEn2tdbBA1TxklFvVuA6thE9CTWLs2AqRGREBX4uPeVmaQ
        GmaB40wScw98ZQJJCAs4Ssz58psFxBYSsJXo/nGMDcRmEVCV2Pv6GQtIA6dAM6PE2Q9LGEES
        vALmEtevLGYFsUUFLCW2vLjPDhEXlDg58wnYIGaBbImvq58zT2AUmIUkNQtJahbQfcwCmhLr
        d+lDhLUlli18zQxh20qsW/eeZQEj6ypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzACNx27OeW
        HYxd74IPMQpwMCrx8J7Y6h8vxJpYVlyZe4hRBWjMow2rLzBKseTl56UqifA6nT0dJ8SbklhZ
        lVqUH19UmpNafIjRFOjRicxSosn5wKSRVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBkWf1jMpD/3awGS35Mn0mV5Hz4wvvZ7yKPKC23+24x/9kszn7Xtq+n5vr
        tkTn+H3BPE2/zUHT7y5bl3I7qfnGorYel+DzJTxcxql5lqs+XJBjl79TobpKulBk04FJt322
        PTsjeFdWVOmnvqnX4tX5e5br1Hb5FOjbijW5f9pZ8H/5Ubn4rb1PXiuxFGckGmoxFxUnAgDR
        6bi/4gIAAA==
X-CMS-MailID: 20200903084555eucas1p2f40375edb325107b68966fd52198b220
X-Msg-Generator: CA
X-RootMTR: 20200903084555eucas1p2f40375edb325107b68966fd52198b220
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200903084555eucas1p2f40375edb325107b68966fd52198b220
References: <fa403451-5f61-8edf-c696-2d020ec5b920@kernel.org>
        <CGME20200903084555eucas1p2f40375edb325107b68966fd52198b220@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-09-02 =C5=9Bro 10:14>, when Sylwester Nawrocki wrote:
> On 9/1/20 17:21, Lukasz Stelmach wrote:
>> It was <2020-08-25 wto 21:06>, when Sylwester Nawrocki wrote:
>>> On 8/21/20 18:13, =C5=81ukasz Stelmach wrote:
>>>> Check return values in prepare_dma() and s3c64xx_spi_config() and
>>>> propagate errors upwards.
>>>>
>>>> Signed-off-by: =C5=81ukasz Stelmach<l.stelmach@samsung.com>
>>>> ---
>>>>    drivers/spi/spi-s3c64xx.c | 47 ++++++++++++++++++++++++++++++++----=
---
>>>>    1 file changed, 39 insertions(+), 8 deletions(-)
>>>
>>>> @@ -298,12 +299,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_d=
ata *dma,
>>>>      	desc =3D dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>>>    				       dma->direction, DMA_PREP_INTERRUPT);
>>>> +	if (!desc) {
>>>> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
>>>> +			dma->direction =3D=3D DMA_DEV_TO_MEM ? "rx" : "tx");
>>>> +		return -ENOMEM;
>>>> +	}
>>>>      	desc->callback =3D s3c64xx_spi_dmacb;
>>>>    	desc->callback_param =3D dma;
>>>>      	dma->cookie =3D dmaengine_submit(desc);
>>>> +	ret =3D dma_submit_error(dma->cookie);
>>>> +	if (ret) {
>>>> +		dev_err(&sdd->pdev->dev, "DMA submission failed");
>>>> +		return -EIO;
>>>
>>> Just return the error value from dma_submit_error() here?
>>>
>>
>> --8<---------------cut here---------------start------------->8---
>> static inline int dma_submit_error(dma_cookie_t cookie)
>> {
>>          return cookie < 0 ? cookie : 0;
>>
>> }
>> --8<---------------cut here---------------end--------------->8---
>>
>> Not quite meaningful IMHO, is it?
>
> dma_submit_error() returns 0 or an error code, I think it makes sense
> to propagate that error code rather than replacing it with -EIO.

It is not an error code that d_s_e() returns it is a value returned by
dma_cookie_assigned() called from within the tx_submit() operaton of a
DMA driver.

=2D-8<---------------cut here---------------start------------->8---
static inline dma_cookie_t dma_cookie_assign(struct
dma_async_tx_descriptor *tx)
{
        struct dma_chan *chan =3D tx->chan;
        dma_cookie_t cookie;

        cookie =3D chan->cookie + 1;
        if (cookie < DMA_MIN_COOKIE)
                cookie =3D DMA_MIN_COOKIE;
        tx->cookie =3D chan->cookie =3D cookie;

        return cookie;
}
=2D-8<---------------cut here---------------end--------------->8---

Yes, a non-zero value returned by d_s_e() indicates an error but it
definitely isn't one of error codes from errno*.h.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl9QrS8ACgkQsK4enJil
gBB7NAf/SgnNtM0F9I8BB9j1VIqynyc0DEP3ii8YAcJGAkFuhWqZur6ty9hbQiyn
+FBQmVYTN/OsiFPDEeljRPEawDMtzHIgosTdlRp5uE5vexyJymZ4NtDv116MVHbj
807t9hrQmNawIZsQZSLBZz3DVkSk6ZKJ5XvLUvo2qB1tkRgb0B4C2zx97AtRiAYU
m86wslRQuzvo4g2wlCybtS2URQkOXcRko+BFy0wu9uapICUfN6vcA4lIROkM6IQh
j+9MlwI7AkmCNCq/C9UzNQJqK2iuVyNR349wQz4hwa48B7ilPz7/ariNENY+JmCB
SWMwwL2S2vxqvj9eUy/d9uk16ebuug==
=81Cc
-----END PGP SIGNATURE-----
--=-=-=--

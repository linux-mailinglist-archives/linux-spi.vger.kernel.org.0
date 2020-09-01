Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9501259B52
	for <lists+linux-spi@lfdr.de>; Tue,  1 Sep 2020 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgIARAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Sep 2020 13:00:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45565 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgIAPVT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Sep 2020 11:21:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200901152115euoutp013978768f795f6ae087f483281d264ee8~wshX1Wn4x3113231132euoutp01g;
        Tue,  1 Sep 2020 15:21:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200901152115euoutp013978768f795f6ae087f483281d264ee8~wshX1Wn4x3113231132euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598973675;
        bh=Q5RTAvvE+mf9wYOvGwtzpynQxa3cXwKnGkdtlVikqx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7lTFbsa3n8D1RYmfr/jsY1kLnG3TK+duL0k91XXRxCJTx0j4yLxkfgJzsM94CY3a
         nMdNiyPyCUL4/3ddiFvJeGk5pT5gcRmXIUX8LnWWSnLOT5asQBPKPgWf0UrQ6FtdC7
         hUUS+x03l0vBQL3TRd+L8GCUpjJUFATPogtJk4r8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200901152114eucas1p18c5ecd50ee6b1d8dc8dc193120b8c57f~wshXnJ8E40569105691eucas1p1D;
        Tue,  1 Sep 2020 15:21:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 30.60.06456.AE66E4F5; Tue,  1
        Sep 2020 16:21:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200901152113eucas1p2977046b7a5b4c5a519f88870d658698a~wshWyNyiW2291622916eucas1p2N;
        Tue,  1 Sep 2020 15:21:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200901152113eusmtrp2c92bb02c92c39e28f78c646b6cea3164~wshWxWyYM2116721167eusmtrp2O;
        Tue,  1 Sep 2020 15:21:13 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-ca-5f4e66eabc1f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.B2.06314.9E66E4F5; Tue,  1
        Sep 2020 16:21:13 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200901152113eusmtip1ff22840f6dd886ce88667c7c645a5744~wshWneNLw3098830988eusmtip1r;
        Tue,  1 Sep 2020 15:21:13 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 6/9] spi: spi-s3c64xx: Check return values
Date:   Tue, 01 Sep 2020 17:21:01 +0200
In-Reply-To: <e7db038c-b8e6-8ddc-edc7-8b69c2019d04@kernel.org> (Sylwester
        Nawrocki's message of "Tue, 25 Aug 2020 21:06:10 +0200")
Message-ID: <dleftjd035tteq.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUzMcRjf936/e+m49r0r8yxmdosNK8L4GZosnKFlXmZMOfq5mu5q9+uQ
        mfKS0hVJprdxvdF6u5x26obRoqVxCRHyVil3KnWVkuHuvmz993mez+fzfJ7nu6+IkrXxfURR
        mjhWq1FGywVi2vxo3OpnOxgSvqio148pGuvhMTezjXzm8qcuAXOh004xVmu1kDF1tvGZ55Z8
        AZNtvcdjTg62C5nKhg4hk9z9lVozRfGqeIhSmMrOCRS3ihMU52vKkMJhmhXK3y1eFcFGRx1m
        tQsD94kjC87cR7EG6dGslDF+InrvmYo8RICXwuP2JtqFZbgUwYfBwFQkduJhBONvDAJSOBA8
        M5zi/Xe8bDXyCHEDQVvBK4oUPQgyLRZhKhKJBNgfKit3uQze2A8G7ya5NRR+yoNrp19QLsIL
        B0H+8IQ7m8Zz4PlHI3KJPPAZBCVZA3wXIcHLoV//xR09Da+Amt4PQtKXQlNOl9tMYTXkWL+5
        zYD7hDDeYkBk12C4ah+lCPYCW2ONkOCZ8KfuGs+1KeAEuJS5jHjTEJjzx2iiWQnvnv4UEBwE
        jjujNNF7wus+Kcn1hEzzFYq0JZByVkbUvlB14c6/KT6QbitFRKKAt307yFtdRFB9LwVloNm5
        k67JnXRNrtNC4XlgtCwk7QVwvcBOEbwaqqoGaAPil6HprI5Tq1guQMMe8eeUak6nUfkfiFGb
        kPOHNf9uHKpFI6376xEWIflUSXZ4SLiMrzzMxavrka9z0ufq8hbkQ2tiNKzcW7L2SXOYTBKh
        jD/GamPCtbpolqtHM0S0fLpkSeHXvTKsUsaxh1g2ltX+Z3kiD59ElNhlDn6wsc5eisI+d18K
        UvUPN295kWVK89t++lfvd1mLI2P/8TXly6UlRn3e0oY5+t9DhXM3J4eKk39IdUvyRkI0zIQj
        iVvgi7cGNnWqgzekJbQN7Jnf0Z9eZttYURKZMNzafmLd4sadyfr1M2q35WfY7uoWdXuZouJ2
        l99+WLGpSE5zkcqA+ZSWU/4F7+FqDmkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xu7ov0/ziDZ7/MLdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddov2py+ZHbg9ri/5
        xOyxaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7Gw5QBjwQLBiikdP1gbGO/xdTFyckgImEhcvbSeCcQWEljK
        KLHye30XIwdQXEpi5dx0iBJhiT/XutggSp4ySpzpSQApYRPQk1i7NgIkLCKgK/FxbytzFyMX
        B7PAcSaJuQe+go0UFnCUmPPlNwtEr61E48apzCA2i4CqxOUH6xlBGjgFWhgllk55zwqS4BUw
        l3jX/QysWVTAUmLLi/vsEHFBiZMzn4ANYhbIlvi6+jnzBEaBWUhSs5CkZgHdxyygKbF+lz5E
        WFti2cLXzBC2rcS6de9ZFjCyrmIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMvm3Hfm7ewXhp
        Y/AhRgEORiUe3hnxfvFCrIllxZW5hxhVgMY82rD6AqMUS15+XqqSCK/T2dNxQrwpiZVVqUX5
        8UWlOanFhxhNgR6dyCwlmpwPTBh5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtS
        i2D6mDg4pRoY7eT+nmDomu0xUW3fVdujjAvsZ+6bJt8z//28BUzTRPlO6pvGXIqbsfl36q9/
        Xy9u+FhdI5P8/GHtz59xT/X4jVLP87m/VJJ6u3zjoUvp9x99cJl/6UeZTsGDJ8vnHLV1+/JQ
        dkOU+VGPt9JGxxZZn+EKSr9yMfPe6v36E3pPLnXU8kmftbXW5LMSS3FGoqEWc1FxIgBYmSz+
        4AIAAA==
X-CMS-MailID: 20200901152113eucas1p2977046b7a5b4c5a519f88870d658698a
X-Msg-Generator: CA
X-RootMTR: 20200901152113eucas1p2977046b7a5b4c5a519f88870d658698a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200901152113eucas1p2977046b7a5b4c5a519f88870d658698a
References: <e7db038c-b8e6-8ddc-edc7-8b69c2019d04@kernel.org>
        <CGME20200901152113eucas1p2977046b7a5b4c5a519f88870d658698a@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-25 wto 21:06>, when Sylwester Nawrocki wrote:
> On 8/21/20 18:13, =C5=81ukasz Stelmach wrote:
>> Check return values in prepare_dma() and s3c64xx_spi_config() and
>> propagate errors upwards.
>>
>> Signed-off-by: =C5=81ukasz Stelmach<l.stelmach@samsung.com>
>> ---
>>   drivers/spi/spi-s3c64xx.c | 47 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 39 insertions(+), 8 deletions(-)
>
>> @@ -298,12 +299,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_dat=
a *dma,
>>     	desc =3D dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>   				       dma->direction, DMA_PREP_INTERRUPT);
>> +	if (!desc) {
>> +		dev_err(&sdd->pdev->dev, "unable to prepare %s scatterlist",
>> +			dma->direction =3D=3D DMA_DEV_TO_MEM ? "rx" : "tx");
>> +		return -ENOMEM;
>> +	}
>>     	desc->callback =3D s3c64xx_spi_dmacb;
>>   	desc->callback_param =3D dma;
>>     	dma->cookie =3D dmaengine_submit(desc);
>> +	ret =3D dma_submit_error(dma->cookie);
>> +	if (ret) {
>> +		dev_err(&sdd->pdev->dev, "DMA submission failed");
>> +		return -EIO;
>
> Just return the error value from dma_submit_error() here?
>

=2D-8<---------------cut here---------------start------------->8---
static inline int dma_submit_error(dma_cookie_t cookie)
{
        return cookie < 0 ? cookie : 0;

}
=2D-8<---------------cut here---------------end--------------->8---

Not quite meaningful IMHO, is it?

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl9OZt0ACgkQsK4enJil
gBBW8Qf/SHVF+tB9t6usYT5EgtkPO669b1lFpJh8qR35ZKbYw00N79FcmShNENt+
u11jWtkEVXv/6CvV84DdmPiGv8Dv/bmMq+OWSTOCyECEMSVAYmlw2vQ9I7azK7nt
FxJo7uj4E0Y3EX3bkYDOK9WU6nZZwkAzDEXCo8RdMk4vn76NL/ExSloPpIngDDvG
CI/58CKI6KewlcGIaZ5yOvDngFnHFD83iNiNC050kee2x6yETRlgxteR3Be1hR80
DYrnXDQt+lKM5C3eIUpmYpn4MVnEZRfhmNxIJDLW7tzYCgCozOC/3FEI6zCS3etc
NNv/mOvOBaKknxX1chnwkITt5ZiCVQ==
=N7L3
-----END PGP SIGNATURE-----
--=-=-=--

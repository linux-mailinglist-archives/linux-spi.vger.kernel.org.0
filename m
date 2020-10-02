Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1E28106C
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgJBKOL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 06:14:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34396 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJBKOK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 06:14:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201002101409euoutp01393ba34e1d878af5b2872d3d7b36912f~6JVFsfq1T2710527105euoutp01N;
        Fri,  2 Oct 2020 10:14:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201002101409euoutp01393ba34e1d878af5b2872d3d7b36912f~6JVFsfq1T2710527105euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601633649;
        bh=AY9tTAZPMnr1orwwsD8OcEUr6pXr1rzIGl4vDHhnrGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoF3iscH84kCMNtpwQ2uqxBRrXPPxFFREeqR1FDYYIJkJBMupSDeMA9ACwgxelfJI
         oxRQmGGuIXMBXaecTpAWS1Kpw/LyIho3kkO6np77Ux5QO8leLdxovn0Cjv+8zSMJw1
         /b2PfiMFUVFJ7ozbpH14xFowBNYAicF55YZMwczY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201002101408eucas1p253231eae1c950c11f1b0e0529f78e0b9~6JVFZ9_wt0933309333eucas1p2O;
        Fri,  2 Oct 2020 10:14:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.E7.05997.07DF67F5; Fri,  2
        Oct 2020 11:14:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201002101408eucas1p121c21cde5e644992078978d9bf1c5194~6JVE-XTlh1181911819eucas1p1N;
        Fri,  2 Oct 2020 10:14:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201002101408eusmtrp1685ee583f6879bccf9a632dead557249~6JVE_A4B40385803858eusmtrp1h;
        Fri,  2 Oct 2020 10:14:08 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-98-5f76fd7016a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.3C.06314.07DF67F5; Fri,  2
        Oct 2020 11:14:08 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002101408eusmtip2db0f4b695fa2de0ca429d40905d440c6~6JVEzWq7q0801108011eusmtip2w;
        Fri,  2 Oct 2020 10:14:08 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 RESEND 2/9] spi: spi-s3s64xx: Add
 S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
Date:   Fri, 02 Oct 2020 12:13:33 +0200
In-Reply-To: <20201001190423.GB11048@kozik-lap> (Krzysztof Kozlowski's
        message of "Thu, 1 Oct 2020 21:04:23 +0200")
Message-ID: <dleftjtuvddjg2.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2znbOc5mn9PwbUXFsB+WaTfqhDMqKkZQ9KNCBC/LTia5aTvO
        LhBqXkopDaWLy0zLai6va0mObqyLlaaWt7JUUmGpqZmSszTbPAb9e773ubwXPpqQtgtldJQm
        jtVqVNFykZisejlRvzJ2Kj5sVUudL3PTbhMwlVfKhczFL70iJqtngGAaGiooxtTTKmSaLHki
        5krDYwGTNPKRYkqfd1CM0TKJNrsq24p+EMpqfQelNBnTRcp7RQnKTLMRKUdNi/eIgsWKg2x0
        VDyr9d8ULj7805gqiL3mdrz9/q5EZJibgVxowOvgUmspkYHEtBQbEFwYvkE6CSkeQ1BQPo8n
        RhE0WroE/xxN+ldCnriDIO9JCsU/bA5V323Hg6ZF2A9KS4OcBk/sA21T4zMGAtcJ4FFJCeEk
        PHAEdKU2zqSSeBkkvWgXObEL1kFhfzLlxBK8AXK6J2bwfLwRzF+7Zuvu8Dq3d2ZUAqsht+Eb
        cjYAPEhBQWfz7Kjb4M2UneCxB/TXmCkeL4LanHOkc1DACZCTvZ73nkNQlWcneU0AfK7/JeLx
        Fpj+epXg9W7wYdCd7+sG2VWXZ8sSOJsm5dXeUJb1cDZFBuf7DYjHShiqLBDwtzqNID+9FV1A
        S/X/raP/bx29I5Zw3K7c4s+XV8DtwgGCx4FQVjZMFiChEXmxOk4dyXJrNOwxP06l5nSaSL+I
        GLUJOX5Z7Z+asQfIMnnAijCN5HMl+KkuTCpUxXMn1Fbk7UjqrrjbiGSkJkbDyj0lW9/Whkol
        B1UnTrLamDCtLprlrGghTcq9JGtv9IVIcaQqjj3CsrGs9h8roF1kiYjq8rD6ZJhtg9bkQ/mK
        3ouZxuIR5ft3Czj7wJ1TO3MuPZM91uw+c2u/15ea6fr80CDs07aybgkV0DoUbjKk11rzQq7F
        e/QaZeUKY8U+m++Oat8UQ7Z/QqGr4uj1F4Nt6Sm7Fea0ObGducGB1W7jzeKWiO8HFgcUp3z6
        7bc9NDt5r5zkDqtWLye0nOov9uBJ7G0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xe7oFf8viDf69FbRY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddotVu/4wOnB7XF/y
        idlj56y77B6bVnWyeWxeUu/Rt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
        lnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gd9WtTIVzOWruLXVt4FxBU8XIyeHhICJxOVZJ1i7
        GLk4hASWMko0P7/G2MXIAZSQklg5Nx2iRljiz7UuNoiap4wS3Q0N7CA1bAJ6EmvXRoDUiAho
        Slz/+x1sDrPAUSaJmecXMIMkhAUSJR6fewZmCwHVXz+0khHEZhFQlWg8eosNxOYUKJU48wJk
        JicHr4C5xORHP8FsUQFLiS0v7kPFBSVOznzCAmIzC2RLfF39nHkCo8AsJKlZSFKzgM5jBrpp
        /S59iLC2xLKFr5khbFuJdevesyxgZF3FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGIfbjv3c
        vIPx0sbgQ4wCHIxKPLwCB0rjhVgTy4orcw8xqgCNebRh9QVGKZa8/LxUJRFep7On44R4UxIr
        q1KL8uOLSnNSiw8xmgL9OZFZSjQ5H5g68kriDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRm
        p6YWpBbB9DFxcEo1MOpWC8qUuPsfPrksyPtv0BWhMzfZtewZ4pZf/PqAadMtC68Ju3y/sEsf
        MuJWPHNmsYJWzd6y7Onb9H+wZvzjv+SglNwXL8X4LKernWXPbJFCp9KcghO9XHNnp0zVf/R9
        ht4X2Z/eP6ZGiScsPP9z+fSYBYuM5lqXyzSyb5lbeqL7fb1bOpvEViWW4oxEQy3mouJEAA29
        qXvlAgAA
X-CMS-MailID: 20201002101408eucas1p121c21cde5e644992078978d9bf1c5194
X-Msg-Generator: CA
X-RootMTR: 20201002101408eucas1p121c21cde5e644992078978d9bf1c5194
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002101408eucas1p121c21cde5e644992078978d9bf1c5194
References: <20201001190423.GB11048@kozik-lap>
        <CGME20201002101408eucas1p121c21cde5e644992078978d9bf1c5194@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-10-01 czw 21:04>, when Krzysztof Kozlowski wrote:
> On Thu, Oct 01, 2020 at 05:21:41PM +0200, =C5=81ukasz Stelmach wrote:
>> Fix issues with DMA transfers bigger than 512 bytes on Exynos3250. Witho=
ut
>> the patches such transfers fail.
>>=20
>> The vendor kernel for ARTIK5 handles CS in a simmilar way.
>>=20
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 26c7cb79cd78..22bf8c75580a 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -1379,6 +1379,7 @@ static struct s3c64xx_spi_port_config exynos4_spi_=
port_config =3D {
>>  	.tx_st_done	=3D 25,
>>  	.high_speed	=3D true,
>>  	.clk_from_cmu	=3D true,
>> +	.quirks		=3D  S3C64XX_SPI_QUIRK_CS_AUTO,
>
> I spotted now: you have here double space after '=3D'.
>

Fixed, thanks. v3 is coming.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl92/U0ACgkQsK4enJil
gBAXYQgAiKZvbYQTmXEUG2W2V5cm013KBr9XPvBL2DWhSyiiaclHIG5Go0fRBJoC
ixMM2+RZ6rncy8L9JrHwbP/46OqKMsQ3YKYF5w6wDi5uY9fR7uTYZqEWlmthld2V
aFTsSl9+mlX0I+6SKQg1G9viKJa2FDIXm+B5CHHS6V3Kn/agXJtwTWkNdOBFgq/w
K5Xm4l/47pzKrqH+YnIo9CDfy6WQxEDv1IuD+XH/UqR9rSuWfm3JFJyj+fwpubej
/9+RpORlzvZGS4p5nvHYgN777PZ2GP7axm9yFNeE7gp4i0dicAPiNfPIRKIS34E2
gvN6t5w4mScuGITbmAVGXW5Q/7FQpA==
=PA0w
-----END PGP SIGNATURE-----
--=-=-=--

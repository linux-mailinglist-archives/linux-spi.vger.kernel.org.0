Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F4C24B741
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 12:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgHTKr5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 06:47:57 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55312 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731423AbgHTKrj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 06:47:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200820104737euoutp024167e954dbac73b66a38f16b8f9bcaf2~s9DCwhMMZ0602806028euoutp02n;
        Thu, 20 Aug 2020 10:47:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200820104737euoutp024167e954dbac73b66a38f16b8f9bcaf2~s9DCwhMMZ0602806028euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597920457;
        bh=7WJ9ipRlkuaJUk4o4grQFz2PxaIdJoQh60sHhV0DFT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jz6FCIM9l9v5yrnVaHYzsAfNR1PLrwbB56fpFAovrgwit935SydBZbUeiM/N1lO/L
         PbIiKFEX7fqvxux7t/lW7K3C0I2hDGFu2u1eegyHH8kMQx+Tnlr9Q5xPa3h3bPsjq7
         rolhTjQvkY+0mv9oiHJQkaNoohdSBmr/mY60/s4k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200820104737eucas1p112881b83eab752b80042953a38074886~s9DCbEQ3b0275402754eucas1p11;
        Thu, 20 Aug 2020 10:47:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 32.CD.06318.9C45E3F5; Thu, 20
        Aug 2020 11:47:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200820104737eucas1p140e3c575eb692a1de54c5a702951ebfe~s9DCGoE9e1948319483eucas1p1B;
        Thu, 20 Aug 2020 10:47:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200820104737eusmtrp1b8657180ba1a19d55ba927dcfeb41838~s9DCGAWmc2448524485eusmtrp1y;
        Thu, 20 Aug 2020 10:47:37 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-a8-5f3e54c98637
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B8.77.06017.8C45E3F5; Thu, 20
        Aug 2020 11:47:36 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200820104736eusmtip1ebfd77e5ae922d9acda4cc440279da19~s9DB51x7W2890228902eusmtip1R;
        Thu, 20 Aug 2020 10:47:36 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/8] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Date:   Thu, 20 Aug 2020 12:47:26 +0200
In-Reply-To: <20200819193816.GB38371@sirena.org.uk> (Mark Brown's message of
        "Wed, 19 Aug 2020 20:38:16 +0100")
Message-ID: <dleftjd03lzj9d.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7onQ+ziDf6uErdY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddgcuj+tLPjF7bFrV
        yeaxeUm9R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGX8nn+OqWCBWMWaV8+ZGhjPCnUxcnJI
        CJhIHFm5lq2LkYtDSGAFo8Sk9bNYIZwvjBLbN3UzQTifGSXm/jkL5HCAtSzuK4aIL2eUaN10
        kglklJDAc0aJR9PlQWrYBPQk1q6NAAmLCChLXP2+lwWknllgDZPE7IdrGUESwgKREreXT2AB
        sVkEVCXOrtjPDmJzChRKzD51FszmFTCXWHliH1iNqIClxJYX96HighInZz4BizML5ErMPP+G
        EWSBhMAtdol1fz6zQvzmInF11QsoW1ji1fEt7BC2jMTpyT0sEM/US0yeZAbR28MosW3ODxaI
        GmuJO+d+sUHYjhK/Dz5ig6jnk7jxVhBiL5/EpG3TmSHCvBIdbdAQVZFY178HaoqURO+rFYwQ
        JR4S7XOgwdbGKLF172S2CYwKs5B8MwvJN7OAWpgFNCXW79KHCGtLLFv4mhnCtpVYt+49ywJG
        1lWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBSev0v+NfdzDu+5N0iFGAg1GJhzdAyTZe
        iDWxrLgy9xCjCtCkRxtWX2CUYsnLz0tVEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv
        8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbGzQ7/WEpX7pBq23hX9GyCUTJ3zLEzpocv3509q/nX
        6Xn/ni/6LWFY9G6qI5/nv04H78gztucctlqxz7ike8B3uTjfSqFp2RvdY/cEVHy59KIu68Ci
        H4v0qlyDpHKuGBc59rpapB0ItfSdJVP28dQtgy2/s4olTlWuPZvjverHc0WtuVt87N7+VWIp
        zkg01GIuKk4EANNLIrViAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7onQuziDXYesLZY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddgcuj+tLPjF7bFrV
        yeaxeUm9R9+WVYwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GX8nn+OqWCBWMWaV8+ZGhjPCnUxcnBICJhILO4r7mLk4hASWMoocbHj
        BxNEXEpi5dz0LkZOIFNY4s+1LjaImqeMEiuXrmIBqWET0JNYuzYCpEZEQFni6ve9LCA2s8BS
        Jon3d11BbGGBcInfh1eBxYUEjCR+NvWwgtgsAqoSZ1fsZwexOQUKJWafOgtm8wqYS6w8sQ+s
        XlTAUmLLi/tQcUGJkzOfQM3Plvi6+jnzBEaBWUhSs5CkZgFdxyygKbF+lz5EWFti2cLXzBC2
        rcS6de9ZFjCyrmIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMuG3Hfm7Zwdj1LvgQowAHoxIP
        b4CSbbwQa2JZcWXuIUYVoDGPNqy+wCjFkpefl6okwut09nScEG9KYmVValF+fFFpTmrxIUZT
        oD8nMkuJJucDk0ReSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZG
        t7ZFNTKPbP1eCFqLCMtH8/Ql5srMLpohwZQ0361OeM3ZSaX9vCZ7g6UfemT5Xt6+7FTSMVWp
        h+c+f2pnN36eZeztdXt7Y9X86wcO9qw5p2FaXvmo5mnbe5OZhuUTZG4JGTfvCnFM13C+zmS0
        PixOQk5iyxb/T/omCwt4p+uGRxUKH3IquqLEUpyRaKjFXFScCAAKbWWM2gIAAA==
X-CMS-MailID: 20200820104737eucas1p140e3c575eb692a1de54c5a702951ebfe
X-Msg-Generator: CA
X-RootMTR: 20200820104737eucas1p140e3c575eb692a1de54c5a702951ebfe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200820104737eucas1p140e3c575eb692a1de54c5a702951ebfe
References: <20200819193816.GB38371@sirena.org.uk>
        <CGME20200820104737eucas1p140e3c575eb692a1de54c5a702951ebfe@eucas1p1.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 20:38>, when Mark Brown wrote:
> On Wed, Aug 19, 2020 at 03:01:21PM +0200, Lukasz Stelmach wrote:
>> It was <2020-08-19 =C5=9Bro 14:39>, when Krzysztof Kozlowski wrote:
>
>>> There is here no commit msg, no explanation.
>
>> As I wrote in the cover letter, this and previous commits make things
>> work on Exynos3250 (ARTIK5 precisely). I can't explain why. I read
>> everything I could about this HW and there were no details about
>> automatic CS handling other than how to turn it on and off.
>
> What is similar about those other SoCs - could you be more specific
> here, or what goes wrong if you don't set this?

Without the quirk set DMA transfers longer than 512 bytes fail. They
simply stop and hit the timeout with a few (<20) bytes pending.

As far as I can tell the SPI controller is the same in different Exynos
SoCs.

> The auto mode (or at least the auto mode that was on the Exynos7) is
> not compatible with many SPI devices if the controller chip select is
> actually in use, the quirk was added for controllers that just don't
> have the manual mode.

According to the manual the auto mode makes the controller toggle CS
between SPI packets (bytes?).

I=C2=A0didn't have any problem transferring data (>512 bytes) from the SPI
device in the polling mode. Only the DMA caused problems.
> See also:
>
>   https://lore.kernel.org/linux-spi/CAAgF-BfGwcNzMx0meFVkJqNMTbQ4_PP1PZ3i=
6edOm6U3bc26_Q@mail.gmail.com/
>
> for an explanation of the quirk.
>

>> CS can also be controlled automatically by setting AUTO_N_MANUAL to 1
>> in CS_CFG. When it is auto CS automatically toggles between packet to
>> packet. NCS_TIME_COUNT in CS_CFG controls the inactive period. The
>> driver by default uses manual mode. But on exynos7 the manual mode is
>> removed.

I *suspect* that the automatic CS toggling between packets gives better
(?) synchronisation between the SPI device and the controller's
internals and prevents some kind of a deadlock inside the
controller. These are just speculations.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl8+VL4ACgkQsK4enJil
gBCobwf+LjO7fiQ+cGZHf8IsqYN/VyXQSsG+kaaGX4m/CYUMGTVs1GZpTWJnAZvM
vCJgkQvHZZN5gWgkKmeH9Bkj91Frzv2zXlW304h2Vg9V5suiF58Xuqi3ynnecAhk
QsYFb1c7X2LCvFhgpCAu0y39iODVafDIFAomUc+7HDRAFHy5rN8od+3HTzd/U46x
s0AnNvJUt/diwApiv9aCpyJphgfMu2I+NXJdfMaFvs5Npp1rtlWGq+U5Z11Yc2VD
UW657sr6135wlHEQPbcCOr7rB5D2Utwq8eM2zciOA5iIumidEpkR5g2GtWDgZM5V
RZIWmtKeVCI4bKveBkkPEvxqpEhJdw==
=aDU8
-----END PGP SIGNATURE-----
--=-=-=--

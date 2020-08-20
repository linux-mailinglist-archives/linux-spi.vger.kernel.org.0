Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FF24B7DC
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgHTLFC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 07:05:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42628 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731097AbgHTKMz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 06:12:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200820101252euoutp020cf5a73ddbb1153ee0f9bb4b580e6736~s8ksYweFh1616116161euoutp02l;
        Thu, 20 Aug 2020 10:12:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200820101252euoutp020cf5a73ddbb1153ee0f9bb4b580e6736~s8ksYweFh1616116161euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597918372;
        bh=Eca9rhf9QUv2Wht7tEgouWJ5QtgOlNZgYftYPW/BMps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBhq4gquN+cSmsUrAfubyFcN1m1/UszRxUyTEwCkCFPFhSn80lMpJokAzebv7CMrd
         14X4KpF7m9tU6K5PMQZ7cWYKQcHw8bgF09IEDM9eZh6qX9PrlxeFENuDqnXUqsFPE3
         Ecxc+c9U/uwjNc4fAmKng33FXsxt5jsG4wtZEUq4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200820101251eucas1p1fa32323daa091eab92f59f36b54b3af2~s8kr8mKWy2913229132eucas1p1U;
        Thu, 20 Aug 2020 10:12:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.53.05997.3AC4E3F5; Thu, 20
        Aug 2020 11:12:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200820101251eucas1p237a794cc11f44c709c0ccdfef766702c~s8krpBSbM0965809658eucas1p2L;
        Thu, 20 Aug 2020 10:12:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200820101251eusmtrp11c30144971bf8177c7a1ac34d73fe7af~s8kroUCtj0130701307eusmtrp1u;
        Thu, 20 Aug 2020 10:12:51 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-9c-5f3e4ca35d51
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9B.E2.06017.3AC4E3F5; Thu, 20
        Aug 2020 11:12:51 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200820101251eusmtip1654a532dfde40f6aee5232a6cc38cac7~s8krdzWLi0662106621eusmtip1f;
        Thu, 20 Aug 2020 10:12:51 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Date:   Thu, 20 Aug 2020 12:12:40 +0200
In-Reply-To: <20200819191227.GG5441@sirena.org.uk> (Mark Brown's message of
        "Wed, 19 Aug 2020 20:12:27 +0100")
Message-ID: <dleftjh7sxzkvb.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7Oxstvk3Dt1US64IZqd3sdFEqKhZkLPqRGKVLD2u1TdlR
        y4hMTFHTLkoXrfAyazLdpmuYSBmslpXkxC5qWeKFzJlEN7KIynkW9O/5ntv7vvDRhLxLqKB1
        xnTWZNTolZSEbH74w7vcvDM2McpuXsKYJ0cFTNMVh5C5ODhCMeeGxwnG620UMc7hl0LmWes1
        irnibRMwOZ/6RIztwRvRJomqp/YzoXJaCynVrdps1VmXFam+OEPVwgTJxhRWr8tkTZGxSZJD
        eZUuMq1l/rGfz+zkKeSAIiSmAa+G5wVniCIkoeW4DoH5XaOIf3xF0Jb3hOQfXxB86LNT/yJn
        WjopXrAgyL/YHsiPIsgdqJxSaJrCEWCzxfsDwXghvPh+d7qJwA0CuDpoQ34hCKfAeGuxwO8n
        8WL4nKP302KcBr7CbpEfS/FaGOl5TPrxbLwOXO8HArwMHpePTPMENkC59wPy9wN+JYKRqmLE
        b7oV3BMWAY+DwNfuEvF4HnSUFZP+uYCzoaw0ms8WI2i+Nknyng3Q3/kzcPFmGH59neL9s6B3
        QsbPnQWlzZcJnpZCQb6cdy8C+7k7gRYFlPjqAtuooM9VP72BHOchyPOEnEcLKv67puK/ayqm
        Wgm8FBytkTy9DG5WjxM8jgG7/SNZhYRWFMJmcAYty600skcjOI2ByzBqI5JTDU409bc6frd/
        bUGtvw66EaaRcqZUrYxJlAs1mVyWwY0WTTUNNdZ3IQVpTDWyymDplqcdB+TSFE3WcdaUmmjK
        0LOcG82lSWWIdFXN2H451mrS2SMsm8aa/qkCWqw4hbTlKy/Jer9te7Xvfu+N/nvdkYdPR+kn
        ky2lesXCHdEycXXDmO/RwJyhBsWQ7uia7XdPdr3dlkzV3RbYdm/KVq9/oDrRs1e1XFfaPWNy
        oibLFR7mibfkcmVhzY6m+793VcXJfJQ4ocAcVPXngmeMtdalNqnjToTtCXWVzJ0Zk+RRK0nu
        kGZFOGHiNH8BM+uEfGMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7qLfeziDXbeFLJY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZNH68yW6x9shddgcuj+tLPjF7bFrV
        yeaxeUm9R9+WVYwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GW0zt/CUrBDtuLX5XUsDYzrJboYOTkkBEwkunecY+ti5OIQEljKKNG4
        YgaQwwGUkJJYOTcdokZY4s+1Lqiap4wSHdPPsYLUsAnoSaxdGwFSIyKgLHH1+14WEJtZYCmT
        xPu7riC2sECSxKUDl1hAyoUEDCVW/dADMVkEVCU+NeaAVHAKFEi86rzEDmLzCphLPLl+EmyK
        qIClxJYX96HighInZz6Bmp4t8XX1c+YJjAKzkKRmIUnNAtrALKApsX6XPkRYW2LZwtfMELat
        xLp171kWMLKuYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIy3bcd+btnB2PUu+BCjAAejEg9v
        gJJtvBBrYllxZe4hRhWgMY82rL7AKMWSl5+XqiTC63T2dJwQb0piZVVqUX58UWlOavEhRlOg
        NycyS4km5wNTRF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkbh
        R+uP/Zz5Odsyad7k7IMxX2YITmmanbvO99MaWVkNztBVB3s0L6daN6wsZyhuPG9ctNvbZIPN
        GpWq/8Xb+e8YGHNvYT/re8lnRySnYH2NW/+NB2WXrDInbAue22k5U3jnjDN6n6YZ6nPWzRe4
        kHdy+gxnKffdx3xurL57aEsXX7PS+7VN782UWIozEg21mIuKEwGT+LDR2QIAAA==
X-CMS-MailID: 20200820101251eucas1p237a794cc11f44c709c0ccdfef766702c
X-Msg-Generator: CA
X-RootMTR: 20200820101251eucas1p237a794cc11f44c709c0ccdfef766702c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200820101251eucas1p237a794cc11f44c709c0ccdfef766702c
References: <20200819191227.GG5441@sirena.org.uk>
        <CGME20200820101251eucas1p237a794cc11f44c709c0ccdfef766702c@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 20:12>, when Mark Brown wrote:
> On Wed, Aug 19, 2020 at 04:01:52PM +0200, Lukasz Stelmach wrote:
>> It was <2020-08-19 =C5=9Bro 14:16>, when Mark Brown wrote:
>>> On Wed, Aug 19, 2020 at 02:58:22PM +0200, Krzysztof Kozlowski wrote:
>>>> On Wed, Aug 19, 2020 at 02:51:27PM +0200, Lukasz Stelmach wrote:
>>>>
>>>>>     0732a9d2a155 spi/s3c64xx: Use core message handling
>>>>
>>>> Then describe at least this... maybe Mark knows why he brough back old
>>>> code after refactoring?
>>>>
>>> I'm not sure what's being referred to as being lost in the second commit
>>> TBH.
>
>> Order of enable_cs() and enable_datapath(). The order 0f5a sets makes
>> (for a reaseon I don't know) my devices work. In the latter commit,
>> which rewrites "everything", enable_datapath() is called before what
>> later (in aa4964c4eb3e) became s3c64xx_spi_set_cs().
>
> That's doesn't look like what the changes do.  Note that the enable_cs()
> function that got moved in 0f5a751ace250097 (spi/s3c64xx: Enable GPIO
> /CS prior to starting hardware) does not touch the chip registers at
> all, it only manipulates GPIOs, code that was subsequently factored out
> into the core.

Indeed, you are 100% right. Anyway that commit has inspired me after
days of trying different stuff to switch enable_datapath() and set_cs()
and it worked. Even if without any technical connection with your commit.

> The write to the _SLAVE_SEL register has so far as I can see always
> been after enable_datapath() right back to the initial commit, it just
> got made more complex for the Exynos7 controller (I'm guessing your
> new one might be an ancestor of that?) in bf77cba95f8c06 (spi:
> s3c64xx: add support for exynos7 SPI controller) and then factored out
> in the commit you mention above.
>
> Are you sure your new ordering works for all controller revisions?

Not 100%, but we've tested it on several differnt SoCs, and haven't seen
any problems.

> According to the comment the _set_cs() is what's actually kicking off
> the transfer

I don't think so. Indeed, without the CS_AUTO quirk CS is pulled down
(the SPI device is selected) but for the transfer to start the SPI clock
needs to start ticking.

> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.

I will.

>>> I don't know that I ever actually used a system that used the native
>>> chip select as the actual chip select.  Perhaps some quirk was
>>> introduced where the chip select signal does something?
>>>
>>> The commit is also lacking a description of what the issues that are
>>> being fixed are.
>>
>> On Exynos3250 DMA transfers from SPI longer than 512 fail.
>
> Could you expand on "fail" please?

Stopping a transfer and hitting timeout with a few bytes (<20) left
pending in the SPI controller.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl8+TJgACgkQsK4enJil
gBCfDgf+Nsy7Obq4x9IRVYhgZCzbEpbVDv10JUhPSq/wNVnSvTj4QcAKQXE2MTcV
1fg5actyzuu912NigSdtrYgMexq/xIEDZVZ0Fv9uKbHeA/K9Q4ytJJD81rfy8B5W
pC8shdxshfzqxoUdTO4wqW7WmQy/IFQwXaT6L0xDNTKpUWTHcFi7Oa78T740WwGx
tLf69SfFsEiKDFTPV3MrBawaV8t5FuuyluYWHDlSjHlXquqwrnpwrxSrTyjdq0LI
xYIxtRsxITOk768GhZX8w/TPVRuij5FuYUD9z5iuPjb5CmVtcZzBoIR2hHHHNYVj
Yi5y+2wy5FHgLamD3J0A2P9bq1L5lQ==
=kEPr
-----END PGP SIGNATURE-----
--=-=-=--

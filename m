Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6B424A101
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHSOCR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 10:02:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42411 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSOCG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 10:02:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200819140204euoutp028baea15cb77b1dc6def845f97a00055d~ssDiAIKDh0917409174euoutp02F;
        Wed, 19 Aug 2020 14:02:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200819140204euoutp028baea15cb77b1dc6def845f97a00055d~ssDiAIKDh0917409174euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597845724;
        bh=G0KaFBK2CZOU69zOLC6mp4OXLhcPCTgcVzd+ZtgbOV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjJ8VjOA7GgPeoDJDyJxwIJdKROX7S/2VKhAgICUY43w1mp80dLR0wcMnqsmv+P46
         i5cnP7v7qPkotbBpNUbAGO/otIRiIR4WI/aeYgIfqc+dgOJbC+IXJrjOxJbGPVXON+
         W33kmeultdlrvuEr1dSUpdaUD5jd43c8w5PyVoGc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200819140204eucas1p1bf05e0c76107014d05c384237c65c654~ssDhuGFOF3126731267eucas1p1q;
        Wed, 19 Aug 2020 14:02:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 27.0A.06456.CD03D3F5; Wed, 19
        Aug 2020 15:02:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200819140203eucas1p2818858289f2394b32f3c647e47705cd2~ssDhUV4h00344603446eucas1p2E;
        Wed, 19 Aug 2020 14:02:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200819140203eusmtrp2a760cde922a7e1fcb7bf52db161217e1~ssDhTmUHu1908919089eusmtrp2X;
        Wed, 19 Aug 2020 14:02:03 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-4c-5f3d30dc2339
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D7.71.06017.BD03D3F5; Wed, 19
        Aug 2020 15:02:03 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200819140203eusmtip27e08d854e0e7ea177b3ee2ff5a345014~ssDhK20we2707227072eusmtip27;
        Wed, 19 Aug 2020 14:02:03 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/8] spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
 s3c64xx_enable_datapath()
Date:   Wed, 19 Aug 2020 16:01:52 +0200
In-Reply-To: <20200819131635.GD5441@sirena.org.uk> (Mark Brown's message of
        "Wed, 19 Aug 2020 14:16:35 +0100")
Message-ID: <dleftj4koy20q7.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTURzlvo/tuZpdp+EPk7BpgUWaZvmsDAuV9UHYH1EEtVZ7TMlN2VP7
        gMigxMxlauXXxI/EZDm1pVaiQipaWc5KK8soU1jOPigTl2XmfAr9d+4553fu+V0uQ8qe0V5M
        nC6J0+tU8XKRhGrs/NWzdnBduHKdOc+FveGwEezt/FqavTY0ImKzhsdI1mqtE7OW4Zc0+6LJ
        KGLzra0Ee+77gJg1d7wTR0gUryp+kAqL6aJIcafirOJyvQkpxi3LY+iDki1qLj4uhdMHbj0i
        iS1Kf4ASv7qfrMkZJlJRF85ALgzgEGjsb6EzkISR4SoEd6sNSDj8RGDPtc8fxhHkXrKIFkYy
        yx8SgnATQcXUZ9IpyLANgaOWzUAMI8IBYDYfcNIe2Bf6J1sop5/E1QQUDZmRU3DHahhryiSc
        mMIr4XfD9bkcF5wIpbbWOSzFoZD6vngOL8VhUP/pvVjg3eBRwQjlxCTWQoH181xTwG/E0D1Y
        TgtNI6H9avN8a3ewd9WLBewNM/dLCGdRwGchN2ejMJuJoNHooATPZhjsmZqf3QaOsQlK8LvC
        6y9uwr2ukNOYRwq0FNLTZILbD2qymudTvMBgr0ICVkBR5y1SeLcLCEbSXtJXkE/hf+sU/rdO
        4Wwsif2htilQoNdAZdkYKeBwqKn5RpUi2oQ8uWReq+H4IB13IoBXaflknSbgWILWgmY/V/ff
        rh/30MTzo20IM0i+WBojD1fKaFUKf0rbhvxmkz7W3epFXpQuQcfJPaTbn3YflknVqlOnOX2C
        Up8cz/FtaBlDyT2l68tHD8mwRpXEHee4RE6/oBKMi1cqWu6I31QV0cuNtoeUvTOu/tLX2bRz
        z9dQzfnbFQ0mkzLbc0Xn6aG3XWqtzche2D/eCwMNGUv3Pota6xZX/sDecWY68ciaEH/N3ukA
        nH3Pu98neNdMc1CfYdL6ZGL9wJ9Cw4eSqMW+kTt2b6iTxlTui/adLH48GR22KlhlWPSwZ0k/
        llN8rCpoNannVf8A0tOAvGQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7q3DWzjDXon6Vks/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsGj/eZLdYe+QuuwOXx/Uln5g9Nq3q
        ZPPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DJmdxxkLHgnXLFu0mOmBsbjAl2MnBwSAiYSPYtOMHUxcnEICSxllJg1
        4zmQwwGUkJJYOTcdokZY4s+1LjaImqeMEkvbzrKD1LAJ6EmsXRsBUiMioCxx9fteFhCbWWAp
        k8T7u64gtrBAksSlA5fA4kIChhJ35l9nBrFZBFQlfm+dBmZzChRILHi+D8zmFTCXaLg/F8wW
        FbCU2PLiPjtEXFDi5MwnUPOzJb6ufs48gVFgFpLULCSpWUDXMQtoSqzfpQ8R1pZYtvA1M4Rt
        K7Fu3XuWBYysqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjbtuxn1t2MHa9Cz7EKMDBqMTD
        G6BkGy/EmlhWXJl7iFEFaMyjDasvMEqx5OXnpSqJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU
        6M+JzFKiyfnANJFXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHR
        +7/wN+FloaraCtOyjuy4sXiffrzvRrGT/YeKGaLCbnM4d52ZcXVSlIO9fOMjk8aj0Z6HPxw/
        vWDHt3UL3feGfFI8tm1vtKj0vMqQlZG/tG9+WzSrovhc5ixG1pDCsLTsNUo72XNfdLsvfVZQ
        /1aHK+eS64UTHyfw8O5UOaphY+Jxz2RpqMYOJZbijERDLeai4kQARSYUcNsCAAA=
X-CMS-MailID: 20200819140203eucas1p2818858289f2394b32f3c647e47705cd2
X-Msg-Generator: CA
X-RootMTR: 20200819140203eucas1p2818858289f2394b32f3c647e47705cd2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200819140203eucas1p2818858289f2394b32f3c647e47705cd2
References: <20200819131635.GD5441@sirena.org.uk>
        <CGME20200819140203eucas1p2818858289f2394b32f3c647e47705cd2@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-08-19 =C5=9Bro 14:16>, when Mark Brown wrote:
> On Wed, Aug 19, 2020 at 02:58:22PM +0200, Krzysztof Kozlowski wrote:
>> On Wed, Aug 19, 2020 at 02:51:27PM +0200, Lukasz Stelmach wrote:
>
>> > Honestly, I don't know and I couldn't find out why. It makes stuff
>> > work. There has been a commit like this before
>
>> >     0f5a751ace25 spi/s3c64xx: Enable GPIO /CS prior to starting hardwa=
re
>
>> > Apparently, it was lost in
>
>> >     0732a9d2a155 spi/s3c64xx: Use core message handling
>
>> Then describe at least this... maybe Mark knows why he brough back old
>> code after refactoring?
>
> I'm not sure what's being referred to as being lost in the second commit
> TBH.

Order of enable_cs() and enable_datapath(). The order 0f5a sets makes
(for a reaseon I don't know) my devices work. In the latter commit,
which rewrites "everything", enable_datapath() is called before what
later (in aa4964c4eb3e) became s3c64xx_spi_set_cs().

> The first commit is simple code motion rather than a correctness
> thing, and more related to the handling of GPIO controlled chip
> selects according to the description (which people should be using
> with that controller anyway where possible IIRC, the native chip
> select has too many assumptions about what it's doing).

Funny, but without the automatic CS control (see the next patch in this
series) my stuff does not work.

> I don't know that I ever actually used a system that used the native
> chip select as the actual chip select.  Perhaps some quirk was
> introduced where the chip select signal does something?
>
> The commit is also lacking a description of what the issues that are
> being fixed are.

On Exynos3250 DMA transfers from SPI longer than 512 fail.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl89MNAACgkQsK4enJil
gBBcTwf8DWZyT4x0kvjwQlAAh0rUJ1GbGposDAteYzB8RPbEbM2FM4VIu1KDKnLY
iJbyrxEKE+R2dTx1ckWHqDnQdXNXoYiKdWfo4v0FqSwdyNdHN4kqNTaVtfMMmGwA
HEIJBdTImd20d8CZV0Qmb41+s3Po8YvEKIFpFALqcXvBSN8fi8PJRX8hYzbr0kck
2KKMARpA/n+uYjINC2wABjCybdwURL/a0bSdYRDNC3TJDZQyJKzHFjQNRcF28VYS
3UCnsVgJdJGjzvRh0wdFqkU+2GsU5/2phTX9wkgh8o6x5jSgCKj1ivvcK2TL1yj3
8ldjR9PmxxV5GaBOPlgTZTUJPiJ/GA==
=KAWn
-----END PGP SIGNATURE-----
--=-=-=--

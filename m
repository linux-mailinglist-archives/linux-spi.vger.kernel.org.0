Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E379BEF5C
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 12:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfIZKPh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 06:15:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50565 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfIZKPh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 06:15:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iDQoA-0007KT-Sd; Thu, 26 Sep 2019 10:15:34 +0000
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver is
 released
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <abeb7029-0b24-64f0-0d1c-63f12ba8fffe@canonical.com>
Date:   Thu, 26 Sep 2019 11:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926121438.655f1f10@jawa>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ
Content-Type: multipart/mixed; boundary="pMI8gq1huC3pfVevEOlp2gM57uALqDbuT";
 protected-headers="v1"
From: Colin Ian King <colin.king@canonical.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <abeb7029-0b24-64f0-0d1c-63f12ba8fffe@canonical.com>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver is
 released
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa>
In-Reply-To: <20190926121438.655f1f10@jawa>

--pMI8gq1huC3pfVevEOlp2gM57uALqDbuT
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26/09/2019 11:14, Lukasz Majewski wrote:
> Hi Colin,
>=20
>> Hi,
>>
>> Static analysis with Coverity has detected an potential dereference
>> of a free'd object with commit:
>>
>> commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
>> Author: Lukasz Majewski <lukma@denx.de>
>> Date:   Wed Sep 25 11:11:42 2019 +0200
>>
>>     spi: Add call to spi_slave_abort() function when spidev driver is
>> released
>>
>> In spidev_release() in drivers/spi/spidev.c the analysis is as
>> follows:
>>
>> 600static int spidev_release(struct inode *inode, struct file *filp)
>> 601{
>> 602        struct spidev_data      *spidev;
>> 603
>> 604        mutex_lock(&device_list_lock);
>>
>>    1. alias: Assigning: spidev =3D filp->private_data. Now both point =
to
>> the same storage.
>>
>> 605        spidev =3D filp->private_data;
>> 606        filp->private_data =3D NULL;
>> 607
>> 608        /* last close? */
>> 609        spidev->users--;
>>
>>    2. Condition !spidev->users, taking true branch.
>>
>> 610        if (!spidev->users) {
>> 611                int             dofree;
>> 612
>> 613                kfree(spidev->tx_buffer);
>> 614                spidev->tx_buffer =3D NULL;
>> 615
>> 616                kfree(spidev->rx_buffer);
>> 617                spidev->rx_buffer =3D NULL;
>> 618
>> 619                spin_lock_irq(&spidev->spi_lock);
>>
>>    3. Condition spidev->spi, taking false branch.
>>
>> 620                if (spidev->spi)
>> 621                        spidev->speed_hz =3D
>> spidev->spi->max_speed_hz; 622
>> 623                /* ... after we unbound from the underlying
>> device? */
>>
>>    4. Condition spidev->spi =3D=3D NULL, taking true branch.
>>
>> 624                dofree =3D (spidev->spi =3D=3D NULL);
>> 625                spin_unlock_irq(&spidev->spi_lock);
>> 626
>>
>>    5. Condition dofree, taking true branch.
>>
>> 627                if (dofree)
>>
>>    6. freed_arg: kfree frees spidev.
>>
>> 628                        kfree(spidev);
>> 629        }
>> 630#ifdef CONFIG_SPI_SLAVE
>>
>>    CID 89726 (#1 of 1): Read from pointer after free (USE_AFTER_FREE)
>> 7. deref_after_free: Dereferencing freed pointer spidev.
>>
>> 631        spi_slave_abort(spidev->spi);
>> 632#endif
>> 633        mutex_unlock(&device_list_lock);
>> 634
>> 635        return 0;
>> 636}
>>
>> The call to spi_slave_abort() on spidev is reading an earlier kfree'd
>> spidev.
>=20
> Thanks for spotting this issue - indeed there is a possibility to use
> spidev after being kfree'd.=20
>=20
> However, Geert (CC'ed) had some questions about placement of this
> function call, so I will wait with providing fix until he replies.

Cool, thanks for the update.

Colin
>=20
>>
>> Colin
>>
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.d=
e
>=20



--pMI8gq1huC3pfVevEOlp2gM57uALqDbuT--

--JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcGLapPABucZhZwDPaMKH38aoAiYFAl2Mj8YACgkQaMKH38ao
AiYYLQ/+OP0GMNizJhdTJA+4gXUyJ0geSuq8uk0MmMVw2p3p3Ty0oQsVH52qkpiV
U2YY8uLxHDeu9aXudMEp6VsbS5y7J9V2Uv1JQjjJt0fZ794SEfTKx2cgP59eD/IN
BIKPYOq0+pBD+7whivvvdqOZGwK48//Omst2Y0dBKMGcCQ1mUzp8aGUBl304b0PV
mt4Vz35B925LW1ah+I/1Rb7zXL9oq6/0NUGgCTX2UGaOALQ2f3cFlpfwdz4GHJ/f
4EkhDIcSzcgWyoaS310B0nekng2Xw7iF4ae1WhpqejbbY1SCr5k4IIm/lkAK7e2j
+soLc02QyHIHlfDK+sYUmQuK/zX0oAYPtqUI6WSO0inh6gKURHvMnHKCT2dwFNGJ
bqoSCt0xwRxGtL8KsPHVApXQ7U/hQ5TDj7UxzLsx2l0kNhPxEijPdHyqQ9vcFtAK
CV5GiDYfpyhycNnOlc205i1DbANK+9ZlZDaTVGMUxckDYCid82JRggI2FT7SHpYC
uf8H1jFA9Y3adMtjRSELzMow5hMd3JHzUK8AZzvqOg4RuWjI2DeJOr+ScDseB3pN
eRBsIS19Z//tsSHU1X1KqfPql7gMB+g70yI6C2T4x7RQL0k3Zv3G3j2QgspO+Tkj
P0vwEi9PpjVMMMYZhbT8YJR6RT70asIgvItwig0IniWRBtYwnXA=
=whl9
-----END PGP SIGNATURE-----

--JK1TJ4HRO8ttDzM3Z5PzE9QI2kMZYmiVZ--

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF52EEAC6
	for <lists+linux-spi@lfdr.de>; Fri,  8 Jan 2021 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbhAHBLj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 20:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbhAHBLj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 20:11:39 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3712EC0612FF
        for <linux-spi@vger.kernel.org>; Thu,  7 Jan 2021 17:10:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x126so5183673pfc.7
        for <linux-spi@vger.kernel.org>; Thu, 07 Jan 2021 17:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=psTBbopMHOBhwdppzqIMbcfjf8tcO7+Li4WvwIgGQ8Q=;
        b=a2u1ybR8e7W7nw8cp8/G8fCWXDD2PFXOkHBuF+4Z9ZTy27Ph5elxXSCKK5xWVU231P
         UqVaBA/u471Rff8g2nEIp9WbymQG2awjLOu1PqWBq+nbEQTplr/DCL3fOzYhknjCmdNO
         yY3wmEqaIofTDQlb3HDVSd4m8C+3wXcsv5GjQlm/l0Yn657imHKGGfhqIuXt1Y/7mBc9
         Y4GmBj3srkyF5dKdjR/e7vyDlvIQFSyFmmtkltOmpuxHRy0p56TJ0T2BfO3tytuvxv40
         /6rvE8KrE7oOK+QKG97vi2uUjJw++3fW+VpyvTQCBxgevIvcAzkAnczuZ+BcVazS7n8T
         OKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=psTBbopMHOBhwdppzqIMbcfjf8tcO7+Li4WvwIgGQ8Q=;
        b=GmCuFEFxwJKXTf15D0nXqs87/iaotQiXwt1OfdBU8+1/Ow9uqMjpJZ1rIJV2HNqvaI
         W0PZW4nUs/Yp89EYUVi6B0PGu99DSmaJmgqjA4RZyLuwYy6YXGyfgz8Xt8go5s4RfyCE
         6WGgLMcxzYVpgJbsLIAwp1SBE7FHGrAYywPCLhDGYSu4P05O45ZD+hS419Yh4HIjRCYg
         u4+34+5OJRBdscg+6XwEf2IzQfInqojEvBa0fJm2dCtGFeewYw7ksh7Swvvx6cSgOvbL
         RVI6lPvNbPoQpo+79nShWwa6QjgldM5N3FitLVR2VWjeOq8L+J1FKGMdCsc4vwD3evK6
         +0eg==
X-Gm-Message-State: AOAM5326L/sLCoLr6IPJLMkjz9Ps4DInMPxsA0ferP+BEJfhZ3g4KoDh
        y1GP9whzVVtEt+iPriMou4w=
X-Google-Smtp-Source: ABdhPJzaYmgOCQfauS7XC8BhDSxC+lFuyhlM6Gch/EORbDUMCzUd2q+DM3Wxr7isT+OzqhwdanbkLQ==
X-Received: by 2002:a62:aa08:0:b029:1a9:bd0e:260b with SMTP id e8-20020a62aa080000b02901a9bd0e260bmr1159849pff.74.1610068251734;
        Thu, 07 Jan 2021 17:10:51 -0800 (PST)
Received: from localhost.lan (p8006072-ipngn42301marunouchi.tokyo.ocn.ne.jp. [180.34.60.72])
        by smtp.gmail.com with ESMTPSA id r123sm6681640pfr.68.2021.01.07.17.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:10:50 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id E409E900892;
        Fri,  8 Jan 2021 01:10:47 +0000 (GMT)
Date:   Fri, 8 Jan 2021 01:10:44 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: 5.11.0-rc1+: "Division by zero in kernel." when writing to
 spidev
Message-ID: <20210108011044.5780aa96@gmail.com>
In-Reply-To: <20210107153546.GD4726@sirena.org.uk>
References: <CAF78GY3NWQ1jzkauG26nagcMuqR0=u7zcWLh+wDdrJ8G=e7how@mail.gmail.com>
        <20210106130049.GC4752@sirena.org.uk>
        <CAF78GY3=m0kMd3d4tS92tZS57mY5XeRuXtET+BVVvnTwcdtO3g@mail.gmail.com>
        <20210106173759.GF4752@sirena.org.uk>
        <CAF78GY0xnKrOj5RhU2GHcQUTo2MLryrBj3+5dAMKoGzJn2okYw@mail.gmail.com>
        <20210107153546.GD4726@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CHi1ZchMVfwIhDaxF1kLkoX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

--Sig_/CHi1ZchMVfwIhDaxF1kLkoX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Jan 2021 15:35:46 +0000, Mark Brown <broonie@kernel.org> wrote:
> Copying in a bunch of people for that driver.

Thanks.
I added Tudor Ambarus as well as my debugging points in the direction
of:
commit 9326e4f1e5dd1a4410c429638d3c412b6fc17040 (spi/for-5.10)
Author: Tudor Ambarus <tudor.ambarus@microchip.com>
Date:   Wed Dec 9 19:35:14 2020 +0200

    spi: Limit the spi device max speed to controller's max speed

    Make sure the max_speed_hz of spi_device does not override
    the max_speed_hz of controller.

> I'd not expect this to be required with a polled path, it's only needed
> if the transfer function returns a positive value indicating that the
> transfer is still in progress which shouldn't be the case when things
> are polled.

Oh, indeed. And the driver is indeed returning 0 in this case.

> > I'll continue poking around later (especially checking computed timeout=
 values),
> > should I submit patches for s/complete/spi_finalize_current_transfer/ ?=
 =20

Reverting=20
    spi: Limit the spi device max speed to controller's max speed
fixes the timeout.

Which brings be back to devicetree:
- the controller node does not define the max clock rate
- the device I add in my overlay does define one
So spi->max_speed_hz is initially non-zero, but
spi->controller->max_speed_hz is zero, then:
-       if (!spi->max_speed_hz)
+       if (!spi->max_speed_hz ||
+           spi->max_speed_hz > spi->controller->max_speed_hz)
                spi->max_speed_hz =3D spi->controller->max_speed_hz;
it becomes zero in 5.11.
Then, because I do not specify a transfer speed in my userland code:
                if (!xfer->speed_hz)
                        xfer->speed_hz =3D spi->max_speed_hz;
it gets zero instead of the (as of 5.10) 4MHz, which led to my original
division-by-zero issue.

What would be the correct fix ?
- declare controller max clock ?
  If so, I think spi.c should warn about this missing value.
- do not cap transfer speed to controller speed when the latter is
  zero ?
- both ?

My working out, for whatever it's worth:
I ran my userland code under "strace -tt -T" and get:
00:31:21.449837 write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0"..., 4000) =3D -1 ETIMEDOUT (Connection timed out) <0.88555=
2>
Given the previous divide-by-zero issue, spi.c is now assuming 100kHz,
which for this 4000 bytes buffer means:
  >>> ((8*1000*4000)/100000) * 2 + 200
  844.96
milliseconds, which roughly matches the call duration measured by
strace.
But this device is declared in my DT as supporting transfer rates up to
4MHz (so period of 250ns), which would mean an actual transfer duration
of:
  >>> 4000*8*250e-9
  0.008
assuming bytes being sent back-to-back (which I believe is the case for
SPI, but worst case I do not expect this to multiply the transfer time
by 100...). So there is something wrong with the transfer speed.

> Probably send the completion patch, yes.

Done.

Regards,
--=20
Vincent Pelletier

--Sig_/CHi1ZchMVfwIhDaxF1kLkoX
Content-Type: application/pgp-signature
Content-Description: Signature digitale OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8a52rEyvQQl9Mmp91tK4CRgbyMAFAl/3sRQACgkQ1tK4CRgb
yMBzPA/+ICzwU+EL3vLO6TzE5PNSySX+LMmhXNWghyeKZcsY012PxmihY9pyl+Op
l82zrE2lQvMV3k8s2ACCJHjhY2XM9dLwOrTKka5l9GvH5m4fuvW5AQQgAxjo1PZx
vUxN1B0Settlwlku8lkftGvi79Pxa0iQcQ6Hlz5+v+H9ohdsSFc3GFdPg/0NSp59
WN5de9HkZESeqK0SDIN59e1jPPE8goIEgpx8M5vghq3+HukxkDvDLoB710m5dqeX
svgq8AiG5aD6dENmWnV9I9ufXLJh1FiAeOaAD6fVkz0zxfr5w1rCeHAKY5hKaTuZ
EBD5qRJxvQ3+46AxdauKoKSbaJ/+D0+drpQkOkq1PWP7W25Lo9J1gxQagZ7WuktA
z9PXdPGCemUOcRfLnRVvZWZOj31/xP5Gx0AiXqwgWV4/PrVl2CeiV1QVhKQr3fLV
3h1Obw86r7iNII7KfzDnLcq/3KE/LGxeh9MMZ97Z/h2jQ97kfMbu9j/50zFx6cYj
KbfD79D8HltxuzY39ZpfDf8jfZdUgMtDxdjofSPDxDfOhzdheygQLbqySiRdaAEC
5qKwPaPjbqL4SUUnV/DeA9VeQI9n3P1hSN58+HxaFnHEwMcMs0v8KnCc89YAVeiG
Y4cp+EHI/9HRorH+ZJQ9/PMqeH/xgGtLn2wsOm/76bAvcHV3v0Q=
=Q5N4
-----END PGP SIGNATURE-----

--Sig_/CHi1ZchMVfwIhDaxF1kLkoX--

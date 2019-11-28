Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D691010C55C
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 09:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfK1InH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 03:43:07 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37224 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfK1InG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Nov 2019 03:43:06 -0500
Received: by mail-lj1-f174.google.com with SMTP id u17so177488lja.4
        for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2019 00:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0A7PAHErMXMiLWk/qlmZsqTmhq9IxC9JLoTdr7xyNiQ=;
        b=Cg3UGJZ/IHjtMYKApRdIpTGOjYJc7oZQQIUXDlVVuLP3ZdHHfbAyQAzgDnBxCPCKTa
         Ag94QWvb+bxutTkfIoKAxlGUwcodZW7arG8jINfdOpcytagMOOjdynJx+a4vOnjOlWcD
         O4kBCBV904z5Gx4HDBe4Kkivh1EMfeoY6sm3NkusDl+SLiwAZ/nKenGNR4LrwH/Clf0Z
         TWF72Yc8RJm2kXK/wnEkPZ9BD3wEKuwn7AQCsvIUB95fCmTVGdpGygpGZRicm/rXCni8
         kzH76vSAgfF4z/qKxVwEBLcbx5O7xJM3gFq+5I0pbcK8BLpbIFk/7IHU0tDY0HlwOlZU
         ROaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0A7PAHErMXMiLWk/qlmZsqTmhq9IxC9JLoTdr7xyNiQ=;
        b=tvl5Ay7h3Lc/xA7wKYH2cmRU0/mgTQJ3k31hgbBEhCEQ5ClhvQ43xEzHQN1/hFK5aV
         6FAHisDIPSp6zdjqB60g9312oLHfJHpE9cBK59EzOjtlB7ZgjWSJs2U+B+J2smsOt7kI
         lulwAxW85UHG2Qz7kcufIXeMRLnbMdECk1CziUVaFzw5RGjvmLcXL4r+ppIeFu26LCwh
         MUI8jtYe72tcJyt6g9nqkBWVvwoLxLnSQND7sSL2BJoibLERniYVT6gUXupcZzNwiZfR
         MGxJVz1ArBBbXSesGa3RGGWin8QGRfmI1Fxe/WEtiBUxt2EmfwDCKIa08FSG/orb9Pkl
         q2JA==
X-Gm-Message-State: APjAAAXDuMRNZpGt55jV8agai1wA0lycJBc2RiockhZ21Y3MKRFqEZqw
        ndIxj6cOD6EG8NiB1Lt8LhoNROjrxHtNFOwjyZtlNw==
X-Google-Smtp-Source: APXvYqws92QE8ol5i46q8ypAJK4FbwtxVhvRJcANz8h3/vN7+CfayttMwqgCnT2dIJTYx8jp+gnG7guxcpOHvro8IG8=
X-Received: by 2002:a2e:161b:: with SMTP id w27mr33863903ljd.183.1574930584775;
 Thu, 28 Nov 2019 00:43:04 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr> <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr> <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr> <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
 <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr> <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
 <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr> <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
 <8b50ce56-0600-373d-178c-92aa780e5376@c-s.fr> <CACRpkdZRWojQAgHtBaNWdjKqv8aX3P-KjatgoG+DLCcYeJ7ztg@mail.gmail.com>
 <99f48a7e-e4f4-2a77-657c-452d7a656ec5@c-s.fr> <CACRpkdat-qtxCn=e1sqPMFF7urue0OoJJcixUwL1=nAT-F+H3Q@mail.gmail.com>
 <c3090d62-d049-5c9b-d48e-380b71755bfb@c-s.fr>
In-Reply-To: <c3090d62-d049-5c9b-d48e-380b71755bfb@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 09:42:53 +0100
Message-ID: <CACRpkdYPxSip9UAa-6sgXSgnCfdaXb8dxoh7ud=j7P+n_ax48A@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 3:29 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 27/11/2019 =C3=A0 14:56, Linus Walleij a =C3=A9crit :

> > I sent three patches, can you apply them on a clean tree
> > and confirm it solves the problem (fingers crossed...)
> >
> > Thanks a lot for helping me fix this!
>
> The series is OK if using 'cs-gpios'.
>
> With 'gpios' in the DTS, I get:
>
> [    3.154747] fsl_spi ff000a80.spi: cs1 >=3D max 1
> [    3.159207] spi_master spi0: spi_device register error

Ooops I looked over the gpiolib patch and found (I think) my mistake.

I sent a v3 patch set that hopefully will make everything work as
expected with just gpios =3D <...>;

Yours,
Linus Walleij

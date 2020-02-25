Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251EA16BD65
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 10:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgBYJit (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 04:38:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34067 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgBYJit (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Feb 2020 04:38:49 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so888085pjq.1;
        Tue, 25 Feb 2020 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eubYQ6F+onW80pNya2OZhzAfL78MLiu0aNJRLs2qNsA=;
        b=iHGyvWi3vIDYzbtQ3ih0oYCT9EXnqH0sQgv9Op/SsdEPqHt3ArIxXUMcOFKz/CqcLz
         4p5O3LloMq9wdsgNx8VDFl2yHfyiYtzv/GvMlTYcGU8Yy9Je9U4irsQSp1iLf6zeooHC
         91ksgnBZjTK6zEw5QTEqDZ8yk+uvHwRyYlpHf0r3m6PCqhuMSeAZ0335NiqAivaDNXuf
         bPwvLXcTymgkttLSUgdZg4nPPT/dxO5YQ7l9221t6lNTtvosfcJ4SCz7H9F/LSOPNc7L
         6bU8LYsgZWveEiUtdRhuIDMBb8xiD7EDLbLWCSrZwztWv7niPfi6Ms8jeyiBf+HJyWvG
         mjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eubYQ6F+onW80pNya2OZhzAfL78MLiu0aNJRLs2qNsA=;
        b=n4xMHEeWL+XAzK5WW/nyBdRKvRj0oY1g7T/2CAly8c4TU9B6pEYFo72p+rFS+1/QYU
         jlXJd2U7w2px9fKeMz6lA2ifT1D3VSyBmFKgeydLrqCkkhRtIdC/qHkzjddlYfSfA8SJ
         zeZ2lUEdQl3THuq1oPk6BJi+tda9WkKP39qawBTspx5m2glz92l6dAfJ6okIP0Kn5n/0
         RMGH4lf2Xl5JTDWfs+egdW5f9Z7a0OmYwOUYL0ONwOGimfRpF8e0Ygz7nzypD0cOgwTZ
         PLYBTdKhre/lFT/JLRYVJH8ODoq5JjOeA7p3bv+r18CyZrMncj/WPW4UTUSy/0M1D2NV
         bdQA==
X-Gm-Message-State: APjAAAWVNr6KtJTdyIijaobMEqoMZlbA5EbreQRlK0Gs3OyxAdNCT80+
        mVIHRouajkkfXCYbPVauOK9aLSYBsNamg46HxoeDCsQMgVQ=
X-Google-Smtp-Source: APXvYqwGE1kujwfwp9nMr4yvVs7zu5fw/b2nkvxZrut0MQffizEl9BspzEBxoZ7RrbRnhk6Skffa3cAMr/fVtmSGXdw=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr4267666pjq.132.1582623528039;
 Tue, 25 Feb 2020 01:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20200203223003.4567-1-eajames@linux.ibm.com> <CACPK8XdmdksFctYk96x46XJcxe3yQD3HfAzC8gdF_GXWJHeu2A@mail.gmail.com>
In-Reply-To: <CACPK8XdmdksFctYk96x46XJcxe3yQD3HfAzC8gdF_GXWJHeu2A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Feb 2020 11:38:40 +0200
Message-ID: <CAHp75VciUDKqxEQw_1bHDmVx19qTZWWjHdfgcJmm4iBwmyFJnA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: Add FSI-attached SPI controller driver
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-fsi@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Feb 25, 2020 at 7:08 AM Joel Stanley <joel@jms.id.au> wrote:
> On Mon, 3 Feb 2020 at 22:30, Eddie James <eajames@linux.ibm.com> wrote:

...

> > +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
> > +{
> > +       int i;
> > +       int num_bytes =3D min(len, 8);
> > +
> > +       for (i =3D 0; i < num_bytes; ++i)
> > +               rx[i] =3D (u8)(in >> (8 * ((num_bytes - 1) - i)));
> > +
> > +       return num_bytes;
> > +}
> > +
> > +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> > +{
> > +       int i;
> > +       int num_bytes =3D min(len, 8);
> > +
> > +       *out =3D 0ULL;
> > +
> > +       for (i =3D 0; i < num_bytes; ++i)
> > +               *out |=3D (u64)tx[i] << (8 * (8 - (i + 1)));
>
> Did this work with non-8 byte transfers? I think the second 8 should
> be num_bytes.
>
> The loop requires careful reading to check. I wonder if we could do
> this instead, which eliminates a lot duplicated loads and stores and
> is easier to read:
>
>        uint8_t *outp =3D (uint8_t *)out;
>
>        for (i =3D 0; i < num_bytes; ++i) {
>                outp[num_bytes - (i + 1)] =3D tx[i];
>        }

Have you had a chance to read my review of this? What do you think
about put_unaligned*()/get_unaligned*() instead of above?

> > +       return num_bytes;
> > +}

...

> > +static int fsi_spi_transfer_init(struct fsi_spi *ctx)
> > +{
> > +       int rc;
> > +       bool reset =3D false;
> > +       unsigned long end;
> > +       u64 seq_state;
> > +       u64 clock_cfg =3D 0ULL;
> > +       u64 status =3D 0ULL;
> > +       u64 wanted_clock_cfg =3D SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> > +               SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
> > +               FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 4);
> > +
> > +       end =3D jiffies + msecs_to_jiffies(SPI_FSI_INIT_TIMEOUT_MS);
> > +       do {
> > +               if (time_after(jiffies, end))
> > +                       return -ETIMEDOUT;
>
> How tightly does this loop spin?
>
> Should there be a delay inside of it?
>
> > +
> > +               rc =3D fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
> > +               if (rc)
> > +                       return rc;
> > +
> > +               if (status & (SPI_FSI_STATUS_ANY_ERROR |
> > +                             SPI_FSI_STATUS_TDR_FULL |
> > +                             SPI_FSI_STATUS_RDR_FULL)) {
> > +                       if (reset)
> > +                               return -EIO;
> > +
> > +                       rc =3D fsi_spi_reset(ctx);
> > +                       if (rc)
> > +                               return rc;
> > +
> > +                       reset =3D true;
> > +                       continue;
> > +               }
> > +
> > +               seq_state =3D status & SPI_FSI_STATUS_SEQ_STATE;
> > +       } while (seq_state && (seq_state !=3D SPI_FSI_STATUS_SEQ_STATE_=
IDLE));
>
> ../drivers/spi/spi-fsi.c: In function =E2=80=98fsi_spi_transfer_one_messa=
ge=E2=80=99:
> ../drivers/spi/spi-fsi.c:363:11: warning: =E2=80=98seq_state=E2=80=99 may=
 be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   363 |  } while (seq_state && (seq_state !=3D SPI_FSI_STATUS_SEQ_STATE_I=
DLE));
>       |           ^~~~~~~~~

It's bogus warning, though, I think, easy to fix by reshuffling loop body.

> > +       rc =3D fsi_spi_read_reg(ctx, SPI_FSI_CLOCK_CFG, &clock_cfg);
> > +       if (rc)
> > +               return rc;
> > +
> > +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
> > +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> > +                         SPI_FSI_CLOCK_CFG_MODE |
> > +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
> > +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) !=3D wanted_clock=
_cfg)
> > +               rc =3D fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> > +                                      wanted_clock_cfg);
> > +
> > +       return rc;
> > +}

--=20
With Best Regards,
Andy Shevchenko

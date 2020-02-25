Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8592516B8BF
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 06:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgBYFIq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 00:08:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44501 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBYFIp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Feb 2020 00:08:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id j23so8230478qtr.11;
        Mon, 24 Feb 2020 21:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OYzEu19BNaQZ+QEcaavvFcdfHL+hwTV/fYQk0Icyp4w=;
        b=DP04zKHVzLp004O+gVK8ynNltFZXaXiHlKcCAWi5DP02PQiDsSrNBukFKw0xBypYYS
         swgYiEzTw+2HOB3+ZyGVNM8awYivRfitziRhcgBYG4Xgz5NA1OgiVdohx1dUMSuj3prB
         xHiHQk4oBhLuFRBZNQFNu5vK6OyRNrcrxyCv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OYzEu19BNaQZ+QEcaavvFcdfHL+hwTV/fYQk0Icyp4w=;
        b=Vb1oNFCEso6T/ou96q/CNz7e4eMBeedVoIfOkrRnK2vBnzQLkK/aCMirITEKBYPHqP
         UucJWiIMdbK5QxCoo0R3TYOFLJn6dnfX+TqLQc0+vBLBWBgtx9Q/fpuRSaUn1WYv1gic
         rB3FZrbkB9MaG4WVWBkKPvgxl6LeBtdzZtfWiwVHkrSqH65/i4Cjf3RyGLgOpMGgf12t
         ivsdITV49O6zagVZIkecHEIhDHXd4IneYTgUW4gxTV60FewjHD0tZMCrvt+ltcm7W6vg
         EB62LRBcA1yEmS0qPJiXEuC1XiYQtQ2tHV7jE9tKXzS08Phr6Mi8gFuiWYBP4av8Pbth
         RB0A==
X-Gm-Message-State: APjAAAUw0Vv0Xf89SBrBuEBlOMWvzVtBIyp3JgT47tp4tXTTTCmzEegs
        r3/BnhB+hsk9O5nGKMHBvzFLKfIAfFQP5ZqbMJE=
X-Google-Smtp-Source: APXvYqwNNUXiFQiIlA5GjBvdgTXw/RNU4AmIj/D0xW5/uLDGR/PwMCWZFNkG2mtSTp++mJ6GGrA8RBG0mnryW+N3q/0=
X-Received: by 2002:ac8:4244:: with SMTP id r4mr50733467qtm.169.1582607324570;
 Mon, 24 Feb 2020 21:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20200203223003.4567-1-eajames@linux.ibm.com>
In-Reply-To: <20200203223003.4567-1-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 Feb 2020 05:08:32 +0000
Message-ID: <CACPK8XdmdksFctYk96x46XJcxe3yQD3HfAzC8gdF_GXWJHeu2A@mail.gmail.com>
Subject: Re: [PATCH v2] spi: Add FSI-attached SPI controller driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-fsi@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Eddie,

Some comments below. For the most part it looks good.

On Mon, 3 Feb 2020 at 22:30, Eddie James <eajames@linux.ibm.com> wrote:

> +FSI-ATTACHED SPI DRIVER
> +M:     Eddie James <eajames@linux.ibm.com>
> +L:     linux-spi@vger.kernel.org

Add linux-fsi@lists.ozlabs.org too

> +S:     Maintained
> +F:     drivers/spi/spi-fsi.c

> +static int fsi_spi_write_reg(struct fsi_spi *ctx, u32 offset, u64 value)
> +{
> +       int rc;
> +       __be32 cmd_be;
> +       __be32 data_be;
> +
> +       dev_dbg(ctx->dev, "Write %02x[%016llx].\n", offset, value);
> +
> +       data_be =3D cpu_to_be32(upper_32_bits(value));
> +       rc =3D fsi_device_write(ctx->fsi, FSI2SPI_DATA0, &data_be,
> +                             sizeof(data_be));
> +       if (rc)
> +               return rc;
> +
> +       data_be =3D cpu_to_be32(lower_32_bits(value));

The lower_32_bits cast is redundant (but harmless).

> +       rc =3D fsi_device_write(ctx->fsi, FSI2SPI_DATA1, &data_be,
> +                             sizeof(data_be));
> +       if (rc)
> +               return rc;
> +
> +       cmd_be =3D cpu_to_be32((offset + ctx->base) | FSI2SPI_CMD_WRITE);

offset + ctx->base must be less than 2 ^ 31 otherwise the top bit of
the address collides with the write command. Should we introduce a
check for that?

> +       rc =3D fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cm=
d_be));
> +       if (rc)
> +               return rc;
> +
> +       return fsi_spi_check_status(ctx);
> +}
> +
> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
> +{
> +       int i;
> +       int num_bytes =3D min(len, 8);
> +
> +       for (i =3D 0; i < num_bytes; ++i)
> +               rx[i] =3D (u8)(in >> (8 * ((num_bytes - 1) - i)));
> +
> +       return num_bytes;
> +}
> +
> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> +{
> +       int i;
> +       int num_bytes =3D min(len, 8);
> +
> +       *out =3D 0ULL;
> +
> +       for (i =3D 0; i < num_bytes; ++i)
> +               *out |=3D (u64)tx[i] << (8 * (8 - (i + 1)));

Did this work with non-8 byte transfers? I think the second 8 should
be num_bytes.

The loop requires careful reading to check. I wonder if we could do
this instead, which eliminates a lot duplicated loads and stores and
is easier to read:

       uint8_t *outp =3D (uint8_t *)out;

       for (i =3D 0; i < num_bytes; ++i) {
               outp[num_bytes - (i + 1)] =3D tx[i];
       }

> +
> +       return num_bytes;
> +}
> +
> +static int fsi_spi_reset(struct fsi_spi *ctx)
> +{
> +       int rc;
> +
> +       dev_dbg(ctx->dev, "Resetting SPI controller.\n");
> +
> +       rc =3D fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> +                              SPI_FSI_CLOCK_CFG_RESET1);
> +       if (rc)
> +               return rc;
> +
> +       return fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> +                                SPI_FSI_CLOCK_CFG_RESET2);
> +}
> +
> +static int fsi_spi_sequence_add(struct fsi_spi_sequence *seq, u8 val)
> +{
> +       seq->data |=3D (u64)val << seq->bit;
> +       seq->bit -=3D 8;
> +
> +       return ((64 - seq->bit) / 8) - 2;

I have no idea what this is doing. Add a comment?

> +}

> +
> +static int fsi_spi_transfer_init(struct fsi_spi *ctx)
> +{
> +       int rc;
> +       bool reset =3D false;
> +       unsigned long end;
> +       u64 seq_state;
> +       u64 clock_cfg =3D 0ULL;
> +       u64 status =3D 0ULL;
> +       u64 wanted_clock_cfg =3D SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> +               SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
> +               FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 4);
> +
> +       end =3D jiffies + msecs_to_jiffies(SPI_FSI_INIT_TIMEOUT_MS);
> +       do {
> +               if (time_after(jiffies, end))
> +                       return -ETIMEDOUT;

How tightly does this loop spin?

Should there be a delay inside of it?

> +
> +               rc =3D fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
> +               if (rc)
> +                       return rc;
> +
> +               if (status & (SPI_FSI_STATUS_ANY_ERROR |
> +                             SPI_FSI_STATUS_TDR_FULL |
> +                             SPI_FSI_STATUS_RDR_FULL)) {
> +                       if (reset)
> +                               return -EIO;
> +
> +                       rc =3D fsi_spi_reset(ctx);
> +                       if (rc)
> +                               return rc;
> +
> +                       reset =3D true;
> +                       continue;
> +               }
> +
> +               seq_state =3D status & SPI_FSI_STATUS_SEQ_STATE;
> +       } while (seq_state && (seq_state !=3D SPI_FSI_STATUS_SEQ_STATE_ID=
LE));

../drivers/spi/spi-fsi.c: In function =E2=80=98fsi_spi_transfer_one_message=
=E2=80=99:
../drivers/spi/spi-fsi.c:363:11: warning: =E2=80=98seq_state=E2=80=99 may b=
e used
uninitialized in this function [-Wmaybe-uninitialized]
  363 |  } while (seq_state && (seq_state !=3D SPI_FSI_STATUS_SEQ_STATE_IDL=
E));
      |           ^~~~~~~~~


> +
> +       rc =3D fsi_spi_read_reg(ctx, SPI_FSI_CLOCK_CFG, &clock_cfg);
> +       if (rc)
> +               return rc;
> +
> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> +                         SPI_FSI_CLOCK_CFG_MODE |
> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) !=3D wanted_clock_c=
fg)
> +               rc =3D fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> +                                      wanted_clock_cfg);
> +
> +       return rc;
> +}

> +static int fsi_spi_probe(struct device *dev)
> +{
> +       int rc;
> +       u32 root_ctrl_8;
> +       struct device_node *np;
> +       int num_controllers_registered =3D 0;
> +       struct fsi_device *fsi =3D to_fsi_dev(dev);
> +
> +       /*
> +        * Check the SPI mux before attempting to probe. If the mux isn't=
 set
> +        * then the SPI controllers can't access their slave devices.
> +        */
> +       rc =3D fsi_slave_read(fsi->slave, FSI_MBOX_ROOT_CTRL_8, &root_ctr=
l_8,
> +                           sizeof(root_ctrl_8));

Is it correct to stop probing if the mux is not set?

I assume it changes at runtime depending on the state of the host.
This could mean the driver probes correctly, but fails to work (if the
mux was set at BMC boot, but then changes).

Should it instead block reads/writes when the mux is in the incorrect state=
?

> +       if (rc)
> +               return rc;
> +
> +       if (!root_ctrl_8) {
> +               dev_dbg(dev, "SPI mux not set, aborting probe.\n");
> +               return -ENODEV;
> +       }
> +
> +       for_each_available_child_of_node(dev->of_node, np) {
> +               u32 base;
> +               struct fsi_spi *ctx;
> +               struct spi_controller *ctlr;
> +
> +               if (of_property_read_u32(np, "reg", &base))

It looks like this has a device tree binding. Can you add a document
describing it too?

> +                       continue;
> +
> +               ctlr =3D spi_alloc_master(dev, sizeof(*ctx));
> +               if (!ctlr)
> +                       break;
> +
> +               ctlr->dev.of_node =3D np;
> +               ctlr->num_chipselect =3D of_get_available_child_count(np)=
 ?: 1;
> +               ctlr->flags =3D SPI_CONTROLLER_HALF_DUPLEX;
> +               ctlr->max_transfer_size =3D fsi_spi_max_transfer_size;
> +               ctlr->transfer_one_message =3D fsi_spi_transfer_one_messa=
ge;
> +
> +               ctx =3D spi_controller_get_devdata(ctlr);
> +               ctx->dev =3D &ctlr->dev;
> +               ctx->fsi =3D fsi;
> +               ctx->base =3D base + SPI_FSI_BASE;
> +
> +               rc =3D devm_spi_register_controller(dev, ctlr);
> +               if (rc)
> +                       spi_controller_put(ctlr);
> +               else
> +                       num_controllers_registered++;
> +       }
> +
> +       if (!num_controllers_registered)
> +               return -ENODEV;
> +
> +       return 0;
> +}

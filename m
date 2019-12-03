Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F6E110436
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLCS2l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:28:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46559 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLCS2l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:28:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id g18so3781308otj.13;
        Tue, 03 Dec 2019 10:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fv7hK3dsMSAwX5HCuemGK+Z9KDZWWG/xHQo0UQoD8U4=;
        b=HJL38RMz5qzH4XVcXnp9hnuarM9hIWZd4BMFknfuTz5mKQp5U6Gb9WzJmSUTXtb/43
         r+h93BHg/QnXC8yh4zvoMCNNwyMSdczGqhbYBGuJkanX3E1sX/WCtz6hOBeY468g2V83
         YIoA5lKpGaX0UZjtswxgRuqtlyH1YGd/p2jZYt6K53PkdpWX6h9eCW5GM5PDlZe5GF+6
         ilS5NhBAfcvd61WVvAM3K/FKMj5n64zQ0+iqNst7jlykRzjnApGv/CS56nZLw430TtwF
         TQSCFLiS3UgJxc0FjNqEcpkQ49g5cyZNnQBTrTGLqEI1SeU40BX1nmEF5Ot/kw0TASY5
         TRJQ==
X-Gm-Message-State: APjAAAU1/UKzg7n/0+IAjlYjcoqPe5aNV+r5mlGiPFuf6GxfVWScdHjM
        bPwtNGcl2eRLxRP3N7bDuK3RRpbw+jeC2sd7s94uumu/
X-Google-Smtp-Source: APXvYqyA+DCAs3/VI5MgeLMWcYKSuUIqmCJm5Yyj2zed+M3ncd0J3s5tbB++PhJ2nC7OuPqasfdaf/2CpX7Z/mP3f6w=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr4258154ota.145.1575397719725;
 Tue, 03 Dec 2019 10:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com> <20191203034519.5640-5-chris.brandt@renesas.com>
In-Reply-To: <20191203034519.5640-5-chris.brandt@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:28:18 +0100
Message-ID: <CAMuHMdVAZOa7OmT0s=RsVJsny9NujDzpdg4T+QoUXGe0kJjOTw@mail.gmail.com>
Subject: Re: [PATCH 4/6] spi: Add SPIBSC driver
To:     Chris Brandt <chris.brandt@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Tue, Dec 3, 2019 at 4:46 AM Chris Brandt <chris.brandt@renesas.com> wrote:
> Add a driver for the SPIBSC controller in Renesas SoC devices.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/spi/spi-spibsc.c
> @@ -0,0 +1,609 @@
> +// SPDX-License-Identifier: GPL-2.0

GPL-2.0-only

> +static void spibsc_print_data(struct spibsc_priv *sbsc, u8 tx, const u8 *buf,
> +                             int len)
> +{
> +#if defined(DEBUG_PRINT_DATA)
> +       char line_buffer[3*16+1];
> +       int i, line_index = 0;
> +
> +       if (tx)
> +               pr_debug("spibsc: send data: ");
> +       else
> +               pr_debug("spibsc: recv data: ");
> +
> +       for (i = 0; i < len; ) {
> +               sprintf(line_buffer + line_index, " %02X", buf[i]);
> +               line_index += 3;
> +               i++;
> +               if (i % 16 == 0) {
> +                       pr_debug(line_buffer);
> +                       line_index = 0;
> +               }
> +       }
> +       if (i % 16 != 0)
> +               pr_debug(line_buffer);
> +       else
> +               pr_debug("\n");
> +#endif

print_hex_dump_debug()?

> +}
> +
> +static int spibsc_wait_trans_completion(struct spibsc_priv *sbsc)
> +{
> +       int t = 256 * 100000;
> +
> +       while (t--) {
> +               if (spibsc_read(sbsc, CMNSR) & CMNSR_TEND)
> +                       return 0;
> +               ndelay(1);
> +       }

So this may busy loop for up to 25.6 ms? Oops...

Can you use the interrupt (SPIHF) instead, signalling a completion?

> +
> +       dev_err(sbsc->dev, "Timeout waiting for TEND\n");
> +       return -ETIMEDOUT;
> +}


> +       /* Use 'Option Data' for 3rd-6th bytes */
> +       switch (tx_len) {
> +       case 6:
> +               dropr |= DROPR_OPD0(tx_data[5]);
> +               opde |= (1 << 0);

Both checkpatch and gcc tell you to add fallthrough coments.

> +       case 5:
> +               dropr |= DROPR_OPD1(tx_data[4]);
> +               opde |= (1 << 1);
> +       case 4:
> +               dropr |= DROPR_OPD2(tx_data[3]);
> +               opde |= (1 << 2);
> +       case 3:
> +               dropr |= DROPR_OPD3(tx_data[2]);
> +               opde |= (1 << 3);
> +               drenr |= DRENR_OPDE(opde);
> +       }

> +static int spibsc_transfer_one_message(struct spi_controller *master,
> +                                      struct spi_message *msg)
> +{
> +       struct spibsc_priv *sbsc = spi_controller_get_devdata(master);
> +       struct spi_transfer *t, *t_last;
> +       u8 tx_data[MAX_CMD_LEN];
> +       int tx_only;
> +       u8 tx_len;
> +       int ret;
> +
> +       t_last = list_last_entry(&msg->transfers, struct spi_transfer,
> +                                transfer_list);
> +       /* defaults */
> +       ret = 0;
> +       sbsc->last_xfer = 0;
> +       tx_only = 1;
> +
> +       /* Analyze the messages */
> +       t = list_first_entry(&msg->transfers, struct spi_transfer,
> +                            transfer_list);
> +       if (t->rx_buf) {
> +               dev_dbg(sbsc->dev, "Cannot Rx without Tx first!\n");
> +               return -EIO;
> +       }
> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
> +               if (t->rx_buf) {
> +                       tx_only = 0;
> +                       if (t != t_last) {
> +                               dev_dbg(sbsc->dev, "RX transaction is not the last transaction!\n");
> +                               return -EIO;
> +                       }
> +               }
> +               if (t->cs_change) {
> +                       dev_err(sbsc->dev, "cs_change not supported");
> +                       return -EIO;
> +               }
> +       }

If you would do the checks above in .prepare_message()
(like e.g. rspi does)...

> +
> +       /* Tx Only (SPI Mode is used) */
> +       if (tx_only == 1) {
> +
> +               dev_dbg(sbsc->dev, "%s: TX only\n", __func__);
> +
> +               /* Initialize for SPI Mode */
> +               spibsc_write(sbsc, CMNCR, CMNCR_INIT);
> +
> +               /* Send messages */
> +               list_for_each_entry(t, &msg->transfers, transfer_list) {
> +
> +                       if (t == t_last)
> +                               sbsc->last_xfer = 1;
> +
> +                       ret = spibsc_send_data(sbsc, t->tx_buf, t->len);
> +                       if (ret)
> +                               break;
> +
> +                       msg->actual_length += t->len;
> +               }
> +
> +               /* Done */
> +               msg->status = ret;
> +               spi_finalize_current_message(master);
> +               return ret;
> +       }
> +
> +       /* Tx, then RX (Data Read Mode is used) */
> +       dev_dbg(sbsc->dev, "%s: Tx then Rx\n", __func__);
> +
> +       /* Buffer up the transmit portion (cmd + addr) so we can send it all at
> +        * once
> +        */
> +       tx_len = 0;
> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
> +               if (t->tx_buf) {
> +                       if ((tx_len + t->len) > sizeof(tx_data)) {
> +                               dev_dbg(sbsc->dev, "Command too big (%d)\n",
> +                                       tx_len + t->len);
> +                               return -EIO;
> +                       }
> +                       memcpy(tx_data + tx_len, t->tx_buf, t->len);
> +                       tx_len += t->len;
> +               }
> +
> +               if (t->rx_buf)
> +                       ret = spibsc_send_recv_data(sbsc, tx_data, tx_len,
> +                                                   t->rx_buf,  t->len);
> +
> +               msg->actual_length += t->len;
> +       }
> +
> +       msg->status = ret;
> +       spi_finalize_current_message(master);

... can't you just use .transfer_one(), instead of duplicating the logic
from spi_transfer_one_message()?
Or is there some special detail that's not obvious to the casual reviewer?


> +static const struct of_device_id of_spibsc_match[] = {
> +       { .compatible = "renesas,spibsc"},
> +       { .compatible = "renesas,r7s72100-spibsc", .data = (void *)HAS_SPBCR},
> +       { .compatible = "renesas,r7s9210-spibsc"},

Do you need to match against all 3 in the driver?
Does SPIBSC work on RZ/A1 when not setting HAS_SPBCR?
If not, the fallback to "renesas,spibsc" is not valid for RZ/A1.

> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, of_spibsc_match);
> +
> +static struct platform_driver spibsc_driver = {
> +       .probe = spibsc_probe,
> +       .remove = spibsc_remove,
> +       .driver = {
> +               .name = "spibsc",
> +               .owner = THIS_MODULE,
> +               .of_match_table = of_spibsc_match,
> +       },
> +};
> +module_platform_driver(spibsc_driver);
> +
> +MODULE_DESCRIPTION("Renesas SPIBSC SPI Flash driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Chris Brandt");
> --
> 2.23.0
>


--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

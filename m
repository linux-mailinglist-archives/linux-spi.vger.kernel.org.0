Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75A1F7498
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFLH2N (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 03:28:13 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39475 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgFLH2M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Jun 2020 03:28:12 -0400
Received: by mail-oi1-f180.google.com with SMTP id d67so7839492oig.6
        for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2020 00:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1D5Z80kkApaHcNGmyNXLpMJS5JaKNs0Uky3dsjcmeU=;
        b=Cc1S98vex8whuVTgDand+iP2gXM35BD1hKqg0/0cE6A5XIsrXY7qXj68WiUXDB01NP
         GOqev0D9rx6wwCg6Lmiu7g+zNW56obntSJbYUJVrYeGjQ5NEfBgOPfYmfXbp/eAauCfZ
         HXWlMEpXvPBlOytUzdjGImXlABq2OhSsQVnlQrjzXG83LPO+V9iKr7dOuVnI10lASgHX
         4aOM0Wv+LMHMj6nM6vF85wP/qdowI7aKnamLS97ky/EZ131OMWO/J/moEyMRjwYlAJC7
         ZSauUISF6wckxHORl0JFPDBSktRtGFxyNuuTiLb2b5hflV4Q68xetevWjLseyYHU9G0M
         KjWA==
X-Gm-Message-State: AOAM531xUxLeA26y2/77wK7gDHLuzOYCTBHqb9HFrba+h976Ph/TE4bC
        ILRnUIiNWaFYaRfQVI+KVIgbSSABitXFeHMW0nX0SkQ+
X-Google-Smtp-Source: ABdhPJzsGPC5M+SMxMIkK7MPfkSDAy6NO4SD9c4dw1afwi7/SiSMugEi3cwxkACg/kI61Mt/KtzXcUZKOZvmXXZZHII=
X-Received: by 2002:a54:4006:: with SMTP id x6mr1161699oie.148.1591946891668;
 Fri, 12 Jun 2020 00:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200611213751.85924899767@corona.crabdance.com>
In-Reply-To: <20200611213751.85924899767@corona.crabdance.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Jun 2020 09:27:58 +0200
Message-ID: <CAMuHMdUootcS-p+=AWcU7y9z_t2aXZer8VGDf2MwNWH-dD3KoA@mail.gmail.com>
Subject: Re: How to extract opcode, addr, dummy and buffer in transfer_one_message()?
To:     schaecsn@gmx.net
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Stefan,

On Thu, Jun 11, 2020 at 11:39 PM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
> I can implement mem_ops() a/o transfer_one_message().
>
> spi-mem.c:spi_mem_exec_op() will directly pass op to mem_ops->exec_op(). There
> I can easily extract opcode, addr, dummy and data buffer. It would probably
> look roughly like
>
> exec_op(struct spi_mem *mem, const struct spi_mem_op *op){
>         dummy = addr = -1;
>
>         opcode = op->cmd.opcode;
>
>         addrlen=op->addr.nbytes;
>         if (addrlen)
>             addr = op->addr.val;
>
>         if (op->dummy.nbytes)
>             dummy = QSPI_DUMMY_CYCLE;
>
>         len=op->data.nbytes;
>         if (len)
>             if (op->data.dir == SPI_MEM_DATA_IN) {
>                 rxbuf = op->data.buf.in;
>                 is_wr = false;
>             } else {
>                 txbuf = op->data.buf.out;
>                 is_wr = true;
>             }
> }
>
> That's great. What about transfer_one_message()?
>
> spi-mem.c:spi_mem_exec_op() builds a message consisting of multiple transfers.
> If there is no address, dummy or data buffer, then they will not be included in
> the transfer array as transfers are created like this
>
>         /* op is the first transfer */
>         tmpbuf[0] = op->cmd.opcode;
>         xfers[xferpos].tx_buf = tmpbuf;
>         ...
>
>         if (op->addr.nbytes) {
>         /* add addr transfer */
>         ...
>         }
>
>         if (op->dummy.nbytes) {
>         /* add dummy transfer */
>         ...
>         }
>
>         if (op->data.nbytes) {
>         /* add data transfer */
>         ...
>         }
>
> These transfers are then passed as a message consisting of 1 to 4 transfers to
> transfer_one_message().
>
> In transfer_one_message(), the first transfer is the opcode. How do I now what
> the next transfers represent? Like in the exec_op() example above, I would like
> to create and initialize my variables opcode, addr, dummy and read or write
> buffer.

The meaning of the transfers depends on the protocol used to talk to
the SPI slave.
The mem_ops() are intended for memory devices. transfer_one_message()
(and transfer_one()) are meant for communicating with generic SPI slaves.

> Related question: what are the disadvantages of always using mem_ops() and
> never transfer_one_message()?

If you do that, your driver cannot talk to SPI slaves that are not supported
by spi_mem, i.e. anything except memory devices.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

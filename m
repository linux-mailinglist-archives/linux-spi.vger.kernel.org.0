Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC522CDCBC
	for <lists+linux-spi@lfdr.de>; Thu,  3 Dec 2020 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgLCRvP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Dec 2020 12:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgLCRvN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Dec 2020 12:51:13 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65083C061A52;
        Thu,  3 Dec 2020 09:50:27 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id ck29so3018001edb.8;
        Thu, 03 Dec 2020 09:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f/lU7wZvUZo1FXkT5r4NrXSCYN/0Xgw0B9cmSE39UdA=;
        b=ZIrdH97CEuLYgmMBy23rE/QGKt+bIHisjsPFuKIE7wUvYV3UZFNVEhzsNg1prn/CYg
         Sx+XjGfJnLksyoxByA08Tt86UCiamtth3ueqtTX34kokrB9JwOOMtq5POZ2Zw6Su/7aq
         uPWhBxRIsrMjAS7wmJJU+ZE18TmWgb4RcxvJBboJCcjcc+aGc9fUTfb78MDX7WiN9A4V
         WwXRvirp7LKRx8eEWA4HUsV7Nd2QrZg15ajBOsgy/AGi37XTs1sq8kWFOF/1RUnMTstt
         aeB48LVWJzamq2NvARiHyUNDnIb1uztkt86aJDcTGuaxI8KlB+fcMwpKIUBuOJKRdZd4
         x6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f/lU7wZvUZo1FXkT5r4NrXSCYN/0Xgw0B9cmSE39UdA=;
        b=lWlEau2AUyin7r1II56WgZj+wMyaGH9G3fy4lDXBz4N9pp2C9NImTnyx+M08wAFKsq
         FXeCUGuM1duq7G+BxaZyY2zHtaEUYKRvoSb6+cysl7krAtNUZqBzVLULFfZOfkwpoAak
         5K0An075w7epiDmE6z80n+MYRp3FsQetOfEHhHiRXLe0P0J7ZSpq+qiVz99zBhkFFwRg
         h+yYRi7MThligzHUEIU5wqt0jF6vQdHojiRjfvrP7qbsx9vPZGHCVL6l45jz5Dcu3EUA
         v6wUrt+qlxtHiQBZIOMfcFK/4bJbPi1AYb3qnkk/T5kbDlxc9GBcLQ7hsDR6xLWOiikr
         JtHQ==
X-Gm-Message-State: AOAM532Z8tY4M7r+HTtEpcokK9QPkeYAwSpvSau3jdgBumou310Jy1u8
        pJbv2YuDfCeWfeOsxbk2lnfvHODBz7E=
X-Google-Smtp-Source: ABdhPJwR6NWvGHwhc1bjgyRw9T3sLWlEraTCh5wKTlRR0UCa9FJmDVEgcg02OADiU5aky/CUj3whRA==
X-Received: by 2002:a50:d6c6:: with SMTP id l6mr3958749edj.80.1607017826093;
        Thu, 03 Dec 2020 09:50:26 -0800 (PST)
Received: from skbuf ([188.25.2.120])
        by smtp.gmail.com with ESMTPSA id r9sm1291588ejd.38.2020.12.03.09.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 09:50:25 -0800 (PST)
Date:   Thu, 3 Dec 2020 19:50:24 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?0JzQsNC60YHQuNC8INCa0LjRgdC10LvRkdCy?= 
        <bigunclemax@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Kochetkov <fido_max@inbox.ru>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add GPIO chip select support
Message-ID: <20201203175024.hzivclydoxp6txir@skbuf>
References: <CALHCpMgQPDqV1tB6v0sA0imwfZGkoG_j84NZCehOT1pf8MTuCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHCpMgQPDqV1tB6v0sA0imwfZGkoG_j84NZCehOT1pf8MTuCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Maxim,

On Thu, Dec 03, 2020 at 08:12:19PM +0300, Максим Киселёв wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
> Date: Thu, 3 Dec 2020 18:56:12 +0300
> Subject: [PATCH] spi: spi-fsl-dspi: Add GPIO chip select support
> 
> This patch allows use of GPIO for the chip select.
> Because dSPI controller can't send transactions without hardware chip
> selects, so first unused native CS will be set in SPI_PUSHR_CMD_PCS

Are you sure?

From the reference manual:

SPIx_PUSHR bits 10–15 PCS:
Select which PCS signals are to be asserted for the transfer. Refer to
the chip-specific SPI information for the number of PCS signals used in
this chip.
0 Negate the PCS[x] signal.
1 Assert the PCS[x] signal.

And the definition is:

#define SPI_PUSHR_CMD_PCS(x)		(BIT(x) & GENMASK(5, 0))

Notice the BIT(x).

I expect that you can set the PCS to 0 and no hard chip select will
assert.

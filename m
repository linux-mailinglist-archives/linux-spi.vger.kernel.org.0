Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23DDAB725
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2019 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfIFL3q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Sep 2019 07:29:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33381 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfIFL3q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Sep 2019 07:29:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id e12so4368755oie.0;
        Fri, 06 Sep 2019 04:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=og0rv7RklmbaQcIC0R6ni4LtZZPaEbtcHPj2K8B0plU=;
        b=iLzWNBiOe3DRX5mGQd/3yAakMxEtfJ3y+5FUSdNLfTulBTeQkvKmxKRet92EGgaW2n
         1QyrZec4MggpVLwz5HyBnkbJ1fBmgl2XD6gMsmidxUiNQpao8Uj41T3i9TGVfg0y0Qn6
         X+s36R18ybJlf2vTzBSapRttlxeTSJRGJcDxzl+txk4kTDT8CVJsaooK/Zp7Od7XqFjm
         llrHzx1Y58fIsokW1zGcxC+RWidbPIRFKr58R3yOwJlncFt+ItEyaPvXxVKxag9OhF6u
         qhAKaAzF76TM6imr2NNJX15iS95WAHuzysxPD7aYvqmbdMHMl6d9Qa0IyTocoKUZrDxR
         57lQ==
X-Gm-Message-State: APjAAAVKkPefAkkYT3x1rkBikRoJlgTA/k2rYun2daPFTInisWa9Kn4D
        v57fSq80sDaH7ssW3oS67CZNs/KqHxl3XvXKARZrQg==
X-Google-Smtp-Source: APXvYqxWOzJwW40O7OlywgjlDssH0y/Z277oQUeNZOHuDPsRbkdZay7EqjBpucgZNeKX06Ml2MARype0U52zwbaC4Mg=
X-Received: by 2002:aca:ea82:: with SMTP id i124mr6229218oih.153.1567769385155;
 Fri, 06 Sep 2019 04:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <TY1PR01MB1562DB9AB5D516662204C1CF8ABB0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562DB9AB5D516662204C1CF8ABB0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Sep 2019 13:29:33 +0200
Message-ID: <CAMuHMdWTHxYbx76fe2VEfBanZw-QmTsVQRRz2RGROm89FdMCJA@mail.gmail.com>
Subject: Re: [RFC] Is runtime_pm in the RSPI driver broken?
To:     Chris Brandt <Chris.Brandt@renesas.com>
Cc:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Thu, Sep 5, 2019 at 7:06 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> Hello SPI and Renesas people (and Geert),
>
> Before I submit a patch, is the rspi.c driver really broken or not?
>
> I'm working with the RZ/A2M at the moment.
>
> Runtime pm was added by Geert back in 2014. (commit 490c97747d5d)
>
> But I'm noticing now that if I turn off all the clocks in u-boot before
> I boot, SPI does not work.
>
> However, if I add a pm_runtime_get_sync() call do the driver, it works
> fine.
>
> So, am I missing something? It seems that the driver is not going to
> work correctly unless pm_runtime_get_sync() gets called.

QSPI on Koelsch, which uses the same driver, is still working for me,
with debug patches to turn off all unneeded clocks during early boot.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

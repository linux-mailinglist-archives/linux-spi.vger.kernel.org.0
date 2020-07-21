Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4202278E8
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGUGjC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 02:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGUGjB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 02:39:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81DCC061794
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2020 23:39:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x9so9831928plr.2
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2020 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yB0Psip9qk9rxqyC1cNcG+jHEmt9ZmS/yY/eRaAVMjQ=;
        b=GSwmb/pWoEZatGwhjB4L8HzE4HJ/d8G7lkThsPmz99FgNuQslW6a0nv495UvOX24Jp
         G5Nz+994jMNj4YVNvI3Ps3uScv5/fVUAAiol2aMM7QkZ+tVTLDeBlew+fPnrBJOc0854
         BIeNAHfZ4Tgh5bv6i2A232iqRw3B8+T1gHuThLOx6uM7uLPOroz7eoukJbmEiSy2MCdT
         XZ6tsPBIPad0idSsmBIT8Og9vvTQLyhrx+Jji9g4jJaUmpHOKS3bkiY2T2XrqnjzUP59
         l+KtWvDpwLZ52XCNGbp/CKq6qbUiJRJ8gDBvr1cPL2wNtseTSjymvzic5KRC1a5zYc1m
         5vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yB0Psip9qk9rxqyC1cNcG+jHEmt9ZmS/yY/eRaAVMjQ=;
        b=ZQ6DvsgzKRtq60xFKqtpP/41W0U+wTsnLE+2QMyndNiEK85zDLvaW41HYpy0v9Jtkq
         E7ywRR1XF9RFnL9/PvLEToWA4uFiL1TKU4EoLHJU/9EU5XIvpFlpJbsjXx/wkaAR8dNO
         Mi6MfHOHDQAlfBezBnPegukw6uS20YIzpiiMdVNCu0aQyKEmm/jchAdS9nLpg2VTbQ16
         H88lGYkNjf8GhUrFlRNQ9mqbzAUxUspRMwfIAdTvKUD9r6UctHCPRdVZichQdmeptSFE
         eThfMfyL0mIWOmhMCsDw8qa+BThdqFEZD77oBZ5fz9/8WozQQxBV/i2OudfvMJjNs/o+
         qKRg==
X-Gm-Message-State: AOAM531/XXA30k6SfJqNVRQNL5H0ctvjcYituoPsaVgrujXF8pAubp95
        XBa+yAg8wfacPunfRhR5Arp9EXm23u9BYNcBTbU=
X-Google-Smtp-Source: ABdhPJzhPTW0PYJ3RI6gt+nL87dP1epQzMzg0Go/K1OGkfu1X7Q1JXGf03Midn+XctLBpcRUDUA34gL/TmpvqrzgUis=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr3363455pjb.129.1595313541234;
 Mon, 20 Jul 2020 23:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200625220808.hac4egxalgn3pcqk@mobilestation>
 <CAHp75VfF3GhjNEgHaQWn+LqbVZVOn3_mORSompexxxRnmiAFcg@mail.gmail.com>
 <20200626132921.tygww3k6b74gq6pl@mobilestation> <20200720105155.GT3703480@smile.fi.intel.com>
 <20200720210206.x67j2t65pwixz5br@mobilestation>
In-Reply-To: <20200720210206.x67j2t65pwixz5br@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 09:38:44 +0300
Message-ID: <CAHp75VerS8xnVmFtUNLY7y-WHO636cz=RyR75VNF4sAN-sMW5w@mail.gmail.com>
Subject: Re: [RFC] spi: dw: Test the last revision of the DMA module
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jul 21, 2020 at 12:02 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Mon, Jul 20, 2020 at 01:51:55PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 26, 2020 at 04:29:21PM +0300, Serge Semin wrote:

...

> > > Anyway sorry for the inconvenience my patch caused. I'll send a fixup patch
> > > soon, which will get back the DW_SPI_DMATDLR setting with just "dws->txburst"
> >
>
> > Any news about a fix?
>
> Fix is in my repo. I was going to submit it together with the rest of the
> changes concerning the DMA noLLP problem after Vinod merges my DW DMAC patchset
> in. But as you can see for some reason he doesn't rush with that at all. If you
> need it I can submit the patch separately tomorrow.

Yes, please!

-- 
With Best Regards,
Andy Shevchenko

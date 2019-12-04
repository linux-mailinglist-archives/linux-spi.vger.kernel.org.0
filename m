Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82501123F2
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDH5n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 02:57:43 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45962 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDH5n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 02:57:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id v10so3948377oiv.12;
        Tue, 03 Dec 2019 23:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4LalYjsnfEaSEeb2Zehe/J93R0bKGaAEEsomnP7Lc4=;
        b=PRvqFkHg9bv4mpYaE8XKLbG5GEGz7O2LmBAOb0awr22hFcyxza1O0PDVjIJpdGdVHk
         d31/MqFt7uNNCkMexqygSi45B6yBlCTTN8VAWs8aQ8LbcklnBxASRl4esqhDjxVaxJIe
         QeU/SGP+0L9wqy5L77nm4gcZSSk1DPyn4ozhi+Yll0tK/lomRrPwwOeLm8LgUAY4yAOx
         jMD1BFVXNc7xqYEkLlGqh14jceyBAVx/n0hTDOvWaSAGZSQRXov0bIvVEHB4hkX4bPlW
         27yZSoJ6+f+MRkI/fsHwGb9eFrEPPkYY1+4LzUL1AtULQ0+jX4R0691fggYv+4ZMoiDx
         t8KA==
X-Gm-Message-State: APjAAAX8MT75CbnQsq+QicFbCqVwwfCeYx053cIbgIcVlv57jPrHZiVv
        nVwk1dlI4i7uFyi+/2AvQiVVgtDHL3TFK4azgClJAg==
X-Google-Smtp-Source: APXvYqzjyb4FJbVQHtyhh2tGF9RdLiHEpGR+02icu52LShy7lvntJoGkd+WARmtOCmx9JC+h7OytDime9XYsdUgzjLY=
X-Received: by 2002:aca:4e87:: with SMTP id c129mr1455643oib.153.1575446262417;
 Tue, 03 Dec 2019 23:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-6-chris.brandt@renesas.com> <CAMuHMdXS_dSEGdMzHFuYraP=dU5WQFM+9DbPW1rFYH2reG2QhA@mail.gmail.com>
 <TY1PR01MB1562E550DD31E799446F0FD48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562E550DD31E799446F0FD48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 08:57:31 +0100
Message-ID: <CAMuHMdVO2ud70cxVUHpCpvvZiMidHG1091bg3iOoOnFGOqpqWQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] ARM: dts: r7s9210: Add SPIBSC Device support
To:     Chris Brandt <Chris.Brandt@renesas.com>
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

On Tue, Dec 3, 2019 at 11:38 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > +                       reg = <0x1f800000 0x8c>, <0x20000000
> > > + 0x10000000 >;
> >
> > Any specific reason you're using 0x8c, not 0x100?
>
> Because....I keep forgetting what is the latest 'correct' size:
>   A. The exact size of the register range
> or
>   B. The size rounded up to look nicer

C. The size used by the on-chip address decoder providing the module's
   select signal? I doubt that's not a power of two ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

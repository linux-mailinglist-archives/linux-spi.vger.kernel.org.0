Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E70123743
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2019 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfLQU0r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Tue, 17 Dec 2019 15:26:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33184 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfLQU0r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Dec 2019 15:26:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so6575069otp.0;
        Tue, 17 Dec 2019 12:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f3gn/oPr6CxFsDIcXTI6Rn3BNMNX8Zy6VkrjtLwd+wI=;
        b=pV/IB7+bw1Wuym2T70mnEnQawUKEjDgF6GyaviKPb1UvNL7GPI2055MXp1f18PmHRG
         M8YDAuBGqScy3FSKJyWE7K8kUpIasuXAFVFRYH4PfqCOK9BvFxGMsGB5r85cxZx3fREc
         LOrZDGIDjEH3wGYr+20NUnMjfCvNKZ239axIly3HQ0QGnXXmw7yWdAuImen1VKPvutLq
         Jt2bTyUvBuFG/bPddVmKkZvi8Z8T/qKL2lBAYq7w7pZ7lEYN6rs+L02PC0b22QWL0Ovm
         tkDUxv5hKS2RNYVwikuJuxkLdmxIsgReUYSJtWd5tfNVFTDH5uO6dL2TW+0K7pGcaMJt
         6O9w==
X-Gm-Message-State: APjAAAUQIE2Jrcz7XxvHsxREGaY3b9YQNhUSFAJrHkiZ1YAD9Skqgntl
        mowaSVMxldJL5/jYGPySySQ/SSU33iz0HG3ct4M=
X-Google-Smtp-Source: APXvYqw4ewhq5K6U9XDjyTAdZX/UY2Fmz1YMPelz213yxmeZOuT6WiuiWSkZYJjY12spRU3p5UX/09gTIseqYiaY7o0=
X-Received: by 2002:a05:6830:18e2:: with SMTP id d2mr9920053otf.107.1576614406335;
 Tue, 17 Dec 2019 12:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com> <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com> <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com> <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
In-Reply-To: <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Dec 2019 21:26:35 +0100
Message-ID: <CAMuHMdUBEnM3SPkK4o8jSPnKMpcbx1EJs4p5PvhC1cGcWpqYAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Chris Brandt <Chris.Brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On Tue, Dec 17, 2019 at 8:30 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 12/17/2019 01:21 AM, Chris Brandt wrote:
> >>> As a side note, there is another HW block in Renesas that does the same
> >>> thing as the SPI-BSC that they use in the MCU devices. That one they
> >>
> >>    MCU?
> > Yup.
> >   But...it has no significance to this discussion though :)
>
>    But what does the acronym mean?

Микроконтро́ллер (англ. Micro Controller Unit, MCU)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

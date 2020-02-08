Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF92E1563A6
	for <lists+linux-spi@lfdr.de>; Sat,  8 Feb 2020 10:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgBHJhJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 8 Feb 2020 04:37:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35283 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgBHJhJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 8 Feb 2020 04:37:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so1743125otd.2;
        Sat, 08 Feb 2020 01:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5rJ2S6x3Li3urw2c5apAzgdC849J3cdRPfTG5d829aI=;
        b=tcdbu6hr89izleZN1Bg7imlFCVQ5ick9fmynJtu0wwzeis+3+0+R7VzIrT99NeVKkB
         j0Tvp+asUYQqIzR6fOadt64vpykQxFNspsZfD9KqShBtwss4vm52osVTcMTcl+WmGXz0
         oJoYO9E3gTuvCB1mCh3KDcCE3rzuSsHdmmXEeZZYkyeSVxNlvW4pcasGEgujCItABpxu
         GUW2eUHu+5rPi/L8qQiZBFaHrE1IoE/XLJVXumvx24mEbaYjrfgAST2MNcPJlz9a1lfC
         gfnQ11MOxwbuJjtgaWnzWljavs8zmrLDbcr6xwxhRqLJn4IxmJz7woyJJp3fDey7IHwg
         0O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5rJ2S6x3Li3urw2c5apAzgdC849J3cdRPfTG5d829aI=;
        b=Mr254kgIsMSZXMDT7unA4q2V0Wd8mf375HcTJywfp5Z7ZKHBFF0IaBzhuz4Q3p+mrw
         WEJDIIDnZzuDomKeoFADhor7QYCDp1NIRHXMUzw0b9jSNaPuHm1uz8ZBPy1xZphTzyj2
         POI+00UzD3FcY19l36haSKBDr7IDawgii6Buwk4yaaAvo24Y1kyaEB8RZ6GaYAoKep9t
         Ttljxp5cetSwKIor9UHAZAsDZsxTcQZGaecBjcDc47O0zmcPiNSSjm4jkMI2WTkjEq8z
         8hwfhW/kZPgSxi2zzw1vBE/rGGiUOFR3We1wNyvMHff38UiTKPCzGJDElxdvFZNv59Ot
         uSBA==
X-Gm-Message-State: APjAAAW2YKx6sretJT7niI+wKe1OhL4NsPMau4h/UNenBcs0XEgX072O
        j1UEDPdEjVgCtQcPD+bGmrPbi0VwycIXL3VxGPU=
X-Google-Smtp-Source: APXvYqxBlIEr7h40H0E21tzciM+gdFeVQAsg7X9G/3jnCKm8uAZQWU6EWwc85VXixcZ/mCa3lr/kkt9wifhJjT+u5t8=
X-Received: by 2002:a9d:3e43:: with SMTP id h3mr2736578otg.84.1581154629023;
 Sat, 08 Feb 2020 01:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20200206150626.708649-1-gch981213@gmail.com> <20200206150626.708649-3-gch981213@gmail.com>
 <20200206205551.GA15172@bogus> <CAJsYDVKXvAkQawwayX8JVrjvEKPuTyQXE8rw=BRiyVROKrdWrg@mail.gmail.com>
 <7f53a397-0237-4c68-e284-d92adf19c368@gmail.com>
In-Reply-To: <7f53a397-0237-4c68-e284-d92adf19c368@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 8 Feb 2020 17:36:57 +0800
Message-ID: <CAJsYDVJ3RfMh9MrMGsS=9=XayJjkatwnVa6DRjf6KmYp8JS9SQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-binding: spi: add bindings for spi-ar934x
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Feb 8, 2020 at 7:54 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 2/6/20 9:55 PM, Chuanhong Guo wrote:
> > It's caused by "clocks = <&pll ATH79_CLK_AHB>" where ATH79_CLK_AHB
> > isn't defined without a include of dt-bindings/clock/ath79-clk.h
> > I'll replace this with a bogus "clocks = <&spi_clock>" instead in v3.
>
> You can include ath79-clk.h in your example, see for instance
> Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml

Oh. But I've already sent v3 out yesterday :(

I think this is just cosmetic changes and doesn't make much difference
so I'd like to keep v3 as-is now and if there are other comments for
me to send a v4 I'll change this one as well.

Regards,
Chuanhong Guo

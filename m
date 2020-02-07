Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A0615522F
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2020 06:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgBGF4B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 00:56:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36503 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgBGF4B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Feb 2020 00:56:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id j20so1075869otq.3;
        Thu, 06 Feb 2020 21:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNqCMb+6h4mDmpo7PkQEAJD5G5WQFTN1ZybnlaretkM=;
        b=lnpaKhopowUy9WJU51IFT2Qyj/Li8tKyAWr1EmQyJ79vbJoKEtcstMGwTG6fC1zupI
         jKQ0CprnNVt8NXkDuLYcY0/vOMSWLKn0fRRbKfUwcuezFmAX1FlLDb/mIhdwd6uBAzbP
         ZpWYLpmemTfHlReLscC0i04meUAzisbaRED4QVOOfo7r+pZ/3Edn2SC5GbAkjYSO0I8m
         ivsR4HYnkDOrJzn6sU6Qafd/4SinuBIEuz+8Q2jVIw2x+93uAQ1dnFwlpuqGK3eOQYKq
         7xQ7g+2Hf/+UOj1jP/LaDjiyxaJwMyMAZMbVIVGpOK9WuIsbLgxIAhpAiVF75i6r1s5j
         vLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNqCMb+6h4mDmpo7PkQEAJD5G5WQFTN1ZybnlaretkM=;
        b=iDUozY5AzbmPUpm7INXz41XI2X68hkKX4Tf0WPY1ReevqIEeYnp4Z3qBcqciWgq4dQ
         uUTrwaigWKkb47Z7o6jNFubU9m+koHzDRA/yc7eyy5zPgCQKbpZ5IAKn4cvAXw8op4X5
         moeieqEZnfUUmSdVEIb2dkQ1SbvADw332ACej/BfVc/57XHGum/YJPzqyjilpzGWePWX
         2OgHVd+0+wy0jNrviwgKt8YzDslhXvv/qqwXjWx5yZ5v5rJhXEZkR6sUyXXMvdqcD5LN
         JzAgIO4nNsZBsEK6VE6Llh3eAjAuqz+OB26Wk5CB2xyOhZiFpOo70AqqVcyMkF7RAp4Y
         vJqQ==
X-Gm-Message-State: APjAAAWuMywRFt5ibTBHH99CmehO68ZFK63SYqXbLviCX044V2BKNO8d
        DnvkyW4AnN06qfMNSfyGUSZpQ60qXCuk40Z9+gk=
X-Google-Smtp-Source: APXvYqwzD5KFwcxS7dg0R98BSgS9GsIPoXAkhL2KBxUj0jdTvN15pvxBJkGZzklBEVCAyldxuKMoSctdORZp9XFTwk8=
X-Received: by 2002:a9d:4c92:: with SMTP id m18mr1409184otf.168.1581054960272;
 Thu, 06 Feb 2020 21:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20200206150626.708649-1-gch981213@gmail.com> <20200206150626.708649-3-gch981213@gmail.com>
 <20200206205551.GA15172@bogus>
In-Reply-To: <20200206205551.GA15172@bogus>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 7 Feb 2020 13:55:49 +0800
Message-ID: <CAJsYDVKXvAkQawwayX8JVrjvEKPuTyQXE8rw=BRiyVROKrdWrg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-binding: spi: add bindings for spi-ar934x
To:     Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 7, 2020 at 4:55 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu,  6 Feb 2020 23:06:26 +0800, Chuanhong Guo wrote:
> > Add binding documentation for SPI controller in Qualcomm Atheros
> > AR934x/QCA95xx SoCs.
> >
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > ---
> > Changes since v1: none
> >  .../bindings/spi/qca,ar934x-spi.yaml          | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> Error: Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dts:20.28-29 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1234394
> Please check and re-submit.

It's caused by "clocks = <&pll ATH79_CLK_AHB>" where ATH79_CLK_AHB
isn't defined without a include of dt-bindings/clock/ath79-clk.h
I'll replace this with a bogus "clocks = <&spi_clock>" instead in v3.

Regards,
Chuanhong Guo

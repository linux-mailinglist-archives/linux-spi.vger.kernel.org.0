Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC361B13F0
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDTSHH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 14:07:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33983 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgDTSHH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 14:07:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so2498345otu.1;
        Mon, 20 Apr 2020 11:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/F9lXiZp6WfOHeGu0sKn56dA0/QUwLyw11qUHlCornI=;
        b=MdGNbnTN/Q211xPaobcA39ym+sBkqMb5Z2fr8jiHyRGTKUTIcB2+sSSlGYMywUKgVv
         5OqLXxMhfw04PC2fkhpCPR+imvbQMXkkLQfgIKOZHXM8efMn77KSPGZznZkqC1XqTrCy
         o+YpN63XrrPq44XuqnuzFS601H5JVSxRKmYss4TdIwk8UMM1CJvm/c3bEfbSU2rZ0J5a
         jda+w8C9fGr1hLXJ0CtfmcMyHpbcA0iho9CTPbog9VmtVeq8zXw5txyr83KK5VFQIi14
         aUHlb+DNW4sDt1mvHaq0o6CetLbjgn6Y/xFIrOv0NKf+1uHck7KThZfC9Ci6c0qNebC9
         AVAw==
X-Gm-Message-State: AGi0PuaTlD34hobMlu94BfjmtbBYQP+hEsuZaVv/8G8ETzJ9hzC8Zvup
        L548KRVnJ2nDelldvFjquilQq8zfTWjTtLluja4=
X-Google-Smtp-Source: APiQypLplOG5Gnpz2Pq1DckcaMS6JXWQLeWdaCrJKaP4PXPjY/XqttAryur3vuOOYDJNPT9KP9N5rPqIrTIaU2eioV4=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr7689674otn.107.1587406026239;
 Mon, 20 Apr 2020 11:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200318001603.9650-1-olteanv@gmail.com> <20200318001603.9650-13-olteanv@gmail.com>
In-Reply-To: <20200318001603.9650-13-olteanv@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 20:06:54 +0200
Message-ID: <CAMuHMdUDYWNOOrAXrq1Lf5_GD84Z1rr4Co5buZS-GnJvGyN5yA@mail.gmail.com>
Subject: Re: [PATCH v5 12/12] arm64: dts: ls1028a-rdb: Add a spidev node for
 the mikroBUS
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, eha@deif.com,
        Angelo Dureghello <angelo@sysam.it>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, weic@nvidia.com,
        mhosny@nvidia.com, michael@walle.cc, peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vladimir,

On Wed, Mar 18, 2020 at 1:17 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> For debugging, it is useful to have access to the DSPI controller
> signals. On the reference design board, these are exported to either the
> mikroBUS1 or mikroBUS2 connector (according to the CPLD register
> BRDCFG3[SPI3]).
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -83,6 +83,20 @@
>         };
>  };
>
> +&dspi2 {
> +       bus-num = <2>;
> +       status = "okay";
> +
> +       /* mikroBUS1 */
> +       spidev@0 {

Please use generic node names, e.g. "dac@0".

> +               compatible = "rohm,dh2228fv";
> +               spi-max-frequency = <20000000>;
> +               fsl,spi-cs-sck-delay = <100>;
> +               fsl,spi-sck-cs-delay = <100>;
> +               reg = <0>;
> +       };
> +};
> +
>  &esdhc {
>         sd-uhs-sdr104;
>         sd-uhs-sdr50;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

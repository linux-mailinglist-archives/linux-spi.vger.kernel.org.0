Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0BF214
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2019 10:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfD3IdJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Apr 2019 04:33:09 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33551 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfD3IdJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Apr 2019 04:33:09 -0400
Received: by mail-vk1-f196.google.com with SMTP id x194so2923604vke.0;
        Tue, 30 Apr 2019 01:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UbtPc15q7GKjPaxpVvUWLOqg1VlSL3zdcDHBknplqUM=;
        b=KKF66LvB4hXLT/pNgPl7J03Aedbn8lzAfCc1BGXMSc1JuJmgtJKVmwbIxmyfRUWuRu
         qN/jKZBfH20DI73zPN/gPi6tvRscsLu3flzxpqpfvn+Re4ZqNlIJR4muOFqSPWYxTIoX
         +7LgXlarYAfAr7fcKAtl6/tR8Ym4YMDkbcDKBQwmjc0k89xgEbnABKZ9JE5VA0L3uUlx
         4zzopcMkgkYFYTM8K/nLa4G/4fRZ6lbDKeIkLMbgR0rILJLU/vjjtWYZKubr7Io0pwGB
         Vli5VNvmZrCvozlzuK+c+nHEgQ8sQcrqfTOmfiNAuThB/oJLM3/7LbbPTiERGUQkalfC
         eiWQ==
X-Gm-Message-State: APjAAAUS7Tks5VqVEvfF8TlLbm8i0ozNd8xgdMAvZF91KnlIGoXkdzY7
        ArMkY4SnXhWMnthqpOfb3C+RCbAd4knN+ZBDmdk=
X-Google-Smtp-Source: APXvYqwNJvA/cUF1NB0m6pyWsl9CyCvHUJUiwZKEfQfVXdBF7uE7d6duKg78DxzSZJkgPLe13xRctlVB0lkGA9a5OhY=
X-Received: by 2002:a1f:17cd:: with SMTP id 196mr219315vkx.83.1556613188159;
 Tue, 30 Apr 2019 01:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <1554969262-15028-20-git-send-email-cv-dong@jinso.co.jp> <20190415085333.91F9A1127B60@debutante.sirena.org.uk>
In-Reply-To: <20190415085333.91F9A1127B60@debutante.sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Apr 2019 10:32:56 +0200
Message-ID: <CAMuHMdXnZjND2f9dfrq=0+TuS3ZpAgmpAspBfbH-VvtsH=6TYg@mail.gmail.com>
Subject: Re: Applied "spi: sh-msiof: Document r8a77470 bindings" to the spi tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        =?UTF-8?B?44Kr44Kq44O744O044Kh44Oz44O744OJ44Oz?= 
        <cv-dong@jinso.co.jp>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Hoan Nguyen An <na-hoan@jinso.co.jp>,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Mon, Apr 15, 2019 at 10:53 AM Mark Brown <broonie@kernel.org> wrote:
> The patch
>
>    spi: sh-msiof: Document r8a77470 bindings
>
> has been applied to the spi tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From efc3d5b2e79bd5470fa4a333933867d7b934a3e6 Mon Sep 17 00:00:00 2001
> From: Cao Van Dong <cv-dong@jinso.co.jp>
> Date: Thu, 11 Apr 2019 16:54:21 +0900
> Subject: [PATCH] spi: sh-msiof: Document r8a77470 bindings
>
> Document SoC specific bindings for R-Car RZ/G1C(r8a77470) SoC.
>
> Signed-off-by: Cao Van Dong <cv-dong@jinso.co.jp>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Is their any specific reason this was dropped from spi/for-next again?
Upon closer look, the following seem to have been dropped as well, compared
to last week:

$ git cherry -v spi/for-next 96a9209ae8ebb4e8
+ 0e530e4eba5e9003af83c6afda833c64c7fcae08 spi: spi-mem: Fix build
error without CONFIG_SPI_MEM
+ d4a91044e241d8f87fb990b673549a7d2f9cacc4 spi: spi-mem: Make
spi_mem_default_supports_op() static inline
+ 2c54c4a640ed4dc9db03693641a1a651535f05f1 spi: pxa2xx: use a module
softdep for dw_dmac
+ bf0c999f7f0e8934c8db8261fb67a38770fffac2 spi: pxa2xx: fix SCR
(divisor) calculation
+ efc3d5b2e79bd5470fa4a333933867d7b934a3e6 spi: sh-msiof: Document
r8a77470 bindings
+ ac533755d3cb2db003785f9f770646295643bee1 spi: Remove one needless
transfer speed fall back case
+ 179f7949c0663f1923564acf0e626d459ea80047 spi: Remove warning in
spi_split_transfers_maxsize()
+ 8ed2e1a50e74a08adce3fe0207be1649b2b13a83 spi: Release spi_res after
finalizing message
+ 316e60af88bc81780a01c0f5b431affe0e679686 spi/trace: Cap buffer
contents at 64 bytes
+ 3f6e3f7843a6a1667ed890ca51a1388fc7bf3429 spi: tegra114: fix PIO transfer
+ 5127b4d69f96793dfabb602b133dc19d1aa36880 spi: pxa2xx: Add support
for Intel Comet Lake
+ bee5c20b7323a7af027d1b4ba538137b518ad232 dt-bindings: spi:
spi-mt65xx: add support for MT8516
+ 4b490710d4d24f95e95a07baac6f3f98bb94cf3b spi: expand mode support
+ ad1ac1fa0b24b40281eeccdc1d7b085e77639357 spi/spi-bcm2835: Split
transfers that exceed DLEN

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

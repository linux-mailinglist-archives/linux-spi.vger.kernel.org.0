Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53502E334E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 01:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgL1A2F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Dec 2020 19:28:05 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:44676 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgL1A2F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Dec 2020 19:28:05 -0500
Received: by mail-io1-f51.google.com with SMTP id z5so8063730iob.11;
        Sun, 27 Dec 2020 16:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUj3CGCHKtCpdQoflvCE/NwJPmKZRFWdSmUER5qp19k=;
        b=WKG8LcHVTd/phh3OqieBv6oIxsMNfLjKvKPpc4t1Lfc8tJRkKhtPNLORnD2BD8cvxg
         JkSI/1xV+0gnVECleVtkYMGFHEV+K3b7P7WcmGBtdFqMXUsYU8q1+9d4C7OPoNHVUszb
         UcGtlju5XeO477L5QuXKbIk91LLLbQnZHSFD6n30I13GUVJIEuQfaVv3nA88u6ob3NLX
         do275rrpQd5Ufkob93aGnpYEQxJMtPqz9vuHNu+RmJh40Q2F1wq80XprCwJVedCxqwxS
         Io2xMu8Cups/aYUjurciZ1DmY6SQf07GN42TihyTRCNy5cl+li6pN2rXTYrzf+Zz4Qu2
         efcQ==
X-Gm-Message-State: AOAM5306ZDGnN0uA4ODq4+ZQ5AvMahfRrVEjNunYdpw6oL5aMtrCWgWx
        l8W2SE4pEdS6frXuH36d7n5erH6J0otsKUF5GXs=
X-Google-Smtp-Source: ABdhPJwFQPG/W46SaNilgQevaI8GRY1Oz0hQxCz/CBKa2z2rQ5LL8DnXmFIK2jcoA79xHAHIObmaGjObNfn06BH3+MA=
X-Received: by 2002:a5e:db4b:: with SMTP id r11mr34714131iop.148.1609115244473;
 Sun, 27 Dec 2020 16:27:24 -0800 (PST)
MIME-Version: 1.0
References: <1608973923-8328-1-git-send-email-zhangqing@loongson.cn> <1608973923-8328-3-git-send-email-zhangqing@loongson.cn>
In-Reply-To: <1608973923-8328-3-git-send-email-zhangqing@loongson.cn>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 28 Dec 2020 08:27:12 +0800
Message-ID: <CAAhV-H4OR=BCcwU=RgYdKY2JdRgM7SVWO7Y5+dZtTpqt+yWwfA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Sat, Dec 26, 2020 at 5:16 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Add spi support.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>
> v2:
> - Add spi about pci device DT
>
> v3:
> - Remove spiflash node
>
> v4:
> - Remove useless compatible
>
> v5:
> - Remove num-chipselects
>
> ---
>  arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> index f99a7a1..dba717d 100644
> --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> @@ -405,6 +405,15 @@
>                                 interrupt-map-mask = <0 0 0 0>;
>                                 interrupt-map = <0 0 0 0 &pic 39 IRQ_TYPE_LEVEL_HIGH>;
>                         };
> +
> +                       spi@16,0 {
> +                               compatible = "pci0014,7a0b.0",
> +                                                  "pci0014,7a0b",
> +                                                  "pciclass088000",
> +                                                  "pciclass0880";
> +
> +                               reg = <0xb000 0x0 0x0 0x0 0x0>;
> +                       };
>                 };
>
>                 isa {
> --
> 2.1.0
>

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B72D4CDB
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgLIV3F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 16:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgLIV3F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 16:29:05 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED522C0613D6;
        Wed,  9 Dec 2020 13:28:24 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id i62so701268vkb.7;
        Wed, 09 Dec 2020 13:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Y8EdRxn8dSpFUJIAxU90D9R+cEmBFpkuR2dcS1QMOQ=;
        b=uBH77reQ5WSxZogdoGv9vsLQcBmmvl9zfLpdFq5vGV10KH1T1L6oKowHBtOm3Y/pgL
         7Yi2n+U8wcL4iUqmlFLAseOwQK9XJjsIQD75uYiT88bfq33rvY46LYdrSbvC/N0GsKO7
         TbnSe/qJUteYvvy1yP6mGWiI1QUfkobGgrwmDQ3oPGWvg6j94ke6hn5q29xdXLZJcV7U
         w9Hf1RsJ1OOvBy54iPPp5ffksrmebhADRdhrvZoOGjMcTSUvktgleCUHVjCDiNgpwpFf
         6Mf5QxS5oUFVqHwfjRtSU92E4qwe9o2wJ67PARiK+NWjeeyFJFYBsG6Jy4M1JlxjiNUS
         Q0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Y8EdRxn8dSpFUJIAxU90D9R+cEmBFpkuR2dcS1QMOQ=;
        b=MBPNAPXAOnGo+KKhqQyALi3fISIAP8XcgS7R0QjKhd8J0osSrRIdGZBkEqtEoiy9ed
         4IzrSiBuQasORioH9/u4SB2ZblePq4mttw5tTxpTLCvrpv2frUcn7F5cwkpi5GK3EARo
         0KuwFeljFapBOSAMMCQUvfQWY2xPhJMn/bWq+DK2l0RgibCxwsaqHiTOUzZ0xDYMAYXX
         +bOdxeABIhPyRkIT0WNSMx3tsLUXQJ6VxjN5u6l6u+/kLkILuhQqXWdG9qNwdZjNjLVZ
         aVs+6j2kg/VEYoJ2hCUEjOexlyBXo9mzgHS9FnMImeiXib7zeM0Bh5yOY/zghC2W2RrC
         m7aQ==
X-Gm-Message-State: AOAM532EC1uhV6K8cGIFemhWl+PDYwcdyi5T8y5zcAs9Bo3WT/3qrxXh
        o4c3T0I0LZrEEWFmL1jVuLIdi2rigzgz98XEjPI=
X-Google-Smtp-Source: ABdhPJxrniZdXByb0gLOCGHbVq+71ilItd9cTm3O5PBX588zWLWH/Ww7xnDvuAabQ5vtA4PQcLOab+DyuE6G8CDHVMA=
X-Received: by 2002:a1f:3a12:: with SMTP id h18mr4641949vka.23.1607549304008;
 Wed, 09 Dec 2020 13:28:24 -0800 (PST)
MIME-Version: 1.0
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
 <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com>
 <3FA1D050-3BD5-4A97-9D83-520CCF75D147@goldelico.com> <CAGngYiVL9M72hFRWnmT_8RRX9pUTSLsNuYz6mUo0Be4Vivk7Xw@mail.gmail.com>
 <20201209210133.44ab9c97@aktux> <09D41BD9-F6BA-4566-8151-ACB3B2274B52@goldelico.com>
In-Reply-To: <09D41BD9-F6BA-4566-8151-ACB3B2274B52@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 9 Dec 2020 16:28:12 -0500
Message-ID: <CAGngYiU3DptnURBH=xf0eO4ZtKMH1sd2qWQqfBNbDkXDpzwGeg@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and
 gpio descriptors
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 9, 2020 at 3:08 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> But I have tested with
>
> > spi->mode |= SPI_MODE_3;
>
> which should keep the mode intact. Right? That did not work either.
>

- make sure ("spi: fix client driver breakages when using GPIO descriptors")
  is in your tree
- your panel's CS is active-low, so 'spi-cs-high' should be removed from its
  devicetree entry. In accordance with the rules as explained in commit
  message of 6953c57ab172. Also in accordance with the table you posted
  in this patch.

When these two changes in place, your panel should work. I have tested this
by mirroring your setup on my board:

spi5-gpio {
       compatible = "spi-gpio";
       #address-cells = <0x1>;
       #size-cells = <0x0>;
       pinctrl-names = "default";
       pinctrl-0 = <&...>;

       sck-gpios = <&gpio... GPIO_ACTIVE_HIGH>;
       miso-gpios = <&gpio... GPIO_ACTIVE_HIGH>;
       mosi-gpios = <&gpio... GPIO_ACTIVE_HIGH>;
       cs-gpios = <&gpio... GPIO_ACTIVE_HIGH>;
       num-chipselects = <1>;

       ethernet-switch@0 { /* active low cs */
               compatible = "micrel,ksz8795";
               spi-max-frequency = <1000000>;
               reg = <0>;
       };
};

If this does not work for you, then what are we missing?

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B291D0976
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgEMHEm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 03:04:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43953 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgEMHEm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 03:04:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id i22so3966938oik.10;
        Wed, 13 May 2020 00:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMqsXTZkQsUYXsgUW5SNfqYNzeikt2R+rOYAkqTmE5k=;
        b=Qlo78ui8y08TBdBC1f87m+1ryXxVvJIB0Om7wNF+f5clbFdgRJkuZ+KV3ytof3yMzv
         pM02R0CKD0jZQOggg78PwzYCICqcG2pqnWlJxECulifzUnEt9l855gTMvHK8AU9y91ts
         /uQ9XkcsXgSYXTS2E0/JG62+VXh+H3y2256SXpcam2KItKvB51Ef8zoWWhXlmsWq6bgv
         RLKfQsNJ1wZv/aYbLb16oD9ElcNCyaUn1NW+mNoOSonhUUqa8QBQvjhGKC2E9s9WZHR2
         63gmIBtMFhzTCBuzEMmdiQyxcXTTohcGoM/8EZXUExFNtORXZDpi9p2ZZcQNWEyOb7LV
         pMKA==
X-Gm-Message-State: AGi0Puack8XJaENLTjvv1ed5B7u91qa0FqxGx8C9af530hSjD2PmLX0s
        uidHH4s9Gs0xSRIp3B+eG53NviECbNhbEtanQUiqrw==
X-Google-Smtp-Source: APiQypI2i3OcOk0fZSl5EaM/AtAYKVxaJffZ2UtQJdWMHY7G9eIbkNlIzli6zPVMpFnI38y49fid2zK+GkOq09gyGKs=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr3674965oig.148.1589353479660;
 Wed, 13 May 2020 00:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200512204543.22090-1-robh@kernel.org> <20200512204543.22090-5-robh@kernel.org>
In-Reply-To: <20200512204543.22090-5-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 May 2020 09:04:28 +0200
Message-ID: <CAMuHMdWoh94eFvVKHt5si3LOX4Nwx0-JssxVOy=fXPMXxgndXg@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: Fix incorrect 'reg' property sizes
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On Tue, May 12, 2020 at 10:46 PM Rob Herring <robh@kernel.org> wrote:
> The examples template is a 'simple-bus' with a size of 1 cell for
> #address-cells and #size-cells. The schema was only checking the entries
> had between 2 and 4 cells which really only errors on I2C or SPI type
> devices with a single cell.
>
> The easiest fix in most cases is to change the 'reg' property to for 1 cell
> address and size. In some cases with child devices having 2 cells, that
> doesn't make sense so a bus node is needed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

>  .../devicetree/bindings/arm/renesas,prr.yaml  |  2 +-
>  .../bindings/display/renesas,cmm.yaml         |  2 +-
>  .../interrupt-controller/renesas,irqc.yaml    |  2 +-
>  .../bindings/media/renesas,csi2.yaml          |  2 +-
>  .../bindings/media/renesas,vin.yaml           |  6 +-
>  .../bindings/net/renesas,ether.yaml           |  2 +-
>  .../bindings/pwm/renesas,pwm-rcar.yaml        |  2 +-
>  .../bindings/spi/renesas,sh-msiof.yaml        |  2 +-
>  .../bindings/thermal/rcar-thermal.yaml        |  6 +-
>  .../bindings/usb/renesas,usb3-peri.yaml       |  2 +-
>  .../bindings/usb/renesas,usbhs.yaml           |  2 +-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

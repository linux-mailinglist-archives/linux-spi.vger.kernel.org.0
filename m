Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3518D172366
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 17:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgB0Q31 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 11:29:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36355 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgB0Q31 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 11:29:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so3912261oic.3;
        Thu, 27 Feb 2020 08:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jXudNkkQRrHswSQ0SFgmC83sC0Xe1CS0lzGEyLon8c=;
        b=lCC5GCvaMgW3wpjAcAY2H7qtL6GeE21GSR4n+fs4YSoshmDzJ413dxuScHKoxqij9v
         DJc9LQ961RdriFlF36ko9/UL1fQBd53MSuXcYDp8o0nd1lovnuNdYjOzjXRtUCP4Y1jc
         G1o0x23A/RhfYptXy/AB2dcd3RWoUieniJNpj9WnUCePw6ZNhC85UTX6FeX7dLB6Lw+L
         R4ITxUICPeb019QZixauOpd+0UcmWk+4QKe+NJTtjIy2iLsduLuX7TLfiz13owtziRti
         wZt3VnaG03as4aC6ID/er2lq8Zx6Y98kL/PqdMQfJO4DAWqcG63X5+D+7oazFSMkmP/s
         R5VQ==
X-Gm-Message-State: APjAAAUmQPYnxuPJnWdy/DuWiTJNZKjsYPHkKjQ1eHBuBdU/eMQCiqbk
        NyKjjeVhy2OVSDDGHMat7b/snV1k5gJMcQlGjlo=
X-Google-Smtp-Source: APXvYqyUfhYfCXxfIpygMIWcy0cqjpe0cJtNKxAMEU7HwDavOmFyIh2NtpJAG7ozbOpNRe59proDJcrYJm8sEB1JY1g=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr3859856oia.148.1582820966275;
 Thu, 27 Feb 2020 08:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20200226093703.19765-1-p.yadav@ti.com> <20200226093703.19765-2-p.yadav@ti.com>
In-Reply-To: <20200226093703.19765-2-p.yadav@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 17:29:15 +0100
Message-ID: <CAMuHMdUGN8Yu6Tx0=OoLKzyOZ08fvjF6pEWi3ye02pr3Cgj=cg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush,

On Wed, Feb 26, 2020 at 10:37 AM Pratyush Yadav <p.yadav@ti.com> wrote:
> Allow spi devices to express DTR receive and transmit capabilities via
> the properties "spi-rx-dtr" and "spi-tx-dtr".
>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -120,6 +120,11 @@ patternProperties:
>          description:
>            Delay, in microseconds, after a read transfer.
>
> +      spi-rx-dtr:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Device supports receiving in DTR mode.

Please explain "DTR" in the document, at least once, e.g.

    Double Transfer Rate (DTR).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

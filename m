Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7331D7E64D2
	for <lists+linux-spi@lfdr.de>; Thu,  9 Nov 2023 08:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjKIH5N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 9 Nov 2023 02:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjKIH5N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Nov 2023 02:57:13 -0500
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DDF2712;
        Wed,  8 Nov 2023 23:57:10 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a84204e7aeso7438897b3.0;
        Wed, 08 Nov 2023 23:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699516630; x=1700121430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b28VPbp8gB3rXtgafI6M110iwvDhv/DLhKESOoHQijM=;
        b=cUnYD72c3LSlq7aKD1CSqx4Vgvx3BFpJscLvXCIR72srdTpsrYQq71l05Ct2yjd6sp
         PEU4uDkmdbNJN6MSEdewyLTIJPKaExRlTYc1Iii/47OnF/xzgWeQm6Bo+zO42PHA6Y1d
         wgMqWZ+w3rva4CXSlPc/JHD0Yc2Pq8swPg5DdVd9s0Y+IG8xkPHTzeK3UqRzegkkRV+e
         n2+hXqAiBbgBCBp+VniALFXolC3SjnBbB5i9tqlqtmo4q/4WEmkOqiuBZa8JtctS6H/b
         XKoNeVACjIIJFkXAImjuhmxn2OnemC70UGWXxndgPpKcUACS7A6ZiLvqJ9qRMtfjNbyN
         uGBg==
X-Gm-Message-State: AOJu0Yx2O28EFLlLaGxdwvEhQ1odg0cZ6I4HZqv26Yt5+lWrgjoQvhPV
        huV5YD04GhSX2rygvnB6BB9vwEUCqYPWZQ==
X-Google-Smtp-Source: AGHT+IEDko6/mRdN7OR+50u/xnE67stOpkHlHWy+FLhYSWnAXZ6/PfmYxEi7JzyQ7gSZykL204WFzw==
X-Received: by 2002:a0d:df85:0:b0:5af:b0ca:6950 with SMTP id i127-20020a0ddf85000000b005afb0ca6950mr4441873ywe.42.1699516629909;
        Wed, 08 Nov 2023 23:57:09 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id r190-20020a0dcfc7000000b005a7aef2c1c3sm7837382ywd.132.2023.11.08.23.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 23:57:09 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a84204e7aeso7438687b3.0;
        Wed, 08 Nov 2023 23:57:09 -0800 (PST)
X-Received: by 2002:a81:84cc:0:b0:5a7:fa8b:3fa6 with SMTP id
 u195-20020a8184cc000000b005a7fa8b3fa6mr4343779ywf.9.1699516629341; Wed, 08
 Nov 2023 23:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20231108171149.258656-1-biju.das.jz@bp.renesas.com> <20231108171149.258656-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20231108171149.258656-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Nov 2023 08:56:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdzbtR+ruXwfS1a74rnH494kMsFvaT9MTz7cW-LFpB1A@mail.gmail.com>
Message-ID: <CAMuHMdXdzbtR+ruXwfS1a74rnH494kMsFvaT9MTz7cW-LFpB1A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] spi: spi-mem: Add set_iofv() callback
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Biju Das <biju.das.au@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

On Wed, Nov 8, 2023 at 6:12 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> As per section 8.14 on the AT25QL128A hardware manual,
> IO0..IO3 must be set to Hi-Z state for this flash for fast read quad IO.
> Snippet from HW manual section 8.14:
> The upper nibble of the Mode(M7-4) controls the length of the next FAST
> Read Quad IO instruction through the inclusion or exclusion of the first
> byte instruction code. The lower nibble bits of the Mode(M3-0) are don't
> care. However, the IO pins must be high-impedance before the falling edge
> of the first data out clock.
>
> Add set_iofv() callback for configuring IO fixed values to control the
> pin state.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -297,6 +297,26 @@ static void spi_mem_access_end(struct spi_mem *mem)
>                 pm_runtime_put(ctlr->dev.parent);
>  }
>
> +/**
> + * spi_mem_set_iofv() - Set IO fixed values to control the pin state
> + * @mem: the SPI memory
> + * @val: the IO fixed values

Please document the meaning of this value (i.e. what does a
set or cleared bit mean?).

> + *
> + * Set IO fixed values to control the pin state.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int spi_mem_set_iofv(struct spi_mem *mem, u32 val)
> +{
> +       struct spi_controller *ctlr = mem->spi->controller;
> +
> +       if (ctlr->mem_ops && ctlr->mem_ops->set_iofv)
> +               return ctlr->mem_ops->set_iofv(mem, val);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_mem_set_iofv);
> +
>  /**
>   * spi_mem_exec_op() - Execute a memory operation
>   * @mem: the SPI memory

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

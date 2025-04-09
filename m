Return-Path: <linux-spi+bounces-7478-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D409A81E46
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB141BA429B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE825A2BB;
	Wed,  9 Apr 2025 07:28:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D46255243;
	Wed,  9 Apr 2025 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183701; cv=none; b=hmQXKmWw2+wVn48CoJc5JYLCmH7j2X9uCrMQ8YunNZrtoB2NImCACnaidEEX8JSOlyW958u/fYqw3qF3UIo1Nvh+ID2SPaiomO5MmOT7JZJPdA5f5n5yh2nYW19+hxD3uzhYBgHQjxYI/hMVlmgtlZxOhLxcnyBlENDPx1KbULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183701; c=relaxed/simple;
	bh=omjg1QZNMZX6pt77mJY7Zf7tfINEJaXxUhBVEE1wU8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqwleXdXAb/Oe64JjYa5GIj4dlt19o5/vcwzLd99XJ0zfwRhpYCNReDgKXWpEjHsCqnCjJxT79I4FiWSxNI4oy26hbaz5wkIeXrHzdYpwTOBqEnyuEo8AhqWJbGANeJTaRhpj95Lgluy5ahWm0sLXo6ZT38aJGx6maULlQdxcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d30787263so2980594241.1;
        Wed, 09 Apr 2025 00:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744183697; x=1744788497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xKhtWkjRki+22a5BdMEJ8YGRjcRum9CAdDpeBc10tY=;
        b=D3yIKdOtkYZBpauxzQHgEpz8e0yduFOt/NK5W7tsEiSJP1JpVMaUxHQeCTrtw50SeQ
         ZsrpShuP/vGFRP/YjGGRcp4XNjA+jKdNxevGgoBdQ+jvPqOvUVfLuW5t70TdxUkZDfEk
         lPrljzjPs6CFzBAtuSWA7lCfiFvlN8yiNjx8D1E/Dkdopp93G4xQGDaIsi6Gef7qIhcQ
         9kyRpzGZEJn2MvzXNeBGM5gQ+7u0O7F1f/Ht+BowaAfi8SZEgWWuPHxQ7klaxP1M/nhF
         Mijl10n6sOkU9kuk9lDwvcEUtKxRUml0wD+arO3F/OLxLGueZKMRBkkmq7qAVpG796dd
         28rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8O69UmoJsKaOIDKiePikNj9qtKaeywaTcpk4qlKfhxP/HEHfzjPlyXgkZpDBRXEwWWg3cHfp32eSgJgs=@vger.kernel.org, AJvYcCUfLHTlRhww3uBqXce+dbDcVq8Ula/YvhwlnLX5d+5MScpOOKCyzMrs7E7eEwp3/LkcjMCY2gQKaYtl@vger.kernel.org, AJvYcCV1WSUxHcDZjGJ1FoS13GaGTEHwvMIoHbLnmf1/C7dCbfoMkOF3wbH9yLoSerffttivKTW09xXig9e6@vger.kernel.org, AJvYcCXhSvanja0IhiOF/R2c0tSrNrj3XU5fVozlEYodOtBYYqwP2QRYvRDkjxg3vROZHC841lx84aWTNgQccl64lkysa7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CQNCJSpcdMJmeo5TS8nQMmQz4op569Suhy7xANyU5X4ams3N
	h0pcH4wD3hsJFljohy3p43ncegqkLfAJW+uK7OSjNkvEQTBktegyl4s9DpUn
X-Gm-Gg: ASbGnctsArS20UW6n168PZhcDunu4xlY4R1jGdb2APaBudMBZikSXzrBJ6dKZiQlgUD
	26LcNHwbsOoi3dUZKf/poCT82g2U+CKhODQA2PkW/xTK9BSDdatnVC9D4y7WaW3sYvRkPwfeeOb
	DxW+oviS7o061YT7HdTaCkG1Tz9238WFqve5J0F1eVwhx/WmXg67r8Pngo04ebmrYc8QAkwqHQg
	e13tzt1OECsWZJnd+tI6wsfUv9TriivJfwcDNi06oNr7axx7x4jxUij9yui9LU/vHCnHgNETuZT
	7pFMkNOml38MKmj6V8LbgagNNp5q/tnNvpf5l9UgQ4ZBfvq2qvpSgLwjEE+sNrWqslft7F045dj
	bTHI=
X-Google-Smtp-Source: AGHT+IEyBYBm6ITisH0j9oLAu8nvScfrSd4bNVyko/uz7ptMrE8sejkvRvZ7Wz0hmBIXIUc5Y5W2Jw==
X-Received: by 2002:a05:6102:5108:b0:4c3:49b:8f78 with SMTP id ada2fe7eead31-4c9c6ba2371mr541026137.25.1744183697095;
        Wed, 09 Apr 2025 00:28:17 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c95c5b52sm85350137.0.2025.04.09.00.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:28:16 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86715793b1fso2750554241.0;
        Wed, 09 Apr 2025 00:28:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+EhRWkV97TQM9FMKcgqzSbBxp1pljB3TDW33wsdLJO3xyN3SnvN+OGS6dmuPYjObtZwTyRO9Ye6qT@vger.kernel.org, AJvYcCW+FSNFnUpsSoUkZRcknXPUwgQ9Jsg/XOijdpWys4zH2LVq0PcbifccXEABWcqDjpLKOvv5xwZdndtK5GffK3IXVNA=@vger.kernel.org, AJvYcCWf9I3N6WR0VaoDMO+2fMz/y6nOPg3evYFngb9tB0JlKvuKBxWZJUhJ7NYT9Dxih+F5BSdEy5O+/4pp@vger.kernel.org, AJvYcCX7ddkaiizfFCkrPQNwfrFCcXvND1qo2mMlZLlUOF0bblfz60NbJnpkMCuk4hhUT9qb5ZhbgNWtMmsKlYI=@vger.kernel.org
X-Received: by 2002:a05:6102:5799:b0:4b9:bd00:454b with SMTP id
 ada2fe7eead31-4c9c6ad06d6mr532823137.13.1744183696313; Wed, 09 Apr 2025
 00:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com> <87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wmbu9may.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Apr 2025 09:28:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
X-Gm-Features: ATxdqUFiAzMvlcHccc0z_eHtfMsPKfLXgF1OYzWgU_5mlJsdigoIZrjyH5mpIqA
Message-ID: <CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Wed, 9 Apr 2025 at 03:05, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> both SPI and I2S. Adds MSIOF-I2S driver.
>
> MSIOF-SPI/I2S are using same DT compatible properties.
> MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> MSIOF-SPI doesn't use  Of-Graph.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/sound/soc/renesas/Kconfig
> +++ b/sound/soc/renesas/Kconfig
> @@ -46,6 +46,13 @@ config SND_SOC_RCAR
>         help
>           This option enables R-Car SRU/SCU/SSIU/SSI sound support
>
> +config SND_SOC_MSIOF
> +       tristate "R-Car series MSIOF support"
> +       depends on OF

depends on ARCH_RENESAS || COMPILE_TEST

> +       select SND_DMAENGINE_PCM
> +       help
> +         This option enables R-Car MSIOF sound support
> +
>  config SND_SOC_RZ
>         tristate "RZ/G2L series SSIF-2 support"
>         depends on ARCH_RZG2L || COMPILE_TEST
> diff --git a/sound/soc/renesas/rcar/Makefile b/sound/soc/renesas/rcar/Makefile
> index 45eb875a912a..3a2c875595bd 100644
> --- a/sound/soc/renesas/rcar/Makefile
> +++ b/sound/soc/renesas/rcar/Makefile
> @@ -1,3 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  snd-soc-rcar-y         := core.o gen.o dma.o adg.o ssi.o ssiu.o src.o ctu.o mix.o dvc.o cmd.o debugfs.o
>  obj-$(CONFIG_SND_SOC_RCAR)     += snd-soc-rcar.o
> +
> +snd-soc-msiof-y                        := msiof.o
> +obj-$(CONFIG_SND_SOC_MSIOF)    += snd-soc-msiof.o
> diff --git a/sound/soc/renesas/rcar/msiof.c b/sound/soc/renesas/rcar/msiof.c
> new file mode 100644
> index 000000000000..de8de3468402
> --- /dev/null
> +++ b/sound/soc/renesas/rcar/msiof.c
> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Renesas R-Car MSIOF (Clock-Synchronized Serial Interface with FIFO) I2S driver
> +//
> +// Copyright (C) 2025 Renesas Solutions Corp.
> +// Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +//
> +
> +/*
> + * [NOTE]
> + *
> + * This driver doesn't support Clock/Frame Provider Mode
> + *
> + * Basically MSIOF is created for SPI, but we can use it as I2S (Sound). Because of it, when we use
> + * it as I2S (Sound) with Provider Mode, we need to send dummy TX data even though it is used for
> + * RX. Because SPI HW needs TX Clock/Frame output for RX purpose also. It makes driver code complex.
> + *
> + * And when we use MSIOF (Sound) as Provider Mode, the clock source is [MSO clock] (= 133.33MHz)
> + * SoC internal clock. It is not for 48kHz/44.1kHz base clock. Thus the output/input will not be
> + * accurate sound.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <sound/dmaengine_pcm.h>
> +#include <sound/soc.h>
> +
> +/* register */
> +#define SITMDR1                0x00
> +#define SITMDR2                0x04
> +#define SITMDR3                0x08
> +#define SIRMDR1                0x10
> +#define SIRMDR2                0x14
> +#define SIRMDR3                0x18
> +#define SITSCR         0x20
> +#define SICTR          0x28
> +#define SIFCTR         0x30
> +#define SISTR          0x40
> +#define SIIER          0x44
> +#define SITFDR         0x50
> +#define SIRFDR         0x60

[...]

Perhaps the register definitions can be shared with spi-sh-msiof.c,
by extracting them into a shared header file?

Note that I have already converted drivers/spi/spi-sh-msiof.c locally
to use FIELD_PREP() (which requires changes to some macros), so we
may want to implement the sharing later.

> +static int msiof_hw_start(struct snd_soc_component *component,
> +                         struct snd_pcm_substream *substream, int cmd)
> +{
> +       struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       int is_play = msiof_is_play(substream);
> +       int width = snd_pcm_format_width(runtime->format);
> +       u32 val;
> +
> +       /*
> +        * see
> +        *      Datasheet 109.3.6 [Transmit and Receive Procedures]
> +        *
> +        *      TX: Fig 109.14  - Fig 109.23
> +        *      RX: Fig 109.15
> +        */
> +
> +       /* reset errors */
> +       priv->err_syc[substream->stream] =
> +       priv->err_ovf[substream->stream] =
> +       priv->err_udf[substream->stream] = 0;
> +
> +       /* SITMDRx */
> +       if (is_play) {
> +               val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
> +               if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
> +                       val |= DTDL_1;
> +
> +               msiof_write(priv, SITMDR1, val);
> +
> +               val = BITLEN1(width);
> +               msiof_write(priv, SITMDR2, val | GRP);
> +               msiof_write(priv, SITMDR3, val);
> +

Don't you have to initialize SITMDR[123] unconditionally, as reception
requires transmitting dummy data on R-Car (cfr. SPI_CONTROLLER_MUST_TX)?

> +       }
> +       /* SIRMDRx */
> +       else {
> +               val = SYNCMD_LR | SYNCAC;
> +               if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
> +                       val |= DTDL_1;
> +
> +               msiof_write(priv, SIRMDR1, val);
> +
> +               val = BITLEN1(width);
> +               msiof_write(priv, SIRMDR2, val | GRP);
> +               msiof_write(priv, SIRMDR3, val);
> +       }
> +
> +       /* SIIER */
> +       if (is_play)
> +               val = TDREQE | TDMAE | SISTR_ERR_TX;
> +       else
> +               val = RDREQE | RDMAE | SISTR_ERR_RX;

Likewise for transmit control flags.

> +       msiof_update(priv, SIIER, val, val);
> +
> +       /* SICTR */
> +       if (is_play)
> +               val = TXE | TEDG;
> +       else
> +               val = RXE | REDG;

Likewise,

> +       msiof_update_and_wait(priv, SICTR, val, val, val);
> +
> +       msiof_status_clear(priv);
> +
> +       /* Start DMAC */
> +       snd_dmaengine_pcm_trigger(substream, cmd);
> +
> +       return 0;
> +}
> +
> +static int msiof_hw_stop(struct snd_soc_component *component,
> +                        struct snd_pcm_substream *substream, int cmd)
> +{
> +       struct msiof_priv *priv = snd_soc_component_get_drvdata(component);
> +       struct device *dev = component->dev;
> +       int is_play = msiof_is_play(substream);
> +       u32 val;
> +
> +       /* SIIER */
> +       if (is_play)
> +               val = TDREQE | TDMAE | SISTR_ERR_TX;
> +       else
> +               val = RDREQE | RDMAE | SISTR_ERR_RX;

Likewise.

> +       msiof_update(priv, SIIER, val, 0);
> +
> +       /* Stop DMAC */
> +       snd_dmaengine_pcm_trigger(substream, cmd);
> +
> +       /* SICTR */
> +       if (is_play)
> +               val = TXE;
> +       else
> +               val = RXE;

Likewise.

> +       msiof_update_and_wait(priv, SICTR, val, 0, 0);
> +
> +       /* indicate error status if exist */
> +       if (priv->err_syc[substream->stream] ||
> +           priv->err_ovf[substream->stream] ||
> +           priv->err_udf[substream->stream])
> +               dev_warn(dev, "FSERR(%s) = %d, FOVF = %d, FUDF = %d\n",
> +                        snd_pcm_direction_name(substream->stream),
> +                        priv->err_syc[substream->stream],
> +                        priv->err_ovf[substream->stream],
> +                        priv->err_udf[substream->stream]);
> +
> +       return 0;
> +}

> +static int msiof_probe(struct platform_device *pdev)
> +{
> +       struct msiof_priv *priv;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       struct device_node *port;
> +       int irq, ret;
> +
> +       /* Check MSIOF as Sound mode or SPI mode */
> +       port = of_graph_get_next_port(dev->of_node, NULL);
> +       if (!port)
> +               return -ENODEV;
> +       of_node_put(port);

Just wondering: don't you need to use port? Or is that handled
elsewhere, in common sound code?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


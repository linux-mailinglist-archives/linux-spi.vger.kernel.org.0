Return-Path: <linux-spi+bounces-7477-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32BBA81DFA
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 09:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94904A2653
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 07:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2635E25486E;
	Wed,  9 Apr 2025 07:10:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FE250C1C;
	Wed,  9 Apr 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182602; cv=none; b=X99ZFMIuPEPKi1u3ybWZlQ2j/idoKz2+JrZq1PyXJWBjWyekb900GsDqgC6j5CVttQ5Nw7XbCqliQWmd9rD4vPMKFES/2pBAnVYP9XAaon1LfImUAjORkfUMc7wov3SIy53Fzs9wXORtxG7dOrbXkOv2hwCBQD+AHVs0ExVF754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182602; c=relaxed/simple;
	bh=xzWFr6RQHobZVkQEtYfHxByEWAH6rqCQhtdNhto6g3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DP8qSKbVZo3PKJ2z81s06uZ8U+p1W6dZqpbBtZ59zCeqEOWnOaY3GqbxBGCIZaH3COGyAIFVbDrwOZklzGjLrX8mYrCeByPFZp+3pm6anG/NpY1QYlj7ZYw4vh1YvfNKafGokHCHED1JERpqLQNHDuyL21ieacUMT33MMadJbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523fa0df55dso460159e0c.1;
        Wed, 09 Apr 2025 00:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182597; x=1744787397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCjOEqHOQd0uUlE94eC4JCNmgohT3221wsRkdKFRNL0=;
        b=T6p2A/lJ7E1kBBdAJPG2uevhPIwdzRouqfDqkEWLqS6s60Sz/YYtCB8ZF5jp9Jf7Ec
         2EPUz1LJDTcpztSh/AxOw4SWG/azA4rGz/yl8k/+ZfTYI3fO5V9Zx/8nCvyreUoHwxjK
         ANTZo8iGDi2pZgwH3mixBwVqiTPyK9p7xDo66UXQPG4+ZNP4PD/E0hfzk6CL4asZ6lDj
         lyODNqNDhhBXqJnjqSwqb5W+ErUyra8jdS4sW7JnggjeoG216pcb/knpCmyxDRu0UG5S
         KQKLUAkaSJwDt/wazsYA429pNZ3P2NQSqR1ggt7m9AjQgvLOzj/sTo/QrDOgQ8P5Fx9L
         R0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhlgjra0GC+Oo4wV+N6qLZnfC0bmKJTDC0Gg4G6pXE7XZDXiOpKqBgv6/wy1AG1C+fhWL9nuE+de1ieZE=@vger.kernel.org, AJvYcCW69UzTvzKJUGilTY9ej0RwttfDRHLq4B/4FtzYedyqbf99eBKXNBLjovSrGD6TdTn2ksx5Wv+AiYfB@vger.kernel.org, AJvYcCWvgiUFgeTAbz4+wvcfh1pmoCQ6kAbsME0InT9tnoH0wGUltRS9GZuoYnSgU33ehxsbPyFr6LarC5GrSscY0Wr7KDo=@vger.kernel.org, AJvYcCXTZFlqOzApk+22MD/AeQ93EXrclpUjKXgvRXiXwBPrYaYBEMUazhkmtWf7+S9oR/ZM6DY5+CEJ04Ho@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZDPnzpiJSMc9+Bj7BBZdFHK2l0M2oNdUwOWwRb/CGBHhzXTz
	NQr//vf3p298CNvWhBE5g6iANcpGu4icL0vvJCEkk1/j+26mmeH7MIsBwzG5
X-Gm-Gg: ASbGncsw9w42O3ULLd+u00XlN4y8VZCGKigXLC4hX9T3ufCVi+lQdu52ctgWhz/unRJ
	gZ6wARywZtrP7EM93sGWaer9a7KNySrY+R4ohdPbF97GskfmWAEDMVV2w+x9Gi4KI++kLGl+LOQ
	Mdh/dUQrd7Y7MORREnvuvgpyNmCiF0LbA/LMnhZKnue1uMzRpLCSP1yNSgrzV+XQP5tKh2IWabB
	eJOIrnExbPbNxY+JY6UNyDN0nnJnjh3QCpZEiTkBId2IC7fn+TY8PDHOFL1Hz/zvmzJhCWFrVY1
	l3VxeJZxqrNY0jtWL0cjWiFSSCSJhQTn0ZjtrpklAhI5lyXn1IQ/IhMCZHweiPSg5Mer/cacfk4
	r0Vc=
X-Google-Smtp-Source: AGHT+IHW53vWYq7TSmVYcH2oen8xtBomvJnp8hJWeYmuq3YtIHbILAvG0/tpLwkUXwiUfIhOigD6lw==
X-Received: by 2002:a05:6122:319d:b0:520:4806:a422 with SMTP id 71dfb90a1353d-527a8e901cdmr1233546e0c.3.1744182597091;
        Wed, 09 Apr 2025 00:09:57 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d1b9sm111727e0c.31.2025.04.09.00.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:09:56 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso488879241.0;
        Wed, 09 Apr 2025 00:09:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0pG/UUhJU8/Kb96HPdC6LOpIyomTnDUVpTiSxYwmrtIt0euHyTxgoE0TwPe2XbKpk3DWiT3Q9gV9Ud/wfiU5832I=@vger.kernel.org, AJvYcCUF5Lux6hvCAKowMx2I3P3Nj/EEeXgbkhfB39yT/jtn+F4Ybv7J1yAsYqtbW3lKlp0kkuo1bZ5rQFKBi2g=@vger.kernel.org, AJvYcCV65GjYU8gYiLOyqodb1rJ6z6AYtqdWIUtYwWPL6kPRnCmOToYF+PzZXU6oxNfv1N/H6V7mJuplIph2@vger.kernel.org, AJvYcCXV9zrvkQB431jFrX2RKXz9tbtyTax0Eu9mJ8xixD7Uq4dh5ZoJ5+tnZDPeKrXp6k29gr81gm28f+Y0@vger.kernel.org
X-Received: by 2002:a05:6102:5794:b0:4c2:ff6c:6043 with SMTP id
 ada2fe7eead31-4c9b368e974mr5084603137.0.1744182596209; Wed, 09 Apr 2025
 00:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com> <8734eib0vx.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8734eib0vx.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Apr 2025 09:09:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVC997SufjabEtwx9ZLZrzYRmWpCEXxHh9r8Rtee=QYpg@mail.gmail.com>
X-Gm-Features: ATxdqUG3_OX2HcrfXwIG-FjpUcpmP4Wv0CKo6s-O57I2uDAn7kfrkEinNrI4qAo
Message-ID: <CAMuHMdVC997SufjabEtwx9ZLZrzYRmWpCEXxHh9r8Rtee=QYpg@mail.gmail.com>
Subject: Re: [PATCH 2/7] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
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
> both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> Of-Graph in DT.
>
> MSIOF-SPI/I2S are using same DT compatible properties.
> MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> MSIOF-SPI doesn't use  Of-Graph.
>
> Check "port" node when driver probing
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Still, some comment below

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -20,6 +20,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/sh_dma.h>
> @@ -1276,10 +1277,19 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>         const struct sh_msiof_chipdata *chipdata;
>         struct sh_msiof_spi_info *info;
>         struct sh_msiof_spi_priv *p;
> +       struct device_node *port;

If you would add "__free(device_node)", you could drop the of_node_put()
below.

>         unsigned long clksrc;
>         int i;
>         int ret;
>
> +       /* Check whether MSIOF is used as I2S mode or SPI mode by checking "port" node */
> +       port = of_graph_get_next_port(pdev->dev.of_node, NULL);

This is actually checking for both "ports" and "port".  If you know the
subnode is called "port", you could simplify to of_get_child_by_name().

> +       if (port) {
> +               /* It was MSIOF-I2S */
> +               of_node_put(port);
> +               return -ENODEV;
> +       }
> +
>         chipdata = of_device_get_match_data(&pdev->dev);
>         if (chipdata) {
>                 info = sh_msiof_spi_parse_dt(&pdev->dev);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


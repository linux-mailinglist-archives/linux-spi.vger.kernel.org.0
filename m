Return-Path: <linux-spi+bounces-6776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FBCA32647
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 13:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356ED1886327
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27252209696;
	Wed, 12 Feb 2025 12:51:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD61E87B;
	Wed, 12 Feb 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364681; cv=none; b=T4H/bEdMQgLjiXwv4X1h77emZ5qeVHfxrXB9DKDCnwhjq+pkTcg2CJF2H1t2Gk45A0ELzFPoycuHftnj4251NRX4siyUFBw+wWPwRw5YYwzip4i2hpiBH6p3nJCH3D0q5vKpOMcRVkpPYsSiKylbcxGL//5GEIyNUk4LRGY0jC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364681; c=relaxed/simple;
	bh=h6XDo9MqX66TbKJn2C4oVwqfyTVywHALJIHo9IR9uYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYLgzrCUiv3UDuUBLcIjhz+AgHWIibiTO88xoHvtTdrEZHLIm5Fy6S1MNn/3qrHKKFcpdAIG5Ayp3P9flKNmxdJuCuFhu/D9ejBVk9F0zEI3uweNyDQNymkjD7I5J4WQSLm74oDE6wLocbOybVOTn5laBzwJpGvIgx1FF/QbOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86704887709so1598863241.3;
        Wed, 12 Feb 2025 04:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364677; x=1739969477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ/1ab/AMMhwdUM5h+TBMpEY47u6kr9GW+SYGBdGrF8=;
        b=JooYGfeAqsUex9YxZW2sKm2txxgYlfbwtBHvJ8dnDFrADej9SWbR2ZMn8GAu9BWjsM
         p64lTBnZlgZgmFs2K27o+JxHq+MATUAgYsqZs3wp7lAkha1W4wNDX5AQF4Hyr2if3vKH
         n/XKxf+O9eiPaU1ARAmI7sPBsZFliz1ZruE3PXt2Q4+JHG/aGdD1KjNuh815hlXas9u3
         CMxHPCjihF+rwQme/Ju6/xYjWWrA3BfJeKANkfaKq3B4TJMxrlgeKb4yw/xQ6MD721+n
         tUcY2WFW84pCkunUb4sjZDaUpwNVuSfcoq0oKV0nEEuJtaVwKPhpGyP6YPppgHae9tc4
         hk3w==
X-Forwarded-Encrypted: i=1; AJvYcCVog7TNveicoGTh5cIYIUBT0b1vuCfZhqPu/Hnds0aI1LAX8S1ghsswReKmfiHuAD+CE+Fu6W6i+QzI@vger.kernel.org, AJvYcCXbm16oR6wfSmZM78ymJV1J+6lOz4kB83wLu1ErhlvwtCEax+q7+AaYUBYWw8ZIauI0fI+4tO5tJtGU27Oa@vger.kernel.org, AJvYcCXnFtw5EOnwp7Ikcrak9VML9EAJyGKZc+wLf8Q2zFRd0SZF0NcuAu6Gf2nEdQvkrfV5WnhdfUnHDVwO@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQmFP2NypAy/AStTtyAe6lCjNsmprwWD632eBVpRA6Sm26bJ5
	wAbL0JOKnBBF2fMydb4RCkk65H8IwvsTrIuohwgc84wkKilvA4Qh0nrMSJnd
X-Gm-Gg: ASbGncsLqG6fIbUojojvT79DV7ZBZh8F+/6alNJZYYhdX40ig6/FEeOqx6LqwlZ0LrE
	CRqcmeS1RvbiCfpgzIu4rwFDo9n5d41EOr4A9KlW1apXcGH3cAiGKZnIZ9QuKmArkgpEWoiRofa
	VqC7GZI0b9ssHvdeKInOlCeg/z8mxXwTKkjTuqKupj+RmNRaCTXOdsFV8E8zqMj0waknfvhUgt4
	6v+ayWzqceULOZwZAVQIeXLXfPSgS5nllq2HhNGngRui++kQ4ogvqfZDWPBvz/Xg1JmlNibnbD2
	nC3umpR13GO5hdk1lSGkNe4Q2vik9EcsZEbQM0ggj8/rNssTQgRatg==
X-Google-Smtp-Source: AGHT+IGhjuojFyHJCG/QQ+Q42CBUu/uR/c7Ifr+gCc1PyAKmlLLAV94aP1MwThyHcebzPlywSVEvrw==
X-Received: by 2002:a05:6122:32c6:b0:520:60c2:3fb with SMTP id 71dfb90a1353d-520678bd90cmr2363039e0c.0.1739364676701;
        Wed, 12 Feb 2025 04:51:16 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5203a7d491fsm1016594e0c.0.2025.02.12.04.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:51:15 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8671441a730so1239846241.0;
        Wed, 12 Feb 2025 04:51:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWK87vtpMprU+iaPdS5uZgbJgOhAjzq40DBbE+0bPVxGwvuyu5GxwbK7g/0oT9Ad4HJRxLLrA2vGTnZ@vger.kernel.org, AJvYcCWTAPRrAADFLuoSvVqrNo0363zlx8/zqdkhOWShTfNERucyXRtb37FySZR4KDid4DnGZ/lGo68OmM27fy83@vger.kernel.org, AJvYcCWoc6Sv+fDUegp97iu/MXvRFjtM21qzmc3AHfe+ptaTscUtLhpNodEyoQCOaHrJNjipRpNjPLrbut9J@vger.kernel.org
X-Received: by 2002:a05:6102:3709:b0:4bb:d394:46c5 with SMTP id
 ada2fe7eead31-4bbf21cdce8mr2389568137.9.1739364674977; Wed, 12 Feb 2025
 04:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210131826.220318-1-patrice.chotard@foss.st.com> <20250210131826.220318-5-patrice.chotard@foss.st.com>
In-Reply-To: <20250210131826.220318-5-patrice.chotard@foss.st.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2025 13:51:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVkFym-3byZkszsi9tRoZ6zNOMCT79c2EgQQjn5xd19ig@mail.gmail.com>
X-Gm-Features: AWEUYZnzYg0ThTq4p4M8sQ0EhbXz6WBb20xXzFHLgeW2YGdd91BJTbWp42U4Smo
Message-ID: <CAMuHMdVkFym-3byZkszsi9tRoZ6zNOMCT79c2EgQQjn5xd19ig@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] memory: Add STM32 Octo Memory Manager driver
To: patrice.chotard@foss.st.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	christophe.kerello@foss.st.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrice,

On Mon, 10 Feb 2025 at 14:21, <patrice.chotard@foss.st.com> wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>
> Octo Memory Manager driver (OMM) manages:
>   - the muxing between 2 OSPI busses and 2 output ports.
>     There are 4 possible muxing configurations:
>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>         output is on port 2
>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>         OSPI2 output is on port 1
>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>   - the split of the memory area shared between the 2 OSPI instances.
>   - chip select selection override.
>   - the time between 2 transactions in multiplexed mode.
>   - check firewall access.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Thanks for your patch!

> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -225,6 +225,23 @@ config STM32_FMC2_EBI
>           devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
>           SOCs containing the FMC2 External Bus Interface.
>
> +config STM32_OMM
> +       tristate "STM32 Octo Memory Manager"
> +       depends on SPI_STM32_OSPI || TEST_COMPILE

COMPILE_TEST

> +       help
> +         This driver manages the muxing between the 2 OSPI busses and
> +         the 2 output ports. There are 4 possible muxing configurations:
> +         - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
> +              output is on port 2
> +         - OSPI1 and OSPI2 are multiplexed over the same output port 1
> +         - swapped mode (no multiplexing), OSPI1 output is on port 2,
> +              OSPI2 output is on port 1
> +         - OSPI1 and OSPI2 are multiplexed over the same output port 2
> +         It also manages :
> +           - the split of the memory area shared between the 2 OSPI instances.
> +           - chip select selection override.
> +           - the time between 2 transactions in multiplexed mode.
> +
>  source "drivers/memory/samsung/Kconfig"
>  source "drivers/memory/tegra/Kconfig"

> --- /dev/null
> +++ b/drivers/memory/stm32_omm.c

> +static int stm32_omm_set_amcr(struct device *dev, bool set)
> +{
> +       struct stm32_omm *omm = dev_get_drvdata(dev);
> +       struct regmap *syscfg_regmap;
> +       struct device_node *node;
> +       struct resource res, res1;
> +       resource_size_t mm_ospi2_size = 0;
> +       static const char * const mm_name[] = { "ospi1", "ospi2" };
> +       u32 amcr_base, amcr_mask;
> +       int ret, i, idx;

unsigned int i

> +       unsigned int amcr, read_amcr;
> +
> +       for (i = 0; i < omm->nb_child; i++) {
> +               idx = of_property_match_string(dev->of_node,
> +                                              "memory-region-names",
> +                                              mm_name[i]);
> +               if (idx < 0)
> +                       continue;
> +
> +               /* res1 only used on second loop iteration */
> +               res1.start = res.start;
> +               res1.end = res.end;
> +
> +               node = of_parse_phandle(dev->of_node, "memory-region", idx);
> +               if (!node)
> +                       continue;
> +
> +               ret = of_address_to_resource(node, 0, &res);
> +               if (ret) {
> +                       dev_err(dev, "unable to resolve memory region\n");
> +                       return ret;
> +               }
> +
> +               /* check that memory region fits inside OMM memory map area */
> +               if (!resource_contains(omm->mm_res, &res)) {
> +                       dev_err(dev, "%s doesn't fit inside OMM memory map area\n",
> +                               mm_name[i]);
> +                       dev_err(dev, "[0x%llx-0x%llx] doesn't fit inside [0x%llx-0x%llx]\n",
> +                               res.start, res.end,
> +                               omm->mm_res->start, omm->mm_res->end);

As reported by the kernel test robot, this fails to build when
resource_size_t differs from unsigned long long.  However, you can
easily print the full resource instead:

    dev_err(dev, "%pR doesn't fit inside %pR\n", &res, omm->mm_res);

https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/core-api/printk-formats.rst#L206

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


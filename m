Return-Path: <linux-spi+bounces-12074-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D78EACD60A2
	for <lists+linux-spi@lfdr.de>; Mon, 22 Dec 2025 13:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 531D930115F0
	for <lists+linux-spi@lfdr.de>; Mon, 22 Dec 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B775F2DE70B;
	Mon, 22 Dec 2025 12:48:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42D313E36
	for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407715; cv=none; b=Gq7ldnLTOfcpSpXNZc9hICpLDOZg+HruwHjf/I5OTdwEtLdQjtMYPYIleqvZ+f9JMT+Uf844u26NokU31OL3zG8sHrJzREv/RpG9LqkVk9s7bf+KOQYa/E6PWm6evN67F0QlcIRoExLBARG/sCH/4lsbqTPsNd1LvRq0jOUguFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407715; c=relaxed/simple;
	bh=Xp2JxaURk7cqCR/j5M2KjzDOwxRykTFTwS1VU/qCsh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFnzaWP02MmZjVNw58eksJmkgg7kUWjksO7p884tMsGHZtMetKLv3EH3ONxYlAgCsP3vhTaquBtUfhYrMlVC4oGYwa1/RM8cpfGaD1LIw6DhtLFkNZUc4aqgQLQndcUAo09rKCYj6XxlYwbbEEFma+0+KiXpG7wUcjsJkVd9Ipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-559a4d6b511so448258e0c.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 04:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766407712; x=1767012512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgM9E2RUaWwSmEYTs8cEM73rjhci1votspeG4LjZ3Jk=;
        b=WwVFFAUU/KQBijox8qQPCY69LrQ6w9PIH4MMMJNF0nHp4B2/fl7LcvKDi8UJ+FjkZp
         JqiaCCKnLEo0w/woEX63wDiJGxUWA1mtast46ovkps9oWRHBv8kshY8VrzoNYcuI3nrQ
         09ccqrFU6jZzGHCXGHPvnzhy2xEpo0nEb+FCVYn8SXCwOe1YlXnow8P2duP3wDmTNllX
         erZv8jjgtFGCBewtrMIEMAdYFQwnuyvR2ybrpRnJ1u8SPVYoQLojNubMjFoSiu8O2ZfY
         BegIu87UTDz0ca7nrP6cjk/mlNKFdqlqDorgXFBvz6v34GepFz8Zjkny1X3dHAqVt1DW
         1ZTA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/8qxI9jXOoF38tSppyZMvtufHsT2fFU5iGGomRCJ+toBf3qkku0Azbo/CzqQbvbdCp5JcCkh+rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sjgjc8FuPUlA5zn3WmZXgzqWlN1O1hFF/gZfUZbB7urOP6R+
	kgyC+zH5c81+5NVGwUJ+f0RqB1D/bqCIkkPPKAzAo6GSLUZ6i2pqgEi6Ga6/dBjW
X-Gm-Gg: AY/fxX502w+FbmoMhVgypyBLiOUodklZ5zBibXEBHXHQ6mXa8zwf55gxRLIKjXLQbSL
	m/tiObX+YRZAi0B+QvWCgVpH5XgrA6RYh22bFUc9jA42dVC9Ob7sZENKlfaWBraCgMj6lzUsI9W
	MM1i0N+fWcgysKERQhEh5iXorRUNl4OsoWYVwXvCrZ/PIvZKm1sgDHyCGdNvLswheF87RwVzLYQ
	8vjbGGz7zmwYXvn5v4USqFkmssJAmWN1ZHeWHo+uNlrrZ5aw4q5xLUJDdIK7Kl1oHQWofQZIebX
	xxUmrrZKbqpgwS7NiO8U0VleztexLSzRyJakXz1LIyWjF/Kys0zxznmOGJhNTUeidEJktT3Rx27
	H7g65B8gTpyqyLLlX4+PgBR19glD3WhG9iJOlnyJuVqKz5FVeGCIk3DsZRaHVMJurI2SjYfPRGL
	n6YdzsZ6T/1C/34BviYW2fXlHE7dx+fqW6sIWR92zytsdN+DHXA1sT
X-Google-Smtp-Source: AGHT+IGcd5TpxjyuH9vx09wiFpdYU3DB+zqv3P1PyFJ/kabjUDQdrMc/kOHg6qEuLD8Ki9A43oVZKg==
X-Received: by 2002:a05:6122:7c6:b0:55b:305b:4e45 with SMTP id 71dfb90a1353d-5615beb3bd3mr2906927e0c.17.1766407712209;
        Mon, 22 Dec 2025 04:48:32 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615cf27fe6sm3585276e0c.0.2025.12.22.04.48.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 04:48:32 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56021b53e9eso1066883e0c.2
        for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 04:48:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUE4EzEEqrRwU9K6JgfC+Y6lqSivn3ElBzrDuIxLHu0dQN3yU5CidY0Mf7Utv82Lrhv7aoex5ln0m4=@vger.kernel.org
X-Received: by 2002:a05:6122:a04:b0:55b:180f:fed6 with SMTP id
 71dfb90a1353d-5615be677b9mr2876994e0c.13.1766407711710; Mon, 22 Dec 2025
 04:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com> <20251219-schneider-6-19-rc1-qspi-v1-7-8ad505173e44@bootlin.com>
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-7-8ad505173e44@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2025 13:48:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVBwZW1JCrtpYe7mc55FzEv0BZOWC5NNNVejxXSzDLCpQ@mail.gmail.com>
X-Gm-Features: AQt7F2orBW9lxEBIu81Xb5vtVrPMESy_KNg1aazPhtOsl5NUSmaZ5WtqS55gX-s
Message-ID: <CAMuHMdVBwZW1JCrtpYe7mc55FzEv0BZOWC5NNNVejxXSzDLCpQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] spi: cadence-qspi: Fix probe error path and remove
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vaishnav Achath <vaishnav.a@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Santhosh Kumar K <s-k6@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Miquel,

On Fri, 19 Dec 2025 at 20:23, Miquel Raynal (Schneider Electric)
<miquel.raynal@bootlin.com> wrote:
> The probe has been modified by many different users, it is hard to track
> history, but for sure its current state is partially broken. One easy
> rule to follow is to drop/free/release the resources in the opposite
> order they have been queried.
>
> Fix the labels, the order for freeing the resources, and add the
> missing DMA channel step. Replicate these changes in the remove path as
> well.
>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Thanks for your patch!

> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c

> @@ -1995,7 +1995,7 @@ static int cqspi_probe(struct platform_device *pdev)
>         ret = cqspi_setup_flash(cqspi);
>         if (ret) {
>                 dev_err(dev, "failed to setup flash parameters %d\n", ret);
> -               goto probe_setup_failed;
> +               goto disable_controller;

FTR, this conflicts with commit 9f0736a4e136a6eb ("spi: cadence-quadspi:
Parse DT for flashes with the rest of the DT parsing") in spi/for-next.

>         }
>
>         host->num_chipselect = cqspi->num_chipselect;

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


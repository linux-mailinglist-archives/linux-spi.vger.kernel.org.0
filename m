Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0203C10A177
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfKZPs5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 10:48:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44326 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbfKZPs5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 10:48:57 -0500
Received: by mail-lj1-f195.google.com with SMTP id g3so20764366ljl.11
        for <linux-spi@vger.kernel.org>; Tue, 26 Nov 2019 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88nvJmDpJf3U3oghfZlBzEN8mRIEbqnTMD1mCcruG/8=;
        b=bkI6Ewj+zJdKvZZja3lQVOK2xECFiUjQh1pwZ7rQauT4Gdr1yB3NFAocWj2gkHqOe1
         DIHMGoSdrrRBcGio6QcXTvWiTyEXH9GdsJKTPBaksb57nxBL3DKUpmWnNrJ6u7V/BSVU
         3u3vHWejZaIxsB6atCGIyMuW8f8ut8KKzbOz4hiDBkbZ6eurbRX+29yjuHEFXW3BBAdP
         Yy6boEzXVQ0O1LdYoS2uU5a6sVbCPO7q5sZJXp8KDhyU1geafBYmnNbOKNPkmUUXuX38
         TY6TQK7Y+39kQMf3USEVlfDHYV4rNfcbthlAa59nTHxEmb/RF0gMs2alix6qN/zqHhPX
         6hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88nvJmDpJf3U3oghfZlBzEN8mRIEbqnTMD1mCcruG/8=;
        b=IYcTVZ8wK90heSTz8w8E/PD1awLF7/5ZuAtCAlvPP+e9yJ1/AjHUyX7p6d/N/FUhJl
         3icC3n6OP589KMI+t0XiABMUaI4VFi5LZJGeegQJVbKhKJS4/0geTMLXlVa3NbnTzKNJ
         sQGyemZz3IjtJiAvVuRRWRrtHekRfjKg8aAQTXYDt55aZucYBXqUkZee7lM5bdDJ6DVT
         8mhIlhjIdsCbNeQ+fi4cp/EoWt2l59fCFfRb/VYMw+tSjb15ZOQ3wR0xcEMU2s15iQfZ
         tGvOqL5uv4oGGC6Nzko3hY8dndyHHQuTp9HU0gixEJuiMP2ERNNe70ylUsvQU9lKL/7t
         iUjQ==
X-Gm-Message-State: APjAAAW/9HXw4CiV8lK5zThYQG/4fut2ROyKjQi+ZBNQYZyLvsLyc+WE
        6rXkHrEiq0bskO9hwYn/EnTDRPnbbsF+Oluxjyb59g==
X-Google-Smtp-Source: APXvYqyHY4xz8/1U6rSvVLvhJHAlv2Mr0mXlaim09CME66s+zIBlIghEh1vEh0EInEMRGgMK8ZEuEkrNOwGcfFHcjio=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr27300503lji.251.1574783335558;
 Tue, 26 Nov 2019 07:48:55 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
In-Reply-To: <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Nov 2019 16:48:43 +0100
Message-ID: <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Christophe,

sorry for forgetting about this :(

On Fri, Nov 8, 2019 at 2:34 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> With the two above changes, I get:
> [    3.143014] fsl_spi ff000a80.spi: bail out with error code -22
> [    3.148879] ------------[ cut here ]------------
> [    3.153261] remove_proc_entry: removing non-empty directory 'irq/43',
> leaking at least 'fsl_spi'
> [    3.162473] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:684
> remove_proc_entry+0x1a0/0x1c8

So that is another bug again. (Tearing down IRQs is erroneous
in some way.)

The problem is the first -22 (-EINVAL)

Which comes from of_fsl_spi_probe() IIUC.

Can you try the following? I'm sorry if gmail mangles the
patches, I put a copy here:
https://dflund.se/~triad/fsldebug.diff

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 114801a32371..3f68bea1c3c0 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -617,12 +617,15 @@ static struct spi_master * fsl_spi_probe(struct
device *dev,
  mpc8xxx_spi->type = fsl_spi_get_type(dev);

  ret = fsl_spi_cpm_init(mpc8xxx_spi);
- if (ret)
+ if (ret) {
+ dev_err(dev, "fsl_spi_cpm_init() failed\n");
  goto err_cpm_init;
+ }

  mpc8xxx_spi->reg_base = devm_ioremap_resource(dev, mem);
  if (IS_ERR(mpc8xxx_spi->reg_base)) {
  ret = PTR_ERR(mpc8xxx_spi->reg_base);
+ dev_err(dev, "erroneous ->reg_base\n");
  goto err_probe;
  }

@@ -645,8 +648,10 @@ static struct spi_master * fsl_spi_probe(struct
device *dev,
  ret = devm_request_irq(dev, mpc8xxx_spi->irq, fsl_spi_irq,
         0, "fsl_spi", mpc8xxx_spi);

- if (ret != 0)
+ if (ret != 0) {
+ dev_err(dev, "devm_request_irq() failed\n");
  goto err_probe;
+ }

  reg_base = mpc8xxx_spi->reg_base;

@@ -668,8 +673,10 @@ static struct spi_master * fsl_spi_probe(struct
device *dev,
  mpc8xxx_spi_write_reg(&reg_base->mode, regval);

  ret = devm_spi_register_master(dev, master);
- if (ret < 0)
+ if (ret < 0) {
+ dev_err(dev, "devm_spi_register_master() failed\n");
  goto err_probe;
+ }

  dev_info(dev, "at 0x%p (irq = %d), %s mode\n", reg_base,
  mpc8xxx_spi->irq, mpc8xxx_spi_strmode(mpc8xxx_spi->flags));
@@ -681,6 +688,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 err_cpm_init:
  spi_master_put(master);
 err:
+ dev_err(dev, "exiting fsl_spi_probe() with error\n");
  return ERR_PTR(ret);
 }

@@ -738,12 +746,14 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
  irq = irq_of_parse_and_map(np, 0);
  if (!irq) {
  ret = -EINVAL;
+ dev_err(dev, "irq_of_parse_and_map() failed\n");
  goto err;
  }

  master = fsl_spi_probe(dev, &mem, irq);
  if (IS_ERR(master)) {
  ret = PTR_ERR(master);
+ dev_err(dev, "fsl_spi_probe() failed\n");
  goto err;
  }

Let's drill in and see where this error come from.

Yours,
Linus Walleij

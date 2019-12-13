Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D175411E69F
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLMPdz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 10:33:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53802 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfLMPdz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 10:33:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id w8so3610996wmd.3
        for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2019 07:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAYkCWa+UKUtmAHpxZPtyf0202Fu23Y0TOqeEazyr/Q=;
        b=VB0Qc7V7S5H1KmeOm9KBILALqgHQYmF0aObNiHutpNEkYKmbpAjtI6JvdXopT8ToXQ
         qm9DbdizY6eiF3/gk9eh3FqiObj0x6V2jvz6Ylw/I73linNPmdpuQtck7H3uv4ntHObE
         zQqLulojG9AR9iQ3V4qz2nPme4DxxHaa4KFNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAYkCWa+UKUtmAHpxZPtyf0202Fu23Y0TOqeEazyr/Q=;
        b=s5CitZe+ICJWTNhJVvfRqJEyj1Dx24giE2BtiXPPxIx3FF91bcJHWBLc3wxBRVw06Y
         iZoHk+k0638atF3D8Wxzvf4YRYe8ydaTEflfnXSB7SDUgo3xQcSXUte5DSCoVorsI+0g
         pZnN5F4JNDyl8jl6R03Rdw4L2Uw+IIxkaXI8nObyh5/ua6uGzcT0gqE47vNNwXpCquVc
         Q3/4EZrMw+ZzIjclvX5xuucriuId2IIsI0IT7VaOZUMJw3h8tYVrmLaXQqlOxsLnadIz
         PUuEKi3EEQOstmBO5RtLrPemqYeRy0l+TWzmcewLSxObNq9unQbJDbQC1xcoskJ13MSL
         P61Q==
X-Gm-Message-State: APjAAAW0QQVEKoaubyNeGo3FPvF6hykLuWdPIXqcoeXCj+Oli5k+X4X8
        eWmfkfQbeMfBFigB9IqEIqSCdbxiLddQ+1maccE84w==
X-Google-Smtp-Source: APXvYqzG07t8L0rdT/jCMyiZ1bizG1mmA/UGnwTTkXBgBiB92Pia9cOilPnt362sCSti1OdNCJDkL78l3OzGZ3Q6Gso=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr13988989wmc.174.1576251232755;
 Fri, 13 Dec 2019 07:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20191212231213.29061-1-jquinlan@broadcom.com> <20191213114138.GB4644@sirena.org.uk>
In-Reply-To: <20191213114138.GB4644@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 13 Dec 2019 10:33:41 -0500
Message-ID: <CA+-6iNz4WVJzfntJ5CUXBYvqQG4kEj8g8g_HOxZN5rFWTUvv3g@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 13, 2019 at 6:41 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 12, 2019 at 06:12:13PM -0500, Jim Quinlan wrote:
> > Otherwise one may get multiple error messages for normal
> > operation of a clock provider.
>
> >       if (IS_ERR(bs->clk)) {
> >               err = PTR_ERR(bs->clk);
> > -             dev_err(&pdev->dev, "could not get clk: %d\n", err);
> > +             if (err != -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "could not get clk: %d\n", err);
>
> On the other hand if the clock isn't there and never appears then there
> won't be anything saying why the driver isn't loading which won't be
> helpful when trying to figure out what's going on.

Understood; I could do a dev_dbg() on -EPROBE_DEFER and dev_err() on
all other errors -- would that work for you?

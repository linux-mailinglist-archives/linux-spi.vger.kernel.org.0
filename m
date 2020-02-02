Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E306514FE54
	for <lists+linux-spi@lfdr.de>; Sun,  2 Feb 2020 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgBBQjx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 2 Feb 2020 11:39:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42455 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgBBQjx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 2 Feb 2020 11:39:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so8026837lfl.9;
        Sun, 02 Feb 2020 08:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVaC0F6rgdniTKROUmCnnA4r9wsKzEyhP6hHedwGoWo=;
        b=XoUUS+o3zhjNpAbUAUIfkj/DPoLWtowdwYUaTHzcwfzGiWEvDtnGA0vFtlP/shH3Vo
         25dS7EkTu8G7uCL7S/SjtLAhWZe9JAEAwq4eOCUOTW82/yN4sRnb+6gZmO8M4zYMtsQT
         5jGkW4xhG1S/8gELd3Oapxj2sn4N0CMam04YmPY6py7ZqQdQhhhofHzeb67kzv4QoH8M
         0GXtRajwA83o+0WP59UES85ARZjANg3xULWrkuueaHQC8pTSq6ut/DMAydv1Q351UTsV
         pLn76PMJNYr6w1MdaJb+lZRGW0wbiOBB2DJXtBj2KQ/6eZDXu59Ar2grySPYG9JSw3Hn
         4/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVaC0F6rgdniTKROUmCnnA4r9wsKzEyhP6hHedwGoWo=;
        b=VSbnGTPQJeUOJlenCLhV3/U7B/qYL0dTvbTCAuoQ3KCnGRpZvWXcPJyC1t5sAm9OhF
         bWprzyvuJoXQlUu9nqSHD+X8UHhzH7NbKOvC7Ea6IOvd6cO5oUKTwIJyklfHwjYu0h9a
         Vt/oWgnxiqwTtZ1RhzLtC0NzjUm6Lt0HJXDKvuwa/iWeQFQHQIznd4YWpa2NSPJTt8ZI
         /jMOqH7XIVdHTts+tirxl69jPWM0qWEJhAGC2pUtJMuO8VdHzOAPfxHGl657Oc6vXOGB
         j0F7OHCcjwJObZ4egfNAgFiuDPzCVARt+O2SYgfGBLf9ZXavIaRrErZ5Kdks9mukNekj
         fW5A==
X-Gm-Message-State: APjAAAUsmbR03YVFUtyU803F861X5iR2IcvX82QbBwJoSu5Wtlf6wlus
        fFaLdJaRS0SIODJN7cta3CDpksYgRnkEicW95iQ=
X-Google-Smtp-Source: APXvYqzzlxrTpJnf9hamU4U8roypGWc+64P/nSJO0cYNO9R2+JV7vqrhizVneA72cA7hYjmojWIPthZlH0pd8OGiFsY=
X-Received: by 2002:a19:c3c2:: with SMTP id t185mr9929668lff.56.1580661590508;
 Sun, 02 Feb 2020 08:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20200202125950.1825013-1-aford173@gmail.com> <20200202125950.1825013-2-aford173@gmail.com>
In-Reply-To: <20200202125950.1825013-2-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 2 Feb 2020 13:39:41 -0300
Message-ID: <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Feb 2, 2020 at 10:00 AM Adam Ford <aford173@gmail.com> wrote:
>
> From: Han Xu <han.xu@nxp.com>
>
> Apply patch from NXP upstream repo to
> dynamically allocate AHB memory as needed.

The commit log could be improved here. What is the motivation for doing this?

> +               if (!f->ahb_addr) {
> +                       dev_err(f->dev, "failed to alloc memory\n");

There is no need for this error message as the MM core will take care of it.

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C678410A147
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 16:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfKZPfd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 10:35:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33528 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKZPfd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 10:35:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so20781310ljk.0;
        Tue, 26 Nov 2019 07:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UxTHENj0BMyyDkUJ8QxFSlj5avLFFgnB7fsXjjM6lI=;
        b=LLB1JlpuWLjsw8Now+RNqh3SZGwpc/KCZvo5Fx0uZrhP3I/pxFQb2PSzg39e40Hbe3
         3zbIjTotaTRobPOlsz0KMZJA07Tz1pAJ/IORVAcHo6lwxjpgN4o2mUXwhIcp8el62eUU
         Ig2jqhBOajC9W25RM+VmZP+7r2gFBjyGb0yZeJzLoIY1HPyDKSMfK3spmlAVQwuKNYrB
         RLxdEGvf7n4WqaSQFiLiWdqbi9pe3qak9pZ2mooeJunAIYTO3PZHMLovUQIFiKygMqxB
         TN8pF//+hc1IYcGn6883xwtzNOFlcEKLFBRLQzpzkL6Q3swoazxtMdt7ALGaGSVvfjbw
         cGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UxTHENj0BMyyDkUJ8QxFSlj5avLFFgnB7fsXjjM6lI=;
        b=tDgJlROcDBWSKJeH0WcFw4H3ZgWKbnghF8alsDUedlUcvOrKDq+jmEd9aR4/b70lX9
         MjbOMnBCaHFlK/eBzxZPdyoVwTQAteLzd8+tN5eCyHhX3OHKmhJRMIfTt1fg0c0E7klN
         2FDzlDhAwAEBroJssZw3FqkIpMmH02B9qxr090bos6QRKfnyc3LriydThqXege9EtFMP
         6Vpj8sAltrRkokG+hXXlgEiSsQp71T1oOjNNiMa/W0DxCork28+vQvHIbPpj2j87pm9J
         efFzIlbvQne0htKuUTSZKOWfvuMTM0kpnoNVPEwBce+h1OH5l4rs1Fkp++90XKnP98tM
         p4yQ==
X-Gm-Message-State: APjAAAUFT9YKcvJXB46saABmnRXUKO5Q5z7jNoxJS4sHCj3gM9KNp8fy
        6lyZQsDrX5f6M8ca2m5LtiM+ztomECCQPc/KCe0=
X-Google-Smtp-Source: APXvYqxRvbnCXniDTi/TGdOqR0yh3Pc2H18YCznpfxyMFbf/jDlx6ToLgUkc+dg5q+/tPk/hfhxsbibtpLPQEbBOvOE=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr27814122ljp.0.1574782530405;
 Tue, 26 Nov 2019 07:35:30 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr> <d144f86e-48ff-384a-2937-639c0c6dd3d8@c-s.fr>
In-Reply-To: <d144f86e-48ff-384a-2937-639c0c6dd3d8@c-s.fr>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Nov 2019 12:35:35 -0300
Message-ID: <CAOMZO5DJ+UGuNN-5gZE68Yt2ZTBVZ50teo9H0=c-Rgx+oFAa7A@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Christophe,

On Tue, Nov 26, 2019 at 12:01 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> How can we progress on that ? Problem is still present in 5.4

Linus has sent the following fix:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20191126&id=c5923243eb3208ea63b5ed7905610039c4ca5201

Does this fix the problem?

If it does I think this need to get into stable too.

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9310C89E
	for <lists+linux-spi@lfdr.de>; Thu, 28 Nov 2019 13:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1MV5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Nov 2019 07:21:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38134 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1MV5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Nov 2019 07:21:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id k8so17751976ljh.5
        for <linux-spi@vger.kernel.org>; Thu, 28 Nov 2019 04:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXCA4P1++mZ4GjWU0WE3nsYL5FMcWa3cXbIapek2T/s=;
        b=jabLiYoVLgEE4KTwesZZ2DmLmaC34ZclwZ1kroQlBm1emD0PcHERirT/hIXKWoQFos
         FXGKTcgMut7RTmZ5gXXmVxyK4gRpeofT8e2F8s6uLfmA+TQObcbJyQh1OR+sP5z3w+vH
         iVyRWxpvtyGd0kqgtzW3CQRScRwwOudpNBwxE1TAHpVCjIzAJwfin6SsgPTMGVpotdh3
         ooylYNSUGySU9KKHhWVPly1OHawrnLauXENT78d93EllPbBwpznUq9al7WKA6Jc+w8X2
         yzAsA4EJ59JuX+Vfi82qtpXLIyN+EOD8BlzexqqEakfaRNLtDQBtKzorXhAlD3MTM1sV
         03JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXCA4P1++mZ4GjWU0WE3nsYL5FMcWa3cXbIapek2T/s=;
        b=G/6Uvjk2BML+TeTQznIHNFjQ3nHX9dS/ToIAQh7LFS7qehqLK0EjA/JCSaSm5hFQvH
         ojmYsnClUf62HUGC0mlXK8/joxq54le8/TXvE/U/fCeQ43gDx50FiaC2fQhRpZxWD5rm
         d8fTtMQjT3mIqoE84g7PUAXYxukV32CwBZ6t7g1V/cLnEzgU0TN+jUASmNrQjYbjYlXy
         Vnhz7rgYirZb0xGEY1FDQWcbBWv4MmfKe2RnrL8AAQxWKi4CY9Upv1qvuSvq/0cjucZo
         GZdVi8jmzXkF+bzj8yBA2IKtfCfxHbGmcSYp3ocoZRL51p/hwlniYun3LBfKbMeQJ8ib
         qupQ==
X-Gm-Message-State: APjAAAXRw6M0v9kpjhfALwp8I3vXXM22OX9nxYsHx1B3mA2Jrn8D1pMu
        UdDGt40zuPSnrhdB9kaq3jNleASdCnqpwDVK+EdeNg==
X-Google-Smtp-Source: APXvYqxC+CilfFecs694uPA2TkzfBRgLiP8clA3RZ7THF3M8WYbpWuyE8yJFEz9LrJzLIs8TgrYqaoLQgeR+Iv/pMiA=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr13384895ljm.233.1574943715334;
 Thu, 28 Nov 2019 04:21:55 -0800 (PST)
MIME-Version: 1.0
References: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
In-Reply-To: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 13:21:43 +0100
Message-ID: <CACRpkdZZc5QKqX74WbyO8WQmVw7SSm2HYYMtoxjbEWomGvnkUg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on
 fsl,spi nodes
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Nov 28, 2019 at 1:16 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:

> Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
> descriptors"), the prefered way to define chipselect GPIOs is using
> 'cs-gpios' property instead of the legacy 'gpios' property.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

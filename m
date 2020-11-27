Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862912C67DC
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgK0OZV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 09:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbgK0OZT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 09:25:19 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654D6C0613D1;
        Fri, 27 Nov 2020 06:25:19 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so4445214pgg.12;
        Fri, 27 Nov 2020 06:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4BHoPQWs3wfoV3g79VgV8GEhoq3XXt8Ikk0xMwv5WoI=;
        b=V9BtXLPOii4DpQATk+MmCsK+Ve2A/MjKgvZePZQJyiEHSpItKt8KhEPdLvQEYEOKcy
         OP/HVvR2CWG+PuXjgeuy68l4UVFF3yRyTkF0P/9dUFEsFhfIw9DMVgwbv3c748hYDlZO
         phu+1bdlsZwgoGQIE1SXKEerfddqam+4MTfgS1pSXB2IZ/8as50BGgREwJbF22EO/2+G
         xfi+InCshjurjLJjWYpuXdXvaCfwVQDyyBQ5MXqLZI1RF8XpjXQjZ69I46+xiO3YenTZ
         g7UsznWy1CW2glmc9pxQW+o1Iu0NB2klZi6O/nP6UQJ6HxRIii+p3ueBbcv+bz1iJE3v
         BmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BHoPQWs3wfoV3g79VgV8GEhoq3XXt8Ikk0xMwv5WoI=;
        b=j796bvwGLMV3HHBJYHOWJytE2oyBxm0PmtE4INYmhTxqebFAU4l0M8WYaNCgGk8Lca
         r/Gamr5c7M+5PT1um3ddf2fH1wA1ZhiUM2oozCCqQPLlS2iiNd2f7DtIPPnb8zg5H2xs
         pQL04+4lZ9mDBrMvdR/Zi6RT4+iB0/Rkc637PdGYwn6ARVuDATH96pytC6fUQxuJpmjC
         o2mhpqhH2xz9H5PjK6Q38++jYiTAmqJvx6J454nkKgxgSLpRytpiKR60gT/eyFieTXGZ
         ZmsZx917TwMg+c8Gap+FYfy19zYM/joTs0MNuVbY5HHtLUH5TjNxrRskQpUkT57WI6SJ
         jbKg==
X-Gm-Message-State: AOAM532eboZQA0cm9fZaYI1boMqIYBbtbbO6zEQ4l/SV6sPhSV8Def9F
        gdmi6PUG/Qgn0aQ0e0u5EQiItstacXSmC1fINAU=
X-Google-Smtp-Source: ABdhPJwwwmFIw2kctAp4qvXc/0jW/FjQNuczdO+/Ii1MF8qwXUPmNUj/XTt32yfEIgSQo1JNUdeC3g9PWWaRJ6X6Ba4=
X-Received: by 2002:a17:90a:4816:: with SMTP id a22mr10437588pjh.228.1606487119026;
 Fri, 27 Nov 2020 06:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20201127130834.136348-1-alexandru.ardelean@analog.com> <20201127130834.136348-3-alexandru.ardelean@analog.com>
In-Reply-To: <20201127130834.136348-3-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Nov 2020 16:26:07 +0200
Message-ID: <CAHp75Vcm5-i+n2dS7GxqK8Rp74+Y-+5CdMoBNP7ZCXkw1VnPkw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] spi: dt-bindings: document zero value for
 spi-{rx,tx}-bus-width properties
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 27, 2020 at 3:08 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> Following a change to the SPI framework, providing a value of zero for
> 'spi-rx-bus-width' and 'spi-tx-bus-width' is now possible and will
> essentially mean than no RX or TX is allowed.

than -> that

I'm wondering if we have a possibility to strict this for controllers
that always duplex (I assume that schema works in a way that the
generic bindings is most relaxed in comparison to the device specific
ones in case of the same binding in question).

-- 
With Best Regards,
Andy Shevchenko

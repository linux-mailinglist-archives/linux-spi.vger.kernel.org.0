Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4701DC830
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 10:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgEUIFA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgEUIE7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 04:04:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C67C061A0E;
        Thu, 21 May 2020 01:04:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k7so2734312pjs.5;
        Thu, 21 May 2020 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TO1wq6j7PKKwzMDcL3TCdcuBHoeFZLasBqHQKFsvCUg=;
        b=VzPWx1/v1MYVNfoEQlNcXSyqs/Lelfc0CxX9+hf8vW8JSc3ilWR4neMFzvXQV+UIqz
         /qNg9t9F/qjCWDxP+QGC8XLBVdSr+QtvLTQLPdaV4nzAVLYqVssUH9Gf094Hdn2P2k+X
         i8aRAZz/RFAStlkXvQjPJCOp5xwHQi1HNPUkZV9w5vnN1aqN/m4oodMF9aQNkxmYNdSr
         QAJhJ+7QX1EOw8Tq7pVc+7/B+onMO7sG1UYeFdOAoe/PuTZjESj8k2cbLquLBkESbsnn
         rEHOCMA9N+2Jq+GXfqbdCQstVRfmovsiXoGpZpt5qHYOit4p9LwHP4xLJ/DkJXSp9YGX
         OecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TO1wq6j7PKKwzMDcL3TCdcuBHoeFZLasBqHQKFsvCUg=;
        b=VbEfEVeMlzzZUFexfl4KVUaCB4J1p2TVQysI0OjofSnTG/b6dW1xz/b/1+GBZOw0Si
         blvqJ6/VC9c0ppMn0P1k68Azyg2nYUlMNGtTYp+GN2Kg8UbVsa19kvOyxBkG/Llbup9q
         1zD+UEJxDqsEL5zoq9vQ70/8/z5y5tiCtQw768hW/IH549S+KTEabfeptrndmcVZzmD8
         jKvZFE8vTvsK2Pa+xv7VBJyYwOvhfJj9ctui7mV+wqAWG7InWPosn5s2zLKNq/gUA+/Y
         FQ/ntQlcNc4f54N+ixK9Sd1xNNcsjzuI6PHWEL5QwdsxS/rcJXqZxwHuQKmmlsKsHIm0
         eE1g==
X-Gm-Message-State: AOAM532okYm172Jmajp/fI9aT5ZidA04SBR4R3Sq7YM7VZVUSOQr3cLM
        btyrueT/j/d9ZYYb3yb5GKoA+UFt6aUqvjf+n7mrwQb+VDQ=
X-Google-Smtp-Source: ABdhPJyRqXe3U4NrMcm7j3iaLIce3pW8UMfo66n2vw8qBIEf9n1jtPujxxLiYe+X0XVZj5e4Iz8c0CCB6sGM/zjMufE=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr9697130pjd.181.1590048299087;
 Thu, 21 May 2020 01:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 11:04:41 +0300
Message-ID: <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
Subject: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 10:50 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

...

>         ret = pm_runtime_get_sync(&pdev->dev);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);

> +               pm_runtime_put(&pdev->dev);

For all your patches, please, double check what you are proposing.

Here, I believe, the correct one will be _put_noidle().

AFAIU you are not supposed to actually suspend the device in case of error.
But I might be mistaken, thus see above.

>                 goto exit_pm_disable;
>         }

-- 
With Best Regards,
Andy Shevchenko

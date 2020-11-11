Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1AB2AEC38
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 09:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKKIoF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 03:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgKKIoC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 03:44:02 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF2C0613D1
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2020 00:44:01 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 19so1486639wmf.1
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2020 00:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcBI1iT++WuwPPPSvntHZTuGcKqBiLxKhmPlA8wUhho=;
        b=ivWLbtAgd+1HlfdjrzvbJD+Un2MEikWYtFZjXX4+EFFb+lQI3yBFldgY/n+RnWbRwG
         YqyVUhVqt/oQzmQEuqjKt0KdQqcMk1frkJB1SPhBNavB4MOifCmq12BrDyUjXconwKrV
         erPov9Zh7qQyKunIK7AB/xlLlADkVOxhgULwITifogAc0XIy5vfuEzZ0uYxp2a709SWL
         XV8jKb1b/AcWfUJYOtyCjw7KgVf1zVGZw0nM1lWOvRuLVlz27uXECWNr/+pNdeJhF3Cc
         9FESRI86jzYGLS0xK4Aan9nIlE4zhbnJi3Q1BJoe3HlDaMvkpG3D+RvS6wnrjUmnb18L
         wBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcBI1iT++WuwPPPSvntHZTuGcKqBiLxKhmPlA8wUhho=;
        b=hMqneXaN7+8+znk8XR9ikdKNBPhJrDGITrOzOB5r1zFzjU5SKN+lXS9gBq1F/zvj07
         Sah/oNlf15DWMeb/ZjMOyL1khveMKA/SZm0XiwZ93UxNKKobJLh/2FBFBNhOrvviBmc0
         3P4oiZuRqw3ghyfsXas5ygu/j1dvqli02iICoUFBFDixsRNowUs3DDeIBsRxxIasDFKq
         lLNN9u13RVhxfgNQOpYCFMbxOwAgfXAfKXxXA4B95bkZc4CeeP3/rAF5GwM1XbFsGfdt
         ZAiXxDbkeJkUj7qCjx8Kb1UpV8/uFkG+cvwXcqWAuQxB6LW1QrolfL4ZhUsP+Rt6vTL2
         opqA==
X-Gm-Message-State: AOAM531Bd5Rdnk8g4aQ3IwlRS4VSl/vNHOfHWFYTh0dVUlg4WKYZngOn
        f2Fo+MgdJtAuoMGeszN/ks8dvrg1zpqfhYTB6gQ=
X-Google-Smtp-Source: ABdhPJx4P+lrFaj1yjCQ8qN+HhxCxAH1EHLcYEBuw6Db3AK852HJMmG2Cdscy6ZKPq0EFwcjsaWilc1yx6KCu5UMd88=
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr2831476wmg.161.1605084240476;
 Wed, 11 Nov 2020 00:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20201106015035.139574-1-zhangqilong3@huawei.com>
In-Reply-To: <20201106015035.139574-1-zhangqilong3@huawei.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 11 Nov 2020 16:43:24 +0800
Message-ID: <CAAfSe-tETrydu9n-mU=FA3+76A63+SthO=CCWk0c-BxtmR6eRA@mail.gmail.com>
Subject: Re: [PATCH] spi: sprd: fix reference leak in sprd_spi_remove
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 6 Nov 2020 at 09:39, Zhang Qilong <zhangqilong3@huawei.com> wrote:
>
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in sprd_spi_remove, so we should fix it.
>
> Fixes: e7d973a31c24b ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/spi/spi-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
> index 635738f54c73..b41a75749b49 100644
> --- a/drivers/spi/spi-sprd.c
> +++ b/drivers/spi/spi-sprd.c
> @@ -1010,6 +1010,7 @@ static int sprd_spi_remove(struct platform_device *pdev)
>
>         ret = pm_runtime_get_sync(ss->dev);
>         if (ret < 0) {
> +               pm_runtime_put_noidle(ss->dev);
>                 dev_err(ss->dev, "failed to resume SPI controller\n");
>                 return ret;
>         }
> --
> 2.17.1
>

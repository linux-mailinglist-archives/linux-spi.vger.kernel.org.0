Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E163753DD
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEFMbM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhEFMbM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 08:31:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC57C061574
        for <linux-spi@vger.kernel.org>; Thu,  6 May 2021 05:30:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j10so7478076lfb.12
        for <linux-spi@vger.kernel.org>; Thu, 06 May 2021 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=400x6iZy6/HL/Nrl18LUmigZy1nnEx49HdlvgSm1I4E=;
        b=M2NgilFY+TJZ3Zlc/+9hPTLqnpzPb5y9cMpKop1SX2v1GaaNRvSe3dbcSQuwfaZOb6
         k2qv1+bnAaxyWKzHFVSKypWDNgphX7mgiOARHkfC+i6a4czrT7Lanpp9P0AcPJFgmYN+
         cM0gJ/P/5nfccihyRhk69O1ryrZS1GaEz8URuFwsI3by2SafLaEeeSZI7BGg3mUbgiBh
         D+NkN9YdEsjbNChkNwjiZJpbG3nRElcuFVQwRoMjidvTadtZZkMJNwX6p9Oxa5Q9KqS0
         65WRR+de+m6MKaAG3RcMS7X8wc361aaaHZinNkmwAn7NtmEIapklqGfULVY188UV4Odv
         N+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=400x6iZy6/HL/Nrl18LUmigZy1nnEx49HdlvgSm1I4E=;
        b=fD0oTBTdRplb4WWKOtqmXBzASklHN9HJM0B0BOLMoCUy031S/JXYVPLyqHGaOtPAlj
         KbG+pMjkDvXw+dBiDeqv6QM0XJn688rYIqunvl1kyd27nMtsgFpzdFB+eYvq8TF8hwV5
         A+i2n6sLpSCvQJk9BqMGrA+LdoB8qj7Rmp3j6Q16zNpsjNLNDM8oFuc3SUAs4WyM4xHe
         NADB0jXRSoqUdcA0c4IYtYlYZMRwTonWMxvdgckIRLTOTn4QU7Emk2eEx4uR/B5tLh4u
         hFA7NImN8+YnkZWQ5y5rd0qOgkp3JHSGqbtafd+ogp+c3pbJAkN0VziJOT5OD6vbpdJ6
         QWhQ==
X-Gm-Message-State: AOAM532X76CYfG88/Q306Nrz9DR2kJWGqwEi/XfES6eyMc6RtYbSr/Th
        fRgDq+GjPvUL7JNTC/wRU+rLBqPSuhAv3I49sfLkNw==
X-Google-Smtp-Source: ABdhPJxA6lxDi3ZaNQ6iBPt1DpkaZbIueswU/r0EocErLyl7SXhoVeGhjQcLkVVc3iADVmx3RVAfFZ8bD5JtIhD1EbU=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr2611610lfl.291.1620304212322;
 Thu, 06 May 2021 05:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <424d37007b7e298cf9bca5ac38d45a723e0976ee.1620301297.git.xhao@linux.alibaba.com>
In-Reply-To: <424d37007b7e298cf9bca5ac38d45a723e0976ee.1620301297.git.xhao@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:30:01 +0200
Message-ID: <CACRpkdYyXO=47aTyhUfY6MLNUFiRUzORLGDMeV7E4JULbx3hbQ@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
To:     bier@b-x3vxmd6m-2058.local
Cc:     Mark Brown <broonie@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 6, 2021 at 1:45 PM Xin Hao <bier@b-x3vxmd6m-2058.local> wrote:

> From: Xin Hao <xhao@linux.alibaba.com>
>
> When i was testing the TPM2 device, I found that the driver
> always failed to register which used SPI bus and GPIO as CS
> signal, i found that the reason for the error was that CS could
> not be set correctly, so there fixed it.
>
> Fixes: 766c6b63aa044e ("spi: fix client driver breakages when using
> GPIO descriptors")
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

(...)
>                                 /* polarity handled by gpiolib */
>                                 gpiod_set_value_cansleep(spi->cs_gpiod,
> -                                                        enable1);
> +                                                        !enable);

We have been over this code a lot of times, can you
help us to investigate the root cause here and check
how the interrupts are provided on this platform.

TPM2 makes me think that this is an Intel platform
and maybe ACPI of some kind so you need to run
it by Andy, who is working on some related fixes.

Yours,
Linus Walleij

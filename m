Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB0655480F
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jun 2022 14:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbiFVKZo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jun 2022 06:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiFVKZk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jun 2022 06:25:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A163A5C7
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 03:25:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so5535991ejc.10
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zjn2NcRExPUTirGFzxTZgP9NjWgoGUMnDJgEV1lu04=;
        b=I8En5bsxXFmfyfyTiI0mscFffKVay0IZWSa1/HbfosWxmP06Si3VoiX7GN+9/ngIoZ
         USVmJPDOedjMHazgmdeuL3VoaaygtCusUFGxUFBuK9Z7cgNnLTxHjcVbm4vkABgBwyIK
         NG3W44lMeXVbV/0RTyg1PA8n59n1mShKWNXzwwwTPzsXvD0O5cHSfArjPlRDthOeJ6ti
         vFEsPXGjUAUYHV7Z4sfnSXby8Apt9E4Nz+06p3HWVOFjZCGeL0tx5+8amBuX/oaSSP/B
         HjHFQig9XpSOm6qySIaguAesWRQRTnGhYo45M1LxmdSddAw+3arct4hynn//FAjML28i
         ByVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zjn2NcRExPUTirGFzxTZgP9NjWgoGUMnDJgEV1lu04=;
        b=1kXjQ6Wh4b3GgKxirJ1b8dMLFFpIiG+Nm2bvDSGmaYAwKBSTRMWQ3gbgk6bydfdHIE
         AV8GIbe6e0pBdk5eK0NXaNHDuFR/lfk2Up0Rsx3OoOPfYGaBiEAtdSa3BrFSt4yCmG3Q
         LGejGDGcjp72ki7zO5gvoBvp9BqBBw6M4GKBOvj+YYmEC/KRpHmJFHl6bKH5o71FbjG+
         ymOn6KxkZ/53bz7POnZiPsfAo7rIo11+0knQIefo816soWH8xJqXtoRVsZHdQgSv57pd
         ENXOg03sJ2wXgejGggQ/UOe8f0ICqjnb3Ati8fBQL1Hb4ZI7mANyFiY6W57sBwuBAX6Y
         1YHg==
X-Gm-Message-State: AJIora9QJe3ARJla5lI9wzzBhLuLsPbB8W4Ncb6/+jqCXiQ/kN+PuHll
        49+LKX14riMVZkqL7/yJyxVjQd3FB6y+YIBk6yY=
X-Google-Smtp-Source: AGRyM1vULSENe1QE1XKOk2zwFzPPyWuwL3467lJNApluODeMEqHk4UQbjn/vq2B1beA3apf4wvRk6XKWiu4Q7fHRftg=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr2446013ejh.497.1655893535896; Wed, 22 Jun
 2022 03:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220610074459.3261383-1-andy.chiu@sifive.com> <20220610074459.3261383-2-andy.chiu@sifive.com>
In-Reply-To: <20220610074459.3261383-2-andy.chiu@sifive.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jun 2022 12:24:58 +0200
Message-ID: <CAHp75Vfeh+jpft0sCdVqz+nJAP83LGhQvA_62aQptzt8a4M+gw@mail.gmail.com>
Subject: Re: [PATCH next 1/1] spi: sifive: add PM callbacks to support suspend/resume
To:     Andy Chiu <andy.chiu@sifive.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 10, 2022 at 10:05 AM Andy Chiu <andy.chiu@sifive.com> wrote:
>

Missed changelog.

> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>

>         .driver = {
>                 .name = SIFIVE_SPI_DRIVER_NAME,
> +               .pm = &sifive_spi_pm_ops,

Missed pm_sleep_ptr(). Have you compiled it with CONFIG_PM_SLEEP=n?
Have you got warnings of unused functions?

>                 .of_match_table = sifive_spi_of_match,
>         },

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770C64F8587
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiDGRJI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiDGRJH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 13:09:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F481137036
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 10:07:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ot30so12107053ejb.12
        for <linux-spi@vger.kernel.org>; Thu, 07 Apr 2022 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xs34HmB3mQxNQ3MLumY+2KQcgDnFTGSI4kG5G0wYBkE=;
        b=ww8yK1BrSCPVvq7ixEbabV33ZCd1Z1LaPKRg8Y9l2GljGEWdrrYaE0IAolAPWLNSYw
         P4+1yvv+UgVofEqgfmJPEcKQVCsAk3cFZ6FJzhqn/kIoheUME8P3uujDLRTfAlbCGi8U
         uB58U1uqH9WnrU8adscton7OROJADVndd3wQTshdIDgKvImF+v+elde6rHo8ACcJHqzU
         sqVb/Gz0LrcRDCsPqoMyqr43J578NpzZjNpJuzYR3jaZFDC0f0VK9fT8yw2LO9goEewV
         oPy1VILSQGCwc11r6vmvxPPBQgvoWaHcfSzucncGfZCa9OYQLYbN/x32hsVO5mLtNzhk
         Tnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xs34HmB3mQxNQ3MLumY+2KQcgDnFTGSI4kG5G0wYBkE=;
        b=TenKk7frg1LDnsWWv42zgm8O653QZCkxUkvg9Di+HIZtIrciAiv/VnQUsGOFEn3swr
         qtDFGtpKUAob8GbJ3HZjelf/75I0AVLApY2ruGyFOpTTgttx/M0pZbRAZMhMK3qmCGf6
         wbuwkmwgSFftJJHHfQsXk1ixaCJ87NpWWEbVz6L8zub0T2K2hz9g/wIn70aF6cMxkG56
         DdM+zFnU88k1z5s8et0OHyTK3Wfa2wgvi++tJ6vHcn0/K13cHFCrcJOfZiMzTvwmzBjr
         Zixia5/gCu9RnClSoQw1ZvP9ugMQrnim1dd1SpvXG2CpK16oV7pe+jn7a2GoFOiASRXE
         qaeg==
X-Gm-Message-State: AOAM532+LbiXcLHLk8ikwbUdaNUrLB4Nql6KIEQopMZtZ3u+1WUIBxe9
        5ijZdnz9YX2nKJ3RD+Daujo+ArqisO9epI1IO0aZZw==
X-Google-Smtp-Source: ABdhPJwjeWPbD/dZXbSPnBJKZaQvd4USo4WUCxzx+qC69rVqMrvdlR4MAcWXbshhJpd9JhWv2OjJdw/mZvqpOBsdsiA=
X-Received: by 2002:a17:906:300f:b0:6e0:b38d:777d with SMTP id
 15-20020a170906300f00b006e0b38d777dmr14495463ejz.189.1649351201083; Thu, 07
 Apr 2022 10:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-10-brad@pensando.io>
 <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com> <3c8e94e1-fb8e-0d8f-4e79-b8313a1da5cb@intel.com>
In-Reply-To: <3c8e94e1-fb8e-0d8f-4e79-b8313a1da5cb@intel.com>
From:   Brad Larson <brad@pensando.io>
Date:   Thu, 7 Apr 2022 10:06:30 -0700
Message-ID: <CAK9rFnwsMd1+oQ8cg8Biw7HM=R6aOudfK7Ja+E+iGVgfrvC9Gg@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Apr 7, 2022 at 12:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> What is the relationship between cadence and pensando elba?

Pensando licensed the cadence controller, its 100% cadence IP.  The
integration issue we ran into was with the accessors where we have the
workaround.  The initial patch added a separate Elba driver file but
the feedback was the Elba support didn't justify doing that and to add
to sdhci-cacence.c.

Regards,
Brad

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC0744330
	for <lists+linux-spi@lfdr.de>; Fri, 30 Jun 2023 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjF3UaV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Jun 2023 16:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3UaT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Jun 2023 16:30:19 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3273ABD
        for <linux-spi@vger.kernel.org>; Fri, 30 Jun 2023 13:30:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a36b309524so1746544b6e.3
        for <linux-spi@vger.kernel.org>; Fri, 30 Jun 2023 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688157018; x=1690749018;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkEFnibQjHe9+QSD1TVIevJXwtQmVAtavn1QpGpWrOo=;
        b=AJ4/iImL9x+IdZwpbBe/C20HzATo1j/2yOb8bTR8JYFOlt+I+M3zxHBxiAp0uBXaSK
         p7R5xQzrjpCP59ezgIpfhkcLk0apwZGlp/c0lO9C9119qyzZSqa01n1bNCmHPGx36PKf
         s91bJiEZAzHDuooRD7xRZ4fL/GvStVTxm8NeK8nqsUUvVO+sKNpn7P2FDQyg92qG51P8
         sruhSbLhV23tD0GBhQU3xxzIMwLm6vVAcmm0r6mmPG6lxWgDT7p+kWYikfsEHfGCKlQS
         Na/BoB1V1pnY/M19UY0/rfFAqNNeI5i8+7gZSo7W0d+kpERJAby+/nvsAXfTm6vyqL6t
         6eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688157018; x=1690749018;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkEFnibQjHe9+QSD1TVIevJXwtQmVAtavn1QpGpWrOo=;
        b=W0prkN15DcwuTOrEKd3JhEAggBtUeK04Rr1uuC2d0ZEJZfi7ROEYCb11YP4FADhDzT
         8bYEk5UJDyIkgRhXmH3oXjE0OIQ3quXghlVsiODJIAncN6iNpE/1A5QjSi3AAb5WLB2l
         73eaa+1UiFDWv4LdIYBJk5j7nmXZZYfCESCQF0dwx5Nbqqgjg2TEmH+ylIjbhyL7/InD
         CeNr0s3xH344uxA7XRnVqz6PBGI5oDUS5iYxs174xZwEAP5XIsjIWnKKPtOiyU8WxCUg
         onw9fp5Q57rvysLgqSZanmXzjjpkH0SKJzPgYM0Wraw/C7sMAfROMUDw8uA7QonxUWEQ
         kSUA==
X-Gm-Message-State: AC+VfDwNrQCzV5RjZi4qqd92BTRyhQGkmB7CmGFfiXrA9hV5InZJtpFA
        7yhQdwKEpWz5gDSMHRaQ/NgmjdBmldxAF5/LxuA2pO20xsA=
X-Received: by 2002:a05:6808:199b:b0:3a1:eb47:a943 with SMTP id
 bj27-20020a056808199b00b003a1eb47a943mt4715086oib.10.1688157018100; Fri, 30
 Jun 2023 13:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230630202257.8449-1-jonas.gorski@gmail.com>
In-Reply-To: <20230630202257.8449-1-jonas.gorski@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 30 Jun 2023 22:30:06 +0200
Message-ID: <CAOiHx=k=tpAMmT0Z18UBjgPrJxoxJ8-kTFQme_sthdudbVR5wA@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: add myself for spi-bcm63xx
Cc:     linux-kernel@vger.kernel.org,
        Linux SPI List <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 30 Jun 2023 at 22:23, Jonas Gorski <jonas.gorski@gmail.com> wrote:
>
> I noticed the driver is unclaimed. Since I was the last one doing
> substantial work on it, add me as the maintainer.
>
> As it is only found in legacy products, mark it as "Odd Fixes"
> instead of "Maintained".
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Well, that didn't work as expected, I missed the part where
tocmd/cccmd is done per patch, potentially missing important
recipients. And it felt so convenient ... .

I'll send it again with proper addresses added.

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc201627c2e0..d12da512dceb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4169,6 +4169,13 @@ F:       Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>  F:     drivers/spi/spi-bcm63xx-hsspi.c
>  F:     drivers/spi/spi-bcmbca-hsspi.c
>
> +BROADCOM BCM6348/BCM6358 SPI controller DRIVER
> +M:     Jonas Gorski <jonas.gorski@gmail.com>
> +L:     linux-spi@vger.kernel.org
> +S:     Odd Fixes
> +F:     Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
> +F:     drivers/spi/spi-bcm63xx-spi.c
> +
>  BROADCOM ETHERNET PHY DRIVERS
>  M:     Florian Fainelli <f.fainelli@gmail.com>
>  R:     Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> --
> 2.34.1
>

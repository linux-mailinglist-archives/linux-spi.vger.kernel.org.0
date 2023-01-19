Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24EF673EB8
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jan 2023 17:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjASQ13 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Jan 2023 11:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjASQ1Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Jan 2023 11:27:16 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C57A533
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 08:27:10 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4fbcda8ddfbso21495657b3.2
        for <linux-spi@vger.kernel.org>; Thu, 19 Jan 2023 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9cZOLXE9Rt7cay1kOYQeGynPWNFeemf/Sd0cPM5L7dw=;
        b=d4q1mX9Tar6euCY+/x7rWi+HkA9ifmIQ9HJbt+aNgcVMTxzOoQIifc7fHMpBw8mOGC
         vVj97/L/lvGOSrZA9LPEtUZa0nkULGzeiS/ccLi7QWecDW6SxqCgB1xCVP8LA5tDTYVq
         fgIo9fqZag6x/C/AoBCtA77PMnxtM5qTIkAM+j94avdVyzYWthaM9ZBXhADQZ9kbzDIB
         LHDf5ajK9VUWnwIcZZEq+hf+skM34hkesUZ2/tgdCTt/wKnafZhQ+Y5E3TZUYpjKgMDw
         iiRua3FY140TfljdNf6GkOrIiCSlfVmuTYBmvXNB3sr8IlLbSZuLV6ZskSjAU9gtHreR
         73sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cZOLXE9Rt7cay1kOYQeGynPWNFeemf/Sd0cPM5L7dw=;
        b=l7NZfpfovykqhF5vzlsBSKjjIiq8e6bcNyh7QfMaFcDFErBM3QSQ+Hkwep/F1wk3Uv
         eYGPF5nTP+d0burQJd20dpWPOqV31ufWmfkfA1KCGxeCklj5NznR/mcao+gv6cOA+61p
         QvGK7y9+gKzHWrRqlCeb4wgwA1htW3p4edxxE8hpHPbaBzdUmr5jyuaRGBUbpn/oJO6B
         c9OhExw3bTCYtm9rlA+G+v1RkSvJPS/07ArBsQJIEZ4l8EZdJ75Ax8c0XzV8A8dJblG5
         6bs8W3cMs36DTKPixmaMpG4icIJh/Y574fTIJc2vcFpU64OvUcariog5/FaAryE2mh5K
         TPWg==
X-Gm-Message-State: AFqh2kq6gLOTkqn4jcJ/E96mfD1/jUDEfwk8v2fTHpLVQVLuqt9m3mpO
        yDxjHEKExWyosO0aguC2Jxk1B4ek+VqBM65j5S2i7A==
X-Google-Smtp-Source: AMrXdXtnv1RyES5uPuy0+pbO/A9Z0vWXXFYFR5GKkpOPtRWtgaQbMRYH8K4CP+CKO7hUgj5xHbuo5l0DstZCztxl5Zk=
X-Received: by 2002:a0d:cbcb:0:b0:4f2:1365:fa5 with SMTP id
 n194-20020a0dcbcb000000b004f213650fa5mr1253495ywd.279.1674145629769; Thu, 19
 Jan 2023 08:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20221212180732.79167-1-sudip.mukherjee@sifive.com>
 <20221218174523.cke7ubh6nycd247c@mobilestation> <20230104222036.h4ke6maxkdvuqtqc@mobilestation>
 <20230109162505.o3clvmwu3eremlyd@mobilestation>
In-Reply-To: <20230109162505.o3clvmwu3eremlyd@mobilestation>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Thu, 19 Jan 2023 16:26:58 +0000
Message-ID: <CAHyZL-foBcwQrMy1xAJ7LqnoB8B9DSxwtp6LtvLFBgVwC00avg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Add support for enhanced SPI for Designware SPI controllers
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        jude.onyenegecha@sifive.com, ben.dooks@sifive.com,
        jeegar.lakhani@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 9, 2023 at 4:25 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello Sudip
>
> On Thu, Jan 05, 2023 at 01:20:39AM +0300, Serge Semin wrote:
> > Hi Sudip
> >
> > On Sun, Dec 18, 2022 at 08:45:26PM +0300, Serge Semin wrote:
> > > Hi Sudip
> > >
> > > On Mon, Dec 12, 2022 at 06:07:17PM +0000, Sudip Mukherjee wrote:
> > > > The is v2 of the patch series adding enhanced SPI support. Some Synopsys SSI
> > > > controllers support enhanced SPI which includes Dual mode, Quad mode and
> > > > Octal mode. DWC_ssi includes clock stretching feature in enhanced SPI modes
> > > > which can be used to prevent FIFO underflow and overflow conditions while
> > > > transmitting or receiving the data respectively.
> > > >
> > > > This is almost a complete rework based on the review from Serge.
> > >
> > > Thank you very much for the series. I'll have a look at it on the next
> > > week.
> >
> > Just so you know. I haven't forgot about the series. There are some
> > problematic parts which I need to give more thinking than I originally
> > expected. I'll submit my comments very soon. Sorry for the delay.
> >
> > Good news is that I've got the HW-manual for the DW SSI v1.01a
> > IP-core. So I'll no longer need to ask of you about that device
> > implementation specifics.
>
> Finally I managed to consolidate my thoughts regarding your patchset.
> Here is the summary. Some specific comments will be sent in-reply to
> the corresponding patches.
>
> First of all there is a crucial difference between eSPI capability
> available on DW APB SSI and DW AHB SSI controllers:
> DW APB SSI 4.x:
> + Tx until FIFO is empty
> + No clock stretching at all

Thanks for your detailed review and all the additional details about
DW APB SSI. I did not have this datasheet to check.
So, that will mean I can remove the APB versiom detection from my next series.
But unfortunately, I don't have access to the hardware currently to
prepare and test the v3 series. It will be delayed a bit and I am
hoping I will be able to work on this by early March.


-- 
Regards
Sudip

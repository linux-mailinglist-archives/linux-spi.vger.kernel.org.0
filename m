Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6A66C2DB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jan 2023 15:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjAPOzI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Jan 2023 09:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjAPOyN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Jan 2023 09:54:13 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D6233F3
        for <linux-spi@vger.kernel.org>; Mon, 16 Jan 2023 06:43:19 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a40so211557uad.12
        for <linux-spi@vger.kernel.org>; Mon, 16 Jan 2023 06:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrkHVNRmnhZL9c7e/tiK9zbteggD/bg2MaRxrtXICaA=;
        b=4hi68ap0w5TIliRa6FiT23ev6Yly6wfrRSYwDoOCoStkCiquhU9FZNpG8MYx+xhxp2
         B699t8NGWIyLGkZMc19aTewjSSwoO/KDMSqHMfXUBeWUUxq3zJtjE+/AAhaBrW4nJbOF
         Tp2TTirxp/AQcXahLlJe5a15vd3rmCxkISToBZXO8v8wIv8f3qwMsCIL6ZaXGdM7//po
         xec5EGqZSJFDy80Prpnytz7R3WV9o4mTvvGyju/ogWcAwmKLZlua9yvTAG0dCWexU9mj
         jNksVAB7Muc9KNbQDOtmEG1iJUu0W8D4Tbf6PX/i0Bz4pK4oXhhk9ui/tKq/X7IGDEn9
         7rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrkHVNRmnhZL9c7e/tiK9zbteggD/bg2MaRxrtXICaA=;
        b=FQaU5/V15MS0aa+tz+3agEgY4kRc94gKkJ7kofLfbphVitJZxAgNn2+alRmDupszMf
         Io9H36i0zqtwKy2BcXUwZqRLU7OmX3EcUAR2EzfpmN4ZLnvUZgV43muajIYZo0Th4p5F
         sPdw5oq1Iv+/2DpB986DwVkl6+qQum8e5xzJOGZvG/qyEC4ilnBq9aRTUrjqor/SABqV
         XvnC8uyIbqOmV/vfTRVnhhJM3I1TKZ7hFHdhw4sz2CSIK6kCbASR299Fg2Pe7P5eAzvs
         45eSSro4l/MOj/zaSK7xBDyGHlcoLljdxYhNLFXc2ykWpAKsfUR/6WFSpMgR1QRHP4SX
         evHw==
X-Gm-Message-State: AFqh2kqVjL6iNeYEBZkSa/kGM0JgeDSiHXmgZGEyHPr3oiB6d67tGkPe
        0XXqUpQXSsEyxdH3AbavHf8nc2JDhSH67Hq4UHSPig==
X-Google-Smtp-Source: AMrXdXtyMquODUcwF8GI68Qc/1WycAYd52xwMGrrUlIOZhID3X1ycKOyqw6fPA9YoJfhslIgO5oXJDlTg8skb6vnyoo=
X-Received: by 2002:a9f:362c:0:b0:5d2:c6ce:7c41 with SMTP id
 r41-20020a9f362c000000b005d2c6ce7c41mr4591111uad.112.1673880198144; Mon, 16
 Jan 2023 06:43:18 -0800 (PST)
MIME-Version: 1.0
References: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
 <CAMRc=Mc5YgWqRsmw=n6EV8PW5OZfMZYotiqSy=gSvHH1PbVN4w@mail.gmail.com>
 <CACMJSesujoLTRFXMRuA2tBAJhainmy6-CmoeuO8OwW9VifaiKw@mail.gmail.com>
 <10740fc72ae6fb7aeb7d5ea243495bc225ca656f.camel@toradex.com> <CAMRc=Me0ewbyGi+e2mxijsvLUqUZSF5nNCtUfONT2-q=U0VCLw@mail.gmail.com>
In-Reply-To: <CAMRc=Me0ewbyGi+e2mxijsvLUqUZSF5nNCtUfONT2-q=U0VCLw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 15:43:07 +0100
Message-ID: <CAMRc=Mc36r-Qoq3HDhhVqF+OOQ9YSfsw1wddnXfHFmjL32Q=1g@mail.gmail.com>
Subject: Re: spidev regression in 6.2-rc kernel
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>
Cc:     "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 16, 2023 at 2:45 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Thanks Max, that makes sense now, working on a fix.
>
> Bart

Max, Francesco,

I've sent out a fix, please give it a spin and leave your Tested-by if
you don't mind.

Bart

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB82831EB
	for <lists+linux-spi@lfdr.de>; Mon,  5 Oct 2020 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgJEI0j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Oct 2020 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgJEI0i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Oct 2020 04:26:38 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE1C0613A8
        for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2020 01:26:38 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 5so3769373vsu.5
        for <linux-spi@vger.kernel.org>; Mon, 05 Oct 2020 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41Y6sjMmjcMlV2JauZyN/TxOh6umZ/keewCU2mb8LIc=;
        b=AXAmvxEcZgWulidtPjWzcdr2Qm2OYOtZA0wDa8FmovT91MPeLRIwIVCT8lx9v5UNlG
         SctQfxm1GmrUHlaNPX+RFUQtBHXdidJ0/CU1C9clQS0l30cTxEkteaWVnvPQuLuFSdee
         4MV2Fpon9L5TsVQGS1K3gSKttvhofJOiwA9P0bVAeb/tNn5WAcwRk5Be/IAOdU2QkdYn
         VFrey16k5OCZxA1L7Q1xqspPxsd/+WYGgx9scKUGZYuyhxSBuKF1PhH1KfSOoQx2J5OY
         401UuKSNx0/BKxG4Vky36hMzFvsFJwDUWIuAQewHgLK5qqZWGGWEkqztdK9+VC+FKpcj
         S9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41Y6sjMmjcMlV2JauZyN/TxOh6umZ/keewCU2mb8LIc=;
        b=FKV0eoKuCgDVoDZSCqy2gGItJE9PddiMi/WG6jabmggVgaPNIvPB+3R823uMd4k/vg
         pkmHAn1iHfworQny56TexfIgCBqaH+YRDy7jTw9FLz+NBfO/VZudEvK9PDR79ABR5q4Q
         QO2gS9qGVaUOHcVYSR412p6uQ7/gIrtSzN7ULHizrNp2H8iydaMyCqsbqYXxfJkGwvpu
         CanlLvJLCb6JygGflZS0u3cv65scrNS+jS6Ezuftx5Q4McVhiuwhooxS2l+fid6ml85w
         ofBC6ikwOBv6uoMzH3EaOCk7pEKJlAi9gFomB6Kk9f60qN1wUXN36LvjeVCSgogggILa
         kBnA==
X-Gm-Message-State: AOAM5333RMp8+k75wmpikAohx8NH/Y0AA+eeRyynV9zy1Ad7F0iRLoqU
        eMF+bHyYV+9F3SMVqsWRtUmf9+GaGExSK4rwooApCg==
X-Google-Smtp-Source: ABdhPJxlPMGygHVTcnGIf5MQvmk2y9YM/OMFZ7y/LPtKUwwQZxTgA80YvlEMQPDfoWIYZailBQzIdWarus99WB2IvNI=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr6751269vsp.34.1601886397228;
 Mon, 05 Oct 2020 01:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201002234143.3570746-1-robh@kernel.org>
In-Reply-To: <20201002234143.3570746-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Oct 2020 10:26:01 +0200
Message-ID: <CAPDyKFq=ZUiYhm0-K5ZVYS1FH2O5e-+Gt6Dftf=LmL9ABa7CaA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Another round of adding missing 'additionalProperties'
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-spi@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-leds@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mips@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 3 Oct 2020 at 01:41, Rob Herring <robh@kernel.org> wrote:
>
> Another round of wack-a-mole. The json-schema default is additional
> unknown properties are allowed, but for DT all properties should be
> defined.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-clk@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: linux-leds@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>
> I'll take this thru the DT tree.
>

[...]

>  .../bindings/mmc/mmc-pwrseq-emmc.yaml         |  2 ++
>  .../bindings/mmc/mmc-pwrseq-sd8787.yaml       |  2 ++
>  .../bindings/mmc/mmc-pwrseq-simple.yaml       |  2 ++

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

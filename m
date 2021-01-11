Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FF72F1B5E
	for <lists+linux-spi@lfdr.de>; Mon, 11 Jan 2021 17:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbhAKQr6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Jan 2021 11:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388829AbhAKQr5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Jan 2021 11:47:57 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC331C0617A2
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 08:47:17 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a31so29382uae.11
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQTCUBSd32PPGYWf+4NIALcXpFdvaLx7ubBy6PwA+oo=;
        b=dV4BlOFvq3NnHp1B03OjVOTUkXxDivdCZzUxDmW4DhWl6JK6pz/TMEZzznL40CNtlU
         qTyNX4XXjyD4aWzUANyL5M3W32syMhp1DThb4pUUuqAM0FwZhL67S1aeDy5vDZDwNy2n
         0n7glfkziSL5hW3iiaR7wq4xhfDKi5Lv9eZxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQTCUBSd32PPGYWf+4NIALcXpFdvaLx7ubBy6PwA+oo=;
        b=ozIcudyQeH3eTuGwJjGxAlwo3RPJuWMR/POT9DvKuJ6nGtSPpvLXCdXu9ZiSf6FSEJ
         uoMxirRkoBJUydb0ZHmLHA+J/byKSXZrHKP3rQXun5RkorSX+dc9XsWopxTWkmgCsS1X
         McIHDRZhnBlrYAROgJHhVQNkHjEP2QZesjDO4hnqbdXgQg8Ve/YYynzgCo/JQjAN6/CZ
         VBRKc3YkqM9dfG7+5B6mglKPOz3D/qeMK+wX5hkd36q7HUukNFLgLCwE+PeBa4e97cB+
         6wCXcjkczMkTdCfGPqcHUNtM9KdQ2wfTuPBvwKLYU0GmMRU84gTv3iacD+DCMhwSL+Q7
         AmVQ==
X-Gm-Message-State: AOAM532NXYq2zBds91Eio3OLkrXLlOZM4eQVKZtF0FVZpgTfgp5qn1jd
        ++qXFboUeHlc9NJQ9lEPOOjSLKvQjg3wFg==
X-Google-Smtp-Source: ABdhPJxnV/OxjYT6ckPWvL31Q+ALS2FmE7feK3kCuu4U4om3xxK69m2jCibTgv8PKARJZ0fr4/3TBQ==
X-Received: by 2002:ab0:6386:: with SMTP id y6mr428214uao.14.1610383636578;
        Mon, 11 Jan 2021 08:47:16 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id f70sm52797vke.56.2021.01.11.08.47.14
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:47:15 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id u67so4380131vkb.5
        for <linux-spi@vger.kernel.org>; Mon, 11 Jan 2021 08:47:14 -0800 (PST)
X-Received: by 2002:a1f:4582:: with SMTP id s124mr621617vka.7.1610383633600;
 Mon, 11 Jan 2021 08:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20210111151651.1616813-1-vkoul@kernel.org> <20210111151651.1616813-8-vkoul@kernel.org>
In-Reply-To: <20210111151651.1616813-8-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jan 2021 08:47:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UPNnSmgJM33QjAb4VvTe4Xs-OHcQCkk5E+o3u+afjbjA@mail.gmail.com>
Message-ID: <CAD=FV=UPNnSmgJM33QjAb4VvTe4Xs-OHcQCkk5E+o3u+afjbjA@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sdm845: enable dma for spi
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>, linux-i2c@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Mon, Jan 11, 2021 at 7:18 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> @@ -2622,6 +2626,13 @@ pinmux {
>                                                "gpio2", "gpio3";
>                                         function = "qup0";
>                                 };
> +
> +                               config {

Convention in Qualcomm device tree files seems to be that the node is
"pinconf", not "config".


> +                                       pins = "gpio0", "gpio1",
> +                                              "gpio2", "gpio3";
> +                                       drive-strength = <6>;
> +                                       bias-disable;
> +                               };

Pin config almost never belongs in the SoC dtsi file.  This should be
in the board .dts file.  What if pulls are needed on some pins?  What
if you need a stronger or weaker drive strength?

-Doug

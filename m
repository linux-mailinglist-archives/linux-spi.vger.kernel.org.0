Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65641521AF
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBDVIB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 16:08:01 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37037 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbgBDVIA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 16:08:00 -0500
Received: by mail-vk1-f195.google.com with SMTP id o200so5620494vke.4
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tav9xQOCZwkuANMiV8MFJGLOVoVF6jN2hQatuYeWYMY=;
        b=crTZsnwq4J41vNDWJH/aaqvEG6L4Kx3l3lckX1j/olViQLFgMytNbzfeQJ34/O6n0I
         YtQSWStCH/JKdUlr3xEow4iTzD/wTz+YG/oFH7gUI3x2zV4rf7lSFfkDpVlXHGvaIuwd
         EK3Bnvhh6ZcfTQbOK2uFTtv1dch+fO6x9YPZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tav9xQOCZwkuANMiV8MFJGLOVoVF6jN2hQatuYeWYMY=;
        b=mrhMLI2TvLelJKCdUc8Ay9QMzakUVcVJhmlhYpXtKttAF9niWqrXcerkSp8GWPRfKt
         PdgKFvt+9yrQvUBGAKY5Xad7aN5DU0xhta10qh6C2XF1MoeciVpsdEx5oCq757uazTUf
         Bh8CDCC0m7rrzMEWsLyKxtvxVmh01Qq3/uBSsDSm9geUG6Jx0i6yWDIhlix24ljiKF2a
         nml/JHcJ+QkXF6G6Mc+xPcUgqZ9CHzvIcPIi9FlSnYNrQYp2NLUwtDZWPUdXrEL3ixIt
         BdGYXqYDlM+OaNjldpF0TGevtbwUc7uWzwO5CQvdEUFIIdK43rVKMr9vFXdUMDMPYpHS
         TGOg==
X-Gm-Message-State: APjAAAWVlb2o0i+nhwWYwV/Rov8aSZ8+a262E9rtqwwk9D9mX+i3a9gW
        1/jBfMEY0Cy+b5n2ChWQa4XZZlOgIYw=
X-Google-Smtp-Source: APXvYqzjVnCO9tT2Dw0YMeK8s3kcQgN+jOd3aXlL+D5CYIRHVsoIgogmJh/YlqzzuopWSmtYH6Sv6A==
X-Received: by 2002:a1f:2287:: with SMTP id i129mr18445730vki.2.1580850479437;
        Tue, 04 Feb 2020 13:07:59 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id o68sm6660938vkc.53.2020.02.04.13.07.58
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:07:58 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id r18so12437400vso.5
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 13:07:58 -0800 (PST)
X-Received: by 2002:a67:ec4a:: with SMTP id z10mr18801232vso.73.1580850478221;
 Tue, 04 Feb 2020 13:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-2-swboyd@chromium.org>
In-Reply-To: <20200204191206.97036-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:07:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V2J+TDcydNUx5nbee9794ONyW4yBCcck1ADu2cWeWYnA@mail.gmail.com>
Message-ID: <CAD=FV=V2J+TDcydNUx5nbee9794ONyW4yBCcck1ADu2cWeWYnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Let firmware specify irq trigger flags
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> should take care of this for us. Just use 0 instead so that we use the
> flags from the firmware.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

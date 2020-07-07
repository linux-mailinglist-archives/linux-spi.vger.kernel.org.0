Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA04216D2F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jul 2020 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGGMxS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jul 2020 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGMxR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jul 2020 08:53:17 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E96C08C5E0
        for <linux-spi@vger.kernel.org>; Tue,  7 Jul 2020 05:53:16 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so29333599iob.4
        for <linux-spi@vger.kernel.org>; Tue, 07 Jul 2020 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/YoIMP8c0HJJ+S49WYxsGpiCi+NvL2ww5EeAkEmXVI=;
        b=QFqebrYRDiE5dakUbLufOg818o7Ardt+uJugcI+HpLGySh/41S/8TV1nwhSvhjJHxB
         fTXUp6ton6DMP73OMpTlt1paFI/tftk2v57nIYzrWiXqr/kgOcTawXr0fhF5l/f7cXjt
         0EMSwLaZZMeAml961G+ZnI41KTQleHHP2Zftc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/YoIMP8c0HJJ+S49WYxsGpiCi+NvL2ww5EeAkEmXVI=;
        b=koGi4AgCGHqLViaVrcArEHcbN4MUwoRbEnnFFgj2fA66ulhaN3s+rRpxeyhOEk9sxw
         WFlFZMwnXQ8oYnn2VrVO6/rkT2vq7lw1pdIW4Pe6kHNldKorKrO0Hm8teaZVZT+QlVXu
         LwVdk4QHZxl4SCd3NkEdk9e9zPIJDJpkK6y7LQI7XijsJTRQ4YqE8aAZgffxxIbdljrI
         JVTZcUqjmcyMpCeJxfEyM9w9yHGHYGL4jd25eqeezOFC5ppTYsmIjZImsaIrcsVK6jko
         amAHah2QxYPHw6LSb8jUv0mkJuy0gDPbHYB+a6xKchBObzln3g7LYeQVmGFyHaM1hlNV
         5H7w==
X-Gm-Message-State: AOAM530RokGuRDjLYSF0nzejS7HWMg0ZxRTpFup4XoT7gg8bIY6SXvbG
        uc2vkU5WPLcOUXQrNrYfZDWU5yg/vAs=
X-Google-Smtp-Source: ABdhPJxH2kC3Ny2tCavmyNSw1JWvv6l2d6juryTpe9klNlZgtx40NjeIVH4hIEnDj4MjCBcWdX2d8A==
X-Received: by 2002:a05:6602:6c4:: with SMTP id n4mr30706847iox.202.1594126395946;
        Tue, 07 Jul 2020 05:53:15 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id r6sm12745140iln.77.2020.07.07.05.53.14
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 05:53:15 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id d18so900173ion.0
        for <linux-spi@vger.kernel.org>; Tue, 07 Jul 2020 05:53:14 -0700 (PDT)
X-Received: by 2002:a6b:5c07:: with SMTP id z7mr31742004ioh.140.1594126394129;
 Tue, 07 Jul 2020 05:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid> <20200707120812.GA22129@sirena.org.uk>
In-Reply-To: <20200707120812.GA22129@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Jul 2020 05:53:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
Message-ID: <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        ctheegal@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Tue, Jul 7, 2020 at 5:08 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jul 01, 2020 at 05:45:07PM -0700, Douglas Anderson wrote:
> > Every SPI transfer could have a different clock rate.  The
> > spi-geni-qcom controller code to deal with this was never very well
> > optimized and has always had a lot of code plus some calls into the
>
> This doesn't apply against current code, please check and resend.

As mentioned in the cover letter, I posted this series against the
Qualcomm tree.  The commit that it is fixing landed there with your
Ack so I was hoping this series could land in the Qualcomm tree with
your Ack as well.  Would that be OK?

-Doug

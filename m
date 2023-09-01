Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41978FAE6
	for <lists+linux-spi@lfdr.de>; Fri,  1 Sep 2023 11:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbjIAJei (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Sep 2023 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348828AbjIAJeh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Sep 2023 05:34:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1E710D7
        for <linux-spi@vger.kernel.org>; Fri,  1 Sep 2023 02:34:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso32072821fa.1
        for <linux-spi@vger.kernel.org>; Fri, 01 Sep 2023 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693560873; x=1694165673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XirWmBwg/Ps6jm5whQ65EEWIWZF91+vzUx+/E2s51pQ=;
        b=J23iZpJkES/VUJ7DNJV096hgvdn96ucer08ETRghheKoBcRJNVf2VzUPaXFPTsqG52
         6uRZAqOQpI7OdFD/NN8XyhrtrTWSrVPfYU33KunwCKETuGrevhUkqHkYrXgw3zNtZqQe
         WCXR0HncPdKbEfKLcMdwvUwVFaqj2XxWHY7jd1BEi8scUiTnHXy2oEwPcbC+wZC/SiU2
         IWFVjmj+eRX1MDEC3+qUM/QHaXN2TtCJTUiyOw780MTrGUAilxaj3CUDO7Ba/EM7IeE6
         Pf+0zkq7W65efB5QdeEs1w14tLGoe0kQLcMIebqUPaViSHNNwz8Tcfh9YJ2AuWs7oDGm
         CGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560873; x=1694165673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XirWmBwg/Ps6jm5whQ65EEWIWZF91+vzUx+/E2s51pQ=;
        b=ORHnSgE9Vfqu0AmLv9EM4x6Sg5A0N4dJR3qL77zmp3RjuBDqO63LASUTjr6dChfYUc
         mui2J34SKOeHWf7oEAPVwg8VfLfA5IgYS10iBGbzFdn+gGn/lm6iXE6JZDW8JZwoluxh
         mPG9K7fMmoP/u1vnzIvsbFUXG4KE7oPlu8+BhDWrXab3ZDkzvWYgbqELSQD6jsIj65q+
         QtTjXbCQJQ28KTv1iB0eJZwjiN6qpLc+Ljs2d3ureLcfZFcglqq4E/bbCslEVtf54VC3
         NFicurblOWrph62oFz5R4Mz4vfBXEQ3/aEPs/anvcVtitARYjnD7qZvehVMhaSRbNM3x
         nZgA==
X-Gm-Message-State: AOJu0YzEcDIXCXGGpS41HJcNL+TZndF4UXBsnqVAOyaV66/Oe/TBzUnI
        Ms6FM9hWD5SC9R8hMqE4pyBX7NSHJS7c9IqgZQhwag==
X-Google-Smtp-Source: AGHT+IFUWbRjlXU+fqBN7/hSZyksdmm1qMKqdHFpEmgoh4f1PYmGNp7sg7sgvJA3SvmREz9zF2NQrIifQ15n4XazxZI=
X-Received: by 2002:a2e:9619:0:b0:2b9:ecab:d924 with SMTP id
 v25-20020a2e9619000000b002b9ecabd924mr1338502ljh.18.1693560873039; Fri, 01
 Sep 2023 02:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230831194934.19628-1-brgl@bgdev.pl> <ZPEhS0uBWABpaE+/@smile.fi.intel.com>
 <CAMRc=Md-6i+nqDtYiUUtZExA32c0nJxhevYsiZqmd1PP8aaMng@mail.gmail.com>
 <ZPGnFHgtK1wE6Ppf@smile.fi.intel.com> <CACRpkdbGdCFb9a5bV_aBMd3eee3N5EdWy+Bkpct-YfHUgHysVw@mail.gmail.com>
In-Reply-To: <CACRpkdbGdCFb9a5bV_aBMd3eee3N5EdWy+Bkpct-YfHUgHysVw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Sep 2023 11:34:20 +0200
Message-ID: <CAMRc=Mc4-TUOSJUguT0mPfoMHo3W8JHGscWGga1NwdoHPCdgeg@mail.gmail.com>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 1, 2023 at 11:22=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Fri, Sep 1, 2023 at 10:55=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> > > I'm not sure this is a good candidate for the GPIOLIB quirks. This is
> > > the SPI setup callback (which makes me think - I should have used
> > > gpiod_get(), not devm_gpiod_get() and then put the descriptor in
> > > .cleanup()) and not probe. It would be great to get some background o=
n
> > > why this is even needed in the first place. The only reason I see is
> > > booting the driver with an invalid device-tree that doesn't assign th=
e
> > > GPIO to the SPI controller.
> >
> > Maybe Lukas knows more?
>
> He does!
> The background can be found here:
> https://www.spinics.net/lists/linux-gpio/msg36218.html
> (hm this "spinics" archive should be imported to lore...)
>
> Yours,
> Linus Walleij

Thanks! I will fix the patch and add this link to the commit message.

Bart

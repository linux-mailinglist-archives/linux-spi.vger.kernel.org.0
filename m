Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D363753AB
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhEFMSU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFMST (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 08:18:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8142CC061574;
        Thu,  6 May 2021 05:17:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q2so4930823pfh.13;
        Thu, 06 May 2021 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9qGhux9uV3p7YMDVV2UIEYRyjKzHm/Qxkdk6B58HDWg=;
        b=aChKhmiqNG3NNR32W5zS2h3BhcyuqE+9Ofsi0fG14MUCWv95sbpBDqvzphTdxeb4lb
         Ss0/rTbTLq2mNmCw39St2yYBZtQsss4/1whVE+KV87UkVJSy8hlUkkvpS8hvX5Kw5mRi
         5kkMQwOr0XfBvimZPelelTEl+dW1usTyanvHziwmC418xp2mL5vv/OBqGa34YN9WO7Jb
         vJIcFX3tKF7Io2jrdXNMah33mQo4bRG7MQ4sPV9lbW/yO4iivc8ILbdwVci2jPJ061OV
         axgu2UwFIdhisooup1lzWsJT17WsJYs0bkubzdTJqn+6s4mkNxW27ny/jVzzSZKq1l86
         kTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9qGhux9uV3p7YMDVV2UIEYRyjKzHm/Qxkdk6B58HDWg=;
        b=igWAc4ZnaIgrztyC9wKYYoz9CBd61YljtWTCjiWjDWOEqvUToD07+3PiMEI+FlJ2Le
         T5ZC+3MQDbo0WDdRRahI4EpDNvlwgf0e3ZeUrqmggRNdYf2LGWiFyArl7NBhBeN77axr
         3C3Np33VjmXh41Njiec2+y8pPpFanRmBhpjIB5Qgz15okq++GHhHG/uoByONCOVfO4Po
         ouIY/eD+Ufe5bQqzxPhakPfPXLIT+oLSjVv7Vo5EEjsxamRAPrmp06tUdGP3Dv+ja5iO
         Ne0DoggpzbST999vYOLJNTsVoSvNxkZSd1pPn+D+HS1PARnmA3BaCNpgjnBHhufZMD3Z
         XEFw==
X-Gm-Message-State: AOAM5330eS6B//6d0zT8zwZdh1BOVTB45/oXT545c6nFeb6zZfNzib3M
        IwbxjiLSvBGZm1Gr4I6li2dJQMXOZ/3qPLeDdxI=
X-Google-Smtp-Source: ABdhPJyEGAXFCv+6stiNkyCv3dEt2Sc/MfHoaTQBq/p4OKTwVdeyKK/lizfKvSlagkQREd7x0kwaFaLZOGL5Ryzekhw=
X-Received: by 2002:aa7:8e85:0:b029:28f:2620:957e with SMTP id
 a5-20020aa78e850000b029028f2620957emr4292467pfr.40.1620303439937; Thu, 06 May
 2021 05:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <1620270017-52643-1-git-send-email-f.fangjian@huawei.com>
 <CAHp75Vfr8t9UVqVn6hLSN6Mi3=iNAn612eE-qKq9HfrwNhpg3Q@mail.gmail.com>
 <CAHp75Vei0QGaKiq5Nai7Gsa=jcMSipaXV_6qZbBy=f0OrN=DHQ@mail.gmail.com>
 <e919da77-a664-d78b-2c47-cc9ba8745a72@huawei.com> <CAHp75VdPYGLmDkmKETBHWLOQVHwZAdbk4wBtzMjXcX223eH1-w@mail.gmail.com>
 <CACRpkdYR99SRgDJEK6e-eT86hBOxz-Ym5pf8Zn+0k4u+i=nfOA@mail.gmail.com>
 <CAHp75Veoqnd3Hgzq8DAz-_=QxMt-+r608dkzPp67YA5eitLJNw@mail.gmail.com> <20210506113430.GB4642@sirena.org.uk>
In-Reply-To: <20210506113430.GB4642@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 May 2021 15:17:03 +0300
Message-ID: <CAHp75Vf3yvSJUcmugjs8mcbnRa=PPviqqSrgB+Yyq6QV+J+Sbg@mail.gmail.com>
Subject: Re: [PATCH 0/2] spi: Correct CS GPIOs polarity when using GPIO descriptors
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jay Fang <f.fangjian@huawei.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "huangdaode@huawei.com" <huangdaode@huawei.com>,
        "tangzihao1@hisilicon.com" <tangzihao1@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 6, 2021 at 2:35 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 06, 2021 at 02:24:17PM +0300, Andy Shevchenko wrote:
> > On Thursday, May 6, 2021, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> > > Curious that ACPI has SPI CS as always active high,
>
> > Here I didn=E2=80=99t get what exactly you are pointing out. GPIOs are =
active high,
> > due to historical reasons. Otherwise SPI CS depends on the actual hardw=
are
> > and may be (most of the cases?) active low.
>
> SPI chip selects are almost always active low - the signal is often
> written nCS or /CS for that reason.

Exactly, and it's not altered with ACPI. That's the whole point of
keeping it active high for _GPIO_ CS case.

--=20
With Best Regards,
Andy Shevchenko

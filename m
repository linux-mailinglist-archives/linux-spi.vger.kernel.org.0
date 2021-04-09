Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA592359891
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 11:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhDIJFc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIJFc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Apr 2021 05:05:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D90BC061761
        for <linux-spi@vger.kernel.org>; Fri,  9 Apr 2021 02:05:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p23so1916029ljn.0
        for <linux-spi@vger.kernel.org>; Fri, 09 Apr 2021 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Diu26lQeyc9P30LZFZqyI13l/S31KxD5z4XWDOuH4g8=;
        b=qERsISDlAU/QOVO75hzThfBtSMeroZxxnjblbrgURP4R2TDm1x0A7b8Dc27BY0Jtyw
         UrbSmqFt4gZo47ulHn+1RV7RF7JYmm6OzbUpAIZf3X7SK341PuXhYT3It1fINRnlz6Wi
         HSpj5ivgzBbRfB9g+uP/d6IbtRfGOMFILLKMyAJ8843uEsVQR8GodsRNZTJ5Mww0aJYw
         o4+voc/hj6ou6zm8uP+gcCd7hfQ49QBW+Av5UPmc7QpQdoOIG56OZLxnkz34sNKaSy8e
         dZtN2n47F6NeAY+feM8GVHMmYCwSQiFV60IHITad2s9qs73k3ERomNerayWcRkTzki0v
         G69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Diu26lQeyc9P30LZFZqyI13l/S31KxD5z4XWDOuH4g8=;
        b=IuH6Dw01Ccq6IMxQLvWihdmSPAT0rcS3d8Uct2CzvGt9enqzBwfRrQXOlPpTKccakJ
         3ldCeh+RZQwuZMDjns0zZHx6jrHUWZquWG+CXy3x4z8/S8nVosw/+FqjRAmsDNhX+Ny/
         Gitx1bfHf4HgS/XkSAZazSIg4ioIt8oj+PvWMb5FBVIfN7h+9jLeWjmJxkxEUJ4bNA8b
         qlLKwXBqOTgyCNpUOETkIhdJAz0TMLtdysR+L9tO/k6VFwW/aK7d6f/FOVQj9F8cqcXe
         1NWMfdOi1HbFpIuDFbACIoc+eWxKq4CdkB56LCDU6Fb7mSwHoB3l1yUdU3Wz3Gkjad+i
         kQgw==
X-Gm-Message-State: AOAM533NmYc9pEZ+OWJZEiZGI/FDpQhcO3TKGAjiLrEEOogGYIIXmc06
        4D1LffRtz6UZTlRj5OEGkDJsUDp+wkHqvPWLnj8VyHjTM8jqfMtl
X-Google-Smtp-Source: ABdhPJwaVZc0tYy44wzKUDea7qRugvOw/yWDaetLR7bc9J6yrtNr9rrIY8blj73ciqmYIq9llziS9quXTXF0uV6EiVQ=
X-Received: by 2002:a2e:b014:: with SMTP id y20mr8760575ljk.464.1617959117051;
 Fri, 09 Apr 2021 02:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210407095527.2771582-1-wak@google.com> <CAHp75VcRE3JOyFEMzvP9RW1du3cXx3zaTq-8KJnGt9zaJeiJZg@mail.gmail.com>
In-Reply-To: <CAHp75VcRE3JOyFEMzvP9RW1du3cXx3zaTq-8KJnGt9zaJeiJZg@mail.gmail.com>
From:   William Kennington <wak@google.com>
Date:   Fri, 9 Apr 2021 02:05:05 -0700
Message-ID: <CAPnigKnV+=X9jn+iD2-DemfujRobANcL1NztXQjp_PeGbkWejw@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix use-after-free with devm_spi_alloc_*
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For the header file comment? I think it's actually backwards since
`devm_allocated =3D true` would indicate the device is managed with
devres. Should I send a followup change or v2?


On Fri, Apr 9, 2021 at 12:20 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Wednesday, April 7, 2021, William A. Kennington III <wak@google.com> w=
rote:
>>
>> We can't rely on the contents of the devres list during
>> spi_unregister_controller(), as the list is already torn down at the
>> time we perform devres_find() for devm_spi_release_controller. This
>> causes devices registered with devm_spi_alloc_{master,slave}() to be
>> mistakenly identified as legacy, non-devm managed devices and have their
>> reference counters decremented below 0.
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 660 at lib/refcount.c:28 refcount_warn_saturate+0x1=
08/0x174
>> [<b0396f04>] (refcount_warn_saturate) from [<b03c56a4>] (kobject_put+0x9=
0/0x98)
>> [<b03c5614>] (kobject_put) from [<b0447b4c>] (put_device+0x20/0x24)
>>  r4:b6700140
>> [<b0447b2c>] (put_device) from [<b07515e8>] (devm_spi_release_controller=
+0x3c/0x40)
>> [<b07515ac>] (devm_spi_release_controller) from [<b045343c>] (release_no=
des+0x84/0xc4)
>>  r5:b6700180 r4:b6700100
>> [<b04533b8>] (release_nodes) from [<b0454160>] (devres_release_all+0x5c/=
0x60)
>>  r8:b1638c54 r7:b117ad94 r6:b1638c10 r5:b117ad94 r4:b163dc10
>> [<b0454104>] (devres_release_all) from [<b044e41c>] (__device_release_dr=
iver+0x144/0x1ec)
>>  r5:b117ad94 r4:b163dc10
>> [<b044e2d8>] (__device_release_driver) from [<b044f70c>] (device_driver_=
detach+0x84/0xa0)
>>  r9:00000000 r8:00000000 r7:b117ad94 r6:b163dc54 r5:b1638c10 r4:b163dc10
>> [<b044f688>] (device_driver_detach) from [<b044d274>] (unbind_store+0xe4=
/0xf8)
>>
>> Instead, determine the devm allocation state as a flag on the
>> controller which is guaranteed to be stable during cleanup.
>>
>> Fixes: 5e844cc37a5c ("spi: Introduce device-managed SPI controller alloc=
ation")
>> Signed-off-by: William A. Kennington III <wak@google.com>
>> ---
>>  drivers/spi/spi.c       | 9 ++-------
>>  include/linux/spi/spi.h | 3 +++
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index b08efe88ccd6..904a353798b6 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -2496,6 +2496,7 @@ struct spi_controller *__devm_spi_alloc_controller=
(struct device *dev,
>>
>>         ctlr =3D __spi_alloc_controller(dev, size, slave);
>>         if (ctlr) {
>> +               ctlr->devm_allocated =3D true;
>>                 *ptr =3D ctlr;
>>                 devres_add(dev, ptr);
>>         } else {
>> @@ -2842,11 +2843,6 @@ int devm_spi_register_controller(struct device *d=
ev,
>>  }
>>  EXPORT_SYMBOL_GPL(devm_spi_register_controller);
>>
>> -static int devm_spi_match_controller(struct device *dev, void *res, voi=
d *ctlr)
>> -{
>> -       return *(struct spi_controller **)res =3D=3D ctlr;
>> -}
>> -
>>  static int __unregister(struct device *dev, void *null)
>>  {
>>         spi_unregister_device(to_spi_device(dev));
>> @@ -2893,8 +2889,7 @@ void spi_unregister_controller(struct spi_controll=
er *ctlr)
>>         /* Release the last reference on the controller if its driver
>>          * has not yet been converted to devm_spi_alloc_master/slave().
>>          */
>> -       if (!devres_find(ctlr->dev.parent, devm_spi_release_controller,
>> -                        devm_spi_match_controller, ctlr))
>> +       if (!ctlr->devm_allocated)
>>                 put_device(&ctlr->dev);
>>
>>         /* free bus id */
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 592897fa4f03..643139b1eafe 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -510,6 +510,9 @@ struct spi_controller {
>>
>>  #define SPI_MASTER_GPIO_SS             BIT(5)  /* GPIO CS must select s=
lave */
>>
>> +       /* flag indicating this is a non-devres managed controller */
>
>
>
> Isn=E2=80=99t =E2=80=9Cnon-=E2=80=9C part confusing a lot?
>
>>
>> +       bool                    devm_allocated;
>> +
>>         /* flag indicating this is an SPI slave controller */
>>         bool                    slave;
>>
>> --
>> 2.31.0.208.g409f899ff0-goog
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

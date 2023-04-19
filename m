Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D36E79EF
	for <lists+linux-spi@lfdr.de>; Wed, 19 Apr 2023 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjDSMsS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Apr 2023 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjDSMsR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Apr 2023 08:48:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57317680
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 05:48:15 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54c12009c30so606100857b3.9
        for <linux-spi@vger.kernel.org>; Wed, 19 Apr 2023 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681908495; x=1684500495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaAeFzRpz5toFW8WHRABnZ5unkwbSe8FbOyXO8KgxYA=;
        b=gYL8wGqziSP9DqJQZuStwo0bb3Xgt1vxCNKDj4VnWB7uxsC8dDbX940zSsRC42p35u
         AO78aCAJCMJjwWYlLk/ToNBwVg7SzbPOd4y3Th4iWNa+u9/dj+KHg/4w44kyBXFXVAFe
         IFn+bBxFjkBfNEE1arNPK2BVvDgTUIcAGji5PcAB2MrPro0rC6HNuPY3nlPxF6PW2fx9
         Pm154bse+0A79L+l3/SayNKCAt5nXaz/WzLoPzTGw30XWtKIqh/nVyaAXk0+87mzZ7TR
         SrH3UcZNnZNXo9H0S2uzOk+k4R6NtNeTUH5DQ4K6ZNaFzpXw/tDP3D216F2iyDLnIubR
         iPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908495; x=1684500495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaAeFzRpz5toFW8WHRABnZ5unkwbSe8FbOyXO8KgxYA=;
        b=I/bz59V4xTOrJ62U47l+Wjfen5dpwop1GLsVSbO7m//h/E+I4Dekpz3P/GB+LFuaDI
         DbZkkbkEBsBuKXWAwF5lqEjr8NUsBD/vjBDt6MA/oNdlet34hzNsD1/j/z8vJXI4vxUh
         nBxz7LQwsvyZNHMANdL9TpqPhBawjy2MIBG2rrqrTtzAYeuh/iTQMwN3YfBq9BRqTtsP
         q2Jtcnk6NYXW78ej0YxiEGSQ9a6yK7Ud6rYOhYNUGH/My65aj6G2sXu+QAgpDEKb+i+q
         iN5N5Gokz1DFEFh7ZCD5+t0zzTA7S8GEdcyjrT+vA0ySBaa38MOzcAtH75HepqTn00+J
         C2LQ==
X-Gm-Message-State: AAQBX9fp6om0ipRVa7zFZUtYdMLTIlYkQs47tvU6lkvrLpTRaN+lG0Hb
        C+VRTzXH8tg3t1OWO5PYR3t7guI9XdcINH/M4Ghq8Q==
X-Google-Smtp-Source: AKy350ac6G5w/+o+4Ymp6NChFH7f0TfAm0b94WeoDBjRy57fozX4E16cBg9CVHPXWKWYT2jKfYIjpS9uqc/6xFf4bLo=
X-Received: by 2002:a81:a157:0:b0:54c:956:e070 with SMTP id
 y84-20020a81a157000000b0054c0956e070mr3028598ywg.9.1681908494934; Wed, 19 Apr
 2023 05:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com> <20230418052902.1336866-5-joychakr@google.com>
 <ZD5JC7BdN1usn6Kd@smile.fi.intel.com> <CAOSNQF2sXHFCx9ZfrtfmxHfKrAE0XGP8SRvW6wyYco+FKSPmDw@mail.gmail.com>
 <ZD/VO1cuBYGCP4O2@smile.fi.intel.com>
In-Reply-To: <ZD/VO1cuBYGCP4O2@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Wed, 19 Apr 2023 18:18:04 +0530
Message-ID: <CAOSNQF1wf3m+YTmh5qQWCM6+x3j2whvG6F=dW6Hd7zW0Y+E_1g@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] spi: dw: Add DMA address widths capability check
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Apr 19, 2023 at 5:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 19, 2023 at 11:18:25AM +0530, Joy Chakraborty wrote:
> > On Tue, Apr 18, 2023 at 1:08=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Apr 18, 2023 at 05:29:01AM +0000, Joy Chakraborty wrote:
>
> ...
>
> > > > +     /*
> > > > +      * Assuming both channels belong to the same DMA controller h=
ence the
> > > > +      * address width capabilities most likely would be the same.
> > > > +      */
> > >
> > > I had a small comment on this In v6 thread.
> >
> > Sure,
> >
> > Your comment in V6 thread:
> > "
> > I would add something to explain the side of these address width, like
> >
> >          * Assuming both channels belong to the same DMA controller hen=
ce
> >          * the peripheral side address width capabilities most likely w=
ould
> >          * be the same.
> > "
> >
> > I do not think the address width capabilities are dependent on the
> > side of generation like memory or peripheral.
>
> Yes, they are independent. Memory could do with 4 bytes, while peripheral=
 with
> 1 byte and so on.
>
> > From what I understand,
> > address width capabilities are solely dependent on the transaction
> > generation capability of the DMA controller towards the system bus.
>
> What do you mean by a SB in the above? Memory? Peripheral?

By system bus I mean anything that is connecting the Memory, DMA and
the peripheral.
Something like :

          +-----------+          +-------------------+
          |               |           |                        |
          |   DMA    |           | PERIPHERAL |
          |               |           |                         |
          +----^-+---+          +-----+--^---------+
        *** -->| |                         |    |
                  | |                         |    |
<------------+-v--------------------v---+------------->
                    SYSTEM BUS
<---------------------+--^----------------------------->
                            |   |
                            |   |
                     +----v--+-----+
                     |                   |
                     |  MEMORY |
                     |                   |
                     +--------------+
*** : Address width capabilities should be the capability of the DMA
to generate transactions to the system bus on the marked interface
irrespective of whether it is destined for Peripheral or memory is
what I understand.

>
> > What we intend to highlight here is the assumption that both tx and rx
> > channel would belong to the same DMA controller hence the transaction
> > generation capabilities would be the same both for read and write
> > (e.g. if the DMA controller is able to generate 32 bit sized reads
> > then it should also be able to generate 32 bit sized writes).
> > With this assumption we are doing a bitwise and of both tx and rx capab=
ilities.
> >
> > Please let me know if you think otherwise.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

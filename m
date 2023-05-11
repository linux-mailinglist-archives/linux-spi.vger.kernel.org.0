Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD7D6FEEE4
	for <lists+linux-spi@lfdr.de>; Thu, 11 May 2023 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjEKJcQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 May 2023 05:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjEKJcP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 May 2023 05:32:15 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE98EE43
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 02:32:13 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-559ded5e170so123391387b3.3
        for <linux-spi@vger.kernel.org>; Thu, 11 May 2023 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683797533; x=1686389533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtz1ydyDS624VmYCi2VaMy7J7QuV0VVyUJjC2kZ/qf8=;
        b=B214r8mF5kYcxT+mAmQuyN0qjB6xCyKs/y+9LQeVtodRGPgjN3pRxs+JbDp6I5yqaT
         tJR/scry3pC+y5in5G+Wz/VtFPD7OcLp6IwfddKWhVp8UgzVh72QuxHANVyuP8B65F+/
         9prX+/tDl4XX5009PxzXc9VpQvCph7mCFMr/+R74vtgjuOhfBjNRrBvMHGT1JDNWbxe4
         isUTN2RTF3zGYUGaThiVKRwMQb2cpdhiGzDtPe4NbD+ljunHzF6x+pCJ7+e1lG9Q2zCL
         Pm2eZ6P6+anIo8x2HZvOY0gRFUnThjrkH7MOSvzDC9b2rQLgTMIP3QpS7oWmw2NfGgqI
         z20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797533; x=1686389533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtz1ydyDS624VmYCi2VaMy7J7QuV0VVyUJjC2kZ/qf8=;
        b=TpUVNDtQW1xwGYi20OfAr5AVgGTOnj5lOXvXrTWwDetfM4dDhN4QtfK9UaiwSzRqnT
         u14ihn/mYCTaIxeA81Sexfd2cGki0LmOssY2fVbRWTJI8js7bfO6NM+EAYZkRRM6whP/
         iCM/ptIGB7TnxzNTiIV5s1Ox18FZGcTBhodjJP9nDUkeItWXTYx6VDXGM3IoxuWlieiX
         H1+u6L8VA4xkMarSSkx/LGtIFe2eh1TuAAev2SS+urzJAI/rZELN9SNaRPCMqwdcNuSg
         P8RDhhWIx8IgYiss1V5AsGWdgrNj9LS3ShhblV7x+SMGOxMdVKU8mgrv4MpvGSruEuC/
         AcOA==
X-Gm-Message-State: AC+VfDxorS6uFuAvioonvp1zgJ4bxQnQiTyzAYdWrNhrGXTFPFOEpu3u
        /zz/BcdOUPuqhbhdTsM+Gsw00gXWjppAd1cWvdxL4w==
X-Google-Smtp-Source: ACHHUZ66RgmNmxlWlLfb0U/n0vXe+S6/WC0lP4dIijKvwnUC9l9M6Qxr/jNJgXWNz8egBl9iLaj453DXS0cfu9DOT4I=
X-Received: by 2002:a0d:db47:0:b0:55a:5e16:7257 with SMTP id
 d68-20020a0ddb47000000b0055a5e167257mr20621217ywe.35.1683797532915; Thu, 11
 May 2023 02:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230509082244.1069623-1-joychakr@google.com> <20230509082244.1069623-2-joychakr@google.com>
 <ZFxFCweHVgHyA1E1@finisterre.sirena.org.uk>
In-Reply-To: <ZFxFCweHVgHyA1E1@finisterre.sirena.org.uk>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Thu, 11 May 2023 15:02:00 +0530
Message-ID: <CAOSNQF1GtxY7ud-kobHW=HHvYcq3ySp+YTvvHnPAkxmP5Nv85A@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 11, 2023 at 6:59=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, May 09, 2023 at 08:22:40AM +0000, Joy Chakraborty wrote:
> > Add Support for AxSize =3D 4 bytes configuration from dw dma driver if
> > n_bytes i.e. number of bytes per write to fifo is 4.
>
> This doesn't apply against current code, please check and resend.

Hello Mark,

This patch seems to be applied already as per the reply to the cover letter=
:

[1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
      commit: 5147d5bfddc807e990a762aed0e56724afeda663
[2/5] spi: dw: Move dw_spi_can_dma()
      commit: d2ae5d42464e990b4d26734c180fbff64233992c
[3/5] spi: dw: Add DMA directional capability check
      (no commit info)
[4/5] spi: dw: Add DMA address widths capability check
      (no commit info)
[5/5] spi: dw: Round of n_bytes to power of 2
      (no commit info)

Whereas [3/5] to [5/5] has not been applied.

Do I need to rebase and send the whole series again or resend the last
3 patches based on
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git ?

Thanks
Joy

Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66AA706AFF
	for <lists+linux-spi@lfdr.de>; Wed, 17 May 2023 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjEQOXk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 May 2023 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjEQOXj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 May 2023 10:23:39 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92491131
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 07:23:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f38956ffdbso5334121cf.1
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684333417; x=1686925417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3rLC5o1yC5tyPBlrF7L0OcHbxmqALVQTPYwjd+0mhk=;
        b=ewkfbRVqV5cyOI09+i9rNtwAtAxUzomDMpEnBivHBHECvh1h9nHT3XfQrrJVL+dQRe
         7XKCse198NBfPCc1P0EyijpIgQy2/QIfonW2bj/xoEivf5y8U2l+kBlzSPWgHZfO1QIp
         MhZVln2mo8OWaUc5+S0TBqtN5L7YB8gNDCXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333417; x=1686925417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3rLC5o1yC5tyPBlrF7L0OcHbxmqALVQTPYwjd+0mhk=;
        b=XsPzggFEJbBRpFxuQxXme5CKt3V8o6sGUNoOQA/6ZjOBXvZKCb+Yw53lhdrSPGukB3
         soywQHdOxgTq0SfPX7Z2/H302sAezlUC0yNTBDSSxYMt6QMgAGIZ4psxB+77eeXyhSvF
         iQQGgDUI1zxNyUPYHYdkACT4LWq5USxHHyEhGTHhzLDIlxbiesqJwRinxyZ/ABKntdlr
         o9kyk7xjVmuH0NsiLuogIaJ+h7U1MDFw9/uadADlI00d+adHl79JyoP3BE6LtUtgLwV7
         r5A9RW/mtQ7tZRuNILWlh/aWmGLWzS4N+r0jQ6wQMMjjONYWT/96MM0bg3vXUBhSAPJ0
         C8Kw==
X-Gm-Message-State: AC+VfDw/k0sScS48wtH26mBAjZTYEPyuCPJbRiH9jM2IPhtsPFEuUnfM
        6Hfeayv0YZpvHG/jgP7SXwOV/a9IDx6MeXi2eRo=
X-Google-Smtp-Source: ACHHUZ4t5IBmoC4NivnMoFBZy7Apjg/1Ra8V9jmuKhM/gqpT5il3dE/JUnxyWtzonjolYFRwyElb1Q==
X-Received: by 2002:ac8:5a13:0:b0:3f5:17ea:11c8 with SMTP id n19-20020ac85a13000000b003f517ea11c8mr21562542qta.43.1684333417110;
        Wed, 17 May 2023 07:23:37 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id k4-20020a05620a138400b0075941df3365sm634372qki.52.2023.05.17.07.23.35
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:23:35 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f396606ab0so188231cf.0
        for <linux-spi@vger.kernel.org>; Wed, 17 May 2023 07:23:35 -0700 (PDT)
X-Received: by 2002:ac8:5c8c:0:b0:3e0:c2dd:fd29 with SMTP id
 r12-20020ac85c8c000000b003e0c2ddfd29mr427162qta.4.1684333415183; Wed, 17 May
 2023 07:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com>
 <1683911265-3395-3-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=WbMFDsC7dVjLNrtwi-hDEbSx9R8XzVGFW902OSKSFWjA@mail.gmail.com> <27ed4b11-14bf-081f-619e-75789d8caced@quicinc.com>
In-Reply-To: <27ed4b11-14bf-081f-619e-75789d8caced@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 07:23:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xg4svcZrE+NH-MWJUumDThiYxjACFvCs+YVLZDiE5YvA@mail.gmail.com>
Message-ID: <CAD=FV=Xg4svcZrE+NH-MWJUumDThiYxjACFvCs+YVLZDiE5YvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside
 driver, use framework instead
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, May 17, 2023 at 5:17=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> > One last question: should you call:
> >
> > dma_set_max_seg_size(dev, INT_MAX)
> >
> > ...in your probe function? I don't think you have any limitations of
> > maximum segment size, right? Right now if you don't set anything it
> > looks as if it considers your max to be 64K. That would cause the SPI
> > framework to break things up into multiple chunks which would make you
> > fall back to FIFO mode, right?
>
>
> Actually we would need to call:
>
> dma_set_max_seg_size(dev->parent, INT_MAX)
>
> Please note that in probe()
>
> spi->dma_map_dev =3D dev->parent;
>
> and in __spi_map_msg()
>
> tx_dev =3D ctlr->dma_map_dev;
>
> ret =3D spi_map_buf(ctlr, tx_dev, &xfer->tx_sg,...
>
>
> Since the dev->parent is QUP containing other SEs and its max_seg_size
> seems to be getting set from elsewhere than code (perhaps kernel
> scripts) it seemed safer not to modify that.
>
> So I made below change and uploaded v2...
>
> spi->max_dma_len =3D 0xffff0; /* 24 bits for tx/rx dma length */
>
> which actually doesnt help much because spi_map_buf() picks the lower of
> these 2 but added it anyway
>
> desc_len =3D min_t(size_t, max_seg_size, ctlr->max_dma_len);

OK, fair enough.


> Any case as next step we will look into scatter list support to DMA; and
> practically we may not have transfers over 64KB, so its ok for now?

I think it's OK for now, especially since you do properly fall back to
FIFO in cases that aren't handled. Thanks!

-Doug

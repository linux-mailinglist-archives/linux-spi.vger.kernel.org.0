Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8878A733382
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jun 2023 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345420AbjFPOYx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jun 2023 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbjFPOYw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jun 2023 10:24:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299130E3
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 07:24:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30e412a852dso579595f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jun 2023 07:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686925489; x=1689517489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx7ROQZ0eKytOMjxCt+HG5/XsSe4FTYGId7sGxzTFbA=;
        b=iSU9IT9wDtuk77lxJO5NHE9Hxx1LNfvQvYbEimERwiyxTtYH8pKkFhbQU2R3SrWzcF
         pvFXDTnWHdxd6guyCGhtShV3qtRa+tusfBmX+KbfyuymRFW2obHR7rO4xVzxds9Hdpj0
         /3n2Cn9/DQh0GNhCvBRIHUvlx5bVwlc9GjqJmaQWBRZj2oHxre2D/JMQ/77ip+l6YwK/
         sNbYduBG49rZi1X7gvpRVrCV8BOO4r1/qaZsTIPKZIi78xGuL/DQCy0FQJ2ie8SlEejD
         Qq5JgleSCNfzgItLvmc7a7Bt9lOarQsvejSyMsZv6UOMxnVBi7W8uauUvO7PthJ2osAY
         FPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686925489; x=1689517489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx7ROQZ0eKytOMjxCt+HG5/XsSe4FTYGId7sGxzTFbA=;
        b=aLr/lF6jQOtu7lsm5fKJsu5COtQ1oXQrWi6lwV/xbkmQwadn9f/+wdzlL9VNG++Yyr
         pQpz8h5gvGyf40oBSDYGyBfoSMmLKRXd3PB3/5xp2KgPT66hPFoy0v/GPa9pa190w9X8
         YmfS7UVDbfRqGbQB7tpEs3GTTkZRuQxRtMajXOyUSSaIJtQM+SUvi9Li5J75vSsaDri9
         AG1yiduFsHDEJrAqXHOYh8RuQuJ/IYcnpW7XAY1v/TnDWW0ZTvbsK8Z+UqEdHXfoX2FB
         4PKQtpVjQnMLLIUw/RGtSSFaKKd//mV7STfzpaAQAUSRYTf2+1motUunGUsvX44sRdvW
         Sxxg==
X-Gm-Message-State: AC+VfDw031nUlQU6A+dIaEyoSH66bXAbUt5/nMgUoKeBgpuayP0YHQCD
        uEhPjM2LWqfEh2MPNkXpso+CWdfZAq+bl6YJ/gk=
X-Google-Smtp-Source: ACHHUZ5zmYOrvqRN4wv1JGPunfWr+cohHv3xD8oiWGYmwhn6VVoGZQAxGbMmpj5tSq2/8RA9R5nsrQ==
X-Received: by 2002:a05:6000:1a43:b0:30f:cb1f:d240 with SMTP id t3-20020a0560001a4300b0030fcb1fd240mr1461804wry.32.1686925489459;
        Fri, 16 Jun 2023 07:24:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e5-20020adff345000000b0030630120e56sm23960947wrp.57.2023.06.16.07.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 07:24:47 -0700 (PDT)
Date:   Fri, 16 Jun 2023 17:24:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     linux-spi@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [bug report] spi: spi-qcom-qspi: Add DMA mode support
Message-ID: <78fb1d2e-6fe3-4bd3-a232-ad6be35eaf0e@kadam.mountain>
References: <abc223e8-44af-40bb-a0bd-9865b393f435@moroto.mountain>
 <a244d741-02bb-9d74-0a6c-1f01a6eeb360@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a244d741-02bb-9d74-0a6c-1f01a6eeb360@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 16, 2023 at 07:42:30PM +0530, Vijaya Krishna Nivarthi wrote:
> Hello Dan,
> 
> 
> On 6/16/2023 6:12 PM, Dan Carpenter wrote:
> > Hello Vijaya Krishna Nivarthi,
> > 
> > The patch b5762d95607e: "spi: spi-qcom-qspi: Add DMA mode support"
> > from Apr 24, 2023, leads to the following Smatch static checker
> > warning:
> > 
> > 	drivers/spi/spi-qcom-qspi.c:368 qcom_qspi_setup_dma_desc()
> > 	warn: sleeping in atomic context
> > 
> > drivers/spi/spi-qcom-qspi.c
> >      336 static int qcom_qspi_setup_dma_desc(struct qcom_qspi *ctrl,
> >      337                                 struct spi_transfer *xfer)
> >      338 {
> >      339         int ret;
> >      340         struct sg_table *sgt;
> >      341         dma_addr_t dma_ptr_sg;
> >      342         unsigned int dma_len_sg;
> >      343         int i;
> >      344
> >      345         if (ctrl->n_cmd_desc) {
> >      346                 dev_err(ctrl->dev, "Remnant dma buffers n_cmd_desc-%d\n", ctrl->n_cmd_desc);
> >      347                 return -EIO;
> >      348         }
> >      349
> >      350         sgt = (ctrl->xfer.dir == QSPI_READ) ? &xfer->rx_sg : &xfer->tx_sg;
> >      351         if (!sgt->nents || sgt->nents > QSPI_MAX_SG) {
> >      352                 dev_warn_once(ctrl->dev, "Cannot handle %d entries in scatter list\n", sgt->nents);
> >      353                 return -EAGAIN;
> >      354         }
> >      355
> >      356         for (i = 0; i < sgt->nents; i++) {
> >      357                 dma_ptr_sg = sg_dma_address(sgt->sgl + i);
> >      358                 if (!IS_ALIGNED(dma_ptr_sg, QSPI_ALIGN_REQ)) {
> >      359                         dev_warn_once(ctrl->dev, "dma_address not aligned to %d\n", QSPI_ALIGN_REQ);
> >      360                         return -EAGAIN;
> >      361                 }
> >      362         }
> >      363
> >      364         for (i = 0; i < sgt->nents; i++) {
> >      365                 dma_ptr_sg = sg_dma_address(sgt->sgl + i);
> >      366                 dma_len_sg = sg_dma_len(sgt->sgl + i);
> >      367
> > --> 368                 ret = qcom_qspi_alloc_desc(ctrl, dma_ptr_sg, dma_len_sg);
> > 
> > The qcom_qspi_alloc_desc() is a sleeping allocation, but the caller
> > qcom_qspi_transfer_one() is holding spin_lock_irqsave(&ctrl->lock, flags).
> 
> 
> I think We should be able to move qcom_qspi_setup_dma_desc() , and thus
> qcom_qspi_alloc_desc(), out of critical section.
> 
> Right now we are looking into some issues with DMA mode transfer that have
> showed up recently and will likely have a Fixes: patch next week.
> 
> Can we include this change in same series?
> 
> Another option is to include flags __GFP_ATOMIC in call to dma_pool_alloc()
> and upload a Fixes: patch right away.
> 
> Would that work?
> 
> Can you please advise?

This is from static analysis not testing.  It doesn't affect me at all,
so I don't have any opinion.  I imagine that fixing it next week is
fine.

regards,
dan carpenter


Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAAC5E588D
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 04:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiIVC0a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Sep 2022 22:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIVC03 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Sep 2022 22:26:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF849AB41B
        for <linux-spi@vger.kernel.org>; Wed, 21 Sep 2022 19:26:28 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3450a7358baso84227797b3.13
        for <linux-spi@vger.kernel.org>; Wed, 21 Sep 2022 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VvS7fqwJkQeYJ0Lw0t9dUsk1jdvOWiMdGjdfNwDGzb8=;
        b=QcGgTx/fKHBsdUYZjKpVSuFFxMMiVSp5wBNU7/lfiphOGe1jGD5Qv7++RC3lng4tMU
         R4OjHFT+LJRoAcHg3P8YxavZMm8TVSQq5FwucwcMXtaEU705/UHUy4yNWCvznyM46f7h
         VUQGSnzbStQ/tQxoYOW8XW7S5TOyJnZ0/9Exfuae0xWd9FTt0zqOZ4f2ZH/i5V9ps6m6
         OC6Pw0NmqKHWONncYf7yWoX0RYTw8W9N+HQXX9qEUnGcnf4G997FJ/vhbg7LrlV1iaOR
         WsoEzVAXyLcWb1TsORDd+Cvjq2a78rCmsQsAg7IHhyj+lHmHRpS59iznPntQuDaD2glS
         hrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VvS7fqwJkQeYJ0Lw0t9dUsk1jdvOWiMdGjdfNwDGzb8=;
        b=UQ+GoIcDByyKN8XUiwtS1ghee0gEo9fuTxZZVKkYNNsuN9/DBXCqP/m5nFyrypyU2p
         BoWbn8XwoE9M7BaA+cI6tMwp5fej3B6qbIPyRMSZlA7LyxCOiYf9eygnf3+h1y9RlRiQ
         /U9EiJQytO+jhIUZGGUHgOzK7P34ri9+W1tT1a8OFby0XZte4yNb9uh5Jv3brx2ssaKq
         zfa/gtAiiA30hxJhoj+riEk4toIEITLHFU7fOSijyLWvH5Z5mgGLpUuA70chTsvtoNG2
         k3j1WqK2dNHeF3NH3x/H34RgT+bt3FXVsTPV0GMvg/a4TixM+6dfSE+cqyd5Ll3gkDK9
         /CZg==
X-Gm-Message-State: ACrzQf2Y/ziyk+8pFeh/LsOrtKn/iJ3nFXogCkjKJ/JQoNBNA873zdXq
        DvX3FXJ46Du2J2dJZwtDC9qpEdZS6W43R+UmHRCcj9ycz0g=
X-Google-Smtp-Source: AMsMyM4MwUIfph9xdL9X4w7uxqeAdXgrcdXBzTaOe7j42DQyJyOhELRpLGzs46n849fkyds4rIVnL3DDWA6AVQbnvg4=
X-Received: by 2002:a81:4f83:0:b0:349:cc19:7ccf with SMTP id
 d125-20020a814f83000000b00349cc197ccfmr1128716ywb.308.1663813588075; Wed, 21
 Sep 2022 19:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220920114448.2681053-1-yangyingliang@huawei.com>
 <CAMo8BfJ-LE55ELT7SGK6HJU=EyVZ1pYz7bR-66+EH=+6L4sEMw@mail.gmail.com> <8d8fb017-3bc4-7503-56da-16876d2bd7dc@huawei.com>
In-Reply-To: <8d8fb017-3bc4-7503-56da-16876d2bd7dc@huawei.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 21 Sep 2022 19:26:16 -0700
Message-ID: <CAMo8BfJaD7pG_iutY8jordysjChyzhTpVSqpxXh3QoZsj2QmaQ@mail.gmail.com>
Subject: Re: [PATCH -next] spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 20, 2022 at 11:18 PM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> On 2022/9/21 11:53, Max Filippov wrote:
> > On Tue, Sep 20, 2022 at 4:37 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >>   static int xtfpga_spi_remove(struct platform_device *pdev)
> > There's a call to spi_master_put in the xtfpga_spi_remove,
> > IIUC this call must be dropped too.
> It can not be dropped, the controller is get in spi_bitbang_start(), it
> need be put in remove().

Oh, I see, spi_bitbang_stop doesn't do it for controllers allocated with devres.

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

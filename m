Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D683AD0D2
	for <lists+linux-spi@lfdr.de>; Fri, 18 Jun 2021 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhFRRBG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Jun 2021 13:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhFRRBG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Jun 2021 13:01:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33906C061574
        for <linux-spi@vger.kernel.org>; Fri, 18 Jun 2021 09:58:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c7so8611392edn.6
        for <linux-spi@vger.kernel.org>; Fri, 18 Jun 2021 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Z9mbh4A1VzZ/Kc0VyfgtzFFvfJf67o5osf3IxrdP4Ac=;
        b=DZqFAtruSOP1EmWhZ9WKmB6oeyVbbhY/5aMM58iLr5GfJoLdGoS44wUxqV0neFE+j8
         +EGYH2j3Qu9SuKgHiKX6K5589j45+oSguE1XIG1Vi/ZJRfmfGGl3Tq5dL9Tkzab6/UF7
         Z2ysj1si2bJ+hC5qU4vyRO/L8TlK+rV+ejEdqyFGLn50wbu7dY5A44L6BlTRpJfWxtIC
         mDV7GmSqw+I7y+dDNb3HOtUpjEHBy4SypRTbzHD30mX9XW4zFgL4zrc2Vdp/eiL9zHuz
         fjvVo+TcguGsokK+si0eAXSfcv5+KtCez+wjyPkBQ0J4JWwOPPW57QZO41IFchRmyu8I
         1rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z9mbh4A1VzZ/Kc0VyfgtzFFvfJf67o5osf3IxrdP4Ac=;
        b=ZLvqQPTgiHs7ZDbABUEf4KHpug65tBqwVD0p10WxtCUlnZkWXhwG3LX5+6PJGu13O1
         Q+H5B7AtPFuy+2+Yfn/xbmoj2Xlb9Y411MpE9Xc9p6kjDPUdSJ/tP9TRqXVho40DBBt7
         qf2xIVAwdranzDqDBzlJ/Ms2NtYhGh0UKY+XiDzjAoYTraT8WI8x5jqnKfThQbzxwM7d
         cPgQ376A48YlZeEdHdaa13h6cD8OUM0YaRQ6/Bsru7vHe6giuCZQNfQ348hpSdK2Y2Jh
         elG86Go6/yJsHucgLYXA52FQy2VUTlW4PZwKsUqux7N6Uabi4YDoYm6qa1aACk2GMxWI
         yVrA==
X-Gm-Message-State: AOAM5309nQSp18T28MgGK41UIw5S4lqo4jP+TAUnPitdjbodDe0f3cez
        Wh/y5YnKybHRs/h/E5b82DhqwsZPVwF7TOvmMzFttfPLQTHtFw==
X-Google-Smtp-Source: ABdhPJzobLUNP7LjfbO3DqUXR1hBi1ybnmS4ldVU0NMEo7rCcKn+NmChmxCG41RivNgfMTnoDlP/u/hF/UfwjryLj5w=
X-Received: by 2002:aa7:c0da:: with SMTP id j26mr6162229edp.38.1624035534388;
 Fri, 18 Jun 2021 09:58:54 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 18 Jun 2021 11:58:43 -0500
Message-ID: <CAHCN7xJ_Cidr5EiBXNi11St9vLFmm=s=K6jdHGJrvCzeQQpqyQ@mail.gmail.com>
Subject: ECSPI Slave on i.M8M Mini with DMA
To:     linux-spi <linux-spi@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Charles Stevens <charles.stevens@logicpd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

To the NXP team,

I noticed the spi-imx driver has a function called spi_imx_can_dma()
which returns false if the SPI is configured as a slave, so the dma
cannot be used in slave mode.

Section 10.1.2.7 "DMA" of the The 8MM Ref manual, Rev 3, shows there
are a few conditions that can trigger the DMA.  Of them, two are
RXFIFO data request and RXFIFO full.  The block diagram in that
section shows it can retrieve data with DMA

However, in section 10.1.4 "Applications" of the same document, it
shows the optional DMA configurations are only in the SPI master
configuration and not the SPI slave configuration.

The ECSPIx_DMAREG documentation (section 10.1.5.6) states "The ECSPI
sends out DMA requests when the appropriate FIFO conditions are
matched." Unfortunately it doesn't explicitly state whether that's
only for master or available in either master or slave mode.

Can someone tell me if DMA is available when SPI is configured as a slave?

thank you,

adam
